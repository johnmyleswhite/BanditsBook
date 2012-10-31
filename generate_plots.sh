#!/bin/bash

# Pick your favorite language and run code for that language only.

# Use Julia for simulations

# cd julia
# julia algorithms/epsilon_greedy/test_standard.jl
# julia algorithms/epsilon_greedy/test_annealing.jl
# julia algorithms/softmax/test_standard.jl
# julia algorithms/softmax/test_annealing.jl
# julia algorithms/ucb/test_ucb1.jl
# julia algorithms/exp3/test_exp3.jl
# cd ..

# Use Python for simulations

# cd python
# python algorithms/epsilon_greedy/test_standard.py
# python algorithms/epsilon_greedy/test_annealing.py
# python algorithms/softmax/test_standard.py
# python algorithms/softmax/test_annealing.py
# python algorithms/ucb/test_ucb1.py
# python algorithms/exp3/test_exp3.py
# cd ..

# Use R for generating graphs

# If you used Python for simulations, you'll need to
# replace all the references to `julia` in the R scripts.

Rscript r/epsilon_greedy/plot_standard.R
Rscript r/epsilon_greedy/plot_annealing.R
Rscript r/softmax/plot_standard.R
Rscript r/softmax/plot_annealing.R
Rscript r/ucb/plot_ucb1.R
Rscript r/exp3/plot_exp3.R
Rscript r/comparisons/plot_simple_comparisons.R
Rscript r/comparisons/plot_comparisons.R
