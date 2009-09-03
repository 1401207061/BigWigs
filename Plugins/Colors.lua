﻿----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BigWigs:New("Colors", "$Revision$")
if not plugin then return end

local fmt = string.format

----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsColors")
L:RegisterTranslations("enUS", function() return {
	["Colors"] = true,

	["Messages"] = true,
	["Bars"] = true,
	["Short"] = true,
	["Long"] = true,
	["Short bars"] = true,
	["Long bars"] = true,
	["Color "] = true,
	["Number of colors"] = true,
	["Background"] = true,
	["Text"] = true,
	["Reset"] = true,

	["Bar"] = true,
	["Change the normal bar color."] = true,
	["Emphasized bar"] = true,
	["Change the emphasized bar color."] = true,

	["Colors of messages and bars."] = true,
	["Change the color for %q messages."] = true,
	["Change the %s color."] = true,
	["Change the bar background color."] = true,
	["Change the bar text color."] = true,
	["Resets all colors to defaults."] = true,

	["Important"] = true,
	["Personal"] = true,
	["Urgent"] = true,
	["Attention"] = true,
	["Positive"] = true,
	["Bosskill"] = true,
	["Core"] = true,
	
	upgrade = "Your color values for messages and bars have been reset in order to smooth the upgrade from last version. If you want to tweak them again, right click on Big Wigs and go to Plugins -> Colors.",
} end)

L:RegisterTranslations("koKR", function() return {
	["Colors"] = "색상",

	["Messages"] = "메세지",
	["Bars"] = "바",
	["Short bars"] = "짧은바",
	["Long bars"] = "긴바",
	["Color "] = "색상 ",
	["Number of colors"] = "색상의 수",
	["Background"] = "배경",
	["Text"] = "글자",
	["Reset"] = "초기화",
	
	["Bar"] = "바",
	["Change the normal bar color."] = "기본 바 색상을 변경합니다.",
	["Emphasized bar"] = "강조 바",
	["Change the emphasized bar color."] = "강조 바 색상을 변경합니다.",

	["Colors of messages and bars."] = "메세지와 바의 색상을 설정합니다.",
	["Change the color for %q messages."] = "%q 메세지에 대한 색생을 변경합니다.",
	["Change the %s color."] = "%s의 색상을 변경합니다.",
	["Change the bar background color."] = "배경 색상을 변경합니다.",
	["Change the bar text color."] = "글자 색상을 변경합니다.",
	["Resets all colors to defaults."] = "모든 색상을 기본 설정으로 초기화합니다.",

	["Important"] = "중요",
	["Personal"] = "개인",
	["Urgent"] = "긴급",
	["Attention"] = "주의",
	["Positive"] = "제안",
	["Bosskill"] = "보스사망",
	["Core"] = "코어",
	
	upgrade = "마지막 버전에서부터 새적용 사항을 작동되게 메세지와 바에 대한 색상값이 초기화 되었습니다. 만약 이것을 다시 조절하고 싶다면, Big Wigs 아이콘에 마우스 우-클릭하고 플러그인 -> 색상으로 이동하여 설정하세요.",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Colors"] = "颜色",

	["Messages"] = "信息提示",
	["Bars"] = "计时条",
	["Short"] = "短",
	["Long"] = "长",
	["Short bars"] = "短时间计时条",
	["Long bars"] = "长时间计时条",
	["Color "] = "颜色 ",
	["Number of colors"] = "显示颜色数量",
	["Background"] = "背景",
	["Text"] = "文本",
	["Reset"] = "重置",

	["Bar"] = "计时条",
	["Change the normal bar color."] = "改变一般计时条颜色。",
	["Emphasized bar"] = "醒目计时条",
	["Change the emphasized bar color."] = "改变醒目计时条颜色。",

	["Colors of messages and bars."] = "设置信息文字与计时条的颜色。",
	["Change the color for %q messages."] = "改变%q信息的颜色。",
	["Change the %s color."] = "改变%s颜色。",
	["Change the bar background color."] = "改变计时条背景颜色。",
	["Change the bar text color."] = "改变计时条文本显示颜色",
	["Resets all colors to defaults."] = "重置所有颜色为默认。",

	["Important"] = "重要",
	["Personal"] = "个人",
	["Urgent"] = "紧急",
	["Attention"] = "注意",
	["Positive"] = "醒目",
	["Bosskill"] = "首领击杀",
	["Core"] = "核心",
	
	upgrade = "信息与计时条颜色值已被重置以便升级到最新版本。如果想再次调整，右击 Big Wigs 图标选择插件 -> 颜色。",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Colors"] = "顏色",

	["Messages"] = "訊息",
	["Bars"] = "計時條",
	["Short"] = "短",
	["Long"] = "長",
	["Short bars"] = "短計時條",
	["Long bars"] = "長計時條",
	["Color "] = "顏色 ",
	["Number of colors"] = "顏色數量",
	["Background"] = "背景",
	["Text"] = "文字",
	["Reset"] = "重置",
	
	["Bar"] = "計時條",
	["Change the normal bar color."] = "改變計時條顏色",
	["Emphasized bar"] = "強調條",
	["Change the emphasized bar color."] = "改變強調條顏色.",
	
	["Colors of messages and bars."] = "訊息文字與計時條顏色",
	["Change the color for %q messages."] = "變更 %q 訊息的顏色",
	["Change the %s color."] = "變更顏色 %s。",
	["Change the bar background color."] = "變更背景顏色",
	["Change the bar text color."] = "變更文字顏色",
	["Resets all colors to defaults."] = "全部重置為預設狀態",

	["Important"] = "重要",
	["Personal"] = "個人",
	["Urgent"] = "緊急",
	["Attention"] = "注意",
	["Positive"] = "積極",
	["Bosskill"] = "首領擊殺",
	["Core"] = "核心",
	
	upgrade = "為了更快升級到最新版本,訊息顏色數據和計時條已經重置. 如果你想要再次調整, 右鍵點擊 BigWigs然後移到插件 -> 顏色.",
} end)

