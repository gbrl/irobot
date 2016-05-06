class PlasmaCannon < Weapon
  attr_reader :name, :weight, :damage

  def initialize()
    # name, weight, damage
    super("Plasma Cannon", 200, 55)
  end

end