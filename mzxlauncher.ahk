﻿#Requires AutoHotkey v2.0
#NoTrayIcon

#Include ver.scriptlet

if not FileExist("mzxlauncher.exe")
{
    MsgBox "This doesn't appear to be a valid install of MegaZeux"
    ExitApp
}

if A_Args.Length > 1
{
    #Include args.scriptlet
}

DirCreate A_Temp "mzxlauncher"
FileInstall ".Cmpl8r\mzext.exe", A_Temp "mzxlauncher\mzext.exe", 1
FileInstall ".Cmpl8r\mzxamaker.exe", A_Temp "mzxlauncher\mzxamaker.exe", 1

if not DirExist("Games")
{
    DirCreate "Games"
}

; Create the window:
MyGui := Gui()

; call dark mode for window title + menu
SetWindowAttribute(MyGui)

; call dark mode for controls
SetWindowTheme(MyGui)

#include .Cmpl8r\DarkMode.scriptlet

MyGui.Title := "mzxlauncher"

myGui.OnEvent("Close", myGui_Close)
myGui_Close(thisGui) {  ; Declaring this parameter is optional.
    if FileExist(A_Temp "\mzx.ini") {
        FileDelete A_Temp "\mzx.ini"
    }
}

; Create the ListView with two columns, Name and Size:
LV := MyGui.Add("ListView", "r20 w300", ["Name","Size (KB)", "Path"])

; Notify the script whenever the user clicks a row:
LV.OnEvent("Click", LV_Click)

; Gather a list of file names from a folder and put them into the ListView:
Loop Files, A_ScriptDir "\Games\*.mzxa", "F D R"
    LV.Add(, A_LoopFileName, A_LoopFileSizeKB, A_LoopFileFullPath)

LV.ModifyCol  ; Auto-size each column to fit its contents.
LV.ModifyCol(2, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.

MyBtn := MyGui.Add("Button", "x62 y373 Center w80", "Launch Default")
MyBtn.OnEvent("Click", MyBtn_Click1)  ; Call MyBtn_Click when clicked.

MyBtn := MyGui.Add("Button", "x170 y373 Center w80", "Load selected mzx")
MyBtn.OnEvent("Click", MyBtn_Click2)  ; Call MyBtn_Click when clicked.

; Display the window:
MyGui.Show

LV_Click(LV, RowNumber)
{
    RowText := LV.GetText(RowNumber)  ; Get the text from the row's first field.
    FileAppend "", A_Temp "mzx.ini", "CP0"
    IniWrite A_ScriptDir "\Games\" RowText, A_Temp "\mzx.ini", "Game", "mzx"
}

MyBtn_Click1(*)
{
    MyGui.Hide
    RunWait "megazeux.exe"
    MyGui.Show
}

MyBtn_Click2(*)
{
    if FileExist(A_Temp "\mzx.ini") {
        MyGui.Hide
        Value := IniRead(A_Temp "\mzx.ini", "Game", "mzx")

        RunWait "mzext.exe" " " Value
        
        MyGui.Show
    } else {
        MyGui.Hide
        MsgBox "Please select a Game"
        MyGui.Show
    }

}