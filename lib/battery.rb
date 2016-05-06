class Battery < Item
  def initialize(name = "Battery", weight = 25)
    @weight = weight
    @name = name
  end
end