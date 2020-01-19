local DropHeight = 255
local posX = 196
local posZ = 196
script.Rain:Play()

function dissolve(hit)
	for i = 1, 10 do 
		hit.Transparency = hit.Transparency + .1
		wait(.1)
	end
	hit:Destroy()
end

while wait() do 
	local part = Instance.new("Part")
	part.Size = Vector3.new(3, 3, 3) -- 2.4
	part.BrickColor = BrickColor.new(226)
	part.CanCollide = false
	part.Position = Vector3.new(math.random(-posX, posX), DropHeight, math.random(-posZ, posZ)) 
	part.Parent = script.Parent
	part.Touched:connect(function(hit)
		if not hit.Anchored then
			local Human = hit.Parent:FindFirstChild("Humanoid")
			if Human ~= nil then 
				local Safe = Human:FindFirstChild("Cover")
				if Safe == nil then 
					dissolve(hit)
				end
			else
				dissolve(hit)
			end
		end
	end) 
end
