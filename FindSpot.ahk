#Requires AutoHotkey v2

#Include %A_ScriptDir%\AutoChallenge.ahk
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\Function.ahk
#Include %A_ScriptDir%\Lib\AHKv2-Gdip-master\Gdip_All.ahk
#Include %A_ScriptDir%\Lib\BeatStage.ahk

namekright4 :=
    "|<>*64$29.0zzzy0zzzw1zzzs1zzzk1zzzU1zzz03zzy03zzw03zzs03zzs07zzk07zzU07zzU07zz00Dzy00Dzy00Dzw00Dzs00Tzs00Tzk00TzU00TzU00zz000zy000zy000zw000zs001zs001zz001zzzk1"
namekrightplace :=
    "|<>*82$37.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzw3zzzzz000Tzzk003zzs001zzy000zzz000Tzzk00Dzzw007zzw003zzw001zzs000zzy000Tzz000Dzz0007zz0003zy0001zU0000y00000T00000DU00007k00003w00001y00000U"
namekright2 :=
    "|<>*87$34.zs0003zU1U0Dz0000zw0003zs000DzU000zz0003zk000Dy0000zs0003z0000Ds0000z000000000000000000000000000000000000000000000000000000000800000U000v20003y0000Dk0000y00003k0000C00003s00007s0000DU000Ey0003W"
namekright3 := "|<>*64$30.zzU01zz003zz003zz007zy00Tzw00DzU001s0001w0001s0001s0001k0003k0007k0007U"
sandright:="|<>*82$13.03k0s0Q0B02U18040100000000000E080200U08040100E0802000000000000000000000002"
sandright2 := "|<>*87$9.zzzTsR3Us60k60k61kU"
dungeonrightplace :=
    "|<>*187$59.z1zzzzzzzzz1zzzzzzzzz1zzUTzzzzy3zU01zzzzy3w000zzzzy307y0Dzzzw43zzkDzzzw0TzzsDzzzw3zzzw7zzzsDzU1w7zzzVz0Dwy7zzy7w1zyC7zTwTUzzzSDyTlwzzzzSDwT3r7zzywDsAD01zzywDk8y00NzwwS01w000zxsU07k000zts00DU000Dtk00y0000Dlk81w0000DnXk3k0000Db7UD00000TCD0S00000SSS0w00000wwQ1k00000tss3U00001Xlk60000037XUA000003D70M000006S00k00000Aw21U00000Ps63007zU07UC600DzU0D0T600TzU0S0yA00zzU1s1wA01zzU3k3wS07zzU7U7sw3zzz0S0Dsw7zzy0w0TksDzzs3k0zlsTzzUD01zVkTzz0y03zVsTzw3s07zVszzkTU0Dz1sDz0y03zz1sDw3kTzzzVzzkD1zzzzUzzDs7zzzzUDzz0zzzzzU7zk3zzzzzk000Tzzzzzw003zzzzzzz00zzzzzzzzzzzzzzzzzzzzzzztzzzzzzzzzkzzzzzzzzzk"
undergroundrightplace :=
    "|<>*128$52.001zzzzzw003zzzzzs003zzzzzU007zzzzz0007zzzzy000Dzzzzw0001zzzzs0000zzzrs0000Tzz7k0000300Dk0000000Tk0000000zU0000003zU000003zz000000zVz000003s3zk0007zU3zz00DzzZzzzsTzzzvzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"
undergroundinfrightplace :=
    "|<>*128$52.001zzzzzw003zzzzzs003zzzzzU007zzzzz0007zzzzy000Dzzzzw0001zzzzs0000zzzrs0000Tzz7k0000300Dk0000000Tk0000000zU0000003zU000003zz000000zVz000003s3zk0007zU3zz00DzzZzzzsTzzzvzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"
spiritrightplace :=
    "|<>*113$53.zzzzzzzzzzzzzzzzU3zzzzzzs07zzzzzzlsDzzzzzz2UTzzzzzy00zzzzzzw01zzzzzzk03zzzwDzU07zzzQry00DzzzTvs00Tzzxzxk00zzzvzxk01zzzjzxU03zzzTzxU07zzxzzv00Dzzvzzs00Tzzzzzk00zzzzwTU01zzyzkT003zzzzkC007zzxzkA00Dzzzzk000Tzzvzk000zzzrzs001zzzrzs003zzzrzk007zzzvz000Dzzzxt000TzzzwS000zzzzzw001zzzzzs003zzzzbk007zzzzDU00Dzzzzz000Tzzzzy000zzzzzw001zzzzzs003zzzzzs007zzzzrk00DzzzzjU00TzzzzT000U"
