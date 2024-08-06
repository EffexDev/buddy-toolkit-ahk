#Requires AutoHotkey v2.0
#Include BuddyToolKit.ahk

; --------------- Accounts ----------------
AccountReasons := ["Payment Plan", "Financial Hardship"]
AccountTemplates := [["Set Up","Confirmation", "Payment Options", "Update Details"],["Template"]]
PPMap := Map(
    "Set Up", "Hey xxx,`n`nIf you would like to set up a payment plan, you can do so in the billing section of the Buddy Telco App.`n`nNavigate to the Billing tab at the bottom of the app`nTap the Request a Payment Extension button`nEnter your preferred payment date`n`nYou will receive email confirmation once the plan has been set.`n`nRegards,`nxxx",

    "Confirmation", "Hey xxx,`n`nWe have set the payment plan that you have requested. You should receive a confirmation email outlining the details shortly.`n`nRegards,`nxxx",

    "Payment Options", "Hey xxx,`n`nThe payment methods we currently accept are direct debit and card payments. If you would like to update your payment details you can do this through the billing section of the app.`n`nRegards,`nxxx",

    "Update Details", "Hey xxx,`n`nIf you would like to update your payment details, you can do so through the billing section of the Buddy Telco App.`n`nNavigate to the Billing tab at the bottom of the app`nTap the edit button next to payment method at the top`nComplete the 2FA via SMS or Email`nEnter your new billing information`n`nYour payment details are now updated.`n`nRegards,`nxxx",
)

FHMap := Map(
    "Template", "Hi [Customer],`n`nThank you for submitting your application for financial hardship payment assistance. To progress your application, we will require you to provide some supporting information to assess your eligibility.`n`nThis can be in the form of:`nIncome statement`nExpense statement`nDocumentation from a financial counsellor`nOther documentation showing circumstances related to financial hardship`n`nYou can respond to this email with your documents or send them to hardship@buddytelco.com.au`n`nWe will consider any documents relating to income, statements from advisors and your past payment history with us when we make an assessment.`n`nWe only request this information when it is necessary for us to assess eligibility. We will only retain a copy or record of any information you provide us, for as long is required to complete our assessment of your application. We may not be able to assess your circumstances if you don't provide us with the requested information. However, we also understand that sometimes (for example, if you are experiencing domestic or family violence) you may not be able to provide documents.`n`nWe're here to help. Give us a call to discuss your application with one of our Financial Hardship Officers by phone on 1300 028 339 (9am-5pm AWST).",
)

