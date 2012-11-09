class Softmax
  def initialize(temperature, n_arms)
    @temperature = temperature
    @counts = Array.new(n_arms, 0)
    @values = Array.new(n_arms, 0.0)
  end

  def reset(n_arms)
    @counts = Array.new(n_arms, 0)
    @values = Array.new(n_arms, 0.0)
  end

  def select_arm
    z = @values.collect{|i| Math.exp(i/@temperature)}.reduce(:+)
    probs = @values.collect{|i| Map.exp(i/@temperature)/z}
    categorical_draw(probs)
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

  private
  def categorical_draw(probs)
    z = rand()
    cum_prob = 0.0

    probs.size().times do |i|
      prob = probs[i]
      cum_prob += prob
      if cum_prob > z
        return i
      end
    end

    return probs.size() - 1
  end
end