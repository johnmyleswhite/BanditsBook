import random

def ind_max(x):
  m = max(x)
  return x.index(m)

class ThompsonSampling():
  def __init__(self, initial_alpha, initial_beta, counts, values, s_counts):
    self.counts = counts
    self.s_counts = s_counts
    self.values = values
    self.alpha = initial_alpha
    self.beta = initial_beta
    return

  def initialize(self, n_arms):
    self.counts = [0 for col in range(n_arms)]
    self.values = [0.0 for col in range(n_arms)]
    self.s_counts = [0 for col in range(n_arms)]
    return

  def select_arm(self):
    rho = lambda i:random.betavariate(self.alpha + self.s_counts[i], self.beta + self.counts[i] - self.s_counts[i])
    mu = map(rho, range(len(self.counts)))
    return ind_max(mu);

  def update(self, chosen_arm, reward):
    self.counts[chosen_arm] = self.counts[chosen_arm] + 1
    if reward == 1:
      self.s_counts[chosen_arm] += 1

    n = self.counts[chosen_arm]
    value = self.values[chosen_arm]
    new_value = ((n - 1) / float(n)) * value + (1 / float(n)) * reward
    self.values[chosen_arm] = new_value
    return
