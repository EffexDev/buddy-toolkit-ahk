#Requires AutoHotkey v2.0
#Include Functions.ahk

!1::
{
    Reload
}
; --------------- Accounts ----------------
Days := ["Day 1", "Day 2", "Day 3"]

AccountReasons := ["Billing", "Misc"]
AccountTemplates := [["Payment Plan","Financial Hardship"],["Misc", "Redirection"]]
PPMap := Map(
    "Day 1", "PP 1",
    "Day 2", "PP 2",
    "Day 3", "PP 3",
)

FHMap := Map(
    "Day 1", "FH 1",
    "Day 2", "FH 2",
    "Day 3", "FH 3",
)

MiscMap := Map(
    "Day 1", "Misc 1",
    "Day 2", "Misc 2",
    "Day 3", "FH 3",
)

;------------------- Faults -----------------------
FaultReasons := ["Contacts","Slow Speeds", "Dropouts", "No Connection", "Service Setup"]
FaultTemplates := [["Day 1", "Day 2", "Day 3"],["Questions", "Wifi"],["Questions"],["Questions"],["TP-Link"]]

FaultContactsMap := Map(
    "Day 1", "1",
    "Day 2", "2",
    "Day 3", "3",
    )

SpeedsMap := Map(
    "Questions", "SpeedQ",
    "Wifi", "FH 2",
)

DropoutsMap := Map(
    "Questions", "DropQ",
    "Wifi", "FH 2",
    "Day 3", "FH 3",
)

ConnectionMap := Map(
    "Questions", "Misc 1",
)

SetupMap := Map(
    "TP-Link", "Misc 1",
)

DeliveryReasons := ["Activations", "Validation", "Banlisting", "Missing Payment Info", "Duplicate"]
DeliveryTemplates := [[ "1","2",]]

ComplaintReasons := ["NBN", "Raising", "Clarification", "Resolutions", "State Changes", "TIO"]
ComplaintTemplates := [[ "1","2",]]

;----------------Global Maps--------------
RedirectionMap := Map(
    "Day 1", "RD 1",
    "Day 2", "RD 2",
    "Day 3", "RD 3",
)


