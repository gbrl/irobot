require_relative 'spec_helper'

# Batteries are items that can be used by robot to recharge its shield. 
# Implement Battery item that can be used to recharge the Robot’s shield. Batteries have a weight of 25.

describe Robot do

  before do
    @robot  = Robot.new
  end

  it "should increase by one when a robot is instantiated" do
    first_robots = Robot.class_variable_get(:@@robots).length
    @robot2 = Robot.new
    second_robots = Robot.class_variable_get(:@@robots).length
    expect(first_robots).to eq(second_robots - 1)
  end
end