debugPrint(3,"CyberScript: UI module loaded")
cyberscript.module = cyberscript.module + 1

---Main Function---
function windowsManager() -- manage and toggle UI windows
	
	if draw and  initFinished then--others windows
		ImageFrame()
		if ImGui.BeginPopupModal("locationdesc2", true) then
			ImGui.SetWindowPos(800, 600)
			local DropdownOptions = {"Kill ", "Escort", "Explore", "Ambush", "CustomPlace","Metro"}
			local DropdownSelected = ""
			ImGui.Text("This location file is for : ")
			ImGui.Text(DropdownOptions[currentreason])
			if ImGui.Button("Valid and close") then
				pathtick = 0
				savelocation.isFor = currentreason
				closeSaveLocation()
				ImGui.CloseCurrentPopup()
				saveLocationEnabled = false	
			end
			ImGui.EndPopup()
		end
		
		
		
		
		if(overlayOpen ) then
			
			if debugOptions == true then
				debugWindows()
			end	
			
			
			if file_exists("modules/editor.lua") then
				newWindows()
			end
			
			
			if(openEditor) then
				editorWindows()
				openOption =  false
				if(openEditTrigger) then
					TriggerEditWindows()	
				end
				
				if(openQuestGraph) then
					QuestGraph()	
				end
				
				if(openEditActionTrigger) then
					TriggerActionEditWindows()	
				end
				if(openTriggerItem) then
					SubTriggerEditWindows()	
				end
				if(openControlsEditor) then
					ControlsEditWindows()	
				end
				if openNewTrigger then
					TriggerNewWindows()
				end
				if(openEditAction) then
					ActionEditWindows()	
				end
				if openEditSubAction then
					ActionSubEditWindows()
				end
				if openNewAction then
					ActionNewWindows()
				end
				if openNewRoom then
					RoomNewWindows()
				end
				if openEditRoom then
					RoomEditWindows()
				end
				if(openEditOptions) then
					OptionsEditWindows()	
				end
				if(editor_json_view) then
					openJson()	
				end
				if openNewOptions then
					OptionsNewWindows()
				end
				if openNewObjective then
					ObjectiveNewWindows()
				end
				if openEditObjective then
					ObjectiveEditWindows()
				end
				if openNewConversation then
					ConversationNewWindows()
				end
				if openEditConversation then
					ConversationEditWindows()
				end
				if openNewMessage then
					MessageNewWindows()
				end
				if openEditMessage then
					MessageEditWindows()
				end
				if openNewChoice then
					ChoiceNewWindows()
				end
				if openEditChoice then
					ChoiceEditWindows()
				end
				if openEditItems then
					EditItemsWindows()
				end
				if openNewItems then
					NewItemsWindows()
				end
				if openEditSceneStep then
					SceneStepEditWindows()
				end
				if openNewSceneStep then
					SceneStepNewWindows()
				end
				if openEditHousingTemplate then
					
					EditTemplatePositionWindows()
				end
				
				
			end
			
			if openNetContract then
				ContractWindows()
			end
			
		end
		if(openColorPicker) then
			colorPicker() 
		end
		if((onlineMessagePopup or (ActiveSubMenu == "Phone")) and MultiplayerOn == true) then
			if(onlineReceiver == nil) then
				onlineReceiver = "Instance"
			end
			onlineMessagePopup =  true
			SendMessage()
		end
		if(onlineInstanceCreation) then
			if(CreateInstance.title == nil)then
				CreateInstance.title = ""
				CreateInstance.privacy = 0
				CreateInstance.isreadonly = false
				CreateInstance.nsfw = false
				CreateInstance.password = "nothing"
				defaultprivacy = "Public"
			end
			Multi_InstanceCreate()
		end
		if(onlineGuildCreation) then
			if(CreateGuild.Title == nil)then
				CreateGuild.Title = ""
				CreateGuild.FactionTag = "faction_mox"
			end
			Multi_GuildCreate()
		end		
		if(onlineInstanceUpdate) then
			if(UpdateInstance.title == nil)then
				UpdateInstance.id = CurrentInstance.Id
				UpdateInstance.creationDate = "2022-01-07T14:22:40.710Z"
				UpdateInstance.lastUpdateDate = "2022-01-07T14:22:40.710Z"
				UpdateInstance.title = CurrentInstance.Title
				UpdateInstance.private = 0
				UpdateInstance.readOnly = false
				UpdateInstance.nsfw = false
				UpdateInstance.password = ""
				UpdateInstance.state = 0
				defaultprivacy = "Public"
			end
			Multi_InstanceEdit()
		end
		if(onlineGuildUpdate and currentGuild ~= nil) then
			if(UpdateGuild.Title == nil)then
				
				UpdateGuild.Id = currentGuild.Id
				UpdateGuild.Title = currentGuild.Title
				UpdateGuild.Description = currentGuild.Description
				UpdateGuild.Owner = currentGuild.Owner
				UpdateGuild.FactionTag = currentGuild.FactionTag
				UpdateGuild.LastUpdateDate = currentGuild.LastUpdateDate
				UpdateGuild.CreationDate = currentGuild.CreationDate
				UpdateGuild.Score = currentGuild.Score
			end
			Multi_GuildEdit()
		end		
		
		if(onlineInstancePlaceCreation) then
			Multi_InstanceCreatePlace()
		end
		if(onlineShootMessage) then
			ShootMessage()
		end
		if(multiName ~= "") then
			debugPrint(10,tostring(multiName))
			WhisperMessage()
		end
		
		if isFadeIn then
			fadeinwindows()
		end
		if openEditItemsMulti and selectedItemMulti ~= nil then
			Multi_EditItemsWindows()
		end
		if enableEntitySelection then
			entitySelection()
		end
		if MultiplayerOn then
			MultiNicknameWindows()
		end
		if openInterface then
			WindowsItem()
		end
	end
end

function refreshUIWidget()
	
	if(currentInterfaceWidget ~= nil) then
		
		for k,interface in pairs(currentInterfaceWidget) do 
			for i,control in ipairs(interface.controls) do
				
				
				local leftmargin = 540
				local topmargin = -uimargintop
				local labelcount  = 0
				local havebutton = false
				local buttoncount = 0
				local havetext = false
				local fontsize = uifont
				local width = 400
				local height = 100
				local scalewidth = 0.5
				local scaleheight = 0.5
				local translationheight = 0
				local translationwidth = 0
				local transformheight = 0
				local transformwidth = 0
				local horizontalalign = 1
				local verticalalign = 1
				
				
				
				
				checkContext(control.data)
				
				
				
				-- if(control.data.margin == nil ) then
					-- control.data.margin = {}
				-- end
				-- if(control.data.style == nil ) then
					-- control.data.style = {}
				-- end
				
				local bgcolor = HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 })
				
				local textcolor = HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 })
				
				
				-- if control.data.margin == nil then control.data.margin = {} end
				-- if control.data.childmargin == nil then control.data.childmargin = {} end
				-- if control.data.style == nil then control.data.style = {} end
				-- if control.data.size == nil then control.data.size = {} end
				-- if control.data.scale == nil then control.data.scale = {} end
				-- if control.translation == nil then control.translation = {} end
				-- if control.transform == nil then control.transform = {} end
				 if(control.data.bgcolor ~= nil and control.data.bgcolor.red ~= nil ) then bgcolor = gamecolorStyle(control.data.bgcolor) end
				 if(control.data.textcolor ~= nil and control.data.textcolor.red ~= nil ) then textcolor = gamecolorStyle(control.data.textcolor) end
				
				-- if(control.data.fittocontent == nil) then control.data.fittocontent = true end
				-- if(control.data.opacity == nil) then control.data.opacity = 1 end
				-- if(control.data.rotation == nil) then control.data.rotation = 0 end
				-- if(control.data.interactive == nil) then control.data.interactive = false end
				
				-- if(control.data.event == nil) then control.data.event = {} end
				
				
				-- if(control.data.horizontalalign == nil) then control.data.horizontalalign = 1 end
				-- if(control.data.anchor == nil) then control.data.anchor = 15 end
				-- if(control.data.verticalalign == nil) then control.data.verticalalign = 1 end
				 if(control.data.style.fontsize ~= nil and control.data.style.fontsize ~= "") then fontsize = control.data.style.fontsize end
				 if(control.data.size.width ~= nil and control.data.size.width ~= "") then width = control.data.size.width end
				 if(control.data.size.height ~= nil and control.data.size.height ~= "") then height = control.data.size.height end
				 if(control.data.scale.height ~= nil and control.data.scale.height ~= "") then scaleheight = control.data.scale.height end
				 if(control.data.scale.width ~= nil and control.data.scale.width ~= "") then scalewidth = control.data.scale.width end
				
				 if(control.data.translation.height ~= nil and control.data.translation.height ~= "") then translationheight = control.data.translation.height end
				 if(control.data.translation.width ~= nil and control.data.translation.width ~= "") then translationwidth = control.data.translation.width end
				
				 if(control.data.transform.height ~= nil and control.data.transform.height ~= "") then transformheight = control.data.transform.height end
				 if(control.data.transform.width ~= nil and control.data.transform.width ~= "") then transformwidth= control.data.transform.width end
				
				-- if(control.data.scrollspeed and (control.data.scrolldelay == nil or control.data.autoscroll == nil)) then control.data.scrolldelay = 1 control.data.autoscroll = true end

				
				-- if(control.data.visible == nil) then control.data.visible = true end
				
				if(control.data.output == true) then
				
				print(dump(control.data))
				spdlog.error(dump(control.data))
				
				end
				
				
				if(control.data.type == "label" or control.data.type == "textinput") then
					
					
					
					-- labelcount = labelcount +1
					-- topmargin = topmargin+uimargintop
					-- local texttoDisplay = ""
					
					
					
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"text")) or (table_contains(control.data.dynamic,"default"))  then 
					
					if(control.data.split) then

					local desctab = splitByChunk(control.data.text, control.data.split)
					local descc = ""

					for y=1,#desctab do


					descc = descc.."\n"..desctab[y]
					end
					if(control.ink:GetText() ~= descc) then
					control.ink:SetText(descc)
					end
					else
					if(control.ink:GetText() ~= control.data.text) then
					control.ink:SetText(control.data.text)
					end
					
					end
					 
				
					if(control.scrollspeed) then
					
					control.ink:SetScrollTextSpeed(control.data.scrollspeed)
					control.ink.scrollDelay = control.data.scrolldelay
					control.ink:EnableAutoScroll(control.data.autoscroll)
					
					end
					
					 end
					
					
				end
				
				
				
				if(control.data.type == "image") then
					
					-- control.ink:SetAtlasResource(ResRef.FromName(control.data.tweak))
					-- control.ink:SetTexturePart(control.data.texture)
					-- local stickerTweakId = control.data.tweak
					-- local stickerRecord = TDB.GetPhotoModeStickerRecord(stickerTweakId)
					-- if(stickerRecord ~= nil) then
					-- widget:SetAtlasResource(stickerRecord:AtlasName())
					-- widget:SetTexturePart(stickerRecord:ImagePartName())
					
					
					-- end
				end
				
				
				
					
					if(control.type == "shape") then
					
						if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"shape")) then 
							control.ink.shapeVariant = Enum.new('inkEShapeVariant', control.data.shapevariant)
							control.ink.lineThickness = control.data.linethickness
							control.ink.endCapStyle = Enum.new('inkEEndCapStyle', control.data.endcapstyle)
							control.ink.borderColor = gamecolorStyle(control.data.textcolor)
							
							control.ink.nineSliceScale = inkMargin.new({})
							local vertextt = {}
							for i,vertex in ipairs(control.data.vertex) do
								
								local vector = Vector2.new({X=vertex.x,Y=vertex.y})
								table.insert(vertextt,vector)
								
							
							
							end
							control.ink.vertexList = vertextt
							
							
							
							control.ink.useNineSlice = true
						end
					
					end
					
			
				
				
				if(control.data.type ~= "scrollarea" and control.data.type ~= "button") then
					
					
					
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"color")) or (table_contains(control.data.dynamic,"default") ) then 
					control.ink:SetTintColor(textcolor)
					end
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"visible") )or (table_contains(control.data.dynamic,"default") )  then 
					control.ink:SetVisible(control.data.visible)
					end
					
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"opacity")) or (table_contains(control.data.dynamic,"default") ) then 
					control.ink:SetOpacity(control.data.opacity)
					end
					
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"rotation")) or (table_contains(control.data.dynamic,"default")) then 
					control.ink:SetRotation(control.data.rotation)
					end
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"size")) or (table_contains(control.data.dynamic,"default")) then 
					control.ink:SetSize(Vector2.new({ X = width, Y = height }))
					end
					
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"margin")) or (table_contains(control.data.dynamic,"default"))  then 
					control.ink:SetMargin(inkMargin.new(control.data.margin))
					end
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"translation")) or (table_contains(control.data.dynamic,"default")) then 
					control.ink:SetTranslation(Vector2.new({ X = translationwidth, Y = translationheight }))
					end
					
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"padding")) or (table_contains(control.data.dynamic,"default")) then 
					control.ink:SetPadding(inkMargin.new(control.data.padding))
					end
					
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"pivot")) or (table_contains(control.data.dynamic,"default")) then 
					control.ink:SetRenderTransformPivot(Vector2.new({ X = transformwidth, Y = transformheight }))
					end
					
					else
					
					
					-- control.ink.root:SetFitToContent(control.data.fittocontent)
					-- control.ink.root:SetTintColor(textcolor)
					-- control.ink.root:SetSize(Vector2.new({ X = width, Y = height }))
					-- control.ink.root:SetScale(Vector2.new({ X = scalewidth, Y = scaleheight }))
					-- control.ink.root:SetInteractive(control.data.interactive)
					-- control.ink.root:SetMargin(inkMargin.new(control.data.margin))
					-- control.ink.root:SetAnchor(control.data.anchor)
					-- control.ink.root:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
					-- control.ink.root:SetOpacity(control.data.opacity)
					-- control.ink.root:SetRotation(control.data.rotation)
						if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"visible")) or (table_contains(control.data.dynamic,"default"))   then 
						print("test "..GameDump(control.ink:GetRootWidget()))
						if control.ink:GetRootWidget().name ~=nil then control.ink:GetRootWidget():SetVisible(control.data.visible) end
						end
					-- control.ink.root:SetTranslation(Vector2.new({ X = translationwidth, Y = translationheight }))
					-- control.ink.root:SetPadding(inkMargin.new(control.data.padding))
					-- control.ink.root:SetRenderTransformPivot(Vector2.new({ X = transformwidth, Y = transformheight }))
					
					
					
				end
				
			end
			
			
			
			end
			
			
		end
		
		
		
		
		
		
	
	
	
