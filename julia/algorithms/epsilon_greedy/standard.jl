mutable struct EpsilonGreedy <: BanditAlgorithm
  epsilon::Float64
  counts::Vector{Int}
  values::Vector{Float64}
end

function EpsilonGreedy(epsilon::Float64, n_arms::Int)
  EpsilonGreedy(epsilon, zeros(Int64, n_arms), zeros(n_arms))
end

function initialize(algo::EpsilonGreedy, n_arms::Int)
  algo.counts = zeros(Int64, n_arms)
  algo.values = zeros(n_arms)
end

function initialize(algo::EpsilonGreedy, arms::Vector)
  initialize(algo, length(arms))
end

function select_arm(algo::EpsilonGreedy)
  if rand() > algo.epsilon
    return indmax(algo.values)
  else
    return rand(1:length(algo.values))
  end
end

function update(algo::EpsilonGreedy, chosen_arm::Int, reward::Real)
  algo.counts[chosen_arm] += 1
  n = algo.counts[chosen_arm]

  value = algo.values[chosen_arm]
  algo.values[chosen_arm] = ((n - 1) / n) * value + (1 / n) * reward
end
