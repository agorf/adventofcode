sue = {
  'children'    => 3,
  'cats'        => 7,
  'samoyeds'    => 2,
  'pomeranians' => 3,
  'akitas'      => 0,
  'vizslas'     => 0,
  'goldfish'    => 5,
  'trees'       => 3,
  'cars'        => 2,
  'perfumes'    => 1,
}

$stdin.each_line do |line|
  number, rest = line.chop.sub('Sue ', '').split(': ', 2)
  properties = Hash[*rest.gsub(':', '').split(/,? /)]

  match = true

  if cats = properties.delete('cats')
    match &= sue['cats'] < cats.to_i
  end

  if trees = properties.delete('trees')
    match &= sue['trees'] < trees.to_i
  end

  if pomeranians = properties.delete('pomeranians')
    match &= sue['pomeranians'] > pomeranians.to_i
  end

  if goldfish = properties.delete('goldfish')
    match &= sue['goldfish'] > goldfish.to_i
  end

  match &= sue.values_at(*properties.keys) == properties.values.map(&:to_i)

  if match
    puts number
    break
  end
end
