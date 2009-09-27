--------------------------------------------------------------------------------
-- Module Declaration
--
local mod = BigWigs:NewBoss("Faction Champions", "Trial of the Crusader")
if not mod then return end
mod:Toggle(65960, "MESSAGE")
mod:Toggle(65801, "MESSAGE")
mod:Toggle(65877, "MESSAGE")
mod:Toggle(66010, "MESSAGE")
mod:Toggle(65947, "MESSAGE")
mod:Toggle(65816, "MESSAGE", "BAR")
mod:Toggle(67514, "MESSAGE")
mod:Toggle(67777, "MESSAGE")
mod:Toggle(65983, "MESSAGE")
mod:Toggle(65980, "MESSAGE")
mod:Toggle("bosskill")

--------------------------------------------------------------------------------
-- Localization
--

local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs: Faction Champions", "enUS", true)
if L then
	L.enable_trigger = "The next battle will be against the Argent Crusade's most powerful knights! Only by defeating them will you be deemed worthy..."
	L.defeat_trigger = "A shallow and tragic victory."

	L["Shield on %s!"] = true
	L["Bladestorming!"] = true
	L["Hunter pet up!"] = true
	L["Felhunter up!"] = true
	L["Heroism on champions!"] = true
	L["Bloodlust on champions!"] = true
end
L = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Faction Champions")
mod.locale = L

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self:RegisterEnableMob(
		-- Alliance NPCs
		34460, 34461, 34463, 34465, 34466, 34467, 34468, 34469, 34470, 34471, 34472, 34473, 34474, 34475,
		-- Horde NPCs
		34441, 34444, 34445, 34447, 34448, 34449, 34450, 34451, 34453, 34454, 34455, 34456, 34458, 34459
	)
	self:RegisterEnableYell(L["enable_trigger"])
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Blind", 65960)
	self:Log("SPELL_AURA_APPLIED", "Polymorph", 65801)
	self:Log("SPELL_AURA_APPLIED", "Wyvern", 65877)
	self:Log("SPELL_AURA_APPLIED", "DivineShield", 66010)
	self:Log("SPELL_CAST_SUCCESS", "Bladestorm", 65947)
	self:Log("SPELL_SUMMON", "Felhunter", 67514)
	self:Log("SPELL_SUMMON", "Cat", 67777)
	self:Log("SPELL_CAST_SUCCESS", "Heroism", 65983)
	self:Log("SPELL_CAST_SUCCESS", "Bloodlust", 65980)
	self:Log("SPELL_AURA_APPLIED", "Hellfire", 65816, 68145, 68146, 68147)
	self:Log("SPELL_AURA_REMOVED", "HellfireStopped", 65816, 68145, 68146, 68147)
	self:Log("SPELL_DAMAGE", "HellfireOnYou", 65817, 68142, 68143, 68144)

	self:Yell("Win", L["defeat_trigger"])
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hellfire(player, spellId, _, _, spellName)
	self:IfMessage(65816, spellName, "Urgent", spellId)
	self:Bar(65816, spellName, 15, spellId)
end

function mod:HellfireStopped(player, spellId, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end

do
	local last = nil
	local pName = UnitName("player")
	function mod:HellfireOnYou(player, spellId, _, _, spellName)
		if player == pName then
			local t = GetTime()
			if not last or (t > last + 4) then
				self:TargetMessage(65816, spellName, player, "Personal", spellId, last and nil or "Alarm")
				last = t
			end
		end
	end
end

function mod:Wyvern(player, spellId, _, _, spellName)
	self:TargetMessage(65877, spellName, player, "Attention", spellId)
end

function mod:Blind(player, spellId, _, _, spellName)
	self:TargetMessage(65960, spellName, player, "Attention", spellId)
end

function mod:Polymorph(player, spellId, _, _, spellName)
	self:TargetMessage(65801, spellName, player, "Attention", spellId)
end

function mod:DivineShield(player, spellId)
	self:IfMessage(66010, L["Shield on %s!"]:format(player), "Urgent", spellId)
end

function mod:Bladestorm(player, spellId)
	self:IfMessage(65947, L["Bladestorming!"], "Important", spellId)
end

function mod:Cat(player, spellId)
	self:IfMessage(67777, L["Hunter pet up!"], "Urgent", spellId)
end

function mod:Felhunter(player, spellId)
	self:IfMessage(67514, L["Felhunter up!"], "Urgent", spellId)
end

function mod:Heroism(player, spellId)
	self:IfMessage(65983, L["Heroism on champions!"], "Important", spellId)
end

function mod:Bloodlust(player, spellId)
	self:IfMessage(65980, L["Bloodlust on champions!"], "Important", spellId)
end

