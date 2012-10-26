type AdversarialArm <: BanditArm
  t::Int64
  active_start::Int64
  active_end::Int64
end

function draw(arm::AdversarialArm)
  if arm.active_start <= arm.t <= arm.active_end
    1
  else
    0
  end
end
