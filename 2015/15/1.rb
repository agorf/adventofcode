$properties = $stdin.reduce({}) do |props, line|
  props.merge(
    line.split(':').first => Hash[
      *line.split(': ').last.chomp.split(/,? /).map.with_index {|val, i|
        i % 2 == 0 ? val : val.to_i
      }
    ]
  )
end

def recipe_score(recipe)
  head, *tail = $properties.map do |ingredient, properties|
    properties.select {|k, _| k != 'calories' }.map do |_, value|
      value * recipe[ingredient]
    end
  end

  head.zip(*tail).map {|prods| [prods.reduce(:+), 0].max }.reduce(:*)
end

max_total_score = 0
counters = [0] * $properties.size

loop do
  increased = false

  if counters.reduce(:+) == 100
    recipe = Hash[$properties.keys.zip(counters)]
    max_total_score = [max_total_score, recipe_score(recipe)].max
  end

  -1.downto(-counters.size) do |i|
    if counters[i] + 1 <= 100
      counters[i] += 1
      increased = true
      break
    end

    counters[i] = 0
  end

  break unless increased
end

puts max_total_score
