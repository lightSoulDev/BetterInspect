Global("ARTS", {})
Global("ARTS_POWER", {})
Global("STATS_ATC_MAIN", {})
Global("STATS_ATC", {})
Global("STATS_DEF_MAIN", {})
Global("STATS_DEF", {})
Global("SCROLLS", {})
Global("CLOAKS", {})
Global("BANNERS", {})
Global("DO_TRINKETS", {})
Global("TRINKETS", {})
Global("ALL_TEXTURE_INDEXES", {})
Global("STATS_ORDER", {})

BANNERS = {
    ["����� �������"] = "BannerRed",
    ["����� ���������"] = "BannerBlue",
    ["����� �������"] = "BannerGreen",
}

CLOAKS = {
    ["����������� �������"] = "GuildCloak",
    ["����������� �������"] = "ChampCloak",
    ["����� �������"] = "BannerRed",
    ["����� ���������"] = "BannerBlue",
    ["����� �������"] = "BannerGreen",
}

SCROLLS = {
    ["�������� ����������"] = "Uncommon",
    ["�������� �����������"] = "Rare",
    ["�������� ������ ����"] = "Epic",
    ["�������� �����"] = "Legendary",
    ["�������� ���������"] = "Relic",
}

STATS_ORDER = {
    ['����������'] = 1,
    ['���������'] = 2,
    ['�������������'] = 3,
    ['����������'] = 4,
    ['�����'] = 5,
    ['������'] = 6,
    ['��������'] = 7,
    ['���������������'] = 8,
    ['���������'] = 9,
    ['����'] = 10,
    ['�������������'] = 11,
    ['���������'] = 12,
    ['��������'] = 13,
    ['������������'] = 14,
    ['������������'] = 15,
    ['ritual'] = 16,
    ['power'] = 17,
    ['stamina'] = 18,
}

STATS_ATC_MAIN = {
    ['����������'] = "StatMastery",
    ['���������'] = "StatResolution",
    ['�������������'] = "StatFinisher",
}

STATS_ATC = {
    ['����������'] = "StatGosp",
    ['�����'] = "StatLuck",
    ['������'] = "StatRage",
    ['��������'] = "StatStun",
    ['���������������'] = "StatFastCast",
}

STATS_DEF_MAIN = {
    ['���������'] = "StatStamina",
    ['����'] = "StatWill",
    ['�������������'] = "StatLifesteal",
}

STATS_DEF = {
    ['���������'] = "StatVitality",
    ['��������'] = "StatAntiCrit",
    ['������������'] = "StatCaution",
    ['������������'] = "StatAntiStun",
}

ARTS_POWER = {
    ['�������� �����'] = true
}

DO_TRINKETS = {
    ['���������� ���'] = "BloodyThorn",
    ['������ �����'] = "AltarOfLight",
    ['������ ���� ������'] = "TrinketDragonAmulet",
}

TRINKETS = {
    ['������� �����'] = "TrinketUncom",
    ['������� ����������'] = "TrinketRare",
    ['������� �����������'] = "TrinketEpic",
    ['������� �������� �����'] = "TrinketLegendary",
    ['������� �������'] = "TrinketRelic",

    ['������� ����� � ����������'] = "TrinketUncom",
    ['������� ���������� � ����������'] = "TrinketRare",
    ['������� ����������� � ����������'] = "TrinketEpic",
    ['������� �������� ����� � ����������'] = "TrinketLegendary",
    ['������� ������� � ����������'] = "TrinketRelic",
}

