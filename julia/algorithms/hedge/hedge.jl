type Hedge <: BanditAlgorithm
  eta::Float64
  counts::Vector{Int64}
  values::Vector{Float64}
end

function Hedge(n_arms::Int64, eta::Float64)
  Hedge(eta, zeros(Int64, n_arms), zeros(n_arms))
end

function initialize(algo::Hedge, n_arms::Int64)
  algo.counts = zeros(Int64, n_arms)
  algo.values = zeros(n_arms)
end

function initialize(algo::Hedge, arms::Vector)
  initialize(algo, length(arms))
end

function select_arm(algo::Hedge)
  z = sum(exp(algo.values * algo.eta))
  probs = exp(algo.values * algo.eta) ./ z
  return rand(Categorical(probs))
end

function update(algo::Hedge, chosen_arm::Int64, reward::Real)
  algo.counts[chosen_arm] += 1

  value = algo.values[chosen_arm]
  algo.values[chosen_arm] = value + reward
end
