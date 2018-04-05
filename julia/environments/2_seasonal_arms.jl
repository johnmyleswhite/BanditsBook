struct TwoSeasonalArms <: BanditEnvironment
  season_length::Int
end

function arms(env::TwoSeasonalArms, trial::Int)
  if div(trial, env.season_length) % 2 == 0
    [BernoulliArm(0.1), BernoulliArm(0.9)]
  else
    [BernoulliArm(0.9), BernoulliArm(0.1)]
  end
end

function n_arms(env::TwoSeasonalArms)
  2
end
