require_relative 'spec_helper'

# Batteries are items that can be used by robot to recharge its shield. 
# Implement Battery item that can be used to recharge the Robot’s shield. Batteries have a weight of 25.

describe Robot do

  before do
    @robot  = Robot.new
    @battery = Battery.new
    @laser  = Laser.new
  end

  it "should lose no health when wounded if shields are full" do
    expect(@robot.health).to eq(100)
  end

  it "should lose shields when wounded if are shield full" do
    @robot.wound(@laser.damage)
    expect(@robot.shields).to eq(25)
  end

end