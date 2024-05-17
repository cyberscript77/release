
function BaseMappinBaseController_UpdateRootState(this)
	if(observerthread2  == true or moddisabled == true)    then return end
	local wordpos = this:GetMappin():GetWorldPosition()
	for k,v in pairs(mappinManager) do 
		local mappin = v
		if(mappin.position ~= nil and math.floor(mappin.position.x) == math.floor(wordpos.x) and math.floor(mappin.position.y) == math.floor(wordpos.y) and math.floor(mappin.position.z) == math.floor(wordpos.z)) then
			
			if(mappin.range ~= 0 and mappin.range ~= nil) then 
				if( check3DPos(curPos, mappin.position.x,  mappin.position.y,  mappin.position.z, mappin.range) ) then
					this:SetRootVisible(true)
					else
					this:SetRootVisible(false)
				end
				
			end
			v.widget = this.iconWidget
			v.controller = this
			v.mappinEntity = this:GetMappin()
			v.distanceToPlayer = getDistance(Game.GetPlayer():GetWorldPosition(), v.position)
			
			if(v.tracked ~= nil) then
				if #this.taggedWidgets > 0 then
					
					
					if this:GetProfile():ShowTrackedIcon() then
						
						
						for i=0, #this.taggedWidgets do
							inkWidgetRef.SetVisible(this.taggedWidgets[i], v.tracked)
							
							
						end
						
						local animPlayer = this:GetAnimPlayer_Tracked()
						animPlayer:PlayOrPause(v.tracked)
					end
					
					
				end
			end
			
			if(mappin.style ~= nil) then
				
				if(mappin.style.icon ~= nil) then
					
					local record = TweakDBInterface.GetUIIconRecord("ChoiceIcons."..mappin.style.icon)
					if(record ~= nil) then
						v.widget:SetTexturePart(record:AtlasPartName())
						v.widget:SetAtlasResource(record:AtlasResourcePath())
					end
					
				end
				
				if(mappin.style.color ~= nil) then
					
					this.iconWidget:SetTintColor(gamecolorStyle(mappin.style.color))
				end
			end
			
			break
		end
	end
end

function MappinBaseController_SetRootVisible(this,mappin, mappinVariant, customData)
	
	if(observerthread4 == true or moddisabled  == true)  then return  end
	local mappinType = mappin:GetVariant()
	local wordpos = mappin:GetWorldPosition()
	
	for _,v in pairs(mappinManager) do 
		local mappin = v
		if(mappin.position ~= nil and math.floor(mappin.position.x) == math.floor(wordpos.x) and math.floor(mappin.position.y) == math.floor(wordpos.y) and math.floor(mappin.position.z) == math.floor(wordpos.z)) then
			v.mappinobj = mappin
			break
		end
	end
	
	return result
	
end
