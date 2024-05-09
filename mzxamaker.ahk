#Requires AutoHotkey v2.0
#NoTrayIcon

#Include ver.scriptlet

if A_Args.Length < 1
{
    MsgBox  "Please drop a folder onto the exe"
    
    ExitApp
}

FileInstall ".Cmpl8r\7zr.exe", A_Temp "\7zr.exe", 1

DirCreate A_Temp "\mzxamaker\Game"
FileCopy A_Args[1], A_Temp "\mzxamaker\Game"

SetWorkingDir A_Temp "\mzxamaker"

Loop Files, "*.mzx", "F R"

IniWrite(A_LoopFileName,"manifest.ini", "mzxfile", "mzx")

DirCreate A_ScriptDir "\MZXFile"
RunWait A_Temp "\7zr.exe" " a " A_ScriptDir "\MZXFile\file.mzxa" " " "*", , "Hide"