logme(1,"CyberScript: observer module loaded")
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

	ObserveAfter('questLogGameController', 'BuildQuestList', function(self)
		questLogGameController_BuildQuestList(self)
	end)
	
	---@param e QuestlListItemClicked
	ObserveAfter('questLogGameController', 'OnQuestListItemClicked', function(self, e)
	 questLogGameController_OnQuestListItemClicked(self,e)
		end)
	---@param self questLogGameController
	---@param e RequestChangeTrackedObjective
	ObserveAfter('questLogGameController', 'OnRequestChangeTrackedObjective', function(self, e)
		
		 questLogGameController_OnRequestChangeTrackedObjective(self,e)
	end)
	---@param self QuestListItemController
	ObserveAfter('QuestListItemController', 'UpdateDistance', function(self)
		QuestListItemController_UpdateDistance(self)
		end)
	---@param self QuestDetailsPanelController
	---@param questData JournalQuest
	ObserveAfter('QuestDetailsPanelController', 'Setup', function(self, questData)
		
		 QuestDetailsPanelController_Setup(self, questData)
	
	end)
	
	ObserveAfter('GenericNotificationController', 'SetNotificationData', function(self, notificationData)
		 GenericNotificationController_SetNotificationData(self, notificationData)
		
	
	end)
	
	
	ObserveAfter('QuestDetailsPanelController', 'OnUpdateTrackedObjectiveEvent', function(self, e)
		
		 QuestDetailsPanelController_OnUpdateTrackedObjectiveEvent(self, e)
	end)
	
	Override('QuestListHeaderController', 'Setup', function(self, titleLocKey,questType,wrappedMethod)
		
		
		 QuestListHeaderController_Setup(self, titleLocKey,questType,wrappedMethod)
		
		
	end)
	
	
	--QuestJournalUI
	
	
	--QuestTrackerUI
	
	Observe('QuestTrackerGameController', 'OnTrackedEntryChanges', function(self)
		
		QuestTrackerGameController_OnTrackedEntryChanges(self)
		
	end)
	
	Override('QuestTrackerGameController', 'UpdateTrackerData', function(self, wrappedmethod)
	
		QuestTrackerGameController_UpdateTrackerData(self, wrappedmethod)
	
	end)

	---@param self QuestTrackerGameController
	ObserveAfter('QuestTrackerGameController', 'OnMenuUpdate', function(self, value)
		
		 QuestTrackerGameController_OnMenuUpdate(self, value)
			
	end)
	
	--QuestTrackerUI
	
	
	ObserveAfter("ComputerMainLayoutWidgetController", "OnScreenSaverSpawned", function(this,widget,userData)
		
		 ComputerMainLayoutWidgetController_OnScreenSaverSpawned(this,widget,userData)

	end)
	ObserveAfter("ComputerMainLayoutWidgetController", "OnMailsMenuSpawned", function(this,widget,userData)
		
		 ComputerMainLayoutWidgetController_OnMailsMenuSpawned(this,widget,userData)

	end)
	
	
	
	ObserveAfter("BaseMappinBaseController", "UpdateRootState", function(this)
		
		 BaseMappinBaseController_UpdateRootState(this)

	end)
	
	
	
	--perk
	 ObserveAfter("CodexUtils", "ConvertToCodexData", function(this,journal, currentEntry, currentGroupIndex, stateFilter, newEntries, activeDataSync, useFallbackImages)
		print(currentEntry.id)
		-- PerksMainGameController_SetupLayout(this,screenType)
	end)
	
	-- Override("PerkScreenController", "Setup", function(this,displayData, dataManager , startingIndex,wrappedMethod)
	
		-- PerkScreenController_Setup(this,displayData, dataManager , startingIndex,wrappedMethod)
	-- end)
	
	-- ObserveAfter("PerkDisplayController", "Setup", function(this,displayData, dataManager, index)
	
		-- PerkDisplayController_Setup(this,displayData, dataManager , startingIndex)
	-- end)
		--perk
	
	
	
	ObserveAfter("ComputerMainLayoutWidgetController", "ShowMails", function(this)
		
		 ComputerInkGameController_ShowMails(this)

	end)
	
	ObserveAfter("ComputerMenuWidgetController", "InitializeFiles", function(this,gameController,widgetsData)
		ComputerMenuWidgetController_InitializeFiles(this,gameController,widgetsData)
		

	end)
	
	ObserveAfter("ComputerMenuWidgetController", "InitializeFilesThumbnails", function(this,gameController,widgetsData)
		ComputerMenuWidgetController_InitializeFilesThumbnails(this,gameController,widgetsData)
		

	end)
	
	ObserveAfter("ComputerDocumentWidgetController", "Initialize", function(this,gameController,widgetsData)
		ComputerDocumentWidgetController_Initialize(this,gameController,widgetsData)
		

	end)
	
	ObserveAfter("FullscreenVendorGameController", "PopulateVendorInventory", function(this)
	 FullscreenVendorGameController_PopulateVendorInventory(this)
	end)
	
	
	
	Observe("HUDProgressBarController", "OnInitialize", function (this)
		HUDProgressBarController_OnInitialize(this)
	end)

	Observe("HUDProgressBarController", "Intro", function (this)
		HUDProgressBarController_OnInitialize(this)
	end)
	
	
	ObserveAfter("AnimationControllerComponent", "ApplyFeature", function(this,obj,inputName,value,delay)
	AnimationControllerComponent_ApplyFeature(this,obj,inputName,value,delay)
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
	
	
	ObserveAfter("PanzerHUDGameController", "OnUninitialize", function(this)
	PanzerHUDGameController_OnUninitialize(this)
	
	
	end)
	
	ObserveAfter("PanzerHUDGameController", "OnVehicleStateChanged", function(this)
	
	PanzerHUDGameController_OnVehicleStateChanged(this)
	
	
	end)


	ObserveAfter("PanzerHUDGameController", "OnPlayerVehicleStateChange", function(this)
	
	PanzerHUDGameController_OnPlayerVehicleStateChange(this)
	
	end)
	
	ObserveAfter("PanzerHUDGameController", "EvaluateUIState", function(this)
	
	PanzerHUDGameController_EvaluateUIState(this)
	
	end)
	
	ObserveAfter("PanzerHUDGameController", "OnForwardVehicleQuestEnableUIEvent", function(this)
	
	PanzerHUDGameController_OnForwardVehicleQuestEnableUIEvent(this)
	
	end)
	
	ObserveAfter("PanzerHUDGameController", "OnPlayerAttach", function(this)
	
	 PanzerHUDGameController_OnPlayerAttach(this)
	
	end)
	
	ObserveAfter("PanzerHUDGameController", "OnPlayerDetach", function(this)
	
	PanzerHUDGameController_OnPlayerDetach(this)
	end)
	
	ObserveAfter("vehicleUIGameController", "OnVehiclePanzerBootupUIQuestEvent", function(this)
	
	vehicleUIGameController_OnVehiclePanzerBootupUIQuestEvent(this)
	
	end)

	
	
	ObserveAfter("ChatBoxGameController", "OnInitialize", function(this)
	
	ChatBoxGameController_OnInitialize(this)
	end)
	ObserveAfter("HudPhoneAvatarController", "OnInitialize", function(this)
	
	 HudPhoneAvatarController_OnInitialize(this)
	end)
	ObserveAfter("HudPhoneGameController", "OnInitialize", function(this)
	
	 HudPhoneGameController_OnInitialize(this)
	end)
	
	ObserveAfter("FlightController", "Activate", function(this)
	FlightController_Activate(this)
	
	end)
	
	ObserveAfter("FlightController", "Deactivate", function(this)
	FlightController_Deactivate(this)
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
	
	ObserveAfter("PhoneDialerGameController", "PopulateData", function(this)
		
		PhoneDialerGameController_PopulateData(this)
	end)
	
	ObserveAfter('VehiclesManagerListItemController', 'OnDataChanged', function(this,value)
		
		
		VehiclesManagerListItemController_OnDataChanged(this,value)
		
	end)
	
	ObserveAfter('VehiclesManagerListItemController', 'OnSelected', function(this,itemController,discreteNav)
		
		
		VehiclesManagerListItemController_OnSelected(this,itemController,discreteNav)
		
	end)
	
	ObserveAfter('IncomingCallGameController', 'OnInitialize', function(this)
		
	IncomingCallGameController_OnInitialize(this)
	end)
	
	ObserveAfter('IncomingCallGameController', 'GetIncomingContact', function(this)
		
		 IncomingCallGameController_GetIncomingContact(this)
	end)
	
	ObserveAfter('IncomingCallGameController', 'OnPhoneCall', function(this)
		
	IncomingCallGameController_OnPhoneCall(this)
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
	
	ObserveBefore("ShardsMenuGameController", "PopulateData", function(this)
			
		shardpopulate = true
			
	end)
		
	ObserveAfter("ShardsVirtualNestedListController", "SetData", function(this,data, keepToggledLevels, sortOnce)
			
		ShardsMenuGameController_PopulateData(this,data, keepToggledLevels, sortOnce)
	end)
	

	
	ObserveAfter('WorldMapMenuGameController', 'OnSelectedDistrictChanged', function(this,oldDistrict,newDistrict)
		
		
		
		WorldMapMenuGameController_OnSelectedDistrictChanged(this,oldDistrict,newDistrict)
			WorldMapMenuGameController_OnInitialize(this)
	end)
	
	ObserveAfter('WorldMapMenuGameController', 'OnZoomLevelChanged', function(this,oldLevel,newLevel)
		
		WorldMapMenuGameController_OnZoomLevelChanged(this,oldLevel,newLevel)
			WorldMapMenuGameController_OnInitialize(this)
	end)
	
	ObserveBefore('WorldMapMenuGameController', 'OnSetUserData', function(this,userData )
		WorldMapMenuGameController_OnSetUserData(this,userData)
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
	
	--region CyberScript Estates
	ObserveAfter('PhotoModeGridButton', 'ButtonStateChanged', function(this)
		 PhotoModeGridButton_ButtonStateChanged(this)
	
	end)
	ObserveAfter('BrowserController', 'OnInitialize', function(self)
	
	
	 BrowserController_OnInitialize(self)
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
	
	
	--endregion CyberScript Estates
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
	
	Observe('SubtitlesGameController','SetupLine', function(self) 
		 SubtitlesGameController_SetupLine(self) 
	end)
	
	Observe('BaseSubtitlesGameController','OnUninitialize', function(self) 
		 BaseSubtitlesGameController_OnUninitialize(self) 
	end)
	
	
	Observe('NPCPuppet', 'SendAfterDeathOrDefeatEvent', function(target)
		NPCPuppet_SendAfterDeathOrDefeatEvent(target)
	end)
	
	
	ObserveAfter('MessengerGameController','OnInitialize', function(this) 
		MessengerGameController_PopulateData(this) 
	end)
	
	
	ObserveAfter('MessengerGameController','PopulateData', function(this) 
		MessengerGameController_PopulateData(this) 
	end)
	
	
	
	Observe('MessengerGameController','OnContactActivated', function(self,evt) 
	MessengerGameController_OnContactActivated(self,evt) 
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
	
	ObserveAfter('PhoneMessagePopupGameController', 'SetupData', function(this)
		PhoneMessagePopupGameController_SetupData(this)
		
	end)
	
	Observe('MessengerDialogViewController', 'ShowThread', function(self,thread)
		MessengerDialogViewController_ShowThread(self,thread)
	end)
	
	Observe('MessengerDialogViewController', 'ShowDialog', function(self,contact)
		MessengerDialogViewController_ShowDialog(self,contact)
	end)
	
	Observe('MessengerDialogViewController', 'UpdateData', function(self,animateLastMessage)
		MessengerDialogViewController_UpdateData(self,animateLastMessage)
	end)
	
	Observe('MessangerItemRenderer', 'GetData', function(self)
		MessangerItemRenderer_GetData(self)
	end)
	
	Observe('MessangerReplyItemRenderer', 'OnDataChanged', function(self,value)
		MessangerReplyItemRenderer_OnDataChanged(self,value)
	end)
	
	Observe('MessangerItemRenderer', 'OnJournalEntryUpdated', function(self,entry,extraData)
		MessangerItemRenderer_OnJournalEntryUpdated(self,entry,extraData)
		end)
	
	
	Observe('MessangerReplyItemRenderer', 'OnJournalEntryUpdated', function(self,entry,extraData)
		MessangerReplyItemRenderer_OnJournalEntryUpdated(self,entry,extraData)
	end)
	
	
	
	
	Observe('MessengerDialogViewController', 'ActivateSelectedReplyOption', function(self)
		MessengerDialogViewController_ActivateSelectedReplyOption(self)
	end)
	Observe('MessengerDialogViewController', 'ActivateReply', function(self,target)
		MessengerDialogViewController_ActivateReply(self,target)
	end)
	Observe('MessengerDialogViewController', 'OnPlayerReplyActivated', function(self,index,target)
		MessengerDialogViewController_OnPlayerReplyActivated(self,index,target)
	end)
	
	
	
	
	
	
	
	
	
	Observe('MenuScenario_HubMenu', 'OnSelectMenuItem', function(_, menuItemData)
		MenuScenario_HubMenu_OnSelectMenuItem(_, menuItemData)
	end)
	
	ObserveAfter('PhoneDialerGameController','CallSelectedContact', function(this)
		PhoneDialerGameController_CallSelectedContact_Observer(this)
		
	end)
	
	ObserveAfter('PhoneSystem','OnTriggerCall', function(this, request)
		PhoneSystem_OnTriggerCall(this, request)
	end)
	
	ObserveAfter('PhoneSystem','OnUsePhone', function(this, request)
		 PhoneSystem_OnUsePhone(this, request)
		
	end)
	
	Observe('PhoneDialerGameController', 'Show', function(_,contactsList)
		 PhoneDialerGameController_Show(_,contactsList)
	end)
	
	Observe('PhoneDialerGameController', 'Hide', function()
		PhoneDialerGameController_Hide()
	end)
	
	Observe('VehicleRadioPopupGameController', 'VirtualListReady', function(self)
		VehicleRadioPopupGameController_VirtualListReady(self)
	end)
	
	Observe('VehicleSummonWidgetGameController', 'OnVehicleSummonStateChanged', function(state,value ) 
		
		VehicleSummonWidgetGameController_OnVehicleSummonStateChanged(state,value ) 
	end)
	
	Observe('PopupsManager', 'OnPlayerAttach', function(self)
		
		
	 PopupsManager_OnPlayerAttach(self)
	end)
	
	Observe('PopupsManager', 'OnPlayerDetach', function()
		 PopupsManager_OnPlayerDetach()
	end)
	
	Observe('RadioStationListItemController', 'OnDataChanged', function(self,value)
		RadioStationListItemController_OnDataChanged(self,value)
	end)
	
	ObserveAfter('VehicleRadioPopupGameController', 'Activate', function(self)
		VehicleRadioPopupGameController_Activate(self)
	end)
	
	Observe('VehicleRadioPopupGameController', 'OnScrollChanged', function(self)
		 VehicleRadioPopupGameController_OnScrollChanged(self)
		
	end)
	
	ObserveBefore('RadioStationListItemController', 'OnSelected', function(self,itemController,discreteNav)
		
		RadioStationListItemController_OnSelected(self,itemController,discreteNav)
	end)
	
	Observe('VehicleRadioPopupGameController', 'OnClose', function()
		 VehicleRadioPopupGameController_OnClose()
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
	
	
	Observe('CaptionImageIconsLogicController', 'OnInitialize',function(self,backgroundColor,iconColor)
		CaptionImageIconsLogicController_OnInitialize(self,backgroundColor,iconColor)
		
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
	
	Observe('PopupsManager', 'ShowPhoneMessage', function(self)
		
		
		 PopupsManager_ShowPhoneMessage(self)
		
		
	end)
	
	Observe('PopupsManager', 'OnMessagePopupUseCloseRequest', function(self)
		PopupsManager_OnMessagePopupUseCloseRequest(self)
		
	end)
	
	Observe('QuestCodexLinkController', 'Setup', function(self)
		
		QuestCodexLinkController_Setup(self)
		
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
	
	
	ObserveAfter("DeviceMappinsContainer", "Initialize", function(this)
		
		 DeviceMappinsContainer_EvaluatePositions(this)

	end)
	
	 ObserveAfter("SmartWindowInkGameController", "InitializeMainLayout", function(this)
		
		SmartWindowInkGameController_InitializeMainLayout(this)
		
	 end)
	
	Override("PreventionSpawnSystem", "SpawnCallback", function(this,spawnedObject,wrappedMethod)
		PreventionSpawnSystem_SpawnCallback(this,spawnedObject,wrappedMethod)
	end)
	
	Override("QuestMappinLinkController", "Setup", function(this,mappinEntry,jumpTo,wrappedMethod)

		QuestMappinLinkController_Setup(this,mappinEntry,jumpTo,wrappedMethod)
		
	end)
	
	Override("QuestCodexLinkController", "SetupCodexLink", function(this,codexEntry,wrappedMethod)

		QuestCodexLinkController_SetupCodexLink(this,codexEntry,wrappedMethod)
	end)
	
	
	
	
	Override("CodexPopupGameController", "SetupData", function(this,wrappedMethod)
		CodexPopupGameController_SetupData(this,wrappedMethod)
		
	end)
	
	
	Override("CodexEntryViewController", "ShowEntry", function(this,data,wrappedMethod)
		
		  
		CodexEntryViewController_ShowEntry(this,data,wrappedMethod)
		
	end)
	
	
	Override('PlayerPuppet', 'OnLookAtObjectChangedEvent', function(this)
		PlayerPuppet_OnLookAtObjectChangedEvent(this)
	end)
	
	Override('NcartTimetableControllerPS', 'UpdateCurrentTimeToDepart', function(self,wrappedMethod)
		 NcartTimetableControllerPS_UpdateCurrentTimeToDepart(self,wrappedMethod)
	end)
	
	Override('PhoneDialerGameController','CallSelectedContact',function(this, wrappedMethod)
		
		PhoneDialerGameController_CallSelectedContact(this, wrappedMethod)
	end
	)
	
	Override('DoubleJumpDecisions','EnterCondition',function(this,stateContext,scriptInterface, wrappedMethod)
		
		local value = DoubleJumpDecisions_EnterCondition(this,stateContext,scriptInterface, wrappedMethod)
		return value
	end)
	
	Override('LocomotionAirEvents','OnUpdate',function(this,timeDelta, stateContext, scriptInterface, wrappedMethod)
		
		 LocomotionAirEvents_OnUpdate(this,timeDelta, stateContext, scriptInterface, wrappedMethod)
	end)
	
	
	Override('WorldMapMenuGameController','OnGangListItemSpawned', function(self,gangWidget,userData) 
		WorldMapMenuGameController_OnGangListItemSpawned(self,gangWidget,userData) 
			WorldMapMenuGameController_OnInitialize(self)
	end)
	
	Override('WorldMapMenuGameController','OnSelectedDistrictChanged', function(self,oldDistrict,newDistrict) 
		 WorldMapMenuGameController_OnSelectedDistrictChanged(self,oldDistrict,newDistrict) 
		 	WorldMapMenuGameController_OnInitialize(self)
	end)
	
	Override('WorldMapGangItemController','SetData', function(self,affiliationRecord) 
		
		WorldMapGangItemController_SetData(self,affiliationRecord) 
	end)
	
	
	
	Override('ComputerMainLayoutWidgetController', 'InitializeMenuButtons', function(this, gameController, widgetsData,wrappedMethod)
		ComputerMainLayoutWidgetController_InitializeMenuButtons(this, gameController, widgetsData,wrappedMethod)
	end)
	
	Override('ComputerMainLayoutWidgetController', 'ShowInternet', function(this, startingPage,wrappedMethod)
	
		ComputerMainLayoutWidgetController_ShowInternet(this, startingPage,wrappedMethod)
	end)
	
	
	Override('VehiclesManagerDataHelper', 'GetVehicles', function(this,player, wrappedMethod)
		--print("test helper")
		VehiclesManagerDataHelper_GetVehicles(this,player, wrappedMethod)
	end)
	
	Override('VehiclesManagerPopupGameController', 'Activate', function(this, wrappedMethod)
	
		VehiclesManagerPopupGameController_Activate(this, wrappedMethod)
	end)
	
	Override('VehiclesManagerPopupGameController', 'SetupData', function(this, wrappedMethod)
	
		VehiclesManagerPopupGameController_SetupData(this, wrappedMethod)
	end)
	
	
	Override('VehiclesManagerListItemController', 'OnDataChanged', function(this,value, wrappedMethod)
	
		VehiclesManagerListItemController_OnDataChanged(this,value, wrappedMethod)
	end)
	
	--Vendors
	
	-- Override("VendorHubMenuGameController", "OnSetUserData", function(this,userData,wrappedMethod)
		-- if(objLook ~= nil) then
			-- local entid = objLook:GetEntityID()
			-- local entity = getEntityFromManagerById(entid)
			-- if(entity.id ~= nil) and VendorsStockManager[entity.tag] ~= nil then
			  -- local vendorData = userData.data
			  -- this.vendorUserData = VendorUserData.new()
			  -- this.vendorUserData.vendorData = vendorPanelData
			  -- this.player = this:GetPlayerControlledObject()
			  -- this.PDS = GameInstance.GetScriptableSystemsContainer():Get("PlayerDevelopmentSystem")
			  -- this.VendorDataManager = VendorDataManager.new()
			  -- logme(1,"sell01")
			  -- --this.VendorDataManager:Initialize(this:GetPlayerControlledObject(), objLook:GetEntityID())
			-- this.VendorDataManager.TimeToCompletePurchase = 0
			-- this.VendorDataManager.VendorObject = objLook
			-- this.VendorDataManager.VendorID =  getVendorId()
			-- MarketSystem.OnVendorMenuOpen(this.VendorDataManager.VendorObject)
			
			
			  -- requestStatsEvent = RequestStatsBB.new()
			    -- logme(1,"sell02")
			  -- requestStatsEvent:Set(this.player)
			    -- logme(1,"sell03")
			  -- this.PDS:QueueRequest(requestStatsEvent)
			    -- logme(1,"sell04")
			  -- this:Init()
			    -- logme(1,"sell05")
			-- --print("sell01")
			-- else
					
					
					-- wrappedMethod(userData)
			-- end
			-- else
					
					
					-- wrappedMethod(userData)
		-- end
	-- end)

	
	-- Override("RipperdocIdPanel", "SetName", function(this,vendorName,wrappedMethod)
		-- RipperdocIdPanel_SetName(this,vendorName,wrappedMethod)
	-- end)
	
	-- Override("VendorHubMenuGameController", "SetupTopBar", function(this,wrappedMethod)
		-- VendorHubMenuGameController_SetupTopBar(this,wrappedMethod)
	-- end)
	
	-- Override("FullscreenVendorGameController", "PopulateVendorInventory", function(this,wrappedMethod)
		
		-- FullscreenVendorGameController_PopulateVendorInventory(this,wrappedMethod)
	-- end)
	
	
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
	
	
	Override('QuickhacksListGameController', 'OnAction', function(this,action,consumer,wrappedMethod)
		QuickhacksListGameController_OnAction(this,action,consumer,wrappedMethod)
		
	end)
	
	Override('QuickhacksListGameController', 'ApplyQuickHack', function(this,wrappedMethod)
		QuickhacksListGameController_ApplyQuickHack(this,wrappedMethod)
		
	end)
	
	Override('QuickhacksListGameController', 'OnQuickhackStarted', function(this,value,wrappedMethod)
		QuickhacksListGameController_OnQuickhackStarted(this,value,wrappedMethod)
		
	end)
	
	Override('QuickhacksListGameController', 'SetVisibility', function(this,value,wrappedMethod)
		QuickhacksListGameController_SetVisibility(this,value,wrappedMethod)
		
	end)
	
	Override('QuickhacksListGameController', 'OnMemoryPercentUpdate', function(this,value, wrappedMethod)
		QuickhacksListItemController_OnMemoryPercentUpdate(this,value, wrappedMethod)
	end)
	
	Override('QuickhacksListGameController', 'UpdateQuickhacksMemoryBarSize', function(this,size, wrappedMethod)
		QuickhacksListItemController_UpdateQuickhacksMemoryBarSize(this,size, wrappedMethod)
	end)
	
	---Scanner
	
	Override('QuickhacksListItemController', 'UpdateState', function(this, wrappedMethod)
		QuickhacksListItemController_UpdateState(this, wrappedMethod)
	end)
	
	Override('QuickhacksListItemController', 'PlayChoiceAcceptedAnimation', function(this, wrappedMethod)
		QuickhacksListItemController_PlayChoiceAcceptedAnimation(this, wrappedMethod)
	end)
	
	
	
	
	-- Override('BrowserController', 'TryGetWebsiteData', function(this, address, wrappedMethod)
	
		-- BrowserController_TryGetWebsiteData(thos, address, wrappedMethod)
		
	-- end)
	Override('BrowserController', 'LoadWebPage', function(self,address,wrappedMethod)
	 BrowserController_LoadWebPage(self,address,wrappedMethod)
	
	end)
	Override('WorldMapMenuGameController', 'ShowGangsInfo', function(self,district)
		
		WorldMapMenuGameController_ShowGangsInfo(self,district)
			WorldMapMenuGameController_OnInitialize(self)
	end)
	
	Override('ComputerInkGameController', 'ShowMenuByName', function(this, elementName,wrappedMethod)
		ComputerInkGameController_ShowMenuByName(this, elementName, wrappedMethod)
		
	end)
	
end
---Observer and Overrider---
