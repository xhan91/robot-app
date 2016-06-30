class Battery < Item

  def initialize
    super("Battery", 25)
  end

  def recharge(target)
    target.recharge
  end

end