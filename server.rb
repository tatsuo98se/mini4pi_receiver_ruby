require "socket"

#20000番のポートを解放
s = TCPServer.open(20000)

i = 0
while true
  p "waiting connection... #{i}"
  i = i + 1
  
  thread = Thread.start(s.accept) do |socket|
    id = socket.peeraddr
    p "#{id} tryin to connect..."
    #クライアント側からの接続まち
    p "#{id} connection success."

    while buf = socket.gets
      p buf
    end
    socket.close
    p "#{id} connection terminate."
  end
  
end