#! /usr/bin/env ruby

require 'minitest/autorun'
require_relative 'poker'

class CardTest < Minitest::Test
  def test_exists
    Card
  end
end

class DeckTest < Minitest::Test
  def test_exists
    Deck
  end

  def test_deal_does_not_accept_non_integer
    deck = Deck.new
    assert_raises(ArgumentError) { deck.deal(:p1, 'hi') }
  end

  def test_deal_takes_number_of_cards_to_deal
    deck = Deck.new
    assert_equal 5, deck.deal(:p1, 5).length
  end

  def test_deal_uses_one_by_default
    deck = Deck.new
    assert_equal 1, deck.deal(:p1).length
  end

  def test_deal_returns_an_array_of_cards
    deck = Deck.new
    assert deck.deal(:p1, 4).all? {|card| card.is_a? Card }
  end

  def test_shuffle_scrambles_deck_cards
    reference_deck = Deck.new
    deck = Deck.new
    deck.shuffle
    refute deck.cards == reference_deck.cards
  end

  def test_can_never_have_more_than_fifty_two_cards
    skip
  end

  def test_can_never_have_less_than_fifty_two_cards
    skip
  end

  def test_can_not_have_duplicate_cards
    skip
    reference_deck = Deck.new.sort
    played_deck = Deck.new.shuffle
    stacks = []
    5.times { stacks << played_deck.deal(5) }
    game_deck = stacks.reduce(:+).sort

    assert reference_deck.cards == game_deck.cards
  end

  def test_cannot_deal_more_cards_than_deck_has
    skip
  end

  def test_show_hand_returns_a_players_hand
    deck = Deck.new

    deck.deal(:p1, 26)

    assert_equal 26, deck.show_hand(:p1).count

    deck.deal(:p2, 26)

    assert_equal 26, deck.show_hand(:p2).count

    cheat_cards = deck.show_hand(:p1).count do |card|
      deck.show_hand(:p2).include?(card)
    end

    assert_equal 0, cheat_cards
  end
end

