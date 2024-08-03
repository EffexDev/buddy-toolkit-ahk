#Requires AutoHotkey v2.0
#Include BuddyGuiV2.ahk

; --------------- GUI ----------------
BuddyGui := Gui("+Border","Buddy Contact Board")
BuddyGui.BackColor := "c0082af"
BuddyGui.SetFont("s12","Nunito")
; BuddyGui.Add("Picture", "w200 h-1","BuddyLogo.png")
TemplateTab := BuddyGui.Add("Tab2","h100 w450  BackgroundWhite", ["Accounts", "Faults","Delivery","Complaints",])
ToolsTab := BuddyGui.Add("Tab3", " w450 BackgroundWhite", ["Notepad", "QOL", "Automations"])

TemplateTab.UseTab(1)
SelAccountReason := BuddyGui.AddDropDownList("w160 h100 r20 BackgroundFFFFFF vPickedAccountReason Choose1", AccountReasons)
SelAccountReason.OnEvent('Change', SelAccountReasonSelected)
SelAccountTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedAccount", AccountTemplates
[SelAccountReason.Value])
ChosenDay := BuddyGui.AddDropDownList("yp w100 r3 BackgroundFFFFFF vDayNumber", Days)
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunAccount)

TemplateTab.UseTab(2)
SelFaultReason := BuddyGui.AddDropDownList("w160 h100 r20 BackgroundFFFFFF vPickedFaultReason Choose1", FaultReasons)
SelFaultReason.OnEvent('Change', SelFaultReasonSelected)
SelFaultTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedFault", FaultTemplates[SelFaultReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunFault)

TemplateTab.UseTab(3)
SelDeliveryReason := BuddyGui.AddDropDownList("w160 h100 r20 BackgroundFFFFFF Choose1", DeliveryReasons)
SelDeliveryReason.OnEvent('Change', SelDeliveryReasonSelected)
SelDeliveryTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedDelivery", DeliveryTemplates[SelDeliveryReason.Value])
; GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunFault)

TemplateTab.UseTab(4)
SelComplaintReason := BuddyGui.AddDropDownList("w160 h100 r20 BackgroundFFFFFF Choose1", ComplaintReasons)
SelComplaintReason.OnEvent('Change', SelComplaintReasonSelected)
SelComplaintTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedComplaints", ComplaintTemplates[SelComplaintReason.Value])
; GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunFault)
BuddyGui.Show("h460")

ToolsTab.UseTab(1)
Notes := BuddyGui.Add("Edit", "h300 w415", "")

ToolsTab.UseTab(2)
BuddyGui.Add("Edit", "vSearchTerm w100")
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
    if (Saved.PickedAccount = "Payment Plan")
    {
        Output := PPMap.Get(Saved.DayNumber)
        ControlFocus Notes
        Notes.Focus()
        Send Output
    }
    else if (Saved.PickedAccount = "Financial Hardship")
    {
        Output := FHMap.Get(Saved.DayNumber)
        ControlFocus Notes
        Notes.Focus()
        Send Output 
    }
    else if (Saved.PickedAccount = "Misc")
    {
        Output := MiscMap.Get(Saved.DayNumber)
        ControlFocus Notes
        Notes.Focus()
        Send Output 
    }
    else if (Saved.PickedAccount = "Redirection")
    {
        Output := RedirectionMap.Get(Saved.DayNumber)
        ControlFocus Notes
        Notes.Focus()
        Send Output 
    }
}

RunFault(*)
{
    Saved:= BuddyGui.Submit(False)
    Output := ""
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