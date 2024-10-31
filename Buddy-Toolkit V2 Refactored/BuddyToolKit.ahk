#Requires AutoHotkey v2.0
#Include Templates.ahk

; ALt-F1 to entirely reload the script. This is mostly for testing and debugging.
!F1::
{
    Reload
}

; Declarations of global variables. This is used to make the popout visible to other functions
Global NotesGui := Gui(,"Notepad"), Notes := NotesGui.Add("Edit", "h600 w685", "")
Global TemplatesGui := Gui(,"Templates"), Templates := TemplatesGui.Add("Edit", "h600 w685", "")
Global UsefulLinksGui := Gui(,"Useful Links"), UsefulLinks := UsefulLinksGui.Add("Edit", "h600 w680", "NBN Network Outage Checker:`nhttps://www.nbnco.com.au/support/network-status`n`n------------------------------`n`nBuddy Telco Outage Checker:`nhttps://www.buddytelco.com.au/network/`n`n------------------------------`n`nBuddy Telco Plans:`nhttps://www.buddytelco.com.au/#plan`n`n------------------------------`n`nBuddy Telco Router Guides:`nhttps://www.buddytelco.com.au/help/#router`n`n------------------------------`n`nBuddy Telco Bill Explainer:`nhttps://www.buddytelco.com.au/help/bill-explainer/`n`n------------------------------`n`nBuddy Telco App Links:`nhttps://apps.apple.com/au/app/buddy-telco/id6502035422`nhttps://play.google.com/store/apps/details?id=org.aussiebroadband.buddy&pli=1`n`n------------------------------`n`nBuddy Telco Contact Page:`nhttps://www.buddytelco.com.au/contact/")
Global HotkeysGui := Gui(,"Useful Links"), Hotkeys := HotkeysGui.Add("Text", "+Wrap h230 cFFFFFF", "Available Hotkeys:`n`n@@ - Your email`n`n~~ - Date 7 calendar days from now. For abandoment comms`n`nCTRL+S - Randomized signature for app faults. Also checks the publish to app checkbox`n`nCTRL+DEL - Content aware search ie. Superlookup")

Hotkeys.SetFont("s10","Nunito")
Notes.SetFont("s10","Nunito")
UsefulLinks.SetFont("s10","Nunito")
Hotkeys.SetFont("s10","Nunito")

NotesGui.BackColor := "c007ba8"
UsefulLinksGui.BackColor := "c007ba8"
TemplatesGui.BackColor := "c007ba8"
HotkeysGui.BackColor := "c007ba8"


; The main body of the GUI itself. Dimensions and tabs etc
BuddyGui := Gui("-Caption +Border","Buddy Tool Kit V2.0")
BuddyGui.BackColor := "c007ba8"
BuddyGui.Add("Picture", "ym+10 x+20 w180 h-1","BuddyLogo.png")
BuddyGui.Add("Picture", "ym xm+480 ym+10 w-1 h80","BuddyPC.png")
BuddyGui.SetFont("s10 c000000","Nunito")
TemplateTab := BuddyGui.Add("Tab3","xm h80 w610 BackgroundWhite", ["General", "Accounts", "Faults","Order Support","Complaints","T and Cs"])
ToolsTab := BuddyGui.Add("Tab3", "WP h80 BackgroundWhite c222222 vToolsTab", ["QOL", "Automations", "Options"])

BuddyGui.Show("x1920 y0 w630")

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
Superlookup := BuddyGui.Add("Button","xm+15 y225 vSuperlookup", "Superlookup").OnEvent("Click", ProcessSuperlookup)
BuddyGui.Add("Button", "yp w90", "Notes").OnEvent("Click", NotePad)
BuddyGui.Add("Button","yp w90", "Useful Links").OnEvent("Click", UsefulLinksPad)
BuddyGui.Add("Button","yp w90", "Hotkeys").OnEvent("Click", HotkeysPad)
BuddyGui.Add("Button","yp w90","Startup").OnEvent("Click", Startup)
BuddyGui.Add("Button","yp w100", "Lock Terminal").OnEvent("Click", LockTerminal)
NotePadEmbedded := BuddyGui.Add("Edit", "yp+40 xm+10 h510 w585 vNotePadEmbedded", "")

