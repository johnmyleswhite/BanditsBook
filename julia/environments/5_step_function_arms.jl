type FiveStepFunctionArms <: BanditEnvironment
	shift_time::Int64
end

function arms(env::FiveStepFunctionArms, trial::Int64)
  if trial > env.shift_time
    [
      BernoulliArm(0.1),
      BernoulliArm(0.2),
      BernoulliArm(0.3),
      BernoulliArm(0.4),
      BernoulliArm(0.5)
    ]
  else
    [
      BernoulliArm(0.5),
      BernoulliArm(0.4),
      BernoulliArm(0.3),
      BernoulliArm(0.2),
      BernoulliArm(0.1)
    ]
  end
end

function n_arms(env::FiveStepFunctionArms)
  5
end
