class Exp3
  def initialize(gamma, n_arms)
    @gamma = gamma
    @weights = Array.new(n_arms, 1.0)
  end

  def reset(n_arms)
    @weights = Array.new(n_arms, 1.0)
  end

  def select_arm
    n_arms = @weights.size()
    total_weight = @weights.reduce(:+)
    probs = Array.new(n_arms, 0.0)
    n_arms.times do |arm|
      probs[arm] = (1 - @gamma) * (@weights[arm] / total_weight)
      probs[arm] = probs[arm] + @gamma * (1.0 / n_arms.to_f)
    end
    categorical_draw(probs)
  end

  def update(chosen_arm, reward)
    n_arms = @weights.size()
    total_weight = @weights.reduce(:+)
    probs = Array.new(n_arms, 0.0)
    n_arms.times do |arm|
      probs[arm] = (1 - @gamma) * (@weights[arm] / total_weight)
      probs[arm] = probs[arm] + @gamma * (1.0 / n_arms.to_f)
    end

    x = reward / probs[chosen_arm]

    growth_factor = Math.exp((@gamma / n_arms) * x)
    @weights[chosen_arm] = @weights[chosen_arm] * growth_factor
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