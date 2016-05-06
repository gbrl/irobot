require_relative 'spec_helper'

# A given robot should be able to scan its surroundings (tiles immediately next to its current @position) 
# Note: You should leverage the class method implemented in #18

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

  end

  it "should return 4 since there are only 4 robots near or on position 2,1" do
    expect( @robot4.scan.length ).to eql(4)
  end

  after do
    Robot.class_variable_set(:@@robots, [])
  end
  
end