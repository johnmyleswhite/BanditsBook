struct AdversarialArm <: BanditArm
  t::Int
  active_start::Int
  active_end::Int
end

function draw(arm::AdversarialArm)
  if arm.active_start <= arm.t <= arm.active_end
    return 1
  else
    return 0
  end
end
