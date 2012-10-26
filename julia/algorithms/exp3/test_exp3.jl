load("core.jl")

srand(1)
means = [0.1, 0.1, 0.1, 0.1, 0.9]
n_arms = length(means)
means = means[randperm(n_arms)]
arms = map(mu -> BernoulliArm(mu), means)
println("Best arm is $(ind_max(means))")

total_results = zeros(0, 6)

for exp3_gamma in [0.1:0.1:0.5]
  algo = Exp3(n_arms, exp3_gamma)
  results = test_algorithm(algo, arms, 5000, 250)
  results = hcat(repmat([exp3_gamma], size(results, 1), 1), results)
  total_results = vcat(total_results, results)
end

csvwrite("algorithms/exp3/exp3_results.csv", total_results)
