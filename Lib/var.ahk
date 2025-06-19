#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include %A_ScriptDir%\Lib\AHKv2-Gdip-master\Gdip_All.ahk
#Include %A_ScriptDir%\Lib\GUI.ahk
#Include %A_ScriptDir%\Lib\Function.ahk
#Include %A_ScriptDir%\Lib\WebHookSetting.ahk
#Include %A_ScriptDir%\Lib\FindSpot.ahk
#Include %A_ScriptDir%\Lib\BeatStage.ahk
SendMode "Event"

global MacroStartTime := A_TickCount
global resizetimecheck := A_TickCount

CurrentChallengeMod := ""
GemsEarned := 0
GoldCoins := 0
TraitRerolls := 0
StatChips := 0
SuperStatChips := 0
GreenEssence := 0
ColoredEssence := 0
Bounties := 0

Startercard :=
    "|<>*138$45.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy7TzyzzzUnzzbzzwyDzwTzzXUU011Vw640480DwH63a07xmAUQEQzUsU3l1by762yABzzzzzzzzzzzzzzzzzzzzzzzU"
OkayButton :=
    "|<>*177$64.zzzzzzzzzzzzzzlzzzzzzzs7y7zzzzzzy07sTzzzzzzk0DVzzzzzzy00S7zzzzzzkD0sTzzzzzz1y1VzzzjDxsDw67bs0MTVVzsMQD01Vy67zVVUs063kMTy60300Q73VzsM0Q71kMC7zVU3ky7UVsDw60T3sS07kTUM0Q71w0z0w3U0k87s3y00S61U0TUDw03sQ601z1zs0TVsQ07w7zs7z7nwQTkzzzzzzzzzy3zzzzzzzzzsTzzzzzzzzz1zzzzzzzzzwDzzzzzzzzzkzzzzzzzzzzbzzzzzzzzzzzy"
VictoryText :=
    "|<>*129$46.0AM00001zlnyTzXzT7wTyvPUE30Q0D40081k4QE61U30kl7wSCATWATlsslq0lb7XX6A20A60AMkO0kQ1lVVg7lsD66AznzzzkEm"
EndScreen := "|<>*72$93.zzzzzzzzzzzzzzzs3s3zVzw7k7k0w3s0707k3y0C0C030C00M0Q0DU1k0k0E1U7373VkwCSC64CCQMwMwMT77zlslzlzX7X7X7wMzyD20S1w0sMwMzX70lkk1k3U03037wMs6060DUD00s0szX7sk1k3z0y0D077sMT60CDyS4szssQS7VklklzlkX7z7XU1w06D6020A0zswS0Tk1lsE0E1U7z7nw7zUyDa07Uz4"

IngameStatus := "
(
|<>*102$35.000000TC0001Xy00063AyTD8iDzzzMs8423kEE843sH4607Ma840Q3210UwD631Vjvzwby71WsBs000Nk0000T04
|<>*55$44.00000000000000000000000zU00000zg00000s31tMSQw0zzzzzyD1sMS6DbkA4311twG94W2TDAaH9U7k3A4n13y0nVAsETzzzzwbzzzzzz3zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy
)"
ChallengeStart :=
    "|<>*109$62.000000000003k00000000333k0000w0109a0000NU0k1EU00048080I800012027/3nzjzkw0VxU52C8M1087E1U1U40E20A0E0M1040E1UA060s303UQD3VVv3U3y32lcMEEU0XkkwA644A0MMA701V11U6070k0MEEA0k3M606461061X3sXX0kk0zkTXzjU7s01U000000000000000000U"
LobbyCheck := "|<>*132$26.ANk4k6Ml43aAMDtk63yA1m"
CreateMatch :=
    "|<>*130$104.000000000000001k0007s000C01sS0Q0y0003bU007k0zDUDUAU001UQVUZ4AAq9+8PA000k7zzzlzn73zXznk00AzVkt8C6kkmEQQC002Ds84210w084230k00WCSN8lnD82FXYkA00Azb03AM3m86Mlwn0036NlwX6Dwy96APAk00s6S10skDDW1lUnA0071bksCC7nAkQQAn0zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs"
