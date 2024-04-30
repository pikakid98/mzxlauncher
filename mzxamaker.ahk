#Requires AutoHotkey v2.0
#NoTrayIcon

;@Ahk2Exe-Set FileVersion, 1.0
;@Ahk2Exe-Set ProductVersion, 1.0.0.0
;@Ahk2Exe-Set CompanyName, Pikakid98

if A_Args.Length < 1
{
    MsgBox  "Please drop a folder onto the exe"
    
    ExitApp
}

FileInstall "7zr.exe", A_Temp "\7zr.exe", 1

DirCreate A_Temp "\mzxamaker\Game"
FileCopy A_Args[1], A_Temp "\mzxamaker\Game"

SetWorkingDir A_Temp "\mzxamaker"

Loop Files, "*.mzx", "F R"

IniWrite(A_LoopFileName,"manifest.ini", "mzxfile", "mzx")
RunWait A_Temp "\7zr.exe" " a " A_MyDocuments " " "*", , "Hide"