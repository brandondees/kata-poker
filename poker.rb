#! /usr/bin/env ruby

puts "let's play some poker"

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
  def to_s; inspect; end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = %w[Hearts Spades Clubs Diamonds]
              .product((1..13).to_a)
              .map{|r,s| Card.new(r,s) }
  end

  def ==(other)
    self.cards == other.cards
  end

  def sort
    cards.sort
  end

  def shuffle
    self.cards = cards.shuffle
    return self
  end

  def deal(player, count = 1)
    raise ArgumentError, 'deal count must be an integer' unless count.is_a? Integer

    cards.select {|card| card.player == nil }
         .take(count)
         .each { |card| card.player = player }
  end

  def show_hand(object)
    cards.select {|card| card.player == object.object_id }
  end

  private

  attr_writer :cards
end

