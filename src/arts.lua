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
    ["Знамя Воеводы"] = "BannerRed",
    ["Знамя Хранителя"] = "BannerBlue",
    ["Знамя Тактика"] = "BannerGreen",
}

CLOAKS = {
    ["Гильдейская накидка"] = "GuildCloak",
    ["Чемпионская накидка"] = "ChampCloak",
    ["Знамя Воеводы"] = "BannerRed",
    ["Знамя Хранителя"] = "BannerBlue",
    ["Знамя Тактика"] = "BannerGreen",
}

SCROLLS = {
    ["Орнамент Заступника"] = "Uncommon",
    ["Орнамент Разрушителя"] = "Rare",
    ["Орнамент Тайной Силы"] = "Epic",
    ["Орнамент Героя"] = "Legendary",
    ["Орнамент Странника"] = "Relic",
}

STATS_ORDER = {
    ['Мастерство'] = 1,
    ['Решимость'] = 2,
    ['Беспощадность'] = 3,
    ['Господство'] = 4,
    ['Удача'] = 5,
    ['Ярость'] = 6,
    ['Упорство'] = 7,
    ['Стремительность'] = 8,
    ['Стойкость'] = 9,
    ['Воля'] = 10,
    ['Кровожадность'] = 11,
    ['Живучесть'] = 12,
    ['Инстинкт'] = 13,
    ['Осторожность'] = 14,
    ['Незыблемость'] = 15,
    ['ritual'] = 16,
    ['power'] = 17,
    ['stamina'] = 18,
}

STATS_ATC_MAIN = {
    ['Мастерство'] = "StatMastery",
    ['Решимость'] = "StatResolution",
    ['Беспощадность'] = "StatFinisher",
}

STATS_ATC = {
    ['Господство'] = "StatGosp",
    ['Удача'] = "StatLuck",
    ['Ярость'] = "StatRage",
    ['Упорство'] = "StatStun",
    ['Стремительность'] = "StatFastCast",
}

STATS_DEF_MAIN = {
    ['Стойкость'] = "StatStamina",
    ['Воля'] = "StatWill",
    ['Кровожадность'] = "StatLifesteal",
}

STATS_DEF = {
    ['Живучесть'] = "StatVitality",
    ['Инстинкт'] = "StatAntiCrit",
    ['Осторожность'] = "StatCaution",
    ['Незыблемость'] = "StatAntiStun",
}

ARTS_POWER = {
    ['Наследие Богов'] = true
}

DO_TRINKETS = {
    ['Ненасытный Шип'] = "BloodyThorn",
    ['Память Света'] = "AltarOfLight",
    ['Амулет Всех Стихий'] = "TrinketDragonAmulet",
}

TRINKETS = {
    ['Эмблема Резни'] = "TrinketUncom",
    ['Эмблема Разрушения'] = "TrinketRare",
    ['Эмблема Истребления'] = "TrinketEpic",
    ['Эмблема Кровавой Жатвы'] = "TrinketLegendary",
    ['Эмблема Безумия'] = "TrinketRelic",

    ['Эмблема Резни с орнаментом'] = "TrinketUncom",
    ['Эмблема Разрушения с орнаментом'] = "TrinketRare",
    ['Эмблема Истребления с орнаментом'] = "TrinketEpic",
    ['Эмблема Кровавой Жатвы с орнаментом'] = "TrinketLegendary",
    ['Эмблема Безумия с орнаментом'] = "TrinketRelic",
}

