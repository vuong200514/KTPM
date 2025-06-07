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
        BetterClick(80, 280)	; createpress
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

BetterClick(x, y) {
    MouseMove(x-8, y-31)
    MouseMove(1, 0, , "R")
    MouseClick("Left", -1, 0, , , , "R")
}