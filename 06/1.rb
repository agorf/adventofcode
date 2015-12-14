matrix = Array.new(1000) { Array.new(1000) { 0 } }

$stdin.each_line do |line|
  data = line.match(/(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/)
  cmd  = data[1]
  from = data[2..3].map(&:to_i)
  till = data[4..5].map(&:to_i)

  from[0].upto(till[0]) do |i|
    from[1].upto(till[1]) do |j|
      matrix[i][j] = case cmd
                     when 'turn on'
                       1
                     when 'turn off'
                       0
                     when 'toggle'
                       1 - matrix[i][j]
                     end
    end
  end
end

puts matrix.flatten.select {|n| n == 1 }.size
