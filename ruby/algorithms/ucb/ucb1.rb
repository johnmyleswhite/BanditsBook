class UCB1
  def initialize(epsilon, n_arms)
    @epsilon = epsilon
    @counts = Array.new(n_arms, 0)
    @values = Array.new(n_arms, 0.0)
  end

  def reset(n_arms)
    @counts = Array.new(n_arms, 0)
    @values = Array.new(n_arms, 0.0)
  end

  def select_arm
    arm = @count.index(0)
    return arm unless arm.is_nil?

    ucb_values = Array.new(@count.size, 0.0)
    total_counts = @counts.reduce(:+)

    @counts.size do |arm|
      bonus = Math.sqrt((2 * Math.log(total_counts)) / @counts[arm].to_f)
      ucb_values[arm] = @values[arm] + bonus
    end

     @ucb_values.index(@ucb_values.max)
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

    return
  end
end