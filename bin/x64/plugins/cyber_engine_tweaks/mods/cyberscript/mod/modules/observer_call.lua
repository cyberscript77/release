print("CyberScript: observer module loaded")
cyberscript.module = cyberscript.module +1
--print("hot reload test")
---Observer and Overrider---
function SetObserver()
	
	--QuestJournalUI
	-- enum gameJournalQuestType
-- {
-- MainQuest = 0,
-- SideQuest = 1,
-- MinorQuest = 2,
-- StreetStory = 3,
-- Contract = 4,
-- VehicleQuest = 5
-- }

	
	
	
	ObserveAfter('HUDManager', 'InitializeHUD', function(self)
		HUDManager_InitializeHUD(self)
	end)
	
	ObserveAfter('SimpleQuestListItemController', 'OnDataChanged', function(self,value)
		SimpleQuestListItemController_OnDataChanged(self,value)
	end)
	
	
	
	ObserveAfter('SimpleQuestListItemController', 'OnPress', function(self,e)
		SimpleQuestListItemController_OnPress(self,value)
	end)
	
	ObserveAfter('questLogGameController', 'BuildQuestList', function(self)
		questLogGameController_BuildQuestList(self)
	end)
	
	--TODO
	---@param e QuestlListItemClicked
	ObserveAfter('questLogV2GameController', 'OnActiveQuestChanged', function(self, e)
	 questLogGameController_OnQuestListItemClicked(self,e)
		end)
	---@param self questLogGameController
	---@param e RequestChangeTrackedObjective
	ObserveAfter('questLogV2GameController', 'OnTrackingRequest', function(self, e)
		
		 questLogGameController_OnRequestChangeTrackedObjective(self,e)
	end)
	--TODO
	---@param self QuestListItemController
	ObserveAfter('QuestListItemController', 'UpdateDistance', function(self)
		QuestListItemController_UpdateDistance(self)
		end)
	---@param self QuestDetailsPanelController
	---@param questData JournalQuest
	ObserveAfter('QuestDetailsPanelController', 'Setup', function(self, questData)
		
		 QuestDetailsPanelController_Setup(self, questData)
	
	end)
	
	
	
	ObserveAfter('QuestDetailsPanelController', 'OnUpdateTrackedObjectiveEvent', function(self, e)
		
		 QuestDetailsPanelController_OnUpdateTrackedObjectiveEvent(self, e)
	end)
	
	
	
	--QuestJournalUI
	
	
	--QuestTrackerUI
	
	Observe('QuestTrackerGameController', 'OnTrackedEntryChanges', function(self)
		
		QuestTrackerGameController_OnTrackedEntryChanges(self)
		
	end)

	ObserveAfter('PhoneHotkeyController', 'UpdateData', function(self)
		
		PhoneHotkeyController_UpdateData(self)
		
	end)
	ObserveAfter('PhoneHotkeyController', 'CountMessages', function(self,convEntry, tracked)
		PhoneHotkeyController_CountMessages(self,convEntry, tracked)
		
		
	end)

	ObserveAfter('PhoneHotkeyController', 'Initialize', function(self)
		PhoneHotkeyController_Initialize(self)
		
		
	end)

	ObserveAfter('PhoneHotkeyController', 'OnPlayerAttach', function(self,player)
		PhoneHotkeyController_Initialize(self)
		
		
	end)
	
	--todotest
	Override('QuestTrackerGameController', 'UpdateTrackerData', function(self, wrappedmethod)
	
		QuestTrackerGameController_UpdateTrackerData(self, wrappedmethod)
	
	end)

	---@param self QuestTrackerGameController
	ObserveAfter('QuestTrackerGameController', 'OnMenuUpdate', function(self, value)
		
		 QuestTrackerGameController_OnMenuUpdate(self, value)
			
	end)
	
	--QuestTrackerUI
	
	
	
	
	
	ObserveAfter("BaseMappinBaseController", "UpdateRootState", function(this)
		
		 BaseMappinBaseController_UpdateRootState(this)

	end)
	
	
	
	
	
	
	Observe("HUDProgressBarController", "OnInitialize", function (this)
		HUDProgressBarController_OnInitialize(this)
	end)

	Observe("HUDProgressBarController", "Intro", function (this)
		HUDProgressBarController_OnInitialize(this)
	end)
	
	
	ObserveAfter("BackdoorInkGameController", "OnInitialize", function(this)
	BackdoorInkGameController_OnInitialize(this)
	
	end)
	
	ObserveAfter("hudCorpoController", "OnInitialize", function(this)
	
	hudCorpoController_OnInitialize(this)
	
	
	
	end)
	
	
	
	
	
	ObserveAfter("PlayerPuppet", "OnItemAddedEvent", function(this)
	
	
	
	end)
	
	ObserveAfter("PanzerHUDGameController", "OnInitialize", function(this)
	
PanzerHUDGameController_OnInitialize(this)
	
	end)
	
	
	ObserveAfter("HudPhoneAvatarController", "OnInitialize", function(this)
	
	 HudPhoneAvatarController_OnInitialize(this)
	end)
	ObserveAfter("HudPhoneGameController", "OnInitialize", function(this)
	
	 HudPhoneGameController_OnInitialize(this)
	end)
	
	ObserveAfter("HudPhoneGameController", "ShowAvatar", function(this)
	
	 HudPhoneGameController_OnInitialize(this)
	end)
	
	ObserveAfter("PlayerPuppet", "ReactToHitProcess", function(this,hitEvent)
	
	
	PlayerPuppet_ReactToHitProcess(this,hitEvent)
   
	
	end)
	
	
	ObserveAfter("PlayerPuppet", "SetEntityNoticedPlayerBBValue", function(this,b)
		PlayerPuppet_SetEntityNoticedPlayerBBValue(this,b)
	end)
	
	ObserveAfter("PlayerPuppet", "OnBeingTarget", function(this,evt)
		
		
		PlayerPuppet_OnBeingTarget(this,evt)
	end) 
	
	
	ObserveAfter("MinimapContainerController", "OnInitialize", function(this)
		MinimapContainerController_OnInitialize(this)
		
		
	end)
	
	ObserveAfter("healthbarWidgetGameController", "OnInitialize", function(this)
		
		healthbarWidgetGameController_OnInitialize(this)
		
		
	end)
	
	
	
	ObserveAfter("StaminabarWidgetGameController", "OnInitialize", function(this)
		
		StaminabarWidgetGameController_OnInitialize(this)
		
		
	end)
	
	ObserveAfter("HotkeysWidgetController", "OnInitialize", function(this)
		
		HotkeysWidgetController_OnInitialize(this)
		
		
	end)
	
	ObserveAfter("NPCPuppet", "CompileScannerChunks", function(this)
		
		NPCPuppet_CompileScannerChunks(this)
		
		
		
		
		
	end)
	ObserveBefore("GameObject", "OnScanningLookedAt", function(this)
		
		NPCPuppet_CompileScannerChunksBefore(this)
		
		
		
		
		
	end)
	
	
	
	
	
	ObserveAfter('IncomingCallGameController', 'OnInitialize', function(this)
		
	IncomingCallGameController_OnInitialize(this)
	end)
	
	
	
	
	ObserveAfter('IncomingCallGameController', 'GetIncomingContact', function(this)
		
		 IncomingCallGameController_GetIncomingContact(this)
	end)
	
	
	
	ObserveAfter('TutorialPopupGameController', 'OnInitialize', function(this)
		
		 TutorialPopupGameController_OnInitialize(this)
	end)
	
	ObserveAfter('TutorialPopupGameController', 'OnPlayerAttach', function(this,playerPuppet)
		
		TutorialPopupGameController_OnPlayerAttach(this,playerPuppet)
	end)
	
	ObserveBefore('WorldMapMenuGameController', 'GetDistrictAnimation', function(this,view ,show)
		WorldMapMenuGameController_GetDistrictAnimation(this,view ,show)
			WorldMapMenuGameController_OnInitialize(this)
	end)
	
	ObserveAfter('WorldMapMenuGameController', 'OnInitialize', function(this)
		WorldMapMenuGameController_OnInitialize(this)
		
	end)

	ObserveAfter('WorldMapMenuGameController', 'OnEntityAttached', function(this)
		WorldMapMenuGameController_OnInitialize(this)
		
	end)
	
	ObserveAfter('WorldMapMenuGameController', 'GetDistrictAnimation', function(this,view ,show)
		 WorldMapMenuGameController_GetDistrictAnimation(this,view ,show)
		 	WorldMapMenuGameController_OnInitialize(this)
	end)
	
	ObserveAfter('TrackQuestNotificationAction', 'TrackFirstObjective', function(this,questEntry)
		
		
		TrackQuestNotificationAction_TrackFirstObjective(this,questEntry)
	end)
	
	ObserveAfter('WorldMapMenuGameController', 'OnUpdateHoveredDistricts', function(this,district,subdistrict)
		WorldMapMenuGameController_OnUpdateHoveredDistricts(this,district,subdistrict)
			WorldMapMenuGameController_OnInitialize(this)
	end)
	
	ObserveBefore("ShardItemVirtualController", "OnToggledOn", function (this)
		
		
	end)
	
	ObserveAfter("CodexGameController", "PopulateData", function(this)
		CodexGameController_PopulateData(this)
	
	end)
	

		
	ObserveAfter("ShardsVirtualNestedListController", "SetData", function(this,data, keepToggledLevels, sortOnce)
			
		ShardsMenuGameController_PopulateData(this,data, keepToggledLevels, sortOnce)
	end)
	

	--TODO
	ObserveAfter('WorldMapMenuGameController', 'OnSelectedDistrictChanged', function(this,oldDistrict,newDistrict)
		
		
		
		WorldMapMenuGameController_OnSelectedDistrictChanged(this,oldDistrict,newDistrict)
			WorldMapMenuGameController_OnInitialize(this)
	end)
	
	ObserveAfter('WorldMapMenuGameController', 'OnZoomLevelChanged', function(this,oldLevel,newLevel)
		
		WorldMapMenuGameController_OnZoomLevelChanged(this,oldLevel,newLevel)
			WorldMapMenuGameController_OnInitialize(this)
	end)
	
	ObserveBefore('WorldMapMenuGameController', 'OnSetUserData', function(this,userData )
		
			WorldMapMenuGameController_OnInitialize(this)
		
	end)
	Observe("SettingsMainGameController", "RequestClose", function (_, _, target) -- Check if activated button is the custom mods button
		
		SettingsMainGameController_RequestClose (_, _, target)
	end)
	
	Observe('PlayerPuppet', 'OnGameAttached', function(this)
		 PlayerPuppet_OnGameAttached(this)
	end)
	
	ObserveAfter('JournalNotificationQueue','OnMenuUpdate', function(self)
		 JournalNotificationQueue_OnMenuUpdate(self)
	end)
	
	ObserveAfter('JournalNotificationQueue','OnInitialize', function(self)
		JournalNotificationQueue_OnInitialize(self)
	end)
	
	Observe('BaseWorldMapMappinController', 'SelectMappin', function(self)
		BaseWorldMapMappinController_SelectMappin(self)
	end)
	
	
	
		
	ObserveAfter('BrowserController', 'Init', function(self,gameController)
	
	
	 BrowserController_OnInitialize(self,gameController)
	end)
	

	
	ObserveAfter('WebPage', 'OnInitialize', function(self)
	 WebPage_OnInitialize(self)
	end)
	
	
	ObserveAfter('WebPage', 'FillPageFromJournal', function(self,page)
	
	 WebPage_FillPageFromJournal(self,page)
	
	end)
	ObserveAfter('BrowserController', 'OnPageSpawned', function(this, widget, userData)
		
		 BrowserController_OnPageSpawned(this, widget, userData)
	end)
	
	ObserveAfter('WebPage', 'FillCustomHomePage', function(this, pgNum, journalManager)
		
		 WebPage_FillPageFromJournalWebExt(this)
	end)
	
	
	
	ObserveAfter('WorldMapTooltipController', 'SetData', function(self,data,menu)
		WorldMapTooltipController_SetData(self,data,menu)
	end)
	
	ObserveAfter('WorldMapTooltipContainer', 'SetData', function(self,target,data,menu)
	
	WorldMapTooltipContainer_SetData(self,target,data,menu)
	
	end)
	
	Observe('WorldMapMenuGameController', 'UntrackCustomPositionMappin', function(self)
		WorldMapMenuGameController_UntrackCustomPositionMappin(self)
			WorldMapMenuGameController_OnInitialize(self)
	end)
	
	ObserveAfter('BraindanceGameController','OnInitialize', function(self)
		
	 BraindanceGameController_OnInitialize(self)
		
		
		
		
	end)
	
	Observe('QuestTrackerGameController', 'OnInitialize', function()
		 QuestTrackerGameController_OnInitialize()
	end)
	
	Observe('QuestTrackerGameController', 'OnUninitialize', function()
		
		QuestTrackerGameController_OnUninitialize()
	end)
	
	Observe('interactionWidgetGameController', 'OnInitialize', function(self)
		interactionWidgetGameController_OnInitialize(self)
	end)
	
	ObserveAfter('ChattersGameController','OnInitialize', function(self) 
		ChattersGameController_OnInitialize(self) 
	end)
	
	ObserveAfter('ChattersGameController','OnPlayerAttach', function(self,playerGameObject) 
		ChattersGameController_OnPlayerAttach(self,playerGameObject) 
	end)
	
	ObserveAfter('SubtitlesGameController','OnInitialize', function(self) 
		
		SubtitlesGameController_OnInitialize(self) 
	end)
	
	
	Observe('interactionWidgetGameController', 'OnItemSpawned', function(self)
		 interactionWidgetGameController_OnItemSpawned(self)
	end)
	
	Observe('ChattersGameController','SetupLine', function(self) 
		ChattersGameController_SetupLine(self) 
	end)
	

	
	Observe('BaseSubtitlesGameController','OnUninitialize', function(self) 
		 BaseSubtitlesGameController_OnUninitialize(self) 
	end)
	
	
	Observe('NPCPuppet', 'SendAfterDeathOrDefeatEvent', function(target)
		NPCPuppet_SendAfterDeathOrDefeatEvent(target)
	end)
	
	
	
	
	
	ObserveAfter('MessengerDialogViewController','SetVisited', function(this, records) 
		MessengerDialogViewController_SetVisited(this, records) 
	end)
	
	ObserveAfter('MessengerDialogViewController','AttachJournalManager', function(this, journalManager) 
		
		
		MessengerDialogViewController_AttachJournalManager(this, journalManager) 
		
	end)
	
	ObserveAfter('MessengerDialogViewController','OnInitialize', function(this) 
		
		MessengerDialogViewController_OnInitialize(this) 
		
	end)
	--todotest
	-- Override('PhoneMessagePopupGameController', 'SetupData', function(this,wrappedMethod)
	-- 	PhoneMessagePopupGameController_SetupData(this,wrappedMethod)
		
	-- end)
	
	
	ObserveAfter('PhoneMessagePopupGameController', 'OnRefresh', function(this)
		
		
	end)
	
	-- Observe('MessengerDialogViewController', 'ShowThread', function(self,thread)
	-- 	MessengerDialogViewController_ShowThread(self,thread)
	-- end)
	
	-- Observe('MessengerDialogViewController', 'ShowDialog', function(self,contact)
	-- 	MessengerDialogViewController_ShowDialog(self,contact)
	-- end)
	
	ObserveAfter('MessengerDialogViewController', 'UpdateData', function(self,animateLastMessage,setVisited)
		MessengerDialogViewController_UpdateData(self,animateLastMessage,setVisited)
	end)

	
	Observe('MessangerItemRenderer', 'GetData', function(self)
		MessangerItemRenderer_GetData(self)
	end)
	
	Observe('MessangerItemRenderer', 'OnJournalEntryUpdated', function(self,entry,extraData)
		MessangerItemRenderer_OnJournalEntryUpdated(self,entry,extraData)
		end)
	
	
	
	Observe('MessangerReplyItemRenderer', 'OnJournalEntryUpdated', function(self,entry,extraData)
		MessangerReplyItemRenderer_OnJournalEntryUpdated(self,entry,extraData)
	end)
		
	
	
	Observe('MessengerDialogViewController', 'ActivateReply', function(self,target)
		MessengerDialogViewController_ActivateReply(self,target)
	end)
	
	
	
	
	
	
	
	
	
	
	
	
	ObserveAfter("PhoneDialerLogicController", "PopulateListData", function(this,contactDataArray,selectIndex, itemHash)
		
		PhoneDialerGameController_PopulateData(this,contactDataArray,selectIndex, itemHash)
	end)
	
	ObserveAfter('NewHudPhoneGameController','CallSelectedContact', function(this,contactData)
		PhoneDialerGameController_CallSelectedContact_Observer(this,contactData)
		
	end)


	
	ObserveAfter('NewHudPhoneGameController','OnSmsMessageLostFocus', function(this,evt)
		NewHudPhoneGameController_ToggleShowAllMessages(this,nil)
	
		
	end)
	
	
	ObserveAfter('NewHudPhoneGameController','SetScreenType', function(this,type)
		NewHudPhoneGameController_ToggleShowAllMessages(this,type)
		
	end)
	
	
	ObserveAfter('NewHudPhoneGameController','ExecuteAction', function(this)
		NewHudPhoneGameController_ExecuteAction(this)
		
	end)
	
	
	
	ObserveAfter('NewHudPhoneGameController','ShowSelectedContactMessages', function(this,contactData)
		NewHudPhoneGameController_ShowSelectedContactMessages(this,contactData)
		
	end)
	
	ObserveAfter('NewHudPhoneGameController','GotoSmsMessenger', function(this,contactData)
		NewHudPhoneGameController_GotoSmsMessenger(this,contactData)
		
	end)
	
	ObserveAfter('NewHudPhoneGameController','RefreshSmsMessager', function(this,contactData)
		NewHudPhoneGameController_RefreshSmsMessager(this,contactData)
		
	end)

	ObserveAfter('NewHudPhoneGameController','OnContactSelectionChanged', function(this,evt)
		NewHudPhoneGameController_OnContactSelectionChanged(this,evt)
		
	end)
	
	ObserveAfter('NewHudPhoneGameController','FocusSmsMessenger', function(this)
		NewHudPhoneGameController_FocusSmsMessenger(this)
		
	end)
	
	ObserveAfter('NewHudPhoneGameController','OnSmsMessageGotFocus', function(this,evt)
		NewHudPhoneGameController_OnSmsMessageGotFocus(this,evt)
		
	end)
	
	ObserveAfter('PhoneSystem','OnTriggerCall', function(this, request)
		PhoneSystem_OnTriggerCall(this, request)
	end)
	
	
	
	
	
	
	
	
	
	
	
	
	
	Observe("NewHudPhoneGameController", "OnMenuUpdate", function(this) 
		NewHudPhoneGameController_FocusSmsMessenger(this)  
	end)

	Observe("NewHudPhoneGameController", "OnPlayerAttach", function(this) 
		NewHudPhoneGameController_FocusSmsMessenger(this)  
	end)

	Observe("NewHudPhoneGameController", "OnInitialize", function(this) 
		NewHudPhoneGameController_FocusSmsMessenger(this) 
	end)
	
	
	Observe('PopupsManager', 'OnPlayerAttach', function(self)
		
		
	 PopupsManager_OnPlayerAttach(self)
	end)
	
	Observe('PopupsManager', 'OnPlayerDetach', function()
		 PopupsManager_OnPlayerDetach()
	end)
	
	
	
	Observe('PlayerPuppet', 'OnDeath', function()
		PlayerPuppet_OnDeath()
	end)
	
	
	
	Override('DialogChoiceLogicController', 'UpdateView', function(self,wrappedMethod)
		
		DialogChoiceLogicController_UpdateView(self,wrappedMethod)
		
	end)
	
	
	ObserveAfter('interactionItemLogicController', 'SetData', function(self,data,skillcheck)
		
		interactionItemLogicController_SetData(self,data,skillcheck)
		
	end)
	
	
	
	
	
	ObserveAfter('ShardNotificationController', 'OnInitialize', function(self)
		
		ShardNotificationController_OnInitialize(self)
	end)
	
	ObserveAfter('ShardNotificationController', 'OnPlayerAttach', function(self,playerPuppet)
		 ShardNotificationController_OnPlayerAttach(self,playerPuppet)
	end)
	
	Observe('ShardNotificationController', 'SetButtonHints', function(self)
		
	ShardNotificationController_SetButtonHints(self)
		
		end)
	
	Observe('ShardNotificationController', 'Close', function(self)
	ShardNotificationController_Close(self)
	end)
	
	Observe('gameuiInGameMenuGameController', 'OnHandleMenuInput', function(self)
	 gameuiInGameMenuGameController_OnHandleMenuInput(self)
	end)
	
	Observe('gameuiInGameMenuGameController', 'SpawnMenuInstanceEvent', function(self) -- Get Controller to spawn popup
		
		gameuiInGameMenuGameController_SpawnMenuInstanceEvent(self)
	end)
	
	
	
	Observe('PopupsManager', 'OnMessagePopupUseCloseRequest', function(self)
		PopupsManager_OnMessagePopupUseCloseRequest(self)
		
	end)

	
	
