require 'set'

replacements, molecule = $stdin.read.chop.split("\n\n")

molecules = Set.new

replacements.each_line do |line|
  pattern, replacement = line.chop.split(' => ')

  i = -1

  while i = molecule.index(pattern, i + 1)
    new_molecule = molecule.dup
    new_molecule[i, pattern.size] = replacement
    molecules << new_molecule
  end
end

puts molecules.size
