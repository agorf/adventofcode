require 'digest/md5'

secret_key = $stdin.read.chomp

i = 1

loop do
  hash = Digest::MD5.hexdigest(secret_key + i.to_s)

  if hash =~ /\A0{5}/
    puts i
    break
  end

  i += 1
end

