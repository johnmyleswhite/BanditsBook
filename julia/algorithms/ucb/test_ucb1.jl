include("../../core.jl")

srand(1)
means = [0.1, 0.1, 0.1, 0.1, 0.9]
n_arms = length(means)
shuffle!(means)
arms = map(mu -> BernoulliArm(mu), means)
println("Best arm is $(indmax(means))")

total_results = zeros(0, 5)

algo = UCB(zeros(Int, n_arms), zeros(n_arms))
results = test_algorithm(algo, arms, 5000, 250)
total_results = vcat(total_results, results)

csvwrite("algorithms/ucb/ucb1_results.csv", total_results)