CreateMatchall := "|<>*153$38.zzzzzzzzzzzzzzzzzzzwDzznzyTzzwzzjl324DnxqoHPyzM9YUzUrD14zwBsstXzzzzzzzzzzzzzU"
UnitExistence :=
    "|<>**77$52.000000000ts00007U6qU0000m0PG0000381hDzzzzwzaokMAA623PH1UkUE9BbAknAlQ0mQmNBt4UD871UnUE88kwD3P3VkVyrdD7zzy03MUU000005XC000000Q7U0000U"
Act6Text :=
    "|<>FEFEFE-0.90$71.00000000000000000000000000000000000000000000000000000000000000000000000000000000000D000080003U0l0000s060A0020001k0A0U00A0006kwy3000s000AX9k7U00E7y0la1UAk00EDw1zA30MU0lU0063M60l00y000A2SC0y00s000E0840k000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001"

BountySuffix := "|<>*73$20.zzzzzzzzzzzzzyBkzUM7k60w16DAFXXYQttaASMbDa1rxszzzzzzzs"
ZeroBounty := "|<>*83$23.WTw60PnA07aQnzAtbzNn6y3U"
TenBounty := "|<>*90$12.zzzztXl1UNsNsRtNt1tXzzzzU"
TenBounty2 := "|<>*75$13.vVlUMk0FW8lYQnANWQkDSC"
BossStart :=
    "|<>*142$59.00000000000000000000000000000000000000000y000000003bD0003k00A3H0004k00E3W000MU01XD7Dzzlk037w3lAX0k063k70M41U061kA0kA300C1lslXwQ1zzXXnX7szzzb77X6Dlzzz0C70ATVzzy0Q70Mz1zzz3yD4nzXzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
LegendStage :=
    "|<>*95$45.zzzzzzzw0000000U00000040000000U0000004c00Fc00d300400R9647248d00W0005+0aQYV0ckUA4U05121lW48jzkvvzVxzyDzzwTjzzzzzzw0000000zzzzzzzzzzzzzzzU"
regularchallenges :=
    "|<>*97$181.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzDzzzzzzDzzwtzzzzzzzzzzz0TzzzzzXzzzzw3XzzyATzzzzzzzzzzU3zzzzzlzzzzw0Fzzz6Dzzzzzzzzzzk1zzzzzszzzzw08zzzX7zzzzzzzzzzssSDzzzwTzzzwDATzzlXwTzzzz7szzwSA1k376D0A1yDy0y0Mls30D0C0k7zyC40k1XX7060z7z0C0AMs1U7060M3zz02480llXU30z3zU306AQ8E1U324TzzU364MMslllXzlzllXX6CA8slVX21zzk104CAQMkslzszssVlX60AQEsU3UTzsslz264AQMMzw7AQMklXXyCA8MzsDzwQ81U30660ATz02CA0MEE3760A0l7zyD60s1k31U6Dzk1770A8A1XXU70M3zz7XUS8wFlsX7zw3XXl7670llsXkC3zzzzzysTzzzzzzzzzzzzzzzzzvVzzzzzzzzy0Tzzzzzzzzzzzzzzzzzs1zzzzzzzzz0Dzzzzzzzzzzzzzzzzzw0zzzzzzzzzsTzzzzzzzzzzzzzzzzzzVzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"

PlanetNamek := "|<>*74$64.3XU1U03k0lU6A06006034A8k0M00M0A0k37VVVVXkk7UAS6C66D30T0ksMsMMQA1y301XVVU0k3sC06C67036Dks0ssQQ0QQU"
SandVillage :=
    "|<>*71$48.07zzzzzk07zzzzzk7Dzzzzzk7zl74DwE1z0307k00C0303k0U60301U0s6733VVkz2D37VXkD2737VVk66037VU007037Vk00D037Vs0U"
DoubleDungeon :=
    "|<>*69$61.3sM0QC60671yA4673013Uy6D33VVkXkT37VVkksFsD3VkksMQ8w01kEM0A0ACU"
