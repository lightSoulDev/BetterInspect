function ToWS(arg)
    return userMods.ToWString(arg)
end

function FromWS(arg)
    return userMods.FromWString(arg)
end

function WtSetPlace(w, place)
    local p = w:GetPlacementPlain()
    for k, v in pairs(place) do
        p[k] = place[k] or v
    end
    w:SetPlacementPlain(p)
end

function CreateWG(desc, name, parent, show, place)
    local n = mainForm:CreateWidgetByDesc(mainForm:GetChildChecked(desc, true):GetWidgetDesc())
    if name then n:SetName(name) end
    if parent then parent:AddChild(n) end
    if place then WtSetPlace(n, place) end
    n:Show(show == true)
    return n
end

function ExtractFloatFromString(s)
    local parts = {}

    for w in s:gmatch("%d[%d.,]*") do table.insert(parts, w) end
    local result = ""
    for k, v in pairs(parts) do
        result = result .. tostring(v)
    end

    return tonumber(result) or 0
end

function len(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function ToVariant(value)
    if (value) then return 1 end
    return 0
end

function range(min, max, step)
    local tmp = {}

    local count = (max - min) / step

    for i = 0, count, 1 do
        table.insert(tmp, min + i * step)
    end

    return tmp
end

function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function sortedKeys(t)
    local tmp = {}

    for k, v in pairs(t) do
        table.insert(tmp, k)
    end

    table.sort(tmp, function(a, b) return a:upper() < b:upper() end)
    return tmp
end

function contains(array, value)
    for k, v in pairs(array) do
        if (v == value) then
            return true
        end
    end

    return false
end

function GetGroupTexture(group, name)
    local g = common.GetAddonRelatedTextureGroup(group)

    if g and g:HasTexture(name) then
        return g:GetTexture(name)
    end
end

function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function GetConfig(name)
    local cfg = userMods.GetGlobalConfigSection(common.GetAddonName())
    if not name then return cfg end
    return cfg and cfg[name]
end

function SetConfig(name, value)
    local cfg = userMods.GetGlobalConfigSection(common.GetAddonName()) or {}
    if type(name) == "table" then
        for i, v in pairs(name) do cfg[i] = v end
    elseif name ~= nil then
        cfg[name] = value
    end
    userMods.SetGlobalConfigSection(common.GetAddonName(), cfg)
end

local function checkWString(v)
    if not common.IsWString(v) then
        error(('param 1 not a class WString (type: %s)'):format(common.GetApiType(v)))
    end
    return v
end

local function checkValuedText(v)
    if not common.IsValuedText(v) then
        error(('param 1 not a class ValuedText (type: %s)'):format(common.GetApiType(v)))
    end
    return v
end

function common.ExtractWStringFromValuedText(valuedText)
    return checkValuedText(valuedText):ToWString()
end
