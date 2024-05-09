#Requires AutoHotkey v2.0
#NoTrayIcon

#Include ver.scriptlet

if A_Args.Length < 2
{
    ExitApp
}

FileInstall ".Cmpl8r\7zr.exe", A_Temp "\7zr.exe", 1

DirCreate A_Temp "\mzxamaker\Game"
FileCopy A_Args[1], A_Temp "\mzxamaker\Game"

SetWorkingDir A_Temp "\mzxamaker"

Loop Files, "Game\*.mzx", "F R"

IniWrite(A_LoopFileName,"manifest.ini", "mzxfile", "mzx")

DirCreate A_Args[3]
RunWait A_Temp "\7zr.exe" " a " '"' A_Args[4] '"' " " "*", , "Hide"

FileDelete A_Temp "\7zr.exe"