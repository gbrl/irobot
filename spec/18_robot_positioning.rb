require_relative 'spec_helper'

# Batteries are items that can be used by robot to recharge its shield. 
# Implement Battery item that can be used to recharge the Robot’s shield. Batteries have a weight of 25.

describe Robot do

  before do
    @robot  = Robot.new
    @robot.position  = [2,3]

    @robot2 = Robot.new 
    @robot2.position = [2,3]

    @robot3 = Robot.new
    @robot3.position = [0,3]

    @robot4 = Robot.new
    @robot4.position = [2,0]
  end

  it "should return 2 since there are only 2 robots in position 2,3" do
    all_robots = Robot.class_variable_get(:@@robots).length
    robots_in_2_3 = Robot.in_position(2,3).length
    expect(robots_in_2_3).to eq(2)
  end
end