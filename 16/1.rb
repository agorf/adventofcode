sue = {
  'children'    => '3',
  'cats'        => '7',
  'samoyeds'    => '2',
  'pomeranians' => '3',
  'akitas'      => '0',
  'vizslas'     => '0',
  'goldfish'    => '5',
  'trees'       => '3',
  'cars'        => '2',
  'perfumes'    => '1',
}

$stdin.each_line do |line|
  number, rest = line.chop.sub('Sue ', '').split(': ', 2)
  properties = Hash[*rest.gsub(':', '').split(/,? /)]

  if sue.values_at(*properties.keys) == properties.values
    puts number
    break
  end
end
