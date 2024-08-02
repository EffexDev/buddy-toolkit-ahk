#Requires AutoHotkey v2.0

; --------------- Arrays ----------------
AccountReasons := ["Billing", "Financial Hardship", "Misc", "Redirection"]
AccountTemplates := [[ "Day 1","2",],[ "3", "4", "5"], [ "6", "7", "8"], [ "9", "1", "2"]]

FaultReasons := ["General", "Slow Speeds", "Dropouts", "No Connection", "Service Setup"]
FaultTemplates := [[ "Day 1","2",],[ "3", "4", "5"], [ "6", "7", "8"], [ "9", "1", "2"], [ "3", "4", "5"]]

DeliveryReasons := ["Activations", "Validation", "Banlisting", "Missing Payment Info", "Duplicate"]
DeliveryTemplates := [[ "1","2",],[ "3", "4", "5"], [ "6", "7", "8"], [ "9", "1", "2"], [ "3", "4", "5"]]

ComplaintReasons := ["NBN", "Raising", "Clarification", "Resolutions", "State Changes", "TIO"]
ComplaintTemplates := [[ "1","2",],[ "3", "4", "5"], [ "6", "7", "8"], [ "9", "1", "2"], [ "3", "4", "5"], [ "a", "b", "c"]]

; --------------- Templates ----------------
BuddyGui := Gui("+Border","Buddy Contact Board")
BuddyGui.BackColor := "c0082af"
BuddyGui.SetFont("s12","Nunito")
BuddyGui.Add("Picture", "w200 h-1","BuddyLogo.png")
TemplateTab := BuddyGui.Add("Tab2","h80 w450 BackgroundWhite", ["Accounts", "Faults","Delivery","Complaints",])
ToolsTab := BuddyGui.Add("Tab3", "h300 w450 BackgroundWhite", ["QOL", "Automations"])

TemplateTab.UseTab(1)
SelAccountReason := BuddyGui.AddDropDownList("w150 h100 r20 BackgroundFFFFFF Choose1", AccountReasons)
SelAccountReason.OnEvent('Change', SelAccountReasonSelected)
SelAccountTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedAccount", AccountTemplates[SelAccountReason.Value])

TemplateTab.UseTab(2)
SelFaultReason := BuddyGui.AddDropDownList("w150 h100 r20 BackgroundFFFFFF Choose1", FaultReasons)
SelFaultReason.OnEvent('Change', SelFaultReasonSelected)
SelFaultTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedFault", FaultTemplates[SelFaultReason.Value])
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunFault)

TemplateTab.UseTab(3)
SelDeliveryReason := BuddyGui.AddDropDownList("w150 h100 r20 BackgroundFFFFFF Choose1", DeliveryReasons)
SelDeliveryReason.OnEvent('Change', SelDeliveryReasonSelected)
SelDeliveryTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF Choose1", DeliveryTemplates[SelDeliveryReason.Value])

TemplateTab.UseTab(4)
SelComplaintReason := BuddyGui.AddDropDownList("w150 h100 r20 BackgroundFFFFFF Choose1", ComplaintReasons)
SelComplaintReason.OnEvent('Change', SelComplaintReasonSelected)
SelComplaintTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF Choose1", ComplaintTemplates[SelComplaintReason.Value])
BuddyGui.Show()

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

    RunFault(*)
    {
        FaultSaved := BuddyGui.Submit(False)
        if (FaultSaved.PickedFault == "Day 1")
            PickedFaultGui := gui("+Border","Buddy Contact Board")
            PickedFaultGui.Add("Edit","w300 h300","SMS: We have been trying to reach you`n`n`nEmail: Test Email`n`n`nNotes: Test Notes")
            PickedFaultGui.Show()
    }

; --------------- Tools ----------------
ToolsTab.UseTab(1)
BuddyGui.Add("Edit", "vSearchTerm w100")
BuddyGui.Add("Button", "yp", "Google").OnEvent("Click", ProcessGoogle)

ProcessGoogle(*)
{
    Saved := BuddyGui.Submit(False)
    Run ("https://www.google.com/search?q=" Saved.SearchTerm)
}

BuddyGui.Add("Button","yp", "Superlookup").OnEvent("Click", ProcessSuperlookup)

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

