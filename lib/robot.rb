

class Robot

  class RobotAlreadyDeadError < StandardError
  end

  class UnattackableEnemy < StandardError
  end

  attr_accessor :position, :items, :health, :equipped_weapon

  def initialize(position = [0,0], items = [], health = 100, equipped_weapon = nil)
    @position        = position
    @items           = items
    @health          = health
    @equipped_weapon = equipped_weapon
    @default_damage  = 5
  end

  def health
    self.health
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
    return false if item.weight + self.items_weight > 250
    if item.is_a? Weapon
      @equipped_weapon = item
    end
     @items << item
     item.feed(self) if item.is_a?(BoxOfBolts) && self.health <= 80
  end

  def items_weight
    return 0 if @items.empty?
    weights = @items.map { |item| item.weight }
    weights.reduce(:+) 
  end

  def wound(amount)
    self.health -= amount
    self.health = 0 if self.health < 0
  end

  def heal(amount)
    self.health += amount
    self.health = 100 if self.health > 100
  end

  def heal!(amount)
    raise RobotAlreadyDeadError, "You cannot heal dead robots." if self.health <= 0
    self.health += amount
    self.health = 100 if self.health > 100
  end

  def close_enough?(robot1,robot2)
    (-1..1).include?(robot1.position[1] - robot2.position[1])
  end

  def attack(robot)
    if self.equipped_weapon == nil
      robot.wound(@default_damage) if close_enough?(self,robot)
    else 
      self.equipped_weapon.hit(robot) if close_enough?(self,robot)
    end
  end

  def attack!(robot)
    raise UnattackableEnemy, "You can only attack robots" unless robot.is_a? Robot
    raise UnattackableEnemy, "You can only attack live robots" if robot.health <= 0
    if self.equipped_weapon == nil
      robot.wound(@default_damage) if close_enough?(self,robot)
    else 
      self.equipped_weapon.hit(robot) if close_enough?(self,robot)
    end
  end

end
