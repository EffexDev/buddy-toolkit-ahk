#Requires AutoHotkey v2.0
#Include Templates.ahk

!F1::
{
    Reload
}

; --------------- GUI ----------------
BuddyGui := Gui("-Caption","Buddy Tool Kit")
BuddyGui.BackColor := "c007ba8"
BuddyGui.SetFont("s12","Nunito")
BuddyGui.Add("Picture", "ym+10 w250 h-1","BuddyLogo.png")
BuddyGui.Add("Picture", "ym xm+550 w-1 h120","BuddyPC.png")
BuddyGui.Add("Text", "xm cFFFFFF", "Toolkit Version 1"), 
TemplateTab := BuddyGui.Add("Tab3","xm h100 w700 BackgroundWhite", ["Accounts", "Faults","Delivery","Complaints",])
ToolsTab := BuddyGui.Add("Tab3", "WP h760 BackgroundWhite", ["Notepad", "QOL", "Automations", "About"])

TemplateTab.UseTab(1)
SelAccountReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedAccountReason Choose1", AccountReasons)
SelAccountReason.OnEvent('Change', SelAccountReasonSelected)
SelAccountTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedAccount", AccountTemplates
[SelAccountReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunAccount)

TemplateTab.UseTab(2)
SelFaultReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedFaultReason Choose1", FaultReasons)
SelFaultReason.OnEvent('Change', SelFaultReasonSelected)
SelFaultTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedFault", FaultTemplates[SelFaultReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunFault)

TemplateTab.UseTab(3)
SelDeliveryReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedDeliveryReason Choose1", DeliveryReasons)
SelDeliveryReason.OnEvent('Change', SelDeliveryReasonSelected)
SelDeliveryTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedDelivery", DeliveryTemplates[SelDeliveryReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunDelivery)

TemplateTab.UseTab(4)
SelComplaintReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedComplaintReason Choose1", ComplaintReasons)
SelComplaintReason.OnEvent('Change', SelComplaintReasonSelected)
SelComplaintTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedComplaint", ComplaintTemplates[SelComplaintReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunComplaint)
BuddyGui.Show("x1920 y0 w730 h1080")

ToolsTab.UseTab(1)
Notes := BuddyGui.Add("Edit", "h705 w670", "")

ToolsTab.UseTab(2)
BuddyGui.Add("Edit", "vSearchTerm w300")
BuddyGui.Add("Button", "yp", "Google").OnEvent("Click", ProcessGoogle)
BuddyGui.Add("Button","yp", "Superlookup").OnEvent("Click", ProcessSuperlookup)
BuddyGui.Add("Button","yp", "Lock Terminal").OnEvent("Click", LockTerminal)

ToolsTab.UseTab(3)
BuddyGui.Add("Button",, "Ping Test").OnEvent("Click", PingTest)
BuddyGui.Add("Button","yp", "Traceroute").OnEvent("Click", Traceroute)
BuddyGui.Add("Button","yp", "NSLookup").OnEvent("Click", NSLookup)

ToolsTab.UseTab(4)
BuddyGui.Add("Text", "+Wrap c000000", "Author: Jordan Cartledge`n`nCo-Authors:`nBailey Wilson`nSam Milburn`nTristan Hammat`nYazid Martin`n`nThis tool is designed to be the one stop shop for templates and tools for Buddy Telco. We`nstarted by adapting the Task Panel we used to use at Aussie and adapted and refined it.`n`nThe code was still in V1.1 however and was glued together with hopes and dreams so I wrote it`nin AHK V2.`n`nSo long, and thanks for all the fish.")

;---------------- Functions -------------------
SelAccountReasonSelected(*) 
{
    SelAccountTemplate.Delete()
    SelAccountTemplate.Add(AccountTemplates[SelAccountReason.value])
    SelAccountTemplate.Choose(1)
}

SelFaultReasonSelected(*) 
{
    SelFaultTemplate.Delete()
    SelFaultTemplate.Add(FaultTemplates[SelFaultReason.value])
    SelFaultTemplate.Choose(1)
}

SelDeliveryReasonSelected(*) 
{
    SelDeliveryTemplate.Delete()
    SelDeliveryTemplate.Add(DeliveryTemplates[SelDeliveryReason.value])
    SelDeliveryTemplate.Choose(1)
}