ToolsTab.UseTab(2)
BuddyGui.Add("Button", "xm+15 y225 Section", "Ping Test").OnEvent("Click", PingTest)
BuddyGui.Add("Button", "yp", "Traceroute").OnEvent("Click", Traceroute)
BuddyGui.Add("Button", "yp", "NSLookup").OnEvent("Click", NSLookup)
BuddyGui.Add("Button", "yp", "Prorata Calc").OnEvent("Click", ProRataCalc)

ToolsTab.UseTab(3)
AlwaysOnTopCheckBox := BuddyGui.Add("Checkbox", "xm+15 y225 Section vAlwaysOnTop ").OnEvent("Click", AlwaysOnTopToggle)
AlwaysOnTopCheckBoxText := BuddyGui.Add("Text", "yp xp+20 c000000", "Always on Top")
ShowNotesButton := BuddyGui.Add("Checkbox", "yp x+20 vShowNotesButton").OnEvent("Click", ShowNotes)
ShowNotesButtonText := BuddyGui.Add("Text", "yp xp+20 c000000", "Show Notepad")
DarkmodeButton := BuddyGui.Add("Checkbox", "yp x+20 vDarkModeButton ").OnEvent("Click", Darkmode)
DarkmodeButtonText := BuddyGui.Add("Text", "yp xp+20 c000000", "Darkmode")

BuddyGui["NotePadEmbedded"].Visible := 0

; This is the function for always on top. It checks if the box is checked and toggles always on top mode respectively
AlwaysOnTopToggle(ctrl, *)
{
    if ctrl.Value = 1 { ; Check if checkbox is checked
        BuddyGui.Opt("+AlwaysOnTop")  ; Enable Always on Top
    }
    else {
        BuddyGui.Opt("-AlwaysOnTop")  ; Disable Always on Top
    }
}

Darkmode(ctrl, *)
{
    Global TemplateTab
    Global ToolsTab 
    Global AlwaysOnTopCheckBoxText
    Global ShowNotesButtonText
    Global DarkmodeButtonText
    Global NotePadEmbedded
    Global NotesGui
    Global Notes
    Global TemplatesGui
    Global Templates
    Global UsefulLinksGui
    Global UsefulLinks

    if ctrl.Value { ; Check if checkbox is checked
        BuddyGui.BackColor := "c001C55"
        NotesGui.BackColor := "c001C55"
        TemplatesGui.BackColor := "c001C55"
        UsefulLinksGui.BackColor := "c001C55"
        HotkeysGui.BackColor := "c001C55"
        TemplateTab.Opt("xm h80 w610  Background00072D cFFFFFF")
        ToolsTab.Opt("WP h80 Background00072D cFFFFFF vToolsTab")
        AlwaysOnTopCheckBoxText.Opt("+BackgroundTrans cFFFFFF")
        ShowNotesButtonText.Opt("cFFFFFF")
        DarkmodeButtonText.Opt("cFFFFFF")
        NotePadEmbedded.Opt("Backgroundc000000 cFFFFFF")
        Notes.Opt("Backgroundc000000 cFFFFFF")
        Notes.SetFont("s10","Nunito")
        Templates.Opt("Backgroundc000000 cFFFFFF")
        Templates.SetFont("s10","Nunito")
        UsefulLinks.Opt("Backgroundc000000 cFFFFFF")
        UsefulLinks.SetFont("s10","Nunito")
        Hotkeys.Opt("cFFFFFF")
        Hotkeys.SetFont("s10","Nunito")
    }
    else {
        BuddyGui.BackColor := "c007ba8"
        BuddyGui.Color := "c000000"
        NotesGui.BackColor := "c007ba8"
        UsefulLinksGui.BackColor := "c007ba8"
        TemplatesGui.BackColor := "c007ba8"
        HotkeysGui.BackColor := "c007ba8"
        TemplateTab.Opt("xm h80 w610  BackgroundWhite c000000")
        ToolsTab.Opt("WP h80 BackgroundWhite vToolsTab c000000")
        AlwaysOnTopCheckBoxText.Opt("c000000")
        ShowNotesButtonText.Opt("c000000")
        DarkmodeButtonText.Opt("c000000")
        NotePadEmbedded.Opt("BackgroundcFFFFFF c000000")
        Notes.Opt("BackgroundcFFFFFF c000000")
        Notes.SetFont("s10","Nunito")
        Templates.Opt("BackgroundcFFFFFF c000000")
        Templates.SetFont("s10","Nunito")
        UsefulLinks.Opt("BackgroundcFFFFFF c000000")
        UsefulLinks.SetFont("s10","Nunito")
        Hotkeys.Opt("cFFFFFF")
        Hotkeys.SetFont("s10","Nunito")
    }
}

