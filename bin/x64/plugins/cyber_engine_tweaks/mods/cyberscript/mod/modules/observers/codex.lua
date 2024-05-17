

function CodexGameController_PopulateData(thos)
	if(observerthread4  == true or moddisabled == true)    then return end
	if(thos.f_sortOrder ~= nil or thos.sortOrder ~= nil) then
		
		logme(10,"flib sort mod is enabled, custom codex is disabled")
		else
		
		
		local counter = 0
		local groupData
		local groupVirtualListData
		local i
		local items
		local level
		local success = false
		local newEntries
		local tagsFilter = {}
		local toti = {}
		local data = CodexUtils.GetCodexDataArray(thos.journalManager,thos.activeData)
		
		
		local totalcount = 0
		
		
		local datatemp = CodexUtils.GetCodexDataArray(thos.journalManager,thos.activeData)
		table.insert(tagsFilter, CName("HideInBackpackUI"))
		
		counter = 0
		level = #data+1
		
		i = 1
		
		
		local textAffinity = "Affinity"
		
		for k,v in pairs(cyberscript.entitieshash) do
			
			local score = getScoreKey("Affinity",v.entity_name) 
			if score ~= nil and score > 1 then
				textAffinity = textAffinity.."\n "..v.entity_name.." : "..score
			end
			
			
		end
		
		
		local test = data
		local shardData =  CodexEntryData.new()
		
		shardData.description = textAffinity
		shardData.title = "CS Affinity : NPC"
		shardData.activeDataSync = thos.activeData
		shardData.counter = counter
		shardData.category =4
		shardData.imageType = 0
		shardData.isNew = true
		shardData.hash = 8888888+math.random(1,9999999)
		shardData.activeDataSync = thos.activeData
		table.insert(shardData.newEntries, shardData.hash)
		
		local shardVirtualListData = VirutalNestedListData.new()
		shardVirtualListData.level = -1
		shardVirtualListData.widgetType = 0
		shardVirtualListData.isHeader = false
		shardVirtualListData.data = shardData
		table.insert(data, shardVirtualListData)
		totalcount = totalcount +1
		
		
		textAffinity = "Gang Affinity"
		for k,v in pairs(cyberscript.cache["faction"]) do
			local score =getScoreKey("Affinity",k)
			if score ~= nil then
				textAffinity = textAffinity.."\n "..cyberscript.cache["faction"][k].data.name.." : "..score
			end
		end
		
		test = data
		shardData =  CodexEntryData.new()
		
		shardData.description = textAffinity
		shardData.title = "CS Affinity : Gang"
		shardData.activeDataSync = thos.activeData
		shardData.counter = counter
		shardData.category =4
		shardData.imageType = 0
		shardData.isNew = true
		shardData.hash = 8888888+math.random(1,9999999)
		shardData.activeDataSync = thos.activeData
		table.insert(shardData.newEntries, shardData.hash)
		
		local shardVirtualListData = VirutalNestedListData.new()
		shardVirtualListData.level = -1
		shardVirtualListData.widgetType = 0
		shardVirtualListData.isHeader = false
		shardVirtualListData.data = shardData
		table.insert(data, shardVirtualListData)
		totalcount = totalcount +1
		
		
		for k,v in pairs(cyberscript.cache["help"]) do
			local codex = v.data
			local description = ""
			for i,section in ipairs(codex.section) do
				if(section.message ~= nil) then
					description = description..section.message.."\n\n\n"
					else
					description = description..section.."\n\n\n"
				end
			end
			
			local shardData =  CodexEntryData.new()
			shardData.title = "CS Wiki : "..codex.title
			shardData.description = description
			shardData.activeDataSync = thos.activeData
			shardData.counter = counter
			shardData.category =4
			shardData.imageType = 0
			shardData.isNew = true
			
			shardData.hash = 13081991+math.random(1,9999999)
			shardData.activeDataSync = thos.activeData
			
			table.insert(shardData.newEntries, shardData.hash)
			
			local shardVirtualListData = VirutalNestedListData.new()
			shardVirtualListData.level = -1
			shardVirtualListData.widgetType = 0
			shardVirtualListData.isHeader = false
			shardVirtualListData.data = shardData
			table.insert(data, shardVirtualListData)
			totalcount = totalcount +1
			
		end
		
		
		for k,v in pairs(cyberscript.cache["codex"]) do
			local codex = v.data
			if((getScoreKey(codex.tag,"Score") == nil and codex.locked == false) or getScoreKey(codex.tag,"Score") == 0) then
				
				local shardData =  CodexEntryData.new()
				shardData.title = "CS : "..codex.title
				shardData.description = codex.description
				shardData.activeDataSync = thos.activeData
				shardData.counter = counter
				shardData.category =4
				shardData.imageType = 0
				shardData.isNew = false
				
				shardData.hash = 13081992+math.random(1,9999999)
				shardData.activeDataSync = thos.activeData
				
				table.insert(shardData.newEntries, shardData.hash)
				
				local shardVirtualListData = VirutalNestedListData.new()
				shardVirtualListData.level = -1
				shardVirtualListData.widgetType = 0
				shardVirtualListData.isHeader = false
				shardVirtualListData.data = shardData
				table.insert(data, shardVirtualListData)
				totalcount = totalcount +1
			end
		end
		
		
		groupData = CodexEntryData.new()
		groupData.category =4
		groupData.imageType = 0
		groupData.title = "CyberScript"
		groupData.activeDataSync = thos.activeData
		groupData.counter = totalcount
		groupData.isNew =  false
		groupData.newEntries = {}
		
		groupVirtualListData = VirutalNestedListData.new()
		groupVirtualListData.level = -1
		groupVirtualListData.widgetType = 1
		groupVirtualListData.isHeader = true
		groupVirtualListData.data = groupData
		groupVirtualListData.forceToTopWithinLevel  = true
		table.insert(data, groupVirtualListData)
		
		
		if #data <= 0 then
			thos:ShowNodataWarning()
			else 
			thos:HideNodataWarning()
			thos.listController:SetData(data)
		end
	end
	
