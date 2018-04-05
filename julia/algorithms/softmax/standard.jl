mutable struct Softmax <: BanditAlgorithm
  temperature::Float64
  counts::Vector{Int}
  values::Vector{Float64}
end

function Softmax(n_arms::Int, temperature::Float64)
  Softmax(temperature, zeros(Int, n_arms), zeros(n_arms))
end

function initialize(algo::Softmax, n_arms::Int64)
  algo.counts = zeros(Int, n_arms)
  algo.values = zeros(n_arms)
end

function initialize(algo::Softmax, arms::Vector)
  initialize(algo, length(arms))
end

function select_arm(algo::Softmax)
  z = sum(exp(algo.values ./ algo.temperature))
  probs = exp(algo.values ./ algo.temperature) ./ z
  return rand(Categorical(probs))
end

function update(algo::Softmax, chosen_arm::Int, reward::Real)
  algo.counts[chosen_arm] += 1
  n = algo.counts[chosen_arm]

  value = algo.values[chosen_arm]
  algo.values[chosen_arm] = ((n - 1) / n) * value + (1 / n) * reward
end
