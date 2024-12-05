#!/usr/bin/env ruby

rules_input, updates_input = $stdin.read.chomp.split("\n\n", 2)

rules =
  rules_input.split("\n").each_with_object(Hash.new { |h, k| h[k] = [] }) do |pair_str, result|
    before, after = pair_str.split('|', 2).map(&:to_i)
    result[before] << after
  end

updates =
  updates_input.split("\n").map { |upd_str| upd_str.split(',').map(&:to_i) }

correct_updates =
  updates.select do |update|
    update.each_cons(2).all? do |pair|
      before, after = pair
      rules[before].include?(after)
    end
  end

puts(
  correct_updates.reduce(0) do |sum, update|
    sum + update[update.size / 2]
  end
)
