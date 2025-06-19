#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include %A_ScriptDir%\Lib\AHKv2-Gdip-master\Gdip_All.ahk
#Include %A_ScriptDir%\Lib\gui.ahk
#Include %A_ScriptDir%\Lib\Function.ahk
#Include %A_ScriptDir%\Lib\WebHookSetting.ahk
#Include %A_ScriptDir%\Lib\FindSpot.ahk
#Include %A_ScriptDir%\Lib\BeatStage.ahk
#Include %A_ScriptDir%\Lib\var.ahk
SendMode "Event"

F1:: {
    if WinExist(RobloxWindow) {
        WinActivate(RobloxWindow)
        Sleep 50
        WinMove(0, 0, 800, 600, RobloxWindow)
        Sleep 50
    }
}

F2:: InitializeMacro()

InitializeMacro() {
    global MacroStartTime := A_TickCount
    global RobloxWindow  ; Make sure this is defined elsewhere

    if WinExist(RobloxWindow) {
        WinActivate(RobloxWindow)
        Sleep 50
        WinMove(0, 0, 800, 600, RobloxWindow)
        Sleep 50
    }
    else {
        MsgBox("You must have ROBLOX open in order to start the macro (microsoft roblox doesnt work)", "Error T4",
            "+0x1000")
        return
    }
    global startTime := A_TickCount

    loop {
        Disconect()
        if (ok:=FindText(&X, &Y, 127-150000, 80-150000, 127+150000, 80+150000, 0, 0, gamecheck)) {
            break
        }
    }
    StartChallenge()

}

F3:: {
    StopMacro()
}

F4:: {
    if paused {
        global paused := false
        AddToLog("Unpaused")
        Pause(false)
        return
    }
    else {
        global paused := true
        AddToLog("Paused")
        Pause(true)
        return
    }

}

F5:: {
     BountyAssign()
     IngameCheck(IngameStatus)
}

F6:: {
   ChallengeAssign()
     IngameCheck(IngameStatus)
}

StartBounty() {
    global LastResetTime, CurrentChallengeMod
    ; Check if we need to reset (24 hours passed)
    if (A_TickCount - LastResetTime >= 86400000) {
        LastResetTime := A_TickCount
    }
    if (BountyCheck == 2) {
        AddToLog("Daily bounty limit 10 reached! Starting infinite mode")
        StartInf()
        return
    }
    AddToLog("Starting Bounty")
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 332 - 150000, 248 - 150000, 332 + 150000, 248 + 150000, 0, 0, reward)) {
            break
        }
        Sleep 100
        BetterClick(38, 346) ; click areas
        Sleep 300
        BetterClick(356, 388) ; click play
        Sleep 300
        BetterClick(658, 179)
        sleep 300
        AddToLog("Waiting for lobby")
        loop {
            Disconect()
            sleep 100
            if (ok := FindText(&X, &Y, 120 - 150000, 324 - 150000, 120 + 150000, 324 + 150000, 0, 0, store)) {
                break
            }
        }
        sleep 100
        SendInput ("{w down}")
        sleep 100
        SendInput ("{shift down}")
        Sleep 3000
        SendInput ("{w up}")
        sleep 100
        SendInput ("{shift up}")
        Sleep 100
        SendInput ("{e up}")
        Sleep 100
        SendInput ("{e down}")
        Sleep 200
        SendInput ("{e up}")
        KeyWait "e" ; Wait for "e" to be fully processed
        SendInput ("{e up}")
        Sleep 100
        SendInput ("{e down}")
        Sleep 200
        SendInput ("{e up}")
        KeyWait "e" ; Wait for "e" to be fully processed
        loop 10 {
            Disconect()
            sleep 100
            BetterClick(457, 469) ; bounties
            if (ok := FindText(&X, &Y, 332 - 150000, 248 - 150000, 332 + 150000, 248 + 150000, 0, 0, reward)) {
                break
            }
        }
        sleep 100
        SendInput ("{shift up}")
        if (ok := FindText(&X, &Y, 332 - 150000, 248 - 150000, 332 + 150000, 248 + 150000, 0, 0, reward)) {
            break
        }
    }

    Sleep 100

    if (ok := FindText(&X, &Y, 676 - 150000, 571 - 150000, 676 + 150000, 571 + 150000, 0, 0, ZeroBounty)) {
        AddToLog("No Bounties left, playing inf")
        global BountyCheck := 1
        BetterClick(626, 599)
        sleep 500
        StartInf()
    }
    else if (ok := FindText(&X, &Y, 515 - 150000, 234 - 150000, 515 + 150000, 234 + 150000, 0, 0, LegendStage)) {
        global CurrentChallengeMod := ChallengeMods["LegendStage"]
        AddToLog("Legend Stage Bounty")
    } else {
        global CurrentChallengeMod := ChallengeMods["StoryMode"]
        AddToLog("Story Mode Bounty")
    }
    BetterClick(746, 191) ; play
    Sleep 200
    if (ok := FindText(&X, &Y, 588 - 150000, 492 - 150000, 588 + 150000, 492 + 150000, 0, 0, BossStart)) {
        Sleep 1000
        BountyAssign()
        Sleep 200
        BetterClick(441, 477)   ; Start
        Sleep 500
        BetterClick(392, 313) ; Cancel warning capacity
        Sleep 50
        BetterClick(69, 498)    ; Start2
        Sleep 100
        BetterClick(87, 515)    ; Start3
        sleep 200
        BetterClick(409, 343)
        sleep 200
        BetterClick(75, 498)
        sleep 200
        BetterClick(68, 470)    ; Start3
        IngameCheck(IngameStatus)
    }
    else {
        AddToLog("No Bounty found")
        Sleep 1000
        BetterClick(566, 477) ; Leave
        Sleep 200
        BetterClick(566, 477) ; Leave
        Sleep 200
        BetterClick(407, 133) ; Leave 2
        Sleep 200
        BetterClick(407, 133) ; Leave 2
        StartInf()
    }
}

