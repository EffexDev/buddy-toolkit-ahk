AccountMap := Map(
    "Billing", "Day 1 SMS: This is a test on day 1`n`nDay 2 SMS: This is a test on day 2",
    "Financial Hardship", "2",
    "Misc", "3",
    "Redirection", "4"
)

BillingArray := ["Billing", "Misc"]
TestGui := Gui("+AlwaysOnTop")
UserInput := TestGui.Add("DropDownList", "w200 vUserInput", BillingArray)
TestGui.Add("Button","yp","ok").OnEvent("Click", ProcessMapInput)
OutputField := TestGui.Add("Edit","xm w200 h200")
TestGui.show()

ProcessMapInput(*)
{
    Saved:= TestGui.Submit(False)
    Output := AccountMap.Get(Saved.UserInput)
    OutPutField.Focus()
    Send Output
}


