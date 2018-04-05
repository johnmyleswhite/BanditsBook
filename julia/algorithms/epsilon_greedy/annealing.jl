mutable struct AnnealingEpsilonGreedy <: BanditAlgorithm
  counts::Vector{Int}
  values::Vector{Float64}
end

function AnnealingEpsilonGreedy(n_arms::Int)
  AnnealingEpsilonGreedy(zeros(Int64, n_arms), zeros(n_arms))
end

function initialize(algo::AnnealingEpsilonGreedy, n_arms::Int)
  algo.counts = zeros(Int, n_arms)
  algo.values = zeros(n_arms)
end

function initialize(algo::AnnealingEpsilonGreedy, arms::Vector)
  initialize(algo, length(arms))
end

function select_arm(algo::AnnealingEpsilonGreedy)
  t = sum(algo.counts) + 1
  epsilon = 1 / log(t + eps(1.0))

  if rand() > epsilon
    return indmax(algo.values)
  else
    return rand(1:length(algo.values))
  end
end

function update(algo::AnnealingEpsilonGreedy, chosen_arm::Int, reward::Real)
  algo.counts[chosen_arm] += 1
  n = algo.counts[chosen_arm]

  value = algo.values[chosen_arm]
  algo.values[chosen_arm] = ((n - 1) / n) * value + (1 / n) * reward
end
