#!/usr/bin/env ruby

require 'time'

entries = $stdin.readlines.map { |line|
  {
    when: Time.parse(line),
    id: line[/(?<=#)\d+/],
    action: line.split(' ').last(2).join(' ')
  }
}.sort_by(&:first)

prev_id = nil

# Fill-in missing guard ids
entries.each do |entry|
  if entry[:id].nil?
    entry[:id] = prev_id
  else
    prev_id = entry[:id].to_i
  end
end

entries.reject! { |entry| entry[:action] == 'begins shift' }

sleep_mins_by_guard = Hash.new { |h, k| h[k] = Array.new(60, 0) }

entries.each_slice(2) do |asleep, awake|
  id = asleep[:id]

  (asleep[:when].min...awake[:when].min).each do |min|
    sleep_mins_by_guard[id][min] += 1
  end
end

puts sleep_mins_by_guard.map { |id, mins|
  [id].concat(mins.each_with_index.max.reverse) # id, min, times
}.max_by(&:last)[0..1].reduce(:*)
