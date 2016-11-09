require_relative '../motor.rb'

describe 'when initialize with parameters' do
    it 'should access throgh each accessro ' do
        target = Motor.new(1, 2, 3, 4, {mode: :production})
        expect(target.pin_motor_in1).to eq 1
        expect(target.pin_motor_in2).to eq 2
        expect(target.pin_motor_pwm).to eq 3
        expect(target.pin_servo_pwm).to eq 4
        expect(target.options[:mode]).to eq :production
        expect(target.options[:servo_clock]).to eq 19.2 * 1_000_000
    end
end

