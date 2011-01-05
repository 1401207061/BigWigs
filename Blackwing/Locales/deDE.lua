local L = BigWigs:NewBossLocale("Atramedes", "deDE")
if L then
	L.tracking_me = "Absuchen auf MIR!"

	L.ground_phase = "Bodenphase"
	L.ground_phase_desc = "Warnt, wenn Atramedes landet."
	L.air_phase = "Luftphase"
	L.air_phase_desc = "Warnt, wenn Atramedes abhebt."

	L.air_phase_trigger = "Ja, lauft! Jeder Schritt lässt Euer Herz stärker klopfen. Laut und heftig... ohrenbetäubend. Es gibt kein Entkommen!" -- check

	L.sonicbreath_cooldown = "~Schallatem"
end

L = BigWigs:NewBossLocale("Chimaeron", "deDE")
if L then
	L.bileotron_engage = "Der Gall-O-Tron springt an und stößt eine übel riechende Substanz aus." -- check

	L.next_system_failure = "Nächstes Systemversagen"
	L.break_message = "%2$dx Brechen auf %1$s"

	L.warmup = "Aufwärmen"
	L.warmup_desc = "Timer für die Aufwärmphase."
end

L = BigWigs:NewBossLocale("Magmaw", "deDE")
if L then
	L.inferno = (GetSpellInfo(92191))
	L.inferno_desc = "Beschwört [Blazing Bone Construct]." -- need german name

	L.pillar_of_flame_cd = "~Flammensäule"

	L.slump = "Nach vorne schlittern"
	L.slump_desc = "Magmaul schlittert nach vorne und entblößt seine Zangen."

	L.slump_trigger = "%s schlittert nach vorne und entblößt seine Zangen!" -- check

	L.expose_trigger = "head"
	L.expose_message = "Head Explosed!"
end

L = BigWigs:NewBossLocale("Maloriak", "deDE")
if L then
	--heroic
	L.darkSludge = (GetSpellInfo(92987))
	L.darkSludge_desc = ("Warnt, wenn du in %s stehst."):format((GetSpellInfo(92987)))

	--normal
	L.final_phase = "Letzte Phase"

	L.release_aberration_message = "%s Adds noch!"
	L.release_all = "%s Adds freigelassen!"

	L.bitingchill_say = "Beißende Kälte auf MIR!"

	L.flashfreeze = "~Blitzeis"

	L.phase = "Phasen"
	L.phase_desc = "Warnt vor Phasenwechsel."
	L.next_phase = "Nächste Phase"

	L.you = "%s auf DIR!"

	L.red_phase_trigger = "Vermischen, rühren, erhitzen..." -- check
	L.red_phase = "|cFFFF0000Rote|r Phase"
	L.blue_phase_trigger = "Muss rausfinden, wie die sterbliche Hülle auf extreme Temperaturen reagiert... FÜR DIE FORSCHUNG!" -- check
	L.blue_phase = "|cFF809FFEBlaue|r Phase"
	L.green_phase_trigger = "Etwas instabil vielleicht, aber keine Forschung ohne Risiko!" -- check
	L.green_phase = "|cFF33FF00Grüne|r Phase"
	L.dark_phase = "|cFF660099Dunkle|r Phase"
	--L.dark_phase_trigger = "Your mixtures are weak, Maloriak! They need a bit more... kick!"
end

L = BigWigs:NewBossLocale("Nefarian", "deDE")
if L then
	L.phase = "Phasen"
	L.phase_desc = "Warnt vor Phasenwechsel."

	L.phase_two_trigger = "Verfluchte Sterbliche! Ein solcher Umgang mit dem Eigentum anderer verlangt nach Gewalt!" -- check

	L.phase_three_trigger = "Ich habe versucht, ein guter Gastgeber zu sein, aber ihr wollt einfach nicht sterben! Genug der Spielchen! Ich werde euch einfach... ALLE TÖTEN!" -- check

	L.shadowblaze_trigger = "Fleisch wird zu Asche!" -- check

	L.cinder_say = "Explodierende Asche auf MIR!"

	L.chromatic_prototype = "Chromatischer Prototyp"
end

L = BigWigs:NewBossLocale("Omnotron Defense System", "deDE")
if L then
	L.switch = "Wechsel"
	L.switch_desc = "Warnt vor dem Wechseln der Bosse."
	L.switch_message = "Wechsel - %s %s"

	L.next_switch = "Nächster Wechsel"

	L.acquiring_target = "Zielerfassung"

	L.cloud_message = "Wolke auf DIR!"
	L.protocol_message = "Poison Bombs!"

	L.iconomnotron = "Icon on active boss"
	L.iconomnotron_desc = "Place the primary raid icon on the active boss (requires promoted or leader)."
end