BountyAssign() {
    global CurrentChallenge, CurrentChallengeMod
    loop {
        sleep 100
        Disconect()
        if (ok := FindText(&X, &Y, 589 - 150000, 493 - 150000, 589 + 150000, 493 + 150000, 0, 0, startbountycheck)) {
            break
        }
    }
    if (ok := FindText(&X, &Y, 562-150000, 218-150000, 562+150000, 218+150000, 0, 0, ShibuyaStationBounty)) {
        CurrentChallenge := ShibuyaStationBounty
        AddToLog("Loading in Shibuya Station Bounty")
        UpdateGUI("Shibuya Station Bounty")
    } else if (ok := FindText(&X, &Y, 595-150000, 218-150000, 595+150000, 218+150000, 0, 0, Landofgodsbounty)) {
        CurrentChallenge := Landofgods
        AddToLog("Loading in Land of the Gods Bounty")
        UpdateGUI("Land of the Gods Bounty")
    } else if (ok := FindText(&X, &Y, 446-150000, 218-150000, 446+150000, 218+150000, 0, 0, marshalislandbounty)) {
        CurrentChallenge := marshalisland
        AddToLog("Loading in Marshal Island Bounty")
        UpdateGUI("Marshal Island Bounty")
    } else if (ok := FindText(&X, &Y, 447-150000, 218-150000, 447+150000, 218+150000, 0, 0, DoubleDungeonGodStatue)) {
        CurrentChallenge := DoubleDungeonGodStatue
        AddToLog("Loading in Double Dungeon God Statue Bounty")
        UpdateGUI("Double Dungeon Bounty")
    } else if (ok := FindText(&X, &Y, 447-150000, 218-150000, 447+150000, 218+150000, 0, 0, DoubleDungeonBounty)) {
        CurrentChallenge := DoubleDungeonGodStatue
        AddToLog("Loading in Double Dungeon bounty")
        UpdateGUI("Double Dungeon")
    } else if (ok := FindText(&X, &Y, 443-150000, 219-150000, 443+150000, 219+150000, 0, 0, PlanetNamekBounty)) {
        CurrentChallenge := PlanetNamek
        AddToLog("Loading in Planet Namek bounty")
        UpdateGUI("Planet Namek")
    } else if (ok := FindText(&X, &Y, 586-150000, 217-150000, 586+150000, 217+150000, 0, 0, ShibuyaAftermathBounty)) {
        CurrentChallenge := ShibuyaAftermathBounty
        AddToLog("Loading in Shibuya Aftermath bounty")
        UpdateGUI("Shibuya Aftermath Bounty")
    } else if (ok := FindText(&X, &Y, 471-150000, 219-150000, 471+150000, 219+150000, 0, 0, UndergroundChurchBounty)) {
        CurrentChallenge := UnderGround
        AddToLog("Loading in Under Ground bounty")
        UpdateGUI("Under Ground")
    } else if (ok := FindText(&X, &Y, 404, 191, 775, 304, 0, 0, Castle) || ok := FindText(&X, &Y, 446-150000, 216-150000, 446+150000, 216+150000, 0, 0, Golden)) {
        CurrentChallenge := Castle
        AddToLog("Loading in Golden Castle bounty")
        UpdateGUI("Golden Castle")
    } else if (ok := FindText(&X, &Y, 429-150000, 218-150000, 429+150000, 218+150000, 0, 0, SandVillageBounty)) {
        CurrentChallenge := SandVillageBounty
        AddToLog("Loading in Sand Village bounty")
        UpdateGUI("Sand Village")
    } else if (ok := FindText(&X, &Y, 444-150000, 218-150000, 444+150000, 218+150000, 0, 0, Kuinshi1)) {
        CurrentChallenge := Kuinshi
        AddToLog("Loading in Kuinshi Palace bounty")
        UpdateGUI("Kuinshi Palace")
    } else if (ok := FindText(&X, &Y, 404, 191, 775, 304, 0, 0, Kuinshi)) {
        CurrentChallenge := Kuinshi
        AddToLog("Loading in Kuinshi Palace bounty")
        UpdateGUI("Kuinshi Palace")
    } else if (ok := FindText(&X, &Y, 526-150000, 219-150000, 526+150000, 219+150000, 0, 0, SpiritSocietyBounty)) {
        CurrentChallenge := SpiritSociety
        AddToLog("Loading in Spirit Society bounty")
        UpdateGUI("Spirit Society Bounty")
    } else if (ok := FindText(&X, &Y, 614 - 150000, 233 - 150000, 614 + 150000, 233 + 150000, 0, 0, Landofthegods)) {
        CurrentChallenge := Landofthegods
        AddToLog("Loading in Land Of The Gods Bounty")
        UpdateGUI("Land Of The Gods Bounty")
    } else if (ok := FindText(&X, &Y, 542-150000, 220-150000, 542+150000, 220+150000, 0, 0, EdgeOfHeavenBounty)) {
        CurrentChallenge := EdgeOfHeaven
        AddToLog("Loading in Edge of Heaven Bounty")
        UpdateGUI("Edge of Heaven Bounty")
    } else if (ok := FindText(&X, &Y, 434-150000, 220-150000, 434+150000, 220+150000, 0, 0, ShinningCastleBounty)) {
        CurrentChallenge := ShinningCastle
        AddToLog("Loading in Shining Castle Bounty")
        UpdateGUI("Shining Castle Bounty")
    } else {
        CurrentChallenge := "Macro Broken"
        AddToLog("Entered Bounty but couldn't find anything - leaving bounty")
        BetterClick(562, 475) ; Leave
        Sleep 200
        BetterClick(562, 475) ; Leave
        Sleep 200
        BetterClick(407, 136) ; Leave 2
        Sleep 200
        BetterClick(407, 136) ; Leave 2
        Sleep 2000
        StartInf()
        return
    }
}

