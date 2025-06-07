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
