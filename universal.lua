local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/whoisthisxor/assets/main/Drawing.lua"))()
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Players = game:GetService("Players")
local lcplayer = Players.LocalPlayer
local char = lcplayer.Character or lcplayer.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local Window = Library:CreateWindow({
	Title = 'universal menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local tabz = {
    Main = Window:AddTab('Main'),
	ESPtab = Window:AddTab('ESPtab'),
    uisettings = Window:AddTab('UI Settings'),
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

local espbox = tabz.ESPtab:AddLeftGroupbox('Esp main')

local espstuff = {
	box = nil,
	name = nil,
	tracer = nil
}

local Esp_Enabled = false
local espColor = Color3.fromRGB(255, 0, 0)
local showBox = true
local showName = true
local showTracer = true

function createESP()
	if Esp_Enabled == false then return end

	espstuff.box = esp:MakeBox("all", {
		Visible = true,
		Color = espColor
	})

	espstuff.name = esp:MakeName("all", {
		Visible = true,
		Color = espColor,
		Text  = "Name"
	})

	espstuff.tracer = esp:MakeLine("all", {
        Visible = true,
        Color = espColor
    })
end

function RemoveESP()
	if espstuff.box then
		espstuff.box:Remove() 
	end
	if espstuff.name then
		espstuff.name:Remove() 
	end
	if espstuff.tracer then 
		espstuff.tracer:Remove() 
	end
	
	espstuff = {
		box = nil,
		name = nil,
		tracer = nil
	}
end

function UpdateESPColor(color)
    espColor = color
    if espstuff.box then 
		espstuff.box:UpdateColor(color) 
	end
    if espstuff.name then
		espstuff.name:UpdateColor(color) 
	end
    if espstuff.tracer then 
		espstuff.tracer:UpdateColor(color) 
	end
end

espbox:AddToggle("esp master toggle", {
	Text = "enable esp",
	Default = false,
	Callback = function(Value)
		Esp_Enabled = Value
		if Value == true then
			createESP()
		else
			RemoveESP()
		end
	end
})

espbox:AddLabel("ESP Color"):AddColorPicker("ESP_Color", {
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0,
    Callback = function(Value)
        UpdateESPColor(Value)
    end
})

espbox:AddToggle("ESP_Box", {
    Text = "Show box esp",
    Default = true,
    Callback = function(Value)
        showBox = Value
        if espstuff.box then
            espstuff.box:UpdateVisible(Value)
        end
    end
})

espbox:AddToggle("ESP_Name", {
    Text = "Show name esp",
    Default = true,
    Callback = function(Value)
        showName = Value
        if espstuff.name then
            espstuff.name:UpdateVisible(Value)
        end
    end
})

espbox:AddToggle("ESP_Tracer", {
    Text = "Show tracers",
    Default = true,
    Callback = function(Value)
        showTracer = Value
        if espstuff.tracer then
            espstuff.tracer:UpdateVisible(Value)
        end
    end
})

espbox:AddSlider("ESP_TextSize", {
    Text = "Name Text Size",
    Default = 20,
    Min = 10,
    Max = 50,
    Rounding = 1,
    Callback = function(Value)
        if espstuff.name then
            espstuff.name:UpdateSize(Value)
        end
    end
})
