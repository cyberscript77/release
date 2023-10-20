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
    choice.inputActionName = "None"

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

function ui.init() -- Register needed observers
    Observe("InteractionUIBase", "OnDialogsData", function(this)
        ui.baseControler = this
    end)

    Observe("InteractionUIBase", "OnInitialize", function(this)
        ui.baseControler = this
    end)

    Observe('PlayerPuppet', 'OnAction', function(_, action)
        if ui.input or not ui.hubShown then return end
        local actionName = Game.NameToString(action:GetName(action))
        local actionType = action:GetType(action).value

        if actionName == 'ChoiceScrollUp' then
            if actionType == 'BUTTON_PRESSED'then
                ui.selectedIndex = ui.selectedIndex - 1
                if ui.selectedIndex < 0 then
                    ui.selectedIndex = #ui.hub.choices - 1
                end
                ui.input = true
            end
        elseif actionName == 'ChoiceScrollDown' then
            if actionType == 'BUTTON_PRESSED'then
                ui.selectedIndex = ui.selectedIndex + 1
                if ui.selectedIndex > #ui.hub.choices - 1 then
                    ui.selectedIndex = 0
                end
                ui.input = true
            end
        elseif actionName == 'ChoiceApply' then
            if actionType == 'BUTTON_PRESSED'then
                if ui.callbacks[ui.selectedIndex + 1] then
                    ui.callbacks[ui.selectedIndex + 1]()
                end
                ui.input = true
            end
        end
    end)

    Override("InteractionUIBase", "OnDialogsSelectIndex", function(_, idx, wrapped) -- Avoid index getting set by game
        if ui.hubShown then
            if idx ~= ui.selectedIndex then
			
                return
            end
        end
        wrapped(idx)
    end)

    Override("InteractionUIBase", "OnDialogsData", function(this, value, wrapped) -- Avoid interaction getting overriden by game
        if ui.hubShown then return end
		
		
		 local data=  FromVariant(value)
		if(data.choiceHubs ~= nil and data.choiceHubs[1] ~= nil and ui.injectdialog ~= nil) then
			 local icon = nil
			
			
			local choicelist = {}
		
			for i = 1, #ui.injectdialog.options do
				
				local option = ui.injectdialog.options[i]
				
				local icon = nil
				if option.icon ~= nil then 
					icon = TweakDBInterface.GetChoiceCaptionIconPartRecord("ChoiceCaptionParts."..option.icon)
				end
				
				local choice1 = interactionUI.createChoice(getLang(option.description), icon , gameinteractionsChoiceType.Selected) -- Icon and choiceType are optional
				table.insert(choicelist,choice1)
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
						if(customIndex[i]) then
							local option = ui.injectdialog.options[customIndex[i].index]
							if(option.requirement == nil or checkTriggerRequirement(option.requirement,option.trigger))then
								ui.hub.id = 69420 + math.random(99999)
								ui.selectedIndex = 69420 + math.random(99999)
								ClickOnDialog(option,ui.injectdialog.speaker,"speak")
								
								
							end
						end
						interactionUI.hideHub()
						ui.injectdialog = nil
				end
				
			end
			
			
			this.AreDialogsOpen = #dialogChoiceHubs.choiceHubs > 0;
			this.dialogIsScrollable = true
			this:OnDialogsSelectIndex(0)
			this:UpdateDialogsData(dialogChoiceHubs);
			this:OnInteractionsChanged();
			this:UpdateListBlackboard();
			this:OnDialogsActivateHub(hub.id)
			
			ui.hubShown = true
			ui.native = true
			ui.hub = hub
		else
		
		wrapped(value)
		 end
      --  wrapped(value)
    end)

    Override("dialogWidgetGameController", "OnDialogsActivateHub", function(_, id, wrapped) -- Avoid interaction getting overriden by game
        if ui.hubShown and id ~= ui.hub.id then return end
		
		
        wrapped(id)
    end)
end

function ui.update() -- Run ever frame to avoid unwanted changes
    if ui.hubShown then
        Game.GetBlackboardSystem():Get(GetAllBlackboardDefs().UIInteractions):SetInt(GetAllBlackboardDefs().UIInteractions.SelectedIndex, ui.selectedIndex)
    end
    ui.input = false -- Avoid double input
end

return ui