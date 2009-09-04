﻿--------------------------------------------------------------------------------
-- Module Declaration
--
local boss = BB["Anub'arak"]
local mod = BigWigs:New(boss, "$Revision$")
if not mod then return end
mod.zonename = BZ["Trial of the Crusader"]
mod.enabletrigger = boss
mod.guid = 34564
mod.toggleOptions = {"bosskill", "burrow", "pursue", "phase"}
mod.consoleCmd = "Anubarak"

--------------------------------------------------------------------------------
-- Locals
--

local db
local phase

--------------------------------------------------------------------------------
-- Localization
--

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
L:RegisterTranslations("enUS", function() return {
	engage = "Engage",
	engage_trigger = "This place will serve as your tomb!",

	phase = "Phase",
	phase_desc = "Warn on phase transitions",
	phase_message = "Phase 2!",

	burrow = "Burrow",
	burrow_desc = "Show a timer for Anub'Arak's Burrow ability",
	burrow_emote = "FIXME",
	burrow_message = "Burrow",
	burrow_cooldown = "Next Burrow",

	pursue = "Pursue",
	pursue_desc = "Show who Anub'Arak is pursuing",
	pursue_message = "Pursuing YOU!",
	pursue_other = "Pursuing %s",

} end)
L:RegisterTranslations("koKR", function() return {
	engage = "전투 시작",
	engage_trigger = "여기가 네 무덤이 되리라!",	--check

	phase = "단계",
	phase_desc = "단계 변화를 알립니다.",
	phase_message = "2 단계!",

	burrow = "소멸",
	burrow_desc = "아눕아락의 소멸 기술에 대하여 타이머등으로 알립니다.",
	burrow_emote = "FIXME",	--check
	burrow_message = "소멸!",
	burrow_cooldown = "다음 소멸",

	pursue = "추격",
	pursue_desc = "누가 아눕아락의 추격인지 알립니다.",
	pursue_message = "당신을 추격중!",
	pursue_other = "추격: %s",
} end)
L:RegisterTranslations("frFR", function() return {
	engage = "Engagement",
	engage_trigger = "Ce terreau sera votre tombeau !", -- à vérifier

	phase = "Phase",
	phase_desc = "Prévient quand la rencontre entre dans une nouvelle phase.",
	phase_message = "Phase 2 !",

	burrow = "Fouir",
	burrow_desc = "Affiche un délai de la technique Fouir d'Anub'Arak.",
	--burrow_emote = "FIXME",
	burrow_message = "Fouir",
	burrow_cooldown = "Prochain Fouir",

	pursue = "Poursuite",
	pursue_desc = "Indique qui Anub'Arak est entrain de poursuivre.",
	pursue_message = "VOUS êtes poursuivi(e) !",
	pursue_other = "Pursuivi(e) : %s",
} end)
L:RegisterTranslations("deDE", function() return {
	engage = "Angegriffen",
	engage_trigger = "^Dieser Ort wird Euch als Grab dienen!",

	phase = "Phasen",
	phase_desc = "Warnt vor Phasenwechsel.",
	phase_message = "Phase 2!",

	burrow = "Verbergen",
	burrow_desc = "Zeige einen Timer für Anub'arak's Eingraben.",
	burrow_emote = "^Erhebt Euch, Diener",
	burrow_message = "Eingraben",
	burrow_cooldown = "~Eingraben",

	pursue = "Verfolgen",
	pursue_desc = "Zeigt, wen Anub'arak verfolgt.",
	pursue_message = "DU wirst verfolgt!",
	pursue_other = "%s wird verfolgt!",
} end)
L:RegisterTranslations("zhCN", function() return {
	engage = "激活",
--	engage_trigger = "This place will serve as your tomb!",

	phase = "阶段",
	phase_desc = "当阶段改变时发出警报。",
	phase_message = "第二阶段！",

	burrow = "钻地",
	burrow_desc = "当阿努巴拉克钻地时显示计时条。",
	burrow_emote = "FIXME",
	burrow_message = "钻地",
	burrow_cooldown = "下一钻地",

	pursue = "追击",
	pursue_desc = "当玩家被阿努巴拉克追击时发出警报。",
	pursue_message = ">你< 追击！",
	pursue_other = "追击：>%s<！",
} end)
L:RegisterTranslations("zhTW", function() return {
	engage = "開戰",
	engage_trigger = "這裡將會是你們的墳墓!",

	phase = "階段",
	phase_desc = "當階段改變發出警報。",
	phase_message = "第二階段！",

	burrow = "鑽地",
	burrow_desc = "當阿努巴拉克鑽地時顯示計時條。",
	burrow_emote = "FIXME",
	burrow_message = "鑽地",
	burrow_cooldown = "下一鑽地",

	pursue = "追擊",
	pursue_desc = "當玩家被阿努巴拉克追擊時發出警報。",
	pursue_message = ">你< 追擊！",
	pursue_other = "追擊：>%s<！",
} end)
L:RegisterTranslations("ruRU", function() return {
} end)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:AddCombatListener("SPELL_AURA_APPLIED", "Pursue", 67574)
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	db = self.db.profile
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Pursue(unit)
	if db.pursue then
		if unit == "player" then
			self:IfMessage(L["pursue_message"], "Important")
		else
			self:IfMessage(L["pursue_other"], "Attention")
		end
	end
end

function mod:UNIT_HEALTH(unit)
	if db.phase then
		if UnitName(unit) == boss then
			if UnitHealth(unit) < 30 and phase ~= 2 then
				self:IfMessage(L["phase_message"], "Positive")
			elseif phase ==2 then
				phase = 1
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L["engage_trigger"]) then
		phase = 1
		if db.burrow then
			--self:Bar(L["burrow_cooldown"], 90, 67322)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if db.burrow then
		if msg:find(L["burrow_emote"]) then
			--self:IfMessage(L["burrow"])	
			--self:Bar(L["burrow"], 30, 67322)
			--self:Bar(L["burrow_cooldown"], 90, 67322)
		end
	end
end
