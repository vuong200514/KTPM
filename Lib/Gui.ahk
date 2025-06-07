#Requires AutoHotkey v2
#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk

DoDailyChallengeFile := "Lib\Settings\DoDailyChallenge.txt"

; Khởi tạo các thống kê ban đầu
GemsEarned := 0
GoldCoins := 0
TraitRerolls := 0
Bounties := 0
CurrentChallenge := "None"
ChallengeMods := ["1", "2", "3", "4", "1.5"]
StartTimeGUI := A_TickCount  ; Thời gian bắt đầu
RunningTime := "00:00:00"

; Các hình ảnh GUI
MinimizeImage := "Lib\Images\minimize.png"
CloseImage := "Lib/Images/close.png"
DiscordImage := "Lib\Images\Discord-Logo.png"
lastlog := ""

; Tạo GUI chính
MainGUI := Gui("-Caption +Border +AlwaysOnTop", "Vuong-Auto-Challenge")
MainGUI.BackColor := "3f3f44"
MainGUI.SetFont("s10 bold", "Segoe UI")

; Biến cho hiệu ứng
AnimationTimer := 0
GlowEffect := 0
StatsBlink := false
ActivityBlink := false


; Bắt đầu timer cho hiệu ứng
SetTimer(UpdateAnimations, 100)
SetTimer(UpdateRunTime, 1000)

; Thêm các phần tử vào GUI
AddGUIElements()

; Hiển thị GUI với chiều cao lớn hơn để chứa các phần mới
MainGUI.Show("x0 y0 w820 h920")

; Hàm để thêm các phần tử vào GUI
AddGUIElements() {
    global DoDailyChallengeBox, DoDailyChallengeFile ; Đảm bảo DoDailyChallengeBox là biến toàn cục

    MainGUI.Add("Picture", "x0 y0 w820 h920 +BackgroundTrans", "Lib/Images/background.jpg")
    ; Các nút trên thanh tiêu đề (giữ nguyên)
    MainGUI.Add("Picture", "x766 y12 w15 h5 +BackgroundTrans cffffff", MinimizeImage).OnEvent("Click", (*) =>
        MinimizeGUI())
    MainGUI.Add("Picture", "x790 y7 w15 h15 +BackgroundTrans cffffff", CloseImage).OnEvent("Click", (*) => ExitApp())

    ; Nút Settings với gradient style
    global SettingsBtn := MainGUI.Add("Button", "x380 y870 w130 h35 +0x1000", "⚙️ Settings")
    SettingsBtn.SetFont("s9 bold", "Segoe UI")
    ; Nút Connect to PS với glow effect
    global ConnectBtn := MainGUI.Add("Button", "x600 y870 w150 h35 +0x1000", "🎮 Connect to PS")
    ConnectBtn.SetFont("s9 bold", "Segoe UI")

    ; Background chính cho Roblox (giữ nguyên)
    MainGUI.AddProgress("c0x23232b x8 y27 h602 w800 +E0x20000", 100) ; màu tối hơn, +E0x20000 để làm mờ (nếu hỗ trợ)
    WinSetTransColor("0x23232b 220", MainGUI) ; mờ nhẹ

    MainGUI.SetFont("s12 bold", "Segoe UI")
    global TitleText := MainGUI.Add("Text", "x8 y5 w800 c0xFFD700 +Center +BackgroundTrans", "✨ Vuong Auto Challenge ✨")

    ; ========== CÁC PHẦN MỚI ĐƯỢC DI CHUYỂN XUỐNG DƯỚI ==========
    MainGUI.SetFont("s8", "Segoe UI") ; đồng bộ font nhỏ

    ; Hiện tại thử thách
    MainGUI.Add("GroupBox", "x10 y635 w300 h50 c0xfffc65 +BackgroundTrans +E0x20000", "🎯 Current Challenge")
    global ChallengeText := MainGUI.Add("Text", "x20 y660 w280 h20 c0xFFFFFF +BackgroundTrans +Center", CurrentChallenge)

    ; Nhật ký hoạt động
    MainGUI.Add("GroupBox", "x10 y690 w530 h160 c0xfffc65 +BackgroundTrans +E0x20000", "📝 Activity Log")
    global ActivityLog := MainGUI.Add("Edit", "x15 y710 w520 h135 c0xffffff -E0x200 +Left +VScroll ReadOnly", "🚀 Macro Launched Successfully!")
    ActivityLog.Opt("Background" . MainGUI.BackColor)  ; Dùng màu nền giống MainGUI (3f3f44)

    ; Thống kê
    MainGUI.Add("GroupBox", "x550 y690 w260 h160 c0xfffc65 +BackgroundTrans +E0x20000", "📊 Statistics")
    global RunTimeStat := MainGUI.Add("Text", "x555 y715 w250 h20 c0xFF69B4 +BackgroundTrans +Left", "⏱️ Runtime: " RunningTime)
    global GemsEarnedStat := MainGUI.Add("Text", "x555 y735 w250 h20 c0x7FFFD4 +BackgroundTrans +Left", "💎 Gems: " GemsEarned)
    global GoldCoinsStat := MainGUI.Add("Text", "x555 y755 w250 h20 c0xFFD700 +BackgroundTrans +Left", "🪙 Gold: " GoldCoins)
    global TraitRerollsStat := MainGUI.Add("Text", "x555 y775 w250 h20 c0xFFB6C1 +BackgroundTrans +Left", "🎲 Rerolls: " TraitRerolls)
    global BountiesStat := MainGUI.Add("Text", "x555 y795 w250 h20 c0x87CEEB +BackgroundTrans +Left", "🎯 Bounties: " Bounties)
    
    ; Checkbox chọn thử thách hàng ngày
    MainGUI.Add("GroupBox", "x330 y635 w480 h50 c0xfffc65 +BackgroundTrans +E0x20000", "⚙️ Options")
    global DoDailyChallengeBox := MainGUI.Add("Checkbox", "x850 y445 w200 h30 cffffff", "Daily Challenge")
    global WeekendBox := MainGUI.Add("Checkbox", "x850 y465 w200 h30 cffffff", "Weekend")

    ; Đọc giá trị từ tệp và cập nhật checkbox
    if FileExist(DoDailyChallengeFile) {
        saved := FileRead(DoDailyChallengeFile, "UTF-8")
        DoDailyChallengeBox.Value := (Trim(saved) = "1")
    } else {
        DoDailyChallengeBox.Value := false
    }

    ; Các phím tắt
    MainGUI.Add("GroupBox", "x10 y850 w530 h70 c0xfffc65 +BackgroundTrans +E0x20000", "⌨️ Keybinds")
    MainGUI.Add("Text", "x15 y870 w520 h15 c0xffffff +BackgroundTrans +Left", "🔧 F1 - Fix Roblox Position")
    MainGUI.Add("Text", "x15 y890 w520 h15 c0xffffff +BackgroundTrans +Left", "▶️ F2 - Start | ⏹️ F3 - Stop | ⏸️ F4 - Pause")

    ; Phiên bản phần mềm
    MainGUI.SetFont("s16 bold", "Segoe UI")
    MainGUI.Add("Text", "x8 y632 w800 cWhite +Center +BackgroundTrans", "Anime Vanguard Challenge")
}

