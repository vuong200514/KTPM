#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2
#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include %A_ScriptDir%\Lib\AHKv2-Gdip-master\Gdip_All.ahk
#Include %A_ScriptDir%\AutoChallenge.ahk
#Include %A_ScriptDir%\Lib\WebHookSetting.ahk

WebhookURLFile := "Lib\Settings\WebhookURL.txt"
DiscordUserIDFile := "Lib\Settings\DiscordUSERID.txt"
SendActivityLogsFile := "Lib\Settings\SendActivityLogs.txt"

SendWebhook() {
    global MacroStartTime, GemsEarned, GoldCoins, TraitRerolls, Bounties, webhook, DiscordUserID

    UserIDSent := (DiscordUserID = "") ? "" : "<@" DiscordUserID ">"

    ElapsedTimeMs := A_TickCount - MacroStartTime
    ElapsedTimeSec := Floor(ElapsedTimeMs / 1000)
    ElapsedHours := Floor(ElapsedTimeSec / 3600)
    ElapsedMinutes := Floor(Mod(ElapsedTimeSec, 3600) / 60)
    Runtime := Format("{}h {}m", ElapsedHours, ElapsedMinutes)

    pToken := Gdip_Startup()
    if !pToken {
        MsgBox("Failed to initialize GDI+")
        return
    }

    pBitmap := Gdip_BitmapFromScreen()
    if !pBitmap {
        MsgBox("Failed to capture the screen")
        Gdip_Shutdown(pToken)
        return
    }

    pCroppedBitmap := CropImage(pBitmap, 27, 15, 1100, 640)
    if !pCroppedBitmap {
        MsgBox("Failed to crop the bitmap")
        Gdip_DisposeImage(pBitmap)
        Gdip_Shutdown(pToken)
        return
    }

    statsText := ""
    statsText .= "💎 **Gems:** " GemsEarned "`n"
    statsText .= "🪙 **Gold Coins:** " GoldCoins "`n"
    statsText .= "🔁 **Trait Rerolls:** " TraitRerolls "`n"
    statsText .= "🎯 **Bounties Completed:** " Bounties

    attachment := AttachmentBuilder(pCroppedBitmap)

    myEmbed := EmbedBuilder()
    .setTitle("✅ Challenge Completed!")
    .setDescription("📊 **Macro Runtime:**" . Runtime . "`n" . statsText)
    .setColor(0x32CD32)
    .setImage(attachment)
    .setFooter({ text: "Vuong Macro | AutoHotkey", icon_url: "https://cdn-icons-png.flaticon.com/512/3658/3658752.png" })
    .setAuthor({ name: "Discord Bot", icon_url: "https://cdn-icons-png.flaticon.com/512/4712/4712007.png" })
    .setTimeStamp()

    webhook.send({
        content: (UserIDSent),
        embeds: [myEmbed],
        files: [attachment]
    })

    Gdip_DisposeImage(pBitmap)
    Gdip_DisposeImage(pCroppedBitmap)
    Gdip_Shutdown(pToken)
}

EndWebhook() {
    global MacroStartTime, GemsEarned, GoldCoins, TraitRerolls, Bounties, webhook, DiscordUserID

    UserIDSent := (DiscordUserID = "") ? "" : "<@" DiscordUserID ">"

    ElapsedTimeMs := A_TickCount - MacroStartTime
    ElapsedTimeSec := Floor(ElapsedTimeMs / 1000)
    ElapsedHours := Floor(ElapsedTimeSec / 3600)
    ElapsedMinutes := Floor(Mod(ElapsedTimeSec, 3600) / 60)
    Runtime := Format("{}h {}m", ElapsedHours, ElapsedMinutes)

    statsText := ""
    statsText .= "💎 **Gems:** " GemsEarned "`n"
    statsText .= "🪙 **Gold Coins:** " GoldCoins "`n"
    statsText .= "🔁 **Trait Rerolls:** " TraitRerolls "`n"
    statsText .= "🎯 **Bounties Completed:** " Bounties

    myEmbed := EmbedBuilder()
    .setTitle("🛑 Macro Stopped")
    .setDescription("📊 **Macro Runtime:**" . Runtime . "`n" . statsText)
    .setColor(0xFF4500) ; orange red
    .setFooter({ text: "Vuong Macro | AutoHotkey", icon_url: "https://cdn-icons-png.flaticon.com/512/3658/3658752.png" })
    .setAuthor({ name: "Discord Bot", icon_url: "https://cdn-icons-png.flaticon.com/512/4712/4712007.png" })
    .setTimeStamp()

    webhook.send({
        content: (UserIDSent),
        embeds: [myEmbed],
        files: []
    })
}

