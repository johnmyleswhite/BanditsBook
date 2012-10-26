type BernoulliArm <: BanditArm
  p::Float64
end

function draw(arm::BernoulliArm)
  if rand() > arm.p
    0
  else
    1
  end
end
