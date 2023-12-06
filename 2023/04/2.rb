#!/usr/bin/env ruby

matches_by_card =
  $stdin.each_line.each_with_object({}) do |line, result|
    card, numbers = line.split(':', 2)
    card = card[/\d+/].to_i
    result[card] =
      numbers.
        split('|', 2).
        map { |col| col.scan(/\d+/).map(&:to_i) }.
        reduce(:&).
        size
  end

processed = []
pending = matches_by_card.keys

loop do
  break if pending.empty?

  card = pending.shift
  processed << card

  (card + 1).upto(card + matches_by_card[card]) do |copy_card|
    pending << copy_card
  end
end

puts processed.size