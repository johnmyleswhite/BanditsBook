load("core.jl")

arm1 = BernoulliArm(0.7)
draw(arm1)

arm2 = BernoulliArm(0.2)
draw(arm2)

arms = [arm1, arm2]

algo = EpsilonGreedy(0.7, 2)

initialize(algo, arms)

horizon = 100

for t = 1:horizon
  chosen_arm = select_arm(algo)
  reward = draw(arms[chosen_arm])
  update(algo, chosen_arm, reward)
end

initialize(algo, arms)
