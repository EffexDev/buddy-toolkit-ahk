#Requires AutoHotkey v2.0
#Include Functions.ahk
;Git Test
; --------------- Data ----------------
AccountReasons := ["Billing", "Financial Hardship", "Misc", "Redirection"]
AccountTemplates := [[ "Payment Plan","Financial Hardship","Misc","Redirection"],[ "1 1","1 1","1","1"],[ "1 1","1 1","1","1"],[ "1 1","1 1","1","1"]]
PPMap := Map(
    "Payment Plan", "Day 1 SMS: Test SMS{!}`n`nDay 1 Email: Test Email`n`nDay 2 SMS: Test SMS 2`n`nDay 2 Email: Test Email 2",
    "Financial Hardship", "Day 1 SMS: Test SMS{!}`n`nDay 1 Email: Test Email`n`nDay 2 SMS: Test SMS 2`n`nDay 2 Email: Test Email 2",
    "Misc", "Day 1 SMS: Test SMS{!}`n`nDay 1 Email: Test Email`n`nDay 2 SMS: Test SMS 2`n`nDay 2 Email: Test Email 2",
    "Redirection", "Day 1 SMS: Test SMS{!}`n`nDay 1 Email: Test Email`n`nDay 2 SMS: Test SMS 2`n`nDay 2 Email: Test Email 2",
)

FaultReasons := ["General", "Slow Speeds", "Dropouts", "No Connection", "Service Setup"]
FaultTemplates := [[ "Day 1","2",]]

DeliveryReasons := ["Activations", "Validation", "Banlisting", "Missing Payment Info", "Duplicate"]
DeliveryTemplates := [[ "1","2",]]

ComplaintReasons := ["NBN", "Raising", "Clarification", "Resolutions", "State Changes", "TIO"]
ComplaintTemplates := [[ "1","2",]]

; --------------- Templates ----------------
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
GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunAccount)

TemplateTab.UseTab(2)
SelFaultReason := BuddyGui.AddDropDownList("w160 h100 r20 BackgroundFFFFFF Choose1", FaultReasons)
SelFaultReason.OnEvent('Change', SelFaultReasonSelected)
SelFaultTemplate := BuddyGui.AddDropDownList("yp w160 r20 BackgroundFFFFFF vPickedFault", FaultTemplates[SelFaultReason.Value])
; GenerateFault := BuddyGui.Add("Button", "yp", "Generate").OnEvent("Click", RunFault)

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
BuddyGui.Show("h500")

; --------------- Tools ----------------
ToolsTab.UseTab(1)
Notes := BuddyGui.Add("Edit", "h300 w415", "")

ToolsTab.UseTab(2)
BuddyGui.Add("Edit", "vSearchTerm w100")
BuddyGui.Add("Button", "yp", "Google").OnEvent("Click", ProcessGoogle)

BuddyGui.Add("Button","yp", "Superlookup").OnEvent("Click", ProcessSuperlookup)



