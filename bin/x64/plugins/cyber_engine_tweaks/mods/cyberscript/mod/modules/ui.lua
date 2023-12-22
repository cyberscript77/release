logme(1,"CyberScript: UI module loaded")
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
		
		if file_exists("editor/editor.lua") then
			editorUIManager["editorWindows"] = overlayOpen
		end
		
		
		if(overlayOpen ) then
			
			
			if file_exists("editor/editor.lua") then
				cyberscript.editor2.editorWindowsManager()
			end
			
		end
		
		
		if(openColorPicker) then
			colorPicker() 
		end
		
		
		if isFadeIn then
			fadeinwindows()
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
					
					----print(dump(control.data))
					logme(1,dump(control.data))
					
				end
				
				
				if(control.data.type == "label" or control.data.type == "textinput") then
					
					
					
					-- labelcount = labelcount +1
					-- topmargin = topmargin+uimargintop
					-- local texttoDisplay = ""
					
					
					
					
					if(control.data.dynamic == nil) or (table_contains(control.data.dynamic,"text")) or (table_contains(control.data.dynamic,"default"))  then 
						
						if(control.split and control.split > 0) then
							
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
						
						
						if(control.data.scrollspeed and control.data.scrollspeed > 0) then
							
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
						
						-- if(control.tag == "popup_border") then
						
						-- --print(dump(control.data.textcolor))
						
						-- end
						
						
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


function createdefaultOption(tag,maxkey)
	local defaultinput = {}
	
	for i=1,maxkey do
	
		defaultinput[tag.."_"..i] = "IK_F1"
		defaultinput[tag.."_hold_"..i] = false
	
	end
	
	 defaultinput[tag.."_keys"] = 1
	
   return defaultinput
end


