local eqSlots = {
    [0] = '01',
    [1] = '04',
    [2] = '07',
    [3] = '08',
    [4] = '02',
    [5] = '05',
    [6] = '15',
    [7] = '06',
    [8] = '16',
    [9] = '17',
    [10] = '11',
    [26] = '10',
    [11] = '12',
    [12] = '03',
    [13] = '14',
    [14] = '19',
    [15] = '21',
    [16] = '20',
}

local eqSlotsInspect = {
    [0] = '01',
    [1] = '04',
    [2] = '07',
    [3] = '08',
    [4] = '02',
    [5] = '05',
    [6] = '14',
    [7] = '06',
    [8] = '15',
    [9] = '16',
    [10] = '10',
    [26] = '09',
    [11] = '11',
    [12] = '03',
    [13] = '13',
    [14] = '17',
    [15] = '19',
    [16] = '18',
}

local romanNumerals = {
    [1] = 'I',
    [2] = 'II',
    [3] = 'III',
    [4] = 'IV',
    [5] = 'V',
    [6] = 'VI',
    [7] = 'VII',
    [8] = 'VIII',
    [9] = 'IX',
    [10] = 'X',
}

local DnDEnabled = false

local waitingForQuickInspect = false
local artsPanel = mainForm:GetChildChecked("ArtsPanel", false)
local statsAtcPanel = mainForm:GetChildChecked("StatsPanelAtc", false)
local statsAtcMainPanel = mainForm:GetChildChecked("StatsPanelAtcMain", false)
local statsDefPanel = mainForm:GetChildChecked("StatsPanelDef", false)
local statsDefMainPanel = mainForm:GetChildChecked("StatsPanelDefMain", false)

local panelTemplate = mainForm:GetChildChecked("Panel", false)

local panels = {
    ["Arts"] = {
        panel = artsPanel,
        setting = "ArtsPanel",
    },
    ["StatsAtc"] = {
        panel = statsAtcPanel,
        setting = "StatsAtcPanel",
    },
    ["StatsDef"] = {
        panel = statsDefPanel,
        setting = "StatsDefPanel",
    },
    ["StatsAtcMain"] = {
        panel = statsAtcMainPanel,
        setting = "StatsAtcPanel",
    },
    ["StatsDefMain"] = {
        panel = statsDefMainPanel,
        setting = "StatsDefPanel",
    }
}

local iconTemplate = mainForm:GetChildChecked("InspectIcon", false)
local panelTemplate = mainForm:GetChildChecked("Panel", false)
local cfgBtn = mainForm:GetChildChecked("ConfigButton", false)

local activeInspectWidgets = {}

local function showPanelDnDInfo(panelWidget)
    local infoWidgetDest = panelWidget:GetChildUnchecked("DnDInfo", false)
    if (infoWidgetDest ~= nil) then return end

    local panelPlacement = panelWidget:GetPlacementPlain()

    local infoWidget = CreateWG("Text", "DnDInfo", panelWidget, true,
        {
            alignX = 0,
            sizeX = panelPlacement.sizeX,
            posX = 0,
            highPosX = 0,
            alignY = 0,
            sizeY = panelPlacement.sizeY,
            posY = 0,
            highPosY = 0
        })
    infoWidget:SetFormat(userMods.ToWString(
        "<html><body alignx='center' aligny='middle' fontsize='13' outline='2'><rs class='class'><r name='name'/></rs></body></html>"))
    infoWidget:SetVal("name", panelWidget:GetName())
    infoWidget:SetClassVal("class", "ColorWhite")
end

local function hidePanelDnDInfo(panelWidget, hide)
    local infoWidget = panelWidget:GetChildUnchecked("DnDInfo", false)
    if (infoWidget ~= nil) then
        infoWidget:DestroyWidget()
        if (hide) then panelWidget:Show(false) end
    end
end

local function hidePanel(panelWidget)
    if (not DnDEnabled) then
        panelWidget:Show(false)
    else
        showPanelDnDInfo(panelWidget)
    end
end


local function clearActiveInspect()
    for k, v in pairs(activeInspectWidgets) do
        if (v ~= nil) then
            v:DestroyWidget()
        end
    end
end

local function onWidgetShowChanged(p)
    Log("onWidgetShowChanged: " .. p.widget:GetName())
end

