type NormalArm <: BanditArm
  mu::Float64
  sigma::Float64
end

function draw(arm::NormalArm)
  rand(Normal(mu, sigma))
end
