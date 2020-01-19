function onTouched(part)
	local h = part.Parent:findFirstChild("Humanoid")
	if h~=nil then
		h.Health = h.Health -0
	end
end

script.Parent.Touched:connect(onTouched)

Lava = script.Parent.Parent.Lava
LavaVelocity = Lava.BodyVelocity

while true do
LavaVelocity.velocity = Vector3.new(0,40,0)
wait(5)
LavaVelocity.velocity = Vector3.new(0,80,0)
wait(1)
LavaVelocity.velocity = Vector3.new(0,-200,0)
wait(1)

end
