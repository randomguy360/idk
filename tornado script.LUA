function onTouched(hit)



bp = Instance.new("BodyPosition")
bp.Parent = hit
bp.maxForce = Vector3.new(4e+009, 4e+009, 4e+009)
bp.position = script.Parent.Position



end







connection = script.Parent.Touched:connect(onTouched)



