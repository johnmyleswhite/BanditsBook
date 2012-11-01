function test_algorithm(algo::BanditAlgorithm, arms::Vector, num_sims::Int64, horizon::Int64)
  chosen_arms = zeros(Int64, num_sims * horizon)
  rewards = zeros(num_sims * horizon)
  cumulative_rewards = zeros(num_sims * horizon)
  sim_nums = zeros(num_sims * horizon)
  times = zeros(num_sims * horizon)
  
  for sim in 1:num_sims
    initialize(algo, length(arms))
    
    for t = 1:horizon
      index = (sim - 1) * horizon + t
      sim_nums[index] = sim
      times[index] = t
      
      chosen_arm = select_arm(algo)
      chosen_arms[index] = chosen_arm
      
      reward = draw(arms[chosen_arms[index]])
      rewards[index] = reward
      
      if t == 1
        cumulative_rewards[index] = reward
      else
        cumulative_rewards[index] = cumulative_rewards[index - 1] + reward
      end
      
      update(algo, chosen_arm, reward)
    end
  end
  
  hcat(sim_nums, times, chosen_arms, rewards, cumulative_rewards)
end

function test_algorithm(algo::BanditAlgorithm, arms::Vector, num_sims::Int64, horizon::Int64)
  chosen_arms = zeros(Int64, num_sims * horizon)
  rewards = zeros(num_sims * horizon)
  cumulative_rewards = zeros(num_sims * horizon)
  sim_nums = zeros(num_sims * horizon)
  times = zeros(num_sims * horizon)
  
  for sim in 1:num_sims
    initialize(algo, length(arms))
    
    for t = 1:horizon
      index = (sim - 1) * horizon + t
      sim_nums[index] = sim
      times[index] = t
      
      chosen_arm = select_arm(algo)
      chosen_arms[index] = chosen_arm
      
      reward = draw(arms[chosen_arms[index]])
      rewards[index] = reward
      
      if t == 1
        cumulative_rewards[index] = reward
      else
        cumulative_rewards[index] = cumulative_rewards[index - 1] + reward
      end
      
      update(algo, chosen_arm, reward)
    end
  end
  
  hcat(sim_nums, times, chosen_arms, rewards, cumulative_rewards)
end

function test_algorithm(algo::BanditAlgorithm, env::BanditEnvironment, num_sims::Int64, horizon::Int64)
  chosen_arms = zeros(Int64, num_sims * horizon)
  rewards = zeros(num_sims * horizon)
  cumulative_rewards = zeros(num_sims * horizon)
  sim_nums = zeros(num_sims * horizon)
  times = zeros(num_sims * horizon)
  
  for sim in 1:num_sims
    initialize(algo, n_arms(env))
    
    for t = 1:horizon
      index = (sim - 1) * horizon + t
      sim_nums[index] = sim
      times[index] = t
      
      chosen_arm = select_arm(algo)
      chosen_arms[index] = chosen_arm
      
      current_arms = arms(env, t)
      reward = draw(current_arms[chosen_arms[index]])
      rewards[index] = reward
      
      if t == 1
        cumulative_rewards[index] = reward
      else
        cumulative_rewards[index] = cumulative_rewards[index - 1] + reward
      end
      
      update(algo, chosen_arm, reward)
    end
  end
  
  hcat(sim_nums, times, chosen_arms, rewards, cumulative_rewards)
end
