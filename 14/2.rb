reindeer_specs = $stdin.each_line.reduce({}) do |specs, line|
  data = line.match(%r{(\w+) can fly (\d+) km/s for (\d+) seconds?, but then must rest for (\d+)}).to_a

  specs.merge(
    data[1] => {
      fly_speed:     data[2].to_i,
      fly_duration:  data[3].to_i,
      rest_duration: data[4].to_i
    }
  )
end

def reindeer_distance(reindeer_specs, race_duration)
  round_duration = reindeer_specs.values_at(:fly_duration, :rest_duration).reduce(:+)
  round_distance = reindeer_specs.values_at(:fly_speed, :fly_duration).reduce(:*)
  (race_duration / round_duration) * round_distance +
    [(race_duration % round_duration) * reindeer_specs[:fly_speed], round_distance].min
end

points = Hash.new(0)

1.upto(2503) do |race_duration|
  leading_reindeer = reindeer_specs.map {|name, specs|
    [name, reindeer_distance(specs, race_duration)]
  }.max_by(&:last).first

  points[leading_reindeer] += 1
end

puts points.values.max
