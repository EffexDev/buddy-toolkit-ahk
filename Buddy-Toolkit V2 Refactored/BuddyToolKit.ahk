#Requires AutoHotkey v2.0
#Include Templates.ahk

; ALt-F1 to entirely reload the script. This is mostly for testing and debugging.
!F1::
{
    Reload
}

IniWrite("xxx", "config.ini", "Customer", "CustomerName")

Global LiveChatMap := Map()
Global GeneralNBNMap := Map()
Global GeneralHardwareMap := Map()
Global GeneralOTRSMap := Map()
Global PPMap := Map()
Global FHMap := Map()
Global FaultTemplatesMap := Map()
Global DiscoveryMap := Map()
Global SpeedsMap := Map()
Global DropoutsMap := Map()
Global ConnectionMap := Map()
Global SetupMap := Map()
Global LinkMap := Map()
Global HardwareMap := Map()
Global ServiceRequestMap := Map()
Global DelaysMap := Map()
Global HFCMap := Map()
Global FTTCMap := Map()
Global FTTPMap := Map()
Global ValidationMap := Map()
Global BanlistingMap := Map()
Global PaymentMap := Map()
Global NBNCompMap := Map()
Global RaisingMap := Map()
Global ClarificationMap := Map()
Global ResolutionsMap := Map()
Global ChangesMap := Map()
Global TIOMap := Map()
Global ContactsMap := Map()
Global TCSGeneralMap := Map()
Global TCSBillingMap := Map()
Global TCSSuspensionMap := Map()
Global TCSChangesMap := Map()

; Declarations of global variables. This is used to make the popout visible to other functions
Global NotesGui := Gui(,"Notepad"), Notes := NotesGui.Add("Edit", "h600 w685", "")
Global TemplatesGui := Gui(,"Templates"), Templates := TemplatesGui.Add("Edit", "h600 w685", "")
Global HotkeysGui := Gui(,"Useful Links"), Hotkeys := HotkeysGui.Add("Text", "+Wrap h230 cFFFFFF", "Available Hotkeys:`n`n@@ - Your email`n`n~~ - Date 7 calendar days from now. For abandoment comms`n`nCTRL+Shift+S - Randomized signature for app faults. Also checks the publish to app checkbox`n`nCTRL+DEL - Content aware search ie. Superlookup")

Hotkeys.SetFont("s10","Nunito")
Notes.SetFont("s10","Nunito")
Templates.SetFont("s10","Nunito")

NotesGui.BackColor := "c007ba8"
TemplatesGui.BackColor := "c007ba8"
HotkeysGui.BackColor := "c007ba8"

; The main body of the GUI itself. Dimensions and tabs etc
Global BuddyGui := Gui("-Caption +Border","Buddy Tool Kit V2.0")
BuddyGui.BackColor := "c007ba8"
BuddyGui.Add("Picture", "ym+10 x+20 w180 h-1","BuddyLogo.png")
BuddyGui.Add("Picture", "ym xm+480 ym+10 w-1 h80","BuddyPC.png").OnEvent("Click", WhatTheDogDoin)
BuddyGui.SetFont("s10 c000000","Nunito")
BuddyGui.Add("Text", " xm cFFFFFF" , "Customer Name:")
Global CustomerNameField := BuddyGui.Add("Edit", "yp-3 xm+105 w150 vCustomerNameValue", "").OnEvent("Change", CustomerNameEdit)
BuddyGui.Add("Text", "cFFFFFF yp+3 x+200", "Author: Jordan Cartledge")
TemplateTab := BuddyGui.Add("Tab3","xm h70 w610 BackgroundWhite", ["General", "Accounts", "Faults","Order Support","Complaints","T and Cs"])
ToolsTab := BuddyGui.Add("Tab3", "WP h80 BackgroundWhite c222222 vToolsTab", ["QOL", "Automations", "Useful Links", "Options"])

BuddyGui.Show("x1983 y561 w630")

;DO NOT REMOVE
Send "xxx"

;First set of tabs, for department selection to segregate templates and keep things organised. This grabs the options selected in both dropdowns and saves them into a variable to be used later.
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

