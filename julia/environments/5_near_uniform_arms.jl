type FiveNearUniformArms <: BanditEnvironment
end

function arms(env::FiveNearUniformArms, trial::Int64)
  [
    BernoulliArm(0.48),
    BernoulliArm(0.49),
    BernoulliArm(0.51),
    BernoulliArm(0.50),
    BernoulliArm(0.52)
   ]
end

function n_arms(env::FiveNearUniformArms)
  5
end
