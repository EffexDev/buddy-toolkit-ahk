#Requires AutoHotkey v2.0
#Include BuddyGuiV2.ahk

; --------------- GUI ----------------
BuddyGui := Gui("+Border -Caption","Buddy Contact Board")
BuddyGui.BackColor := "c0082af"
BuddyGui.SetFont("s12","Nunito")
; BuddyGui.Add("Picture", "w200 h-1","BuddyLogo.png")
TemplateTab := BuddyGui.Add("Tab2","h100 w770  BackgroundWhite", ["Accounts", "Faults","Delivery","Complaints",])
ToolsTab := BuddyGui.Add("Tab3", "h660 w770 BackgroundWhite", ["Notepad", "QOL", "Automations"])

TemplateTab.UseTab(1)
SelAccountReason := BuddyGui.AddDropDownList("w160 h100 r20 BackgroundFFFFFF vPickedAccountReason Choose1", AccountReasons)
SelAccountReason.OnEvent('Change', SelAccountReasonSelected)
SelAccountTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedAccount", AccountTemplates
[SelAccountReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunAccount)

TemplateTab.UseTab(2)
SelFaultReason := BuddyGui.AddDropDownList("w160 h100 r20 BackgroundFFFFFF vPickedFaultReason Choose1", FaultReasons)
SelFaultReason.OnEvent('Change', SelFaultReasonSelected)
SelFaultTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedFault", FaultTemplates[SelFaultReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunFault)

TemplateTab.UseTab(3)
SelDeliveryReason := BuddyGui.AddDropDownList("w160 h100 r20 BackgroundFFFFFF vPickedDeliveryReason Choose1", DeliveryReasons)
SelDeliveryReason.OnEvent('Change', SelDeliveryReasonSelected)
SelDeliveryTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedDelivery", DeliveryTemplates[SelDeliveryReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunDelivery)

TemplateTab.UseTab(4)
SelComplaintReason := BuddyGui.AddDropDownList("w160 h100 r20 BackgroundFFFFFF vPickedComplaintReason Choose1", ComplaintReasons)
SelComplaintReason.OnEvent('Change', SelComplaintReasonSelected)
SelComplaintTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedComplaint", ComplaintTemplates[SelComplaintReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunComplaint)
BuddyGui.Show("x1920 y0 w800 h1080")

ToolsTab.UseTab(1)
Notes := BuddyGui.Add("Edit", "h600 w730", "")

ToolsTab.UseTab(2)
BuddyGui.Add("Edit", "vSearchTerm w300")
BuddyGui.Add("Button", "yp", "Google").OnEvent("Click", ProcessGoogle)

BuddyGui.Add("Button","yp", "Superlookup").OnEvent("Click", ProcessSuperlookup)

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
    if (Saved.PickedFaultReason = "Contacts")
        {
        Output := FaultContactsMap.Get(Saved.PickedFault)
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
    if (Saved.PickedDeliveryReason = "Activations")
        {
            Output := ActivationsMap.Get(Saved.PickedDelivery)
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
    Else if (Saved.PickedDeliveryReason = "Duplicate")
        {
            Output := DupeMap.Get(Saved.PickedDelivery)
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

;------------------------- Tools -------------------------------------
    ProcessGoogle(*)
{
    Saved := BuddyGui.Submit(False)
    Run ("https://www.google.com/search?q=" Saved.SearchTerm)
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