shibuyaaftermathrightplace :=
    "|<>*52$61.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzvzzzzzzzzztzzzzzzzzzszzzzzzzzzsTzzzzzzzzsDzzzzzzzzs7zzzzzzzzs3zzzzzzzzs7zzzzzzzzs7zzzzzzzzs7zzzzzzzzs7zzzzzzzzs7zzzzzzzzk7zzzzzzzzk7zzzzzzzzk7zzzzzzzzk7zzzzzzzzk7zzzzzzzzk7zzzzzzzzk7zzzzzzzzk7zzzzzzzzk7zzzzzzzzkDzzzzzzzzkDzzzzzzzzkDzzzzzzzzkDzzzzzzzzUDzzzzzzzzUDzzzzzzzzUDzzzzzzzzUDzzzzzrzzUDzzzzzxzzUDzzzzzzTzUDzzzzzzrzUDzzzzzzxzUDzzzzzzzzUTzzzzzzzzUTzzzzzzzzUTzzzzzzzzUTzzzzzzzr0Tzzzzzzzx0Tzzzzzzzz0TzzzzzzzzkTzzzzzzzzwTzzzzzzzzzTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk"
kuinshirightplace :=
    "|<>*94$32.0DzDzk3znzw0zwzz0DzDzk3znzw0zszz0DyDzk3zXzw0zszz0TyDzk7z7zw1zlzz0TsTzk7y7zw1zVzz0TsTzk7z7zw1zVzz0TsTzk7y7zw1z3zz0Tkzzk7wDzw1z3zz0Tkzzk7wDzw1z3zz0TkzzkDwDzw3z3zz0zVzzkDsTzw3y7zz0zVzzkDsTzw3y7zz0zVzzkDsTzw3w7zz0z3zzkDkzzw3wDzy0z3zzUDkzzs3wDzy0z3zzc"
kuinshi2 := "|<>*82$18.zzyzzyzzwzzszzkzzUzz0zy0zC0S60200000s0US10b01s018U3Uk7ws3y81zV0U"
kuinshi3:="|<>*62$39.zs04007z01k00zs0C007z01y00zs0Dy07zU3zzzzzzzzzzzzzzzzzzzzzzsTkDzzz1z0DzzsDs0Tzz0zU3zzs7w0Tk00zk3z007y0ks00zs03007zU0M00zy03007zw0800zzU1007zz0A00zzs1U4"
GodStatue :=
    "|<>*101$127.003zy00007zzzzzzzzzzk00Dzw00001zzzzzzzzzzw00zzU00w00zzzzzzzzzzy01zy000y00Dzzzbxzzzzz07zw000N007zzznsCzzzzUTzk000AVyzzzztwaDzzzszy00006FVmQBjYyT3YtC6Ts000039UEA21UT31UM61Dk00001an96NAmDkFmAXAr000000ns5n0aNbzAvatUE000000NwyFbnAntaQn8ns000000A230kNa1w361UMA00000061VyQBvoz7nYzC60000003zzzDzzzzzzzzbz0000000zbcATzzzzzzw7zU000000007Q7zzzzzzzjzk000000001w3zzzzzzzzzs00000000001zzzzzzzzzw00000000000000000007y00000000000000000000T000000000000000000007k00000000000000000001s00D00000000000Q000DUQ00Dvk00007k000T07kDs600ADw00006A000Rk3wCC300A3aD0kE43000AMzbA3UU061Xzzzz60U006DzXq0kM03DkRjPlnAETs63skPAMA01Vk820UMs8Tz31k0BsA600k840006Q4Tzn0M06Q6300C2AM60XT280NU8yDT31U0Bl6A301glY0BU0T7Alkk048V000DY8nzyk00Vo8kM030ME410n0Ezylw0MP0MQ01kQA30kMkM00My8QBkQC00TvzzgTwDs007lzzyTw7003kQTUPs30001kRsQ3s7U00000MQ0000000000007k00000Dw0000000000007w"
