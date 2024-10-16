

function BaseWorldMapMappinController_SelectMappin(self)
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	
	GameController["BaseWorldMapMappinController"]  = self
	if(self.mappin ~= nil and self:IsTracked() == true ) then
		
		if lastId ~= nil then Game.GetMappinSystem():SetMappinActive(lastId,true) end
		SelectedMappinMetro = nil
		SelectedScriptMappin = nil
		SelectedMappinHouse = nil
		ActivecustomMappin = nil
		local mappinType = self.mappin:GetVariant()
		local wordpos = self.mappin:GetWorldPosition()
		
		
		
		
		local obj = {}
		obj.id = 0
		obj.tag = "selected_mappin"
		obj.position = self.mappin:GetWorldPosition()
		obj.variant = tostring(mappinType)
		obj.wall =  true
		obj.range = 0
		obj.active =  true
		obj.title = ""
		obj.desc = ""
		obj.style = {}
		obj.style.color = nil
		obj.style.icon = nil
		
		
		if(mappinManager["selected_mappin"] == nil or (mappinManager["selected_mappin"]~= nil and mappinManager["selected_mappin"].position ~= self.mappin:GetWorldPosition())) then
			mappinManager["selected_mappin"] = obj
			
			--print(dump(mappinManager["selected_mappin"].position))
			
		end
		if mappinType == gamedataMappinVariant.CustomPositionVariant then
			
			ActivecustomMappin = self.mappin
			
			local obj = {}
			obj.id = 0
			obj.tag = "selected_user_mappin"
			obj.position = self.mappin:GetWorldPosition()
			obj.variant = tostring(mappinType)
			obj.wall =  true
			obj.range = 0
			obj.active =  true
			obj.title = ""
			obj.desc = ""
			obj.style = {}
			obj.style.color = nil
			obj.style.icon = nil
			
			
			
			mappinManager["selected_user_mappin"] = obj
			
		end
		
		
		if mappinType == gamedataMappinVariant.FastTravelVariant then
			ActiveFastTravelMappin = {}
			
			ActiveFastTravelMappin.markerRef = self.mappin:GetPointData():GetMarkerRef()
			ActiveFastTravelMappin.position = self.mappin:GetWorldPosition()
			
			local obj = {}
			obj.id = 0
			obj.tag = "selected_fasttravel_mappin"
			obj.position = self.mappin:GetWorldPosition()
			obj.variant =  "FastTravelVariant"
			obj.wall =  true
			obj.range = 0
			obj.active =  true
			obj.title = ""
			obj.desc = ""
			obj.style = {}
			obj.style.color = nil
			obj.style.icon = nil
			
			
			
			mappinManager["selected_fasttravel_mappin"] = obj
			
		end
		if(
			mappinType == gamedataMappinVariant.ApartmentVariant or
			mappinType == gamedataMappinVariant.Zzz05_ApartmentToPurchaseVariant or
			mappinType == gamedataMappinVariant.ServicePointFoodVariant or
			mappinType == gamedataMappinVariant.ServicePointBarVariant or
		mappinType == gamedataMappinVariant.ServicePointJunkVariant) then
		local haveFounded = false
		-- local test = {}
		
		-- table.insert(test,cyberscript.cache["place"]["playerhouse01"])
		for _,v in pairs(cyberscript.cache["place"]) do 
			if(math.floor(v.data.x) == math.floor(wordpos.x) and math.floor(v.data.y) == math.floor(wordpos.y) and math.floor(v.data.z) == math.floor(wordpos.z)) then
				SelectedMappinHouse = v.data
				haveFounded = true
			end
		end
		else
		if(mappinType == gamedataMappinVariant.Zzz01_CarForPurchaseVariant) then
			--logme(2,"Metro ?")
			
			local haveFounded = false
			for k,v in pairs(cyberscript.cache["node"]) do 
				local mappin = v.data
				if(mappin.sort == "metro") then
					if(math.floor(mappin.GameplayX) == math.floor(wordpos.x) and math.floor(mappin.GameplayY) == math.floor(wordpos.y) and math.floor(mappin.GameplayZ) == math.floor(wordpos.z)) then
						SelectedMappinMetro = mappin
						haveFounded = true
						--logme(2,"Mine")
						break
					end
				end
			end
			else
			
			local haveFounded = false
			
			for k,v in pairs(mappinManager) do 
				local mappin = v
				
				if(k ~= "selected_mappin" and k ~= "selected_fasttravel_mappin" and mappin.position ~= nil and math.floor(mappin.position.x) == math.floor(wordpos.x) and math.floor(mappin.position.y) == math.floor(wordpos.y) and math.floor(mappin.position.z) == math.floor(wordpos.z)) then
					
					
					SelectedScriptMappin = mappin
					break
				end
			end
		end
		end
	
		else
		
		
		if(self.mappin ~= nil) then
			local wordpos = self.mappin:GetWorldPosition()
		
		
			
			for k,v in pairs(mappinManager) do 
				local mappin = v
				
				if(k ~= "selected_mappin" and k ~= "selected_fasttravel_mappin" and mappin.position ~= nil and math.floor(mappin.position.x) == math.floor(wordpos.x) and math.floor(mappin.position.y) == math.floor(wordpos.y) and math.floor(mappin.position.z) == math.floor(wordpos.z)) then
					--print(k)
					
					SelectedScriptMappin = mappin
					break
				end
			end
		
		end
	
	end
end


