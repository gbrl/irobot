class Laser < Weapon
  attr_reader :name, :weight, :damage

  def initialize(name = "Laser", weight = 125, damage = 25)
    super(name, weight, damage)
  end

end