

local UIPopupsManager = {}

---@type worlduiIGameController
local gameController

---@type inkGameNotificationData
local currentData

---@type inkGameNotificationToken
local currentToken

function UIPopupsManager.Inititalize()
	---@param self PopupsManager
	Observe('PopupsManager', 'OnPlayerAttach', function(self)
		gameController = self
	end)

	Observe('PopupsManager', 'OnPlayerDetach', function()
		gameController = nil
	end)

	---@param self gameuiInGameMenuGameController
	Observe('gameuiInGameMenuGameController', 'OnHandleMenuInput', function(self)
		gameController = self
	end)
end

function UIPopupsManager.IsReady()
	
	return Ref.IsDefined(gameController)
end

function UIPopupsManager.IsShown()
	return Ref.IsDefined(currentToken)
end

---@param controller inkGameController|inkLogicController
function UIPopupsManager.IsOwnPopup(controller)
	-- If there's no notification data then it's not our popup
	if not currentData then
		return false
	end

	local widgetData = controller:GetRootWidget():GetUserData(
		currentData:GetClassName()
	)

	-- If passed user data is not our notification data
	-- then it's not our popup either
	if Ref.NotEquals(currentData, widgetData) then
		return false
	end

	return true
end

---@param notificationData inkGameNotificationData
---@return inkGameNotificationToken
function UIPopupsManager.ShowPopup(notificationData)
	
	
	if not UIPopupsManager.IsReady() then
		return nil
	end

	currentData = notificationData
	currentToken = gameController:ShowGameNotification(notificationData)

	return currentToken
end

function UIPopupsManager.ClosePopup()
	currentToken = nil
	currentData = nil

	collectgarbage()
end

return UIPopupsManager