Placed :=
    "|<>*77$49.jDzzzzwzXbzzzzwTlnzzzzyCst0k0E844QUM08421CF0UMUE0a8UEAE80kA3070UEQC3kLkMADz7mTzzzzzXsDzzzzzvyTzzzzU"
RewardsFailed :=
    "|<>*141$47.0Tz6Dzzs0zzwTzznzzzsz7zby0Mls3U0M0lXU700k1X72401XX6CA8tz76AQ0lnyAAMszX7w0MkkX0Dw0lUk70TwFbXkD4U"
checkingame := "|<>*94$28.SEA1Zt4W6LYm090HAA6"
checkingame2 := "|<>*68$28.m1UAX8YEmAaEP82NVUW"
checkingame3 := "|<>*49$25.8YEm4m3N3NVUo"
sandcancell := "|<>*120$23.21k0410ElUMVU8lnbs210k0U"

RobloxWindow := "ahk_exe RobloxPlayerBeta.exe"


PlaySand() {
    AddToLog("Waiting for Sand map to load in...")
    loop {
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            BetterClick(385, 471) ; Replay
        }
        Disconect()
        sleep 100
        if (ok := FindText(&X, &Y, 454 - 150000, 526 - 150000, 454 + 150000, 526 + 150000, 0, 0, checkingame) || ok :=
        FindText(&X, &Y, 457 - 150000, 526 - 150000, 457 + 150000, 526 + 150000, 0, 0, checkingame2) || ok := FindText(&
            X, &Y, 457 - 150000, 526 - 150000, 457 + 150000, 526 + 150000, 0, 0, checkingame3)) {
            break
        }
    }
    BetterClick(572, 103) ; close lb
    Sleep 100
    LookDown()
    Sleep 500
    BetterClick(371, 154) ; Press yes
    Sleep 500
    AddToLog("Placing Speedwagon to set-up cam")
    PlacespeedoSand()
}

PlayMarshalisland() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            RestartMatch()
            Sleep 200
            BetterClick(400, 310) ; cancel
            Sleep 500
            SendInput ("{s up}")
            Sleep 100
            SendInput ("{s down}")
            Sleep 3500
            SendInput ("{s up}")
            Sleep 500
            BetterClick(400, 310) ; cancel incase it missed
            Sleep 200
            BetterClick(371, 154) ; Press yes
            sleep 500
            KeyWait "a" ; Wait for "a" to be fully processed
            AddToLog("Cam is set-up, beating stage")
            BeatStage()
        }
    }
}

PlayLandofTheGod() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            Sleep 200
            SendInput ("{a up}")
            Sleep 100
            SendInput ("{a down}")
            Sleep 3000
            SendInput ("{a up}")
            Sleep 200
            SendInput ("{s up}")
            Sleep 100
            SendInput ("{s down}")
            Sleep 1000
            SendInput ("{s up}")
            RestartMatch()
            Sleep 200
            CardSelector()
            Sleep 500
            BetterClick(371, 154) ; Press yes
            sleep 500
            AddToLog("Cam is set-up, beating stage")
            BeatStage()
        }
    }
}

PlayDungeonGodStatue() {
    loop {
        Disconect()
        CheckLB()

        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            RestartMatch()
            Sleep 200
            BetterClick(400, 330) ; Click incase it restart before wave 1
            Sleep 500
            SendInput ("{a up}")
            Sleep 100
            SendInput ("{a down}")
            Sleep 2000
            SendInput ("{a up}")
            BetterClick(406, 342)  ; click modifer card
            Sleep 200
            BetterClick(406, 342)  ; click modifer card
            Sleep 200
            BetterClick(400, 310) ; cancel incase it missed
            Sleep 200
            BetterClick(371, 154) ; Press yes
            sleep 500
            KeyWait "a" ; Wait for "a" to be fully processed
            AddToLog("Cam is set-up, beating stage")
            BeatStageDungeon()
        }
    }
}

PlayCastle() {
    loop {
        Disconect()
        CheckLB()

        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            RestartMatch()
            CardSelector()
            Sleep 500
            BetterClick(371, 154) ; Press yes
            sleep 500
            AddToLog("Cam is set-up, beating stage")
            BeatStage()
        }
    }
}