;------------------- Faults -----------------------
FaultReasons := ["General","Slow Speeds", "Dropouts", "No Connection", "Service Setup", "CSP Linking", "Hardware"]
FaultTemplates := [["Titles", "Warning", "Closing", "NBN Raise", "Resets", "Router Swap"],["Direct Connection", "Wifi Limitations", "Bandsteering", "Line Rates"],["Bandsteering", "Stability Profile", "SRA", "Cabling"],["UNI-D Port", "Outage"],["VDSL", "EWAN"],["NBN", "Tracking"],["Local Issue", "Cabling"]]
FaultGeneralMap := Map(
    "Titles", "No Connection`n`nService Setup`n`nService Never Worked`n`nSlow Speeds`n`nDropouts`n`n",

    "Warning", "Hey xxx,`n`nJust wanted to reach out to see if you still needed a hand with this fault?`n`nIf we don`'t hear back from you within the next day or so we will close the fault off, but we can re-open it in the future if we need to.`n`nRegards,`nxxx`n`n------------------------------`n`nHey, Buddy Telco here. Just a quick reminder to jump on the app and check the response to your fault.",

    "Closing", "Hey xxx,`n`nSince we didn`'t hear back we will close this fault off but if you need us to investigate in future just let us know.`n`nRegards,`nxxx",

    "NBN Raise", "Hey xxx,`n`nWe will need to raise this fault to NBN. `n`nPlease select from the following list of appointments or speak to our LiveChat team as the list will may not include the earliest available appointments.`n`n(Insert appts here)`n`nRegards,`nxxx`n------------------------------`nHey Team`n`nCustomer is experiencing a (Insert Fault Type). `nTesting that has been done:`n(Insert T/S and test relevant test results)`n`nPlease investigate`n`nRegards,`nAussie Broadband",

    "Resets", "FTTC: Hey xxx,`n`nIf the link light on your NBN device is red, please perform a factory reset on the device. `n`nYou can do this by locating the small hole labelled reset, and holding a pin, paperclip or SIM ejector tool into this for 15 seconds.`n`nOnce this is done, please let us know if the light is now blue again. `n`nIf this does not resolve the issue, please test using another DSL (Phone) cable, from the NBN device to the telephone port on the wall.`n`nRegards,`nxxx`n`n------------------------------`n`nFTTPHey xxx,`n`nIf the optical light on your NBN device is red, please perform a factory reset on the device.`n`nYou can do this by locating the small hole labelled reset, and holding a pin, paperclip or SIM ejector tool into this for 15 seconds.`n`nPlease check to ensure the fibre optic cable is not damaged in any way. This is the thin yellow or white cable with the green connector. Avoid touching this cable if possible as it is very fragile.`n`nIf the issue does not resolve after the reset, or the cable is damaged, let us know as we may need to raise this to NBN`n`nRegards,`nxxx`n`n------------------------------`n`nHFC: Hey xxx,`n`nWe will need you to perform a hard reset on the NBN NTD.`n`n1. Please unscrew the coaxial cable (TV antenna) from the NBN device.`n`n2. In the back of your nbn box there should be a little reset hole, please try holding a paperclip or pin in your nbn box for 15 seconds to reset it.`n`n3. Now screw the coaxial cable back in.`n`nIf the device does not fully restore after a minute or two please let us know.`n`nRegards,`nxxx`n",

    "Router Swap", "Hey xxx,`n`nPlease see the below instructions for switching your router for another device:`n`n1. Kick your connection using the service tests in the Buddy Telco App`n2. Unplug your Modem/Router from the NBN device`n3. Using the same cable from the NBN device, plug in your new router.`n4. Test the connection once the service becomes active`n`nRegards,`nxxx",
    )

SpeedsMap := Map(
    "Direct Connection", "Hey xxx,`n`nCan you please run some direct connection speed tests? This will show us whether the speeds coming directly from NBNco are poor or not, if the results show an issue it acts as evidence should we need to raise this to nbn.`n`nDirect connection speed test instructions:`n`n1. Kick your connection using the service tests in Buddy app`n2. Unplug your Modem/Router from the NBN device`n3. Using the same cable from the NBN device, plug in a laptop or computer.`n4. Run 3-5 speed tests through www.speedtest.net`n5. Reply to us with the Result IDs the tests generate `n6. Kick the connection again via the Buddy App`n7. Swap from the laptop/PC to the Modem/Router `n`nIf you have any further questions, issues or concerns, reply here or just hop on our live chat, and our friendly team will assist you in no time. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nRegards,`nxxx",

    "Wifi Limitations", "Hey xxx,`n`nWiFi speeds are unfortunately not a good indicator of achievable service speeds.`n`nIt is possible to improve the speeds by adjusting the frequency and channels of the WiFi, which we can provide instructions for, however the automatic mode on most routers is sufficient. What is more likely to help is assessing environmental factors such as distance, line of sight and interference.`n`nTo limit interference please ensure that the router is connected to power on its own socket, not in a power board, and avoid placing it near large white good appliances or microwaves. Metal objects do block WiFi signals so avoid having large metal objects between your router and connected devices.`n`nRegards,`nxxx",

    "Bandsteering", "Hey xxx,`n`nMost modern routers have two WiFi bands, 2.4Ghz and 5Ghz. The 2.4 band has higher range but a lower total throughput, and the 5 band has lower range but higher throughput. If you only see one wifi channel from your router, it means that a setting called band steering is combining the band for you, and negotiating which devices connect to which channel.`n`nFor most scenarios this is ideal, however band steering can sometimes default your devices to the 2.4Ghz band, causing lower than expected speeds.`n`nIn these instances we can walk you through disabling the band steering option on your router if it is available.`n`nRegards,`nxxx",

    "Line Rates", "Below Spec: Hey xxx,`n`nYour service has fallen below NBN specifications, which means we know it is an infrastructure issue and we can raise a ticket to NBN.`n`nPlease select from one of the below available appointments.`n`n(Insert appts here)`n`nRegards,`nxxx`n`n------------------------------`n`nAbove Spec: Hey xxx, `n`nNBN does a minimum assured speed for each FTTN and FTTC service. At this stage your service is currently above that specification which means we need to do some more local troubleshooting.`n`n(Insert instructions or discovery questions here)`n`nRegards,`nxxx`n`n------------------------------`n`nHFC: Hey xxx, `n`nThe speed specifications for HFC is approximately 50% of the plan speed. In the case of high speed services the minimum specifications are:`n1000/50 plan then the minimum speed is 501/25.`n250/25 plan then the minimum speed is 126/12.`n`nTo determine this we will need you to run direct connection tests from a laptop or PC directly to the NBN device.`n`nDirect connection speed test instructions:`n1. Kick your connection using the service tests in the Buddy Telco App`n2. Unplug your Modem/Router from the NBN device`n3. Using the same cable from the NBN device, plug in a laptop or computer.`n4. Run 3-5 speed tests through www.speedtest.net[/url]`n5. Reply to us with the Result IDs the tests generate `n6. Kick the connection again via the Buddy App`n7. Swap from the laptop/PC to the Modem/Router `n`nRegards,`nxxx`n`n------------------------------`n`nFTTP: Hey xxx,`n`nThe speed specifications for FTTP is approximately 50% of the plan speed. In the case of high speed services the minimum specifications are:`n1000/50 plan then the minimum speed is 501/25.`n250/25 plan then the minimum speed is 126/12.`n`nTo determine this we will need you to run direct connection tests from a laptop or PC directly to the NBN device, as NBN will not accept tests done over Wi-Fi or ethernet to the router.`n`nDirect connection speed test instructions:`n1. Kick your connection using the service tests in the Buddy Telco App`n2. Unplug your Modem/Router from the NBN device`n3. Using the same cable from the NBN device, plug in a laptop or computer.`n4. Run 3-5 speed tests through www.speedtest.net[/url]`n5. Reply to us with the Result IDs the tests generate `n6. Kick the connection again via the Buddy App`n7. Swap from the laptop/PC to the Modem/Router `n`nRegards,`nxxx"
)

