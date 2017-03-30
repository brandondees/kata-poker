#! /usr/bin/env ruby
require 'simplecov'
SimpleCov.start

class Card
  attr_reader :rank, :suit
  attr_reader :player

  def initialize(suit, rank)
    @rank = rank
    @suit = suit
  end

  def player=(object)
    @player = object.object_id
  end

  include Comparable
  def <=>(other)
    [rank, suit] <=> [other.rank, other.suit]
  end

  def inspect
    "#{self.class}: #{rank} of #{suit}"
  end

  def to_s
    inspect
  end
end

class Deck
  attr_reader :cards

  DEAL_COUNT_INTEGER_MSG = 'Deal count must be an integer!'.freeze
  DECK_COUNT_MSG = "Deck doesn't have enough cards to deal".freeze

  def initialize
    @cards = %w(Hearts Spades Clubs Diamonds)
             .product((1..13).to_a)
             .map { |r, s| Card.new(r, s) }
  end

  def ==(other)
    cards == other.cards
  end

  def sort
    self.cards = cards.sort
    self
  end

  def shuffle
    self.cards = cards.shuffle
    self
  end

  def deal(player, count = 1)
    raise ArgumentError, DEAL_COUNT_INTEGER_MSG unless count.is_a? Integer
    raise ArgumentError, DECK_COUNT_MSG if deck_count < count

    cards.select { |card| card.player.nil? }
         .take(count)
         .each { |card| card.player = player }
  end

  def show_hand(object)
    cards.select { |card| card.player == object.object_id }
  end

  def deck_count
    cards.count { |card| card.player.nil? }
  end

  private

  attr_writer :cards
end

