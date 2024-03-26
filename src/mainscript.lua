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
    [16] = '18'
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

local QUALITY = {
    'Junk',
    'Goods',
    'Common',
    'Uncommon',
    'Rare',
    'Epic',
    'Legendary',
    'Relic',
    'Dragon'
}

local QUALITY_HEX = {
    'ff999999',
    'ffdcdcdc',
    'ff00e526',
    'ff2080ff',
    'ffc040ff',
    'ffff8000',
    'ff00ffd2',
    'ffe0ff40',
    'fffb5ead'
}

local lastTarget = nil

local Offensive, Defensive = 1, 2
local runeType = {
    [DRESS_SLOT_OFFENSIVERUNE1] = Offensive,
    [DRESS_SLOT_OFFENSIVERUNE2] = Offensive,
    [DRESS_SLOT_OFFENSIVERUNE3] = Offensive,
    [DRESS_SLOT_DEFENSIVERUNE1] = Defensive,
    [DRESS_SLOT_DEFENSIVERUNE2] = Defensive,
    [DRESS_SLOT_DEFENSIVERUNE3] = Defensive,
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
local currentRatingPanel = mainForm:GetChildChecked("CurrentRatingPanel", false)
local gearScoreText = mainForm:GetChildChecked("GearScoreText", false)
local fairyScoreText = mainForm:GetChildChecked("FairyScoreText", false)
local runeScoreText = mainForm:GetChildChecked("RuneScoreText", false)
local powerScoreText = mainForm:GetChildChecked("PowerScoreText", false)

local Bag = common.GetAddonMainForm("ContextBag"):GetChildChecked("Bag", false)
local Area = Bag:GetChildChecked("Area", false)
local BagSlot1 = Area:GetChildChecked("SlotLine01", false):GetChildChecked("Item01", false):GetChildChecked("Frame",
    false)
BagSlot1:SetOnShowNotification(true)
local buttonslot1 = Bag:GetChildChecked("Tabs", false):GetChildChecked("Tab01", false)
local buttonslot2 = Bag:GetChildChecked("Tabs", false):GetChildChecked("Tab02", false)
local buttonslot3 = Bag:GetChildChecked("Tabs", false):GetChildChecked("Tab03", false)

local itemwt = {}
local itemwttime = {}
local itemwteq = {}
local itemwtlvl = {}
local itemIDLIST = {}

-- local lastRatingPanel = mainForm:GetChildChecked("LastRatingPanel", false)

local panelTemplate = mainForm:GetChildChecked("Panel", false)

local InspectWidget = common.GetAddonMainForm("InspectCharacter")
local InspectEquipmentPanel = InspectWidget:GetChildChecked("MainPanel", false):GetChildChecked("Primary", false)
    :GetChildChecked("EquipmentPanel", false)
-- local InspectToggleRitualPanel = InspectWidget:GetChildChecked("MainPanel", false):GetChildChecked("Primary", false)
--     :GetChildChecked("ToggleRitualPanel", false)

local CharEq = common.GetAddonMainForm("ContextCharacter2"):GetChildChecked("MainPanel", false)
local FrameEq = CharEq:GetChildChecked("FrameEquipment", false)
FrameEq:GetChildChecked("Slot01", false):GetChildChecked("Frame", false):SetOnShowNotification(true)

-- InspectEquipmentPanel:GetChildChecked("EquipmentSlot01", false):GetChildChecked("Frame", false):SetOnShowNotification(true)

local fontSpecificParams = {
    [10] = {
        posY = 5,
    },
    [11] = {
        posY = 5,
    }
}

local CharEq = common.GetAddonMainForm("ContextCharacter2"):GetChildChecked("MainPanel", false)
local FrameEq = CharEq:GetChildChecked("FrameEquipment", false)
FrameEq:GetChildChecked("Slot01", false):GetChildChecked("Frame", false):SetOnShowNotification(true)

local texts = {
    ["GearScore"] = {
        widget = gearScoreText,
        setting = "GearScoreText",
    },
    ["FairyScore"] = {
        widget = fairyScoreText,
        setting = "FairyScoreText",
    },
    ["RuneScore"] = {
        widget = runeScoreText,
        setting = "RuneScoreText",
    },
    ["PowerScore"] = {
        widget = powerScoreText,
        setting = "PowerScoreText",
    },
}

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
    ["CurrentRating"] = {
        panel = currentRatingPanel,
        setting = "CurrentRatingPanel",
    },
    -- ["LastRating"] = {
    --     panel = lastRatingPanel,
    --     setting = "LastRatingPanel",
    -- },
}

local inspectLabels = {}
local inspectPercents = {}
local selfLabels = {}

local iconTemplate = mainForm:GetChildChecked("InspectIcon", false)
local panelTemplate = mainForm:GetChildChecked("Panel", false)
local cfgBtn = mainForm:GetChildChecked("ConfigButton", false)

local lastInspectUnitId = nil

local activeInspectWidgets = {}

