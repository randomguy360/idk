function onTouched(hit)
if hit.Parent:FindFirstChild("Humanoid")then
hit:hit()
elseif hit.Parent:IsA"Hat"then
hit:Remove()
end end
script.Parent.Touched:connect(onTouched)
