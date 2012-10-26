load("core.jl")

srand(1)
means = [0.1, 0.1, 0.1, 0.1, 0.9]
n_arms = length(means)
means = means[randperm(n_arms)]
arms = map(mu -> BernoulliArm(mu), means)
println("Best arm is $(ind_max(means))")

total_results = zeros(0, 6)

for temperature in [0.1:0.1:0.5]
  algo = Softmax(n_arms, temperature)
  results = test_algorithm(algo, arms, 5000, 250)
  results = hcat(repmat([temperature], size(results, 1), 1), results)
  total_results = vcat(total_results, results)
end

csvwrite("algorithms/softmax/standard_softmax_results.csv", total_results)
