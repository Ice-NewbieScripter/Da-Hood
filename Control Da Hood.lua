--control
local fatcaseoh = {"512f6", "JokeTheFool", "Sherosama", "Papa_Mbaye", "AStrongMuscle", "streetren", "NikoSenpai", "WashedGarage", "iumu", "Benoxa", "Luutyy", "clubstar54", "givkitheth", "kywiexcx", "ATKDrizzy", "dtbbullet", "XavierWildYT", "RogueDaHoodKing", "paxxythecreator", "NatsuDBlaze", "AnqelicMar", "DrBlakMD", "DarkWhirlwind", "coreten", "LegacyCross", "Greed_Ocean"} -- you can add more players by doing {"Player1", "Player2"}
            
game.Players.PlayerAdded:Connect(function(plr)
for i, v in pairs(fatcaseoh) do
if plr.Name == v then
local loc = game.Players.LocalPlayer
loc:Kick("A Mod Has Joined")
end
end
end)

loadstring(game:HttpGet("https://pastebin.com/raw/nzXicwc1", true))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/DaHood/AnimationPack.lua"))()

if getgenv().GrabWatcher then
	getgenv().GrabWatcher:Disconnect()
	getgenv().GrabWatcher = nil
	wait()
end

if getgenv().CHARADDED___ then
	getgenv().CHARADDED___:Disconnect()
	getgenv().CHARADDED___ = nil
	wait()
end

local OWNER = game:GetService("Players").LocalPlayer

local workPlayers = workspace.Players

local LiveConnections = {}

local function Align(P0, P1, Offset)
	return game:GetService("RunService").Heartbeat:Connect(function()
		P0.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		P0.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		P0.CFrame = P1.CFrame * (Offset or CFrame.new())
		P0.Velocity = Vector3.new(0, 0, 0)
		if not P0:FindFirstChildWhichIsA("BodyVelocity") then Instance.new("BodyVelocity",P0) end
		P0.BodyVelocity.velocity = Vector3.new(0,0,0)
		P0.BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
	end)
end

