password = $stdin.read.chop

def valid_password?(pwd)
  pwd !~ /[iol]/ && # does not contain i, o, l
    pwd =~ Regexp.union(('a'..'z').each_cons(3).map(&:join)) && # contains abc, bcd, ...
    pwd.scan(/(([a-z])\2)/).map(&:first).uniq.size >= 2 # contains at least two aa, bb, ..., zz
end

first = true

(password..'z'*password.size).each do |pwd|
  next unless valid_password?(pwd)

  unless first
    puts pwd
    break
  end

  first = false
end