StartChallenge() {
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 87 - 150000, 295 - 150000, 87 + 150000, 295 + 150000, 0, 0, Create)) {
            break
        }
        BetterClick(38, 347)
        Sleep 300
        BetterClick(606, 285) ; click challenges
        Sleep 300
        BetterClick(657, 175)
        AddToLog("Waiting before moving")
        loop {
            Disconect()
            sleep 100
            if (ok := FindText(&X, &Y, 120 - 150000, 324 - 150000, 120 + 150000, 324 + 150000, 0, 0, store)) {
                break
            }
        }
        SendInput("{d up}") ; Ensure key is released
        Sleep 100
        SendInput ("{d down}")
        sleep 50
        SendInput ("{shift down}")
        Sleep 1800
        SendInput ("{d up}")
        sleep 100
        SendInput ("{shift up}")
    }

    loop {
        Disconect()
        sleep 10
        if (ok := FindText(&X, &Y, 87 - 150000, 295 - 150000, 87 + 150000, 295 + 150000, 0, 0, Create)) {
            break
        }
    }
    SendInput ("{shift up}")
    Sleep 50
    loop {
        Disconect()
        BetterClick(80, 280)	; createpress
        sleep 100
        if (ok := FindText(&X, &Y, 113, 352, 379, 462, 0, 0, regularchallenges)) {
            break
        }
    }

    if (dodaily == 1) {
        loop {
            Disconect()
            BetterClick(220, 310) ; daily click
            sleep 100
            if (ok := FindText(&X, &Y, 199 - 150000, 338 - 150000, 199 + 150000, 338 + 150000, 0, 0, dailychallenge)) {
                break
            }
        }
    }
    if (dodaily == 1 && ok := FindText(&X, &Y, 663 - 150000, 291 - 150000, 663 + 150000, 291 + 150000, 0, 0,
        challengecheck)) {
        AddToLog("Attempting Daily Challenge")
        BetterClick(630, 265) ; Click trait reroll
        loop {
            Disconect()
            sleep 100
            BetterClick(400, 320)
            sleep 100
            BetterClick(400, 330)
            sleep 100
            BetterClick(400, 340)
            sleep 100
            BetterClick(400, 350)
            sleep 100
            BetterClick(400, 360)
            if (ok := FindText(&X, &Y, 229 - 150000, 286 - 150000, 229 + 150000, 286 + 150000, 0, 0, rewardchallenge)) {
                break
            }
        }
        loop {
            Disconect()
            sleep 500
            BetterClick(400, 320)
            sleep 500
            if (ok := FindText(&X, &Y, 123 - 150000, 513 - 150000, 123 + 150000, 513 + 150000, 0, 0, startcheck)) {
                break
            }
        }
        ChallengeAssign()
        BetterClick(100, 500)	; startpress
        sleep 300
        BetterClick(100, 500)	; startpress
        IngameCheck(IngameStatus)
    }
    else {
        loop {
            Disconect()
            if (ok := FindText(&X, &Y, 662 - 150000, 272 - 150000, 662 + 150000, 272 + 150000, 0, 0, regular)) {
                if (ok := FindText(&X, &Y, 663 - 150000, 291 - 150000, 663 + 150000, 291 + 150000, 0, 0, challengecheck
                )) {
                    AddToLog("Attempting Trait Reroll Challenge")
                    BetterClick(637, 297) ; Click trait reroll
                    loop {
                        Disconect()
                        if (ok := FindText(&X, &Y, 229 - 150000, 286 - 150000, 229 + 150000, 286 + 150000, 0, 0,
                            rewardchallenge)) {
                            break
                        }
                    }
                    ChallengeAssign()
                    BetterClick(67, 464)	; startpress
                    IngameCheck(IngameStatus)
                }
                else {
                    AddToLog("Played Challenge")
                    BetterClick(692, 163)
                    sleep 500
                    BetterClick(407, 135)
                    StartBounty()
                }
            }
        }
    }
}

