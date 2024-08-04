#Requires AutoHotkey v2.0
#Include Functions.ahk

; --------------- Accounts ----------------
AccountReasons := ["Payment Plan", "Financial Hardship"]
AccountTemplates := [["Day 1","Day 2", "Day 3"],["Day 1", "Day 2", "Day 3"]]
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
DeliveryTemplates := [["Day 1","Day 2", "Day 3"],["Day 1","Day 2", "Day 3"],["Day 1","Day 2", "Day 3"],["Day 1","Day 2", "Day 3"],["Day 1","Day 2", "Day 3"]]
ActivationsMap := Map(
    "Day 1", "1",
    "Day 2", "2",
    "Day 3", "3",
    )

ValidationMap := Map(
    "Day 1", "SpeedQ",
    "Day 2", "FH 2",
    "Day 3", "FH 2",
)

BanlistingMap := Map(
    "Day 1", "DropQ",
    "Day 2", "FH 2",
    "Day 3", "FH 3",
)

PaymentMap := Map(
    "Day 1", "Misc 1",
    "Day 2", "FH 2",
    "Day 3", "FH 2",
)

DupeMap := Map(
    "TP-Link", "Misc 1",
)

ComplaintReasons := ["NBN", "Raising", "Clarification", "Resolutions", "State Changes", "TIO"]
ComplaintTemplates := [["Test"],["Test"],["Test"],["Test"],["Test"],["Test"]]
NBNMap := Map(
    "Test", "1",
    )

RaisingMap := Map(
    "Test", "1",
    )

ClarificationMap := Map(
    "Test", "1",
    )

ResolutionsMap := Map(
    "Test", "1",
    )

ChangesMap := Map(
    "Test", "1",
    )

TIOMap := Map(
    "Test", "1",
    )

;----------------Global Maps--------------
RedirectionMap := Map(
    "Day 1", "RD 1",
    "Day 2", "RD 2",
    "Day 3", "RD 3",
)


