class AnnealingEpsilonGreedy
  def initialize(n_arms)
    @counts = Array.new(n_arms, 0)
    @values = Array.new(n_arms, 0.0)
  end
  
  def reset(n_arms)
    @counts = Array.new(n_arms, 0)
    @values = Array.new(n_arms, 0.0)
  end

  def select_arm
    t = @counts.reduce(:+) + 1
    epsilon = 1 / Math.log(t + 0.0000001)

    if rand() > epsilon
      @values.index(@values.max)
    else
      rand(@values.size)
    end
  end

  def update(chosen_arm, reward)
     n = @counts[chosen_arm]
     @counts[chosen_arm] = n + 1

     value = @values[chosen_arm]
     if n == 0
       @values[chosen_arm] = reward
     else
       new_value = ((n - 1) / n.to_f) * value + (1 / n.to_f) * reward
       @values[chosen_arm] = new_value
     end
  end
end