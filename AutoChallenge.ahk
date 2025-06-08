#Requires AutoHotkey v2.0
#Include %A_ScriptDir%\Lib\var.ahk

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


}

F3:: {
    ;stop the macro
}

F4:: {
    if paused {
        global paused := false
        Pause(false)
        return
    }
    else {
        global paused := true
        Pause(true)
        return
    }

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
        IngameCheck(IngameStatus)
    }
    else {
        AddToLog("No Bounty found")
        TPtoLobby()
        Sleep 5000
        BetterClick(564, 477) ; Leave
        Sleep 200
        BetterClick(445, 445) ; Leave
        Sleep 200
        BetterClick(400, 100) ; Leave 2
        Sleep 200
        BetterClick(408, 135) ; Leave 2
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
    if (ok := FindText(&X, &Y, 404, 191, 775, 304, 0, 0, ShibuyaStationBounty)) {
        CurrentChallenge := ShibuyaStationBounty
        AddToLog("Loading in Shibuya Station Bounty")
        UpdateGUI("Shibuya Station Bounty")
    } else if (ok := FindText(&X, &Y, 614 - 150000, 233 - 150000, 614 + 150000, 233 + 150000, 0, 0, Landofthegods)) {
        CurrentChallenge := Landofgods
        AddToLog("Loading in Land of the Gods Bounty")
        UpdateGUI("Land of the Gods Bounty")
    } else if (ok := FindText(&X, &Y, 404, 191, 775, 304, 0, 0, marshalislandbounty)) {
        CurrentChallenge := marshalisland
        AddToLog("Loading in Marshal Island Bounty")
        UpdateGUI("Marshal Island Bounty")
    } else if (ok := FindText(&X, &Y, 404, 191, 775, 3040, 0, DoubleDungeonGodStatue)) {
        CurrentChallenge := DoubleDungeonGodStatue
        AddToLog("Loading in Double Dungeon God Statue Bounty")
        UpdateGUI("Double Dungeon Bounty")
    } else if (ok := FindText(&X, &Y, 404, 191, 775, 304, 0, 0, DoubleDungeonBounty)) {
        CurrentChallenge := DoubleDungeonGodStatue
        AddToLog("Loading in Double Dungeon bounty")
        UpdateGUI("Double Dungeon")
    } else if (ok := FindText(&X, &Y, 404, 191, 775, 304, 0, 0, PlanetNamekBounty)) {
        CurrentChallenge := PlanetNamek
        AddToLog("Loading in Planet Namek bounty")
        UpdateGUI("Planet Namek")
    } else {
        CurrentChallenge := "Macro Broken"
        AddToLog("Entered Bounty but couldn't find anything - leaving bounty")
        BetterClick(445, 440) ; Leave
        Sleep 200
        return
    }
}


StartChallenge() {
    loop {
        if (ok := FindText(&X, &Y, 87 - 150000, 295 - 150000, 87 + 150000, 295 + 150000, 0, 0, Create)) {
            break
        }
        BetterClick(38, 347)
        Sleep 300
        BetterClick(606, 285) ; click challenges
        Sleep 300
        BetterClick(657, 175)
        loop {
            sleep 100
            if (ok := FindText(&X, &Y, 120 - 150000, 324 - 150000, 120 + 150000, 324 + 150000, 0, 0, store)) {
                break
            }
        }
        sleep 100
        SendInput ("{shift up}")
        Sleep 100
        SendInput ("{shift down}")
        sleep 50
        SendInput("{d up}") ; Ensure key is released
        Sleep 100
        SendInput ("{d down}")
        Sleep 1800
        SendInput ("{d up}")
        KeyWait "d" ; Wait for "d" to be fully processed
    }

    loop {
        sleep 10
        if (ok := FindText(&X, &Y, 87 - 150000, 295 - 150000, 87 + 150000, 295 + 150000, 0, 0, Create)) {
            break
        }
    }
    SendInput ("{shift up}")
    Sleep 50
    loop {
        BetterClick(80, 280)	; createpressW
        sleep 100
        if (ok := FindText(&X, &Y, 113, 352, 379, 462, 0, 0, regularchallenges)) {
            break
        }

    }
    sleep 300
    if (1 == 1 && ok := FindText(&X, &Y, 663 - 150000, 291 - 150000, 663 + 150000, 291 + 150000, 0, 0,
        challengecheck)) {
        BetterClick(630, 265) ; Click trait reroll
        loop {
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
            sleep 500
            BetterClick(400, 320)
            sleep 500
            if (ok := FindText(&X, &Y, 123 - 150000, 513 - 150000, 123 + 150000, 513 + 150000, 0, 0, startcheck)) {
                break
            }
        }
        BetterClick(100, 500)	; startpress
        sleep 300
        BetterClick(100, 500)	; startpress
    }
    else {
        loop {
            if (ok := FindText(&X, &Y, 662 - 150000, 272 - 150000, 662 + 150000, 272 + 150000, 0, 0, regular)) {
                if (ok := FindText(&X, &Y, 663 - 150000, 291 - 150000, 663 + 150000, 291 + 150000, 0, 0, challengecheck
                )) {
                    BetterClick(637, 297) ; Click trait reroll
                    loop {
                        if (ok := FindText(&X, &Y, 229 - 150000, 286 - 150000, 229 + 150000, 286 + 150000, 0, 0,
                            rewardchallenge)) {
                            break
                        }
                    }
                }
                else {
                    BetterClick(692, 163)
                    sleep 500
                    BetterClick(407, 135)
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
    } else {
        CurrentChallenge := "Macro Broken"
        AddToLog("Entered challenge but couldn't find anything - must restart")
        BetterClick(235, 432) ; press leave button
        Sleep 2000
        return
    }
    global CurrentChallengeMod := ChallengeMods["TraitReroll"]
}

BetterClick(x, y) {
    MouseMove(x-8, y-31)
    MouseMove(1, 0, , "R")
    MouseClick("Left", -1, 0, , , , "R")
}