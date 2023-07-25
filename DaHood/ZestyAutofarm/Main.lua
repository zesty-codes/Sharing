local autofarm = {
    enabled = true;
    shoeFarmer = true;
    collectMoneyDrops = false;
    farmCounters = true;
    cashAura = false;
    farmPatients = true;
    maxAdditiveMoneyAmount = 150000,
    sendWebhook = false,
    Webhook = ""
}
local afkpart = Instance.new("Part")
afkpart.Anchored = true
afkpart.Parent = workspace
afkpart.CFrame = CFrame.new(100, 492, 100)
afkpart.CanCollide = true
afkpart.Size = Vector3.new(100, 1, 100)
local receivedMoney = 0
function sendWebhook(currentMoney, additiveMoney, moneyGoal, moneyAfterGoalReached, robbedWhat, earnedSoFar)
    spawn(function() task.spawn(function() coroutine.wrap(function() if not autofarm.sendWebhook then return nil end
    if additiveMoney == 0 or additiveMoney == 4 or additiveMoney == 2 then return nil end
    local calculation1 = currentMoney + additiveMoney
    local data = game:GetService("HttpService"):JSONEncode(
        {
            embeds = {
                {
                    title = "**Zestycodes's Da Hood Autofarm Webhook**",
                    description = "Farmed: "..robbedWhat.."\nCurrent money: "..currentMoney.."\nAdditive money: "..additiveMoney.."\nEarned so far: "..earnedSoFar.."\nMoney goal: "..moneyGoal.."\nMoney after goal reached: "..moneyAfterGoalReached,
                    type = "rich",
                    color = tonumber(0x7269da),
                    footer = {
                        text = "Developed by zestycodes"
                    }
                }
            }
        }
    );
    (request or http_request or HttpRequest or http and http.request or fluxus and fluxus.request or getgenv().request)({
        Url = autofarm.Webhook,
        Body = data,
        Method = "POST",
        Headers = {["content-type"] = "application/json"}
    }) end)() end) end)
end
local calculated = 0 + autofarm.maxAdditiveMoneyAmount
NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/lobox920/Notification-Library/Main/Library.lua"))()
if not getgenv().DaHoodAutofarm then
    getgenv().DaHoodAutofarm = autofarm
end
autofarm = getgenv().DaHoodAutofarm
task.spawn(function()
	if connections then
		for a, b in next, connections(game:GetService('Players').LocalPlayer.Idled) do
			b:Disable()
		end
	else
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:Connect(function()
			vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			wait(1)
			vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		end)
	end
end)
NotificationLibrary:SendNotification("Info", "Launching zestycodes's Da Hood autofarm.\nStarting to autofarm when the game loads.", 6)
local ignored = workspace.Ignored
local drops = ignored.Drop
local fireclickdetector = fireclickdetector or fire_clickdetector or fire_click_detector or FireClickDetector
local lplr = game.Players.LocalPlayer
local goal = calculated
for i, v in next, workspace:GetDescendants() do
    if v.ClassName:find("Seat") then
        v:Destroy()
    end
end
calculated = calculated + lplr:WaitForChild("DataFolder"):WaitForChild("Currency").Value
if lplr.Character:FindFirstChild("ForceField") then
    repeat wait() until not lplr.Character:FindFirstChild("ForceField")
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100, 500, 100)
    wait(9)
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100, 500, 100)
end
if not lplr.Character:FindFirstChild("Humanoid") or lplr.Character:FindFirstChild("Humanoid") and lplr.Character:FindFirstChild("Humanoid").Health <= 40 then
    NotificationLibrary:SendNotification("Error", "Failed launching, reinitializing the autofarm...", 6)
    lplr.CharacterAdded:Wait()
    repeat wait() until not lplr.Character:FindFirstChild("ForceField")
    NotificationLibrary:SendNotification("Info", "Initializing zestycodes's Da Hood autofarm.", 6)
end
function rejoin()
    game:GetService("TeleportService"):TeleportToPlaceInstance(2788229376, game.JobId, lplr)
end
wait(5)
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100, 500, 100)
local kickstoreWorker = ignored["Clean the shoes on the floor and come to me for cash"]
local shoeattempts = 0
function goThroughShoes()
    local shoes = {}
    for i, v in next, drops:GetChildren() do
        if v.Name == "MeshPart" and v:FindFirstChild("ClickDetector") then
            table.insert(shoes, v)
        end
    end
    return shoes