end

function interactionUI_init() -- Register needed observers
    Observe("InteractionUIBase", "OnDialogsData", function(this)
        interactionUI.baseControler = this
    end)

    Observe("InteractionUIBase", "OnInitialize", function(this)
        interactionUI.baseControler = this
		GameController["InteractionUIBase"] = this
    end)

    Observe('PlayerPuppet', 'OnAction', function(_, action)
       interactionUI.OnAction(action)
    end)

    Override("InteractionUIBase", "OnDialogsSelectIndex", function(_, idx, wrapped) -- Avoid index getting set by game
       interactionUI.OnDialogsSelectIndex( idx, wrapped)
    end)

    Override("InteractionUIBase", "OnDialogsData", function(this, value, wrapped) -- Avoid interaction getting overriden by game
        interactionUI.OnDialogsData(this, value, wrapped)
      --  wrapped(value)
    end)

    Override("dialogWidgetGameController", "OnDialogsActivateHub", function(_, id, wrapped) -- Avoid interaction getting overriden by game
        interactionUI.OnDialogsActivateHub(id, wrapped)
    end)
end


function inputManager_init() -- Register needed observers
     Observe("SettingsSelectorControllerKeyBinding", "ListenForInput", function(this) -- A keybind widget is listening for input, so should we (Since gamepad inputs are not sent to the native OnKeyBindingEvent by default)
        GameController["SettingsSelectorControllerKeyBinding"] = this
    end)

    ObserveBefore("PlayerPuppet", "OnGameAttached", function()
		if(inputManager.inputListener == nil) then inputManager.onInit() end
        Game.GetCallbackSystem():UnregisterCallback("Input/Key", inputManager.inputListener:Target())
        Game.GetCallbackSystem():RegisterCallback("Input/Key", inputManager.inputListener:Target(), inputManager.inputListener:Function("OnKeyInput"))
    end)

    ObserveBefore("PlayerPuppet", "OnDetach", function()
		if(inputManager.inputListener == nil) then inputManager.onInit() end
        Game.GetCallbackSystem():UnregisterCallback("Input/Key", inputManager.inputListener:Target())
    end)
