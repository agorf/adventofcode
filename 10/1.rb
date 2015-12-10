def look_and_say(n)
  n.to_s.scan(/((\d)\2*)/).map {|o, i| [o.size, i].join }.join.to_i
end

n = $stdin.read.chop.to_i

40.times do
  n = look_and_say(n)
end

puts n.to_s.size
