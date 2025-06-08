#Requires AutoHotkey v2
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\WebHookSetting.ahk
#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include %A_ScriptDir%\AutoChallenge.ahk
#Include %A_ScriptDir%\Lib\GUI.ahk
SendMode "Event"

TPtoSpawn() {
    if (ok:=FindText(&A, &B, 676-150000, 119-150000, 676+150000, 119+150000, 0, 0, lbcheckk) || ok:=FindText(&A, &B, 599-150000, 119-150000, 599+150000, 119+150000, 0, 0, lbcheckk4)) {
        CloseLB(A-35, B-50)
    }
    Sleep 100
    BetterClick(26, 608) ; settings
    Sleep 400
    BetterClick(524, 240) ; spawn
    Sleep 300
    Disconect()
    BetterClick(579, 157) ; close settings
}

TPtoLobby() {
    BetterClick(26, 608) ; settings
    Sleep 400
    BetterClick(523, 277) ; lobby
    Sleep 800
    BetterClick(349, 342) ; confirm
}

SensitivityCalculator() {
    width := A_ScreenWidth
    height := A_ScreenHeight

    SensitivityCalc := ((width * width) + (height * height)) / ((1920 * 1920) + (1080 * 1080))
    Sensitivity := (0.15 * Sqrt(SensitivityCalc))
    Sensitivity := Format("{:.3f}", Sensitivity)
    SensitivityString := "" Sensitivity
    loop {
        if (SubStr(SensitivityString, -1) = "0") {
            SensitivityString := SubStr(SensitivityString, 1, (StrLen(SensitivityString) - 1))

        }
        else {
            break
        }
    }
    return SensitivityString
}


Disconect() {
    if (ok := FindText(&X, &Y, 343 - 150000, 433 - 150000, 343 + 150000, 433 + 150000, 0, 0, disconected) || ok := FindText(&X, &Y, 436 - 150000, 432 - 150000, 436 + 150000, 432 + 150000, 0, 0, telefail) || ok :=
        FindText(&X, &Y, 476 - 150000, 248 - 150000, 476 + 150000, 248 + 150000, 0, 0, telefailed2) || ok := FindText(&X, &Y, 436 - 150000, 433 - 150000, 436 + 150000, 433 + 150000, 0, 0, id17)) {
        AddToLog("Found disconected reconectting")
        global resizetimecheck := A_TickCount
        Reconnecttops()
        loop {
            sleep 200
            BetterClick(60, 120)
            Resizecheck()
            sleep 200
            if (ok := FindText(&X, &Y, 120 - 150000, 324 - 150000, 120 + 150000, 324 + 150000, 0, 0, store)) {
                break
            }
        }
        StartChallenge()
    }
    if (ok:=FindText(&A, &B, 676-150000, 119-150000, 676+150000, 119+150000, 0, 0, lbcheckk) || ok:=FindText(&A, &B, 599-150000, 119-150000, 599+150000, 119+150000, 0, 0, lbcheckk4)) {
        Sleep 100
        BetterClick(572, 105)
        sleep 100
        BetterClick(648, 104) ; close lb
    }
}

Resizecheck() {
    elapsedcheck := (A_TickCount - resizetimecheck) / 60000
    if (elapsedcheck >= 1.5) {
        AddToLog("Resizing roblox")
        if WinExist(RobloxWindow) {
            WinActivate(RobloxWindow)
            Sleep 50
            WinMove(27, 15, 800, 600, RobloxWindow)
            Sleep 50
        }
        loop {
            Disconect()
            sleep 100
            if (ok := FindText(&X, &Y, 120 - 150000, 324 - 150000, 120 + 150000, 324 + 150000, 0, 0, store)) {
                break
            }
        }
        StartChallenge()
    }
}

Reconnecttops() {
    url := FileRead(PSLinkFile, "UTF-8")
    AddToLog("Reconnecting")
    if RegExMatch(url, "games/(\d+)", &placeMatch) {
        placeID := placeMatch[1]
    }
    if RegExMatch(url, "privateServerLinkCode=(\d+)", &linkMatch) {
        linkCode := linkMatch[1]
    }
    Run("roblox://placeID=" placeID "&linkCode=" linkCode)
    return true
}

Changecamera() {
    Disconect()
    BetterClick(235, 441) ; use spectator
    Sleep 500
    BetterClick(334, 541) ; Pressleft
    Sleep 200
    BetterClick(479, 542) ; Pressright
    Sleep 300
    BetterClick(407, 611) ; leave spectator
}

SendWHanimeRanger() {
    statsText := "🥚 Egg Earned: "
    webhook.send({
        content: statsText
    })
}
