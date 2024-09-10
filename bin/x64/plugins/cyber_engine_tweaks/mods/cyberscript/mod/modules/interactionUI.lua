local ui =  {
    baseControler = nil,
    hub = nil,
    callbacks = {},
    hubShown = false,
    selectedIndex = 0,
    input = false,
	injectdialog = nil
}

---@param localizedName string
---@param icon gamedataChoiceCaptionIconPart_Record
---@param choiceType gameinteractionsChoiceType
---@return gameinteractionsvisListChoiceData
function ui.createChoice(localizedName, icon, choiceType) -- Creates and returns a choice
    local choice = gameinteractionsvisListChoiceData.new()
    choice.localizedName = localizedName or "Choice"
    choice.inputActionName = CName("None")

    if icon then
        local part = gameinteractionsChoiceCaption.new()
        part:AddPartFromRecord(icon)
        choice.captionParts = part
    end

    if choiceType then
        local choiceT = gameinteractionsChoiceTypeWrapper.new()
        choiceT:SetType(choiceType)
        choice.type = choiceT
    end

    return choice
end

---@param title string
---@param choices table
---@param activityState gameinteractionsvisEVisualizerActivityState
---@return gameinteractionsvisListChoiceHubData
function ui.createHub(title, choices, activityState, id) -- Creates and returns a hub
    local hub = gameinteractionsvisListChoiceHubData.new()
    hub.title = title or "Title"
    hub.choices = choices or {}
    hub.activityState = activityState or gameinteractionsvisEVisualizerActivityState.Active
    hub.hubPriority = 1
	if(id == nil) then
    hub.id = 69420 + math.random(99999)
	else
	hub.id = id
	end

    return hub
end

---@param hub gameinteractionsvisListChoiceHubData
function ui.setupHub(hub) -- Setup interaction hub
    ui.hub = hub
end

function ui.showHub() -- Shows the hub previously set using setupHub()
    ui.baseControler = GameController["InteractionUIBase"]
	
	if not ui.hub or not ui.baseControler then return end
	
    local data = DialogChoiceHubs.new()
    data.choiceHubs = {ui.hub}

    ui.baseControler.AreDialogsOpen = #data.choiceHubs > 0
    ui.baseControler.dialogIsScrollable = #data.choiceHubs > 1

    ui.baseControler:OnDialogsSelectIndex(0)
    ui.baseControler:UpdateDialogsData(data)
    ui.baseControler:OnInteractionsChanged()
    ui.baseControler:UpdateListBlackboard()
    ui.baseControler:OnDialogsActivateHub(ui.hub.id)

    ui.hubShown = true
    ui.selectedIndex = 0
end

function ui.hideHub() -- Hides the hub
    if not ui.hub or not ui.baseControler then return end

    local data = DialogChoiceHubs.new()
    ui.baseControler:UpdateDialogsData(data)
    ui.baseControler:OnInteractionsChanged()
    ui.baseControler:UpdateListBlackboard()

    ui.hubShown = false
end

function ui.registerChoiceCallback(choiceIndex, callback) -- Register a callback for a choice via index, starting at 1
    ui.callbacks[choiceIndex] = callback
end

function ui.clearCallbacks() -- Remove all callbacks
    ui.callbacks = {}
end



function ui.update() -- Run ever frame to avoid unwanted changes
    if ui.hubShown then
		pcall(function()
        Game.GetBlackboardSystem():Get(GetAllBlackboardDefs().UIInteractions):SetInt(GetAllBlackboardDefs().UIInteractions.SelectedIndex, ui.selectedIndex, true)
		end)
	end
    ui.input = false -- Avoid double input
end

function ui.OnAction(action)
	
	 if interactionUI.input or not interactionUI.hubShown then return end
        local actionName = Game.NameToString(action:GetName(action))
        local actionType = action:GetType(action).value

        if actionName == 'ChoiceScrollUp' then
            if actionType == 'BUTTON_PRESSED'then
                interactionUI.selectedIndex = interactionUI.selectedIndex - 1
                if interactionUI.selectedIndex < 0 then
                    interactionUI.selectedIndex = #interactionUI.hub.choices - 1
                end
                interactionUI.input = true
            end
        elseif actionName == 'ChoiceScrollDown' then
            if actionType == 'BUTTON_PRESSED'then
                interactionUI.selectedIndex = interactionUI.selectedIndex + 1
                if interactionUI.selectedIndex > #interactionUI.hub.choices - 1 then
                    interactionUI.selectedIndex = 0
                end
                interactionUI.input = true
            end
        elseif actionName == 'ChoiceApply' then
            if actionType == 'BUTTON_PRESSED'then
                if interactionUI.callbacks[interactionUI.selectedIndex + 1] then
                    interactionUI.callbacks[interactionUI.selectedIndex + 1]()
					
					StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
                end
                interactionUI.input = true
            end
        end

