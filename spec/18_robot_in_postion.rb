require_relative 'spec_helper'

describe Robot do

  before(:each) do 
    @@all_robots = []
  end
  
  describe "#Robot.in_position(x,y)" do

    it "should return a list of robots in the position" do
      robot1 = Robot.new
      robot1.move_left
      robot2 = Robot.new
      robot2.move_left
      expect(Robot.in_position(-1,0)).to eq([robot1, robot2])
    end

    it "should return a empty array if the position is empty" do
      expect(Robot.in_position(0,0)).to eq([])
    end

  end

end