L:RegisterTranslations("deDE", function() return {
	["Colors"] = "Farben",

	["Messages"] = "Nachrichten",
	["Bars"] = "Anzeigebalken",
	["Short"] = "Kurz",
	["Long"] = "Lang",
	["Short bars"] = "Kurze Anzeigebalken",
	["Long bars"] = "Lange Anzeigebalken",
	["Color "] =  "Farbe ",
	["Number of colors"] = "Anzahl der Farben",
	["Background"] = "Hintergrund",
	["Text"] = "Text",
	["Reset"] = "Zurücksetzen",


	["Bar"] = "Balken",
	["Change the normal bar color."] = "Ändert die normale Farbe der Anzeigebalken.",
	["Emphasized bar"] = "Betonte Balken",
	["Change the emphasized bar color."] = "Ändert die Farbe der betonten Balken.",

	["Colors of messages and bars."] = "Farben der Nachrichten und Anzeigebalken.",
	["Change the color for %q messages."] = "Ändert die Farbe für %q Nachrichten.",
	["Change the %s color."] = "Ändert die %s Farbe.",
	["Change the bar background color."] = "Ändert die Hintergrundfarbe der Anzeigebalken.",
	["Change the bar text color."] = "Ändert die Textfarbe der Anzeigebalken.",
	["Resets all colors to defaults."] = "Setzt alle Farben auf Standard zurück.",

	["Important"] = "Wichtig",
	["Personal"] = "Persönlich",
	["Urgent"] = "Dringend",
	["Attention"] = "Achtung",
	["Positive"] = "Positiv",
	["Bosskill"] = "Boss besiegt",
	["Core"] = "Kern",

upgrade = "Deine Farben Einstellungen für Nachrichten und Balken wurden zurückgesetzt um Probleme beim Aktualisieren von der letzten version zu vermeiden. Wenn du sie wieder ändern möchtest, rechtsklick auf Big Wigs und geh zu Plugins -> Farben.",
} end)

