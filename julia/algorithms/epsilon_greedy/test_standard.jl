load("core.jl")

srand(1)
means = [0.1, 0.1, 0.1, 0.1, 0.9]
n_arms = length(means)
means = means[randperm(n_arms)]
arms = map(mu -> BernoulliArm(mu), means)
println("Best arm is $(ind_max(means))")

total_results = zeros(0, 6)

for epsilon in [0.1:0.1:0.5]
  algo = EpsilonGreedy(epsilon, zeros(Int64, n_arms), zeros(n_arms))
  results = test_algorithm(algo, arms, 5000, 250)
  results = hcat(repmat([epsilon], size(results, 1), 1), results)
  total_results = vcat(total_results, results)
end

csvwrite("algorithms/epsilon_greedy/standard_results.csv", total_results)
