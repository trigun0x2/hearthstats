User.destroy_all
klasses = Klass.all

  # create users and profiles
User.transaction do
  puts "Seeding user data..."
  5.times do |user_count|
    User.create!(email: "info_#{user_count+1}@example.com", password: 'example')
  end
end

Profile.transaction do
  print "Seeding profile data..."
  User.all.each_with_index do |user, i|
    Profile.create(user_id: user.id, name: "info_#{i+1}")
  end
end

# create decks
Deck.transaction do
  puts "Seeding deck data..."
  User.all.each do |user|
    (9 + rand(15)).times do |i|
      deck = Deck.new({
        name: "demo-deck ##{i}",
        klass_id:  klasses.sample.id
      })
      deck.user_id = user.id
      deck.active = [true, false].sample
      deck.is_public = [true, false].sample

      # pick 30 cards
      possible_cards = Card.where("klass_id = ? OR klass_id IS NULL", deck.klass_id)
      deck_cards = {}
      while deck_cards.values.sum < 30 do
        many = deck_cards.length == 29 ? 1 : [1,2].sample
        many.times do
          card = possible_cards.sample
          deck_cards[card] ||= 0
          deck_cards[card] += 1
        end
      end

      # build cardstring
      deck_cards      = deck_cards.sort_by { |card, count| [card.mana, card.name] }
      deck.cardstring = deck_cards.map { |card, count| "#{card.id}_#{count}"}.join(',')

      deck.save
    end
  end
end

UniqueDeck.transaction do
  puts "Seeding unique deck and deck type data..."
  # create unique decks
  Deck.all.each { |deck| UniqueDeck.create_from_deck(deck) }

  # create unique deck types
  Deck.first(3 + rand(3)).each_with_index do |deck, i|
    UniqueDeckType.create({
      name: "Unique Deck Type #{i}",
      match_string: deck.cardstring.split(',').take(2).join(','),
      archtype_id: UniqueDeckType::ARCHTYPES.keys.sample,
      klass_id: deck.klass_id
    })
  end
end

UniqueDeck.transaction do
  # update unique decks to match new unique deck types
  UniqueDeck.all.each do |unique_deck|
    unique_deck.check_unique_deck_type
    unique_deck.save
  end
end

Match.transaction do
  puts "Seeding match data..."
  User.all.each do |user|
    user.decks.each do |deck|
      matches_params = []

      10000.times do |i|
        params = {}
        params[:mode] = Mode::LIST.keys.sample
        params[:oppclass] = Klass::LIST.keys.sample
        params[:result] = (i % 20 == 0 ? 'Draw' : ['Win', 'Loss'].sample)
        params[:coin] = ['true', 'false'].sample
        params[:oppname] = ('a'..'z').to_a.shuffle[0,8].join
        params[:numturns] = 4 + rand(15)
        params[:created_at] = rand(100).hours.ago

        matches_params << params
      end

      Match.mass_import_new_matches(matches_params, deck.id, deck.klass.id, user.id)

      #if match.mode_id == 1
        #arena_run = ArenaRun.create(
          #user_id:  user.id,
          #complete: [true, false].sample,
          #klass_id: deck.klass_id
        #)

        #MatchRun.create(match_id: match.id, arena_run_id: arena_run.id)
      #end
    end
  end
end
