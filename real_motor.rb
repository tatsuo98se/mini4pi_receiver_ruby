require_relative 'motor'

class RealMotor < Motor

    MAX_LEFT_VALUE = 0.035
    MAX_RIGHT_VALUE = 0.045
    CENTER = 0.040
    CLOCK = 385

    attr_reader(:stearing, 
                :pwm,
                :in1,
                :in2)

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
        @pwm = PiPiper::Pwm.new(pin: @pin_motor_pwm, clock: 100)
        @stearing = PiPiper::Pwm.new( pin: @pin_servo_pwm, mode: :markspace, clock: CLOCK)
        @in1 = PiPiper::Pin.new(pin: @pin_motor_in1, direction: :out)
        @in2 = PiPiper::Pin.new(pin: @pin_motor_in2, direction: :out)
    end

    def set_motor_params(pwm, in1, in2)
        super(pwm, in1, in2)
        in1 ? @in1.on : @in1.off
        in2 ? @in2.on : @in2.off
        @pwm.on
        @pwm.value = pwm
    end

    def set_steering_params(steering_in_percent)
        super(steering_in_percent) 
        @stearing.on
        if(steering_in_percent > 0) then
            steering_in_percent = [steering_in_percent, 1].min
            @stearing.value = CENTER - (CENTER - MAX_LEFT_VALUE) * steering_in_percent.abs
        elsif(steering_in_percent < 0) then 
            steering_in_percent = [steering_in_percent, -1].max 
            @stearing.value = CENTER + (MAX_RIGHT_VALUE - CENTER) * steering_in_percent.abs
        else
            @stearing.value = CENTER
        end

    end

    def sleep
        super
        @pwm.off
        @stearing.off
        @in1.off
        @in2.off
    end
end