ShibuyaStation := "|<>*70$73.klwT4TsTs1sXsEwC07w3s0k0gAC603z0A0E0K63301zk30M0D3V3Vkzy1kwC7Vs1lsTzsMSD3kw1sQDswAD3VUT0w07wAC7U0kDUz03y07Us0M7sTU1zU7kQ0C"
UnderGround := "|<>*71$100.7sl3z4D0wEsFW70yATX07k0s0k3060M1sFyA0D0303080M103V7sk0M0ACA5U1Ug464TX3VVkkskyD67lsMlwAS6D3037swMz7VX7klsMQA0QTVVXwS64477VU0kzly06DkEM00QS703037w0MzU3kU"
SpiritSociety := "|<>*74$74.1z0760MU3w7y81k0lU680zU730A0AM/X0Tw0kw33V67ssTzkATsFsFXyC7zzV4S4CAMzXVzlsF33036DssTwAA00k1lXyD1z03W"
Landofthegods := "|<>*87$54.kS0C00w00kS0A00w00kS0A3UM60kT0A7kMD0kTsA7kMDUkDsA7kMD0U"
EdgeOfHeavenBounty := "|<>*99$54.z1w07k0A701s03U0A701k63U0A301kT30kC301kS31sD1zVk031wD1zVk071sDUzVkTz1sDUzVkDj00DkzVs07U0DkzVs07k0DszVw07s0DwU"
Landofgods := "|<>*71$31.zzUTszzU7kC1U1s60kEM3UMwADwAS6DT6D33W311U8"
ShinningCastleBounty := "|<>*101$62.3z00S300S307k03Uk03Uk0Q00sA00sA030sC30sC3A0kT1UkT1UnsA7kMA7kMAz31w631w637kkT1UkT1UksA7kMA7kMA031w631w6301kT1UkT1Uk0w7kMA7kMAU"

ShibuyaAftermathchallenge := "|<>*69$83.k3k00M0k3007U1U3U00U1U60060267U033X1Q00A04ADVsS767sMMMQ00D3kw0ATlkkls00S7Vs0szXVVVk00QD3kzlz73300DksS1U1XyC6702"

Castlechallenge := "|<>*71$60.Dzk3kw0C0AS1U1kw0A0AQ1UUls0ACAS1XklsQACADVXklswA0A7lXklsQA0Q11UUks0ADw01k1kQ0A0AU"
Golden := "|<>*88$92.U03zzz1zzUzzzzzk7VzzzkTzsDzzzzw7yzw7w7z63y1yCD3zzw0T1z00y0D10kzzy03kTU0D01k04D0700Q7k03U0A003k1U071w00k63000w0M70kS1UA7UkC0DU63sA7Uw31sA7k3z1Uy31sDUk031w0TkMDUkS3kA01kT03w63kA7UQ31zw7kU01U070M00kDj1w8"
marshalisland := "|<>*77$95.00k0M104M0ATw81X0FU0kr0Mk0Mzslz61X7VVz3lXklzlUCC76D37y7X7VXzXUASSAS6DwD6D37z7UMzwM0ATsSA067yCsEU"
marshalislandbounty := "|<>*98$89.0y0Tnnssw0SDwww1s0y03U0k0MDU0s1U1s0701U0kS01k003U0C0301Us03W04700Q06031k0760MA30s7z1y30kCC0kMD1kTy3w63kQQ3UkT3Uzw7sA7kswD1Uw71zsDkMD1lyy31sC3zkTUkS3Xzw600Q7zUT1U077zsC00sDz0C3U0CDzkS01kTz0Q7U0T"
Landofgodsbounty := "|<>*87$66.0zzy0Dw03U11zzw07s03U11s0s03k03011s0k03k031v1s0kC1UM30z1w0kT1Uw3U31zUkT1Uy3U10zUkT1Uw3k0UTUkS1UQ3w0k00k03U03bUk00s03k0300U"
SpiritSocietyBounty := "|<>*89$91.7zw0Ts0kT07U0Vz0zw07s08D01U00T01w01s04700M08DU0Q00s0630MA063U061kA3b1Uw7Uz0lk31w63zUkS3kTkEz1Uy31zkM01sDs0DkET1UzsA01w7y03kMD0kCQ63zy3z00kA00s0630yz0Tk00700S011k0DU7w207k0TU0Us07s3y1U"
PlanetNamekBounty := "|<>*102$84.7sA7w2710zk1s07sA7s0700TU0s07sA7k0700D00M03UQ7k0700C0kM000Q7UM70sC3sS300w7Uw71w63kS301w7Uy71w600S303w7Uw71w600y37zw7Uw71w63zy37zw1U071w61zy17zw1k071w700y07zy0s071w700z0U"
SandVillageBounty := "|<>*100$61.UDz00s03w0E0z00Q00w0A07U0C00S0701UM70sC1nw0kS3Uy31tzkMDVkT1UybwA7UsDUkT0y63kQ7kM70C300C3sC04"
DoubleDungeonBounty := "|<>*87$93.7w7s0y3sA03sDs0szkS03kT1U0D1y037y3U0C3sA00sDU08zkM01kT1U071s217y30s63sA3UMD1s8zkMDUkT1Uy31sD17w31w63sA7kMD008z0sDUkT1Uy31s037k71s61kA3UMD1zs01s01s01U070M7r00TU0D00A00s1U0Q"
ShibuyaStationBounty := "|<>*83$95.1zs0DU0s0A7k1w020TU0S00U0MD01s000700s0100kQ01k040701U0301Uk03U0A07Uz0k7Uz1UQ30sT0D1y3kD1y31w63szkC3w7US3w63sA7kDkQ7sD0w7sA7kMDUD1sDkC1sDkMD0kT0A3k7U03k7Uk01Uy007U7U07U71k071wE"
Castle :=
    "|<>*87$195.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzszzwzzzzzzzzzzzzzzzzzwTzzzzz1zzzy3zz3zzzzzzzzVzzzzzzzz1zzzzz03zzzkTzsDzzzzzzzk1zzzzzyDsDzzzzk07zzy3zz1zzzzzzzs03zzzzzUz1zzzzs00zzzkTzsDzzzzzzy00Tzzzzw7sDzzzz007zzy3zz1zzzzzzzU03zzzzzUz1zzzzk7VzzzkTzsDzzzzzzs1kTzzzzw7sDzzzy3zTy3y3zX1z0z77zz0zjwQTUS071zkDzUTzz07kTk0DU3kEDzkDzy03k0k0MDs0zw7zzk0S3w01s0C00zy3zzU0C04031y03zUw0Q01kT00C00k03zkTzs01U0U0MDU0Dw7U300C3s01U8600Ty3zy00A7i031s21zUw0M70kS1UA7UkC1zkTzkA1UTw7sD1sDw7k31w63kS1Uw63sDy3zy3kC0DUz1sD1zUzkMDUkS3sA00kT1zkTzkS1k0w7sD00Dw3y31w63kS1U0C3sDy1zy3kD03Uz1s03zkDkMD0kS1kA7zkT1zs7skC1y0Q7sD1zzz00300C0k01UTS3sDz00200CS3UD0M7rzs00Q01k300C01kT1zw00M01U0Q0s1U0TzU07k0T0Q01k0C3sDzk03U0A03k7UA03zy01z07s3k0T01kT1zzU0y03U0y0w1k0Tzw0zw1zUzX3y0T7wTzz0TsMT0Tw7kTU7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzw"