local function showTextDnDInfo(textWidget)
    textWidget:SetFormat('<header color="0xFFFFFFFF" alignx="middle" aligny="middle" fontsize="' ..
        13 .. '" shadow="1" outline="1"><rs class="class"><r name="value"/></rs></header>');
    textWidget:SetBackgroundColor({ r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
    textWidget:SetVal("value", textWidget:GetName())
    textWidget:SetClassVal("class", "ColorWhite")
    textWidget:Show(true)
end

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

local function hideText(textWidget)
    if (not DnDEnabled) then
        textWidget:Show(false)
    else
        showTextDnDInfo(textWidget)
    end
end

local function hidePanel(panelWidget)
    if (not DnDEnabled) then
        panelWidget:Show(false)
        hidePanelDnDInfo(panelWidget, false)
    else
        showPanelDnDInfo(panelWidget)
    end
end

local function cleanTags(itemId)
    if (itemwt[itemId]) then
        itemwt[itemId]:DestroyWidget()
        itemwt[itemId] = nil
    end
    if (itemwtlvl[itemId]) then
        itemwtlvl[itemId]:DestroyWidget()
        itemwtlvl[itemId] = nil
    end
    if (itemwttime[itemId]) then
        itemwttime[itemId]:DestroyWidget()

    end
    if (itemwteq["|" .. tostring(itemId) .. "_01" .. "|"]) then
        itemwteq["|" .. tostring(itemId) .. "_01" .. "|"]:DestroyWidget()
        itemwteq["|" .. tostring(itemId) .. "_01" .. "|"] = nil
    end
    if (itemwteq["|" .. tostring(itemId) .. "_02" .. "|"]) then
        itemwteq["|" .. tostring(itemId) .. "_02" .. "|"]:DestroyWidget()
        itemwteq["|" .. tostring(itemId) .. "_02" .. "|"] = nil
    end

    itemIDLIST[itemId] = nil
    -- Log("Cleared: " .. tostring(itemId))
end

local function onChangeInventorySlot(params)
    if (BagSlot1:IsVisibleEx()) then
        if UI.get("BagLabels", "BagGlobalEnable") then
            if itemIDLIST[params.itemId] ~= nil then
                local info = itemLib.GetItemInfo(params.itemId)
                if (info) then
                    -- cleanTags(params.itemId)
                    local tab = avatar.GetInventoryItemIds()
                    local bugSize = avatar.GetInventorySize() / 3
                    if buttonslot1:GetVariant() == 1 then
                        CheckBagItemById(tab, 0, bugSize, params.slotIndex)
                    elseif buttonslot2:GetVariant() == 1 then
                        CheckBagItemById(tab, 1, bugSize, bugSize + params.slotIndex)
                    elseif buttonslot3:GetVariant() == 1 then
                        CheckBagItemById(tab, 2, bugSize, 2 * bugSize + params.slotIndex)
                    end
                end
            end
        end
    end
end

local function clearActiveInspect()
    for k, v in pairs(activeInspectWidgets) do
        if (v ~= nil) then
            v:DestroyWidget()
        end
    end

    for k, v in pairs(inspectLabels) do
        if (v ~= nil) then
            v:DestroyWidget()
        end
    end
end

function ClearBagLabels()
    for k, v in pairs(itemwt) do
        v:DestroyWidget()
        itemwt[k] = nil
    end
    for k, v in pairs(itemwttime) do
        v:DestroyWidget()
        itemwttime[k] = nil
    end
    for k, v in pairs(itemwteq) do
        v:DestroyWidget()
        itemwteq[k] = nil
    end

    for k, v in pairs(itemwtlvl) do
        v:DestroyWidget()
        itemwtlvl[k] = nil
    end

    -- itemwt = {}
    -- itemwttime = {}
    -- itemwteq = {}
    -- itemwtlvl = {}
end

function DrawBagTab(tabindex)
    if (UI.get("BagLabels", "BagGlobalEnable")) then
        local tab = avatar.GetInventoryItemIds()
        local bugSize = avatar.GetInventorySize() / 3
        for bugslots = bugSize * tabindex, bugSize * (tabindex + 1) - 1 do
            CheckBagItemById(tab, tabindex, bugSize, bugslots)
        end
    end
end

local itemnames = {
    ['Инсигния героя'] = true,
    ['Упакованная инсигния героя'] = true,
    ['Компас героя'] = true,
}

function CheckBagItemById(tab, tabindex, bugSize, bugslots)
    local itemId = avatar.GetInventoryItemId(bugslots)
    -- Log("CheckBagItemById: " .. tostring(itemId))
    if (itemId) then
        cleanTags(itemId)
        local tabSlot = containerLib.GetItemSlot(itemId).slot - bugSize * tabindex
        local info = itemLib.GetItemInfo(itemId)
        local tempInfo = itemLib.GetTemporaryInfo(itemId)
        if (info and UI.get("BagLabels", "BagShowItemLevel") and (itemnames[userMods.FromWString(info.name)] or ARTS[userMods.FromWString(info.name)])) then
            -- BagShowItemLevel
            -- BagItemLevelColor
            -- BagItemLevelTextFontSize
            local fontsize = UI.get("BagLabels", "BagItemLevelTextFontSize") or 14
            local labelColor = UI.get("BagLabels", "BagItemLevelColor") or "ColorWhite"

            local lvl = CreateWG("Text", "ItemLvl", Area:GetChildChecked(
                    "SlotLine" .. userMods.FromWString(common.FormatInt(math.floor(((tabSlot + 1) / 6) + 0.9), "%02d")),
                    false):GetChildChecked("Item0" .. containerLib.GetItemSlot(itemId).slot % 6 + 1, false), true,
                {
                    alignX = 0,
                    sizeX = 44,
                    posX = 2,
                    highPosX = 0,
                    alignY = 0,
                    sizeY = 44,
                    posY = 1,
                    highPosY = 0
                })

            lvl:SetFormat(userMods.ToWString("<html><body alignx='left' aligny='bottom' fontsize='" ..
                fontsize .. "' outline='1' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))
            if (ARTS[userMods.FromWString(info.name)] and not tempInfo) then
                lvl:SetVal("name", " " .. tostring(info.level))
            elseif userMods.FromWString(info.name):find("Компас") then
                lvl:SetVal("name", tostring(info.level))
            elseif userMods.FromWString(info.name):find("Инсигния") then
                lvl:SetVal("name",
                    tostring(userMods.FromWString(common.ExtractWStringFromValuedText(info.description)):sub(84, 86)))
            elseif userMods.FromWString(info.name):find("Упакованная") then
                lvl:SetVal("name",
                    tostring(userMods.FromWString(common.ExtractWStringFromValuedText(info.description)):sub(227, 230)))
            end
            itemwtlvl[itemId] = lvl
            -- Log("Created [itemwtlvl]: " .. tostring(itemId) .. " " .. tostring(userMods.FromWString(info.name)))
            itemIDLIST[itemId] = true
            lvl:SetClassVal("class", labelColor)
        elseif (info and itemLib.GetBudgets(itemId) ~= nil) then
            if (not UI.get("BagLabels", "BagShowEqPercents")) then
                goto continue_bagitems
            end
            local offPosX = 1
            local bs = ""
            local fontsize = UI.get("BagLabels", "BagEqPercentTextFontSize") or 14
            local percentInfo = itemLib.GetBudgets(itemId)

            if (percentInfo == nil) then return end
            if (percentInfo[ENUM_FloatingBudgetType_OffenceBudget] < 100) then offPosX = offPosX + 2 end

            local off = CreateWG("Text", "ItemLvl", Area:GetChildChecked(
                    "SlotLine" .. userMods.FromWString(common.FormatInt(math.floor(((tabSlot + 1) / 6) + 0.9), "%02d")),
                    false):GetChildChecked("Item0" .. containerLib.GetItemSlot(itemId).slot % 6 + 1, false), true,
                {
                    alignX = 0,
                    sizeX = 44,
                    posX = -offPosX,
                    highPosX = 0,
                    alignY = 0,
                    sizeY = 44,
                    posY = 2,
                    highPosY = 0
                })

            off:SetFormat(userMods.ToWString("<html><body alignx='right' aligny='top' fontsize='" ..
                fontsize .. "' outline='1' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))
            off:SetVal("name", bs .. tostring(percentInfo[ENUM_FloatingBudgetType_OffenceBudget]))
            off:SetClassVal("class", UI.get("BagLabels", "BagEqPercentColor") or "ColorWhite")

            itemwteq["|" .. tostring(itemId) .. "_01|"] = off
            itemIDLIST[itemId] = true
        elseif (info and info.isRitual and info.level ~= nil) then
            -- for _k, _v in pairs(info) do
            --     Log(tostring(_k) .. " " .. tostring(_v))
            -- end
            if (not UI.get("BagLabels", "BagShowDOCraft")) then
                goto continue_bagitems
            end
            local offPosX = 1
            local bs = ""
            local fontsize = UI.get("BagLabels", "BagDOTextFontSize") or 14

            local off = CreateWG("Text", "ItemLvl", Area:GetChildChecked(
                    "SlotLine" .. userMods.FromWString(common.FormatInt(math.floor(((tabSlot + 1) / 6) + 0.9), "%02d")),
                    false):GetChildChecked("Item0" .. containerLib.GetItemSlot(itemId).slot % 6 + 1, false), true,
                {
                    alignX = 0,
                    sizeX = 44,
                    posX = -offPosX,
                    highPosX = 0,
                    alignY = 0,
                    sizeY = 44,
                    posY = 2,
                    highPosY = 0
                })

            off:SetFormat(userMods.ToWString("<html><body alignx='right' aligny='top' fontsize='" ..
                fontsize .. "' outline='1' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))
            off:SetVal("name", bs .. tostring(info.level))
            off:SetClassVal("class", UI.get("BagLabels", "BagDOColor") or "ColorWhite")

            itemwteq["|" .. tostring(itemId) .. "_01|"] = off
            itemIDLIST[itemId] = true
        end
        ::continue_bagitems::
        if info and tempInfo then
            if (not UI.get("BagLabels", "BagShowTimeleft")) then
                return
            end

            local timestamp = tempInfo.remainingMs / 1000
            local seconds = math.floor(timestamp % 60)
            local mins = math.floor(timestamp / 60) % 60
            local hours = math.floor(timestamp / 3600) % 24
            local days = math.floor(timestamp / 86400)
            local descr = ""
            local posX = 2
            if (days > 0) then
                descr = tostring(days) .. "д"
                -- if (days >= 100) then posX = posX end
            elseif (hours > 0) then
                descr = tostring(hours) .. "ч"
            elseif (mins > 0) then
                descr = tostring(mins) .. "м"
            elseif (seconds > 0) then
                descr = tostring(seconds) .. "с"
            end

            local bs = ""
            local fontsize = UI.get("BagLabels", "BagTimeleftTextFontSize") or 14

            local critTime = tonumber(UI.get("BagLabels", "BagTimeleftCriticalHours")) or 48

            local lvl = CreateWG("Text", "ItemLvl", Area:GetChildChecked(
                    "SlotLine" .. userMods.FromWString(common.FormatInt(math.floor(((tabSlot + 1) / 6) + 0.9), "%02d")),
                    false):GetChildChecked("Item0" .. containerLib.GetItemSlot(itemId).slot % 6 + 1, false), true,
                {
                    alignX = 0,
                    sizeX = 44,
                    posX = -posX,
                    highPosX = 0,
                    alignY = 0,
                    sizeY = 44,
                    posY = 1,
                    highPosY = 0
                })

            lvl:SetFormat(userMods.ToWString("<html><body alignx='right' aligny='top' fontsize='" ..
                fontsize .. "' outline='1' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))
            lvl:SetVal("name", bs .. tostring(descr))
            if (timestamp < critTime * 3600) then
                lvl:SetClassVal("class", UI.get("BagLabels", "BagTimeleftCriticalColor") or "ColorWhite")
            else
                lvl:SetClassVal("class", UI.get("BagLabels", "BagTimeleftColor") or "ColorWhite")
            end

            itemwttime[itemId] = lvl
            itemIDLIST[itemId] = true
        end
    end
end

function DrawBagLabels()
    ClearBagLabels()
    if buttonslot1:GetVariant() == 1 then
        DrawBagTab(0)
    end
    if buttonslot2:GetVariant() == 1 then
        DrawBagTab(1)
    end
    if buttonslot3:GetVariant() == 1 then
        DrawBagTab(2)
    end
end

local function onWidgetShowChanged(p)
    -- Log("onWidgetShowChanged: " .. p.widget:GetName())
    -- if (p.widget:GetName() == "StatIcon") then
    --     if (p.widget:IsVisible()) then
    --         p.widget:Show(false)
    --     end
    -- end

    -- if (p.widget:GetName() == "Frame" and p.widget:GetParent() ~= nil and p.widget:GetParent():GetName() == "EquipmentSlot01") then
    --     if (p.widget:IsVisible()) then
    --         Log(InspectWidget:GetChildChecked("MainPanel", false):GetChildChecked("Primary", false)
    --             :GetChildChecked("ToggleRitualPanel", false):GetChildChecked("ToggleRitualButton", false):GetVariant())
    --     end
    -- end

    if (p.widget:GetName() == "Frame" and p.widget:GetParent() ~= nil and p.widget:GetParent():GetName() == "Slot01") then
        for k, v in pairs(selfLabels) do
            if (v ~= nil) then
                v:DestroyWidget()
                selfLabels[k] = nil
            end
        end
        if (p.widget:IsVisibleEx()) then
            -- if (UI.get("InspectLabels", "Show")) then
            DrawSelf()
            -- end
        end
    elseif (p.widget:GetName() == "Frame" and p.widget:GetParent():GetName() == "Item01" and p.widget:IsVisibleEx()) then
        DrawBagLabels()
    elseif (p.widget:GetName() == "Bag" and p.widget:GetParent():GetName() == "ContextBag" and (not p.widget:IsVisibleEx())) then
        ClearBagLabels()
    end
end

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- =-             D R A W   S T A T S             -=
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

local function drawStatIcon(name, value, textureId, panelInfo, count)
    local panel = panelInfo.panel
    local setting = panelInfo.setting or "_"

    local size = UI.get(setting, "IconSizeV3") or 40

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

        local fontSize = UI.get(setting, "TextFontSize") or 15
        if (value >= 1000 and 40 < 36) then fontSize = 10 end

        local countWidget = CreateWG("Text", "Count", textBg or widget, true,
            {
                alignX = 0,
                sizeX = size,
                posX = 0,
                highPosX = 0,
                alignY = 0,
                sizeY = size,
                posY = (fontSpecificParams[fontSize] ~= nil and fontSpecificParams[fontSize].posY) or 3,
                highPosY = 0
            }
        )
        local alignX = UI.get(setting, "TextAlignX") or "right"
        local alignY = UI.get(setting, "TextAlignY") or "bottom"

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

    local texture = GetGroupTexture(UI.get(setting, "TextureStyle") or "RELATED_TEXTURES", textureId)
    if (texture == nil) then
        texture = GetGroupTexture("RELATED_TEXTURES", textureId)
    end
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

function DrawRitualInfo(i, eqSlot, info, itemId, isSelf)
    local posX = 0
    local posY = 1
    if (i == 14 or i == 15) then
        posX = 3
        posY = 6
    end

    local offPosX = posX
    local deffPosX = posX
    local bs = ""
    local fontsize = UI.get("InspectLabels", "DOTextFontSize") or 12
    local dopY = 0
    local level = info.level
    if (level == nil) then return end

    if (level < 100) then offPosX = posX + 2 end

    if (i == 14 or i == 15) then
        offPosX = offPosX - 3
        deffPosX = deffPosX + 2
        dopY = 4
    end

    local off = CreateWG("Text", "Item", eqSlot, true,
        {
            alignX = 0,
            sizeX = 44,
            posX = deffPosX - 2,
            highPosX = 0,
            alignY = 0,
            sizeY = 44,
            posY = posY - 25 - dopY + 14,
            highPosY = 0
        })
    if (isSelf) then
        table.insert(selfLabels, off)
    else
        table.insert(inspectLabels, off)
        table.insert(inspectPercents, off)
    end
    off:SetFormat(userMods.ToWString("<html><body alignx='right' aligny='bottom' fontsize='" ..
        fontsize ..
        "' outline='1' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))
    off:SetVal("name", bs .. tostring(level / 10))
    off:SetClassVal("class", UI.get("InspectLabels", "DOColor") or "SubscribeWarning")
end

function DrawOffDeffPercent(i, eqSlot, info, itemId, isSelf)
    local posX = 0
    local posY = 1
    if (i == 14 or i == 15) then
        posX = 3
        posY = 6
    end

    local offPosX = posX
    local deffPosX = posX
    local bs = ""
    local fontsize = UI.get("InspectLabels", "PercentTextFontSize") or 13
    local dopY = 0
    local percentInfo = itemLib.GetBudgets(itemId)
    if (percentInfo == nil) then return end

    if (percentInfo[ENUM_FloatingBudgetType_OffenceBudget] < 100) then offPosX = posX + 2 end

    if (i == 14 or i == 15) then
        offPosX = offPosX - 3
        deffPosX = deffPosX + 2
        dopY = 4
    end

    local off = CreateWG("Text", "Item", eqSlot, true,
        {
            alignX = 0,
            sizeX = 44,
            posX = deffPosX - 2,
            highPosX = 0,
            alignY = 0,
            sizeY = 44,
            posY = posY - 25 - dopY,
            highPosY = 0
        })
    if (isSelf) then
        table.insert(selfLabels, off)
    else
        table.insert(inspectLabels, off)
        table.insert(inspectPercents, off)
    end
    off:SetFormat(userMods.ToWString("<html><body alignx='right' aligny='bottom' fontsize='" ..
        fontsize .. "' outline='1' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))
    off:SetVal("name", bs .. tostring(percentInfo[ENUM_FloatingBudgetType_OffenceBudget]))
    off:SetClassVal("class", UI.get("InspectLabels", "PercentColor") or "ColorWhite")

    -- if (percentInfo[ENUM_FloatingBudgetType_DefenceBudget] < 100) then deffPosX = posX - 2 end

    -- local deff = CreateWG("Text", "Item", eqSlot, true,
    --     {
    --         alignX = 0,
    --         sizeX = 44,
    --         posX = deffPosX - 1,
    --         highPosX = 0,
    --         alignY = 0,
    --         sizeY = 44,
    --         posY = posY - 25 - dopY,
    --         highPosY = 0
    --     })
    -- table.insert(inspectLabels, deff)
    -- table.insert(inspectPercents, deff)
    -- deff:SetFormat(userMods.ToWString("<html><body alignx='right' aligny='bottom' fontsize='" ..
    --     fontsize .. "' outline='1' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))
    -- deff:SetVal("name", bs .. tostring(percentInfo[ENUM_FloatingBudgetType_DefenceBudget]))
    -- deff:SetClassVal("class", "ColorWhite")
end

local function onInventorySlotChanged(p)
    -- Log("onInventorySlotChanged")
    for k, v in pairs(p) do
        Log(tostring(k) .. " : " .. tostring(v))
    end
end

local function onEqSlotChanged(p)
    -- Log("onEqSlotChanged")
    for k, v in pairs(p) do
        Log(tostring(k) .. " : " .. tostring(v))
    end
end

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- =-           D R A W   R A T I N G S           -=
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

local function drawRating(arena, rating, size, panel, pos)
    -- Log(arena)
    -- for n, m in pairs(rating) do
    --     Log(tostring(n) .. " : " .. tostring(m))
    -- end
    local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
    local textBg = nil
    WtSetPlace(widget, { sizeX = size, sizeY = size, posX = (size + 1) * pos, posY = 0 })

    if (UI.get(panel.setting, "TextBackground")) then
        textBg = mainForm:CreateWidgetByDesc(panelTemplate:GetWidgetDesc())
        widget:AddChild(textBg)
        WtSetPlace(textBg, { sizeX = size, sizeY = size, posX = 0, posY = 0 })
        textBg:SetBackgroundColor(UI.getGroupColor(panel.setting .. "TextBgColor") or
            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        textBg:Show(true)
    end

    local texture = GetGroupTexture("RELATED_TEXTURES", arena)
    if (texture ~= nil) then
        if (widget ~= nil) then
            widget:SetBackgroundTexture(texture)
        end
    end

    local fontSize = UI.get(panel.setting, "TextFontSize") or 15
    local textWidget = CreateWG("Text", "Info", textBg or widget, true,
        {
            alignX = 0,
            sizeX = size,
            posX = 0,
            highPosX = 0,
            alignY = 0,
            sizeY = size,
            posY = (fontSpecificParams[fontSize] ~= nil and fontSpecificParams[fontSize].posY) or
                3,
            highPosY = 0
        }
    )
    local alignX = UI.get(panel.setting, "TextAlignX") or "right"
    local alignY = UI.get(panel.setting, "TextAlignY") or "bottom"

    textWidget:SetFormat(userMods.ToWString(
        "<html><body alignx='"
        .. alignX ..
        "' aligny='"
        .. alignY ..
        "' fontsize='"
        .. fontSize ..
        "' outline='2'><rs class='class'><r name='name'/></rs></body></html>")
    )

    local desc = ""
    if (arena == "HPI") then
        local type = UI.get(panel.setting, "HPIType") or "place"
        if (type == "place") then
            desc = tostring(rating.top)
        elseif (type == "level") then
            desc = "-"
            if (rating.difficulty ~= nil) then
                local numbers = {}
                for num in string.gmatch(FromWS(rating.difficulty.name), "%d+") do
                    numbers[#numbers + 1] = num
                end

                desc = tostring(numbers[#numbers])
            end
        elseif (type == "time") then
            desc = "-"
            local timestamp = rating.timeSpentMs / 1000
            local seconds = math.floor(timestamp % 60)
            local mins = math.floor(timestamp / 60) % 60
            local hours = math.floor(timestamp / 3600) % 24
            local days = math.floor(timestamp / 86400)
            if (days > 0) then
                desc = tostring(days) .. "д"
            elseif (hours > 0) then
                desc = tostring(hours) .. "ч"
            elseif (mins > 0) then
                desc = tostring(mins) .. "м"
            elseif (seconds > 0) then
                desc = tostring(seconds) .. "с"
            end
        end
    else
        local type = UI.get(panel.setting, "PvPType") or "place"
        if (type == "place") then
            desc = tostring(rating.top)
        elseif (type == "score") then
            desc = tostring(rating.score)
        elseif (type == "winrate") then
            if (rating.over_game > 0) then
                desc = tostring(FromWS(common.FormatFloat(rating.wins * 100 / rating.over_game, '%.1f')))
            else
                desc = "-"
            end
        end
    end

    textWidget:SetVal("name", desc)
    textWidget:SetClassVal("class", "ColorWhite")

    panel.panel:AddChild(widget)
    widget:Show(true)
    textWidget:Show(true)
    table.insert(activeInspectWidgets, widget)
end

local function drawRatings(unitId)
    local showCurrent = UI.get("CurrentRatingPanel", "Show")
    -- local showLast = UI.get("LastRatingPanel", "Show")
    if (not showCurrent) then return end

    local currentSize = UI.get("CurrentRatingPanel", "IconSizeV3") or 40
    -- local lastSize = UI.get("LastRatingPanel", "IconSizeV3") or 40

    if matchMaking.IsRatingPvPScoreAvailable() then
        local x3 = matchMaking.GetRatingPvPScoreByUnitId(ENUM_RatingArenaType_3x3, unitId)
        local x6 = matchMaking.GetRatingPvPScoreByUnitId(ENUM_RatingArenaType_6x6, unitId)
        local hpi = matchMaking.GetRatingPvPScoreByUnitId(ENUM_RatingArenaType_HPI, unitId)

        local ratings = {
            ['3x3'] = {
                current = x3.currentSeason,
                last = x3.lastSeason
            },
            ['6x6'] = {
                current = x6.currentSeason,
                last = x6.lastSeason
            },
            ['HPI'] = {
                current = hpi.currentSeason,
                last = hpi.lastSeason
            }
        }
        local pos = 0
        for arena, rating in pairs(ratings) do
            showCurrent = showCurrent and rating.current ~= nil
            if (showCurrent) then
                drawRating(arena, rating.current, currentSize, panels["CurrentRating"], pos)
            end
            -- showLast = showLast and rating.last ~= nil
            -- if (showLast) then
            --     drawRating(arena, rating.last, lastSize, panels["LastRating"], pos)
            -- end
            pos = pos + 1
        end

        currentRatingPanel:Show(showCurrent)
        WtSetPlace(currentRatingPanel,
            { sizeX = (currentSize + 1) * 3, sizeY = currentSize })
        currentRatingPanel:SetBackgroundColor(UI.getGroupColor("CurrentRatingPanelBgColor") or
            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })


        -- lastRatingPanel:Show(showLast)
        -- WtSetPlace(lastRatingPanel,
        --     { sizeX = (lastSize + 1) * 3, sizeY = lastSize })
        -- lastRatingPanel:SetBackgroundColor(UI.getGroupColor("LastRatingPanelBgColor") or
        --     { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
    end
end

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-- =-           D R A W   S C R O L L S           -=
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

local function drawScrolls(unitId)
    if (not UI.get("ScrollsPanel", "Show")) then return end
    local size = UI.get("ScrollsPanel", "IconSizeV3") or 40

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
            local fontSize = UI.get("ScrollsPanel", "TextFontSize") or 15
            local textWidget = CreateWG("Text", "Info", textBg or widget, true,
                {
                    alignX = 0,
                    sizeX = size,
                    posX = 0,
                    highPosX = 0,
                    alignY = 0,
                    sizeY = size,
                    posY = (fontSpecificParams[fontSize] ~= nil and fontSpecificParams[fontSize].posY) or 3,
                    highPosY = 0
                }
            )
            local alignX = UI.get("ScrollsPanel", "TextAlignX") or "right"
            local alignY = UI.get("ScrollsPanel", "TextAlignY") or "bottom"

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

function DrawSelf()
    local unitId = avatar.GetId()
    if (unitId == nil) then return end

    local inspectedItems = unit.GetEquipmentItemIds(unitId, ITEM_CONT_EQUIPMENT)

    if (inspectedItems ~= nil) then
        for k, v in pairs(inspectedItems) do
            local itemId = v
            if (itemId == nil) then goto continue_stats end
            local info = itemLib.GetItemInfo(itemId)
            if (info == nil) then goto continue_stats end

            if (UI.get("InspectLabels", "ShowPercents") and eqSlots[k] ~= nil) then
                local eqSlot = FrameEq:GetChildUnchecked("Slot" .. eqSlots[k], false)
                if (eqSlot ~= nil) then
                    DrawOffDeffPercent(k, eqSlot, info, itemId, true)
                end
            else
                if (k == 18 and UI.get("InspectLabels", "ShowCapeInfo")) then
                    local eqSlot = FrameEq:GetChildUnchecked("Slot13", false)
                    if (eqSlot ~= nil) then
                        local level = info.level
                        if (level == nil) then level = 1 end
                        if (UI.get("ExtraPanel", "UseRomansForBanners")) then
                            level = romanNumerals[level]
                        end

                        if (info.level > 0 and info.level < 4) then
                            local lvl = CreateWG("Text", "Item", eqSlot, true,
                                {
                                    alignX = 0,
                                    sizeX = 44,
                                    posX = -2,
                                    highPosX = 2,
                                    alignY = 0,
                                    sizeY = 44,
                                    posY = 1,
                                    highPosY = 0
                                })
                            local fontsize = UI.get("InspectLabels", "CapeTextFontSize") or 16
                            lvl:SetFormat(userMods.ToWString(
                                "<html><body alignx='right' aligny='top' fontsize='" ..
                                tostring(fontsize) ..
                                "' outline='2' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))

                            lvl:SetVal("name", " " .. tostring(level))
                            lvl:SetClassVal("class", UI.get("InspectLabels", "CapeColor") or "ColorWhite")

                            table.insert(selfLabels, lvl)
                        end
                    end
                elseif (UI.get("InspectLabels", "ShowArtsInfo") and k >= 38 and k <= 40) then
                    local info = itemLib.GetItemInfo(itemId)
                    if (info == nil) then goto continue_arts end

                    local level = info.level
                    local tempInfo = itemLib.GetTemporaryInfo(itemId)
                    if (tempInfo ~= nil and level % 5 == 0) then
                        if (UI.get("ArtsPanel", "UseRomansForTemporary")) then
                            level = romanNumerals[level / 5]
                        else
                            level = level / 5
                        end
                    end

                    local eqSlot = FrameEq:GetChildChecked("Slot" .. (k - 38 + 23), false)
                    if (eqSlot ~= nil) then
                        local descr = tostring(level)
                        local lvl = CreateWG("Text", "Item", eqSlot, true,
                            {
                                alignX = 0,
                                sizeX = 44,
                                posX = -2,
                                highPosX = 2,
                                alignY = 0,
                                sizeY = 44,
                                posY = 1,
                                highPosY = 0
                            })
                        local fontsize = UI.get("InspectLabels", "ArtsTextFontSize") or 16

                        lvl:SetFormat(userMods.ToWString(
                            "<html><body alignx='center' aligny='top' fontsize='" ..
                            tostring(fontsize) ..
                            "' outline='2' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))
                        lvl:SetClassVal("class", UI.get("InspectLabels", "ArtsColor") or "ColorWhite")

                        if (tempInfo ~= nil) then
                            local timestamp = tempInfo.remainingMs / 1000
                            local seconds = math.floor(timestamp % 60)
                            local mins = math.floor(timestamp / 60) % 60
                            local hours = math.floor(timestamp / 3600) % 24
                            local days = math.floor(timestamp / 86400)
                            if (days > 0) then
                                descr = tostring(days) .. "д"
                            elseif (hours > 0) then
                                descr = tostring(hours) .. "ч"
                            elseif (mins > 0) then
                                descr = tostring(mins) .. "м"
                            elseif (seconds > 0) then
                                descr = tostring(seconds) .. "с"
                            end
                        end

                        lvl:SetVal("name", " " .. descr)

                        table.insert(selfLabels, lvl)
                    end
                    ::continue_arts::
                end
            end

            ::continue_stats::
        end
    end

    local dragonItems = unit.GetEquipmentItemIds(unitId, ITEM_CONT_EQUIPMENT_RITUAL)

    if (dragonItems ~= nil) then
        for k, v in pairs(dragonItems) do
            local ritualInfo = itemLib.GetItemInfo(v)

            if (ritualInfo) then
                if (UI.get("InspectLabels", "ShowDOCraft") and eqSlots[k] ~= nil) then
                    local eqSlot = FrameEq:GetChildUnchecked("Slot" .. eqSlots[k], false)
                    if (eqSlot ~= nil) then
                        DrawRitualInfo(k, eqSlot, ritualInfo, v, true)
                    end
                end
            end
        end
    end
end

function DrawInfo(unitId)
    local showStats = true
    local showArts = UI.get("ArtsPanel", "Show") or false
    local showExtras = UI.get("ExtraPanel", "Show") or false
    if (not UI.get(panels["StatsAtc"].setting, "ShowAdd") and
            not UI.get(panels["StatsDef"].setting, "ShowAdd") and
            not UI.get(panels["StatsAtcMain"].setting, "ShowMain") and
            not UI.get(panels["StatsDefMain"].setting, "ShowMain")) then
        showStats = false
    end

    local stats = {
        ["ritual"] = 0,
        ["power"] = 0,
        ["stamina"] = 0,
        ['Мастерство'] = 0,
        ['Решимость'] = 0,
        ['Беспощадность'] = 0,
        ['Господство'] = 0,
        ['Удача'] = 0,
        ['Ярость'] = 0,
        ['Упорство'] = 0,
        ['Стремительность'] = 0,
    }

    local shardName = unit.GetPlayerShardName(unitId)
    local guildLabel = ""

    local gearScore = unit.GetGearScore(unitId)

    local gearQuality = 0
    local gearCount = 0

    local artsCount = 0
    local artSize = UI.get("ArtsPanel", "IconSizeV3") or 40

    local extrasCount = 0
    local extrasSize = UI.get("ExtraPanel", "IconSizeV3") or 40
    local cloakMode = UI.get("ExtraPanel", "ShowCloak")

    local fairyInfo = unit.GetFairyInfo(unitId)
    local fairyPower = 0
    local artPower = 0
    local guildPowerBonus = 0

    -- local InspectData = {
    --     name = "[" .. FromWS(shardName) .. "] " .. FromWS(object.GetName(unitId)),
    --     extras = {},
    --     runes = {},
    --     arts = {},
    --     raitings = {},
    --     scrolls = {},
    -- }

    if (fairyInfo) then
        local fairyRank = tostring(fairyInfo.rank)
        local fairyLevel = fairyInfo.level
        fairyPower = fairyInfo.powerBonus

        -- InspectData.fairy = {
        --     rank = fairyInfo.rank,
        --     level = fairyLevel,
        -- }

        if (UI.get("FairyScoreText", "Show")) then
            local fontSize = UI.get("FairyScoreText", "TextFontSize") or 16
            local color = UI.get("FairyScoreText", "CustomColor")
            if (color == "-") then
                color = QUALITY[fairyInfo.rank + 1]
            end

            fairyScoreText:SetFormat('<header color="0xFFFFFFFF" alignx="middle" aligny="middle" fontsize="' ..
                tostring(fontSize) .. '" shadow="1" outline="1"><rs class="class"><r name="value"/></rs></header>');

            fairyScoreText:SetBackgroundColor({ r = 0.0, g = 0.0, b = 0.0, a = 0 })
            if (UI.get("FairyScoreText", "ShowTextBackground")) then
                fairyScoreText:SetBackgroundColor(UI.getGroupColor("FairyScoreTextBgColor"))
            end
            if (UI.get("FairyScoreText", "UseRomansForFairy")) then
                fairyRank = romanNumerals[fairyInfo.rank]
            end

            if (UI.get("FairyScoreText", "ShowFairyLevel")) then
                fairyRank = fairyRank .. " (" .. tostring(fairyLevel) .. ")"
            end

            fairyScoreText:SetVal("value", fairyRank)
            fairyScoreText:SetClassVal("class", color)
            fairyScoreText:Show(true)
        end
    end

    if (not common.IsOnPayToPlayShard() and UI.get("RuneScoreText", "Show")) then
        local runes = {}
        local runeBonusField = { [Offensive] = "offensiveBonus", [Defensive] = "defensiveBonus" }
        local runeQuality = { 1, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 6, 6, 7 }
        for slot, t in pairs(runeType) do
            local id = unit.GetEquipmentItemId(unitId, slot, ITEM_CONT_EQUIPMENT)
            local info = id and itemLib.GetRuneInfo(id)
            local rank = info ~= nil and (info.level or info.runeLevel) or 0
            local bonus = info ~= nil and info[runeBonusField[t]] or 0
            runes[slot] = {}
            runes[slot].runeQuality = rank
            runes[slot].runeScore = bonus
            runes[slot].runeStyle = QUALITY[runeQuality[rank + 1]]
        end

        if (len(runes) > 0) then
            -- InspectData.runes = runes

            local fontSize = UI.get("RuneScoreText", "TextFontSize") or 16
            local runeSeparator = UI.get("RuneScoreText", "RuneSeparator") or "."
            local mainSeparator = UI.get("RuneScoreText", "MainSeparator") or " / "

            runeScoreText:SetFormat('<header color="0xFFFFFFFF" alignx="middle" aligny="middle" fontsize="' ..
                tostring(fontSize) ..
                '" shadow="1"><rs class="class1"><r name="value1"/></rs>' ..
                runeSeparator ..
                '<rs class="class2"><r name="value2"/></rs>' ..
                runeSeparator ..
                '<rs class="class3"><r name="value3"/></rs>' ..
                mainSeparator ..
                '<rs class="class4"><r name="value4"/></rs>' ..
                runeSeparator ..
                '<rs class="class5"><r name="value5"/></rs>' ..
                runeSeparator .. '<rs class="class6"><r name="value6"/></rs> </header>');

            runeScoreText:SetBackgroundColor({ r = 0.0, g = 0.0, b = 0.0, a = 0 })
            if (UI.get("RuneScoreText", "ShowTextBackground")) then
                runeScoreText:SetBackgroundColor(UI.getGroupColor("RuneScoreTextBgColor"))
            end

            runeScoreText:SetVal('value1', common.FormatInt(runes[DRESS_SLOT_OFFENSIVERUNE1].runeQuality, '%d'))
            runeScoreText:SetClassVal('class1', runes[DRESS_SLOT_OFFENSIVERUNE1].runeStyle)

            runeScoreText:SetVal('value2', common.FormatInt(runes[DRESS_SLOT_OFFENSIVERUNE2].runeQuality, '%d'))
            runeScoreText:SetClassVal('class2', runes[DRESS_SLOT_OFFENSIVERUNE2].runeStyle)

            runeScoreText:SetVal('value3', common.FormatInt(runes[DRESS_SLOT_OFFENSIVERUNE3].runeQuality, '%d'))
            runeScoreText:SetClassVal('class3', runes[DRESS_SLOT_OFFENSIVERUNE3].runeStyle)

            runeScoreText:SetVal('value4', common.FormatInt(runes[DRESS_SLOT_DEFENSIVERUNE1].runeQuality, '%d'))
            runeScoreText:SetClassVal('class4', runes[DRESS_SLOT_DEFENSIVERUNE1].runeStyle)

            runeScoreText:SetVal('value5', common.FormatInt(runes[DRESS_SLOT_DEFENSIVERUNE2].runeQuality, '%d'))
            runeScoreText:SetClassVal('class5', runes[DRESS_SLOT_DEFENSIVERUNE2].runeStyle)

            runeScoreText:SetVal('value6', common.FormatInt(runes[DRESS_SLOT_DEFENSIVERUNE3].runeQuality, '%d'))
            runeScoreText:SetClassVal('class6', runes[DRESS_SLOT_DEFENSIVERUNE3].runeStyle)

            runeScoreText:Show(true)
        end
    end

    local inspectedItems = unit.GetEquipmentItemIds(unitId, ITEM_CONT_EQUIPMENT)

    if (inspectedItems ~= nil) then
        for k, v in pairs(inspectedItems) do
            local itemId = v
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

            if (eqSlotsInspect[k] ~= nil) then
                local qualityInfo = itemLib.GetQuality(itemId)
                if (qualityInfo ~= nil) then
                    gearQuality = gearQuality + qualityInfo.quality
                    gearCount = gearCount + 1
                end
                local eqSlot = InspectEquipmentPanel:GetChildUnchecked("EquipmentSlot" .. eqSlotsInspect[k], false)
                if (UI.get("InspectLabels", "ShowPercents") and eqSlot ~= nil) then
                    DrawOffDeffPercent(k, eqSlot, info, itemId, false)
                end
            else
                if (k == 18) then
                    local eqSlot = InspectEquipmentPanel:GetChildUnchecked("EquipmentSlot12", false)
                    if (eqSlot ~= nil) then
                        local level = info.level
                        if (level == nil) then level = 1 end
                        if (UI.get("ExtraPanel", "UseRomansForBanners")) then
                            level = romanNumerals[level]
                        end

                        guildPowerBonus = (0.04 * unit.GetGuildInfo(unitId).level / 100)

                        guildLabel = "[" ..
                            tostring(unit.GetGuildInfo(unitId).level) .. "] " .. FromWS(unit.GetGuildInfo(unitId).name)
                        -- InspectData.guildLabel = guildLabel

                        if (UI.get("InspectLabels", "ShowCapeInfo") and info.level > 0 and info.level < 4) then
                            local lvl = CreateWG("Text", "Item", eqSlot, true,
                                {
                                    alignX = 0,
                                    sizeX = 44,
                                    posX = -2,
                                    highPosX = 2,
                                    alignY = 0,
                                    sizeY = 44,
                                    posY = 1,
                                    highPosY = 0
                                })

                            local fontsize = UI.get("InspectLabels", "CapeTextFontSize") or 16
                            lvl:SetFormat(userMods.ToWString(
                                "<html><body alignx='right' aligny='top' fontsize='" ..
                                tostring(fontsize) ..
                                "' outline='2' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))

                            lvl:SetVal("name", " " .. tostring(level))
                            lvl:SetClassVal("class", UI.get("InspectLabels", "CapeColor") or "ColorWhite")

                            table.insert(inspectLabels, lvl)
                        end

                        -- InspectData.extras[1] = {
                        --     name = FromWS(info.name),
                        --     label = tostring(romanNumerals[info.level or 1])
                        -- }

                        if (showExtras and cloakMode ~= nil and cloakMode ~= "-") then
                            local name = FromWS(info.name)
                            if (cloakMode == "banners" and BANNERS[name] == nil) then goto skip_cloak end

                            if (CLOAKS[name] ~= nil) then
                                local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
                                local textBg = nil
                                WtSetPlace(widget,
                                    {
                                        sizeX = extrasSize,
                                        sizeY = extrasSize,
                                        posX = (extrasSize + 1) * extrasCount,
                                        posY = 0
                                    })

                                if (UI.get("ExtraPanel", "TextBackground")) then
                                    textBg = mainForm:CreateWidgetByDesc(panelTemplate:GetWidgetDesc())
                                    widget:AddChild(textBg)
                                    WtSetPlace(textBg, { sizeX = extrasSize, sizeY = extrasSize, posX = 0, posY = 0 })
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
                                local fontSize = UI.get("ExtraPanel", "TextFontSize") or 15
                                local textWidget = CreateWG("Text", "Info", textBg or widget, true,
                                    {
                                        alignX = 0,
                                        sizeX = extrasSize,
                                        posX = 0,
                                        highPosX = 0,
                                        alignY = 0,
                                        sizeY = extrasSize,
                                        posY = (fontSpecificParams[fontSize] ~= nil and fontSpecificParams[fontSize].posY) or
                                            3,
                                        highPosY = 0
                                    }
                                )
                                local alignX = UI.get("ExtraPanel", "TextAlignX") or "right"
                                local alignY = UI.get("ExtraPanel", "TextAlignY") or "bottom"

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

                                if (BANNERS[name] == nil) then
                                    levelString = " "
                                end

                                textWidget:SetVal("name", tostring(levelString))
                                textWidget:SetClassVal("class", "ColorWhite")

                                extraPanel:AddChild(widget)
                                widget:Show(true)
                                textWidget:Show(true)
                                table.insert(activeInspectWidgets, widget)
                                extrasCount = extrasCount + 1
                            end

                            ::skip_cloak::
                        end
                    end
                elseif (k >= 38 and k <= 40) then
                    local info = itemLib.GetItemInfo(itemId)
                    if (info == nil) then goto continue_arts end

                    if (ARTS_POWER[FromWS(info.name)]) then
                        if (info.level <= 20) then
                            artPower = (info.level * 25) + 250
                        else
                            artPower = (20 * 25 + 250) + ((info.level - 20) * 12.5)
                        end
                    end

                    local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
                    local textBg = nil
                    WtSetPlace(widget,
                        { sizeX = artSize, sizeY = artSize, posX = (artSize + 1) * (k - 38), posY = 0 })

                    if (UI.get("ArtsPanel", "TextBackground")) then
                        textBg = mainForm:CreateWidgetByDesc(panelTemplate:GetWidgetDesc())
                        widget:AddChild(textBg)
                        WtSetPlace(textBg, { sizeX = artSize, sizeY = artSize, posX = 0, posY = 0 })
                        textBg:SetBackgroundColor(UI.getGroupColor("ArtsPanelTextBgColor") or
                            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
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

                        local eqSlot = InspectEquipmentPanel:GetChildChecked("EquipmentSlot" .. (k - 38 + 24), false)
                        if (UI.get("InspectLabels", "ShowArtsInfo") and eqSlot ~= nil) then
                            local descr = tostring(level)
                            local lvl = CreateWG("Text", "Item", eqSlot, true,
                                {
                                    alignX = 0,
                                    sizeX = 44,
                                    posX = -2,
                                    highPosX = 2,
                                    alignY = 0,
                                    sizeY = 44,
                                    posY = 1,
                                    highPosY = 0
                                })

                            local fontsize = UI.get("InspectLabels", "ArtsTextFontSize") or 16
                            lvl:SetFormat(userMods.ToWString(
                                "<html><body alignx='center' aligny='top' fontsize='" ..
                                tostring(fontsize) ..
                                "' outline='2' shadow='1'><rs class='class'><r name='name'/></rs></body></html>"))
                            lvl:SetClassVal("class", UI.get("InspectLabels", "ArtsColor") or "ColorWhite")

                            if (tempInfo ~= nil) then
                                local timestamp = tempInfo.remainingMs / 1000
                                local seconds = math.floor(timestamp % 60)
                                local mins = math.floor(timestamp / 60) % 60
                                local hours = math.floor(timestamp / 3600) % 24
                                local days = math.floor(timestamp / 86400)
                                if (days > 0) then
                                    descr = tostring(days) .. "д"
                                elseif (hours > 0) then
                                    descr = tostring(hours) .. "ч"
                                elseif (mins > 0) then
                                    descr = tostring(mins) .. "м"
                                elseif (seconds > 0) then
                                    descr = tostring(seconds) .. "с"
                                end
                            end

                            lvl:SetVal("name", " " .. descr)

                            table.insert(inspectLabels, lvl)
                        end
                        local fontSize = UI.get("ArtsPanel", "TextFontSize") or 15
                        local levelWidget = CreateWG("Text", "Level", textBg or widget, true,
                            {
                                alignX = 0,
                                sizeX = artSize,
                                posX = 0,
                                highPosX = 0,
                                alignY = 0,
                                sizeY = artSize,
                                posY = (fontSpecificParams[fontSize] ~= nil and fontSpecificParams[fontSize].posY) or
                                    3,
                                highPosY = 0
                            }
                        )
                        local alignX = UI.get("ArtsPanel", "TextAlignX") or "right"
                        local alignY = UI.get("ArtsPanel", "TextAlignY") or "bottom"

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

                        -- InspectData.arts[k - 38 + 1] = {
                        --     name = FromWS(info.name),
                        --     label = tostring(level)
                        -- }

                        widget:Show(true)
                        levelWidget:Show(true)
                        artsCount = artsCount + 1
                        table.insert(activeInspectWidgets, widget)
                    end
                    ::continue_arts::
                elseif (k == 19) then
                    -- InspectData.extras[2] = {
                    --     name = FromWS(info.name),
                    --     label = ""
                    -- }
                    if (showExtras and UI.get("ExtraPanel", "ShowTrinket") and TRINKETS[FromWS(info.name)]) then
                        local texture = GetGroupTexture("RELATED_TEXTURES", TRINKETS[FromWS(info.name)])
                        if (texture ~= nil) then
                            local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
                            local textBg = nil
                            WtSetPlace(widget,
                                { sizeX = extrasSize, sizeY = extrasSize, posX = (extrasSize + 1) * extrasCount, posY = 0 })

                            if (UI.get("ExtraPanel", "TextBackground")) then
                                textBg = mainForm:CreateWidgetByDesc(panelTemplate:GetWidgetDesc())
                                widget:AddChild(textBg)
                                WtSetPlace(textBg, { sizeX = extrasSize, sizeY = extrasSize, posX = 0, posY = 0 })
                                textBg:SetBackgroundColor(UI.getGroupColor("ExtraPanelTextBgColor") or
                                    { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
                                textBg:Show(true)
                            end

                            widget:SetBackgroundTexture(texture)

                            extraPanel:AddChild(widget)
                            widget:Show(true)
                            table.insert(activeInspectWidgets, widget)
                            extrasCount = extrasCount + 1
                        end
                    end
                end
            end


            for k1, v1 in pairs(itemBonus.specStats) do
                if (v1 ~= nil and v1.tooltipName ~= nil and v1.value ~= nil) then
                    local statName = FromWS(v1.tooltipName)
                    if (stats[statName] == nil) then
                        stats[statName] = 0
                    end
                    stats[statName] = stats[statName] + v1.value
                end
            end

            ::continue_stats::
        end
    end
    if (UI.get("GearScoreText", "Show")) then
        local fontSize = UI.get("GearScoreText", "TextFontSize") or 16
        local color = UI.get("GearScoreText", "CustomColor")
        if (color == "-") then
            color = QUALITY[math.floor((gearQuality / gearCount) + 0.5)]
        end

        gearScoreText:SetFormat('<header color="0x' ..
            QUALITY_HEX[math.floor((gearQuality / gearCount) + 0.5)] .. '" alignx="middle" aligny="middle" fontsize="' ..
            tostring(fontSize) .. '" shadow="1" outline="1"><rs class="class"><r name="value"/></rs></header>');

        gearScoreText:SetBackgroundColor({ r = 0.0, g = 0.0, b = 0.0, a = 0 })
        if (UI.get("GearScoreText", "ShowTextBackground")) then
            gearScoreText:SetBackgroundColor(UI.getGroupColor("GearScoreTextBgColor"))
        end

        gearScoreText:SetVal("value", tostring(math.floor(gearScore + 0.5)))
        gearScoreText:SetClassVal("class", color)
        gearScoreText:Show(true)
    end

    -- InspectData.gs = {
    --     value = gearScore,
    --     quality = math.floor((gearQuality / gearCount) + 0.5),
    -- }

    local dragonItems = unit.GetEquipmentItemIds(unitId, ITEM_CONT_EQUIPMENT_RITUAL)

    if (dragonItems ~= nil) then
        for k, v in pairs(dragonItems) do
            local ritualInfo = itemLib.GetItemInfo(v)

            if (ritualInfo) then
                local temp = 0
                for j = 0, 15 do
                    local bonus = 5 + j * 10
                    local max = 200 + bonus * 2
                    local min = max - 10
                    -- Log("bonus: " ..
                    --     tostring(bonus) ..
                    --     " max: " ..
                    --     tostring(max) .. " min: " .. tostring(min) .. " level: " .. tostring(ritualInfo.level))

                    if (ritualInfo.level >= min and ritualInfo.level <= max) then
                        temp = bonus + ritualInfo.level - min
                    end
                end

                if (eqSlotsInspect[k] ~= nil) then
                    local eqSlot = InspectEquipmentPanel:GetChildUnchecked("EquipmentSlot" .. eqSlotsInspect[k], false)
                    if (UI.get("InspectLabels", "ShowDOCraft") and eqSlot ~= nil) then
                        DrawRitualInfo(k, eqSlot, ritualInfo, v, false)
                    end
                elseif (k == 19) then
                    -- InspectData.extras[3] = {
                    --     name = FromWS(ritualInfo.name),
                    --     label = ""
                    -- }
                    if (showExtras and UI.get("ExtraPanel", "ShowDO") and DO_TRINKETS[FromWS(ritualInfo.name)]) then
                        local texture = GetGroupTexture("RELATED_TEXTURES", DO_TRINKETS[FromWS(ritualInfo.name)])
                        if (texture ~= nil) then
                            local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
                            local textBg = nil
                            WtSetPlace(widget,
                                { sizeX = extrasSize, sizeY = extrasSize, posX = (extrasSize + 1) * extrasCount, posY = 0 })

                            if (UI.get("ExtraPanel", "TextBackground")) then
                                textBg = mainForm:CreateWidgetByDesc(panelTemplate:GetWidgetDesc())
                                widget:AddChild(textBg)
                                WtSetPlace(textBg, { sizeX = extrasSize, sizeY = extrasSize, posX = 0, posY = 0 })
                                textBg:SetBackgroundColor(UI.getGroupColor("ExtraPanelTextBgColor") or
                                    { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
                                textBg:Show(true)
                            end

                            widget:SetBackgroundTexture(texture)

                            extraPanel:AddChild(widget)
                            widget:Show(true)
                            table.insert(activeInspectWidgets, widget)
                            extrasCount = extrasCount + 1
                        end
                    end
                end

                -- Log(FromWS(ritualInfo.name))
                -- Log(DO_TRINKETS[FromWS(ritualInfo.name)])

                -- if (DO_TRINKETS[FromWS(ritualInfo.name)]) then
                --     local texture = GetGroupTexture("RELATED_TEXTURES", DO_TRINKETS[FromWS(ritualInfo.name)])
                --     Log(texture)
                --     if (texture ~= nil) then
                --         local eqSlot = InspectEquipmentPanel:GetChildUnchecked("EquipmentSlot22", false)
                --         Log(eqSlot)
                --         if (eqSlot ~= nil) then
                --             local widget = mainForm:CreateWidgetByDesc(iconTemplate:GetWidgetDesc())
                --             widget:SetBackgroundTexture(texture)
                --             WtSetPlace(widget, { alignX = 1, sizeX = 24, sizeY = 24, posX = 0, highPosX = 1, posY = 1 })
                --             eqSlot:AddChild(widget)
                --             widget:Show(true)
                --         end
                --     end
                -- end

                stats["power"] = stats["power"] + temp
            end
        end
    end

    local sumPower = 300 + stats["power"] + fairyPower
    sumPower = sumPower + (sumPower * 0.09)

    if (guildPowerBonus > 0) then
        sumPower = sumPower + (sumPower * guildPowerBonus)
    end

    sumPower = sumPower + artPower

    -- InspectData.power = {
    --     value = sumPower,
    -- }

    if (UI.get("PowerScoreText", "Show")) then
        local fontSize = UI.get("PowerScoreText", "TextFontSize") or 16
        local color = UI.get("PowerScoreText", "Color")
        if (color == "-") then
            color = "Dragon"
        end

        powerScoreText:SetFormat('<header color="0x' ..
            QUALITY_HEX[math.floor((gearQuality / gearCount) + 0.5)] .. '" alignx="middle" aligny="middle" fontsize="' ..
            tostring(fontSize) .. '" shadow="1" outline="1"><rs class="class"><r name="value"/></rs></header>');

        powerScoreText:SetBackgroundColor({ r = 0.0, g = 0.0, b = 0.0, a = 0 })
        if (UI.get("PowerScoreText", "ShowTextBackground")) then
            powerScoreText:SetBackgroundColor(UI.getGroupColor("PowerScoreTextBgColor"))
        end

        powerScoreText:SetVal("value", tostring(math.floor(sumPower + 0.5)))
        powerScoreText:SetClassVal("class", color or "ColorWhite")
        powerScoreText:Show(true)
    end

    local atc_count = 0
    local def_count = 0
    local atc_main_count = 0
    local def_main_count = 0

    -- sort stats, so they are in the same order as in the settings
    local stats_sorted = {}
    for k, v in pairs(stats) do
        if (STATS_ORDER[k] ~= nil) then
            table.insert(stats_sorted, k)
        end
    end
    table.sort(stats_sorted, function(a, b)
        return STATS_ORDER[a] < STATS_ORDER[b]
    end)

    for si = 1, #stats_sorted do
        local k = stats_sorted[si]
        local v = stats[k]
        if (v > 0) then
            if (STATS_ATC_MAIN[k] ~= nil and UI.get(panels["StatsAtcMain"].setting, "ShowMain")) then
                if (not UI.get(panels["StatsAtcMain"].setting, "SeparateInTwo")) then
                    local added = drawStatIcon(k, v, STATS_ATC_MAIN[k], panels["StatsAtc"], atc_count)
                    if (added) then atc_count = atc_count + 1 end
                else
                    local added = drawStatIcon(k, v, STATS_ATC_MAIN[k], panels["StatsAtcMain"], atc_main_count)
                    if (added) then atc_main_count = atc_main_count + 1 end
                end
            elseif (STATS_ATC[k] ~= nil and UI.get(panels["StatsAtc"].setting, "ShowAdd")) then
                local added = drawStatIcon(k, v, STATS_ATC[k], panels["StatsAtc"], atc_count)
                if (added) then atc_count = atc_count + 1 end
            elseif (STATS_DEF_MAIN[k] ~= nil and UI.get(panels["StatsDefMain"].setting, "ShowMain")) then
                if (not UI.get(panels["StatsDefMain"].setting, "SeparateInTwo")) then
                    local added = drawStatIcon(k, v, STATS_DEF_MAIN[k], panels["StatsDef"], def_count)
                    if (added) then def_count = def_count + 1 end
                else
                    local added = drawStatIcon(k, v, STATS_DEF_MAIN[k], panels["StatsDefMain"], def_main_count)
                    if (added) then def_main_count = def_main_count + 1 end
                end
            elseif (STATS_DEF[k] ~= nil and UI.get(panels["StatsDef"].setting, "ShowAdd")) then
                local added = drawStatIcon(k, v, STATS_DEF[k], panels["StatsDef"], def_count)
                if (added) then def_count = def_count + 1 end
            else
                -- Log(k .. " : " .. v)
            end
        end
    end

    if (showStats) then
        if (atc_count > 0) then
            local panelInfo = panels["StatsAtc"]

            local size = UI.get(panelInfo.setting, "IconSizeV3") or 40
            WtSetPlace(panelInfo.panel,
                { sizeX = (size + 1) * atc_count, sizeY = size })
            panelInfo.panel:SetBackgroundColor(UI.getGroupColor(panelInfo.setting .. "BgColor") or
                { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
            panelInfo.panel:Show(true)

            WtSetPlace(panelInfo.panel, { sizeX = (size + 1) * atc_count, sizeY = size })
        end
        if (def_count > 0) then
            local panelInfo = panels["StatsDef"]

            local size = UI.get(panelInfo.setting, "IconSizeV3") or 40
            WtSetPlace(panelInfo.panel,
                { sizeX = (size + 1) * def_count, sizeY = size })
            panelInfo.panel:SetBackgroundColor(UI.getGroupColor(panelInfo.setting .. "BgColor") or
                { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
            panelInfo.panel:Show(true)

            WtSetPlace(panelInfo.panel, { sizeX = (size + 1) * def_count, sizeY = size })
        end
        if (atc_main_count > 0) then
            local panelInfo = panels["StatsAtcMain"]

            local size = UI.get(panelInfo.setting, "IconSizeV3") or 40
            WtSetPlace(panelInfo.panel,
                { sizeX = (size + 1) * atc_main_count, sizeY = size })
            panelInfo.panel:SetBackgroundColor(UI.getGroupColor(panelInfo.setting .. "BgColor") or
                { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
            panelInfo.panel:Show(true)

            WtSetPlace(panelInfo.panel, { sizeX = (size + 1) * atc_main_count, sizeY = size })
        end
        if (def_main_count > 0) then
            local panelInfo = panels["StatsDefMain"]

            local size = UI.get(panelInfo.setting, "IconSizeV3") or 40
            WtSetPlace(panelInfo.panel,
                { sizeX = (size + 1) * def_main_count, sizeY = size })
            panelInfo.panel:SetBackgroundColor(UI.getGroupColor(panelInfo.setting .. "BgColor") or
                { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
            panelInfo.panel:Show(true)

            WtSetPlace(panelInfo.panel, { sizeX = (size + 1) * def_main_count, sizeY = size })
        end
    end
    if (showArts and artsCount > 0) then
        WtSetPlace(artsPanel, { sizeX = (artSize + 1) * 3, sizeY = artSize })
        artsPanel:SetBackgroundColor(UI.getGroupColor("ArtsPanelBgColor") or { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        artsPanel:Show(true)
    end

    if (showExtras and extrasCount > 0) then
        WtSetPlace(extraPanel,
            { sizeX = (extrasSize + 1) * extrasCount, sizeY = extrasSize })
        extraPanel:SetBackgroundColor(UI.getGroupColor("ExtraPanelBgColor") or
            { r = 0.0, g = 0.0, b = 0.0, a = 0.5 })
        extraPanel:Show(true)
    end

    -- Save
    -- if (UI_SETTINGS["Database_" .. InspectData.name] ~= nil) then
    --     UI.groupPop("Database", InspectData.name)
    -- end
    -- UI.groupPush("Database",
    --     UI.createInspectData(InspectData.name, InspectData), true
    -- )
end

local function onInspectStarted(p)
    local unitId = avatar.GetTarget()
    if (unitId == nil) then return end
    if (unitId == lastInspectUnitId) then return end
    if not object.IsExist(unitId) then return end

    if (avatar.IsTargetInspected()) then
        lastInspectUnitId = unitId
        drawScrolls(unitId)
        DrawInfo(unitId)
        drawRatings(unitId)
    end
end

local function onTargetChange(p)
    clearActiveInspect()
    lastInspectUnitId = nil

    -- if (lastTarget ~= nil) then
    --     common.UnRegisterEventHandler(onEqSlotChanged, "EVENT_UNIT_EQUIPMENT_CHANGED", {
    --         objectId = lastTarget
    --     })
    --     -- common.UnRegisterEventHandler(OnChangeEqSlot, "EVENT_UNIT_EQUIPMENT_CHANGED", {
    --     --     objectId = lastTarget
    --     -- })
    -- end

    -- lastTarget = avatar.GetTarget()
    -- common.RegisterEventHandler(onEqSlotChanged, "EVENT_UNIT_EQUIPMENT_CHANGED", {
    --     objectId = lastTarget
    -- })

    hidePanel(artsPanel)
    hidePanel(statsAtcPanel)
    hidePanel(statsAtcMainPanel)
    hidePanel(statsDefPanel)
    hidePanel(statsDefMainPanel)
    hidePanel(scrollsPanel)
    hidePanel(extraPanel)
    hidePanel(currentRatingPanel)
    hideText(gearScoreText)
    hideText(fairyScoreText)
    hideText(runeScoreText)
    hideText(powerScoreText)
    -- hidePanel(lastRatingPanel)

    local unitId = avatar.GetTarget()
    if (unitId == nil) then return end
    if not object.IsExist(unitId) then return end

    if (unitId == avatar.GetId()) then
        drawScrolls(avatar.GetId())
        DrawInfo(avatar.GetId())
        drawRatings(avatar.GetId())
    elseif (unit.IsPlayer(unitId) and avatar.IsInspectAllowed()) then
        -- Log("Inspecting player " .. unitId)
        avatar.StartInspect(unitId)
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

    for _, text in pairs(texts) do
        if (text ~= nil and text.widget ~= nil) then
            DnD.Enable(text.widget, DnDEnabled)

            if (not text.widget:IsVisibleEx() and DnDEnabled) then
                showTextDnDInfo(text.widget)
            elseif (text.widget:IsVisibleEx() and not DnDEnabled) then
                if (text.widget:GetValuedText() ~= nil and common.ExtractWStringFromValuedText(text.widget:GetValuedText()) ~= nil) then
                    if (FromWS(common.ExtractWStringFromValuedText(text.widget:GetValuedText())) == "GearScoreText" or
                            FromWS(common.ExtractWStringFromValuedText(text.widget:GetValuedText())) == "FairyScoreText" or
                            FromWS(common.ExtractWStringFromValuedText(text.widget:GetValuedText())) == "RuneScoreText" or
                            FromWS(common.ExtractWStringFromValuedText(text.widget:GetValuedText())) == "PowerScoreText") then
                        text.widget:Show(false)
                    end
                end
            end
        end
    end

    Log("Drag & Drop - " .. (DnDEnabled and "On." or "Off."))

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

----------------------------------------------------------------------------------------------------
-- AOPanel support

local IsAOPanelEnabled = GetConfig("EnableAOPanel") or GetConfig("EnableAOPanel") == nil

local function onAOPanelStart(p)
    if IsAOPanelEnabled then
        local SetVal = { val1 = userMods.ToWString("BI"), class1 = "RelicCursed" }
        local params = { header = SetVal, ptype = "button", size = 32 }
        userMods.SendEvent("AOPANEL_SEND_ADDON",
            { name = common.GetAddonName(), sysName = common.GetAddonName(), param = params })

        local cfgBtn = mainForm:GetChildChecked("ConfigButton", false)
        if cfgBtn then
            cfgBtn:Show(false)
        end
    end
end

local function onAOPanelLeftClick(p)
    if p.sender == common.GetAddonName() then
        onCfgLeft()
    end
end

local function onAOPanelRightClick(p)
    if p.sender == common.GetAddonName() then
        onCfgRight()
    end
end

local function onAOPanelChange(params)
    if params.unloading and params.name == "UserAddon/AOPanelMod" then
        local cfgBtn = mainForm:GetChildChecked("ConfigButton", false)
        if cfgBtn then
            cfgBtn:Show(true)
        end
    end
end

local function searchDB()

end

local function onSlash(p)
	local m = userMods.FromWString(p.text)
	local split_string = {}
	for w in m:gmatch("%S+") do table.insert(split_string, w) end

	if (split_string[1]:lower() == '/bi.clear') then
		ClearBagLabels()
	end
end

----------------------------------------------------------------------------------------------------

local function setupUI()
    LANG = common.GetLocalization() or "rus"
    UI.init("BetterInspect")

    UI.addGroup("ArtsPanel", {
        UI.createCheckBox("Show", true),
        UI.createSlider("IconSizeV3", { stepsCount = 40, width = 212, offset = 24 }, 28),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 12),
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
        UI.createCheckBox("SeparateInTwo", false),
        UI.createSlider("IconSizeV3", { stepsCount = 40, width = 212, offset = 24 }, 28),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 10),
        UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
        UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
        UI.createCheckBox("Round", true),
        UI.createCheckBox("TextBackground", false),
        UI.createList("TextureStyle", { "RELATED_TEXTURES", "STAT_SMALL_POTION", "STAT_ELIXIR_PWR" }, 1, false),
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
        UI.createCheckBox("SeparateInTwo", false),
        UI.createSlider("IconSizeV3", { stepsCount = 40, width = 212, offset = 24 }, 28),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 10),
        UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
        UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
        UI.createCheckBox("Round", true),
        UI.createCheckBox("TextBackground", false),
        UI.createList("TextureStyle", { "RELATED_TEXTURES", "STAT_SMALL_POTION", "STAT_ELIXIR_PWR" }, 1, false),
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

        UI.createSlider("IconSizeV3", { stepsCount = 40, width = 212, offset = 24 }, 28),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 12),
        UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
        UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
        -- UI.createCheckBox("ShowTempInfo", false),
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
        UI.createCheckBox("ShowTrinket", true),
        UI.createCheckBox("ShowDO", true),
        UI.createSlider("IconSizeV3", { stepsCount = 40, width = 212, offset = 24 }, 28),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 12),
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

    UI.addGroup("CurrentRatingPanel", {
        UI.createCheckBox("Show", true),
        UI.createList("PvPType", { "score", "place", "winrate" }, 1, false),
        UI.createList("HPIType", { "place", "level", "time" }, 1, false),
        UI.createSlider("IconSizeV3", { stepsCount = 40, width = 212, offset = 24 }, 28),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 12),
        UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
        UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
        UI.createCheckBox("TextBackground", false),
    })


    UI.createColorGroup("CurrentRatingPanelBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.createColorGroup("CurrentRatingPanelTextBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.addGroup("GearScoreText", {
        UI.createCheckBox("Show", true),
        UI.createList("CustomColor", UI.getClassList(true), 0, true),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 17),
        UI.createCheckBox("ShowTextBackground", false),
    })
    UI.createColorGroup("GearScoreTextBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.addGroup("PowerScoreText", {
        UI.createCheckBox("Show", true),
        UI.createList("Color", UI.getClassList(), 22, true),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 17),
        UI.createCheckBox("ShowTextBackground", false),
    })
    UI.createColorGroup("PowerScoreTextBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.addGroup("FairyScoreText", {
        UI.createCheckBox("Show", true),
        UI.createList("CustomColor", UI.getClassList(true), 0, true),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 15),
        UI.createCheckBox("UseRomansForFairy", true),
        UI.createCheckBox("ShowFairyLevel", false),
        UI.createCheckBox("ShowTextBackground", false),
    })
    UI.createColorGroup("FairyScoreTextBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.addGroup("RuneScoreText", {
        UI.createCheckBox("Show", true),
        UI.createInput("RuneSeparator", {
            maxChars = 10,
            filter = ""
        }, '.'),
        UI.createInput("MainSeparator", {
            maxChars = 10,
            filter = ""
        }, ' / '),
        UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 15),
        UI.createCheckBox("ShowTextBackground", false),
    })
    UI.createColorGroup("RuneScoreTextBgColor", {
        r = 0,
        g = 0,
        b = 0,
        a = 50,
    })

    UI.addGroup("InspectLabels", {
        UI.withCustomClass(UI.createListLabel("-", {
            "InspectPercents",
        }), "tip_white"),
        UI.createCheckBox("ShowPercents", true),
        UI.createList("PercentColor", UI.getClassList(), 1, true),
        UI.createSlider("PercentTextFontSize", { stepsCount = 8, width = 212, offset = 10 }, 13),
        UI.withCustomClass(UI.createListLabel("-", {
            "InspectDO",
        }), "tip_white"),
        UI.createCheckBox("ShowDOCraft", true),
        UI.createList("DOColor", UI.getClassList(), 25, true),
        UI.createSlider("DOTextFontSize", { stepsCount = 8, width = 212, offset = 10 }, 12),
        UI.withCustomClass(UI.createListLabel("-", {
            "InspectArts",
        }), "tip_white"),
        UI.createCheckBox("ShowArtsInfo", true),
        UI.createList("ArtsColor", UI.getClassList(), 1, true),
        UI.createSlider("ArtsTextFontSize", { stepsCount = 8, width = 212, offset = 10 }, 16),
        UI.withCustomClass(UI.createListLabel("-", {
            "InspectCape",
        }), "tip_white"),
        UI.createCheckBox("ShowCapeInfo", true),
        UI.createList("CapeColor", UI.getClassList(), 1, true),
        UI.createSlider("CapeTextFontSize", { stepsCount = 8, width = 212, offset = 10 }, 16),
    })

    UI.addGroup("BagLabels", {
        UI.createCheckBox("BagGlobalEnable", true),
        UI.withCustomClass(UI.createListLabel("-", {
            "BagEqPercents",
        }), "tip_white"),
        UI.createCheckBox("BagShowEqPercents", true),
        UI.createList("BagEqPercentColor", UI.getClassList(), 1, true),
        UI.createSlider("BagEqPercentTextFontSize", { stepsCount = 8, width = 212, offset = 10 }, 14),
        UI.withCustomClass(UI.createListLabel("-", {
            "BagDo",
        }), "tip_white"),
        UI.createCheckBox("BagShowDOCraft", true),
        UI.createList("BagDOColor", UI.getClassList(), 1, true),
        UI.createSlider("BagDOTextFontSize", { stepsCount = 8, width = 212, offset = 10 }, 14),
        UI.withCustomClass(UI.createListLabel("-", {
            "BagItemLevel",
        }), "tip_white"),
        UI.createCheckBox("BagShowItemLevel", true),
        UI.createList("BagItemLevelColor", UI.getClassList(), 1, true),
        UI.createSlider("BagItemLevelTextFontSize", { stepsCount = 8, width = 212, offset = 10 }, 14),
        UI.withCustomClass(UI.createListLabel("-", {
            "BagTimeleft",
        }), "tip_white"),
        UI.createCheckBox("BagShowTimeleft", true),
        UI.createList("BagTimeleftColor", UI.getClassList(), 1, true),
        UI.createInput("BagTimeleftCriticalHours", {
            maxChars = 4,
            filter = "_INT"
        }, '48'),
        UI.createList("BagTimeleftCriticalColor", UI.getClassList(), 25, true),
        UI.createSlider("BagTimeleftTextFontSize", { stepsCount = 8, width = 212, offset = 10 }, 14),
    })

    -- UI.addGroup("Database", {
    --     UI.createButtonInput("SearchDB", {
    --         width = 90,
    --         states = {
    --             "Search",
    --         },
    --         callback = searchDB
    --     }, 1),
    -- })


    -- UI.addGroup("LastRatingPanel", {
    --     UI.createCheckBox("Show", true),
    --     UI.createList("PvPType", { "score", "top", "winrate" }, 1, false),
    --     UI.createList("PvEType", { "top", "score", "winrate" }, 1, false),
    --     UI.createSlider("IconSizeV3", { stepsCount = 40, width = 212, offset = 24 }, 40),
    --     UI.createSlider("TextFontSize", { stepsCount = 20, width = 212, offset = 10 }, 15),
    --     UI.createList("TextAlignX", { "left", "center", "right" }, 3, false),
    --     UI.createList("TextAlignY", { "top", "middle", "bottom" }, 3, false),
    --     UI.createCheckBox("TextBackground", false),
    -- })


    -- UI.createColorGroup("LastRatingPanelBgColor", {
    --     r = 0,
    --     g = 0,
    --     b = 0,
    --     a = 50,
    -- })

    -- UI.createColorGroup("LastRatingPanelTextBgColor", {
    --     r = 0,
    --     g = 0,
    --     b = 0,
    --     a = 50,
    -- })

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
            label = "Stats",
            buttons = {
                left = { "Restore" },
                right = { "Accept" }
            },
            groups = {
                "StatsAtcPanel",
                "StatsAtcPanelBgColor",
                "StatsAtcPanelTextBgColor",
                "StatsDefPanel",
                "StatsDefPanelBgColor",
                "StatsDefPanelTextBgColor",
            }
        },
        -- {
        --     label = "StatsAtc",
        --     buttons = {
        --         left = { "Restore" },
        --         right = { "Accept" }
        --     },
        --     groups = {
        --         "StatsAtcPanel",
        --         "StatsAtcPanelBgColor",
        --         "StatsAtcPanelTextBgColor",
        --     }
        -- },
        -- {
        --     label = "StatsDef",
        --     buttons = {
        --         left = { "Restore" },
        --         right = { "Accept" }
        --     },
        --     groups = {
        -- "StatsDefPanel",
        -- "StatsDefPanelBgColor",
        -- "StatsDefPanelTextBgColor",
        --     }
        -- },
        -- {
        --     label = "Scrolls",
        --     buttons = {
        --         left = { "Restore" },
        --         right = { "Accept" }
        --     },
        --     groups = {
        -- "ScrollsPanel",
        -- "ScrollsPanelBgColor",
        -- "ScrollsPanelTextBgColor",
        --     }
        -- },
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
                "ScrollsPanel",
                "ScrollsPanelBgColor",
                "ScrollsPanelTextBgColor",
                "CurrentRatingPanel",
                "CurrentRatingPanelBgColor",
                "CurrentRatingPanelTextBgColor",
            }
        },
        {
            label = "Texts",
            buttons = {
                left = { "Restore" },
                right = { "Accept" }
            },
            groups = {
                "InspectLabels",
                "GearScoreText",
                "GearScoreTextBgColor",
                "PowerScoreText",
                "PowerScoreTextBgColor",
                "FairyScoreText",
                "FairyScoreTextBgColor",
                "RuneScoreText",
                "RuneScoreTextBgColor",
                "BagLabels",
            }
        },
        -- {
        --     label = "Database",
        --     buttons = {
        --         left = { "Restore" },
        --     },
        --     groups = {
        --         "Database",
        --     }
        -- },
    }, "Arts")

    UI.loadUserSettings()
    UI.render()
end

function Init()
    -- CHECKS

    common.RegisterEventHandler(onWidgetShowChanged, "EVENT_WIDGET_SHOW_CHANGED")
    common.RegisterEventHandler(onChangeInventorySlot, "EVENT_INVENTORY_SLOT_CHANGED")
    -- common.RegisterEventHandler(onChangeEqSlot, "EVENT_UNIT_EQUIPMENT_CHANGED")
    -- common.RegisterEventHandler(onInspect, "EVENT_INSPECT_STARTED")
    -- common.RegisterEventHandler(onInspectFinish, "EVENT_INSPECT_FINISHED")
	common.RegisterEventHandler(onSlash, 'EVENT_UNKNOWN_SLASH_COMMAND')
    common.RegisterEventHandler(onTargetChange, "EVENT_AVATAR_TARGET_CHANGED")
    common.RegisterEventHandler(onInspectStarted, "EVENT_INSPECT_STARTED")

    common.RegisterEventHandler(onTimer, "EVENT_SECOND_TIMER")

    common.RegisterReactionHandler(onCfgLeft, "ConfigLeftClick")
    common.RegisterReactionHandler(onCfgRight, "ConfigRightClick")

    -- AOPanel
    common.RegisterEventHandler(onAOPanelStart, "AOPANEL_START")
    common.RegisterEventHandler(onAOPanelLeftClick, "AOPANEL_BUTTON_LEFT_CLICK")
    common.RegisterEventHandler(onAOPanelRightClick, "AOPANEL_BUTTON_RIGHT_CLICK")
    common.RegisterEventHandler(onAOPanelChange, "EVENT_ADDON_LOAD_STATE_CHANGED")

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
                size = UI.get(v.setting, "IconSizeV3") or size
                color = UI.getGroupColor(v.setting .. "BgColor") or color
            end

            WtSetPlace(v.panel,
                { sizeX = (size + 1) * 3, sizeY = size })
            v.panel:SetBackgroundColor(color)
        end
    end

    for kt, text in pairs(texts) do
        if (text ~= nil and text.widget ~= nil) then
            DnD.Init(text.widget, text.widget, true)
            DnD.Enable(text.widget, false)
            local color = { r = 0.0, g = 0.0, b = 0.0, a = 0.5 }

            if (text.setting ~= nil) then
                color = UI.getGroupColor(text.setting .. "BgColor") or color
            end

            -- WtSetPlace(v.panel,
            --     { sizeX = (size + 1) * 3, sizeY = size })
            text.widget:SetBackgroundColor(color)
        end
    end

    -- LogWidget(mainForm)
end

if (avatar.IsExist()) then
    Init()
else
    common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
end