ShowNotes(ctrl,*)
{
    global NotePadEmbedded
    Global ToolsTab

    if ctrl.Value {
        BuddyGui["NotePadEmbedded"].Visible := 1
        BuddyGui.Show("h800")
        ToolsTab.Move(,, , 600)
    }
    else {
        BuddyGui["NotePadEmbedded"].Visible := 0
        BuddyGui.Show("h275 w630")
        ToolsTab.Move(,, , 80)
    }
}

; This section controls cascading dropdowns. It will clear the second dropdown field and replace it when the first is altered. This allows you to have multiple categories per department.
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

; The series of functions below are what generates the templates when the generate button is clicked. 
; They are all the same so I will break down the logic of the first one and it can be applied to the rest.

RunGeneral(ctrl, *)
{
    Global ShowNotesButton
    ; Takes the options submitted from the dropdowns and saves them to an array called "Saved"
    Saved:= BuddyGui.Submit(False)
    ; Sets the Output variable to null. Stops templates from writing over each other.
    Output := ""

    try{
    ; Checks if the reason in the "General" tab was set to "Faults"
    if (Saved.PickedGeneralReason = "NBN")
    {
        showNotes := BuddyGui["ShowNotesButton"].Value

        if (showNotes) {  ; If checkbox is checked
            Output := GeneralNBNMap.Get(Saved.PickedGeneral)
            ToolsTab.Choose(1)
            ControlFocus NotePadEmbedded
            NotePadEmbedded.Focus()
            Send Output
        }
        else {  ; If checkbox is unchecked
            TemplatesPad()
            Output := GeneralNBNMap.Get(Saved.PickedGeneral)
            ToolsTab.Choose(1)
            ControlFocus Templates
            Templates.Focus()
            Send Output 
        }
    }
    else if (Saved.PickedGeneralReason = "Hardware") 
    {
        showNotes := BuddyGui["ShowNotesButton"].Value

        if (showNotes) {  ; If checkbox is checked
            Output := GeneralHardwareMap.Get(Saved.PickedGeneral)
            ToolsTab.Choose(1)
            ControlFocus NotePadEmbedded
            NotePadEmbedded.Focus()
            Send Output
        }
        else {  ; If checkbox is unchecked
            TemplatesPad()
            Output := GeneralHardwareMap.Get(Saved.PickedGeneral)
            ToolsTab.Choose(1)
            ControlFocus Templates
            Templates.Focus()
            Send Output 
        }
    }
    else if (Saved.PickedGeneralReason = "OTRS")
    {
        showNotes := BuddyGui["ShowNotesButton"].Value

        if (showNotes) {  ; If checkbox is checked
            Output := GeneralOTRSMap.Get(Saved.PickedGeneral)
            ToolsTab.Choose(1)
            ControlFocus NotePadEmbedded
            NotePadEmbedded.Focus()
            Send Output
        }
        else {  ; If checkbox is unchecked
            TemplatesPad()
            Output := GeneralOTRSMap.Get(Saved.PickedGeneral)
            ToolsTab.Choose(1)
            ControlFocus Templates
            Templates.Focus()
            Send Output 
        }
    }
    }
    ; If the selected reason does not match, or one of the dropdowns is empty, throw as an error
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
        showNotes := BuddyGui["ShowNotesButton"].Value

        if (showNotes) {  ; If checkbox is checked
            Output := PPMap.Get(Saved.PickedAccount)
            ToolsTab.Choose(1)
            ControlFocus NotePadEmbedded
            NotePadEmbedded.Focus()
            Send Output
        }
        else {  ; If checkbox is unchecked
            TemplatesPad()
            Output := PPMap.Get(Saved.PickedAccount)
            ToolsTab.Choose(1)
            ControlFocus Templates
            Templates.Focus()
            Send Output 
        }
    }
    else if (Saved.PickedAccountReason = "Financial Hardship")
    {
        showNotes := BuddyGui["ShowNotesButton"].Value

        if (showNotes) {  ; If checkbox is checked
            Output := FHMap.Get(Saved.PickedAccount)
            ToolsTab.Choose(1)
            ControlFocus NotePadEmbedded
            NotePadEmbedded.Focus()
            Send Output
        }
        else {  ; If checkbox is unchecked
            TemplatesPad()
            Output := FHMap.Get(Saved.PickedAccount)
            ToolsTab.Choose(1)
            ControlFocus Templates
            Templates.Focus()
            Send Output 
        } 
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
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := SpeedsMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := SpeedsMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            } 
        }
    else if (Saved.PickedFaultReason = "General")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := FaultTemplatesMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := FaultTemplatesMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            } 
        }
    else if (Saved.PickedFaultReason = "Discovery")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := DiscoveryMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := DiscoveryMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            } 
        }
    else if (Saved.PickedFaultReason = "Dropouts")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := DropoutsMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := DropoutsMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            } 
        }
    else if (Saved.PickedFaultReason = "No Connection")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := ConnectionMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := ConnectionMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            } 
        }
    else if (Saved.PickedFaultReason = "Service Setup")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := SetupMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := SetupMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            } 
        }
    else if (Saved.PickedFaultReason = "CSP Linking")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := LinkMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := LinkMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            } 
        }
    else if (Saved.PickedFaultReason = "Hardware")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := HardwareMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := HardwareMap.Get(Saved.PickedFault)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            } 
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
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := HFCMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := HFCMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            } 
        }
    Else if (Saved.PickedDeliveryReason = "FTTC")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := FTTCMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := FTTCMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedDeliveryReason = "FTTP")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := FTTPMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := FTTPMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedDeliveryReason = "Validation")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := HFCMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := HFCMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedDeliveryReason = "Banlisting")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := BanlistingMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := BanlistingMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedDeliveryReason = "Missing Payment Info")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := PaymentMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := PaymentMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedDeliveryReason = "Service Request")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := ServiceRequestMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := ServiceRequestMap.Get(Saved.PickedDelivery)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
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
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := NBNMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := NBNMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedComplaintReason = "Raising")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := RaisingMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := RaisingMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedComplaintReason = "Clarification")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := ClarificationMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := ClarificationMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedComplaintReason = "Resolutions")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := ResolutionsMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := ResolutionsMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedComplaintReason = "State Changes")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := ChangesMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := ChangesMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedComplaintReason = "TIO")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := TIOMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := TIOMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
        }
    Else if (Saved.PickedComplaintReason = "Contacts")
        {
            showNotes := BuddyGui["ShowNotesButton"].Value

            if (showNotes) {  ; If checkbox is checked
                Output := ContactsMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus NotePadEmbedded
                NotePadEmbedded.Focus()
                Send Output
            }
            else {  ; If checkbox is unchecked
                TemplatesPad()
                Output := ContactsMap.Get(Saved.PickedComplaint)
                ToolsTab.Choose(1)
                ControlFocus Templates
                Templates.Focus()
                Send Output 
            }
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
        showNotes := BuddyGui["ShowNotesButton"].Value

        if (showNotes) {  ; If checkbox is checked
            Output := TCSGeneralMap.Get(Saved.PickedTCS)
            ToolsTab.Choose(1)
            ControlFocus NotePadEmbedded
            NotePadEmbedded.Focus()
            Send Output
        }
        else {  ; If checkbox is unchecked
            TemplatesPad()
            Output := TCSGeneralMap.Get(Saved.PickedTCS)
            ToolsTab.Choose(1)
            ControlFocus Templates
            Templates.Focus()
            Send Output 
        }
    }
    else if (Saved.PickedTCSReason = "Billing")
    {
        showNotes := BuddyGui["ShowNotesButton"].Value

        if (showNotes) {  ; If checkbox is checked
            Output := TCSBillingMap.Get(Saved.PickedTCS)
            ToolsTab.Choose(1)
            ControlFocus NotePadEmbedded
            NotePadEmbedded.Focus()
            Send Output
        }
        else {  ; If checkbox is unchecked
            TemplatesPad()
            Output := TCSBillingMap.Get(Saved.PickedTCS)
            ToolsTab.Choose(1)
            ControlFocus Templates
            Templates.Focus()
            Send Output 
        }
    }
    else if (Saved.PickedTCSReason = "Suspension/Termination")
    {
        showNotes := BuddyGui["ShowNotesButton"].Value

        if (showNotes) {  ; If checkbox is checked
            Output := TCSSuspensionMap.Get(Saved.PickedTCS)
            ToolsTab.Choose(1)
            ControlFocus NotePadEmbedded
            NotePadEmbedded.Focus()
            Send Output
        }
        else {  ; If checkbox is unchecked
            TemplatesPad()
            Output := TCSSuspensionMap.Get(Saved.PickedTCS)
            ToolsTab.Choose(1)
            ControlFocus Templates
            Templates.Focus()
            Send Output 
        }
    }
    else if (Saved.PickedTCSReason = "Changes")
    {
        showNotes := BuddyGui["ShowNotesButton"].Value

        if (showNotes) {  ; If checkbox is checked
            Output := TCSChangesMap.Get(Saved.PickedTCS)
            ToolsTab.Choose(1)
            ControlFocus NotePadEmbedded
            NotePadEmbedded.Focus()
            Send Output
        }
        else {  ; If checkbox is unchecked
            TemplatesPad()
            Output := TCSChangesMap.Get(Saved.PickedTCS)
            ToolsTab.Choose(1)
            ControlFocus Templates
            Templates.Focus()
            Send Output 
        }
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

; Runs a ping test using an IP address that is saved to the clipboard. Will open CMD if it is not open already
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

; Runs a traceroute using an IP address that is saved to the clipboard. Will open CMD if it is not open already
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

; Runs a nslookup using an IP address that is saved to the clipboard. Will open CMD if it is not open already
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

; This is a function to open a GUI containing two calendars, 2 edit fields and a submit button. It's for calculating prorata credits
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

        ; Generates a third GUI with the correct prorata amount
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

; Generates a GUI with a large blank input field for typing notes into. There is no check to see if it is already open as having more than one open could be intended. THIS IS NOT PERSISTENMT AND CANNOT SAVE FILES
Notepad(DarkmodeButton, *) {
    Global NotesGui, Notes    

    if !NotesGui {  ; Only create a new GUI if it doesn't exist    
        NotesGui := Gui(,"Notepad")
        NotesGui.SetFont("s10","Nunito")
        NotesGui.BackColor := "c007ba8"
        Notes := NotesGui.Add("Edit", "h600 w685", "")
        
        NotesGui.OnEvent("Close", (*) => (NotesGui := "", Notes := ""))
    }
    NotesGui.Show("w710 h620")
}

; Generates a GUI with an input field. Will only open if it is not already open to prevent duplicates. 
TemplatesPad(*) {
    Global TemplatesGui, Templates

    if !TemplatesGui {  ; Only create a new GUI if it doesn't exist
        TemplatesGui := Gui(,"Templates")
        TemplatesGui.SetFont("s10","Nunito")
        TemplatesGui.BackColor := "c007ba8"
        Templates := TemplatesGui.Add("Edit", "h600 w685", "")
        
        ; Add handler for GUI close to reset the variables
        TemplatesGui.OnEvent("Close", (*) => (TemplatesGui := "", Templates := ""))
    }
    TemplatesGui.Show("w710 h620")
}

; Generates a GUI with a pre-populated edit field. This has to be an edit field so you can copy+paste out of it
UsefulLinksPad(DarkmodeButton, *) {
    Global UsefulLinksGui, UsefulLinks
    if !UsefulLinksGui {
        UsefulLinksGui := Gui(,"Useful Links")
        UsefulLinksGui.SetFont("s10","Nunito")
        UsefulLinksGui.BackColor := "c007ba8"
        UsefulLinks := UsefulLinksGui.Add("Edit", "h600 w680", "NBN Network Outage Checker:`nhttps://www.nbnco.com.au/support/network-status`n`n------------------------------`n`nBuddy Telco Outage Checker:`nhttps://www.buddytelco.com.au/network/`n`n------------------------------`n`nBuddy Telco Plans:`nhttps://www.buddytelco.com.au/#plan`n`n------------------------------`n`nBuddy Telco Router Guides:`nhttps://www.buddytelco.com.au/help/#router`n`n------------------------------`n`nBuddy Telco Bill Explainer:`nhttps://www.buddytelco.com.au/help/bill-explainer/`n`n------------------------------`n`nBuddy Telco App Links:`nhttps://apps.apple.com/au/app/buddy-telco/id6502035422`nhttps://play.google.com/store/apps/details?id=org.aussiebroadband.buddy&pli=1`n`n------------------------------`n`nBuddy Telco Contact Page:`nhttps://www.buddytelco.com.au/contact/")
        
        UsefulLinksGui.OnEvent("Close", (*) => (UsefulLinksGui := "", UsefulLinks := ""))
    }
    UsefulLinksGui.Show("w710 h620")
}

; Generates a static GUI with a list of hotkeys that do not have GUI buttons
HotkeysPad(*) {
    Global HotkeysGui, Hotkeys
    if !HotkeysGui {
        HotkeysGui := Gui(,"Available Hotkeys")
        HotkeysGui.SetFont("s10","Nunito")
        HotkeysGui.BackColor := "c007ba8"
        Hotkeys := HotkeysGui.Add("Text", "+Wrap cFFFFFF", "Available Hotkeys:`n`n@@ - Your email`n`n~~ - Date 7 calendar days from now. For abandoment comms`n`nCTRL+S - Randomized signature for app faults. Also checks the publish to app checkbox`n`nCTRL+DEL - Content aware search ie. Superlookup")
        
        HotkeysGui.OnEvent("Close", (*) => (HotkeyssGui := "", Hotkeys := ""))
    }
    HotkeysGui.Show("w710 h250")
}

; Runs when you press the lock terminal button. Locks the Terminal.
LockTerminal(*)
{
    Run "rundll32 user32.dll`,LockWorkStation"
}

; Hotkey to run the function below
<^Del::ProcessSuperlookup()

; Content-aware search. Can be run with the hotkey above. Just a bunch of regex to search the clipboard for certain strings and then append them to URLs and then open said URL
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
        Run "https://cms.aussiebroadband.com.au/?wq=" MATCH[0]
    ;Emails
    else if (RegExMatch(A_Clipboard, "^[^@]+@[^@]+\.[^@]+$", &Match))
        Run "https://cms.aussiebroadband.com.au/?type=email&search=" MATCH[0]

    else if (RegExMatch(A_Clipboard, "^16937\d{6}$", &Match))
        Run "https://www.speedtest.net/result/" MATCH[0]
}

; Runs the stuff I need to work for the day. Only opens a single instance of them
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

; Sets the variables for the logged in users full name, and first name.
csFullName := A_UserName
csFirstName := ""
Match:=""
;  Declares a Dice variable at 0
Dice:= 0
; Declares an array of sign offs for CSP faults
sign := ["Regards,", "Cheers,", "Have a great day{!}", "All the best,"]

; Regex matches the full name, removes anything after the full stop and converts to Title Case to get the first name in a variable.
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

^+s::{ ; Randomized signature. Also auto-ticks the publish to app button and focuses the submit button so you can just hit enter.
    Dice:= Random(1,4)
    Selected := sign.Get(Dice)
    Send (Selected)
    Send "{Enter}"
    Send (csTitle)
    SendInput "{Tab 1}{Space}"
	SendInput "{Tab 3}"
    Dice:= Random(1,4)   
}