end


---Misc Function---
function showInputHint(key, text, prio, holdAnimation, tag)
	
	local hold = holdAnimation or false
	
	local evt = UpdateInputHintEvent.new()
	
	local data = InputHintData.new()
	data.action = key
	data.source = "CyberScript"
	data.
	localizedLabel = text
	data.enableHoldAnimation = hold
	data.sortingPriority  = prio or 1
	evt = UpdateInputHintEvent.new()
	evt.data = data
	evt.show = true
	evt.targetHintContainer = "GameplayInputHelper"
	Game.GetUISystem():QueueEvent(evt)
	table.insert(currentInputHintList, {tag = tag, key = key})
end

function hideCustomHints(tag)
	
	local evt = DeleteInputHintBySourceEvent.new()
	evt.source = "CyberScript"
	evt.targetHintContainer = "GameplayInputHelper"
	Game.GetUISystem():QueueEvent(evt)
end





function buildWebPageBountonSquare(parent,imageprop,textprop,page,action)
	local stickerRecord = TDB.GetPhotoModeStickerRecord(imageprop.tweak)
	
	
	local selectionImage = inkImage.new()
	selectionImage:SetName(CName.new(imageprop.tag))
	selectionImage:SetMargin(imageprop.margin)
	selectionImage:SetSize(Vector2.new({ X = imageprop.size.x, Y = imageprop.size.y }))
	selectionImage:SetFitToContent(imageprop.fittocontent)
	selectionImage:SetAtlasResource(stickerRecord:AtlasName())
	selectionImage:SetTexturePart(stickerRecord:ImagePartName())
	selectionImage:SetScale(Vector2.new({ X = imageprop.scale.x, Y = imageprop.scale.y }))
	selectionImage:Reparent(parent, 0)
	selectionImage:SetInteractive(true)
	
	local descText = inkText.new()
	descText:SetName(CName.new(textprop.tag))
	descText:SetText(textprop.text)
	descText:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
	descText:SetFontStyle('Semi-Bold')
	descText:SetFontSize(textprop.fontsize)
	descText:SetTintColor(textprop.textcolor)
	descText:SetHorizontalAlignment(textHorizontalAlignment.Center)
	descText:SetVerticalAlignment(textVerticalAlignment.Center)
	descText:SetMargin(textprop.margin)
	descText:SetLetterCase(1)
	descText:SetScale(Vector2.new({ X = textprop.scale.x, Y = textprop.scale.y }))
	descText:SetSize(Vector2.new({ X = textprop.size.x, Y = textprop.size.y }))
	descText:Reparent(parent, 1)
	
	
	EventProxy.RegisterCallback(selectionImage, 'OnRelease', function(_, evt)
			
			
			
			
			if(action ~= nil and #action > 0) then
			
				runActionList(action, "WebButtonEvent", "interact",false,"nothing",true)
			
			end
			
			
		--+	GameController["WebPage"]  = self:FillPageFromJournal(page)
		  
		evt:Handle()
	end)
	
	
	
	
end


function makeCustomInterface(parentroot,interface)
	
			local rootWidget = parentroot
			
		
			currentevt = {}
			currentscroll = {}
		
			
		
			
			local leftmargin = 540
			local topmargin = -uimargintop
			local labelcount  = 0
			local havebutton = false
			local buttoncount = 0
			local havetext = false
			local fontsize = uifont
			local width = 400
			local height = 100
			local scalewidth = 0.5
			local scaleheight = 0.5
			local translationheight = 0
			local translationwidth = 0
			local transformheight = 0
			local transformwidth = 0
			local horizontalalign = 1
			local verticalalign = 1
			
			if(interface.onload_action ~= nil and #interface.onload_action > 0) then
			
				runActionList(interface.onload_action, interface.tag, "interact",false,"nothing",true)
			
			end
			currentInterfaceWidgetTest = {}
			currentInterfaceWidget[interface.tag] = {}
			currentInterfaceWidget[interface.tag].controls = {}
			currentInterfaceWidget[interface.tag].parent = parentroot
			
			
			for i,control in ipairs(interface.controls) do
			local status, result = pcall( function()
				if(checkTriggerRequirement(control["requirement"],control["trigger"])) then
					
					checkContext(control)
					local bgcolor = HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 })
					
					local textcolor = HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 })
					
					
					if control.margin == nil then control.margin = {} end
					if control.childmargin == nil then control.childmargin = {} end
					if control.padding == nil then control.padding = {} end
					if control.style == nil then control.style = {} end
					if control.size == nil then control.size = {} end
					if control.scale == nil then control.scale = {} end
					if control.translation == nil then control.translation = {} end
					if control.transform == nil then control.transform = {} end
					
					if(control.bgcolor ~= nil and control.bgcolor.red ~= nil ) then bgcolor = gamecolorStyle(control.bgcolor) end
					if(control.textcolor ~= nil and control.textcolor.red ~= nil ) then textcolor = gamecolorStyle(control.textcolor) end
					
					if(control.fittocontent == nil) then control.fittocontent = true end
					if(control.opacity == nil) then control.opacity = 1 end
					if(control.rotation == nil) then control.rotation = 0 end
					if(control.interactive == nil) then control.interactive = false end
					
					if(control.event == nil) then control.event = {} end
					
					
					if(control.horizontalalign == nil) then control.horizontalalign = 1 end
					if(control.anchor == nil) then control.anchor = 15 end
					if(control.verticalalign == nil) then control.verticalalign = 1 end
					if(control.style.fontsize ~= nil and control.style.fontsize ~= "") then fontsize = control.style.fontsize end
					if(control.size.width ~= nil and control.size.width ~= "") then width = control.size.width end
					if(control.size.height ~= nil and control.size.height ~= "") then height = control.size.height end
					if(control.scale.height ~= nil and control.scale.height ~= "") then scaleheight = control.scale.height end
					if(control.scale.width ~= nil and control.scale.width ~= "") then scalewidth = control.scale.width end
					
					if(control.translation.height ~= nil and control.translation.height ~= "") then translationheight = control.translation.height end
					if(control.translation.width ~= nil and control.translation.width ~= "") then translationwidth = control.translation.width end
					
					if(control.transform.height ~= nil and control.transform.height ~= "") then transformheight = control.transform.height end
					if(control.transform.width ~= nil and control.transform.width ~= "") then transformwidth= control.transform.width end
					
					
					if(control.visible == nil) then control.visible = true end
					if(control.scrollspeed and (control.scrolldelay == nil or control.autoscroll == nil)) then control.scrolldelay = 1 control.autoscroll = true end

					local obj = {}
				
					obj.tag = control.tag
					obj.data = control
					obj.type = control.type
					
					
					
					local widgetcontrol = nil
					
					
					
					
					
					
					
					if(control.type == "label" or control.type == "textinput") then
						
						
						
						labelcount = labelcount +1
						topmargin = topmargin+uimargintop
						local texttoDisplay = ""
						
						if(control.type == "textinput") then
							widgetcontrol = inkTextInput.new()
						
						else
							widgetcontrol = inkText.new()
						
						end
						
						if(control.split) then
						
						local desctab = splitByChunk(control.text, control.split)
						local descc = ""
						
						for y=1,#desctab do
						
						
							descc = descc.."\n"..desctab[y]
						end
						widgetcontrol:SetText(descc)
						else
						widgetcontrol:SetText(control.text)
						end
						
						widgetcontrol:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						widgetcontrol:SetFontStyle('Medium')
						widgetcontrol:SetFontSize(fontsize)
						widgetcontrol:SetHorizontalAlignment(control.horizontalalign)
						widgetcontrol:SetVerticalAlignment(control.verticalalign)
						
						
						if(control.scrollspeed) then
						
						widgetcontrol:SetScrollTextSpeed(control.scrollspeed)
						widgetcontrol.scrollDelay = control.scrolldelay
						widgetcontrol:EnableAutoScroll(control.autoscroll)
						
						end
						
						
						
					end
										
				
					
					if(control.type == "image") then
						widgetcontrol = inkImage.new()
						widgetcontrol:SetAtlasResource(ResRef.FromName(control.tweak))
						widgetcontrol:SetTexturePart(control.texture)
						-- local stickerTweakId = control.tweak
						-- local stickerRecord = TDB.GetPhotoModeStickerRecord(stickerTweakId)
						-- if(stickerRecord ~= nil) then
							-- widgetcontrol:SetAtlasResource(stickerRecord:AtlasName())
							-- widgetcontrol:SetTexturePart(stickerRecord:ImagePartName())
						
						-- end
					end
					
					if(control.type == "button") then
						control.interactive = true
						
						
						local buttonData = {
							name = StringToName(control.tag),
							text = control.title,
							value = i,
							tag =  control.tag,
							action = control.action
						}
						local fontsize = uifont
						widgetcontrol = UIButton.Create(buttonData.name, buttonData.text,fontsize, width, height,control.margin,bgcolor,textcolor)
						
						widgetcontrol:RegisterCallback('OnRelease', function(button, evt)
							if evt:IsAction('click') then
								
									runActionList(control.action, control.tag, "interact",false,"nothing",false)
								
								evt:Handle()
							end
						end)
						widgetcontrol:RegisterCallback('OnEnter', function(_, evt)
							
								if(control.onenter_action ~= nil and #control.onenter_action > 0) then
									runActionList(control.onenter_action, control.tag.."_onenter", "interact",false,"nothing",false)
								end
							
							evt:Handle()
						end)
						widgetcontrol:RegisterCallback('OnLeave', function(_, evt)
							
								if(control.onleave_action ~= nil and #control.onleave_action > 0) then
									runActionList(control.onleave_action, control.tag.."_onleave", "interact",false,"nothing",false)
								end
							
							evt:Handle()
						end)
						
						--debugPrint(2,"button")
					end
					
					if(control.type == "scrollarea") then
					
					
					
						widgetcontrol = UIScroller.Create(control.tag)
					
						
						
						
						
						
						
						Cron.NextTick(function()
							widgetcontrol:UpdateContent(true)
						end)
							
					end
					
					if(control.type == "area") then
						widgetcontrol = inkCanvas.new()
						
					end
					
					if(control.type == "vertical_area") then
						widgetcontrol = inkVerticalPanelWidget.new()
						
						
						widgetcontrol:SetChildMargin(inkMargin.new(control.childmargin))
						
					end
					
					if(control.type == "horizontal_area") then
						widgetcontrol = inkHorizontalPanelWidget.new()
						
						widgetcontrol:SetChildMargin(inkMargin.new(control.childmargin))
					
					end
										
					if(control.type == "rectangle") then
						widgetcontrol = inkRectangleWidget.new()
						
					end	
					
					if(control.type == "circle") then
						widgetcontrol = inkCirclewWidget.new()
						
					end	
					
					
					if(control.type == "shape") then
					
						widgetcontrol = inkShapeWidget.new()
						widgetcontrol.shapeVariant = Enum.new('inkEShapeVariant', control.shapevariant)
						widgetcontrol.lineThickness = control.linethickness
						widgetcontrol.endCapStyle = Enum.new('inkEEndCapStyle', control.endcapstyle)
						widgetcontrol.borderColor = gamecolorStyle(control.textcolor)
						
						widgetcontrol.nineSliceScale = inkMargin.new({})
						local vertextt = {}
						for i,vertex in ipairs(control.vertex) do
							
							local vector = Vector2.new({X=vertex.x,Y=vertex.y})
							table.insert(vertextt,vector)
							
						
						
						end
						widgetcontrol.vertexList = vertextt
						
						
						
						widgetcontrol.useNineSlice = true
					
					
					end
					
					
					if(control.type == "scrollarea") then
						if(control.parent == nil or control.parent == "")then
							widgetcontrol:GetRootWidget():Reparent(parentroot, -1)
							else
							local parentv = getInkWidgetControl(interface.tag,control.parent)
							if(parentv ~= nil ) then 
								widgetcontrol:GetRootWidget():Reparent(parentv.ink, -1)
							
							else
								widgetcontrol:Reparent(parentroot, -1)
							
							end
						end
					
					else
						if(control.parent == nil or control.parent == "")then
							widgetcontrol:Reparent(parentroot, -1)
							
						else
								local parentv = getInkWidgetControl(interface.tag,control.parent)
								
								if(parentv ~= nil ) then 
							
								
								
									if(parentv.type ~= nil and parentv.type == "scrollarea") then
										
										local scrollContent = parentv.ink:GetContentWidget()
										widgetcontrol:Reparent(scrollContent, -1)
										
									else
									
									
										widgetcontrol:Reparent(parentv.ink, -1)
										
									end
							else
								widgetcontrol:Reparent(parentroot, -1)
								
							end
						end
					
					end
					
					
					
					if control.interactive == true then
					
						for i,event in ipairs(control.event) do
							print("tiiit")
							EventProxy.RegisterCallback(widgetcontrol, event.eventname, function(_, evt)
							
										print("toot")
									if( event.action ~= nil and #event.action > 0 and workerTable[control.tag..event.eventname] == nil) then
										print("teste")
										runActionList(event.action, control.tag..event.eventname, "interact",false,"nothing",true)
									end
								
								evt:Handle()
							end)
						end
					
					end
					
					if(control.type ~= "scrollarea" and control.type ~= "button" ) then
					CName.add(control.tag)
					widgetcontrol:SetName(CName(control.tag))
					widgetcontrol:SetFitToContent(control.fittocontent)
					widgetcontrol:SetTintColor(textcolor)
					widgetcontrol:SetSize(Vector2.new({ X = width, Y = height }))
					widgetcontrol:SetScale(Vector2.new({ X = scalewidth, Y = scaleheight }))
					widgetcontrol:SetInteractive(control.interactive)
					widgetcontrol:SetMargin(inkMargin.new(control.margin))
					widgetcontrol:SetAnchor(control.anchor)
					widgetcontrol:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
					widgetcontrol:SetOpacity(control.opacity)
					widgetcontrol:SetRotation(control.rotation)
					widgetcontrol:SetVisible(control.visible)
					widgetcontrol:SetTranslation(Vector2.new({ X = translationwidth, Y = translationheight }))
					widgetcontrol:SetPadding(inkMargin.new(control.padding))
					widgetcontrol:SetRenderTransformPivot(Vector2.new({ X = transformwidth, Y = transformheight }))
					widgetcontrol:SetState("default")
					
					--else
					
					-- widgetcontrol.root:SetName(CName.new(control.tag))
					-- widgetcontrol.root:SetFitToContent(control.fittocontent)
					-- widgetcontrol.root:SetTintColor(textcolor)
					-- widgetcontrol.root:SetSize(Vector2.new({ X = width, Y = height }))
					-- widgetcontrol.root:SetScale(Vector2.new({ X = scalewidth, Y = scaleheight }))
					-- widgetcontrol.root:SetInteractive(control.interactive)
					-- widgetcontrol.root:SetMargin(inkMargin.new(control.margin))
					-- widgetcontrol.root:SetAnchor(control.anchor)
					-- widgetcontrol.root:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
					-- widgetcontrol.root:SetOpacity(control.opacity)
					-- widgetcontrol.root:SetRotation(control.rotation)
					-- widgetcontrol.root:SetVisible(control.visible)
					-- widgetcontrol.root:SetTranslation(Vector2.new({ X = translationwidth, Y = translationheight }))
					-- widgetcontrol.root:SetPadding(inkMargin.new(control.padding))
					-- widgetcontrol.root:SetRenderTransformPivot(Vector2.new({ X = transformwidth, Y = transformheight }))
					-- widgetcontrol.root:SetState("default")
						
					if(control.type == "shape") then
				
					for i,v in ipairs(widgetcontrol.vertexList) do
					
					
					
					
					end
					
					end
					end
					
				
					
					obj.ink = widgetcontrol
					
				
					table.insert(currentInterfaceWidget[interface.tag].controls,obj)
				
				end
			end)
			
			
			 if status == false then
		
			print(control.tag)
			 print(result)
			spdlog.error(dump(control))
			spdlog.error(result)
			
			
			 end
			end
			
			
		
	
end

function openanpage(page)
	irpmenu.main = false
	irpmenu.contact = false
	irpmenu.fixer = false
	irpmenu.service = false
	irpmenu.social = false
	irpmenu.address = false
	irpmenu.radio = false
	irpmenu.tools = false
	irpmenu.multi = false
	irpmenu.editor = false
	irpmenu[page] = true
end
function buildnativesetting()
  nativeSettings.data["CMCUSTOM"] = nil
  nativeSettings.addTab("/CMCUSTOM", getLang("ui_setting_customsetting")) -- Add our mods tab (path, label)
	
	if arraySetting ~= nil then
	for k,v in pairs(arraySetting) do
local setting = v.setting

if nativeSettings.data["CMCUSTOM"].subcategories[setting.category] == nil then
nativeSettings.addSubcategory("/CMCUSTOM/"..setting.category, setting.categorylibelle) -- Optional: Add a subcategory (path, label), you can add as many as you want
	
end

if setting.type == "button" then
nativeSettings.addButton("/CMCUSTOM/"..setting.category, setting.label, setting.description,setting.buttonlabel, setting.textsize, function()
 	runActionList(setting.action, setting.tag, "interact",false,"nothing",true)
 	
 end)
end

if setting.type == "toggle" then
nativeSettings.addSwitch("/CMCUSTOM/"..setting.category, setting.label, setting.description, getVariableKeyWithDefault(setting.variable.tag,setting.variable.key,setting.defaultvalue), setting.defaultvalue, function(value)
	setVariable(setting.target.tag,setting.target.key,value)
 	runActionList(setting.action, setting.tag, "interact",false,"nothing",true)
 	
 end)
end

if setting.type == "sliderInt" then
 nativeSettings.addRangeInt("/CMCUSTOM/"..setting.category, setting.label, setting.description, setting.min, setting.max, setting.step, getScoreKeyWithDefault(setting.variable.tag,setting.variable.key,setting.defaultvalue), setting.defaultvalue, function(value)

	setScore(setting.target.tag,setting.target.key,value)
 	runActionList(setting.action, setting.tag, "interact",false,"nothing",true)
 	
 end)
end


if setting.type == "sliderFloat" then
 nativeSettings.addRangeFloat("/CMCUSTOM/"..setting.category, setting.label, setting.description, setting.min, setting.max, setting.step,"%.2f", getScoreKeyWithDefault(setting.variable.tag,setting.variable.key,setting.defaultvalue), setting.defaultvalue, function(value)

	setScore(setting.target.tag,setting.target.key,value)
 	runActionList(setting.action, setting.tag, "interact",false,"nothing",true)
 	
 end)
end

if setting.type == "sliderText" then
 nativeSettings.addSelectorString("/CMCUSTOM/"..setting.category, setting.label, setting.description, getScoreKeyWithDefault(setting.variable.tag,setting.variable.key,setting.variable.defaultvalue), setting.defaultvalue, function(value)

	setScore(setting.target.tag,setting.target.key,getScoreKeyWithDefault(setting.variable.tag,setting.variable.key,setting.variable.defaultvalue)[value])
 	runActionList(setting.action, setting.tag, "interact",false,"nothing",true)
 	
 end)
end


end
	end
  end
function getcurrentpage()
	
	local page = "main"
	for k,v in pairs(irpmenu) do
		
		if v then
			page = k
		end
	end
	return page
end

function loadUIsetting()
	
	local scr_w, scr_h = GetDisplayResolution()
	locationWindowsX = locationWindowsX or getUserSetting("locationWindowsX")
	locationWindowsY = locationWindowsY or getUserSetting("locationWindowsY")
	
	if locationWindowsX > scr_w or locationWindowsY > scr_h then
		locationWindowsX = 35
		locationWindowsY = 355
	end
end

function makeNativeSettings()
	
	nativeSettings.addTab("/CM", getLang("ui_setting_main")) -- Add our mods tab (path, label)
	if (ScriptedEntityAffinity == nil or
	AutoAmbush == nil or
	AmbushEnabled== nil or
	AmbushMin== nil or
	enableLocation== nil or
	showFactionAffinityHud== nil or
	displayXYZset== nil or
	InfiniteDoubleJump==nil or
	DisableFallDamage==nil or
	Player_Sprint_Multiplier==nil or
	Player_Run_Multiplier==nil or
	Jump_Height==nil or
	Double_Jump_Height==nil) then
	local obj = {}
	
	obj.AutoAmbush = tostring(AutoAmbush)
	obj.AmbushEnabled = tostring(AutoAmbush)
	obj.ScriptedEntityAffinity = tostring(ScriptedEntityAffinity)
	obj.enableLocation = tostring(enableLocation)
	obj.showFactionAffinityHud = tostring(showFactionAffinityHud)
	obj.displayXYZset = tostring(displayXYZset)
	obj.InfiniteDoubleJump = tostring(InfiniteDoubleJump)
	obj.DisableFallDamage = tostring(DisableFallDamage)
	obj.Player_Sprint_Multiplier = tostring(Player_Sprint_Multiplier)
	obj.Player_Run_Multiplier = tostring(Player_Run_Multiplier)
	obj.Jump_Height = tostring(Jump_Height)
	obj.Double_Jump_Height = tostring(Double_Jump_Height)
	

	
	
	nativeSettings.addSubcategory("/CM/gameplay", "Ooops there is an mising setting in CyberScript Setting !")
	nativeSettings.addSubcategory("/CM/gameplay01", "Try rebuild the cache and reload the mod/save/game !")
	nativeSettings.addSubcategory("/CM/gameplay02", "Send quest_mod.log to discord Admin on Cyberscript Discord !")
	
	
		
	
 
	nativeSettings.addButton("/CM/gameplay02", "Reset the mod", "Will totaly delete downloaded datapack, cache and latest session", "Reset the mod", 45, function()
	
	if file_exists("sessions/latest.txt") then
		os.remove("sessions/latest.txt")
	end
	
	for k,v in arrayDatapack do
			if(k ~="default") then
			DeleteModpack(k)
			end
	end
	
	local reader = dir("cache")
	
	for i=1, #reader do 
		if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
			
				os.remove('cache/'..reader[i].name)
	
	
			
			
		end
	end
	
	
 	ImportDataPack()
	LoadDataPackCache()
	debugPrint(2, getLang("ui_setting_actions_rebuild_done"))
 	
 end)
 
 
	
	
	else
	local status, result =  pcall(function()
	nativeSettings.addSubcategory("/CM/gameplay", getLang("ui_setting_gameplay")) -- Optional: Add a subcategory (path, label), you can add as many as you want
	
	settingsTables["gamepad"] =  
	nativeSettings.addSwitch("/CM/gameplay",  getLang("ui_setting_gameplay_controller"),  getLang("ui_setting_gameplay_controller"), currentController == "gamepad", false, function(state) -- path, label, desc, currentValue, defaultValue, callback
		currentController = state == false and "mouse" or "gamepad"
		updateUserSetting("currentController", state)
	end)
	
	
	settingsTables["radio"] = 
	nativeSettings.addRangeInt("/CM/gameplay",  getLang("ui_setting_gameplay_radio"),  getLang("ui_setting_gameplay_radio"), 0, 100, 1, currentRadioVolume, currentRadioVolume, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
		currentRadioVolume = value
	end)
	
	
	nativeSettings.addRangeFloat("/CM/gameplay", getLang("ui_setting_gameplay_scroll"),  getLang("ui_setting_gameplay_scroll"), 0.001, 0.1, 0.001, "%.3f", ScrollSpeed, ScrollSpeed, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
		pcall(function() 
		ScrollSpeed = tonumber(string.format("%.3f", value))
		updateUserSetting("ScrollSpeed", ScrollSpeed)
		end)
	end)
	
	
	
	nativeSettings.addSubcategory("/CM/script", "Script Engine Settings")
	
	nativeSettings.addSwitch("/CM/script", getLang("Scripted Entity Affinity"), getLang("Gang Affinity affect Scripted Entities From Script Engine"), ScriptedEntityAffinity, ScriptedEntityAffinity, function(state) -- path, label, desc, currentValue, defaultValue, callback
		ScriptedEntityAffinity = state
		updateUserSetting("ScriptedEntityAffinity", ScriptedEntityAffinity)
	end)
	
	nativeSettings.addSwitch("/CM/script", getLang("AutoAmbushToggle"), getLang("AutoAmbush"), AutoAmbush, true, function(state) -- path, label, desc, currentValue, defaultValue, callback
		AutoAmbush = state
		updateUserSetting("AutoAmbush", AutoAmbush)
	end)
	
	nativeSettings.addSwitch("/CM/script", getLang("EnableDisableAmbush"), getLang("EnableDisableAmbush"), AmbushEnabled, true, function(state) -- path, label, desc, currentValue, defaultValue, callback
		AmbushEnabled = state
		updateUserSetting("AmbushEnabled", AmbushEnabled)
	end)
	
	nativeSettings.addRangeInt("/CM/script", getLang("SetAmbushMinTime"), getLang("SetAmbushMinTime"), 1, 120, 1, AmbushMin, 5, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
		AmbushMin = value
		updateUserSetting("AmbushMin", value)
	end)
	
	
	nativeSettings.addSubcategory("/CM/hud",getLang("ui_setting_display"))
	
	nativeSettings.addSwitch("/CM/hud", getLang("ui_setting_display_hud"), getLang("ui_setting_display_hud"), enableLocation, true, function(state) -- path, label, desc, currentValue, defaultValue, callback
		enableLocation = state
		updateUserSetting("enableLocation", state)
	end)
	
	nativeSettings.addSwitch("/CM/hud", getLang("ui_setting_display_hud_gang"), getLang("ui_setting_display_hud_gang"), showFactionAffinityHud, true, function(state) -- path, label, desc, currentValue, defaultValue, callback
		showFactionAffinityHud = state
		updateUserSetting("showFactionAffinityHud", state)
	end)
	
	nativeSettings.addSwitch("/CM/hud", getLang("ui_setting_display_hud_xyz"), getLang("ui_setting_display_hud_xyz"), displayXYZset, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
		displayXYZset = state
		updateUserSetting("displayXYZ", displayXYZset)
	end)
	
	
	
	
	nativeSettings.addSubcategory("/CM/actions",getLang("ui_setting_actions"))
	
	nativeSettings.addButton("/CM/actions", getLang("ui_setting_actions_untrackquest"), getLang("ui_setting_actions_untrackquest"),"Untrack", 45, function()
 	Game.untrack()
 	
 end)

	nativeSettings.addSwitch("/CM/actions", getLang("Enable Custom Quest"), getLang("Enable Custom Quest"), enableCustomQuest, true, function(state) -- path, label, desc, currentValue, defaultValue, callback
		enableCustomQuest = state
		updateUserSetting("enableCustomQuest", enableCustomQuest)
	end)
	
	nativeSettings.addButton("/CM/actions",  getLang("ui_setting_actions_resetquest"),  getLang("ui_setting_actions_resetquest"), "Reset CS Quest", 45, function()
 		if currentQuest then
			resetQuest()
		end
 	
 end)
 
	nativeSettings.addButton("/CM/actions", getLang("ui_setting_actions_cleanthemess"), getLang("ui_setting_actions_cleanthemess"), "Clean the mess", 45, function()
 		
		despawnAll()
		workerTable = {}
 	
 end)
	
	nativeSettings.addButton("/CM/actions", getLang("ui_setting_actions_recalculateaffinity"), getLang("ui_setting_actions_recalculateaffinity_msg"),"Recalculate", 45, function()
		
		
		for k,v in pairs(arrayFaction) do
			setScore(k, "Score", 0)
		end
	
		
		for i=1, #arrayPnjDb do
			setScore(arrayPnjDb[i].Names, "Score", 0)
			
		end
		
		
		GangAffinityCalculator()
		initGangRelation()
		initGangDistrictScore()
 
 end)
 
	nativeSettings.addButton("/CM/actions", getLang("ui_setting_actions_cleareaffinity"), getLang("ui_setting_actions_recalculateaffinity_msg"),"Clear", 45, function()
		for k,v in pairs(arrayFaction) do
			setScore("Affinity",k, 0)
		end
		for i=1, #arrayPnjDb do
			setScore("Affinity",arrayPnjDb[i].Names, 0)
		end
	
 	
 end)
	
	nativeSettings.addButton("/CM/actions", getLang("Hot Reload the mod"), getLang("Hot Reload the mod. Without Reload CET"), "Hot Reload", 45, function()
		hotreload = true
	
 	
 end)
 
	
	nativeSettings.addButton("/CM/actions", getLang("ui_setting_actions_refresh"), getLang("ui_setting_actions_refresh"), "Refresh", 45, function()
	CheckandUpdateDatapack()
	LoadDataPackCache()
	debugPrint(2,"CyberScript : Datapack Cache refreshed")
 	
 end)
 
	nativeSettings.addButton("/CM/actions", getLang("ui_setting_actions_rebuild"), getLang("ui_setting_actions_rebuild"), "Rebuild", 45, function()
	
	local reader = dir("cache")
	
	for i=1, #reader do 
		if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
			
				os.remove('cache/'..reader[i].name)
	
	
			
			
		end
	end
	
	
 	ImportDataPack()
	CheckandUpdateDatapack()
	LoadDataPackCache()
	debugPrint(2, getLang("ui_setting_actions_rebuild_done"))
 	
 end)
 
	
	nativeSettings.addButton("/CM/actions", "Reset the mod", "Will totaly delete download datapack, cache and latest session", "Reset the mod", 45, function()
	
	if file_exists("sessions/latest.txt") then
		os.remove("sessions/latest.txt")
	end
	
	for k,v in arrayDatapack do
	
			if(k ~="default") then
			debugPrint(10,k)
			DeleteModpack(k)
			end
	end
	
	local reader = dir("cache")
	
	for i=1, #reader do 
		if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
			
				os.remove('cache/'..reader[i].name)
	
	
			
			
		end
	end
	
	
 	ImportDataPack()
	CheckandUpdateDatapack()
	LoadDataPackCache()
	debugPrint(2, getLang("ui_setting_actions_rebuild_done"))
 	
 end)
 
 
 
	nativeSettings.addTab("/CMCHEAT", getLang("ui_setting_cheat")) -- Add our mods tab (path, label)
	
	nativeSettings.addSubcategory("/CMCHEAT/player", getLang("ui_setting_cheat")) -- Optional: Add a subcategory (path, label), you can add as many as you want
	
	nativeSettings.addSwitch("/CMCHEAT/player",  getLang("ui_setting_cheat_infinite_doublejump"),  getLang("ui_setting_cheat_infinite_doublejump"), InfiniteDoubleJump, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
		InfiniteDoubleJump = state
		updateUserSetting("InfiniteDoubleJump", InfiniteDoubleJump)
	end)
	
	nativeSettings.addSwitch("/CMCHEAT/player",  getLang("ui_setting_cheat_disable_fall_damage"),  getLang("ui_setting_cheat_disable_fall_damage"), DisableFallDamage, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
		DisableFallDamage = state
		updateUserSetting("DisableFallDamage", DisableFallDamage)
	end)
	
	nativeSettings.addRangeFloat("/CMCHEAT/player", getLang("ui_setting_cheat_player_sprint"),  getLang("ui_setting_cheat_player_sprint"), 1, 10, 0.1, "%.1f", Player_Sprint_Multiplier, 1, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
		pcall(function() 
		Player_Sprint_Multiplier = tonumber(string.format("%.1f", value))
		updateUserSetting("Player_Sprint_Multiplier", Player_Sprint_Multiplier)
		TweakDB:SetFlat("PlayerLocomotion.player_locomotion_data_Sprint_inline1.value", 6.5 * Player_Sprint_Multiplier)
		TweakDB:Update("PlayerLocomotion.player_locomotion_data_Sprint_inline1.value")
		
		-- local newMod = gameConstantStatModifierData.new()
		-- newMod.statType = 619
		-- newMod.modifierType = 2
		-- newMod.value = Player_Sprint_Multiplier
		
		-- Game.GetStatsSystem():AddModifier(Game.GetPlayer():GetEntityID(),newmod)
		
		end)
	end)
	
	nativeSettings.addRangeFloat("/CMCHEAT/player", getLang("ui_setting_cheat_player_run"),  getLang("ui_setting_cheat_player_run"), 1, 10, 0.1, "%.1f", Player_Run_Multiplier, 1, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
		pcall(function() 
		Player_Run_Multiplier = tonumber(string.format("%.1f", value))
		updateUserSetting("Player_Run_Multiplier", Player_Run_Multiplier)
		TweakDB:SetFlat("PlayerLocomotion.player_locomotion_data_Stand_inline1.value", 3.5 * Player_Run_Multiplier)
		TweakDB:Update("PlayerLocomotion.player_locomotion_data_Stand_inline1.value")
		
		-- local newMod = gameConstantStatModifierData.new()
		-- newMod.statType = 619
		-- newMod.modifierType = 2
		-- newMod.value = Player_Run_Multiplier
		
		-- Game.GetStatsSystem():AddModifier(Game.GetPlayer():GetEntityID(),newmod)
		end)
	end)

	
	nativeSettings.addRangeFloat("/CMCHEAT/player", getLang("ui_setting_cheat_jump_height"),  getLang("ui_setting_cheat_jump_height"), 1, 10, 0.1, "%.1f", Jump_Height, 1, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
		pcall(function() 
		Jump_Height = tonumber(string.format("%.1f", value))
		updateUserSetting("Jump_Height", Jump_Height)
		TweakDB:SetFlat("PlayerLocomotion.JumpJumpHeightModifier.value", 1 * Jump_Height)
		TweakDB:Update("PlayerLocomotion.JumpJumpHeightModifier.value")
		
		-- local newMod = gameConstantStatModifierData.new()
		-- newMod.statType = 596
		-- newMod.modifierType = 2
		-- newMod.value = Jump_Height
		
		-- Game.GetStatsSystem():AddModifier(Game.GetPlayer():GetEntityID(),newmod)
		
		end)
	end)
	
	nativeSettings.addRangeFloat("/CMCHEAT/player", getLang("ui_setting_cheat_doublejump_height"),  getLang("ui_setting_cheat_doublejump_height"), 1, 10, 0.1, "%.1f", Double_Jump_Height, 1, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
		pcall(function() 
		Double_Jump_Height = tonumber(string.format("%.1f", value))
		updateUserSetting("Double_Jump_Height", Double_Jump_Height)
		TweakDB:SetFlat("PlayerLocomotion.DoubleJumpJumpHeightModifier.value", 2.6 * Double_Jump_Height)
		TweakDB:Update("PlayerLocomotion.DoubleJumpJumpHeightModifier.value")
		
		-- local newMod = gameConstantStatModifierData.new()
		-- newMod.statType = 596
		-- newMod.modifierType = 2
		-- newMod.value = Jump_Height
		
		-- Game.GetStatsSystem():AddModifier(Game.GetPlayer():GetEntityID(),newmod)
		end)
	end)

	
	
	
	end)
	
	if status == false then
		
		
		
			spdlog.error(result)
			
			nativeSettings.addSubcategory("/CM/gameplay", "Ooops there is an error in CyberScript Setting !")
	nativeSettings.addSubcategory("/CM/gameplay01", "Try rebuild the cache and reload the mod/save/game !")
	nativeSettings.addSubcategory("/CM/gameplay02", "Send quest_mod.log to discord Admin on Cyberscript Discord !")
	
	
		
	
 
	nativeSettings.addButton("/CM/gameplay02", "Reset the mod", "Will totaly delete download datapack, cache and latest session", "Reset the mod", 45, function()
	
	if file_exists("sessions/latest.txt") then
		os.remove("sessions/latest.txt")
	end
	
	for k,v in arrayDatapack do
			if(k ~="default") then
			DeleteModpack(k)
			end
	end
	
	local reader = dir("cache")
	
	for i=1, #reader do 
		if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
			
				os.remove('cache/'..reader[i].name)
	
	
			
			
		end
	end
	
	
 	ImportDataPack()
	LoadDataPackCache()
	debugPrint(2, getLang("ui_setting_actions_rebuild_done"))
 	
 end)
		end
	
	
	end
	end


---IMGUI UI---
function newWindows()
	
	if not ImGui.Begin(getLang("CyberScript")) then return end
	ImGui.SetNextWindowPos(800, 800, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(menuWindowsX, menuWindowsY, ImGuiCond.Appearing) -- set window size w, h
	ImGui.SetWindowSize(menuWindowsX, menuWindowsY)
	ImGui.SetWindowFontScale(menufont)
	ImGui.BeginChild("around", menuFrameX, menuFrameY)
	
	if getcurrentpage() ~= "main" then
		
		if ImGui.Button(getLang("back"), menuBTNX*2, menuBTNY) then
			
			if getcurrentpage() == "service" then
				openHelpMenu = false
				elseif getcurrentpage() == "editor" then
				resetEditorObject()
				openEditor = false
				elseif getcurrentpage() == "multi" then
				openNetContract = false
				
			end
			openanpage("main")
		end
		ImGui.Spacing()
	end
	
	if getcurrentpage() == "main" then
		ImGui.BeginChild("line2", menuRowX, menuRowY)
		
		
		
		-- if ImGui.Button(getLang("ui_menu_online"), menuBTNX, menuBTNY) then
			-- openanpage("multi")
		-- end
		-- ImGui.SameLine()
		
		if ImGui.Button(getLang("editor"), menuBTNX*2, menuBTNY) then
			openanpage("editor")
		end
		ImGui.EndChild()
		elseif getcurrentpage() == "editor" then
		openEditor = true
		-- elseif getcurrentpage() == "multi" then
		-- openNetContract = true
	end
	ImGui.EndChild()
end

function loadHUD()
	
		
		
		for k,v in pairs(arrayHUD) do
			local hud = v.hud
			if(hud.type == "container") then
				displayHUD[k] = inkCanvas.new()
				displayHUD[k]:SetName(CName.new(hud.tag))
				displayHUD[k]:SetAnchor(inkEAnchor.Fill)
				displayHUD[k]:Reparent(rootContainer, -1)
				debugPrint(10,"create "..hud.tag)
			
			end
		end
		
		
		for k,v in pairs(arrayHUD) do
			local hud = v.hud
			if(hud.type == "container") then
				if(hud.container == nil or hud.container == "default" or  hud.container == "") then
					displayHUD[k]:Reparent(rootContainer, -1)
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
					displayHUD[k]:Reparent(container, -1)
				else
					displayHUD[k]:Reparent(displayHUD[hud.container], -1)
				end
				debugPrint(10,"create "..hud.tag)
			end
		
		end
	
end

function ImageFrame()
	
	for k,v in pairs(currentLoadedTexture) do
	
	ImGui.SetWindowFontScale(2)
	CPS.colorBegin("WindowBg", {v.bgcolor , v.bgopacity})
	CPS.colorBegin("Text", {v.titlecolor , v.titleopacity})
	CPS.colorBegin("Border", {v.bordercolor , v.borderopacity})
	
	CPS.colorBegin("TextDisabled", {"000000" , 0})
	CPS.colorBegin("FrameBg", {"000000" , 0})
	CPS.colorBegin("TitleBg", {"000000" , 0})
	
	CPS.colorBegin("TitleBgActive", {"000000" , 0})
	CPS.colorBegin("Header", {"000000" , 0})
	CPS.colorBegin("ScrollbarBg", {"000000" , 0})
	
	CPS.colorBegin("ScrollbarGrab", {"000000" , 0})
	CPS.colorBegin("ScrollbarGrabHovered", {"000000" , 0})
	CPS.colorBegin("ScrollbarGrabActive", {"000000" , 0})
	
	if ImGui.Begin(v.title) then 
	
	local windowWidth = 220
	local screenWidth, screenHeight = GetDisplayResolution()
	local screenRatioX, screenRatioY = screenWidth / 1920, screenHeight / 1200
	
	
	local posx = v.size.x +v.position.x
	ImGui.SetWindowSize(v.size.x, v.size.y)
	
	ImGui.SetWindowPos(  v.position.x * screenRatioX, v.position.y * screenRatioY)
	
	
	ImGui.Image(v.texture)

	
	ImGui.End()
	ImGui.SetWindowFontScale(1)
	CPS.colorEnd(1)
	CPS.colorEnd(1)
	CPS.colorEnd(1)
	
	CPS.colorEnd(1)
	CPS.colorEnd(1)
	CPS.colorEnd(1)
	
	CPS.colorEnd(1)
	CPS.colorEnd(1)
	CPS.colorEnd(1)
	
	CPS.colorEnd(1)
	CPS.colorEnd(1)
	CPS.colorEnd(1)
	end
	
	
	end
	
end

function debugWindows()
	
	if CPS == nil then return end
	CPS:setThemeBegin()
	
	if not ImGui.Begin("Debug Windows") then
		CPS:setThemeEnd()
		return
	end
	ImGui.SetNextWindowPos(900, 500, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(300, 800, ImGuiCond.Appearing) -- set window size w, h
	
	if not ImGui.BeginTabBar("AdressTabs", ImGuiTabBarFlags.NoTooltip) then
		ImGui.End()
		CPS:setThemeEnd()
		return
	end
	
	
	
	CPS.styleBegin("TabRounding", 0)
	
	if ImGui.BeginTabItem("Command") then
		local status, result =  pcall(function()
			
			local chara = ImGui.InputText("chara", "", 100, ImGuiInputTextFlags.AutoSelectAll)
			ImGui.Text("Selected Character :"..chara)
			
			if CPS:CPButton("Spawn Character") then
				
				local positionVec4 = Game.GetPlayer():GetWorldPosition()
				
				local entity = nil
				entity = Game.GetPlayer()
				positionVec4.x = positionVec4.x + 2
				positionVec4.y = positionVec4.y + 2
				
				local tag = "debug_"..tostring(math.random(0,999999)) --asigned but never used
				spawnEntity(chara, tag, positionVec4.x, positionVec4.y, positionVec4.z, 97, false, false, false)
			end
			ImGui.Spacing()
			
			if CPS:CPButton("Finish game quest") then
				
				local jm = Game.GetJournalManager()
				
				local te = jm:GetTrackedEntry()
				
				local qe = jm:GetParentEntry(jm:GetParentEntry(te))
				
				local qeh = jm:GetEntryHash(qe)
				jm:ChangeEntryStateByHash(qeh, "Succeeded", "Notify")
				debugPrint(6,"Current game active quest ended")
			end
			ImGui.Spacing()
			
			if CPS:CPButton("Close DB (need reload mod after this)") then
				db:close()
				db = nil
			end
			ImGui.Spacing()
			
			if CPS:CPButton("Keystone Net Window") then
				openNetContract = true
			end
			ImGui.Spacing()
			
			if CPS:CPButton("Toggle Invincible") then
				
				if not isGodMod then
					Game.GetGodModeSystem():EnableOverride(Game.GetPlayer():GetEntityID(), "Invulnerable", CName.new("SecondHeart"))
					else
					Game.GetGodModeSystem():DisableOverride(Game.GetPlayer():GetEntityID(), CName.new("SecondHeart"))
				end
			end
			
			if CPS:CPButton("Despawn All") then
				workerTable = {}
				despawnAll()
			end
			ImGui.Spacing()
			for k,v  in pairs(arrayFaction) do
				
				if CPS:CPButton("Increase "..arrayFaction[k].faction.Name.." Affinity by 5") then
					addFactionScoreByTagScore(k, 5)
					
				end
				
				if CPS:CPButton("Decrease "..arrayFaction[k].faction.Name.." Affinity by 5") then
					addFactionScoreByTagScore(k, -5)
					
				end
			end
			ImGui.Spacing()
			
			if ImGui.BeginCombo("##minpc", npcchara) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
				for i=1, #arrayListCharacter do
					
					if ImGui.Selectable(arrayListCharacter[i], (arrayListCharacter[i] == npcchara)) then
						
						npcchara = arrayListCharacter[i]
						ImGui.SetItemDefaultFocus()
					end
					
				end
				
				ImGui.EndCombo()
			end
			ImGui.Spacing()
			if CPS:CPButton("Increase "..npcchara.." Affinity by 1") then
					addAffinityScoreByNPCId(npcchara)
					
			end
			ImGui.Spacing()
			
			if CPS:CPButton("Reset All Affinity") then
				for k,v in pairs(arrayFaction) do
					updateFactionScore(k, 0)
					reloadDB()
				end
				
				for i=1,#arrayPnjDb do
					local pnj = arrayPnjDb[i]
					if(currentSave.Variable["Affinity"][pnj.Names] ~= nil) then
						
						currentSave.Variable["Affinity"][pnj.Names] = nil
						
					end
				end
			end
			ImGui.Spacing()
			
			if CPS:CPButton("Spawn Ambush") then
				checkAmbush()
			end
			
			
			ImGui.Spacing()
			for i=1, #arrayPhoneNPC do
				
				if CPS:CPButton("Increase "..arrayPhoneNPC[i].Names.." Affinity by 1") then
					addAffinityScoreByNPCId(arrayPhoneNPC[i].Names)
					reloadDB()
				end
				
				if CPS:CPButton("Decrease "..arrayPhoneNPC[i].Names.." Affinity by 1") then
					addAffinityScoreByNPCIdScore(arrayPhoneNPC[i].Names,-1)
					reloadDB()
				end
			end
			ImGui.Spacing()
			
			if CPS:CPButton("Reload DB") then
				reloadDB()
			end
			
			if CPS:CPButton("Reload datapack") then
				ImportMissionPack()
				loadMissionPack()
			end
			
			if CPS:CPButton("Get mission by trigger") then
				getMissionByTrigger()
				debugPrint(6,"enabled mission"..#possibleQuest)
			end
			ImGui.Spacing()
			ImGui.Spacing()
			ImGui.Spacing()
			ImGui.Spacing()
			ImGui.Spacing()
			
			if CPS:CPButton("showFaction")  then
				for k,v in pairs(arrayFaction)do
					debugPrint(6,k)
				end
			end
			ImGui.Spacing()
			ImGui.Spacing()
			ImGui.Spacing()
			inputquest = ImGui.InputText("quest", inputquest, 100, ImGuiInputTextFlags.AutoSelectAll)
			ImGui.Text("Selected Quest :"..inputquest)
			
			if CPS:CPButton("Start Mission") then
				setScore(inputquest, "Score", 0)
			end
			ImGui.Spacing()
			
			if CPS:CPButton("reset debug quest") then
				updateQuestStatut(inputquest, 0)
			end
			
			if CPS:CPButton("check quest conditions") then
				
				local qu = getQuestByTag(inputquest)
				debugPrint(6,testTriggerRequirement(qu.trigger_condition_requirement,qu.trigger_condition))
				debugPrint(6,testTriggerRequirement(qu.start_condition_requirement,qu.start_condition))
				debugPrint(6,testTriggerRequirement(qu.end_condition_requirement,qu.end_condition))
				debugPrint(6,testTriggerRequirement(qu.failure_condition_requirement,qu.failure_condition))
			end
			ImGui.Spacing()
			-- inputkey = ImGui.InputText("Score/Variable Key", inputkey, 100, ImGuiInputTextFlags.AutoSelectAll)
			-- ImGui.Spacing()
			-- inputscore = ImGui.InputText("Score Tag", inputscore, 100, ImGuiInputTextFlags.AutoSelectAll)
			-- ImGui.Text("For the Score :"..inputscore.." for the key "..inputkey.." the value is "..tonullstring(getScoreKey(inputscore,inputkey)))
			-- ImGui.Text("For the Score :"..inputscore.." for the default score the value is "..tonullstring(getScoreKey(inputscore,"Score")))
			-- ImGui.Spacing()
			-- inputvariable = ImGui.InputText("Variable Tag", inputvariable, 100, ImGuiInputTextFlags.AutoSelectAll)
			-- ImGui.Text("For the Variable :"..inputvariable.." for the key "..inputkey.." the value is "..tonullstring(getVariableKey(inputvariable,inputkey)))
		 end)
		
		if status == false then
		
		
			debugPrint(10,result)
			spdlog.error(result)
		end
		
		ImGui.EndTabItem()
	end
	
	
	
	
	if ImGui.BeginTabItem("Dev Playground") then
		
		local status, result =  pcall(function()
		if ImGui.Button("Stance Cover") then
			changeStance("test",1)
		end
		
		if ImGui.Button("Stance Crouch") then
			changeStance("test",2)
		end
		
		if ImGui.Button("Stance Stand") then
			changeStance("test",3)
		end
		
		if ImGui.Button("Stance Swim") then
			changeStance("test",4)
		end
		
		if ImGui.Button("Stance Vehicle") then
			changeStance("test",5)
		end
		
		if ImGui.Button("Stance VehicleWindows") then
			changeStance("test",6)
		end
		
		end)
		
		if status == false then
		
		
			debugPrint(10,result)
			spdlog.error(result)
		end
		
		ImGui.EndTabItem()
	end
	
	CPS.styleEnd(1)
	ImGui.EndTabBar()
	ImGui.End()
	CPS:setThemeEnd()
end



function fadeinwindows()
	
	local screenWidth, screenHeight = GetDisplayResolution()
	CPS.colorBegin("WindowBg", {"000000" , opacity})
	
	if ImGui.Begin(fademessage) then
		ImGui.SetNextWindowSize(screenWidth, screenHeight, ImGuiCond.Appearing) -- set window size w, h
		ImGui.SetWindowSize(screenWidth+5, screenHeight+5)
		ImGui.SetWindowPos(-5, -5)
	end
	CPS.colorEnd(1)
	ImGui.End()
end

function entitySelection()
	CPS:setThemeBegin()
	
	if not ImGui.Begin(lang.Selection) then
		CPS:setThemeEnd()
		return
	end
	ImGui.SetNextWindowPos(900, 500, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(310, 0	, ImGuiCond.Appearing) -- set window size w, h
	ImGui.SetWindowSize(300, 150)
	ImGui.SetWindowPos(800, 900)
	
	if objLook then
		CPS.colorBegin("Text", IRPtheme.EntitySelectionWindows)
		ImGui.TextWrapped(objLook:ToString())
		CPS.colorEnd(1)
	end
	
	if CPS:CPButton(lang.ChoosethisOne) then
		
		if entitySelectionIsVehicule == objLook:IsVehicle() then
			
			if selectionSlot >= 1 and selectionSlot <= 5 then
				
				local obj = getEntityFromManager("selection" .. tostring(selectionSlot))
				obj.id = objLook:GetEntityID()
				debugPrint(6,"targeted !!")
			end
			selectedEntity = true
			enableEntitySelection = false
			entitySelectionIsVehicule = false
		end
	end
	ImGui.End()
	CPS:setThemeEnd()
end

	
function displaySetting(setting, libelle)
	
	if setting == 1 then
		colorclass = IRPtheme.EnabledColor
		state = lang.Enabled
		else
		colorclass = IRPtheme.DisabledColor
		state = lang.Disabled
	end
	CPS.colorBegin("Text", colorclass)
	ImGui.TextWrapped(libelle.." : "..state)
	CPS.colorEnd(1)
end

---Native UI---
function HousingWindows()
	-- debugPrint(6,tostring(currentHouse ~= nil))
	-- debugPrint(6,tostring(isInHouse))
	
	if currentHouse ~= nil and isInHouse and #currentSave.arrayPlayerItems > 0 and inEditMode == true then
		
		if ImGui.Begin("My House") then
			ImGui.SetNextWindowPos(800, 750, ImGuiCond.Appearing) -- set window position x, y
			ImGui.SetNextWindowPos(800, 400, ImGuiCond.FirstUseEver) -- set window position x, y
			ImGui.SetNextWindowSize(300, 500, ImGuiCond.Appearing) -- set window size w, h
			ImGui.SetWindowSize(300, 500)
			
			if ImGui.BeginTabBar("Tabbar", ImGuiTabBarFlags.NoTooltip) then
				CPS.styleBegin("TabRounding", 0)
				
				if ImGui.BeginTabItem("Buyed Items") then
					CPS.colorBegin("Button", IRPtheme.HousingWindowsButton)
					CPS.colorBegin("Text", IRPtheme.HousingWindowsText)
					
					if #currentSave.arrayPlayerItems > 0 then
						for i=1, #currentSave.arrayPlayerItems do 
							
							local mitems = currentSave.arrayPlayerItems[i]
							
							if mitems.Quantity > 0 then
								CPS.colorBegin("Text", "ff5145")-- get color from styles.lua
								CPS.colorBegin("Button", { 48, 234, 247 ,0})  -- get color from styles.lua
								
								if ImGui.Button("Place "..mitems.Title.." Here ("..mitems.Quantity..")") then
									
									local pos = Game.GetPlayer():GetWorldPosition()
									
									local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
									
									local spawnedItem = {}
									debugPrint(6,pos.x)
									spawnedItem.Tag = mitems.Tag
									spawnedItem.HouseTag = currentHouse.tag
									spawnedItem.ItemPath = mitems.Path
									spawnedItem.X = pos.x
									spawnedItem.Y = pos.y
									spawnedItem.Z = pos.z
									spawnedItem.Yaw = angles.yaw
									spawnedItem.Pitch = angles.pitch
									spawnedItem.Roll = angles.roll
									spawnedItem.Title = mitems.Title
									saveHousing(spawnedItem)
									
									local housing = getHousing(spawnedItem.Tag,spawnedItem.X,spawnedItem.Y,spawnedItem.Z)
									spawnedItem.Id = housing.Id
									updatePlayerItemsQuantity(mitems,-1)
									spawnedItem.entityId = spawnItem(spawnedItem, pos, angles)
									table.insert(currentItemSpawned,spawnedItem)
								end
								CPS.colorEnd(1)
								CPS.colorEnd(1)
							end
						end
					end
					CPS.colorEnd(1)
					CPS.colorEnd(1)
					ImGui.EndTabItem()
				end
				
				if ImGui.BeginTabItem("Placed Items") then
					CPS.colorBegin("Button", IRPtheme.HousingWindowsPlacingItemButton)
					CPS.colorBegin("Text", IRPtheme.HousingWindowsPlacingItemText)
					
					if selectedItem == nil then
						
						if #currentItemSpawned > 0 then
							for i=1, #currentItemSpawned do 
								
								local mitems = currentItemSpawned[i]
								
								if not (selectedItem ~= nil and selectedItem.Id == mitems.Id) then
									
									if ImGui.Button("Select "..mitems.Title.."("..mitems.Id..")") then
										selectedItem = nil
										selectedItem = mitems
									end
								end
							end
						end
					end
					
					if selectedItem ~= nil then
						ImGui.TextWrapped("Selected : "..selectedItem.Title.."("..selectedItem.Id..")")
						ImGui.Spacing()
						ImGui.Spacing()
						
						if ImGui.Button("X+") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.x = objpos.x + 0.05
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("X-") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.x = objpos.x - 0.05
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("Y+") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.y = objpos.y + 0.05
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("Y-") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.y = objpos.y - 0.05
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("Z+") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.z = objpos.z + 0.05
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("Z-") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.z = objpos.z - 0.05
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						
						if ImGui.Button("Yaw+") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.yaw = angle.yaw + 5
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("Yaw-") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.yaw = angle.yaw + -5
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("Pitch+") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.pitch = angle.pitch + 5
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("Pitch-") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.pitch = angle.pitch + -5
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("Roll+") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.roll = angle.roll + 5
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						ImGui.SameLine()
						
						if ImGui.Button("Roll-") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = entity:GetWorldPosition()
							
							local worldpos = Game.GetPlayer():GetWorldTransform()
							
							local qat = entity:GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.roll = angle.roll + -5
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						
						if ImGui.Button("Move to Player") then
							
							local entity = Game.FindEntityByID(selectedItem.entityId)
							
							local objpos = Game.GetPlayer():GetWorldPosition()
							
							local qat = Game.GetPlayer():GetWorldOrientation()
							
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
						
						if ImGui.Button("Remove") then
							
							if Game.FindEntityByID(selectedItem.entityId) then
								for i=1, #currentSave.arrayPlayerItems do
									
									local mitem = currentSave.arrayPlayerItems[i]
									
									if mitem.Tag == selectedItem.Tag then
										Game.FindEntityByID(selectedItem.entityId):GetEntity():Destroy()
										debugPrint(6,"toto")
										updatePlayerItemsQuantity(mitem,1)
										deleteHousing(selectedItem.Id)
										
										local index = getItemEntityIndexFromManager(selectedItem.entityId)
										--despawnItem(selectedItem.Id)
										table.remove(currentItemSpawned,index)
										Cron.After(1, function()
											selectedItem = nil
										end)
									end
								end
								else
								debugPrint(6,"nope")
							end
						end
						ImGui.Spacing()
						ImGui.Spacing()
						
						if ImGui.Button("Unselect "..selectedItem.Title.."("..selectedItem.Id..")") then
							selectedItem = nil
						end
					end
					CPS.colorEnd(1)
					CPS.colorEnd(1)
					ImGui.EndTabItem()
				end
				CPS.styleEnd(1)
				ImGui.EndTabBar()
			end
			ImGui.End()
		end
	end
end

function BuyedItemsUI()
	currentInterface = nil
	
	local ui = {}
	ui.title = getLang("ui_buyed_items")
	ui.tag = "buyed_items_ui"
	ui.controls = {}
	
	local area = {}
	area.type = "scrollarea"
	area.tag =	"buyed_items_ui_scroll"
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.action = {}
	area.margin = {}
	area.style = {}
	area.margin.top = 15
	area.style.fontsize = 30
	area.style.width = 1500
	area.style.height = 700
	table.insert(ui.controls,area)
	area = {}
	area.type = "vertical_area"
	area.tag =	"buyed_items_ui_varea"
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.action = {}
	area.margin = {}
	area.style = {}
	area.margin.top = 15
	area.parent = "buyed_items_ui_scroll"
	area.style.fontsize = 30
	area.style.width = 1500
	area.style.height = 350
	table.insert(ui.controls,area)
	
	if(#currentSave.arrayPlayerItems > 0 ) then
		for i = 1, #currentSave.arrayPlayerItems do 
			
			local mitems = currentSave.arrayPlayerItems[i]
			
			if(mitems.Quantity > 0) then
				
				local buttons = {}
				buttons.type = "button"
				buttons.title = "Place "..mitems.Title.." Here ("..mitems.Quantity..")"
				buttons.tag =mitems.Tag.."_button_"..i
				buttons.width = 1000
				buttons.trigger = {}
				buttons.trigger.auto = {}
				buttons.trigger.auto.name = "auto"
				buttons.margin = {}
				buttons.style = {}
				buttons.margin.top = 15
				buttons.style.fontsize = 35
				buttons.style.width = 1450
				buttons.style.height = 100
				buttons.parent = "buyed_items_ui_varea"
				buttons.requirement = {}
				
				local requirement = {}
				table.insert(requirement,"auto")
				table.insert(buttons.requirement,requirement)
				buttons.action = {}
				
				local spawn_item = {}
				spawn_item.name = "spawn_buyed_item" 
				spawn_item.tag = mitems.Tag
				table.insert(buttons.action,spawn_item)
				spawn_item = {}
				spawn_item.name = "grab_select_item" 
				table.insert(buttons.action,spawn_item)
				
				local close_action = {}
				close_action.name = "close_interface" 
				table.insert(buttons.action,close_action)
				table.insert(ui.controls,buttons)
			end
		end
		currentInterface = ui
		
		if UIPopupsManager.IsReady() then
			
			local notificationData = inkGameNotificationData.new()
			notificationData.notificationName = 'base\\gameplay\\gui\\widgets\\notifications\\shard_notification.inkwidget'
			notificationData.queueName = 'modal_popup'
			notificationData.isBlocking = true
			notificationData.useCursor = true
			UIPopupsManager.ShowPopup(notificationData)
			else
			Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
		end
	end
end

function BuyedItemsUIMulti()
	currentInterface = nil
	
	local ui = {}
	ui.title = getLang("ui_multi_buyed_items")
	ui.tag = "buyed_items_ui_multi"
	ui.controls = {}
	
	local area = {}
	area.type = "scrollarea"
	area.tag =	"buyed_items_ui_scroll"
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.action = {}
	area.margin = {}
	area.style = {}
	area.margin.top = 15
	area.style.fontsize = 30
	area.style.width = 1500
	area.style.height = 700
	table.insert(ui.controls,area)
	area = {}
	area.type = "vertical_area"
	area.tag =	"buyed_items_ui_varea"
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.action = {}
	area.margin = {}
	area.style = {}
	area.margin.top = 15
	area.parent = "buyed_items_ui_scroll"
	area.style.fontsize = 30
	area.style.width = 1500
	area.style.height = 350
	table.insert(ui.controls,area)
	
	if(#currentSave.arrayPlayerItems > 0 ) then
		for i = 1, #currentSave.arrayPlayerItems do 
			
			local mitems = currentSave.arrayPlayerItems[i]
			
			if(mitems.Quantity > 0) then
				
				local buttons = {}
				buttons.type = "button"
				buttons.title = "Place "..mitems.Title.." Here ("..mitems.Quantity..")"
				buttons.tag =mitems.Tag.."_button_"..i
				buttons.width = 1000
				buttons.trigger = {}
				buttons.trigger.auto = {}
				buttons.trigger.auto.name = "auto"
				buttons.margin = {}
				buttons.style = {}
				buttons.margin.top = 15
				buttons.style.fontsize = 35
				buttons.style.width = 1450
				buttons.style.height = 100
				buttons.parent = "buyed_items_ui_varea"
				buttons.requirement = {}
				
				local requirement = {}
				table.insert(requirement,"auto")
				table.insert(buttons.requirement,requirement)
				buttons.action = {}
				
				local spawn_item = {}
				spawn_item.name = "spawn_buyed_item_multi" 
				spawn_item.tag = mitems.Tag
				table.insert(buttons.action,spawn_item)
				spawn_item = {}
				spawn_item.name = "grab_select_item_multi" 
				table.insert(buttons.action,spawn_item)
				
				local close_action = {}
				close_action.name = "close_interface" 
				table.insert(buttons.action,close_action)
				table.insert(ui.controls,buttons)
			end
		end
		currentInterface = ui
		
		if UIPopupsManager.IsReady() then
			
			local notificationData = inkGameNotificationData.new()
			notificationData.notificationName = 'base\\gameplay\\gui\\widgets\\notifications\\shard_notification.inkwidget'
			notificationData.queueName = 'modal_popup'
			notificationData.isBlocking = true
			notificationData.useCursor = true
			UIPopupsManager.ShowPopup(notificationData)
			else
			Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
		end
	end
end

function ActivatedGroup()
	currentInterface = nil
	
	local ui = {}
	ui.title = getLang("ui_datapack_choice")
	ui.tag = "datapack_current"
	ui.controls = {}
	
	if(#currentInteractGroup > 0 ) then
		
		local label = {}
		label.type = "label"
		label.tag ="selected_group_lbl"
		label.trigger = {}
		label.trigger.auto = {}
		label.trigger.auto.name = "auto"
		label.margin = {}
		label.style = {}
		label.anchor = 0
		label.margin.top = 15
		label.style.fontsize = 35
		label.requirement = {}
		
		local requirement = {}
		table.insert(requirement,"auto")
		table.insert(label.requirement,requirement)
		label.value = {}
		label.value.type = "text"
		label.value.value =  "Selected : "..currentInteractGroup[currentInteractGroupIndex]
		table.insert(ui.controls,label)
		
		local area = {}
		area.type = "scrollarea"
		area.tag =	"datapack_current_scroll"
		area.trigger = {}
		area.trigger.auto = {}
		area.trigger.auto.name = "auto"
		area.requirement = {}
		area.dynamic = {}
		local requirement = {}
		table.insert(requirement,"auto")
		table.insert(area.requirement,requirement)
		area.action = {}
		area.margin = {}
		area.style = {}
		area.size = {}
		area.margin.top = 15
		area.anchor = 0
		area.style.fontsize = 30
		area.size.width = 1200
		area.size.height = 700
		area.scale = {}
		area.scale.width = 1
		area.scale.height = 1
		table.insert(ui.controls,area)
		area = {}
		area.type = "vertical_area"
		area.tag =	"datapack_current_varea"
		area.trigger = {}
		area.trigger.auto = {}
		area.trigger.auto.name = "auto"
		area.requirement = {}
		
		local requirement = {}
		table.insert(requirement,"auto")
		table.insert(area.requirement,requirement)
		area.action = {}
		area.margin = {}
		area.style = {}
		area.size = {}
		area.margin.top = 15
		area.anchor = 0
		area.parent = "datapack_current_scroll"
		area.style.fontsize = 30
		area.size.width = 1500
		area.size.height = 350
		area.scale = {}
		area.scale.width = 1
		area.scale.height = 1
		table.insert(ui.controls,area)
		for i = 1, #currentInteractGroup do 
			
		
			local buttons = {}
			buttons.type = "button"
			buttons.title = "Choose "..currentInteractGroup[i]
			buttons.tag =currentInteractGroup[i].."_button_"..i
			buttons.trigger = {}
			buttons.trigger.auto = {}
			buttons.trigger.auto.name = "auto"
			buttons.requirement = {}
			buttons.dynamic = {}
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(buttons.requirement,requirement)
			buttons.action = {}
			buttons.margin = {}
			buttons.style = {}
			buttons.parent = "datapack_current_varea"
			buttons.style.fontsize = 35
			buttons.size = {}
			buttons.size.width = 1450
			buttons.size.height = 100
			buttons.scale = {}
			buttons.scale.width = 1
			buttons.scale.height = 1
			buttons.anchor = 0
			
			local spawn_item = {}
			spawn_item.name = "set_datapack_group" 
			spawn_item.value = i
			table.insert(buttons.action,spawn_item)
			
			local close_action = {}
			close_action.name = "close_interface" 
			table.insert(buttons.action,close_action)
			table.insert(ui.controls,buttons)
		end
		currentInterface = ui
		
		if UIPopupsManager.IsReady() then
			
			local notificationData = inkGameNotificationData.new()
			notificationData.notificationName = 'base\\gameplay\\gui\\widgets\\notifications\\shard_notification.inkwidget'
			notificationData.queueName = 'modal_popup'
			notificationData.isBlocking = true
			notificationData.useCursor = true
			UIPopupsManager.ShowPopup(notificationData)
			else
			Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
		end
	end
end

function PlacedItemsUI()
	currentInterface = nil
	
	local ui = {}
	ui.title = getLang("ui_manage_placed_item")
	ui.tag = "placed_items_ui"
	ui.controls = {}
	
	local area = {}
	area.type = "scrollarea"
	area.tag =	"placed_items_ui_scroll"
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.action = {}
	area.margin = {}
	area.style = {}
	area.margin.top = 15
	area.style.fontsize = 30
	area.style.width = 1500
	area.style.height = 700
	table.insert(ui.controls,area)
	area = {}
	area.type = "vertical_area"
	area.tag =	"placed_items_ui_varea"
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.action = {}
	area.margin = {}
	area.style = {}
	area.margin.top = 15
	area.parent = "placed_items_ui_scroll"
	area.style.fontsize = 30
	area.style.width = 1500
	area.style.height = 350
	table.insert(ui.controls,area)
	
	if(#currentItemSpawned > 0 ) then
		
		if selectedItem ~= nil then
			
			local label = {}
			label.type = "label"
			label.tag ="selected_item_lbl"
			label.trigger = {}
			label.trigger.auto = {}
			label.trigger.auto.name = "auto"
			label.margin = {}
			label.style = {}
			label.margin.top = 15
			label.style.fontsize = 35
			label.requirement = {}
			
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(label.requirement,requirement)
			label.value = {}
			label.value.type = "text"
			label.value.value =  "Selected : "..selectedItem.Title.."("..selectedItem.Id..")"
			table.insert(ui.controls,label)
		end
		for i = 1, #currentItemSpawned do 
			
			local mitems = currentItemSpawned[i]
			
			local buttons = {}
			buttons.type = "button"
			buttons.title = "Select "..mitems.Title.."("..mitems.Id..")"
			buttons.tag =mitems.Tag.."_button_"..i
			buttons.margin = {}
			buttons.style = {}
			buttons.margin.top = 15
			buttons.style.fontsize = 35
			buttons.style.width = 1000
			buttons.style.height = 100
			buttons.trigger = {}
			buttons.trigger.auto = {}
			buttons.trigger.auto.name = "auto"
			buttons.requirement = {}
			
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(buttons.requirement,requirement)
			buttons.action = {}
			
			local spawn_item = {}
			spawn_item.name = "select_item" 
			spawn_item.value = mitems.Id
			table.insert(buttons.action,spawn_item)
			
			local close_action = {}
			close_action.name = "close_interface" 
			table.insert(buttons.action,close_action)
			table.insert(ui.controls,buttons)
		end
		
		local buttons = {}
		buttons.type = "button"
		buttons.title = "Unselect item"
		buttons.tag ="unselect_button"
		buttons.trigger = {}
		buttons.trigger.auto = {}
		buttons.trigger.auto.name = "auto"
		buttons.margin = {}
		buttons.style = {}
		buttons.parent = "placed_items_ui_varea"
		buttons.style.fontsize = 35
		buttons.style.width = 1450
		buttons.style.height = 100
		buttons.requirement = {}
		
		local requirement = {}
		table.insert(requirement,"auto")
		table.insert(buttons.requirement,requirement)
		buttons.action = {}
		
		local spawn_item = {}
		spawn_item.name = "unselect_item" 
		table.insert(buttons.action,spawn_item)
		
		local close_action = {}
		close_action.name = "close_interface" 
		table.insert(buttons.action,close_action)
		table.insert(ui.controls,buttons)
		currentInterface = ui
		
		if UIPopupsManager.IsReady() then
			
			local notificationData = inkGameNotificationData.new()
			notificationData.notificationName = 'base\\gameplay\\gui\\widgets\\notifications\\shard_notification.inkwidget'
			notificationData.queueName = 'modal_popup'
			notificationData.isBlocking = true
			notificationData.useCursor = true
			UIPopupsManager.ShowPopup(notificationData)
			else
			Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
		end
	end
end

function PlacedItemsUIMulti()
	currentInterface = nil
	
	local ui = {}
	ui.title =  getLang("ui_multi_manage_placed_item")
	ui.tag = "placed_items_ui_multi"
	ui.controls = {}
	
	local area = {}
	area.type = "scrollarea"
	area.tag =	"placed_items_ui_scroll"
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.action = {}
	area.margin = {}
	area.style = {}
	area.margin.top = 15
	area.style.fontsize = 30
	area.style.width = 1500
	area.style.height = 700
	table.insert(ui.controls,area)
	area = {}
	area.type = "vertical_area"
	area.tag =	"placed_items_ui_varea"
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.action = {}
	area.margin = {}
	area.style = {}
	area.margin.top = 15
	area.parent = "placed_items_ui_scroll"
	area.style.fontsize = 30
	area.style.width = 1500
	area.style.height = 350
	table.insert(ui.controls,area)
	
	if(#currentItemMultiSpawned > 0 ) then
		
		if selectedItemMulti ~= nil then
			
			local label = {}
			label.type = "label"
			label.tag ="selected_item_lbl"
			label.trigger = {}
			label.trigger.auto = {}
			label.trigger.auto.name = "auto"
			label.margin = {}
			label.style = {}
			label.margin.top = 15
			label.style.fontsize = 35
			label.parent = "placed_items_ui_varea"
			label.requirement = {}
			
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(label.requirement,requirement)
			label.value = {}
			label.value.type = "text"
			label.value.value =  "Selected : "..selectedItemMulti.Title.."("..selectedItemMulti.Id..")"
			table.insert(ui.controls,label)
		end
		for i = 1, #currentItemMultiSpawned do 
			
			local mitems = currentItemMultiSpawned[i]
			
			local buttons = {}
			buttons.type = "button"
			buttons.title = "Select "..mitems.Title.."("..mitems.Id..")"
			buttons.tag =mitems.Tag.."_button_"..i
			buttons.margin = {}
			buttons.style = {}
			buttons.margin.top = 15
			buttons.style.fontsize = 35
			buttons.style.width = 1000
			buttons.style.height = 100
			buttons.trigger = {}
			buttons.trigger.auto = {}
			buttons.trigger.auto.name = "auto"
			buttons.parent = "placed_items_ui_varea"
			buttons.requirement = {}
			
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(buttons.requirement,requirement)
			buttons.action = {}
			
			local spawn_item = {}
			spawn_item.name = "select_item_multi" 
			spawn_item.value = mitems.Id
			table.insert(buttons.action,spawn_item)
			
			local close_action = {}
			close_action.name = "close_interface" 
			table.insert(buttons.action,close_action)
			table.insert(ui.controls,buttons)
		end
		
		local buttons = {}
		buttons.type = "button"
		buttons.title = "Unselect item"
		buttons.tag ="unselect_button"
		buttons.trigger = {}
		buttons.trigger.auto = {}
		buttons.trigger.auto.name = "auto"
		buttons.margin = {}
		buttons.style = {}
		buttons.parent = "placed_items_ui_varea"
		buttons.style.fontsize = 35
		buttons.style.width = 1450
		buttons.style.height = 100
		buttons.requirement = {}
		
		local requirement = {}
		table.insert(requirement,"auto")
		table.insert(buttons.requirement,requirement)
		buttons.action = {}
		
		local spawn_item = {}
		spawn_item.name = "unselect_item_multi" 
		table.insert(buttons.action,spawn_item)
		
		local close_action = {}
		close_action.name = "close_interface" 
		table.insert(buttons.action,close_action)
		table.insert(ui.controls,buttons)
		currentInterface = ui
		
		if UIPopupsManager.IsReady() then
			
			local notificationData = inkGameNotificationData.new()
			notificationData.notificationName = 'base\\gameplay\\gui\\widgets\\notifications\\shard_notification.inkwidget'
			notificationData.queueName = 'modal_popup'
			notificationData.isBlocking = true
			notificationData.useCursor = true
			UIPopupsManager.ShowPopup(notificationData)
			else
			Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
		end
	end
end


--interact--
function cycleInteract()
	--inputcount = inputcount +1
	
	currentInteractGroupIndex = currentInteractGroupIndex or 1
	inputInAction = false
	logme(1,"possibleInteractDisplay"..#possibleInteractDisplay)
	-- debugPrint(6,"currentInteractGroupIndex"..currentInteractGroupIndex)
	logme(1,"currentInteractGroup"..currentInteractGroup[currentInteractGroupIndex])
	-- debugPrint(6,actionValue)

	if currentPossibleInteractChunkIndex == 0 then
		-- currentPossibleInteractChunkIndex = 1
		candisplayInteract = true
	end

	if candisplayInteract then
		currentPossibleInteractChunkIndex = currentPossibleInteractChunkIndex + 1

		getTriggeredActionsDisplay()

		debugPrint(6,"tyau")
		createInteraction(true)
	end

	if currentPossibleInteractChunkIndex > #possibleInteractDisplay then
		-- currentInteractGroupIndex = currentInteractGroupIndex + 1
		currentPossibleInteractChunkIndex = 0

		-- if(currentInteractGroupIndex > #currentInteractGroup) then
			-- currentInteractGroupIndex = 1
		-- end

		-- Game.GetPlayer():SetWarningMessage(getLang("current_interact_group")..currentInteractGroup[currentInteractGroupIndex])
	end

	if GameController["interactionWidgetGameController"].currentOptions then
		if GameController["interactionWidgetGameController"].id < 1 then
			if currentDialogHub then
				-- createInteraction(false)
				createDialog(currentDialogHub.dial)
				isdialogactivehub = true
			end
		else
			--createInteraction(true)
			isdialogactivehub = false
			debugPrint(6,"tyu")
		end
	else
		createInteraction(true)
		isdialogactivehub = false
		debugPrint(6,"tyuss")
	end

	
end

function cycleInteractgroup()
	inputcount = inputcount +1

	debugPrint(6,"possibleInteractDisplay"..#possibleInteractDisplay)
	-- debugPrint(6,actionValue)

	if currentPossibleInteractChunkIndex == 0 then
		-- currentPossibleInteractChunkIndex = 1
		candisplayInteract = true
	end

	if candisplayInteract then
		currentPossibleInteractChunkIndex = currentPossibleInteractChunkIndex + 1

		getTriggeredActionsDisplay()

		createInteraction(true)
	end

	if currentPossibleInteractChunkIndex > #possibleInteractDisplay then
		currentPossibleInteractChunkIndex = 0

		if  currentInteractGroupIndex > #currentInteractGroup then
			currentInteractGroupIndex = 1
		end

		Game.GetPlayer():SetWarningMessage(getLang("current_interact_group")..currentInteractGroup[currentInteractGroupIndex])
	end

	if GameController["interactionWidgetGameController"].currentOptions ~= nil then
		if GameController["interactionWidgetGameController"].id < 1 then
			if currentDialogHub then
				-- createInteraction(false)
				createDialog(currentDialogHub.dial)
				isdialogactivehub = true
			end
		else
			--createInteraction(true)
			isdialogactivehub = false
		end
	else
		createInteraction(true)
		isdialogactivehub = false
	end
end

function hideInteract()
	if candisplayInteract then
		currentPossibleInteractChunkIndex = 0

		createInteraction(false)
		candisplayInteract = false
	end
end



---Radio---
function playRadio()
	
	if(currentRadio ~= nil and currentRadio.radio ~= nil) then
		
		if currentRadio.radio.tracks ~= nil and #currentRadio.radio.tracks > 0  then
			
			local canplay = true
			
			if(currentRadio.radio.only_in_car == true) then
				canplay = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
				else
				canplay = true
			end
			
			if(currentRadio.isplaying == nil and IsPlaying("music") == true) then
				Stop("music")
			end
			
			
			if(canplay and (IsPlaying("music") == false))then
				
				local index = math.random(1,#currentRadio.radio.tracks)
				
				local song = currentRadio.radio.tracks[index]
				currentRadio.isplaying = true
				
				local actionlist = {}
				
				local action = {}
				action = {}
				action.name = "play_sound_file"
				action.value = song.file
				action.datapack = currentRadio.namespace
				action.volume = currentRadioVolume
				action.channel = "music"
				table.insert(actionlist,action)
				runActionList(actionlist, "play_radio_radio_"..currentRadio.radio.tag, "interact",false,"nothing",true)
				else
				
				if(currentRadio.radio.only_in_car == true) then
					
					local iscar = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
					
					if(iscar == false) then
						
						Stop("music")
					end
				end
			end
		end
	end
end

function openRadio()
	if GameController["PopupsManager"] and not popupActive then
		popupActive = true
		GameController["PopupsManager"]:SpawnVehicleRadioPopup()
	end
end

function playRandomfromRadio()
	
	if currentRadio.tracks ~= nil and #currentRadio.tracks > 0 then
		
		if(IsPlaying("music") == false) then
			
			local canplay = true
			
			if(autoplayincar) then
				canplay = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
			end
			
			if(canplay)then
				
				local index = math.random(1,#currentRadio.tracks)
				
				local song = currentRadio.tracks[index]
				
				if(shuffleall) then
					local numitems = 0 -- find the size of the table
					
					for k,v in pairs(arrayRadio) do
						numitems = numitems + 1
					end

					local randval = math.random(1, numitems) -- get a random point

					local randentry
					local count = 0
					
					for k,v in pairs(arrayRadio) do
						count = count + 1
						if(count == randentry) then
							currentRadio = v.radio
							break
						end
					end
					
					index = math.random(1,#currentRadio.tracks)
					song = currentRadio.tracks[index]
				end
				
				local sound = getSoundByNameNamespace(song.file,currentRadio.namespace)
				
				if(sound ~= nil) then
					
					local path = cyberscript.soundpath..sound.path
					debugPrint(6,path..sound.name)
					PlaySound(sound.name,path,"music",currentRadioVolume)
					
					local message = SimpleScreenMessage.new()
					message.message = "Currently Playing : "..sound.name.." From Radio "..currentRadio.name
					message.isShown = true
					
					local blackboardDefs = Game.GetAllBlackboardDefs()
					
					local blackboardUI = Game.GetBlackboardSystem():Get(blackboardDefs.UI_Notifications)
					blackboardUI:SetVariant(
						blackboardDefs.UI_Notifications.OnscreenMessage,
						ToVariant(message),
						true
					)
				end
			end
			else
			
			if(autoplayincar) then
				
				local iscar = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
				
				if(iscar == false) then
					debugPrint(6,"stop music")
					Stop("music")
				end
			end
		end
	end
end

function RadioWindows()
	CPS.colorBegin("Button", IRPtheme.PhoneRadioButton)
	CPS.colorBegin("Text", IRPtheme.PhoneRadioText)
	
	if ImGui.BeginTabItem("Radio") then
		
		if ImGui.BeginTabBar("RadioTabs", ImGuiTabBarFlags.NoTooltip) then
			CPS.styleBegin("TabRounding", 0)
			for k,v in pairs(arrayRadio) do
				
				local radio = v.radio
				
				if ImGui.BeginTabItem(radio.name) then
					autoplayRadio = ImGui.Checkbox("AutoPlay", autoplayRadio)
					ImGui.SameLine()
					autoplayincar = ImGui.Checkbox("In Car Only ?", autoplayincar)
					ImGui.SameLine()
					shuffleall = ImGui.Checkbox("Shuffle All", shuffleall)
					ImGui.SameLine()
					
					if ImGui.Button("Pause/Resume", 100, 0) then
						
						if(pausemusic == false) then
							pausemusic = true
							Pause("music")
							else
							pausemusic = false
							Resume("music")
						end
					end
					ImGui.SameLine()
					
					if ImGui.Button("Stop", 100, 0) then
						Stop("music")
						currentRadio = {}
					end
					ImGui.SameLine()
					ImGui.PushItemWidth(150)  
					currentRadioVolume, used = ImGui.SliderInt("Volume", currentRadioVolume, 0, 100, "%d")
					for y = 1, #radio.tracks do
						
						local song = radio.tracks[y]
						
						if ImGui.Button(song.name, 300, 0) then
							currentRadio = radio
							
							local sound = getSoundByNameNamespace(song.file,currentRadio.namespace)
							
							if(sound ~= nil) then
								
								local path = cyberscript.soundpath..sound.path
								debugPrint(6,path..sound.name)
								PlaySound(sound.name,path,"music",currentRadioVolume)
							end
						end
					end
					ImGui.EndTabItem()
				end
			end
			CPS.styleEnd(1)
			ImGui.EndTabBar()
		end
		ImGui.EndTabItem()
	end
	CPS.colorEnd(1)
	CPS.colorEnd(1)
end


---UI factory---
function WindowsItem()
	
	if(currentInterface["values"] == nil) then
		currentInterface["values"] = {}
	end
	
	if ImGui.Begin(currentInterface.title) then
		ImGui.SetNextWindowPos(currentInterface.x, currentInterface.y, ImGuiCond.Appearing) -- set window position x, y
		ImGui.SetNextWindowPos(currentInterface.x, currentInterface.y, ImGuiCond.FirstUseEver) -- set window position x, y
		ImGui.SetNextWindowSize(currentInterface.width, currentInterface.heigh, ImGuiCond.Appearing) -- set window size w, h
		ImGui.SetWindowSize(currentInterface.width, currentInterface.heigh)
		
		if ImGui.Button(lang.Close) then
			openInterface = false
		end
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		windowsFactory()
		ImGui.End()
	end
end

function windowsFactory()
	for i=1,#currentInterface.controls do
		
		if(currentInterface.controls[i].type == "sameline") then
			ImGui.SameLine()
		end
		
		if(currentInterface.controls[i].type == "linebreak") then
			ImGui.Separator()
		end
		
		if(currentInterface.controls[i].type ~= "sameline" and currentInterface.controls[i].type ~= "linebreak") then
			
			if(checkTriggerRequirement(currentInterface.controls[i]["requirement"],currentInterface.controls[i]["trigger"])) then
				
				if(currentInterface.controls[i].type == "text") then
					
					if(currentInterface.controls[i].value.type == "text") then
						currentInterface["values"][currentInterface.controls[i].tag] = ImGui.InputText(currentInterface.controls[i].title, currentInterface["values"][currentInterface.controls[i].tag], 100, ImGuiInputTextFlags.AutoSelectAll)
						elseif(currentInterface.controls[i].value.type == "variable") then
						
						local variable = getVariableKey(currentInterface.controls[i].value.tag,currentInterface.controls[i].value.key)
						
						if(variable== nil) then
							variable = ""
						end
						currentInterface["values"][currentInterface.controls[i].tag] = ImGui.InputText(currentInterface.controls[i].title, variable, 100, ImGuiInputTextFlags.AutoSelectAll)
					end
				end
				
				if(currentInterface.controls[i].type == "label") then
					
					if(currentInterface.controls[i].value.type == "text") then
						ImGui.TextWrapped(currentInterface.controls[i].value.value)
						elseif(currentInterface.controls[i].value.type == "score") then
						
						local score = getScoreKey(currentInterface.controls[i].value.tag,currentInterface.controls[i].value.key)
						
						if(score== nil) then
							score = 0
						end
						ImGui.TextWrapped(score)
						elseif(currentInterface.controls[i].value.type == "variable") then
						
						local variable = getVariableKey(currentInterface.controls[i].value.tag,currentInterface.controls[i].value.key)
						
						if(variable== nil) then
							variable = ""
						end
						ImGui.TextWrapped(variable)
					end
				end
				
				if(currentInterface.controls[i].type == "number") then
					
					if(currentInterface.controls[i].value.type == "text") then
						currentInterface["values"][currentInterface.controls[i].tag] = ImGui.InputFloat(currentInterface.controls[i].title, currentInterface.controls[i].value, 1, 10, "%.1f", ImGuiInputTextFlags.None)
						elseif(currentInterface.controls[i].value.type == "score") then
						
						local score = getScoreKey(currentInterface.controls[i].value.tag,currentInterface.controls[i].value.key)
						
						if(score== nil) then
							score = 0
						end
						currentInterface["values"][currentInterface.controls[i].tag] = ImGui.InputFloat(currentInterface.controls[i].title, score, 1, 10, "%.1f", ImGuiInputTextFlags.None)
					end
				end
				
				if(currentInterface.controls[i].type == "button") then
					
					if ImGui.Button(currentInterface.controls[i].title) then
					end
				end
			end
		end
	end
end

function createButton(name, text, fontsize,width,height)
	
	local button = inkCanvas.new()
	button:SetName(name)
	button:SetSize(width, height)
	button:SetAnchorPoint(Vector2.new({ X = 0.5, Y = 0.5 }))
	button:SetInteractive(true)
	
	local bg = inkImage.new()
	bg:SetName('bg')
	bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
	bg:SetTexturePart('cell_bg')
	bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
	bg:SetOpacity(0.8)
	bg:SetAnchor(inkEAnchor.Fill)
	bg.useNineSliceScale = true
	bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
	bg:Reparent(button, -1)
	
	local fill = inkImage.new()
	fill:SetName('fill')
	fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
	fill:SetTexturePart('cell_bg')
	fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
	fill:SetOpacity(0.0)
	fill:SetAnchor(inkEAnchor.Fill)
	fill.useNineSliceScale = true
	fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
	fill:Reparent(button, -1)
	
	local frame = inkImage.new()
	frame:SetName('frame')
	frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
	frame:SetTexturePart('cell_fg')
	frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
	frame:SetOpacity(0.3)
	frame:SetAnchor(inkEAnchor.Fill)
	frame.useNineSliceScale = true
	frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
	frame:Reparent(button, -1)
	
	local label = inkText.new()
	label:SetName('label')
	label:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
	label:SetFontStyle('Medium')
	label:SetFontSize(fontsize)
	label:SetLetterCase(textLetterCase.UpperCase)
	label:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
	label:SetAnchor(inkEAnchor.Fill)
	label:SetHorizontalAlignment(textHorizontalAlignment.Center)
	label:SetVerticalAlignment(textVerticalAlignment.Center)
	label:SetText(text)
	label:Reparent(button, -1)
	return button
end



---Native Interaction---
function createInteractionChoice(action, title)
	
	local choiceData =  InteractionChoiceData.new()
	choiceData.
	localizedName = title
	choiceData.inputAction = action
	
	local choiceType = ChoiceTypeWrapper.new()
	choiceData.type = choiceType
	return choiceData
end

function createInteractionHub(active)
	
	if(choiceHubData == nil) then
		choiceHubData =  gameinteractionsvisInteractionChoiceHubData.new()
		choiceHubData.active =true 
		choiceHubData.flags = EVisualizerDefinitionFlags.Undefined
		choiceHubData.title = "possibleInteractList" --'Test Interaction Hub'
	end
	choiceHubData.active = active
	
	local choices = {}
	possibleInteractdisplayUI = {}
	-- table.insert(choices, createInteraction('Choice1', 'Blow up the sky'))
	
	if(active == true) then
		
		if(#loadInteract > 0) then
			for z=1,#loadInteract do 
				local interact = arrayInteract[loadInteract[z]].interact
					if(interact.type == nil or interact.type == "interact") then
						
						checkContext(interact)
						
					
					
					
						table.insert(choices, createInteractionChoice('Choice'..z, getLang(interact.name)))
					end
				end
		else
		
			if possibleInteractDisplay ~= nil and currentPossibleInteractChunkIndex ~= nil and #possibleInteractDisplay > 0  and possibleInteractDisplay[currentPossibleInteractChunkIndex] ~= nil then
				for z=1,#possibleInteractDisplay[currentPossibleInteractChunkIndex] do 
				
					local interact = possibleInteractDisplay[currentPossibleInteractChunkIndex][z]
					checkContext(interact)
				
					
					if(interact.type == nil or interact.type == "interact") then
						interact.input = z
						table.insert(choices, createInteractionChoice('Choice'..z, getLang(interact.name)))
					else
						showInputHint(interact.key, getLang(interact.name), 1, interact.hold, interact.tag)
					end
				end
				
			end
		end
		else
		choiceHubData.id = 0 - math.random(50,1000)
	end
	choiceHubData.choices = choices
end




function prepareVisualizersInfo(hub)
	
	local visualizersInfo = VisualizersInfo.new()
	visualizersInfo.activeVisId = hub.id
	visualizersInfo.visIds = { hub.id }
	return visualizersInfo
end

function createInteraction(active)
	
	local blackboardDefs = Game.GetAllBlackboardDefs()
	
	local interactionBB = Game.GetBlackboardSystem():Get(blackboardDefs.UIInteractions)
	
	local value = FromVariant(interactionBB:GetVariant(blackboardDefs.UIInteractions.InteractionChoiceHub))
	createInteractionHub(active)
	
	local interactionHub = choiceHubData
	
	local visualizersInfo = prepareVisualizersInfo(interactionHub)
	interactionBB:SetVariant(blackboardDefs.UIInteractions.InteractionChoiceHub, ToVariant(interactionHub), true)
	interactionBB:SetVariant(blackboardDefs.UIInteractions.VisualizersInfo, ToVariant(visualizersInfo), true)
end


---Native Dialog---
function createDialog(dialog)
	isdialogactivehub = true
	candisplayInteract = false
	createInteraction(false)
	
	local dialogHub = createDialogHub(dialog,true)
	currentDialogHub = {}
	currentDialogHub.hub= {}
	currentDialogHub.dial = {}
	currentDialogHub.index = 1
	currentDialogHub.hub = dialogHub
	currentDialogHub.dial = dialog
	
	local blackboardDefs = Game.GetAllBlackboardDefs()
	
	local interactionBB = Game.GetBlackboardSystem():Get(blackboardDefs.UIInteractions)
	interactionBB:SetVariant(blackboardDefs.UIInteractions.DialogChoiceHubs, ToVariant(dialogHub), true)
	isdialogactivehub = true
	
	if(playerisstopped == false) then
		StatusEffectHelper.ApplyStatusEffect(Game.GetPlayer(), "GameplayRestriction.FistFight")
		playerisstopped = true
	end
end

function createDialogHub(dialogIIRP,active)
	
	local choiceHubDataDial =  gameinteractionsvisDialogChoiceHubs.new()
	
	local choiceHubs = {}
	
	if(active == true) then
		table.insert(choiceHubs ,createDialogTitle(dialogIIRP,active))
	end
	choiceHubDataDial.choiceHubs = choiceHubs
	return choiceHubDataDial
end

function createDialogTitle(dialogIIRP,active)
	
	local dialog =  gameinteractionsvisListChoiceHubData.new()
	dialog.id = 0 - math.random(50,1000)
	
	if(active == true) then
		dialog.activityState =Enum.new('gameinteractionsvisEVisualizerActivityState', 'Active')
		else
		dialog.activityState =Enum.new('gameinteractionsvisEVisualizerActivityState', 'None')
	end
	
	dialog.flags = Enum.new('gameinteractionsvisEVisualizerDefinitionFlags', 'HeadlineSelection')
	dialog.isPhoneLockActive = true
	dialog.title =  getDialogOwner(dialogIIRP.speaker.value)
	dialog.hubPriority  = 0
	dialog.activityState  =  Enum.new('gameinteractionsvisEVisualizerActivityState', 'Active')
	
	local choices = {}
	for i = 1, #dialogIIRP.options do
		
		local option = dialogIIRP.options[i]
		dialogIIRP.options[i].input = i
		table.insert(choices, creatDialogChoice('Choice'..i, getLang(option.Description),option.icon,option.choicetype))
	end
	dialog.choices = choices
	return dialog
end


function getDialogOwner(speaker)
	
	local result = speaker
	
	if(speaker == "any") then
		if(currentNPC ~= nil) then
			result = currentNPC.Names
		elseif(currentStar ~= nil) then
			result = currentStar.Names
		else
			result = speaker
		end
	end
	
	return result
	
end

function creatDialogChoice(action, title, icon, optionchoice)
	
	local choiceData =  gameinteractionsvisListChoiceData.new()
	choiceData.localizedName = getLang(title)
	choiceData.inputAction = action
	
	local choiceType = gameinteractionsChoiceTypeWrapper.new()
	choiceType:SetType(choiceType,Enum.new('gameinteractionsChoiceType', 'Inactive'))
	
  if icon ~= nil then
		local iconrecord = TweakDBInterface.GetChoiceCaptionIconPartRecord("ChoiceCaptionParts."..icon)
        local part = gameinteractionsChoiceCaption.new()
        part:AddPartFromRecord(iconrecord)
        choiceData.captionParts = part
    end
	
	
	 if optionchoice ~= nil then
        local choiceType = gameinteractionsChoiceTypeWrapper.new()
        choiceType:SetType(optionchoice)
     
    end
	
	choiceData.type = choiceType
	return choiceData
end

function removeDialog()
	
	local blackboardDefs = Game.GetAllBlackboardDefs()
	
	local interactionBB = Game.GetBlackboardSystem():Get(blackboardDefs.UIInteractions)
	interactionBB:SetVariant(blackboardDefs.UIInteractions.DialogChoiceHubs, ToVariant(gameinteractionsvisDialogChoiceHubs.new()), true)
	
	if(playerisstopped == true) then
		StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.FistFight")
		playerisstopped = false
	end
end
