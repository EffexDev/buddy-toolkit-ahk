#Requires AutoHotkey v2.0
#Include BuddyToolKit.ahk

; --------------- Accounts ----------------
AccountReasons := ["Payment Plan", "Financial Hardship"]
AccountTemplates := [["Set Up","Confirmation", "Payment Options", "Update Details"],["Day 1", "Day 2", "Day 3"]]
PPMap := Map(
    "Set Up", "Hey xxx,`n`nIf you would like to set up a payment plan, you can do so in the billing section of the Buddy Telco App.`n`nNavigate to the Billing tab at the bottom of the app`nTap the Request a Payment Extension button`nEnter your preferred payment date`n`nYou will receive email confirmation once the plan has been set.`n`nRegards,`nxxx",

    "Confirmation", "Hey xxx,`n`nWe have set the payment plan that you have requested. You should receive a confirmation email outlining the details shortly.`n`nRegards,`nxxx",

    "Payment Options", "Hey xxx,`n`nThe payment methods we currently accept are direct debit and card payments. If you would like to update your payment details you can do this through the billing section of the app.`n`nRegards,`nxxx",

    "Update Details", "Hey xxx,`n`nIf you would like to update your payment details, you can do so through the billing section of the Buddy Telco App.`n`nNavigate to the Billing tab at the bottom of the app`nTap the edit button next to payment method at the top`nComplete the 2FA via SMS or Email`nEnter your new billing information`n`nYour payment details are now updated.`n`nRegards,`nxxx",
)

FHMap := Map(
    "Template", "Hi [Customer],`n`nThank you for submitting your application for financial hardship payment assistance. To progress your application, we will require you to provide some supporting information to assess your eligibility.`n`nThis can be in the form of:`nIncome statement`n Expense statement`nDocumentation from a financial counsellor`nOther documentation showing circumstances related to financial hardship`n`nYou can respond to this email with your documents or send them to hardship@buddytelco.com.au`n`nWe will consider any documents relating to income, statements from advisors and your past payment history with us when we make an assessment.`n`nWe only request this information when it is necessary for us to assess eligibility. We will only retain a copy or record of any information you provide us, for as long is required to complete our assessment of your application. We may not be able to assess your circumstances if you don't provide us with the requested information. However, we also understand that sometimes (for example, if you are experiencing domestic or family violence) you may not be able to provide documents.`n`nWe're here to help. Give us a call to discuss your application with one of our Financial Hardship Officers by phone on 1300 028 339 (9am-5pm AWST).",
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


