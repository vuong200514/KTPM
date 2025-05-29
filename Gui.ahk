#Requires AutoHotkey v2

DoDailyChallengeFile := "Lib\Settings\DoDailyChallenge.txt"

StartTimeGUI := A_TickCount
RunningTime := "00:00:00"

;Biến
MinimizeImage := "Lib\Images\minimize.png"
CloseImage := "Lib\Images\close.png"
LogoImage := "Lib\Images\Logo.png"
DiscordImage := "Lib\Images\Discord-Logo.png"
lastlog := ""

;Tạo GUI
MainGUI := Gui("-Caption +Border +AlwaysOnTop", "Vuong-Auto-Challenge")
MainGUI.BackColor := "3f3f44"
MainGUI.SetFont("s10 bold", "Segoe UI")
AddGUIElements()
MainGUI.Show("x0 y0 w820 h920")

;Thêm phần tử vào GUI
AddGUIElements() {
    global DoDailyChallengeFile

    MainGUI.Add("Picture", "x0 y0 w820 h920 +BackgroundTrans")
    MainGUI.Add("Picture", "x766 y12 w15 h5 +BackgroundTrans cffffff", MinimizeImage).OnEvent("Click", (*) =>
        MinimizeGUI())
    MainGUI.Add("Picture", "x790 y7 w15 h15 +BackgroundTrans cffffff", CloseImage).OnEvent("Click", (*) => ExitApp())

    MainGUI.AddProgress("c0x23232b x8 y27 h602 w800 +E0x20000", 100)
    WinSetTransColor("0x23232b 220", MainGUI)

    MainGUI.SetFont("s12 bold", "Segoe UI")
    global TitleText := MainGUI.Add("Text", "x8 y5 w800 c0xFFD700 +Center +BackgroundTrans", "✨ Vuong Auto Challenge ✨")

    MainGUI.SetFont("s8", "Segoe UI")

    MainGUI.Add("GroupBox", "x10 y635 w300 h50 c0xfffc65 +BackgroundTrans +E0x20000", "🎯 Current Challenge")

    MainGUI.Add("GroupBox", "x10 y690 w530 h160 c0xfffc65 +BackgroundTrans +E0x20000", "📝 Activity Log")

    MainGUI.Add("GroupBox", "x550 y690 w260 h160 c0xfffc65 +BackgroundTrans +E0x20000", "📊 Statistics")

    MainGUI.Add("GroupBox", "x330 y635 w480 h50 c0xfffc65 +BackgroundTrans +E0x20000", "⚙️ Options")

}


MinimizeGUI() {
    WinMinimize("Vuong-Auto-Challenge")
}
