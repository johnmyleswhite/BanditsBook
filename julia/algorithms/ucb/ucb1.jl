# Play each machine once.
# Then always play machine j that maximizes UCB value.
# Like sqrt(log(sum(counts).^2)) / sqrt(counts[j])

mutable struct UCB <: BanditAlgorithm
  counts::Vector{Int}
  values::Vector{Float64}
end

function UCB(n_arms::Int)
  UCB(zeros(Int, n_arms), zeros(n_arms))
end

function initialize(algo::UCB, n_arms::Int)
  algo.counts = zeros(Int, n_arms)
  algo.values = zeros(n_arms)
end

function initialize(algo::UCB, arms::Vector)
  initialize(algo, length(arms))
end

function select_arm(algo::UCB)
  if any(algo.counts .== 0)
    return find(algo.counts .== 0)[1]
  else
    ucb_values = algo.values + sqrt((2 * log(sum(algo.counts))) ./ algo.counts)
    return indmax(ucb_values)
  end
end

function update(algo::UCB, chosen_arm::Int, reward::Real)
  algo.counts[chosen_arm] += 1
  n = algo.counts[chosen_arm]

  value = algo.values[chosen_arm]
  algo.values[chosen_arm] = ((n - 1) / n) * value + (1 / n) * reward
end
