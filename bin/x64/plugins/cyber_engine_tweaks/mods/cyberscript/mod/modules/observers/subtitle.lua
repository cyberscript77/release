




function interactionItemLogicController_SetData(self,data,skillcheck)
	if(observerthread4 == true or moddisabled  == true)  then return  end
	if(cyberscript.cache["interact"][data.localizedName] ~= nil) then
		local interact = cyberscript.cache["interact"][data.localizedName].data
		
		
		self.label:SetText(getLang(interact.name))
		
		
		if(interact	 ~= nil) then
			
			
			if(	interact.style ~= nil) then
				local fontcolor = interact.style.textcolor
				
				if(fontcolor ~= nil) then
					self.label.widget:SetTintColor(gamecolorStyle(fontcolor))
				end
				
				local bgcolor = interact.style.bgcolor
				
				if(bgcolor ~= nil) then
					
					self.QuickHackHolder.widget:GetWidgetByIndex(0):GetWidgetByIndex(1):SetTintColor(gamecolorStyle(bgcolor))
					
				end
				
				local iconcolor = interact.style.iconcolor
				if(iconcolor ~= nil) then
					self.QuickHackIcon:SetTintColor(gamecolorStyle(iconcolor))
				end
				
			end
			
		end
		
	end
end

function DialogChoiceLogicController_UpdateView(self,wrappedMethod)
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	if(currentDialogHub ~= nil and self.ActiveTextRef ~= nil) then
		
		local isphoneDialog = true
		
		local dialogoption = currentDialogHub.dial.options[interactionUI.selectedIndex+1]
		
		if(dialogoption ~= nil and 
			(getLang(dialogoption.description) ==  "["..self.tagWrapper.widget:GetWidgetByIndex(0):GetText().."]" 
			or getLang(dialogoption.description) ==  self.ActiveTextRef.widget:GetText())) then
			
			
			self.ActiveTextRef.widget:SetTintColor(gamecolor(0, 0, 0,1))
			self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(gamecolor(0, 0, 0,1))
			
			if (dialogoption.requirement ~= nil and checkTriggerRequirement(dialogoption.requirement,dialogoption.trigger) == false) then
				self.ActiveTextRef.widget:SetTintColor(gamecolor(237, 124, 109,1))
				self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(gamecolor(237, 124, 109,1))
				
				self.SelectedBg:SetTintColor(gamecolor(255, 86, 64,0))
				else
				
				if not (dialogoption.style == nil or dialogoption.style.color == nil  or dialogoption.style.color.red == nil or dialogoption.style.color.green == nil or dialogoption.style.color.blue == nil) then
					
					
					local fontcolor = dialogoption.style.color
					
					self.SelectedBg:SetTintColor(gamecolorStyle(fontcolor))
					
					
					
				end
			end
			
			
			
			
			
			
		end
		
		local dialogoption_unselect = nil
		
		
		for i,v in ipairs(currentDialogHub.dial.options) do
			
			if((getLang(v.description) ==  "["..self.tagWrapper.widget:GetWidgetByIndex(0):GetText().."]" or getLang(v.description) ==  self.ActiveTextRef.widget:GetText()) and getLang(v.description) ~=  getLang(currentDialogHub.dial.options[interactionUI.selectedIndex+1].description)) then
				
				dialogoption_unselect = v
				
				
				if (dialogoption_unselect ~= nil and dialogoption_unselect.requirement ~= nil and checkTriggerRequirement(dialogoption_unselect.requirement,dialogoption_unselect.trigger) == false)then
					
					
					pcall(function()
						
						self.ActiveTextRef.widget:SetTintColor(gamecolor(237, 124, 109,1))
						self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(gamecolor(237, 124, 109,1))
						
						
					end)
					else
					
					if (dialogoption_unselect ~= nil and dialogoption_unselect.style ~= nil and dialogoption_unselect.style.color ~= nil  and dialogoption_unselect.style.color.red ~= nil and dialogoption_unselect.style.color.green ~= nil and dialogoption_unselect.style.color.blue ~= nil) then
						
						local fontcolor = dialogoption_unselect.style.color
						
						self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(gamecolorStyle(fontcolor))
						self.ActiveTextRef.widget:SetTintColor(gamecolorStyle(fontcolor))
						
						else
						
						self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(HDRColor.new({ Red=0.368627, Green=0.964706, Blue=1.000000, Alpha=1.000000 }))
						
						
						self.ActiveTextRef.widget:SetTintColor(HDRColor.new({ Red=0.368627, Green=0.964706, Blue=1.000000, Alpha=1.000000 }))
						
					end
					
					
				end
				
			end
			
			
		end
		
		
		
		
		
		
		
		
		
		
		
		
		else
		
		return wrappedMethod()
	end
end