UpdateGUI(CurrentChal) {
    ChallengeText.Value := CurrentChal
}

AddToLog(text) {
    global lastlog
    ActivityLog.Value := text "`n" ActivityLog.Value
}

MinimizeGUI() {
    WinMinimize("Vuong-Auto-Challenge")
}

UpdateStats(newGems := 0, newGold := 0, newRerolls := 0, newBounties := 0) {
    global GemsEarned, GoldCoins, TraitRerolls, Bounties
    global GemsEarnedStat, GoldCoinsStat, TraitRerollsStat, BountiesStat
    if (newGems != 0) {
        GemsEarned += newGems
        GemsEarnedStat.Value := "Gems Earned: " GemsEarned
    }
    if (newGold != 0) {
        GoldCoins += newGold
        GoldCoinsStat.Value := "Gold Coins Earned: " GoldCoins
    }
    if (newRerolls != 0) {
        TraitRerolls += newRerolls
        TraitRerollsStat.Value := "Trait Rerolls Earned: " TraitRerolls
    }
    if (newBounties != 0) {
        Bounties += newBounties
        BountiesStat.Value := "Bounties Completed: " Bounties
    }
}

UpdateAnimations() {
    global AnimationTimer, GlowEffect, StatsBlink, ActivityBlink
    global TitleText
    
    AnimationTimer++
    GlowEffect := Round(Sin(AnimationTimer * 0.1) * 30 + 70)
    
    ; Pulsing effect cho title
    if (Mod(AnimationTimer, 1) == 0) {
        try {
            TitleColor := Format("0x{:06X}", 0xFF0000 + (GlowEffect << 8))
            TitleText.Opt("c" . TitleColor)
        }
    }
    
    ; Blinking effect cho stats khi có cập nhật
    if (StatsBlink && Mod(AnimationTimer, 10) == 0) {
        try {
            StatsAlpha := (Mod(AnimationTimer, 20) < 10) ? 255 : 150
            ; Tạo hiệu ứng blink
            StatsBlink := false  ; Reset sau 1 lần blink
        }
    }
    
    ; Subtle glow cho các box
    if (Mod(AnimationTimer, 30) == 0) {
        try {
            ; Rotating glow colors cho các container
            GlowIntensity := Round(Sin(AnimationTimer * 0.05) * 20 + 50)
        }
    }
}

UpdateRunTime() {
    global StartTimeGUI, RunningTime, RunTimeStat
    
    ElapsedMs := A_TickCount - StartTimeGUI
    ElapsedSeconds := ElapsedMs // 1000
    
    Hours := ElapsedSeconds // 3600
    Minutes := (ElapsedSeconds - Hours * 3600) // 60
    Seconds := Mod(ElapsedSeconds, 60)
    
    RunningTime := Format("{:02d}:{:02d}:{:02d}", Hours, Minutes, Seconds)
    
    try {
        RunTimeStat.Value := "⏱️ Runtime: " . RunningTime
    }
}


DoDailyChallengeBox.OnEvent("Click", (*) => SaveDoDailyToFile())

SaveDoDailyToFile() {
    global DoDailyChallengeFile, DoDailyChallengeBox
    FileDelete(DoDailyChallengeFile)
    FileAppend(DoDailyChallengeBox.Value ? "1" : "0", DoDailyChallengeFile, "UTF-8")
}

