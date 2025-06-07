#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include %A_ScriptDir%\Lib\AHKv2-Gdip-master\Gdip_All.ahk
SendMode "Event"

global MacroStartTime := A_TickCount
global resizetimecheck := A_TickCount

global ChallengeMods := Map(
    "TraitReroll", { name: "TraitReroll", gems: 0, gold: 1000, rerolls: 1, bounties: 0 },
    "StoryMode", { name: "StoryMode", gems: 580, gold: 100, rerolls: 1, bounties: 1 },
    "LegendStage", { name: "LegendStage", gems: 530, gold: 75, rerolls: 1, bounties: 1 },
    "Infinity", { name: "Infinity", gems: 800, gold: 750, rerolls: 0, bounties: 0 },
)

RobloxWindow := "ahk_exe RobloxPlayerBeta.exe"
