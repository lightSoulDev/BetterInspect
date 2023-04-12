Global("LOGGER", {})

local function log(message, class)
    local textFormat = string.format("<html fontsize='16'><rs class='class'>%s</rs></html>", message)
    local VT = common.CreateValuedText()
    VT:SetFormat(userMods.ToWString(textFormat))
    if class == nil then
        class = "LogColorWhite"
    end
    VT:SetClassVal("class", class)
    local chatLog = common.GetAddonMainForm("ChatLog")
    if chatLog == nil then
        return
    end

    local chatContainer = chatLog:GetChildUnchecked("Area", false)
        :GetChildUnchecked("Panel02", false):GetChildUnchecked("Container", false)
    chatContainer:PushFrontValuedText(VT)
end

function Log(message)
    message = string.format("[%s]: %s", common.GetAddonName(), message)
    log(message, nil)
end

function Err(message)
    message = string.format("[%s]: %s", common.GetAddonName(), message)
    log(message, "LogColorRed")
end

function Warn(message)
    message = string.format("[%s]: %s", common.GetAddonName(), message)
    log(message, "LogColorYellow")
end

function Debug(message)
    log(message, "LogColorWhite")
end

local function withLevel(message, level)
    if level == nil or level <= 0 then
        return message
    end

    local prefix = "|__"
    for i = 2, level do
        prefix = "    " .. prefix
    end

    return prefix .. message
end

local count = 0

function LogWidget(widget, level)
    if level == nil then
        Debug("Widget: " .. widget:GetName())
        level = 1
    end
    for k, v in pairs(widget:GetNamedChildren()) do
        Debug(withLevel("[" .. k .. "] " .. v:GetName(), level))
        LogWidget(v, level + 1)
    end
end

function LogWidgetChildrenCount(widget, level)
    if level == nil then
        Debug("Widget: " .. widget:GetName())
        level = 1
        count = 0
    end
    for k, v in pairs(widget:GetNamedChildren()) do
        count = count + 1
        LogWidgetChildrenCount(v, level + 1)
    end

    return count
end
