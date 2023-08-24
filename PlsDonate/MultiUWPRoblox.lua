--[[
YouAMoronMeAFame
YoutubersBaad
SoldierKillerWarrior
FebruaryIsSoBad
GarbageMoronImagine
ImmortalKombat1962
AerialSupports
AntiPostieClan
--]]
local lplr = game:GetService("Players").LocalPlayer
local settings = {
	SoldierKillerWarrior = 1,
	FebruaryIsSoBad = 7,
	GarbageMoronImagine = 16,
	ImmortalKombat1962 = 24,
	AerialSupports = 29,
	AntiPostieClan = 34,
	ProfessionallyPro = 39
}
local found = false
for Username, WaitValue in next, settings do
	if lplr.Name == Username then
		found = true
		task.wait(WaitValue)
	end
end
if game.PlaceId ~= 8737602449 then return nil end
if found == false then return nil end
local robuxRaised = lplr:WaitForChild("leaderstats"):WaitForChild("Raised").Value
local request = request or http_request or http and http.request or fluxus and fluxus.request or syn and syn.request or HttpRequest
local before = lplr:WaitForChild("leaderstats"):WaitForChild("Raised").Value
local Remotes = require(game:GetService("ReplicatedStorage"):FindFirstChild("Remotes"))
local setfpscap = setfpscap or set_fps_cap or changefpscap or change_fps_cap or setrbxfps or function(v)
	local a = tick()
	coroutine.wrap(function()
		while a+1/v > tick() do end
		task.wait()
		a = tick()
	end)()
end
local unclaimed = {}
local function findUnclaimed()
	for i, v in pairs(lplr.PlayerGui:WaitForChild('MapUIContainer'):WaitForChild('MapUI'):WaitForChild('BoothUI'):GetChildren()) do
		if (v.Details.Owner.Text == "unclaimed") then
			table.insert(unclaimed, tonumber(string.match(tostring(v), "%d+")))
		end
	end
end
findUnclaimed()
function encodeJSONAsync(tbl)
	return game:GetService("HttpService"):JSONEncode(tbl)
end
setfpscap(15)
function GET(v)
	return Remotes.Event(v)
end
function say(v)
	return game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest"):FireServer(v, "All")
end
function sendWebhook(context, webhook)
	if context == "donation" then
		request(
			{
				Url = webhook,
				Body = encodeJSONAsync(
					{
						content = "<@990352426253033562>",
						embeds = {
							{
								title = "Pls Donate UWP Autofarm v1",
								description = "A person has donated to "..lplr.DisplayName.."!",
								fields = {
									{
										name = "**Details**",
										value = "Raised before: "..before.."\nTax before: "..tostring(math.floor(before * 0.6)).."\nRaised just now: "..robuxRaised.."\nTax after raised: "..tostring(math.floor(robuxRaised * 0.6))
									}
								}
							}
						}
					}
				),
				Method = "POST",
				Headers = {
					["content-type"] = "application/json"
				}
			}
		)
	elseif context == "connectionestabilished" then
		request(
			{
				Url = webhook,
				Body = encodeJSONAsync(
					{
						content = "<@990352426253033562>",
						embeds = {
							{
								title = "Pls Donate UWP Autofarm v1",
								description = "A alt has been connected with the autofarm!  ("..lplr.DisplayName..")",
							}
						}
					}
				),
				Method = "POST",
				Headers = {
					["content-type"] = "application/json"
				}
			}
		)
	elseif context == "serverhop" then
		request(
			{
				Url = webhook,
				Body = encodeJSONAsync(
					{
						content = "<@990352426253033562>",
						embeds = {
							{
								title = "Pls Donate UWP Autofarm v1",
								description = "A has serverhopped!  ("..lplr.DisplayName..")",
							}
						}
					}
				),
				Method = "POST",
				Headers = {
					["content-type"] = "application/json"
				}
			}
		)
	end