end
function goThroughMoneyDrops()
    local moneydrops = {}
    for i, v in next, drops:GetChildren() do
        if v.Name == "MoneyDrop" and v:FindFirstChild("ClickDetector") then
            table.insert(moneydrops, v)
        end
    end
    return moneydrops
end
function gettarget()
    local Character = lplr.Character or lplr.CharacterAdded:wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local maxdistance = math.huge
    local target
    for i, v in pairs(game:GetService("Workspace").Cashiers:GetChildren()) do
        if v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local distance = (HumanoidRootPart.Position - v.Head.Position).magnitude
            if distance < maxdistance then
                target = v
                maxdistance = distance
            end
        end
    end
    return target
end
function collectShoes()
    local shoes = goThroughShoes()
    for i, shoe in next, shoes do
        lplr.Character.HumanoidRootPart.CFrame = shoe.CFrame
        wait(1/920)
        repeat
            task.spawn(function() pcall(function()
                lplr.Character.HumanoidRootPart.CFrame = shoe.CFrame
                fireclickdetector(shoe:FindFirstChildWhichIsA("ClickDetector"))
            end) end)
            game:GetService("RunService").Heartbeat:wait()
        until not shoe or shoe and not shoe:FindFirstChildWhichIsA("ClickDetector")
        wait(.24)
    end
    shoeattempts = shoeattempts + 1
    return true
