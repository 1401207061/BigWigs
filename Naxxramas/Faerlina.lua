----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Grand Widow Faerlina"]
local mod = BigWigs:New(boss, "$Revision$")
if not mod then return end
mod.zonename = BZ["Naxxramas"]
mod.enabletrigger = boss
mod.guid = 15953
mod.toggleOptions = {28732, 28794, "enrage", "bosskill"}
mod.consoleCmd = "Faerlina"

------------------------------
--      Are you local?      --
------------------------------

local started = nil
local enraged = nil
local enrageName = GetSpellInfo(28798)
local enrageMessageId = nil
local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
L:RegisterTranslations("enUS", function() return {
	starttrigger1 = "Kneel before me, worm!",
	starttrigger2 = "Slay them in the master's name!",
	starttrigger3 = "You cannot hide from me!",
	starttrigger4 = "Run while you still can!",

	startwarn = "Faerlina engaged, 60 sec to frenzy!",
	enragewarn15sec = "15 sec to frenzy!",
	enragewarn = "Frenzied!",
	enragewarn2 = "Frenzied Soon!",
	enrageremovewarn = "Frenzy removed! ~60 sec until next!",

	silencewarn = "Silenced!",
	silencewarn5sec = "Silence ends in 5 sec",
	silencebar = "Silence",

	rain_message = "Fire on YOU!",
} end )

L:RegisterTranslations("ruRU", function() return {
	starttrigger1 = "Склонитесь передо мной, черви!",  
	starttrigger2 = "Убейте их во имя господина!",  
	starttrigger3 = "Вам не скрыться от меня!",  
	starttrigger4 = "Бегите, пока еще можете!",  

	startwarn = "Великая вдова Фарлина вступает в бой, 60 секунд до бешенства!",
	enragewarn15sec = "15 секунд до Бешенства!",
	enragewarn = "Бешенство!",
	enragewarn2 = "Скоро бешенство!",
	enrageremovewarn = "Бешенство снято! ~60 секунд до следующего!",

	silencewarn = "Безмолвие! Задержка ярости!",
	silencewarn5sec = "Безмолвие закончится через 5 секунд",
	silencebar = "Безмолвие",

	rain_message = "Огненный ливень на ВАС!",
} end )

L:RegisterTranslations("deDE", function() return {
	starttrigger1 = "Kniet nieder, Wurm!",
	starttrigger2 = "Tötet sie im Namen des Meisters!",
	starttrigger3 = "Ihr könnt euch nicht vor mir verstecken!",
	starttrigger4 = "Flieht, solange ihr noch könnt.",

	startwarn = "Großwitwe Faerlina angegriffen! Raserei in 60 sek!",
	enragewarn15sec = "Raserei in 15 sek!",
	enragewarn = "Raserei!",
	enragewarn2 = "Raserei bald!",
	enrageremovewarn = "Raserei vorbei! Nächste in ~60 sek!",
	
	silencewarn = "Stille! Raserei verzögert!",
	silencewarn5sec = "Stille endet in 5 sek!",
	silencebar = "Stille",

	rain_message = "Feuerregen auf DIR!",
} end )

L:RegisterTranslations("koKR", function() return {
	starttrigger1 = "내 앞에 무릎을 꿇어라, 벌레들아!",
	starttrigger2 = "주인님의 이름으로 처단하라!",
	starttrigger3 = "나에게서 도망칠 수는 없다!",
	starttrigger4 = "두 발이 성할 때 도망쳐라!",

	startwarn = "귀부인 팰리나 전투 시작! 60초 후 광기!",
	enragewarn15sec = "15초 후 광기!",
	enragewarn = "광기!",
	enragewarn2 = "잠시 후 광기!",
	enrageremovewarn = "광기 사라짐! 약 60초 후 다음 광기",

	silencewarn = "침묵!",
	silencewarn5sec = "5초 후 침묵 종료!",
	silencebar = "침묵",

	rain_message = "당신은 불의 비!",
} end )