L:RegisterTranslations("frFR", function() return {
	["Colors"] = "Couleurs",

	["Messages"] = "Messages",
	["Bars"] = "Barres",
	["Short"] = "Court",
	["Long"] = "Long",
	["Short bars"] = "Barres courtes",
	["Long bars"] = "Barres longues",
	["Color "] = "Couleur ",
	["Number of colors"] = "Nombre de couleurs",
	["Background"] = "Arrière-plan",
	["Text"] = "Texte",
	["Reset"] = "RÀZ",

	["Bar"] = "Barre",
	["Change the normal bar color."] = "Change la couleur des barres normales.",
	["Emphasized bar"] = "Barre en évidence",
	["Change the emphasized bar color."] = "Change la couleur des barres mises en évidence.",

	["Colors of messages and bars."] = "Couleurs des messages et des barres.",
	["Change the color for %q messages."] = "Change la couleur des messages %q.",
	["Change the %s color."] = "Change la couleur de %s.",
	["Change the bar background color."] = "Change la couleur de l'arrière-plan.",
	["Change the bar text color."] = "Change la couleur du texte des barres.",
	["Resets all colors to defaults."] = "Réinitialise tous les paramètres à leurs valeurs par défaut.",

	["Important"] = "Important",
	["Personal"] = "Personnel",
	["Urgent"] = "Urgent",
	["Attention"] = "Attention",
	["Positive"] = "Positif",
	["Bosskill"] = "Défaite",
	["Core"] = "Noyau",

	upgrade = "Les valeurs de couleur pour vos messages & barres ont été réinitialisées afin de faciliter la mise à jour à partir de la dernière version. Si vous voulez les modifier à nouveau, faites un clic droit sur Big Wigs et allez dans Plugins -> Couleurs.",
} end)

L:RegisterTranslations("esES", function() return {
	["Colors"] = "Colores",

	["Messages"] = "Mensajes",
	["Bars"] = "Barras",
	["Short"] = "Cortas",
	["Long"] = "Largas",
	["Short bars"] = "Barras cortas",
	["Long bars"] = "Barras largas",
	["Color "] = "Color",
	["Number of colors"] = "Número de colores",
	["Background"] = "Fondo",
	["Text"] = "Texto",
	["Reset"] = "Reiniciar",

	["Bar"] = "Barra",
	["Change the normal bar color."] = "Cambia el color de la barra normal",
	["Emphasized bar"] = "Barra enfatizada",
	["Change the emphasized bar color."] = "Cambia el color de la barra enfatizada",

	["Colors of messages and bars."] = "Color de los mensajes y barras",
	["Change the color for %q messages."] = "Cambia el color para %q mensajes",
	["Change the %s color."] = "Cambia el %s color",
	["Change the bar background color."] = "Cambia el color de fondo de la barra",
	["Change the bar text color."] = "Cambia el color del texto de la barra",
	["Resets all colors to defaults."] = "Reinicia todos los colores a los valores por defecto",

	["Important"] = "Importante",
	["Personal"] = "Personal",
	["Urgent"] = "Urgente",
	["Attention"] = "Atención",
	["Positive"] = "Positivo",
	["Bosskill"] = "Muerte de Jefe",
	["Core"] = "Núcleo",
} end)

-- Translated by wow.playhard.ru translators
L:RegisterTranslations("ruRU", function() return {
	["Colors"] = "Цвета",

	["Messages"] = "Сообщения",
	["Bars"] = "Полосы",
	["Short"] = "Короткие",
	["Long"] = "Длинные",
	["Short bars"] = "Короткие полосы",
	["Long bars"] = "Длинные полосы",
	["Color "] = "Цвет",
	["Number of colors"] = "Число цветов",
	["Background"] = "Фон",
	["Text"] = "Текст",
	["Reset"] = "Сброс",
	
	["Bar"] = "Полосы",
	["Change the normal bar color."] = "Изменение цвета обычных полос.",
	["Emphasized bar"] = "Увеличенные полосы",
	["Change the emphasized bar color."] = "Изменение цвета увеличенных полос.",

	["Colors of messages and bars."] = "Цвета сообщений и полос",
	["Change the color for %q messages."] = "Изменить цвет %q сообщений",
	["Change the %s color."] = "Изменить цвет %s",
	["Change the bar background color."] = "Изменить цвет фона полосы",
	["Change the bar text color."] = "Изменить цвет текста полосы",
	["Resets all colors to defaults."] = "Сброс всех цветов на стандартные значения",

	["Important"] = "Важные",
	["Personal"] = "Личные",
	["Urgent"] = "Экстренные",
	["Attention"] = "Внимание",
	["Positive"] = "Позитивные",
	["Bosskill"] = "Убийство Босса",
	["Core"] = "Ядро",
	
	upgrade = "Ваши установленные цвета для сообщений и полос, были сброшены в целях упрощения обновления последней версии. Если вы хотите настроить их снова, щелкните правой кнопкой мыши по Big Wigs и перейдите в Плагины -> Цвета.",
} end)

