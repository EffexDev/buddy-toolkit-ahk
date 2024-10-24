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
BuddyGui.Add("Text", "xm cFFFFFF", "Toolkit Version 1.5"), 
TemplateTab := BuddyGui.Add("Tab3","xm h100 w700 BackgroundWhite", ["General", "Accounts", "Faults","Delivery","Complaints","T and Cs"])
ToolsTab := BuddyGui.Add("Tab3", "WP h760 BackgroundWhite", ["Notepad", "QOL", "Automations", "Useful Links", "Hotkeys", "About"])

TemplateTab.UseTab(1)
SelGeneralReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedGeneralReason Choose1", GeneralReasons)
SelGeneralReason.OnEvent('Change', SelGeneralReasonSelected)
SelGeneralTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedGeneral", GeneralTemplates
[SelGeneralReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunGeneral)

TemplateTab.UseTab(2)
SelAccountReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedAccountReason Choose1", AccountReasons)
SelAccountReason.OnEvent('Change', SelAccountReasonSelected)
SelAccountTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedAccount", AccountTemplates
[SelAccountReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunAccount)

TemplateTab.UseTab(3)
SelFaultReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedFaultReason Choose1", FaultReasons)
SelFaultReason.OnEvent('Change', SelFaultReasonSelected)
SelFaultTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedFault", FaultTemplates[SelFaultReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunFault)

TemplateTab.UseTab(4)
SelDeliveryReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedDeliveryReason Choose1", DeliveryReasons)
SelDeliveryReason.OnEvent('Change', SelDeliveryReasonSelected)
SelDeliveryTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedDelivery", DeliveryTemplates[SelDeliveryReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunDelivery)

TemplateTab.UseTab(5)
SelComplaintReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedComplaintReason Choose1", ComplaintReasons)
SelComplaintReason.OnEvent('Change', SelComplaintReasonSelected)
SelComplaintTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedComplaint", ComplaintTemplates[SelComplaintReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunComplaint)
BuddyGui.Show("x1920 y0 w730 h1080")

TemplateTab.UseTab(6)
SelTCSReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedTCSReason Choose1", TCSReasons)
SelTCSReason.OnEvent('Change', SelTCSReasonSelected)
SelTCSTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedTCS", TCSTemplates[SelTCSReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunTCS)
BuddyGui.Show("x1920 y0 w730 h1080")

ToolsTab.UseTab(1)
Notes := BuddyGui.Add("Edit", "h705 w670", "")

ToolsTab.UseTab(2)
BuddyGui.Add("Edit", "xm+15 y320 Section vSearchTerm w300", "")
BuddyGui.Add("Button","x+10 yp-3", "Google").OnEvent("Click", ProcessGoogle)
BuddyGui.Add("Button","xs y+20", "Superlookup").OnEvent("Click", ProcessSuperlookup)
BuddyGui.Add("Text", "x+10 yp+5", "Will run a smart search for whatever is copied to clipboard")
BuddyGui.Add("Button","xs y+535","Startup").OnEvent("Click", Startup)
BuddyGui.Add("Text", "x+10 yp+5", "Opens all programs necessary for a work day")
BuddyGui.Add("Button","xs y+20", "Lock Terminal").OnEvent("Click", LockTerminal)
BuddyGui.Add("Text", "x+10 yp+5", "Locks your terminal")

ToolsTab.UseTab(3)
BuddyGui.Add("Button", "xm+15 y320 Section", "Ping Test").OnEvent("Click", PingTest)
BuddyGui.Add("Text", "x+10 yp+5", "Runs a ping from command prompt to an IP address saved on the clipboard")
BuddyGui.Add("Button", "xs y+20", "Traceroute").OnEvent("Click", Traceroute)
BuddyGui.Add("Text", "x+10 yp+5", "Traces the route to an IP address saved on the clipboard")
BuddyGui.Add("Button", "xs y+20", "NSLookup").OnEvent("Click", NSLookup)
BuddyGui.Add("Text", "x+10 yp+5", "Performs a DNS lookup on the domain/IP saved to clipboard")
BuddyGui.Add("Button", "xs y+20", "Prorata Calc").OnEvent("Click", ProRataCalc)
BuddyGui.Add("Text", "x+10 yp+5", "Calculate prorated amounts based on service dates")

