type FiveConstantArms <: BanditEnvironment
end

function arms(env::FiveConstantArms, trial::Int64)
  [
   BernoulliArm(0.1),
   BernoulliArm(0.3),
   BernoulliArm(0.5),
   BernoulliArm(0.4),
   BernoulliArm(0.2)
   ]
end

function n_arms(env::FiveConstantArms)
  5
end