PlayKuinshi() {
    loop {
        Disconect()
        CheckLB()

        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            Placespeedo()
        }
        else {
            Sleep 1000
            AddToLog("Checking if in the right spawn")
            if (ok := FindText(&X, &Y, 462 - 150000, 462 - 150000, 462 + 150000, 462 + 150000, 0, 0, kuinshirightplace) ||
            ok := FindText(&X, &Y, 822 - 150000, 589 - 150000, 822 + 150000, 589 + 150000, 0, 0, kuinshi2) || ok:=FindText(&X, &Y, 745-150000, 490-150000, 745+150000, 490+150000, 0, 0, kuinshi3)) {
                RestartMatch()
                CardSelector()
                Sleep 500
                BetterClick(371, 154) ; Press yes
                sleep 500
                AddToLog("Cam is set-up, beating stage")
                BeatStage()
                Sleep 500
            }
            else {
                if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
                    Sleep 500
                    BetterClick(385, 471) ; Replay
                    Sleep 2000
                    if !(ok := FindText(&X, &Y, 613 - 150000, 471 - 150000, 613 + 150000, 471 + 150000, 0, 0,
                        RewardsFailed)) {
                        AddToLog("Found Fail Menu, Retrying")
                        Placespeedo()
                    }
                }
                else {
                    AddToLog("Wrong spawn, trying again")
                    TPtoSpawn()
                    Sleep 600
                    Changecamera()
                }

            }
        }
    }
}

PlayNamek() {
    loop {
        Disconect()
        CheckLB()

        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            Sleep 1000
            AddToLog("Checking if in the right spawn")
            if (ok := FindText(&X, &Y, 270 - 150000, 159 - 150000, 270 + 150000, 159 + 150000, 0, 0, namekrightplace) ||
            ok := FindText(&X, &Y, 683 - 150000, 494 - 150000, 683 + 150000, 494 + 150000, 0, 0, namekright2) || ok :=
            FindText(&X, &Y, 357 - 150000, 473 - 150000, 357 + 150000, 473 + 150000, 0, 0, namekright3) || ok :=
            FindText(&X, &Y, 107 - 150000, 494 - 150000, 107 + 150000, 494 + 150000, 0, 0, namekright4)) {
                RestartMatch()
                Sleep 200
                BetterClick(400, 330) ; Click incase it restart before wave 1
                Sleep 500
                VoteStart() ; Press yes
                AddToLog("Cam is set-up, beating stage")
                BeatStage()
                Sleep 500
            }
            else {
                if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
                    Sleep 500
                    BetterClick(385, 471) ; Replay
                    Sleep 2000
                    if !(ok := FindText(&X, &Y, 613 - 150000, 471 - 150000, 613 + 150000, 471 + 150000, 0, 0,
                        RewardsFailed)) {
                        AddToLog("Found Fail Menu, Retrying")
                        Placespeedo()
                    }
                }
                else {
                    AddToLog("Wrong spawn, trying again")
                    TPtoSpawn()
                    Sleep 600
                    Changecamera()
                }

            }
        }
    }
}

PlayShibuya() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 471 - 150000, 173 - 150000, 471 + 150000, 173 + 150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            RestartMatch()
            Sleep 200
            BetterClick(400, 330) ; Click incase it restart before wave 1
            sleep 500
            BetterClick(371, 154) ; Press yes
            sleep 500
            AddToLog("Cam is set-up, beating stage")
            BetterClick(406, 342)  ; click modifer card
            Sleep 500
            BetterClick(406, 342)  ; click modifer card
            BeatStage()

        }
    }
}

shibuyaright2 :=
    "|<>*52$32.zzzzwDzzzy3zzzz0zzzzUDzzzk7zzzs3zzzw1zzzy1zzzz0zzzzUTzzzkDzzzs7zzzs3zzzw1zzzy0zzzz0TzzzUDzzzk7zzzs3zzzw1zzzy1zzzz0zzzzUTzzzkDzzzk7zzzs3zzzw1zzzz0zzzzkTzzzwDzzzz7zzzznzzzzxzzzzzU"

