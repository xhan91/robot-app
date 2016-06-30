require_relative 'spec_helper'

describe SpecialWeapon do

  it "should damage all robots surrounding the robot and use only once" do
    special_weapon = SpecialWeapon.new
    robot = Robot.new
    robot.equipped_weapon = special_weapon
    robot1 = Robot.new
    robot1.move_left
    robot2 = Robot.new
    robot2.move_left
    robot2.move_up
    robot.attack(robot1)
    expect(robot.health).to eq(70)
    expect(robot1.health).to eq(70)
    expect(robot2.health).to eq(70)
    expect(robot.equipped_weapon).to be(nil)
  end

end