SelComplaintReasonSelected(*) 
{
    SelComplaintTemplate.Delete()
    SelComplaintTemplate.Add(ComplaintTemplates[SelComplaintReason.value])
    SelComplaintTemplate.Choose(1)
}

RunAccount(*)
{
    Saved:= BuddyGui.Submit(False)
    Output := ""
    try{
    if (Saved.PickedAccountReason = "Payment Plan")
    {
        Output := PPMap.Get(Saved.PickedAccount)
        ControlFocus Notes
        Notes.Focus()
        Send Output
    }
    else if (Saved.PickedAccountReason = "Financial Hardship")
    {
        Output := FHMap.Get(Saved.PickedAccount)
        ControlFocus Notes
        Notes.Focus()
        Send Output 
    }
    }
    Catch as Error{
        MsgBox "Make sure you select all options."
    }
}

RunFault(*)
{
    Saved:= BuddyGui.Submit(False)
    Output := ""
    try{
    if (Saved.PickedFaultReason = "General")
        {
        Output := FaultGeneralMap.Get(Saved.PickedFault)
        ControlFocus Notes
        Notes.Focus()
        Send Output
        }
    else if (Saved.PickedFaultReason = "Slow Speeds")
        {
            Output := SpeedsMap.Get(Saved.PickedFault)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "Dropouts")
        {
            Output := DropoutsMap.Get(Saved.PickedFault)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "No Connection")
        {
            Output := ConnectionMap.Get(Saved.PickedFault)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "Service Setup")
        {
            Output := SetupMap.Get(Saved.PickedFault)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "CSP Linking")
        {
            Output := LinkMap.Get(Saved.PickedFault)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "Hardware")
        {
            Output := HardwareMap.Get(Saved.PickedFault)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    }
    catch as Error{
        MsgBox "Make sure you select all options."
    }
}

RunDelivery(*)
{
    Saved:= BuddyGui.Submit(False)
    Output := ""
    try{
    if (Saved.PickedDeliveryReason = "HFC")
        {
            Output := HFCMap.Get(Saved.PickedDelivery)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedDeliveryReason = "FTTC")
        {
            Output := FTTCMap.Get(Saved.PickedDelivery)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedDeliveryReason = "Validation")
        {
            Output := ValidationMap.Get(Saved.PickedDelivery)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedDeliveryReason = "Banlisting")
        {
            Output := BanlistingMap.Get(Saved.PickedDelivery)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedDeliveryReason = "Missing Payment Info")
        {
            Output := PaymentMap.Get(Saved.PickedDelivery)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    }
    catch as Error{
        MsgBox "Make sure you select all options."
    }
}

RunComplaint(*)
{
    Saved:= BuddyGui.Submit(False)
    Output := ""
    try{
    if (Saved.PickedComplaintReason = "NBN")
        {
            Output := NBNMap.Get(Saved.PickedComplaint)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "Raising")
        {
            Output := RaisingMap.Get(Saved.PickedComplaint)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "Clarification")
        {
            Output := ClarificationMap.Get(Saved.PickedComplaint)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "Resolutions")
        {
            Output := ResolutionsMap.Get(Saved.PickedComplaint)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "State Changes")
        {
            Output := ChangesMap.Get(Saved.PickedComplaint)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "TIO")
        {
            Output := TIOMap.Get(Saved.PickedComplaint)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    }
    catch as Error{
        MsgBox "Make sure you select all options."
    }
}

;------------------------ Make it Draggable --------------------------

LShift & LButton::
EWD_MoveWindow(*)
{
    CoordMode "Mouse"  ; Switch to screen/absolute coordinates.
    MouseGetPos &EWD_MouseStartX, &EWD_MouseStartY, &EWD_MouseWin
    WinGetPos &EWD_OriginalPosX, &EWD_OriginalPosY,,, EWD_MouseWin
    if !WinGetMinMax(EWD_MouseWin)  ; Only if the window isn't maximized 
        SetTimer EWD_WatchMouse, 10 ; Track the mouse as the user drags it.

    EWD_WatchMouse()
    {
        if !GetKeyState("LButton", "P")  ; Button has been released, so drag is complete.
        {
            SetTimer , 0
            return
        }
        if GetKeyState("Escape", "P")  ; Escape has been pressed, so drag is cancelled.
        {
            SetTimer , 0
            WinMove EWD_OriginalPosX, EWD_OriginalPosY,,, EWD_MouseWin
            return
        }
        ; Otherwise, reposition the window to match the change in mouse coordinates
        ; caused by the user having dragged the mouse:
        CoordMode "Mouse"
        MouseGetPos &EWD_MouseX, &EWD_MouseY
        WinGetPos &EWD_WinX, &EWD_WinY,,, EWD_MouseWin
        SetWinDelay -1   ; Makes the below move faster/smoother.
        WinMove EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY,,, EWD_MouseWin
        EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
        EWD_MouseStartY := EWD_MouseY
    }
}

;------------------------- Tools -------------------------------------
    ProcessGoogle(*)
{
    Saved := BuddyGui.Submit(False)
    Run ("https://www.google.com/search?q=" Saved.SearchTerm)
}

PingTest(*)
{
    if WinExist("C:\Windows\SYSTEM32\cmd.exe")
    WinActivate
else
    Run "cmd.exe"
    Sleep 300
    Send "ping " A_Clipboard "{Enter}"
    return
}

Traceroute(*)
{
    if WinExist("C:\Windows\SYSTEM32\cmd.exe")
        WinActivate
    else
        Run "cmd.exe"
        Sleep 300
        Send "tracert " A_Clipboard "{Enter}"
        return
}

NSLookup(*)
{
    if WinExist("C:\Windows\SYSTEM32\cmd.exe")
        WinActivate
    else
        Run "cmd.exe"
        Sleep 300
        Send "nslookup " A_Clipboard "{Enter}"
        return
}

LockTerminal(*)
{
    Run "rundll32 user32.dll`,LockWorkStation"
}

ProcessSuperlookup(*)
{
    ;NOC Jira Tickets
    if (RegExMatch(A_Clipboard, "(NOC)\-\d*", &Match)) 
        Run "msedge.exe https://aussiebb.atlassian.net/servicedesk/customer/portal/18/" MATCH[0]
    ;NBN AVC/INC/ORD/PRI/WRI/HRI/CVCs
    else if (RegExMatch(A_Clipboard, "(AVC|INC|ORD|PRI|WRI|HRI|CVC)\d*", &Match))
        Run "https://nbnportals.nbnco.net.au/online_customers/page/home?search=" MATCH[0]
    ;NBN CRQs
    else if (RegExMatch(A_Clipboard, "^CRQ\d*", &Match))
        Run "https://nbnportals.nbnco.net.au/online_customers/page/change_activity/list?criteriaType=CHANGE_REF_NO&criteria=" MATCH[0]
    ;NBN APTs
    else if (RegExMatch(A_Clipboard, "APT\d*", &Match))
        Run "https://nbnportals.nbnco.net.au/online_customers/page/appointment/view/ASI000000001104/" MATCH[0]
	;NBN LOC
    else if (RegExMatch(A_Clipboard, "LOC\d+", &Match))
        Run "https://nbnportals.nbnco.net.au/online_customers/page/manageaddress/site_qualification/setup"
    ;Australia Post T/Ns
    else if (RegExMatch(A_Clipboard, "(?:R|92A|34ECK|I8|2KUZ|34TDC|36AAC|36BRU|030|0207)\d+", &Match))
        Run "https://auspost.com.au/mypost/track/#/details/" MATCH [0]
    ;Sites
    else if (RegExMatch(A_Clipboard, "^http(s)?:\/\/|www\.", &Match))
        Run A_Clipboard
}

csFullName := A_UserName
csFirstName := ""
Match:=""
Dice:= 0
sign := ["Regards,", "Cheers,", "Have a great day{!}", "All the best,"]

if (RegExMatch(csFullName, "^[^.]*",&csFirstName)) {
csTitle:=StrTitle(csFirstName[0])
}

:*:@@::  ; Double @ for sending email address to input field
{    
    SendInput csFullName
    SendInput "@team.aussiebroadband.com.au"
}

^+s::{
    Dice:= Random(1,4)
    Selected := sign.Get(Dice)
    Send (Selected)
    Send "{Enter}"
    Send (csTitle)
    SendInput "{Tab 1}{Space}"
	SendInput "{Tab 3}"
    Dice:= Random(1,4)   
}

^+o:: ;
{
    SendInput "{shift down}{tab}{tab}{tab}{tab}{tab}{tab}{shift up}s"
    Sleep 1000
    SendInput "{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}c"
    SendInput "{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}"
}