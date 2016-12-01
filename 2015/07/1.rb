$cache = {}

$stdin.each_line do |line|
  expr, name = line.chomp.split(' -> ')

  body = if m = expr.match(/\A([a-z]+) RSHIFT (\d+)\z/)
    -> { send(m[1]) >> m[2].to_i }
  elsif m = expr.match(/\A([a-z]+) OR ([a-z]+)\z/)
    -> { send(m[1]) | send(m[2]) }
  elsif m = expr.match(/\A([a-z]+)\z/)
    -> { send(m[1]) }
  elsif m = expr.match(/\A(\d+)\z/)
    -> { m[1].to_i }
  elsif m = expr.match(/\ANOT ([a-z]+)\z/)
    -> { 2**16 - 1 - send(m[1]) }
  elsif m = expr.match(/\A([a-z]+) AND ([a-z]+)\z/)
    -> { send(m[1]) & send(m[2]) }
  elsif m = expr.match(/\A(\d+) AND ([a-z]+)\z/)
    -> { m[1].to_i & send(m[2]) }
  elsif m = expr.match(/\A([a-z]+) LSHIFT (\d+)\z/)
    -> { send(m[1]) << m[2].to_i }
  end

  define_method name do
    if value = $cache[name]
      value
    else
      $cache[name] = body.call
    end
  end
end

puts a
