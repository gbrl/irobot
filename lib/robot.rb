class Robot
  attr_accessor :position, :items, :health, :equipped_weapon

  def initialize(position = [0,0], items = [], health = 100, equipped_weapon = nil)
    @position = position
    @items    = items
    @health   = health
    @equipped_weapon = equipped_weapon
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

  def attack(robot)
    if self.equipped_weapon == nil
      robot.wound(5)
    else 
      self.equipped_weapon.hit(robot)
    end
  end

end
