

local input = {
    listeningKeybindWidget = nil,
    inputListener = nil,
    bindings = {},
    activeKeys = {},
    nuiTables = {}
}

local function handleInput(event)
    local key = event:GetKey().value
    local action = event:GetAction().value
	
    if input.listeningKeybindWidget and key:find("IK_Pad") and action == "IACT_Release" then -- OnKeyBindingEvent has to be called manually for gamepad inputs, while there is a keybind widget listening for input
        input.listeningKeybindWidget:OnKeyBindingEvent(KeyBindingEvent.new({keyName = key}))
        input.listeningKeybindWidget = nil
    elseif input.listeningKeybindWidget and action == "IACT_Release" then -- Key was bound, by keyboard
        input.listeningKeybindWidget = nil
    end

    if action == "IACT_Press" then
        input.activeKeys[key] = 0
    else
        input.activeKeys[key] = nil
    end
end

function input.onInit()
    input.listeningKeybindWidget = GameController["SettingsSelectorControllerKeyBinding"]
    input.inputListener = NewProxy({
        OnKeyInput = { -- https://github.com/psiberx/cp2077-codeware/wiki#game-events
            args = {'whandle:KeyInputEvent'},
            callback = handleInput
        }
    })

   

    Game.GetCallbackSystem():RegisterCallback("Input/Key", input.inputListener:Target(), input.inputListener:Function("OnKeyInput"))
end

function input.onUpdate(deltaTime)
    for key, time in pairs(input.activeKeys) do -- Update hold times
        input.activeKeys[key] = time + deltaTime
			
		
    end
    
    for key, binding in pairs(input.bindings) do
        local allPressed = true
        for _, keyInfo in pairs(binding.keys) do
            if not input.activeKeys[keyInfo[1]] or (input.activeKeys[keyInfo[1]] and keyInfo[2] and not (input.activeKeys[keyInfo[1]] > holdTime)) then
                allPressed = false
                break
            end
        end

        if allPressed then
         
			 for _, key in pairs(binding.keys) do
					
				if not key[3] then
					input.activeKeys[key[1]] = nil
					
				end
                
            end
            logme(1,"event for "..key,true)
            binding.callback()
        end
    end
end

function input.onShutdown()
if(input.inputListener ~= nil) then
Game.GetCallbackSystem():UnregisterCallback("Input/Key", input.inputListener:Target())
end
end

--- Create an info table to be filled, or from given parameters
---@param maxKeysLabel string
---@param keybindLabel string
---@param isHoldLabel string
---@param keybindDescription string
---@param isHoldDescription string
---@param id string
---@param isgamepad boolean
---@param maxKeys number
---@param maxKeysLabel string
---@param maxKeysDescription string
---@param supportsHold boolean
---@param defaultOptions table
---@param savedOptions table
---@param callback function
---@param saveCallback function
---@return table
function input.createBindingInfo(nativeSettingsPath, keybindLabel, isHoldLabel, keybindDescription, isHoldDescription, id, maxKeys, maxKeysLabel, maxKeysDescription, supportsHold,forceHold, defaultOptions, savedOptions, callback, saveCallback)
    local info = {
        nativeSettingsPath = nativeSettingsPath or "",
        keybindLabel = keybindLabel or "",
        isHoldLabel = isHoldLabel or "",
        keybindDescription = keybindDescription or "",
        isHoldDescription = isHoldDescription or "",
        id = id or "",
        isgamepad = false,
        maxKeys = maxKeys or 1,
        maxKeysLabel = maxKeysLabel or "",
        maxKeysDescription = maxKeysDescription or "",
        supportsHold = supportsHold or false,
		forceHold = forceHold or false,
        defaultOptions = defaultOptions or {},
        savedOptions = savedOptions or {},
        callback = callback,
        saveCallback = saveCallback
    }

    return info
end

