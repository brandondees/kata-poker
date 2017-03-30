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

  def test_always_has_52_cards
    deck = Deck.new
    assert_equal 52, deck.cards.count
  end

  def test_can_not_have_duplicate_cards
    # Derived from Avdi's original "audit_game" validation
    reference_deck = Deck.new
    played_deck = Deck.new.shuffle
    [:p1, :p2, :p3, :p4].each do |player|
      played_deck.deal(player, 5)
    end

    assert reference_deck.sort == played_deck.sort
  end

  def test_cannot_deal_more_cards_than_deck_has
    deck = Deck.new
    deck.deal(:p1, 30)
    assert_raises(ArgumentError) { deck.deal(:p2, 30) }
  end

  def test_deck_count_returns_count_left_in_deck
    deck = Deck.new
    deck.deal(:p1, 30)
    assert_equal 22, deck.deck_count
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

