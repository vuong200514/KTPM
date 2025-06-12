#Requires AutoHotkey v2
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\WebHookSetting.ahk
#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include %A_ScriptDir%\AutoChallenge.ahk
#Include %A_ScriptDir%\Lib\GUI.ahk
#Include %A_ScriptDir%\Lib\Function.ahk
#Include %A_ScriptDir%\Lib\Var.ahk

MAXXED :=
    "|<>*130$24.DbziD7zz77zz240F00238Un7DUW3DY03Ta2vU"
upgrade7 := "|<>*80$17.zzzzzzzzzzzzzzk0VW0X7XaD7AySNswnntb7nDTaTzCDsQTtzzzzzzzzy"
placed :=
    "|<>*120$35.00s0003zs0C0A0E0y0E5zxC0XzzyA17m48A2109kM421knU8w3lb7ls733zrvS77zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk"
upgrade10 :=
    "|<>*78$82.rzzzzzzzzzzzzyzzzzzzzzzzzzzvzzzzzzzzzzzzzTzzzzzzzzzzzzxzzzzzzzzzzzzzrzzzzzzzzzzzzzTSTzzzztzsNlVxstzzzzz7zX237rXbzzzzwRy896TSCEA04211sV6Nxst0k0E843XYNbrnYE86840CSFaTTAF0UMUE1tt4Nxw30k1k847ba3brsQ7UjUkMSSQCTTzlxbzzzztzztxzzbkTzzzzlzy7rzyzbzzzzz7zwzTzzzzzzzzzzzzy"
last := "|<>*100$30.0000000000000007000sBU01g8UyxA8Xzz68W1238a0+38YF3C8wFV682012A313WDzzyyU"
strongest := "|<>*92$17.Fw11DyQ8a80D9AkGMlUszzS"
weakest := "|<>*111$26.6NU0nzw0MaNtw9aTz308M0E040611A1aFM0Na64U"
okaycheck := "|<>*185$31.y9b0Hz4X08zW1W4Tl1nX3lUtlk0kA0s0tX0SE"

;BeatStage
BeatStageDungeon() {
    PlaceUnitCheck2(469, 432, 2)
    PlaceUnitCheck2(510, 432, 2)
    PlaceUnitCheck2(550, 432, 2)

    PlaceUnitCheck2(548, 278, 1)

    PlaceUnitCheck2(317, 492, 5)

    PlaceUnitCheck2(420, 139, 4)
    ChangePriority(420, 139, 4)

    PlaceUnitCheck2(460, 139, 4)
    ChangePriority(460, 139, 4)

    PlaceUnitCheck2(500, 139, 4)
    ChangePriority(500, 139, 3)

    PlaceUnitCheck2(540, 139, 4)
    ChangePriority(540, 139, 3)

    UpgradeFarm2(469, 432)
    UpgradeFarm2(510, 432)
    UpgradeFarm2(550, 432)

    UpgradeDps2(317, 492, 10)
    loop {
        if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        sleep 200
        BetterClick(400,620)
    }
}

