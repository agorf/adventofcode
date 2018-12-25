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

sleep_by_guard = Hash.new(0)
sleep_mins_by_guard = Hash.new { |h, k| h[k] = Array.new(60, 0) }

entries.each_slice(2) do |asleep, awake|
  id = asleep[:id]

  sleep_by_guard[id] += ((awake[:when] - asleep[:when]) / 60.0).to_i

  (asleep[:when].min...awake[:when].min).each do |min|
    sleep_mins_by_guard[id][min] += 1
  end
end

id = sleep_by_guard.max_by(&:last).first
min = sleep_mins_by_guard[id].each_with_index.max.last

puts id * min
