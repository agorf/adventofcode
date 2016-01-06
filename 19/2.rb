replacements_str, molecule = $stdin.read.chop.split("\n\n")

$replacements = {}

replacements_str.split("\n").map do |line|
  replacement, pattern = line.split(' => ')
  $replacements[pattern] = replacement
end

$max_size = $replacements.keys.max_by(&:length).scan(/[A-Z][a-z]?/).length

def molecule_replacements(molecule)
  i = 0
  size = 1
  tokens = molecule.scan(/[A-Z][a-z]?/)
  molecules = []

  loop do
    substr = tokens[i, size].join

    break if substr.empty?

    if replacement = $replacements[substr]
      molecules << tokens[0...i].join + replacement + (tokens[i + size..-1] || []).join
    end

    size += 1

    if size > $max_size
      size = 1
      i += 1
    end
  end

  molecules
end

molecules_with_steps = [[molecule, 0]]
min_steps = Float::INFINITY

while molecule_with_steps = molecules_with_steps.pop # DFS
  molecule, steps = molecule_with_steps

  $stderr.puts "min_steps=#{min_steps}"

  molecule_replacements(molecule).each do |new_molecule|
    if new_molecule == 'e'
      min_steps = [min_steps, steps + 1].min
    elsif steps + 1 < min_steps
      molecules_with_steps << [new_molecule, steps + 1]
    end
  end
end

puts min_steps
