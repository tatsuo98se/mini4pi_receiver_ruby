require_relative 'motor'

class RealMotor < Motor

    MAX_LEFT_VALUE = 0.1
    MAX_RIGHT_VALUE = 0.001
    CENTER = 0.23

    def initialize(pin_motor_in1, 
                   pin_motor_in2,
                   pin_motor_pwm,
                   pin_servo_pwm,
                   options)

        super(pin_motor_in1, 
              pin_motor_in2,
              pin_motor_pwm,
              pin_servo_pwm,
              options)

        require 'pi_piper'
        @stearing = PiPiper::Pwm.new( pin: @pin_servo_pwm, mode: :markspace, clock: @options[:servo_clock])
        @pwm = PiPiper::Pwm.new(pin: @pin_motor_pwm)
        @in1 = PiPiper::Pin.new(pin: @pin_motor_in1, direction: :out)
        @in2 = PiPiper::Pin.new(pin: @pin_motor_in2, direction: :out)
    end

    def set_motor_params(pwm, in1, in2)
        super(pwm, in1, in2)
        in1 ? @in1.on : @in1.off
        in2 ? @in2.on : @in2.off
        @pwm.value = pwm
    end

    def set_servo_param(steering_in_percent)
        super(steering_in_percent)
    end
end

