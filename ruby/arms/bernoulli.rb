class BernoulliArm
  def initialize(p)
    @p = p
  end

  def draw
    if rand() > @p
      0.0
    else
      1.0
    end
  end
end