ToolsTab.UseTab(4)
BuddyGui.Add("Edit", "h705 w670", "NBN Network Outage Checker:`nhttps://www.nbnco.com.au/support/network-status`n`n------------------------------`n`nBuddy Telco Outage Checker:`nhttps://www.buddytelco.com.au/network/`n`n------------------------------`n`nBuddy Telco Plans:`nhttps://www.buddytelco.com.au/#plan`n`n------------------------------`n`nBuddy Telco Router Guides:`nhttps://www.buddytelco.com.au/help/#router`n`n------------------------------`n`nBuddy Telco Bill Explainer:`nhttps://www.buddytelco.com.au/help/bill-explainer/`n`n------------------------------`n`nBuddy Telco App Links:`nhttps://apps.apple.com/au/app/buddy-telco/id6502035422`nhttps://play.google.com/store/apps/details?id=org.aussiebroadband.buddy&pli=1`n`n------------------------------`n`nBuddy Telco Contact Page:`nhttps://www.buddytelco.com.au/contact/")

ToolsTab.UseTab(5)
BuddyGui.Add("Text", "+Wrap c000000", "Available Hotkeys:`n`n@@ - Your email`n`n~~ - Date 7 calendar days from now. For abandoment comms`n`nCTRL+S - Randomized signature for app faults. Also checks the publish to app checkbox`n`nCTRL+DEL - Content aware search ie. Superlookup")

ToolsTab.UseTab(6)
BuddyGui.Add("Text", "+Wrap c000000", "Author: Jordan Cartledge`n`nCo-Authors:`nBailey Wilson`nSam Milburn`nTristan Hammat`nYazid Martin`nCallan Johnson`n`nThis tool is designed to be the one stop shop for templates and tools for Buddy Telco. We`nstarted by adapting the Task Panel we used to use at Aussie and adapted and refined it.`n`nThe code was still in V1.1 however and was glued together with hopes and dreams so I wrote`nit in AHK V2.`n`nSo long, and thanks for all the fish.")

;---------------- Functions -------------------
SelGeneralReasonSelected(*) 
{
    SelGeneralTemplate.Delete()
    SelGeneralTemplate.Add(GeneralTemplates[SelGeneralReason.value])
    SelGeneralTemplate.Choose(1)
}

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

SelTCSReasonSelected(*) 
{
    SelTCSTemplate.Delete()
    SelTCSTemplate.Add(TCSTemplates[SelTCSReason.value])
    SelTCSTemplate.Choose(1)
}

RunGeneral(*)
{
    Saved:= BuddyGui.Submit(False)
    Output := ""
    try{
    if (Saved.PickedGeneralReason = "Faults")
    {
        Output := GeneralFaultMap.Get(Saved.PickedGeneral)
        ToolsTab.Choose(1)
        ControlFocus Notes
        Notes.Focus()
        Send Output
    }
    else if (Saved.PickedGeneralReason = "NBN")
    {
        Output := GeneralNBNMap.Get(Saved.PickedGeneral)
        ToolsTab.Choose(1)
        ControlFocus Notes
        Notes.Focus()
        Send Output 
    }
    else if (Saved.PickedGeneralReason = "Hardware")
    {
        Output := GeneralHardwareMap.Get(Saved.PickedGeneral)
        ToolsTab.Choose(1)
        ControlFocus Notes
        Notes.Focus()
        Send Output 
    }
    else if (Saved.PickedGeneralReason = "OTRS")
        {
            Output := GeneralOTRSMap.Get(Saved.PickedGeneral)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output 
        }
    }
    Catch as Error{
        MsgBox "Make sure you select all options."
    }
}

