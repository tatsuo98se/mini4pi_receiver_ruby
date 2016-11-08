require 'pi_piper'
require_relative 'motor'

$pwm = PiPiper::Pwm.new pin: 18
$in1 = PiPiper::Pin.new(:pin => 4, :direction => :out)
$in2 = PiPiper::Pin.new(:pin =>17, :direction => :out)

class RealMotor < Motor
    def set_motor_params(pwm, in1, in2)
        super.set_motor_params(pwm, in1, in2)
        in1 ? $in1.on : $in1.off
        in2 ? $in2.on : $in2.off
        $pwm.value = pwm
        p "set_motor_params #{pwm} #{in1}, #{in2}"
    end
end

