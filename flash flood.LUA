count = 0
while true do
	count = count + 1
	if count <= 55 then
		script.Parent.CFrame = script.Parent.CFrame  + Vector3.new(0, 0.4, 0)
	end
	for i, v in pairs(game.Players:GetChildren()) do
		local torso = v.Character:FindFirstChild("Torso") or v.Character:FindFirstChild("UpperTorso")
		if v.Character and v.Character:FindFirstChild("Humanoid") and torso then
			if torso.Position.Y < (script.Parent.CFrame.p.Y + 13) then
				v.Character.Humanoid:TakeDamage(6)
			end
		end
	end
	wait(.2)
end
