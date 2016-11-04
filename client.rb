require "socket"

begin
#localhostの20000ポートに接続
socket = TCPSocket.open("localhost",20000)
rescue
  puts "TCPSocket.open failed :#$!"
else
  loop do
      msg = socket.write "1\n"
      sleep 1
  end
  socket.close
end
