local ui =  {
    baseControler = nil,
    hub = nil,
    callbacks = {},
    hubShown = false,
    selectedIndex = 0,
    input = false
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
function ui.createHub(title, choices, activityState) -- Creates and returns a hub
    local hub = gameinteractionsvisListChoiceHubData.new()
    hub.title = title or "Title"
    hub.choices = choices or {}
    hub.activityState = activityState or gameinteractionsvisEVisualizerActivityState.Active
    hub.hubPriority = 1
    hub.id = 69420 + math.random(99999)

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

    Override("InteractionUIBase", "OnDialogsData", function(_, value, wrapped) -- Avoid interaction getting overriden by game
        if ui.hubShown then return end
        wrapped(value)
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