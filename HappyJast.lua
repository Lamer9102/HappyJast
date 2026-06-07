local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

getgenv().Settings = {
    Version = 1.3,
    Mouse = false,
    Hide = false,
    Range = 9e9,
    Sword = false,
}

local function SendNotification(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 5
        })
    end)
end

LocalPlayer:GetMouse().Button1Down:Connect(function()
    if Settings.Mouse and LocalPlayer:GetMouse().Hit then
        LocalPlayer.Character:PivotTo(CFrame.new(LocalPlayer:GetMouse().Hit.Position + Vector3.new(0, 3, 0)))
    end
end)

local function FireTouchTransmitter(part)
    local PartClass = part:FindFirstAncestorWhichIsA("Part")
    if firetouchinterest then
        local Character = LocalPlayer.Character:FindFirstChildOfClass("Part")
  
        if Character and part and PartClass then
            firetouchinterest(PartClass, Character, 0)
            firetouchinterest(PartClass, Character, 1)
            PartClass:PivotTo(Character:GetPivot())
        end
    else
        LocalPlayer.Character:PivotTo(PartClass:GetPivot())
    end
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:NewWindow(string.format("xxqLgnd Script %s", Settings.Version))

local MainToggle = Window:NewSection("Main Scripts")

MainToggle:CreateButton("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",true))()
end)

MainToggle:CreateButton("Dark Dex", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua",true))()
end)

MainToggle:CreateButton("Buy Item Checker", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xxqLgnd/Utilities/main/BuyItemChecker.lua",true))()
end)

MainToggle:CreateButton("WyConnect", function()
    loadstring(game:HttpGet("https://pastefy.app/16kxxJlL/raw",true))()
end)

MainToggle:CreateButton("Remote Spy", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua",true))()
end)

MainToggle:CreateButton("Turtle Spy", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Spy/main/source.lua",true))()
end)

MainToggle:CreateButton("Remote Browser", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/RemoteBrowser",true))()
end)

MainToggle:CreateButton("Dev Purchase's", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ckw69/Wyborn/refs/heads/main/Dev%20Product%20Purchase",true))()
end)

MainToggle:CreateButton("Adonis Bypass", function()
    local adonisFound = false
    for _, v in pairs(game:GetDescendants()) do
        if v.Name == "__FUNCTION" then
            adonisFound = true
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua'))()
            break
        end
    end
    if not adonisFound then
        SendNotification("Error...", "Adonis didn't found")
    end
end)

local MovingToggle = Window:NewSection("Moving")

MovingToggle:CreateToggle("Mouse Teleport", function(state)
    task.spawn(function()
        Settings.Mouse = state
    end)
end)

MovingToggle:CreateButton("Copy Position", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format("%d, %d, %d", PlayerPosition.X, PlayerPosition.Y, PlayerPosition.Z))
    end)
end)

MovingToggle:CreateButton("Copy Teleport", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format("game:GetService('Players').LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(%d, %d, %d)))", PlayerPosition.X + .5, PlayerPosition.Y + .5, PlayerPosition.Z + .5))
    end)
end)

MovingToggle:CreateButton("Copy TweenService", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format("game:GetService('TweenService'):Create(game:GetService('Players').LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2), {CFrame = CFrame.new(%d, %d, %d)}):Play()", PlayerPosition.X, PlayerPosition.Y, PlayerPosition.Z))
    end)
end)

MovingToggle:CreateButton("Copy MoveTo", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format([[
            local Humanoid = game:GetService('Players').LocalPlayer.Character.Humanoid
            Humanoid.WalkSpeed = 16
            Humanoid.JumpPower = 19
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            Humanoid:MoveTo(Vector3.new(%d, %d, %d))
            ]], PlayerPosition.X, PlayerPosition.Y, PlayerPosition.Z
        ))
    end)
end)

MovingToggle:CreateButton("Copy Lerp", function()
    pcall(function()
        local PlayerPosition = LocalPlayer.Character.HumanoidRootPart:GetPivot()
        setclipboard(string.format([[
            local HumanoidRootPart = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart
            for i = 0, 1, 0.05 do
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(CFrame.new(%d, %d, %d), i); task.wait()
            end]], PlayerPosition.X, PlayerPosition.Y, PlayerPosition.Z
        ))
    end)
end)

local ToolsToggle = Window:NewSection("Tools")

ToolsToggle:CreateToggle("Auto Hide Players", function(state)
    task.spawn(function()
        Settings.Hide = state
        while true do
            if not Settings.Hide then return end

            for _, v in pairs(Players:GetPlayers()) do
                if v.Name ~= LocalPlayer.Name and v.Character then
                    v.Character:Destroy()
                end
            end
            task.wait(.1)
        end
    end)
end)

ToolsToggle:CreateButton("Fire All ProximityPrompt", function()
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                fireproximityprompt(v)
            end
        end
    end)
end)

ToolsToggle:CreateButton("HoldDuration 0", function()
    task.spawn(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
    end)
end)

ToolsToggle:CreateButton("Fire All ClickDetectors", function()
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("ClickDetector") then
                fireclickdetector(v)
            end
        end
    end)
end)

ToolsToggle:CreateButton("Fire All Firetouchinterests", function()
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                FireTouchTransmitter(v)
            end
        end
    end)
end)

ToolsToggle:CreateTextbox("Sword Killaura Range", function(t)
    local tt = tonumber(t)
    if type(tt) == "number" then
        Settings.Range = tt
    end
end)

ToolsToggle:CreateToggle("Sword Killaura", function(state)
    task.spawn(function()
        Settings.Sword = state
        while true do
            if not Settings.Sword then return end
            for _,v in pairs(Players:GetPlayers()) do
                local Distance = LocalPlayer:DistanceFromCharacter(v.Character:GetPivot().Position)
                if v.Character and v.Character.Name ~= LocalPlayer.Name and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") and Distance <= Settings.Range then
                    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool and tool:FindFirstChild("Handle") then
                        tool:Activate()
                        for _,z in next, v.Character:GetChildren() do
                            if z:IsA("BasePart") then
                                firetouchinterest(tool.Handle, v, 0)
                                firetouchinterest(tool.Handle, v, 1)
                            end
                        end
                    end
                end
            end
            task.wait(.4)
        end
    end)
end)

