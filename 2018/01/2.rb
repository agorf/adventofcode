#!/usr/bin/env ruby

freq_changes = $stdin.readlines.map(&:to_i)
seen_freqs = { 0 => true }
freq = 0

loop do
  freq_changes.each do |num|
    freq += num

    if seen_freqs[freq]
      puts freq
      exit
    end

    seen_freqs[freq] = true
  end
end

raise 'No frequency seen twice!'