end

function ui.OnDialogsSelectIndex( idx, wrapped)
	
	
	 if interactionUI.hubShown then
            if idx ~= interactionUI.selectedIndex then
			
                return
            end
        end
        wrapped(idx)
	
end

function ui.OnDialogsData(this, value, wrapped)
	if interactionUI.hubShown then nativeDialogOpen = false return end --we are in custom dialog
		
		nativeDialogOpen = true
	
		 local data=  FromVariant(value)
		 local isconcerned = true
		
		
		 
		 
		if(data.choiceHubs ~= nil and data.choiceHubs[1] ~= nil and interactionUI.injectdialog ~= nil and #interactionUI.injectdialog ~= 0 and isconcerned) then
			 local icon = nil
			
			
			
			local choicelist = {}
			local optionlist = {}
			local counter = 0
			for indexdial,dialog in ipairs(interactionUI.injectdialog) do
			
				for i = 1, #dialog.options do
					counter = counter + 1
					local option = dialog.options[i]
					
					local icon = nil
					if option.icon ~= nil then 
						icon = TweakDBInterface.GetChoiceCaptionIconPartRecord("ChoiceCaptionParts."..option.icon)
					end
					
					local choice1 = interactionUI.createChoice(getLang(option.description), icon , gameinteractionsChoiceType.Selected) -- Icon and choiceType are optional
					table.insert(choicelist,choice1)
					
					local optionitem = {}
					optionitem.dialindex = indexdial
					optionitem.optionindex = i
					optionitem.option = option
					optionitem.index = #data.choiceHubs[1].choices + counter
					optionlist[optionitem.index] = optionitem
				
				end
			end
			
			
			local arraychoice = {}
			local dialogChoiceHubs = DialogChoiceHubs.new()
			dialogChoiceHubs.choiceHubs = {}
			
		
			
			
			
			local hub = gameinteractionsvisListChoiceHubData.new()
			hub.title = data.choiceHubs[1].title
			hub.choices ={}
			hub.activityState = data.choiceHubs[1].activityState
			hub.activityState = gameinteractionsvisEVisualizerActivityState.Active
			hub.hubPriority = 1
			
		
			for k,v in ipairs(data.choiceHubs[1].choices) do
				local chop = deepcopy(v)
				
				table.insert(arraychoice,chop)
				
			end
			local customIndex = {}
			
			
			for k,v in ipairs(choicelist) do
				local chop = deepcopy(v)
				
				table.insert(arraychoice,chop)
				customIndex[#arraychoice] = {}
				customIndex[#arraychoice].index = k
				
			end
			
			hub.choices =arraychoice
			
			local arrayhub = {}
			table.insert(arrayhub,hub)
			 dialogChoiceHubs.choiceHubs = arrayhub
			
			for i = 1, #hub.choices do
				
				
			   interactionUI.callbacks[i] = function()
			   
						if(optionlist[i] ~= nil) then
						
						
							local option = interactionUI.injectdialog[optionlist[i].dialindex].options[optionlist[i].optionindex]
							
							if(option.requirement == nil or checkTriggerRequirement(option.requirement,option.trigger))then
							
								interactionUI.hub.id = 69420 + math.random(99999)
								interactionUI.selectedIndex = 69420 + math.random(99999)
								ClickOnDialog(option,hub.title,"speak")
								interactionUI.injectdialog[optionlist[i].dialindex] = nil
								
							end
						end
						interactionUI.hideHub()
						
				end
				
			end
			
			
			this.AreDialogsOpen = #dialogChoiceHubs.choiceHubs > 0;
			this.dialogIsScrollable = true
			this:OnDialogsSelectIndex(0)
			this:UpdateDialogsData(dialogChoiceHubs);
			this:OnInteractionsChanged();
			this:UpdateListBlackboard();
			this:OnDialogsActivateHub(hub.id)
			
			interactionUI.hubShown = true
			interactionUI.native = true
			interactionUI.hub = hub
		else
		
		wrapped(value)
		 end
end

function ui.OnDialogsActivateHub(id, wrapped)
	
	if interactionUI.hubShown and id ~= interactionUI.hub.id then return end
		
		
        wrapped(id)
	
end
return ui