//= require 'plugins/defiant.min.js'

// Replay

var LogReplayed = (new function(){
  var match_json = gon.match_json
  var cards = gon.cards
  // State order: [handCards, playerBoard, oppBoard]
  var turnStates = []
  var player_id = null
  var firstPlayer = null
  var handCards = []
  var playerBoard = []
  var oppBoard = []

  this.init = function() {
    _drawStartingHands();
    _drawTurns();
    _createTurnState();
  }
  function _drawStartingHands(){
    drawnCards = JSON.search(match_json["turns"][0]["actions"], '//*[action="DRAWN"]');
    coin = JSON.search(match_json["turns"][0]["actions"], '//*[card="The Coin"]');
    startingCards = drawnCards.concat(coin);
    p1cards = JSON.search(startingCards, '//*[player=1]');
    p2cards = JSON.search(startingCards, '//*[player=2]');
    if (p1cards.length > p2cards.length){
      player_id = 1;
      startingHand = p1cards;
      if (startingHand.length == 3){
        firstPlayer = 1;
      }else{
        firstPlayer = 2;
      }
    }else{
      player_id = 2;
      startingHand = p2cards;
      if (startingHand.length == 3){
        firstPlayer = 2;
      }else{
        firstPlayer = 1;
      }
    }
    region = "#player-side .hand"
    $.each(startingHand, function(i, item){
      _drawCard(item.card, region);
      handCards.push([item.cardId, item.card])
    });
  }

  this.drawState = function(turnNum) {
    turn = turnStates[turnNum - 1]
    turnHand = turn[0]
    turnBoard = turn[1]
    turnOppBoard = turn[2]
    _clearBoard();
    $.each(turnHand, function(i, card) {
      _drawCard(card[1], "#player-side .hand")
    });
    $.each(turnBoard, function(i, card) {
      _drawCard(card[1], "#player-side .play-area")
    });
    $.each(turnOppBoard, function(i, card) {
      _drawCard(card[1], "#opponent-side .play-area")
    });
    console.log("state drawn");
  }

  function _drawTurns() {
    turnCount = match_json["turns"].length - 1
    for (i = 1; i <= turnCount; i++){
      $("#turns-cont ul").append("<li class='turn' data-turn='"+i+"'>Turn " + i + "</li>");
    }
    $(".turn").click(function() {
      turn = parseInt($(this).data("turn"));
      drawState(turn);
    })
  }
  function _createTurnState() {
    match_json.turns.splice(0,1);
    $.each(match_json.turns, function(i,turn) {
      $.each(turn.actions, function(q, action) {
        switch(action["action"]){
          case "DRAWN":
            if (action.player == player_id){
              handCards.push([action.cardId, action.card]);
            }
            break;
          case "PLAYED":
          // TODO: Spells not added to board
            if (action.player == player_id){
              handCards.remove([action.cardId, action.card]);
              playerBoard.push([action.cardId, action.card]);
            }else{
              oppBoard.push([action.cardId, action.card]);
            }
            break;
        }
      })
      turnStates.push([handCards, playerBoard, oppBoard]);
      console.log(turnStates);
    });
  }
  
  function _clearBoard (argument) {
    $("#player-side .hand").html("");
    $("#player-side .play-area").html("");
    $("#opponent-side .play-area").html("");
  }
  function _drawCard (cardName, region) {
    $(region).append("<img src='/assets/cards/"+cardName.toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/(^-|-$)/g,'')+".png'/>")
  }

  function _drawn(json){

  }

  Array.prototype.remove = function() {
    var what, a = arguments, L = a.length, ax;
    while (L && this.length) {
        what = a[--L];
        while ((ax = this.indexOf(what)) !== -1) {
            this.splice(ax, 1);
        }
    }
    return this;
  };
});

$(document).ready(function(){
  LogReplayed.init()
});