end


function ShardsMenuGameController_PopulateData(thos,data, keepToggledLevels, sortOnce)
	
	if(observerthread4  == true or moddisabled == true)    then return end
	
	
	local count = 0
	
	local test = deepcopy(data,nil)
	
	
	for k,v in pairs(cyberscript.cache["shard"]) do
		
		local shard = v.data
		checkContext(shard)
		
		
		if((getScoreKey(shard.tag,"Score") == nil and shard.locked == false) or getScoreKey(shard.tag,"Score") == 0) then
			count = count + 1
			
			local shardData =  ShardEntryData.new()
			shardData.title = shard.title
			shardData.description = shard.description
			
			
			shardData.isNew = shard.new
			shardData.hash = (math.random(1,9999999)+1308202029)
			shardData.isCrypted = shard.crypted
			
			shardData.counter =  data[1].data.counter
			shardData.timeStamp  =  data[1].data.timeStamp 
			shardData.newEntries   = {}
			shardData.imageId = data[1].data.imageId
			shardData.activeDataSync = data[1].data.activeDataSync
			shardData.itemID = data[1].data.itemID
			table.insert(shardData.newEntries, shardData.hash)
			
			
			
			local shardVirtualListData = VirutalNestedListData.new()
			shardVirtualListData.level = 999999
			shardVirtualListData.collapsable = false
			shardVirtualListData.forceToTopWithinLevel = false
			shardVirtualListData.widgetType = 0
			shardVirtualListData.isHeader = false
			shardVirtualListData.data = shardData
			table.insert(test, shardVirtualListData)
			
		end
	end
	
	if(count > 0) then
		
		
		local groupData = ShardEntryData.new()
		groupData.title = "CyberScript"
		groupData.isNew = false
		groupData.hash = 1308202299
		groupData.isCrypted = false
		groupData.newEntries   = {}
		groupData.counter =  1
		
		
		groupData.timeStamp  =  data[1].data.timeStamp 
		
		groupData.imageId = data[15].data.imageId
		groupData.activeDataSync = data[15].data.activeDataSync
		groupData.itemID = data[15].data.itemID
		
		local groupVirtualListData = VirutalNestedListData.new()		
		
		groupVirtualListData.collapsable = false
		groupVirtualListData.isHeader = true
		groupVirtualListData.level = 999999
		groupVirtualListData.forceToTopWithinLevel = false
		groupVirtualListData.widgetType = 1
		groupVirtualListData.data = groupData
		table.insert(test, groupVirtualListData)
		data = test
		
		local castedData = test
		
		if not keepToggledLevels then
			thos.toggledLevels = {}
		end
		
		thos.dataSource:Reset(castedData)
		--thos.dataView:SetToggledLevels(thos.toggledLevels, thos.defaultCollapsed) this line break missingperson ?!
		thos:EnableSorting()
		
		if sortOnce then
			thos:DisableSorting()
		end
		
		
	end
	
	
	
	
	
	
	