PlayShibuyaAfterMath() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            Sleep 1000
            AddToLog("Checking if in the right spawn")
            if (ok := FindText(&X, &Y, 270 - 150000, 159 - 150000, 270 + 150000, 159 + 150000, 0, 0,
                shibuyaaftermathrightplace) || ok := FindText(&X, &Y, 580 - 150000, 501 - 150000, 580 + 150000, 501 +
                    150000, 0, 0, shibuyaright2)) {
                RestartMatch()
                CardSelector()
                Sleep 500
                BetterClick(371, 154) ; Press yes
                sleep 500
                AddToLog("Cam is set-up, beating stage")
                BeatStage()
                Sleep 500

            }
            else {
                if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
                    Sleep 500
                    BetterClick(385, 471) ; Replay
                    Sleep 2000
                    if !(ok := FindText(&X, &Y, 613 - 150000, 471 - 150000, 613 + 150000, 471 + 150000, 0, 0,
                        RewardsFailed)) {
                        AddToLog("Found Fail Menu, Retrying")
                        Placespeedo()
                    }
                }
                else {
                    AddToLog("Wrong spawn, trying again")
                    TPtoSpawn()
                    Sleep 600
                    Changecamera()
                }

            }
        }
    }
}

PlayShibuyaBounty() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            sleep 500
            RestartMatch()
            Sleep 200
            BetterClick(371, 154) ; Press yes
            Sleep 200
            BetterClick(400, 330) ; Click incase it restart before wave 1
            AddToLog("Cam is set-up, beating stage")
            BeatStage()

        }
    }
}
TestfixSandFarm() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 525 - 150000, 325 - 150000, 525 + 150000, 325 + 150000, 0, 0, sandcancell)) {
            BetterClick(400, 310) ; cancell
        }
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            PlacespeedoSandFarm()
        }
        else {
            Sleep 1500
            AddToLog("Checking if in the right spawn")
            if (ok:=FindText(&X, &Y, 686-150000, 455-150000, 686+150000, 455+150000, 0, 0, sandright) ||
                ok:=FindText(&X, &Y, 560-150000, 212-150000, 560+150000, 212+150000, 0, 0, sandright2)) {
                BetterClick(400, 330) ; Click incase it restart before wave 1
                sleep 500
                SendInput ("{w up}")
                Sleep 100
                SendInput ("{w down}")
                Sleep 2500
                SendInput ("{w up}")
                KeyWait "w" ; Wait for "w" to be fully processed
                Sleep 500
                SendInput ("{d up}")
                Sleep 100
                SendInput ("{d down}")
                Sleep 2500
                SendInput ("{d up}")
                KeyWait "d" ; Wait for "w" to be fully processed
                Sleep 500
                SendInput ("{s up}")
                Sleep 100
                SendInput ("{s down}")
                Sleep 1000
                SendInput ("{s up}")
                KeyWait "s" ; Wait for "w" to be fully processed
                Sleep 500
                RestartMatch()
                Sleep 500
                if (ok := FindText(&X, &Y, 379, 205, 488, 255, 0, 0, Startercard)) {
                    CardSelector()
                    Sleep 500
                    BetterClick(371, 154) ; Press yes
                    sleep 500
                    AddToLog("Cam is set-up, beating stage")
                    BeatStage()
                }
                else {
                    BetterClick(406, 342)  ; click modifer card
                    Sleep 500
                    BetterClick(405, 310) ; close restart
                    Sleep 500
                    BetterClick(371, 154) ; Press yes
                    sleep 500
                    AddToLog("Cam is set-up, beating stage")
                    BeatStage()
                    Sleep 500
                }
            }
            else {
                if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
                    Sleep 500
                    BetterClick(385, 471) ; Replay
                    Sleep 2000
                    if !(ok := FindText(&X, &Y, 613 - 150000, 471 - 150000, 613 + 150000, 471 + 150000, 0, 0,
                        RewardsFailed)) {
                        AddToLog("Found Fail Menu, Retrying")
                        PlacespeedoSandFarm()
                    }
                }
                else {
                    AddToLog("Wrong spawn, trying again")
                    TPtoSpawn()
                    Sleep 500
                    Changecamera()
                }
            }
        }
    }
}

