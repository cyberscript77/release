debugPrint(3,"CyberScript: scripting module loaded")
cyberscript.module = cyberscript.module +1

---Main Function---

function mainThread()-- update event when mod is ready and in game (main thread for execution)
	local objective = Game.GetJournalManager():GetTrackedEntry()
	if (AutoAmbush == 1 and objective ~= nil) then --AutoAmbush (disable ambush event when MainQuest or SideQuest is active)
		-- MainQuest = 0,
		-- SideQuest = 1,
		-- MinorQuest = 2,
		-- StreetStory = 3,
		-- Contract = 4,
		-- VehicleQuest = 5
		
		local phase = Game.GetJournalManager():GetParentEntry(objective)
		local quest = Game.GetJournalManager():GetParentEntry(phase)
		
		if(string.match(tostring(quest:GetType()), "MainQuest") or string.match(tostring(quest:GetType()), "SideQuest"))then
			if(AmbushEnabled ~= 0)then
				AmbushEnabled = 0
				updateUserSetting("AmbushEnabled",AmbushEnabled)
			end
			else
			if(AmbushEnabled ~= 1)then
				AmbushEnabled = 1
				updateUserSetting("AmbushEnabled",AmbushEnabled)
			end
		end
	end
	inScanner = GameUI.IsScanner()
	player = Game.GetPlayer()
	currentTime = getGameTime()
	curPos = player:GetWorldPosition()
	next_ambush = next_ambush + 1	
	loadCustomPlace()
	itemMover()
	curRot = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
	
	districtState = lang.Friendly
	getCurrentDistrict2()
	
	
	
	
	if(currentDistricts2 ~= nil)then
		
		setVariable("current_district","tag", currentDistricts2.Tag)
		
		
		if(districtState == nil) then
			districtState = "loading"
			
		end	
		
		local disstate = isHostileDistrict()
		setVariable("current_district","state",disstate)
		
		if(disstate == 0) then 
			
			setVariable("current_district","stateName",getLang("Friendly"))
			districtState = getLang("Friendly")
			
		end
		
		if(disstate == 1) then 
			
			setVariable("current_district","stateName",getLang("Neutral"))
			districtState = getLang("Neutral")
			
		end
		
		if(disstate == 2) then 
			
			setVariable("current_district","stateName",getLang("Hostile"))
			districtState = getLang("Hostile")
			
		end
		
		
		
		
		local districttext = ""
		if(currentDistricts2.districtLabels ~=nil and #currentDistricts2.districtLabels > 0) then
			
			if(currentDistricts2.districtLabels ~=nil and #currentDistricts2.districtLabels > 1) then
				
				setVariable("current_district","subdistrict_enum", currentDistricts2.districtLabels[2])
				else
				setVariable("current_district","subdistrict_enum", "")
			end
			
			for i, test in ipairs(currentDistricts2.districtLabels) do
				if i == 1 then
					if(#currentDistricts2.districtLabels == 1) then
						
						
						districttext = districttext.."  |  "..test.." ("..districtState..")"
						else
						
						districttext = districttext..test
						
					end
					else
					districttext = districttext.."  |  "..test.." ("..districtState..")"
				end
			end
			
			setVariable("current_district","districttext",districttext)
			
			else
			setVariable("current_district","tag", "")
			setVariable("current_district","districttext","")
			setVariable("current_district","subdistrict_enum", "")
			setVariable("current_district","state","")
			setVariable("current_district","stateName","")
			
		end
		
		
		else
		setVariable("current_district","tag", "")
		setVariable("current_district","districttext","")
		setVariable("current_district","subdistrict_enum", "")
		setVariable("current_district","state","")
		setVariable("current_district","stateName","")
		
	end
	
	
	
	setVariable("player_position","x",ftos(curPos.x))
	setVariable("player_position","y",ftos(curPos.y))
	setVariable("player_position","z",ftos(curPos.z))
	
	setVariable("player_rotation","yaw",ftos(curRot.yaw))
	setVariable("player_rotation","pitch",ftos(curRot.pitch))
	setVariable("player_rotation","roll",ftos(curRot.roll))
	
	setScore("player","money",getStackableItemAmount("Items.money"))
	
	
	pcall(function()
	if(GameController["MinimapContainerController"] ~= nil and displayHUD["default_minimap_root"] == nil ) then
		
		
		displayHUD["default_minimap_root"] = GameController["MinimapContainerController"]:GetRootWidget()
		
		displayHUD["default_minimap_container"] = GameController["MinimapContainerController"]:GetRootWidget():GetWidgetByIndex(4)
		
	end
	end)
	pcall(function()
	if(GameController["healthbarWidgetGameController"] ~= nil and displayHUD["default_healthbar"] == nil ) then
		
		displayHUD["default_healthbar"] = GameController["healthbarWidgetGameController"]:GetRootWidget()
		
	end
	end)
	pcall(function()
	if(GameController["StaminabarWidgetGameController"] ~= nil and displayHUD["default_staminabar"] == nil ) then
		
		displayHUD["default_staminabar"] = GameController["StaminabarWidgetGameController"]:GetRootWidget()
		
	end
	end)
	pcall(function()
	if(GameController["HotkeysWidgetController"] ~= nil and displayHUD["default_hotkey"] == nil ) then
		
		
		displayHUD["default_hotkey"] = GameController["HotkeysWidgetController"].root
		displayHUD["default_hotkey_phone"] = GameController["HotkeysWidgetController"].phone
		displayHUD["default_hotkey_car"] = GameController["HotkeysWidgetController"].car
		displayHUD["default_hotkey_consumables"] = GameController["HotkeysWidgetController"].consumables
		displayHUD["default_hotkey_gadgets"] = GameController["HotkeysWidgetController"].gadgets
	end
	end)
	pcall(function()
	if(GameController["BraindanceGameControllerRoot"] ~= nil and displayHUD["main_root_default"] == nil ) then
		
		print("setting HUD")
		spdlog.error(GameDump(GameController["BraindanceGameControllerRoot"]))
		
		local rootContainerHUD = GameController["BraindanceGameControllerRoot"]
		rootContainerHUD:SetVisible(true)
		
		
		local cscontainer = rootContainerHUD:GetWidget(CName("default_cs")) 
		local makenew = false
		local hudprocessing = false
		spdlog.error(GameDump(cscontainer))
		
		
		if(cscontainer == nil) or (cscontainer:GetName() ~= CName("default_cs")) then
			print("No container")
			CName.add("default_cs")
			local cscontainer = nil
			cscontainer = inkCanvas.new()
			cscontainer:SetName(CName("default_cs"))
			cscontainer:SetAnchor(0)
			cscontainer:SetFitToContent(false)
			cscontainer:SetSize(rootContainerHUD:GetWidth(),rootContainerHUD:GetHeight() )
			cscontainer:Reparent(rootContainerHUD, -1)
			makenew = true
			spdlog.error(GameDump(cscontainer))
			spdlog.error(NameToString(cscontainer:GetName()))
			
		end
		
		
		
		displayHUD["main_root_default"] = cscontainer
		
		
		
		if(makenew == true) then
			print("redo HUD")
			hudprocessing = true
			for k,v in pairs(arrayHUD) do
				local hud = v.hud
				if(hud.type == "container") then
					displayHUD[k] = inkCanvas.new()
					displayHUD[k]:SetName(CName.new(hud.tag))
					displayHUD[k]:SetAnchor(inkEAnchor.Fill)
					displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
					debugPrint(10,"create "..hud.tag)
					
				end
			end
			
			
			for k,v in pairs(arrayHUD) do
				local hud = v.hud
				if(hud.type == "container") then
					if(hud.container == nil or hud.container == "default" or  hud.container == "") then
						displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
						else
						displayHUD[k]:Reparent(displayHUD[hud.container], -1)
					end
					
					
				end
			end
			
			for k,v in pairs(arrayHUD) do
				local hud = v.hud
				if(hud.type == "widget") then
					displayHUD[k] = inkText.new()
					displayHUD[k]:SetName(CName.new(hud.tag))
					displayHUD[k]:SetMargin(inkMargin.new({ top = hud.margin.top, left = hud.margin.left}))
					displayHUD[k]:SetFontFamily(hud.fontfamily)
					displayHUD[k]:SetFontStyle(hud.fontstyle)
					displayHUD[k]:SetFontSize(hud.fontsize)
					displayHUD[k]:SetTintColor(gamecolor(hud.color.red,hud.color.green,hud.color.blue,1))
					displayHUD[k]:SetVisible(hud.visible)
					displayHUD[k]:SetHorizontalAlignment(textHorizontalAlignment.Center)
					displayHUD[k]:SetVerticalAlignment(textVerticalAlignment.Center)
					
					if(hud.container == nil or hud.container == "default" or hud.container == "") then
						displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
						else
						displayHUD[k]:Reparent(displayHUD[hud.container], -1)
					end
					debugPrint(10,"create "..hud.tag)
				end
				
			end
			
			print("HUD created")
			else
			if hudprocessing == false then
				print("recreate HUD")
				displayHUD["main_root_default"]:RemoveAllChildren()
				
				
				for k,v in pairs(arrayHUD) do
					local hud = v.hud
					if(hud.type == "container") then
						
						
						displayHUD[k] = inkCanvas.new()
						displayHUD[k]:SetName(CName.new(hud.tag))
						displayHUD[k]:SetAnchor(inkEAnchor.Fill)
						displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
						debugPrint(10,"create "..hud.tag)
						
						
					end
				end
				
				
				for k,v in pairs(arrayHUD) do
					local hud = v.hud
					if(hud.type == "container") then
						if(hud.container == nil or hud.container == "default" or  hud.container == "") then
							displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
							else
							displayHUD[k]:Reparent(displayHUD[hud.container], -1)
						end
						
						
					end
				end
				
				for k,v in pairs(arrayHUD) do
					local hud = v.hud
					if(hud.type == "widget") then
						
						
						displayHUD[k] = inkText.new()
						displayHUD[k]:SetName(CName.new(hud.tag))
						displayHUD[k]:SetMargin(inkMargin.new({ top = hud.margin.top, left = hud.margin.left}))
						displayHUD[k]:SetFontFamily(hud.fontfamily)
						displayHUD[k]:SetFontStyle(hud.fontstyle)
						displayHUD[k]:SetFontSize(hud.fontsize)
						displayHUD[k]:SetTintColor(gamecolor(hud.color.red,hud.color.green,hud.color.blue,1))
						displayHUD[k]:SetVisible(hud.visible)
						displayHUD[k]:SetHorizontalAlignment(textHorizontalAlignment.Center)
						displayHUD[k]:SetVerticalAlignment(textVerticalAlignment.Center)
						
						if(hud.container == nil or hud.container == "default" or hud.container == "") then
							displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
							else
							displayHUD[k]:Reparent(displayHUD[hud.container], -1)
						end
						debugPrint(10,"create "..hud.tag)
					end
					
					
					
					
				end
				
				print("HUD initialised")
			end
		end
	end
	end)
	pcall(function()
	if(GameController["hudCorpoController"] ~= nil and displayHUD["hud_corpo"] == nil ) then
		
		displayHUD["hud_corpo"] = GameController["hudCorpoController"].root
		
		
		
		displayHUD["hud_corpo_market"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0)
		displayHUD["hud_corpo_market_marketFluffIcon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(0)
		displayHUD["hud_corpo_market_marketFluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(1)
		displayHUD["hud_corpo_market_marketConnection"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(2)
		displayHUD["hud_corpo_market_marketHolderIcon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(3)
		displayHUD["hud_corpo_market_marketHolderFluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(4)
		
		displayHUD["hud_corpo_market_marketWindowWrapperA"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5)
		displayHUD["hud_corpo_market_marketWindowWrapperA_container"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0)
		displayHUD["hud_corpo_market_marketWindowWrapperA_marketText"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(0)
		displayHUD["hud_corpo_market_marketWindowWrapperA_marketWindow"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(1)
		displayHUD["hud_corpo_market_marketWindowWrapperA_marketMask"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(2)
		displayHUD["hud_corpo_market_marketWindowWrapperA_FluffTxt_bottom2"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(3)
		displayHUD["hud_corpo_market_marketWindowWrapperA_Flufftxt_Bottom"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(4)
		displayHUD["hud_corpo_market_marketWindowWrapperA_logoArasaka"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(5)
		displayHUD["hud_corpo_market_marketWindowWrapperA_FluffTxt_bottom3"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(6)
		displayHUD["hud_corpo_market_marketWindowWrapperA_03_mt_bottfluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(7)
		
		displayHUD["hud_corpo_market_marketWindowWrapperB"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(6)
		displayHUD["hud_corpo_market_marketWindowWrapperB_markerGraph"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(0)
		displayHUD["hud_corpo_market_marketWindowWrapperB_marketWindow"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(1)
		displayHUD["hud_corpo_market_marketWindowWrapperB_marketMask"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(2)
		
		displayHUD["hud_corpo_assistant"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1)
		displayHUD["hud_corpo_assistant_header"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(0)
		displayHUD["hud_corpo_assistant_text"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(1)
		displayHUD["hud_corpo_assistant_connection"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(2)
		displayHUD["hud_corpo_assistant_holderfluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(3)
		displayHUD["hud_corpo_assistant_holdericon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(4)
		displayHUD["hud_corpo_assistant_holderplate"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(5)
		
		
		
		displayHUD["hud_corpo_stock"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2)
		displayHUD["hud_corpo_stock_stockConnection"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(0)
		displayHUD["hud_corpo_stock_stockFluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(1)
		displayHUD["hud_corpo_stock_stockLogo"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(2)
		displayHUD["hud_corpo_stock_stockHolderIcon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(3)
		displayHUD["hud_corpo_stock_stockHolderFluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(4)
		displayHUD["hud_corpo_stock_stockBorder"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(5)
		displayHUD["hud_corpo_stock_marqueeUnit"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6)
		
		displayHUD["hud_corpo_stock_marqueeUnit_name_pet"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(2)
		displayHUD["hud_corpo_stock_marqueeUnit_name_orb"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(5)
		displayHUD["hud_corpo_stock_marqueeUnit_name_mil"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(8)
		displayHUD["hud_corpo_stock_marqueeUnit_name_ara"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(11)
		
		displayHUD["hud_corpo_stock_marqueeUnit_value_pet"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(0)
		displayHUD["hud_corpo_stock_marqueeUnit_value_orb"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(3)
		displayHUD["hud_corpo_stock_marqueeUnit_value_mil"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(6)
		displayHUD["hud_corpo_stock_marqueeUnit_value_ara"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(9)
		
		displayHUD["hud_corpo_stock_marqueeUnit_arrow_pet"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(1)
		displayHUD["hud_corpo_stock_marqueeUnit_arrow_orb"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(4)
		displayHUD["hud_corpo_stock_marqueeUnit_arrow_mil"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(7)
		displayHUD["hud_corpo_stock_marqueeUnit_arrow_ara"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(10)
		
		displayHUD["hud_corpo_logo"] = GameController["hudCorpoController"].root:GetWidgetByIndex(3)
		
		displayHUD["hud_corpo_news"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5)
		displayHUD["hud_corpo_news_stockHolderIcon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(0)
		displayHUD["hud_corpo_news_hudFluffRight"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(1)
		displayHUD["hud_corpo_news_title"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(2)
		displayHUD["hud_corpo_news_inkFlexWidget9"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(3)
		displayHUD["hud_corpo_news_content"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(3):GetWidgetByIndex(0)
		displayHUD["hud_corpo_news_inkBorderWidget14"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(4)
		
	end
	end)
	
	-- local panzer = VehiclePanzerBootupUIQuestEvent.new()
	-- panzer.mode  = 3
	
	-- Game.GetUISystem():QueueEvent(panzer)
	pcall(function()
	if(GameController["PanzerHUDGameController"] ~= nil) then
		
		
		
		
	end
	end)
	
	--Targeted entity
	objLook = Game.GetTargetingSystem():GetLookAtObject(Game.GetPlayer(),false,false)
	
	if(objLook ~= nil) then
	

	
	
		if(objLook ~= nil) then
			tarName = objLook:ToString()
			--	debugPrint(10,tostring(objLook:GetHighLevelStateFromBlackboard()))
			if(string.match(tarName, "NPCPuppet"))then
				-- objLook:MarkAsQuest(true)
				-- debugPrint(10,GameDump(objLook:GetCurrentOutline()))
				appName = Game.NameToString(objLook:GetCurrentAppearanceName())
				targName = tostring(objLook:GetTweakDBDisplayName(true))
				openCompanion, gangscore, lookatgang = checkAttitudeByGangScore(objLook)
				
				
				
				
				local obj = getEntityFromManagerById(objLook:GetEntityID())
				
				if(obj.id ~= nil) then
					cyberscript.EntityManager["lookatentity"].tag = obj.tag
					
					if obj.isquest == nil then obj.isquest = false end
					
					objLook:MarkAsQuest(obj.isquest)
					
					else
					
					
					cyberscript.EntityManager["lookatentity"].tag = nil
					
					if cyberscript.EntityManager["lookatnpc"].isquest == nil then cyberscript.EntityManager["lookatnpc"].isquest = false end
					
					objLook:MarkAsQuest(cyberscript.EntityManager["lookatnpc"].isquest)
					cyberscript.EntityManager["lookatnpc"].tweak = obj.tweak
					
				end
				
				cyberscript.EntityManager["lookatnpc"].id = nil
				
				cyberscript.EntityManager["lookatnpc"].id = objLook:GetEntityID()
				
				
				
				-- end
			end
			objLookIsVehicule = objLook:IsVehicle()
			local obj = getEntityFromManagerById(objLook:GetEntityID())
			
			else
			
			openCompanion = false
			objLookIsVehicule = false
		end
		else
		
		
		cyberscript.EntityManager["lookatnpc"].id = nil
		cyberscript.EntityManager["lookatnpc"].tweak = "None"
		currentScannerItem = nil
		cyberscript.EntityManager["lookatentity"].tag = nil
		
		openCompanion = false
		objLookIsVehicule = false
	end
	
	
	--house
	if(currentHouse ~= nil) then
		interactautohide = false
		setVariable("current_place","tag",currentHouse.tag)
		setVariable("current_place","name",currentHouse.name)
		if(currentRoom ~= nil) then
			
			setVariable("current_place","room_tag",currentRoom.tag)
			setVariable("current_place","room_name",currentRoom.name)
			else
			setVariable("current_place","room_tag","")
			setVariable("current_place","room_name","")
			
		end
		else
		setVariable("current_place","tag","")
		setVariable("current_place","name","")
		setVariable("current_place","room_tag","")
		setVariable("current_place","room_name","")
	end
	
	
	--Quest
	if(currentSave.arrayPlayerData.CurrentQuest ~= nil) then
		haveMission = true
		canTakeContract = false
	end
	checkNPC()
	--Vehicle
	local inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
	if (inVehicule) then
		
		local vehicule = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
		if(vehicule ~= nil) then
			local obj = getEntityFromManagerById(vehicule:GetEntityID())
			inVehiculeTweak = ""
			for i=1,#arrayVehicles do
				if(tostring(TweakDBID.new(arrayVehicles[i])) == tostring(vehicule:GetRecordID())) then
					inVehiculeTweak = arrayVehicles[i]
				end
			end
			
			local isThiscar = (obj.id ~= nil and obj.isAV == true)
			
			
			
			
			if isThiscar then
				AVisIn = true
				
				
				CurrentAVEntity =  vehicule
				local fppComp = Game.GetPlayer():GetFPPCameraComponent()
				
				local bool = false
				bool = IsPlaying("env")
				if(bool == false) then
					local sound = getSoundByNameNamespace("av_engine.mp3","av")
					if(sound ~= nil) then
						local path = cyberscript.soundpath..sound.path
						PlaySound(sound.name,path,"env",100)
					end
				end
				
				else
				if(obj.id == nil) then
					cyberscript.EntityManager["current_car"].id = nil
					
					cyberscript.EntityManager["current_car"].id = vehicule:GetEntityID()
				end
			end
		end
		else
		inVehiculeTweak = ""
		
		
		cyberscript.EntityManager["current_car"].id = nil
		
	end
	
	--AV
	if(AVinput.exit ~= nil and AVinput.exit == true) then
		if AVisIn == true and inVehicule == true then
			local fppComp = Game.GetPlayer():GetFPPCameraComponent()
			fppComp:SetLocalPosition(Vector4:new(0.0, 0.0, 0.0, 1.0))
			Stop("env")
			if(AVseat ~= nil) then
				UnsetSeat("player",false, AVseat)
				AVseat = nil
				Cron.After(1, function()
					
					debugPrint(10,#cyberscript.GroupManager["AV"].entities)
					for i=1, #cyberscript.GroupManager["AV"].entities do 
						local entityTag = cyberscript.GroupManager["AV"].entities[i]
						debugPrint(10,entityTag)
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							despawnEntity(entityTag)
						end
					end
					cyberscript.GroupManager["AV"].entities = {}	
					CurrentAVEntity = nil
					AVisIn = false
					AVinput.exit = false							
				end)
				else
				CurrentAVEntity = nil
				AVisIn = false
				AVinput.exit = false		
			end
		end
	end
	if (AVinput.isMoving == true and AVisIn and AVinput.keyPressed == true ) then
		
		fly(AVinput.currentDirections, 0)
		elseif (AVinput.isMoving == true and AVinput.keyPressed == false and AVisIn) then
		if AVspeed > 0.3 then
			AVspeed = AVspeed - 0.05
			if AVinput.lastInput ~= "" then
				debugPrint(1,AVinput.lastInput)
				if AVinput.lastInput == "forward" then
					AVinput.currentDirections.forward = true
					fly(AVinput.currentDirections, 0)
				end
				if AVinput.lastInput == "backwards" then
					AVinput.currentDirections.backwards = true
					fly(AVinput.currentDirections, 0)
				end
				else
				AVinput.isMoving = false
				AVinput.keyPressed = false
				AVinput.currentDirections.backwards = false
				AVinput.currentDirections.forward = false
				AVinput.lastInput = ""
			end
			else
			AVinput.isMoving = false
			AVinput.keyPressed = false
			AVinput.currentDirections.backwards = false
			AVinput.currentDirections.forward = false
			AVinput.lastInput = ""
			local group =getGroupfromManager("AV")
			for i=1, #group.entities do 
				local entityTag = group.entities[i]
				local isplayer = false
				if entityTag == "player" then
					isplayer = true
				end
				local obj = getEntityFromManager(entityTag)
				local enti = Game.FindEntityByID(obj.id)
				if(enti ~= nil) then
					
					local newAngle = {}
					newAngle.yaw = AVyaw
					newAngle.roll = AVroll
					newAngle.pitch = AVPitch
					teleportTo(enti, enti:GetWorldPosition(), newAngle, false)
				end
			end
		end
		elseif(AVisIn) then
		AVinput.isMoving = false
		AVinput.currentDirections.backwards = false
		AVinput.currentDirections.forward = false
		AVinput.lastInput = ""
		local group =getGroupfromManager("AV")
		for i=1, #group.entities do 
			local entityTag = group.entities[i]
			local isplayer = false
			if entityTag == "player" then
				isplayer = true
			end
			local obj = getEntityFromManager(entityTag)
			local enti = Game.FindEntityByID(obj.id)
			if(enti ~= nil) then
				
				local newAngle = {}
				newAngle.yaw = AVyaw
				newAngle.roll = AVroll
				newAngle.pitch = AVPitch
				teleportTo(enti, enti:GetWorldPosition(), newAngle, false)
			end
		end
		
		local speede = math.floor(AVspeed*10)
		setScore("av","speed",speede)
	end
	
	--Pause Menu and Ambush timer
	if(inMenu) then
		if(GameController["SubtitlesGameController"] ~= nil) then
			GameController["SubtitlesGameController"]:Cleanup()
		end
		
		
		if(ActiveMenu == "PauseMenu" ) then
			if(ExecPauseMenu == false and getUserSetting("AutoRefreshDatapack") == true) then
				ExecPauseMenu =  true
				
				loadModule()
				CheckandUpdateDatapack()
				LoadDataPackCache()
				
				
			end
			else
			if(ExecPauseMenu == true) then
				ExecPauseMenu =  false
			end
		end
		else
		if(ExecPauseMenu == true) then
			ExecPauseMenu =  false
		end
		
		
		for k,v in pairs(arrayBoundedEntity) do
			
			
			
			local obj = getEntityFromManager(k)
			local enti = Game.FindEntityByID(obj.id)
			if(enti ~= nil) then
				
				local anchorobj = getEntityFromManager(v.anchor)
				local anchorenti = Game.FindEntityByID(anchorobj.id)
				if(anchorenti ~= nil) then
					
					local position = anchorenti:GetWorldPosition()
					
					local qat = anchorenti:GetWorldOrientation()
					local rotation = GetSingleton('Quaternion'):ToEulerAngles(qat)
					
					if(v.copyrotation == false) then
						
						qat = enti:GetWorldOrientation()
						rotation = GetSingleton('Quaternion'):ToEulerAngles(qat)
						
					end
					
					
					
					
					
					local isplayer = false
					if k == "player" then
						isplayer = true
					end
					
					position.x = position.x + v.x
					position.y = position.y + v.y
					position.z = position.z + v.z
					
					rotation.yaw = rotation.yaw + v.yaw
					rotation.pitch = rotation.pitch + v.pitch
					rotation.roll = rotation.roll + v.roll
					
					if(
						(
							arrayBoundedEntity[k].lastposition.x ~= position.x or
							arrayBoundedEntity[k].lastposition.y ~= position.y or 
							arrayBoundedEntity[k].lastposition.z  ~= position.z
						) 
						or
						(
							v.copyrotation == true and (
								
								arrayBoundedEntity[k].lastorientation.yaw ~= rotation.yaw or
								arrayBoundedEntity[k].lastorientation.pitch ~= rotation.pitch or 
								arrayBoundedEntity[k].lastorientation.roll  ~= rotation.roll
							)
						)
						
						
					) then
					
					
					arrayBoundedEntity[k].lastposition.x = position.x
					arrayBoundedEntity[k].lastposition.y = position.y
					arrayBoundedEntity[k].lastposition.z = position.z
					
					
					
					arrayBoundedEntity[k].lastorientation.yaw = rotation.yaw
					arrayBoundedEntity[k].lastorientation.pitch = rotation.pitch
					arrayBoundedEntity[k].lastorientation.roll = rotation.roll
					
					
					
					if(v.isitem == true) then
						local item = {}
						
						enti:GetEntity():Destroy()
						
						local transform = Game.GetPlayer():GetWorldTransform()
						transform:SetPosition(position)
						transform:SetOrientationEuler(rotation)
						cyberscript.EntityManager[k].id = exEntitySpawner.Spawn(obj.tweak, transform)
						
						else
						
						teleportTo(objlook, position, rotation, isplayer)
					end
					
					
					
					end
					
					
				end
				
				else
				
				--arrayBoundedEntity[k] = nil
				
			end
			
			
		end
		
		
		
		local ambusec = AmbushMin*60*60
		
		if (tick % ambusec == 0) then --every X second
			checkAmbush()
			
		end
	end
	
	--Record Location
	
	
	--Dialog check
	if(currentDialogHub ~= nil) then
		
		local blackboardDefs = Game.GetAllBlackboardDefs()
		local interactionBB = Game.GetBlackboardSystem():Get(blackboardDefs.UIInteractions)
		interactionBB:SetVariant(blackboardDefs.UIInteractions.DialogChoiceHubs, ToVariant(currentDialogHub.hub), true)
		isdialogactivehub = true
		
	end
	
	--Timer
	if(currentTimer ~= nil) then
		
		ticktimer = ticktimer +1
		local texttimer = currentTimer.message.." : "..tostring(math.ceil((ticktimer/60))).." seconds"
		
		if(currentTimer.type == "remaning") then
			
			
			texttimer =  currentTimer.message.." : "..tostring(currentTimer.value - math.ceil((ticktimer/60))).." seconds"
			
			
			
		end
		
		setVariable("current_timer","text",texttimer)
		
		else
		setVariable("current_timer","text","")
	end
	
	--Star Manager
	if cancheckmission then
		--StarEventManager()
	end
	
	--Freeze camera action
	-- if freezeCamera then
	
	-- Game.GetPlayer():GetFPPCameraComponent().pitchMin = pitch - 0.01 -- Use pitchMin/Max to set pitch, needs to have a small difference between Min and Max
	-- Game.GetPlayer():GetFPPCameraComponent().pitchMax = pitch
	-- Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), Game.GetPlayer():GetWorldPosition() , EulerAngles.new(0,0,yaw)) -- Set yaw when teleporting
	-- end
	
	--Timers 
	if (tick % 5 == 0) then --every 0.5 second
		
		
		
		refreshUIWidget()
		
		if curPos ~= nil and displayHUD["main_root_default"] ~= nil and displayHUD["posWidget"] ~= nil then
			if(enableLocation == true) then
				
				
				
				
				
				
				for k,v in pairs(arrayHUD) do
					if(v.hud.requirement == nil or checkTriggerRequirement(v.hud.requirement,v.hud.trigger))then
						if(v.hud.type == "widget" or v.hud.type == "container")then
							checkContext(v.hud)
							
						end
						if(v.hud.type == "widget" and displayHUD[k] ~= nil) then
							displayHUD[k]:SetText(v.hud.text)
							displayHUD[k]:SetFontFamily(v.hud.fontfamily)
							displayHUD[k]:SetFontStyle(v.hud.fontstyle)
							displayHUD[k]:SetFontSize(v.hud.fontsize)
							displayHUD[k]:SetTintColor(gamecolor(v.hud.color.red,v.hud.color.green,v.hud.color.blue,1))
							displayHUD[k]:SetMargin(inkMargin.new({ top = v.hud.margin.top, left = v.hud.margin.left}))
							displayHUD[k]:SetVisible(v.hud.visible)
							
						end
						
						if(v.hud.type == "container" and displayHUD[k] ~= nil) then
							
							displayHUD[k]:SetMargin(inkMargin.new({ top = v.hud.margin.top, left = v.hud.margin.left}))
							displayHUD[k]:SetVisible(v.hud.visible)
							
							
						end
					end
					
				end
				
				
				for k,v in pairs(arrayHUD) do
					if(v.hud.type == "theme" )then
						
						if(v.hud.theme ~= nil) then
							for i,thme in ipairs(v.hud.theme) do
								
								if( displayHUD[thme.target] ~= nil) then
									
									
									if(thme.requirement == nil or checkTriggerRequirement(thme.requirement,thme.trigger))then
										checkContext(thme)
										
										
										
										
										if(thme.fontfamily ~= nil) then displayHUD[thme.target]:SetFontFamily(thme.fontfamily) end
										if(thme.fontstyle ~= nil) then displayHUD[thme.target]:SetFontStyle(thme.fontstyle) end
										if(thme.fontsize ~= nil) then displayHUD[thme.target]:SetFontSize(thme.fontsize) end
										if(thme.color ~= nil) then displayHUD[thme.target]:SetTintColor(gamecolor(thme.color.red,thme.color.green,thme.color.blue,1)) end
										if(thme.margin ~= nil) then displayHUD[thme.target]:SetMargin(inkMargin.new({ top = thme.margin.top, left = thme.margin.left})) end
										if(thme.text ~= nil) then displayHUD[thme.target]:SetText(thme.text) end
										if(thme.visible ~= nil) then displayHUD[thme.target]:SetVisible(thme.visible) end
										if(thme.anchor ~= nil) then displayHUD[thme.target]:SetAnchor(thme.anchor) end
										if(thme.parent ~= nil) then displayHUD[thme.target]:Reparent(displayHUD[thme.parent]) end
										if(thme.scrollspeed ~= nil) then displayHUD[thme.target]:SetScrollTextSpeed(thme.scrollspeed) end
									end
								end
								
							end
							
							else
							if( displayHUD[v.hud.target] ~= nil) then
								if(v.hud.requirement == nil or checkTriggerRequirement(v.hud.requirement,v.hud.trigger))then
									checkContext(v.hud)
									
									if(v.hud.fontfamily ~= nil) then displayHUD[v.hud.target]:SetFontFamily(v.hud.fontfamily) end
									if(v.hud.fontstyle ~= nil) then displayHUD[v.hud.target]:SetFontStyle(v.hud.fontstyle) end
									if(v.hud.fontsize ~= nil) then displayHUD[v.hud.target]:SetFontSize(v.hud.fontsize) end
									if(v.hud.color ~= nil) then displayHUD[v.hud.target]:SetTintColor(gamecolor(v.hud.color.red,v.hud.color.green,v.hud.color.blue,1)) end
									if(v.hud.margin ~= nil) then displayHUD[v.hud.target]:SetMargin(inkMargin.new({ top = v.hud.margin.top, left = v.hud.margin.left})) end
									if(v.hud.text ~= nil) then displayHUD[v.hud.target]:SetText(v.hud.text) end
									if(v.hud.visible ~= nil) then displayHUD[v.hud.target]:SetVisible(v.hud.visible) end
									if(v.hud.anchor ~= nil) then displayHUD[v.hud.target]:SetAnchor(v.hud.anchor) end
									if(v.hud.parent ~= nil) then displayHUD[v.hud.target]:Reparent(v.hud.parent) end
									if(v.hud.scrollspeed ~= nil) then displayHUD[v.hud.target]:SetScrollTextSpeed(v.hud.scrollspeed) end
								end
							end
						end
						
						
						
					end
				end
				
				
				if(currentDistricts2 ~= nil)then
					
					
					
					
					
					
					if(showFactionAffinityHud == true) then
						
						displayHUD["factionwidget"]:RemoveAllChildren()
						
						
						if(#currentDistricts2.districtLabels > 0) then
							local gangslist = {}
							if(#currentDistricts2.districtLabels > 1) then
								local gangs = getGangfromDistrict(currentDistricts2.districtLabels[2],20)
								for i=1,#gangs do
									if(getScoreKey("Affinity",gangs[i].tag) ~= nil) then
										table.insert(gangslist,gangs[i])
									end
								end
								else
								local gangs = getGangfromDistrict(currentDistricts2.districtLabels[1],20)
								for i=1,#gangs do
									if(getScoreKey("Affinity",gangs[i].tag) ~= nil) then
										table.insert(gangslist,gangs[i])
										
									end
								end
								
							end
							
							for i,v in ipairs(gangslist) do
								
								
								local gang = getFactionByTag(v.tag)
								local top = (i*50)
								locationWidgetPlace_top = locationWidgetFactionDisctrict_top + (i*50) + 50
								
								local isleader = (i==1)
								
								displayGangScoreWidget(getScoreKey("Affinity",v.tag),gang.Name,displayHUD["factionwidget"],top,isleader)
								
								
							end
							
							
							
							
							
						end
						
						
					end
					
					
					
				end
				
				
				if displayHUD["main_root_default"] ~= nil then
					
					displayHUD["main_root_default"]:SetVisible(true)
					
					
					
					
					
					
					
				end
				
				else
				if displayHUD["main_root_default"] ~= nil then
					
					displayHUD["main_root_default"]:SetVisible(false)
				end
			end
			
		end	
		
		
	end
	if (tick % 100 == 0) then --every 1 second
		-- if(lastTargetKilled ~= nil)then
			-- cyberscript.EntityManager["last_killed"].id = nil
			-- cyberscript.EntityManager["last_killed"].tweak = "none"
			-- lastTargetKilled = nil
		-- end
	end
	
	if (tick % 60 == 0) then --every 1 second
		getTriggeredActions()
		doTriggeredEvent()	
		
		
		for k,v in pairs(cyberscript.EntityManager) do
			if v.lock == false then	
				enti = Game.FindEntityByID(v.id)
				if(enti ~= nil and enti:isAttached() == false) then
				
					despawnEntity(v.tag)
				end
			
			
			end
		
		
		end
		
		if activeMetroDisplay == true then
			MetroCurrentTime = MetroCurrentTime - 1
			debugPrint(10,MetroCurrentTime)
			if MetroCurrentTime <= 0 then
				activeMetroDisplay = false
			end
		end
		
		checkFixer()
		
	end
	if (tick % 120 == 0) then --every 2 second
		playRadio()
	end
	if (tick % 180 == 0) then --every 3 second
		TweakDB:SetFlat("PreventionSystem.setup.totalEntitiesLimit", 999999)
		getOsTimeHHmm()
		
		
		
		if(npcStarSpawn) then
			if(timerDespawn ~= nil) then
				local currentime = getGameTime()
				if(currentime.day > timerDespawn.day or currentime.hour > timerDespawn.hour) then
					despawnEntity("current_star")
					timerDespawn = nil
					npcStarSpawn = nil
				end
			end
		end
	end
	if (tick % 3600 == 0) then --every 3 second
		-- if(GameController["BraindanceGameController"] == nil or GameController["TutorialPopupGameController"]== nil or GameController["IncomingCallGameController"]==nil or GameController["ChattersGameController"]==nil or GameController["SubtitlesGameController"] == nil or GameController["MessengerDialogViewController"]==nil or LinkController==nil) then
		-- Game.GetPlayer():SetWarningMessage(getLang("missingcontroller"))
		-- if(GameController["BraindanceGameController"] == nil)then
		-- debugPrint(1,"CyberScript : BraindanceGameController is missing !")
		-- end
		-- if(GameController["TutorialPopupGameController"] == nil)then
		-- debugPrint(1,"CyberScript : TutorialPopupGameController is missing !")
		-- end
		-- if(GameController["IncomingCallGameController"] == nil)then
		-- debugPrint(1,"CyberScript : IncomingCallGameController is missing !")
		-- end
		-- if(GameController["ShardNotificationController"] == nil)then
		-- debugPrint(1,"CyberScript : ShardNotificationController is missing !")
		-- end
		-- if(GameController["ChattersGameController"] == nil)then
		-- debugPrint(1,"CyberScript : ChattersGameController is missing !")
		-- end
		
		-- if(GameController["MessengerDialogViewController"] == nil)then
		-- debugPrint(1,"CyberScript : MessengerDialogViewController is missing !")
		-- end
		-- if(LinkController == nil)then
		-- debugPrint(1,"CyberScript : LinkController is missing !")
		-- end
		
		-- end
	end
	if(tick % 18000 == 0) then
		SalaryIsPossible = true
	end
	
	
end
function refresh(delta) -- update event (include thread refresh action and QuestThreadManager)
	isGameLoaded = Game.GetPlayer() and Game.GetPlayer():IsAttached() and not GetSingleton('inkMenuScenario'):GetSystemRequestsHandler():IsPreGame()
	if(ModIsLoaded) then
		if isGameLoaded  then
			if Game.GetPlayer() and initFinished and (GameUI.IsLoading() == false) then
				tick = tick +1
				local firstLaunch = tick
				Cron.Update(delta)
				if(tick > 60)then
					if(tick >= 61 and tick <= 62 and draw == false)then
						
						inGameInit()
						
					end
					
					if(file_exists("success.txt"))then
						updatefinished = true
						updateinprogress = false
						
						os.remove("success.txt")
					end
					
					
					if(autoScript == true) then
						CompileCachedThread()
						ScriptExecutionEngine()
						QuestThreadManager()
					end
					
					mainThread()
					
					else
					draw = false
				end
				else
				if Game.GetPlayer() and initFinished == false then
					
					if(nativeSettings ~= nil) then
						nativesettingEnabled = true
					end
					eventCatcher = sampleStyleManagerGameController.new()
					
					
					initFinished = true
					draw = true
				end	
			end
		end
	end
end




--Script Execution Engine
function CompileCachedThread()
	workerTableKey = {}
	if(workerTable ~= nil)then
		
		for k in pairs(workerTable) do
			table.insert(workerTableKey, k)
		end
		
	end
	
end

function ScriptExecutionEngine()
	
	
	if(workerTable ~= nil )then
		
		
		
		for i,v in ipairs(workerTableKey) do 
			local k = workerTableKey[i]
			if(workerTable[k] ~= nil) then
				
				if(GameUI.IsMenu() == false or (workerTable[k]["bypassMenu"] ~= nil and workerTable[k]["bypassMenu"] == true)) then
					local index = workerTable[k]["index"]
					local list = workerTable[k]["action"]
					local parent = workerTable[k]["parent"]
					local pending = workerTable[k]["pending"]
					
					-- debugPrint(4,k)
					-- debugPrint(4,list)
					-- debugPrint(4,index)
					
					if(workerTable[k]["index"] > #workerTable[k]["action"] and workerTable[k]["pending"] == false and workerTable[k]["started"] == true) then
						
						if workerTable[k]["parent"] ~= nil and workerTable[k]["parent"] ~= ""then
							
							if(workerTable[workerTable[k]["parent"]] ~= nil) then
								workerTable[workerTable[k]["parent"]]["pending"] = false
								
								workerTable[workerTable[k]["parent"]]["index"] = workerTable[workerTable[k]["parent"]]["index"] + 1
							end
						end
						
						if workerTable[k]["children"] == "" then
							
							--
							
							if(workerTable[k].quest == nil)then
								workerTable[k] = nil
								workerTableKey[i] = nil
								else
								workerTable[k].disabled = true
							end
							
							else
							
							if workerTable[workerTable[k]["children"]] == nil then
								
								--workerTable[k] = nil
								--workerTableKey[i] = nil
								--		workerTable[k].disabled = true
								if(workerTable[k].quest == nil or workerTable[k].quest == false)then
									workerTable[k] = nil
									workerTableKey[i] = nil
									else
									workerTable[k].disabled = true
								end
							end
							
						end
						
						
					end
					
					if(workerTable[k] ~= nil) then
						
						if(index <= #list and workerTable[k].disabled == false) then
							workerTable[k]["started"] = true
							if(pending == false) then
								
								if(workerTable[k]["index"] ~= nil) then
									
									if(list[index].name == "goto") then
										
										if(list[index].parent == true) then
											debugPrint(4,"Go to"..list[index].index.." of "..parent)
											
											workerTable[parent]["index"] = list[index].index-1
											workerTable[k]["index"] = workerTable[k]["index"]+1
											workerTable[parent]["pending"] =  false
											k = parent
											else
											debugPrint(4,"Go to"..list[index].index.." of "..k)
											
											
											workerTable[k]["index"] = list[index].index 
										end
										
										else
										local isfinish = false
										
										
										local action = list[index]
										local status, retval = pcall(executeAction,action,k,parent,workerTable[k]["index"],workerTable[k]["source"],workerTable[k]["executortag"])
										
										
										
										if status == false then
											
											
											debugPrint(1,getLang("scripting_error") .. retval.." Action : "..tostring(JSON:encode_pretty((list[index]))).." tag "..k.." parent "..parent.." index "..workerTable[k]["index"])
											spdlog.error(getLang("scripting_error") .. retval.." Action : "..tostring(JSON:encode_pretty((list[index]))).." tag "..k.." parent "..parent.." index "..workerTable[k]["index"])
											--Game.GetPlayer():SetWarningMessage("CyberScript Scripting error, check the log for more detail")
											workerTable[k] =  nil
											else
											isfinish = retval
											
										end
										
										
										
										
										
										if(workerTable[k] ~= nil) then
											if(isfinish == true) then
												
												
												workerTable[k]["index"] = workerTable[k]["index"]+1
												
												--debugPrint(4,"action finished")
												workerTable[k]["pending"] = false
												
												else
												
												workerTable[k]["pending"] = true
												
												
												
												
											end
											
											
										end
										
									end
									
									else
									
									--	workerTable[k] =  nil
									--workerTable[k].disabled = true
									--	workerTableKey[i] = nil
									if(workerTable[k].quest == nil)then
										workerTable[k] = nil
										workerTableKey[i] = nil
										else
										workerTable[k].disabled = true
									end
								end
								else
								
								
								local actionisgood = checkWaitingAction(list[index],k,parent,index)
								
								workerTable[k]["pending"] = (actionisgood ~= pending)
								
								if(workerTable[k]["pending"] == false) then
									
									workerTable[k]["index"] = workerTable[k]["index"]+1
								end
								
								
								
								
							end
							
							
						end
					end
					
				end
			end
			
		end
		
		
		
		
	end
	
end

function checkWaitingAction(action,tag,parent,index)
	
	
	
	result = false
	
	
	if(action.name == "wait") then
		
		local temp = getGameTime()
		
		if(temp.hour > action.hour or (temp.hour == action.hour and temp.min > action.min)) then
			result = true
		end
		
		
		
		
	end
	
	
	
	
	if(action.name == "wait_second") then
		
		if(tick >= action.tick) then
			result = true
		end
		
		
		
	end
	
	
	if(action.name == "subtitle" or action.name == "random_subtitle") then
		
		if(tick >= action.tick) then
			result = true
			GameController["SubtitlesGameController"]:Cleanup()
		end
		
		
		
	end
	
	if(action.name == "npc_chat" or action.name == "random_npc_chat") then
		
		if(tick >= action.tick) then
			result = true
			GameController["ChattersGameController"]:Cleanup()
		end
		
		
		
	end
	
	
	if(action.name == "fade_in") then
		
		
		
		isFadeIn = true
		--debugPrint(4,opacity)
		
		
		if(tick >= action.tick) then
			
			
			opacity = 1
			
			
			
			result = true
			
			else
			local fadeincursor = tonumber(action.tick)
			
			
			
			local currentcursor = tonumber(tick)
			
			
			--debugPrint(4,fadeincursor)
			--debugPrint(4,currentcursor)
			
			
			opacity = (100/(fadeincursor-currentcursor))
			
			
		end	
	end
	
	if(action.name == "fade_out") then
		
		
		
		
		--debugPrint(4,opacity)
		
		
		if(tick >= action.tick) then
			
			
			opacity = 0
			isFadeIn = false
			
			
			result = true
			
			else
			local fadeoutcursor = tonumber(action.tick)
			
			
			
			local currentcursor = tonumber(tick)
			
			
			--debugPrint(4,fadeincursor)
			--debugPrint(4,currentcursor)
			
			
			opacity = 1 - (100/(fadeoutcursor-currentcursor))
			
			
		end	
	end
	
	if(action.name == "wait_for_trigger") then
		
		
		local trigger = action.trigger
		result = checkTrigger(trigger)
		
	end
	
	if(action.name == "wait_for_framework") then
		
		
		
		result = (waiting == false)
		--print("wait_for_framework "..tostring(waiting).." "..tostring(result))
		
	end
	
	
	if(action.name == "wait_for_target") then
		
		if(selectTarget ~= nil) then
			
			result =  true
			
		end
		
		
	end
	
	if(action.name == "wait_for_selection") then
		
		result = selectedEntity
		
		
	end
	
	
	if(action.name == "while_one") then
		
		local trigger = action.trigger
		result = checkTrigger(trigger)
		debugPrint(4,"while one "..tostring(result))
		executeAction(action.action,tag,parent,index,source,executortag)
		
		
	end
	
	if(action.name == "finish_mission") then
		
		if currentQuest ~= nil and currentQuest.tag == action.tag then
			
			result = true
			canDoEndAction = true
			
			else
			
			if currentQuest == nil or (currentQuest ~= nil and currentQuest.tag ~= action.tag) then
				
				result = false
				
				
			end
			
		end
		
	end
	
	return result
end

function cleanThreadManager()
	if GameUI.IsDetached() then
		workerTable = {}
		actionistaken = false
	end
	
	local count = 0
	if(#workerTable > 0 ) then
		
		for i=1, #workerTable do
			
			if workerTable[i].active == false then
				count = count + 1
			end
			
		end
		
		
		if(count == #workerTable) then
			----debugPrint(4,"clean worker table")
			workerTable = {}
			actionistaken = false
		end
		
	end
	
end




--requirement
function checkTriggerRequirement(requirement,triggerlist)
	
	local result = false
	
	if GameUI.IsLoading() == false and requirement ~= nil then
		
		for i=1, #requirement do --pour chaque requirement de la quete
			
			local requirementcondition = requirement[i]
			local count = 0
			
			for y =1,#requirementcondition do --pour chaque condition du requirement en cours
				
				
				if(result == false) then --si un requirement n'a pas été validé déja
					
					local trigger = triggerlist[requirementcondition[y]]
					
					local triggerIsOk = checkTrigger(trigger) --on evalue le trigger
					
					if(triggerIsOk) then --on incrémente le compteur si le trigger est ok
						
						
						count = count +1
					end
					
					
				end
				
				
				
				
			end
			
			if(count == #requirementcondition) then --si le compteur de bon trigger est egale a la totalité du requirementcondition, c'est que tout les parametres sont requis pour ce requirement
				result = true
			end
			
			
			
			
			
		end	
		
		if(#requirement == 0 and #triggerlist == 0) then
			result = true
			
		end
		
	end
	
	return result
end

function testTriggerRequirement(requirement,triggerlist)
	local result = false
	
	for i=1, #requirement do --pour chaque requirement de la quete
		
		local requirementcondition = requirement[i]
		
		local count = 0
		debugPrint(10,"Requirement : "..#requirementcondition)
		debugPrint(4,dump(requirementcondition))
		for y =1,#requirementcondition do --pour chaque condition du requirement en cours
			
			debugPrint(10,"Requirement : "..requirementcondition[y])
			if(result == false) then --si un requirement n'a pas été validé déja
				debugPrint(10,"Trigger : "..requirementcondition[y])
				local trigger = triggerlist[requirementcondition[y]]
				debugPrint(10,"Trigger : ")
				debugPrint(10,trigger.name)
				
				local triggerIsOk = checkTrigger(trigger) --on evalue le trigger
				debugPrint(10,triggerIsOk)
				if(triggerIsOk) then --on incrémente le compteur si le trigger est ok
					
					
					
					count = count +1
					debugPrint(10,count)
				end
				
				
			end
			
			
			
			
		end
		
		if(count == #requirementcondition) then --si le compteur de bon trigger est egale a la totalité du requirementcondition, c'est que tout les parametres sont requis pour ce requirement
			result = true
		end
		
		
		
		
		
	end	
	
	if(#requirement == 0 and #triggerlist == 0) then
		result = true
		
	end
	
	return result
end




--run action Thread
function runActionList(actionlist, tag, source,isquest,executortag,bypassMenu)
	
	
	local copy = deepcopy(actionlist, copies)
	
	-- for k,v in pairs(copy) then
	-- copy[k]["active"] = true
	-- end
	
	if(source == nil) then
		source = "interact"
	end
	
	
	
	
	if(workerTable[tag] == nil) then
		workerTable[tag] = {}
	end
	
	workerTable[tag]["action"] = copy
	workerTable[tag]["index"] = 1
	workerTable[tag]["parent"] = ""
	workerTable[tag]["started"] = false
	workerTable[tag]["pending"] = false
	workerTable[tag]["disabled"] = false
	workerTable[tag]["source"] = source
	workerTable[tag]["executortag"] = executortag
	workerTable[tag]["bypassMenu"] = bypassMenu
	
	if(isquest ~= nil) then
		workerTable[tag]["quest"] = isquest
	end
	
end

function runSubActionList(actionlist, tag, parent, source, isquest,executortag,bypassMenu)
	
	
	
	local copy = deepcopy(actionlist, copies)
	
	-- for k,v in pairs(copy) then
	-- copy[k]["active"] = true
	-- end
	
	if(source == nil) then
		source = "interact"
	end
	
	if(workerTable[tag] == nil) then
		workerTable[tag] = {}
	end
	
	
	workerTable[tag]["action"] = copy
	workerTable[tag]["index"] = 1
	workerTable[tag]["parent"] = parent
	workerTable[tag]["pending"] = false
	workerTable[tag]["started"] = false
	workerTable[tag]["source"] = source
	workerTable[parent]["pending"] = true
	workerTable[parent]["children"] = tag
	workerTable[tag]["disabled"] = false
	workerTable[tag]["executortag"] = executortag
	workerTable[tag]["bypassMenu"] = bypassMenu
	
	if(isquest ~= nil and isquest == true) then
		workerTable[tag]["quest"] = true
	end
	
end




--Do and Check object
function doEvent(tag)
	
	local boj = arrayEvent[tag]
	
	if( boj ~= nil) then
		local event = boj.event
		--testTriggerRequirement(event.requirement,event.trigger)
		
		if(checkTriggerRequirement(event.requirement,event.trigger))then
			
			--debugPrint(10,"CyberScript : Doing event : "..event.name)
			
			--	doActionof(event.action,"interact")
			runActionList(event.action, tag, "interact",false,"nothing")
			else
			--debugPrint(10,"CyberScript : can't do event : "..event.name)
			
		end
	end
end

function doFunction(tag)
	
	local boj = arrayFunction[tag]
	local event = boj.func
	debugPrint(4,event.tag)
	runActionList(event.action, tag, "interact",false,"nothing",boj.func.bypassmenu)
	
end

function doTriggeredEvent()
	
	
	
	worldprocessing = true
	
	possibleEvent = {}
	
	
	
	for key,value in pairs(arrayEvent) do --actualcode
		
		local event = arrayEvent[key].event
		
		if(event.way == "world") then
			--debugPrint(4,"check for "..event.name)
			--testTriggerRequirement(event.requirement,event.trigger)
			if(checkTriggerRequirement(event.requirement,event.trigger))then
				
				runActionList(event.action,key,"interact",false,"nothing")
				
			end
		end 
	end
	
	worldprocessing = false
	
	
end

function doInitEvent()
	
	
	
	worldprocessing = true
	
	possibleEvent = {}
	
	
	
	for key,value in pairs(arrayEvent) do --actualcode
		
		local event = value.event
		
		if(event.way == "init") then
			
			if(checkTriggerRequirement(event.requirement,event.trigger))then
				
				
				
				runActionList(event.action,key,"interact",false,"nothing")
			end
		end 
	end
	
	worldprocessing = false
	debugPrint(10,"CyberScript : doing init event...")
	
end

function doIf(action,list,currentindex,listaction)
	if(list[1].name ~= "goto" or list[1].name ~= "if") then
		local moveindex = #list
		local newlist = listaction
		for i = 1, moveindex do
			newlist[currentindex+moveindex+i] =  newlist[currentindex+i]
		end
		
		for i = 1, moveindex do
			newlist[currentindex+i] =  list[i]
		end
		
		debugPrint(4,"List Is :")
		for i=1, #newlist do
			debugPrint(4,newlist[i].name)
		end
		debugPrint(4,"End of ")
		action.newlist = newlist
		
		
		
		return false
	end	
	
end

function checkIf(action,parent,source,executortag)
	
	local trigger = action.trigger
	if(checkTrigger(trigger)) then
		
		local tag= "if_"..math.random(1,9999)
		local actiontodo = action.if_action
		runSubActionList(actiontodo, tag.."_if", parent,source,false,executortag)
		
		else
		
		local tag= "else_"..math.random(1,9999)
		local actiontodo = action.else_action
		runSubActionList(actiontodo, tag.."_else", parent,source,false,executortag)
		
		
		
		
	end
	
	
	
	
end

function checkEvents()
	
	getTriggeredActions()
	local message = ""
	
	if(#possibleInteract > 0) then
		message = message.."There is some interactions"
		else
		message = message.."There is no interactions"
	end
	
	if currentQuest == nil then
		
		if(#possibleQuest > 0) then
			message = message.." and some quest"
			else
			message = message.." and no quest"
		end
		
		
	end
	
	message = message.." available near from you"
	Game.GetPlayer():SetWarningMessage(message)
	
end

function checkAmbush()
	local ambushevent = {}
	
	if(AmbushEnabled == true and isAVinService == false) then
		--debugPrint(4,"mark1")
		if(currentDistricts2.customdistrict ~= nil) then
			--debugPrint(4,"mark1")		
			
			
			debugPrint(3,"check ambsush")
			--	debugPrint(4,"mark1")	
			for k,v in pairs(arrayEvent) do
				
				if(arrayEvent[k].event.way == "ambush") then
					--debugPrint(4,arrayEvent[k].event.way)
					--table.insert(ambushevent,k)
					debugPrint(10,k)
					doEvent(k)
					
					
				end
			end
			
			-- if(#ambushevent > 0) then
			-- local tag = math.random(1,#ambushevent)
			-- debugPrint(4,"doing ambush "..tag)
			-- doEvent(ambushevent[tag])
			-- end
			
			
			
			
			
			
			
			
		end
	end
	
end

function checkSpeakDialog()
	
	if currentStar ~= nil then
		--if string.match(currentStar.Names,targName) then
		
		
		
		if tostring(TweakDBID.new(currentStar.TweakIDs)) == tostring(objLook:GetRecordID()) then
			
			if startSpeak == false then
				
				selectNPCForSpeak(currentStar)
				
				
				
				
			end
			else
			if(currentDialogHub ~= nil) then
				openSpeakDialogWindow = false	
				startSpeak =false
				isdialogactivehub = false
				removeDialog()
				currentDialogHub = nil
				debugPrint(4,"totot")
			end
		end
		
		
	end
	
	if objLook == nil then
		
		openSpeakDialogWindow = false	
		startSpeak =false
		
	end
	
end

function checkFixer()
	
	
	
	
	if phonedFixer == false then
		if curPos ~= nil then
			--	debugPrint(4,curPos)
			currentfixer = checkWithFixer(curPos)
		end
	end
	
	
	
	-- pcall(function() 
	if(currentfixer ~= nil) then --if fixer si founded
		
		
		if(checkTriggerRequirement(currentfixer.requirement,currentfixer.trigger)) then --check that fixer can be spawn
			
			--print(currentfixer.Tag)
			oldfixer = currentfixer
		
					
					local obj = getEntityFromManager(currentfixer.Tag)
					
					
					
					
					if(obj.id == nil) then -- if there is no entity
							--print("spawn")
						
						local twkVehi = TweakDBID.new(currentfixer.NPCId)
						
						
						spawnNPC(currentfixer.NPCId,"", currentfixer.Tag, currentfixer.LOC_X, currentfixer.LOC_Y, currentfixer.LOC_Z, 42, true, false, nil, false, nil)
						
						-- local obj = getEntityFromManager(currentfixer.Tag)
						-- local enti = Game.FindEntityByID(obj.id)
						-- lookAtPlayer(enti, 999999999)
						
						-- setFriendAgainst(currentfixer.Tag, "player")
						
					
						if(currentfixer.spawn_action ~= nil and #currentfixer.spawn_action >0 and fixerIsSpawn == false) then
							
							
							runActionList(currentfixer.spawn_action, currentfixer.Tag.."_Spawn",nil,nil,currentfixer.Tag)
							
						end
						
						
						
					end	
				
			
			
			
			
			
			
			
		
			
		end
		
	else -- if we move away from fixer so currentfixer is nil
	

			Game.ChangeZoneIndicatorPublic()
			
			if(oldfixer ~= nil) then
				
	
			local obj = getEntityFromManager(oldfixer.Tag)
					
					
					
					
			if(obj.id ~= nil) then
			despawnEntity(oldfixer.Tag)
			
			
			
			if(oldfixer ~= nil and oldfixer.despawn_action ~= nil and #oldfixer.despawn_action >0) then
				
				--doActionof(currentfixer.action,"interact")
				runActionList(oldFixer.despawn_action, oldFixer.Tag.."_Despawn",nil, nil,currentfixer.Tag)
				
				
				
			end
			
		oldfixer = nil
			
			
		end
		
			end
		
	end
	
	
	
	
end


function checkContext(item)
	if(item.context ~= nil) then
		
		if(isArray(item.context))then
			for i,v in ipairs(item.context) do
				
				if(checkTriggerRequirement(v.requirement,v.trigger))then
					
					if(v.action ~= nil and #v.action > 0) then
						
						runActionList(v.action, item.tag, "see", false,"see",false)					
					end
					
					
					for k,u in pairs(v.prop) do
						local path =  splitDot(k, ".")
						setValueToTablePath(item, path, GeneratefromContext(u))
						
					end
				end
			end
			else
			if(checkTriggerRequirement(item.context.requirement,item.context.trigger))then
				for k,u in pairs(item.context.prop) do
					
					
					local path =  splitDot(k, ".")
					
					
					setValueToTablePath(item, path, GeneratefromContext(u))
				end
			end
		end
		
	end
end

function checkNPC()
	
	
	local playerpos= Game.GetPlayer():GetWorldPosition()
	
	for k,v in pairs(arrayCustomNPC) do
		
		local npc = arrayCustomNPC[k].npc
		
		
		checkContext(npc)
		
		
		local obj = getEntityFromManager(k)
		
		local npcpostion = getPositionFromParameter(npc.location)
		
		if(npcpostion.x ~= nil and npcpostion.y ~= nil and npcpostion.z~= nil)then
		if( check3DPos(playerpos, npcpostion.x,  npcpostion.y,  npcpostion.z, npc.location.player_range) and getEntityFromManager(k).id == nil and checkTriggerRequirement(npc.requirement,npc.triggers) ) then
			--if the npc is not spawned
		
			local tweakDBnpc =  npc.tweakDB
			
			if(tweakDBnpc== "district") then
				
				local gangs = getGangfromDistrict(currentDistricts2.Tag,20)
				
				if(#gangs == 0) then
					
					break
					
				end
				
				local gang = getFactionByTag(gangs[1].tag)
				
				if(#gang.SpawnableNPC > 0) then
					local index = math.random(1,#gang.SpawnableNPC)
					
					tweakDBnpc = gang.SpawnableNPC[index]
					else
					break
				end
				
				elseif (tweakDBnpc== "subdistrict") then
				
				local gangs = {}
				
				for i, test in ipairs(currentDistricts2.districtLabels) do
					if i > 1 then
						
						
						gangs = getGangfromDistrict(test,20)
						
						if(#gangs == 0) then
							
							break
							
						end
					end
				end
				
				local gang = getFactionByTag(gangs[1].tag)
				
				if(#gang.SpawnableNPC > 0) then
					local index = math.random(1,#gang.SpawnableNPC)
					
					tweakDBnpc = gang.SpawnableNPC[index]
					else
					break
				end
				
				if(tweakDBnpc== "districttag") then
					
					gangs = getGangfromDistrict(npc.locationtag,20)
					
					if(#gangs == 0) then
						
						break
						
					end
					
					local gang = getFactionByTag(gangs[1].tag)
					
					if(#gang.SpawnableNPC > 0) then
						local index = math.random(1,#gang.SpawnableNPC)
						
						tweakDBnpc = gang.SpawnableNPC[index]
						else
						break
					end
					
					elseif (tweakDBnpc== "subdistricttag") then
					
					local gangs = {}
					
					gangs = getGangfromDistrict(npc.locationtag,20)
					
					local gang = getFactionByTag(gangs[1].tag)
					
					if(#gang.SpawnableNPC > 0) then
						local index = math.random(1,#gang.SpawnableNPC)
						
						tweakDBnpc = gang.SpawnableNPC[index]
						else
						break
					end
					
					
					
					
				end
			end
			
			
			spawnNPC(tweakDBnpc,"", npc.tag, npcpostion.x, npcpostion.y, npcpostion.z, 42, true, false, nil, false, npc.rotation)
			
			npc.isspawn=true
			npc.init=false
			
			
			else
		
			
			
			if(obj ~= nil and obj.id ~= nil) then 
				local enti = Game.FindEntityByID(obj.id)	
				
				
				if(enti ~= nil) then--entity exist 
					
					if((check3DPos(Game.GetPlayer():GetWorldPosition(), npcpostion.x,  npcpostion.y,  npcpostion.z, npc.location.player_range) and npc.spawnforced == false) or npc.spawnforced == true) then --ifplayer is in the location
						
						if(arrayCustomNPC[k].npc.init==false) then --if not initiaded
							
							local npc = arrayCustomNPC[k].npc
							
							if(npc.appeareance ~= nil or npc.appeareance ~= "" and arrayCustomNPC[k].npc.appearancesetted == false) then
								
								local obj = getEntityFromManager(npc.tag)
								local enti = Game.FindEntityByID(obj.id)
								if(enti ~= nil) then
									
									--getAppearance(enti)
									setAppearance(enti,npc.appeareance)
									arrayCustomNPC[k].npc.appearancesetted = true
								end
								
								
							end
							
							if(workerTable[npc.tag.."_spawn"] == nil and #npc.spawnaction > 0 and npc.dospawnaction == true) then
								
								
								
								runActionList(npc.spawnaction, npc.tag.."_spawn", "interact",false,npc.tag)
								
							end
							
							if(workerTable[npc.tag.."_routine"] == nil and #npc.routineaction > 0 and npc.doroutineaction == true) then
								runActionList(npc.routineaction, npc.tag.."_routine", "interact",false,npc.tag)
								
							end
							
							
							arrayCustomNPC[k].npc.init = true
							
							else
							
							
							
							if(workerTable[npc.tag.."_routine"] == nil and npc.repeat_routine == true and #npc.routineaction > 0 and npc.doroutineaction == true) then
								runActionList(npc.routineaction, npc.tag.."_routine", "interact",false,npc.tag)
								--	debugPrint(4,"doing routine of "..npc.name)
								
							end
							
							
							if (workerTable[npc.tag.."_death"] == nil and npc.deathaction ~= nil and #npc.deathaction > 0 and (enti:IsDead() == true or enti:IsActive() == false) and npc.dodeathaction == true)then
								runActionList(npc.deathaction, npc.tag.."_death", "interact",false,npc.tag)
								
								npc.dodeathaction= false
							end
						end
						
						
						else
						
						
						if(npc.auto_despawn == true) then
							
							arrayCustomNPC[k].npc.isspawn=false
							arrayCustomNPC[k].npc.init=false
							arrayCustomNPC[k].npc.appearancesetted = nil
							
							if(workerTable[npc.tag.."_spawn"] ~= nil) then
								
								workerTable[npc.tag.."_spawn"] = nil
								
							end
							
							if(workerTable[npc.tag.."_routine"] ~= nil) then
								
								workerTable[npc.tag.."_routine"] = nil
								
							end
							
							if(workerTable[npc.tag.."_death"] ~= nil) then
								
								workerTable[npc.tag.."_death"] = nil
								
							end
							
							despawnEntity(npc.tag)
								
							if(workerTable[npc.tag.."_despawn"] == nil and #npc.despawnaction > 0 and npc.dospawnaction == true) then
								runActionList(npc.despawnaction, npc.tag.."_despawn", "interact",false,npc.tag)
								
							end
							
						end
						
					end
					
				end
			end
			
			
			
		
		end
		
		else
		--print("error for npc working location. NPC : "..k)
		end
		
		
	end
	
	
end

function checkValue(operator,value1,value2)
	return (
		(value1 ~= nil and value2 ~= nil and 
			(
				(operator == "<" and value1 < value2) or 
				(operator == "<=" and value1 <= value2) or
				(operator == ">" and value1 > value2) or
				(operator == ">=" and value1 >= value2) or
				(operator == "!=" and value1 ~= value2) or 
				(operator == "=" and value1 == value2)
			)
		) or
		(operator == "empty" and value1 == nil) or
		(operator == "notempty" and value1 ~= nil)
		
		or
		(operator == "nothing" and value1 == nil) or
		(operator == "notnothing" and value1 ~= nil)
		
		
	)
end

--Get List

function getInteractGroup()
	
	currentInteractGroup ={}
	
	local groupof = {}
	
	for key,value in pairs(arrayInteract) do --actualcode
		
		
		local interact2 = arrayInteract[key].interact
		local canadd = true
		
		for i=1,#currentInteractGroup do
			
			if(currentInteractGroup[i] == interact2.group)  then
				canadd = false
				
			end
			
		end
		
		if(canadd == true) then
			
			table.insert(currentInteractGroup, interact2.group)
			
		end
		
		
	end
	
	
	
	
end

function getTriggeredActions()
	
	
	
	worldprocessing = true
	local possibleinteractchunk = {}
	possibleInteract = {}
	local possibleinteractchunked = {}
	
	
	for key,value in pairs(arrayInteract) do --actualcode
		
		local interact2 = arrayInteract[key].interact
		
		--testTriggerRequirement(interact2.requirement,interact2.trigger)
		if(checkTriggerRequirement(interact2.requirement,interact2.trigger)) and (interact2.group == currentInteractGroup[currentInteractGroupIndex] or key == "open_datapack_group_ui") then
			
			--debugPrint(4,"check for "..interact2.name.." "..tostring(checkTriggerRequirement(interact2.requirement,interact2.trigger)))
			table.insert(possibleinteractchunk, interact2)
			else
			
			if(#currentInputHintList > 0) then
				
				for i = 1, #currentInputHintList do
					
					if(currentInputHintList[i].tag == interact2.tag) then
						hideCustomHints(interact2.tag)
						currentInputHintList[i] = nil
					end
					
					
				end
				
				
			end
			
		end
	end
	local chunk = {}
	local count = 1
	
	
	for i=1,#possibleinteractchunk+1 do 
		
		--	
		if(#chunk < 4 and i<#possibleinteractchunk+1) then
			
			
			if(possibleinteractchunk[i] ~= nil) then
				
				table.insert(chunk,possibleinteractchunk[i])
				count = count + 1
				
			end
			
			else
			
			
			
			local chunkcopy = {}
			for z=1,#chunk do 
				
				table.insert(chunkcopy,chunk[z])
				
			end
			
			table.insert(possibleInteract,chunkcopy)
			
			
			if(possibleinteractchunk[i] ~= nil) then
				chunk = {}
				table.insert(chunk,possibleinteractchunk[i])
				
				count = 1
				
			end
		end
		
		
	end
	
	
	
	
	
	
	worldprocessing = false
	
	
end

function getTriggeredActionsDisplay()
	
	-- if(#currentInputHintList > 0) then
	
	-- for i = 1, #currentInputHintList do
	
	-- hideCustomHints(currentInputHintList[i].tag)
	
	-- end
	
	-- end
	
	
	possibleinteractchunk = {}
	
	local possibleinteractchunked = {}
	possibleInteractDisplay = {}
	for i=1,#possibleInteract do
		
		for z=1,#possibleInteract[i] do 
			
			
			if((possibleInteract[i][z].display == "event_interact" 
				or 
				(currentHouse ~= nil and (possibleInteract[i][z].display == "place"
					or possibleInteract[i][z].display == "place_main" or 
				possibleInteract[i][z].display == "event_interact")))) then
				table.insert(possibleinteractchunk,possibleInteract[i][z])
			end
			
			
		end
		
		
	end
	
	
	local chunk = {}
	
	for i=1,#possibleinteractchunk+1 do 
		
		--	
		if(#chunk < 4 and i<#possibleinteractchunk+1) then
			
			
			if(possibleinteractchunk[i] ~= nil) then
				
				table.insert(chunk,possibleinteractchunk[i])
				
				
			end
			
			else
			
			
			
			local chunkcopy = {}
			for z=1,#chunk do 
				chunk[z].input=z
				table.insert(chunkcopy,chunk[z])
				
			end
			
			table.insert(possibleInteractDisplay,chunkcopy)
			
			if(possibleinteractchunk[i] ~= nil) then
				chunk = {}
				table.insert(chunk,possibleinteractchunk[i])
				
				
			end
		end
		
		
	end
	
	
	
	
	
	
	
end

function getMissionByTrigger()
	
	
	--find new mission
	
	
	possibleQuest = {}
	
	for key,value in pairs(arrayQuest2) do --actualcode
		
		if(checkQuestStatutByTag(key, nil) == true or checkQuestStatutByTag(key, -1) == true) then
			local quest = arrayQuest2[key].quest
			
			if(HaveTriggerCondition(quest))then
				
				--------debugPrint(4,"trigger")
				
				--if(possibleQuest[quest] ~= nil) then
				
				table.insert(possibleQuest, quest)
				
				if(QuestManager.GetQuestState(quest.tag).isActive == false) then
					
					if(quest.unlock_action ~= nil and #quest.unlock_action > 0) then
						runActionList(quest.unlock_action,quest.tag.."_unlockaction","quest",true,"see_engine",true)
					end
					
					
					QuestManager.MarkQuestAsActive(quest.tag)
					
					
				end
				--end
				
				else
				--debugPrint(4,tostring(QuestManager.isVisited(key)))
				if not QuestManager.isVisited(key) then
					QuestManager.MarkQuestAsInactive(key)
					--debugPrint(4,"remove"..key)
				end
			end
			
			else
			if(checkQuestStatutByTag(key, 3) == true) then
				--QuestManager.MarkQuestAsInactive(key)
				QuestManager.MarkQuestASucceeded(key)
			end
			
		end
		
	end
	
	
	
	
	
	
	takenQuest = {}
	
	for key,value in pairs(arrayQuest2) do --actualcode
		local statuQue = checkQuestStatutByTag(key, 0) or checkQuestStatutByTag(key, 1) or checkQuestStatutByTag(key, 2)
		
		if( statuQue== true) then
			
			local quest = arrayQuest2[key].quest
			
			
			
			
			--if(possibleQuest[quest] ~= nil) then
			--table.insert(takenQuest, quest)
			QuestManager.MarkQuestAsActive(quest.tag)
			--end
			
		end
		
	end
	
	
	
end





--GET objects

function getEventByTag(tag)
	debugPrint(4,"d,f,	")
	for i=1,#arrayEvent do
		debugPrint(4,arrayEvent[i].event.name)
		if(arrayEvent[i].event.tag == tag)then
			
			return arrayEvent[i].event
			
		end
		
	end
	
	return nil
end

function getSubtitleByTag(tag)
	
	for i=1,#arraySubtitle do
		
		if(arraySubtitle[i].tag == tag)then
			
			return arraySubtitle[i]
			
		end
		
	end
	
	return nil
end

function getShardByTag(tag)
	
	
	if(arrayShard[tag] ~= nil)then
		
		return arrayShard[tag].shard
		
	end
	return nil
	
end

function getCustomNPCByTag(tag)
	
	
	if(arrayCustomNPC[tag] ~= nil)then
		
		return arrayCustomNPC[tag].npc
		
	end
	return nil
	
end

function getInteractByTag(tag)
	
	return arrayInteract[tag].interact
	
	
end

function getInteractsBySortTag(tag)
	local result = {}
	
	for i = 1, #possibleInteract do
		
		for z = 1, #possibleInteract[i] do
			--debugPrint(4,possibleInteract[i].name)
			if(possibleInteract[i][z].sorttag == tag)then
				
				table.insert(result, possibleInteract[i][z])
				
			end
			
		end
		
	end
	
	return result
end

function getPhoneConversationByTag(tag)
	
	if(arrayPhoneConversation[tag] ~= tag)then
		
		return arrayPhoneConversation[tag].conv
		
	end
	
	return nil
	
end

function getPath(tag)
	
	
	if(arrayPath[tag] ~= nil) then
		return arrayPath[tag].gamepath
	end
	return nil
	
end

function getPOI(tag)
	
	
	if(arrayPOI[tag] ~= nil) then
		return arrayPOI[tag].poi
	end
	return nil
	
	
end

function FindPOI(tag,district,subdistrict,iscar,poitype,locationtag,fromposition,range,frompositionx,frompositiony,frompositionz)
	local currentpoilist = {}
	local frompos = curPos
	if(frompositionx ~= nil and frompositiony ~= nil and frompositionz ~= nil) then
		
		frompos.x = frompositionx
		frompos.y = frompositiony
		frompos.z = frompositionz
		
	end
	
	for k,v in pairs(arrayPOI) do
		
		
		
		
		if
			(#v.poi.locations > 0) then	
			
			for y=1,#v.poi.locations do
				
				local location = v.poi.locations[y]
				
				-- debugPrint(4,"TEST POI ---")
				-- debugPrint(4,"tag : "..tostring((
				-- ((tag == nil or tag == "" or (v.poi.tag ~= nil and v.poi.tag == tag)) and locationtag == false) or
				-- ((tag == nil or tag == "" or (location.Tag ~= nil and location.Tag == tag)) and locationtag == true)
				-- )))
				
				-- debugPrint(4,"district : "..tostring((district == nil or district == "" or (district ~= nil and location.district == district))))
				-- debugPrint(4,"subdistrict : "..tostring((subdistrict == nil or subdistrict == "" or (subdistrict ~= nil and location.subdistrict == subdistrict))))
				
				-- debugPrint(4,"iscar : "..tostring((iscar == nil or (iscar ~= nil and location.inVehicule == iscar))))
				-- debugPrint(4,"poitype : "..tostring((poitype == nil or poitype == 1 or (poitype == v.poi.isFor))))
				-- debugPrint(4,"fromposition : "..tostring((fromposition == false or	(fromposition == true and check3DPos(curPos, location.x, location.y, location.z, range)))))
				-- debugPrint(4,"TEST POI ---")
				
				if
					(
						(
							((tag == nil or tag == "" or (v.poi.tag ~= nil and v.poi.tag == tag)) and locationtag == false) or
							((tag == nil or tag == "" or (location.Tag ~= nil and location.Tag == tag)) and locationtag == true)
						)
						
						and
						
						(district == nil or district == "" or (district ~= nil and location.district == district)) and
						(subdistrict == nil or subdistrict == "" or (subdistrict ~= nil and location.subdistrict == subdistrict)) and
						(iscar == nil or (iscar ~= nil and location.inVehicule == iscar)) and
						
						
						(poitype == nil or 
							
							(
								(isArray(poitype) == false and isArray(v.poi.isFor) == false and (poitype == 1 or (poitype == v.poi.isFor))) or
								(isArray(poitype) == true and isArray(v.poi.isFor) == false and table_contains(poitype,v.poi.isFor)) or
								(isArray(poitype) == false and isArray(v.poi.isFor) == true and table_contains(v.poi.isFor,poitype)) or
								(isArray(poitype) == true and isArray(v.poi.isFor) == true and table.compare(poitype, v.poi.isFor))
							)
							
						) and
						
						
						(fromposition == false or	(fromposition == true and check3DPos(frompos, location.x, location.y, location.z, range)))
						
						
					)
					then
					
					
					
					
					table.insert(currentpoilist,v.poi.locations[y])
					
					
					
					
					
					
					
				end
				
				
				
				
				
			end
			
			
		end
		
	end
	
	if(#currentpoilist > 0) then
		
		local currentpoi = nil
		currentpoi = currentpoilist[math.random(#currentpoilist)]
		
		return currentpoi
		else
		return nil
	end
	
end

function getNodeIndexFromCircuit(tag,listnodes)
	for i=1,#listnodes do
		
		
		
		
		if(listnodes[i] == tag)then
			return i
		end
		
		
		
		
		
		
	end
end

function getPathBetweenTwoNode(CurrentNode, NextNode)
	debugPrint(4,"CurrentNode"..CurrentNode)
	debugPrint(4,"NextNode"..NextNode)
	for k,v in pairs(arrayPath)do
		
		
		local path = v.gamepath
		debugPrint(4,"startNode"..path.startNode)
		debugPrint(4,"endNode"..path.endNode)
		
		if(path.startNode == CurrentNode and path.endNode == NextNode)then
			return path
		end
		
		
		
		
		
		
	end
end

function getNodefromPosition(x,y,z,range)
	local vec4 = {}
	vec4.x = x
	vec4.y = y
	vec4.z = z
	
	for k,v in pairs(arrayNode) do
		
		
		local node = v.node
		
		
		
		if(check3DPos(vec4,node.X,node.Y,node.Z,range) or check3DPos(vec4,node.GameplayX,node.GameplayY,node.GameplayZ,range))then
			return node
		end
		
		
		
		
		
		
	end
	
	
end

function getTrack(tag)
	
	for i=1,#arrayTrack do
		
		
		local location = arrayTrack[i]
		
		if(location.tag == tag)then
			return location
		end
		
		
		
		
		
		
	end
	
	
end

function getCurrentTrack(tag)
	
	for i=1,#enabledTrack do
		
		
		local location = enabledTrack[i]
		
		if(location.tag == tag)then
			return location
		end
		
		
		
		
		
		
	end
	
	
end

function getCurrentTrackIndex(tag)
	
	for i=1,#enabledTrack do
		
		
		local location = enabledTrack[i]
		
		if(location.tag == tag)then
			return i
		end
		
		
		
		
		
		
	end
	
	
end

function checkQuestStatutByTag(tag, statut)
	local result = false
	
	
	
	
	
	
	
	
	if(currentSave.Variable[tag] ~= nil) then
		
		
		
		if( currentSave.Variable[tag]["Score"] == statut) then
			result = true
		end
		
		else
		
		if(currentSave.Variable[tag] == statut) then
			
			result = true
			
		end
		
	end
	
	return result
end

function getCircuit(tag)
	
	
	
	if(arrayCircuit[tag] ~= nil) then
		return arrayCircuit[tag].circuit
	end
	
	
end

function getNode(tag)
	
	
	if(arrayNode[tag] ~= nil) then
		return arrayNode[tag].node
	end
	
	
	
	
	
	
end

function getRadioByTag(tag)
	
	
	
	if(arrayRadio[tag] ~= nil)then
		return arrayRadio[tag].radio
	end
	
	
	return nil
	
end	

function getMappinByTag(tag)
	
	
	return mappinManager[tag]
	
end

function getPNJ (tab, val)
    for index, value in ipairs(tab) do
        if value.ID == val then
			
            return value
		end
	end
	
    return false
end

function getGameTime()
	
	local temp = {}
	local gameTime = Game.GetTimeSystem():GetGameTime()
	
	temp.hour = GetSingleton('GameTime'):Hours(gameTime)
	temp.min = GetSingleton('GameTime'):Minutes(gameTime)
	temp.sec = GetSingleton('GameTime'):Seconds(gameTime)
	temp.day = GetSingleton('GameTime'):Days(gameTime)
	
	return temp
	
end

function getDistrictfromEnum(enum)
	
	for i = 1, #arrayDistricts do
		if arrayDistricts[i].EnumName:upper() == Game.GetLocalizedText(enum):upper() then
			return arrayDistricts[i]
			
			
		end
		
	end
	
end

function getDistrictBySubfromEnum(enum)
	
	for i = 1, #arrayDistricts do
		if(#arrayDistricts[i].SubDistrict > 0) then
			for j=1,#arrayDistricts[i].SubDistrict do
				if arrayDistricts[i].SubDistrict[j]:upper() == Game.GetLocalizedText(enum):upper() then
					return arrayDistricts[i]
					
					
				end
			end
		end	
	end
	
end

function getDistrictByTag(district)
	
	for i = 1, #arrayDistricts do
		if(arrayDistricts[i].Tag == district) then
			
			
			return arrayDistricts[i]
			
			
			
		end
	end	
end

function getMappinByGroup(group)
	local mapLot = {}
	
	for k,v in pairs(mappinManager) do
		if(v.group and v.group == group )then
			table.insert(mapLot,v)
		end
	end
	
	return mapLot
end

function GetPlayerGender()
	-- True = Female / False = Male
	if string.find(tostring(Game.GetPlayer():GetResolvedGenderName()), "Female") then
		return "female"
		else
		return "male"
	end
end

function GetEntityGender(entity)
	-- True = Female / False = Male
	debugPrint(4,tostring(Game.NameToString(entity:GetBodyType())))
	if string.find(tostring(Game.NameToString(entity:GetBodyType())), "oman") then
		return "female"
		else
		return "male"
	end
end

function getQuestByTag(tag)
	
	local parentquest = arrayQuest2[tag]
	local quest = nil
	if(parentquest ~= nil) then
		quest =  parentquest.quest
		--debugPrint(4,parentquest.file)
	end
	return quest
	
	
end

function getQuestStatut(tag)
	
	
	
	local score = getScoreKey(tag,"Score")
	
	if(score ~= nil) then
		return score
		
	end
	
	return nil
	
	
end

function getMarketScoreByTag(tag)
	
	local result = nil
	
	for i=1,#arrayMarket do
		
		if(arrayMarket[i].tag == tag) then
			return arrayMarket[i]
		end
		
		
		
	end
	
	return result
	
end

function getScorebyTag(tag)
	
	local score = 0
	
	score = getScoreKey(tag,"Score")
	if(score == nil)then
		score = 0
	end
	
	
	
	return score
	
end

function getFactionByDistrictTag(tag)
	
	local factiontable = {}
	
	for k,v in pairs(arrayFaction) do
		checkContext(v)
		if(arrayFaction[k].faction.DistrictTag == tag) then
			
			table.insert(factiontable,arrayFaction[k].faction)
			
		end
		
		
		
	end
	
	return factiontable
	
end

function getVIPfromfactionbyscore(factiontag)
	local tempvip = {}
	
	local faction = getFactionByTag(factiontag)
	
	local playerscore = getScorebyTag(factiontag)
	
	
	if(#faction.VIP > 0) then
		for i=1,#faction.VIP do 
			
			if(faction.VIP[i].score <= playerscore) then
				
				local npc = getNPCByName(faction.VIP[i].name)
				
				table.insert(tempvip,npc.TweakIDs)
				
			end
			
			
		end
	end
	
	if(#tempvip == 0) then
		debugPrint(10,getLang("scripting_novip01")..factiontag..getLang("scripting_novip02")..playerscore)
	end
	
	return tempvip
end

function getGangfromDistrict(district,minimum)
	
	local factiontable = {}
	
	for k,v in pairs(currentSave.Variable) do
		
		if(currentSave.Variable[k][district] ~= nil and currentSave.Variable[k][district] >= minimum) then
			
			local factionscore= {}
			factionscore.tag = k
			factionscore.score = currentSave.Variable[k][district]
			table.insert(factiontable,factionscore)
			
			else
			
			if(currentSave.Variable[k][district] == nil) then
				
				currentSave.Variable[k][district] = 0
				
			end
			
		end
		
		
		
	end
	
	table.sort(factiontable, function(a,b) return a.score > b.score end)
	
	return factiontable
	
end

function getGangRivalsFromGang(gang)
	
	local factiontable = {}
	if(currentSave.Variable[gang] ~= nil) then
		for k,v in pairs(currentSave.Variable[gang]) do
			if(k ~= "Score") then
				local factionscore= {}
				factionscore.tag = k
				factionscore.score =getFactionRelation(gang,k)
				table.insert(factiontable,factionscore)
			end
		end
	end
	table.sort(factiontable, function(a,b) return a.score < b.score end)
	
	return factiontable
	
end

function getGangRivalfromDistrict(gang,district,minimum)
	
	local districttable = {}
	local factiontable = {}
	
	for k,v in pairs(currentSave.Variable) do
		
		if(currentSave.Variable[k][district] ~= nil and currentSave.Variable[k][district] >= minimum) then
			
			local factionscore= {}
			factionscore.tag = k
			factionscore.score = currentSave.Variable[k][district]
			table.insert(districttable,factionscore)
			
			else
			
			if(currentSave.Variable[k][district] == nil) then
				
				currentSave.Variable[k][district] = 0
				
			end
			
		end
		
		
		
	end
	
	
	
	
	for i=1,#districttable do
		
		local factionscore= {}
		factionscore.tag = districttable[i].tag
		factionscore.score = getFactionRelation(gang,districttable[i].tag)
		table.insert(factiontable,factionscore)
		
	end
	
	
	table.sort(factiontable, function(a,b) return a.score > b.score end)
	return factiontable
	
end

function getGangfromDistrictAndSubdistrict(district,minimum)
	
	local factiontable = {}
	
	
	local mydistrict = getDistrictByTag(district)
	
	for k,v in pairs(currentSave.Variable) do
		
		
		if(currentSave.Variable[k][mydistrict.Tag] ~= nil and currentSave.Variable[k][mydistrict.Tag] >= minimum) then
			-- debugPrint(4,k)
			
			local obj = {}
			obj.tag = k
			obj.score = currentSave.Variable[k][mydistrict.Tag]
			table.insert(factiontable,obj)
			
			
			
			
			else
			
			if(currentSave.Variable[k][mydistrict.Tag] == nil) then
				
				currentSave.Variable[k][mydistrict.Tag] = 0
				
			end
			
		end
		
		
		
	end
	
	
	
	
	table.sort(factiontable, function(a,b) return a.score > b.score end)
	
	return factiontable
	
end

function getGangAffinityfromDistrictAndSubdistrict(district,minimum)
	
	local factiontable = {}
	
	
	
	local mydistrict = getDistrictByTag(district)
	
	for k,v in pairs(currentSave.Variable) do
		
		
		if(currentSave.Variable[k][mydistrict.Tag] ~= nil and currentSave.Variable[k][mydistrict.Tag] >= minimum) then
			
			
			local obj = {}
			obj.tag = k
			obj.score = getScorebyTag(k)
			table.insert(factiontable,obj)
			
			
			
			
			else
			
			if(currentSave.Variable[k][mydistrict.Tag] == nil) then
				
				currentSave.Variable[k][mydistrict.Tag] = 0
				
			end
			
		end
		
		
		
	end
	
	for i=1,#mydistrict.SubDistrict do
		
		local subdist = mydistrict.SubDistrict[i]
		debugPrint(4,subdist)
		for k,v in pairs(currentSave.Variable) do
			
			
			if(currentSave.Variable[k][subdist] ~= nil and currentSave.Variable[k][subdist] >= minimum) then
				for i=1,#factiontable do
					if(factiontable[i].tag == k) then
						
						factiontable[i].score =  factiontable[i].score + getScorebyTag(k)
						else
						
						local obj = {}
						obj.tag = k
						obj.score = getScorebyTag(k)
						table.insert(factiontable,obj)
						debugPrint(4,k)
						
					end
					
					
					
				end
			end
			
			
		end
	end
	
	
	
	table.sort(factiontable, function(a,b) return a.score > b.score end)
	
	return factiontable
	
end

function getFactionByTag(tag)
	
	local factiontable = {}
	
	for k,v in pairs(arrayFaction) do
		checkContext(v)
		if(arrayFaction[k].faction.Tag == tag) then
			
			return arrayFaction[k].faction
			
		end
		
		
		
	end
	
	return factiontable
	
end

function getItemEntityFromManager(entid)
	
	local obj =  nil
	
	if(#currentItemSpawned > 0) then
		for i = 1, #currentItemSpawned do
			
			local enti = currentItemSpawned[i]
			
			
			
			if type(enti.entityId) ~= "number" then
				
				if(enti.entityId.hash == entid.hash) then
					
					obj = enti
					
				end
				
			end
			
			
			
			
			
		end
	end
	return obj
	
	
	
end

function getItemEntityIndexFromManager(entid)
	
	
	
	if(#currentItemSpawned > 0) then
		for i = 1, #currentItemSpawned do
			
			local enti = currentItemSpawned[i]
			
			
			
			if type(enti.entityId) ~= "number" then
				
				if(enti.entityId.hash == entid.hash) then
					
					return i
					
				end
				
			end
			
			
			
			
			
		end
	end
	
	return nil
	
	
	
end

function getItemByHouseTagandTagFromManager(tag,housetag)
	
	
	
	if(#currentItemSpawned > 0) then
		for i = 1, #currentItemSpawned do
			
			local enti = currentItemSpawned[i]
			
			
			
			if enti.HouseTag == housetag and enti.Tag == tag then
				
				
				
				return i
				
				
				
			end
			
			
			
			
			
		end
	end
	
	return nil
	
	
	
end

function getItemEntityFromManagerByPlayerLookinAt()
	
	local obj =  nil
	
	if(#currentItemSpawned > 0) then
		for i = 1, #currentItemSpawned do
			
			local enti = currentItemSpawned[i]
			local playerlook = getForwardPosition(Game.GetPlayer(),2)
			
			
			
			if type(enti.entityId) ~= "number" then
				local postion = Vector4.new(enti.X, enti.Y, enti.Z, 1)
				
				if(check3DPos(postion, playerlook.x, playerlook.y, playerlook.z,1, 3)) then
					
					obj = enti
					
				end
				
			end
			
			
			
			
			
		end
	end
	return obj
	
	
	
end

function getItemFromUserHousing(tag,X,Y,Z,HouseTag,ItemPath)
	
		for i=1,#currentSave.arrayHousing do
			
			if(currentSave.arrayHousing[i].Tag == tag and currentSave.arrayHousing[i].HouseTag == HouseTag and currentSave.arrayHousing[i].ItemPath == ItemPath) then
				return currentSave.arrayHousing[i]
			end
			
		end
	
	return nil
end

function getItemCountInCart(tag) 
	
	local count = 0
	
	for i=1,#ItemsCart do
		
		if(ItemsCart[i].tag == tag) then
			
			count = count + 1
			
		end
		
	end
	
	
	return count
	
end

function getEntityFromManager(tag)
	local obj = {}
	obj.id = nil
	
	
	local enti = cyberscript.EntityManager[tag]
	if(enti ~= nil) then
		obj = enti
	end
	
	
	
	
	if(tag == "lookatentity" or tag == "last_spawned") then
		
		
		
		
		
		local enti = cyberscript.EntityManager[cyberscript.EntityManager[tag].tag]
		
		if(enti ~= nil) then
			
			obj = enti
			
		end	
		
		
		
		
		
	end
	
	if(tag == "mounted_vehicle" ) then
		
		if Game['GetMountedVehicle;GameObject'](Game.GetPlayer()) ~= nil then
			
			
			
			
			local enti = cyberscript.EntityManager["mounted_vehicle"]
			if (enti ~= nil) and type(enti.id) ~= "number" then
				
				if(enti.id ~= nil and enti.id.hash == Game['GetMountedVehicle;GameObject'](Game.GetPlayer()):GetEntityID().hash) then
					obj = enti
				end
				
			end	
			
			
			if(obj.id == nil) then
				obj.id = Game['GetMountedVehicle;GameObject'](Game.GetPlayer()):GetEntityID()
				obj.tag = "mounted_vehicle"
				obj.tweak = nil
				else
				--		obj.tag = "lookat"
			end
			
		end
	end
	
	
	
	return obj
end

function getTrueEntityFromManager(tag)
	
	
	
	local enti = cyberscript.EntityManager[tag]
	if(tag == "lookatentity") then
		
	
	
	
	
		local enti = cyberscript.EntityManager[cyberscript.EntityManager["lookatEntity"].tag]
		
		if(enti ~= nil) then
			
				return enti
			
		end	
		
		
		
	
	
	end
	
	if((enti ~= nil) and enti.tag == tag) then
		return enti
	end
	
	
	
	
end

function setEntityFromManager(tag,obju)
	
	
	
	
	cyberscript.EntityManager[tag] = obju
	
	
	
	
	
	
end

function getExpression(name)
	
	for i = 1, #reactionlist do
		
		local enti = reactionlist[i]
		if(enti.name == name) then
			return enti
		end
		
		
	end
	
end

function getEntityFromManagerById(Id)
	local obj = {}
	obj.id = nil
	for k,v in pairs(cyberscript.EntityManager) do
		
		local enti = v
		
		
		
		if type(enti.id) ~= "number" then
			
			if(enti.id ~= nil and Id ~= nil and enti.id.hash == Id.hash) then
				obj = v
				
				
			end
			
		end
		
		
		
		
		
	end
	return obj
	
end


function getScannerdataFromEntityOrGroupOfEntity(entity)
	
	if (ScannerInfoManager[entity.tag] ~= nil) then
		return ScannerInfoManager[entity.tag]
		
		else
		local group= getEntityGroupfromEntityTag(entity.tag)
		if group ~= nil then
			
			if (ScannerInfoManager[group.tag] ~= nil) then
				return ScannerInfoManager[group.tag]
			end
		end
		
	end
	
	return nil
	
	
end

function getGroupfromManager(tag)
	
	
	
	return cyberscript.GroupManager[tag]
	
	
end

function getEntityGroupfromEntityTag(tag)
	local goodgroup = nil
	
	for k,v in pairs(cyberscript.GroupManager)do
		
		local group = v
		if(#group.entities > 0) then
			
			for y=1,#group.entities do
				
				local entity = group.entities[y]
				
				if(entity == tag) then
					goodgroup = group
				end
				
				
				
			end
		end
	end
	
	return goodgroup
end

function getEntityIndexIntoGroup(grouptag, tag)
	local group = getGroupfromManager(grouptag)
	local index = nil
	for i, v in ipairs (group) do 
		if (v == tag) then
			index = i 
		end
	end
	return index
end



function getCustomNPCbyTag(tag)
	
	
	
	if (arrayCustomNPC[tag] ~= nil) then
		
		return arrayCustomNPC[tag].npc
		
	end
	
	
	
	return nil
	
end

function getInkWidget(tag)
	
	
	for k, interface in pairs(currentInterfaceWidget) do
		
		for i,control in ipairs(interface.controls) do
			
			if(control.tag == tag) then
				
				return control
				
			end
			
		end
		
		
	end
	
end

function getInkWidgetControl(uitag,tag)
	
	
	if(currentInterfaceWidget[uitag] ~= nil) then
		
		for i,control in ipairs(currentInterfaceWidget[uitag].controls) do
			
			if(control.tag == tag) then
				
				return control
				
			end
			
		end
		
	end
	
	
end

function GetInterfaceChildren(interface,tag)
	
	
	
	
	for i,control in ipairs(interface.controls) do
		
		if(control.tag == tag) then
			
			return control
			
		end
		
	end
	
	
	
	
end


function RemoveInterfaceChildren(interface,tag)
	
	
	
	
	for i,control in ipairs(interface.controls) do
		
		if(control.tag == tag) then
			
			control = nil
			
		end
		
	end
	
	
	
	
end

function getCustomAction(house,roomTypeId)
	
	
	for i=1, #arrayPlaceInteract do 
		if(has_value(arrayPlaceInteract[i].place,house.type)) then
			
			if(arrayPlaceInteract[i].type == roomTypeId) then
				
				if(arrayPlaceInteract[i].placetag ~= "")then
					
					
					customActionUI(arrayPlaceInteract[i])
					
					
					else
					if(arrayPlaceInteract[i].placeTag == house.tag)then 
						
						customActionUI(arrayPlaceInteract[i])
						
					end
				end
				
				
			end
			
			
		end
		
	end
end

function getHouseByTag(tag)
	
	return arrayHouse[tag].house
end

function getRoomByTag(tag, housetag)
	
	for i=1,#arrayHouse[housetag].house.rooms do
		
		if(arrayHouse[housetag].house.rooms[i].tag == tag) then
			return arrayHouse[housetag].house.rooms[i]
		end
	end
	return nil
end

function getHouseStatut(houseTag)
	
	
	return getScoreKey(houseTag,"Statut")
	
	
end

function getHouseProperties(houseTag)
	
	
	return getScore(houseTag)
	
	
	
end

function getNPCById(npcId)
	
	for i=1, #arrayPnjDb do
		
		if arrayPnjDb[i].ID == npcId then
			
			
			
			return arrayPnjDb[i]
		end
		
	end
end

function getNPCByTweakId(tweak)
	
	for i=1, #arrayPnjDb do
		
		if arrayPnjDb[i].TweakIDs == tweak then
			
			
			
			return arrayPnjDb[i]
		end
		
	end
end

function getNPCByName(name)
	
	for i=1, #arrayPnjDb do
		
		if arrayPnjDb[i].Names == name then
			
			
			
			return arrayPnjDb[i]
		end
		
	end
end

function getPhonedNPCByName(name)
	
	for i=1, #arrayPhoneNPC do
		
		if arrayPhoneNPC[i].Names == name then
			
			
			
			return arrayPhoneNPC[i]
		end
		
	end
end

function findPhonedNPCByName(name)
	debugPrint(4,#arrayPhoneNPC)
	for i=1, #arrayPhoneNPC do
		
		if string.find(string.lower(name),string.lower(arrayPhoneNPC[i].Names) ) then
			
			
			
			return arrayPhoneNPC[i]
		end
		
	end
end

function getPhonedNPCByTweakDBId(tweak)
	
	for i=1, #arrayPhoneNPC do
		
		if arrayPhoneNPC[i].TweakIDs == tweak then
			
			
			
			return arrayPhoneNPC[i]
		end
		
	end
end

function getFixerByTag(tag)
	
	
	
	if arrayFixer[tag] ~= nil then
		
		local fixer = arrayFixer[tag].fixer
		checkContext(fixer)
		
		
		
		return fixer
	end
	
	return nil
end

function getSoundByName(name)
	
	for k,v in pairs(arraySound) do
		
		if v.sound.name == name then
			
			
			
			return v.sound
		end
		
	end
	
	return nil
end

function getLang(text)
	
	if(lang[text] ~= nil and lang[text] ~= "" )then
	    
		return lang[text]	
	end	
	
	return text
	
end

function getCustomScorebyTag(tag)
	
	return getScore(tag)
	
end

function getPlayerItemsbyTag(tag)
	
	for i=1,#currentSave.arrayPlayerItems do
		if(currentSave.arrayPlayerItems[i].Tag == tag) then
			return currentSave.arrayPlayerItems[i]
		end
	end
	
end



function getSoundByNameNamespace(name,namespace)
	
	for k,v in pairs(arraySound) do
		
		if k == name and v.sound.namespace == namespace then
			
			debugPrint(4,"sound founded")
			
			return v.sound
		end
		
	end
	
	return nil
end

function GetSoundSettingValue(volumTag)
	
	local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", volumTag)
	return SfxVolume:GetValue()
end

function getHelpByTag(tag)
	for i=1, #arrayHelp do
		
		if arrayHelp[i].tag == tag then
			return arrayHelp[i].help
		end
	end
	return
end


function getTextureByTag(tag)
	
	
	
	if arrayTexture[tag] ~= nil then
		
		
		
		return arrayTexture[tag].texture
	end
	
	return nil
end