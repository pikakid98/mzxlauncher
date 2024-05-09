#Requires AutoHotkey v2.0
#NoTrayIcon

#Include ver.scriptlet

if A_Args.Length < 3
{
    ExitApp
}

FileInstall ".Cmpl8r\7zr.exe", A_Temp "\7zr.exe", 1

RunWait A_Temp "\7zr.exe" " x " '"' A_Args[1] '"' " -o" '"' A_Args[2] '"' , , "Hide"

FileDelete A_Temp "\7zr.exe"

if not FileExist(A_Args[2] "\manifest.ini") {
    MsgBox "Extraction Failed!"
    ExitApp
}

if A_Args[3] = "-noplay"
{
    ExitApp
}

if A_Args[3] = "-play"
{
    mzxmanifest := IniRead(A_Args[2] "\manifest.ini", "mzxfile", "mzx")

    RunWait A_Args[4] "\mzxrun.exe" " " '"' A_Args[2] "\Game\" mzxmanifest '"'
    DirDelete A_Args[2], 1

    ExitApp
}