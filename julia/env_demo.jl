load("core.jl")

total_results = zeros(0, 6)

#env = TwoSeasonalArms(100)
env = FiveDriftingArms()

# for exp3_gamma in [0.1:0.1:0.5]
#   algo = Exp3(n_arms(env), exp3_gamma)
#   results = test_algorithm(algo, env, 5000, 400)
#   results = hcat(repmat([exp3_gamma], size(results, 1), 1), results)
#   total_results = vcat(total_results, results)
# end

for tau in [0.1:0.1:0.5]
  algo = Softmax(n_arms(env), tau)
  results = test_algorithm(algo, env, 5000, 400)
  results = hcat(repmat([tau], size(results, 1), 1), results)
  total_results = vcat(total_results, results)
end

csvwrite("env_demo.csv", total_results)
