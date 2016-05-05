class Grenade < Weapon
  attr_accessor :name, :weight, :damage, :range

  def initialize(name = "Grenade", weight = 40, damage = 15)
    super(name, weight, damage)
    @range = 2
  end
  
end