UndergroundChurchBounty := "|<>*84$136.TsA01y00w0701k0A0701sDVzUk03k03U0A0600k0M03Uy7y300D00A10k0E030100C3sTsA3UM60kS30z0kA3w3UMDVzUkT1Uw31sA7w7UkTkT1Uy7y31w63sA00kTkS31z1w63sDkA7kMD0k071z1sA7w7kMDUT1kT1UQ31zw7w30kTkS1UQ0071w600A3vkTk031z0070000w7kQ00s071zU0A7y00w02"
ShibuyaAftermathBounty := "|<>*84$139.s1zkT1zzzzzzzzzzzzy3w7zs0zU007y1yCD77lzwQQ0C37w0Dk001w0S0311UDs0C0310w07k000w0701U003s0201U0C21s000Q01U0k001s0100k021Uy000A10k0M000s00k0M011kDkT1y3kM7w30kA30S3w3U007sDUz1sA7y3UQ63kD1y3s001w7kTU063z1kS31s7Uz1w000y3sDk071zUsD1Uw3kTUy000D1w7sDzUzkQ7UkC1sDkT0007Uy0w3vkTsC3kM00w1sDUDy3kTUD00sDw71sC00S0Q7kE"
Kuinshi :=
    "|<>*84$203.bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzxzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwTzzzzz7zyDzzzzzzz7zzzzzzzzzzTwzzzkTzzzzw7zsDzUDzzzw7zzzzzzzzzsDkzzzUzzzzzsDzkTw03zzzsDzzzzzzzzzkT0zzz1zzzzzkTzUzs01zzzkTzzzzzzzzzUw1zzy3zzzzzUzz1zk01zzzUzzzzzzzzzz1k7zzzzzzzzz1zzzzU03zzz1zzzzzzzzzy3UTzzzzzzzzy3zzzz1s3zzy3zzzzzzzzzw61wTlswQTy1w6DwTy3w7wQQ7z77y3zUTzs87kT1Uk0Dk0s87kTw7sDU0sDs0Dk1w0Tzk0TUy31U0DU1k07UzsDkS00kTU0D01k0TzU1z1w6300C03U071zkT0s01Uy00Q0300Tz07y3sA600Q7j00C3zU01U031s00k0A10zy07w7kMA3UM7y1kA7z0070k63kA1UQsD1zw07sDUkMDUs0w7kMDy00S3kA7Uw31zkS3zs07kT1UkT1k0sDUkTw01w7UMD1s63zU07zkE7Uy31Uy3k0kT1Uzs07sD0kS3kA7z00TzUk70s631w7s1Uy31zkTzkC1Uw3UM7C3zzz1k700A63sCS31w63zUzzU030M00k0A3vzy3kC00MA7kM063sA7z1zzU060M01k0A03zw7kC00kMDUk0A7kMDy3zzU0C0s03k0M03zsDky01UkT1U0sDUkTw7zzU0w1s0Dk1s0Dzszny77Xlz7k7szXlzwTzzVVw7sMTkDw0zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk"
