require_relative 'spec_helper'

describe Robot do

  describe "#scan" do

    it "should return empty array if no robots surrounding" do
      robot = Robot.new
      expect(robot.scan).to eq([])
    end

    it "should return robots surrounding the robot" do
      robot = Robot.new
      robot_left = Robot.new
      robot_left.move_left
      robot_down = Robot.new
      robot_down.move_down
      expect(robot.scan).to eq([robot_left,robot_down])
    end

  end  

end