TestfixSand() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            PlacespeedoSand()
        }
        else {
            Sleep 1000
            AddToLog("Checking if in the right spawn")
            if (ok:=FindText(&X, &Y, 455-150000, 91-150000, 455+150000, 91+150000, 0, 0, sandright) ||
                ok:=FindText(&X, &Y, 560-150000, 212-150000, 560+150000, 212+150000, 0, 0, sandright2)) {
                RestartMatch()
                Sleep 200
                BetterClick(400, 330) ; Click incase it restart before wave 1
                sleep 500
                SendInput ("{w up}")
                Sleep 100
                SendInput ("{w down}")
                Sleep 2500
                SendInput ("{w up}")
                KeyWait "w" ; Wait for "w" to be fully processed
                Sleep 500
                SendInput("{d up}") ; Ensure key is released
                Sleep 100
                SendInput ("{d down}")
                Sleep 4000
                SendInput ("{d up}")
                KeyWait "d" ; Wait for "d" to be fully processed}
                Sleep 500
                SendInput("{s up}") ; Ensure key is released
                Sleep 100
                SendInput ("{s down}")
                Sleep 2000
                SendInput ("{s up}")
                KeyWait "s" ; Wait for "d" to be fully processed}
                BetterClick(406, 342)  ; click modifer card
                Sleep 500
                BetterClick(406, 342)  ; click modifer card
                Sleep 200
                BetterClick(400, 310) ; cancel incase it missed
                Sleep 200
                BetterClick(371, 154) ; Press yes
                sleep 500
                BeatStage()
                Sleep 500
            }
            else {
                if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
                    Sleep 500
                    BetterClick(385, 471) ; Replay
                    Sleep 2000
                    if !(ok := FindText(&X, &Y, 613 - 150000, 471 - 150000, 613 + 150000, 471 + 150000, 0, 0,
                        RewardsFailed)) {
                        AddToLog("Found Fail Menu, Retrying")
                        PlacespeedoSand()
                    }
                }
                else {
                    AddToLog("Wrong spawn, trying again")
                    TPtoSpawn()
                    Sleep 600
                    Changecamera()
                }

            }
        }
    }
}

PlayDungeon() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            RestartMatch()
            Sleep 200
            BetterClick(400, 330) ; Click incase it restart before wave 1
            sleep 500
            BetterClick(406, 342)  ; click modifer card
            Sleep 200
            BetterClick(400, 310) ; cancel incase it missed
            Sleep 200
            BetterClick(371, 154) ; Press yes
            sleep 500
            AddToLog("Cam is set-up, beating stage")
            BeatStage()

        }
    }
}

PlaySpirit() {
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            if (ok := FindText(&X, &Y, 651 - 150000, 569 - 150000, 651 + 150000, 569 + 150000, 0, 0, spiritrightplace)) {
                RestartMatch()
                Sleep 200
                BetterClick(400, 330) ; Click incase it restart before wave 1
                sleep 500
                BetterClick(406, 342)  ; click modifer card
                Sleep 500
                BetterClick(406, 342)  ; click modifer card
                Sleep 200
                BetterClick(400, 310) ; cancel incase it missed
                Sleep 200
                BetterClick(371, 154) ; Press yes
                sleep 500
                AddToLog("Cam is set-up, beating stage")
                BeatStage()
                Sleep 500

            }
            else {
                if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
                    Sleep 500
                    BetterClick(385, 471) ; Replay
                    Sleep 2000
                    if !(ok := FindText(&X, &Y, 613 - 150000, 471 - 150000, 613 + 150000, 471 + 150000, 0, 0,
                        RewardsFailed)) {
                        AddToLog("Found Fail Menu, Retrying")
                        Placespeedo()
                    }
                }
                else {
                    AddToLog("Wrong spawn, trying again")
                    TPtoSpawn()
                    Sleep 600
                    Changecamera()
                }
            }
        }
    }
}

PlayUnderground() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()

        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            RestartMatch()
            Sleep 200
            BetterClick(400, 330) ; Click incase it restart before wave 1
            Sleep 200
            BetterClick(406, 342)  ; click modifer card
            Sleep 500
            BetterClick(406, 342)  ; click modifer card
            Sleep 200
            BetterClick(400, 310) ; cancel incase it missed
            Sleep 200
            BetterClick(371, 154) ; Press yes
            sleep 500
            Sleep 200
            BetterClick(371, 154) ; Press yes
            Sleep 500
            AddToLog("Cam is set-up, beating stage")
            BeatStage()
        }
    }
}