local function addKeybind(info, index, nativeSettings) -- Add single keybind widget
    local numberText = info.maxKeys ~= 1 and " " .. index or ""
    local holdID = "hold_" .. index
	local forceholdID = "forcehold_" .. index
    local numID = "key_" .. index

    local controller = "keyboard"

    if(currentController == true)then
        controller = "gamepad"
    end

    if not info.savedOptions[info.id][controller][numID] then info.savedOptions[info.id][controller][numID] = info.defaultOptions[info.id][controller][numID] end
    if not info.savedOptions[info.id][controller][holdID] then info.savedOptions[info.id][controller][holdID] = info.defaultOptions[info.id][controller][holdID] end
	if not info.savedOptions[info.id][controller][forceholdID] then info.savedOptions[info.id][controller][forceholdID] = false end

    input.bindings[info.id]["keys"][index] = {
        [1] = info.savedOptions[info.id][controller][numID], -- Key code
        [2] = info.savedOptions[info.id][controller][holdID], -- Is hold
		[3] = info.savedOptions[info.id][controller][forceholdID] -- Is forceHold
    }
    if(input.nuiTables[info.id] == nil) then input.nuiTables[info.id] = {} end
    if(input.nuiTables[info.id][controller] == nil) then input.nuiTables[info.id][controller] = {} end
    
    input.nuiTables[info.id][controller][numID] = nativeSettings.addKeyBinding(info.nativeSettingsPath,
    "Key # ".. numberText, info.keybindDescription,
    info.savedOptions[info.id][controller][numID], info.defaultOptions[info.id][controller][numID],
    info.savedOptions[info.id][controller][holdID], function(key)
        input.bindings[info.id]["keys"][index][1] = key
        info.saveCallback(numID, key)
    end)

    if info.supportsHold then
        input.nuiTables[info.id][controller][holdID] = nativeSettings.addSwitch(info.nativeSettingsPath, "Key # ".. numberText.." - "..info.isHoldLabel .. numberText, info.isHoldDescription, info.savedOptions[info.id][controller][holdID], info.defaultOptions[info.id][controller][holdID], function(state)
            input.nuiTables[info.id][controller][numID].isHold = state -- Update isHold value for nui
            nativeSettings.setOption(input.nuiTables[info.id][controller][numID], input.nuiTables[info.id][controller][numID].value) -- Force update to see change visually
            input.bindings[info.id]["keys"][index][2] = state
			
            info.saveCallback(holdID, state)
        end)
    end
	
	

   
end 

function input.addNativeSettingsBinding(info) -- Add combined hotkey widget from info table

    if not nativeSettings.pathExists(info.nativeSettingsPath) then print("[InputManager] Invalid path for binding \"" .. info.id .. "\"") return end
    if not info.savedOptions then info.savedOptions = info.defaultOptions end
    if not info.savedOptions[info.id] then info.savedOptions[info.id] = info.defaultOptions[info.id] end -- Fallback to default options
    input.bindings[info.id] = {callback = info.callback, keys = {}} -- Binding information contains callback and keys with hold+key data

    local maxID = "keys"
    local controller = "keyboard"

    if(currentController == true)then
        controller = "gamepad"
    end

   
    if not info.savedOptions[info.id][controller][maxID] then 
        info.savedOptions[info.id][controller][maxID] = 
        info.defaultOptions[info.id][controller][maxID] 
    end

    if info.maxKeys ~= 1 then -- Add slider to change amount of key widgets
        nativeSettings.addRangeInt(info.nativeSettingsPath, info.maxKeysLabel, info.maxKeysDescription, 1, info.maxKeys, 1, info.savedOptions[info.id][controller][maxID], info.defaultOptions[info.id][controller][maxID], function(value)
            info.saveCallback(maxID, value)

            for i = value + 1, info.maxKeys do -- Remove keys
                if input.nuiTables[info.id][controller]["key_" .. i] then
                   
                    nativeSettings.removeOption(input.nuiTables[info.id][controller]["key_" .. i])
                    input.nuiTables[info.id][controller]["key_" .. i] = nil
                    
                    input.bindings[info.id]["keys"][i] = nil
                    
                    if input.nuiTables[info.id][controller]["hold_" .. i] then
                   
                        nativeSettings.removeOption(input.nuiTables[info.id][controller]["hold_" .. i])
                        input.nuiTables[info.id][controller]["hold_" .. i] = nil
                    end
                end
            end

            for i = 1, value do -- Add keys
                if not input.nuiTables[info.id][controller]["key_" .. i] then
                    addKeybind(info, i, nativeSettings)
                end
            end
        end)

    end
   
    for i = 1, info.savedOptions[info.id][controller][maxID] do
        addKeybind(info, i, nativeSettings)
    end
  
end

return input