ARTS = {
    ['Наследие Богов'] = "ArtefactGodsLegacy",
    ['Неотвратимый Хлыст Немейны'] = "ArtefactWhip",
    ['Неотвратимый Хлыст Немейны I'] = "ArtefactWhip",
    ['Неотвратимый Хлыст Немейны II'] = "ArtefactWhip",
    ['Неотвратимый Хлыст Немейны III'] = "ArtefactWhip",
    ['Убийственная Стрела Канаана'] = "ArtefactArrow",
    ['Убийственная Стрела Канаана I'] = "ArtefactArrow",
    ['Убийственная Стрела Канаана II'] = "ArtefactArrow",
    ['Убийственная Стрела Канаана III'] = "ArtefactArrow",
    ['Чаша Гнева Незеба'] = "ArtefactCup",
    ['Чаша Гнева Незеба I'] = "ArtefactCup",
    ['Чаша Гнева Незеба II'] = "ArtefactCup",
    ['Чаша Гнева Незеба III'] = "ArtefactCup",
    ['Талисман Воли Яскера'] = "ArtefactWill",
    ['Талисман Воли Яскера I'] = "ArtefactWill",
    ['Талисман Воли Яскера II'] = "ArtefactWill",
    ['Талисман Воли Яскера III'] = "ArtefactWill",
    ['Сапоги Странствий Эллекена'] = "ArtefactBoot",
    ['Сапоги Странствий Эллекена I'] = "ArtefactBoot",
    ['Сапоги Странствий Эллекена II'] = "ArtefactBoot",
    ['Сапоги Странствий Эллекена III'] = "ArtefactBoot",
    ['Книга Жизни Найана'] = "ArtefactBook",
    ['Книга Жизни Найана I'] = "ArtefactBook",
    ['Книга Жизни Найана II'] = "ArtefactBook",
    ['Книга Жизни Найана III'] = "ArtefactBook",
    ['Нефритовый Жезл Нефер Ура'] = "ArtefactNefer",
    ['Нефритовый Жезл Нефер Ура I'] = "ArtefactNefer",
    ['Нефритовый Жезл Нефер Ура II'] = "ArtefactNefer",
    ['Нефритовый Жезл Нефер Ура III'] = "ArtefactNefer",
    ['Сапфировая Кираса Оберона'] = "ArtefactShield",
    ['Сапфировая Кираса Оберона I'] = "ArtefactShield",
    ['Сапфировая Кираса Оберона II'] = "ArtefactShield",
    ['Сапфировая Кираса Оберона III'] = "ArtefactShield",
    ['Звёздная Брошь Смеяны'] = "ArtefactBrooch",
    ['Звёздная Брошь Смеяны I'] = "ArtefactBrooch",
    ['Звёздная Брошь Смеяны II'] = "ArtefactBrooch",
    ['Звёздная Брошь Смеяны III'] = "ArtefactBrooch",
    ['Кровавый Клинок Гурлухсора'] = "ArtefactDagger",
    ['Кровавый Клинок Гурлухсора I'] = "ArtefactDagger",
    ['Кровавый Клинок Гурлухсора II'] = "ArtefactDagger",
    ['Кровавый Клинок Гурлухсора III'] = "ArtefactDagger",
    ['Оберегающий Плащ Тенсеса'] = "ArtefactCloak",
    ['Оберегающий Плащ Тенсеса I'] = "ArtefactCloak",
    ['Оберегающий Плащ Тенсеса II'] = "ArtefactCloak",
    ['Оберегающий Плащ Тенсеса III'] = "ArtefactCloak",
    ['Спасительный Щит Йокке'] = "ArtefactYoke",
    ['Спасительный Щит Йокке I'] = "ArtefactYoke",
    ['Спасительный Щит Йокке II'] = "ArtefactYoke",
    ['Спасительный Щит Йокке III'] = "ArtefactYoke",
    ['Очищающая Песнь Лорелеи'] = "ArtefactLoreyley",
    ['Очищающая Песнь Лорелеи I'] = "ArtefactLoreyley",
    ['Очищающая Песнь Лорелеи II'] = "ArtefactLoreyley",
    ['Очищающая Песнь Лорелеи III'] = "ArtefactLoreyley",
    ['Волшебная Фигурка Мэйвэ'] = "ArtefactMayve",
    ['Волшебная Фигурка Мэйвэ I'] = "ArtefactMayve",
    ['Волшебная Фигурка Мэйвэ II'] = "ArtefactMayve",
    ['Волшебная Фигурка Мэйвэ III'] = "ArtefactMayve",
    ['Сияющий Посох Скракана'] = "ArtefactStaff",
    ['Сияющий Посох Скракана I'] = "ArtefactStaff",
    ['Сияющий Посох Скракана II'] = "ArtefactStaff",
    ['Сияющий Посох Скракана III'] = "ArtefactStaff",
    ['Священный Ковчег Айденуса'] = "ArtefactKadilo",
    ['Священный Ковчег Айденуса I'] = "ArtefactKadilo",
    ['Священный Ковчег Айденуса II'] = "ArtefactKadilo",
    ['Священный Ковчег Айденуса III'] = "ArtefactKadilo",
    ['Абсолютный Барьер Просперо'] = "ArtefactProspero",
    ['Абсолютный Барьер Просперо I'] = "ArtefactProspero",
    ['Абсолютный Барьер Просперо II'] = "ArtefactProspero",
    ['Абсолютный Барьер Просперо III'] = "ArtefactProspero",
    ['Алмазное Зерцало Мелюзины'] = "ArtefactMelusina",
    ['Алмазное Зерцало Мелюзины I'] = "ArtefactMelusina",
    ['Алмазное Зерцало Мелюзины II'] = "ArtefactMelusina",
    ['Алмазное Зерцало Мелюзины III'] = "ArtefactMelusina",
    -- Support Old Clients
    ['Кодекс Бытия'] = "ArtefactKB",
    ['Крест Победы'] = "ArtefactKP",
    ['Трикветр Единства'] = "ArtefactTE",
    ['Аспис Дракона'] = "ArtefactAD",
    ['Корона Скитальца'] = "ArtefactKS",
    ['Грааль Пробуждения'] = "ArtefactGP",
    ['Зерцало Свободы'] = "ArtefactZS",
    ['Потускневший Кодекс Бытия'] = "ArtefactKBInactive",
    ['Потускневший Крест Победы'] = "ArtefactKPInactive",
    ['Потускневший Трикветр Единства'] = "ArtefactTEInactive",
    ['Потускневший Аспис Дракона'] = "ArtefactADInactive",
    ['Потускневшая Корона Скитальца'] = "ArtefactKSInactive",
    ['Потускневший Грааль Пробуждения'] = "ArtefactGPInactive",
    ['Потускневшее Зерцало Свободы'] = "ArtefactZSInactive",
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