BeatStage() {
    global GemsEarned, GoldCoins, TraitRerolls

    ;ok
    if (CurrentChallenge = ShibuyaAftermathBounty) {
        if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
            AddToLog("Found return to lobby button")
            EndscreenFuncs()
            return
        }
        ;Place farm and unit
        PlaceUnitCheck(360, 140, 2)
        PlaceUnitCheck(400, 140, 2)
        PlaceUnitCheck(440, 140, 2)
        PlaceUnitCheck(400, 320, 5)
        PlaceUnitCheck(350, 330, 4)
        PlaceUnitCheck(460, 380, 4)
        ;Place Damage unit
        PlaceUnitCheck(450, 290, 4)
        PlaceUnitCheck(400, 400, 6)
        Sleep 100
        UpgradeDps2(430, 331, 12)
        Sleep 100
        ; Now wait for EndScreen to appear
        while !(ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
            Sleep 500  ; Check every 500 milliseconds
        }

        ; Once the loop exits, it means the EndScreen button was found
        AddToLog("Found return to lobby button")
        EndscreenFuncs()
        return
    }
    else if (CurrentChallenge = UnderGround) {
        PlaceUnitCheck2(200, 153, 5)
        PlaceUnitCheck2(240, 153, 6)
        PlaceUnitCheck2(280, 153, 4)
        PlaceUnitCheck2(357, 100, 1)
        PlaceUnitCheck2(357, 140, 1)
        PlaceUnitCheck2(357, 180, 1)

        UpgradeDps2(200, 153, 10)
        loop {
            if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
                AddToLog("Found return to lobby button")
                EndscreenFuncs()
                return
            }
            sleep 200
            BetterClick(400,620)
        }
    }
    else if (CurrentChallenge = EdgeOfHeaven) {
        PlaceUnitCheck2(300, 450, 2)
        PlaceUnitCheck2(340, 450, 2)
        PlaceUnitCheck2(380, 450, 2)

        PlaceUnitCheck2(130, 490, 6)
        PlaceUnitCheck2(664, 463, 4)
        PlaceUnitCheck2(700, 463, 4)
        
        UpgradeFarm2(300, 450)
        UpgradeFarm2(340, 450)

        PlaceUnitCheck2(402, 277, 5)
        UpgradeDpsSkill(402, 277, 10)

        loop {
            if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
                AddToLog("Found return to lobby button")
                EndscreenFuncs()
                return
            }
            sleep 200
            BetterClick(400,620)
        }
    }
    ;ok
    else if (CurrentChallenge = "UnderGround Infinite") {
        loop {
            Disconect()
            elapsedMinutes := (A_TickCount - startTime) / 60000
            AddToLog("Minute: " elapsedMinutes)
            if (elapsedMinutes >= 29.4) {
                AddToLog("Challenge reseted, going challenge")
                Disconect()
                ChallengeModUpdater()
                TPtoLobby()
                InitiateWebhook()
                loop {
                    Disconect()
                    sleep 100
                    if (ok := FindText(&X, &Y, 120 - 150000, 324 - 150000, 120 + 150000, 324 + 150000, 0, 0, store)) {
                        break
                    }
                }
                StartChallenge()
                return
            }

            ; Close Restart
            AntiSoftlock2()
            CheckLB()

            ; Detect End Screen
            if (ok := FindText(&X, &Y, 342 - 150000, 135 - 150000, 342 + 150000, 135 + 150000, 0, 0, EndScreen)) {
                if (elapsedMinutes >= 29.4) {
                    Disconect()
                    AddToLog("Found return to lobby button")
                    EndscreenFuncs()
                }
                else {
                    AddToLog("Restarting Inf")
                    RestartMatch()
                    VoteStart()
                    Disconect()
                }
                return
            }

            ; Place units
            PlaceUnit2(200, 153, 5)
            PlaceUnit2(240, 153, 6)
            PlaceUnit2(280, 153, 4)
            PlaceUnit2(357, 100, 1)
            PlaceUnit2(357, 140, 1)
            PlaceUnit2(357, 180, 1)
            sleep 300
            BetterClick(200, 153)
            sleep 300
            SendInput("t")
            sleep 300
            BetterClick(240, 153)
            sleep 300
            SendInput("t")
            sleep 300
            Disconect()
        }
    }
}

Placespeedo() {
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            BetterClick(385, 471) ; Replay
        }

        CheckLB()
        BetterClick(371, 154) ; Press yes
        Sleep 500
        PlaceUnit2(408, 345, 2) ; Place Speed
        Sleep 500
        if (ok := FindText(&X, &Y, 471 - 150000, 173 - 150000, 471 + 150000, 173 + 150000, 0, 0, Placed)) {
            if (CurrentChallenge = PlanetNamek) {
                PlayNamek()
            }
            else if (CurrentChallenge = marshalisland) {
                PlayMarshalisland()
            }
            else if (CurrentChallenge = Landofgods) {
                PlayLandofTheGod()
            }
            else if (CurrentChallenge = Kuinshi) {
                PlayKuinshi()
            }
            else if (CurrentChallenge = ShibuyaAftermathBounty) {
                PlayShibuyaAfterMath()
            }
            else if (CurrentChallenge = ShibuyaStation) {
                PlayShibuya()
            }
            else if (CurrentChallenge = Castle) {
                PlayCastle()
            }
            else if (CurrentChallenge = ShibuyaStationBounty) {
                PlayShibuyaBounty()
            }
            else if (CurrentChallenge = SandVillage) {
                PlaySand()
            }
            else if (CurrentChallenge = SandVillageBounty) {
                PlaySand()
            }
            else if (CurrentChallenge = DoubleDungeonGodStatue) {
                PlayDungeonGodStatue()
            }
            else if (CurrentChallenge = DoubleDungeon) {
                PlayDungeon()
            }
            else if (CurrentChallenge = SpiritSociety) {
                PlaySpirit()
            }
            else if (CurrentChallenge = UnderGround) {
                PlayUnderground()
            }
            else if (CurrentChallenge = EdgeOfHeaven) {
                PlayEdgeofHeaven()
            }
            else {
                PlayUndergoundInf()
            }
        }
        else {
            TPtoSpawn()
        }
    }
}