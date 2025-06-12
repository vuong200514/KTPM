#Requires AutoHotkey v2
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\WebHookSetting.ahk
#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include %A_ScriptDir%\AutoChallenge.ahk
#Include %A_ScriptDir%\Lib\GUI.ahk
SendMode "Event"

LBCheck := "|<>*90F$35.zzzzzzzzzzzzVzzzjzNzzzTyu666VxZhhhPsE3/c3rbaLFzjhhhfTT333Ezzzyzzzzzxzzzzzzzz"
checkingame := "|<>*137$27.10U8A6MlCsn79n6QFD1kUNw"
telefail := "|<>*171$18.01UDVUMlUkNUk9Xk9aUBgk9skNwkNaMlWDVXU"
id17 := "|<>*165$34.0WNW4E4A2Am0TlsnD10QV8U6127X8"
telefailed2 := "|<>*149$52.0RllllnVU1zb77DaD3zkQQQ0MwDw0llk1bkzXX77DyD3yAASQSssU"
tab1 := "|<>*68$10.DkS8lkDVy7kCAFsDm"
tab2 := "|<>*108$13.3EgfKE38xhO6VU"
cancel := "|<>*139$46.Ns30M60lVUA1UMX6QMnYT2ADlnCFw0k1UAtUMz8"
vote := "|<>*66$47.Y03020018QD9611000C0C00042QEwkW8"
vote2 := "|<>*33$23.zzDzA08O000q111i007E"
card1 := "|<>*33$41.zzzzzv7zzzzzyA104M100000k00IkH1UkHdUaG1UbH1AU313"
card2 := "|<>*16$45.040FU400000A0044kH1UkHUa2N862S4kH80kEo"
falsecheck := "|<>*130$26.280wkU0D8141WEHW1iAsUPX0ACU"
yescheck := "|<>*109$13.nzn61014UUEMEA4E"

CheckLB() {
    if (ok := FindText(&X, &Y, 590, 108, 649, 150, 0, 0, LBCheck)) {
        AddToLog("Leaderboard late load in detected, closing")
        Sleep 100
        BetterClick(572, 105)
        sleep 300
        BetterClick(648, 104) ; close lb
    }
}

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

VoteStart() {
    BetterClick(371, 154)
}

AntiSoftlock() {
    if (ok := FindText(&X, &Y, 205, 104, 659, 508, 0, 0, OkayButton)) {
        BetterClick(X, Y)
    }
    if (ok := FindText(&X, &Y, 272, 269, 586, 405, 0, 0, CancelText)) {
        BetterClick(X, Y)
        Sleep 200
        BetterClick(573, 125) ; close settings
        Sleep 200

    }
    Disconect()
}

AntiSoftlock2() {
    if (ok := FindText(&X, &Y, 205, 104, 659, 508, 0, 0, OkayButton)) {
        BetterClick(X, Y)
    }
    if (ok := FindText(&X, &Y, 272, 269, 586, 405, 0, 0, CancelText)) {
        BetterClick(X, Y)
        Sleep 200
        BetterClick(573, 125) ; close settings
        Sleep 200
    }
    Disconect()
}

LookDown() {
    BetterClick(408, 336)
    sleep 300
    BetterClick(80, 320)
    sleep 300
    MouseClickDrag "Right", 80, 300, 80, 600
    sleep 300
    BetterClick(80, 320)
    sleep 300
    loop 40 {
        SendInput("{WheelDown}")
        Sleep 25
    }
}

PlaceUnit(x, y, slot) {
    if (ok:=FindText(&A, &B, 676-150000, 119-150000, 676+150000, 119+150000, 0, 0, lbcheckk) || ok:=FindText(&A, &B, 599-150000, 119-150000, 599+150000, 119+150000, 0, 0, lbcheckk4)) {
        CloseLB(A, B)
    }
    SendInput(slot)
    Sleep 500
    BetterClick(x+27, y+15)
    Sleep 50
    SendInput("q")
}

PlaceUnitCheck(x, y, slot) {
    AddToLog("Placing Farms Shibuya")
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 223, 339, 402, 389, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        else
        PlaceUnit(x, y, slot)
        sleep 500
        if (ok := FindText(&X, &Y, 77 - 150000, 417 - 150000, 77 + 150000, 417 + 150000, 0, 0, placed)) {
            Antisoftlock()
            Sleep 200
            BetterClick(400,620)
            break ; Exit loop
        }
    }
}