end


function ShardNotificationController_OnInitialize(self)
	if(observerthread5 == true or moddisabled  == true)   then return end
	GameController["ShardNotificationController"]  = self
end

function ShardNotificationController_OnPlayerAttach(self,playerPuppet)
	if(observerthread5 == true or moddisabled  == true)   then return end
	GameController["ShardNotificationController"]  = self
end

function ShardNotificationController_SetButtonHints(self)
	if(observerthread5 == true or moddisabled  == true)   then return end
	if not UIPopupsManager.IsOwnPopup(self) then
		return
	end
	
	GameController["ShardNotificationController"]  = self
	if(currentInterface ~= nil and (currentInterface.type == nil or currentInterface.type == "popup")) then
		
		
		local titleIcon = self:GetRootWidget():GetWidgetByPathName(StringToName('container/Panel/vertical_organizer/topBar/icon'))
		
		titleIcon:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\fullscreen\\hub_menu\\hub_atlas.inkatlas'))
		titleIcon:SetTexturePart('ico_journal')
		inkTextRef.SetText(self.titleRef, getLang(currentInterface.title))
		titleIcon:SetTintColor(inkWidgetRef.GetTintColor(self.titleRef))
		local contentArea = self:GetRootWidget():GetWidgetByPathName(StringToName('container/Panel/vertical_organizer/contentArea'))
		
		makeCustomInterface(contentArea,currentInterface)
	end
	
	
end

function ShardNotificationController_Close(self)
	if(observerthread5 == true or moddisabled  == true)   then return end
	buttonsData = {}
	if UIPopupsManager.IsOwnPopup(self) then
		UIPopupsManager.ClosePopup()
	end
end


function CodexPopupGameController_SetupData(thos,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod() end
	thos.data = thos:GetRootWidget():GetUserData("CodexPopupData")
	--print(GameDump(thos:GetRootWidget()))
	if string.match(thos.data.entry.id,"CS_customcodex:") then
		
		local splittext = split(thos.data.entry.id,':')
		
		
		local codex = cyberscript.cache["codex"][splittext[2]].data
		
		
		
		local codexEntryData = GenericCodexEntryData.new()
		codexEntryData.title = codex.tag
		codexEntryData.description = codex.description
		codexEntryData.hash = 13081991
		
		
		
		
		thos.entryViewController:ShowEntry(codexEntryData)
		inkWidgetRef.SetVisible(thos.entryViewRef, true)
		inkWidgetRef.SetVisible(thos.characterEntryViewRef, false)
		inkWidgetRef.SetVisible(thos.imageViewRef, false)
		
		
		else
		
		wrappedMethod()
		
		
	end
	
end


function CodexEntryViewController_ShowEntry(thos,data, inputDevice, inputScheme,wrappedMethod)
	
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod() end
	if data.hash == 13081991 then
		
		local codex = cyberscript.cache["codex"][data.title].data
		
		checkContext(codex)
		
		
		thos.scroll = inkWidgetRef.GetControllerByType(thos.scrollWidget, "inkScrollController")
		thos.scroll:SetScrollPosition(0.00);
		inkTextRef.SetText(thos.descriptionText, codex.description)
		inkTextRef.SetText(thos.titleText, codex.title)
		inkWidgetRef.SetVisible(thos.imageWidget, false)
		inkWidgetRef.SetVisible(thos.imageWidgetWrapper, false)
		inkWidgetRef.SetVisible(thos.noEntrySelectedWidget, false)
		inkWidgetRef.SetVisible(thos.contentWrapper, true)
		
		else
		
		wrappedMethod(data, inputDevice, inputScheme)
		
		
	end
	
end