DropoutsMap := Map(
    "Bandsteering", "Hey xxx,`n`nMost modern routers have two WiFi bands, 2.4Ghz and 5Ghz. The 2.4 band has higher range but a lower total throughput, and the 5 band has lower range but higher throughput. If you only see one wifi channel from your router, it means that a setting called band steering is combining the band for you, and negotiating which devices connect to which channel.`n`nFor most scenarios this is ideal, however band steering can sometimes cause your devices to disconnect when attempting to switch from one band to another. This will present as micro-dropouts, usually when roaming around the house.`nIn these instances we can walk you through logging into your router.`n`nRegards,`nxxx",

    "Stability Profile", "Apply: Hey  xxx,`n`nIn order for us to raise this as a dropouts fault with NBN, we need to apply a stability profile and monitor the connection for 48 hours. The profile can negatively affect speeds to a degree. Please let us know when it would be an appropriate time for us to apply this, as it will cause the router to lose connection momentarily. `n`nRegards,`nxxx`n`n------------------------------`n`nRemove: Hey xxx,`n`nAs the testing now shows no dropouts we could now look at removing the stability profile on your service to return your speeds back to normal. When we do this, you will initially experience a dropout whilst your modem re-syncs. `n`nRegards,`nxxx",

    "SRA", "Hey xxx,`n`nSRA and SOS/ROC are protocols that ensure the router remains connected at the correct frequency. When the router first syncs wit DSL/RJ11 cable. (This is ah the NBN line it syncs at the current line rate. SRA and SOS/ROC allow it to change to different line rates when the frequency on the incoming copper changes. If SRA and SOS/ROC are not showing on the NBN testing or are not available settings on the router this can cause dropouts and speed fluctuations. If the settings are not available in the router, it may need a firmware upgrade, or the router may not be compatible.`n`nRegards,`nxxx",

    "Cabling", "Hey xxx,`n`nDue to the number of external factors that can affect WiFi signals, we are unable to isolate dropouts faults using WiFi troubleshooting.`nAre you able to connect a device such as a laptop or PC to the router using an ethernet cable and test to see if the dropouts still occur?`n`nAnother good way to tell the difference is if your mobile phone will switch back to mobile data when the dropout occurs. If it does, you likely have a local WiFi issue.`n`nRegards,`nxxx"
)

