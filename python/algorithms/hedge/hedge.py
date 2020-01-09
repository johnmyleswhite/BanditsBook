import math
import random

def categorical_draw(probs):
  z = random.random()
  cum_prob = 0.0
  for i in range(len(probs)):
    prob = probs[i]
    cum_prob += prob
    if cum_prob > z:
      return i
  
  return len(probs) - 1

class Hedge:
  def __init__(self, temperature, counts, values):
    self.temperature = temperature
    self.counts = counts
    self.values = values
    return
  
  def initialize(self, n_arms):
    self.counts = [0 for col in range(n_arms)]
    self.values = [0.0 for col in range(n_arms)]
    return
  
  def select_arm(self):
    try:
      z = sum([math.exp(v / self.temperature) for v in self.values])
    except OverflowError:
      z = math.inf
    probs = []
    for v in self.values:
      try:
        probs.append(math.exp(v / self.temperature) / z)
      except OverflowError:
        probs.append(math.inf)
    return categorical_draw(probs)
  
  def update(self, chosen_arm, reward):
    self.counts[chosen_arm] = self.counts[chosen_arm] + 1
    
    value = self.values[chosen_arm]
    self.values[chosen_arm] = value + reward
    return
