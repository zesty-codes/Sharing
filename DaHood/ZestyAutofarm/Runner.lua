local getgenv = (getgenv or get_global_environment or getfenv or function() return _G or _ENV end)
local request = request or HttpRequest or fluxus and fluxus.request or http and http.request or http_request;
getgenv().DaHoodAutofarm = {
    enabled = true;
    shoeFarmer = true;
    collectMoneyDrops = false;
    farmCounters = true;
    cashAura = true;
    farmPatients = true;
    maxAdditiveMoneyAmount = 150000,
    sendWebhook = false,
    Webhook = ""
}
loadstring(
    request(
       {
           Url = "https://raw.githubusercontent.com/zesty-codes/Sharing/main/DaHood/ZestyAutofarm/Main.lua",
           Method = "GET"
       }
    ).Body
)()
