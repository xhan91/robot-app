require_relative 'spec_helper'

describe Battery do

  before(:each) do
    @battery = Battery.new
  end

  it "starts with name" do
    expect(@battery.name).to eq("Battery")
  end

  it "starts with weight" do
    expect(@battery.weight).to eq(25)
  end

  describe "#recharge" do
    it "should recharge robot's shield" do
      robot = Robot.new
      robot.wound(10)
      # expect(robot).to receive(:shield=)
      @battery.recharge(robot)
      expect(robot.shield).to eq(50)
    end
  end

end
