logme(1,"CyberScript: quest module loaded")
cyberscript.module = cyberscript.module +1


--Main function
function QuestThreadManager()
	--logme(2,getScoreKey("joytoy_quest_radiant","Score"))
	if currentQuest ~= nil and GameUI.IsMenu() == false then
		
		
		possibleQuest = {}
		-- logme(2,"Score quest init")
		-- logme(2,getScoreKey(currentQuest.tag,"Score"))
		
		--quest init
		if(getScoreKey(currentQuest.tag,"Score") == 0)then
			setScore(currentQuest.tag,"Score",1)
			--logme(2,"Score quest init")
		end
		--quest trigger
		if(getScoreKey(currentQuest.tag,"Score") == 1)then
			
			if(canDoTriggerAction) then
				if(DoedTriggerAction == false) then
					DoedTriggerAction = true
					doTriggerAction(currentQuest)
					
					canDoTriggerAction = false
					
				end
				
				
			end
			
			
			
		end
		
		
		if(currentQuest.alreadyStart == true and currentQuest.lastIndex ~= nil) then
			
			runActionList(currentQuest.objectives[currentQuest.lastIndex].resume_action,currentQuest.objectives[currentQuest.lastIndex].tag.."_resume","quest",true,"see_engine")
			
		end
		
		--quest started
		
		if(getScoreKey(currentQuest.tag,"Score") == 2)then
			
			completedobjective = 0
			totalobjectivenotoptionnal = 0
			
			for i=1, #currentQuest.objectives do
				
				
				local objectif =  currentQuest.objectives[i]
				
				
				
				
				if(QuestManager.GetObjectiveState(objectif.tag).isActive == true) then
					
					local result = false
					result = checkTriggerRequirement(objectif.requirement,objectif.trigger)
					-- if(objectif.tag == "test_objective_new_4") then
					-- logme(1,objectif.tag.." active "..tostring(QuestManager.GetObjectiveState(objectif.tag).isActive))
					
				
					-- logme(1,objectif.tag.." trigger "..tostring(dump(objectif.trigger)))
					
					--logme(1,objectif.tag.." result "..tostring(result))
					-- end
					
					if(result == true and workerTable[objectif.tag.."_action"] == nil) then
					--	logme(1,objectif.tag.." ACtion")
						
						
						local action ={}
						action.name = "quest_notification"
						action.title =  currentQuest.title
						action.desc = currentQuest.title
						action.quest = currentQuest.tag
						
						if(objectif.extra ~= nil and objectif.extra.update ~= nil) then
							action.desc = objectif.extra.update
						end
						action.duration = 4
						action.type = "update"
					
						
						
						if(objectif.unlock ~= nil and #objectif.unlock > 0) then
							
							action.objective = objectif.unlock[1]
							
							for i,v in ipairs(objectif.unlock) do
							if(QuestManager.GetObjectiveState(v).state ~= gameJournalEntryState.Undefined) then
								QuestManager.MarkObjectiveAsActive(v)
								QuestManager.TrackObjective(v,true)
							end
								
								
								
							end
							
							
							
							local newobjective = QuestManager.GetObjective(objectif.unlock[1])
							if newobjective.extra ~= nil then
								
								
								
								
								
								if newobjective.extra.mappin ~= nil then
									
									local mappin = getMappinByTag(newobjective.extra.mappin)
									
									
									
									
									
									
									if(mappin and mappin.controller ~= nil)then
										
										local startHub = StartHubMenuEvent.new()
										
										local userData = MapMenuUserData.new()
										userData.moveTo = Vector3.new(mappin.position.x, mappin.position.y, mappin.position.z)					
										startHub:SetStartMenu("world_map",nil,userData)
										Game.GetUISystem():QueueEvent(startHub)
										
										Cron.After(0.1, function()
											
											GameController["WorldMapMenuGameController"]:TrackMappin(mappin.controller)
											local closeHub = ForceCloseHubMenuEvent.new()
											Game.GetUISystem():QueueEvent(closeHub)							
											
										end)
									end
									
									
									
									
								end
								
							end
							
						end
						
						local playlist = deepcopy(objectif.action,nil)
						
						table.insert(playlist,action)
						
						runActionList(playlist,objectif.tag.."_action","quest",true,"see_engine")
						
						
						QuestManager.MarkObjectiveAsComplete(objectif.tag)
						
							
						
						
					end
					
					else
					
				end
				
				if(QuestManager.GetObjectiveState(objectif.tag).state == gameJournalEntryState.Succeeded and objectif.isoptionnal == false) then
					completedobjective = completedobjective +1
				--	print("completedobjective "..objectif.tag)
				end
				
				if(QuestManager.GetObjectiveState(objectif.tag).state ~= gameJournalEntryState.Undefined and objectif.isoptionnal == false) then
					totalobjectivenotoptionnal = totalobjectivenotoptionnal +1
					--print("totalobjectivenotoptionnal "..objectif.tag)
				end
				
				
				
			end
		
			if(completedobjective >= totalobjectivenotoptionnal) then
			--	print("test3 ")
				canDoEndAction = true
				
			end
			
			
				if(
				(currentQuest.failure_condition_requirement ~= nil and currentQuest.failure_condition ~= nil) and
				(#currentQuest.failure_condition_requirement ~= 0)
			) then
				
				canDoFailAction = HaveFailCondition(currentQuest)
				
				
			end
			
			
			if(canDoFailAction == true) then
				
				if(workerTable[currentQuest.tag.."_fail"] == nil) then
					
					local action = {}
					
					action.name = "quest_notification"
					action.title =  currentQuest.title
					action.desc = currentQuest.content
					if(currentQuest.extra ~= nil and currentQuest.extra.fail ~= nil) then
						action.desc = currentQuest.extra.fail
					end
					action.duration = 4
					action.type = "fail"
					
					
					if(#currentQuest.failure_action > 0)then
					
						
						local playlist = deepcopy(currentQuest.failure_action,nil)
						table.insert(playlist,action)
						runActionList(playlist,currentQuest.tag.."_fail","quest",false,"see_engine",true)
						else
						executeAction(action,"fail_mission","",0,"see","")
					end
					
				
					local resettag = currentQuest.tag
					closeQuest(currentQuest)
						print("dsqqzsqs")
					QuestManager.resetQuestfromJson(resettag)
					setScore(resettag,"Score",-1)
					
					
					logme(1,"Quest Fail ACtion")
					currentQuest = nil
					--	closeQuest(currentQuest)
				end
				
				
				
			end
			
			
			if(canDoResetAction) then
				
				if(DoedResetAction == false) then
					resetQuest()
					logme(2,"Quest Reset")
				end
				
				
				
			end
			
			
			if(canDoEndAction) then
				print("test5 ")
				if(DoedEndAction == false and canwaitend == false) then
					
					DoedEndAction = true
					
				end
				
				if(DoedEndAction == true) then
					DoedEndAction = false
					
					local action = {}
					action.name = "quest_notification"
					action.title =  currentQuest.title
					action.desc = currentQuest.title
					if(currentQuest.extra ~= nil and currentQuest.extra.success ~= nil) then
						action.desc = currentQuest.extra.success
					end
					action.duration = 4
					action.type = "success"
					executeAction(action,"success_mission","",0,"see","")
					logme(2,"mark5")
					if(currentQuest.isNCPD ~= nil and currentQuest.isNCPD == true ) then
						local action = {}
						action.name = "npcd_finish_notification"
						action.levelXPAwarded = math.random(1,50)
						action.streetCredXPAwarded = math.random(1,50)
						
						table.insert(currentQuest.end_action,action)
					end
					
					doEndAction(currentQuest)
					
					
					
					
					
				end
				
				if(workerTable[currentQuest.tag.."_end"] == nil and canwaitend == true) then
					
					
					closeQuest(currentQuest)
					canDoEndAction = false
					logme(2,"Quest End ACtion")
					
				end
			end
			
			
		
			
			
			-- if(completedobjective == totalobjectivenotoptionnal and QuestManager.GetQuestState(currentQuest.tag).isComplete == true)then
			
			
			-- closeQuest(currentQuest)
			
			
			-- end
		end
		
		
	end
end


--Quest States
function startQuest(quest)
	
	-- logme(10,tostring(QuestManager.GetQuestState(quest.tag).isActive))
	-- logme(10,"is null "..tostring(getScoreKey(quest.tag,"Score") == nil))
	
	
	if(QuestManager.GetQuestState(quest.tag).isActive == true) then
		Game.untrack()
		
		currentSave.arrayPlayerData.CurrentQuest = quest.tag
		
		phonedFixer = false
		haveMission = true
		draw = true
		npcSpawned = false
		npcStarSpawn = false
		canDoTriggerAction = true
		currentQuest = quest
		
		currentQuest.alreadyStart = false
		
		
		for i=1,#quest.objectives do
			local objectif = quest.objectives[i]
			if(QuestManager.GetObjectiveState(objectif.tag).isComplete == true) then
				
				currentQuest.alreadyStart = true
				currentQuest.lastIndex = i
				logme(2,"alreadustart")
				
				
			end
			
		end
		
		if(currentQuest.alreadyStart == true) then
			
			QuestManager.MarkObjectiveAsActive(quest.objectives[currentQuest.lastIndex+1])
			
		end
		
		
		
		
		
		local action = {}
		action.name = "quest_notification"
		action.title =  currentQuest.title
		
		action.desc = currentQuest.content..getLang("mission_start_look_map")
		if(currentQuest.extra ~= nil and currentQuest.extra.new ~= nil) then
			action.desc = currentQuest.extra.new
		end
		action.duration = 4
		action.type = "new"
		executeAction(action,"start_mission","",0,"see","")
		
		setScore(currentQuest.tag,"Score",0)
		
	end
	
	
end

function TriggerQuest(unlockTagQuest)
	------logme(2,unlockTagQuest)
	if(unlockTagQuest ~= nil and unlockTagQuest ~= "") then
		
		isAlreadyDo = false
		
		local score = getScoreKey(unlockTagQuest,"Score")
		
		if(score ~= nil and score == 3) then
			isAlreadyDo = true
			
		end
		
		
		
		if isAlreadyDo == false then
			
			
			local quest = cyberscript.cache["mission"][unlockTagQuest].data
			
			startQuest(quest)
			
			--Game.GetPlayer():SetWarningMessage(getLang("quest_trigger") .. quest.Title)
			------logme(2,"Forced Contract" .. quest.Title)
			
			
		end
		
	end
	
	
	
end

function restoreQuestProgression(CurrentQuestStatut)
	logme(2,"resume progression")
	if(CurrentQuestStatut ~= nil and CurrentQuestStatut ~= "nil")then
		
		if(CurrentQuestStatut == 0)then
			canDoTriggerAction = true
			currentQuestStarted = false
			currentQuestFinished = false
			doTriggerAction(currentQuest)
		end
		
		if(CurrentQuestStatut == 1)then
			canDoTriggerAction = false
			currentQuestStarted = true
			currentQuestFinished = true
			doStartAction(currentQuest)
		end
		else
		canDoTriggerAction = true
		currentQuestStarted = false
		currentQuestFinished = false
		
	end
	
end

function untrackQuest()
	if currentQuest ~= nil then
		resetQuest()
	end
end

function resetQuest()
	
	workerTable[currentQuest.tag.."_start"] = nil
	workerTableKey[currentQuest.tag.."_start"] = nil
	
	workerTable[currentQuest.tag.."_trigger"] = nil
	workerTableKey[currentQuest.tag.."_trigger"] = nil
	
	workerTable[currentQuest.tag.."_end"] = nil
	workerTableKey[currentQuest.tag.."_end"] = nil
	
	workerTable[currentQuest.tag.."_fail"] = nil
	workerTableKey[currentQuest.tag.."_fail"] = nil
	
	workerTable[currentQuest.tag.."_reset"] = nil
	workerTableKey[currentQuest.tag.."_reset"] = nil
	
	
	if(currentQuest.reset_action ~= nil) then
		
		runActionList(currentQuest.reset_action,currentQuest.tag.."_reset","quest",false,"see_engine")
		
		
	end
	
	QuestManager.MarkQuestAsInactive(currentQuest.tag)
	QuestManager.MarkAllObjectiveOfQuestAs(currentQuest.tag,1)
	QuestManager.MarkQuestAsUnVisited(currentQuest.tag)
	setScore(currentQuest.tag,"Score",0)
	
	
	QuestManager.resetQuestfromJson(currentQuest.tag)
	
	
	currentQuest = nil
	currentQuestStarted = false
	currentQuestFinished = false
	currentQuestFailed = false
	enemySpawned = false
	npcSpawned = false
	npcStarSpawn = false
	haveMission = false
	
	currentSave.arrayPlayerData.CurrentQuest = nil
	currentSave.arrayPlayerData.CurrentQuestStatut = nil
	
	
	
	canDoTriggerAction = false
	canDoStartAction = false
	canDoEndAction = false
	canDoFailAction = false
	
	DoedTriggerAction = false
	DoedStartAction = false
	DoedEndAction = false
	DoedFailAction = false
	TrackObjective()
	logme(2,"Interrupt quest")
	
end

function closeQuest(quest)
	
	workerTable[quest.tag.."_start"] = nil
	workerTableKey[quest.tag.."_start"] = nil
	
	
	
	
	QuestManager.UntrackObjective()
	
	QuestManager.MarkQuestASucceeded(quest.tag)
	
	for i=1, #quest.objectives do
		
		QuestManager.MarkObjectiveAsInactive(quest.objectives[i].tag)
		
		workerTableKey[quest.objectives[i].tag.."_action"] = nil
		workerTable[quest.objectives[i].tag.."_action"] = nil
		
	end
	setScore(quest.tag,"Score",3)
	
	if(quest.recurrent ~= nil and quest.recurrent == true) then
		
		QuestManager.resetQuestfromJson(quest.tag)
		setScore(quest.tag,"Score",-1)
		logme(2,"resetjson")
	end
	
	currentObjectiveId = 0
	inkCompoundRef.RemoveAllChildren(GameController["QuestTrackerGameController"].ObjectiveContainer) 
	currentQuest = nil
	currentQuestStarted = false
	currentQuestFinished = false
	currentQuestFailed = false
	enemySpawned = false
	npcSpawned = false
	npcStarSpawn = false
	haveMission = false
	currentSave.arrayPlayerData.CurrentQuest = nil
	currentSave.arrayPlayerData.CurrentQuestStatut = nil
	currentSave.arrayPlayerData.CurrentQuestState = nil
	
	logme(2,"closed quest")
	canDoTriggerAction = false
	canDoStartAction = false
	canDoEndAction = false
	canDoFailAction = false
	canwaitend = false
	DoedTriggerAction = false
	DoedStartAction = false
	DoedEndAction = false
	DoedFailAction = false
	
	
end


--Trigger Quest and action Quest

function HaveTriggerCondition(quest)
	local result = false
	--testTriggerRequirement(quest.trigger_condition_requirement,quest.trigger_condition)
	result = checkTriggerRequirement(quest.trigger_condition_requirement,quest.trigger_condition)
	----logme(2,askTriggerRequirement(quest.trigger_condition_requirement,quest.trigger_condition))
	if(result)then
		----print(quest.title.." is okk")
	end
	return result
end

function doTriggerAction(quest)
	if(#quest.trigger_action >0)then
		runActionList(quest.trigger_action,quest.tag.."_trigger","quest",false,"see_engine")
	end
	setScore(currentQuest.tag,"Score",2)
end



function HaveStartCondition(quest)
	local result = false
	
	--testTriggerRequirement(quest.start_condition_requirement,quest.start_condition)
	
	result = checkTriggerRequirement(quest.start_condition_requirement,quest.start_condition)
	
	
	
	
	
	return result
end

function doStartAction(quest)
	
	
	runActionList(quest.start_action,quest.tag.."_start","quest",true,"see_engine")
	
	setScore(currentQuest.tag,"Score",2)
end



function HaveFailCondition(quest)
	--logme(2,"toto")
	local result = false
	--testTriggerRequirement(quest.failure_condition_requirement,quest.failure_condition,1)
	result = checkTriggerRequirement(quest.failure_condition_requirement,quest.failure_condition)
	
	return result
end

function HaveEndCondition(quest)
	local result = false
	result = checkTriggerRequirement(quest.end_condition_requirement,quest.end_condition)
	return result
end



function doEndAction(quest)
	
	if(#quest.end_action >0)then
		runActionList(quest.end_action,quest.tag.."_end","quest",false,"see_engine")
	end
	canwaitend = true
	
end


function TrackObjective()
	
	if QuestManager.IsTrackingObjective() then
		
	
		local trackedQuestId = QuestManager.GetTrackedQuestId()
		local trackedQuestDef = QuestManager.GetQuest(trackedQuestId)
		local trackedObjectiveId = QuestManager.GetTrackedObjectiveId()
		
		GameController["QuestTrackerGameController"].root:SetVisible(true)
		
		inkTextRef.SetText(GameController["QuestTrackerGameController"].QuestTitle, trackedQuestDef.title)
		inkCompoundRef.RemoveAllChildren(GameController["QuestTrackerGameController"].ObjectiveContainer)
		
		for _, objectiveDef in ipairs(trackedQuestDef.objectives) do
			local objectiveState = QuestManager.GetObjectiveState(objectiveDef.id)
			
			
			
			local objectiveEntry = QuestManager.GetObjectiveEntry(objectiveDef.id)
			
				local isquest = (trackedQuestDef.metadata.questtype == 0 or trackedQuestDef.metadata.questtype == 1  or trackedQuestDef.metadata.questtype == 2)
		
			if objectiveState.state == gameJournalEntryState.Succeeded and (objectiveState.hidden == nil or objectiveState.hidden == false) then
				local objectiveWidget = GameController["QuestTrackerGameController"]:SpawnFromLocal(inkWidgetRef.Get(GameController["QuestTrackerGameController"].ObjectiveContainer), "Objective")
				
				---@type QuestTrackerObjectiveLogicController
				local objectiveController = objectiveWidget:GetController()
				objectiveController:SetData(objectiveDef.title, objectiveDef.id == trackedObjectiveId, objectiveDef.isOptional, 0, 0, objectiveEntry, isquest )
				objectiveController:SetObjectiveState("succeeded");
				inkWidgetRef.SetVisible(objectiveController.trackingIcon, true)
				objectiveController.AnimProxy = objectiveController:PlayLibraryAnimation("ObjectiveSucceeded")
				objectiveController.AnimProxy:RegisterToCallback(inkanimEventType.OnFinish, objectiveController, "OnAnimEnd")
				QuestManager.MarkObjectiveAsCompleteAndHidden(objectiveDef.id)
			end
			
			if objectiveState.state == gameJournalEntryState.Failed then
				local objectiveWidget = GameController["QuestTrackerGameController"]:SpawnFromLocal(inkWidgetRef.Get(GameController["QuestTrackerGameController"].ObjectiveContainer), "Objective")
				
				---@type QuestTrackerObjectiveLogicController
				local objectiveController = objectiveWidget:GetController()
				objectiveController:SetData(objectiveDef.title, objectiveDef.id == trackedObjectiveId, objectiveDef.isOptional, 0, 0, objectiveEntry, isquest )
				objectiveController:SetObjectiveState("failed");
				inkWidgetRef.SetVisible(objectiveController.trackingIcon, true)
				objectiveController.AnimProxy = objectiveController:PlayLibraryAnimation("ObjectiveFailed")
				objectiveController.AnimProxy:RegisterToCallback(inkanimEventType.OnFinish, objectiveController, "OnAnimEnd")
			end
			
			if objectiveState.state == gameJournalEntryState.Active then
				local objectiveWidget = GameController["QuestTrackerGameController"]:SpawnFromLocal(inkWidgetRef.Get(GameController["QuestTrackerGameController"].ObjectiveContainer), "Objective")
				
				---@type QuestTrackerObjectiveLogicController
				local objectiveController = objectiveWidget:GetController()
				objectiveController:SetData(objectiveDef.title, objectiveDef.id == trackedObjectiveId, objectiveDef.isOptional, 0, 0, objectiveEntry, isquest )
				
			end
			
			local quest = getQuestByTag(trackedQuestId)
			
			
			
			
			if(quest ~= nil and (getScoreKey(quest.tag,"Score") == nil or getScoreKey(quest.tag,"Score") <= 3) and currentQuest == nil ) then
				
				--untrackQuest()
				
				startQuest(quest)
				
			end
			
		end
		
		currentObjectiveId = trackedObjectiveId
		
		
		
		elseif currentObjectiveId ~= 0 then
		
		GameController["QuestTrackerGameController"].root:SetVisible(false)
		inkCompoundRef.RemoveAllChildren(GameController["QuestTrackerGameController"].ObjectiveContainer)
		currentObjectiveId = 0
		
		else
		GameController["QuestTrackerGameController"]:UpdateTrackerData()
		
	end
	
end


function doFailAction(quest)
	if(#quest.failure_action >0)then
		runActionList(quest.failure_action,quest.tag.."_fail","quest",false,"see_engine",true)
	end
	
	setScore(currentQuest.tag,"Score",2)
	
end