--------------------------------------------------------------------------------
-- Options
--

plugin.defaultDB = {
	Important = { 1, 0.2, 0.2 }, -- Red
	Personal = { 0.2, 0.4, 1 }, -- Blue
	Urgent = { 1, 0.5, 0.1 }, -- Orange
	Attention = { 1, 1, 0.1 }, -- Yellow
	Positive = { 0.2, 1, 0.2 }, -- Green
	Bosskill = { 0.2, 1, 0.2 }, -- Green
	Core = { 0.2, 1, 1 }, -- Cyan

	barBackground = { 0.5, 0.5, 0.5, 0.3 },
	barText = { 1, 1, 1 },
	barColor = { 0.25, 0.33, 0.68, 1 },
	barEmphasized = { 1, 0, 0, 1 },
}

local function get(key)
	if not key or key == "reset" then return end -- Work around AceConsole-2.0 problem.
	return unpack(plugin.db.profile[key])
end
local function set(key, r, g, b, a) plugin.db.profile[key] = {r, g, b, a} end

plugin.consoleCmd = L["Colors"]
plugin.consoleOptions = {
	type = "group",
	name = L["Colors"],
	desc = L["Colors of messages and bars."],
	handler = plugin,
	pass = true,
	get = get,
	set = set,
	args = {
		messages = {
			type = "header",
			name = L["Messages"],
			order = 1,
		},
		Important = {
			name = L["Important"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Important"]),
			order = 2,
		},
		Personal = {
			name = L["Personal"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Personal"]),
			order = 3,
		},
		Urgent = {
			name = L["Urgent"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Urgent"]),
			order = 4,
		},
		Attention = {
			name = L["Attention"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Attention"]),
			order = 5,
		},
		Positive = {
			name = L["Positive"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Positive"]),
			order = 6,
		},
		Bosskill = {
			name = L["Bosskill"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Bosskill"]),
			order = 7,
		},
		Core = {
			name = L["Core"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Core"]),
			order = 8,
		},
		spacer1 = { type = "header", name = " ", order = 9, },
		bars = {
			type = "header",
			name = L["Bars"],
			order = 10,
		},
		barColor = {
			name = L["Bar"],
			type = "color",
			desc = L["Change the normal bar color."],
			hasAlpha = true,
			order = 11,
		},
		barEmphasized = {
			name = L["Emphasized bar"],
			type = "color",
			desc = L["Change the emphasized bar color."],
			hasAlpha = true,
			order = 11,
		},
		barBackground = {
			name = L["Background"],
			type = "color",
			desc = L["Change the bar background color."],
			hasAlpha = true,
			order = 13,
		},
		barText = {
			name = L["Text"],
			type = "color",
			desc = L["Change the bar text color."],
			order = 14,
		},
		spacer2 = { type = "header", name = " ", order = 15, },
		reset = {
			type = "execute",
			name = L["Reset"],
			desc = L["Resets all colors to defaults."],
			func = "ResetDB",
			order = 16,
		},
	},
}

function plugin:OnEnable()
	if not self.db.profile.upgraded then
		self:ResetDB()
		self.db.profile.upgraded = 1
		BigWigs:Print(L["upgrade"])
	end
end

local function copyTable(to, from)
	setmetatable(to, nil)
	for k,v in pairs(from) do
		if type(k) == "table" then
			k = copyTable({}, k)
		end
		if type(v) == "table" then
			v = copyTable({}, v)
		end
		to[k] = v
	end
	setmetatable(to, from)
	return to
end

function plugin:ResetDB()
	copyTable(self.db.profile, self.defaultDB)
end

function plugin:HasMessageColor(hint)
	return self.db.profile[hint] and true or nil
end

function plugin:MsgColor(hint)
	local t = self.db.profile[hint]
	if t then
		return unpack(t)
	else
		return 1, 1, 1
	end
end