ChallengeAssign() {
    global CurrentChallenge, CurrentChallengeMod
    if (ok := FindText(&X, &Y, 121-150000, 199-150000, 121+150000, 199+150000, 0, 0, ShibuyaStation)) {
        CurrentChallenge := ShibuyaStation
        AddToLog("Loading in Shibuya Station challenge")
        UpdateGUI("Shibuya Station")
    } else if (ok := FindText(&X, &Y, 89-150000, 199-150000, 89+150000, 199+150000, 0, 0, marshalisland)) {
        CurrentChallenge := marshalisland
        AddToLog("Loading in Marshal Island")
        UpdateGUI("Marshal Island")
    } else if (ok := FindText(&X, &Y, 205 - 150000, 213 - 150000, 205 + 150000, 213 + 150000, 0, 0, Landofgods)) {
        CurrentChallenge := Landofgods
        AddToLog("Loading in Land of the Gods")
        UpdateGUI("Land of the Gods")
    } else if (ok := FindText(&X, &Y, 68-150000, 199-150000, 68+150000, 199+150000, 0, 0, DoubleDungeon)) {
        CurrentChallenge := DoubleDungeonGodStatue
        AddToLog("Loading in Double Dungeon challenge")
        UpdateGUI("Double Dungeon")
    } else if (ok := FindText(&X, &Y, 89-150000, 198-150000, 89+150000, 198+150000, 0, 0, UnderGround)) {
        CurrentChallenge := UnderGround
        AddToLog("Loading in Under Ground challenge")
        UpdateGUI("Under Ground")
    } else if (ok := FindText(&X, &Y, 166-150000, 164-150000, 166+150000, 164+150000, 0, 0,
        ShibuyaAftermathchallenge)) {
        CurrentChallenge := ShibuyaAftermathBounty
        AddToLog("Loading in Shibuya Aftermath")
        UpdateGUI("Shibuya Aftermath")
    } else if (ok := FindText(&X, &Y, 70-150000, 164-150000, 70+150000, 164+150000, 0, 0, Castlechallenge)) {
        CurrentChallenge := Castle
        AddToLog("Loading in Golden Castle")
        UpdateGUI("Golden Castle")
    } else if (ok := FindText(&X, &Y, 70 - 150000, 212 - 150000, 70 + 150000, 212 + 150000, 0, 0, KuinshiChallenge)) {
        CurrentChallenge := Kuinshi
        AddToLog("Loading in Kuinshi Palace")
        UpdateGUI("Kuinshi Palace")
    } else if (ok := FindText(&X, &Y, 63-150000, 197-150000, 63+150000, 197+150000, 0, 0, SandVillage)) {
        CurrentChallenge := SandVillageBounty
        AddToLog("Loading in Sand Village challenge")
        UpdateGUI("Sand Village")
    } else if (ok := FindText(&X, &Y, 145-150000, 199-150000, 145+150000, 199+150000, 0, 0, PlanetNamek)) {
        CurrentChallenge := PlanetNamek
        AddToLog("Loading in Planet Namek challenge")
        UpdateGUI("Planet Namek")
    } else if (ok := FindText(&X, &Y, 75-150000, 199-150000, 75+150000, 199+150000, 0, 0, SpiritSociety)) {
        CurrentChallenge := SpiritSociety
        AddToLog("Loading in Spirit Society challenge")
        UpdateGUI("Spirit Society")
    } else if ((ok:=FindText(&X, &Y, 75-150000, 199-150000, 75+150000, 199+150000, 0, 0, EdgeOfHeaven))) {
        CurrentChallenge := EdgeOfHeaven
        AddToLog("Loading in Edge of Heaven challenge")
        UpdateGUI("Edge of Heaven")
    } else if ((ok:=FindText(&X, &Y, 65-150000, 164-150000, 65+150000, 164+150000, 0, 0, ShinningCastle))) {
        CurrentChallenge := ShinningCastle
        AddToLog("Loading in Shinning Castle challenge")
        UpdateGUI("Shinning Castle")
    } else {
        CurrentChallenge := "Macro Broken"
        AddToLog("Entered challenge but couldn't find anything - must restart")
        BetterClick(175, 462) ; press leave button
        Sleep 2000
        StartInf()
        return
    }
    global CurrentChallengeMod := ChallengeMods["TraitReroll"]
}

