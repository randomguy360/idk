feedbackEnabled = true
function feedback(parent, message)
	if not feedbackEnabled then return end
	local h = parent:findFirstChild("announcement")
	if h ~= nil then
		h.Text = message
	else
		h = Instance.new("Message")
		h.Name = "announcement"
		h.Text = message
		h.Parent = parent
	end
end

function removeFeedback(parent, delay)
	local h = parent:findFirstChild("announcement")
	if h ~= nil then
		local txt = h.Text
		wait(delay)
		if h ~= nil and h.Text == txt then -- Make sure that there is not more feedback.
			h:remove()
		end
	end
end

function compilePlayers(players)
	local names = ""
	if #players == 1 then return players[1].Name end
	for i=1,#players do
		if i == #players then
			names = names.. "and ".. players[i].Name
		else
			names = names.. players[i].Name.. ", "
		end
	end
	return names
end
----------

function setTag(parent, type, name, value)

	local tag = parent:findFirstChild(name)
	if tag ~= nil then
		if tag.className == type then
			tag.Value = value
		else
			local newTag = Instance.new(type)
			newTag.Name = name
			newTag.Value = value
			newTag.Parent = parent 
		end
	else
		local newTag = Instance.new(type)
		newTag.Name = name
		newTag.Value = value
		newTag.Parent = parent 
	end
end

function getTag(parent, type, name, default)

	local tag = parent:findFirstChild(name)
	if tag ~= nil then
		if tag.className == type then
			return tag.Value
		else
			print("No tag of the specified name and class was found in ", parent)
			return default
		end
	else
		print("No tag named ", name, " found in ", parent)
		return default
	end
end

function died(player, humanoid)
	if player ~= nil then
		if humanoid ~= nil then
			if humanoid.Health == 0 then
				setTag(player, "BoolValue", "survived", false)
			end
		else
			setTag(player, "BoolValue", "survived", false)
		end
	end	
end

running = true
function start()
	local players = game.Players:getChildren()
	local connections = {}

	running = true

	for i=1,#players do
		if players[i].Character ~= nil then
			setTag(players[i], "BoolValue", "survived", true)
			table.insert(connections, players[i].Character.Humanoid.Changed:connect(function () died(players[i], players[i].Character.Humanoid) end))
		end
	end

	while running do
		wait(1)
	end

	players = game.Players:getChildren()
	local survivedt = {}

	for i=1,#players do
		local survived = getTag(players[i], "BoolValue", "survived", false)
		if survived then
			setTag(players[i]:findFirstChild("leaderstats"), "IntValue", "Survivals", getTag(players[i]:findFirstChild("leaderstats"), "IntValue", "Survivals", 0) + 1)
			setTag(players[i]:findFirstChild("leaderstats"), "IntValue", "Points", getTag(players[i]:findFirstChild("leaderstats"), "IntValue", "Points", 0) + bin.points.Value)
			table.insert(survivedt, players[i])
		end
	end
	bin.points.Value = 0



	for i=1,#connections do -- Disconnect all previous connections.
		connections[i]:disconnect()
	end

	if #survivedt > 0 then
		feedback(game.Workspace, compilePlayers(survivedt).. " survived.")
	else
		feedback(game.Workspace, "Nobody Survived!")
	end
	removeFeedback(game.Workspace, 3)
end

function runningChanged(run)
	print("Running Changed")
	if run.Value == true then
		start()
	else
		running = false
	end
end

function newPlayer(player)
	local stats = Instance.new("IntValue")
	stats.Name = "leaderstats"

	local points = Instance.new("IntValue")
	points.Name = "Points"
	points.Value = 0

	local survivals = Instance.new("IntValue")
	survivals.Name = "Survivals"
	survivals.Value = 0

	points.Parent = stats
	survivals.Parent = stats
	stats.Parent = player
end

game.Players.ChildAdded:connect(newPlayer)
bin.running.Changed:connect(function () runningChanged(bin.running) end)
print("Leaderboard Loaded")
