class Robot
  attr_reader :position, :items, :health, :shield
  attr_accessor :equipped_weapon

  @@all_robots = []
  CAPACITY = 250

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
    @shield = 50
    @@all_robots << self
  end

  def recharge
    @shield = 50
  end

  def wound(amount)
    # @health -= amount
    # @health = 0 if health < 0
    if amount > shield
      # amount -= shield
      @health -= (amount - shield)
      @shield = 0
      @health = 0 if health < 0
    else
      @shield -= amount
    end
  end

  def heal(amount)
    health + amount > 100 ? @health = 100 : @health += amount
    # @health += amount
    # @health = 100 if health > 100
  end

  def heal!(amount)
    raise RobotAlreadyDeadError.new("Cannot heal a dead robot!") if health <= 0
    heal(amount)
  end

  def attack(enemy)
    if equipped_weapon.is_a?(Grenade)
      attack_with_grenade(enemy)
    elsif equipped_weapon.is_a?(SpecialWeapon)
      attack_with_special_weapon(enemy)      
    else
      if in_reach?(enemy)
        if equipped_weapon
          equipped_weapon.hit(enemy)
        else
          attack_power = 5
          enemy.wound(attack_power)
        end
      end
    end
  end

  def attack!(enemy)
    raise UnattackableEnemy.new("Enemy is not a robot!") unless enemy.is_a?(Robot)
    attack(enemy)
  end

  def in_reach?(enemy)
    ((enemy.position[0] - self.position[0]).abs
      + (enemy.position[1] - self.position[1]).abs) <= (equipped_weapon ? equipped_weapon.range : 1)
  end

  def attack_with_grenade(enemy)
    # if ((enemy.position[0] - self.position[0]).abs
    #   + (enemy.position[1] - self.position[1]).abs) <= equipped_weapon.range
    if in_reach?(enemy)
      enemy.wound(equipped_weapon.damage)
      items.delete(equipped_weapon)
      self.equipped_weapon = nil
    end
  end

  def attack_with_special_weapon(enemy)
    if in_reach?(enemy)
      targets = enemy.scan
      targets << enemy
      targets.each {|target| target.wound_directly(equipped_weapon.damage)}
      items.delete(equipped_weapon)
      self.equipped_weapon = nil
    end
  end

  def wound_directly(amount)
    @health -= amount
    @health = 0 if health < 0
  end

  def move_left
    self.position[0] -= 1
  end

  def move_right
    self.position[0] += 1
  end

  def move_up
    self.position[1] += 1
  end

  def move_down
    self.position[1] -= 1
  end

  def pick_up(item)
    if items_weight + item.weight <= CAPACITY
      @items << item
      if item.is_a?(Weapon)
        self.equipped_weapon = item
      elsif item.is_a?(BoxOfBolts) && health <= 80
        item.feed(self)
      end
      true
    end
  end

  def items_weight
    items.inject(0) {|sum, item| sum += item.weight}
  end

  def scan
    result = []
    result += Robot.in_position(position[0]+1,position[1])
    result += Robot.in_position(position[0]-1,position[1])
    result += Robot.in_position(position[0],position[1]+1)
    result += Robot.in_position(position[0],position[1]-1)
    result
  end

  class << self

    def all_robots
      @@all_robots
    end

    def in_position(x,y)
      result = []
      @@all_robots.each do |robot|
        if robot.position == [x,y]
          result << robot
        end
      end
      result
    end

  end

end

class RobotAlreadyDeadError < StandardError
end

class UnattackableEnemy < StandardError
end
