struct BernoulliArm <: BanditArm
  p::Float64
end

function draw(arm::BernoulliArm)
  if rand() > arm.p
    return 0
  else
    return 1
  end
end