function WorldMapTooltipController_SetData(self,data,menu)
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	local mappinVariant = nil
	
	if(data ~= nil) then
		if( data.mappin ~= nil) then
			
			mappinVariant = data.mappin:GetVariant()
			
		end
		
		if mappinVariant ~= nil and mappinVariant == gamedataMappinVariant.FixerVariant and fixeroldText == nil then fixeroldText = self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):GetText() end
		
		
		if(SelectedScriptMappin ~= nil) then
			
			if(mappinVariant ~= nil and mappinVariant == gamedataMappinVariant.FixerVariant and SelectedScriptMappin.tag ~= nil) then
				
				local fixer = getFixerByTag(SelectedScriptMappin.tag)
				if(fixer ~= nil) then
					-- self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):SetVisible(true)
					-- self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(1):SetVisible(true)
					
					-- self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(2):SetVisible(false)
					-- self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(3):SetVisible(false)
					
					self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):SetText("Cyberscript Fixer")
					
					inkTextRef.SetText(self.gigBarCompletedText, "100")
					inkTextRef.SetText(self.gigBarTotalText, "100")
					self.gigProgress = 1
					
					
					inkWidgetRef.SetVisible(self.fixerPanel, true)
					inkImageRef.SetVisible(self.icon, false)
					
					self.descText:SetText("")
					
					self:PlayAnim("OnTooltipIntro", "OnFixerProgressBarAnim");
					else
					
				end
				else
				inkImageRef.SetVisible(self.icon, true)
				self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):SetText(fixeroldText)
				
			end
			else
			if(mappinVariant ~= nil and mappinVariant == gamedataMappinVariant.FixerVariant) then self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):SetText(fixeroldText) end
			inkWidgetRef.SetVisible(self.icon, true)
		end
		
	end
end

function WorldMapTooltipContainer_SetData(self,target,data,menu)
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	local displayXYZ = getUserSetting("displayXYZ")
	local mappinVariant = nil
	
	if( data.mappin ~= nil) then
		
		mappinVariant = data.mappin:GetVariant()
		
	end
	
	if(SelectedMappinHouse ~= nil or SelectedMappinMetro ~= nil or SelectedScriptMappin ~= nil) then
		inkWidgetRef.SetVisible(self.defaultTooltipController.descText, true)
		if(SelectedMappinHouse ~= nil) then
			inkTextRef.SetText(self.defaultTooltipController.titleText, SelectedMappinHouse.name)
			local desc = getLang("bebought")..tostring(SelectedMappinHouse.isbuyable)
			desc = desc.."\n"..getLang("price")..tostring(SelectedMappinHouse.price)
			desc = desc.."\n"..getLang("canhavebusiness")..tostring(SelectedMappinHouse.isrentable)
			desc = desc.."\n"..getLang("defaultsalary")..tostring(SelectedMappinHouse.rent)
			desc = desc.."\n"..getLang("prestige")..tostring(SelectedMappinHouse.coef)
			local position = ActivecustomMappin:GetWorldPosition()
			local postext = "\n X :"..math.floor(position.x).." \n Y: "..math.floor(position.y).." \n Z: "..math.floor(position.z)
			if(displayXYZ ~= nil and displayXYZ == 1) then
				inkTextRef.SetText(self.defaultTooltipController.descText, desc..postext)
				else
				inkTextRef.SetText(self.defaultTooltipController.descText, desc)
			end
			SelectedMappinHouse = nil
			elseif(SelectedMappinMetro ~= nil) then
			inkTextRef.SetText(self.titleText, getLang("metro_station")..SelectedMappinMetro.name)
			local desc = getLang("metro_available")
			local position = ActivecustomMappin:GetWorldPosition()
			local postext = "\n X :"..math.floor(position.x).." \n Y: "..math.floor(position.y).." \n Z: "..math.floor(position.z)
			if(displayXYZ ~= nil and displayXYZ == 1) then
				inkTextRef.SetText(self.defaultTooltipController.descText, desc..postext)
				else
				inkTextRef.SetText(self.defaultTooltipController.descText, desc)
			end
			SelectedMappinMetro = nil
			elseif(SelectedScriptMappin ~= nil) then
			
			inkTextRef.SetText(self.defaultTooltipController.titleText, getLang(SelectedScriptMappin.title))
			inkTextRef.SetText(self.defaultTooltipController.descText, SelectedScriptMappin.desc)
			if(ActivecustomMappin ~= nil) then
				if(displayXYZ ~= nil and displayXYZ == 1) then
					local position = ActivecustomMappin:GetWorldPosition()
					local postext = "\n X :"..math.floor(position.x).." \n Y: "..math.floor(position.y).." \n Z: "..math.floor(position.z)
					
					inkTextRef.SetText(self.defaultTooltipController.descText, getLang(SelectedScriptMappin.desc)..postext)
					else
					inkTextRef.SetText(self.defaultTooltipController.descText, getLang(SelectedScriptMappin.desc))
				end
			end
			SelectedScriptMappin = nil
		end
		else
		if(ActivecustomMappin ~= nil) then
			local position = ActivecustomMappin:GetWorldPosition()
			local postext = "\n X :"..math.floor(position.x).." \n Y: "..math.floor(position.y).." \n Z: "..math.floor(position.z)
			if(displayXYZ ~= nil and displayXYZ == 1) then
				inkWidgetRef.SetVisible(self.defaultTooltipController.descText, true)
				inkTextRef.SetText(self.defaultTooltipController.descText,  self.defaultTooltipController.descText:GetText()..postext)
			end
		end
	end
end

function WorldMapMenuGameController_UntrackCustomPositionMappin(self)
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	ActivecustomMappin = nil
	--logme(2,"obs3")
end


