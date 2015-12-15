$properties = $stdin.reduce({}) do |props, line|
  props.merge(
    line.split(':').first => Hash[
      *line.split(': ').last.chop.split(/,? /).map.with_index {|val, i|
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

# TODO make input-agnostic (the following assumes 4 ingredients)

max_total_score = 0

1.upto(100) do |i|
  1.upto(100 - i) do |j|
    1.upto(100 - (i + j)) do |k|
      l = 100 - (i + j + k)
      recipe = Hash[$properties.keys.zip([i, j, k, l])]
      max_total_score = [max_total_score, recipe_score(recipe)].max
    end
  end
end

puts max_total_score
