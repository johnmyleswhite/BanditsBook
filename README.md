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

# API

As described in the book, a Bandit algorithm should implement two methods:
* `select_arm()`
* `update()`

As described in the book, an Arm simulator should implement:
* `draw()`

In addition, the Bandit algorithms are designed to implement one additional method used in simulations:
* `initialize()`

In a future iteration, this code should be extended to provide Environment objects, which encapsulate not only a set of Arms, but also a mechanism for having those Arms change over time.