Kuinshi1 := "|<>*83$81.UT1w6300z03UUM7sDUkM03s0Q011z1w6300C03U00TsDUkM01kSw001z1w630s61zUQ07sDUkMDUs0w7k0T1w631w703Uy41sDUkMDUw0A7kk70s631w7s1Uy70Q00kMDUtsA7kU"
KuinshiChallenge := "|<>*72$11.7k70A0EE1U70S0w0s0lUXU7UDUTY"
EdgeOfHeaven:="|<>*71$72.0TU1k1k1zU600DU1U1U1z0200701U1Vlz1100D3VXlVlz7VV7z7VXlU1z7VVDz3VVVU3z7VV0301U1Vzz11V01U1k1U1zU3V01k1s1k1zU7VU"
ShinningCastle:="|<>*73$55.1z07X07X0E3U1lU1lUA0k0sk0Mk7UMQAMQAMTy4S6AS6ASD2D36D36D337VX7VX7U1XklXklXs1lsMlsMlw"

Wave10 :=
    "|<>FFFFFF-0.90$71.0000000000000000000000000000000000000000000001U1UUU00000ADk111000000wNU270000003tVU2C8NA0D01n3044F688V01a20/424MV203A40CCA8F6006MM0MQ8EI400Akk0kENUs800Mn00UUT0UDU0Vy00000006010s000000000000000000000000E"
ChallengeMods := ["Essence Stone", "Trait Reroll", "Stat Chip", "BountiesAttempts", "Infinity"]
EssenceStoneChallenge :=
    "|<>*93$60.zzzzzzzzzzk3zzzzzzzzk3zzzzzzzzk3zzzzzzzznzVksCFwS3kD1Uk60kA1k7Dbl60kAFkD1UV6QXsFnzUk06QXs1k3MgFyQkATk30UE6QkA1k31UsCQwS3zzzzzzzzzzU"
StatChipChallenge := "|<>*98$32.zzzzzy3bzyT0NzzblCTztwz1tA71UM21s460kTVb6CTSNlnbl6C0sw1VUC7VwSHlzzzzzs"
CancelText :=
    "|<>*133$52.3y000006ksQ00000Na0E00001aE3TzwTDyP7z9Yz7Utcnk60kA1aX30M30l6PAslb8y4NgTXaQXs1bk30Nn0lyDU41bA30MTUsaQsS3Xzzzzzzzzy"
FailedText :=
    "|<>*145$45.0Tz6Dzzs3zslzzz0TzyDzzzzzzlzDzzk36D0S0A0Mlk3U1U36C680AQMllV7zXX6C0MzwMMllz6zU3666M7y0Mks3UU"
UpdateLogs :=
    "|<>*111$47.zzlyTzwTkzzzW9sz0Pzz421y0TzwT5zwMVkkOC7sk10U0M7k0QFX0XDU8sl610T7llaA2DyDXkAMW1yTbkst63jzzzzzzzTzzzzzzyTzzzzzzu"
