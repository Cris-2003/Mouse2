-- CFrameLerpOnce ModuleScript

local RunService = game:GetService("RunService")

local CFrameLerpOnce = {}
local activeLerps = {}

--[[
API:
CFrameLerpOnce:Lerp(key, cfRef, targetCFrame, duration)
- key: unique identifier for this lerp (string/object)
- cfRef: table containing the CFrame variable as `.value` (e.g. {value = AimCFrame})
         (You must use a table to allow the module to update your variable by reference)
- targetCFrame: CFrame, the target value
- duration: number, time in seconds

Example usage:
local CurrentOffset = {value = CFrame.new()}
CFrameLerpOnce:Lerp('Mouse2Shiftlock', CurrentOffset, CFrame.new(0,0,0), 0.5)
CFrameLerpOnce:Lerp('Mouse2Shiftlock', CurrentOffset, CFrame.new(2,2,2), 0.5)
]]

function CFrameLerpOnce:Lerp(key, cfRef, targetCFrame, duration)
	if not key or not cfRef or not targetCFrame then return end
	duration = duration or 0.5

	-- If a lerp is already running, stop it and use the last value as the new start
	if activeLerps[key] then
		activeLerps[key].disconnect()
	end

	local running = true
	local elapsed = 0
	-- Always start from the current value
	local startCFrame = cfRef.value

	local function disconnect()
		running = false
		activeLerps[key] = nil
	end

	local connection
	connection = RunService.RenderStepped:Connect(function(dt)
		if not running then
			if connection.Connected then
				connection:Disconnect()
			end
			return
		end
		elapsed = elapsed + dt
		local alpha = math.clamp(elapsed / duration, 0, 1)
		cfRef.value = startCFrame:Lerp(targetCFrame, alpha)
		if alpha >= 1 then
			cfRef.value = targetCFrame
			disconnect()
			if connection.Connected then
				connection:Disconnect()
			end
		end
	end)

	activeLerps[key] = {
		disconnect = function()
			running = false
			if connection.Connected then
				connection:Disconnect()
			end
			activeLerps[key] = nil
		end
	}
end

return CFrameLerpOnce

