require_relative 'spec_helper'

describe Robot do

  it "should track all created robots" do
    robot1 = Robot.new
    robot2 = Robot.new
    robot3 = Robot.new
    expect(Robot.all_robots).to eq([robot1, robot2, robot3])
  end

end