type AnnealingEpsilonGreedy <: BanditAlgorithm
  counts::Vector{Int64}
  values::Vector{Float64}
end

function AnnealingEpsilonGreedy(n_arms::Int64)
  AnnealingEpsilonGreedy(zeros(Int64, n_arms), zeros(n_arms))
end

function initialize(algo::AnnealingEpsilonGreedy, n_arms::Int64)
  algo.counts = zeros(Int64, n_arms)
  algo.values = zeros(n_arms)
end

function initialize(algo::AnnealingEpsilonGreedy, arms::Vector)
  initialize(algo, length(arms))
end

function select_arm(algo::AnnealingEpsilonGreedy)
  t = sum(algo.counts) + 1
  epsilon = 1 / log(t + eps(1.0))
  
  if rand() > epsilon
    ind_max(algo.values)
  else
    randi(length(algo.values))
  end
end

function update(algo::AnnealingEpsilonGreedy, chosen_arm::Int64, reward::Real)
  n = algo.counts[chosen_arm]
  algo.counts[chosen_arm] = n + 1
  
  value = algo.values[chosen_arm]
  if n == 0
    algo.values[chosen_arm] = reward
  else
    algo.values[chosen_arm] = ((n - 1) / n) * value + (1 / n) * reward
  end
end
