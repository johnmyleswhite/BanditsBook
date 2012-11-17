load("core.jl")

srand(1)
means = [0.1, 0.1, 0.1, 0.1, 0.9]
n = length(means)
means = means[randperm(n)]
current_arms = map(mu -> BernoulliArm(mu), means)
println("Best arm is $(ind_max(means))")

total_results = zeros(0, 6)

for eta in [0.1:0.1:0.5]
  algo = Hedge(n, eta)
  results = test_algorithm(algo, current_arms, 5000, 250)
  results = hcat(repmat([eta], size(results, 1), 1), results)
  total_results = vcat(total_results, results)
end

csvwrite("algorithms/hedge/hedge_results.csv", total_results)