RunAccount(*)
{
    Saved:= BuddyGui.Submit(False)
    Output := ""
    try{
    if (Saved.PickedAccountReason = "Payment Plan")
    {
        Output := PPMap.Get(Saved.PickedAccount)
        ToolsTab.Choose(1)
        ControlFocus Notes
        Notes.Focus()
        Send Output
    }
    else if (Saved.PickedAccountReason = "Financial Hardship")
    {
        Output := FHMap.Get(Saved.PickedAccount)
        ToolsTab.Choose(1)
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
    if (Saved.PickedFaultReason = "Slow Speeds")
        {
            Output := SpeedsMap.Get(Saved.PickedFault)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "Discovery")
        {
            Output := DiscoveryMap.Get(Saved.PickedFault)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "Dropouts")
        {
            Output := DropoutsMap.Get(Saved.PickedFault)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "No Connection")
        {
            Output := ConnectionMap.Get(Saved.PickedFault)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "Service Setup")
        {
            Output := SetupMap.Get(Saved.PickedFault)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "CSP Linking")
        {
            Output := LinkMap.Get(Saved.PickedFault)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    else if (Saved.PickedFaultReason = "Hardware")
        {
            Output := HardwareMap.Get(Saved.PickedFault)
            ToolsTab.Choose(1)
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
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedDeliveryReason = "FTTC")
        {
            Output := FTTCMap.Get(Saved.PickedDelivery)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedDeliveryReason = "FTTP")
        {
            Output := FTTPMap.Get(Saved.PickedDelivery)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedDeliveryReason = "Validation")
        {
            Output := ValidationMap.Get(Saved.PickedDelivery)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedDeliveryReason = "Banlisting")
        {
            Output := BanlistingMap.Get(Saved.PickedDelivery)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedDeliveryReason = "Missing Payment Info")
        {
            Output := PaymentMap.Get(Saved.PickedDelivery)
            ToolsTab.Choose(1)
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
    try {
    if (Saved.PickedComplaintReason = "NBN")
        {
            Output := NBNMap.Get(Saved.PickedComplaint)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "Raising")
        {
            Output := RaisingMap.Get(Saved.PickedComplaint)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "Clarification")
        {
            Output := ClarificationMap.Get(Saved.PickedComplaint)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "Resolutions")
        {
            Output := ResolutionsMap.Get(Saved.PickedComplaint)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "State Changes")
        {
            Output := ChangesMap.Get(Saved.PickedComplaint)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "TIO")
        {
            Output := TIOMap.Get(Saved.PickedComplaint)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    Else if (Saved.PickedComplaintReason = "Contacts")
        {
            Output := ContactsMap.Get(Saved.PickedComplaint)
            ToolsTab.Choose(1)
            ControlFocus Notes
            Notes.Focus()
            Send Output
        }
    }
    catch as Error{
        MsgBox "Make sure you select all options."
    }
}

RunTCS(*)
{
    Saved:= BuddyGui.Submit(False)
    Output := ""
    try{
    if (Saved.PickedTCSReason = "General")
    {
        Output := TCSGeneralMap.Get(Saved.PickedTCS)
        ToolsTab.Choose(1)
        ControlFocus Notes
        Notes.Focus()
        Send Output
    }
    else if (Saved.PickedTCSReason = "Billing")
    {
        Output := TCSBillingMap.Get(Saved.PickedTCS)
        ToolsTab.Choose(1)
        ControlFocus Notes
        Notes.Focus()
        Send Output 
    }
    else if (Saved.PickedTCSReason = "Suspension/Termination")
    {
        Output := TCSSuspensionMap.Get(Saved.PickedTCS)
        ToolsTab.Choose(1)
        ControlFocus Notes
        Notes.Focus()
        Send Output 
    }
    else if (Saved.PickedTCSReason = "Changes")
    {
        Output := TCSChangesMap.Get(Saved.PickedTCS)
        ToolsTab.Choose(1)
        ControlFocus Notes
        Notes.Focus()
        Send Output 
    }
    }
    Catch as Error{
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

ProRataCalc(*) {
    ProrataGui := Gui(,"Buddy Tool Kit")
    ProrataGui.BackColor := "c007ba8"
    ProrataGui.Add("MonthCal", "yp+10 vBillingStart")
    ProrataGui.Add("MonthCal", "yp vServiceEnd")
    ProrataGui.Show("w500 h275")
    ProrataGui.Add("Edit","xm+5 w100 vMonthlyCost", "")
    ProrataGui.Add("Text","yp cFFFFFF", "Enter the monthly billing amount")
    ProrataGui.Add("Edit","xm+5 w100 vdaysInMonth", "")
    ProrataGui.Add("Text","yp cFFFFFF", "How many days this month?")
    ProrataGui.Add("Button","xm+5", "Calculate").OnEvent("Click", PRCalcBox)

        PRCalcBox(*) {
            Saved:= ProrataGui.Submit(False)
            DaysPassed := DateDiff(Saved.ServiceEnd, Saved.BillingStart, "days")
            Month := 
            DailyCost := Saved.MonthlyCost / Saved.daysInMonth
            DaysUsed := DailyCost * DaysPassed
            ProrataAmount := Saved.MonthlyCost - DaysUsed
            MsgBox "The prorata amount is " ProrataAmount
        }
}

LockTerminal(*)
{
    Run "rundll32 user32.dll`,LockWorkStation"
}

ProcessSuperlookup(*)
{
    ;NOC Jira Tickets
    if (RegExMatch(A_Clipboard, "(NOC)\-\d*", &Match)) 
        Run "https://aussiebb.atlassian.net/servicedesk/customer/portal/18/" MATCH[0]
    ;NBN AVC/INC/ORD/PRI/WRI/HRI/CVCs
    else if (RegExMatch(A_Clipboard, "(AVC|INC|ORD|PRI|WRI|HRI|CVC)\d*", &Match))
        Run "https://nbnportals.nbnco.net.au/online_customers/page/home?headerSearch=" MATCH[0]
    ;NBN CRQs
    else if (RegExMatch(A_Clipboard, "^CRQ\d*", &Match))
        Run "https://nbnportals.nbnco.net.au/online_customers/page/change_activity/list?criteriaType=CHANGE_REF_NO&criteria=" MATCH[0]
    ;NBN APTs
    else if (RegExMatch(A_Clipboard, "APT\d*", &Match))
        Run "https://nbnportals.nbnco.net.au/online_customers/page/appointment/view/ASI000000001104/" MATCH[0]
	;NBN LOC
    else if (RegExMatch(A_Clipboard, "LOC\d+", &Match))
        Run "https://nbnportals.nbnco.net.au/online_customers/page/manageaddress/site_qualification/search?address.nbnLocationId=" MATCH[0]
    ;Australia Post T/Ns
    else if (RegExMatch(A_Clipboard, "(?:R|92A|34ECK|I8|2KUZ|34TDC|36AAC|36BRU|36LFM|36LDQ|030|0207)\d+", &Match))
        Run "https://auspost.com.au/mypost/track/#/details/" MATCH [0]
    ;Sites
    else if (RegExMatch(A_Clipboard, "^http(s)?:\/\/|www\.", &Match))
        Run A_Clipboard
    ;Mobile Numbers
    else if (RegExMatch(A_Clipboard, "^04[\d\s]+\s?$", &Match))
        Run "https://cms.aussiebroadband.com.au/aj-search.php?type=billing_name&search=" MATCH[0]
    ;Emails
    else if (RegExMatch(A_Clipboard, "^[^@]+@[^@]+\.[^@]+$", &Match))
        Run "https://cms.aussiebroadband.com.au/aj-search.php?type=email&search=" MATCH[0]
}

Startup(*)
{
        if WinExist("C:\Program Files\Slack\slack.exe")
        {
            WinActivate
        } 
    else 
        {
            Run "C:\Program Files\Slack\Slack.exe"
        }

    if WinExist("ahk_exe C:\Program Files\Google\Chrome\Application\chrome.exe")
        {
            WinActivate
        }
    else 
        {
            Run "chrome.exe"
        }
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

:*:~~:: ; Gives an address 7 calendar days in the future for abandonment comms
{
    CurrentDate := FormatTime(, "yyyyMMdd")
    NewDate := FormatTime(DateAdd(CurrentDate, 7, "days"), "dd/MM/yyyy")
    Send(NewDate)
}

^+s::{ ; Randomized signature. Also auto-ticks the publishj to app button and focuses the submit button so you can just hit enter.
    Dice:= Random(1,4)
    Selected := sign.Get(Dice)
    Send (Selected)
    Send "{Enter}"
    Send (csTitle)
    SendInput "{Tab 1}{Space}"
	SendInput "{Tab 3}"
    Dice:= Random(1,4)   
}

<^Del::ProcessSuperlookup()