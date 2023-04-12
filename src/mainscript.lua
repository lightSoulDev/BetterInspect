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
local scrollsPanel = mainForm:GetChildChecked("ScrollsPanel", false)
local extraPanel = mainForm:GetChildChecked("ExtraPanel", false)

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
    },
    ["Scrolls"] = {
        panel = scrollsPanel,
        setting = "ScrollsPanel",
    },
    ["Extra"] = {
        panel = extraPanel,
        setting = "ExtraPanel",
    },
}

local iconTemplate = mainForm:GetChildChecked("InspectIcon", false)
local panelTemplate = mainForm:GetChildChecked("Panel", false)
local cfgBtn = mainForm:GetChildChecked("ConfigButton", false)

local activeInspectWidgets = {}

local function showPanelDnDInfo(panelWidget)
    local infoWidgetDest = panelWidget:GetChildUnchecked("DnDInfo", false)
    if (infoWidgetDest ~= nil) then return end

    local panelPlacement = panelWidget:GetPlacementPlain()

    local width = 5
    if (panelWidget:GetName() == "ArtsPanel") then width = 3 end

    WtSetPlace(panelWidget, { sizeX = (panelPlacement.sizeY + 1) * width, sizeY = panelPlacement.sizeY })

    local infoWidget = CreateWG("Text", "DnDInfo", panelWidget, true,
        {
            alignX = 0,
            sizeX = (panelPlacement.sizeY + 1) * width,
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

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- =-             D R A W   S T A T S             -=
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

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

    if (not UI.get(panels["StatsAtc"].setting, "ShowAdd") and
        not UI.get(panels["StatsDef"].setting, "ShowAdd") and
        not UI.get(panels["StatsAtcMain"].setting, "ShowMain") and
        not UI.get(panels["StatsDefMain"].setting, "ShowMain")) then
        return
    end

    local stats = {
        ["ritual"] = 0,
        ["power"] = 0,
        ["stamina"] = 0
    }

    local inspectedItems = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 26, 11, 12, 13, 14, 15, 16 }

    for i, slot in pairs(eqSlotsInspect) do
        local itemId = unit.GetEquipmentItemId(unitId, i, ITEM_CONT_EQUIPMENT)
        if (itemId == nil) then goto continue_stats end
        local info = itemLib.GetItemInfo(itemId)
        if (info == nil) then goto continue_stats end

        local itemBonus = itemLib.GetBonus(itemId)
        if (itemBonus == nil) then goto continue_stats end
        if (itemBonus.miscStats) then
            if itemBonus.miscStats.power then
                stats["power"] = stats["power"] + itemBonus.miscStats.power.effective
            end
            if (itemBonus.miscStats.stamina) then
                stats["stamina"] = stats["stamina"] + itemBonus.miscStats.stamina.effective
            end
        end

        for k, v in pairs(itemBonus.specStats) do
            if (v ~= nil and v.tooltipName ~= nil and v.value ~= nil) then
                local statName = FromWS(v.tooltipName)
                if (stats[statName] == nil) then
                    stats[statName] = 0
                end
                stats[statName] = stats[statName] + v.value
            end
        end

        ::continue_stats::
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
            -- Log(k .. " : " .. v)
        end
    end

    if (atc_count > 0) then
        local panelInfo = panels["StatsAtc"]

        WtSetPlace(panelInfo.panel,
            { sizeX = (40 + 1) * atc_count, sizeY = 40 })
        panelInfo.panel:SetBackgroundColor(UI.getGroupColor(panelInfo.setting .. "BgColor") or
            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        panelInfo.panel:Show(true)

        local size = UI.get(panelInfo.setting, "IconSize") or 40
        WtSetPlace(panelInfo.panel, { sizeX = (size + 1) * atc_count, sizeY = size })
    end
    if (def_count > 0) then
        local panelInfo = panels["StatsDef"]

        WtSetPlace(panelInfo.panel,
            { sizeX = (40 + 1) * def_count, sizeY = 40 })
        panelInfo.panel:SetBackgroundColor(UI.getGroupColor(panelInfo.setting .. "BgColor") or
            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        panelInfo.panel:Show(true)

        local size = UI.get(panelInfo.setting, "IconSize") or 40
        WtSetPlace(panelInfo.panel, { sizeX = (size + 1) * def_count, sizeY = size })
    end
    if (atc_main_count > 0) then
        local panelInfo = panels["StatsAtcMain"]

        WtSetPlace(panelInfo.panel,
            { sizeX = (40 + 1) * atc_main_count, sizeY = 40 })
        panelInfo.panel:SetBackgroundColor(UI.getGroupColor(panelInfo.setting .. "BgColor") or
            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        panelInfo.panel:Show(true)

        local size = UI.get(panelInfo.setting, "IconSize") or 40
        WtSetPlace(panelInfo.panel, { sizeX = (size + 1) * atc_main_count, sizeY = size })
    end
    if (def_main_count > 0) then
        local panelInfo = panels["StatsDefMain"]

        WtSetPlace(panelInfo.panel,
            { sizeX = (40 + 1) * def_main_count, sizeY = 40 })
        panelInfo.panel:SetBackgroundColor(UI.getGroupColor(panelInfo.setting .. "BgColor") or
            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        panelInfo.panel:Show(true)

        local size = UI.get(panelInfo.setting, "IconSize") or 40
        WtSetPlace(panelInfo.panel, { sizeX = (size + 1) * def_main_count, sizeY = size })
    end
end

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- =-            D R A W   E X T R A S            -=
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

local function drawExtras(unitId)
    hidePanelDnDInfo(extraPanel, false)

    if (not UI.get("ExtraPanel", "Show")) then return end
    local size = UI.get("ExtraPanel", "IconSize") or 40

    local count = 0

    local cloakMode = UI.get("ExtraPanel", "ShowCloak")
    if (cloakMode ~= nil and cloakMode ~= "-") then
        local itemId = unit.GetEquipmentItemId(unitId, 18, ITEM_CONT_EQUIPMENT)
        if (itemId == nil) then goto skip_cloak end
        local info = itemLib.GetItemInfo(itemId)
        if (info == nil) then goto skip_cloak end

        local name = FromWS(info.name)
        if (cloakMode == "banners" and BANNERS[name] == nil) then goto skip_cloak end

        if (CLOAKS[name] ~= nil) then
            local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
            local textBg = nil
            WtSetPlace(widget, { sizeX = size, sizeY = size, posX = (size + 1) * count, posY = 0 })

            if (UI.get("ExtraPanel", "TextBackground")) then
                textBg = mainForm:CreateWidgetByDesc(panelTemplate:GetWidgetDesc())
                widget:AddChild(textBg)
                WtSetPlace(textBg, { sizeX = size, sizeY = size, posX = 0, posY = 0 })
                textBg:SetBackgroundColor(UI.getGroupColor("ExtraPanelTextBgColor") or
                    { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
                textBg:Show(true)
            end

            local textureId = CLOAKS[name]

            local texture = GetGroupTexture("RELATED_TEXTURES", textureId)
            if (texture ~= nil) then
                if (widget ~= nil) then
                    widget:SetBackgroundTexture(texture)
                end
            end

            local textWidget = CreateWG("Text", "Info", textBg or widget, true,
                {
                    alignX = 0,
                    sizeX = size,
                    posX = 0,
                    highPosX = 0,
                    alignY = 0,
                    sizeY = size,
                    posY = 3,
                    highPosY = 0
                }
            )
            local alignX = UI.get("ExtraPanel", "TextAlignX") or "right"
            local alignY = UI.get("ExtraPanel", "TextAlignY") or "bottom"
            local fontSize = UI.get("ExtraPanel", "TextFontSize") or 15

            textWidget:SetFormat(userMods.ToWString(
                "<html><body alignx='"
                .. alignX ..
                "' aligny='"
                .. alignY ..
                "' fontsize='"
                .. fontSize ..
                "' outline='2'><rs class='class'><r name='name'/></rs></body></html>")
            )

            local level = info.level or 1
            local levelString = tostring(level)

            if (UI.get("ExtraPanel", "UseRomansForBanners")) then
                levelString = romanNumerals[level]
            end

            textWidget:SetVal("name", tostring(levelString))
            textWidget:SetClassVal("class", "ColorWhite")

            extraPanel:AddChild(widget)
            widget:Show(true)
            textWidget:Show(true)
            table.insert(activeInspectWidgets, widget)
            count = count + 1
        end

        ::skip_cloak::
    end

    if (count > 0) then
        WtSetPlace(extraPanel,
            { sizeX = (size + 1) * count, sizeY = size })
        extraPanel:SetBackgroundColor(UI.getGroupColor("ExtraPanelBgColor") or
            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        extraPanel:Show(true)

        local size = UI.get("ExtraPanel", "IconSize") or 40
        WtSetPlace(extraPanel, { sizeX = (size + 1) * count, sizeY = size })
    end
end

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- =-           D R A W   S C R O L L S           -=
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

local function drawScrolls(unitId)
    hidePanelDnDInfo(scrollsPanel, false)
    if (not UI.get("ScrollsPanel", "Show")) then return end
    local size = UI.get("ScrollsPanel", "IconSize") or 40

    local activeBuffs = object.GetBuffs(unitId)
    if (activeBuffs == nil) then return end

    local scrolls = {
        ["Uncommon"] = false,
        ["Rare"] = false,
        ["Epic"] = false,
        ["Legendary"] = false,
        ["Relic"] = false
    }

    local rarityIndex = {
        [1] = "Uncommon",
        [2] = "Rare",
        [3] = "Epic",
        [4] = "Legendary",
        [5] = "Relic"
    }

    local rarityFilterIndex = {
        ["Uncommon"] = 1,
        ["Rare"] = 2,
        ["Epic"] = 3,
        ["Legendary"] = 4,
        ["Relic"] = 5
    }

    for k, v in pairs(activeBuffs) do
        local info = object.GetBuffInfo(v)
        if (info ~= nil) then
            local buffName = FromWS(info.name)
            if (SCROLLS[buffName] ~= nil) then
                scrolls[SCROLLS[buffName]] = true
            end
        end
    end

    local count = 0
    local rarityFilter = 1
    if (UI.get("ScrollsPanel", "Rarity") ~= nil) then
        rarityFilter = rarityFilterIndex[UI.get("ScrollsPanel", "Rarity") or "Uncommon"]
    end
    for k, v in pairs(rarityIndex) do
        if (scrolls[v] and k >= rarityFilter) then
            local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
            local textBg = nil
            WtSetPlace(widget, { sizeX = size, sizeY = size, posX = (size + 1) * count, posY = 0 })

            if (UI.get("ScrollsPanel", "TextBackground")) then
                textBg = mainForm:CreateWidgetByDesc(panelTemplate:GetWidgetDesc())
                widget:AddChild(textBg)
                WtSetPlace(textBg, { sizeX = size, sizeY = size, posX = 0, posY = 0 })
                textBg:SetBackgroundColor(UI.getGroupColor("ScrollsPanelTextBgColor") or
                    { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
                textBg:Show(true)
            end

            local textureId = "ScrollArts" .. v

            local texture = GetGroupTexture("RELATED_TEXTURES", textureId)
            if (texture ~= nil) then
                if (widget ~= nil) then
                    widget:SetBackgroundTexture(texture)
                end
            end

            local textWidget = CreateWG("Text", "Info", textBg or widget, true,
                {
                    alignX = 0,
                    sizeX = size,
                    posX = 0,
                    highPosX = 0,
                    alignY = 0,
                    sizeY = size,
                    posY = 3,
                    highPosY = 0
                }
            )
            local alignX = UI.get("ScrollsPanel", "TextAlignX") or "right"
            local alignY = UI.get("ScrollsPanel", "TextAlignY") or "bottom"
            local fontSize = UI.get("ScrollsPanel", "TextFontSize") or 15

            textWidget:SetFormat(userMods.ToWString(
                "<html><body alignx='"
                .. alignX ..
                "' aligny='"
                .. alignY ..
                "' fontsize='"
                .. fontSize ..
                "' outline='2'><rs class='class'><r name='name'/></rs></body></html>")
            )

            textWidget:SetVal("name", "+")
            textWidget:SetClassVal("class", "ColorWhite")

            scrollsPanel:AddChild(widget)
            widget:Show(true)
            textWidget:Show(true)
            table.insert(activeInspectWidgets, widget)
            count = count + 1
        end
    end

    if (count > 0) then
        WtSetPlace(scrollsPanel,
            { sizeX = (size + 1) * count, sizeY = size })
        scrollsPanel:SetBackgroundColor(UI.getGroupColor("ScrollsPanelBgColor") or
            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        scrollsPanel:Show(true)
    end
end

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- =-              D R A W   A R T S              -=
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

local function drawMyArtsPanel()
    hidePanelDnDInfo(artsPanel, false)
    if (not UI.get("ArtsPanel", "Show")) then return end

    local artSize = UI.get("ArtsPanel", "IconSize") or 40

    WtSetPlace(artsPanel,
        { sizeX = (artSize + 1) * 3, sizeY = artSize })
    artsPanel:SetBackgroundColor(UI.getGroupColor("ArtsPanelBgColor") or { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
    artsPanel:Show(true)

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
end

local function onTargetChange(p)
    clearActiveInspect()

    hidePanel(artsPanel)
    hidePanel(statsAtcPanel)
    hidePanel(statsAtcMainPanel)
    hidePanel(statsDefPanel)
    hidePanel(statsDefMainPanel)
    hidePanel(scrollsPanel)
    hidePanel(extraPanel)

    local unitId = avatar.GetTarget()
    if (unitId == nil) then return end

    if (unitId == avatar.GetId()) then
        drawMyArtsPanel()
        drawStatPanels(avatar.GetId())
        drawScrolls(avatar.GetId())
        drawExtras(avatar.GetId())
    end

    -- LogWidget(mainForm)
    -- Log(LogWidgetChildrenCount(mainForm))
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

    UI.addGroup("ScrollsPanel", {
        UI.createCheckBox("Show", true),
        UI.createList("Rarity", {
            "Uncommon",
            "Rare",
            "Epic",
            "Legendary",
            "Relic",
        }, 3, true),

        UI.createSlider("IconSize", { stepsCount = 32, width = 212, offset = 32 }, 40),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 15),
        UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
        UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
        UI.createCheckBox("ShowTempInfo", false),
        UI.createCheckBox("TextBackground", false),
    })


    UI.createColorGroup("ScrollsPanelBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.createColorGroup("ScrollsPanelTextBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.addGroup("ExtraPanel", {
        UI.createCheckBox("Show", true),

        UI.createList("ShowCloak", { "-", "all", "banners" }, 3, false),
        -- UI.createCheckBox("ShowTempInfo", false),

        UI.createSlider("IconSize", { stepsCount = 32, width = 212, offset = 32 }, 40),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 15),
        UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
        UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
        UI.createCheckBox("UseRomansForBanners", true),
        UI.createCheckBox("TextBackground", false),
    })


    UI.createColorGroup("ExtraPanelBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.createColorGroup("ExtraPanelTextBgColor", {
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
        {
            label = "Scrolls",
            buttons = {
                left = { "Restore" },
                right = { "Accept" }
            },
            groups = {
                "ScrollsPanel",
                "ScrollsPanelBgColor",
                "ScrollsPanelTextBgColor",
            }
        },
        {
            label = "Extra",
            buttons = {
                left = { "Restore" },
                right = { "Accept" }
            },
            groups = {
                "ExtraPanel",
                "ExtraPanelBgColor",
                "ExtraPanelTextBgColor",
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

    setupUI()

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
    -- LogWidget(mainForm)
end

if (avatar.IsExist()) then
    Init()
else
    common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
end
