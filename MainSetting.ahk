#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2
#Include %A_ScriptDir%\Lib\WebHookSetting.ahk
#Include %A_ScriptDir%\Lib\PrivateServer.ahk
global MainSettings
; Create the initial GUI
MainSettings := Gui("+AlwaysOnTop")
MainSettings.SetFont("s8 bold", "Segoe UI")

; Set GUI properties
MainSettings.BackColor := "0c000a"
MainSettings.MarginX := 20
MainSettings.MarginY := 20
MainSettings.OnEvent("Close", (*) => MainSettings.Hide())
MainSettings.Title := "Main Settings UI"

MainSettings.Add("GroupBox", "x10 y20 w340 h60 +Center c5de0f1", "Misc Settings")

; Add Launch Button
Webhookbttn := MainSettings.Add("Button", "x20 y45 w150", "Webhook Settings")
Webhookbttn.OnEvent("Click", (*) => WebhookSettingsUI())

PSbttn := MainSettings.Add("Button", "x190 y45 w150", "Auto Reconnect Settings")
PSbttn.OnEvent("Click", (*) => PSLinkSettingsUI())

; Show the initial GUI
OpenMainSettings() {
    global MainSettings
    MainSettings.Show("w360 h100")
}
