import random
import math

def ind_max(x):
  m = max(x)
  return x.index(m)

class AnnealingEpsilonGreedy(object):

  def __init__(self, counts, values):
    self.counts = counts
    self.values = values

  def initialize(self, n_arms):
    self.counts = [0] * n_arms
    self.values = [0.0] * n_arms

  def select_arm(self):
    t = sum(self.counts) + 1
    epsilon = 1 / math.log(t + 0.0000001)

    if random.random() > epsilon:
      return ind_max(self.values)
    else:
      return random.randrange(len(self.values))

  def update(self, chosen_arm, reward):
    new_count = self.counts[chosen_arm] + 1
    self.counts[chosen_arm] = new_count

    value = self.values[chosen_arm]
    new_value = (((new_count - 1) / float(new_count)) * value +
                 (1 / float(new_count)) * reward)
    self.values[chosen_arm] = new_value
