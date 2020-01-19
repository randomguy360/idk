disasters = {"Meteor","Rising Lava","Tornado"} 
countdownTime = 15 
disasterTime = 45

countdownMessage = "The next disaster will occur in %s seconds." 


items = {}
local w = game.Workspace:getChildren()
for i=1,#w do
	if w[i].Name == "leaderboard" and w[i]:findFirstChild("running") ~= nil and w[i]:findFirstChild("points") ~= ni then
		leaderboard = w[i]
	end
end
for i=1,#disasters do
	local item = game.Lighting:findFirstChild(disasters[i])
	if item ~= nil then
		item.Parent = nil
		table.insert(items, item)
	else
		print("Error! ", disasters[i], " was not found!")
	end
end

function chooseDisaster()
	return items[math.random(#items)]
end

function sethint(text)
	local hint = game.Workspace:findFirstChild("hint")
	if (hint ~= nil) then
		hint.Text = text
	else
		print("Hint does not exist, creating...")
		h = Instance.new("Hint")
		h.Name = "hint"
		h.Text = text
		h.Parent = game.Workspace
	end
	--print("Hint set to: ", text)
end

function removeHint()
	hint = game.Workspace:findFirstChild("hint")
	if (hint ~= nil) then hint:remove() end
end

function countdown(time)
	sethint(string.format(countdownMessage, tostring(time)))
	while (time > 0) do
		wait(1)
		time = time - 1
		sethint(string.format(countdownMessage, tostring(time)))
	end
	removeHint()
	return true
end

while true do
	countdown(countdownTime)

	if leaderboard ~= nil and leaderboard:findFirstChild("running") and leaderboard:findFirstChild("points") then -- For use with my BTS leaderboard.
		leaderboard.points.Value = 30 --Points after you survive disasters.
		leaderboard.running.Value = true
	end

	local m = chooseDisaster():clone()

     if disasterMessage ~= nil then
		local msg = Instance.new("Message")
		msg.Name = "DisasterMsg"
		msg.Text = string.format(disasterMessage, m.Name)
		msg.Parent = game.Workspace
		wait(3)
		msg.Parent = nil
	end

	m.Parent = game.Workspace
	m:makeJoints()
	wait(disasterTime)
	m:remove()

	if leaderboard ~= nil then 
		leaderboard.running.Value = false
	end
end

