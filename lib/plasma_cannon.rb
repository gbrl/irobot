class PlasmaCannon < Weapon
  attr_reader :name, :weight, :damage

  def initialize(name="Plasma Cannon", weight=200, damage=55)
    super(name,weight,damage)
  end

end