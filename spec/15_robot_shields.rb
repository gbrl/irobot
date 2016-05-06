require_relative 'spec_helper'

# Robots can start with 50 shield points. When the robot is damaged it first drains the 
# shield and then starts affecting actual health.

# You will likely also have to fix previous tests that will fail due to this enhancement. 
# However, focus on running spec 16 until you are done, then rerun all your tests to find 
# other failing tests and modify the tests to modify their expectations.

describe Robot do

  before do
    @robot = Robot.new
    @grenade = Grenade.new
    @laser = Laser.new
    @plasma_cannon = PlasmaCannon.new
  end

  it "should lose no health when wounded if shields are full" do
    expect(@robot.health).to eq(100)
  end

  it "should lose shields when wounded if are shield full" do
    @robot.wound(@laser.damage)
    expect(@robot.shields).to eq(25)
  end

end