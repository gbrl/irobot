class Weapon < Item
  attr_accessor :damage

  def initialize(name, weight, damage)
    @damage = damage
    super(name,weight)
  end

  def hit(robot)
    robot.wound(self.damage)
  end

end