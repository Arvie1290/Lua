
-- Official ArvieHub GUI (Full Version + Script Detail Viewer) - Final  
-- by Arvie1290  
  
local Players = game:GetService("Players")  
local CoreGui = game:GetService("CoreGui")  
local UserInputService = game:GetService("UserInputService")  
local TextService = game:GetService("TextService")  
local LocalPlayer = Players.LocalPlayer  
  
-- Anti double execute  
if CoreGui:FindFirstChild("ArvieHub_Gui") then  
    CoreGui:FindFirstChild("ArvieHub_Gui"):Destroy()  
end  
  
-- GUI utama  
local ScreenGui = Instance.new("ScreenGui")  
ScreenGui.Name = "ArvieHub_Gui"  
ScreenGui.Parent = CoreGui  
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling  
  
-- Frame utama  
local MainFrame = Instance.new("Frame")  
MainFrame.Size = UDim2.new(0, 600, 0, 350)  
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)  
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)  
MainFrame.BorderSizePixel = 2  
MainFrame.Active = true  
MainFrame.Draggable = false  
MainFrame.Parent = ScreenGui  
  
-- Title bar  
local TitleBar = Instance.new("TextLabel")  
TitleBar.Size = UDim2.new(1, -90, 0, 30)  
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 0, 0)  
TitleBar.Text = "ArvieHub (V1.1)"  
TitleBar.TextColor3 = Color3.fromRGB(255, 0, 0)  
TitleBar.Font = Enum.Font.SourceSansBold  
TitleBar.TextSize = 18  
TitleBar.Parent = MainFrame  
  
-- Tombol close  
local CloseBtn = Instance.new("TextButton")  
CloseBtn.Size = UDim2.new(0, 30, 0, 30)  
CloseBtn.Position = UDim2.new(1, -30, 0, 0)  
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)  
CloseBtn.Text = "X"  
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)  
CloseBtn.Font = Enum.Font.SourceSansBold  
CloseBtn.TextSize = 18  
CloseBtn.Parent = MainFrame  
CloseBtn.MouseButton1Click:Connect(function()  
    ScreenGui:Destroy()  
end)  
  
-- Tombol minimize  
local MinimizeBtn = Instance.new("TextButton")  
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)  
MinimizeBtn.Position = UDim2.new(1, -60, 0, 0)  
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)  
MinimizeBtn.Text = "-"  
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)  
MinimizeBtn.Font = Enum.Font.SourceSansBold  
MinimizeBtn.TextSize = 18  
MinimizeBtn.Parent = MainFrame  
  
local isMinimized = false  
MinimizeBtn.MouseButton1Click:Connect(function()  
    isMinimized = not isMinimized  
    for _, v in pairs(MainFrame:GetChildren()) do  
        if v ~= TitleBar and v ~= CloseBtn and v ~= MinimizeBtn then  
            v.Visible = not isMinimized  
        end  
    end  
    MainFrame.Size = isMinimized and UDim2.new(0, 600, 0, 30) or UDim2.new(0, 600, 0, 350)  
    MinimizeBtn.Text = isMinimized and "+" or "-"  
end)  

-- Dragging  
local dragging = false  
local dragStart, startPos  
local function updateDrag(input)  
    local delta = input.Position - dragStart  
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)  
end  
TitleBar.InputBegan:Connect(function(input)  
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then  
        dragging = true  
        dragStart = input.Position  
        startPos = MainFrame.Position  
        input.Changed:Connect(function()  
            if input.UserInputState == Enum.UserInputState.End then  
                dragging = false  
            end  
        end)  
    end  
end)  
UserInputService.InputChanged:Connect(function(input)  
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then  
        updateDrag(input)  
    end  
end)  
  
-- Frame kiri (Script List)  
local ScriptList = Instance.new("ScrollingFrame")  
ScriptList.Size = UDim2.new(0.45, -5, 1, -40)  
ScriptList.Position = UDim2.new(0, 5, 0, 35)  
ScriptList.BackgroundTransparency = 1  
ScriptList.ScrollBarThickness = 6  
ScriptList.Parent = MainFrame  
  
