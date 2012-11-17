type AnnealingSoftmax <: BanditAlgorithm
  counts::Vector{Int64}
  values::Vector{Float64}
end

function AnnealingSoftmax(n_arms::Int64)
  AnnealingSoftmax(zeros(Int64, n_arms), zeros(n_arms))
end

function initialize(algo::AnnealingSoftmax, n_arms::Int64)
  algo.counts = zeros(Int64, n_arms)
  algo.values = zeros(n_arms)
end

function initialize(algo::AnnealingSoftmax, arms::Vector)
  initialize(algo, length(arms))
end

function select_arm(algo::AnnealingSoftmax)
  t = sum(algo.counts) + 1
  temperature = 1 / log(t + eps(1.0))
  z = sum(exp(algo.values ./ temperature))
  probs = exp(algo.values ./ temperature) ./ z
  return rand(Categorical(probs))
end

function update(algo::AnnealingSoftmax, chosen_arm::Int64, reward::Real)
  algo.counts[chosen_arm] += 1
  n = algo.counts[chosen_arm]

  value = algo.values[chosen_arm]
  algo.values[chosen_arm] = ((n - 1) / n) * value + (1 / n) * reward
end