ConnectionMap := Map(
    "UNI-D Port", "Hey xxx,`n`nIt looks like your router might be plugged into the wrong port on the NBN device. `n`nEnsure that your router is connected to (Insert UNI-D port).`n`nRegards,`nxxx",

    "Outage", "Ongoing: Hey xxx,`n`nUnfortunately at this stage your service is being affected by an outage. We do not currently have an ETA on a fix but the issue is currently being investigated.`n`nIf you have any further questions, issues or concerns, feel free to simply reply back to this message or reach out to our support team via LiveChat from our website or within the Buddy Telco App.`n`nRegards,`nxxx`n`n------------------------------`n`nResolved: Hey xxx,`n`nIt does appear that your service was being affected by an outage that has since been resolved, if you are still having issues please power-cycle your router (turn off and on).`n`nIf the issue has been resolved alongside that outage let us know and we`'ll close this fault off, otherwise we may close this fault as resolved anyway within 24 hours `n`nRegards,`nxxx"
)

SetupMap := Map(
    "VDSL", "Hey xxx,`n`nPlease find the below settings for your VDSL connection. Bear in mind that these are generic settings, and may vary in name based off your router brand. `nLog into your router using the IP address/URL on the bottom/back of the router. (It might look like 192.168.0.1)`nEnter the username and password located near that IP address/URL. Locate the Setup Connection section or enter the quick setup.`n`nConnection Mode: VDSL`nConnection Type: Dynamic IP `nPrimary: 202.142.142.142`nSecondary: 202.142.142.242`n802.11P: -1`nVLAN Tag: -1`nNAT: Enabled`nFirewall: Enabled`nMTU Size: 1500 `nMSS Size: 1460`nIP Protocol: IPv4/IPv6 `nDHCPv6 (IANA): Enabled`nDHCPv6 (IAPD): Enabled`nIGMP: Enabled`n`nRegards,`nxxx",

    "EWAN", "Hey xxx, `n`nPlease find the below settings for your EWAN connection. Bear in mind that these are generic settings, and may vary in name based off your router brand. `nLog into your router using the IP address/URL on the bottom/back of the router. (It might look like 192.168.0.1)`nEnter the username and password located near that IP address/URL. Locate the Setup Connection section or enter the quick setup.`n`nConnection Mode: EWAN or Ethernet WAN`nConnection Type: Dynamic IP `nPrimary: 202.142.142.142`nSecondary: 202.142.142.242`n802.11P: -1`nVLAN Tag: -1`nNAT: Enabled`nFirewall: Enabled`nMTU Size: 1500 `nMSS Size: 1460`nIP Protocol: IPv4/IPv6 `nDHCPv6 (IANA): Enabled`nDHCPv6 (IAPD): Enabled`nIGMP: Enabled`n`nRegards,`nxxx"
)

LinkMap := Map(
    "NBN", "NBN Appointment ID:`n`nNBN Incident ID:",
    "Tracking", "Return Post Tracking Code:"
)

HardwareMap := Map(
    "Local Issue", "Hey xxx,`n`nIt looks like the issue might be with your local hardware. We`'re happy to help you troubleshoot to ensure the NBN infrastructure isn`'t part of the problem. However, if the fault is due to your devices, we can`'t guarantee a fix. This also applies to WiFi issues, as we can`'t confirm the perfect conditions for wireless signals.`n`nRegards,`nxxx",

    "Cabling", "FTTN/FTTB: Hey xxx,`n`nTo connect your FTTN/FTTB service, please follow the cabling guide below:`n`n1. Ensure that the router is connected to power near your active phone port. (If you have more than one it is usually the closest to the front of the house)`n2. Connect the DSL port on your router to the phone port on the wall using a DSL/RJ11 cable. (This is a phone cable)`n3. Configure your router. `n`nIf you need assistance configuring your router please see the router guides on our site.`n`nRegards,`nxxx`n`n------------------------------`n`nHFC: Hey xxx,`n`nTo connect your HFC service, please follow the cabling guide below:`n`nEnsure that the NBN device is connected to power and the coaxial port on the wall. This looks like a TV antenna cable that screws on.`nConnect your router using an ethernet cable from the WAN port to the UNI-D port on the NBN device. Depending on the router model it may also say LAN1/WAN`nConfigure your router. `n`nIf you need assistance configuring your router please see the router guides on our site.`n`nRegards,`nxxx`n`n------------------------------`n`nFTTC: Hey xxx,`n`nTo connect your FTTC service, please follow the cabling guide below:`n`n1. Ensure that the NBN device is connected to power near your active phone port. (If you have more than one it is usually the closest to the front of the house)`n2. Connect the NBN device from the wall socket port to the phone port on the wall using a DSL/RJ11 cable`n3. Connect your router to power near the NBN device.`n4. Connect your router from its WAN port to the Gateway port on the NBN device `n5. Configure your router. `n`nIf you need assistance configuring your router please see the router guides on our site.`n`nRegards,`nxxx`n`n------------------------------`n`nFTTP: Hey xxx,`n`nTo connect your FTTP service, please follow the cabling guide below:`n`n1. Ensure that your NBN device is powered on.`n2. Connect your router to power near the NBN device and power it on.`n3. Connect your router from the WAN port to the UNID-1 port on the NBN device using an ethernet cable.`n4. Configure your router`n`nIf you need assistance configuring your router please see the router guides on our site.`n`nRegards,`nxxx"
)

