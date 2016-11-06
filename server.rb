require 'socket'
require 'pi_piper'
require 'timers'

$pwm = PiPiper::Pwm.new pin: 18
$in1 = PiPiper::Pin.new(:pin => 4, :direction => :out)
$in2 = PiPiper::Pin.new(:pin =>17, :direction => :out)

$xdirection = 0
$ydirection = 0

def driveMoter(x, y)
  if(x==0 && y==0) then
    $in1.off
    $in2.off
    $pwm.value = 0.0
    return
  end

  p "drive moter #{x}, #{y}"
  if(y > 0) then
    $in1.on
    $in2.off

  else
    $in1.off
    $in2.on
  end
  $pwm.value = y.abs.to_f/100.0

end

#Timer
timers = Timers::Group.new
timer = timers.now_and_every(0.1) { driveMoter($xdirection, $ydirection) }
Thread.start{loop{timers.wait}}

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
      x, y =  buf.split(",")
      p buf
      $xdirection = x.to_i
      $ydirection = y.to_i
    end
    socket.close
    p "#{id} connection terminate."
  end  
end
