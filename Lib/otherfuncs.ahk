#Requires AutoHotkey v2
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include %A_ScriptDir%\AutoChallenge.ahk
#Include %A_ScriptDir%\Lib\gui.ahk
#Include %A_ScriptDir%\Lib\var.ahk
SendMode "Event"

TPtoSpawn() {
    Sleep 100
    BetterClick(26, 608) ; settings
    Sleep 400
    BetterClick(524, 240) ; spawn
    Sleep 300
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
        if (ok := FindText(&X, &Y, 223, 339, 402, 389, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            return
        }
        else
        PlaceUnit(x, y, slot)
        sleep 500
        if (ok := FindText(&X, &Y, 77 - 150000, 417 - 150000, 77 + 150000, 417 + 150000, 0, 0, placed)) {
            Sleep 200
            BetterClick(400,620)
            break ; Exit loop
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

Changecamera() {
    BetterClick(235, 441) ; use spectator
    Sleep 500
    BetterClick(334, 541) ; Pressleft
    Sleep 200
    BetterClick(479, 542) ; Pressright
    Sleep 300
    BetterClick(407, 611) ; leave spectator
}