DeliveryReasons := ["HFC", "FTTC", "Validation", "Banlisting", "Missing Payment Info"]
DeliveryTemplates := [["Day 1","Day 2", "Day 3"],["Day 1","Day 2", "Day 3"],["Day 1","Day 2", "Day 3"],["Day 1"],["Day 1","Day 2", "Day 3"]]
HFCMap := Map(
    "Day 1", "HFC Activation`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing great.`n`nWe wanted to update you on your recent NBN order. It`'s currently delayed because NBNs system can`'t detect the NTD connected. Ensure the coaxial cable is securely connected to the back of the NBN NTD and that the device is powered on.`n`nAdditionally, they have asked us to verify the MAC address and serial number of your HFC NTD. This information can be found on the sticker at the bottom of the device. Please reply to this email with that information or a photo of the sticker, and we`'ll take it from there.`n`nIf you have any questions, you can reach out here or just hop on our live chat, and our friendly team will assist you in no time. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`n------------------------------`n`nThanks for your understanding. We can`'t wait to get you up and running.`n`nHey there. It`'s Buddy Telco. We need to chat about your NBN order. Please reach out to our live chat team so we can get things moving. We`'re here Monday to Friday, from 9:00 AM to 5:00 PM AWST. Thanks.`n`n------------------------------`n`nSMS and Email Sent",

    "Day 2", "HFC Abandonment`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing great.`n`nWe wanted to update you on your recent NBN order. It`'s currently delayed because NBNs system can`'t detect the NBN NTD connected. Ensure the coaxial cable is securely connected to the back of the NBN NTD and that the device is powered on.`n`nAdditionally, NBN has asked us to verify the MAC address and serial number of your HFC NTD. This information can be found on the sticker at the bottom of the device. Please reply to this email with that information or a photo of the sticker, and we`'ll take it from there.`n`nIf you have any questions, you can reach out here or just hop on our live chat, and our friendly team will assist you in no time. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nIf we don`'t hear from you by XX/XX/XXXX, we`'ll have to abandon your order. We don`'t want you to miss out, so please reach out soon.`n`nThanks for your understanding. We can`'t wait to get you up and running.`n`n------------------------------`n`nHey there. It`'s Buddy Telco. We need to chat about your NBN order. Please reach out to our live chat team before XX/XX/XXXX or we will have to abandon your order. We`'re here Monday to Friday, from 9:00 AM to 5:00 PM AWST. Thanks.`n`n------------------------------`n`nAbandonment date set",

    "Day 3", "Order Abandoned`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing well.`n`nSince we haven`'t heard back from you, we`'ve Abandoned your NBN order. But don`'t worry, it`'s super easy to sign back up on our website.`n`nNeed help signing up? Just hop onto our live chat, and our friendly team will be happy to assist you. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nHave a great day.`n`n------------------------------`n`nHey there. It`'s Buddy Telco. Since we haven`'t heard from you, we`'ve abandoned your NBN order. You can sign up again anytime on our website. For help, our friendly live chat team is available Monday-Friday, 9:00 AM to 5:00 PM AWST.`n`n------------------------------`n`nOrder abandoned",
    )

