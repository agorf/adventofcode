password = $stdin.read.chop

def valid_password?(pwd)
  valid   = pwd !~ /[iol]/ # does not contain i, o, l
  valid &&= pwd =~ Regexp.union(('a'..'z').each_cons(3).map(&:join)) # contains abc, bcd, ...
  valid &&= pwd.scan(/(([a-z])\2)/).map(&:first).uniq.size >= 2 # contains at least two aa, bb, ..., zz
  valid
end

(password..'z'*password.size).each do |pwd|
  if valid_password?(pwd)
    puts pwd
    break
  end
end
