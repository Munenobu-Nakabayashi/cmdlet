@echo off

setlocal enabledelayedexpansion

rem // Update 2024.02.20
pushd d:\Users\eac-520052729\work5

type null > .\icmpEchoReplyCheck.txt
type null > .\booleanCheck.txt

set i=""
for /f "delims=" %%i in (.\ITShisanDaicho.txt) do (
    powershell .\aliveCheck.ps1 %%i > .\booleanCheck.txt
    set b=""
    for /f "delims=" %%b in (.\booleanCheck.txt) do (
        if %%b==True (
            echo %%i �̑Ί݃A�h���X���ICMP����������܂��B�a�ʂ��܂��B >> icmpEchoReplyCheck.txt
        ) else (
            echo %%i �̑Ί݃A�h���X���ICMP����������܂���B�a�ʂ��܂���B >> icmpEchoReplyCheck.txt
        )
    )
    type null > .\booleancheck.txt
)

popd

endlocal

exit 0