PlayUndergoundInf() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            RestartMatch()
            Sleep 200
            BetterClick(400, 330) ; Click incase it restart before wave 1
            sleep 500
            BetterClick(371, 154) ; Press yes
            sleep 500
            AddToLog("Cam is set-up, beating stage")
            BeatStage()
        }
    }

}

PlayEdgeofHeaven() {
    loop {
        Disconect()
        CheckLB()
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            BetterClick(385, 471) ; Replay
            sleep 2000
            Placespeedo()
        }
        else {
            TPtoSpawn()
            Sleep 500
            Changecamera()
            Sleep 200
            SendInput ("{d up}")
            Sleep 100
            SendInput ("{d down}")
            Sleep 2000
            SendInput ("{d up}")
            Sleep 100
            RestartMatch()
            Sleep 200
            CardSelector()
            Sleep 500
            BetterClick(371, 154) ; Press yes
            sleep 500
            AddToLog("Cam is set-up, beating stage")
            BeatStage()
        }
    }
}

PlacespeedoSandFarm() {
    loop {
        Disconect()
        if (ok := FindText(&X, &Y, 525 - 150000, 325 - 150000, 525 + 150000, 325 + 150000, 0, 0, sandcancell)) {
            BetterClick(400, 310) ; cancell
        }
        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            BetterClick(400, 310) ; Replay
        }

        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
        }
        else
            CheckLB()
        if (ok := FindText(&X, &Y, 525 - 150000, 325 - 150000, 525 + 150000, 325 + 150000, 0, 0, sandcancell)) {
            BetterClick(400, 310) ; cancell
        }
        sleep 200
        if (ok := FindText(&X, &Y, 525 - 150000, 325 - 150000, 525 + 150000, 325 + 150000, 0, 0, sandcancell)) {
            BetterClick(400, 310) ; cancell
        }
        sleep 200
        BetterClick(385, 471) ; Replay
        Sleep 250
        BetterClick(371, 154) ; Press yes
        Sleep 500

        SendInput ("{w up}")
        Sleep 100
        SendInput ("{w down}")
        Sleep 2800
        SendInput ("{w up}")
        KeyWait "w" ; Wait for "w" to be fully processed

        if (ok := FindText(&X, &Y, 525 - 150000, 325 - 150000, 525 + 150000, 325 + 150000, 0, 0, sandcancell)) {
            BetterClick(400, 310) ; cancell
        }
        PlaceUnit(420, 315, 2) ; Place Speed
        Sleep 500
        if (ok := FindText(&X, &Y, 471 - 150000, 173 - 150000, 471 + 150000, 173 + 150000, 0, 0, Placed)) {
            TestfixSandFarm()
        }
        else {
            TPtoSpawn()
        }
    }
}

PlacespeedoSand() {
    loop {
        if (ok := FindText(&X, &Y, 525 - 150000, 325 - 150000, 525 + 150000, 325 + 150000, 0, 0, sandcancell)) {
            BetterClick(400, 310) ; cancell
        }
        Disconect()

        if (ok := FindText(&X, &Y, 179-150000, 166-150000, 179+150000, 166+150000, 0, 0, RewardsFailed)) {
            Sleep 500
            BetterClick(385, 471) ; Replay
        }
        else
            if (ok := FindText(&X, &Y, 525 - 150000, 325 - 150000, 525 + 150000, 325 + 150000, 0, 0, sandcancell)) {
                BetterClick(400, 310) ; cancell
            }
        CheckLB()
        BetterClick(385, 471) ; Replay
        Sleep 250
        BetterClick(371, 154) ; Press yes
        Sleep 500
        SendInput ("{w up}")
        Sleep 100
        SendInput ("{w down}")
        Sleep 2800
        SendInput ("{w up}")
        KeyWait "w" ; Wait for "w" to be fully processed

        PlaceUnit(427, 315, 2) ; Place Speed
        Sleep 500
        if (ok := FindText(&X, &Y, 471 - 150000, 173 - 150000, 471 + 150000, 173 + 150000, 0, 0, Placed)) {
            TestfixSand()
        }
        else {
            TPtoSpawn()
        }
    }
}