PlaceUnit2(x, y, slot) {
    if (ok:=FindText(&A, &B, 676-150000, 119-150000, 676+150000, 119+150000, 0, 0, lbcheckk) || ok:=FindText(&A, &B, 599-150000, 119-150000, 599+150000, 119+150000, 0, 0, lbcheckk4)) {
        CloseLB(A, B)
    }
    SendInput(slot)
    Sleep 500
    BetterClick(x, y)
    Sleep 50
    SendInput("q")
}

PlaceUnitCheck2(x, y, slot) {
    AddToLog("Placing unit")
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 223, 339, 402, 389, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        else {
            PlaceUnit2(x, y, slot)
            sleep 1000
            if (ok := FindText(&X, &Y, 77 - 150000, 417 - 150000, 77 + 150000, 417 + 150000, 0, 0, placed)) {
                Antisoftlock()
                BetterClick(400,620)
                break ; Exit loop
            }
        }
    }
}

UpgradeUnit2(x, y) {
    BetterClick(x, y)
    Sleep 50
    SendInput("t")
}

ChangePriority(x, y, n) {
    AddToLog("Changing Priority")
    loop n {
        Disconect()
        if (ok := FindText(&X, &Y, 223, 339, 402, 389, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        else
            BetterClick(x, y)
        Sleep 200
        SendInput("r")
    }
}

UpgradeFarm(x, y) {
    AddToLog("Upgrading Farms")
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 223, 339, 402, 389, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        else
            BetterClick(x+27, y+15)
        sleep 200
        SendInput("t")
        Sleep 1000
        if (ok := FindText(&X, &Y, 245-150000, 396-150000, 245+150000, 396+150000, 0, 0, MAXXED)) {
            break ; Exit loop
        }
    }
}

UpgradeFarm2(x, y) {
    AddToLog("Upgrading Farms")
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 223, 339, 402, 389, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        else
            BetterClick(x+1, y+1)
        sleep 200
        SendInput("t")
        Sleep 1000
        if (ok := FindText(&X, &Y, 245-150000, 396-150000, 245+150000, 396+150000, 0, 0, MAXXED)) {
            break ; Exit loop
        }
    }
}

UpgradeDps(x, y) {
    AddToLog("Upgrading DPS Units")
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        else
            BetterClick(x+27, y+15)
        SendInput("t")
        Sleep 500
    }
}
wincheck:="|<>*131$37.0zzzzzyPAUwCD0a0A27W004N3l0Am06lk6N7m0sbAk8E"
canup:="|<>*130$41.vs0000Tzs0000xxzDzzvVnzzzzz3bzzzzy7A60210CMA0420Qn30lUktY21m1071U3UE8S7UjUkTwznzzzztw7zzzzrwzzzy"
UpgradeDps2(x, y, n) {
    AddToLog("Upgrading DPS Units")
    i := 0
    sleep 500
    BetterClick(x, y)
    while (i < n) {
        sleep 500
        Disconect()
        if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        else {
            if (ok:=FindText(&X, &Y, 190-150000, 397-150000, 190+150000, 397+150000, 0, 0, canup)) {
                SendInput("t")
                Sleep 500
                i++
            }
        }
        if (ok:=FindText(&X, &Y, 476-150000, 322-150000, 476+150000, 322+150000, 0, 0, wincheck)) {
            AddToLog("Found win change to collect mode")
            loop {
                BetterClick(400,620)
                if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
                    AddToLog("Found return to lobby button")
                    EndscreenFuncs()
                    return
                }
            }
        }
    }
}

UpgradeDpsSkill(x, y, n) {
    AddToLog("Upgrading DPS Units")
    i := 0
    j := 0
    sleep 500
    BetterClick(x, y)
    while (i < n) {
        sleep 500
        Disconect()
        if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        else {
            if (ok:=FindText(&X, &Y, 190-150000, 397-150000, 190+150000, 397+150000, 0, 0, canup)) {
                SendInput("t")
                Sleep 500
                i++
            }
        }
        if (i = 10 && j = 0) {
            sleep 200
            BetterClick(318, 292)
            sleep 200
            BetterClick(373, 292)
            Sleep 200
            BetterClick(712, 454)
            Sleep 200
            BetterClick(715, 168)
            j  := 1
        }
        if (ok:=FindText(&X, &Y, 476-150000, 322-150000, 476+150000, 322+150000, 0, 0, wincheck)) {
            AddToLog("Found win change to collect mode")
            loop {
                Disconect()
                BetterClick(400,620)
                if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
                    AddToLog("Found return to lobby button")
                    EndscreenFuncs()
                    return
                }
            }
        }
    }
}

