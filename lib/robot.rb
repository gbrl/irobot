class Robot

  MAX_CAPACITY = 250

  @@robots = []

  class RobotAlreadyDeadError < StandardError
  end

  class UnattackableEnemy < StandardError
  end

  attr_accessor :position, :items, :health, :equipped_weapon, :shields

  def initialize(position = [0,0], items = [], health = 100, equipped_weapon = nil, shields = 50)
    @position        = position
    @items           = items
    @health          = health
    @equipped_weapon = equipped_weapon
    @shields         = shields
    @default_damage  = 5
    @@robots << self
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
    # Return with false if item weight would 
    return false if (item.weight + self.items_weight > MAX_CAPACITY) || self.items_weight >= MAX_CAPACITY
    # If the item is a wepon, equip it right away.
    if item.is_a? Weapon
      @equipped_weapon = item
    end
    # If it's a box of bolts and we can carry it, feed it to our robot.
    if item.is_a?(BoxOfBolts) && self.health <= 80
      item.feed(self) 
    end
    # Add the item to our items list
    @items << item
  end

  # def items_weight
  #   return 0 if @items.empty?
  #   weights = @items.map { |item| item.weight }
  #   weights.reduce(:+) 
  # end

  def items_weight
    @items.inject(0) { |sum,item| sum += item.weight }
  end

  def wound(amount)
    if amount < self.shields
      self.shields -= amount
    elsif self.shields > 0
      self.health = (self.shields - amount) + self.health
    else
      self.health -= amount
    end
    self.health = 0 if self.health < 0
  end

  def heal(amount)
    self.health += amount
    self.health = 100 if self.health > 100
  end

  def self.recharge()
    batteries = []
    self.items.each_with_index do |item,index| 
      batteries << item if item.is_a? Battery
    end
    if batteries.length >= 1
      self.shields = 50
      self.items.delete(batteries[0])
    end
  end

  def self.in_position(x,y)
    position = [x,y]
    robots = @@robots.select { |robot| robot.position == position }
  end

  def scan
    robots_nearby = []
    tile_up    = [self.position[0],(self.position[1]+1)]
    tile_down  = [self.position[0],(self.position[1]-1)]
    tile_left  = [(self.position[0]-1),self.position[1]]
    tile_right = [(self.position[0]+1),self.position[1]]

    [tile_up,tile_down,tile_left,tile_right,self.position].each do |position|
      robots_nearby << Robot.in_position(position[0],position[1])
    end
    robots_nearby = robots_nearby.reject { |robot| robot === self }
    robots_nearby.flatten!
  end

  def heal!(amount)
    raise RobotAlreadyDeadError, "You cannot heal dead robots." if self.health <= 0
    self.health += amount
    self.health = 100 if self.health > 100
  end

  def close_enough?(robot,enemy)
    distance = enemy.position[1] - robot.position[1]
    if (distance == 2) && (robot.equipped_weapon.is_a? Grenade)
      true
    elsif distance == 1 || distance == -1 || distance == 0
      true
    else
      false
    end
  end

  def attack(enemy)
    if self.equipped_weapon == nil
        enemy.wound(5) if close_enough?(self,enemy)
    elsif close_enough?(self,enemy)
        self.equipped_weapon.hit(enemy) 
        self.equipped_weapon = nil
    end
  end

  def bomb(enemy)
    if close_enough?(self,enemy) && (self.equipped_weapon.is_a? SuperGrenade)
      casualties = enemy.scan
      casualties.each do |victim|
        victim.health -= 30 unless victim == self
      end
    else
      raise UnattackableEnemy, "The enemy is too far for a SuperGrenade."
    end
  end

  def attack!(enemy)
    raise UnattackableEnemy, "You can only attack enemies" unless enemy.is_a? Robot
    raise UnattackableEnemy, "You can only attack live enemies" if enemy.health <= 0
    if self.equipped_weapon == nil
      enemy.wound(@default_damage) if close_enough?(self,enemy)
    else 
      self.equipped_weapon.hit(enemy) if close_enough?(self,enemy)
    end
  end

end
