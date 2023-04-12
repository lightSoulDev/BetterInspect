Global("LOCALES", {})

-- ger
-- fra
-- tr

LOCALES = {
    ["rus"] = {
        ["DMG_FALL"] = "Падение",
        ["DMG_BARRIER"] = "Из барьера",

        ["ButtonAccept"] = "Принять",
        ["ButtonRestore"] = "Сбросить",
        ["ButtonAdd"] = "Добавить",
        ["ButtonDelete"] = "Удалить",

        ["TAB_Common"] = "Основные",
        ["TAB_Buffs"] = "Баффы",
        ["TAB_Casts"] = "Касты",
        ["TAB_Units"] = "Юниты",
        ["TAB_Colors"] = "Цвета",

        ["GROUP_Bars"] = "Настройки панелей",
        ["SETTING_MaxBars"] = "Максимально количество панелей",
        ["SETTING_BarsWidth"] = "Ширина панелей",
        ["SETTING_BarsHeight"] = "Высота панелей",
        ["SETTING_ShowBuffCaster"] = "Показывать кастера баффа",
        ["SETTING_ShowCastTarget"] = "Показывать цель каста моба",
        ["SETTING_SeparateBuffs"] = "Отображать баффы на отдельной панели",
        ["GROUP_Interaction"] = "Интерактивность",
        ["SETTING_IsClickable"] = "Кликабельность",
        ["SETTING_EnableRightClick"] = "Выделение цели каста / кастера правой кнопкой мышки",
        ["GROUP_BuffsSettings"] = "Баффы",
        ["BuffsModeDisableInfo"] = "Отключить фильтр",
        ["BuffsModeHideOnlyInfo"] = "Показывать всё кроме баффов из списка",
        ["BuffsModeShowOnlyInfo"] = "Показывать только баффы из списка",
        ["GROUP_CastsSettings"] = "Касты",
        ["CastsModeDisableInfo"] = "Отключить фильтр",
        ["CastsModeHideOnlyInfo"] = "Показывать всё кроме кастов из списка",
        ["CastsModeShowOnlyInfo"] = "Показывать только касты из списка",
        ["GROUP_UnitsSettings"] = "Юниты",
        ["UnitsModeDisableInfo"] = "Отключить фильтр",
        ["UnitsModeHideOnlyInfo"] = "Показывать всё кроме юнитов из списка",
        ["UnitsModeShowOnlyInfo"] = "Показывать только юниты из списка",
        ["ShowOnly"] = "Показывать",
        ["HideOnly"] = "Игнорировать",
        ["Disable"] = "Отключить",
        ["SETTING_AddBuff"] = "Добавить (имя/маска)",
        ["SETTING_AddCast"] = "Добавить (название)",
        ["SETTING_AddUnit"] = "Добавить (имя)",
        ["SETTING_Mode"] = "Режим работы фильтра",

        ["GROUP_MyBuffColor"] = "Цвет моего баффа",
        ["GROUP_EnemyBuffColor"] = "Цвет вражеского баффа",
        ["GROUP_OtherBuffColor"] = "Цвет баффа других игроков",
        ["GROUP_MobCastColor"] = "Обычный цвет каста моба",
        ["GROUP_MobCastAtMeColor"] = "Цвет каста моба если цель - я",
        ["SETTING_r"] = "Красный канал",
        ["SETTING_g"] = "Зеленый канал",
        ["SETTING_b"] = "Синий канал",
        ["SETTING_a"] = "Альфа канал",
        ["ColorPreview"] = "Предпросмотр цвета",
        ["SETTING_AddRecommended"] = "Добавить рекомендуемое для выбранного режима",
        ["CB_self"] = "Я",
        ["CB_enemyPlayer"] = "Вр. Игр",
        ["CB_enemyMob"] = "Вр. Моб",
        ["CB_raidgroup"] = "Пати",
        ["CB_friendlyPlayer"] = "Др. Игр",
        ["CB_friendlyMob"] = "Др. Моб",
    },
    ["eng_eu"] = {
        ["DMG_FALL"] = "Fall",
        ["DMG_BARRIER"] = "From barrier",
        ["ButtonAccept"] = "Accept",
        ["ButtonRestore"] = "Restore",
        ["ButtonAdd"] = "Add",
        ["ButtonDelete"] = "Delete",

        ["TAB_Common"] = "Common",
        ["TAB_Visual"] = "Colors",
        ["TAB_Ignored"] = "Ignore",

        ["GROUP_PanelSettings"] = "Panel settings",
        ["SETTING_IsClickable"] = "Enable clicking",
    }
}

LOCALES["eng"] = LOCALES["eng_eu"]
