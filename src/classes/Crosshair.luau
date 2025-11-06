local CrosshairClass = {}
CrosshairClass.__index = CrosshairClass

CrosshairClass.new = function()
	local self = setmetatable({}, CrosshairClass)
	self.Crosshair = Instance.new("ScreenGui")
	self.Crosshair.Name = "Crosshair"
	self.Crosshair.ResetOnSpawn = false
	self.Crosshair.DisplayOrder = 0
	self.Crosshair.IgnoreGuiInset = true

	self.Icon = Instance.new("ImageLabel")
	self.Icon.Name = "Icon"
	self.Icon.Parent = self.Crosshair
	self.Icon.BackgroundTransparency = 1
	self.Icon.Size = UDim2.new(0.1, 0, 0.1, 0)
	self.Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	self.Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	self.Icon.Image = "rbxassetid://11984821416" -- Default crosshair image
	self.Icon.ScaleType = Enum.ScaleType.Fit

	self.UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	self.UIAspectRatioConstraint.Parent = self.Icon

	return self
end

function CrosshairClass:ParentTo(parent)
	if parent then
		self.Crosshair.Parent = parent
	else
		warn("Parent instance is nil. Crosshair not parented.")
	end
end

return CrosshairClass

