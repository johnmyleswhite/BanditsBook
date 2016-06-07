execfile("core.py")

import random

random.seed(1)
means = [0.1, 0.1, 0.1, 0.1, 0.9]
n_arms = len(means)
random.shuffle(means)
arms = [BernoulliArm(m) for m in means]
print("Best arm is " + str(ind_max(means)))

my_algo = AnnealingEpsilonGreedy([], [])
my_algo.initialize(n_arms)
results = test_algorithm(my_algo, arms, 5000, 250)

with open("algorithms/epsilon_greedy/annealing_results.tsv", "w") as f:
    for i in range(len(results[0])):
        f.write("\t".join(str(res[i]) for res in results) + "\n")