ARTS = {
    ['�������� �����'] = "ArtefactGodsLegacy",
    ['������������ ����� �������'] = "ArtefactWhip",
    ['������������ ����� ������� I'] = "ArtefactWhip",
    ['������������ ����� ������� II'] = "ArtefactWhip",
    ['������������ ����� ������� III'] = "ArtefactWhip",
    ['������������ ������ �������'] = "ArtefactArrow",
    ['������������ ������ ������� I'] = "ArtefactArrow",
    ['������������ ������ ������� II'] = "ArtefactArrow",
    ['������������ ������ ������� III'] = "ArtefactArrow",
    ['���� ����� ������'] = "ArtefactCup",
    ['���� ����� ������ I'] = "ArtefactCup",
    ['���� ����� ������ II'] = "ArtefactCup",
    ['���� ����� ������ III'] = "ArtefactCup",
    ['�������� ���� ������'] = "ArtefactWill",
    ['�������� ���� ������ I'] = "ArtefactWill",
    ['�������� ���� ������ II'] = "ArtefactWill",
    ['�������� ���� ������ III'] = "ArtefactWill",
    ['������ ���������� ��������'] = "ArtefactBoot",
    ['������ ���������� �������� I'] = "ArtefactBoot",
    ['������ ���������� �������� II'] = "ArtefactBoot",
    ['������ ���������� �������� III'] = "ArtefactBoot",
    ['����� ����� ������'] = "ArtefactBook",
    ['����� ����� ������ I'] = "ArtefactBook",
    ['����� ����� ������ II'] = "ArtefactBook",
    ['����� ����� ������ III'] = "ArtefactBook",
    ['���������� ���� ����� ���'] = "ArtefactNefer",
    ['���������� ���� ����� ��� I'] = "ArtefactNefer",
    ['���������� ���� ����� ��� II'] = "ArtefactNefer",
    ['���������� ���� ����� ��� III'] = "ArtefactNefer",
    ['���������� ������ �������'] = "ArtefactShield",
    ['���������� ������ ������� I'] = "ArtefactShield",
    ['���������� ������ ������� II'] = "ArtefactShield",
    ['���������� ������ ������� III'] = "ArtefactShield",
    ['������� ����� ������'] = "ArtefactBrooch",
    ['������� ����� ������ I'] = "ArtefactBrooch",
    ['������� ����� ������ II'] = "ArtefactBrooch",
    ['������� ����� ������ III'] = "ArtefactBrooch",
    ['�������� ������ ����������'] = "ArtefactDagger",
    ['�������� ������ ���������� I'] = "ArtefactDagger",
    ['�������� ������ ���������� II'] = "ArtefactDagger",
    ['�������� ������ ���������� III'] = "ArtefactDagger",
    ['����������� ���� �������'] = "ArtefactCloak",
    ['����������� ���� ������� I'] = "ArtefactCloak",
    ['����������� ���� ������� II'] = "ArtefactCloak",
    ['����������� ���� ������� III'] = "ArtefactCloak",
    ['������������ ��� �����'] = "ArtefactYoke",
    ['������������ ��� ����� I'] = "ArtefactYoke",
    ['������������ ��� ����� II'] = "ArtefactYoke",
    ['������������ ��� ����� III'] = "ArtefactYoke",
    ['��������� ����� �������'] = "ArtefactLoreyley",
    ['��������� ����� ������� I'] = "ArtefactLoreyley",
    ['��������� ����� ������� II'] = "ArtefactLoreyley",
    ['��������� ����� ������� III'] = "ArtefactLoreyley",
    ['��������� ������� �����'] = "ArtefactMayve",
    ['��������� ������� ����� I'] = "ArtefactMayve",
    ['��������� ������� ����� II'] = "ArtefactMayve",
    ['��������� ������� ����� III'] = "ArtefactMayve",
    ['������� ����� ��������'] = "ArtefactStaff",
    ['������� ����� �������� I'] = "ArtefactStaff",
    ['������� ����� �������� II'] = "ArtefactStaff",
    ['������� ����� �������� III'] = "ArtefactStaff",
    ['��������� ������ ��������'] = "ArtefactKadilo",
    ['��������� ������ �������� I'] = "ArtefactKadilo",
    ['��������� ������ �������� II'] = "ArtefactKadilo",
    ['��������� ������ �������� III'] = "ArtefactKadilo",
    ['���������� ������ ��������'] = "ArtefactProspero",
    ['���������� ������ �������� I'] = "ArtefactProspero",
    ['���������� ������ �������� II'] = "ArtefactProspero",
    ['���������� ������ �������� III'] = "ArtefactProspero",
    ['�������� ������� ��������'] = "ArtefactMelusina",
    ['�������� ������� �������� I'] = "ArtefactMelusina",
    ['�������� ������� �������� II'] = "ArtefactMelusina",
    ['�������� ������� �������� III'] = "ArtefactMelusina",
    -- Support Old Clients
    ['������ �����'] = "ArtefactKB",
    ['����� ������'] = "ArtefactKP",
    ['�������� ��������'] = "ArtefactTE",
    ['����� �������'] = "ArtefactAD",
    ['������ ���������'] = "ArtefactKS",
    ['������ �����������'] = "ArtefactGP",
    ['������� �������'] = "ArtefactZS",
    ['������������ ������ �����'] = "ArtefactKBInactive",
    ['������������ ����� ������'] = "ArtefactKPInactive",
    ['������������ �������� ��������'] = "ArtefactTEInactive",
    ['������������ ����� �������'] = "ArtefactADInactive",
    ['������������ ������ ���������'] = "ArtefactKSInactive",
    ['������������ ������ �����������'] = "ArtefactGPInactive",
    ['������������ ������� �������'] = "ArtefactZSInactive",
}

function TableConcat(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

function GetTextureIndex(name)
    if (BANNERS[name] ~= nil) then
        return BANNERS[name]
    elseif (CLOAKS[name] ~= nil) then
        return CLOAKS[name]
    elseif (SCROLLS[name] ~= nil) then
        return SCROLLS[name]
    elseif (STATS_ATC_MAIN[name] ~= nil) then
        return STATS_ATC_MAIN[name]
    elseif (STATS_ATC[name] ~= nil) then
        return STATS_ATC[name]
    elseif (STATS_DEF_MAIN[name] ~= nil) then
        return STATS_DEF_MAIN[name]
    elseif (STATS_DEF[name] ~= nil) then
        return STATS_DEF[name]
    elseif (DO_TRINKETS[name] ~= nil) then
        return DO_TRINKETS[name]
    elseif (TRINKETS[name] ~= nil) then
        return TRINKETS[name]
    elseif (ARTS[name] ~= nil) then
        return ARTS[name]
    else
        return nil
    end
end
