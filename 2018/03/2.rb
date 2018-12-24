#!/usr/bin/env ruby

require 'set'

claims = Hash.new { |h, k| h[k] = [] }
claim_ids = Set.new

$stdin.each_line do |line|
  id, x, y, w, h = line.scan(/\d+/).map(&:to_i)

  (x...x + w).each do |i|
    (y...y + h).each do |j|
      claims[[i, j]] << id
      claim_ids << id
    end
  end
end

claims.each_value do |ids|
  next if ids.size == 1

  ids.each do |id|
    claim_ids.delete(id)
  end
end

puts claim_ids.first
