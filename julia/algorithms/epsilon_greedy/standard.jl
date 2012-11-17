type EpsilonGreedy <: BanditAlgorithm
  epsilon::Float64
  counts::Vector{Int64}
  values::Vector{Float64}
end

function EpsilonGreedy(epsilon::Float64, n_arms::Int64)
  EpsilonGreedy(epsilon, zeros(Int64, n_arms), zeros(n_arms))
end

function initialize(algo::EpsilonGreedy, n_arms::Int64)
  algo.counts = zeros(Int64, n_arms)
  algo.values = zeros(n_arms)
end

function initialize(algo::EpsilonGreedy, arms::Vector)
  initialize(algo, length(arms))
end

function select_arm(algo::EpsilonGreedy)
  if rand() > algo.epsilon
    return ind_max(algo.values)
  else
    return randi(length(algo.values))
  end
end

function update(algo::EpsilonGreedy, chosen_arm::Int64, reward::Real)
  algo.counts[chosen_arm] += 1
  n = algo.counts[chosen_arm]
  
  value = algo.values[chosen_arm]
  algo.values[chosen_arm] = ((n - 1) / n) * value + (1 / n) * reward
end