TemplateTab.UseTab(6)
SelTCSReason := BuddyGui.AddDropDownList("w200 h100 r20 BackgroundFFFFFF vPickedTCSReason Choose1", TCSReasons)
SelTCSReason.OnEvent('Change', SelTCSReasonSelected)
SelTCSTemplate := BuddyGui.AddDropDownList("yp w200 r20 BackgroundFFFFFF vPickedTCS", TCSTemplates[SelTCSReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunTCS)

; The tools tab. Controls the bottom set of tabs and the content of them. Functions are below
ToolsTab.UseTab(1)
Superlookup := BuddyGui.Add("Button","xm+15 y245 vSuperlookup", "Superlookup").OnEvent("Click", ProcessSuperlookup)
BuddyGui.Add("Button", "yp w90", "Notes").OnEvent("Click", NotePad)
BuddyGui.Add("Button","yp w90", "Hotkeys").OnEvent("Click", HotkeysPad)
BuddyGui.Add("Button","yp w90","Startup").OnEvent("Click", Startup)
BuddyGui.Add("Button","yp w100", "Lock Terminal").OnEvent("Click", LockTerminal)
NotePadEmbedded := BuddyGui.Add("Edit", "yp+40 xm+10 h510 w585 vNotePadEmbedded", "")

ToolsTab.UseTab(2)
BuddyGui.Add("Button", "xm+15 y245 Section", "Ping Test").OnEvent("Click", PingTest)
BuddyGui.Add("Button", "yp", "Traceroute").OnEvent("Click", Traceroute)
BuddyGui.Add("Button", "yp", "NSLookup").OnEvent("Click", NSLookup)
BuddyGui.Add("Button", "yp", "Prorata Calc").OnEvent("Click", ProRataCalc)

ToolsTab.UseTab(3)
BuddyGui.Add("Button", "xm+15 y245 Section", "CMS").OnEvent("Click", RunCMS)
BuddyGui.Add("Button", "yp", "Order Support").OnEvent("Click", RunOrderSupport)
BuddyGui.Add("Button", "yp", "NBN SQ").OnEvent("Click", RunNBNSQ)
BuddyGui.Add("Button", "yp", "Complaints").OnEvent("Click", RunComplaints)
BuddyGui.Add("Button", "yp", "Buddy Website").OnEvent("Click", RunBuddy)
BuddyGui.Add("Button", "yp", "Outages").OnEvent("Click", RunOutages)
BuddyGui.Add("Button", "yp", "ChatGPT").OnEvent("Click", RunGPT)

ToolsTab.UseTab(4)
Global AlwaysOnTopButton := BuddyGui.Add("Checkbox", "xm+15 y245 Section vAlwaysOnTop ").OnEvent("Click", AlwaysOnTopToggle)
AlwaysOnTopCheckBoxText := BuddyGui.Add("Text", "yp xp+20 c000000", "Always on Top")
Global ShowNotesButton := BuddyGui.Add("Checkbox", "yp x+20 vShowNotesButton").OnEvent("Click", ShowNotes)
ShowNotesButtonText := BuddyGui.Add("Text", "yp xp+20 c000000", "Show Notepad")
Global DarkmodeButton := BuddyGui.Add("Checkbox", "yp x+20 vDarkModeButton ").OnEvent("Click", Darkmode)
DarkmodeButtonText := BuddyGui.Add("Text", "yp xp+20 c000000", "Darkmode")

BuddyGui["NotePadEmbedded"].Visible := 0


; This section controls cascading dropdowns. It will clear the second dropdown field and replace it when the first is altered. This allows you to have multiple categories per department.
global CustomerName := ""  ; Initialize at script level

CustomerNameEdit(CustomerNameValue, *) {
    global CustomerName
    CustomerName := BuddyGui["CustomerNameValue"].Value
    IniWrite(CustomerName, "config.ini", "Customer", "CustomerName")
    UpdateTemplates()
}

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

#Include Settings.ahk
#Include Generate.ahk
#Include FunctionLibrary.ahk