local function onInspect(p)
    Log("onInspect: ")

    local tab = unit.GetEquipmentItemIds(avatar.GetTarget(), ITEM_CONT_EQUIPMENT)
    if (tab == nil) then return end

    if (avatar.IsTargetInspected()) then

    end
end

local function drawStatIcon(name, value, textureId, panelInfo, count)
    local panel = panelInfo.panel
    local setting = panelInfo.setting or "_"

    local size = UI.get(setting, "IconSize") or 40

    local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
    local textBg = nil
    WtSetPlace(widget, { sizeX = size, sizeY = size, posX = (size + 1) * (count), posY = 0 })

    if (value > 0) then
        if (UI.get(setting, "TextBackground")) then
            textBg = mainForm:CreateWidgetByDesc(panelTemplate:GetWidgetDesc())
            widget:AddChild(textBg)
            WtSetPlace(textBg, { sizeX = size, sizeY = size, posX = 0, posY = 0 })
            textBg:SetBackgroundColor(UI.getGroupColor(setting .. "TextBgColor") or
                { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
            textBg:Show(true)
        end

        local fontSize = 12
        if (value >= 1000 and 40 < 36) then fontSize = 10 end

        local countWidget = CreateWG("Text", "Count", textBg or widget, true,
            {
                alignX = 0,
                sizeX = 40,
                posX = 0,
                highPosX = 0,
                alignY = 0,
                sizeY = 40,
                posY = 3,
                highPosY = 0
            }
        )
        local alignX = UI.get(setting, "TextAlignX") or "right"
        local alignY = UI.get(setting, "TextAlignY") or "bottom"
        fontSize = UI.get(setting, "TextFontSize") or fontSize

        countWidget:SetFormat(userMods.ToWString(
            "<html><body alignx='"
            .. alignX ..
            "' aligny='"
            .. alignY ..
            "' fontsize='"
            .. fontSize ..
            "' outline='2'><rs class='class'><r name='name'/></rs></body></html>")
        )
        local stringCount = string.format("%.1f", value)
        if (UI.get(setting, "Round")) then
            stringCount = string.format("%.01d", value)
        end
        countWidget:SetVal("name", "" .. stringCount)
        countWidget:SetClassVal("class", "ColorWhite")

        countWidget:Show(true)
        table.insert(activeInspectWidgets, countWidget)
    end

    local texture = GetGroupTexture("RELATED_TEXTURES", textureId)
    if (texture ~= nil) then
        if (widget ~= nil) then
            widget:SetBackgroundTexture(texture)
            panel:AddChild(widget)
            widget:Show(true)
            table.insert(activeInspectWidgets, widget)
            return true
        end
    end

    return false
end

local function drawStatPanels(unitId)
    hidePanelDnDInfo(statsAtcPanel, false)
    hidePanelDnDInfo(statsDefPanel, false)
    hidePanelDnDInfo(statsAtcMainPanel, false)
    hidePanelDnDInfo(statsDefMainPanel, false)

    local stats = {
        ["ritual"] = 0,
        ["power"] = 0,
        ["stamina"] = 0
    }

    local powerArtLevel = 0

    for i = 0, 41 do
        local itemId = unit.GetEquipmentItemId(unitId, i, ITEM_CONT_EQUIPMENT)
        if (itemId == nil) then goto continue_stats end
        local info = itemLib.GetItemInfo(itemId)
        if (info == nil) then goto continue_stats end

        local itemBonus = itemLib.GetBonus(itemId)
        if (itemBonus ~= nil and itemBonus.miscStats) then
            if itemBonus.miscStats.power then
                stats["power"] = stats["power"] + itemBonus.miscStats.power.effective
            end
            if (itemBonus.miscStats.stamina) then
                stats["stamina"] = stats["stamina"] + itemBonus.miscStats.stamina.effective
            end
        end

        if (i >= 38 and i <= 40) then
            if (ARTS_POWER[FromWS(info.name)]) then
                powerArtLevel = info.level or 0
            end
        elseif (eqSlotsInspect[i]) then
            -- Log("[" .. i .. "] " .. FromWS(info.name))
            for k, v in pairs(itemBonus.specStats) do
                if (v ~= nil and v.tooltipName ~= nil and v.value ~= nil) then
                    local statName = FromWS(v.tooltipName)
                    if (stats[statName] == nil) then
                        stats[statName] = 0
                    end
                    -- Log(statName .. " " .. v.value)
                    stats[statName] = stats[statName] + v.value
                end
            end
        end

        ::continue_stats::
    end

    if (powerArtLevel > 0) then
        stats["power"] = stats["power"] + (powerArtLevel * 25) + 250
    end

    local atc_count = 0
    local def_count = 0
    local atc_main_count = 0
    local def_main_count = 0

    for k, v in pairs(stats) do
        if (STATS_ATC[k] ~= nil and UI.get(panels["StatsAtc"].setting, "ShowAdd")) then
            local added = drawStatIcon(k, v, STATS_ATC[k], panels["StatsAtc"], atc_count)
            if (added) then atc_count = atc_count + 1 end
        elseif (STATS_DEF[k] ~= nil and UI.get(panels["StatsDef"].setting, "ShowAdd")) then
            local added = drawStatIcon(k, v, STATS_DEF[k], panels["StatsDef"], def_count)
            if (added) then def_count = def_count + 1 end
        elseif (STATS_ATC_MAIN[k] ~= nil and UI.get(panels["StatsAtcMain"].setting, "ShowMain")) then
            if (not UI.get(panels["StatsAtcMain"].setting, "SeparateInTwo")) then
                local added = drawStatIcon(k, v, STATS_ATC_MAIN[k], panels["StatsAtc"], atc_count)
                if (added) then atc_count = atc_count + 1 end
            else
                local added = drawStatIcon(k, v, STATS_ATC_MAIN[k], panels["StatsAtcMain"], atc_main_count)
                if (added) then atc_main_count = atc_main_count + 1 end
            end
        elseif (STATS_DEF_MAIN[k] ~= nil and UI.get(panels["StatsDefMain"].setting, "ShowMain")) then
            if (not UI.get(panels["StatsDefMain"].setting, "SeparateInTwo")) then
                local added = drawStatIcon(k, v, STATS_DEF_MAIN[k], panels["StatsDef"], def_count)
                if (added) then def_count = def_count + 1 end
            else
                local added = drawStatIcon(k, v, STATS_DEF_MAIN[k], panels["StatsDefMain"], def_main_count)
                if (added) then def_main_count = def_main_count + 1 end
            end
        else
            Log(k .. " : " .. v)
        end
    end

    if (atc_count > 0) then
        WtSetPlace(statsAtcPanel,
            { sizeX = (40 + 1) * atc_count, sizeY = 40 })
        -- statsAtcPanel:SetBackgroundColor({ r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        statsAtcPanel:Show(true)
    end
    if (def_count > 0) then
        WtSetPlace(statsDefPanel,
            { sizeX = (40 + 1) * def_count, sizeY = 40 })
        -- statsDefPanel:SetBackgroundColor({ r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        statsDefPanel:Show(true)
    end
    if (atc_main_count > 0) then
        WtSetPlace(statsAtcMainPanel,
            { sizeX = (40 + 1) * atc_main_count, sizeY = 40 })
        -- statsAtcMainPanel:SetBackgroundColor({ r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        statsAtcMainPanel:Show(true)
    end
    if (def_main_count > 0) then
        WtSetPlace(statsDefMainPanel,
            { sizeX = (40 + 1) * def_main_count, sizeY = 40 })
        -- statsDefMainPanel:SetBackgroundColor({ r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        statsDefMainPanel:Show(true)
    end
end

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- =-              D R A W   A R T S              -=
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

local function drawMyArtsPanel()
    if (not UI.get("ArtsPanel", "Show")) then return end

    local artSize = UI.get("ArtsPanel", "IconSize") or 40

    WtSetPlace(artsPanel,
        { sizeX = (artSize + 1) * 3, sizeY = artSize })
    artsPanel:SetBackgroundColor(UI.getGroupColor("ArtsPanelBgColor") or { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
    artsPanel:Show(true)
    hidePanelDnDInfo(artsPanel, false)

    -- Artefact slots (38, 39, 40)
    for i = 38, 40 do
        local itemId = unit.GetEquipmentItemId(avatar.GetId(), i, ITEM_CONT_EQUIPMENT)
        if (itemId == nil) then goto continue_arts end
        local info = itemLib.GetItemInfo(itemId)
        if (info == nil) then goto continue_arts end

        local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
        local textBg = nil
        WtSetPlace(widget, { sizeX = artSize, sizeY = artSize, posX = (artSize + 1) * (i - 38), posY = 0 })

        if (UI.get("ArtsPanel", "TextBackground")) then
            textBg = mainForm:CreateWidgetByDesc(panelTemplate:GetWidgetDesc())
            widget:AddChild(textBg)
            WtSetPlace(textBg, { sizeX = artSize, sizeY = artSize, posX = 0, posY = 0 })
            textBg:SetBackgroundColor(UI.getGroupColor("ArtsPanelTextBgColor") or { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
            textBg:Show(true)
        end

        if (ARTS[FromWS(info.name)] ~= nil) then
            local textureId = ARTS[FromWS(info.name)]

            local texture = GetGroupTexture("RELATED_TEXTURES", textureId)
            if (texture ~= nil) then
                if (widget ~= nil) then
                    widget:SetBackgroundTexture(texture)
                end
            end
        end


        if (widget ~= nil) then
            artsPanel:AddChild(widget)

            local level = info.level
            if (level == nil) then level = 1 end

            local tempInfo = itemLib.GetTemporaryInfo(itemId)
            if (tempInfo ~= nil and level % 5 == 0) then
                if (UI.get("ArtsPanel", "UseRomansForTemporary")) then
                    level = romanNumerals[level / 5]
                else
                    level = level / 5
                end
            end

            local levelWidget = CreateWG("Text", "Level", textBg or widget, true,
                {
                    alignX = 0,
                    sizeX = artSize,
                    posX = 0,
                    highPosX = 0,
                    alignY = 0,
                    sizeY = artSize,
                    posY = 3,
                    highPosY = 0
                }
            )
            local alignX = UI.get("ArtsPanel", "TextAlignX") or "right"
            local alignY = UI.get("ArtsPanel", "TextAlignY") or "bottom"
            local fontSize = UI.get("ArtsPanel", "TextFontSize") or 15

            levelWidget:SetFormat(userMods.ToWString(
                "<html><body alignx='"
                .. alignX ..
                "' aligny='"
                .. alignY ..
                "' fontsize='"
                .. fontSize ..
                "' outline='2'><rs class='class'><r name='name'/></rs></body></html>")
            )

            levelWidget:SetVal("name", tostring(level))
            levelWidget:SetClassVal("class", "ColorWhite")

            widget:Show(true)
            levelWidget:Show(true)
            table.insert(activeInspectWidgets, widget)
        end

        ::continue_arts::
    end

    LogWidget(artsPanel)
end

local function onTargetChange(p)
    clearActiveInspect()
    hidePanel(artsPanel)
    hidePanel(statsAtcPanel)
    hidePanel(statsAtcMainPanel)
    hidePanel(statsDefPanel)
    hidePanel(statsDefMainPanel)

    local unitId = avatar.GetTarget()
    if (unitId == nil) then return end

    if (unitId == avatar.GetId()) then
        drawMyArtsPanel()
        drawStatPanels(avatar.GetId())
    end
end

local function onTimer(p)
    common.UnRegisterEventHandler(onTimer, "EVENT_SECOND_TIMER")
end

local function toggleDnD()
    DnDEnabled = not DnDEnabled

    DnD.Enable(cfgBtn, DnDEnabled)

    for k, v in pairs(panels) do
        if (v ~= nil and v.panel ~= nil) then
            DnD.Enable(v.panel, DnDEnabled)
            v.panel:SetTransparentInput(not DnDEnabled)

            if (not v.panel:IsVisibleEx() and DnDEnabled) then
                v.panel:Show(true)
                showPanelDnDInfo(v.panel)
            elseif (v.panel:IsVisibleEx() and not DnDEnabled) then
                hidePanelDnDInfo(v.panel, true)
            end
        end
    end

    UI.dnd(DnDEnabled)
end

local function onCfgLeft()
    if DnD:IsDragging() then
        return
    end

    UI.toggle()
end

local function onCfgRight()
    if DnD:IsDragging() then
        return
    end

    toggleDnD()
end

local function setupUI()
    LANG = common.GetLocalization() or "rus"
    UI.init("BetterInspect")

    UI.addGroup("ArtsPanel", {
        UI.createCheckBox("Show", true),
        UI.createSlider("IconSize", { stepsCount = 32, width = 212, offset = 32 }, 40),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 15),
        UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
        UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
        UI.createCheckBox("UseRomansForTemporary", true),
        UI.createCheckBox("TextBackground", false),
    })


    UI.createColorGroup("ArtsPanelBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.createColorGroup("ArtsPanelTextBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.addGroup("StatsAtcPanel", {
        UI.createCheckBox("ShowMain", true),
        UI.createCheckBox("ShowAdd", true),
        UI.createCheckBox("SeparateInTwo", true),
        UI.createSlider("IconSize", { stepsCount = 32, width = 212, offset = 32 }, 40),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 15),
        UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
        UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
        UI.createCheckBox("Round", true),
        UI.createCheckBox("TextBackground", false),
    })

    UI.createColorGroup("StatsAtcPanelBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.createColorGroup("StatsAtcPanelTextBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.addGroup("StatsDefPanel", {
        UI.createCheckBox("ShowMain", true),
        UI.createCheckBox("ShowAdd", true),
        UI.createCheckBox("SeparateInTwo", true),
        UI.createSlider("IconSize", { stepsCount = 32, width = 212, offset = 32 }, 40),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 15),
        UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
        UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
        UI.createCheckBox("Round", true),
        UI.createCheckBox("TextBackground", false),
    })

    UI.createColorGroup("StatsDefPanelBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.createColorGroup("StatsDefPanelTextBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.setTabs({
        {
            label = "Arts",
            buttons = {
                left = { "Restore" },
                right = { "Accept" }
            },
            groups = {
                "ArtsPanel",
                "ArtsPanelBgColor",
                "ArtsPanelTextBgColor",
            }
        },
        {
            label = "StatsAtc",
            buttons = {
                left = { "Restore" },
                right = { "Accept" }
            },
            groups = {
                "StatsAtcPanel",
                "StatsAtcPanelBgColor",
                "StatsAtcPanelTextBgColor",
            }
        },
        {
            label = "StatsDef",
            buttons = {
                left = { "Restore" },
                right = { "Accept" }
            },
            groups = {
                "StatsDefPanel",
                "StatsDefPanelBgColor",
                "StatsDefPanelTextBgColor",
            }
        },
    }, "Arts")

    UI.loadUserSettings()
    UI.render()
end

function Init()
    common.RegisterEventHandler(onWidgetShowChanged, "EVENT_WIDGET_SHOW_CHANGED")
    -- common.RegisterEventHandler(onChangeInventorySlot, "EVENT_INVENTORY_SLOT_CHANGED")
    -- common.RegisterEventHandler(onChangeEqSlot, "EVENT_UNIT_EQUIPMENT_CHANGED")
    common.RegisterEventHandler(onInspect, "EVENT_INSPECT_STARTED")
    -- common.RegisterEventHandler(onInspectFinish, "EVENT_INSPECT_FINISHED")
    common.RegisterEventHandler(onTargetChange, "EVENT_AVATAR_TARGET_CHANGED")

    common.RegisterEventHandler(onTimer, "EVENT_SECOND_TIMER")

    common.RegisterReactionHandler(onCfgLeft, "ConfigLeftClick")
    common.RegisterReactionHandler(onCfgRight, "ConfigRightClick")

    DnDEnabled = false

    DnD.Init(cfgBtn, cfgBtn, true)
    DnD.Enable(cfgBtn, false)

    UI.dnd(false)

    local index = 0
    for k, v in pairs(panels) do
        if (v ~= nil and v.panel ~= nil) then
            index = index + 1
            DnD.Init(v.panel, v.panel, true)
            DnD.Enable(v.panel, false)
            v.panel:SetTransparentInput(true)

            local size = 40
            local color = { r = 0.0, g = 0.0, b = 0.0, a = 0.5 }

            if (v.setting ~= nil) then
                size = UI.get(v.setting, "IconSize") or size
                color = UI.getGroupColor(v.setting .. "BgColor") or color
            end

            WtSetPlace(v.panel,
                { sizeX = (size + 1) * 3, sizeY = size })
            v.panel:SetBackgroundColor(color)
        end
    end

    setupUI()
    -- LogWidget(mainForm)
end

if (avatar.IsExist()) then
    Init()
else
    common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
end