function buildWebPageBountonSquare(parent,imageprop,textprop,page,action,customimage)
	local selectionImage = inkImage.new()
	
	if(customimage ~= nil and customimage == true) then 
		selectionImage:SetAtlasResource(ResRef.FromName(imageprop.tweak))
		selectionImage:SetTexturePart(imageprop.texture)
		imageprop.scale.x = 1.3
		imageprop.scale.y = 1
		
		else
		local stickerRecord = TDB.GetPhotoModeStickerRecord(imageprop.tweak)
		selectionImage:SetAtlasResource(stickerRecord:AtlasName())
		selectionImage:SetTexturePart(stickerRecord:ImagePartName())
		
		
	end
	
	
	selectionImage:SetName(CName.new(imageprop.tag))
	selectionImage:SetMargin(imageprop.margin)
	selectionImage:SetSize(Vector2.new({ X = imageprop.size.x, Y = imageprop.size.y }))
	selectionImage:SetFitToContent(imageprop.fittocontent)
	
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
				if(control.scrollspeed and (control.scrolldelay == nil or control.autoscroll == nil)) then control.scrolldelay = 30 control.autoscroll = true end
				
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
					
					if(control.split and control.split > 0) then
						
						local desctab = splitByChunk(control.text, control.split)
						local descc = desctab
						
						
						widgetcontrol:SetText(descc)
						else
						widgetcontrol:SetText(control.text)
					end
					
					widgetcontrol:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					widgetcontrol:SetFontStyle('Medium')
					widgetcontrol:SetFontSize(fontsize)
					widgetcontrol:SetHorizontalAlignment(control.horizontalalign)
					widgetcontrol:SetVerticalAlignment(control.verticalalign)
					
					
					if(control.scrollspeed and control.scrollspeed > 0) then
						
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
					widgetcontrol = UIButton.Create(buttonData.name, buttonData.text,fontsize, control.size.width, control.size.height,control.margin,bgcolor,textcolor)
					
					widgetcontrol:RegisterCallback('OnRelease', function(button, evt)
						
						
						runActionList(control.action, control.tag, "interact",false,"nothing",false)
						
						evt:Handle()
						
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
					
					--logme(2,"button")
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
						EventProxy.RegisterCallback(widgetcontrol, event.eventname, function(_, evt)
							
							if( event.action ~= nil and #event.action > 0 and workerTable[control.tag..event.eventname] == nil) then
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
					
					else
					
					-- widgetcontrol.root:SetName(CName.new(control.tag))
					widgetcontrol.root:SetFitToContent(control.fittocontent)
					-- widgetcontrol.root:SetTintColor(textcolor)
					widgetcontrol.root:SetSize(Vector2.new({ X = width, Y = height }))
					-- widgetcontrol.root:SetScale(Vector2.new({ X = scalewidth, Y = scaleheight }))
					-- widgetcontrol.root:SetInteractive(control.interactive)
					widgetcontrol.root:SetMargin(inkMargin.new(control.margin))
					widgetcontrol.root:SetAnchor(control.anchor)
					-- widgetcontrol.root:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
					-- widgetcontrol.root:SetOpacity(control.opacity)
					-- widgetcontrol.root:SetRotation(control.rotation)
					-- widgetcontrol.root:SetVisible(control.visible)
					-- widgetcontrol.root:SetTranslation(Vector2.new({ X = translationwidth, Y = translationheight }))
					-- widgetcontrol.root:SetPadding(inkMargin.new(control.padding))
					-- widgetcontrol.root:SetRenderTransformPivot(Vector2.new({ X = transformwidth, Y = transformheight }))
					-- widgetcontrol.root:SetState("default")
					if(control.type == "scrollarea") then
						--widgetcontrol:GetWidgetByIndex(0):SetSize(Vector2.new({ X = width, Y = height }))
					end
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
			
			logme(1,control.tag)
			logme(1,result)
			logme(1,dump(control))
			
			
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
		nativeSettings.data["CSKEYBIND"] = nil
		nativeSettings.addTab("/CSKEYBIND", getLang("CyberScript KeyBinding"))
		nativeSettings.addSubcategory("/CSKEYBIND/gameplay", getLang("Gameplay"))
		
		local info = inputManager.createBindingInfo() -- Create an info table that holds information for a binding, makes it easier to reuse later
		info.keybindLabel = "Key for open group Interact Menu #" -- Label of each key, will be followed by the key number, e.g. "Key 1"
		info.keybindDescription = "Keybind for open group Interact Menu" -- Description that'll be displayed for all the bindings keys
		info.supportsHold = false -- Whether to show the hold switches for this bindings keys
		info.isHoldLabel = "Hold the key ?"
		info.isHoldDescription = "Key need to be holded for trigger the event"
		info.id = "cyberscriptOpenGroup" -- Unique id for the binding, used for the savedOptions/defaultOptions tables and the saveCallback. See above for more details
		info.maxKeys = 3 -- Maximum amount of keys for this binding, shows a slider if it is bigger than 1
		info.maxKeysLabel = "Hotkey Keys Amount" -- Label for the binding's key amount slider
		info.maxKeysDescription = "Changes how many keys this hotkey has, all of them have to pressed for the Group Menu to be activated" -- Description for the binding's key amount slider
		info.nativeSettingsPath = "/CSKEYBIND/gameplay" -- Native settings path for where to add the bindigs options, if it is a multikey binding it has to be a seperate subcategory
		info.defaultOptions = createdefaultOption("cyberscriptOpenGroup",3) -- Table containing the default options
		info.savedOptions = arrayUserInput -- Table containing the current options
		info.forceHold = false
		info.saveCallback = function(name, value) -- Callback for when anything about the binding gets changed, gets the changed variable's generated name + the value
			 -- Store changed value
			arrayUserInput[name] = value
		end
		info.callback = function() -- Callback for when the binding has been activated
			
			if(newgroupinteractUI) then
				cycleInteract2()
			else
				cycleInteract()
			end
		end
		inputManager.addNativeSettingsBinding(info) 
		
	-- Add our mods tab (path, label)
	if(isEmpty(cyberscript.cache["setting"]) == false) then
		nativeSettings.data["CMCUSTOM"] = nil
		nativeSettings.addTab("/CMCUSTOM", getLang("ui_setting_customsetting")) -- Add our mods tab (path, label)
		if cyberscript.cache["setting"] ~= nil then
			for k,v in pairs(cyberscript.cache["setting"]) do
				local setting = v.data
				
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
						setVariable(setting.variable.tag,setting.variable.key,value)
						--print(tostring(setting.variable.tag))
						--print(tostring(setting.variable.key))
						--print(tostring(value))
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
				
				if setting.type == "input" then
					local info = inputManager.createBindingInfo() -- Create an info table that holds information for a binding, makes it easier to reuse later
					info.keybindLabel = setting.label -- Label of each key, will be followed by the key number, e.g. "Key 1"
					info.keybindDescription = setting.description -- Description that'll be displayed for all the bindings keys
					info.supportsHold = setting.hold -- Whether to show the hold switches for this bindings keys
					info.isHoldLabel = "Hold the key ?"
					info.isHoldDescription = "Key need to be holded for trigger the event"
					info.id = setting.tag -- Unique id for the binding, used for the savedOptions/defaultOptions tables and the saveCallback. See above for more details
					info.maxKeys = setting.maxkeys -- Maximum amount of keys for this binding, shows a slider if it is bigger than 1
					info.maxKeysLabel = "Max keys that can be bounded for trigger the event" -- Label for the binding's key amount slider
					info.maxKeysDescription = "Changes how many keys this hotkey has, all of them have to pressed for the hotkey to be activated" -- Description for the binding's key amount slider
					info.nativeSettingsPath = "/CMCUSTOM/"..setting.category, setting.categorylibelle -- Native settings path for where to add the bindigs options, if it is a multikey binding it has to be a seperate subcategory
					info.defaultOptions = createdefaultOption(setting.tag,setting.maxkeys) -- Table containing the default options
					info.savedOptions = arrayUserInput -- Table containing the current options
					info.forceHold = setting.forcehold
					info.saveCallback = function(name, value) -- Callback for when anything about the binding gets changed, gets the changed variable's generated name + the value
						-- Store changed value
							arrayUserInput[name] = value
					end
					info.callback = function() -- Callback for when the binding has been activated
						
						if(cyberscript.cache["event"][setting.targetevent] ~= nil) then
							local event = cyberscript.cache["event"][setting.targetevent].data
							checkContext(event)
							
							if(event.way == "input" and checkTriggerRequirement(event.requirement,event.trigger) and workerTable[setting.targetevent] == nil)then
								
								runActionList(event.action,setting.targetevent,"event",false,"nothing")
								
							end
							
						end
					end
					inputManager.addNativeSettingsBinding(info) 
					
				end
			end
		end
		else
		
		nativeSettings.data["CMCUSTOM"] = nil
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
		Double_Jump_Height==nil or
	UltraSpeedDodge==nil) then
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
	obj.UltraSpeedDodge = tostring(UltraSpeedDodge)
	
	
	
	
	else
	local status, result =  pcall(function()
		
		nativeSettings.addSubcategory("/CM/general", getLang("General")) -- Optional: Add a subcategory (path, label), you can add as many as you want
		
		settingsTables["disabled"] =  
		nativeSettings.addSwitch("/CM/general",  getLang("Disable CyberScript"),  getLang("Disable CyberScript"), moddisabled, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			moddisabled = state
			updateUserSetting ("moddisabled", moddisabled)
		end)
		
		
		nativeSettings.addSubcategory("/CM/gameplay", getLang("ui_setting_gameplay")) -- Optional: Add a subcategory (path, label), you can add as many as you want
		
		settingsTables["gamepad"] =  
		nativeSettings.addSwitch("/CM/gameplay",  getLang("ui_setting_gameplay_controller"),  getLang("ui_setting_gameplay_controller"), currentController == "gamepad", false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			currentController = state == false and "mouse" or "gamepad"
			updateUserSetting("currentController", state)
		end)
		
		
		
		nativeSettings.addSubcategory("/CM/script", "Script Settings")
		
		
		nativeSettings.addRangeInt("/CM/script", getLang("SetAmbushMinTime"), getLang("SetAmbushMinTime"), 1, 120, 1, AmbushMin, 5, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
			AmbushMin = value
			updateUserSetting("AmbushMin", value)
		end)
		
		
		nativeSettings.addRangeInt("/CM/script", getLang("Point of Interest Detection Range"), getLang("Automatic Point of Interest Detection Range"), 1, 100, 1, CurrentPOIDetectionRange, 10, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
			CurrentPOIDetectionRange = value
			updateUserSetting("CurrentPOIDetectionRange", value)
		end)
		
		
		
		nativeSettings.addSwitch("/CM/script", getLang("Enable Logging"), getLang("Enable Logging (can impact performance)"), debugLog, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			debugLog = state
			updateUserSetting("debugLog", state)
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
		
		
		nativeSettings.addRangeFloat("/CM/hud", getLang("ui_setting_gameplay_scroll"),  getLang("ui_setting_gameplay_scroll"), 0.001, 0.1, 0.001, "%.3f", ScrollSpeed, ScrollSpeed, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
			pcall(function() 
				ScrollSpeed = tonumber(string.format("%.3f", value))
				updateUserSetting("ScrollSpeed", ScrollSpeed)
			end)
		end)
		
		
		nativeSettings.addSwitch("/CM/hud", getLang("Show Cyberscript Fixer on Map"), getLang("Show Cyberscript Fixer on Map"), showcyberscriptfixeronmap, true, function(state) -- path, label, desc, currentValue, defaultValue, callback
			showcyberscriptfixeronmap = state
			updateUserSetting("showcyberscriptfixeronmap", state)
			if(showcyberscriptfixeronmap) then
				setNewFixersPoint()
				else
				removeFixersPoint() 
			end
		end)
		
		
		nativeSettings.addSwitch("/CM/hud", getLang("Mods interacts displayed as dialog"), getLang("Mods interacts displayed as dialog"), newgroupinteractUI, true, function(state) -- path, label, desc, currentValue, defaultValue, callback"), enableLocation, true, function(state) -- path, label, desc, currentValue, defaultValue, callback
			newgroupinteractUI = state
			updateUserSetting("newgroupinteractUI", state)
			
		end)
		
		nativeSettings.addSubcategory("/CM/quests",getLang("Quest setting"))
		
		nativeSettings.addButton("/CM/quests", getLang("ui_setting_actions_untrackquest"), getLang("ui_setting_actions_untrackquest"),"Untrack", 45, function()
			Game.GetJournalManager():TrackEntry(JournalEntry.new())
			
		end)
		
		nativeSettings.addSwitch("/CM/quests", getLang("Enable Custom Quest"), getLang("Enable Custom Quest"), enableCustomQuest, true, function(state) -- path, label, desc, currentValue, defaultValue, callback
			enableCustomQuest = state
			updateUserSetting("enableCustomQuest", enableCustomQuest)
		end)
		
		nativeSettings.addButton("/CM/quests",  getLang("ui_setting_actions_resetquest"),  getLang("ui_setting_actions_resetquest"), "Reset CS Quest", 45, function()
			if currentQuest then
				resetQuest()
			end
			
		end)
		
		nativeSettings.addButton("/CM/quests", getLang("ui_setting_actions_cleanthemess"), getLang("ui_setting_actions_cleanthemess"), "Clean the mess", 45, function()
			
			despawnAll()
			workerTable = {}
			
		end)
		
		
		
		
		
		nativeSettings.addSubcategory("/CM/affinity",getLang("Affinity setting"))
		
		nativeSettings.addButton("/CM/affinity", getLang("ui_setting_actions_recalculateaffinity"), getLang("ui_setting_actions_recalculateaffinity_msg"),"Recalculate", 45, function()
			
			
			for k,v in pairs(cyberscript.cache["faction"]) do
				setScore(k, "Score", 0)
			end
			
			
			for k,v in pairs(cyberscript.entitieshash) do
				
				setScore(v.entity_name, "Score", 0)
				
				
			end
			
			
			GangAffinityCalculator()
			initGangRelation()
			initGangDistrictScore()
			
		end)
		
		nativeSettings.addButton("/CM/affinity", getLang("ui_setting_actions_cleareaffinity"), getLang("ui_setting_actions_recalculateaffinity_msg"),"Clear", 45, function()
			for k,v in pairs(cyberscript.cache["faction"]) do
				setScore("Affinity",k, 0)
			end
			for k,v in pairs(cyberscript.entitieshash) do
				
				setScore(v.entity_name, "Score", 0)
				
				
			end
			
			
		end)
		
		
		nativeSettings.addSubcategory("/CM/modsetting",getLang("Mod setting"))
		
		
		
		nativeSettings.addSwitch("/CM/modsetting", getLang("Auto Refresh Mods When Pause Menu"), getLang("Auto Refresh Mods When Pause Menu"), AutoRefreshDatapack, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			AutoRefreshDatapack = state
			updateUserSetting("AutoRefreshDatapack", AutoRefreshDatapack)
		end)
		
		nativeSettings.addButton("/CM/modsetting", getLang("ui_setting_actions_refresh"), getLang("ui_setting_actions_refresh"), "Refresh", 45, function()
			CheckandUpdateDatapack()
			LoadDataPackCache()
			logme(2,"CyberScript : Datapack Cache refreshed")
			
		end)
		
		nativeSettings.addButton("/CM/modsetting", getLang("ui_setting_actions_rebuild"), getLang("ui_setting_actions_rebuild"), "Rebuild", 45, function()
			
			local reader = dir("user/cache")
			
			for i=1, #reader do 
				if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
					
					os.remove('user/cache/'..reader[i].name)
					
					
					
					
				end
			end
			
			
			ImportDataPack()
			CheckandUpdateDatapack()
			LoadDataPackCache()
			logme(2, getLang("ui_setting_actions_rebuild_done"))
			
		end)
		
		nativeSettings.addButton("/CM/modsetting", "!!! Reset the mod !!! ", "WARNING : Will totaly delete downloaded Mods, cache and session", "Reset the mod", 45, function()
			
			if file_exists("user/sessions/latest.txt") then
				os.remove("user/sessions/latest.txt")
			end
			
			
			local reader = dir("user/sessions")
			
			
			for i=1, #reader do 
				if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
					
					os.remove('user/sessions/'..reader[i].name)
					
					
					
					
				end
			end
			
			local reader = dir("datapack")
			for i=1, #reader do 
				if(tostring(reader[i].type) == "directory") then
					
					os.remove('datapack/'..reader[i].name)
					
					
					
					
				end
			end
			
			local reader = dir("user/cache")
			for i=1, #reader do 
				if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
					
					os.remove('user/cache/'..reader[i].name)
					
					
					
					
				end
			end
			
			
			ImportDataPack()
			LoadDataPackCache()
			logme(2, getLang("ui_setting_actions_rebuild_done"))
			
		end)
		
		
		
		nativeSettings.addTab("/CMCHEAT", getLang("ui_setting_cheat")) -- Add our mods tab (path, label)
		
		nativeSettings.addSubcategory("/CMCHEAT/player", getLang("ui_setting_cheat")) -- Optional: Add a subcategory (path, label), you can add as many as you want
		
		nativeSettings.addSwitch("/CMCHEAT/player",  getLang("ui_setting_cheat_infinite_doublejump"),  getLang("ui_setting_cheat_infinite_doublejump"), InfiniteDoubleJump, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			InfiniteDoubleJump = state
			updateUserSetting("InfiniteDoubleJump", InfiniteDoubleJump)
		end)
		
		nativeSettings.addRangeInt("/CMCHEAT/player", getLang("Jump limit"),  getLang("100 = infinite"), 2, 100, 1, numberOfMultiJumps, 2, function(value)
			pcall(function() 
				numberOfMultiJumps = value
				updateUserSetting("numberOfMultiJumps", numberOfMultiJumps)
				
				
			end)
		end)
		
		
		nativeSettings.addSwitch("/CMCHEAT/player",  getLang("ui_setting_cheat_disable_fall_damage"),  getLang("ui_setting_cheat_disable_fall_damage"), DisableFallDamage, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			DisableFallDamage = state
			updateUserSetting("DisableFallDamage", DisableFallDamage)
		end)
		
		nativeSettings.addSwitch("/CMCHEAT/player",  getLang("Immortal"),  getLang("Immortal"), Immortal, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			Immortal = state
			updateUserSetting("Immortal", Immortal)
			
			if (Immortal) then
				
				Game.GetGodModeSystem():EnableOverride(Game.GetPlayer():GetEntityID(), "Invulnerable", CName.new("SecondHeart"))
				if Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer()) then
					local veh = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
					if veh then
						Game.GetGodModeSystem():AddGodMode(veh:GetEntityID(), "Invulnerable", CName.new("Default"))
					end
				end
				else
				local hasSecondHeart = false
				local ssc = Game.GetScriptableSystemsContainer()
				local es = ssc:Get(CName.new('EquipmentSystem'))
				local espd = es:GetPlayerData(Game.GetPlayer())
				espd['GetItemInEquipSlot2'] = espd['GetItemInEquipSlot;gamedataEquipmentAreaInt32']
				for i=0,2 do
					if espd:GetItemInEquipSlot2("CardiovascularSystemCW", i).tdbid.hash == 3619482064 then
						hasSecondHeart = true
					end
				end
				if hasSecondHeart then
					Game.GetGodModeSystem():EnableOverride(Game.GetPlayer():GetEntityID(), "Immortal", CName.new("SecondHeart"))
					else
					Game.GetGodModeSystem():DisableOverride(Game.GetPlayer():GetEntityID(), CName.new("SecondHeart"))
				end
				if Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer()) then
					local veh = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
					if veh then
						Game.GetGodModeSystem():ClearGodMode(veh:GetEntityID(), CName.new("Default"))
					end
				end
				
			end
			
		end)
		-- Parameters: path, label, desc, currentValue, defaultValue, callback, optionalIndex
		nativeSettings.addSwitch("/CMCHEAT/player",  getLang("Infinite Stamina"),  getLang("Infinite Stamina"), InfiniteStaminas, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			InfiniteStaminas = state
			updateUserSetting("InfiniteStaminas", InfiniteStaminas)
			
			InfiniteStamina(InfiniteStaminas)
		end)
		
		nativeSettings.addSwitch("/CMCHEAT/player",  getLang("Infinite Ammo"),  getLang("Infinite Ammo"), InfiniteAmmo, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			InfiniteAmmo = state
			updateUserSetting("InfiniteAmmo", InfiniteAmmo)
			
			if(InfiniteAmmo) then
				Game.GetInventoryManager().AddEquipmentStateFlag(Game.GetInventoryManager(),gameEEquipmentManagerState.InfiniteAmmo)
				local player = Game.GetPlayer()
				local activeWeapon = GameObject.GetActiveWeapon(player)
				-- The gist behind this is:
				-- Reload the weapon in 0 seconds, end the reload
				GameObject.GetActiveWeapon(player).StartReload(activeWeapon,0)
				GameObject.GetActiveWeapon(player).StopReload(activeWeapon,gameweaponReloadStatus.Standard)
				else
				Game.GetInventoryManager().RemoveEquipmentStateFlag(Game.GetInventoryManager(),gameEEquipmentManagerState.InfiniteAmmo)
				local player = Game.GetPlayer()
				local activeWeapon = GameObject.GetActiveWeapon(player)
				-- The gist behind this is:
				-- Reload the weapon in 0 seconds, end the reload
				GameObject.GetActiveWeapon(player).StartReload(activeWeapon,0)
				GameObject.GetActiveWeapon(player).StopReload(activeWeapon,gameweaponReloadStatus.Standard)
			end
			
		end)
		
		
		nativeSettings.addSwitch("/CMCHEAT/player",  getLang("Unlimited Carry"),  getLang("Unlimited Carry"), UnlimitedCarryLimit, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			UnlimitedCarryLimit = state
			updateUserSetting("UnlimitedCarryLimit", UnlimitedCarryLimit)
			
			if(UnlimitedCarryLimit) then 
				Game.GetStatsSystem():AddModifier(Game.GetPlayer():GetEntityID(),RPGManager.CreateStatModifier(gamedataStatType.CarryCapacity,gameStatModifierType.Additive,99999999))
				else
				Game.GetStatsSystem():AddModifier(Game.GetPlayer():GetEntityID(),RPGManager.CreateStatModifier(gamedataStatType.CarryCapacity,gameStatModifierType.Additive,-99999999))
			end
			
		end)
		
		
		nativeSettings.addSubcategory("/CMCHEAT/reload",getLang("Theses cheats need that you save after enable them then reload"))
		
		nativeSettings.addRangeFloat("/CMCHEAT/reload", getLang("ui_setting_cheat_player_sprint"),  getLang("ui_setting_cheat_player_sprint"), 1, 10, 0.1, "%.1f", Player_Sprint_Multiplier, 1, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
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
		
		nativeSettings.addRangeFloat("/CMCHEAT/reload", getLang("ui_setting_cheat_player_run"),  getLang("ui_setting_cheat_player_run"), 1, 10, 0.1, "%.1f", Player_Run_Multiplier, 1, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
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
		
		
		nativeSettings.addRangeFloat("/CMCHEAT/reload", getLang("ui_setting_cheat_jump_height"),  getLang("ui_setting_cheat_jump_height"), 1, 10, 0.1, "%.1f", Jump_Height, 1, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
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
		
		nativeSettings.addRangeFloat("/CMCHEAT/reload", getLang("ui_setting_cheat_doublejump_height"),  getLang("ui_setting_cheat_doublejump_height"), 1, 10, 0.1, "%.1f", Double_Jump_Height, 1, function(value) -- path, label, desc, min, max, step, currentValue, defaultValue, callback
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
		
		
		nativeSettings.addSwitch("/CMCHEAT/reload",  getLang("ui_setting_cheat_player_dodge"),  getLang("ui_setting_cheat_player_dodge"), UltraSpeedDodge, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			UltraSpeedDodge = state
			updateUserSetting("UltraSpeedDodge", UltraSpeedDodge)
			
			TweakDB:SetFlat("PlayerLocomotion.player_locomotion_data_Dodge_inline9.value", 1)
			TweakDB:SetFlat("PlayerLocomotion.player_locomotion_data_DodgeAir_inline9.value", 1)
			TweakDB:SetFlat("player.locomotion.maxGroundSpeed", 999999.0)
			TweakDB:SetFlat("player.locomotion.maxAirXYSpeed", 999999.0)
			
		end)
		
		nativeSettings.addSwitch("/CMCHEAT/reload",  getLang("ui_setting_cheat_player_ram"),  getLang("ui_setting_cheat_player_ram"), RamUpgrade, false, function(state) -- path, label, desc, currentValue, defaultValue, callback
			RamUpgrade = state
			updateUserSetting("RamUpgrade", RamUpgrade)
			
			TweakDB:SetFlat("Items.AdvancedRamUpgradeLegendaryPlusPlus_inline1.value", 1000)
			TweakDB:SetFlat("Items.AdvancedRamUpgradeLegendaryPlusPlus_inline4.value", 25)
			
			TweakDB:SetFlat("Items.AdvancedRamUpgradeLegendaryPlusPlus_inline2.floatValues", {1000})
			TweakDB:SetFlat("Items.AdvancedRamUpgradeLegendaryPlusPlus_inline5.floatValues", {25})
			
		end)
		nativeSettings.addTab("/CSKEYBIND", getLang("Cyberscript KeyBinding")) -- Add our mods tab (path, label)
		nativeSettings.addSubcategory("/CSKEYBIND/gameplay", getLang("Gameplay"))
	end)
	
	if status == false then
		
		
		
		logme(1,result)
		
		nativeSettings.addSubcategory("/CM/gameplay00", "sssOoops there is an error in CyberScript Setting !")
		nativeSettings.addSubcategory("/CM/gameplay01", "Try rebuild the cache and reload the mod/save/game !")
		nativeSettings.addSubcategory("/CM/gameplay02", "Send quest_mod.log to discord Admin on Cyberscript Discord !")
		
		
		
		
		
		nativeSettings.addButton("/CM/gameplay02", "!!! Reset the mod !!! ", "WARNING : Will totaly delete downloaded datapack, cache and session", "Reset the mod", 45, function()
			
			if file_exists("user/sessions/latest.txt") then
				os.remove("user/sessions/latest.txt")
			end
			
			
			local reader = dir("sessions")
			
			
			for i=1, #reader do 
				if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
					
					os.remove('user/sessions/'..reader[i].name)
					
					
					
					
				end
			end
			
			local reader = dir("datapack")
			for i=1, #reader do 
				if(tostring(reader[i].type) == "directory") then
					
					os.remove('datapack/'..reader[i].name)
					
					
					
					
				end
			end
			
			local reader = dir("user/cache")
			for i=1, #reader do 
				if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
					
					os.remove('user/cache/'..reader[i].name)
					
					
					
					
				end
			end
			
			
			ImportDataPack()
			LoadDataPackCache()
			logme(2, getLang("ui_setting_actions_rebuild_done"))
			
		end)
	end
	
	
	end
end


---IMGUI UI---


function loadHUD()
	
	
	
	for k,v in pairs(cyberscript.cache["hud"]) do
		local hud = v.data
		if(hud.type == "container") then
			displayHUD[k] = inkCanvas.new()
			displayHUD[k]:SetName(CName.new(hud.tag))
			displayHUD[k]:SetAnchor(inkEAnchor.Fill)
			displayHUD[k]:Reparent(rootContainer, -1)
			logme(1,"create "..hud.tag)
			
		end
	end
	
	
	for k,v in pairs(cyberscript.cache["hud"]) do
		local hud = v.data
		if(hud.type == "container") then
			if(hud.container == nil or hud.container == "default" or  hud.container == "") then
				displayHUD[k]:Reparent(rootContainer, -1)
				else
				displayHUD[k]:Reparent(displayHUD[hud.container], -1)
			end
			
			
		end
	end
	
	for k,v in pairs(cyberscript.cache["hud"]) do
		local hud = v.data
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
			logme(1,"create "..hud.tag)
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



function fadeinwindows()
	
	local screenWidth, screenHeight = GetDisplayResolution()
	CPS.colorBegin("WindowBg", {"000000" , opacity})
	CPS.colorBegin("FrameBg", {"000000" , opacity})
	CPS.colorBegin("MenuBarBg", {"000000" , opacity})
	CPS.colorBegin("TitleBg", {"000000" , opacity})
	CPS.colorBegin("Header", {"000000" , opacity})
	CPS.colorBegin("Border", {"000000" , opacity})
	CPS.colorBegin("PopupBg", {"000000" , opacity})
	CPS.colorBegin("HeaderActive", {"000000" , opacity})
	CPS.colorBegin("TitleBgActive", {"000000" , opacity})
	CPS.colorBegin("Text", {"000000" , opacity})
	
	if ImGui.Begin(fademessage) then
		ImGui.SetNextWindowSize(screenWidth, screenHeight, ImGuiCond.Appearing) -- set window size w, h
		ImGui.SetWindowSize(screenWidth+5, screenHeight+5)
		ImGui.SetWindowPos(-5, -5)
		ImGui.End()
	end
	
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
			
			local notificationData = ShardReadPopupData.new()
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
	if(newgroupinteractUI == false) then
		currentInterface = nil
		
		local ui = {}
		ui.title = getLang("Select active Interactions Group")
		ui.tag = "datapack_current"
		ui.controls = {}
		
		if(#currentInteractGroup > 0 ) then
			
			
			local area = {}
			area.type = "area"
			area.tag =	"main_area"
			area.rotation = 0
			area.anchor = 15
			area.fittocontent = true
			area.trigger = {}
			area.trigger.auto = {}
			area.trigger.auto.name = "auto"
			area.requirement = {}
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(area.requirement,requirement)
			area.margin = {}
			area.margin.top = 0
			area.margin.left = 0
			area.size = {}
			area.size.width = 1500
			area.size.height = 1000
			area.scale = {}
			area.scale.width = 1
			area.scale.height = 1
			table.insert(ui.controls,area)
			
			local area = {}
			area.type = "area"
			area.tag =	"container"
			area.parent =	"main_area"
			area.rotation = 0
			area.anchor = 0
			area.opacity = 1
			area.visible = true
			area.fittocontent = true
			area.trigger = {}
			area.trigger.auto = {}
			area.trigger.auto.name = "auto"
			area.requirement = {}
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(area.requirement,requirement)
			area.margin = {}
			area.margin.top = 0
			area.margin.left = 0
			area.size = {}
			area.size.width = 1500
			area.size.height = 1000
			area.scale = {}
			area.scale.width = 1
			area.scale.height = 1
			table.insert(ui.controls,area)
			
			
			local area = {}
			area.type = "vertical_area"
			area.tag =	"main_vertical"
			area.parent = "container"
			area.rotation = 0
			area.anchor = 0
			area.opacity = 1
			area.visible = true
			area.fittocontent = false
			area.trigger = {}
			area.trigger.auto = {}
			area.trigger.auto.name = "auto"
			area.requirement = {}
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(area.requirement,requirement)
			area.margin = {}
			area.margin.top = 0
			area.margin.left = 0
			area.childmargin = {}
			area.childmargin.top = 0
			area.childmargin.left = 0
			area.size = {}
			area.size.width = 1500
			area.size.height = 1000
			area.scale = {}
			area.scale.width = 1
			area.scale.height = 1
			table.insert(ui.controls,area)
			
			local label = {}
			label.type = "label"
			label.tag ="selected_group_lbl"
			label.trigger = {}
			label.trigger.auto = {}
			label.trigger.auto.name = "auto"
			label.parent = "main_vertical"
			label.margin = {}
			label.style = {}
			label.anchor = 1
			label.margin.top = 5
			label.style.fontsize = 45
			label.requirement = {}
			label.textcolor = {}
			label.textcolor.red = 52
			label.textcolor.green = 235
			label.textcolor.blue = 235
			
			
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(label.requirement,requirement)
			
			label.text =  "Selected : "..currentInteractGroup[currentInteractGroupIndex]
			table.insert(ui.controls,label)
			
			local area = {}
			area.type = "area"
			area.tag =	"scrollercontainer"
			area.parent =	"main_vertical"
			area.rotation = 0
			area.anchor = 0
			area.opacity = 1
			area.visible = true
			area.fittocontent = false
			area.trigger = {}
			area.trigger.auto = {}
			area.trigger.auto.name = "auto"
			area.requirement = {}
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(area.requirement,requirement)
			area.margin = {}
			area.margin.top = 0
			area.margin.left = 0
			area.size = {}
			area.size.width = 1500
			area.size.height = 200
			area.scale = {}
			area.scale.width = 1
			area.scale.height = 1
			table.insert(ui.controls,area)
			
			local area = {}
			area.type = "scrollarea"
			area.tag =	"datapack_current_scroll"
			area.trigger = {}
			area.trigger.auto = {}
			area.trigger.auto.name = "auto"
			area.parent = "scrollercontainer"
			area.requirement = {}
			area.dynamic = {}
			local requirement = {}
			table.insert(requirement,"auto")
			table.insert(area.requirement,requirement)
			area.action = {}
			area.margin = {}
			
			area.style = {}
			area.size = {}
			area.fittocontent = false
			area.anchor = 0
			
			area.size.width = 1500
			area.size.height = 600
			area.scale = {}
			area.scale.width = 1
			area.scale.height = 1
			table.insert(ui.controls,area)
			
			
			local area = {}
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
			area.fittocontent = false
			area.anchor = 0
			area.parent = "datapack_current_scroll"
			area.style.fontsize = 30
			area.size.width = 1500
			area.size.height = 600
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
				buttons.size.width = 1200
				buttons.size.height = 100
				buttons.scale = {}
				buttons.scale.width = 1
				buttons.scale.height = 1
				buttons.anchor = 0
				
				local spawn_item = {}
				spawn_item.name = "set_datapack_group_index" 
				spawn_item.value = i
				table.insert(buttons.action,spawn_item)
				
				local close_action = {}
				close_action.name = "close_interface" 
				table.insert(buttons.action,close_action)
				
				table.insert(ui.controls,buttons)
			end
			currentInterface = ui
			
			if UIPopupsManager.IsReady() then
				
				local notificationData = ShardReadPopupData.new()
				notificationData.notificationName = 'base\\gameplay\\gui\\widgets\\notifications\\shard_notification.inkwidget'
				notificationData.queueName = 'modal_popup'
				
				
				notificationData.requiredGameState = "inkGameState";
				notificationData.isBlocking = true;
				notificationData.useCursor = true;
				notificationData.title = "Cyberscript Manager";
				notificationData.text = "Choose a group";
				notificationData.isCrypted = false;
				
				UIPopupsManager.ShowPopup(notificationData)
				else
				Game.GetPlayer():SetWarningMessage("Open and close Masqsqsqin menu before call an popup.")
			end
		end
		
	end
	
end


function ActivatedGroup2()
	local dialog = {}
	
	dialog.trigger = {}
	dialog.requirement = {}
	dialog.desc = ""
	dialog.tag = "ActivatedGroup2"
	dialog.speaker = "Interactions Group Selected : "..currentInteractGroup[currentInteractGroupIndex]
	dialog.context = {}
	dialog.options = {}
	
	
	
	if(#currentInteractGroup > 0 ) then
		
		
		
		
		
		for i = 1, #currentInteractGroup do 
			
			
			local options = {}
			options.requirement = nil
			options.trigger = nil
			options.description = currentInteractGroup[i]
			options.action = {}
			
			local spawn_item = {}
			spawn_item.name = "set_datapack_group_index" 
			spawn_item.value = i
			table.insert(options.action,spawn_item)
			
			table.insert(dialog.options,options)
		end
		
		
		createDialog(dialog)
	end
	
	
end

function cycleInteract2()
	getTriggeredActions()
	currentInteractGroupIndex = currentInteractGroupIndex or 1
	getTriggeredActionsDisplay()
	local dialog = {}
	
	dialog.trigger = {}
	dialog.requirement = {}
	dialog.desc = ""
	dialog.tag = "cycleInteract2"
	dialog.speaker = currentInteractGroup[currentInteractGroupIndex]
	dialog.context = {}
	dialog.options = {}
	
	
	
	for key,value in pairs(cyberscript.cache["interact"]) do --actualcode
		
		local interact = cyberscript.cache["interact"][key].data
		checkContext(interact)
		--testTriggerRequirement(interact2.requirement,interact2.trigger)
		if(checkTriggerRequirement(interact.requirement,interact.trigger)) and 
			(interact.group == currentInteractGroup[currentInteractGroupIndex] and key ~= "default_open_datapack_group_ui") then
			
			if((interact.type == nil or interact.type == "interact") and (interact.display == nil or interact.display == "event_interact")) then
				
				local options = {}
				options.requirement = interact.requirement
				options.trigger = interact.trigger
				options.description = interact.name
				options.action = interact.action
				
				options.icon = interact.icon
				options.style = {}
				if interact.style ~= nil and interact.style.textcolor ~= nil then
					options.style.color = interact.style.textcolor
					
				end
				options.tag = interact.tag
				
				
				
				
				table.insert(dialog.options,options)
				
				else
				if((interact.type == nil or interact.type == "hint")) then
					
					showInputHint(interact.key, getLang(interact.name), 1, interact.hold, interact.tag)
				end
			end
			else
			if(#currentInputHintList > 0) then
				
				for i = 1, #currentInputHintList do
					
					if(currentInputHintList[i]~= nil and currentInputHintList[i].tag == interact.tag) then
						hideCustomHints(interact.tag)
						
						currentInputHintList[i] = nil
					end
					
					
				end
				
				
			end
		end
		
		
		
		
	end
	
	local interact = cyberscript.cache["interact"]["default_open_datapack_group_ui"].data
	local options = {}
	options.requirement = interact.requirement
	options.trigger = interact.trigger
	options.description = interact.name
	
	options.action =  {}
	options.action[1] = {}
	options.action[1].name = "open_datapack_group_ui2"
	
	options.icon = interact.icon
	options.style = {}
	if interact.style ~= nil and interact.style.textcolor ~= nil then
		options.style.color = interact.style.textcolor
		
	end
	options.tag = interact.tag
	
	
	
	
	table.insert(dialog.options,options)
	
	if(#dialog.options > 0) then
		
		local options = {}
		options.requirement = nil
		options.trigger = nil
		options.description = "Exit"
		options.action = {}
		
		
		options.action[1] = {}
		options.action[1].name = "nothing"
		
		
		
		
		
		table.insert(dialog.options,options)
		--print("mark2")
		createDialog(dialog)
	end
	
end
function Activatedshard(shard)
	currentInterface = nil
	----print(dump(shard))
	local ui = {}
	ui.title = shard.title
	ui.tag = "ui_custom_shard"
	ui.controls = {}
	
	
	
	
	
	local area = {}
	area.type = "area"
	area.tag =	"main_area"
	area.rotation = 0
	area.anchor = 15
	area.fittocontent = true
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.margin = {}
	area.margin.top = 0
	area.margin.left = 0
	area.size = {}
	area.size.width = 1000
	area.size.height = 1000
	area.scale = {}
	area.scale.width = 1
	area.scale.height = 1
	table.insert(ui.controls,area)
	
	local area = {}
	area.type = "area"
	area.tag =	"container"
	area.parent =	"main_area"
	area.rotation = 0
	area.anchor = 0
	area.opacity = 1
	area.visible = true
	area.fittocontent = true
	area.trigger = {}
	area.trigger.auto = {}
	area.trigger.auto.name = "auto"
	area.requirement = {}
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(area.requirement,requirement)
	area.margin = {}
	area.margin.top = 0
	area.margin.left = 0
	area.size = {}
	area.size.width = 1000
	area.size.height = 1000
	area.scale = {}
	area.scale.width = 1
	area.scale.height = 1
	table.insert(ui.controls,area)
	
	
	local label = {}
	label.type = "label"
	label.tag ="selected_group_lbl"
	label.trigger = {}
	label.trigger.auto = {}
	label.trigger.auto.name = "auto"
	label.parent = "container"
	label.margin = {}
	label.style = {}
	label.anchor = 0
	label.margin.top = 5
	label.style.fontsize = 55
	label.requirement = {}
	label.textcolor = {}
	label.textcolor.red = 0
	label.textcolor.green = 255
	label.textcolor.blue = 247
	
	
	local requirement = {}
	table.insert(requirement,"auto")
	table.insert(label.requirement,requirement)
	
	label.text = shard.description
	table.insert(ui.controls,label)
	
	
	
	currentInterface = ui
	
	if UIPopupsManager.IsReady() then
		
		local notificationData = ShardReadPopupData.new()
		notificationData.notificationName = 'base\\gameplay\\gui\\widgets\\notifications\\shard_notification.inkwidget'
		notificationData.queueName = 'modal_popup'
		notificationData.isBlocking = true
		notificationData.useCursor = true
		UIPopupsManager.ShowPopup(notificationData)
		
		else
		Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
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
			
			local notificationData = ShardReadPopupData.new()
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
	getTriggeredActions()
	currentInteractGroupIndex = currentInteractGroupIndex or 1
	inputInAction = false
	
	candisplayInteract = true
	if currentPossibleInteractChunkIndex == 0 then
		-- currentPossibleInteractChunkIndex = 1
		candisplayInteract = true
	end
	
	if candisplayInteract then
		currentPossibleInteractChunkIndex = currentPossibleInteractChunkIndex + 1
		
		getTriggeredActionsDisplay()
		
		--logme(1,"000")
		createInteraction(true)
	end
	
	if currentPossibleInteractChunkIndex > #possibleInteractDisplay then
		-- currentInteractGroupIndex = currentInteractGroupIndex + 1
		currentPossibleInteractChunkIndex = 0
		
		-- if(currentInteractGroupIndex > #currentInteractGroup) then
		-- currentInteractGroupIndex = 1
		-- end
		
		--Game.GetPlayer():SetWarningMessage(getLang("current_interact_group")..currentInteractGroup[currentInteractGroupIndex])
	end
	
	-- if GameController["interactionWidgetGameController"].currentOptions then
	-- if GameController["interactionWidgetGameController"].id < 1 then
	-- if currentDialogHub then
	-- -- createInteraction(false)
	-- createDialog(currentDialogHub.dial)
	-- isdialogactivehub = true
	-- end
	-- else
	-- --createInteraction(true)
	-- isdialogactivehub = false
	-- --logme(6,"tyu")
	-- end
	-- else
	-- createInteraction(true)
	-- isdialogactivehub = false
	-- --logme(6,"tyuss")
	-- end
	
	
end

function cycleInteractgroup()
	inputcount = inputcount +1
	
	logme(6,"possibleInteractDisplay"..#possibleInteractDisplay)
	-- logme(6,actionValue)
	
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
	if(newgroupinteractUI == false) then
	if candisplayInteract then
		currentPossibleInteractChunkIndex = 0
		
		createInteraction(false)
		candisplayInteract = false
	end
	else
	
		interactionUI.hideHub()
	end
end



---Radio---
function playRadio()
	
	if(currentRadio ~= nil and currentRadio.data ~= nil) then
		
		if currentRadio.data.tracks ~= nil and #currentRadio.data.tracks > 0  then
			
			local canplay = true
			
			if(currentRadio.data.only_in_car == true) then
				canplay = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
				else
				canplay = true
				
			end
			
			if(currentRadio.playedmusic == nil or (currentRadio.playedmusic ~= nil and (cyberscript.soundmanager[currentRadio.playedmusic.name] == nil or cyberscript.soundmanager[currentRadio.playedmusic.name].isplaying == false))) then
				
				if(currentRadio.playedmusic ~= nil) then
					currentRadio.lastplayedmusic = currentRadio.playedmusic
					
				end
				
				currentRadio.isplaying = false
				currentRadio.playedmusic = nil
				
				
			end
			
			if(canplay and (currentRadio.playedmusic == nil))then
				
				local index = math.random(1,#currentRadio.data.tracks)
				
				local song = currentRadio.data.tracks[index]
				
				if(currentRadio.lastplayedmusic ~= nil) then
					while(song.name == currentRadio.lastplayedmusic) do
						
						index = math.random(1,#currentRadio.data.tracks)
						
						song = currentRadio.data.tracks[index]
					end
					
					
				end
				
				currentRadio.isplaying = true
				currentRadio.playedmusic = song
				
				
				local actionlist = {}
				
				local action = {}
				action = {}
				action.name = "play_custom_sound"
				action.value = song.name
				action.isradio = true
				
				table.insert(actionlist,action)
				runActionList(actionlist, "play_radio_radio_"..currentRadio.data.tag, "interact",false,"nothing",true)
				else
				
				if(currentRadio.data.only_in_car == true) then
					
					local iscar = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
					
					if(iscar == false and (currentRadio.playedmusic ~= "" and currentRadio.playedmusic ~= nil)) then
						
						Stop(currentRadio.playedmusic.name)
						currentRadio.isplaying = false
						currentRadio.playedmusic = nil
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
					
					for k,v in pairs(cyberscript.cache["radio"]) do
						numitems = numitems + 1
					end
					
					local randval = math.random(1, numitems) -- get a random point
					
					local randentry
					local count = 0
					
					for k,v in pairs(cyberscript.cache["radio"]) do
						count = count + 1
						if(count == randentry) then
							currentRadio = v.data
							break
						end
					end
					
					index = math.random(1,#currentRadio.tracks)
					song = currentRadio.tracks[index]
				end
				
				local sound = getSoundByNameNamespace(song.file,currentRadio.namespace)
				
				if(sound ~= nil) then
					
					local path = cyberscript.soundpath..sound.path
					logme(6,path..sound.name)
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
					logme(6,"stop music")
					Stop("music")
				end
			end
		end
	end
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
function createInteractionChoice(action, title,icon,displaytype)
	
	local choiceData =  InteractionChoiceData.new()
	choiceData.localizedName = title
	choiceData.inputAction = action
	
	if icon ~= nil then
		
		local iconrecord = TweakDBInterface.GetChoiceCaptionIconPartRecord("ChoiceCaptionParts."..icon)
        local part = gameinteractionsChoiceCaption.new()
        part:AddPartFromRecord(iconrecord)
        choiceData.captionParts = part
	end
	
	
	
	local choiceType = ChoiceTypeWrapper.new()
	choiceData.type = choiceType
	
	
	if displaytype ~= nil then
        local choiceType = gameinteractionsChoiceTypeWrapper.new()
        choiceType:SetType(displaytype)
		choiceData.type = choiceType
	end
	
	
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
				local interact = cyberscript.cache["interact"][loadInteract[z]].data
				if(interact.type == nil or interact.type == "interact") then
					
					checkContext(interact)
					
					
					
					
					table.insert(choices, createInteractionChoice('Choice'..z, interact.tag,interact.icon,interact.displaytype))
				end
			end
			else
			
			if possibleInteractDisplay ~= nil and currentPossibleInteractChunkIndex ~= nil and #possibleInteractDisplay > 0  and possibleInteractDisplay[currentPossibleInteractChunkIndex] ~= nil then
				for z=1,#possibleInteractDisplay[currentPossibleInteractChunkIndex] do 
					
					local interact = possibleInteractDisplay[currentPossibleInteractChunkIndex][z]
					checkContext(interact)
					
					
					if(interact.type == nil or interact.type == "interact") then
						interact.input = z
						table.insert(choices, createInteractionChoice('Choice'..z, interact.tag,interact.icon,interact.displaytype))
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
	--createInteraction(false)
	
	
	currentDialogHub = {}
	currentDialogHub.hub= {}
	currentDialogHub.dial = {}
	currentDialogHub.index = 1
	
	currentDialogHub.dial = dialog
	
	local choicelist = {}
	
	for i = 1, #dialog.options do
		
		local option = dialog.options[i]
		
		local icon = nil
		if option.icon ~= nil then 
			icon = TweakDBInterface.GetChoiceCaptionIconPartRecord("ChoiceCaptionParts."..option.icon)
		end
		
		local choice1 = interactionUI.createChoice(getLang(option.description), icon , gameinteractionsChoiceType.Selected) -- Icon and choiceType are optional
		table.insert(choicelist,choice1)
	end
	
	
	
    -- Setup, set and show hub
    local hub = interactionUI.createHub(getDialogOwner(dialog.speaker), choicelist,id) -- Create hub and give it the list of choices
	
	interactionUI.setupHub(hub) -- Set the hub
	
    interactionUI.showHub() -- Show the previously set hub
	currentDialogHub.hub = hub
    -- Setup callbacks
	
	for i = 1, #dialog.options do
		
		--print(i)
		interactionUI.callbacks[i] = function()
			local option = dialog.options[i]
			if(option.requirement == nil or checkTriggerRequirement(option.requirement,option.trigger))then
				
				ClickOnDialog(option,dialog.speaker,"speak")
				
					interactionUI.hideHub()
				
			end
		end
		
	end
	
	
	
	if(playerisstopped == false) then
		StatusEffectHelper.ApplyStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
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
	dialog.title =  getDialogOwner(dialogIIRP.speaker)
	dialog.hubPriority  = 0
	dialog.activityState  =  Enum.new('gameinteractionsvisEVisualizerActivityState', 'Active')
	
	local choices = {}
	for i = 1, #dialogIIRP.options do
		
		local option = dialogIIRP.options[i]
		dialogIIRP.options[i].input = i
		table.insert(choices, creatDialogChoice('Choice'..i, getLang(option.description),option.icon,option.choicetype))
	end
	dialog.choices = choices
	return dialog
end


function getDialogOwner(speaker)
	
	local result = getLang(speaker)
	
	if(speaker == "any") then
		if(currentNPC ~= nil) then
			result = currentNPC.Names
			elseif(currentStar ~= nil) then
			result = currentStar.Names
			else
			result = getLang(speaker)
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
	
	if icon ~= nil and icon ~= "" then
		local iconrecord = TweakDBInterface.GetChoiceCaptionIconPartRecord("ChoiceCaptionParts."..icon)
        local part = gameinteractionsChoiceCaption.new()
        part:AddPartFromRecord(iconrecord)
        choiceData.captionParts = part
	end
	
	
	if optionchoice ~= nil then
        local choiceType = gameinteractionsChoiceTypeWrapper.new()
        choiceType:SetType(optionchoice)
		choiceData.type = choiceType
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
