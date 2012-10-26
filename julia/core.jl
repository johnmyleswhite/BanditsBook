load("distributions.jl")
import Distributions.*

function ind_max(x)
  findmax(x)[2]
end

abstract BanditAlgorithm
abstract BanditArm

load("arms/adversarial.jl")
load("arms/bernoulli.jl")
load("arms/normal.jl")

load("algorithms/epsilon_greedy/standard.jl")
load("algorithms/epsilon_greedy/annealing.jl")
load("algorithms/softmax/standard.jl")
load("algorithms/softmax/annealing.jl")
load("algorithms/ucb/ucb1.jl")
load("algorithms/exp3/exp3.jl")

load("testing_framework/tests.jl")