end

function SetOverrider()
	
	-- Override("DeathLandEvents", "OnEnter", function(this,stateContext, scriptInterface,wrappedMethod)
	-- logme(10,"tombé1")
	-- this:PlayHardLandingEffects(stateContext, scriptInterface)
    -- this:BroadcastLandingStim(stateContext, scriptInterface, gamedataStimType.LandingHard)
    -- this:OnForcedExit(stateContext, scriptInterface)
    -- this:SetDetailedState(scriptInterface, gamePSMDetailedLocomotionStates.HardLand);
    -- this:SetBlackboardIntVariable(scriptInterface, GetAllBlackboardDefs().PlayerStateMachine.Landing, EnumInt(gamePSMLandingState.HardLand))
	
	-- end)
	
	ObserveAfter("WorldMappinsContainerController", "CreateMappinUIProfile", function(this,mappin, mappinVariant, customData)
		
		 MappinBaseController_SetRootVisible(this,mappin, mappinVariant, customData)

	end)
	
	
	
	 ObserveAfter("SmartWindowInkGameController", "InitializeMainLayout", function(this)
		
		SmartWindowInkGameController_InitializeMainLayout(this)
		
	 end)
	--TODO
	-- Override("PreventionSpawnSystem", "SpawnRequestFinished", function(this,requestResult,wrappedMethod)
	-- 	PreventionSpawnSystem_SpawnCallback(this,requestResult,wrappedMethod)
	-- end)
	 
	Override("QuestMappinLinkController", "Setup", function(this,mappinEntry,mappinHash,jumpTo,isTracked,wrappedMethod)

		QuestMappinLinkController_Setup(this,mappinEntry,mappinHash,jumpTo,isTracked,wrappedMethod)
		
	end)
	
	Override("QuestCodexLinkController", "SetupCodexLink", function(this,codexEntry,wrappedMethod)

		QuestCodexLinkController_SetupCodexLink(this,codexEntry,wrappedMethod)
	end)
	
	
	
	
	Override("CodexPopupGameController", "SetupData", function(this,wrappedMethod)
		CodexPopupGameController_SetupData(this,wrappedMethod)
		
	end)
	
	
	Override("CodexEntryViewController", "ShowEntry", function(this,data, inputDevice, inputScheme,wrappedMethod)
		
		  
		CodexEntryViewController_ShowEntry(this,data, inputDevice, inputScheme,wrappedMethod)
		
	end)
	
	
	
	
	Override('PhoneDialerGameController','CallSelectedContact',function(this, wrappedMethod)
		
		PhoneDialerGameController_CallSelectedContact(this, wrappedMethod)
	end
	)
	
	
	
	
	--TODO
	-- Override('WorldMapMenuGameController','OnSelectedDistrictChanged', function(self,oldDistrict,newDistrict) 
		 -- WorldMapMenuGameController_OnSelectedDistrictChanged(self,oldDistrict,newDistrict) 
		 	-- WorldMapMenuGameController_OnInitialize(self)
	-- end)
	
	Override('WorldMapGangItemController','SetData', function(self,affiliationRecord) 
		
		WorldMapGangItemController_SetData(self,affiliationRecord) 
	end)
	
	
	
	
	
	---Scanner
	Override('ScannervehicleGameController', 'OnVehicleInfoChanged', function(this, value,wrappedMethod)
		ScannervehicleGameController_OnVehicleInfoChanged(this, value,wrappedMethod)
		--print("OnVehicleInfoChanged")
	end)
	
	
	Override('ScannerNPCHeaderGameController', 'OnNameChanged', function(this, value,wrappedMethod)
		ScannerNPCHeaderGameController_OnNameChanged(this, value,wrappedMethod)
		--print("OnNameChanged")
	end)
	
	Override('ScannerNPCHeaderGameController', 'OnLevelChanged', function(this, value,wrappedMethod)
		 ScannerNPCHeaderGameController_OnLevelChanged(this, value,wrappedMethod)
		 --print("OnLevelChanged")
	end)
	
	Override('ScannerNPCHeaderGameController', 'OnAttitudeChange', function(this, value,wrappedMethod)
		 ScannerNPCHeaderGameController_OnAttitudeChange(this, value,wrappedMethod)
		 --print("OnAttitudeChange")
		
	end)
	
	Override('ScannerNPCBodyGameController', 'OnFactionChanged', function(this, value,wrappedMethod)
		ScannerNPCBodyGameController_OnFactionChanged(this, value,wrappedMethod)
		--print("OnFactionChanged")
	end)
	
	
	Override('ScannerNPCBodyGameController', 'OnRarityChanged', function(this, value,wrappedMethod)
		 ScannerNPCBodyGameController_OnRarityChanged(this, value,wrappedMethod)
		 --print("OnRarityChanged")
	end)
	
	Override('ScannerBountySystemGameController', 'OnBountySystemChanged', function(this, value,wrappedMethod)
		ScannerBountySystemGameController_OnBountySystemChanged(this, value,wrappedMethod)
		--print("OnBountySystemChanged")
	end)
	
	Override('scannerDetailsGameController', 'RefreshLayout', function(this,wrappedMethod)
		scannerDetailsGameController_RefreshLayout(this,wrappedMethod)
		--print("RefreshLayout")
	end)
	
	
	Override('QuickhacksListGameController', 'PopulateData', function(this,data,wrappedMethod)
		QuickhacksListGameController_PopulateData(this,data,wrappedMethod)
	end)
	
	
	
	
	
	ObserveAfter('QuickhacksListGameController', 'ApplyQuickHack', function(this,shouldUseUI)
		QuickhacksListGameController_ApplyQuickHack(this,shouldUseUI)
		
	end)
	
	Override('QuickhacksListGameController', 'OnQuickhackStarted', function(this,value,wrappedMethod)
		QuickhacksListGameController_OnQuickhackStarted(this,value,wrappedMethod)
		
	end)
	

	
	
	Override('BrowserController', 'LoadWebPage', function(self,address,wrappedMethod)
	 BrowserController_LoadWebPage(self,address,wrappedMethod)
	
	end)
	Override('WorldMapMenuGameController', 'ShowGangsInfo', function(self,district,sub)
		
		WorldMapMenuGameController_ShowGangsInfo(self,district,sub)
			WorldMapMenuGameController_OnInitialize(self)
	end)
	
	Override('ComputerInkGameController', 'ShowMenuByName', function(this, elementName,wrappedMethod)
		ComputerInkGameController_ShowMenuByName(this, elementName, wrappedMethod)
		
	end)



		
	ObserveAfter('MessengerNotification', 'OnActionTriggered', function(self)
		
		MessengerNotification_OnAction(self)
		
	end)

	Observe('VehicleSummonWidgetGameController', 'OnVehicleSummonStateChanged', function(state,value ) 
		
		VehicleSummonWidgetGameController_OnVehicleSummonStateChanged(state,value ) 
	end)
		

	
end
---Observer and Overrider---
