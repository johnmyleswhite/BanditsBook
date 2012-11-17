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
    return ind_max(algo.values)
  else
    return randi(length(algo.values))
  end
end

function update(algo::AnnealingEpsilonGreedy, chosen_arm::Int64, reward::Real)
  algo.counts[chosen_arm] += 1
  n = algo.counts[chosen_arm]

  value = algo.values[chosen_arm]
  algo.values[chosen_arm] = ((n - 1) / n) * value + (1 / n) * reward
end
