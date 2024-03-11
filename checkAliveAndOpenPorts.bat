rem //Auther: Shinji Kawasaki
@echo off

setlocal enabledelayedexpansion

rem pushd d:\Users\eac-520052729\work8
pushd C:\Users\eac-520052729\Desktop\work8

type null > .\openPortCheck.txt
type null > .\work.txt
type null > .\boolean.txt
type null > .\workPort.txt

set array[0]=22
set array[1]=23
set array[2]=25
set array[3]=80
set array[4]=137
set array[5]=138
set array[6]=139
set array[7]=389
set array[8]=443
set array[9]=445
set array[10]=623
set array[11]=636
set array[12]=902
set array[13]=903
set array[14]=1521
set array[15]=3389
set array[16]=5432
set array[17]=5631
set array[18]=5632

for /f "delims=" %%i in (.\mitourokulist.txt) do (
    powershell .\aliveCheck.ps1 %%i > .\work.txt
    for /f "delims=" %%b in (.\work.txt) do (
        if %%b==False (
            echo %%i ----- ノードはICMP応答がありません。 >> .\openPortCheck.txt
        ) else (
            rem // echo %%i ノードはICMP応答があります。 ----- >> .\openPortCheck.txt
            rem // echo ----- >> openPortCheck.txt
            for /L %%j in (0,1,18) do (
                rem // UPDATE 2024.02.13 --- Start ( OMG !! )
                powershell .\testNetConnection.ps1 %%i !array[%%j]! > .\boolean.txt
                rem // UPDATE 2024.02.13 --- End
                for /f "delims=" %%b in (.\boolean.txt) do (
                    rem // echo %%b
                    if %%b==True (
                        echo %%i !array[%%j]! 番ポートを開放しています。 >> .\openPortCheck.txt
                    ) else (
                        rem // 2行発生するうち、ブール値記載行のみ反応する仕掛け（警告行をスキップし1行にする）
                        if %%b==False (
                            echo %%i !array[%%j]! 番ポートを開放していません。 >> .\openPortCheck.txt
                        )
                    )
                )
            )
            rem // echo ----- >> openPortCheck.txt
            rem  // echo %%i ノードのポート開放チェックは以上です。 >> .\openPortCheck.txt
        )
    )
    type null > .\work.txt
    rem // echo. >> openPortCheck.txt
)

popd

endlocal

exit 0