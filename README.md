# Code to Accompany the Book "Bandit Algorithms for Website Optimization"

This repo contains code in several languages that implements several standard algorithms for solving the Multi-Armed Bandits Problem, including:

* epsilon-Greedy
* Softmax
* UCB1
* Exp3

It also contains code that provides a testing framework for bandit algorithms based around simple Monte Carlo simulations.

# Languages

This codebase is split up by language. In most languages, there are parallel implementations of the core algorithms and infrastructure for testing the algorithms:

* Python
* Julia

In R, there is a body of code for visualizing the results of simulations and analyzing those results. The R code would benefit from some refactoring to make it DRYer.

If you're interested in seeing how some of these algorithms would be implemented in Javascript, you should try out Mark Reid's code: http://mark.reid.name/code/bandits/

# Getting Started

To try out this code, you can go into the Python or Julia directories and then run the demo script.

In Python, that looks like:

    python demo.py

In Julia, that looks like:

    julia demo.jl

You should step through that code line-by-line to understand what the functions are doing. The book provides more in-depth explanations of how the algorithms work.

# Adding New Algorithms: API Expectations

As described in the book, a Bandit algorithm should implement two methods:

* `select_arm()`
* `update()`

As described in the book, an Arm simulator should implement:

* `draw()`

In addition, the Bandit algorithms are designed to implement one additional method used in simulations:

* `initialize()`

In a future iteration, this code should be extended to provide Environment objects, which encapsulate not only a set of Arms, but also a mechanism for having those Arms change over time.
