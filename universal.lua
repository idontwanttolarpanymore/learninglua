local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Players = game:GetService("Players")
local lcplayer = Players.LocalPlayer
local char = lcplayer.Character or lcplayer.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local Window = Library:CreateWindow({

	Title = 'simple menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local tabz = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}


local LeftGroupBox = tabz.Main:AddLeftGroupbox('Character')


local wsEnabled = false
local wsValue = 16
local jpEnabled = false
local jpValue = 50

LeftGroupBox:AddToggle('ws ENABLE', {
    Text = 'enable/disable walkspeed',
    Default = false,
    Callback = function(Value)
        wsEnabled = Value 
        if not Value then
            hum.WalkSpeed = 16  
        end
    end
})

LeftGroupBox:AddSlider('Ws slider', {
    Text = 'walkspeed:',
    Default = 16,
    Min = 0,
    Max = 1000,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        wsValue = Value
    end
})

LeftGroupBox:AddToggle('jp ENABLE', {
    Text = 'enable/disable jump power',
    Default = false,
    Callback = function(Value)
        jpenabled = Value 
        if not Value then
            hum.Jumppower = 50  
        end
    end
})

LeftGroupBox:AddSlider('jp slider', {
    Text = 'jump power:',
    Default = 50,
    Min = 0,
    Max = 1000,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        jpValue = Value
    end
})


task.spawn(function()
    while true do
        task.wait(0.1)
        if wsEnabled then
            hum.WalkSpeed = wsValue
        end
        if jpEnabled then
            hum.JumpPower = jpValue
        end
    end
end)

