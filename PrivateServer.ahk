#Requires AutoHotkey v2.0
PSLinkFile := "Lib\Settings\PSLink.txt"

PSLinkSettingsUI() {
    global PSLinkFile

    ; Load the saved PSLink value if it exists
    if FileExist(PSLinkFile)
        PSLinkBox.Value := FileRead(PSLinkFile, "UTF-8")

    ; Show the UI
    PSLinkGUI.Show("w300 h120")
}

SavePSLinkSettings() {
    global PSLinkFile, PSLinkBox

    ; Validate the input (optional, modify the condition if needed)
    if !(PSLinkBox.Value = "" || (RegExMatch(PSLinkBox.Value, "^https://www\.roblox\.com/games/\d+.*"))) {
        MsgBox("Invalid Private Server Link!", "Error", "+0x1000")
        PSLinkBox.Value := ""
        return
    }

    ; Save the new value
    if FileExist(PSLinkFile)
        FileDelete(PSLinkFile)

    FileAppend(PSLinkBox.Value, PSLinkFile, "UTF-8")

    ; Hide the UI
    PSLinkGUI.Hide()
}

; GUI Setup
PSLinkGUI := Gui("+AlwaysOnTop")
PSLinkGUI.SetFont("s8 bold", "Segoe UI")

PSLinkGUI.Add("Text", "x10 y8 cWhite", "Private Server Link")
PSLinkBox := PSLinkGUI.Add("Edit", "x10 y25 w280", "")

SavePSLinkButton := PSLinkGUI.Add("Button", "x170 y60 w120 +BackgroundTrans", "Save Link")
SavePSLinkButton.OnEvent("Click", (*) => SavePSLinkSettings())

PSLinkGUI.BackColor := "0c000a"
PSLinkGUI.MarginX := 20
PSLinkGUI.MarginY := 20
PSLinkGUI.OnEvent("Close", (*) => PSLinkGUI.Hide())
PSLinkGUI.Title := "Private Server Link Settings"