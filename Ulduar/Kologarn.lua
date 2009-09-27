----------------------------------
--      Module Declaration      --
----------------------------------
local mod = BigWigs:NewBoss("Kologarn", "Ulduar")
if not mod then return end
mod:RegisterEnableMob(32930)
mod:Toggle(64290, "MESSAGE", "BAR")
mod:Toggle("shockwave", "MESSAGE", "BAR")
mod:Toggle("eyebeam", "MESSAGE", "BAR", "WHISPER", "ICON", "FLASHNSHAKE", "SAY")
mod:Toggle("arm", "MESSAGE")
mod:Toggle(63355, "MESSAGE")
mod:Toggle("bosskill")


------------------------------
--      Are you local?      --
------------------------------

local grip = mod:NewTargetList()
local pName = UnitName("player")

----------------------------
--      Localization      --
----------------------------

local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs: Kologarn", "enUS", true)
if L then
	L.arm = "Arm dies"
	L.arm_desc = "Warn for Left & Right Arm dies."
	L.left_dies = "Left Arm dies"
	L.right_dies = "Right Arm dies"
	L.left_wipe_bar = "Respawn Left Arm"
	L.right_wipe_bar = "Respawn Right Arm"

	L.shockwave = "Shockwave"
	L.shockwave_desc = "Warn when the next Shockwave is coming."
	L.shockwave_trigger = "Oblivion!"

	L.eyebeam = "Focused Eyebeam"
	L.eyebeam_desc = "Warn who gets Focused Eyebeam."
	L.eyebeam_trigger = "his eyes on you"
	L.eyebeam_message = "Eyebeam: %s"
	L.eyebeam_bar = "~Eyebeam"
	L.eyebeam_you = "Eyebeam on YOU!"
	L.eyebeam_say = "Eyebeam on ME!"

	L.eyebeamsay = "Eyebeam Say"
	L.eyebeamsay_desc = "Say when you are the target of Focused Eyebeam."

	L.armor_message = "%2$dx Crunch on %1$s"
end
L = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Kologarn")
mod.locale = L

------------------------------
--      Initialization      --
------------------------------

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Grip", 64290, 64292)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Armor", 63355, 64002)
	self:Log("UNIT_DIED", "Deaths")

	self:Death("Deaths", 32933, 32934, 32930)

	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:AddSyncListener("EyeBeamWarn")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Armor(player, spellId, _, _, spellName)
	local _, _, icon, stack = UnitDebuff(player, spellName)
	if stack and stack > 1 then
		self:TargetMessage(63355, L["armor_message"], player, "Urgent", icon, "Info", stack)
	end
end

local function gripWarn(spellId, spellName)
	mod:TargetMessage(64290, spellName, grip, "Attention", spellId, "Alert")
end

function mod:Grip(player, spellId, _, _, spellName)
	grip[#grip + 1] = player
	self:ScheduleEvent("BWgripeWarn", gripWarn, 0.2, spellId, spellName)
	self:Bar(64290, spellName, 10, spellId)
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(event, msg)
	if msg:find(L["eyebeam_trigger"]) then
		self:LocalMessage("eyebeam", L["eyebeam_you"], "Personal", 63976, "Long")
		SendChatMessage("eyebeam", L["eyebeam_say"], "SAY")
	end
	self:Sync("EyeBeamWarn", pName)
end

function mod:Deaths(guid)
	if guid == 32933 then
		self:IfMessage("arm", L["left_dies"], "Attention")
		self:Bar("arm", L["left_wipe_bar"], 50, 2062)
	elseif guid == 32934 then
		self:IfMessage("arm", L["right_dies"], "Attention")
		self:Bar("arm", L["right_wipe_bar"], 50, 2062)
	else
		self:Win()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if msg == L["shockwave_trigger"] then
		self:IfMessage("shockwave", L["shockwave"], "Attention", 63982)
		self:Bar("shockwave", L["shockwave"], 21, 63982)
	end
end

function mod:OnSync(sync, rest, nick)
	if sync == "EyeBeamWarn" and rest then
		self:TargetMessage("eyebeam", GetSpellInfo(40620), rest, "Positive", 63976, "Info") --40620 = "Eyebeam"
		self:Bar("eyebeam", L["eyebeam_message"]:format(rest), 11, 63976)
		self:Bar("eyebeam", L["eyebeam_bar"], 20, 63976)
		self:PrimaryIcon("eyebeam", rest)
		self:ScheduleEvent("BWRemoveEyeIcon", "SendMessage", 11, "BigWigs_RemoveRaidIcon", 1)
	end
end

