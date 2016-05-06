require_relative 'spec_helper'

# Introduce the concept of a special weapon which is like a grenade but with a range of 1. 
# However, in addition to being targetted at a specific robot, 
# this one-time use weapon damages all robots surrounding the target. 
# Its damage goes straight through shields (if you implemented shields) 
# and directly reduces their health by 30 points.

describe Robot do

  before do
    Robot.class_variable_set(:@@robots, [])

    @robot  = Robot.new
    @robot.position  = [1,1]

    @robot2 = Robot.new 
    @robot2.position = [1,2]

    @robot3 = Robot.new
    @robot3.position = [1,3]

    @robot4 = Robot.new
    @robot4.position = [2,1]

    @robot5 = Robot.new 
    @robot5.position = [2,2]

    @robot6 = Robot.new
    @robot6.position = [2,3]

    @robot7 = Robot.new
    @robot7.position = [3,0]

    @robot8 = Robot.new 
    @robot8.position = [3,1]

    @robot9 = Robot.new
    @robot9.position = [3,2]

    @robot10 = Robot.new
    @robot10.position = [3,3]

    @robot11 = Robot.new 
    @robot11.position = [4,0]

    @robot12 = Robot.new
    @robot12.position = [4,1]

    @supergrenade = SuperGrenade.new

  end

  it "should return 380 points total group health after 4 robots are bombed" do
      # expect( @robot4.scan.length ).to eql(3)
      @robot7.equipped_weapon = @supergrenade
      casualties = @robot8.scan
      @robot7.bomb(@robot8)
      total_health = casualties.inject(0) { |sum,robot| sum += robot.health }
      # 4 robots have 70 points health, and one (the attack has 100), together that equals 380
      expect(total_health).to eql(380)
  end

  after do
    Robot.class_variable_set(:@@robots, [])
  end
  
end