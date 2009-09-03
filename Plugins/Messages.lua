----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BigWigs:New("Messages", "$Revision$")
if not plugin then return end

local sink = LibStub("LibSink-2.0")
sink:Embed(plugin)
sink = nil

------------------------------
--      Are you local?      --
------------------------------

local dew = AceLibrary("Dewdrop-2.0")

local minHeight = 20
local maxHeight = 30
local scaleUpTime = 0.2
local scaleDownTime = 0.4
local labels = {}

local colorModule = nil
local messageFrame = nil
local anchor = nil
local floor = math.floor

----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsMessages")
L:RegisterTranslations("enUS", function() return {
	["Messages"] = true,
	["Options for message display."] = true,

	["BigWigs Anchor"] = true,
	["Output Settings"] = true,

	["Show anchor"] = true,
	["Show the message anchor frame.\n\nNote that the anchor is only usable if you select 'BigWigs' as Output."] = true,

	["Use colors"] = true,
	["Toggles white only messages ignoring coloring."] = true,

	["Scale"] = true,
	["Set the message frame scale."] = true,

	["Use icons"] = true,
	["Show icons next to messages, only works for Raid Warning."] = true,

	["Class colors"] = true,
	["Colors player names in messages by their class."] = true,

	["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = true,
	["White"] = true,

	["Outputs all BigWigs messages to the default chat frame in addition to the display setting."] = true,

	["Chat frame"] = true,

	["Test"] = true,
	["Close"] = true,

	["Reset position"] = true,
	["Reset the anchor position, moving it to the center of your screen."] = true,

	["Spawns a new test warning."] = true,
	["Hide"] = true,
	["Hides the anchors."] = true,

	Font = "Fonts\\FRIZQT__.TTF",
} end)

L:RegisterTranslations("koKR", function() return {
	["Messages"] = "메세지",
	["Options for message display."] = "메세지 표시에 대한 설정입니다.",

	["BigWigs Anchor"] = "BigWigs 메세지 위치",
	["Output Settings"] = "출력 설정",

	["Show anchor"] = "고정 위치 표시",
	["Show the message anchor frame.\n\nNote that the anchor is only usable if you select 'BigWigs' as Output."] = "메세지의 고정 위치를 표시합니다.\n\n'BigWigs'로 출력이 선택되어 있을 때에만 표시합니다.",

	["Use colors"] = "색상 사용",
	["Toggles white only messages ignoring coloring."] = "메세지에 색상 사용을 설정합니다.",

	["Scale"] = "크기",
	["Set the message frame scale."] = "메세지창의 크기를 설정합니다.",

	["Use icons"] = "아이콘 사용",
	["Show icons next to messages, only works for Raid Warning."] = "레이드 경고를 위한, 메세지 옆에 아이콘 표시합니다.",

	["Class colors"] = "직업 색상",
	["Colors player names in messages by their class."] = "메세지의 플레이어 이름에 직업 색상을 사용합니다.",

	["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = "|cffff0000색|cffff00ff상|r",
	["White"] = "흰색",

	["Outputs all BigWigs messages to the default chat frame in addition to the display setting."] = "모든 BigWigs 메세지를 디스플레이 설정에 추가된 기본 대화창에 출력합니다.",

	["Chat frame"] = "대화창",

	["Test"] = "테스트",
	["Close"] = "닫기",

	["Reset position"] = "위치 초기화",
	["Reset the anchor position, moving it to the center of your screen."] = "화면의 중앙으로 고정 위치를 초기화합니다.",

	["Spawns a new test warning."] = "새 테스트 경고를 표시합니다.",
	["Hide"] = "숨김",
	["Hides the anchors."] = "앵커를 숨깁니다.",

	Font = "Fonts\\2002.TTF",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Messages"] = "信息",
	["Options for message display."] = "信息显示选项。",

	["BigWigs Anchor"] = "BigWigs 锚点",
	["Output Settings"] = "输出设置",

	["Show anchor"] = "显示锚点",
	["Show the message anchor frame.\n\nNote that the anchor is only usable if you select 'BigWigs' as Output."] = "显示信息锚点。\n\n只有输出为“BigWigs”时锚点可用。",

	["Use colors"] = "使用彩色信息",
	["Toggles white only messages ignoring coloring."] = "选择是否只发送单色信息。",

	["Scale"] = "缩放",
	["Set the message frame scale."] = "设定信息框体缩放。",

	["Use icons"] = "使用图标",
	["Show icons next to messages, only works for Raid Warning."] = "显示图标，只能使用在团队警告频道。",

	["Class colors"] = "职业颜色",
	["Colors player names in messages by their class."] = "使用职业颜色来染色信息内玩家颜色。",

	["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = "|cffff0000颜|cffff00ff色|r",
	["White"] = "白色",

	["Outputs all BigWigs messages to the default chat frame in addition to the display setting."] = "除了增加显示设置之外，将所有 BigWigs 信息输出到默认聊天框。",

	["Chat frame"] = "聊天框体",

	["Test"] = "测试",
	["Close"] = "关闭",

	["Reset position"] = "重置位置",
	["Reset the anchor position, moving it to the center of your screen."] = "重置锚点位置，移动到屏幕的中间。",

	["Spawns a new test warning."] = "生成一个新的报警测试。",
	["Hide"] = "隐藏",
	["Hides the anchors."] = "隐藏锚点。",

	Font = "Fonts\\ZYKai_T.TTF",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Messages"] = "訊息",
	["Options for message display."] = "訊息框架選項。",

	["BigWigs Anchor"] = "BigWigs 錨點",
	["Output Settings"] = "輸出設定",

	["Show anchor"] = "顯示錨點",
	["Show the message anchor frame.\n\nNote that the anchor is only usable if you select 'BigWigs' as Output."] = "顯示訊息錨點。\n\n只有輸出為“BigWigs”時錨點可用。",

	["Use colors"] = "使用彩色訊息",
	["Toggles white only messages ignoring coloring."] = "切換是否只發送單色訊息。",

	["Scale"] = "縮放",
	["Set the message frame scale."] = "設定訊息框架縮放。",

	["Use icons"] = "使用圖示",
	["Show icons next to messages, only works for Raid Warning."] = "顯示圖示，只能使用在團隊警告頻道。",

	["Class colors"] = "職業顏色",
	["Colors player names in messages by their class."] = "使用職業顏色來染色訊息內玩家顏色。",

	["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = "|cffff0000顏|cffff00ff色|r",
	["White"] = "白色",

	["Outputs all BigWigs messages to the default chat frame in addition to the display setting."] = "除了選擇的顯示位置外，也顯示在聊天頻道上。",

	["Chat frame"] = "聊天框架",

	["Test"] = "測試",
	["Close"] = "關閉",

	["Reset position"] = "重置位置",
	["Reset the anchor position, moving it to the center of your screen."] = "重置錨點位置，將它移至螢幕中央。",

	["Spawns a new test warning."] = "生成一個新的警報測試。",
	["Hide"] = "隱藏",
	["Hides the anchors."] = "隱藏錨點。",

	Font = "Fonts\\bHEI01B.TTF"
} end)

L:RegisterTranslations("deDE", function() return {
	["Messages"] = "Nachrichten",
	["Options for message display."] = "Optionen für die Anzeige von Nachrichten.",

	["BigWigs Anchor"] = "Big Wigs Verankerung",
	["Output Settings"] = "Ausgabeeinstellungen",

	["Show anchor"] = "Verankerung anzeigen",
	["Show the message anchor frame.\n\nNote that the anchor is only usable if you select 'BigWigs' as Output."] = "Die Verankerung des Nachrichtenfensters anzeigen.\n\nDie Verankerung wird nur benutzt, wenn du unter 'Ausgabe' -> 'BigWigs' auswählst.",

	["Use colors"] = "Farben verwenden",
	["Toggles white only messages ignoring coloring."] = "Wählt, ob Nachrichten farbig oder weiß angezeigt werden.",

	["Scale"] = "Skalierung",
	["Set the message frame scale."] = "Legt die Skalierung des Nachrichtenfensters fest.",

	["Use icons"] = "Symbole benutzen",
	["Show icons next to messages, only works for Raid Warning."] = "Zeigt Symbole neben Nachrichten an.",

	["Class colors"] = "Klassenfarben",
	["Colors player names in messages by their class."] = "Färbt Spielernamen in Nachrichten nach deren Klasse ein.",

	["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = "|cffff0000Fa|cffff00ffr|cff00ff00be|r",
	["White"] = "Weiß",

	["Outputs all BigWigs messages to the default chat frame in addition to the display setting."] = "Gibt alle Big Wigs Nachrichten im Standard-Chatfenster aus, zusätzlich zu der Einstellung von 'Ausgabe'.",

	["Chat frame"] = "Chatfenster",

	["Test"] = "Test",
	["Close"] = "Schließen",

	["Reset position"] = "Position zurücksetzen",
	["Reset the anchor position, moving it to the center of your screen."] = "Setzt die Position der Verankerung zur Mitte deines Interfaces zurück.",

	["Spawns a new test warning."] = "Erzeugt eine neue Testnachricht.",
	["Hide"] = "Schließen",
	["Hides the anchors."] = "Versteckt die Verankerung.",

	Font = "Fonts\\FRIZQT__.TTF",
} end)

L:RegisterTranslations("frFR", function() return {
	["Messages"] = "Messages",
	["Options for message display."] = "Options concernant l'affichage des messages.",

	["BigWigs Anchor"] = "Ancre de BigWigs",
	["Output Settings"] = "Paramètres de sortie",

	["Show anchor"] = "Afficher l'ancre",
	["Show the message anchor frame.\n\nNote that the anchor is only usable if you select 'BigWigs' as Output."] = "Affiche l'ancre du cadre des messages.\n\nNotez que l'ancre est uniquement utilisable si vous avez choisi 'BigWigs' comme Sortie.",

	["Use colors"] = "Utiliser des couleurs",
	["Toggles white only messages ignoring coloring."] = "Utilise ou non des couleurs dans les messages à la place du blanc unique.",

	["Scale"] = "Échelle",
	["Set the message frame scale."] = "Détermine l'échelle du cadre des messages.",

	["Use icons"] = "Utiliser les icônes",
	["Show icons next to messages, only works for Raid Warning."] = "Affiche les icônes à côté des messages. Ne fonctionne que sur l'Avertissement raid.",

	["Class colors"] = "Couleurs de classe",
	["Colors player names in messages by their class."] = "Colore le nom des joueurs dans les messages selon leur classe.",

	["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = "|cffff0000Co|cffff00ffule|cff00ff00ur|r",
	["White"] = "Blanc",

	["Outputs all BigWigs messages to the default chat frame in addition to the display setting."] = "Affiche tous les messages de BigWigs dans la fenêtre de discussion par défaut, en plus de son affichage normal.",

	["Chat frame"] = "Fenêtre de discussion",

	["Test"] = "Test",
	["Close"] = "Fermer",

	["Reset position"] = "RÀZ position",
	["Reset the anchor position, moving it to the center of your screen."] = "Réinitialise la position de l'ancre, la replaçant au centre de l'écran.",

	["Spawns a new test warning."] = "Fait apparaître un nouvel avertissement de test.",
	["Hide"] = "Masquer",
	["Hides the anchors."] = "Masque l'ancre.",

	Font = "Fonts\\FRIZQT__.TTF",
} end)

L:RegisterTranslations("esES", function() return {
	["Messages"] = "Mensajes",
	["Options for message display."] = "Opciones para mostrar mensajes.",

	["BigWigs Anchor"] = "Ancla de BigWigs",
	["Output Settings"] = "Parámetros de salida",
	
	["Show anchor"] = "Mostrar ancla",
	["Show the message anchor frame.\n\nNote that the anchor is only usable if you select 'BigWigs' as Output."] = "Mostrar la ventana del ancla de los mensajes.\n\nLa ventana de ancla es utilizable solo si seleccionas BigWigs como salida.",

	["Use colors"] = "Usar colores",
	["Toggles white only messages ignoring coloring."] = "Mostrar solo mensajes en blanco, ignorando colores.",

	["Scale"] = "Escala",
	["Set the message frame scale."] = "Establece la escala del mensaje.",

	["Use icons"] = "Usar iconos",
	["Show icons next to messages, only works for Raid Warning."] = "mostrar iconos al lado de los mensajes. Solo funciona para avisos de banda.",

	["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = "|cffff0000Co|cffff00fflo|cff00ff00r|r",
	["White"] = "Blanco",

	["Outputs all BigWigs messages to the default chat frame in addition to the display setting."] = "Envía también a la ventana de chat por defecto todos los mensaje de BigWigs.",

	["Chat frame"] = "Ventana de chat",

	["Test"] = "Probar",
	["Close"] = "Cerrar",

	["Reset position"] = "Reiniciar posición",
	["Reset the anchor position, moving it to the center of your screen."] = "Reinicia la posición del ancla, moviéndola al centro de la pantalla.",

	Font = "Fonts\\FRIZQT__.TTF",
} end)
-- Translated by wow.playhard.ru translators
L:RegisterTranslations("ruRU", function() return {
	["Messages"] = "Сообщения",
	["Options for message display."] = "Опции отображения сообщений",

	["BigWigs Anchor"] = "Якорь BigWigs",
	["Output Settings"] = "Настройки вывода",

	["Show anchor"] = "Показать якорь",
	["Show the message anchor frame.\n\nNote that the anchor is only usable if you select 'BigWigs' as Output."] = "Отображение якоря сообщений\n\nЗаметьте, что якорь доступен только если вы выбрали 'BigWigs' для вывода сообщений.",

	["Use colors"] = "Использовать цвета",
	["Toggles white only messages ignoring coloring."] = "Не раскрашивать сообщения (белый текст).",

	["Scale"] = "Масштаб",
	["Set the message frame scale."] = "Настройка масштаба фрейма сообщений.",

	["Use icons"] = "Использовать иконки",
	["Show icons next to messages, only works for Raid Warning."] = "Отображать иконки сообщений, работает только для объявлений рейда.",

	["Class colors"] = "Окраска по классу",
	["Colors player names in messages by their class."] = "Окрашивает имя игрока в сообщениях в соответствии с его классом.",

	["|cffff0000Co|cffff00fflo|cff00ff00r|r"] = "|cffff0000Co|cffff00fflo|cff00ff00r|r",
	["White"] = "Белый",

	["Outputs all BigWigs messages to the default chat frame in addition to the display setting."] = "Выводить все сообщения BigWigs в стандартное окно чата в дополнении с настройками отображения",

	["Chat frame"] = "Окно чата",

	["Test"] = "Тест",
	["Close"] = "Закрыть",

	["Reset position"] = "Сброс",
	["Reset the anchor position, moving it to the center of your screen."] = "Сбрасывает позицию якоря, перемещая его в центр вашего экрана.",

	["Spawns a new test warning."] = "Вывод новых тестовых сообщений.",
	["Hide"] = "Скрыть",
	["Hides the anchors."] = "Скрывает якорь.",

	Font = "Fonts\\NIM_____.ttf",
} end)

--------------------------------------------------------------------------------
-- Anchor
--

local function onDragStart(self) self:StartMoving() end
local function onDragStop(self)
	self:StopMovingOrSizing()
    local s = self:GetEffectiveScale()
   	plugin.db.profile.posx = self:GetLeft() * s
	plugin.db.profile.posy = self:GetTop() * s
end

local function onControlEnter(self)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
	GameTooltip:AddLine(self.tooltipHeader)
	GameTooltip:AddLine(self.tooltipText, 1, 1, 1, 1)
	GameTooltip:Show()
end
local function onControlLeave() GameTooltip:Hide() end

local function menu() dew:FeedAceOptionsTable(plugin.consoleOptions) end
local function displayOnMouseDown(self, button)
	if button == "RightButton" then
		dew:Open(self, "children", menu)
	end
end
local createMsgFrame
local function createAnchor()
	anchor = CreateFrame("Frame", "BigWigsMessageAnchor", UIParent)
	anchor:EnableMouse(true)
	anchor:SetMovable(true)
	anchor:RegisterForDrag("LeftButton")
	anchor:SetWidth(120)
	anchor:SetHeight(20)
	anchor:ClearAllPoints()
	local x = plugin.db.profile.posx
	local y = plugin.db.profile.posy
	local s = anchor:GetEffectiveScale()
	if not x or not y then
		anchor:SetPoint("TOP", RaidWarningFrame, "BOTTOM", 0, 45) --Below the Blizzard raid warnings
	else
		anchor:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / s, y / s)
	end
	local bg = anchor:CreateTexture(nil, "PARENT")
	bg:SetAllPoints(anchor)
	bg:SetBlendMode("BLEND")
	bg:SetTexture(0, 0, 0, 0.3)
	local header = anchor:CreateFontString(nil, "OVERLAY")
	header:SetFontObject(GameFontNormal)
	header:SetText(L["Messages"])
	header:SetAllPoints(anchor)
	header:SetJustifyH("CENTER")
	header:SetJustifyV("MIDDLE")
	local test = CreateFrame("Button", nil, anchor)
	test:SetPoint("BOTTOMLEFT", anchor, "BOTTOMLEFT", 3, 3)
	test:SetHeight(14)
	test:SetWidth(14)
	test.tooltipHeader = L["Test"]
	test.tooltipText = L["Spawns a new test warning."]
	test:SetScript("OnEnter", onControlEnter)
	test:SetScript("OnLeave", onControlLeave)
	test:SetScript("OnClick", function() plugin:TriggerEvent("BigWigs_Test") end)
	test:SetNormalTexture("Interface\\AddOns\\BigWigs\\Textures\\icons\\test")
	local close = CreateFrame("Button", nil, anchor)
	close:SetPoint("BOTTOMLEFT", test, "BOTTOMRIGHT", 4, 0)
	close:SetHeight(14)
	close:SetWidth(14)
	close.tooltipHeader = L["Hide"]
	close.tooltipText = L["Hides the anchors."]
	close:SetScript("OnEnter", onControlEnter)
	close:SetScript("OnLeave", onControlLeave)
	close:SetScript("OnClick", function() anchor:Hide() end)
	close:SetNormalTexture("Interface\\AddOns\\BigWigs\\Textures\\icons\\close")
	anchor:SetScript("OnDragStart", onDragStart)
	anchor:SetScript("OnDragStop", onDragStop)
	anchor:SetScript("OnMouseDown", displayOnMouseDown)
	anchor:Hide()
	createMsgFrame()
end

local function resetAnchor()
	if anchor then
		anchor:ClearAllPoints()
		anchor:SetPoint("TOP", RaidWarningFrame, "BOTTOM", 0, 45) --Below the Blizzard raid warnings
	end
	plugin.db.profile.posx = nil
	plugin.db.profile.posy = nil
end

--------------------------------------------------------------------------------
-- Options
--

plugin.defaultDB = {
	sink20OutputSink = "BigWigs",
	usecolors = true,
	scale = 1.0,
	posx = nil,
	posy = -150,
	chat = nil,
	useicons = true,
	classcolor = true,
}
plugin.consoleCmd = L["Messages"]

local function bwAnchorDisabled()
	return plugin.db.profile.sink20OutputSink ~= "BigWigs"
end

plugin.consoleOptions = {
	type = "group",
	name = L["Messages"],
	desc = L["Options for message display."],
	handler = plugin,
	pass = true,
	get = function(key)
		if key == "anchor" then
			return anchor and anchor:IsShown()
		else
			return plugin.db.profile[key]
		end
	end,
	set = function(key, val)
		if key == "anchor" then
			if not anchor then createAnchor() end
			if val then
				anchor:Show()
			else
				anchor:Hide()
			end
		else
			plugin.db.profile[key] = val
		end
	end,
	args = {
		anchor = {
			type = "toggle",
			name = L["Show anchor"],
			desc = L["Show the message anchor frame.\n\nNote that the anchor is only usable if you select 'BigWigs' as Output."],
			disabled = bwAnchorDisabled,
			order = 1,
		},
		reset = {
			type = "execute",
			name = L["Reset position"],
			desc = L["Reset the anchor position, moving it to the center of your screen."],
			func = resetAnchor,
			disabled = bwAnchorDisabled,
			order = 2,
		},
		scale = {
			type = "range",
			name = L["Scale"],
			desc = L["Set the message frame scale."],
			min = 0.2,
			max = 5.0,
			step = 0.1,
			disabled = bwAnchorDisabled,
			order = 3,
		},
		spacer = {
			type = "header",
			name = " ",
			order = 4,
		},
		generalHeader = {
			type = "header",
			name = L["Output Settings"],
			order = 10,
		},
		chat = {
			type = "toggle",
			name = L["Chat frame"],
			desc = L["Outputs all BigWigs messages to the default chat frame in addition to the display setting."],
			order = 101,
		},
		usecolors = {
			type = "toggle",
			name = L["Use colors"],
			desc = L["Toggles white only messages ignoring coloring."],
			map = {[true] = L["|cffff0000Co|cffff00fflo|cff00ff00r|r"], [false] = L["White"]},
			order = 102,
			disabled = function() return not colorModule end,
		},
		classcolor = {
			type = "toggle",
			name = L["Class colors"],
			desc = L["Colors player names in messages by their class."],
			order = 103,
		},
		useicons = {
			type = "toggle",
			name = L["Use icons"],
			desc = L["Show icons next to messages, only works for Raid Warning."],
			order = 104,
		},
	},
}

------------------------------
--      Initialization      --
------------------------------

function plugin:OnRegister()
	self:SetSinkStorage(self.db.profile)

	self:RegisterSink("BigWigs", "BigWigs", nil, "Print")

	self.consoleOptions.args.output = self:GetSinkAce2OptionsDataTable().output
	self.consoleOptions.args.output.order = 100
end

function plugin:OnEnable()
	self:RegisterEvent("BigWigs_Message")

	if BigWigs:HasModule("Colors") then
		colorModule = BigWigs:GetModule("Colors")
	else
		colorModule = nil
	end
end

function plugin:OnDisable() if anchor then anchor:Hide() end end

--------------------------------------------------------------------------------
-- Message frame
--

local function newFontString(i)
	local fs = messageFrame:CreateFontString(nil, "ARTWORK")
	fs:SetFontObject(GameFontNormalHuge)
	fs:SetWidth(800)
	fs:SetHeight(0)
	fs.lastUsed = 0
	FadingFrame_SetFadeInTime(fs, 0.2)
	FadingFrame_SetHoldTime(fs, 10)
	FadingFrame_SetFadeOutTime(fs, 3)
	fs:Hide()
	return fs
end

local function onUpdate(self, elapsed)
	local show = nil
	for i, v in next, labels do
		if v:IsShown() then
			if v.scrollTime then
				v.scrollTime = v.scrollTime + elapsed
				if v.scrollTime <= scaleUpTime then
					v:SetTextHeight(floor(minHeight + ((maxHeight - minHeight) * v.scrollTime / scaleUpTime)))
				elseif v.scrollTime <= scaleDownTime then
					v:SetTextHeight(floor(maxHeight - ((maxHeight - minHeight) * (v.scrollTime - scaleUpTime) / (scaleDownTime - scaleUpTime))))
				else
					v:SetTextHeight(minHeight)
					v.scrollTime = nil
				end
			end
			FadingFrame_OnUpdate(v)
			show = true
		end
	end
	if not show then self:Hide() end
end

function createMsgFrame()
	messageFrame = CreateFrame("Frame", "BWMessageFrame", UIParent)
	messageFrame:SetWidth(512)
	messageFrame:SetHeight(80)
	messageFrame:SetPoint("TOP", anchor, "BOTTOM")
	messageFrame:SetScale(plugin.db.profile.scale or 1)
	messageFrame:SetFrameStrata("HIGH")
	messageFrame:SetToplevel(true)
	messageFrame:SetScript("OnUpdate", onUpdate)
	for i = 1, 4 do
		local fs = newFontString(i)
		table.insert(labels, fs)
		if i == 1 then
			fs:SetPoint("TOP")
		else
			fs:SetPoint("TOP", labels[i - 1], "BOTTOM")
		end
	end
end

------------------------------
--      Event Handlers      --
------------------------------

function plugin:Print(addon, text, r, g, b, _, _, _, _, _, icon)
	if not anchor then createAnchor() end
	if not messageFrame then createMsgFrame() end
	messageFrame:SetScale(self.db.profile.scale)
	messageFrame:Show()
	if icon then text = "|T"..icon..":20:20:-5|t"..text end
	
	-- move 4 -> 1
	local old = labels[4]
	labels[4] = labels[3]
	labels[3] = labels[2]
	labels[2] = labels[1]
	labels[1] = old
	
	-- reposition
	for i = 1, 4 do
		labels[i]:ClearAllPoints()
		if i == 1 then
			labels[i]:SetPoint("TOP")
		else
			labels[i]:SetPoint("TOP", labels[i - 1], "BOTTOM")
		end
	end
	-- new message at 1
	local slot = labels[1]

	slot:SetText(text)
	slot:SetTextColor(r, g, b, 1)
	slot.scrollTime = 0
	slot:SetTextHeight(minHeight)
	FadingFrame_Show(slot)
end

function plugin:BigWigs_Message(text, color, _, sound, broadcastonly, icon)
	if broadcastonly or not text then return end

	local db = self.db.profile
	local r, g, b = 1, 1, 1 -- Default to white.
	if db.usecolors then
		if type(color) == "table" and color.r and color.g and color.b then
			r, g, b = color.r, color.g, color.b
		elseif colorModule and colorModule:HasMessageColor(color) then
			r, g, b = colorModule:MsgColor(color)
		end
	end

	if icon and db.useicons then
		local _, _, gsiIcon = GetSpellInfo(icon)
		icon = gsiIcon or icon
	else
		icon = nil
	end

	self:Pour(text, r, g, b, nil, nil, nil, nil, nil, icon)
	if db.chat then
		BigWigs:CustomPrint(r, g, b, nil, nil, nil, text)
	end
end