DoubleDungeonGodStatue :=
    "|<>*107$83.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyTzzzzzzzzzzs3wTzzzzxzzzzzk1szzzzzlzzzzzU1zzzzzzXzzzzz71zlzzwT7wTzzyD360s1U81UA1zwT6A1U30E20M3zsyAMz06DkA8EjzlwMkCCA3lskXzzXklkAQQ3Xk37zz73XsMky77XyDzy076Mk1aC33ATzw0SA1k30S70Mzzs3ww7l71yD0nzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzw"
MAXXED :=
    "|<>*109$20.1k08y03NU0QTzq7zw1040088UX7M8UyE0Ba0uDzzU"
wave15 :=
    "|<>*137$67.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzznntzzzzzyC1lsszzzzzy60wMQTzzzzy30yACTzzzDz1Xz62A0D61zUkTk0403W0TwM7s06AFX6DyA1w63CA1U7z7Mz31X61k7zXwTVlk3VszzlUDtsw1sw1zskDwyz0wzUzwQDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzw"
store := "|<>*132$26.ANk4k6Ml43aAMDtk63yA1m"
AREAS := "|<>*113$41.wDU60D3sD64Ty3USC8zs70QME7kAMs1UD6M0k30y0U1U6Ds1016A0k2"
Loaded := "|<>*118$25.wUM3SF8Vj9Y6k4n32"
Cancell := "|<>*135$12.C7M1E3lznDX3nClyk3s1y3U"
Back := "|<>*127$37.C70C1X47060F21U30M1kllXw0wMsly0SAMMv0060A0UE"
Create := "|<>*136$33.Ds8421jDAYMDtk0n0nDDYMU"
challengecheck := "|<>*97$26.M0M140400218E40008"
reward := "|<>*102$29.00003W00UP0U10r1UE1s"
startbountycheck := "|<>*141$34.60k30UCD6ATcssslyXXlX7sC70ATc"
lbcheckk := "|<>*73$8.D1W1kwC163m"
lbcheckk4 :="|<>*64$7.S60AC61ADDo"
gamecheck:= "|<>*110$49.zzzzzzz0TzzzzzzUDzzzzzzns001zzzty001zzzwzzzzzzzyTzzzzzzzDTzzzzzzbjzzzzzznzzzzzzztw000zzzwz000zzzyTzzzzzzzDzzzzzzzbzzzzzzznzzzzzzztzzzzzzzw0000Tzzzs000Dzzzzk"

global dodaily := DoDailyChallengeBox.Value
dailychallenge := "|<>*144$19.3zDgl7b02X210A0n"
regular := "|<>*138$25.csgQ086A0134YS432"
disconected := "|<>*112$40.DvinjRozSTiNj3w1kta0DrwPqvwzDrj3bs"

rewardchallenge := "|<>*125$49.sU1a83000F4UA1UU0EW04MnnU81U6ANlnWDk3UAw1l0Mlk6S0wkSNwHDUE"
startcheck :=
    "|<>*131$48.U2V0000802V000083bVtzrzs3z0D4QEk1y0A0A0UU6080A0Uk30M0ABkw3VswADMzVVMwAM87VVsQAM833Vs0AM803kQ0AMAU6kQ0AMAU"

global BountyCheck := 1
global lastInput := ""
global paused := false
global LastResetTime := A_TickCount
global CurrentChallenge := "None"
global ChallengeMods := Map(
    "TraitReroll", { name: "TraitReroll", gems: 0, gold: 1000, rerolls: 1, bounties: 0 },
    "StoryMode", { name: "StoryMode", gems: 580, gold: 100, rerolls: 1, bounties: 1 },
    "LegendStage", { name: "LegendStage", gems: 530, gold: 75, rerolls: 1, bounties: 1 },
    "Infinity", { name: "Infinity", gems: 800, gold: 750, rerolls: 0, bounties: 0 },
)

RobloxWindow := "ahk_exe RobloxPlayerBeta.exe"

UpdateGUI(CurrentChallenge)

modType := ""
if (CurrentChallengeMod = "Mod 1")
    modType := "Green Essence Challenge"
else if (CurrentChallengeMod = "Mod 2")
    modType := "Trait Reroll Challenge"
else if (CurrentChallengeMod = "Mod 3")
    modType := "Stat Chip Challenge"
else if (CurrentChallengeMod = "Mod 4")
    modType := "Story Mode"
else if (CurrentChallengeMod = "Mod 5")
    modType := "Infinite"
else if (CurrentChallengeMod = "Mod 1.5")
    modType := "Legend Stage"