FTTCMap := Map(
    "Day 1", "Order Activation`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing great. `n`nWe wanted to touch base about your recent NBN order. Unfortunately, we can`'t move forward with it until we hear from you.`n`nJust hop on our live chat, and our friendly team will assist you in no time. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nThanks a bunch for your understanding. We can`'t wait to get you up and running. `n`nRegards,`nxxx`n`n------------------------------`n`nHey there. It`'s Buddy Telco. We need to chat about your NBN order. Please reach out to our live chat team so we can get things moving. We`'re here Monday to Friday, from 9:00 AM to 5:00 PM AWST. Thanks`n`n------------------------------`n`nSent SMS and Email. Set abandonment date on next touch",

    "Day 2", "Order Abandonment`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing well.`n`nUnfortunately if we don`'t hear back from you by XX/XX/XX we will have to abandon your order.`n`nPlease reach out to the team via LiveChat between 9AM and 5PM Monday-Friday AWST.`n`nRegards,`nxxx`n`n------------------------------`n`nHey there. It`'s Buddy Telco. Unfortunately if we don`'t hear from you by XX/XX/XXXX we will have to abandon your order. For help, our friendly live chat team is available Monday-Friday, 9:00 AM to 5:00 PM AWST`n`n------------------------------`n`nSet abandonment date for XX/XX/XXXX",

    "HFC Details", "Hey xxx,`n`nIt looks like NBN are requesting confirmation of the MAC ID and Serial Number on your NBN device. Please reach out to us via LiveChat when you can and we can have this updated in our system. This can occur when NBN have replaced the device at the address, or if they are expecting a different device than what is plugged.`n`nRegards,`nxxx",
    )

ValidationMap := Map(
    "Day 1", "Order Validation`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing great.`n`nWe wanted to touch base about your recent NBN order, currently your order has failed the mobile validation stage. Unfortunately, we can`'t move forward with it until we hear from you.`n`nTo move your order forward, simply contact our live chat team to complete the two-factor verification and we`'ll take care of the rest. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nThanks for your understanding. We can`'t wait to get you up and running.`n`nRegards`nxxx`n`n------------------------------`n`nHey there. It`'s Buddy Telco. We need to chat about your NBN order. Please reach out to our live chat team so we can get things moving. We`'re here Monday to Friday, from 9:00 AM to 5:00 PM AWST. Thanks`n`n------------------------------`n`nSent SMS and Email",

    "Day 2", "Order Activation`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing great.`n`nWe wanted to touch base about your recent NBN order, currently your order has failed the mobile validation stage. Unfortunately, we can`'t move forward with it until we hear from you.`n`nTo move your order forward, simply contact our live chat team to complete the two-factor verification and we`'ll take care of the rest. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nIf we don`'t hear from you by XX/XX/XXXX, we`'ll have to cancel your order. We don`'t want you to miss out, so please reach out soon.`n`nThanks a bunch for your understanding. We can`'t wait to get you up and running.`n`nRegards,`nxxx`n`n------------------------------`n`nHey there. It`'s Buddy Telco. As we haven`'t heard from you, we will abandon your order on XX/XX/XXXX. You can sign up again anytime on our website. For help, our friendly live chat team is available Monday-Friday, 9:00 AM to 5:00 PM AWST`n`n------------------------------`n`nSet abandonment date for XX/XX/XXXX",

    "Day 3", "Order Abandonment`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing well.`n`nSince we haven`'t heard back from you, we`'ve abandoned your NBN order. But don`'t worry, it`'s super easy to sign back up on our website.`n`nNeed help signing up? Just hop onto our live chat, and our friendly team will be happy to assist you. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nHave a great day.`n`nRegards,`nxxx`n`n------------------------------`n`nHey there. It`'s Buddy Telco. Since we haven`'t heard from you, we`'ve abandoned your NBN order. You can sign up again anytime on our website. For help, our friendly live chat team is available Monday-Friday, 9:00 AM to 5:00 PM AWST.`n`n------------------------------`n`nOrder abandoned"
)

