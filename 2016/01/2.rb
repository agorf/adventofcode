coords          = [0, 0]
orient          = 0 # North
history         = Hash.new(0)
history[coords] = 1

$stdin.read.split(', ').each do |command|
  direction, blocks = command.split('', 2)
  blocks = blocks.to_i

  multi = direction == 'L' ? -1 : 1
  orient = (orient + (multi * 1)) % 4

  case orient
  when 0 # North
    (1..blocks).each do |i|
      history[[coords[0], coords[1] + i]] += 1
    end

    coords[1] += blocks
  when 1 # East
    (1..blocks).each do |i|
      history[[coords[0] + i, coords[1]]] += 1
    end

    coords[0] += blocks
  when 2 # South
    (1..blocks).each do |i|
      history[[coords[0], coords[1] - i]] += 1
    end

    coords[1] -= blocks
  when 3 # West
    (1..blocks).each do |i|
      history[[coords[0] - i, coords[1]]] += 1
    end

    coords[0] -= blocks
  end

  if same_loc = history.find {|_, v| v > 1 }
    puts same_loc[0].map(&:abs).reduce(:+)
    break
  end
end

