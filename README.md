# Code to Accompany the Book "Bandit Algorithms for Website Optimization"

This repo contains code in several languages that implements several standard algorithms for solving the Multi-Armed Bandits Problem, including:

* epsilon-Greedy
* Softmax (Boltzmann)
* UCB1
* UCB2
* Hedge
* Exp3

It also contains code that provides a testing framework for bandit algorithms based around simple Monte Carlo simulations.

# Languages

This codebase is split up by language. In most languages, there are parallel implementations of the core algorithms and infrastructure for testing the algorithms:

* Python
* Julia
* Ruby

In R, there is a body of code for visualizing the results of simulations and analyzing those results. The R code would benefit from some refactoring to make it DRYer.

If you're interested in seeing how some of these algorithms would be implemented in Javascript, you should try out Mark Reid's code: http://mark.reid.name/code/bandits/

If you're looking for Java code, try Dani Sola's work: https://github.com/danisola/bandit

If you're looking for Scala code, try everpeace(Shingo Omura)'s work: https://github.com/everpeace/banditsbook-scala

If you're looking for Go code, try Rany Keddo's work: https://github.com/purzelrakete/bandit

If you're looking for Clojure code, try Paul Ingles's work: https://github.com/pingles/clj-bandit

If you're looking for Swift code, see https://github.com/crenwick/Swiper

For a Flask implementation, see https://github.com/DeaconDesperado/flask_mab

# Getting Started

To try out this code, you can go into the Python or Julia directories and then run the demo script.

In Python, that looks like:

    python demo.py

In Julia, that looks like:

    julia demo.jl

You should step through that code line-by-line to understand what the functions are doing. The book provides more in-depth explanations of how the algorithms work.

The Ruby code was contributed by Kashif Rasul. If you're interested in translating the code into another language, please submit a pull request. I will merge any new implementations as soon as I can.

# Adding New Algorithms: API Expectations

As described in the book, a Bandit algorithm should implement two methods:

* `select_arm()`: A method that returns the index of the Arm that the Bandit object selects on the current play. No arguments are required.
* `update()`: A method that updates the internal state of the Bandit object in response to its most recently selected arm's reward. The index of the chosen arm and the amount of reward received must be passed as arguments.

As described in the book, an Arm simulator should implement:

* `draw()`: A method that returns a single instance of reward from the arm that was pulled. No arguments are required.

In addition, the Bandit algorithms are designed to implement one additional method used in simulations:

* `initialize()`: A method that returns nothing. Instead, this method resets all of the data-driven variables in a Bandit object. For most objects, this resets the counts and values field to their initial states. No arguments are required.

Beyond the testing framework described in the book, I am currently providing an additional system built around the concept of an Environment. Environment objects encapsulate not only a set of Arms, but also a mechanism for having those Arms change over time. This allows you to simulate complex scenarios that aren't well described by a constant set of arms.

If you would like to implement your own Environment, you will need to provide a very simple interface. The Environment interface requries you to implement two methods:

* `arms()`: A method that returns the array of arms that exist at time T. You must pass T as an argument.
* `n_arms()`: A method that returns the number of arms that the environment will return with each call to `arms()`. While the arms may change over time, the number of arms should not. No arguments are required.