-- Frame kanan (Detail)  
local DetailFrame = Instance.new("Frame")  
DetailFrame.Size = UDim2.new(0.55, -10, 1, -40)  
DetailFrame.Position = UDim2.new(0.45, 5, 0, 35)  
DetailFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)  
DetailFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)  
DetailFrame.BorderSizePixel = 2  
DetailFrame.Parent = MainFrame  
  
-- Detail isi  
local TitleScript = Instance.new("TextLabel")  
TitleScript.Size = UDim2.new(1, -10, 0, 30)  
TitleScript.Position = UDim2.new(0, 5, 0, 5)  
TitleScript.BackgroundTransparency = 1  
TitleScript.TextColor3 = Color3.fromRGB(255, 255, 255)  
TitleScript.Font = Enum.Font.SourceSansBold  
TitleScript.TextSize = 20  
TitleScript.Parent = DetailFrame  
  
local GameInfo = Instance.new("TextLabel")  
GameInfo.Size = UDim2.new(1, -10, 0, 20)  
GameInfo.Position = UDim2.new(0, 5, 0, 40)  
GameInfo.BackgroundTransparency = 1  
GameInfo.TextColor3 = Color3.fromRGB(180, 180, 180)  
GameInfo.Font = Enum.Font.SourceSans  
GameInfo.TextSize = 14  
GameInfo.Parent = DetailFrame  
  
local DescScroll = Instance.new("ScrollingFrame")  
DescScroll.Size = UDim2.new(1, -10, 0, 100)  
DescScroll.Position = UDim2.new(0, 5, 0, 65)  
DescScroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)  
DescScroll.BackgroundTransparency = 0.3  
DescScroll.ScrollBarThickness = 6  
DescScroll.CanvasSize = UDim2.new(0, 0, 0, 0)  
DescScroll.Parent = DetailFrame  
  
local DescriptionBox = Instance.new("TextLabel")  
DescriptionBox.Size = UDim2.new(1, -10, 0, 100)  
DescriptionBox.Position = UDim2.new(0, 5, 0, 0)  
DescriptionBox.BackgroundTransparency = 1  
DescriptionBox.TextColor3 = Color3.fromRGB(255, 255, 255)  
DescriptionBox.TextWrapped = true  
DescriptionBox.TextYAlignment = Enum.TextYAlignment.Top  
DescriptionBox.Font = Enum.Font.SourceSans  
DescriptionBox.TextSize = 14  
DescriptionBox.Parent = DescScroll  
  
local Photo = Instance.new("ImageLabel")  
Photo.Size = UDim2.new(1, -10, 0, 100)  
Photo.Position = UDim2.new(0, 5, 0, 170)  
Photo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  
Photo.ScaleType = Enum.ScaleType.Fit  
Photo.Parent = DetailFrame  
  
-- Tombol bawah  
local CopyGameLink = Instance.new("TextButton")  
CopyGameLink.Size = UDim2.new(0.3, 0, 0, 30)  
CopyGameLink.Position = UDim2.new(0, 5, 1, -35)  
CopyGameLink.BackgroundColor3 = Color3.fromRGB(60, 0, 0)  
CopyGameLink.Text = "COPY GAME LINK"  
CopyGameLink.TextColor3 = Color3.fromRGB(255, 255, 255)  
CopyGameLink.Font = Enum.Font.SourceSansBold  
CopyGameLink.TextSize = 14  
CopyGameLink.Parent = DetailFrame  
  
local CopyLoad = Instance.new("TextButton")  
CopyLoad.Size = UDim2.new(0.3, 0, 0, 30)  
CopyLoad.Position = UDim2.new(0.35, 0, 1, -35)  
CopyLoad.BackgroundColor3 = Color3.fromRGB(60, 0, 0)  
CopyLoad.Text = "COPY LOADSTRING"  
CopyLoad.TextColor3 = Color3.fromRGB(255, 255, 255)  
CopyLoad.Font = Enum.Font.SourceSansBold  
CopyLoad.TextSize = 14  
CopyLoad.Parent = DetailFrame  
  
local RunBtn = Instance.new("TextButton")  
RunBtn.Size = UDim2.new(0.3, 0, 0, 30)  
RunBtn.Position = UDim2.new(0.7, -5, 1, -35)  
RunBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  
RunBtn.Text = "RUN"  
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)  
RunBtn.Font = Enum.Font.SourceSansBold  
RunBtn.TextSize = 16  
RunBtn.Parent = DetailFrame  
  
