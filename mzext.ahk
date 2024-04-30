#Requires AutoHotkey v2.0
#NoTrayIcon

;@Ahk2Exe-Set FileVersion, 1.0
;@Ahk2Exe-Set ProductVersion, 1.0.0.0
;@Ahk2Exe-Set CompanyName, Pikakid98

FileInstall "7zr.exe", A_Temp "\7zr.exe", 1

RunWait A_Temp "\7zr.exe" " x " '"' A_Args[1] '"' " -o" A_Temp "\MZX" , , "Hide"

if FileExist(A_Temp "\MZX\manifest.ini") {
    mzxmanifest := IniRead(A_Temp "\MZX\manifest.ini", "mzxfile", "mzx")

    RunWait "megazeux.exe" " " '"' A_Temp "\MZX\Game\" mzxmanifest '"'
    DirDelete A_Temp "\MZX", 1
} else {
    MsgBox "Extraction Failed!"
}