BanlistingMap := Map(
    "Day 1", "Order Failure`n`n------------------------------`n`nHey ,`n`nWe hope you`'re doing great.`n`nWe wanted to touch base about your recent NBN order, seems like some details are flagging as ban listed. Unfortunately, we can`'t move forward with it until we hear from you.`n`nBut don`'t worry, it`'s super easy to get in touch. Just hop on our live chat, and our friendly team will assist you in no time. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nIf we don`'t hear from you by [insert date], we`'ll have to cancel your order. We don`'t want you to miss out, so please reach out soon.`n`nThanks a bunch for your understanding. We can`'t wait to get you up and running.`n`nRegards`nxxx`n`n------------------------------`n`nHey there. It`'s Buddy Telco. We need to chat about your NBN order. Please reach out to our live chat team so we can get things moving. We`'re here Monday to Friday, from 9:00 AM to 5:00 PM AWST. Thanks`n`n------------------------------`n`nSent SMS and Email for banlisting",
)

PaymentMap := Map(
    "Day 1", "Missing Payment Details`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing great.`n`nWe wanted to touch base about your recent NBN order, currently your account is missing payment details. Unfortunately, we can`'t move forward with the order until we get payment details added to your account.`n`nBut don`'t worry. You can update these details via the Buddy app or web portal, or just hop on our live chat, and our friendly team will assist you in no time. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nThanks a bunch for your understanding. We can`'t wait to get you up and running.`n`nRegards,`nxxx`n`n------------------------------`n`nHey there. It`'s Buddy Telco. We need to chat about your NBN order. Please reach out to our live chat team so we can get things moving. We`'re here Monday to Friday, from 9:00 AM to 5:00 PM AWST. Thanks.`n`n------------------------------`n`nSent SMS and Email",

    "Day 2", "Missing Payment Details`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing great.`n`nWe wanted to touch base about your recent NBN order, currently your account is missing payment details. Unfortunately, we can`'t move forward with the order until we get payment details added to your account.`n`nBut don`'t worry, you can update these details via the Buddy app or web portal, or just hop on our live chat, and our friendly team will assist you in no time. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nIf we don`'t hear from you by XX/XX/XXXX, we`'ll have to cancel your order. We don`'t want you to miss out, so please reach out soon.`n`nThanks a bunch for your understanding. We can`'t wait to get you up and running.`n`nRegards,`nxxx`n`n------------------------------`n`nHey there. It`'s Buddy Telco. We need to chat about your NBN order. Please reach out to our live chat team before XX/XX/XXXX or we will have to abandon your order. We`'re here Monday to Friday, from 9:00 AM to 5:00 PM AWST. Thanks`n`n------------------------------`n`nSent SMS and Email",

    "Day 3", "Order abandonment`n`n------------------------------`n`nHey xxx,`n`nWe hope you`'re doing well.`n`nSince we haven`'t heard back from you, we`'ve abandoned your NBN order. But don`'t worry, it`'s super easy to sign back up on our website.`n`nNeed help signing up? Just hop onto our live chat, and our friendly team will be happy to assist you. We`'re available Monday to Friday, from 9:00 AM to 5:00 PM AWST.`n`nHave a great day.`n`nRegards,`nxxx`n`n------------------------------`n`nHey there. It`'s Buddy Telco. Since we haven`'t heard from you, we`'ve abandoned your NBN order. You can sign up again anytime on our website. For help, our friendly live chat team is available Monday-Friday, 9:00 AM to 5:00 PM AWST.`n`n------------------------------`n`nOrder abandoned",
)

ComplaintReasons := ["NBN", "Raising", "Clarification", "Resolutions", "State Changes", "TIO"]
ComplaintTemplates := [["Templates"],["Templates"],["Templates"],["Templates"],["Changing PRD"],["Templates"]]
NBNMap := Map(
    "Templates", "Dear xxx,`n`nComplaints may be made to the NBN and updates on the progress of complaints can be obtained by contacting the NBN Complaints Team on the following: `n`nThe NBN Co website online form at `'Contact Us`'. `nwww.nbnco.com.au/online_channel/contact_us`nby email to complaints@nbnco.com.au`nby phone to 1800 687 626`nby mail Locked Bag 27, Gold Coast MC, 9726`nby fax to Complaint Team 1800 106 033.`n`n------------------------------`n`nDear ,`n`nAs discussed earlier today in relation to your nbn connection. Please be advised we have raised a NBN formal complaint on your behalf. An NBN Case Manager will contact yourself within the next 5 business days, if you haven`'t been contacted within this time please do not hesitate to let us know.`n`nComplaint reference details are as follows:`nNBN Formal Complaint Reference Number: XXXX`nNBN Complaints Team Contact: 1800 687 626`n`nPlease do not hesitate to contact our Customer Service team directly on 1300 028 339 should you have any further questions.",
    )

