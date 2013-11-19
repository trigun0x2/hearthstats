# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.hearthstats.net"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  Add '/aboutus'
  Add '/contactus'
  Add '/changelog'
  Add '/help'

  #
  # Add all articles:
  #
    Profile.find_each do |profile|
      add profile_path(profile), :lastmod => profile.updated_at
    end
end

SitemapGenerator::Sitemap.ping_search_engines