RestartMatch() {
    BetterClick(27, 610) ; settings
    Sleep 500
    BetterClick(523, 316) ; restart
    Sleep 500
    BetterClick(349, 343) ; confirm restart
    sleep 500
    if (ok := FindText(&X, &Y, 435 - 150000, 351 - 150000, 435 + 150000, 351 + 150000, 0, 0, cancel)) {
        BetterClick(404, 338)
    }
}

InitiateWebhook() {
    global WebhookURL := FileRead(WebhookURLFile, "UTF-8")
    global DiscordUserID := FileRead(DiscordUserIDFile, "UTF-8")

    if (webhookURL ~= 'i)https?:\/\/discord\.com\/api\/webhooks\/(\d{18,19})\/[\w-]{68}') {
        global webhook := WebHookBuilder(WebhookURL)
        SendWebhook()
    }
}

StopMacro() {
    global WebhookURL := FileRead(WebhookURLFile, "UTF-8")
    global DiscordUserID := FileRead(DiscordUserIDFile, "UTF-8")

    if (webhookURL ~= 'i)https?:\/\/discord\.com\/api\/webhooks\/(\d{18,19})\/[\w-]{68}') {
        global webhook := WebHookBuilder(WebhookURL)
        EndWebhook()
    }
    Reload()
}

BetterClick(x, y) {
    MouseMove(x-8, y-31)
    MouseMove(1, 0, , "R")
    MouseClick("Left", -1, 0, , , , "R")
}

CloseLB(x, y) {
    BetterClick(572, 105)
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

IngameCheck(status) {
    loop {
        Disconect()
        Sleep 100
        if (ok := FindText(&X, &Y, 693, 387, 838, 446, 0, 0, status)) || (ok := FindText(&X, &Y, 349, 489, 513, 548, 0,
            0, status)) {
            if (CurrentChallenge = "UnderGround Infinite") {
                AddToLog("Loaded into UnderGround Infinite")
            }
            else {
                AddToLog("Loaded into " modType " ")
            }
            SetupCamera()
            break
        }
    }
    return true
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

EndscreenFuncs() {
    Sleep 1000
    if (ok := FindText(&X, &Y, 178-150000, 165-150000, 178+150000, 165+150000, 0, 0, FailedText)) {
        AddToLog("Failed challenge, going back to lobby")
    }
    else {
        if (ok := FindText(&X, &Y, 195-150000, 166-150000, 195+150000, 166+150000, 0, 0, VictoryText)) {
            AddToLog("Detected Victory, going back to lobby")
        }
        else {
            AddToLog("Couldn't detect victory or fail, assuming victory")
        }
        ChallengeModUpdater()
    }
    Sleep 200
    BetterClick(171, 471) ; return to lobby
    sleep 200
    BetterClick(171, 471) ; return to lobby
    InitiateWebhook()
    if (CurrentChallenge != "UnderGround Infinite") {
        global startTime := A_TickCount
    }
    loop {
        Disconect()
        if (ok:=FindText(&X, &Y, 116-150000, 63-150000, 116+150000, 63+150000, 0, 0, gamecheck)) {
            break
        }
    }
    StartChallenge()
    return true
}

CardSelector() {
    AddToLog("Looking for Immunity Modifier")
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 401 - 150000, 171 - 150000, 401 + 150000, 171 + 150000, 0, 0, yescheck)) {
            BetterClick(X - 40, Y - 40)
        }
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
        }
        else {
            MouseMove(700, 500)
            loop {
                sleep 100
                Disconect()
                if (ok := FindText(&X, &Y, 425 - 150000, 414 - 150000, 425 + 150000, 414 + 150000, 0, 0, vote) || ok :=
                FindText(&X, &Y, 580 - 150000, 412 - 150000, 580 + 150000, 412 + 150000, 0, 0, vote2)) {
                    break
                }
                if (ok := FindText(&X, &Y, 395 - 150000, 508 - 150000, 395 + 150000, 508 + 150000, 0, 0, falsecheck)) {
                    break
                }
                if (ok := FindText(&X, &Y, 435 - 150000, 351 - 150000, 435 + 150000, 351 + 150000, 0, 0, cancel)) {
                    BetterClick(406, 342)
                    break
                }
            }
            if (ok := FindText(&X, &Y, 294 - 150000, 307 - 150000, 294 + 150000, 307 + 150000, 0, 0, card1) || ok := FindText(&X, &Y, 573 - 150000, 308 - 150000, 573 + 150000, 308 + 150000, 0, 0, card2)) {
                BetterClick(X, Y)
                break
            }
            else {
                AddToLog("Couldn't Find Immunity Card, Trying Again")
                BetterClick(260, 280)
                Sleep 500
                VoteStart()
                Sleep 5300
                Restartmatch()
            }
        }
    }
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