local function InsertOn(Table, Value)
	if type(Table) == "table" and Value then
		Table[#Table + 1] = Value
	end
end

local function Loop(Name, Callback)
	if game:GetService("RunService")[Name] then
		local CurrentLoop
		CurrentLoop = game:GetService("RunService")[Name]:Connect(function()
			local Result, Output = pcall(Callback)
			
			if not Result then
				CurrentLoop:Disconnect()
				warn(Output)
			end
		end)
		
		return CurrentLoop
	end
end
local PlayerClone

function AnimStop(ID, SPEED)
    for i,v in pairs(PlayerClone:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do
        if (v.Animation.AnimationId:match("rbxassetid://"..ID)) then
            if tonumber(SPEED) then
                v:Stop(SPEED)
            else
                v:Stop()
            end
        end 
    end
end

local function AnimPlay(ID,SPEED)
	for i,v in pairs(PlayerClone:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do if (v.Animation.AnimationId:match("rbxassetid://"..ID)) then v:Stop() end end
	local animation = Instance.new('Animation', game:GetService("Workspace"))
	animation.AnimationId = 'rbxassetid://'..ID
	playing = PlayerClone.Humanoid:LoadAnimation(animation)
	playing:Play() 
		if tonumber(SPEED) then
			playing:AdjustSpeed(SPEED)
		else
			playing:AdjustSpeed(1)
		end
	animation:Destroy()
end

local function AnimPlay1(ID)
	for i,v in pairs(OWNER.Character.Humanoid:GetPlayingAnimationTracks()) do
		if (v.Animation.AnimationId:match("rbxassetid://"..ID)) then
			v:Stop(0)
			if not PlayerClone:FindFirstChild(ID) then
				local animation = Instance.new('Animation', PlayerClone)
				animation.AnimationId = 'rbxassetid://'..ID
				animation.Name = "_____GYAT"
				playing = PlayerClone.Humanoid:LoadAnimation(animation)
				playing:Play()
			end
	 	end
	end
	if PlayerClone.Humanoid.MoveDirection.magnitude > 0 then
		AnimStop(ID)
		for _, v in pairs(PlayerClone:GetChildren()) do
			if v.Name == "_____GYAT" then
				v:Destroy()
			end
		end
	end	
end

local function AnimPlay2(ID,SPEED)
	for i,v in pairs(PlayerClone:WaitForChild("Humanoid"):GetPlayingAnimationTracks()) do if (v.Animation.AnimationId:match("rbxassetid://"..ID)) then v:Stop() return end end
	local animation = Instance.new('Animation', game:GetService("Workspace"))
	animation.AnimationId = 'rbxassetid://'..ID
	playing = PlayerClone.Humanoid:LoadAnimation(animation)
	playing:Play() 
		if tonumber(SPEED) then
			playing:AdjustSpeed(SPEED)
		else
			playing:AdjustSpeed(1)
		end
	animation:Destroy()
end

local function CloneCharacter(OldCharacter)

	OldCharacter.Archivable = true
	
	local newClone = OldCharacter:Clone()
	newClone.Humanoid.RootPart.Anchored = false
	newClone.Humanoid.Health = 9e9
	newClone.Humanoid.MaxHealth = 9e9
	newClone.RagdollConstraints:Destroy()
	newClone.BodyEffects:Destroy()
	newClone:WaitForChild("GRABBING_CONSTRAINT"):Destroy()
	for _, Class in pairs(newClone:GetDescendants()) do
		if Class:IsA("BasePart") and
		Class.Name ~= "Head" and
		Class.Name ~= "HumanoidRootPart" and
		Class.Name ~= "UpperTorso" and
		Class.Name ~= "LowerTorso" and
		Class.Name ~= "LeftUpperArm" and
		Class.Name ~= "RightUpperArm" and
		Class.Name ~= "LeftLowerArm" and
		Class.Name ~= "RightLowerArm" and
		Class.Name ~= "LeftHand" and
		Class.Name ~= "RightHand" and
		Class.Name ~= "LeftUpperLeg" and
		Class.Name ~= "RightUpperLeg" and
		Class.Name ~= "LeftLowerLeg" and
		Class.Name ~= "RightLowerLeg" and
		Class.Name ~= "LeftFoot" and
		Class.Name ~= "RightFoot" then
			Class.Massless = false
			Class:Destroy()
		end

		if Class:IsA("BasePart") then
			Class.CustomPhysicalProperties = PhysicalProperties.new(100, 2, .5, 100, 1)
			Class.Transparency = 1
		end
		
		if Class:IsA("Decal") then
			Class.Transparency = 1
		end

		if Class:IsA("Motor6D") then
			Class:Destroy()
		end

	end

	newClone.Parent = OWNER.Character
	newClone.Humanoid:ChangeState("GettingUp")
	OldCharacter.Archivable = false
	return newClone
end

local function onGrab()
	if OWNER.Character.BodyEffects.Grabbed.Value then
		wait()
		local GrabbedCharacter = OWNER.Character.BodyEffects.Grabbed.Value
		local GrabConstraint = GrabbedCharacter:WaitForChild("GRABBING_CONSTRAINT")
		
		if not GrabConstraint then return end
		
		local RopeGrab = GrabConstraint:FindFirstChildOfClass("RopeConstraint")
		RopeGrab.Length = 1/0
		
		local Origin
		
		OWNER.Character.Humanoid.RootPart.CFrame = OWNER.Character.Humanoid.RootPart.CFrame * CFrame.new(0, -15, 0)
		
		PlayerClone = CloneCharacter(GrabbedCharacter)

		workspace.CurrentCamera.CameraSubject = PlayerClone
		local RayParams = RaycastParams.new()
		RayParams.FilterDescendantsInstances = {OWNER.Character, PlayerClone}
		RayParams.IgnoreWater = true
		InsertOn(LiveConnections, Loop("Heartbeat", function()
			local RootPartPosition = PlayerClone.Humanoid.RootPart.CFrame.Position
			local RaycastResult = workspace:Raycast(RootPartPosition, RootPartPosition - Vector3.new(0, 9e9, 0), RayParams)
			local Position = Vector3.new()
			if RaycastResult and RaycastResult.Instance ~= nil then
				Position = RaycastResult.Position - Vector3.new(0, PlayerClone.Humanoid.RootPart.Size.Y * 5, 0)
			end
			OWNER.Character.Humanoid.RootPart.CFrame = CFrame.new(Vector3.new(Position.X, -Position.Y, Position.Z))
            OWNER.Character.Humanoid.RootPart.Velocity = Vector3.zero
		    --for i,v in pairs(OWNER.Character:FindFirstChild("Humanoid"):GetPlayingAnimationTracks()) do v:Stop() end
		end))

		InsertOn(LiveConnections, Loop("Stepped", function()
			AnimPlay1(3152375249)
			AnimPlay1(3152378852)
			AnimPlay1(3189773368)
			AnimPlay1(3189776546)
			AnimPlay1(3189777795)
			AnimPlay1(3189779152)
			AnimPlay1(3487719500)
			AnimPlay1(11710529975)
			AnimPlay1(11710524717)
			AnimPlay1(11710527244)
			AnimPlay1(11710529220)
			AnimPlay1(11710529220)
			AnimPlay1(11710524200)
			AnimPlay1(11710541744)
			--AnimPlay3(3152394906)
			PlayerClone.Humanoid.Jump = OWNER.Character.Humanoid.Jump
			PlayerClone.Humanoid:Move(OWNER.Character.Humanoid.MoveDirection, false)
			
			for _, Class in pairs(GrabbedCharacter:GetDescendants()) do
				if Class:IsA("BasePart") then
					Class.CanCollide = false
				end
			end
		end))
		
		for _, Class in pairs(PlayerClone:GetChildren()) do
			if Class:IsA("BasePart") and GrabbedCharacter:FindFirstChild(Class.Name) and Class.Name ~= "Head" and Class.Name ~= RopeGrab.Attachment1.Parent then
				InsertOn(LiveConnections, Align(GrabbedCharacter:FindFirstChild(Class.Name), Class, CFrame.new(0, 0, 0)))
			end
		end
		
		local function Stop()
			OWNER.Character.Humanoid.RootPart.CFrame = CFrame.new(PlayerClone.PrimaryPart.CFrame.Position) * CFrame.new(0, 5, 0)
			OWNER.Character.Humanoid.RootPart.Velocity = Vector3.zero
			workspace.CurrentCamera.CameraSubject = OWNER.Character
			PlayerClone:Destroy()
			for _, Connection in pairs(LiveConnections) do Connection:Disconnect()end
			for _, v in pairs(GrabbedCharacter:GetDescendants()) do if v:IsA("BodyVelocity") then v:Destroy()end end
		end
		
		local Ungrabbed
		local Speed__UP
		InsertOn(LiveConnections, OWNER:GetMouse().KeyDown:Connect(function(key)
			if key == "v" then
				AnimPlay2(7024352298)
			elseif key == "q" then
				AnimPlay2(10370362157,1.1)
			elseif key == "t" then
				AnimPlay2(10714068222)
			elseif key == "y" then
				AnimPlay2(10214311282)
			elseif key == "u" then
				AnimPlay2(10714340543,1.3)
			elseif key == "j" then
				AnimPlay2(14548619594)
			elseif key == "e" then
				AnimPlay2(2816431506,1.5)
			elseif key == "r" then
				AnimPlay2(11444443576,1.1)
			elseif key == "2" then
				AnimPlay(3152394906)
			elseif key == "f" then
				AnimPlay(2788354405)
			elseif key == "x" then
				Speed__UP = not Speed__UP
				if Speed__UP == true then
					repeat task.wait()
						PlayerClone.HumanoidRootPart.CFrame = PlayerClone.HumanoidRootPart.CFrame + PlayerClone.Humanoid.MoveDirection * 5
					until Speed__UP == false
				end
			end
		end))

		InsertOn(LiveConnections, OWNER:GetMouse().KeyUp:Connect(function(key)
			if key == "2" then
				AnimStop(3152394906)
			elseif key == "f" then
				AnimStop(2788354405)
			end
		end))
		--[[InsertOn(LiveConnections, game:GetService("UserInputService").InputBegan:Connect(function(v)
			if v.KeyCode == Enum.KeyCode.LeftControl then
				AnimPlay(3152394906)
			elseif v.KeyCode == Enum.KeyCode.F then
				AnimPlay(2788354405)
			end
		end))

		InsertOn(LiveConnections, game:GetService("UserInputService").InputEnded:Connect(function(v)
			if v.KeyCode == Enum.KeyCode.LeftControl then
				AnimStop(3152394906)
			elseif v.KeyCode == Enum.KeyCode.F then
				AnimStop(2788354405)
			end
		end))]]

		Ungrabbed = OWNER.Character.BodyEffects.Grabbed.Changed:Connect(function()
			if OWNER.Character.BodyEffects.Grabbed.Value == nil then
				Stop()
				Ungrabbed:Disconnect()
			end
		end)
	end
end

getgenv().GrabWatcher = OWNER.Character.BodyEffects.Grabbed:GetPropertyChangedSignal("Value"):Connect(onGrab)
getgenv().CHARADDED___ = OWNER.CharacterAdded:connect(function()
    OWNER.Character:WaitForChild("FULLY_LOADED_CHAR")
    getgenv().GrabWatcher = OWNER.Character.BodyEffects.Grabbed:GetPropertyChangedSignal("Value"):Connect(onGrab)
end)