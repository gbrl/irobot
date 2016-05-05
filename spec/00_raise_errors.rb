require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @dead_robot = Robot.new
    @dead_robot.health = 0
    @item = Item.new("Thing",1)
  end

  describe "#attack!" do
    it "should not attack dead robots" do
      expect {@robot.attack!(@dead_robot)}.to raise_error(Robot::UnattackableEnemy)
    end

    it "should not attack items" do
      expect {@robot.attack!(@item)}.to raise_error(Robot::UnattackableEnemy)
    end
  end

  describe "#heal!" do
    it "should not heal dead robots" do
      expect {@dead_robot.heal!(3)}.to raise_error(Robot::RobotAlreadyDeadError)
    end
  end
end