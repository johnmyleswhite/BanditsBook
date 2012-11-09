def test_algorithm(algo, arms, num_sims, horizon)
  chosen_arms =  Array.new(num_sims * horizon, 0.0)
  rewards = Array.new(num_sims * horizon, 0.0)
  cumulative_rewards = Array.new(num_sims * horizon, 0.0)
  sim_nums = Array.new(num_sims * horizon, 0.0)
  times = Array.new(num_sims * horizon, 0.0)

  num_sims.times do |sim|
    sim = sim + 1
    algo.reset(arms.size)
    horizon.times do |t|
      t = t + 1
      index = (sim-1) * horizon + (t-1)
      sim_nums[index] = sim
      times[index] = t

      chosen_arm = algo.select_arm()
      chosen_arms[index] = chosen_arm

      reward = arms[chosen_arms[index]].draw()
      rewards[index] = reward

      if t == 1
        cumulative_rewards[index] = reward
      else
        cumulative_rewards[index] = cumulative_rewards[index - 1] + reward
      end
      algo.update(chosen_arm, reward)
    end
  end

  return [sim_nums, times, chosen_arms, rewards, cumulative_rewards]
end