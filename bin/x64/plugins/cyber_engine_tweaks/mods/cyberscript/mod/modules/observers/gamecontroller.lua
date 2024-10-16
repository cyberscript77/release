function HUDManager_InitializeHUD(self)
	if(observerthread1  == true or moddisabled == true)    then return end
	GameController["HUDManager"] = self
	
	
end

function HUDProgressBarController_OnInitialize(thos)
	
	if(observerthread2 == true or moddisabled  == true)     then return end
	GameController["HUDProgressBarController"] = thos
end


function BackdoorInkGameController_OnInitialize(thos)
	if(observerthread2  == true or moddisabled == true)    then return end
	GameController["BackdoorInkGameController"] = thos
	
	--thos:GetRootWidget():SetVisible(true) E3 smart windows issue
	
end


function hudCorpoController_OnInitialize(thos)
	if(observerthread2 == true or moddisabled  == true)     then return end
	
	GameController["hudCorpoController"] = thos
	hudCorpoControllerReady = true
	
	
	
end


function PanzerHUDGameController_OnInitialize(thos)
	if(observerthread2 == true or moddisabled  == true)     then return end
	GameController["PanzerHUDGameController"] = thos
	PanzerHUDGameControllerReady = true
	
	displayHUD["hud_panzer"] = GameController["PanzerHUDGameController"] :GetRootWidget()
	
end




function HudPhoneAvatarController_OnInitialize(this)
	if(observerthread3  == true or moddisabled == true)    then return end
	GameController["HudPhoneAvatarController"] = this
end
function HudPhoneGameController_OnInitialize(this)
	if(observerthread3  == true or moddisabled == true)    then return end
	GameController["HudPhoneGameController"] = this
end


function HudPhoneAvatarController_ShowAvatar(this,showAvatar)
	if(observerthread3  == true or moddisabled == true)    then return end
	
	--This is already set by the OnInitialize
	--GameController["HudPhoneAvatarController"] = this
	
	hudPhoneShowAvatar = showAvatar
end



function MinimapContainerController_OnInitialize(thos)
	if(observerthread3  == true or moddisabled == true)    then return end
	GameController["MinimapContainerController"]  = thos
	
	
end

function PhoneHotkeyController_Initialize(self)
	GameController["PhoneHotkeyController"] = self
	

end
function healthbarWidgetGameController_OnInitialize(thos)
	if(observerthread3  == true or moddisabled == true)    then return end
	GameController["healthbarWidgetGameController"]  = thos
	
	
end


function StaminabarWidgetGameController_OnInitialize(thos)
	if(observerthread3  == true or moddisabled == true)    then return end
	GameController["StaminabarWidgetGameController"]  = thos
	
	
end

function HotkeysWidgetController_OnInitialize(thos)
	if(observerthread3  == true or moddisabled == true)    then return end
	GameController["HotkeysWidgetController"]  = thos
	
	
end


function IncomingCallGameController_OnInitialize(thos)
	
	if(observerthread4  == true or moddisabled == true)    then return end
	
	GameController["IncomingCallGameController"]  = thos
end

function IncomingCallGameController_GetIncomingContact(thos)
	
	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["IncomingCallGameController"]  = thos
end


function TutorialPopupGameController_OnInitialize(thos)
	
	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["TutorialPopupGameController"]  = thos
end

function TutorialPopupGameController_OnPlayerAttach(thos,playerPuppet)
	
	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["TutorialPopupGameController"]  = thos
end


function WorldMapMenuGameController_OnInitialize(this)
	
	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["WorldMapMenuGameController"]  = this
	
end



function JournalNotificationQueue_OnMenuUpdate(self)
	----logme(2,"obs2")
	
	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["JournalNotificationQueue"]  = self
end

function JournalNotificationQueue_OnInitialize(self)
	----logme(2,"obs2")
	
	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["JournalNotificationQueue"]  = self
end


function BraindanceGameController_OnInitialize(self)
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	GameController["BraindanceGameController"]  = self
	
	GameController["BraindanceGameControllerRoot"] = self:GetRootWidget().parentWidget
	
	
	
	
end


function interactionWidgetGameController_OnInitialize(self)
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	Cron.NextTick(function()
		
		GameController["interactionWidgetGameController"]  = self
		--logme(2,"new interact hub")
	end)
end

function ChattersGameController_OnInitialize(self) 
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	GameController["ChattersGameController"]  = self
	
	--logme(2,"Chat Sub Controller Init")
	
end

function ChattersGameController_OnPlayerAttach(self,playerGameObject) 
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	GameController["ChattersGameController"]  = self
	
	--logme(2,"Chat Sub Controller Init")
end

function SubtitlesGameController_OnInitialize(self) 
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	GameController["SubtitlesGameController"]  = self

end


function interactionWidgetGameController_OnItemSpawned(self)
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	if(GameController["interactionWidgetGameController"] == nil) then
		Cron.NextTick(function()
			
			GameController["interactionWidgetGameController"]  = self
			logme(2,"new interact hub")
		end)
	end
end

function ChattersGameController_SetupLine(self) 
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	if(currentChattersGameController == nil) then
		--logme(2,"obs99")
		Cron.NextTick(function()
			
			GameController["ChattersGameController"]  = self
			--logme(2,"Chat Sub Controller Init")
		end)
	end
end


function BaseSubtitlesGameController_OnUninitialize(self) 
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	currentChattersGameController = nil
	currentSubtitlesGameController = nil
end


function MessengerGameController_OnInitialize(this) 
	

	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["MessengerGameController"] = this
end


function PopupsManager_OnPlayerAttach(self)
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	
	GameController["PopupsManager"]  = self
end

function PopupsManager_OnPlayerDetach()
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	radiopopup = nil
end



function gameuiInGameMenuGameController_OnHandleMenuInput(self)
	if(observerthread5 == true or moddisabled  == true)   then return end
	GameController["gameuiInGameMenuGameController"]  = self
end

function gameuiInGameMenuGameController_SpawnMenuInstanceEvent(self) -- Get Controller to spawn popup
	if(observerthread5 == true or moddisabled  == true)   then return end
	GameController["gameuiInGameMenuGameController"]  = self
end

function NewHudPhoneGameController_ShowSelectedContactMessages(this,contactData) 
	

	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["NewHudPhoneGameController"] = this
end

function NewHudPhoneGameController_GotoSmsMessenger(this,contactData) 
	

	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["NewHudPhoneGameController"] = this
	
end

function NewHudPhoneGameController_FocusSmsMessenger(this) 
	

	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["NewHudPhoneGameController"] = this
end

function NewHudPhoneGameController_OnSmsMessageGotFocus(this,evt)
	

	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["NewHudPhoneGameController"] = this
	
	
end

function NewHudPhoneGameController_ExecuteAction(this,types) 
	

	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["NewHudPhoneGameController"] = this
end

function MessengerDialogViewController_AttachJournalManager(thos, journalManager) 
	

	
	if(observerthread4 == true or moddisabled  == true)   then return end
	GameController["MessengerDialogViewController"]  = thos
	
end



function NewHudPhoneGameController_RefreshSmsMessager(this,contactData) 
	

	if(observerthread4  == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))    then return end
	GameController["NewHudPhoneGameController"] = this
	
	
end


function MessengerDialogViewController_OnInitialize(thos) 
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	
	GameController["MessengerDialogViewController"]  = thos
	
end
