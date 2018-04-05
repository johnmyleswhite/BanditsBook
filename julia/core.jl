#load("distributions.jl")
using Distributions

abstract type BanditAlgorithm end
abstract type BanditArm end
abstract type BanditEnvironment end

include("arms/adversarial.jl")
include("arms/bernoulli.jl")
include("arms/normal.jl")

include("algorithms/epsilon_greedy/standard.jl")
include("algorithms/epsilon_greedy/annealing.jl")
include("algorithms/softmax/standard.jl")
include("algorithms/softmax/annealing.jl")
include("algorithms/ucb/ucb1.jl")
include("algorithms/exp3/exp3.jl")
include("algorithms/hedge/hedge.jl")

include("environments/2_seasonal_arms.jl")
include("environments/5_constant_arms.jl")
include("environments/5_drifting_arms.jl")
include("environments/5_near_uniform_arms.jl")
include("environments/5_step_function_arms.jl")

include("testing_framework/tests.jl")
