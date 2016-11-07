

def createMotor(mode=:production)
    if(mode == :production) then
#        require_relative 'real_motor'
        return RealMotor.new
    else
        return StubMotor.new
    end

end

class Motor

    $lastUpdate = Time.now

    def driveMotor(x, y)
        if(x==0 && y==0 && (Time.now - $lastUpdate) > 0.5) then
            set_motor_params(0.0, false, false);
            return
        end

        p "drive motor #{x}, #{y}"
        if(y > 0) then
            set_motor_params(y.abs.to_f/100.0, true, false);

        else
            set_motor_params(y.abs.to_f/100.0, false, true);
        end

    end

    def update_last_operation_date
        $lastUpdate = Time.now
    end

    def set_motor_params(pwm, in1, in2)
    end
end

class StubMotor < Motor
    def set_motor_params(pwm, in1, in2)
        p "set_motor_params #{pwm} #{in1}, #{in2}"
    end
end