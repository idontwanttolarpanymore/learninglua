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


local LeftGroupBox = tabz.Main:AddLeftGroupbox('Groupbox')

local yesno = false

LeftGroupBox:AddToggle('ws ENABLE', {
    Text = 'enable/disable walkspeed',
    Default = false, 
    Callback = function(Value)
		if Value == true then
			print("is true")
			yesno = true
		end

    end
})

LeftGroupBox:AddSlider('Ws slider', {
    Text = 'walkspeed:',
    Default = 0,
    Min = 0,
    Max = 1000,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        while yesno == true do
			task.wait(0.2)
			hum.WalkSpeed = Value
		end
    end
})

