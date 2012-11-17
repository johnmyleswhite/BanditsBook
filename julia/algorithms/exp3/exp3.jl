type Exp3 <: BanditAlgorithm
  gamma::Float64
  weights::Vector{Float64}
end

function Exp3(n_arms::Int64, gamma::Float64)
  Exp3(gamma, ones(n_arms))
end

function initialize(algo::Exp3, n_arms::Int64)
  algo.weights = ones(n_arms)
end

function initialize(algo::Exp3, arms::Vector)
  initialize(algo, length(arms))
end

function select_arm(algo::Exp3)
  K = length(algo.weights)
  probs = (1 - algo.gamma) * (algo.weights ./ sum(algo.weights)) + (algo.gamma / K)
  return rand(Categorical(probs))
end

function update(algo::Exp3, chosen_arm::Int64, reward::Real)
  K = length(algo.weights)
  probs = (1 - algo.gamma) * (algo.weights ./ sum(algo.weights)) + (algo.gamma / K)

  x = zeros(K)
  x[chosen_arm] = reward / probs[chosen_arm]

  algo.weights = algo.weights .* exp((algo.gamma / K) .* x)  
end