RaisingMap := Map(
    "Templates", "Complaints - Template`n`nIssue: [Describe the issue or problem the customer is facing, providing any relevant background information, incidents, or observations that led to their concerns.]`n`nWhat Has Been Done So Far: [Outline any actions you have taken to address the issue thus far, such as troubleshooting, external escalation, explanation of our policies and procedures, or bringing it to the attention of your supervisor. Have we done everything we can internally to resolve the customer`'s concerns, including following correct escalation pathways, if not, why not?]`n`nCustomer`'s Desired Outcome from the Complaint: [Clearly state what resolution or action that the customer has advised would effectively address the issue.]"
    )

ClarificationMap := Map(
    "Templates", "Dear xxx,`n`nThanks for letting us know about this issue.`n`nAs you have not contacted our customer service team on this matter yet, I have interpreted this as a request for technical support and have raised a fault with our customer service team to help you resolve this issue in the Buddy Telco. If you have issues with the way our customer service team handles the fault or with how long they take to progress it, please feel free to reach back out to the complaints team and we will take a look into this for you.`n`nIf you did wish to lodge a formal complaint please respond to this email to advise us and a complaints officer will reach out to you soon.`n`n------------------------------`n`nDear xxx,`n`nThank you for taking the time to get in touch with us regarding this matter. `n`nUnfortunately I have been unable to identify you on any account at Buddy Telco. `nIf you are contacting us regarding an account that you are not authorised on please have the account holder reach out to us through one of the following methods:`n`nPhoning 1300 028 339 - Monday to Friday 9am to 5pm AWST`nEmailing complaints@buddytelco.com.au`nCompleting the online complaint form at the bottom of this page`nPost at PO Box 3351, Gippsland Mail Centre VIC 3841`n`nOnce we are able to validate your complaint against a Buddy Telco  we will be more than happy to investigate your issue."
    )

ResolutionsMap := Map(
    "Templates", "Dear xxx,`n`nThank you for the response.`n`nI have applied this credit and marked this complaint as resolved. You should receive an email confirming this credit within 24 hours.`nIf you have any further questions or concerns, please do not hesitate to contact our customer service team via LiveChat.`n`n------------------------------`n`nDear ,`n`nThank you for the response.`n`nI have submitted this refund to our finance team and marked this complaint as resolved. You should receive this refund within 10 business days. Please feel free to reach out to us for updates on this.`n`nIf you have any further questions or concerns, please do not hesitate to contact our customer service team via LiveChat.`n`n------------------------------`n`nDear xxx,`n`nThank you for the response.`n`nI have applied this discount and marked this complaint as resolved. You should see this reflected on future invoices.`nIf you have any further questions or concerns, please do not hesitate to contact our customer service team via LiveChat",
    )

ChangesMap := Map(
    "Changing PRD", "Dear xxx,`n`nPlease be advised that I am moving the proposed resolution date of your complaint to XXX. This is occurring due to xxx. `n`nIf at any point you are unsatisfied with our handling of your complaint, its progress or outcome, you may opt to seek external dispute resolution via an external dispute resolution provider such as the Telecommunications Industry Ombudsman.`n`nThe Telecommunications Industry Ombudsman can be contacted by:`nPhone: 1800 062 058`nFax: 1800 630 614`nOnline: http://www.tio.com.au/making-a-complaint",
    )

TIOMap := Map(
    "Templates", "Dear xxx,`n`nIf you are unsatisfied with our response to your complaint and you wish to seek external dispute resolution, you may do so via the Telecommunications Industry Ombudsman.`nThe Telecommunications Industry Ombudsman can be contacted by:`n`nPhone: 1800 062 058`nFax: 1800 630 614`nOnline: http://www.tio.com.au/making-a-complaint`n`n------------------------------`n`nDear xxx,`n`nI invite you to respond to this email within 10 working days. If we do not receive a response within 10 working days, the matter will be considered resolved and your complaint will be closed.`n`nIf your Ombudsman case progresses further we will receive notification from the Ombudsman and your complaint will be reopened and addressed accordingly.",
    )

