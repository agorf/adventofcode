require 'digest/md5'

secret_key = $stdin.read.chomp

i = 1

loop do
  if Digest::MD5.hexdigest(secret_key + i.to_s) =~ /\A0{6}/
    puts i
    break
  end

  i += 1
end

