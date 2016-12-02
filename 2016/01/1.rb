coords = [0, 0]
orient = 0 # North

$stdin.read.split(', ').each do |command|
  direction, blocks = command.split('', 2)
  blocks = blocks.to_i

  multi = direction == 'L' ? -1 : 1
  orient = (orient + (multi * 1)) % 4

  case orient
  when 0 then coords[1] += blocks
  when 1 then coords[0] += blocks
  when 2 then coords[1] -= blocks
  when 3 then coords[0] -= blocks
  end
end

puts coords.map(&:abs).reduce(:+)