L:RegisterTranslations("zhCN", function() return {
	starttrigger1 = "跪下求饶吧，懦夫！",
	starttrigger2 = "以主人之名，杀了他们！",
	starttrigger3 = "休想从我面前逃掉！",
	starttrigger4 = "逃啊！有本事就逃啊！",

	startwarn = "黑女巫法琳娜已激活 - 60秒后，激怒！",
	enragewarn15sec = "15秒后，激怒！",
	enragewarn = "激怒！",
	enragewarn2 = "即将 激怒！",
	enrageremovewarn = "激怒已移除 - 约60后，激怒！",
	silencewarn = "沉默！延缓了激怒！",
	silencewarn5sec = "5秒后沉默结束！",

	silencebar = "<沉默>",

	rain_message = ">你< 火焰之雨！",
} end )

L:RegisterTranslations("zhTW", function() return {
	starttrigger1 = "跪下求饒吧，懦夫!",
	starttrigger2 = "以主人之名，殺了他們!",
	starttrigger3 = "休想從我面前逃掉!",
	starttrigger4 = "逃啊!有本事就逃啊!",

	startwarn = "大寡婦費琳娜已進入戰鬥 - 60秒後，狂怒！",
	enragewarn15sec = "15秒後，狂怒！",
	enragewarn = "狂怒！",
	enragewarn2 = "即將 狂怒！",
	enrageremovewarn = "狂怒已移除 - 約60秒後，狂怒！",
	silencewarn = "沉默！延緩了狂怒！",
	silencewarn5sec = "5秒後沉默結束！",

	silencebar = "<沉默>",

	rain_message = ">你< 火焰之雨！",
} end )

L:RegisterTranslations("frFR", function() return {
	starttrigger1 = "À genoux, vermisseau !",
	starttrigger2 = "Tuez-les au nom du maître !",
	starttrigger3 = "Vous ne pouvez pas m'échapper !",
	starttrigger4 = "Fuyez tant que vous le pouvez !",

	startwarn = "Grande veuve Faerlina engagée, 60 sec. avant Frénésie !",
	enragewarn15sec = "15 sec. avant Frénésie !",
	enragewarn = "Frénésie !",
	enragewarn2 = "Frénésie imminente !",
	enrageremovewarn = "Frénésie enlevée ! ~60 sec. avant la suivante !",

	silencewarn = "Réduite au silence !",
	silencewarn5sec = "Fin du silence dans 5 sec.",
	silencebar = "Silence",

	rain_message = "Pluie de feu sur VOUS !",
} end )

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Silence", 28732, 54097)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Rain", 28794, 54099)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Enrage", 28798, 54100) --Norm/Heroic
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	started = nil
	enrageMessageId = nil

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Silence(unit, spellId)
	if not UnitIsUnit(unit, boss) then return end
	if not enraged then
		-- preemptive, 30s silence
		self:IfMessage(L["silencewarn"], "Positive", spellId)
		self:Bar(L["silencebar"], 30, spellId)
		self:DelayedMessage(25, L["silencewarn5sec"], "Urgent")
	else
		-- Reactive enrage removed
		if self.db.profile.enrage then
			self:Message(L["enrageremovewarn"], "Positive")
			enrageMessageId = self:DelayedMessage(45, L["enragewarn2"], "Important")
			self:Bar(enrageName, 60, 28798)
		end
		self:Bar(L["silencebar"], 30, spellId)
		self:DelayedMessage(25, L["silencewarn5sec"], "Urgent")
		enraged = nil
	end
end

function mod:Rain(player)
	if player == pName then
		self:LocalMessage(L["rain_message"], "Personal", 54099, "Alarm")
	end
end

function mod:Enrage(unit, spellId, _, _, spellName)
	if not UnitIsUnit(unit, boss) then return end
	if self.db.profile.enrage then
		self:IfMessage(L["enragewarn"], "Urgent", spellId)
	end
	self:TriggerEvent("BigWigs_StopBar", self, enrageName)
	if enrageMessageId then
		self:CancelScheduledEvent(enrageMessageId)
	end
	enraged = true
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if not started and (msg == L["starttrigger1"] or msg == L["starttrigger2"] or msg == L["starttrigger3"] or msg == L["starttrigger4"]) then
		self:Message(L["startwarn"], "Urgent")
		if self.db.profile.enrage then
			enrageMessageId = self:DelayedMessage(45, L["enragewarn2"], "Important")
			self:Bar(enrageName, 60, 28798)
		end
		started = true --If I remember right, we need this as she sometimes uses an engage trigger mid-fight
		enraged = nil
	end
end


