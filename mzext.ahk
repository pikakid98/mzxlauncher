#Requires AutoHotkey v2.0
#NoTrayIcon

#Include ver.scriptlet

if A_Args.Length < 1
{
    MsgBox  "
    (
        Please run via a .mzxa file
        
        "mzext.exe" "{FILE}.mzxa"
    )"

    ExitApp
}

FileInstall ".Cmpl8r\7zr.exe", A_Temp "\7zr.exe", 1

RunWait A_Temp "\7zr.exe" " x " '"' A_Args[1] '"' " -o" A_Temp "\MZX" , , "Hide"

if FileExist(A_Temp "\MZX\manifest.ini") {
    mzxmanifest := IniRead(A_Temp "\MZX\manifest.ini", "mzxfile", "mzx")

    RunWait "megazeux.exe" " " '"' A_Temp "\MZX\Game\" mzxmanifest '"'
    DirDelete A_Temp "\MZX", 1
} else {
    MsgBox "Extraction Failed!"
}