TextWebhook() {
    global MacroStartTime, GemsEarned, GoldCoins, TraitRerolls, Bounties, webhook, DiscordUserID, lastlog

    ElapsedTimeMs := A_TickCount - MacroStartTime
    ElapsedTimeSec := Floor(ElapsedTimeMs / 1000)
    ElapsedHours := Floor(ElapsedTimeSec / 3600)
    ElapsedMinutes := Floor(Mod(ElapsedTimeSec, 3600) / 60)

    myEmbed := EmbedBuilder()
    .setTitle("")
    .setDescription("[" FormatTime(A_Now, "hh:mm tt") "] " lastlog)
    .setColor(0x0A97B0)

    webhook.send({
        content: "",
        embeds: [myEmbed],
        files: []
    })
}

CropImage(pBitmap, x, y, width, height) {
    pGraphics := Gdip_GraphicsFromImage(pBitmap)
    if !pGraphics {
        MsgBox("Failed to initialize graphics object")
        return
    }

    pCroppedBitmap := Gdip_CreateBitmap(width, height)
    if !pCroppedBitmap {
        MsgBox("Failed to create cropped bitmap")
        Gdip_DeleteGraphics(pGraphics)
        return
    }

    pTargetGraphics := Gdip_GraphicsFromImage(pCroppedBitmap)
    if !pTargetGraphics {
        MsgBox("Failed to initialize graphics for cropped bitmap")
        Gdip_DisposeImage(pCroppedBitmap)
        Gdip_DeleteGraphics(pGraphics)
        return
    }

    Gdip_DrawImage(pTargetGraphics, pBitmap, 0, 0, width, height, x, y, width, height)

    Gdip_DeleteGraphics(pGraphics)
    Gdip_DeleteGraphics(pTargetGraphics)

    return pCroppedBitmap
}

WebhookSettingsUI() {
    if FileExist(WebhookURLFile)
        WebhookURLBox.Value := FileRead(WebhookURLFile, "UTF-8")

    if FileExist(DiscordUserIDFile)
        DiscordUserIDBox.Value := FileRead(DiscordUserIDFile, "UTF-8")

    if FileExist(SendActivityLogsFile)
        SendActivityLogsBox.Value := (FileRead(SendActivityLogsFile, "UTF-8") = "1")

    WebhookGUI.Show("w300 h150")
}

SaveWebhookSettings() {
    if !(WebhookURLBox.Value = "" || RegExMatch(WebhookURLBox.Value, "^https://discord\.com/api/webhooks/.*")) {
        MsgBox("Invalid Webhook URL! Please enter a valid Discord webhook URL.", "Error", "+0x1000")
        WebhookURLBox.Value := ""
        return
    }

    if !(RegExMatch(DiscordUserIDBox.Value, "^\d*$")) {
        MsgBox("Invalid Discord User ID! Please enter a valid Discord User ID or keep it empty.", "Error", "+0x1000")
        DiscordUserIDBox.Value := ""
        return
    }

    WebhookGUI.Hide()

    if FileExist(WebhookURLFile)
        FileDelete(WebhookURLFile)
    if FileExist(DiscordUserIDFile)
        FileDelete(DiscordUserIDFile)
    if FileExist(SendActivityLogsFile)
        FileDelete(SendActivityLogsFile)

    FileAppend(WebhookURLBox.Value, WebhookURLFile, "UTF-8")
    FileAppend(DiscordUserIDBox.Value, DiscordUserIDFile, "UTF-8")
    FileAppend(SendActivityLogsBox.Value ? "1" : "0", SendActivityLogsFile, "UTF-8")
}

WebhookGUI := Gui("+AlwaysOnTop")
WebhookGUI.SetFont("s8 bold", "Segoe UI")
WebhookGUI.Add("Text", "x10 y8 cWhite", "Webhook URL")
WebhookURLBox := WebhookGUI.Add("Edit", "x10 y22 w280", "")
WebhookGUI.Add("Text", "x10 y56 cWhite", "Discord User ID (optional)")
DiscordUserIDBox := WebhookGUI.Add("Edit", "x10 y70 w280", "")
SendActivityLogsBox := WebhookGUI.Add("Checkbox", "x10 y109 cWhite", "Webhook Activity Logs")
SaveWebhook := WebhookGUI.Add("Button", "x170 y105 w120 +BackgroundTrans", "Save Settings")
SaveWebhook.OnEvent("Click", (*) => SaveWebhookSettings())

WebhookGUI.BackColor := "0c000a"
WebhookGUI.MarginX := 20
WebhookGUI.MarginY := 20
WebhookGUI.OnEvent("Close", (*) => WebhookGUI.Hide())
WebhookGUI.Title := "Webhook Settings"