end
local speedMultiplier = robuxRaised + 20
local webhook = "%s"
local updateMessages = {
	"Donate me robux to make my character spin faster!",
	"+ 1 R$ = * 1.2 spinning speed"
}
local timeToHop = 128
function update()
	GET("SetBoothText"):FireServer(updateMessages[math.random(1, #updateMessages)], "booth")
end
local thankyouMessages = {
	"Thanks so much, I appreciate that!",
	"Thank you, I appreciate ur support since im in need of robux!",
	"Tysm!"
}
lplr:WaitForChild("leaderstats"):WaitForChild("Raised").Changed:Connect(function()
	timeToHop = 128
	local old = robuxRaised
	robuxRaised = lplr:WaitForChild("leaderstats"):WaitForChild("Raised").Value
	before = old
	sendWebhook("donation", webhook)
	say(thankyouMessages[math.random(1, #thankyouMessages)])
end)
local beggingMessages = {
	"Donate to me to make me spin faster!",
	"Donate me robux to increase my spinning speed!",
	"Please donate to me, i'm in need of robux!",
	"Please donate to me, i'm working on a new game!",
	"If you donate to me, you will be investing into a new huge project!",
	"1 R$ = 1 new feature added to my game!",
	"If you donate to me, I can give you admin in my game!",
	"Our small dev team is working on a big game right now, any donations will help alot!",
	
}
function applyFunnySpinner()
	local head = lplr.Character.Head
	local spinny = Instance.new("BodyAngularVelocity", head)
	spinny.Parent = head
	spinny.MaxTorque = Vector3.new(0, math.huge, 0)
	spinny.AngularVelocity = Vector3.new(0, 1.1 * robuxRaised, 0)
	if robuxRaised == 0 then
		spinny.AngularVelocity = Vector3.new(0, 1.1, 0)
	end
	local connection;connection = lplr:WaitForChild("leaderstats"):WaitForChild("Raised").Changed:Connect(function()
		task.wait(.24)
		spinny.AngularVelocity = Vector3.new(0, 1.1 * robuxRaised)
	end)
end
local function boothclaim()
	Remotes.Event("ClaimBooth"):InvokeServer(unclaimed[1])
	if not string.find(lplr.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI" .. unclaimed[1])).Details.Owner.Text, lplr.DisplayName) then
		task.wait(1)
		if not string.find(lplr.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI" .. unclaimed[1])).Details.Owner.Text, lplr.DisplayName) then
			error()
		end
	end
end
function walkToBooth()
	local pos = 3
	local _CFrame = CFrame.new(0, 0, pos)
	local boothPos, mainPosX
	local Controls = require(lplr.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
	for i, v in next, game:GetService("Workspace").BoothInteractions:GetChildren() do
		if v:GetAttribute("BoothSlot") == unclaimed[1] then
			mainPosX = v.CFrame
			boothPos = v.CFrame * _CFrame
			break
		end
	end
	Controls:Disable()
	lplr.Character.Humanoid.WalkSpeed = 32
	lplr.Character.Humanoid.Sit = false
	local atBooth = false
	lplr.Character.Humanoid:MoveTo(boothPos.Position)
	lplr.Character.Humanoid.MoveToFinished:Connect(function(reached)
		atBooth = true
	end)
	local atboothtick = 0
	repeat
		task.wait()
		lplr.Character.Humanoid.Sit = false
		atboothtick += 1
		if atboothtick > 1200 then
			break
		end
	until atBooth
	lplr.Character.Humanoid.WalkSpeed = 16
	lplr.Character.Humanoid.RootPart.CFrame = CFrame.new(boothPos.Position)
	Controls:Enable()
	lplr.Character:SetPrimaryPartCFrame(CFrame.new(lplr.Character.HumanoidRootPart.Position, Vector3.new(40, 14, 101)))
end
if game:GetService('CoreGui'):FindFirstChild('RobloxPromptGui') then
	game:GetService('CoreGui').RobloxPromptGui.DescendantAdded:Connect(function(v)
		if v:IsA('TextLabel') and string.find(string.lower(v.Text), "internet") then
			sendWebhook()
			game:GetService("TeleportService"):Teleport(game.PlaceId, lplr)
		end
	end)
end

walkToBooth()
local suc, err = pcall(boothclaim)
if not suc then
	game:GetService("TeleportService"):Teleport(game.PlaceId, lplr)
end
applyFunnySpinner()
coroutine.wrap(function()
	while true do
		update()
		task.wait(60)
	end
end)()
coroutine.wrap(function()
	local secondsToWait = 40
	while true do
		say(beggingMessages[math.random(1, #beggingMessages)])
		task.wait(secondsToWait)
	end
end)()
local qot = queue_on_teleport or queueonteleport or queue_on_tp
sendWebhook("connectionestabilished", webhook)
