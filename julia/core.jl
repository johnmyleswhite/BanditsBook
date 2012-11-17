load("distributions.jl")
using Distributions

function ind_max(x)
  findmax(x)[2]
end

abstract BanditAlgorithm
abstract BanditArm
abstract BanditEnvironment

load("arms/adversarial.jl")
load("arms/bernoulli.jl")
load("arms/normal.jl")

load("algorithms/epsilon_greedy/standard.jl")
load("algorithms/epsilon_greedy/annealing.jl")
load("algorithms/softmax/standard.jl")
load("algorithms/softmax/annealing.jl")
load("algorithms/ucb/ucb1.jl")
load("algorithms/exp3/exp3.jl")
load("algorithms/hedge/hedge.jl")

load("environments/2_seasonal_arms.jl")
load("environments/5_constant_arms.jl")
load("environments/5_drifting_arms.jl")
load("environments/5_near_uniform_arms.jl")
load("environments/5_step_function_arms.jl")

load("testing_framework/tests.jl")