-- Data scripts        
local scripts = {      
    {      
        name = "Speed Hub",      
        url = "https://raw.githubusercontent.com/SpeedHubV5/RANDOMIZER-/refs/heads/main/Esp-kg/SPEED-HUB-X",      
        gamelink = "https://www.roblox.com/games/126884695634066",      
        namegame = "Grow A Garden",      
        description = "Script Ini Punya : \n View Egg (Isi Telur) \n Udah Itu Aja Gak Tau Hehehe... :v \n (Keknya Make Key Ato Gak Soalnya Gak Pernah Nyoba)",      
        photo = "rbxassetid://11228473620",      
        placeid = "126884695634066"      
    },            
}      
  
-- Variabel debounce  
local debounceRun = false  
local debounceCopy = false  
local currentScriptData = nil  
  
-- Fungsi update detail  
function updateDetails(scriptData)  
    currentScriptData = scriptData  
    TitleScript.Text = scriptData.name or "{Title Script}"  
    GameInfo.Text = scriptData.namegame or "{Game Name}"  
    DescriptionBox.Text = "Description:\n"..(scriptData.description or "")  
    Photo.Image = scriptData.photo or ""  
    task.wait(0.1)  
    local textSize = TextService:GetTextSize(DescriptionBox.Text, DescriptionBox.TextSize, DescriptionBox.Font, Vector2.new(math.max(DescriptionBox.AbsoluteSize.X,1), math.huge))  
    DescriptionBox.Size = UDim2.new(1, -10, 0, textSize.Y + 10)  
    DescScroll.CanvasSize = UDim2.new(0, 0, 0, textSize.Y + 20)  
end  
  
-- Tombol copy Game Link  
CopyGameLink.MouseButton1Click:Connect(function()  
    if currentScriptData and setclipboard and not debounceCopy then  
        debounceCopy = true  
        setclipboard(currentScriptData.gamelink or "")  
        task.delay(0.3, function()  
            debounceCopy = false  
        end)  
    end  
end)  
  
-- Tombol copy Loadstring  
CopyLoad.MouseButton1Click:Connect(function()  
    if currentScriptData and setclipboard and not debounceCopy then  
        debounceCopy = true  
        setclipboard(currentScriptData.url and 'loadstring(game:HttpGet("'..currentScriptData.url..'"))()' or "")  
        task.delay(0.3, function()  
            debounceCopy = false  
        end)  
    end  
end)  
  
-- Tombol Run  
RunBtn.MouseButton1Click:Connect(function()  
    if currentScriptData and currentScriptData.url and not debounceRun then  
        debounceRun = true  
        pcall(function()  
            loadstring(game:HttpGet(currentScriptData.url))()  
        end)  
        task.delay(0.5, function()  
            debounceRun = false  
        end)  
    end  
end)  
  
-- Membuat tombol list script  
local selectedButton = nil  
local function createScriptButton(scriptData, index)  
    local btn = Instance.new("TextButton")  
    btn.Size = UDim2.new(1, -10, 0, 35)  
    btn.Position = UDim2.new(0, 5, 0, (index-1)*40)  
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)  
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)  
    btn.Font = Enum.Font.SourceSansBold  
    btn.TextSize = 16  
    btn.Text = scriptData.name or "Script"  
    btn.Parent = ScriptList  
  
    btn.MouseButton1Click:Connect(function()  
        if selectedButton then  
            selectedButton.BackgroundColor3 = Color3.fromRGB(30, 0, 0)  
        end  
        selectedButton = btn  
        btn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)  
        updateDetails(scriptData)  
    end)  
end  
  
-- Buat semua tombol list  
for i, s in ipairs(scripts) do  
    createScriptButton(s, i)  
end  
  
-- Auto pilih script pertama  
if #scripts > 0 then  
    updateDetails(scripts[1])  
    ScriptList:FindFirstChildOfClass("TextButton").BackgroundColor3 = Color3.fromRGB(60,0,0)  
    selectedButton = ScriptList:FindFirstChildOfClass("TextButton")  
end
