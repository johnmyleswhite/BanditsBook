type FiveDriftingArms <: BanditEnvironment
end

function arms(env::FiveDriftingArms, trial::Int64)
  [
    BernoulliArm(((0 + trial) % 100) / 100.0),
    BernoulliArm(((10 + trial) % 100) / 100.0),
    BernoulliArm(((20 + trial) % 100) / 100.0),
    BernoulliArm((100 - ((1 + trial) % 100)) / 100.0),
    BernoulliArm((100 - trial % 100) / 100.0)
   ]
end

function n_arms(env::FiveDriftingArms)
  5
end