end
function collectMoneyDrops(dist)
    local MoneyDrops = goThroughMoneyDrops()
    local waitTime = 1
    for i, MoneyDrop in next, MoneyDrops do
        if (lplr.Character.HumanoidRootPart.Position - MoneyDrop.Position).Magnitude >= dist then
            continue
        end
        if (lplr.Character.HumanoidRootPart.Position - MoneyDrop.Position).Magnitude < 18 then
            waitTime = .24
        end
        lplr.Character.HumanoidRootPart.CFrame = MoneyDrop.CFrame
        --game:GetService("TweenService"):Create(lplr.Character.HumanoidRootPart, TweenInfo.new(12, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {CFrame = MoneyDrop.CFrame}):Play()
        repeat
            pcall(function()
                lplr.Character.HumanoidRootPart.CFrame = MoneyDrop.CFrame
                fireclickdetector(MoneyDrop:FindFirstChildWhichIsA("ClickDetector"))
            end)
            wait(waitTime)
        until not MoneyDrop or MoneyDrop and not MoneyDrop:FindFirstChildWhichIsA("ClickDetector")
        wait(autofarm.collectMoneyDrops == false and 1 / 925 or 2.44)
    end
end
function getMoneyFromKickstoreWorker()
    for i = 1, 10 do
        lplr.Character.HumanoidRootPart.CFrame = kickstoreWorker.Head.CFrame
        wait(1/920)
        fireclickdetector(kickstoreWorker:FindFirstChildWhichIsA("ClickDetector"))
        wait(1/920)
    end
end
function farmPatient()
    local patient = ignored["HospitalJob"]:FindFirstChildWhichIsA("Model")
    if patient then
        local R,G,B = ignored["HospitalJob"].Red, ignored["HospitalJob"].Green, ignored["HospitalJob"].Blue
        if patient.Name:lower() == "can i get the red bottle" then
            lplr.Character.HumanoidRootPart.CFrame = R.CFrame
            wait(.24)
            fireclickdetector(R:FindFirstChildWhichIsA("ClickDetector"))
        elseif patient.Name:lower() == "can i get the green bottle" then
            lplr.Character.HumanoidRootPart.CFrame = G.CFrame
            wait(.24)
            fireclickdetector(G:FindFirstChildWhichIsA("ClickDetector"))
        elseif patient.Name:lower() == "can i get the blue bottle" then
            lplr.Character.HumanoidRootPart.CFrame = B.CFrame
            wait(.24)
            fireclickdetector(B:FindFirstChildWhichIsA("ClickDetector"))
        end
        wait(.24)
        lplr.Character.HumanoidRootPart.CFrame = patient.Head.CFrame
        wait(.24)
        fireclickdetector(patient:FindFirstChildWhichIsA("ClickDetector"))
    end
end
local moneyvalue = lplr:WaitForChild("DataFolder"):WaitForChild("Currency")
local shoeattempts = 0
local Text = Drawing.new("Text")
Text.Visible = true
Text.Transparency = 1
Text.Color = Color3.fromRGB(255,255,255)
Text.Text = "Current money: "..moneyvalue.Value.."\nGoal: "..goal.."\nMoney after goal: "..calculated.."\nMoney earned so far: "..receivedMoney
Text.Size = 24
Text.Center = true
Text.Outline = true
Text.OutlineColor = Color3.fromRGB(0,0,0)
Text.Position = Vector2.new(770,420)
Text.Font = Drawing.Fonts.Plex
game:GetService("RunService").Stepped:Connect(function()
    Text.Text = "Current money: "..moneyvalue.Value.."\nGoal: "..goal.."\nMoney after goal: "..calculated.."\nMoney earned so far: "..receivedMoney
end)
function main()
    local counter = gettarget()
    local shoes = 0
    for i, v in next, drops:GetChildren() do
        if v.Name == "MeshPart" and v:FindFirstChildWhichIsA("ClickDetector") then
            shoes = shoes + 1
        end
    end
    if lplr.Character.Humanoid.Health <= 70 then
        if lplr.Character:FindFirstChild("Combat") then
            lplr.Character.Combat:Destroy()
        elseif lplr.Backpack:FindFirstChild("Combat") then
            lplr.Backpack.Combat:Destroy()
        end
        lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
        lplr.CharacterAdded:Wait()
        combat = lplr.Backpack:WaitForChild("Combat", 60)
    end
    if counter and autofarm.farmCounters == true and (counter.Head.CFrame.Position - CFrame.new(-626.998657, 22.6975899, -288.093353, -0.999998987, -8.11054997e-05, -0.00143144943, -8.04997544e-05, 0.999999881, -0.000423222868, 0.00143148366, -0.000423107209, -0.999998868).Position).Magnitude >= 20 then
        NotificationLibrary:SendNotification("Info", "Auto robbing the counter/ATM.", 1)
        local tries = 0
        local combat = lplr.Backpack:FindFirstChild("Combat") or lplr.Character:FindFirstChild("Combat")
        for i, v in pairs(lplr.Character:GetChildren()) do
            if v:IsA("Tool") then
                v.Parent = lplr.Backpack
            end
        end
        for i, v in pairs(lplr.Backpack:GetChildren()) do
            if v:IsA("Tool") and v.Name == "Combat" then
                v.Parent = lplr.Character
            end
        end
        if not combat then
            lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
            lplr.CharacterAdded:Wait()
            combat = lplr.Backpack:WaitForChild("Combat", 20)
            combat.Parent = lplr.Character
            if lplr.Character.Humanoid.Health <= 1 then
                combat:Destroy()
            end
        end
        for i, v in pairs(lplr.Backpack:GetChildren()) do
            if v:IsA("Tool") and v.Name == "Combat" then
                v.Parent = lplr.Character
            end
        end
        if lplr.Character.Humanoid.Health <= 70 then
            combat:Destroy()
            lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
            lplr.CharacterAdded:Wait()
            combat = lplr.Backpack:WaitForChild("Combat", 60)
        end
        combat.Parent = lplr.Character
        repeat game:GetService("RunService").Heartbeat:wait()
		    pcall(function()
                for i, v in pairs(lplr.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name == "Combat" then
                        v.Parent = lplr.Character
                    end
                end
		    	local root = lplr.Character.HumanoidRootPart
		    	lplr.Character.HumanoidRootPart.CFrame = counter.Head.CFrame * CFrame.new(0, -2.5, 3)
                task.spawn(function() coroutine.wrap(function()
                    for i = 1, 63 do
		    	        lplr.Character.HumanoidRootPart.CFrame = counter.Head.CFrame * CFrame.new(0, -2.5, 3)
                        wait(1/1932)
                    end
                end)() end)
                if combat then
		    	    combat.Parent = lplr.Character
		    	    combat:Activate()
                end
		    end)
        until not counter or counter.Humanoid.Health < 2
        local old = moneyvalue.Value
        wait(.24)
        for i, v in pairs(lplr.Character:GetChildren()) do
            if v:IsA("Tool") then
                v.Parent = lplr.Backpack
            end
        end
        if lplr.Character.Humanoid.Health <= 1 then
            combat.Parent = nil
        end
	    task.spawn(function() coroutine.wrap(function() collectMoneyDrops(62) end)() end)
        wait(2)
        coroutine.wrap(function()
        local new = moneyvalue.Value - old
        receivedMoney = receivedMoney + new
        sendWebhook(moneyvalue.Value, new, goal, moneyvalue.Value + goal, "ATM", receivedMoney)
        NotificationLibrary:SendNotification("Success", "Successfuly autorobbed the ATM/counter.", 1) end)()
    end
    if autofarm.shoeFarmer then
        if shoes > 1 then
            NotificationLibrary:SendNotification("Info", "Grabbing shoes.", 1)
            collectShoes()
            for i = 1, 5 do
                lplr.Character.HumanoidRootPart.CFrame = kickstoreWorker.Head.CFrame
                wait(1/920)
                fireclickdetector(kickstoreWorker:FindFirstChildWhichIsA("ClickDetector"))
                wait(1/920)
            end
            local new = 18
            receivedMoney = receivedMoney + new
            sendWebhook(moneyvalue.Value, new, goal, moneyvalue.Value + goal, "Kick store", receivedMoney)
            NotificationLibrary:SendNotification("Success", "Successfuly returned shoes to the kickstore worker.", 1)
        end
    end
    if #goThroughMoneyDrops() >= 0 and autofarm.collectMoneyDrops == true then
        local old = moneyvalue.Value
        NotificationLibrary:SendNotification("Info", "Grabbing money on the floors.", 1)
        collectMoneyDrops(0x932FF226)
        local new = moneyvalue.Value - old
        receivedMoney = receivedMoney + new
        sendWebhook(moneyvalue.Value, new, goal, moneyvalue.Value + goal, "Money drops", receivedMoney)
        NotificationLibrary:SendNotification("Success", "Successfuly grabbed money on the floors.", 1)
    end
    if autofarm.farmPatients and ignored["HospitalJob"]:FindFirstChildWhichIsA("Model") then
        farmPatient()
        receivedMoney = receivedMoney + 35
        sendWebhook(moneyvalue.Value, 35, goal, moneyvalue.Value + goal, "Hospital job", receivedMoney)
        NotificationLibrary:SendNotification("Success", "Successfuly farmed the patient.", 1)
    end
    lplr.Character.HumanoidRootPart.CFrame = CFrame.new(100, 500, 100)
    NotificationLibrary:SendNotification("Info", "Waiting until theres something to do.", 1)
end
local function updateMouse(target)
	if not target then return end
	local Mouse = game.Players.LocalPlayer:GetMouse()
	local posVector3 = workspace.CurrentCamera:WorldToScreenPoint(target)
	local x, y = posVector3.X - Mouse.X, posVector3.Y - Mouse.Y
	if math.abs(x) > 4 then
		x = math.sign(x) * math.max(math.sqrt(math.abs(x)), 4)
	end
	if math.abs(y) > 4 then
		y = math.sign(y) * math.max(math.sqrt(math.abs(y)), 4)
	end
	(mousemoverel or mouse_move_rel or mousemove_rel or mouse_moverel)(x, y)
end
game:GetService("RunService").Stepped:Connect(function()
    if autofarm.enabled and autofarm.cashAura then
        local MoneyDrops = goThroughMoneyDrops()
        for i, MoneyDrop in next, MoneyDrops do
            if (lplr.Character.HumanoidRootPart.Position - MoneyDrop.Position).Magnitude < 15 then
               fireclickdetector(MoneyDrop:FindFirstChildWhichIsA("ClickDetector"))
            end
        end
    end
    if lplr.DataFolder.Currency.Value > calculated then
        rejoin()
    end
end)
NotificationLibrary:SendNotification("Success", "Successfuly launched zestycodes's Da Hood autofarm!", 3)
local keypress, keyrelease = keypress or key_press or press_key or presskey, keyrelease or key_release or releasekey or release_key
while autofarm.enabled do
    if autofarm.maxAdditiveMoneyAmount > moneyvalue.Value then
        Text:Destroy()
        break
    end
	if #goThroughShoes() <= 1 then repeat wait() until #goThroughShoes() >= 0 end
	local success, error = pcall(main)
    if not success then
        NotificationLibrary:SendNotification("Error", "The Da Hood Autofarm errored, and now you will rejoin the server. The autofarm will get automatically executed again.", 6)
        queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/zesty-codes/Sharing/main/DaHood/ZestyAutofarm/Main.lua", true))()]])
        wait(2)
        rejoin()
    end
    wait(.24)
    wait(1)
	mouse2press()
	keypress(0x41)
	keypress(0x44)
	wait(1/352)
	keyrelease(0x41)
	keypress(62)
	keypress(0x41)
	mouse2release()
	keyrelease(0x41)
	keyrelease(62)
	keyrelease(0x44)
end
for i, v in pairs(seats) do
    v.Parent = workspace
end