StartInf() {
    global CurrentChallenge
    AddToLog("Going to infinite")
    CurrentChallenge := "UnderGround Infinite"
    global CurrentChallengeMod := ChallengeMods["Infinity"]
    UpdateGUI(CurrentChallenge)
    Sleep 100
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 87 - 150000, 295 - 150000, 87 + 150000, 295 + 150000, 0, 0, Create)) {
            break
        }
        BetterClick(95, 294) ; click play
        sleep 300
        BetterClick(158, 335) ; click teleport
        Sleep 200
        AddToLog("Waiting before moving")
        loop {
            Disconect()
            sleep 100
            if (ok := FindText(&X, &Y, 120 - 150000, 324 - 150000, 120 + 150000, 324 + 150000, 0, 0, store)) {
                break
            }
        }
        SendInput ("{shift up}")
        sleep 100
        SendInput ("{shift down}")
        sleep 50
        SendInput ("{s down}")
        Sleep 2500
        SendInput ("{s up}")
        KeyWait "s" ; Wait for "s" to be fully processed

        SendInput("{d up}") ; Ensure key is released
        Sleep 100
        SendInput ("{d down}")
        Sleep 2000
        SendInput ("{d up}")
        KeyWait "d" ; Wait for "d" to be fully processed
        SendInput ("{shift up}")
    }
    SendInput ("{shift up}")

    ; Loop until the CreateMatch is found
    while (true) {
        if (ok := FindText(&X, &Y, 40, 270, 190, 312, 0, 0, CreateMatch)) {
            BetterClick(82, 276) ; CreateMatch
            Sleep 500
            BetterClick(148, 422) ; select underground
            Sleep 300
            BetterClick(311, 275) ; select sandbox
            Sleep 300
            loop 3 {
                Sleep 50
                SendInput("{WheelDown 10}") ; scroll down
            }
            Sleep 800
            BetterClick(312, 430) ; select inf
            Sleep 1000
            BetterClick(560, 445) ; Start
            Sleep 1000
            if (ok := FindText(&X, &Y, 415 - 150000, 358 - 150000, 415 + 150000, 358 + 150000, 0, 0, Cancell)) {
                AddToLog("Cancelled max cap")
                BetterClick(407, 342) ; Click cancel
                sleep 500
            }
            BetterClick(68, 460) ; Start2
            IngameCheck(IngameStatus)
            break
        }
        else {
            Sleep 100
        }
    }
}