debugPrint(3,"CyberScript: Editor module loaded")


function resetEditorObject()
	
	openEditor = false
	openEditTrigger = false
	openNewTrigger = false
	
	openTriggerItem = false
	
	openNewAction = false
	openEditAction = false
	
	
	
	openNewRoom = false
	openEditRoom = false
	
	loadQuest = ""
	loadInteract = ""
	loadPlace = ""
	loadDialog = ""
	loadEvent = ""
	loadFunction = ""
	loadCustomNPC = ""
	loadFixer = ""
	loadFaction = ""
	loadRadio = ""
	loadNode = ""
	loadCircuit = ""
	loadPath = ""
	loadLang = ""
	LoadInterface = ""
	loadHelp =""
	loadShard = ""
	loadPhoneDialog = ""
	
	
	newRequirementItem = ""
	selectedTrigger2 = ""
	currentSelectTrigger = {}
	currentSelectAction = {}
	currentSelectSubAction = {}
	currentSelectRoom = {}
	currentSelectOptions = {}
	currentSelectObjective = {}
	currentSelectConversation = {}
	currentSelectMessage = {}
	currentSelectChoice = {}
	
	currentEditorTrigger = nil
	currentEditorAction = nil
	currentEditorOptions = nil
	currentHouseCenter = nil
	
	
	questTrigger = true
	questStart = true
	questEnd = true
	questFail = true
	currentEditorSubTrigger = {}
	
	genericItem = {}
	genericItem.name = ""
	genericItem.file = ""
	
	dicKey = ""
	dicValue = ""
	
	selectedTrigger = "auto"
	selectedTrigger2 = "auto"
	npcchara = "Judy"
	defaultQuestType = "Contract"
	defaultEnumDistrict = "Watson"
	defaultfaction = "Mox"
	defaultJournalEntryState = "Active"
	defaultDistrict = "Watson"
	waydialog = "phone"
	selectedAction = "notify"
	
	selectedTriggerTable = {}
	newtrigger = {}
	
	currentParentItem = {}
	
	activeEditedQuest = {} -- 0
	activeEditedInteract = {} --1 
	activeEditedDialog = {}--2
	activeEditedFixer = {} --3
	activeEditedPlace = {} --4
	activeEditedFunction = {} --5
	activeEditedFaction = {} --5
	activeEditedRadio = {} --5
	activeEditedNode = {} --5
	activeEditedCircuit = {} --5
	activeEditedPath = {} --5
	activeEditedEvent = {} --5
	activeEditedLang = {} --5
	activeEditHelp = {} --5
	activeEditedInterfaces = {}
	activeEditedCustomNPC = {} --5
	activeEditedShard = {} --5
	activeEditedPhoneDialog = {} --5
	
	
	myDatapack = {}
	myDatapack.name = ""
	myDatapack.desc = ""
	myDatapack.author = ""
	myDatapack.file = ""
	myDatapack.tag = ""
	myDatapack.version = 1
	myDatapack.isessential = false
	
	myDatapackQuest = {}
	myDatapackInteract = {}
	myDatapackDialog = {}
	myDatapackFixer = {}
	myDatapackPlace = {}
	myDatapackFunction = {}
	myDatapackFaction = {}
	myDatapackRadio = {}
	myDatapackNode = {}
	myDatapackCircuit = {}
	myDatapackPath = {}
	myDatapackLanguage = {}
	myDatapackEvent = {}
	myDatapackHousing = {}
	myDatapackHelp = {}
	myDatapackCustomNPC = {}
	myDatapackShard = {}
	myDatapackPhoneDialog = {}
	
end

function initEditor()
	
	--debugPrint(2,"toto")
	
	for i=1,#arrayPnjDb do
		
		table.insert(arrayListCharacter,arrayPnjDb[i].Names)
		
	end
	
	
	
	
	
	for i=1,#arrayPnjDb do
		
		table.insert(arrayPNJ,arrayPnjDb[i].TweakIDs)
		
	end
	
	for i=1,#arrayVehicles do
		
		table.insert(arrayPNJ,arrayVehicles[i])
		
	end
	
end


--Main Windows

function editorWindows()
	
	
	
	

	
	ImGui.SetNextWindowPos(300, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(1200, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("editor_editor")) then
		
		ImGui.Spacing()
		if ImGui.BeginTabBar("EditorTabs", ImGuiTabBarFlags.NoTooltip) then
			
			MainTabs()
			local status, retval =pcall(function()
				if ImGui.BeginTabItem(getLang("editor_Story")) then
					
					if ImGui.BeginTabBar("QuestsTabsTabsBar", ImGuiTabBarFlags.NoTooltip) then
						
						
						QuestTabs()
						
						DialogTabs()
						
						PhoneDialogTabs()
						
						CustomNPCTabs()
						
						SceneTabs()
						
						ImGui.EndTabBar()
					end
					
					ImGui.EndTabItem()
					
					
				end
				
				
				
				if ImGui.BeginTabItem(getLang("editor_World")) then
					
					if ImGui.BeginTabBar("RelationsTabsTabsBar", ImGuiTabBarFlags.NoTooltip) then
						
						
						InteractTabs()
						
						
						
						FixerTabs()
						
						FactionTabs()
						
						PlaceTabs()
						
						if(currentHouse ~= nil) then
							ItemTabs()
						end
						
						EventTabs()
						
						FunctionTabs()
						
						
						ImGui.EndTabBar()
					end
					
					ImGui.EndTabItem()
					
				end
				
				NodeSystemTabs()
				
				
				
				if ImGui.BeginTabItem(getLang("editor_UI")) then
					
					if ImGui.BeginTabBar("UITabsTabsBar", ImGuiTabBarFlags.NoTooltip) then
						
						InterfacesTabs()
						
						RadioTabs()
						
						LangTabs()
						
						HelpTabs()
						
						
						
						ShardTab()
						
						
						ImGui.EndTabBar()
					end
					
					ImGui.EndTabItem()
				end
				
				
				
				DatapackBuilder()
				
				VariableEditor()
				debugTab()
				SettingTab()
			end)
			if status == false then
				
				
				debugPrint(10,getLang("editor_error") .. retval)
				spdlog.error(getLang("editor_error") .. retval)
				Game.GetPlayer():SetWarningMessage(getLang("editor_error_msg"))
				
				
				
			end
			
			ImGui.EndTabBar()
		end
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
	
	
end


function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
			else return a[i], t[a[i]]
		end
	end
	return iter
end

--Tabs


function MainTabs()
	
	
	
	if ImGui.BeginTabItem(getLang("editor_Introduction")) then
		
		
		
		local text = getLang("editor_main"):gsub("\\\\([n])", {n="\n"})
		local text2 = text:gsub("\\([n])", {n="\n"})
		ImGui.InputTextMultiline("##EditorMain", text2, 99999 , 1100, 400, ImGuiInputTextFlags.ReadOnly)
		
		ImGui.EndTabItem()
	end
end

function QuestTabs()
	
	if(activeEditedQuest.tag == nil) then
		activeEditedQuest.title = ""
		activeEditedQuest.content = ""
		activeEditedQuest.tag = ""
		
		activeEditedQuest.recommandedlevel = 12
		activeEditedQuest.questtype = EgameJournalQuestType.Contract
		activeEditedQuest.district = EgamedataDistrict.Watson
		
		activeEditedQuest["trigger_condition"] = {}
		activeEditedQuest["trigger_condition_requirement"] = {}
		activeEditedQuest["trigger_action"] = {}
		
		activeEditedQuest["objectives"] = {}
		
		activeEditedQuest["end_action"] = {}
		activeEditedQuest["failure_action"] = {}
		activeEditedQuest["reset_action"] = {}
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Quest")) then
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadQuesttag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayQuest2) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadQuest = v
					loadQuesttag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedQuest = loadQuest.quest
			
			if(activeEditedQuest.tag == nil) then
				
				activeEditedQuest.title = "new"
				activeEditedQuest.content = ""
				activeEditedQuest.tag = ""
				
				activeEditedQuest.recommandedlevel = 12
				activeEditedQuest.questtype = EgameJournalQuestType.Contract
				activeEditedQuest.district = EgamedataDistrict.Watson
				
				activeEditedQuest["trigger_condition"] = {}
				activeEditedQuest["trigger_condition_requirement"] = {}
				activeEditedQuest["trigger_action"] = {}
				
				activeEditedQuest["objectives"] = {}
				
				activeEditedQuest["end_action"] = {}
				activeEditedQuest["failure_action"] = {}
				activeEditedQuest["reset_action"] = {}
				
				
			end
		end
		if(loadQuest.quest ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				
				activeEditedQuest = {}
				loadQuest = {}
				loadQuesttag = ""
				
				if(activeEditedQuest.tag == nil) then
					
					activeEditedQuest.title = "new"
					activeEditedQuest.content = ""
					activeEditedQuest.tag = ""
					
					activeEditedQuest.recommandedlevel = 12
					activeEditedQuest.questtype = EgameJournalQuestType.Contract
					activeEditedQuest.district = EgamedataDistrict.Watson
					
					activeEditedQuest["trigger_condition"] = {}
					activeEditedQuest["trigger_condition_requirement"] = {}
					activeEditedQuest["trigger_action"] = {}
					
					activeEditedQuest["objectives"] = {}
					
					activeEditedQuest["end_action"] = {}
					activeEditedQuest["failure_action"] = {}
					activeEditedQuest["reset_action"] = {}
					
					
				end
			end
		end
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedQuest.title = ImGui.InputText(getLang("editor_title"), activeEditedQuest.title, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedQuest.content = ImGui.InputText(getLang("editor_content"), activeEditedQuest.content, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedQuest.tag = ImGui.InputText(getLang("editor_tag"), activeEditedQuest.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedQuest.recommandedlevel =  ImGui.InputInt(getLang("editor_recommendedlevel"), activeEditedQuest.recommandedlevel, 1,10, ImGuiInputTextFlags.None)
		
		
		if ImGui.BeginCombo(getLang("editor_Quest_Type"), defaultQuestType) then
			
			
			for k,v in pairs(EgameJournalQuestType) do
				
				if ImGui.Selectable(k, (activeEditedQuest.questtype == EgameJournalQuestType[k])) then
					activeEditedQuest.questtype = EgameJournalQuestType[k]
					
					defaultQuestType = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		if ImGui.BeginCombo(getLang("editor_district"), defaultEnumDistrict) then
			
			
			for k,v in pairs(EgamedataDistrict) do
				
				if ImGui.Selectable(k, (activeEditedQuest.district == EgamedataDistrict[k])) then
					activeEditedQuest.district = EgamedataDistrict[k]
					
					defaultEnumDistrict = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		
		
		
		triggerNode(getLang("trigger_condition"),activeEditedQuest,"trigger_condition")
		if(tableHasKey(activeEditedQuest["trigger_condition"])) then
			ImGui.Text(getLang("editor_msg_phone_way"))
			requirementNode(getLang("trigger_condition_requirement"),activeEditedQuest,"trigger_condition_requirement","trigger_condition")
			if(#activeEditedQuest["trigger_condition_requirement"] > 0) then
				
				actionNode(getLang("trigger_action"),activeEditedQuest,"trigger_action")
				
				
				ObjectiveNode(activeEditedQuest)
				
				actionNode(getLang("end_action"),activeEditedQuest,"end_action")
				actionNode(getLang("failure_action"),activeEditedQuest,"failure_action")
				actionNode(getLang("reset_action"),activeEditedQuest,"reset_action")
				
				
				else
				ImGui.Text(getLang("need_requirement"))
			end
		end
		
		
		
		
		
		
		
		
		
		
		
		
		
		if(activeEditedQuest.tag ~= nil and activeEditedQuest.tag ~= "")then
			
			if ImGui.Button(getLang("Show Graph")) then
			
				openQuestGraph = true
			
			
			end
			
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackQuest,activeEditedQuest)
				
				
			end
			
			ImGui.SameLine()
			
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedQuest.tag ~= "" then
				
				arrayQuest2[activeEditedQuest.tag] = {}
				arrayQuest2[activeEditedQuest.tag].quest = activeEditedQuest
				
				QuestManager.RemoveQuest(activeEditedQuest.tag)
				loadQuestToUI(activeEditedQuest)
				
			end
			
			ImGui.SameLine()
			
			if ImGui.Button(getLang("editor_export")) then
				
				
				local file = assert(io.open("json/report/"..activeEditedQuest.tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedQuest)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
				
			end
			
			else
			
			ImGui.Text(getLang("editor_export_warning"))
			
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedQuest.tag ~= "" then
			
			editor_json_tag = activeEditedQuest.tag
			editor_json = JSON:encode_pretty(activeEditedQuest)
			editor_json_obj = activeEditedQuest
			editor_json_obj_name = "activeEditedQuest"
			editor_json_view = true
			
			
			
		end
		
		
		ImGui.EndTabItem()
	end
end

function QuestGraph()
	
	if(activeEditedQuest.tag ~= nil) then
		
		
	
	ImGui.SetNextWindowPos(300, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(1200, 800, ImGuiCond.Appearing) -- set window size w, h
	

	
	
	
	if ImGui.Begin(getLang("Quest Graph")) then
	
		if ImGui.Button(getLang("Close")) then
			
			openQuestGraph = false
			
			
		end
	
	
	ImGui.Text("Name : "..activeEditedQuest.title)
	ImGui.Text("Description : "..activeEditedQuest.content)
	ImGui.Text("Tag : "..activeEditedQuest.tag)
	
	for k,v in pairs(EgameJournalQuestType) do
		if activeEditedQuest.questtype == EgameJournalQuestType[k] then
		
			ImGui.Text("Type : "..k)
		
		end
	
	end
	
	ImGui.Text("Recommanded Level : "..activeEditedQuest.recommandedlevel)
	
	local recurrent = "True"
	if(activeEditedQuest.recurrent == false) then recurrent = "False" end
	
	ImGui.Text("Recurent : "..recurrent)
	
	for k,v in pairs(EgamedataDistrict) do
				
				if activeEditedQuest.district == EgamedataDistrict[k] then
		
					ImGui.Text("District : "..k)
		
				end
				
				
	end
	
	ImGui.Text("This quest is available when : ")
	local requirement = ""
	for iparent,parent in ipairs(activeEditedQuest.trigger_condition_requirement) do
	
		for ichildren,children in pairs(parent) do
	
		
			local text = "Unknown Trigger"
				
			for i,value in ipairs(triggertemplate) do
				
				if(value.name == activeEditedQuest.trigger_condition[children].name) then
						
						text = value.helper
						
				
				end
				
			end
			
			requirement = requirement..text
			
			if(activeEditedQuest.trigger_condition_requirement[iparent][ichildren+1] ~= nil) then
		
			requirement = requirement.. "\n AND \n"
			
			else
			
			requirement = requirement.. "\n"
		
			end
		
		end
		
		if(activeEditedQuest.trigger_condition_requirement[iparent+1] ~= nil) then
		
			requirement = requirement.. "\n OR \n"
		
		end
	
	
	
	end
	ImGui.Text(requirement)
	
	
	
	
	ImGui.Separator()
	ImGui.Text("Objectives Graph")
	ImGui.Separator()
	
	
	
	ImGui.PushStyleColor(ImGuiCol.ChildBg,  0.81960784313725,	0.81960784313725,	0.81960784313725, 0.2)
	if ImGui.BeginChild("graphquest", 1100, 400, true) then
	
	ImGui.PushStyleColor(ImGuiCol.ChildBg,  0,	0,	0, 1)
	if ImGui.BeginChild("graphquestStart", 150, 30, true) then
		
		
		ImGui.PushStyleColor(ImGuiCol.Text,  0, 1, 0.054901960784314, 1)
		ImGui.Text("Start OF THE QUEST")
		ImGui.PopStyleColor()
	
		
		
	end
	ImGui.EndChild()
	ImGui.PopStyleColor()
	
	ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
	ImGui.SameLine()
	ImGui.Text("-")
	ImGui.SameLine()
	ImGui.Text("-")
	ImGui.SameLine()
	ImGui.Text(">")
	ImGui.SameLine()
	ImGui.PopStyleColor()
	
	
	nextObj(activeEditedQuest.objectives[1])
	
	
	ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
	ImGui.SameLine()
	ImGui.Text("-")
	ImGui.SameLine()
	ImGui.Text("-")
	ImGui.SameLine()
	ImGui.Text(">")
	ImGui.SameLine()
	ImGui.PopStyleColor()
	
	ImGui.PushStyleColor(ImGuiCol.ChildBg,  0,	0,	0, 1)
	if ImGui.BeginChild("graphquestEnd", 150, 30, true) then
	
	ImGui.PushStyleColor(ImGuiCol.Text, 0.71372549019608,0.0,0.0, 1)
	ImGui.Text("END OF THE QUEST")
	ImGui.PopStyleColor()
	
		
	end	
	
	ImGui.EndChild()
	ImGui.PopStyleColor()
	
	
		
	end
	ImGui.EndChild()
	ImGui.PopStyleColor()
	
	
	end
	
	ImGui.End()
	
	end
	
end


function nextObj(objective)


		ImGui.PushStyleColor(ImGuiCol.ChildBg,  0,	0,	0, 0)
		ImGui.BeginChild("##"..objective.title.."container", 200, 400, true,ImGuiWindowFlags.AlwaysHorizontalScrollbar) 
		
		
		if(objective.isoptionnal ~= true) then
		ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
		ImGui.SameLine()
		ImGui.Text("-")
		ImGui.SameLine()
		ImGui.Text("-")
		ImGui.SameLine()
		ImGui.Text(">")
		ImGui.SameLine()
		ImGui.PopStyleColor()
		else
		ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
		ImGui.Spacing()
		ImGui.Text("|")
		ImGui.Spacing()
		ImGui.Text("|")
		ImGui.Spacing()
		ImGui.Text("V")
		ImGui.Spacing()
		ImGui.PopStyleColor()
		end
		
		
		
		
		if objective.isoptionnal == true then
			ImGui.PushStyleColor(ImGuiCol.ChildBg,  0.1921568627451,0.77254901960784,0.31372549019608, 0.5)
			else
			ImGui.PushStyleColor(ImGuiCol.ChildBg, 0.1921568627451,0.65882352941176,0.77254901960784, 0.5)
		end
		if ImGui.BeginChild(objective.title, 190, 200, true) then
			if ImGui.BeginChild(objective.title.."child", 190, 190, false) then
			ImGui.Text(objective.title)
			
			ImGui.Separator()
			
			ImGui.Text("Tag : "..objective.tag)
			ImGui.Text("State : "..objective.state)
			ImGui.Text("is Optionnal : "..tostring(objective.isoptionnal))
			
			ImGui.Text("This objective is finished when : ")
			local requirementobj = ""
			for iparent,parent in ipairs(objective.requirement) do
			
				for ichildren,children in pairs(parent) do
			
				
					local text = "Unknown Trigger"
						
					for i,value in ipairs(triggertemplate) do
						
						if(value.name == objective.trigger[children].name) then
								
								text = value.helper
								
						
						end
						
					end
					
					requirementobj = requirementobj..text
					
					if(objective.requirement[iparent][ichildren+1] ~= nil) then
				
					requirementobj = requirementobj.. "\n AND \n"
					
					else
					
					requirementobj = requirementobj.. "\n"
				
					end
				
				end
				
				if(objective.requirement[iparent+1] ~= nil) then
				
					requirementobj = requirementobj.. "\n OR \n"
				
				end
			
			
			
			end
			ImGui.Text(requirementobj)
	
		
			end
			ImGui.EndChild()
		
		end
		ImGui.EndChild()
		ImGui.PopStyleColor()
	
		if(objective.unlock ~= nil and #objective.unlock > 0) then
		
			
			for i,v in ipairs(objective.unlock) do
			
				
				for i,o in ipairs(activeEditedQuest.objectives) do
				
					if(o.tag == v) then
						if(activeEditedQuest.objectives[i].isoptionnal ~= true) then
							ImGui.EndChild()
							ImGui.PopStyleColor()
							ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
							ImGui.SameLine()
							ImGui.Text("-")
							ImGui.SameLine()
							ImGui.Text("-")
							ImGui.SameLine()
							ImGui.Text(">")
							ImGui.SameLine()
							ImGui.PopStyleColor()
							nextObj(activeEditedQuest.objectives[i])
							else
							ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
							ImGui.Spacing()
							ImGui.Text("|")
							ImGui.Spacing()
							ImGui.Text("|")
							ImGui.Spacing()
							ImGui.Text("V")
							ImGui.Spacing()
							ImGui.PopStyleColor()
							nextObj(activeEditedQuest.objectives[i])
							ImGui.EndChild()
							ImGui.PopStyleColor()

						end
						
					end
				end
			
			
			end
		
	else
	
		ImGui.EndChild()
		ImGui.PopStyleColor()
	
		end
		

end



function DialogTabs()
	
	
	if(activeEditedDialog.Tag == nil) then
		activeEditedDialog.Desc = ""
		activeEditedDialog.havequitoption = true
		activeEditedDialog.speaker = {}
		activeEditedDialog.speaker.value = "Judy"
		activeEditedDialog.speaker.way = "phone"
		activeEditedDialog.Tag = ""
		activeEditedDialog["trigger"] = {}
		activeEditedDialog["requirement"] = {}
		activeEditedDialog["options"] = {}
		
		
	end
	
	if(activeEditedDialog.havequitoption == nil) then
		activeEditedDialog.havequitoption = true
	end
	
	if ImGui.BeginTabItem(getLang("editor_Choices")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadDialogtag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayDialog) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadDialog = v.dialog
					loadDialogtag = k
					
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
				
			end
			ImGui.EndCombo()
		end
		
		
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedDialog = loadDialog
			
			if(activeEditedDialog.Tag == nil) then
				activeEditedDialog.Desc = ""
				activeEditedDialog.speaker = {}
				activeEditedDialog.speaker.value = "Judy"
				activeEditedDialog.speaker.way = "phone"
				activeEditedDialog.Tag = ""
				activeEditedDialog["trigger"] = {}
				activeEditedDialog["requirement"] = {}
				activeEditedDialog["options"] = {}
				
				
			end
			
		end
		
		if(loadDialog.Tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				
				activeEditedDialog = {}
				loadDialog = {}
				loadDialogtag = ""
				
				if(activeEditedDialog.Tag == nil) then
					activeEditedDialog.Desc = ""
					activeEditedDialog.speaker = {}
					activeEditedDialog.speaker.value = "Judy"
					activeEditedDialog.speaker.way = "phone"
					activeEditedDialog.Tag = ""
					activeEditedDialog["trigger"] = {}
					activeEditedDialog["requirement"] = {}
					activeEditedDialog["options"] = {}
					
					
				end
			end
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedDialog.Desc = ""
		
		activeEditedDialog.Tag = ImGui.InputText(getLang("editor_tag"), activeEditedDialog.Tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedDialog.havequitoption = ImGui.Checkbox(getLang("editor_havequitoption"), activeEditedDialog.havequitoption)
		
		--npcchara = "Judy"
		
		ImGui.Text(getLang("editor_speaker_who"))
		--	debugPrint(2,activeEditedDialog.speaker.value)
		
		if(activeEditedDialog.speaker.value ~= nil) then
			
			for i,v in ipairs(arrayPnjDb) do
				
				if activeEditedDialog.speaker.value  == v.Names then
					
					npcchara = v.Names
					
				end
				
				
			end
		end
		
		
		if ImGui.BeginCombo("##My ComboBox1", npcchara) then
			
			
			for i,v in ipairs(arrayPnjDb) do
				
				if ImGui.Selectable(v.Names, (activeEditedDialog.speaker.value == v.Names)) then
					activeEditedDialog.speaker.value = v.Names
					
					npcchara = v.Names
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		ImGui.Text(getLang("editor_speaker_way"))
		
		if(activeEditedDialog.speaker.way ~= nil) then
			
			if activeEditedDialog.speaker.way == "quest" then
				
				waydialog = "Quest"
				
			end
			
			if activeEditedDialog.speaker.way == "phone" then
				
				waydialog = "Phone"
				
			end
			
			if activeEditedDialog.speaker.way == "interact" then
				
				waydialog = "Interact"
				
			end
			
			if activeEditedDialog.speaker.way == "speak" then
				
				waydialog = "Speak"
				
			end
			
			
			
			
		end
		
		if ImGui.BeginCombo("##My ComboBox2", waydialog) then
			
			if ImGui.Selectable("Quest", (activeEditedDialog.speaker.way == "quest")) then
				activeEditedDialog.speaker.way = "quest"
				waydialog = "Quest"
				ImGui.SetItemDefaultFocus()
			end
			
			if ImGui.Selectable("Phone", (activeEditedDialog.speaker.way == "phone")) then
				activeEditedDialog.speaker.way = "phone"
				waydialog = "Phone"
				ImGui.SetItemDefaultFocus()
			end
			
			if ImGui.Selectable("Interact", (activeEditedDialog.speaker.way == "interact")) then
				activeEditedDialog.speaker.way = "interact"
				waydialog = "Interact"
				ImGui.SetItemDefaultFocus()
			end
			
			if ImGui.Selectable("Speak", (activeEditedDialog.speaker.way == "speak")) then
				activeEditedDialog.speaker.way = "speak"
				waydialog = "Speak"
				ImGui.SetItemDefaultFocus()
			end
			
			
			ImGui.EndCombo()
		end
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		triggerNode(getLang("trigger_condition"),activeEditedDialog,"trigger")
		
		
		
		
		if(tableHasKey(activeEditedDialog["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),activeEditedDialog,"requirement","trigger")
			if(#activeEditedDialog["requirement"] > 0) then
				optionsNode(getLang("editor_answer"),activeEditedDialog)
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
			
			
			
			
		end
		
		if(activeEditedDialog.Tag ~= nil and activeEditedDialog.Tag ~= "")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackDialog,activeEditedDialog)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedDialog.Tag ~= "" then
				
				
				
				arrayDialog[activeEditedDialog.Tag] = {}
				arrayDialog[activeEditedDialog.Tag].dialog = activeEditedDialog
				
				createDialog(activeEditedDialog)	
				
				
				
				
				
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedDialog.Tag ~= "" then
				
				local arraydialogTemp = {}
				table.insert(arraydialogTemp,activeEditedDialog)
				local file = assert(io.open("json/report/"..activeEditedDialog.Tag..".json", "w"))
				local stringg = JSON:encode_pretty(arraydialogTemp)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedDialog.Tag ~= "" then
			
			editor_json_tag = activeEditedDialog.Tag
			editor_json = JSON:encode_pretty(activeEditedDialog)
			editor_json_obj = activeEditedDialog
			editor_json_obj_name = "activeEditedDialog"
			editor_json_view = true
			
			
			
		end
		
		
		ImGui.EndTabItem()
	end
	
	
	
end


function PhoneDialogTabs()
	
	
	if(activeEditedPhoneDialog.tag == nil) then
		
		activeEditedPhoneDialog.tag = ""
		activeEditedPhoneDialog.unlock = false
		activeEditedPhoneDialog.speaker = "Judy"
		activeEditedPhoneDialog["conversation"] = {}
		
		
	end
	
	
	
	if ImGui.BeginTabItem(getLang("editor_phone_dialog")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadPhoneDialogtag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayPhoneConversation) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadPhoneDialog = v.conv
					loadPhoneDialogtag = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			ImGui.EndCombo()
		end
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedPhoneDialog =loadPhoneDialog
			
			if(activeEditedPhoneDialog == nil) then
				activeEditedPhoneDialog = {}
				activeEditedPhoneDialog.tag = ""
				activeEditedPhoneDialog.unlock = false
				activeEditedPhoneDialog.speaker = "Judy"
				activeEditedPhoneDialog["conversation"] = {}
				
				
			end
			
		end
		if(loadPhoneDialog.tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadPhoneDialog = {}
				loadPhoneDialogtag = ""
				activeEditedPhoneDialog = {}
				if(activeEditedPhoneDialog == nil) then
					activeEditedPhoneDialog = {}
					activeEditedPhoneDialog.tag = ""
					activeEditedPhoneDialog.unlock = false
					activeEditedPhoneDialog.speaker = "Judy"
					activeEditedPhoneDialog["conversation"] = {}
					
					
				end
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedPhoneDialog.speaker = ImGui.InputText(getLang("editor_speaker"), activeEditedPhoneDialog.speaker, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedPhoneDialog.tag = ImGui.InputText(getLang("editor_tag"), activeEditedPhoneDialog.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedPhoneDialog.unlock = ImGui.Checkbox(getLang("editor_unlock"), activeEditedPhoneDialog.unlock)
		
		--npcchara = "Judy"
		
		
		ConversationNode(activeEditedPhoneDialog)
		
		if(#activeEditedPhoneDialog["conversation"] > 0) then
			
			if(activeEditedPhoneDialog.tag ~= nil and activeEditedPhoneDialog.tag ~= "")then
				
				if ImGui.Button(getLang("editor_save_for_build")) then
					
					
					
					table.insert(myDatapackDialog,activeEditedPhoneDialog)
					
					
				end
				ImGui.SameLine()
				if ImGui.Button(getLang("editor_test_in_game")) and activeEditedPhoneDialog.tag ~= "" then
					
					
					
					
					local fixetemp = getPhoneConversationByTag(activeEditedPhoneDialog.tag) 
					if(fixetemp == nil) then
						
						
						if(activeEditedPhoneDialog.unlock == false ) then
							
							if(getScoreKey(activeEditedPhoneDialog.tag,"unlocked") == 0 or getScoreKey(activeEditedPhoneDialog.tag,"unlocked") == nil ) then
								
								setScore(activeEditedPhoneDialog.tag,"unlocked",0)
								
								
								
							end
							
							else
							
							if(getScoreKey(activeEditedPhoneDialog.tag,"unlocked") == 0 or getScoreKey(activeEditedPhoneDialog.tag,"unlocked") == nil) then
								
								setScore(activeEditedPhoneDialog.tag,"unlocked",1)
								
								
								
							end
							
							
						end
						for z =1, #activeEditedPhoneDialog.conversation do
							
							if(activeEditedPhoneDialog.conversation[z].unlock == false ) then
								
								if(getScoreKey(activeEditedPhoneDialog.conversation[z].tag,"unlocked") == 0 or getScoreKey(activeEditedPhoneDialog.conversation[z].tag,"unlocked") == nil ) then
									
									setScore(activeEditedPhoneDialog.conversation[z].tag,"unlocked",0)
									
								end
								
								
								else
								
								if(getScoreKey(activeEditedPhoneDialog.conversation[z].tag,"unlocked") == 0 or getScoreKey(activeEditedPhoneDialog.conversation[z].tag,"unlocked") == nil ) then
									
									setScore(activeEditedPhoneDialog.conversation[z].tag,"unlocked",1)
									
									
									
									
								end
							end
							
							
							for y=1, #activeEditedPhoneDialog.conversation[z].message do
								
								if(activeEditedPhoneDialog.conversation[z].message[y].unlock == false ) then
									
									if(getScoreKey(activeEditedPhoneDialog.conversation[z].message[y].tag,"unlocked") == 0 or getScoreKey(activeEditedPhoneDialog.conversation[z].message[y].tag,"unlocked") ==  nil ) then
										
										setScore(activeEditedPhoneDialog.conversation[z].message[y].tag,"unlocked",0)
										
									end
									
									else
									
									if(getScoreKey(activeEditedPhoneDialog.conversation[z].message[y].tag,"unlocked") == 0 or getScoreKey(activeEditedPhoneDialog.conversation[z].message[y].tag,"unlocked") == nil ) then
										
										setScore(activeEditedPhoneDialog.conversation[z].message[y].tag,"unlocked",1)
										
										
										
										
									end
									
								end
								
								
								
								
								
							end
							
							
						end
						
						arrayPhoneConversation[activeEditedPhoneDialog.tag] = {}
						arrayPhoneConversation[activeEditedPhoneDialog.tag].conv = activeEditedPhoneDialog
						arrayPhoneConversation[activeEditedPhoneDialog.tag].file = "editor"
						arrayPhoneConversation[activeEditedPhoneDialog.tag].datapack = "editor"
						else
						fixetemp = activeEditedPhoneDialog
					end
					
					
				end
				ImGui.SameLine()
				if ImGui.Button(getLang("editor_export")) and activeEditedPhoneDialog.tag ~= "" then
					
					local arraydialogTemp = {}
					table.insert(arraydialogTemp,activeEditedPhoneDialog)
					local file = assert(io.open("json/report/"..activeEditedPhoneDialog.tag..".json", "w"))
					local stringg = JSON:encode_pretty(arraydialogTemp)
					--debug--debugPrint(2,stringg)
					file:write(stringg)
					file:close()
					
					
				end
				
				
				else
				ImGui.Text(getLang("editor_export_warning"))
			end
			
			
		end
		
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedPhoneDialog.tag ~= "" then
			
			editor_json_tag = activeEditedPhoneDialog.tag
			editor_json = JSON:encode_pretty(activeEditedPhoneDialog)
			
			editor_json_obj = activeEditedPhoneDialog
			editor_json_obj_name = "activeEditedPhoneDialog"
			editor_json_view = true
			
		end
		ImGui.EndTabItem()
		
		
		
		
		
		
		
	end
	
	
end


function InteractTabs()
	
	if(activeEditedInteract.tag == nil) then
		activeEditedInteract.name = ""
		activeEditedInteract.tag = ""
		activeEditedInteract.timer = 0
		activeEditedInteract.sorttag = ""
		activeEditedInteract.display = "event_interact"
		activeEditedInteract.type = "interact"
		activeEditedInteract.hold = false
		activeEditedInteract.key = "QuickMelee"
		activeEditedInteract["trigger"] = {}
		activeEditedInteract["requirement"] = {}
		activeEditedInteract["action"] = {}
		
		
	end
	
	
	
	
	if ImGui.BeginTabItem(getLang("editor_Interact")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadInteracttag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayInteract) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadInteract = v
					loadInteracttag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedInteract = loadInteract.interact
			
			if(activeEditedInteract.tag == nil) then
				activeEditedInteract.name = ""
				activeEditedInteract.tag = ""
				activeEditedInteract.timer = 0
				activeEditedInteract.sorttag = ""
				activeEditedInteract.display = "event_interact"
				activeEditedInteract.type = "interact"
				activeEditedInteract.hold = false
				activeEditedInteract.key = "QuickMelee"
				activeEditedInteract["trigger"] = {}
				activeEditedInteract["requirement"] = {}
				activeEditedInteract["action"] = {}
				
				
			end
			
		end
		if(loadInteract.interact ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadInteract = {}
				loadInteracttag = ""
				activeEditedInteract = {}
				if(activeEditedInteract.tag == nil) then
					activeEditedInteract.name = ""
					activeEditedInteract.tag = ""
					activeEditedInteract.timer = 0
					activeEditedInteract.sorttag = ""
					activeEditedInteract.display = "event_interact"
					activeEditedInteract.type = "interact"
					activeEditedInteract.hold = false
					activeEditedInteract.key = "QuickMelee"
					activeEditedInteract["trigger"] = {}
					activeEditedInteract["requirement"] = {}
					activeEditedInteract["action"] = {}
					
					
				end
				
				
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedInteract.name = ImGui.InputText(getLang("editor_Name"), activeEditedInteract.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedInteract.tag = ImGui.InputText(getLang("editor_tag"), activeEditedInteract.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Text(getLang("editor_Interact_Timer_msg"))
		activeEditedInteract.timer = ImGui.InputInt(getLang("editor_Interact_Timer"), activeEditedInteract.timer, 1,10, ImGuiInputTextFlags.None)
		ImGui.Text(getLang("editor_Interact_SortTag_msg"))
		activeEditedInteract.sorttag = ImGui.InputText(getLang("editor_Interact_SortTag"), activeEditedInteract.sorttag, 100, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Text(getLang("editor_Interact_Display_msg"))
		activeEditedInteract.display = ImGui.InputText(getLang("editor_Interact_Display_msg"), activeEditedInteract.display, 100, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Text(getLang("editor_Interact_Type_msg"))
		
		if(activeEditedInteract.type == nil ) then
			activeEditedInteract.type = ""
		end
		
		activeEditedInteract.type = ImGui.InputText(getLang("editor_Interact_Type"), activeEditedInteract.type, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		if(activeEditedInteract.type == "hint") then
			
			activeEditedInteract.hold = ImGui.Checkbox(getLang("editor_Interact_hold"), activeEditedInteract.hold)
			activeEditedInteract.key = ImGui.InputText(getLang("editor_Interact_key"), activeEditedInteract.key, 100, ImGuiInputTextFlags.AutoSelectAll)
		end
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		triggerNode(getLang("trigger_condition"),activeEditedInteract,"trigger")
		
		
		
		
		if(tableHasKey(activeEditedInteract["trigger"])) then
			
			
			requirementNode(getLang("trigger_condition_requirement"),activeEditedInteract,"requirement","trigger")
			
			if(#activeEditedInteract["requirement"] > 0) then
				actionNode(getLang("trigger_action"),activeEditedInteract,"action")
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
			
			
			
			
		end
		
		if(activeEditedInteract.tag ~= nil and activeEditedInteract.tag ~= "")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackInteract,activeEditedInteract)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedInteract.tag ~= "" then
				
				arrayInteract[activeEditedInteract.tag] = {}
				arrayInteract[activeEditedInteract.tag].interact = activeEditedInteract
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedInteract.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedInteract.tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedInteract)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				table.insert(myDatapackInteract,activeEditedInteract)
				
			end
			
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedInteract.tag ~= "" then
			
			editor_json_tag = activeEditedInteract.tag
			editor_json = JSON:encode_pretty(activeEditedInteract)
			
			editor_json_obj = activeEditedInteract
			editor_json_obj_name = "activeEditedInteract"
			editor_json_view = true
			
		end
		
		
		ImGui.EndTabItem()
	end
	
end

function EventTabs()
	
	if(activeEditedEvent.tag == nil) then
		activeEditedEvent.name = ""
		activeEditedEvent.tag = ""
		activeEditedEvent.way = "world" --world init ambush
		
		activeEditedEvent["trigger"] = {}
		activeEditedEvent["requirement"] = {}
		activeEditedEvent["action"] = {}
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Event")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadEventtag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayEvent) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadEvent = v
					loadEventtag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedEvent = loadEvent.event
			
			if(activeEditedEvent.tag == nil) then
				activeEditedEvent.name = ""
				activeEditedEvent.tag = ""
				activeEditedEvent.way = "world"
				
				activeEditedEvent["trigger"] = {}
				activeEditedEvent["requirement"] = {}
				activeEditedEvent["action"] = {}
				
				
			end
			
		end
		
		if(loadEvent.event ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadEvent = {}
				loadEventtag = ""
				activeEditedEvent = {}
				
				if(activeEditedEvent.tag == nil) then
					activeEditedEvent.name = ""
					activeEditedEvent.tag = ""
					activeEditedEvent.way = "world"
					
					activeEditedEvent["trigger"] = {}
					activeEditedEvent["requirement"] = {}
					activeEditedEvent["action"] = {}
					
					
				end
				
				
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedEvent.name = ImGui.InputText(getLang("editor_Name"), activeEditedEvent.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedEvent.tag = ImGui.InputText(getLang("editor_tag"), activeEditedEvent.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Text(getLang("editor_Event_way_msg"))
		activeEditedEvent.way = ImGui.InputText(getLang("editor_Event_way"), activeEditedEvent.way, 100, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		triggerNode(getLang("trigger_condition"),activeEditedEvent,"trigger")
		
		
		
		
		if(tableHasKey(activeEditedEvent["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),activeEditedEvent,"requirement","trigger")
			
			if(#activeEditedEvent["requirement"] > 0) then
				actionNode(getLang("trigger_action"),activeEditedEvent,"action")
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
			
			
			
			
			
		end
		
		if(activeEditedEvent.tag ~= nil and activeEditedEvent.tag ~= "")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackEvent,activeEditedEvent)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedEvent.tag ~= "" then
				
				
				
				if(checkTriggerRequirement(activeEditedEvent.requirement,activeEditedEvent.trigger))then
					
					runActionList(activeEditedEvent.action,activeEditedEvent.tag,"interact",false,"player")
					
					
				end
				
				
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedEvent.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedEvent.tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedEvent)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedEvent.tag ~= "" then
			
			editor_json_tag = activeEditedEvent.tag
			editor_json = JSON:encode_pretty(activeEditedEvent)
			
			editor_json_obj = activeEditedEvent
			editor_json_obj_name = "activeEditedEvent"
			editor_json_view = true
			
		end
		
		ImGui.EndTabItem()
		
	end
	
end

function FixerTabs()
	
	if(activeEditedFixer.Tag == nil) then
		activeEditedFixer.Name = ""
		activeEditedFixer.LOC_X = 0
		activeEditedFixer.LOC_Y = 0
		activeEditedFixer.LOC_Z = 0
		activeEditedFixer.range = 0
		activeEditedFixer.Faction = ""
		activeEditedFixer.Tag = ""
		activeEditedFixer.NPCId = ""
		activeEditedFixer.exist = false
		activeEditedFixer.npcexist = false
		
		activeEditedFixer["trigger"] = {}
		activeEditedFixer["requirement"] = {}
		activeEditedFixer["spawn_action"] = {}
		activeEditedFixer["despawn_action"] = {}
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Fixer")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadFixertag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayFixer) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadFixer = v.fixer
					loadFixertag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		if(ImGui.Button("Load Fixer")) then
			
			activeEditedFixer = loadFixer
			
			if(activeEditedFixer == nil) then
				activeEditedFixer = {}
				activeEditedFixer.Tag = ""
				activeEditedFixer.Name = ""
				activeEditedFixer.LOC_X = 0
				activeEditedFixer.LOC_Y = 0
				activeEditedFixer.LOC_Z = 0
				activeEditedFixer.range = 0
				activeEditedFixer.Faction = ""
				activeEditedFixer.Tag = ""
				activeEditedFixer.NPCId = 0
				activeEditedFixer.exist = false
				activeEditedFixer.npcexist = false
				
				activeEditedFixer["trigger"] = {}
				activeEditedFixer["requirement"] = {}
				activeEditedFixer["spawn_action"] = {}
				activeEditedFixer["despawn_action"] = {}
				else
				
				
				local factiontemp = getFactionByTag(activeEditedFixer.Tag)
				if(factiontemp.Tag ~= nil) then
					defaultFaction = factiontemp.Name
					else
					defaultFaction = "Mox"
				end
			end
			
		end
		
		
		if(loadFixer.Tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadFixer = {}
				loadFixertag = ""
				activeEditedFixer = {}
				
				if(activeEditedFixer.Tag == nil) then
					activeEditedFixer = {}
					activeEditedFixer.Tag = ""
					activeEditedFixer.Name = ""
					activeEditedFixer.LOC_X = 0
					activeEditedFixer.LOC_Y = 0
					activeEditedFixer.LOC_Z = 0
					activeEditedFixer.range = 0
					activeEditedFixer.Faction = ""
					activeEditedFixer.Tag = ""
					activeEditedFixer.NPCId = 0
					activeEditedFixer.exist = false
					activeEditedFixer.npcexist = false
					
					activeEditedFixer["trigger"] = {}
					activeEditedFixer["requirement"] = {}
					activeEditedFixer["spawn_action"] = {}
					activeEditedFixer["despawn_action"] = {}
					else
					
					local factiontemp = getFactionByTag(activeEditedFixer.Tag)
					if(factiontemp.Tag ~= nil) then
						defaultFaction = factiontemp.Name
						else
						defaultFaction = "Mox"
					end
				end
				
			end
			
		end
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedFixer.Name = ImGui.InputText(getLang("editor_Name"), activeEditedFixer.Name, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedFixer.LOC_X = ImGui.InputFloat(getLang("editor_x"), activeEditedFixer.LOC_X, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedFixer.LOC_Y = ImGui.InputFloat(getLang("editor_y"), activeEditedFixer.LOC_Y, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedFixer.LOC_Z = ImGui.InputFloat(getLang("editor_z"), activeEditedFixer.LOC_Z, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedFixer.range = ImGui.InputFloat(getLang("editor_range"), activeEditedFixer.range, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		if ImGui.Button(getLang("editor_Name"), 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			activeEditedFixer.LOC_X = vec4.x
			activeEditedFixer.LOC_Y = vec4.y
			activeEditedFixer.LOC_Z = vec4.z
			
			
		end
		if(activeEditedFixer.Faction ~= "") then
			
			local fact = getFactionByTag(activeEditedFixer.Faction)
			defaultfaction = fact.Name
			
		end
		
		if(activeEditedFixer.NPCId ~= "") then
			
			for i,v in ipairs(arrayPnjDb) do
				
				if activeEditedFixer.NPCId  == v.Names then
					
					npcchara = v.Names
					
				end
				
				
			end
		end
		
		
		if ImGui.BeginCombo(getLang("editor_Faction"), defaultfaction) then
			
			
			for k,v in pairs(arrayFaction) do
				
				if ImGui.Selectable(v.faction.Name, (activeEditedFixer.Faction  == k)) then
					activeEditedFixer.Faction  = k
					defaultfaction = v.Name
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		--activeEditedFixer.Faction = ImGui.InputText("Faction", activeEditedFixer.Faction, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedFixer.Tag = ImGui.InputText(getLang("editor_tag"), activeEditedFixer.Tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		if ImGui.BeginCombo(getLang("editor_NPC"), npcchara) then
			
			
			for i,v in ipairs(arrayPnjDb) do
				
				if ImGui.Selectable(v.Names, (activeEditedFixer.NPCId  == v.Names)) then
					activeEditedFixer.NPCId  = v.Names
					npcchara = v.Names
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		
		activeEditedFixer.exist = ImGui.Checkbox(getLang("editor_Fixer_exist"), activeEditedFixer.exist)
		activeEditedFixer.npcexist = ImGui.Checkbox(getLang("editor_Fixer_npc_exist"), activeEditedFixer.npcexist)
		
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		triggerNode(getLang("trigger_condition"),activeEditedFixer,"trigger")
		
		
		
		
		if(tableHasKey(activeEditedFixer["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),activeEditedFixer,"requirement","trigger")
			
			if(#activeEditedFixer["requirement"] > 0) then
				actionNode("Spawn Action :",activeEditedFixer,"spawn_action")
				
				actionNode("Despawn Action :",activeEditedFixer,"despawn_action")
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
			
			
		end
		
		if(activeEditedFixer.Tag ~= nil and activeEditedFixer.Tag ~= "")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackFixer,activeEditedFixer)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedFixer.Tag ~= "" then
				
				
				
				local fixetemp = getFixerByTag(activeEditedFixer.Tag) 
				if(fixetemp == nil) then
					arrayFixer[activeEditedFixer.Tag] = {}
					arrayFixer[activeEditedFixer.Tag].fixer = activeEditedFixer
					arrayFixer[activeEditedFixer.Tag].file = "editor"
					arrayFixer[activeEditedFixer.Tag].datapack = "editor"
					else
					fixetemp = activeEditedFixer
				end
				
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedFixer.Tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedFixer.Tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedFixer)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedFixer.Tag ~= "" then
			
			editor_json_tag = activeEditedFixer.Tag
			editor_json = JSON:encode_pretty(activeEditedFixer)
			editor_json_obj = activeEditedFixer
			editor_json_obj_name = "activeEditedFixer"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
		
		
	end
	
	
end

function FactionTabs()
	
	if(activeEditedFaction.Tag == nil) then
		activeEditedFaction.Name = ""
		activeEditedFaction.Tag = ""
		activeEditedFaction.DistrictTag = ""
		activeEditedFaction.Logo = ""
		
		activeEditedFaction["AttitudeGroup"] = {}
		activeEditedFaction["Rivals"] = {}
		activeEditedFaction["SpawnableNPC"] = {}
		activeEditedFaction["SpawnableVehicule"] = {}
		activeEditedFaction["VIP"] = {}
		
		
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Faction")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadFactiontag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayFaction) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadFaction = v.faction
					loadFactiontag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedFaction = loadFaction
			
			if(activeEditedFaction.Tag == nil) then
				activeEditedFaction.Name = ""
				activeEditedFaction.Tag = ""
				activeEditedFaction.DistrictTag = ""
				
				activeEditedFaction["AttitudeGroup"] = {}
				activeEditedFaction["Rivals"] = {}
				activeEditedFaction["SpawnableNPC"] = {}
				activeEditedFaction["SpawnableVehicule"] = {}
				else
				defaultFaction = activeEditedFaction.Name
				defaultDistrict = activeEditedFaction.DistrictTag
			end
			
		end
		if(loadFaction.Tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadFaction = {}
				loadFactiontag = ""
				activeEditedFaction = {}
				
				if(activeEditedFaction.Tag == nil) then
					activeEditedFaction.Name = ""
					activeEditedFaction.Tag = ""
					activeEditedFaction.DistrictTag = ""
					
					activeEditedFaction["AttitudeGroup"] = {}
					activeEditedFaction["Rivals"] = {}
					activeEditedFaction["SpawnableNPC"] = {}
					activeEditedFaction["SpawnableVehicule"] = {}
					else
					defaultFaction = activeEditedFaction.Name
					defaultDistrict = activeEditedFaction.DistrictTag
				end
				
			end
			
		end
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedFaction.Name = ImGui.InputText(getLang("editor_Name"), activeEditedFaction.Name, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedFaction.Tag = ImGui.InputText(getLang("editor_tag"), activeEditedFaction.Tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedFaction.Logo = ImGui.InputText(getLang("editor_Faction_Logo"), activeEditedFaction.Logo, 100, ImGuiInputTextFlags.AutoSelectAll)
		--activeEditedFaction.DistrictTag = ImGui.InputText(getLang("editor_tag"), activeEditedFaction.Tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		
		
		
		if ImGui.BeginCombo(getLang("editor_district"), defaultDistrict) then
			
			
			for i,v in ipairs(arrayDistricts) do
				
				if ImGui.Selectable(v.Name, (activeEditedFaction.DistrictTag  == v.Tag)) then
					activeEditedFixer.DistrictTag  = v.Tag
					defaultDistrict = v.Name
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		
		listStringNode(getLang("editor_Faction_AttitudeGroup"),getLang("editor_Faction_AttitudeGroup_msg"),activeEditedFaction,"AttitudeGroup")
		listStringNode(getLang("editor_Faction_Rivals"),getLang("editor_Faction_Rivals_msg"),activeEditedFaction,"Rivals")
		listStringNode(getLang("editor_Faction_SpawnableNPC"),getLang("editor_Faction_SpawnableNPC_msg"),activeEditedFaction,"SpawnableNPC")
		listStringNode(getLang("editor_Faction_SpawnableVehicule"),getLang("editor_Faction_SpawnableVehicule_msg"),activeEditedFaction,"SpawnableVehicule")
		
		listVIPNode(getLang("editor_Faction_SpawnableVehicule"),getLang("editor_Faction_SpawnableVehicule_msg"),activeEditedFaction,"VIP")
		
		
		if(activeEditedFaction.Tag ~= nil and activeEditedFaction.Tag ~= "")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackFaction,activeEditedFaction)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedFaction.Tag ~= "" then
				
				
				
				local fixetemp = getFactionByTag(activeEditedFaction.Tag) 
				if(fixetemp.Tag == nil) then
					
					arrayEvent[activeEditedFaction.Tag] = {}
					arrayEvent[activeEditedFaction.Tag].faction = activeEditedFaction
					arrayEvent[activeEditedFaction.Tag].file = "editor"
					arrayEvent[activeEditedFaction.Tag].datapack = "editor"
					else
					fixetemp = activeEditedFaction
				end
				
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedFaction.Tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedFaction.Tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedFaction)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedFaction.Tag ~= "" then
			
			editor_json_tag = activeEditedFaction.Tag
			editor_json = JSON:encode_pretty(activeEditedFaction)
			editor_json_obj = activeEditedFaction
			editor_json_obj_name = "activeEditedFaction"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
		
		
	end
	
	
end

function RadioTabs()
	
	if(activeEditedRadio.tag == nil) then
		activeEditedRadio.name = ""
		activeEditedRadio.tag = ""
		activeEditedRadio.only_in_car = false
		
		activeEditedRadio["tracks"] = {}
		
		
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Radio")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadRadiotag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayRadio) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadRadio = v
					loadRadiotag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedRadio = loadRadio.radio
			
			if(activeEditedRadio.tag == nil) then
				activeEditedRadio.name = ""
				activeEditedRadio.tag = ""
				activeEditedRadio.only_in_car = false
				
				activeEditedRadio["tracks"] = {}
			end
			
		end
		
		if(loadRadio.radio ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadRadio = {}
				loadRadiotag = ""
				activeEditedRadio = {}
				if(activeEditedRadio.tag == nil) then
					activeEditedRadio.name = ""
					activeEditedRadio.tag = ""
					activeEditedRadio.only_in_car = false
					
					activeEditedRadio["tracks"] = {}
				end
				
				
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedRadio.name = ImGui.InputText(getLang("editor_Name"), activeEditedRadio.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedRadio.tag = ImGui.InputText(getLang("editor_tag"), activeEditedRadio.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedRadio.only_in_car = ImGui.Checkbox(getLang("editor_Radio_only_in_car"), activeEditedRadio.only_in_car)
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		
		listSongNode(getLang("editor_Radio_tracks"),getLang("editor_Radio_tracks_msg"),activeEditedRadio,"tracks")
		
		
		
		
		if(activeEditedRadio.tag ~= nil and activeEditedRadio.tag ~= "")then
			
			ImGui.Text(getLang("editor_Radio_warning01"))
			
			ImGui.Text(getLang("editor_Radio_warning02"))
			ImGui.Spacing()
			
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackRadio,activeEditedRadio)
				
				
			end
			ImGui.SameLine()
			
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_Radio_test")) and activeEditedRadio.tag ~= "" then
				
				
				
				arrayRadio[activeEditedRadio.tag] = {}
				arrayRadio[activeEditedRadio.tag].radio = activeEditedRadio
				arrayRadio[activeEditedRadio.tag].file = "editor"
				arrayRadio[activeEditedRadio.tag].datapack = "editor"
				arrayRadio[activeEditedRadio.tag].namespace = "Test"
				arrayRadio[activeEditedRadio.tag].enabled = false
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedRadio.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedRadio.tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedRadio)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedRadio.tag ~= "" then
			
			editor_json_tag = activeEditedRadio.tag
			editor_json = JSON:encode_pretty(activeEditedRadio)
			editor_json_obj = activeEditedRadio
			editor_json_obj_name = "activeEditedRadio"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
		
		
	end
	
	
end

function LangTabs()
	if(activeEditedLang.name == nil) then
		activeEditedLang.name = ""
		
		activeEditedLang["data"] = {}
		
		
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Lang")) then
		
		
		activeEditedLang.name = ImGui.InputText(getLang("editor_Lang_Filename"), activeEditedLang.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		listDictionnaryNode(getLang("editor_Lang_Key"),getLang("editor_Lang_Key_msg"),activeEditedLang,"data")
		
		
		
		
		
		if(activeEditedLang.name ~= nil and activeEditedLang.name ~= "")then
			
			
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackLanguage,activeEditedLang)
				
				
			end
			ImGui.SameLine()
			
			
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedLang.name ~= "" then
				
				
				for key, value in pairs(activeEditedLang["data"]) do 
					
					lang[key] = value
				end
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedLang.name ~= "" then
				
				else
				ImGui.Text(getLang("editor_export_warning"))
			end
		end
		
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedLang.name ~= "" then
			
			editor_json_tag = activeEditedLang.name
			editor_json = JSON:encode_pretty(name)
			editor_json_obj = activeEditedLang
			editor_json_obj_name = "activeEditedLang"
			editor_json_view = true
			
			
		end
		ImGui.EndTabItem()
		
		
	end
	
end

function ItemTabs()
	if ImGui.BeginTabItem(getLang("editor_Housing")) then
		
		if(currentHouse ~=nil) then
			
			
			
			ItemNode()
			
			
			
			if ImGui.Button(getLang("editor_Housing_Export")) then 
				
				
				if(#currentItemSpawned > 0) then
					local toexport = {}
					
					
					
					for i=1,#currentItemSpawned do
						
						local obj = {}
						obj.Id = currentItemSpawned[i].Id
						obj.Tag = currentItemSpawned[i].Tag
						obj.HouseTag = currentItemSpawned[i].HouseTag
						obj.ItemPath = currentItemSpawned[i].ItemPath
						obj.X = currentItemSpawned[i].X
						obj.Y = currentItemSpawned[i].Y
						obj.Z = currentItemSpawned[i].Z
						obj.Yaw = currentItemSpawned[i].Yaw
						obj.Pitch = currentItemSpawned[i].Pitch
						obj.Roll = currentItemSpawned[i].Roll
						obj.scale = currentItemSpawned[i].scale
						obj.defaultScale = currentItemSpawned[i].defaultScale
						table.insert(toexport,obj)
						
					end
					
					
					local file = assert(io.open("json/report/"..activeEditedPlace.tag.."_housing.json", "w"))
					local stringg = JSON:encode_pretty(toexport)
					--debug--debugPrint(2,stringg)
					file:write(stringg)
					file:close()
				end
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_Housing_Save")) then 
				
				
				if(#currentItemSpawned > 0) then
					local toexport = {}
					local housing = {}
					
					
					for i=1,#currentItemSpawned do
						
						local obj = {}
						obj.Id = currentItemSpawned[i].Id
						obj.Tag = currentItemSpawned[i].Tag
						obj.HouseTag = currentItemSpawned[i].HouseTag
						obj.ItemPath = currentItemSpawned[i].ItemPath
						obj.X = currentItemSpawned[i].X
						obj.Y = currentItemSpawned[i].Y
						obj.Z = currentItemSpawned[i].Z
						obj.Yaw = currentItemSpawned[i].Yaw
						obj.Pitch = currentItemSpawned[i].Pitch
						obj.Roll = currentItemSpawned[i].Roll
						obj.Title = currentItemSpawned[i].Title
						obj.scale = currentItemSpawned[i].scale
						obj.defaultScale = currentItemSpawned[i].defaultScale
						table.insert(toexport,obj)
						
					end
					
					housing.tag = activeEditedPlace.tag
					housing.items = toexport
					
					
					if(#myDatapackHousing > 0) then
						
						local exist = false
						
						for i=1,#myDatapackHousing do
							if(myDatapackHousing[i].tag == activeEditedPlace.tag) then
								
								myDatapackHousing[i].items =toexport
								exist = true
								
							end
						end
						
						
						if(exist == false)then
							table.insert(myDatapackHousing, housing)
							
						end
						
						else
						table.insert(myDatapackHousing, housing)
					end
				end
				
			end
			ImGui.Spacing()
			if ImGui.Button(getLang("editor_Housing_Buy"), 300, 0) then
				
				setScore(currentHouse.tag,"Statut",1)
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_Housing_Sell"), 300, 0) then
				
				setScore(currentHouse.tag,"Statut",0)
			end	
			
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_Housing_OpenBusiness"), 300, 0) then
				
				setScore(currentHouse.tag,"Statut",2)
			end	
			
			ImGui.Spacing()
			
			
			ImGui.Separator()
			
			ImGui.Text("Template")
			
			if ImGui.Button(getLang("editor_Housing_template_set_center_player_pos")) then 
				
				currentHouseCenter = {}
				local vec4 = Game.GetPlayer():GetWorldPosition()
				currentHouseCenter.x = vec4.x
				currentHouseCenter.y = vec4.y
				currentHouseCenter.z = vec4.z
				
			end
			if(currentHouseCenter ~= nil) then
				
				newHousingTemplateTag = ImGui.InputText("Housing Template "..getLang("editor_tag"), newHousingTemplateTag, 100, ImGuiInputTextFlags.AutoSelectAll)
				newHousingTemplateName = ImGui.InputText("Housing Template Name", newHousingTemplateName, 100, ImGuiInputTextFlags.AutoSelectAll)
				newHousingTemplatePrice = ImGui.InputFloat("Housing Template Price", newHousingTemplatePrice, 1, 10, "%.1f", ImGuiInputTextFlags.None)
				newHousingTemplateDescription = ImGui.InputTextMultiline("Housing Template "..getLang("editor_desc"), newHousingTemplateDescription, 100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
				newHousingTemplateTarget = ImGui.InputText("Housing Template Target (leave blank if not needed)", newHousingTemplateTarget, 100, ImGuiInputTextFlags.AutoSelectAll)
				
				
				if(newHousingTemplateTag ~= "") then
					if ImGui.Button(getLang("editor_Housing_template_test")) then 
						
						if(#currentItemSpawned > 0) then
							local toexport = {}
							toexport.items = {}
							
							
							for i=1,#currentItemSpawned do
								
								local obj = {}
								obj.Id = currentItemSpawned[i].Id
								obj.Tag = currentItemSpawned[i].Tag
								obj.HouseTag = currentItemSpawned[i].HouseTag
								obj.ItemPath = currentItemSpawned[i].ItemPath
								obj.X = currentItemSpawned[i].X - currentHouseCenter.x
								obj.Y = currentItemSpawned[i].Y - currentHouseCenter.y
								obj.Z = currentItemSpawned[i].Z - currentHouseCenter.z
								obj.Yaw = currentItemSpawned[i].Yaw
								obj.Pitch = currentItemSpawned[i].Pitch
								obj.Roll = currentItemSpawned[i].Roll
								obj.Title = currentItemSpawned[i].Title
								obj.scale = currentItemSpawned[i].scale
								obj.defaultScale = currentItemSpawned[i].defaultScale
								table.insert(toexport.items,obj)
								deleteHousing(currentItemSpawned[i].Id)
							end
							
							toexport.center = currentHouseCenter
							toexport.tag = newHousingTemplateTag
							toexport.name = newHousingTemplateName
							toexport.price = newHousingTemplatePrice
							toexport.desc = newHousingTemplateDescription
							toexport.target = newHousingTemplateTarget
							
							despawnItemFromHouse()
							
							if(#toexport.items > 0) then
								
								
								
								
								for i,v in ipairs(toexport.items) do
									
									local obj = {}
									obj.Id = v.Id
									obj.Tag = v.Tag
									obj.HouseTag = currentHouse.tag
									obj.ItemPath = v.ItemPath
									obj.X = currentHouseCenter.x +v.X
									obj.Y = currentHouseCenter.y + v.Y
									obj.Z = currentHouseCenter.z + v.Z
									obj.Yaw = v.Yaw
									obj.Pitch = v.Pitch
									obj.Roll = v.Roll
									obj.Title = v.Title
									obj.fromTemplate = true
									obj.scale = v.scale
									obj.defaultScale = v.defaultScale
									
									saveHousing(obj)
									
									local housing = getHousing(obj.Tag,obj.X,obj.Y,obj.Z)
									obj.Id = housing.Id
									
									local poss = Vector4.new( obj.X, obj.Y,  obj.Z,1)
									
									
									local angless = EulerAngles.new(obj.Roll, obj.Pitch,  obj.Yaw)
									
									
									obj.entityId = spawnItem(obj, poss, angless)
									local entity = Game.FindEntityByID(obj.entityId)
									local components = checkForValidComponents(entity)
									if components then
										local visualScale = checkDefaultScale(components)
										obj.defaultScale = {
											x = visualScale.x * 100,
											y = visualScale.x * 100,
											z = visualScale.x * 100,
										}
										if obj.scale and obj.scale ~= "nil" then
											setItemScale(entity,obj, obj.scale)
											else
											obj.scale = {
												x = components[1].visualScale.x * 100,
												y = components[1].visualScale.y * 100,
												z = components[1].visualScale.z * 100,
											}
										end
									end
									
									table.insert(currentItemSpawned,obj)
									
								end
								
								
							end
							
							
							arrayHousingTemplate[newHousingTemplateTag] = {}
							arrayHousingTemplate[newHousingTemplateTag].template = toexport
							currentHousingTemplate = toexport
							currentHousingTemplatetag=toexport.tag
							
						end
						
					end
					
					
					if ImGui.Button(getLang("editor_Housing_template_export")) then 
						
						
						if(#currentItemSpawned > 0) then
							local toexport = {}
							toexport.items = {}
							
							
							for i=1,#currentItemSpawned do
								
								local obj = {}
								obj.Id = currentItemSpawned[i].Id
								obj.Tag = currentItemSpawned[i].Tag
								obj.HouseTag = currentItemSpawned[i].HouseTag
								obj.ItemPath = currentItemSpawned[i].ItemPath
								obj.X = currentItemSpawned[i].X - currentHouseCenter.x
								obj.Y = currentItemSpawned[i].Y - currentHouseCenter.y
								obj.Z = currentItemSpawned[i].Z - currentHouseCenter.z
								obj.Yaw = currentItemSpawned[i].Yaw
								obj.Pitch = currentItemSpawned[i].Pitch
								obj.Roll = currentItemSpawned[i].Roll
								obj.Title = currentItemSpawned[i].Title
								obj.scale = currentItemSpawned[i].scale
								obj.defaultScale = currentItemSpawned[i].defaultScale
								table.insert(toexport.items,obj)
								
							end
							
							toexport.center = currentHouseCenter
							toexport.tag = newHousingTemplateTag
							toexport.name = newHousingTemplateName
							toexport.price = newHousingTemplatePrice
							toexport.desc = newHousingTemplateDescription
							toexport.target = newHousingTemplateTarget
							
							local file = assert(io.open("json/report/"..activeEditedPlace.tag.."_housing_template.json", "w"))
							local stringg = JSON:encode_pretty(toexport)
							--debug--debugPrint(2,stringg)
							file:write(stringg)
							file:close()
						end
						
					end
					
					
					if ImGui.Button(getLang("editor_Housing_template_save")) then 
						
						
						if(#currentItemSpawned > 0) then
							local toexport = {}
							toexport.items = {}
							
							
							for i=1,#currentItemSpawned do
								
								local obj = {}
								obj.Id = currentItemSpawned[i].Id
								obj.Tag = currentItemSpawned[i].Tag
								obj.HouseTag = currentItemSpawned[i].HouseTag
								obj.ItemPath = currentItemSpawned[i].ItemPath
								obj.X = currentItemSpawned[i].X - currentHouseCenter.x
								obj.Y = currentItemSpawned[i].Y - currentHouseCenter.y
								obj.Z = currentItemSpawned[i].Z - currentHouseCenter.z
								obj.Yaw = currentItemSpawned[i].Yaw
								obj.Pitch = currentItemSpawned[i].Pitch
								obj.Roll = currentItemSpawned[i].Roll
								obj.Title = currentItemSpawned[i].Title
								obj.scale = currentItemSpawned[i].scale
								obj.defaultScale = currentItemSpawned[i].defaultScale
								table.insert(toexport.items,obj)
								
							end
							
							toexport.center = currentHouseCenter
							toexport.tag = newHousingTemplateTag
							toexport.name = newHousingTemplateName
							toexport.price = newHousingTemplatePrice
							toexport.desc = newHousingTemplateDescription
							toexport.target = newHousingTemplateTarget
							
							
							
							if(#myDatapackHousingTemplate > 0) then
								
								local exist = false
								
								for i=1,#myDatapackHousingTemplate do
									if(myDatapackHousingTemplate[i].tag == toexport.tag) then
										
										myDatapackHousingTemplate[i] =toexport
										exist = true
										
									end
								end
								
								
								if(exist == false)then
									table.insert(myDatapackHousingTemplate, toexport)
								end
								
								else
								table.insert(myDatapackHousingTemplate, toexport)
							end
						end
						
					end
					
				end
				
				if ImGui.BeginCombo(getLang("editor_Housing_load_template"), currentHousingTemplatetag) then -- Remove the ## if you'd like for the title to display above combo box
					
					
					
					for k,v in pairs(arrayHousingTemplate) do
						
						if ImGui.Selectable(k, false) then
							
							
							currentHousingTemplate = v.template
							currentHousingTemplatetag=k
							newHousingTemplateTag = k
							if(v.template.name == nil) then v.template.name = "" end
							newHousingTemplateName = tostring(v.template.name)
							if(v.template.price == nil) then v.template.price = 0 end
							newHousingTemplatePrice =  tonumber(v.template.price)
							if(v.template.desc == nil) then v.template.desc = "" end
							newHousingTemplateDescription =  tostring(v.template.desc)
							if(v.template.target == nil) then v.template.target = "" end
							newHousingTemplateTarget =  tostring(v.template.target)
							ImGui.SetItemDefaultFocus()
						end
						
						
						
						
					end
					
					
					ImGui.EndCombo()
				end
				
				if(currentHousingTemplate ~= nil) then
					if ImGui.Button(getLang("editor_Housing_apply_template")) then 
						
						
						if(#currentHousingTemplate.items > 0) then
							
							
							
							
							for i,v in ipairs(currentHousingTemplate.items) do
								
								local obj = {}
								obj.Id = v.Id
								obj.Tag = v.Tag
								obj.HouseTag = currentHouse.tag
								obj.ItemPath = v.ItemPath
								obj.X = currentHouseCenter.x +v.X
								obj.Y = currentHouseCenter.y + v.Y
								obj.Z = currentHouseCenter.z + v.Z
								obj.Yaw = v.Yaw
								obj.Pitch = v.Pitch
								obj.Roll = v.Roll
								obj.Title = v.Title
								obj.fromTemplate = true
								obj.template = currentHousingTemplate.tag
								
								saveHousing(obj)
								
								local housing = getHousing(obj.Tag,obj.X,obj.Y,obj.Z)
								obj.Id = housing.Id
								
								local poss = Vector4.new( obj.X, obj.Y,  obj.Z,1)
								
								
								local angless = EulerAngles.new(obj.Roll, obj.Pitch,  obj.Yaw)
								
								
								obj.entityId = spawnItem(obj, poss, angless)
								
								Cron.After(0.5, function(obj)
									
									local entity = Game.FindEntityByID(obj.entityId)
									
									
									
									local components = checkForValidComponents(entity)
									if components then
										local visualScale = checkDefaultScale(components)
										obj.defaultScale = {
											x = visualScale.x * 100,
											y = visualScale.x * 100,
											z = visualScale.x * 100,
										}
										if obj.scale and obj.scale ~= "nil" then
											setItemScale(entity,obj, obj.scale)
											else
											obj.scale = {
												x = components[1].visualScale.x * 100,
												y = components[1].visualScale.y * 100,
												z = components[1].visualScale.z * 100,
											}
										end
									end
								end)
								table.insert(currentItemSpawned,obj)
								
							end
							
							
						end
						
					end
					
					if ImGui.Button(getLang("editor_Housing_edit_template")) then 
						openEditHousingTemplate = true
					end
					if ImGui.Button(getLang("editor_Housing_clear_template")) then 
						
						currentHousingTemplate = nil
						if(#currentItemSpawned > 0) then
							
							for i=1,#currentItemSpawned do
								
								if(currentItemSpawned[i].fromTemplate ~= nil and currentItemSpawned[i].fromTemplate == true) then
									deleteHousing(currentItemSpawned[i].Id)
									despawnItemFromId(currentItemSpawned[i].Id)
									
								end
								
								
							end
							
							
						end
						
						
					end
					
					
				end
				
			end
			
			if ImGui.Button(getLang("editor_Housing_clear_all"), 300, 0) then
				if(#currentItemSpawned > 0) then
					
					
					for i=1,#currentItemSpawned do
						
						deleteHousing(currentItemSpawned[i].Id)
						
						
					end
					
					despawnItemFromHouse()
				end
			end	
			
			ImGui.Spacing()
			ImGui.Separator()
			
			if(ActualPlayerMultiData ~= nil and #ActualPlayerMultiData.currentPlaces > 0 and ActualPlayerMultiData.instance.CanBuild == true) then
				
				ImGui.Text("Multiplayer Place : ".. ActualPlayerMultiData.currentPlaces[1].name)
				
				if(currentHouseCenter ~= nil) then
					
					
					if(currentHousingTemplate ~= nil) then
						if ImGui.Button(getLang("editor_Housing_apply_template_multi")) then 
							
							
							if(#currentHousingTemplate.items > 0) then
								
								local itemlist = {}
								
								
								for i,v in ipairs(currentHousingTemplate.items) do
									
									local obj = {}
									obj.Id = 0
									obj.HouseId = 0
									obj.Tag = v.Tag
									obj.HouseTag = ActualPlayerMultiData.currentPlaces[1].tag
									obj.ItemPath = v.ItemPath
									obj.X = currentHouseCenter.x +v.X
									obj.Y = currentHouseCenter.y + v.Y
									obj.Z = currentHouseCenter.z + v.Z
									obj.Yaw = v.Yaw
									obj.Pitch = v.Pitch
									obj.Roll = v.Roll
									obj.Title = v.Title
									
									table.insert(itemlist,obj)
									
									
									
								end
								
								
								SetItemList(itemlist)
								
							end
							
						end
						
						if ImGui.Button(getLang("editor_Housing_clear_all_multi"), 300, 0) then
							DeleteAllItem(ActualPlayerMultiData.currentPlaces[1].tag)
						end	
						
						
					end
					
				end
				
				
				ImGui.Spacing()
				ImGui.Separator()
				
				
			end
			if ImGui.Button(getLang("editor_open_json_editor")) and #currentItemSpawned > 0 then
				local toexport = {}
				
				
				
				for i=1,#currentItemSpawned do
					
					local obj = {}
					obj.Id = currentItemSpawned[i].Id
					obj.Tag = currentItemSpawned[i].Tag
					obj.HouseTag = currentItemSpawned[i].HouseTag
					obj.ItemPath = currentItemSpawned[i].ItemPath
					obj.X = currentItemSpawned[i].X
					obj.Y = currentItemSpawned[i].Y
					obj.Z = currentItemSpawned[i].Z
					obj.Yaw = currentItemSpawned[i].Yaw
					obj.Pitch = currentItemSpawned[i].Pitch
					obj.Roll = currentItemSpawned[i].Roll
					obj.Title = currentItemSpawned[i].Title
					table.insert(toexport,obj)
					
				end
				editor_json_tag = "housing_"..currentHouse.tag
				editor_json = JSON:encode_pretty(toexport)
				editor_json_obj = toexport
				editor_json_obj_name = "toexport"
				editor_json_view = true
				
				
			end
			
		end	
		
		
		ImGui.EndTabItem()
		
		
	end
end


function InterfacesTabs()
	if(activeEditedInterfaces.tag == nil) then
		activeEditedInterfaces.title = ""
		activeEditedInterfaces.tag = ""
		activeEditedInterfaces.width = 0
		activeEditedInterfaces.heigh = 0
		activeEditedInterfaces.x = 0
		activeEditedInterfaces.y = 0
		
		activeEditedInterfaces["controls"] = {}
		
		
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Interfaces")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), LoadInterfacetag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayInterfaces) do
				
				if ImGui.Selectable(k, false) then
					
					
					LoadInterface = v
					LoadInterfacetag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedInterfaces = LoadInterface.ui
			
			if(activeEditedInterfaces.tag == nil) then
				activeEditedInterfaces.title = ""
				activeEditedInterfaces.tag = ""
				activeEditedInterfaces.width = 0
				activeEditedInterfaces.heigh = 0
				activeEditedInterfaces.x = 0
				activeEditedInterfaces.y = 0
				
				activeEditedInterfaces["controls"] = {}
				
				
			end
			
		end
		
		
		
		if(LoadInterface.ui ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				LoadInterface = {}
				LoadInterfacetag = ""
				activeEditedInterfaces = {}
				
				
				if(activeEditedInterfaces.tag == nil) then
					activeEditedInterfaces.title = ""
					activeEditedInterfaces.tag = ""
					activeEditedInterfaces.width = 0
					activeEditedInterfaces.heigh = 0
					activeEditedInterfaces.x = 0
					activeEditedInterfaces.y = 0
					
					activeEditedInterfaces["controls"] = {}
					
					
				end
				
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedInterfaces.title = ImGui.InputText(getLang("editor_title"), activeEditedInterfaces.title, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedInterfaces.tag = ImGui.InputText(getLang("editor_tag"), activeEditedInterfaces.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedInterfaces.width = ImGui.InputFloat(getLang("editor_Interfaces_Width"), activeEditedInterfaces.width, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedInterfaces.heigh = ImGui.InputFloat(getLang("editor_Interfaces_Heigh"), activeEditedInterfaces.heigh, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedInterfaces.x = ImGui.InputFloat(getLang("editor_x"), activeEditedInterfaces.x, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedInterfaces.y = ImGui.InputFloat(getLang("editor_y"), activeEditedInterfaces.y, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		controlsNode(getLang("editor_Interfaces_Controls"),getLang("editor_Interfaces_Controls_msg"),activeEditedInterfaces,"controls")
		
		
		if(activeEditedInterfaces.tag ~= nil and activeEditedTheme.tag ~= "")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackInterfaces,activeEditedInterfaces)
				
				
			end
			ImGui.SameLine()
			
			
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedInterfaces.tag ~= "" then
				
				openInterface = false
				currentInterface = activeEditedInterfaces
				openInterface = true
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedInterfaces.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedInterfaces.tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedInterfaces)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditedInterfaces.tag ~= "" then
			
			editor_json_tag =  activeEditedInterfaces.tag
			editor_json = JSON:encode_pretty(activeEditedInterfaces)
			editor_json_obj = activeEditedInterfaces
			editor_json_obj_name = "activeEditedInterfaces"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
		
		
	end
	
	
end

function HelpTabs()
	if(activeEditHelp.tag == nil) then
		activeEditHelp.title = ""
		activeEditHelp.tag = ""
		activeEditHelp["section"] = {}
		
		
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Help")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadHelptag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(arrayHelp) do
				
				if ImGui.Selectable(v.tag, false) then
					
					
					loadHelp = v
					loadHelptag=v.tag
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditHelp = loadHelp
			
			if(activeEditHelp.tag == nil) then
				activeEditHelp.title = ""
				activeEditHelp.tag = ""
				activeEditHelp["section"] = {}
				
			end
			
		end
		
		if(loadHelp.tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadHelp = {}
				loadHelptag = ""
				activeEditHelp = {}
				
				
			end
			
		end
		
		
		activeEditHelp.title = ImGui.InputText(getLang("editor_title"), activeEditHelp.title, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditHelp.tag = ImGui.InputText(getLang("editor_tag"), activeEditHelp.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		listStringNode(getLang("editor_Help_Sections"),getLang("editor_Help_Sections_msg"),activeEditHelp,"section",true)
		
		
		
		
		if(activeEditHelp.title ~= nil and activeEditHelp.title ~= "" and #activeEditHelp["section"] > 0)then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackHelp,activeEditHelp)
				
				
			end
			
			ImGui.SameLine()
			
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditHelp.tag ~= "" then
				
				
				table.insert(arrayHelp,activeEditHelp)
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) then
				
				
				local file = assert(io.open("json/report/"..activeEditHelp.tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditHelp)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			else
			ImGui.Text("You need an Tag, an Title and at least one section before testing or export !")
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditHelp.tag ~= "" then
			
			editor_json_tag =  activeEditHelp.tag
			editor_json = JSON:encode_pretty(activeEditHelp)
			editor_json_obj = activeEditHelp
			editor_json_obj_name = "activeEditHelp"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
		
		
	end
	
end

function PlaceTabs()
	
	if(activeEditedPlace.tag == nil) then
		activeEditedPlace.name = ""
		activeEditedPlace.tag = ""
		activeEditedPlace.posX = 0
		activeEditedPlace.posY = 0
		activeEditedPlace.posZ = 0
		activeEditedPlace.range = 0
		activeEditedPlace.Zrange = 0
		activeEditedPlace.EnterX = 0
		activeEditedPlace.EnterY = 0
		activeEditedPlace.EnterZ = 0
		activeEditedPlace.ExitX = 0
		activeEditedPlace.ExitY = 0
		activeEditedPlace.ExitZ = 0
		activeEditedPlace.type = 0
		activeEditedPlace.coef = 0
		activeEditedPlace.isbuyable = false
		activeEditedPlace.price = 0
		activeEditedPlace.isrentable = false
		activeEditedPlace.rent = 0
		activeEditedPlace["rooms"] = {}
		activeEditedPlace["trigger"] = {}
		activeEditedPlace["requirement"] = {}
		activeEditedPlace["action"] = {}
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Place")) then
		
		
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadPlacetag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayHouse) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadPlace = v.house
					loadPlacetag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		ImGui.SameLine()
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedPlace = loadPlace
			
			if(activeEditedPlace == nil) then
				activeEditedPlace.name = ""
				activeEditedPlace.tag = ""
				activeEditedPlace.posX = 0
				activeEditedPlace.posY = 0
				activeEditedPlace.posZ = 0
				activeEditedPlace.range = 0
				activeEditedPlace.Zrange = 0
				activeEditedPlace.EnterX = 0
				activeEditedPlace.EnterY = 0
				activeEditedPlace.EnterZ = 0
				activeEditedPlace.ExitX = 0
				activeEditedPlace.ExitY = 0
				activeEditedPlace.ExitZ = 0
				activeEditedPlace.type = 0
				activeEditedPlace.coef = 0
				activeEditedPlace.isbuyable = false
				activeEditedPlace.price = 0
				activeEditedPlace.isrentable = false
				activeEditedPlace.rent = 0
				activeEditedPlace["rooms"] = {}
				activeEditedPlace["trigger"] = {}
				activeEditedPlace["requirement"] = {}
				activeEditedPlace["action"] = {}
				
				ImGui.Text("Object not founded, default value is loaded")
				else
				
				ImGui.Text("Loaded !")
			end
			
		end
		
		
		if(loadPlace.tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadPlace = {}
				loadPlacetag = ""
				activeEditedPlace = {}
				
				if(activeEditedPlace == nil) then
					activeEditedPlace.name = ""
					activeEditedPlace.tag = ""
					activeEditedPlace.posX = 0
					activeEditedPlace.posY = 0
					activeEditedPlace.posZ = 0
					activeEditedPlace.range = 0
					activeEditedPlace.Zrange = 0
					activeEditedPlace.EnterX = 0
					activeEditedPlace.EnterY = 0
					activeEditedPlace.EnterZ = 0
					activeEditedPlace.ExitX = 0
					activeEditedPlace.ExitY = 0
					activeEditedPlace.ExitZ = 0
					activeEditedPlace.type = 0
					activeEditedPlace.coef = 0
					activeEditedPlace.isbuyable = false
					activeEditedPlace.price = 0
					activeEditedPlace.isrentable = false
					activeEditedPlace.rent = 0
					activeEditedPlace["rooms"] = {}
					activeEditedPlace["trigger"] = {}
					activeEditedPlace["requirement"] = {}
					activeEditedPlace["action"] = {}
					
					ImGui.Text("Object not founded, default value is loaded")
					else
					
					ImGui.Text("Loaded !")
				end
				
				
			end
			
		end
		
		if(currentHouse ~= nil) then
			
			if(ImGui.Button("Load the current place")) then
				
				local house = getHouseByTag(currentHouse.tag)
				
				
				
				
				
				if(house == nil) then
					activeEditedPlace.name = ""
					activeEditedPlace.tag = ""
					activeEditedPlace.posX = 0
					activeEditedPlace.posY = 0
					activeEditedPlace.posZ = 0
					activeEditedPlace.range = 0
					activeEditedPlace.Zrange = 0
					activeEditedPlace.EnterX = 0
					activeEditedPlace.EnterY = 0
					activeEditedPlace.EnterZ = 0
					activeEditedPlace.ExitX = 0
					activeEditedPlace.ExitY = 0
					activeEditedPlace.ExitZ = 0
					activeEditedPlace.type = 0
					activeEditedPlace.coef = 0
					activeEditedPlace.isbuyable = false
					activeEditedPlace.price = 0
					activeEditedPlace.isrentable = false
					activeEditedPlace.rent = 0
					activeEditedPlace["rooms"] = {}
					activeEditedPlace["trigger"] = {}
					activeEditedPlace["requirement"] = {}
					activeEditedPlace["action"] = {}
					
					ImGui.Text("Object not founded, default value is loaded")
					else
					
					
					for k,v in pairs(house) do
						
						activeEditedPlace[k] = v
						
					end
					
					
					ImGui.Text("Loaded !")
				end
				
			end
			
		end
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		activeEditedPlace.name = ImGui.InputText(getLang("editor_Name"), activeEditedPlace.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedPlace.tag = ImGui.InputText(getLang("editor_tag"), activeEditedPlace.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedPlace.posX = ImGui.InputFloat(getLang("editor_x"), activeEditedPlace.posX, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedPlace.posY = ImGui.InputFloat(getLang("editor_y"), activeEditedPlace.posY, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedPlace.posZ = ImGui.InputFloat(getLang("editor_z"), activeEditedPlace.posZ, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_copy_player_location"), 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			activeEditedPlace.posX = vec4.x
			activeEditedPlace.posY = vec4.y
			activeEditedPlace.posZ = vec4.z
			
			
		end
		
		
		activeEditedPlace.EnterX = ImGui.InputFloat(getLang("editor_Place_EnterX"), activeEditedPlace.EnterX, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedPlace.EnterY = ImGui.InputFloat(getLang("editor_Place_EnterY"), activeEditedPlace.EnterY, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedPlace.EnterZ = ImGui.InputFloat(getLang("editor_Place_EnterZ"), activeEditedPlace.EnterZ, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		
		if ImGui.Button(getLang("editor_Place_Enter_copy"), 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			activeEditedPlace.EnterX = vec4.x
			activeEditedPlace.EnterY = vec4.y
			activeEditedPlace.EnterZ = vec4.z
			
			
		end
		
		activeEditedPlace.ExitX = ImGui.InputFloat(getLang("editor_Place_ExitX"), activeEditedPlace.ExitX, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedPlace.ExitY = ImGui.InputFloat(getLang("editor_Place_ExitY"), activeEditedPlace.ExitY, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedPlace.ExitZ = ImGui.InputFloat(getLang("editor_Place_ExitZ"), activeEditedPlace.ExitZ, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		
		if ImGui.Button(getLang("editor_Place_Exit_copy"), 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			activeEditedPlace.ExitX = vec4.x
			activeEditedPlace.ExitY = vec4.y
			activeEditedPlace.ExitZ = vec4.z
			
			
		end
		
		ImGui.Spacing()
		activeEditedPlace.range = ImGui.InputFloat(getLang("editor_Place_range"), activeEditedPlace.range, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedPlace.Zrange = ImGui.InputFloat(getLang("editor_Place_Zrange"), activeEditedPlace.Zrange, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		
		if ImGui.BeginCombo("##My ComboBox2", placetype) then -- Remove the ## if you'd like for the title to display above combo box
			
			if ImGui.Selectable("House", (activeEditedPlace.type == 0)) then
				activeEditedPlace.type = 0
				placetype = "House"
				ImGui.SetItemDefaultFocus()
			end
			if ImGui.Selectable("Bar", (activeEditedPlace.type == 1)) then
				activeEditedPlace.type = 1
				placetype = "Bar"
				ImGui.SetItemDefaultFocus()
			end
			if ImGui.Selectable("Nightclub", (activeEditedPlace.type == 2)) then
				activeEditedPlace.type = 2
				placetype = "Nightclub"
				ImGui.SetItemDefaultFocus()
			end
			if ImGui.Selectable("Restaurant", (activeEditedPlace.type == 3)) then
				activeEditedPlace.type = 3
				placetype = "Restaurant"
				ImGui.SetItemDefaultFocus()
			end
			if ImGui.Selectable("Shop/Mall", (activeEditedPlace.type == 4)) then
				activeEditedPlace.type = 4
				placetype = "Shop/Mall"
				ImGui.SetItemDefaultFocus()
			end
			if ImGui.Selectable("Special", (activeEditedPlace.type == 5)) then
				activeEditedPlace.type = 5
				placetype = "Special"
				ImGui.SetItemDefaultFocus()
			end
			
			
			ImGui.EndCombo()
		end
		
		
		
		
		
		ImGui.Text(getLang("editor_Place_Coef_msg01"))
		ImGui.Text(getLang("editor_Place_Coef_msg02"))
		
		
		activeEditedPlace.coef = ImGui.InputFloat(getLang("editor_Place_Coef"), activeEditedPlace.coef, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedPlace.isbuyable = ImGui.Checkbox(getLang("editor_Place_isbuyable"), activeEditedPlace.isbuyable)
		if(activeEditedPlace.isbuyable == true) then
			
			activeEditedPlace.price = ImGui.InputFloat(getLang("editor_Place_price"), activeEditedPlace.price, 1, 10, "%.1f", ImGuiInputTextFlags.None)
			activeEditedPlace.isrentable = ImGui.Checkbox(getLang("editor_Place_isrentable"), activeEditedPlace.isbuyable)
			if(activeEditedPlace.isrentable == true) then
				ImGui.Text(getLang("editor_Place_isrentable_msg"))
				activeEditedPlace.rent = ImGui.InputFloat(getLang("editor_Place_rent"), activeEditedPlace.rent, 1, 10, "%.1f", ImGuiInputTextFlags.None)
				
			end
		end
		
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		RoomNode(activeEditedPlace)
		
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		triggerNode(getLang("trigger_condition"),activeEditedPlace,"trigger")
		
		
		
		
		if(tableHasKey(activeEditedPlace["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),activeEditedPlace,"requirement","trigger")
			
			if(#activeEditedPlace["requirement"] > 0) then
				actionNode(getLang("trigger_action"),activeEditedPlace,"action")
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
			
			
			
		end
		
		if(#activeEditedPlace["requirement"] > 0) then
			
			
			if(activeEditedPlace.tag ~= "" or activeEditedPlace.tag ~= nil) then
				
				
				
				
				
				
				
				
				if ImGui.Button(getLang("editor_save_for_build")) then
					
					
					
					table.insert(myDatapackPlace,activeEditedPlace)
					
					
				end
				
				ImGui.SameLine()
				
				if ImGui.Button(getLang("editor_test_in_game")) and activeEditedPlace.tag ~= "" then
					
					
					arrayHouse[activeEditedPlace.tag] = {}
					arrayHouse[activeEditedPlace.tag].house = activeEditedPlace
					arrayHouse[activeEditedPlace.tag].file = "editor"
					arrayHouse[activeEditedPlace.tag].datapack = "editor"
					
					
					
					
					
				end
				
				ImGui.SameLine()
				if ImGui.Button(getLang("editor_export")) and activeEditedPlace.tag ~= "" then
					
					
					local file = assert(io.open("json/report/"..activeEditedPlace.tag..".json", "w"))
					local stringg = JSON:encode_pretty(activeEditedPlace)
					--debug--debugPrint(2,stringg)
					file:write(stringg)
					file:close()
					
					
				end
				else
				
				ImGui.Text(getLang("editor_export_warning"))
				
			end
			
			else
			
			ImGui.Text(getLang("editor_Place_warning"))
			
		end
		
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditedPlace.tag ~= "" then
			
			editor_json_tag =  activeEditedPlace.tag
			editor_json = JSON:encode_pretty(activeEditedPlace)
			editor_json_obj = activeEditedPlace
			editor_json_obj_name = "activeEditedPlace"
			editor_json_view = true
			
			
		end
		
		
		
		ImGui.Text(getLang("editor_Place_msg01"))
		ImGui.Text(getLang("editor_Place_msg02"))
		ImGui.Text(getLang("editor_Place_msg03"))
		
		
		
		
		ImGui.EndTabItem()
	end
	
	
end

function FunctionTabs()
	
	
	if(activeEditedFunction.tag == nil) then
		activeEditedFunction.name = ""
		activeEditedFunction.tag = ""
		
		activeEditedFunction["action"] = {}
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Function")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadFunctiontag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayFunction) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadFunction = v
					loadFunctiontag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedFunction = loadFunction.func
			
			if(activeEditedFunction.tag == nil) then
				activeEditedFunction.name = ""
				activeEditedFunction.tag = ""
				
				activeEditedFunction["action"] = {}
				
				
			end
			
		end
		
		if(loadFunction.func ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadFunction = {}
				loadFunctiontag = ""
				activeEditedFunction = {}
				
				if(activeEditedFunction.tag == nil) then
					activeEditedFunction.name = ""
					activeEditedFunction.tag = ""
					
					activeEditedFunction["action"] = {}
					
					
				end
				
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedFunction.name = ImGui.InputText(getLang("editor_Name"), activeEditedFunction.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedFunction.tag = ImGui.InputText(getLang("editor_tag"), activeEditedFunction.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		actionNode(getLang("trigger_action"),activeEditedFunction,"action")
		
		
		
		if(activeEditedFunction.tag ~= nil and activeEditedFunction.tag ~= "")then
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackFunction,activeEditedFunction)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedFunction.tag ~= "" then
				
				arrayFunction[activeEditedFunction.tag] = {}
				arrayFunction[activeEditedFunction.tag].func = activeEditedFunction
				runActionList(activeEditedFunction.action, activeEditedFunction.tag,"interact",false,"player")
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedFunction.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedFunction.tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedFunction)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			
			ImGui.SameLine()
			if ImGui.Button("Dump") and activeEditedFunction.tag ~= "" then
				
				
				debugPrint(2,dump((activeEditedFunction)))
				
				
			end
			
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditedFunction.tag ~= "" then
			
			editor_json_tag =  activeEditedFunction.tag
			editor_json = JSON:encode_pretty(activeEditedFunction)
			editor_json_obj = activeEditedFunction
			editor_json_obj_name = "activeEditedFunction"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
	end
	
	
end	


function NodeSystemTabs()
	
	if ImGui.BeginTabItem("NodeSystemTabs") then
		
		if ImGui.BeginTabBar("NodeSystemTabsBar", ImGuiTabBarFlags.NoTooltip) then
			
			
			
			
			
			
			
			NodeTabs()
			
			CircuitTabs()
			
			PathTabs()
			
			POITabs()
			
			
			
			ImGui.EndTabBar()
		end
		
		ImGui.EndTabItem()
	end
end


function NodeTabs()
	
	
	if(activeEditedNode.tag == nil) then
		activeEditedNode.name = ""
		activeEditedNode.tag = ""
		activeEditedNode.sort = ""
		activeEditedNode.X = 0
		activeEditedNode.Y = 0
		activeEditedNode.Z = 0
		activeEditedNode.GameplayX = 0
		activeEditedNode.GameplayY = 0
		activeEditedNode.GameplayZ = 0
		
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_unload")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadNodetag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayNode) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadNode = v.node
					loadNodetag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedNode = loadNode
			
			if(activeEditedNode.tag == nil) then
				activeEditedNode.name = ""
				activeEditedNode.tag = ""
				activeEditedNode.sort = ""
				activeEditedNode.X = 0
				activeEditedNode.Y = 0
				activeEditedNode.Z = 0
				activeEditedNode.GameplayX = 0
				activeEditedNode.GameplayY = 0
				activeEditedNode.GameplayZ = 0
				
				
			end
			
		end
		
		if(loadNode.tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadNode = {}
				loadNodetag = ""
				activeEditedNode = {}
				
				
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		activeEditedNode.name = ImGui.InputText(getLang("editor_Name"), activeEditedNode.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedNode.tag = ImGui.InputText(getLang("editor_tag"), activeEditedNode.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Text(getLang("editor_Node_sort_msg"))
		activeEditedNode.sort = ImGui.InputText(getLang("editor_Node_sort"), activeEditedNode.sort, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Text(getLang("editor_Node_xyz_msg"))
		activeEditedNode.X = ImGui.InputFloat(getLang("editor_x"), activeEditedNode.X, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedNode.Y = ImGui.InputFloat(getLang("editor_y"), activeEditedNode.Y, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedNode.Z = ImGui.InputFloat(getLang("editor_z"), activeEditedNode.Z, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		
		if ImGui.Button(getLang("editor_copy_player_location"), 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			activeEditedNode.X = vec4.x
			activeEditedNode.Y = vec4.y
			activeEditedNode.Z = vec4.z
			
			
		end
		
		ImGui.Text(getLang("editor_Node_gameplayxyz_msg"))
		
		activeEditedNode.GameplayX = ImGui.InputFloat(getLang("editor_Node_gameplayx"), activeEditedNode.GameplayX, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedNode.GameplayY = ImGui.InputFloat(getLang("editor_Node_gameplayy"), activeEditedNode.GameplayY, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedNode.GameplayZ = ImGui.InputFloat(getLang("editor_Node_gameplayz"), activeEditedNode.GameplayZ, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		
		if ImGui.Button(getLang("editor_Node_gameplayxyz_copy"), 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			activeEditedNode.GameplayX = vec4.x
			activeEditedNode.GameplayY = vec4.y
			activeEditedNode.GameplayZ = vec4.z
			
			
		end
		
		if(activeEditedNode.tag ~= nil and activeEditedNode.tag ~= "")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackNode,activeEditedNode)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedNode.tag ~= "" then
				
				local testtemp = getNode(activeEditedNode.tag)
				
				if(activeEditedNode.tag == nil) then
					
					arrayNode[activeEditedNode.tag] = {}
					arrayNode[activeEditedNode.tag].node = activeEditedNode
					arrayNode[activeEditedNode.tag].file = "editor"
					arrayNode[activeEditedNode.tag].datapack = "editor"
					else
					
					testtemp = activeEditedNode
					
					
					
				end
				
				
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedNode.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedNode.tag..".json", "w"))
				local nodeTable = {}
				
				table.insert(nodeTable,activeEditedNode)
				
				local stringg = JSON:encode_pretty(nodeTable)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
				
			end
			
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditedNode.tag ~= "" then
			
			editor_json_tag =  activeEditedNode.tag
			editor_json = JSON:encode_pretty(activeEditedNode)
			editor_json_obj = activeEditedNode
			editor_json_obj_name = "activeEditedNode"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
	end
	
	
end	


function CircuitTabs()
	
	
	if(activeEditedCircuit.tag == nil) then
		
		activeEditedCircuit.tag = ""
		activeEditedCircuit["nodes"] = {}
		
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Circuit")) then
		
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadCircuittag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayCircuit) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadCircuit = v.circuit
					loadCircuittag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		
		
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedCircuit = loadCircuit
			
			if(activeEditedCircuit.tag == nil) then
				activeEditedCircuit["nodes"] = {}
				
				
			end
			
		end
		
		if(activeEditedCircuit.tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadCircuit = {}
				loadCircuittag = ""
				activeEditedCircuit = {}
				
				
				if(activeEditedCircuit.tag == nil) then
					activeEditedCircuit["nodes"] = {}
					
					
				end
				
			end
			
		end
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		
		activeEditedCircuit.tag = ImGui.InputText(getLang("editor_tag"), activeEditedCircuit.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		listStringNode(getLang("editor_Circuit_Nodes"),getLang("editor_Circuit_Nodes_msg"),activeEditedCircuit,"nodes")
		
		if(activeEditedCircuit.tag ~= nil and activeEditedCircuit.tag ~= "")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackCircuit,activeEditedCircuit)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedCircuit.tag ~= "" then
				
				local testtemp = getCircuit(activeEditedCircuit.tag)
				
				if(activeEditedNode.tag == nil) then
					
					arrayCircuit[activeEditedCircuit.tag] = {}
					arrayCircuit[activeEditedCircuit.tag].circuit = activeEditedCircuit
					arrayCircuit[activeEditedCircuit.tag].file = "editor"
					arrayCircuit[value.tag].datapack = "editor"
					else
					
					testtemp = activeEditedCircuit
					
					
					
				end
				
				
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedCircuit.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedCircuit.tag..".json", "w"))
				local nodeTable = {}
				
				table.insert(nodeTable,activeEditedCircuit)
				
				local stringg = JSON:encode_pretty(nodeTable)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
				
			end
			
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditedCircuit.tag ~= "" then
			
			editor_json_tag =  activeEditedCircuit.tag
			editor_json = JSON:encode_pretty(activeEditedCircuit)
			editor_json_obj = activeEditedCircuit
			editor_json_obj_name = "activeEditedCircuit"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
	end
	
	
end	



function PathTabs()
	
	
	if(activeEditedPath.tag == nil) then
		
		
		activeEditedPath.desc = ""
		activeEditedPath.tag = ""
		activeEditedPath.startNode = ""
		activeEditedPath.endNode = ""
		activeEditedPath.isFor = 4
		activeEditedPath.recordRotation = false
		activeEditedPath.recordRelative = false
		activeEditedPath["locations"] = {}
		
		
		
	end
	
	if editorPathTarget == nil then
		
		
		editorPathTarget = "player"
	end
	
	if ImGui.BeginTabItem(getLang("editor_Path")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadPathtag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayPath) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadPath = v.gamepath
					loadPathtag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedPath = loadPath
			
			if(activeEditedPath.tag == nil) then
				activeEditedPath.desc = ""
				activeEditedPath.tag = ""
				activeEditedPath.startNode = ""
				activeEditedPath.endNode = ""
				activeEditedPath.isFor = 4
				activeEditedPath.recordRotation = false
				activeEditedPath.recordRelative = false
				activeEditedPath["locations"] = {}
				
				else
				
				if(activeEditedPath.recordRotation == nil) then
					activeEditedPath.recordRotation = false
					
				end
				if(activeEditedPath.recordRelative == nil) then
					activeEditedPath.recordRelative = false
					
				end
			end
			
		end
		
		
		if(loadPath.tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadPath = {}
				loadPathtag = ""
				activeEditedPath = {}
				
				if(activeEditedPath.tag == nil) then
					activeEditedPath.desc = ""
					activeEditedPath.tag = ""
					activeEditedPath.startNode = ""
					activeEditedPath.endNode = ""
					activeEditedPath.isFor = 4
					activeEditedPath.recordRotation = false
					activeEditedPath.recordRelative = false
					
					activeEditedPath["locations"] = {}
					
					else
					
					if(activeEditedPath.recordRotation == nil) then
						activeEditedPath.recordRotation = false
					end
					
				end
				
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		
		activeEditedPath.desc = ImGui.InputText(getLang("editor_Name"), activeEditedPath.desc, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedPath.tag = ImGui.InputText(getLang("editor_tag"), activeEditedPath.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedPath.startNode = ImGui.InputText(getLang("editor_Path_StartNode"), activeEditedPath.startNode, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedPath.endNode = ImGui.InputText(getLang("editor_Path_EndNode"), activeEditedPath.endNode, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedPath.recordRotation = ImGui.Checkbox(getLang("editor_Path_recordRotation"), activeEditedPath.recordRotation)
		activeEditedPath.recordRelative = ImGui.Checkbox(getLang("editor_Path_recordRelative"), activeEditedPath.recordRelative)
		
		if ImGui.BeginTabBar("EditorTabs", ImGuiTabBarFlags.NoTooltip) then
			
			if ImGui.BeginTabItem(getLang("editor_Path_Record")) then
				if saveLocationEnabled == false then
					
					if ImGui.BeginCombo(getLang("editor_Path_RecordTarget"), recorderEntity) then
						
						
						for i,v in ipairs(recorderEntityList) do
							
							if ImGui.Selectable(v, (recorderEntity == v)) then
								
								recorderEntity = v
								
								ImGui.SetItemDefaultFocus()
							end
							
							
						end
						
						ImGui.EndCombo()
					end
					
					
					pathOffsetX = ImGui.DragFloat("##pathOffsetX", pathOffsetX, 0.01, -9999, 9999, "%.3f X Offset")
					pathOffsetY = ImGui.DragFloat("##pathOffsetY", pathOffsetY, 0.01, -9999, 9999, "%.3f Y Offset")
					pathOffsetZ = ImGui.DragFloat("##pathOffsetZ", pathOffsetZ, 0.01, -9999, 9999, "%.3f Z Offset")
					
					if(activeEditedPath.tag ~= nil and activeEditedPath.tag ~= "") then
						
						if ImGui.Button(getLang("editor_Path_RecordPath"))then
							Game.t1()
							recordRotation = activeEditedPath.recordRotation
							recordRelative = activeEditedPath.recordRelative
							recordInitialPosition = Game.GetPlayer():GetWorldPosition()
							tempLocation = {}
							saveLocationEnabled = true
							
							
							
						end
						
						
						else
						ImGui.Text(getLang("editor_Path_mgs"))
						
					end
					else
					if ImGui.Button(getLang("editor_Path_Record_Stop"))then
						saveLocationEnabled = false
						activeEditedPath["locations"] = tempLocation
						tempLocation = {}
						Game.t2()
					end
				end
				ImGui.EndTabItem()
			end
			
			if ImGui.BeginTabItem(getLang("editor_Path_Play")) then
				if(#activeEditedPath["locations"]>0) then
					
					
					
					
					
					if ImGui.BeginCombo(getLang("editor_Path_PlayTarget"), editorPathTarget) then
						
						
						for i,v in ipairs(pathPlayerEntityList) do
							
							if ImGui.Selectable(v, (editorPathTarget == v)) then
								
								editorPathTarget = v
								
								ImGui.SetItemDefaultFocus()
							end
							
							
						end
						
						ImGui.EndCombo()
					end
					
					editorPathTarget = ImGui.InputText(getLang("editor_Path_PlayTargetCustom"), editorPathTarget, 100, ImGuiInputTextFlags.AutoSelectAll)
					
					
					sliderPathTarget, used = ImGui.SliderInt(getLang("editor_Path_CurrentFrame"), sliderPathTarget, 1, #activeEditedPath["locations"], "%d")
					if used then
						local frame =activeEditedPath["locations"][sliderPathTarget]
						
						local poss = Vector4.new( frame.x, frame.y,  frame.z,1)
						
						local angless = EulerAngles.new(frame.roll, frame.pitch,  frame.yaw)
						
						local isplayer = false
						if editorPathTarget == "player" then
							isplayer = true
						end
						local obj = getEntityFromManager(editorPathTarget)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							teleportTo(enti, Vector4.new( poss.x, poss.y, poss.z,1), angless,isplayer)
						end
					end
					
					activeEditedPath["locations"][sliderPathTarget].x = ImGui.DragFloat("##locationX", activeEditedPath["locations"][sliderPathTarget].x, 0.001, -9999, 9999, "%.4f X ")
					activeEditedPath["locations"][sliderPathTarget].y = ImGui.DragFloat("##locationY", activeEditedPath["locations"][sliderPathTarget].y, 0.001, -9999, 9999, "%.4f Y ")
					activeEditedPath["locations"][sliderPathTarget].z = ImGui.DragFloat("##locationZ", activeEditedPath["locations"][sliderPathTarget].z, 0.001, -9999, 9999, "%.4f Z ")
					activeEditedPath["locations"][sliderPathTarget].yaw = ImGui.DragFloat("##locationYaw", activeEditedPath["locations"][sliderPathTarget].yaw, 0.001, -9999, 9999, "%.4f YAW ")
					activeEditedPath["locations"][sliderPathTarget].pitch = ImGui.DragFloat("##locationPitch", activeEditedPath["locations"][sliderPathTarget].pitch, 0.001, -9999, 9999, "%.4f PITCH ")
					activeEditedPath["locations"][sliderPathTarget].roll = ImGui.DragFloat("##locationRoll", activeEditedPath["locations"][sliderPathTarget].roll, 0.001, -9999, 9999, "%.4f Roll ")
					
					
					
					if ImGui.Button(getLang("editor_Path_DeleteFrame")..sliderPathTarget)then
						table.remove(activeEditedPath["locations"],sliderPathTarget)
						sliderPathTarget = sliderPathTarget - 1
						if(sliderPathTarget <= 0) then sliderPathTarget = 1 end
					end
					
					if ImGui.Button(getLang("editor_Path_CopyFrameBefore"))then
						table.insert(activeEditedPath["locations"],sliderPathTarget-1,activeEditedPath["locations"][sliderPathTarget])
						sliderPathTarget = sliderPathTarget - 1
					end
					
					if ImGui.Button(getLang("editor_Path_CopyFrameAfter"))then
						table.insert(activeEditedPath["locations"],sliderPathTarget+1,activeEditedPath["locations"][sliderPathTarget])
						sliderPathTarget = sliderPathTarget + 1
					end
					
					if(activeEditedPath["locations"][sliderPathTarget]["action"] == nil) then
						activeEditedPath["locations"][sliderPathTarget]["action"] = {}
					end
					
					actionNode(getLang("editor_Path_CurrentFrameAction"),activeEditedPath["locations"][sliderPathTarget],"action")
					
					
					
					if ImGui.Button(getLang("editor_Path_PlayPath"))then
						arrayPath[activeEditedPath.tag] = {}
						arrayPath[activeEditedPath.tag].gamepath = activeEditedPath
						arrayPath[activeEditedPath.tag].file = path
						arrayPath[activeEditedPath.tag].datapack = datapackname
						debugPrint(10,editorPathTarget)
						local actionlist = {}
						local action = {}
						
						
						action.name = "play_path"
						action.path = activeEditedPath.tag
						action.tag = editorPathTarget
						action.isrelative = activeEditedPath.recordRelative
						action.zoffset = 0
						table.insert(actionlist,action)
						spdlog.error(dump(actionlist))
						runActionList(actionlist, "play_path_"..math.random(1,99999), tag,source,false,executortag)
					end
					
					else
					
					ImGui.Text(getLang("editor_Path_NoRecord"))
					
				end
				ImGui.EndTabItem()
			end		
			
			ImGui.EndTabBar()
		end
		
		
		
		if(activeEditedPath.tag ~= nil and activeEditedPath.tag ~= "")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackPath,activeEditedPath)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedPath.tag ~= "" then
				
				arrayPath[activeEditedPath.tag] = {}
				arrayPath[activeEditedPath.tag].gamepath = activeEditedPath
				arrayPath[activeEditedPath.tag].file = path
				arrayPath[activeEditedPath.tag].datapack = datapackname
				
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedPath.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedPath.tag..".json", "w"))
				local nodeTable = {}
				
				
				
				local stringg = JSON:encode_pretty(activeEditedPath)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
				
			end
			
			else
			ImGui.Text(getLang("editor_export_warning"))
		end
		
		ImGui.Spacing()
		
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditedPath.tag ~= "" then
			
			editor_json_tag =  activeEditedPath.tag
			editor_json = JSON:encode_pretty(activeEditedPath)
			editor_json_obj = activeEditedPath
			editor_json_obj_name = "activeEditedPath"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
	end
	
	
end	


function POITabs()
	
	
	if(activeEditedPOI.desc == nil) then
		
		
		activeEditedPOI.desc = ""
		activeEditedPOI.tag = ""
		activeEditedPOI.isFor = 1
		activeEditedPOI["locations"] = {}
		
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_POI")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), LoadPOItag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayPOI) do
				
				if(v.poi.tag == nil) then
					
					
					else
					if ImGui.Selectable(k, false) then
						
						
						loadPOI = v.poi
						LoadPOItag=k
						
						ImGui.SetItemDefaultFocus()
					end
				end
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedPOI = loadPOI
			
			if(activeEditedPOI.desc == nil) then
				activeEditedPOI.desc = ""
				activeEditedPOI.tag = ""
				activeEditedPOI.isFor = 1
				activeEditedPOI["locations"] = {}
				
				
			end
			
		end
		
		
		if(loadPOI.desc ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadPOI = {}
				loadPOItag = ""
				activeEditedPOI = {}
				
				if(activeEditedPOI.tag == nil) then
					activeEditedPOI.desc = ""
					activeEditedPOI.tag = ""
					activeEditedPOI.isFor = 1
					activeEditedPOI["locations"] = {}
					
					
				end
				
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		
		activeEditedPOI.desc = ImGui.InputText(getLang("editor_Name"), activeEditedPOI.desc, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedPOI.tag = ImGui.InputText(getLang("editor_tag"), activeEditedPOI.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		activeEditedPOI.isFor = ImGui.InputInt(getLang("editor_POI_isFor"),activeEditedPOI.isFor, 1, 10, ImGuiInputTextFlags.None)
		
		
		listLocationsNode(getLang("editor_POI_locations"),"locations list",activeEditedPOI,"locations")
		
		if(activeEditedPOI.tag ~= nil and activeEditedPOI.tag ~= "" and activeEditedPOI.tag ~= "OBSOLETE")then
			
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackPOI,activeEditedPOI)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedPOI.tag ~= "" then
				
				local testtemp = getPOI(activeEditedPOI.tag)
				
				if(activeEditedPOI.tag == nil) then
					table.insert(arrayPOI, activeEditedPOI)
					
					else
					
					testtemp = activeEditedPOI
					
					
					
				end
				
				
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedPOI.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedPOI.tag..".json", "w"))
				local nodeTable = {}
				
				
				
				local stringg = JSON:encode_pretty(activeEditedPOI)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
				
			end
			
			else
			ImGui.Text("You need an Tag before testing or export ! ")
			if(activeEditedPOI.tag == "OBSOLETE")then
				ImGui.Text("This POI is OBSOLETE")
			end
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditedPOI.tag ~= "" then
			
			editor_json_tag =  activeEditedPOI.tag
			editor_json = JSON:encode_pretty(activeEditedPOI)
			editor_json_obj = activeEditedPOI
			editor_json_obj_name = "activeEditedPOI"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
	end
	
	
end	

function CustomNPCTabs()
	
	
	if(activeEditedCustomNPC.tag == nil) then
		activeEditedCustomNPC.name = ""
		activeEditedCustomNPC.tag = ""
		activeEditedCustomNPC.tweakDB = ""
		activeEditedCustomNPC.appeareance = ""
		activeEditedCustomNPC.repeat_routine = true
		activeEditedCustomNPC.auto_despawn = true
		activeEditedCustomNPC.useBetaSpawn = false
		activeEditedCustomNPC.location = {}
		activeEditedCustomNPC.location.x = 0
		activeEditedCustomNPC.location.y = 0
		activeEditedCustomNPC.location.z = 0
		activeEditedCustomNPC.location.radius = 0
		activeEditedCustomNPC.triggers = {}
		activeEditedCustomNPC.requirement = {}
		
		activeEditedCustomNPC["routineaction"] = {}
		activeEditedCustomNPC["spawnaction"] = {}
		activeEditedCustomNPC["despawnaction"] = {}
		activeEditedCustomNPC["deathaction"] = {}
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_CustomNPC")) then
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadCustomNPCtag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayCustomNPC) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadCustomNPC = v.npc
					loadCustomNPCtag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedCustomNPC = loadCustomNPC
			
			if(activeEditedCustomNPC.tag == nil) then
				activeEditedCustomNPC.name = ""
				activeEditedCustomNPC.tag = ""
				activeEditedCustomNPC.tweakDB = ""
				activeEditedCustomNPC.appeareance = ""
				activeEditedCustomNPC.repeat_routine = true
				activeEditedCustomNPC.auto_despawn = true
				activeEditedCustomNPC.useBetaSpawn = false
				activeEditedCustomNPC.location = {}
				activeEditedCustomNPC.location.x = 0
				activeEditedCustomNPC.location.y = 0
				activeEditedCustomNPC.location.z = 0
				activeEditedCustomNPC.location.radius = 0
				activeEditedCustomNPC.triggers = {}
				activeEditedCustomNPC.requirement = {}
				
				activeEditedCustomNPC["routineaction"] = {}
				activeEditedCustomNPC["spawnaction"] = {}
				activeEditedCustomNPC["despawnaction"] = {}
				activeEditedCustomNPC["deathaction"] = {}
				
				
			end
			
		end
		
		
		
		if(loadCustomNPC.tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadCustomNPC = {}
				loadCustomNPCtag = ""
				activeEditedCustomNPC = {}
				if(activeEditedCustomNPC.tag == nil) then
					activeEditedCustomNPC.name = ""
					activeEditedCustomNPC.tag = ""
					activeEditedCustomNPC.tweakDB = ""
					activeEditedCustomNPC.appeareance = ""
					activeEditedCustomNPC.repeat_routine = true
					activeEditedCustomNPC.auto_despawn = true
					activeEditedCustomNPC.useBetaSpawn = false
					activeEditedCustomNPC.location = {}
					activeEditedCustomNPC.location.x = 0
					activeEditedCustomNPC.location.y = 0
					activeEditedCustomNPC.location.z = 0
					activeEditedCustomNPC.location.radius = 0
					activeEditedCustomNPC.triggers = {}
					activeEditedCustomNPC.requirement = {}
					
					activeEditedCustomNPC["routineaction"] = {}
					activeEditedCustomNPC["spawnaction"] = {}
					activeEditedCustomNPC["despawnaction"] = {}
					activeEditedCustomNPC["deathaction"] = {}
					
					
				end
				
			end
			
		end
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedCustomNPC.name = ImGui.InputText(getLang("editor_Name"), activeEditedCustomNPC.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedCustomNPC.tag = ImGui.InputText(getLang("editor_tag"), activeEditedCustomNPC.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		
		if ImGui.BeginCombo("TweakDB", npcchara) then
			
			
			for i,v in ipairs(arrayPnjDb) do
				
				if ImGui.Selectable(v.Names, (activeEditedFixer.NPCId  == v.TweakIDs)) then
					activeEditedCustomNPC.tweakDB  = v.TweakIDs
					npcchara = v.Names
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		activeEditedCustomNPC.appeareance = ImGui.InputText(getLang("editor_CustomNPC_appeareance"), activeEditedCustomNPC.appeareance, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedCustomNPC.repeat_routine = ImGui.Checkbox(getLang("editor_CustomNPC_repeat_routine"), activeEditedCustomNPC.repeat_routine)
		
		activeEditedCustomNPC.auto_despawn = ImGui.Checkbox(getLang("editor_CustomNPC_auto_despawn"), activeEditedCustomNPC.auto_despawn)
		
		activeEditedCustomNPC.useBetaSpawn = ImGui.Checkbox(getLang("editor_CustomNPC_useBetaSpawn"), activeEditedCustomNPC.useBetaSpawn)
		
		activeEditedCustomNPC.location.x = ImGui.InputFloat(getLang("editor_x"), activeEditedCustomNPC.location.x, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedCustomNPC.location.y = ImGui.InputFloat(getLang("editor_y"), activeEditedCustomNPC.location.y, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedCustomNPC.location.z = ImGui.InputFloat(getLang("editor_z"), activeEditedCustomNPC.location.z, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		activeEditedCustomNPC.location.radius = ImGui.InputFloat(getLang("editor_range"), activeEditedCustomNPC.location.radius, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		
		if ImGui.Button(getLang("editor_copy_player_location"), 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			
			activeEditedCustomNPC.location.x =  vec4.x
			activeEditedCustomNPC.location.y =  vec4.y
			activeEditedCustomNPC.location.z =  vec4.z
			
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		triggerNode(getLang("trigger_condition"),activeEditedCustomNPC,"triggers")
		
		
		
		
		if(tableHasKey(activeEditedCustomNPC["triggers"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),activeEditedCustomNPC,"requirement","triggers")
			
			if(#activeEditedCustomNPC["requirement"] > 0) then
				actionNode("Spawn Action :",activeEditedCustomNPC,"spawnaction")
				
				actionNode("Routine Action :",activeEditedCustomNPC,"routineaction")
				
				actionNode("Death Action :",activeEditedCustomNPC,"deathaction")
				
				actionNode("Despawn Action :",activeEditedCustomNPC,"despawnaction")
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
			
			
			
		end
		
		
		
		
		
		
		
		if((#activeEditedCustomNPC["requirement"] > 0) and activeEditedCustomNPC.tag ~= nil and activeEditedCustomNPC.tag ~= "")then
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackCustomNPC,activeEditedCustomNPC)
				
				
			end
			ImGui.SameLine()
			
			if ImGui.Button(getLang("editor_test_in_game")) and activeEditedCustomNPC.tag ~= "" then
				
				local current = getCustomNPCByTag(activeEditedCustomNPC.tag)
				
				if(current == nil) then
					
					arrayCustomNPC[activeEditedCustomNPC.tag] = {}
					arrayCustomNPC[activeEditedCustomNPC.tag].npc = activeEditedCustomNPC
					
					arrayCustomNPC[activeEditedCustomNPC.tag].npc.isspawn=false
					arrayCustomNPC[activeEditedCustomNPC.tag].npc.init=false
					arrayCustomNPC[activeEditedCustomNPC.tag].npc.spawnforced=false
					arrayCustomNPC[activeEditedCustomNPC.tag].npc.dospawnaction=true
					arrayCustomNPC[activeEditedCustomNPC.tag].npc.doroutineaction=true
					arrayCustomNPC[activeEditedCustomNPC.tag].npc.dodeathaction=true
					arrayCustomNPC[activeEditedCustomNPC.tag].npc.dodespawnaction=true
					arrayCustomNPC[activeEditedCustomNPC.tag].npc.workinglocation=value.location
					
					arrayCustomNPC[activeEditedCustomNPC.tag].datapack = "editor"
					arrayCustomNPC[activeEditedCustomNPC.tag].file = "editor"
					else
					
					current = activeEditedCustomNPC
					
				end
				
				
				
				else
				ImGui.Text(getLang("editor_export_warning"))
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedCustomNPC.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedCustomNPC.tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedCustomNPC)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			ImGui.SameLine()
			if ImGui.Button("Dump") and activeEditedCustomNPC.tag ~= "" then
				
				
				debugPrint(2,dump((activeEditedCustomNPC)))
				
				
			end
			
		end
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditedCustomNPC.tag ~= "" then
			
			editor_json_tag =  activeEditedCustomNPC.tag
			editor_json = JSON:encode_pretty(activeEditedCustomNPC)
			editor_json_obj = activeEditedCustomNPC
			editor_json_obj_name = "activeEditedCustomNPC"
			editor_json_view = true
			
			
		end
		
		
		ImGui.EndTabItem()
	end
	
	
end	


function ShardTab()
	
	if(activeEditedShard.tag == nil) then
		activeEditedShard.title = ""
		activeEditedShard.description = ""
		activeEditedShard.tag = ""
		
		activeEditedShard.locked = true
		activeEditedShard.crypted = true
		activeEditedShard.new = false
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Shard")) then
		
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadShardtag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(arrayShard) do
				
				if ImGui.Selectable(v.tag, false) then
					
					
					loadShard = v
					loadShardtag=v.tag
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedShard = loadShard
			
			if(activeEditedShard.tag == nil) then
				activeEditedShard.title = ""
				activeEditedShard.description = ""
				activeEditedShard.tag = ""
				
				activeEditedShard.locked = false
				activeEditedShard.crypted = false
				activeEditedShard.new = true
				
				
				
			end
			
		end
		
		
		if(loadShard.tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadShard = {}
				loadShardtag = ""
				activeEditedShard = {}
				
				if(activeEditedShard.tag == nil) then
					activeEditedShard.title = ""
					activeEditedShard.description = ""
					activeEditedShard.tag = ""
					
					activeEditedShard.locked = false
					activeEditedShard.crypted = false
					activeEditedShard.new = true
					
					
					
				end
				
			end
			
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		activeEditedShard.title = ImGui.InputText(getLang("editor_title"), activeEditedShard.title, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedShard.tag = ImGui.InputText(getLang("editor_tag"), activeEditedShard.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedShard.description = ImGui.InputTextMultiline(getLang("editor_desc"), activeEditedShard.description, 100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		
		activeEditedShard.locked = ImGui.Checkbox(getLang("editor_Shard_locked"), activeEditedShard.locked)
		activeEditedShard.crypted = ImGui.Checkbox(getLang("editor_Shard_crypted"), activeEditedShard.crypted)
		
		activeEditedShard.new = ImGui.Checkbox(getLang("editor_Shard_new"), activeEditedShard.new)
		
		
		if(activeEditedShard.tag ~= nil and activeEditedShard.tag ~= "")then
			if ImGui.Button(getLang("editor_save_for_build")) then
				
				
				
				table.insert(myDatapackShard,activeEditedShard)
				
				
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_test_in_game")) then
				
				local current = getShardByTag(activeEditedShard.tag)
				
				if(current == nil) then
					
					table.insert(arrayShard,activeEditedShard)
					else
					
					current = activeEditedShard
					
				end
				
				
				
				else
				ImGui.Text(getLang("editor_export_warning"))
			end
			ImGui.SameLine()
			if ImGui.Button(getLang("editor_export")) and activeEditedShard.tag ~= "" then
				
				
				local file = assert(io.open("json/report/"..activeEditedShard.tag..".json", "w"))
				local stringg = JSON:encode_pretty(activeEditedShard)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
			end
			ImGui.SameLine()
			if ImGui.Button("Dump") and activeEditedShard.tag ~= "" then
				
				
				debugPrint(2,dump((activeEditedShard)))
				
				
			end
		end
		
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and activeEditedShard.tag ~= "" then
			
			editor_json_tag = activeEditedShard.tag
			editor_json = JSON:encode_pretty(activeEditedShard)
			editor_json_obj = activeEditedShard
			editor_json_obj_name = "activeEditedShard"
			editor_json_view = true
			
			
		end
		
		ImGui.EndTabItem()
	end
end




function DatapackBuilder()
	
	if ImGui.BeginTabItem(getLang("editor_Build")) then
		
		myDatapack.name = ImGui.InputText(getLang("editor_Name"), myDatapack.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		myDatapack.desc = ImGui.InputText(getLang("editor_desc"), myDatapack.desc, 500, ImGuiInputTextFlags.AutoSelectAll)
		myDatapack.author = ImGui.InputText(getLang("editor_Build_Author"), myDatapack.author, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		myDatapack.tag = ImGui.InputText(getLang("editor_tag"), myDatapack.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		myDatapack.version = ImGui.InputText(getLang("editor_Build_Version"), myDatapack.version, 100 , ImGuiInputTextFlags.AutoSelectAll)
		
		listStringNode(getLang("editor_Build_Flags"),getLang("editor_Build_Flags_msg"),myDatapack,"flags")
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		ImGui.Text(getLang("editor_Build_myDatapackQuest")..tostring(#myDatapackQuest))
		ImGui.Text(getLang("editor_Build_myDatapackDialog")..tostring(#myDatapackDialog))
		ImGui.Text(getLang("editor_Build_myDatapackEvent")..tostring(#myDatapackEvent))
		ImGui.Text(getLang("editor_Build_myDatapackInteract")..tostring(#myDatapackInteract))
		ImGui.Text(getLang("editor_Build_myDatapackFixer")..tostring(#myDatapackFixer))
		ImGui.Text(getLang("editor_Build_myDatapackFaction")..tostring(#myDatapackFaction))
		ImGui.Text(getLang("editor_Build_myDatapackFunction")..tostring(#myDatapackFunction))
		ImGui.Text(getLang("editor_Build_myDatapackNode")..tostring(#myDatapackNode))
		ImGui.Text(getLang("editor_Build_myDatapackPath")..tostring(#myDatapackPath))
		ImGui.Text(getLang("editor_Build_myDatapackCircuit")..tostring(#myDatapackCircuit))
		ImGui.Text(getLang("editor_Build_myDatapackPlace")..tostring(#myDatapackPlace))
		ImGui.Text(getLang("editor_Build_myDatapackHousing")..tostring(#myDatapackHousing))
		ImGui.Text(getLang("editor_Build_myDatapackRadio")..tostring(#myDatapackRadio))
		ImGui.Text(getLang("editor_Build_myDatapackLanguage")..tostring(#myDatapackLanguage))
		ImGui.Text(getLang("editor_Build_myDatapackHelp")..tostring(#myDatapackHelp))
		ImGui.Text(getLang("editor_Build_myDatapackInterfaces")..tostring(#myDatapackInterfaces))
		ImGui.Text(getLang("editor_Build_myDatapackCustomNPC")..tostring(#myDatapackCustomNPC))
		ImGui.Text(getLang("editor_Build_myDatapackShard")..tostring(#myDatapackShard))
		ImGui.Text(getLang("editor_Build_myDatapackPhoneDialog")..tostring(#myDatapackPhoneDialog))
		ImGui.Text(getLang("editor_Build_myDatapackPOI")..tostring(#myDatapackPOI))
		ImGui.Text(getLang("editor_Build_myDatapackScene")..tostring(#myDatapackScene))
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		if(myDatapack.tag ~= nil and myDatapack.tag ~= "")then
			if ImGui.Button(getLang("editor_Build_Build")) and myDatapack.tag ~= "" then
				
				myDatapack.file = myDatapack.tag..".zip"
				
				--	os.execute( "mkdir json\\report\\"..myDatapack.tag )
				
				
				
				local file = assert(io.open("json/mydatapack/desc.json", "w"))
				local stringg = JSON:encode_pretty(myDatapack)
				--debug--debugPrint(2,stringg)
				file:write(stringg)
				file:close()
				
				
				local dirz = "json/mydatapack/circuit"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/dialog"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/faction"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/fixer"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/function"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/interact"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/lang"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/mission"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/node"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/path"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/place"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/housing"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				
				dirz = "json/mydatapack/poi"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/radio"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/help"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/interfaces"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/npc"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/shard"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/phone_dialog"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/poi"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				dirz = "json/mydatapack/scene"
				local reader = dir(dirz)
				if(reader ~= nil) then
					for i=1, #reader do 
						if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
							
							os.remove(dirz.."/"..reader[i].name)
							
						end
						
					end
				end
				
				
				if(#myDatapackQuest > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\mission" )
					
					for i=1,#myDatapackQuest do 
						
						local file = assert(io.open("json/mydatapack/mission/"..myDatapackQuest[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackQuest[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
				end
				
				
				if(#myDatapackDialog > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\dialog" )
					
					local file = assert(io.open("json/mydatapack/dialog/"..myDatapack.tag..".json", "w"))
					local stringg = JSON:encode_pretty(myDatapackDialog)
					--debug--debugPrint(2,stringg)
					file:write(stringg)
					file:close()
					
					
					
				end
				
				
				if(#myDatapackCircuit > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\circuit" )
					
					local file = assert(io.open("json/mydatapack/circuit/"..myDatapack.tag..".json", "w"))
					local stringg = JSON:encode_pretty(myDatapackCircuit)
					--debug--debugPrint(2,stringg)
					file:write(stringg)
					file:close()
					
					
					
				end
				
				
				if(#myDatapackEvent > 0)then
					--os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\event" )
					
					for i=1,#myDatapackEvent do 
						
						local file = assert(io.open("json/mydatapack/event/"..myDatapackEvent[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackEvent[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				
				if(#myDatapackFaction > 0)then
					--		os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\faction" )
					
					for i=1,#myDatapackFaction do 
						
						local file = assert(io.open("json/mydatapack/faction/"..myDatapackFaction[i].Tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackFaction[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				if(#myDatapackLanguage > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\fixer" )
					
					for i=1,#myDatapackLanguage do 
						
						local file = assert(io.open("json/mydatapack/lang/"..myDatapackLanguage[i].name..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackLanguage[i]["data"])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				if(#myDatapackFixer > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\fixer" )
					
					for i=1,#myDatapackFaction do 
						
						local file = assert(io.open("json/mydatapack/fixer/"..myDatapackFixer[i].Tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackFixer[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				
				if(#myDatapackFunction > 0)then
					--			os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\function" )
					
					for i=1,#myDatapackFunction do 
						
						local file = io.open("json/mydatapack/function/"..myDatapackFunction[i].tag..".json", "w")
						local stringg = JSON:encode_pretty(myDatapackFunction[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				
				if(#myDatapackInteract > 0)then
					--			os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\interact" )
					
					for i=1,#myDatapackInteract do 
						
						local file = assert(io.open("json/mydatapack/interact/"..myDatapackInteract[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackInteract[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				if(#myDatapackNode > 0)then
					--os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\node" )
					
					
					local file = assert(io.open("json/mydatapack/node/"..myDatapack.tag..".json", "w"))
					local stringg = JSON:encode_pretty(myDatapackNode)
					--debug--debugPrint(2,stringg)
					file:write(stringg)
					file:close()
					
					
					
					
				end
				
				
				
				
				
				
				if(#myDatapackPlace > 0)then
					--os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\place" )
					
					for i=1,#myDatapackPlace do 
						
						local file = assert(io.open("json/mydatapack/place/"..myDatapackPlace[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackPlace[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				
				if(#myDatapackHousing > 0)then
					--os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\place" )
					
					for i=1,#myDatapackHousing do 
						
						local file = assert(io.open("json/mydatapack/housing/"..myDatapackHousing[i].name.."_housing.json", "w"))
						local stringg = JSON:encode_pretty(myDatapackHousing[i].items)
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				
				if(#myDatapackPath > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\path" )
					
					for i=1,#myDatapackPath do 
						
						local file = assert(io.open("json/mydatapack/path/"..myDatapackPath[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackPath[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				
				if(#myDatapackRadio > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\radio" )
					--os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\song" )
					for i=1,#myDatapackRadio do 
						
						local file = assert(io.open("json/mydatapack/radio/"..myDatapackRadio[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackRadio[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				if(#myDatapackHelp > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\radio" )
					--os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\song" )
					for i=1,#myDatapackHelp do 
						
						local file = assert(io.open("json/mydatapack/help/"..myDatapackHelp[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackHelp[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				
				if(#myDatapackInterfaces > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\fixer" )
					
					for i=1,#myDatapackInterfaces do 
						
						local file = assert(io.open("json/mydatapack/interfaces/"..myDatapackInterfaces[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackInterfaces[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				
				if(#myDatapackCustomNPC > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\fixer" )
					
					for i=1,#myDatapackCustomNPC do 
						
						local file = assert(io.open("json/mydatapack/npc/"..myDatapackCustomNPC[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackCustomNPC[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				if(#myDatapackShard > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\fixer" )
					
					for i=1,#myDatapackShard do 
						
						local file = assert(io.open("json/mydatapack/shard/"..myDatapackShard[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackShard[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				if(#myDatapackPhoneDialog > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\fixer" )
					
					for i=1,#myDatapackPhoneDialog do 
						
						local file = assert(io.open("json/mydatapack/phone_dialog/"..myDatapackPhoneDialog[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackPhoneDialog[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				if(#myDatapackPOI > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\fixer" )
					
					for i=1,#myDatapackPOI do 
						
						local file = assert(io.open("json/mydatapack/poi/"..myDatapackPOI[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackPOI[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				if(#myDatapackScene > 0)then
					--	os.execute( "mkdir json\\report\\"..myDatapack.tag.."\\fixer" )
					
					for i=1,#myDatapackScene do 
						
						local file = assert(io.open("json/mydatapack/scene/"..myDatapackScene[i].tag..".json", "w"))
						local stringg = JSON:encode_pretty(myDatapackScene[i])
						--debug--debugPrint(2,stringg)
						file:write(stringg)
						file:close()
						
					end
					
					
					
				end
				
				ZipMyDatapack()
				
			end
			
			
			
			
			
			else
			ImGui.Text(getLang("editor_Build_Msg"))
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		if ImGui.Button(getLang("editor_Build_Clean")) then
			
			myDatapack = {}
			myDatapack.name = ""
			myDatapack.desc = ""
			myDatapack.author = ""
			myDatapack.file = ""
			myDatapack.tag = ""
			myDatapack.version = "0.0.0"
			myDatapack.flags ={}
			
			myDatapackQuest = {}
			myDatapackInteract = {}
			myDatapackDialog = {}
			myDatapackFixer = {}
			myDatapackPlace = {}
			myDatapackFunction = {}
			myDatapackFaction = {}
			myDatapackRadio = {}
			myDatapackNode = {}
			myDatapackCircuit = {}
			myDatapackPath = {}
			myDatapackLanguage = {}
			myDatapackEvent = {}
			myDatapackHousing = {}
			myDatapackHelp = {}
			myDatapackTheme = {}
			myDatapackCustomNPC = {}
			myDatapackPOI = {}
			myDatapackScene = {}
			
			
		end
		ImGui.EndTabItem()
	end
	
	
end



function SettingTab()
	
	if ImGui.BeginTabItem(getLang("editor_Setting")) then
		ImGui.Text(getLang("editor_Setting_Camera"))
		if editorcam then ImGui.Text(getLang("editor_Setting_Camera_Mode1")) else ImGui.Text(getLang("editor_Setting_Camera_Mode2")) end
		if ImGui.Button(getLang("editor_Setting_Camera_Switch")) then
			editorcam = not editorcam
		end
		
		camstep =  ImGui.DragFloat("##camstep", camstep, 0.1, 0.1, 10, "%.3f Camera Step")
		
		
		
		if(editorcam) then
			
			local obj = getEntityFromManager("editor_cam")
			
			if(obj.id == nil ) then
				
				local position = {}
				editorView.x = Game.GetPlayer():GetWorldPosition().x
				editorView.y = Game.GetPlayer():GetWorldPosition().y
				editorView.z = Game.GetPlayer():GetWorldPosition().z
				
				position.x = Game.GetPlayer():GetWorldPosition().x
				position.y = Game.GetPlayer():GetWorldPosition().y
				position.z = Game.GetPlayer():GetWorldPosition().z
				
				local qat = Game.GetPlayer():GetWorldOrientation()
				local angless = GetSingleton('Quaternion'):ToEulerAngles(qat)
				local angle = {}
				
				angle.roll = angless.roll
				angle.pitch = angless.pitch
				angle.yaw = angless.yaw
				
				editorView.roll = angless.roll
				editorView.pitch = angless.pitch
				editorView.yaw = angless.yaw
				
				spawnCamera("editor_cam","free","",position,angle,false)
				
				else
				
				local enti = Game.FindEntityByID(obj.id)
				if(enti == nil) then
					
					
					
					local position = {}
					position.x = Game.GetPlayer():GetWorldPosition().x
					position.y = Game.GetPlayer():GetWorldPosition().y
					position.z = Game.GetPlayer():GetWorldPosition().z
					
					local angle = {}
					angle.roll = Game.GetPlayer():GetWorldOrientation().roll
					angle.pitch = Game.GetPlayer():GetWorldOrientation().pitch
					angle.yaw = Game.GetPlayer():GetWorldOrientation().yaw
					
					spawnCamera("editor_cam","free","",position,angle,false)
					
					
				end
				
				
				
				
				
				
			end
			
			
			
			
			editorView.x,change = ImGui.DragFloat("##editorViewx", editorView.x, camstep, -9999, 9999, "%.3f X")
			if change then
				local position = {}
				position.x = editorView.x
				position.y = editorView.y
				position.z = editorView.z
				
				local angle = {}
				angle.roll = editorView.roll
				angle.pitch = editorView.pitch
				angle.yaw = editorView.yaw
				moveCamera("editor_cam","free_cam","",position,angle)
			end
			
			editorView.y,change = ImGui.DragFloat("##editorViewy", editorView.y, camstep, -9999, 9999, "%.3f Y")
			if change then
				local position = {}
				position.x = editorView.x
				position.y = editorView.y
				position.z = editorView.z
				
				local angle = {}
				angle.roll = editorView.roll
				angle.pitch = editorView.pitch
				angle.yaw = editorView.yaw
				moveCamera("editor_cam","free_cam","",position,angle)
			end
			
			editorView.z,change = ImGui.DragFloat("##editorViewz", editorView.z, camstep, -9999, 9999, "%.3f Z")
			if change then
				
				local position = {}
				position.x = editorView.x
				position.y = editorView.y
				position.z = editorView.z
				
				local angle = {}
				angle.roll = editorView.roll
				angle.pitch = editorView.pitch
				angle.yaw = editorView.yaw
				moveCamera("editor_cam","free_cam","",position,angle)
			end
			
			
			editorView.yaw,change = ImGui.DragFloat("##editorViewyaw", editorView.yaw, camstep, -9999, 9999, "%.3f Yaw")
			if change then
				
				local position = {}
				position.x = editorView.x
				position.y = editorView.y
				position.z = editorView.z
				
				local angle = {}
				angle.roll = editorView.roll
				angle.pitch = editorView.pitch
				angle.yaw = editorView.yaw
				moveCamera("editor_cam","free_cam","",position,angle)
			end
			
			editorView.roll,change = ImGui.DragFloat("##editorViewroll", editorView.roll, camstep, -9999, 9999, "%.3f Roll")
			if change then
				
				local position = {}
				position.x = editorView.x
				position.y = editorView.y
				position.z = editorView.z
				
				local angle = {}
				angle.roll = editorView.roll
				angle.pitch = editorView.pitch
				angle.yaw = editorView.yaw
				moveCamera("editor_cam","free_cam","",position,angle)
			end
			
			editorView.pitch,change = ImGui.DragFloat("##editorViewpitch", editorView.pitch, camstep, -9999, 9999, "%.3f Pitch")
			if change then
				
				local position = {}
				position.x = editorView.x
				position.y = editorView.y
				position.z = editorView.z
				
				local angle = {}
				angle.roll = editorView.roll
				angle.pitch = editorView.pitch
				angle.yaw = editorView.yaw
				moveCamera("editor_cam","free_cam","",position,angle)
			end
			
			
			else
			
			local obj = getEntityFromManager("editor_cam")
			
			if(obj.id ~= nil ) then
				
				local obj = getEntityFromManager("editor_cam")
				local enti = Game.FindEntityByID(obj.id)
				
				if(enti ~= nil) then
					
					enti:Dispose()
					
				end
				
				
				
			end
			cyberscript.EntityManager["editor_cam"] = nil
			
			
			
			editorView.x,change = ImGui.DragFloat("##editorViewx", editorView.x, camstep, -9999, 9999, "%.3f Camera Side")
			if change then
				local fppComp = Game.GetPlayer():GetFPPCameraComponent()
				fppComp:SetLocalPosition(Vector4:new(editorView.x, editorView.y, editorView.z, 1.0))
			end
			
			editorView.y,change = ImGui.DragFloat("##editorViewy", editorView.y, camstep, -9999, 9999, "%.3f Camera Depth")
			if change then
				local fppComp = Game.GetPlayer():GetFPPCameraComponent()
				fppComp:SetLocalPosition(Vector4:new(editorView.x, editorView.y, editorView.z, 1.0))
			end
			
			editorView.z,change = ImGui.DragFloat("##editorViewz", editorView.z, camstep, -9999, 9999, "%.3f Camera Height")
			if change then
				local fppComp = Game.GetPlayer():GetFPPCameraComponent()
				fppComp:SetLocalPosition(Vector4:new(editorView.x, editorView.y, editorView.z, 1.0))
			end
			
			
			
			
		end
		
		if ImGui.Button(getLang("editor_Setting_Camera_Reset"), 100, 0) then
			
			
			local fppComp = Game.GetPlayer():GetFPPCameraComponent()
			fppComp:SetLocalPosition(Vector4:new(0, 0, 0, 1.0))
			
			
			
		end
		
		if ImGui.Button(getLang("editor_Setting_Camera_lookat"), 100, 0) then
			
			
			enableCamera("editor_cam")
			
			
			
		end
		if ImGui.Button(getLang("editor_Setting_Camera_exit"), 100, 0) then
			
			
			stopCamera("editor_cam")
			
			
			
		end
		if ImGui.Button(getLang("editor_Setting_Freeze_Time"), 100, 0) then
			if(editorFreeze == true) then
				editorFreeze= false
				
				Game.SetTimeDilation(0)
				
				else
				editorFreeze = true
				
				Game.SetTimeDilation(0.0000000000001)
			end
			
		end
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Text(getLang("editor_Setting_PlayerPosition"))
		curPos.x,change2 = ImGui.DragFloat("##curPosx", curPos.x, camstep, -9999, 9999, "%.3f Player Pos X")
		if change2 then
			teleportTo(Game.GetPlayer(), curPos, 1,true)
		end
		
		curPos.y,change2 = ImGui.DragFloat("##curPosy", curPos.y, camstep, -9999, 9999, "%.3f Player Pos Y")
		if change2 then
			teleportTo(Game.GetPlayer(), curPos, 1,true)
		end
		
		curPos.z,change2 = ImGui.DragFloat("##curPosz", curPos.z, camstep, -9999, 9999, "%.3f Player Pos Z")
		if change2 then
			teleportTo(Game.GetPlayer(), curPos, 1,true)
		end
		
		
	
		
		
		
		if ImGui.Button("TP to Custom MapPin") then
			
			if(ActivecustomMappin ~= nil) then
				
				local pos = ActivecustomMappin:GetWorldPosition()
				Game.TeleportPlayerToPosition(pos.x,pos.y,pos.z)
			end
		end
		pox = ImGui.InputInt("X", pox)
		poy = ImGui.InputInt("Y", poy)
		poz = ImGui.InputInt("Z", poz)
		
		if ImGui.Button("TP to XYZ") then
			Game.TeleportPlayerToPosition(pox,poy,poz)
		end
		
		
		
		ImGui.EndTabItem()
	end
	
	
end

function colorPicker()
	
	ImGui.SetNextWindowPos(300, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.Begin("ColorPicker")
	if ImGui.Button("Close", 100, 0) then
		openColorPicker = false
		
	end
	ImGui.Text("Copy the code that begin to # for your theme")
	
	if(colorPickerModeRGB == true) then
		
		currentcolorTable = ImGui.ColorPicker4("Edit color", currentcolorTable, ImGuiColorEditFlags.DisplayRGB )
		
		else
		currentcolorTable = ImGui.ColorPicker4("Edit color", currentcolorTable, ImGuiColorEditFlags.DisplayHex )
	end
	
	
	ImGui.End()
end


function SceneTabs()
	
	if(activeEditedScene == nil or activeEditedScene.tag == nil) then
		activeEditedScene = {}
		activeEditedScene.tag = ""
		
		activeEditedScene.isbraindance = false
		activeEditedScene["init_action"] = {}
		activeEditedScene["step"] = {}
		activeEditedScene["end_action"] = {}
		activeEditedScene["reset_action"] = {}
		
		
	end
	
	if ImGui.BeginTabItem(getLang("editor_Scene")) then
		
		
		
		
		if ImGui.BeginCombo(getLang("editor_load_script"), loadScenetag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(arrayScene) do
				
				if ImGui.Selectable(k, false) then
					
					
					loadScene = v.scene
					loadScenetag=k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		ImGui.SameLine()
		if(ImGui.Button(getLang("editor_load"))) then
			
			activeEditedScene = loadScene
			
			if(activeEditedScene == nil  or activeEditedScene.tag == nil) then
				activeEditedScene = {}
				activeEditedScene.tag = ""
				
				activeEditedScene.isbraindance = false
				activeEditedScene["init_action"] = {}
				activeEditedScene["step"] = {}
				activeEditedScene["end_action"] = {}
				activeEditedScene["reset_action"] = {}
				
				ImGui.Text("Object not founded, default value is loaded")
				else
				
				ImGui.Text("Loaded !")
			end
			
		end
		
		
		if(activeEditedScene.tag ~= nil) then
			ImGui.SameLine()
			if(ImGui.Button(getLang("editor_unload"))) then
				loadScene = {}
				loadScenetag = ""
				activeEditedScene = {}
				
				if(activeEditedScene == nil  or activeEditedScene.tag == nil) then
					activeEditedScene = {}
					activeEditedScene.tag = ""
					
					activeEditedScene.isbraindance = false
					activeEditedScene["init_action"] = {}
					activeEditedScene["step"] = {}
					activeEditedScene["end_action"] = {}
					activeEditedScene["reset_action"] = {}
					
					ImGui.Text("Object not founded, default value is loaded")
					else
					
					ImGui.Text("Loaded !")
				end
				
				
			end
			
		end
		
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		
		
		activeEditedScene.tag = ImGui.InputText(getLang("editor_tag"), activeEditedScene.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Spacing()
		
		
		
		activeEditedScene.isbraindance = ImGui.Checkbox(getLang("editor_Scene_isbraindance"), activeEditedScene.isbraindance)
		
		
		
		
		
		ImGui.Spacing()
		ImGui.Spacing()
		ImGui.Spacing()
		
		actionNode(getLang("editor_Scene_init_action"),activeEditedScene,"init_action")
		ImGui.SameLine()
		if ImGui.Button(getLang("editor_Scene_init_action_play"), 300, 0) then
			
			runActionList(activeEditedScene["init_action"], activeEditedScene["tag"].."_editor", "interact",false,"editor")
		end
		
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		SceneStepNode(activeEditedScene)
		
		ImGui.Spacing()
		ImGui.Spacing()
		
		
		actionNode(getLang("editor_Scene_end_action"),activeEditedScene,"end_action")
		ImGui.SameLine()
		if ImGui.Button(getLang("editor_Scene_end_action_play"), 300, 0) then
			
			runActionList(activeEditedScene["end_action"], activeEditedScene["tag"].."_editor", "interact",false,"editor")
		end
		ImGui.Spacing()
		ImGui.Spacing()
		
		actionNode(getLang("editor_Scene_reset_action"),activeEditedScene,"reset_action")
		ImGui.SameLine()
		if ImGui.Button(getLang("editor_Scene_reset_action_play"), 300, 0) then
			
			runActionList(activeEditedScene["reset_action"], activeEditedScene["tag"].."_editor", "interact",false,"editor")
		end
		ImGui.Spacing()
		ImGui.Spacing()
		
		if(#activeEditedScene["init_action"] > 0 and #activeEditedScene["step"] > 0 and #activeEditedScene["end_action"] > 0 and #activeEditedScene["reset_action"] > 0) then
			
			
			if(activeEditedScene.tag ~= "" or activeEditedScene.tag ~= nil) then
				
				
				
				
				
				
				
				
				if ImGui.Button(getLang("editor_save_for_build")) then
					
					
					
					table.insert(myDatapackScene,activeEditedScene)
					
					
				end
				
				ImGui.SameLine()
				
				if ImGui.Button(getLang("editor_Scene_play")) and activeEditedScene.tag ~= "" then
					
					
					arrayScene[activeEditedScene.tag] = {}
					arrayScene[activeEditedScene.tag].scene = activeEditedScene
					arrayScene[activeEditedScene.tag].file = "editor"
					arrayScene[activeEditedScene.tag].datapack = "editor"
					
					currentScene = activeEditedScene
					currentScene.index = 1
					
					local actionlist = {}
					
					local action = {}
					action.name = "play_scene"
					
					table.insert(actionlist,action)
					
					
					runActionList(actionlist, activeEditedScene.tag.."_editor", "interact",false,"editor")
					
					
					
				end
				
				ImGui.SameLine()
				if ImGui.Button(getLang("editor_export")) and activeEditedScene.tag ~= "" then
					
					
					local file = assert(io.open("json/report/"..activeEditedScene.tag..".json", "w"))
					local stringg = JSON:encode_pretty(activeEditedScene)
					--debug--debugPrint(2,stringg)
					file:write(stringg)
					file:close()
					
					
				end
				else
				
				ImGui.Text(getLang("editor_export_warning"))
				
			end
			
			else
			
			ImGui.Text(getLang("editor_Scene_msg"))
			
		end
		
		
		
		ImGui.Spacing()
		if ImGui.Button(getLang("editor_open_json_editor")) and  activeEditedScene.tag ~= "" then
			
			editor_json_tag =  activeEditedScene.tag
			editor_json = JSON:encode_pretty(activeEditedScene)
			editor_json_obj = activeEditedScene
			editor_json_obj_name = "activeEditedScene"
			editor_json_view = true
			
			
		end
		
		
		
		
		ImGui.EndTabItem()
	end
	
	
end





function VariableEditor()
	
	
	if ImGui.BeginTabItem(getLang("editor_variable")) then
		
		ImGui.Text("Add an new variable : ")
		ImGui.Spacing()
		editorCurrentVariable = ImGui.InputText(getLang("Variable"), editorCurrentVariable, 100, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Spacing()
		editorCurrentVariableKey = ImGui.InputText(getLang("Key"), editorCurrentVariableKey, 100, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Spacing()
		editorCurrentVariableValue = ImGui.InputText("Value",editorCurrentVariableValue, 100, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Spacing()
		
		if ImGui.Button(getLang("Add Variable")) then
			
			
			if(currentSave.Variable[editorCurrentVariable] == nil) then currentSave.Variable[editorCurrentVariable] = {} end
			currentSave.Variable[editorCurrentVariable][editorCurrentVariableKey] = editorCurrentVariableValue
			
			
		end
		
		
		
		ImGui.Spacing()
		
		
		ImGui.Separator()
		
		editorCurrentVariableSearch = ImGui.InputText(getLang("Search Variable"), editorCurrentVariableSearch, 100, ImGuiInputTextFlags.AutoSelectAll)
		editorCurrentVariableKeySearch = ImGui.InputText(getLang("Search Key"), editorCurrentVariableKeySearch, 100, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Spacing()
		
		
		ImGui.Separator()
		
		
		for variabletag,variable in pairs(currentSave.Variable) do
			if (editorCurrentVariableSearch == "" or (editorCurrentVariableSearch ~= "" and (string.match(variabletag,editorCurrentVariableSearch)))) then
				if ImGui.TreeNode(variabletag)  then
					for key,value in pairs (variable) do
						
						if (editorCurrentVariableKeySearch == "" or (editorCurrentVariableKeySearch ~= "" and (string.match(key,editorCurrentVariableKeySearch)))) then
							
							if ImGui.TreeNode(key)  then
								
								if(type(value) == "string") then
									currentSave.Variable[variabletag][key] = ImGui.InputText("##("..type(value)..") "..variabletag..key,value, 100, ImGuiInputTextFlags.AutoSelectAll)
								end
								if(type(value) == "number") then
									currentSave.Variable[variabletag][key] = ImGui.InputFloat("##("..type(value)..") "..variabletag..key,value, 1, 10,"%.2f", ImGuiInputTextFlags.None)
								end
								if(type(value) == "boolean") then
									currentSave.Variable[variabletag][key] = ImGui.Checkbox("##("..type(value)..") "..variabletag..key, currentSave.Variable[variabletag][key])
								end
								if(type(value) == "table") then
									currentSave.Variable[variabletag][key] = ImGui.Text("It's an object, can't be edit like this :( ")
									ImGui.SameLine()
									if ImGui.Button(getLang("Dump in log and console")) then
										
										
										
										print("Editor Variable Dump for "..variabletag.." "..key.." : "..dump(currentSave.Variable[variabletag][key]))
										spdlog.error("Editor Variable Dump for "..variabletag.." "..key.." : "..dump(currentSave.Variable[variabletag][key]))
										
										
									end
								end
								if(type(value) == "userdata") then
									currentSave.Variable[variabletag][key] = ImGui.Text("It's an Game Object, can't be edit like this :( ")
									ImGui.SameLine()
									if ImGui.Button(getLang("Dump in log and console")) then
										
										
										
										print("Editor Variable Game Dump for "..variabletag.." "..key.." : "..GameDump(currentSave.Variable[variabletag][key]))
										spdlog.error("Editor Variable Game Dump for "..variabletag.." "..key.." : "..GameDump(currentSave.Variable[variabletag][key]))
										
										
									end
								end
								ImGui.Spacing()
								if ImGui.Button(getLang("editor_reset")) then
									
									
									
									currentSave.Variable[variabletag][key] = nil
									
									
								end
								ImGui.TreePop()
							end
						end
					end
					ImGui.TreePop()
				end
			end
		end
		
		
		
		
		ImGui.EndTabItem()
		
		
	end
	
end



function debugTab()
	
	if ImGui.BeginTabItem("Debug & Tools") then
		
				if ImGui.BeginTabBar("DebugTabsBar", ImGuiTabBarFlags.NoTooltip) then
				
					if ImGui.BeginTabItem("Current Looked Entity") then
						local status, result =  pcall(function()
							if objLook ~= nil then
								ImGui.Indent()
								
								local entity = objLook
								-- Functions
								IGE.DrawNodeTree("GetEntityID", "entEntityID", entity:GetEntityID(), 
								function(entEntityID) entEntityIDDraw(entEntityID) end)
								
								if ImGui.Button("Destroy") then
									entity:Dispose()
								end
								
								
								if entity:IsPlayer() then
									IGE.DisplayObjectArray("GetPlayerCurrentWorkspotTags", "CName", entity:GetPlayerCurrentWorkspotTags(),
									function(key, value) CNameDraw("Tag", value) end)
								end
								
								if entity:IsVehicle() then
									ImGui.Text("Entity is an vehicle")
									ImGui.Spacing()
									ImGui.Text("Available Seats Slot: ")
									
									local seatstable = GetSeats(entity)
									
									if #seatstable > 0 then
										for i=1, #seatstable do 
											ImGui.Text(seatstable[i])
											ImGui.Spacing()
										end
									end
									else
									ImGui.Text("Entity is not an vehicule")
									ImGui.Spacing()
								end
								
								local obj = getEntityFromManagerById(entity:GetEntityID())
								
								if obj.id ~= nil then
									ImGui.Text("This entity has been registered as Entity in CyberScript with tag "..obj.tag)
									ImGui.Spacing()
									
									ImGui.Text("This entity has been registered as AV ?"..tostring(obj.isAV))
									ImGui.Spacing()
									if ImGui.Button("dump") then
										debugPrint(10,tostring(dump(obj)))
									end
									local group = getEntityGroupfromEntityTag(obj.tag)
									
									if group ~= nil then
										ImGui.Text("This entity has been registered in the Group "..group.tag)
									end
								end
								
								CNameDraw("GetCurrentAppearanceName", entity:GetCurrentAppearanceName())
								CNameDraw("GetCurrentContext", entity:GetCurrentContext())
								CNameDraw("GetDisplayName", entity:GetDisplayName())
								ImGui.Text("GetTweakDBDisplayName: "..entity:GetTweakDBDisplayName(true))
								ImGui.Text("GetTweakDBFullDisplayName:"..entity:GetTweakDBFullDisplayName(true))
								
								
								
								IGE.DisplayVector4("GetWorldPosition", entity:GetWorldPosition())
								IGE.ObjectToText("GetWorldOrientation", entity:GetWorldOrientation())
								IGE.DisplayVector4("GetWorldForward", entity:GetWorldForward())
								
								IGE.DisplayVector4("GetWorldRight", entity:GetWorldRight())
								IGE.DisplayVector4("GetWorldUp", entity:GetWorldUp())
								IGE.ObjectToText("GetWorldYaw", entity:GetWorldYaw())
								-- IGE.ObjectToText("IsAttached", entity:IsAttached()) -- Good way to tell if object has been deleted!
								-- IGE.ObjectToText("IsControlledByAnotherClient", entity:IsControlledByAnotherClient())
								-- IGE.ObjectToText("IsControlledByAnyPeer", entity:IsControlledByAnyPeer())
								-- IGE.ObjectToText("IsControlledBylocalPeer", entity:IsControlledBylocalPeer())
								-- IGE.ObjectToText("ShouldEnableRemoteLayer", entity:ShouldEnableRemoteLayer())
								-- IGE.ObjectToText("HasDirectActionsActive", entity:HasDirectActionsActive())
								-- IGE.ObjectToText("CanRevealRemoteActionsWheel", entity:CanRevealRemoteActionsWheel())
								-- IGE.ObjectToText("ShouldRegisterToHUD", entity:ShouldRegisterToHUD())
								-- IGE.ObjectToText("GetIsIconic", entity:GetIsIconic())
								-- IGE.ObjectToText("GetContentScale", entity:GetContentScale())
								-- IGE.ObjectToText("IsExplosive", entity:IsExplosive())
								-- IGE.ObjectToText("IsFastTravelPoint", entity:IsFastTravelPoint())
								-- IGE.ObjectToText("HasAnySlaveDevices", entity:HasAnySlaveDevices())
								-- IGE.ObjectToText("IsBodyDisposalPossible", entity:IsBodyDisposalPossible())
								-- IGE.ObjectToText("IsReplicated", entity:IsReplicated())
								
								
								ImGui.Unindent()
								
								
								posstep =  ImGui.DragFloat("##post", posstep, 0.1, 0.1, 10, "%.3f Position Step")
								rotstep =  ImGui.DragFloat("##rost", rotstep, 0.1, 0.1, 10, "%.3f Rotation Step")
								
								
								
								moveX =  ImGui.DragFloat("##x", moveX, posstep, -9999, 9999, "%.3f X")
								
								
								
								moveY = ImGui.DragFloat("##y", moveY, posstep, -9999, 9999, "%.3f Y")
								
								
								moveZ = ImGui.DragFloat("##z", moveZ, posstep, -9999, 9999, "%.3f Z")
								
								
								moveYaw =  ImGui.DragFloat("##yaw", moveYaw, rotstep, -9999, 9999, "%.3f YAW")
								
								
								movePitch = ImGui.DragFloat("##pitch", movePitch, rotstep, -9999, 9999, "%.3f PITCH")
								
								
								moveRoll = ImGui.DragFloat("##roll", moveRoll, rotstep, -9999, 9999, "%.3f ROLL")
								
								
								
								
								
								
								
								if ImGui.Button("change position", 300, 0) then
									local positu =  entity:GetWorldPosition()
									local qat = entity:GetWorldOrientation()
									local angless = GetSingleton('Quaternion'):ToEulerAngles(qat)
									positu.x = positu.x + moveX
									positu.y = positu.y + moveY
									positu.z = positu.z + moveZ
									
									
									local cmd = NewObject('handle:AITeleportCommand')
									
									cmd.doNavTest = false
									cmd.rotation = angless
									cmd.position = positu 
									
									
									executeCmd(entity, cmd)
									
								end
								
								if ImGui.Button("change angle", 300, 0) then
									local qat = entity:GetWorldOrientation()
									local angless = GetSingleton('Quaternion'):ToEulerAngles(qat)
									
									angless.yaw = angless.yaw + moveYaw
									angless.pitch = angless.pitch + movePitch
									angless.roll = angless.roll + moveRoll
									
									local cmd = NewObject('handle:AITeleportCommand')
									
									cmd.doNavTest = false
									cmd.rotation = angless
									cmd.position = entity:GetWorldPosition() 
									
									
									executeCmd(entity, cmd)
									
									
								end
								
								
								
							end
							
						end)
						
						if status == false then
							
							
							debugPrint(10,result)
							spdlog.error(result)
						end
						
						ImGui.EndTabItem()
					end
					
					if ImGui.BeginTabItem("Current CS Quest") then
						local status, result = pcall(function()
							
							if currentQuest ~= nil then
								ImGui.Text("title : "..currentQuest.title)
								ImGui.Text("content : "..currentQuest.content)
								ImGui.Text("tag : "..currentQuest.tag)
								ImGui.Text("recommandedlevel : "..currentQuest.recommandedlevel)
								ImGui.Text("questtype : "..currentQuest.questtype)
								ImGui.Text("district : "..currentQuest.district)
								ImGui.Text("isNPCD : "..tostring(currentQuest.isNPCD))
								ImGui.Text("recurrent : "..tostring(currentQuest.recurrent))
								ImGui.Text("State : "..tostring(getScoreKey(currentQuest.tag,"Score")))
								for k,v in pairs(currentQuest.trigger_condition) do
									ImGui.Text(v.name)
								end
								
								if ImGui.TreeNode("trigger_action") then
									for i=1, #currentQuest.trigger_action do
										ImGui.Text(currentQuest.trigger_action[i].name)
									end
									ImGui.TreePop()
								end
								
								if ImGui.TreeNode("objectives") then
									for i=1, #currentQuest.objectives do
										
										local objective = currentQuest.objectives[i]
										
										if ImGui.TreeNode(objective.title.." ( "..objective.tag.." )") then
											ImGui.Text("state : "..tostring(QuestManager.GetObjectiveState(objective.tag).state))
											ImGui.Text("isoptionnal : "..tostring(objective.isoptionnal))
											ImGui.Text("isActive : "..tostring(QuestManager.GetObjectiveState(objective.tag).isActive))
											ImGui.Text("isComplete : "..tostring(QuestManager.GetObjectiveState(objective.tag).isComplete))
											ImGui.Text("isTracked : "..tostring(QuestManager.GetObjectiveState(objective.tag).isTracked))
											ImGui.TreePop()
										end
									end
									ImGui.TreePop()
								end
								else
								ImGui.Text("No current Quest")
							end
						end)
						
						if status == false then
							
							
							debugPrint(10,result)
							spdlog.error(result)
						end
						
						ImGui.EndTabItem()
					end
					
					if ImGui.BeginTabItem("Current Bounty") then
						local status, result = pcall(function()
							
							if currentScannerItem ~= nil then
								ImGui.Text("primaryname : "..currentScannerItem.primaryname)
								ImGui.Text("secondaryname : "..currentScannerItem.secondaryname)
								ImGui.Text("entityname : "..currentScannerItem.entityname)
								ImGui.Text("level : "..tostring(currentScannerItem.level))
								ImGui.Text("rarity : "..tostring(currentScannerItem.rarity))
								ImGui.Text("attitude : "..tostring(currentScannerItem.attitude))
								ImGui.Text("Desc : "..currentScannerItem.text)
								if currentScannerItem.bounty ~= nil then
									
									ImGui.Text("reward : "..tostring(currentScannerItem.bounty.reward))
									ImGui.Text("streetreward : "..tostring(currentScannerItem.bounty.streetreward))
									ImGui.Text("danger : "..tostring(currentScannerItem.bounty.danger))
									ImGui.Text("issuedby : "..tostring(currentScannerItem.bounty.issuedby))
									
									
									for i,v in ipairs(currentScannerItem.bounty.transgressions) do
										ImGui.Text(v)
										end
									
									for i,v in ipairs(currentScannerItem.bounty.customtransgressions) do
										ImGui.Text(v)
									end
								end
								
								else
								ImGui.Text("No current Bounty")
							end
						end)
						
						if status == false then
							
							
							debugPrint(10,result)
							spdlog.error(result)
						end
						
						ImGui.EndTabItem()
					end
					
					if ImGui.BeginTabItem("Script Execution Engine") then
						ImGui.TextColored(0.79, 0.40, 0.29, 1, "tick is .."..tostring(tick))
						ImGui.TextColored(0.79, 0.40, 0.29, 1, "Current Controller is .."..tostring(currentController))
						if ImGui.Button("Toggle automatic thread running") then
							autoScript = not autoScript
						end
						ImGui.Text("Automatic Mode : "..tostring(autoScript))
						
						if ImGui.Button("Reset pending actions (Script)") then
							workerTable = {}
							despawnAll()
						end
						ImGui.Spacing()
						ImGui.Spacing()
						
						if ImGui.Button("Manual script Step") then
							CompileCachedThread()
							ScriptExecutionEngine()
						end
						
						local status, result =  pcall(function()
							for k,v in pairs(workerTable) do 
								
								if ImGui.TreeNode(k) then
									
									local index = workerTable[k]["index"]
									
									local list = workerTable[k]["action"]
									
									local parent = workerTable[k]["parent"]
									
									local source = workerTable[k]["source"]
									
									local pending = workerTable[k]["pending"]
									
									local started = workerTable[k]["started"]
									
									local disabled = workerTable[k]["disabled"]
									
									local quest = workerTable[k]["quest"]
									
									local executortag = workerTable[k]["executortag"]
									ImGui.Text("index : "..index)
									ImGui.Text("list : "..#list)
									ImGui.Text("parent : "..parent)
									ImGui.Text("source : "..source)
									ImGui.Text("pending : "..tostring(pending))
									ImGui.Text("started : "..tostring(started))
									ImGui.Text("disabled : "..tostring(disabled))
									
									if quest ~= nil then
										ImGui.Text("quest : "..tostring(quest))
									end
									ImGui.Text("Executor Tag : "..executortag)
									if(list[index] ~= nil) then
									ImGui.Text("Current Action : "..list[index].name)
									end
									ImGui.TreePop()
								end
							end
						end)
						
						if status == false then
						
						
							debugPrint(10,result)
							spdlog.error(result)
						end
						
						ImGui.EndTabItem()
					end
					
					if ImGui.BeginTabItem("Mod Data") then
						local status, result =  pcall(function()
							
							if ImGui.TreeNode("Group") then
								for k,v in pairs(cyberscript.GroupManager) do
									
									local group = v
									if ImGui.TreeNode(group.tag) then
									
										ImGui.Text("Tag : "..group.tag)
								
										ImGui.Text("Entities : "..#group.entities)
										
									ImGui.TreePop()
									end
								end
								ImGui.TreePop()
							end
							
							ImGui.Separator()
							
							
							if ImGui.TreeNode("Entities") then
								for k,v in pairs(cyberscript.EntityManager) do
									
									local enti = v
									if ImGui.TreeNode(enti.tag) then
									
										for key,prop in pairs(enti) do
										
											ImGui.Text(key.." : "..tostring(prop))
										
										end
										
									ImGui.TreePop()
									end
								end
								ImGui.TreePop()
							end
							
							ImGui.Separator()
							
							if ImGui.TreeNode("Items Spawned") then
								for i,v in ipairs(currentItemSpawned) do
									
									local enti = v
									if ImGui.TreeNode(enti.tag) then
									
										for key,prop in pairs(enti) do
										
											ImGui.Text(key.." : "..tostring(prop))
										
										end
										
									ImGui.TreePop()
									end
								end
								ImGui.TreePop()
							end
							
							ImGui.Separator()
							
							if ImGui.TreeNode("Setting") then
								for k,v in pairs(currentSave.arrayUserSetting) do
									
									
									if ImGui.TreeNode(k) then
									
										ImGui.Text("Value : "..tostring(v))
										
									ImGui.TreePop()
									end
								end
								ImGui.TreePop()
							end
							
							ImGui.Separator()
							
							if ImGui.TreeNode("Interact Group") then
								for k,v in ipairs(currentInteractGroup) do
									
									local enti = v
									ImGui.Text(v)
								end
								ImGui.TreePop()
							end
							
							ImGui.Separator()
							
							if ImGui.Button("Refresh Interact Group")  then
								
								getInteractGroup()
							end
							
							ImGui.Separator()
							ImGui.Text("Possible Interact : "..#possibleInteract)
							ImGui.Text("Possible Interact Display : "..#possibleInteractDisplay)
							ImGui.Separator()
							
							if ImGui.Button("Dump Currentsave data")  then
								
								local sessionFile = io.open('currentsave.txt', 'w')
								sessionFile:write(dump(currentSave))
								sessionFile:close()
							end
							
							
							if ImGui.Button("Dump arrayDatapack data")  then
								
								local sessionFile = io.open('arrayDatapack.lua', 'w')
								sessionFile:write(dump(arrayDatapack))
								sessionFile:close()
							end
							
							if ImGui.Button("Dump HUD key")  then
								
								local sessionFile = io.open('displayHUD.txt', 'w')
								for k,v in pairs(displayHUD) do
									sessionFile:write(k, "\n")
								end
								sessionFile:close()
							end
							
							
						end)
						
						if status == false then
							
							
							debugPrint(10,result)
							spdlog.error(result)
						end
						
						ImGui.EndTabItem()
					end
					
					if ImGui.BeginTabItem("Mod Log") then
						
						local status, result = pcall(function()
							
							
							logrecordlevel = ImGui.InputInt(getLang("Record at Log Level"), logrecordlevel, 1,10, ImGuiInputTextFlags.None)
							ImGui.Spacing()
							
							logLevel = ImGui.InputInt(getLang("Log Level"), logLevel, 1,10, ImGuiInputTextFlags.None)
							ImGui.Spacing()
							logFilter = ImGui.InputText(getLang("Log Filter"), logFilter, 100, ImGuiInputTextFlags.AutoSelectAll)
							ImGui.Spacing()
							if ImGui.Button("Clear log and log file") then
								logTable = {}
								logf:close()
								io.open("cyberscript.log", "w"):close()
								logf = io.open("cyberscript.log", "a")
							end
							ImGui.Spacing()
							ImGui.Separator()
							ImGui.Spacing()
							
							
							ImGui.BeginChild("log", 1500, 600)
							
							for i,v in ipairs(logTable) do
								if(v.level <= logLevel and (logFilter == nil or logFilter == "" or (logFilter ~= nil and logFilter ~= "" and string.match(v.msg, logFilter)))) then
									ImGui.Text("[Level:"..v.level.."]"..v.datestring..":"..v.msg)
								end
							end
							
							ImGui.EndChild()
							
							
						end)
								
						if status == false then
							
							
							debugPrint(10,result)
							spdlog.error(result)
						end
						ImGui.EndTabItem()
						
					end
				
				ImGui.EndTabBar()
				end
					
	ImGui.EndTabItem()
	end
		
	
	
	
end






--Windows
function TriggerEditWindows()
	
	
	
	ImGui.SetNextWindowPos(100, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(300, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Trigger") then
		
		currentEditorTrigger.key = ImGui.InputText("Tag of Trigger", currentEditorTrigger.key, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		
		selectedTrigger = currentEditorTrigger.value.name
		local test  = triggerFactory(currentEditorTrigger.value,selectedTriggerTable[1],1) 
		ImGui.Spacing()
		if(currentEditorTrigger.value.name ~= nil and currentEditorTrigger.key ~= nil) then
			if ImGui.Button("Save and close", 300, 0) then
				currentEditorTrigger.parentobj[currentEditorTrigger.parent][currentEditorTrigger.key] = test
				currentParentItem = nil
				
				currentEditorTrigger = nil
				selectedTrigger = ""
				openEditTrigger = false
			end
			
			
			if ImGui.Button("Delete and close", 300, 0) then
				currentEditorTrigger.parentobj[currentEditorTrigger.parent][currentEditorTrigger.key] = nil
				currentParentItem = nil
				
				currentEditorTrigger = nil
				selectedTrigger = ""
				openEditTrigger = false
			end
			
			
		end
		if ImGui.Button("Close", 300, 0) then
			currentParentItem = nil
			currentEditorTrigger = nil
			selectedTrigger = ""
			openEditTrigger = false
			editor_check_trigger_test = false
			editor_check_trigger_test_visble = false
		end
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
	
	
end

function TriggerNewWindows()
	
	
	
	ImGui.SetNextWindowPos(100, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(300, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add Trigger") then
		
		currentEditorTrigger.key = ImGui.InputText("Tag of Trigger", currentEditorTrigger.key, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		for key,vaz in pairs(currentEditorTrigger.value) do
			currentSelectTrigger[key] = vaz
		end
		
		
		currentSelectTrigger  = triggerFactory(currentSelectTrigger,selectedTriggerTable[1]) 
		
		ImGui.Spacing()
		
		if(currentSelectTrigger ~= nil and currentSelectTrigger.name ~= nil  and currentSelectTrigger.name ~= "" and currentEditorTrigger.key ~= nil and currentEditorTrigger.key ~= "") then
			
			if ImGui.Button("Save and close", 300, 0) then
				haschanged = false
				currentEditorTrigger.parentobj[currentEditorTrigger.parent][currentEditorTrigger.key] = currentSelectTrigger
				currentParentItem = nil
				currentSelectTrigger = {}
				currentEditorTrigger = nil
				selectedTrigger = ""
				openNewTrigger = false
				
				
				
			end
			
		end
		
		if ImGui.Button("Close", 300, 0) then
			currentParentItem = nil
			currentSelectTrigger = {}
			currentEditorTrigger = nil
			selectedTrigger = ""
			openNewTrigger = false
			editor_check_trigger_test = false
			editor_check_trigger_test_visble = false
		end
		
		
		
		ImGui.PopStyleVar(2)
		ImGui.End()
		
		
		
	end
end

function TriggerActionEditWindows()
	
	
	
	ImGui.SetNextWindowPos(100, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(300, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Trigger") then
		
		currentEditorTrigger.key = ImGui.InputText("Tag of Trigger", currentEditorTrigger.key, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		
		selectedTrigger = currentEditorTrigger.value.name
		local test  = triggerFactory(currentEditorTrigger.value,selectedTriggerTable[1],1) 
		ImGui.Spacing()
		if(currentEditorTrigger.value.name ~= nil and currentEditorTrigger.key ~= nil) then
			if ImGui.Button("Save and close", 300, 0) then
				
				currentEditorTrigger.parentobj[currentEditorTrigger.parent] = test
				currentParentItem = nil
				
				currentEditorTrigger = nil
				selectedTrigger = ""
				openEditActionTrigger = false
			end
			
			
			if ImGui.Button("Delete and close", 300, 0) then
				currentEditorTrigger.parentobj[currentEditorTrigger.parent] = {}
				currentEditorTrigger.parentobj[currentEditorTrigger.parent].name = "auto"
				currentParentItem = nil
				
				currentEditorTrigger = nil
				selectedTrigger = ""
				openEditActionTrigger = false
			end
			
			
		end
		if ImGui.Button("Close", 300, 0) then
			currentParentItem = nil
			currentEditorTrigger = nil
			selectedTrigger = ""
			openEditActionTrigger = false
			editor_check_trigger_test = false
			editor_check_trigger_test_visble = false
		end
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
	
	
end



function SubTriggerEditWindows()
	
	
	
	ImGui.SetNextWindowPos(100, 200, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Sub Trigger") then
		
		
		
		currentParentItem = triggerFactory(currentParentItem,selectedTriggerTable[3]) 
		ImGui.Spacing()
		if(currentParentItem.name ~= nil) then
			if ImGui.Button("Save and close", 300, 0) then
				haschanged = true
				openTriggerItem = false
			end
			
		end
		
		
		if ImGui.Button("Close", 300, 0) then
			
			haschanged = true
			openTriggerItem = false
			currentParentItem = nil
			editor_check_trigger_test = false
			editor_check_trigger_test_visble = false
		end
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
	
	
end


function ActionEditWindows()
	
	
	
	ImGui.SetNextWindowPos(0, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(700, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Action") then
		
		selecAction = currentEditorAction.value.name
		local test  = actionFactory(currentEditorAction.value) 
		
		
		ImGui.Spacing()
		
		
		if ImGui.Button("Save and close", 300, 0) then
			
			
			currentEditorAction.parentobj[currentEditorAction.parent][currentEditorAction.index] = currentEditorAction.value
			currentEditorAction = nil
			openEditAction = false
			
		end
		
		
		if ImGui.Button("Delete and close", 300, 0) then
			
			
			table.remove(currentEditorAction.parentobj[currentEditorAction.parent],currentEditorAction.index)
			
			openEditAction = false
			currentEditorAction = nil
		end
		
		
		if ImGui.Button("Close", 300, 0) then
			openEditAction = false
			currentEditorAction = nil
		end
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
	
	
end

function ActionNewWindows()
	
	
	
	ImGui.SetNextWindowPos(0, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(700, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add Actions") then
		
		
		
		
		
		
		
		
		
		
		currentSelectAction  = actionFactory(currentSelectAction) 
		
		ImGui.Spacing()
		
		if(currentSelectAction ~= nil and currentSelectAction.name ~= nil) then
			
			
			
			if ImGui.Button("Save and close", 300, 0) then
				table.insert(currentEditorAction.parentobj[currentEditorAction.parent],currentSelectAction)
				openNewAction = false
				currentEditorAction = nil
				currentSelectAction = ""
				
			end
		end
		
		
	end
	
	
	if ImGui.Button("Close", 300, 0) then
		openNewAction = false
		currentEditorAction = nil
		currentSelectAction = ""
	end
	
	
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
	
	
end


function ActionSubEditWindows()
	
	
	
	ImGui.SetNextWindowPos(0, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(700, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Sub Action") then
		
		
		ImGui.Text("If the subaction is an IF, the editor will not see it (it can only see script with 2 layers)")
		
		
		currentSelectSubAction  = actionFactory(currentSelectSubAction) 
		ImGui.Spacing()
		
		
		if ImGui.Button("Save and close", 300, 0) then
			
			debugPrint(2,dump(currentEditorSubAction.parentobj))
			debugPrint(2,currentEditorSubAction.parent)
			debugPrint(2,currentEditorSubAction.index)
			
			if(currentEditorSubAction.index == nil) then
				table.insert(currentEditorSubAction.parentobj[currentEditorSubAction.parent],currentSelectSubAction)
				else
				currentEditorSubAction.parentobj[currentEditorSubAction.parent][currentEditorSubAction.index] = currentSelectSubAction
			end
			
			debugPrint(2,dump(currentEditorSubAction.parentobj))
			debugPrint(2,currentEditorSubAction.parent)
			debugPrint(2,currentEditorSubAction.index)
			currentSelectSubAction = nil
			openEditSubAction = false
			
		end
		
		
		if ImGui.Button("Delete and close", 300, 0) then
			
			
			table.remove(currentEditorSubAction.parentobj[currentEditorSubAction.parent],currentEditorSubAction.index)
			
			openEditSubAction = false
			currentSelectSubAction = nil
		end
		
		
		if ImGui.Button("Close", 300, 0) then
			openEditSubAction = false
			currentEditorSubAction = nil
		end
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
	
	
end

function __genOrderedIndex( t )
	local orderedIndex = {}
	for key in pairs(t) do
		table.insert( orderedIndex, key )
	end
	table.sort( orderedIndex )
	return orderedIndex
end

function orderedNext(t, state)
	-- Equivalent of the next function, but returns the keys in the alphabetic
	-- order. We use a temporary ordered key table that is stored in the
	-- table being iterated.
	
	local key = nil
	----debugPrint(2,"orderedNext: state = "..tostring(state) )
	if state == nil then
		-- the first time, generate the index
		t.__orderedIndex = __genOrderedIndex( t )
		key = t.__orderedIndex[1]
		else
		-- fetch the next value
		for i = 1,table.getn(t.__orderedIndex) do
			if t.__orderedIndex[i] == state then
				key = t.__orderedIndex[i+1]
			end
		end
	end
	
	if key then
		return key, t[key]
	end
	
	-- no more value to return, cleanup
	t.__orderedIndex = nil
	return
end

function orderedPairs(t)
	-- Equivalent of the pairs() function on tables. Allows to iterate
	-- in order
	return orderedNext, t, nil
end

function RoomNewWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add New Room") then
		
		
		
		
		
		currentSelectRoom.name = ImGui.InputText(getLang("editor_Name"), currentSelectRoom.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		currentSelectRoom.tag = ImGui.InputText(getLang("editor_tag"), currentSelectRoom.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		currentSelectRoom.posX = ImGui.InputFloat(getLang("editor_x"), currentSelectRoom.posX, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		currentSelectRoom.posY = ImGui.InputFloat(getLang("editor_y"), currentSelectRoom.posY, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		currentSelectRoom.posZ = ImGui.InputFloat(getLang("editor_z"), currentSelectRoom.posZ, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		currentSelectRoom.range = ImGui.InputFloat("Area (range)", currentSelectRoom.range, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		currentSelectRoom.Zrange = ImGui.InputFloat("Z area (vertical range)", currentSelectRoom.Zrange, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		
		if ImGui.Button("Copy Player's XYZ", 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			currentSelectRoom.posX = vec4.x
			currentSelectRoom.posY = vec4.y
			currentSelectRoom.posZ = vec4.z
			
			
		end
		
		currentSelectRoom.canEat = ImGui.Checkbox("Can Eat in this room ?", currentSelectRoom.canEat)
		currentSelectRoom.canDrink = ImGui.Checkbox("Can drink in this room ?", currentSelectRoom.canDrink)
		currentSelectRoom.canDo = ImGui.Checkbox("Can do interaction in this room ?(Other than drink or eat)", currentSelectRoom.canDo)
		
		
		triggerNode(getLang("trigger_condition"),currentSelectRoom,"trigger")
		
		
		
		
		if(tableHasKey(currentSelectRoom["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),currentSelectRoom,"requirement","trigger")
			if(#currentSelectRoom["requirement"] > 0) then
				
				
				actionNode(getLang("trigger_action"),currentSelectRoom,"action")
				if(currentSelectRoom.tag ~= nil and currentSelectRoom.tag ~= "" and currentSelectRoom.name ~= nil and currentSelectRoom.name ~= "") then
					
					
					
					if ImGui.Button("Save and close", 300, 0) then
						currentSelectRoom.type = {}
						
						if(currentSelectRoom.canEat == true) then
							table.insert(currentSelectRoom.type,0)
						end
						
						if(currentSelectRoom.canDrink == true) then
							table.insert(currentSelectRoom.type,1)
						end
						
						if(currentSelectRoom.canDo == true) then
							table.insert(currentSelectRoom.type,2)
						end
						
						currentSelectRoom.canEat = nil
						currentSelectRoom.canDrink = nil
						currentSelectRoom.canDo = nil
						
						
						table.insert(activeEditedPlace["rooms"],currentSelectRoom)
						
						
						currentSelectRoom = {}
						
						openNewRoom = false
					end
					
					
					if ImGui.Button("Close", 300, 0) then
						
						currentSelectRoom = {}
						
						openNewRoom = false
					end
					
					
				end
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
			
		end
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end


function SceneStepNewWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add New Step") then
		
		
		
		
		
		
		currentSelectSceneStep.tag = ImGui.InputText(getLang("editor_tag"), currentSelectSceneStep.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		
		
		
		actionNode(getLang("trigger_action"),currentSelectSceneStep,"action")
		
		
		if(currentSelectSceneStep.tag ~= nil and currentSelectSceneStep.tag ~= "" and #currentSelectSceneStep.action > 0) then
			
			
			
			if ImGui.Button("Save and close", 300, 0) then
				
				
				
				table.insert(activeEditedScene["step"],currentSelectSceneStep)
				
				
				currentSelectSceneStep = {}
				
				openNewSceneStep = false
			end
			
			
			
			
			else
			ImGui.Text("Need at least 1 action and an tag for unlock save")
			
		end
		
		if ImGui.Button("Close", 300, 0) then
			
			currentSelectSceneStep = {}
			
			openNewSceneStep = false
		end
		
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end

function SceneStepEditWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Step") then
		
		
		
		
		
		
		currentSelectSceneStep.tag = ImGui.InputText(getLang("editor_tag"), currentSelectSceneStep.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		
		
		
		actionNode(getLang("trigger_action"),currentSelectSceneStep,"action")
		
		
		if(currentSelectSceneStep.tag ~= nil and currentSelectSceneStep.tag ~= "" and #currentSelectSceneStep.action > 0) then
			
			
			
			if ImGui.Button("Save and close", 300, 0) then
				
				
				
				
				activeEditedScene["step"][currentSelectSceneStep.index] = currentSelectSceneStep
				
				currentSelectSceneStep = {}
				
				openEditSceneStep = false
			end
			
			
			if ImGui.Button("Delete", 300, 0) then
				
				table.remove(activeEditedScene["step"],currentSelectSceneStep.index)
				
				currentSelectSceneStep = {}
				
				openEditSceneStep = false
				
			end
			
			else
			ImGui.Text("Need an action for unlock save")
			
		end
		
		if ImGui.Button("Close", 300, 0) then
			
			currentSelectSceneStep = {}
			
			openEditSceneStep = false
		end
		
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end

function RoomEditWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Room") then
		
		
		
		
		
		currentSelectRoom.name = ImGui.InputText(getLang("editor_Name"), currentSelectRoom.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		currentSelectRoom.tag = ImGui.InputText(getLang("editor_tag"), currentSelectRoom.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		currentSelectRoom.posX = ImGui.InputFloat(getLang("editor_x"), currentSelectRoom.posX, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		currentSelectRoom.posY = ImGui.InputFloat(getLang("editor_y"), currentSelectRoom.posY, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		currentSelectRoom.posZ = ImGui.InputFloat(getLang("editor_z"), currentSelectRoom.posZ, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		currentSelectRoom.range = ImGui.InputFloat("Area (range)", currentSelectRoom.range, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		currentSelectRoom.Zrange = ImGui.InputFloat("Z area (vertical range)", currentSelectRoom.Zrange, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		
		
		
		currentSelectRoom.canEat = ImGui.Checkbox("Can Eat in this room ?", currentSelectRoom.canEat)
		currentSelectRoom.canDrink = ImGui.Checkbox("Can drink in this room ?", currentSelectRoom.canDrink)
		currentSelectRoom.canDo = ImGui.Checkbox("Can do interaction in this room ?(Other than drink or eat)", currentSelectRoom.canDo)
		
		if ImGui.Button("Copy Player's XYZ", 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			currentSelectRoom.posX = vec4.x
			currentSelectRoom.posY = vec4.y
			currentSelectRoom.posZ = vec4.z
			
			
		end
		triggerNode(getLang("trigger_condition"),currentSelectRoom,"trigger")
		
		
		
		
		if(tableHasKey(currentSelectRoom["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),currentSelectRoom,"requirement","trigger")
			if(#currentSelectRoom["requirement"] > 0) then
				
				
				actionNode(getLang("trigger_action"),currentSelectRoom,"action")
				if(currentSelectRoom.tag ~= nil and currentSelectRoom.tag ~= "" and currentSelectRoom.name ~= nil and currentSelectRoom.name ~= "") then
					
					
					
					if ImGui.Button("Save and close", 300, 0) then
						currentSelectRoom.type = {}
						
						if(currentSelectRoom.canEat == true) then
							table.insert(currentSelectRoom.type,0)
						end
						
						if(currentSelectRoom.canDrink == true) then
							table.insert(currentSelectRoom.type,1)
						end
						
						if(currentSelectRoom.canDo == true) then
							table.insert(currentSelectRoom.type,2)
						end
						
						currentSelectRoom.canEat = nil
						currentSelectRoom.canDrink = nil
						currentSelectRoom.canDo = nil
						
						
						activeEditedPlace["rooms"][currentSelectRoom.index] = currentSelectRoom
						
						
						currentSelectRoom = {}
						
						openEditRoom = false
					end
					
					if ImGui.Button("Delete", 300, 0) then
						
						activeEditedPlace["rooms"][currentSelectRoom.index] = nil
						
						currentSelectRoom = {}
						
						openEditRoom = false
						
					end
					
					if ImGui.Button("Close", 300, 0) then
						
						currentSelectRoom = {}
						
						openEditRoom = false
					end
					
					
				end
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
		end
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end


function OptionsNewWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add New Answers") then
		
		
		
		
		
		currentEditorOptions.value.Description = ImGui.InputTextMultiline("V's Answer", currentEditorOptions.value.Description,100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		
		
		
		triggerNode(getLang("trigger_condition"),currentEditorOptions.value,"trigger")
		
		EditorAddColor = ImGui.Checkbox("Custom color ?", EditorAddColor)
		
		
		
		if(EditorAddColor == true and currentEditorOptions["style"] == nil)then
			
			currentEditorOptions["style"]["bgcolor"] = {}
			currentEditorOptions["style"]["bgcolor"]["red"] = 0
			currentEditorOptions["style"]["bgcolor"]["green"] = 0
			currentEditorOptions["style"]["bgcolor"]["blue"] = 0
			currentEditorOptions["style"]["bgcolor"]["opacity"] = 1
			
			currentEditorOptions["style"]["textcolor"] = {}
			currentEditorOptions["style"]["textcolor"]["red"] = 0
			currentEditorOptions["style"]["textcolor"]["green"] = 0
			currentEditorOptions["style"]["textcolor"]["blue"] = 0
			currentEditorOptions["style"]["textcolor"]["opacity"] = 1
			
		end
		
		
		if(EditorAddColor == true)then
			
			if ImGui.Button("Toggle Color Picker", 300, 0) then
				colorPickerModeRGB = true
				
				if(openColorPicker == false)then
					openColorPicker = true
					else
					openColorPicker = false
					
				end
				
				
				
			end
			
			listDictionnaryIntNode("BackgroundColor :","Background Color of the element.",currentEditorOptions["style"],"bgcolor")
			listDictionnaryIntNode("FontColor :","Font Color of the element",currentEditorOptions["style"],"textcolor")
			
		end
		
		if(tableHasKey(currentEditorOptions.value["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),currentEditorOptions.value,"requirement","trigger")
			
			actionNode(getLang("trigger_action"),currentEditorOptions.value,"action")
			
			
		end
		
		if(currentEditorOptions.value.Description ~= nil and currentEditorOptions.value.Description ~= "") then
			
			
			
			if ImGui.Button("Save and close", 300, 0) then
				
				
				
				table.insert(activeEditedDialog["options"],currentEditorOptions.value)
				
				
				currentEditorOptions = {}
				
				openNewOptions = false
			end
			
			
			if ImGui.Button("Close", 300, 0) then
				
				currentEditorOptions = {}
				
				openNewOptions = false
			end
			
			
		end
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end

function NewItemsWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Items") then
		
		searchitem = ImGui.InputText("Search", searchitem, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		if(searchitem ~= "" or searchitem ~= nil) then
			
			arrayDBitemsfilter = {}
			for i=1, #arrayDBitems do
				if(string.match(arrayDBitems[i].flag, searchitem) or
					string.match(arrayDBitems[i].parentCategory, searchitem) or
					string.match(arrayDBitems[i].childCategory, searchitem) or
					string.match(arrayDBitems[i].Title, searchitem)
					
					
					
				)then 
				
				table.insert(arrayDBitemsfilter,arrayDBitems[i])
				end
			end
			
			
			
			if ImGui.BeginCombo("##My Combo Box", totitem) then -- Remove the ## if you'd like for the title to display above combo box
				
				for i=1, #arrayDBitemsfilter do
					
					if ImGui.Selectable(arrayDBitemsfilter[i].Title) then
						totitem = arrayDBitemsfilter[i].Title
						local pos = Game.GetPlayer():GetWorldPosition()
						local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
						
						currentEditorItems.Tag = arrayDBitemsfilter[i].Tag
						currentEditorItems.HouseTag = activeEditedPlace.tag
						currentEditorItems.ItemPath = arrayDBitemsfilter[i].Path
						currentEditorItems.X = pos.x
						currentEditorItems.Y = pos.y
						currentEditorItems.Z = pos.z
						currentEditorItems.Yaw = angles.yaw
						currentEditorItems.Pitch = angles.pitch
						currentEditorItems.Roll = angles.roll
						currentEditorItems.Title = arrayDBitemsfilter[i].Title
						
						
						ImGui.SetItemDefaultFocus()
					end
					
					
					
				end
				
				ImGui.EndCombo()
			end
			else
			if ImGui.BeginCombo("##My Combo Box", totitem) then -- Remove the ## if you'd like for the title to display above combo box
				
				for i=1, #arrayDBitems do
					
					if ImGui.Selectable(arrayDBitems[i].Title) then
						totitem = arrayDBitems[i].Title
						local pos = Game.GetPlayer():GetWorldPosition()
						local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
						
						currentEditorItems.Tag = arrayDBitems[i].Tag
						currentEditorItems.HouseTag = activeEditedPlace.tag
						currentEditorItems.ItemPath = arrayDBitems[i].Path
						currentEditorItems.X = pos.x
						currentEditorItems.Y = pos.y
						currentEditorItems.Z = pos.z
						currentEditorItems.Yaw = angles.yaw
						currentEditorItems.Pitch = angles.pitch
						currentEditorItems.Roll = angles.roll
						currentEditorItems.Title = arrayDBitems[i].Title
						
						
						ImGui.SetItemDefaultFocus()
					end
					
					
					
				end
				
				ImGui.EndCombo()
			end
		end
		
		
		
		
		
		
		if(currentEditorItems.Tag ~= nil) then
			
			
			
			if ImGui.Button("Save and close", 300, 0) then
				
				saveHousing(currentEditorItems)
				
				local housing = getHousing(currentEditorItems.Tag,currentEditorItems.X,currentEditorItems.Y,currentEditorItems.Z)
				currentEditorItems.Id = housing.Id
				
				local poss = Vector4.new( currentEditorItems.X, currentEditorItems.Y,  currentEditorItems.Z,1)
				
				
				local angless = EulerAngles.new(currentEditorItems.Roll, currentEditorItems.Pitch,  currentEditorItems.Yaw)
				
				
				currentEditorItems.entityId = spawnItem(currentEditorItems, poss, angless)
				
				Cron.After(0.7, function()
					
					local entity = Game.FindEntityByID(currentEditorItems.entityId)
					local components = checkForValidComponents(entity)
					if components then
						local visualScale = checkDefaultScale(components)
						currentEditorItems.defaultScale = {
							x = visualScale.x * 100,
							y = visualScale.x * 100,
							z = visualScale.x * 100,
						}
						currentEditorItems.scale = {
							x = visualScale.x * 100,
							y = visualScale.y * 100,
							z = visualScale.z * 100,
						}
					end
					
					table.insert(currentItemSpawned,currentEditorItems)
					
					
					currentEditorItems = {}
					
					openNewItems = false
				end)
			end
			
			
			
			
			
		end
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end


function EditItemsWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Items") then
		
		
		
		
		
		
		posstep =  ImGui.DragFloat("##post", posstep, 0.1, 0.1, 10, "%.3f Position Step")
		
		
		
		rotstep =  ImGui.DragFloat("##rost", rotstep, 0.1, 0.1, 10, "%.3f Rotation Step")
		
		
		currentEditorItems.X,change =  ImGui.DragFloat("##x", currentEditorItems.X, posstep, -9999, 9999, "%.3f X")
		if change then
			local poss = Vector4.new( currentEditorItems.X, currentEditorItems.Y,  currentEditorItems.Z,1)
			
			
			local angless = EulerAngles.new(currentEditorItems.Roll, currentEditorItems.Pitch,  currentEditorItems.Yaw)
			
			
			
			
			updateItemPosition(currentEditorItems, poss, angless, true)
		end
		
		currentEditorItems.Y,change = ImGui.DragFloat("##y", currentEditorItems.Y, posstep, -9999, 9999, "%.3f Y")
		if change then
			local poss = Vector4.new( currentEditorItems.X, currentEditorItems.Y,  currentEditorItems.Z,1)
			
			
			local angless = EulerAngles.new(currentEditorItems.Roll, currentEditorItems.Pitch,  currentEditorItems.Yaw)
			
			
			
			
			updateItemPosition(currentEditorItems, poss, angless, true)
		end
		
		
		currentEditorItems.Z,change = ImGui.DragFloat("##z", currentEditorItems.Z, posstep, -9999, 9999, "%.3f Z")
		if change then
			local poss = Vector4.new( currentEditorItems.X, currentEditorItems.Y,  currentEditorItems.Z,1)
			
			
			local angless = EulerAngles.new(currentEditorItems.Roll, currentEditorItems.Pitch,  currentEditorItems.Yaw)
			
			
			
			
			updateItemPosition(currentEditorItems, poss, angless, true)
		end
		
		
		
		
		currentEditorItems.Yaw,change =  ImGui.DragFloat("##yaw", currentEditorItems.Yaw, rotstep, -9999, 9999, "%.3f YAW")
		if change then
			local poss = Vector4.new( currentEditorItems.X, currentEditorItems.Y,  currentEditorItems.Z,1)
			
			
			local angless = EulerAngles.new(currentEditorItems.Roll, currentEditorItems.Pitch,  currentEditorItems.Yaw)
			
			
			
			
			updateItemPosition(currentEditorItems, poss, angless, true)
		end
		currentEditorItems.Pitch,change = ImGui.DragFloat("##pitch", currentEditorItems.Pitch, rotstep, -9999, 9999, "%.3f PITCH")
		if change then
			local poss = Vector4.new( currentEditorItems.X, currentEditorItems.Y,  currentEditorItems.Z,1)
			
			
			local angless = EulerAngles.new(currentEditorItems.Roll, currentEditorItems.Pitch,  currentEditorItems.Yaw)
			
			
			
			
			updateItemPosition(currentEditorItems, poss, angless, true)
		end
		currentEditorItems.Roll,change = ImGui.DragFloat("##roll", currentEditorItems.Roll, rotstep, -9999, 9999, "%.3f ROLL")
		
		
		
		
		if change then
			local poss = Vector4.new( currentEditorItems.X, currentEditorItems.Y,  currentEditorItems.Z,1)
			
			
			local angless = EulerAngles.new(currentEditorItems.Roll, currentEditorItems.Pitch,  currentEditorItems.Yaw)
			
			
			
			
			updateItemPosition(currentEditorItems, poss, angless, true)
			
			scaleChanged = true
		end
		
		
		
		
		if ImGui.Button("Copy Player's XYZ", 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			currentEditorItems.X = vec4.x
			currentEditorItems.Y = vec4.y
			currentEditorItems.Z = vec4.z
			
			local poss = Vector4.new( currentEditorItems.X, currentEditorItems.Y,  currentEditorItems.Z,1)
			
			
			local angless = EulerAngles.new(currentEditorItems.Roll, currentEditorItems.Pitch,  currentEditorItems.Yaw)
			
			
			
			updateItemPosition(currentEditorItems, poss, angless, true)
			
			
		end
		
		
		
		
		
		
		
		
		
		print(tostring(currentEditorItems.scale == nil ))
		if(components) then
			
			if currentEditorItems.scale == nil then
				
				
				local visualScale = checkDefaultScale(components)
				currentEditorItems.defaultScale = {
					x = visualScale.x * 100,
					y = visualScale.x * 100,
					z = visualScale.x * 100,
				}
				currentEditorItems.scale = {
					x = visualScale.x * 100,
					y = visualScale.y * 100,
					z = visualScale.z * 100,
				}
			end
			
			if proportionalMode then
				
				currentEditorItems.scale.x, scaleChanged = ImGui.DragFloat("##scale", currentEditorItems.scale.x, 0.1)
				
				
				if scaleChanged then
					currentEditorItems.scale.y = currentEditorItems.scale.x
					currentEditorItems.scale.z = currentEditorItems.scale.x
				end
				
				
				
				else
				currentEditorItems.scale.x, used = ImGui.DragFloat("##scaleX", currentEditorItems.scale.x, 0.1)
				if used then scaleChanged = true end
				
				currentEditorItems.scale.y, used = ImGui.DragFloat("##scaleY", currentEditorItems.scale.y, 0.1)
				if used then scaleChanged = true end
				
				currentEditorItems.scale.z, used = ImGui.DragFloat("##scaleZ", currentEditorItems.scale.z, 0.1)
				if used then scaleChanged = true end
			end
			
			
			
			if scaleChanged then
				Cron.After(0.7, function()
					local entityid = currentEditorItems.entityId
					local entity = Game.FindEntityByID(entityid)
					local components = checkForValidComponents(entity)
					setItemScale(entity, currentEditorItems, currentEditorItems.scale,proportionalMode)
				end)
			end
			
			proportionalMode, proportionalModeChanged = ImGui.Checkbox("Proportional Mode", proportionalMode)
			
			if proportionalModeChanged then
				
				setItemScale(entity, currentEditorItems, currentEditorItems.scale,proportionalMode)
			end
			
		end
		if(currentEditorItems.Tag ~= nil) then
			
			if ImGui.Button("Delete", 300, 0) then
				
				local housingitem = getHousing(currentEditorItems.Tag,currentEditorItems.X,currentEditorItems.Y,currentEditorItems.Z)
				despawnItem(currentEditorItems.entityId)
				deleteHousing(housingitem.Id)
				
				table.remove(currentItemSpawned,currentEditorItems.index)
				currentEditorItems = {}
				
				openEditItems = false
				
				
			end
			
			if ImGui.Button("Save and close", 300, 0) then
				
				
				currentEditorItems = {}
				
				openEditItems = false
			end
			
			
			
			
			
		end
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end



function EditTemplatePositionWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Housing Template Position Edition") then
		
		
		
		
		
		
		posstep =  ImGui.DragFloat("##post", posstep, 0.1, 0.1, 10, "%.3f Position Step")
		
		
		
		rotstep =  ImGui.DragFloat("##rost", rotstep, 0.1, 0.1, 10, "%.3f Rotation Step")
		
		
		editHousingTemplateX =  ImGui.DragFloat("##x", editHousingTemplateX, posstep, -9999, 9999, "%.3f X")
		
		editHousingTemplateY = ImGui.DragFloat("##y", editHousingTemplateY, posstep, -9999, 9999, "%.3f Y")
		
		editHousingTemplateZ = ImGui.DragFloat("##z", editHousingTemplateZ, posstep, -9999, 9999, "%.3f Z")
		
		
		
		
		editHousingTemplateYaw =  ImGui.DragFloat("##yaw", editHousingTemplateYaw, rotstep, -9999, 9999, "%.3f YAW")
		
		editHousingTemplatePitch = ImGui.DragFloat("##pitch", editHousingTemplatePitch, rotstep, -9999, 9999, "%.3f PITCH")
		
		editHousingTemplateRoll = ImGui.DragFloat("##roll", editHousingTemplateRoll, rotstep, -9999, 9999, "%.3f ROLL")
		
		
		
		
		
		if ImGui.Button("Apply", 300, 0) then
			
			
			
			if(#currentItemSpawned > 0) then
				
				for i,v in ipairs(currentItemSpawned) do
					
					if(v.fromTemplate ~= nil and v.fromTemplate == true) then
						
						local poss = Vector4.new( v.X + editHousingTemplateX, v.Y + editHousingTemplateY,  v.Z + editHousingTemplateZ,1)
						
						
						local angless = EulerAngles.new(v.Roll + editHousingTemplateRoll, v.Pitch + editHousingTemplatePitch,  v.Yaw + editHousingTemplateYaw)
						
						
						
						
						updateItemPosition(v, poss, angless, true)
						
					end
					
					
				end
				
				
			end
			
			
			editHousingTemplateX = 0
			editHousingTemplateY = 0
			editHousingTemplateZ = 0
			
			editHousingTemplateYaw = 0
			editHousingTemplatePitch = 0
			editHousingTemplateRoll = 0
			
			
			
			
			
		end
		
		
		if ImGui.Button("Close", 300, 0) then
			
			editHousingTemplateY = 0
			editHousingTemplateZ = 0
			
			editHousingTemplateYaw = 0
			editHousingTemplatePitch = 0
			editHousingTemplateRoll = 0
			
			openEditHousingTemplate = false
			
			
		end
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end

function OptionsEditWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Answers") then
		
		
		
		currentEditorOptions.value.Description = ImGui.InputTextMultiline("V's Answer", currentEditorOptions.value.Description,100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		
		
		
		triggerNode(getLang("trigger_condition"),currentEditorOptions.value,"trigger")
		
		EditorAddColor = ImGui.Checkbox("Custom color ?", EditorAddColor)
		
		
		
		if(EditorAddColor == true and currentEditorOptions["style"] == nil)then
			
			currentEditorOptions["style"]["bgcolor"] = {}
			currentEditorOptions["style"]["bgcolor"]["red"] = 0
			currentEditorOptions["style"]["bgcolor"]["green"] = 0
			currentEditorOptions["style"]["bgcolor"]["blue"] = 0
			currentEditorOptions["style"]["bgcolor"]["opacity"] = 1
			
			currentEditorOptions["style"]["textcolor"] = {}
			currentEditorOptions["style"]["textcolor"]["red"] = 0
			currentEditorOptions["style"]["textcolor"]["green"] = 0
			currentEditorOptions["style"]["textcolor"]["blue"] = 0
			currentEditorOptions["style"]["textcolor"]["opacity"] = 1
			
		end
		
		
		if(EditorAddColor == true)then
			
			if ImGui.Button("Toggle Color Picker", 300, 0) then
				colorPickerModeRGB = true
				
				if(openColorPicker == false)then
					openColorPicker = true
					else
					openColorPicker = false
					
				end
				
				
				
			end
			
			listDictionnaryIntNode("BackgroundColor :","Background Color of the element.",currentEditorOptions["style"],"bgcolor")
			listDictionnaryIntNode("FontColor :","Font Color of the element",currentEditorOptions["style"],"textcolor")
			
		end
		
		
		if(tableHasKey(currentEditorOptions.value["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),currentEditorOptions.value,"requirement","trigger")
			
			actionNode(getLang("trigger_action"),currentEditorOptions.value,"action")
			
			
		end
		
		if(currentEditorOptions.value.Description ~= nil and currentEditorOptions.value.Description ~= "") then
			
			
			
			if ImGui.Button("Save and close", 300, 0) then
				
				
				
				activeEditedDialog["options"][currentEditorOptions.index] = currentEditorOptions.value
				
				currentEditorOptions = {}
				
				openEditOptions = false
			end
			
			
			if ImGui.Button("Close", 300, 0) then
				
				currentEditorOptions = {}
				
				openEditOptions = false
			end
			
			
		end
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end

function ControlsEditWindows()
	
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin("Controls") then
		
		ImGui.Text("Choose an type : ")
		ImGui.Spacing()
		
		
		
		--debugPrint(2,toti)
		if ImGui.BeginCombo("##My Combo Box", toti) then -- Remove the ## if you'd like for the title to display above combo box
			
			for i=1, #controltypelist do
				
				if ImGui.Selectable(controltypelist[i]) then
					selectedControlType = controltypelist[i]
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
			end
			
			ImGui.EndCombo()
		end
		
		currentEditorControls.child.type = selectedControlType
		if(currentEditorControls.child.type ~= "" or currentEditorControls.child.type ~= nil) then
			
			ImGui.Text("Selected Type : "..currentEditorControls.child.type )
			
		end
		if(currentEditorControls.child.type == "label") then
			local label = ""
			
			
			if(currentEditorControls.child.trigger == nil) then
				currentEditorControls.child.trigger = {}
				currentEditorControls.child.requirement  = {}
				currentEditorControls.child.value = {}
				currentEditorControls.child.value.type = ""
				
				
				
			end
			if currentEditorControls.child.tag == nil then
				
				currentEditorControls.child.tag = ""
				currentEditorControls.child.parent = ""
				
			end
			currentEditorControls.child.tag = ImGui.InputText(getLang("editor_tag"), currentEditorControls.child.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
			triggerNode(getLang("trigger_condition"),currentEditorControls.child,"trigger")
			
			if(tableHasKey(currentEditorControls.child["trigger"])) then
				
				requirementNode(getLang("trigger_condition_requirement"),currentEditorControls.child,"requirement","trigger")
				
				
				if(currentEditorControls.child.value == nil) then
					
					currentEditorControls.child.value = {}
					
					
				end
				
				local value = ""
				ImGui.Text("Value : ")
				if(currentEditorControls.child.value.type ~= nil) then
					
					value = currentEditorControls.child.value.type
					
				end
				
				if ImGui.BeginCombo("##My Combo Box333", "") then -- Remove the ## if you'd like for the title to display above combo box
					
					for i=1, #controltypevaluelist  do
						
						if ImGui.Selectable(controltypevaluelist[i]) then
							selectedControlvalue = controltypevaluelist[i]
							
							ImGui.SetItemDefaultFocus()
						end
						
						
						
					end
					
					ImGui.EndCombo()
				end
				
				currentEditorControls.child.value.type = selectedControlvalue
				ImGui.Text("Selected : "..currentEditorControls.child.value.type)
				
				if currentEditorControls.child.value.type == "text" then
					if(currentEditorControls.child.value.value == nil) then
						
						currentEditorControls.child.value.value = ""
						
					end
					currentEditorControls.child.value.value = ImGui.InputText("Text",currentEditorControls.child.value.value, 100, ImGuiInputTextFlags.AutoSelectAll)
				end
				
				if currentEditorControls.child.value.type == "number" then
					if(currentEditorControls.child.value.value == nil) then
						
						currentEditorControls.child.value.value = 0
						
					end
					currentEditorControls.child.value.value = ImGui.InputFloat("Number", 0, 1, 10, "%.1f", ImGuiInputTextFlags.None)
				end
				
				if currentEditorControls.child.value.type == "score" then
					if(currentEditorControls.child.value.tag == nil) then
						
						currentEditorControls.child.value.tag = ""
						currentEditorControls.child.value.key = ""
						
					end
					ImGui.Text("Tag is the tag fo the score you want target. Key is the field of the score that you want display (Score or Quantity)")
					currentEditorControls.child.value.tag = ImGui.InputText(getLang("editor_tag"), currentEditorControls.child.value.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
					currentEditorControls.child.value.key = ImGui.InputText("Key (Score/Quantity)", currentEditorControls.child.value.key, 100, ImGuiInputTextFlags.AutoSelectAll)
				end
				
				if currentEditorControls.child.value.type == "variable" then
					if(currentEditorControls.child.value.tag == nil) then
						
						currentEditorControls.child.value.tag = ""
						currentEditorControls.child.value.key = ""
						
					end
					ImGui.Text("Tag is the tag fo the variable you want target. Key is the field of the variable that you want display")
					currentEditorControls.child.value.tag = ImGui.InputText(getLang("editor_tag"),currentEditorControls.child.value.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
					currentEditorControls.child.value.key = ImGui.InputText("Key",	currentEditorControls.child.value.key, 100, ImGuiInputTextFlags.AutoSelectAll)
				end
				
				
				
			end
			
		end
		
		if(currentEditorControls.child.type == "image") then
			
			local label = ""
			if(currentEditorControls.child.tweak == nil) then
				currentEditorControls.child.tweak = ""
				currentEditorControls.child.tag = ""
				currentEditorControls.child.parent = ""
			end
			
			
			if(currentEditorControls.child.trigger == nil) then
				currentEditorControls.child.trigger = {}
				currentEditorControls.child.requirement  = {}
				currentEditorControls.child.action = {}
				
			end
			
			currentEditorControls.child.tweak = ImGui.InputText("TweakID", currentEditorControls.child.tweak, 100, ImGuiInputTextFlags.AutoSelectAll)
			currentEditorControls.child.tag = ImGui.InputText(getLang("editor_tag"), currentEditorControls.child.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
			
			triggerNode("Condition :",currentEditorControls.child,"trigger")
			
			if(tableHasKey(currentEditorControls.child["trigger"])) then
				
				requirementNode("Requirement :",currentEditorControls.child,"requirement","trigger")
				
				if(#currentEditorControls.child["requirement"] > 0) then
					if(currentEditorControls.child.action == nil) then
						
						currentEditorControls.child.action = {}
						
						
					end
					
					
					
					else
					ImGui.Text("Need requirement for be displayed")
				end
				
				
				
			end
			
		end
		
		if(currentEditorControls.child.type == "button") then
			
			local label = ""
			if(currentEditorControls.child.title == nil) then
				currentEditorControls.child.title = ""
				currentEditorControls.child.tag = ""
				currentEditorControls.child.parent = ""
			end
			
			
			if(currentEditorControls.child.trigger == nil) then
				currentEditorControls.child.trigger = {}
				currentEditorControls.child.requirement  = {}
				currentEditorControls.child.action = {}
				
			end
			if currentEditorControls.child.tag == nil then
				
				currentEditorControls.child.tag = ""
				currentEditorControls.child.title = ""
				
				
			end
			currentEditorControls.child.title = ImGui.InputText("Title", currentEditorControls.child.title, 100, ImGuiInputTextFlags.AutoSelectAll)
			currentEditorControls.child.tag = ImGui.InputText(getLang("editor_tag"), currentEditorControls.child.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
			
			triggerNode("Condition :",currentEditorControls.child,"trigger")
			
			if(tableHasKey(currentEditorControls.child["trigger"])) then
				
				requirementNode("Requirement :",currentEditorControls.child,"requirement","trigger")
				
				if(#currentEditorControls.child["requirement"] > 0) then
					if(currentEditorControls.child.action == nil) then
						
						currentEditorControls.child.action = {}
						
						
					end
					
					actionNode(getLang("trigger_action"),currentEditorControls.child,"action")
					
					else
					ImGui.Text(getLang("need_requirement"))
				end
				
				
				
			end
			
		end
		
		if(currentEditorControls.child.type == "scrollarea" or currentEditorControls.child.type == "area" or currentEditorControls.child.type == "vertical_area") then
			local label = ""
			
			
			if(currentEditorControls.child.trigger == nil) then
				currentEditorControls.child.trigger = {}
				currentEditorControls.child.requirement  = {}
				
				
			end
			if currentEditorControls.child.tag == nil then
				
				currentEditorControls.child.tag = ""
				currentEditorControls.child.parent = ""
				
				
			end
			
			currentEditorControls.child.tag = ImGui.InputText(getLang("editor_tag"), currentEditorControls.child.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
			triggerNode(getLang("trigger_condition"),currentEditorControls.child,"trigger")
			
			if(tableHasKey(currentEditorControls.child["trigger"])) then
				
				requirementNode(getLang("trigger_condition_requirement"),currentEditorControls.child,"requirement","trigger")
				
				
				
				
				
			end
		end
		
		if(currentEditorControls.child.parent == nil)then
			
			currentEditorControls.child.parent = ""
			
		end
		currentEditorControls.child.parent = ImGui.InputText("Parent tag : (Empty if not needed)", currentEditorControls.child.parent, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		if(currentEditorControls.child.margin == nil) then
			
			currentEditorControls.child.margin = {}
			
		end
		
		if(currentEditorControls.child.style == nil) then
			
			currentEditorControls.child.style = {}
			
			
			
		end
		
		listDictionnaryIntNode("Margin :","Margin of the element, can be : top||left||bottom||right",currentEditorControls.child,"margin")
		listDictionnaryIntNode("Style :","Style of the element, can be : width||height||fontsize",currentEditorControls.child,"style")
		
		
		
		EditorAddColor = ImGui.Checkbox("Custom color ?", EditorAddColor)
		
		
		
		if(EditorAddColor == true and currentEditorControls.child["bgcolor"] == nil)then
			
			currentEditorControls.child["bgcolor"] = {}
			currentEditorControls.child["bgcolor"]["red"] = 0
			currentEditorControls.child["bgcolor"]["green"] = 0
			currentEditorControls.child["bgcolor"]["blue"] = 0
			currentEditorControls.child["bgcolor"]["opacity"] = 0
			
			currentEditorControls.child["textcolor"] = {}
			currentEditorControls.child["textcolor"]["red"] = 0
			currentEditorControls.child["textcolor"]["green"] = 0
			currentEditorControls.child["textcolor"]["blue"] = 0
			currentEditorControls.child["textcolor"]["opacity"] = 0
			
		end
		
		
		if(EditorAddColor == true)then
			
			if ImGui.Button("Toggle Color Picker", 300, 0) then
				colorPickerModeRGB = true
				
				if(openColorPicker == false)then
					openColorPicker = true
					else
					openColorPicker = false
					
				end
				
				
				
			end
			
			listDictionnaryIntNode("BackgroundColor :","Background Color of the element.",currentEditorControls.child,"bgcolor")
			listDictionnaryIntNode("FontColor :","Font Color of the element",currentEditorControls.child,"textcolor")
			
		end
		
		
		
		if(currentEditorControls.child.type ~= nil and currentEditorControls.child.type ~= "") then
			
			
			
			if ImGui.Button("Save and close", 300, 0) then
				
				if(currentEditorControls.index ~= nil) then
					
					activeEditedInterfaces["controls"][currentEditorControls.index] = currentEditorControls.child
					--debugPrint(2,"edited")
					else
					--debugPrint(2,"saved")
					table.insert(activeEditedInterfaces["controls"],currentEditorControls.child)
				end
				
				currentEditorControls = {}
				
				
				openControlsEditor = false
			end
			
			
			if ImGui.Button("Close", 300, 0) then
				
				currentEditorControls = {}
				
				
				openControlsEditor = false
			end
		end
		
		
		
		
		
		
	end
	
	
	
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
	
	
end



function ObjectiveNewWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add New Objective") then
		
		
		
		
		
		currentSelectObjective.title = ImGui.InputText("Title", currentSelectObjective.title, 100, ImGuiInputTextFlags.AutoSelectAll)
		currentSelectObjective.tag = ImGui.InputText(getLang("editor_tag"), currentSelectObjective.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		
		if ImGui.BeginCombo("State :", defaultJournalEntryState) then
			
			
			for k,v in pairs(EgameJournalEntryState) do
				
				if ImGui.Selectable(k, (currentSelectObjective.state == currentSelectObjective[k])) then
					currentSelectObjective.state = EgameJournalEntryState[k]
					
					defaultJournalEntryState = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		currentSelectObjective.isoptionnal = ImGui.Checkbox("Is Optionnal ?", currentSelectObjective.isoptionnal)
		
		triggerNode(getLang("trigger_condition"),currentSelectObjective,"trigger")
		
		
		
		
		if(tableHasKey(currentSelectObjective["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),currentSelectObjective,"requirement","trigger")
			if(#currentSelectObjective["requirement"] > 0) then
				
				
				actionNode(getLang("trigger_action"),currentSelectObjective,"action")
				actionNode("Fail Action :",currentSelectObjective,"failaction")
				actionNode("Resume Action :",currentSelectObjective,"resume_action")
				
				
				if(
					currentSelectObjective.tag ~= nil 
					and currentSelectObjective.tag ~= "" 
					and currentSelectObjective.title ~= nil 
					and #currentSelectObjective.action > 0 
					
				) then
				
				
				
				if ImGui.Button("Save and close", 300, 0) then
					
					
					table.insert(activeEditedQuest["objectives"],currentSelectObjective)
					
					
					currentSelectObjective = {}
					
					openNewObjective = false
				end
				
				
				if ImGui.Button("Close", 300, 0) then
					
					currentSelectObjective = {}
					
					openNewObjective = false
				end
				
				
				end
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
			
		end
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end

function ObjectiveEditWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Objective") then
		
		
		
		
		
		currentSelectObjective.title = ImGui.InputText("Title", currentSelectObjective.title, 100, ImGuiInputTextFlags.AutoSelectAll)
		currentSelectObjective.tag = ImGui.InputText(getLang("editor_tag"), currentSelectObjective.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		
		if ImGui.BeginCombo("State :", defaultJournalEntryState) then
			
			
			for k,v in pairs(EgameJournalEntryState) do
				
				if ImGui.Selectable(k, (currentSelectObjective.state == currentSelectObjective[k])) then
					currentSelectObjective.state = EgameJournalEntryState[k]
					
					defaultJournalEntryState = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		currentSelectObjective.isoptionnal = ImGui.Checkbox("Is Optionnal ?", currentSelectObjective.isoptionnal)
		
		triggerNode(getLang("trigger_condition"),currentSelectObjective,"trigger")
		
		
		
		
		if(tableHasKey(currentSelectObjective["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),currentSelectObjective,"requirement","trigger")
			if(#currentSelectObjective["requirement"] > 0) then
				
				
				actionNode(getLang("trigger_action"),currentSelectObjective,"action")
				actionNode("Fail Action :",currentSelectObjective,"failaction")
				actionNode("Resume Action :",currentSelectObjective,"resume_action")
				
				
				if(
					currentSelectObjective.tag ~= nil 
					and currentSelectObjective.tag ~= "" 
					and currentSelectObjective.title ~= nil 
					and #currentSelectObjective.action > 0 
					
				) then
				
				
				
				if ImGui.Button("Save and close", 300, 0) then
					
					
					activeEditedQuest["objectives"][currentSelectObjective.index] = currentSelectObjective
					
					
					
					
					currentSelectObjective = {}
					
					openEditObjective = false
				end
				
				
				if ImGui.Button("Close", 300, 0) then
					
					currentSelectObjective = {}
					
					openEditObjective = false
				end
				
				
				end
				else
				ImGui.Text(getLang("need_requirement"))
			end
			
			
			
			
		end
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end




function ConversationNewWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add New Conversation") then
		
		
		
		
		
		currentSelectConversation.name = ImGui.InputText("Title", currentSelectConversation.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		currentSelectConversation.tag = ImGui.InputText(getLang("editor_tag"), currentSelectConversation.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		currentSelectConversation.unlock = ImGui.Checkbox("Is Unlocked ?", currentSelectConversation.unlock)
		
		MessageNode(currentSelectConversation)
		
		
		
		
		if(tableHasKey(currentSelectConversation["message"])) then
			
			
			
			
			
			
			if(
				currentSelectConversation.tag ~= nil 
				and currentSelectConversation.tag ~= "" 
				and currentSelectConversation.name ~= nil 
				and #currentSelectConversation.message > 0 
				
			) then
			
			
			
			if ImGui.Button("Save and close", 300, 0) then
				
				
				table.insert(activeEditedPhoneDialog["conversation"],currentSelectConversation)
				
				
				currentSelectConversation = {}
				
				openNewConversation = false
			end
			
			
			if ImGui.Button("Close", 300, 0) then
				
				currentSelectConversation = {}
				
				openNewConversation = false
			end
			
			
			end
			else
			ImGui.Text("Need at least 1 Message for valid")
			
			
			
			
			
		end
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end

function ConversationEditWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add New Conversation") then
		
		
		
		
		
		currentSelectConversation.name = ImGui.InputText("Title", currentSelectConversation.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		currentSelectConversation.tag = ImGui.InputText(getLang("editor_tag"), currentSelectConversation.tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		currentSelectConversation.unlock = ImGui.Checkbox("Is Unlocked ?", currentSelectConversation.unlock)
		
		MessageNode(currentSelectConversation)
		
		
		
		
		if(tableHasKey(currentSelectConversation["message"])) then
			
			
			
			
			
			
			if(
				currentSelectConversation.tag ~= nil 
				and currentSelectConversation.tag ~= "" 
				and currentSelectConversation.name ~= nil 
				and #currentSelectConversation.message > 0 
				
			) then
			
			
			
			if ImGui.Button("Save and close", 300, 0) then
				
				
				activeEditedPhoneDialog["conversation"][currentSelectConversation.index] = currentSelectConversation
				
				
				
				
				currentSelectConversation = {}
				
				openEditConversation = false
			end
			
			
			if ImGui.Button("Close", 300, 0) then
				
				currentSelectConversation = {}
				
				openEditConversation = false
			end
			
			end
			else
			ImGui.Text("Need at least 1 Message for valid")
			
			
			
			
			
		end
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end




function MessageNewWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add New Message") then
		
		
		
		
		currentSelectMessage.tag = ImGui.InputText(getLang("editor_tag"), currentSelectMessage.tag, 100, ImGuiInputTextFlags.AutoSelectAll)	
		
		currentSelectMessage.text = ImGui.InputTextMultiline("Text", currentSelectMessage.text ,100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		
		currentSelectMessage.unlock = ImGui.Checkbox("Is unlocked ?", currentSelectMessage.unlock)
		
		currentSelectMessage.readed = ImGui.Checkbox("Is readed ?", currentSelectMessage.readed)
		
		currentSelectMessage.unlocknext = ImGui.InputText("Unlock Next Message Tag (empty if none)", currentSelectMessage.unlocknext, 100, ImGuiInputTextFlags.AutoSelectAll)	
		
		
		if ImGui.BeginCombo("Sender :", defaulftGameMessageSender) then
			
			
			for k,v in pairs(EgameMessageSender) do
				
				if ImGui.Selectable(k, (currentSelectMessage.sender == v)) then
					currentSelectMessage.sender = EgameMessageSender[k]
					
					defaulftGameMessageSender = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		ChoicesNode(currentSelectMessage)
		
		
		
		
		
		
		
		
		
		
		if(
			currentSelectMessage.tag ~= nil 
			and currentSelectMessage.tag ~= "" 
			and currentSelectMessage.text ~= nil 
			
		) then
		
		
		
		if ImGui.Button("Save and close", 300, 0) then
			
			
			table.insert(currentSelectConversation["message"],currentSelectMessage)
			
			
			currentSelectMessage = {}
			
			openNewMessage = false
		end
		
		
		if ImGui.Button("Close", 300, 0) then
			
			currentSelectMessage = {}
			
			openNewMessage = false
		end
		
		
		end
		else
		ImGui.Text("Need an tag and an text for valid")
		
		
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end

function MessageEditWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	if ImGui.Begin("Edit Message") then
		
		
		
		
		currentSelectMessage.tag = ImGui.InputText(getLang("editor_tag"), currentSelectMessage.tag, 100, ImGuiInputTextFlags.AutoSelectAll)	
		
		currentSelectMessage.text = ImGui.InputTextMultiline("Text", currentSelectMessage.text ,100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		
		currentSelectMessage.unlock = ImGui.Checkbox("Is unlocked ?", currentSelectMessage.unlock)
		
		currentSelectMessage.readed = ImGui.Checkbox("Is readed ?", currentSelectMessage.readed)
		
		currentSelectMessage.unlocknext = ImGui.InputText("Unlock Next Message Tag (empty if none)", currentSelectMessage.unlocknext, 100, ImGuiInputTextFlags.AutoSelectAll)	
		
		
		if ImGui.BeginCombo("Sender :", defaulftGameMessageSender) then
			
			
			for k,v in pairs(EgameMessageSender) do
				
				if ImGui.Selectable(k, (currentSelectMessage.sender == v)) then
					currentSelectMessage.sender = EgameMessageSender[k]
					
					defaulftGameMessageSender = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		ChoicesNode(currentSelectMessage)
		
		
		
		
		
		
		
		
		
		
		if(
			currentSelectMessage.tag ~= nil 
			and currentSelectMessage.tag ~= "" 
			and currentSelectMessage.text ~= nil 
			
		) then
		
		
		
		if ImGui.Button("Save and close", 300, 0) then
			
			currentSelectConversation["message"][currentSelectMessage.index] = currentSelectMessage
			
			
			currentSelectMessage = {}
			
			openEditMessage = false
		end
		
		
		if ImGui.Button("Close", 300, 0) then
			
			currentSelectMessage = {}
			
			openEditMessage = false
		end
		
		
		end
		else
		ImGui.Text("Need an tag and an text for valid")
		
		
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end



function ChoiceNewWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Add New Choice") then
		
		
		
		
		currentSelectChoice.tag = ImGui.InputText(getLang("editor_tag"), currentSelectChoice.tag, 100, ImGuiInputTextFlags.AutoSelectAll)	
		
		currentSelectChoice.text = ImGui.InputTextMultiline("Text", currentSelectChoice.text ,100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		
		currentSelectChoice.unlocknext = ImGui.InputText("Unlock Next Message Tag (empty if none)", currentSelectChoice.unlocknext, 100, ImGuiInputTextFlags.AutoSelectAll)	
		
		
		currentSelectChoice.action_bypassmenu_execution = ImGui.Checkbox("Action execution by pass in-menu limitation (use at your risk !!!)", currentSelectChoice.action_bypassmenu_execution)
		
		
		
		triggerNode(getLang("trigger_condition"),currentSelectChoice,"trigger")
		
		
		if(tableHasKey(currentSelectChoice["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),currentSelectChoice,"requirement","trigger")
			if(#currentSelectChoice["requirement"] > 0) then
				
				
				actionNode(getLang("trigger_action"),currentSelectChoice,"action")
				
				
				if(
					currentSelectChoice.tag ~= nil 
					and currentSelectChoice.tag ~= "" 
					and currentSelectChoice.text ~= nil 
					
				) then
				
				
				
				if ImGui.Button("Save and close", 300, 0) then
					
					
					table.insert(currentSelectMessage["choices"],currentSelectChoice)
					
					
					currentSelectChoice = {}
					
					openNewChoice = false
				end
				
				
				if ImGui.Button("Close", 300, 0) then
					
					currentSelectChoice = {}
					
					openNewChoice = false
				end
				else
				ImGui.Text("Need an tag and an text for valid")
				
				end
				
				
				else
				ImGui.Text(getLang("need_requirement"))
				
			end
			
			else
			ImGui.Text("Need trigger for unlock action")
		end
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end



function ChoiceEditWindows()
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Edit Choice") then
		
		
		
		
		currentSelectChoice.tag = ImGui.InputText(getLang("editor_tag"), currentSelectChoice.tag, 100, ImGuiInputTextFlags.AutoSelectAll)	
		
		currentSelectChoice.text = ImGui.InputTextMultiline("Text", currentSelectChoice.text ,100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		
		currentSelectChoice.unlocknext = ImGui.InputText("Unlock Next Message Tag (empty if none)", currentSelectChoice.unlocknext, 100, ImGuiInputTextFlags.AutoSelectAll)	
		
		
		currentSelectChoice.action_bypassmenu_execution = ImGui.Checkbox("Action execution by pass in-menu limitation (use at your risk !!!)", currentSelectChoice.action_bypassmenu_execution)
		
		
		
		triggerNode(getLang("trigger_condition"),currentSelectChoice,"trigger")
		
		
		if(tableHasKey(currentSelectChoice["trigger"])) then
			
			requirementNode(getLang("trigger_condition_requirement"),currentSelectChoice,"requirement","trigger")
			if(#currentSelectChoice["requirement"] > 0) then
				
				
				actionNode(getLang("trigger_action"),currentSelectChoice,"action")
				
				
				if(
					currentSelectChoice.tag ~= nil 
					and currentSelectChoice.tag ~= "" 
					and currentSelectChoice.text ~= nil 
					
				) then
				
				
				
				if ImGui.Button("Save and close", 300, 0) then
					
					
					
					currentSelectMessage["choices"][currentSelectChoice.index] = currentSelectChoice
					
					currentSelectChoice = {}
					
					openEditChoice = false
				end
				
				
				if ImGui.Button("Close", 300, 0) then
					
					currentSelectChoice = {}
					
					openEditChoice = false
				end
				else
				ImGui.Text("Need an tag and an text for valid")
				
				end
				
				
				else
				ImGui.Text(getLang("need_requirement"))
				
			end
			
			else
			ImGui.Text("Need trigger for unlock action")
		end
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
end


--Node Tree
function RoomNode(obj)
	
	if ImGui.TreeNode("Rooms") then
		
		
		if(#obj["rooms"] > 0) then
			for i=1,#obj["rooms"] do
				
				
				if ImGui.Button(obj["rooms"][i]["name"], 300, 0) then
					currentSelectRoom = obj["rooms"][i]
					currentSelectRoom.index = i
					currentSelectRoom.parent = "rooms"
					currentSelectRoom.tagprefix = obj.tag.."_"
					currentSelectRoom.canEat = false
					currentSelectRoom.canDrink = false
					currentSelectRoom.canDo = false
					
					
					if(#currentSelectRoom.type > 0) then
						for i = 1,#currentSelectRoom.type  do
							if(currentSelectRoom.type[i] == 0) then
								currentSelectRoom.canEat = true
							end
							
							if(currentSelectRoom.type[i] == 1) then
								currentSelectRoom.canDrink = true
							end
							
							if(currentSelectRoom.type[i] == 2) then
								currentSelectRoom.canDo = true
							end
						end
						
					end
					openEditRoom = true
				end
				
				
				
			end
			
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentSelectRoom = {}
			currentSelectRoom.parent = "rooms"
			currentSelectRoom.tagprefix = obj.tag.."_"
			currentSelectRoom.canEat = false
			currentSelectRoom.canDrink = false
			currentSelectRoom.canDo = false
			currentSelectRoom.name = ""
			currentSelectRoom.tag = ""
			currentSelectRoom.posX = 0
			currentSelectRoom.posY = 0
			currentSelectRoom.posZ= 0
			currentSelectRoom.range = 0
			currentSelectRoom.Zrange = 0
			currentSelectRoom["trigger"] = {}
			currentSelectRoom["requirement"] = {}
			currentSelectRoom["action"] = {}
			openNewRoom = true
		end
		ImGui.TreePop()
	end
	
end

function ObjectiveNode(obj)
	
	if ImGui.TreeNode("Objectives") then
		
		
		if(#obj["objectives"] > 0) then
			for i=1,#obj["objectives"] do
				
				
				if ImGui.Button(obj["objectives"][i]["title"], 300, 0) then
					currentSelectObjective = {}
					currentSelectObjective = obj["objectives"][i]
					currentSelectObjective.index = i
					currentSelectObjective.parent = "objectives"
					currentSelectObjective.tagprefix = obj.tag.."_"
					
					
					
					
					
					openEditObjective = true
				end
				
				
				
			end
			
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentSelectObjective = {}
			currentSelectObjective.parent = "objectives"
			currentSelectObjective.tagprefix = obj.tag.."_"
			
			
			currentSelectObjective.title = ""
			currentSelectObjective.tag = ""
			currentSelectObjective.state = EgameJournalEntryState.Active
			currentSelectObjective.isoptionnal = false
			
			
			currentSelectObjective["trigger"] = {}
			currentSelectObjective["requirement"] = {}
			currentSelectObjective["action"] = {}
			currentSelectObjective["failaction"] = {}
			currentSelectObjective["resume_action"] = {}
			
			
			
			openNewObjective = true
		end
		ImGui.TreePop()
	end
	
end





function ConversationNode(obj)
	
	if ImGui.TreeNode("Conversation") then
		
		
		if(#obj["conversation"] > 0) then
			for i=1,#obj["conversation"] do
				
				
				if ImGui.Button(obj["conversation"][i]["name"], 300, 0) then
					currentSelectConversation = obj["conversation"][i]
					currentSelectConversation.index = i
					currentSelectConversation.parent = "conversation"
					currentSelectConversation.tagprefix = obj.tag.."_"
					
					
					
					
					
					openEditConversation = true
				end
				
				
				
			end
			
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentSelectConversation = {}
			currentSelectConversation.parent = "conversation"
			currentSelectConversation.tagprefix = obj.tag.."_"
			
			
			currentSelectConversation.name = ""
			currentSelectConversation.tag = ""
			currentSelectConversation.unlock = false
			
			
			currentSelectConversation["message"] = {}
			
			
			
			openNewConversation = true
		end
		ImGui.TreePop()
	end
	
end

function MessageNode(obj)
	
	if ImGui.TreeNode("Message") then
		
		
		if(#obj["message"] > 0) then
			for i=1,#obj["message"] do
				
				
				if ImGui.Button(obj["message"][i]["tag"], 300, 0) then
					currentSelectMessage = obj["message"][i]
					currentSelectMessage.index = i
					currentSelectMessage.parent = "message"
					currentSelectMessage.tagprefix = obj.tag.."_"
					
					
					
					
					
					openEditMessage = true
				end
				
				
				
			end
			
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentSelectMessage = {}
			currentSelectMessage.parent = "message"
			currentSelectMessage.tagprefix = obj.tag.."_"
			
			currentSelectMessage.tag = ""
			currentSelectMessage.text = ""
			currentSelectMessage.sender = 0
			currentSelectMessage.unlock = false
			currentSelectMessage.readed = false
			currentSelectMessage.unlocknext = ""
			
			
			
			
			currentSelectMessage["choices"] = {}
			
			
			
			openNewMessage = true
		end
		ImGui.TreePop()
	end
	
end


function ChoicesNode(obj)
	
	if ImGui.TreeNode("Choices") then
		
		
		if(#obj["choices"] > 0) then
			for i=1,#obj["choices"] do
				
				
				if ImGui.Button(obj["choices"][i]["tag"], 300, 0) then
					currentSelectChoice = obj["choices"][i]
					currentSelectChoice.index = i
					currentSelectChoice.parent = "choices"
					currentSelectChoice.tagprefix = obj.tag.."_"
					
					
					
					
					
					openEditChoice = true
				end
				
				
				
			end
			
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentSelectChoice = {}
			currentSelectChoice.parent = "choices"
			currentSelectChoice.tagprefix = obj.tag.."_"
			
			currentSelectChoice.tag = ""
			currentSelectChoice.text = ""
			currentSelectChoice.unlocknext = ""
			currentSelectChoice.action_bypassmenu_execution = false
			
			
			
			
			
			currentSelectChoice["trigger"] = {}
			currentSelectChoice["requirement"] = {}
			currentSelectChoice["action"] = {}
			
			
			
			openNewChoice = true
		end
		ImGui.TreePop()
	end
	
end


function SceneStepNode(obj)
	
	if ImGui.TreeNode("Steps of the scene ") then
		
		
		if(#obj["step"] > 0) then
			for i=1,#obj["step"] do
				
				
				if ImGui.Button("Edit "..obj["step"][i]["tag"], 300, 0) then
					currentSelectSceneStep = obj["step"][i]
					currentSelectSceneStep.index = i
					currentSelectSceneStep.parent = "step"
					currentSelectSceneStep.tagprefix = obj.tag.."_"
					
					
					
					
					
					openEditSceneStep = true
				end
				ImGui.SameLine()
				if ImGui.Button("Play "..obj["step"][i]["tag"], 300, 0) then
					
					runActionList(obj["step"][i]["action"], obj["step"][i]["tag"].."_editor", "interact",false,"editor")
				end
				
				
				
			end
			
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentSelectSceneStep = {}
			currentSelectSceneStep.parent = "step"
			currentSelectSceneStep.tagprefix = obj.tag.."_"
			
			currentSelectSceneStep.tag = ""
			
			
			currentSelectSceneStep["action"] = {}
			
			
			
			openNewSceneStep = true
		end
		ImGui.TreePop()
	end
	
end



function triggerNode(title,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		
		
		
		for key,value in pairs(obj[parent]) do
			
			
			if ImGui.Button(key, 300, 0) then
				currentEditorTrigger = {}
				currentEditorTrigger.key = key
				currentEditorTrigger.value = value
				currentEditorTrigger.parent = parent
				currentEditorTrigger.object = 0
				currentEditorTrigger.parentobj = obj
				openEditTrigger = true
			end
			
			
			
		end
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentEditorTrigger = {}
			currentEditorTrigger.key = ""
			currentEditorTrigger.value = {}
			currentEditorTrigger.parent = parent
			currentEditorTrigger.object = 0
			currentEditorTrigger.parentobj = obj
			openNewTrigger = true
		end
		
		ImGui.TreePop()
	end
	
end


function triggerActionNode(title,obj,parent,maxtrigger)
	
	if ImGui.TreeNode(title) then
		
		
		
		
		
		
		if ImGui.Button(obj[parent].name, 300, 0) then
			currentEditorTrigger = {}
			currentEditorTrigger.key = parent
			currentEditorTrigger.value = obj[parent]
			currentEditorTrigger.parent = parent
			currentEditorTrigger.object = 0
			currentEditorTrigger.parentobj = obj
			openEditActionTrigger = true
		end
		
		
		
		
		
		
		ImGui.TreePop()
	end
	
end

function requirementNode(title,obj,parent,triggerlistkey)
	
	if ImGui.TreeNode(title) then
		
		
		
		
		for i = 1, #obj[parent] do 
			
			
			
			if(#obj[parent][i] > 0) then
				if ImGui.TreeNode("Requirement Group "..i) then
					
					for y = 1, #obj[parent][i] do 
						
						
						if ImGui.BeginCombo("##existingtrigger", obj[parent][i][y]) then -- Remove the ## if you'd like for the title to display above combo box
							
							for key,value in pairs(obj[triggerlistkey]) do
								--debugPrint(2,key)
								if ImGui.Selectable(key, (key == obj[parent][i][y])) then
									obj[parent][i][y] = key
									ImGui.SetItemDefaultFocus()
								end
								
							end
							
							ImGui.EndCombo()
						end
						
						
						if ImGui.Button("Delete", 300, 0) then
							
							table.remove(obj[parent][i],y)
							
						end
						
						
						if(#obj[parent][i] > 1)then
							ImGui.Text("AND")
						end
						
						
						
					end
					
					if ImGui.BeginCombo("##newtrigger", newRequirementItem) then -- Remove the ## if you'd like for the title to display above combo box
						
						for key,value in pairs(obj[triggerlistkey]) do
							--debugPrint(2,key)
							if ImGui.Selectable(key, (key == newRequirementItem)) then
								newRequirementItem = key
								ImGui.SetItemDefaultFocus()
							end
							
						end
						
						ImGui.EndCombo()
					end
					if ImGui.Button("Add", 300, 0) then
						
						table.insert(obj[parent][i],newRequirementItem)
						newRequirementItem = ""
						
					end
					ImGui.TreePop()
				end
				
				else
				
				
				if ImGui.BeginCombo("##My Combo Box3", newRequirementItem) then -- Remove the ## if you'd like for the title to display above combo box
					
					for key,value in pairs(obj[triggerlistkey]) do
						--debugPrint(2,key)
						if ImGui.Selectable(key, (key == newRequirementItem)) then
							newRequirementItem = key
							ImGui.SetItemDefaultFocus()
						end
						
					end
					
					ImGui.EndCombo()
				end
				if ImGui.Button("Add", 300, 0) then
					
					table.insert(obj[parent][i],newRequirementItem)
					newRequirementItem = ""
				end
				
			end
			
			if(#obj[parent] == i and #obj[parent] > 1)then
				ImGui.Text("OR")
			end
			
			
			
		end
		
		if ImGui.Button("Add an new group", 300, 0) then
			local group = {}
			table.insert(obj[parent],group)
			
		end
		ImGui.TreePop()
	end
end

function actionsubNode(title,obj,key)
	
	if ImGui.TreeNode(title) then
		if(obj[key] ~= nil) then
			for i = 1, #obj[key] do 
				
				if ImGui.Button(obj[key][i].name, 300, 0) then
					
					currentEditorSubAction = {}
					currentEditorSubAction.index = i
					currentEditorSubAction.value = obj[key][i]
					currentEditorSubAction.parent = key
					currentEditorSubAction.parentobj = obj
					currentEditorSubAction.object = 0
					openEditSubAction = true
					
				end
				
			end
		end
		
		if ImGui.Button("(Add new)", 300, 0) then
			
			if(obj[key] == nil) then
				obj[key] = {}
			end
			currentEditorSubAction = {}
			
			currentEditorSubAction.value = {}
			currentEditorSubAction.parent = key
			
			currentEditorSubAction.parentobj = obj
			currentEditorSubAction.object = 0
			openEditSubAction = true
		end
		ImGui.TreePop()
	end
	
end

function actionNode(title,obj,key)
	
	if ImGui.TreeNode(title) then
		
		for i = 1, #obj[key] do 
			
			if ImGui.Button(obj[key][i].name.." ("..tostring(i)..")", 300, 0) then
				debugPrint(2,i)
				currentEditorAction = {}
				currentEditorAction.index = i
				currentEditorAction.value = obj[key][i]
				currentEditorAction.parent = key
				currentEditorAction.parentobj = obj
				currentEditorAction.object = 0
				openEditAction = true
				
			end
			
		end
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentEditorAction = {}
			
			currentEditorAction.value = {}
			currentEditorAction.parent = key
			
			currentEditorAction.parentobj = obj
			currentEditorAction.object = 0
			openNewAction = true
		end
		ImGui.TreePop()
	end
	
end

function optionsNode(title,obj)
	if ImGui.TreeNode(title) then
		
		if #obj["options"] > 0 then
			for i = 1, #obj["options"] do 
				
				if ImGui.Button(obj["options"][i].Description, 300, 0) then
					
					currentEditorOptions = {}
					currentEditorOptions.index = i
					currentEditorOptions.value = obj["options"][i]
					currentEditorOptions.parent = "options"
					currentEditorOptions.parentobj = obj
					
					openEditOptions = true
					
				end
				
			end
		end
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentEditorOptions = {}
			
			currentEditorOptions.value = {}
			currentEditorOptions.value.Description = ""
			currentEditorOptions.value["trigger"] = {}
			currentEditorOptions.value["requirement"] = {}
			currentEditorOptions.value["action"] = {}
			currentEditorOptions.parent = "options"
			currentEditorOptions.parentobj = obj
			
			
			openNewOptions = true
		end
		ImGui.TreePop()
	end
end


function controlsNode(title,help,obj,parent)
	if obj[parent] ~= nil then
		
	end
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		if #obj[parent] > 0 then
			for i = 1, #obj[parent] do 
				if(obj[parent][i] ~= nil) then
					ImGui.Text(obj[parent][i].type.." "..i)
					
					ImGui.SameLine()
					
					if ImGui.Button("Edit "..obj[parent][i].type.." "..i, 300, 0) then
						currentEditorControls = {}
						currentEditorControls.child = obj[parent][i]
						currentEditorControls.parent = "controls"
						currentEditorControls.parentobj = obj
						currentEditorControls.index = i
						
						openControlsEditor = true
					end
					ImGui.SameLine()
					if ImGui.Button("Delete "..obj[parent][i].type.." "..i, 300, 0) then
						
						obj[parent][i] = nil
						
					end
				end
			end
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentEditorControls = {}
			
			
			currentEditorControls.child= {}
			
			currentEditorControls.parent = "controls"
			currentEditorControls.parentobj = obj
			
			
			openControlsEditor = true
		end
		ImGui.TreePop()
		
	end
end

function ItemNode()
	
	if ImGui.TreeNode("Items") then
		
		
		
		
		for i,value in ipairs(currentItemSpawned) do
			
			
			if ImGui.Button(currentItemSpawned[i].Id, 600, 0) then
				currentEditorItems = currentItemSpawned[i]
				currentEditorItems.index = i
				openEditItems = true
			end
			
			
			
		end
		
		if ImGui.Button("(Add new)", 300, 0) then
			currentEditorItems = {}
			
			currentEditorItems.HouseTag = currentHouse.tag
			
			openNewItems = true
		end
		
		ImGui.TreePop()
	end
	
end


function listStringNode(title,help,obj,parent,multiline)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		if(#obj[parent] > 0) then
			for i = 1, #obj[parent] do 
				
				if ImGui.Button("Delete "..obj[parent][i], 300, 0) then
					
					table.remove(obj[parent],i)
					
				end
				
				
				
				
				
			end
		end
		
		ImGui.Text("New item :")
		if(multiline == nil or multiline == false) then
			newRequirementItem = ImGui.InputText("Name of "..title, newRequirementItem, 100, ImGuiInputTextFlags.AutoSelectAll)
			else
			newRequirementItem = ImGui.InputTextMultiline("Name of "..title, newRequirementItem, 100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		end
		if ImGui.Button("Add", 300, 0) then
			
			table.insert(obj[parent],newRequirementItem)
			newRequirementItem = ""
		end
		
		ImGui.TreePop()
	end
	
end

function listDictionnaryIntNode(title,help,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		
		for k,v in pairs(obj[parent]) do 
			
			ImGui.Text(k.." ")
			ImGui.SameLine()
			ImGui.Text(tostring(v))
			ImGui.SameLine()
			if ImGui.Button("Delete", 300, 0) then
				
				obj[parent][k] = nil
				
			end
			
			
			
			
			
		end
		
		
		ImGui.Text("New value :")
		
		dicKey = ImGui.InputText("Key", dicKey, 100, ImGuiInputTextFlags.AutoSelectAll)
		dicInt = ImGui.InputInt("Value", dicInt, 1, 10, ImGuiInputTextFlags.None)
		if ImGui.Button("Add", 300, 0) then
			obj[parent][dicKey] = dicInt
			dicKey = ""
			dicInt = 0
		end
		
		ImGui.TreePop()
	end
end


function listDictionnaryNode(title,help,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		
		for k,v in pairs(obj[parent]) do 
			
			ImGui.Text(k)
			ImGui.SameLine()
			ImGui.Text(v)
			ImGui.SameLine()
			if ImGui.Button("Delete", 300, 0) then
				
				obj[parent][k] = nil
				
			end
			
			
			
			
			
		end
		
		
		ImGui.Text("New value :")
		
		dicKey = ImGui.InputText("Key", dicKey, 100, ImGuiInputTextFlags.AutoSelectAll)
		dicValue = ImGui.InputTextMultiline("Value", dicValue, 100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		if ImGui.Button("Add", 300, 0) then
			obj[parent][dicKey] = dicValue
			dicKey = ""
			dicValue = ""
		end
		
		ImGui.TreePop()
	end
end



function listThemeNode(title,help,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		for k,v in pairs(obj[parent]) do 
			
			ImGui.Text(k)
			ImGui.SameLine()
			ImGui.Text(v)
			ImGui.SameLine()
			if ImGui.Button("Delete", 300, 0) then
				
				obj[parent][k] = nil
				
			end
			
			
			
			
			
		end
		
		local toto = ""
		if ImGui.BeginCombo("##My Combo Box", toto) then -- Remove the ## if you'd like for the title to display above combo box
			
			for k,v in pairs(IRPtheme) do 
				
				if ImGui.Selectable(k) then
					selectedThemeKey = k
					selectedThemeValue = v
					toto = selectedThemeKey
					ImGui.SetItemDefaultFocus()
				end
				
				
				
			end
			
			ImGui.EndCombo()
		end
		
		ImGui.Text("Selected :"..selectedThemeKey)
		local text = ""
		local number = 0
		
		if('number' == selectedThemeValue) then
			selectedThemeText = ImGui.InputFloat("", selectedThemeText, 1, 10, "%.1f", ImGuiInputTextFlags.None)
			
			else
			selectedThemeText = ImGui.InputText("", selectedThemeText, 10, ImGuiInputTextFlags.None)
			
		end
		
		ImGui.Text("Value :"..selectedThemeText)
		
		if ImGui.Button("Add", 300, 0) then
			selectedThemeText = selectedThemeText:gsub("#", "") 
			obj[parent][selectedThemeKey] = selectedThemeText
			--activeEditedTheme["data"][selectedThemeKey] = selectedThemeText
			
		end
		
		-- ImGui.Text("New value :")
		
		-- dicKey = ImGui.InputText("Key", dicKey, 100, ImGuiInputTextFlags.AutoSelectAll)
		-- dicValue = ImGui.ColorPicker4("Choose color", col, ImGuiColorEditFlags.DisplayHex)
		-- if ImGui.Button("Add", 300, 0) then
		-- obj[parent][dicKey] = dicValue
		-- dicKey = ""
		-- dicValue = ""
		-- end
		
		ImGui.TreePop()
	end
	
end

function listSongNode(title,help,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		if(#obj[parent] > 0) then
			for i = 1, #obj[parent] do 
				
				if ImGui.Button("Delete "..obj[parent][i].name, 300, 0) then
					
					table.remove(obj[parent],i)
					
				end
				
				
				
				
				
			end
		end
		
		ImGui.Text("New song :")
		
		genericItem.name = ImGui.InputText(getLang("editor_Name"),genericItem.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		genericItem.file = ImGui.InputText("File", genericItem.file, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		if ImGui.Button("Add", 300, 0) then
			
			table.insert(obj[parent],genericItem)
			genericItem = {}
			genericItem.name = ""
			genericItem.file = ""
		end
		
		ImGui.TreePop()
	end
	
end

function listLocationsNode(title,help,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		if(#obj[parent] > 0) then
			for i = 1, #obj[parent] do 
				
				if ImGui.Button("Delete "..obj[parent][i].Tag, 300, 0) then
					
					table.remove(obj[parent],i)
					
				end
				
				
				if ImGui.Button("Edit "..obj[parent][i].Tag, 300, 0) then
					
					genericLocation = obj[parent][i]
					editLocation = true
					
				end
				
				if editLocation == true then
					
					ImGui.Text("Location :")
					
					genericLocation.Tag = ImGui.InputText(getLang("editor_tag"),genericLocation.Tag, 100, ImGuiInputTextFlags.AutoSelectAll)
					genericLocation.inVehicule = ImGui.Checkbox("in Vehicule", genericLocation.inVehicule)
					
					
					
					ImGui.Text("District : ") 
					ImGui.SameLine()
					if ImGui.BeginCombo("##locationdistrict", genericLocation.district) then
						
						
						for i,v in ipairs(arrayDistricts) do
							
							if ImGui.Selectable(v.Name, (genericLocation.district == v.EnumName)) then
								genericLocation.district = v.EnumName
								ImGui.SetItemDefaultFocus()
							end
							
							
						end
						
						ImGui.EndCombo()
					end
					ImGui.Text("SubDistrict : ") 
					ImGui.SameLine()
					if ImGui.BeginCombo("##locationsubdistrict", genericLocation.subdistrict) then
						
						
						for i,v in ipairs(arraySubDistrict) do
							
							if ImGui.Selectable(v, (genericLocation.subdistrict == v)) then
								genericLocation.subdistrict = v
								ImGui.SetItemDefaultFocus()
							end
							
							
						end
						
						ImGui.EndCombo()
					end
					ImGui.Spacing()
					ImGui.Text("X : ") 
					ImGui.SameLine()
					genericLocation.x = ImGui.InputFloat("##locx", genericLocation.x, 1, 10, "%.1f", ImGuiInputTextFlags.None)
					ImGui.Spacing()
					
					ImGui.Text("Y : ") 
					ImGui.SameLine()
					genericLocation.y = ImGui.InputFloat("##locy", genericLocation.y, 1, 10, "%.1f", ImGuiInputTextFlags.None)
					ImGui.Spacing()
					
					ImGui.Text("Z : ") 
					ImGui.SameLine()
					genericLocation.z = ImGui.InputFloat("##loccz", genericLocation.z, 1, 10, "%.1f", ImGuiInputTextFlags.None)
					ImGui.Spacing()
					
					if ImGui.Button("Copy Player's XYZ", 300, 0) then
						
						local vec4 = Game.GetPlayer():GetWorldPosition()
						
						
						genericLocation.x = vec4.x
						genericLocation.y =vec4.y
						genericLocation.z = vec4.z
						
						
					end
					
					
					if ImGui.Button("Edit", 300, 0) then
						
						obj[parent][i] = genericLocation
						genericLocation = {}
						genericLocation.x = 0
						genericLocation.y = 0
						genericLocation.z = 0
						genericLocation.district = "Watson"
						genericLocation.subdistrict = "ArasakaWaterfront"
						genericLocation.inVehicule = false
						genericLocation.Tag = ""
						editLocation = false
					end
					
					
					
				end
				
				
			end
		end
		
		ImGui.Text("Location :")
		
		genericLocation.Tag = ImGui.InputText(getLang("editor_tag"),genericLocation.Tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		genericLocation.inVehicule = ImGui.Checkbox("in Vehicule", genericLocation.inVehicule)
		
		
		
		ImGui.Text("District : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##locationdistrict", genericLocation.district) then
			
			
			
			
			for i,v in ipairs(arrayDistricts) do
				
				if ImGui.Selectable(v.Name, (genericLocation.district == v.EnumName)) then
					genericLocation.district = v.EnumName
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		ImGui.Text("SubDistrict : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##locationsubdistrict", genericLocation.subdistrict) then
			
			
			for i,v in ipairs(arraySubDistrict) do
				
				if ImGui.Selectable(v.Name, (genericLocation.subdistrict == v)) then
					genericLocation.subdistrict = v
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		ImGui.Spacing()
		ImGui.Text("X : ") 
		ImGui.SameLine()
		genericLocation.x = ImGui.InputFloat("##locx", genericLocation.x, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Y : ") 
		ImGui.SameLine()
		genericLocation.y = ImGui.InputFloat("##locy", genericLocation.y, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Z : ") 
		ImGui.SameLine()
		genericLocation.z = ImGui.InputFloat("##loccz", genericLocation.z, 1, 10, "%.1f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		if ImGui.Button("Copy Player's XYZ", 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			
			
			genericLocation.x = vec4.x
			genericLocation.y =vec4.y
			genericLocation.z = vec4.z
			
			
		end
		
		
		
		
		
		
		if ImGui.Button("Add", 300, 0) then
			
			table.insert(obj[parent],genericLocation)
			genericLocation = {}
			genericLocation.x = 0
			genericLocation.y = 0
			genericLocation.z = 0
			genericLocation.district = "Watson"
			genericLocation.subdistrict = "ArasakaWaterfront"
			genericLocation.inVehicule = false
			genericLocation.Tag = ""
		end
		
		
		
		ImGui.TreePop()
	end
	
end

function listVIPNode(title,help,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		if(#obj[parent] > 0) then
			for i = 1, #obj[parent] do 
				
				if ImGui.Button("Delete "..obj[parent][i].name, 300, 0) then
					
					table.remove(obj[parent],i)
					
				end
				
				
				
				
				
			end
		end
		
		ImGui.Text("New VIP :")
		
		genericVIP.name = ImGui.InputText(getLang("editor_Name"),genericVIP.name, 100, ImGuiInputTextFlags.AutoSelectAll)
		genericVIP.score = ImGui.InputInt("Score", genericVIP.score, 1,10, ImGuiInputTextFlags.None)
		
		if ImGui.Button("Add", 300, 0) then
			
			table.insert(obj[parent],genericVIP)
			genericVIP = {}
			genericVIP.name = ""
			genericVIP.score = 0
		end
		
		ImGui.TreePop()
	end
	
end

--Factory
function triggerFactory(entity,selectedTrigger)
	ImGui.Text("Choose an trigger : ")
	ImGui.Spacing()
	local toto = ""
	if ImGui.BeginCombo("##My Combo Box2ssss", toto) then -- Remove the ## if you'd like for the title to display above combo box
		
		for k, option in orderedPairs(arraytriggertemplate) do
			
			if ImGui.Selectable(k, (option == selectedTrigger)) then
				selectedTrigger = option
				editor_check_trigger_test = false
				editor_check_trigger_test_visble = false
				ImGui.SetItemDefaultFocus()
			end
			
		end
		
		ImGui.EndCombo()
	end
	
	local isNew = false
	
	--debugPrint(2,selectedTrigger)
	if(entity == nil or entity.name ~= selectedTrigger) then
		isNew = true
		for i = 1,#triggertemplate do 
			
			if(triggertemplate[i].name == selectedTrigger)then
				
				local newp = {}
				--debugPrint(2,"Entity "..dump(triggertemplate[i]))
				for key,vaz in pairs(triggertemplate[i]) do
					newp[key] = vaz
					----debugPrint(2,dump(vaz))
				end
				entity = newp
				
			end
		end
	end
	--debugPrint(2,dump(entity))
	
	if(entity ~= nil and entity.name ~= nil) then
		ImGui.Text("Selected : "..entity["name"])
		ImGui.Spacing()
		if ImGui.Button("?", 300, 0) then
			
		end
		
		local hovered = ImGui.IsItemHovered()
		
		if hovered  and entity["helper"]~= nil  then
			CPS:CPToolTip1Begin(200, 700)
			
			
			
			local splitContentRequ = splitByChunk(getLang(entity["helper"]),20)
			
			for i,v in ipairs(splitContentRequ) do
				ImGui.TextColored(0.36, 0.96, 1, 1, v)--content
			end
			
			
			
			
			CPS:CPToolTip1End()
		end
		
		if(string.find(entity["name"], "position") ~= nil) then
			if ImGui.Button(getLang("editor_copy_player_location"), 300, 0) then
				
				local vec4 = Game.GetPlayer():GetWorldPosition()
				entity["x"] = vec4.x
				entity["y"] = vec4.y
				entity["z"] = vec4.z
				
				
			end
		end 
		
		
		for i=1,#triggerorder do
			for key,vaz in pairs(entity) do
				
				if(triggerorder[i] == key) then
					ImGui.Text(key)
					ImGui.SameLine()
					
					
					
					
					if(key ~= "name" and string.find(key, "help") == nil) then
						
						
						if('number' == type(entity[key])) then
							entity[key] = ImGui.InputFloat(key, entity[key], 1, 10, "%.1f", ImGuiInputTextFlags.None)
							
							elseif((entity["name"] == "npc" and key == "value") or (entity["name"] == "npc_affintiy" and key == "value")) then
							
							if(entity["name"] == "npc" and entity["way"] ~= nil) then
								
								if entity["way"] == "fixer" then
									
									if(entity[key] == nil) then entity[key] = "" end
									
									if ImGui.BeginCombo("##fixertrigger", npcFixer) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										for k,v in pairs(arrayFixer) do
											
											if ImGui.Selectable(v.fixer.Name, (v.fixer.Tag == entity[key])) then
												entity[key] = k
												npcFixer = v.fixer.Name
												ImGui.SetItemDefaultFocus()
											end
											
										end
										
										ImGui.EndCombo()
									end
									
									ImGui.Text(entity[key])
									
									else
									
									
									if(entity[key] == nil) then entity[key] = "" end
									
									if ImGui.BeginCombo("##minpc", npcchara) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										for i=1, #arrayListCharacter do
											
											if ImGui.Selectable(arrayListCharacter[i], (arrayListCharacter[i] == entity[key])) then
												entity[key] = arrayListCharacter[i]
												npcchara = arrayListCharacter[i]
												ImGui.SetItemDefaultFocus()
											end
											
										end
										
										ImGui.EndCombo()
									end
									
									ImGui.Text(entity[key])
									
								end
								
								else
								
								
								if(entity[key] == nil) then entity[key] = "" end
								
								if ImGui.BeginCombo("##minpc", npcchara) then -- Remove the ## if you'd like for the title to display above combo box
									
									
									
									for i=1, #arrayPnjDb do
										
										if ImGui.Selectable(arrayPnjDb[i].Names, (arrayPnjDb[i] == entity[key])) then
											entity[key] = arrayPnjDb[i].TweakIDs
											npcchara = arrayPnjDb[i].Names
											ImGui.SetItemDefaultFocus()
										end
										
									end
									
									ImGui.EndCombo()
								end
								
								ImGui.Text(entity[key])
								
								
							end
							
							
							
							
							
							
							elseif ('string' == type(entity[key])) then
							entity[key] = ImGui.InputText(key, tostring(entity[key]), 100, ImGuiInputTextFlags.AutoSelectAll)
							
							elseif ('boolean' == type(entity[key])) then
							entity[key] = ImGui.Checkbox(key, entity[key])
							
							
							
							elseif ('table' == type(entity[key])) then
							
							if(key == "trigger") then
								
								
								if openTriggerItem == false and haschanged == false then
									currentParentItem = entity[key]
									
									
									
									openTriggerItem = true
								end
								
								
								entity[key] = currentParentItem
								
								if(entity[key] ~= nil)then
									for v,k in pairs(entity[key]) do
										ImGui.Text(v.." : "..tostring(k))
									end
								end
								
								
								elseif(key == "triggers")then
								
								for i=1,#entity[key] do
									local index = entity[key][i].name
									-- for k,v in pairs(arraytriggertemplate) do
									
									-- if(arraytriggertemplate[index] == entity[key][i].name) then
									
									
									-- end
									
									-- end
									triggerUI(entity[key][i],index)
									
								end
								
								elseif(key == "reaction")then
								
								entity[key].category = ImGui.InputFloat(key, entity[key].category, 1, 10, "%.1f", ImGuiInputTextFlags.None)
								entity[key].idle = ImGui.InputFloat(key, entity[key].idle, 1, 10, "%.1f", ImGuiInputTextFlags.None)
								
								
								
								
								
								elseif(key == "if_action" or key ==  "else_action" or key ==  "for_action")then
								--makeListAction(entity[key])
								ImGui.Text("Soon in editor, for now you can do it in notepad++")
								
								
								else 
								
								makeListString(entity[key])
								
								local resumeString = ""
								
								if(#entity[key] >0)then
									for i = 1,#entity[key] do 
										
										
										local virgule = ""
										if(i > 1) then
											virgule = ","
										end
										local entiy = '"'..entity[key][i]..'"'
										resumeString = resumeString..virgule..entiy
									end
								end
								ImGui.Text(resumeString)
								
								
								
							end
							
						end
						
						else
						
						if(key ~= "name") and string.find(key, "helper") == nil then
							ImGui.Text(entity[key])
							
						end
						
						
					end
					
				end
			end
			
		end
		
		
		
		if ImGui.Button("Test Trigger", 300, 0) then
			editor_check_trigger_test = checkTrigger(entity)
		end
		
		if editor_check_trigger_test then
			ImGui.Text("Result : "..tostring(editor_check_trigger_test))
			else
			ImGui.Text("Result : "..tostring(editor_check_trigger_test))
		end
		
		
		return entity
	end
	
	
	
	
	
end

function actionFactory(entity)
	ImGui.Text("Choose an action : ")
	ImGui.Spacing()
	
	
	if ImGui.BeginCombo("##My Combo Box", "") then -- Remove the ## if you'd like for the title to display above combo box
		
		for k, option in orderedPairs(arrayactiontemplate) do
			
			if ImGui.Selectable(k) then
				selecAction = option
				
				ImGui.SetItemDefaultFocus()
			end
			
			
			
		end
		
		ImGui.EndCombo()
	end
	
	local isNew = false
	
	--debugPrint(2,dump(entity))
	if(entity == nil or entity.name == nil or entity.name ~= selecAction) then
		isNew = true
		for i = 1,#actiontemplate do 
			
			if(actiontemplate[i].name == selecAction)then
				entity={}
				for key,vaz in pairs(actiontemplate[i]) do
					entity[key] = vaz
					if(key == "if_action" or key ==  "else_action" or key ==  "for_action")then
						entity[key] = {}
					end
				end
			end
			
			
			
		end
	end
	
	
	local list = {}
	if(entity ~= nil and entity.name ~= nil) then
		
		if ImGui.Button("?", 300, 0) then
			
		end
		
		local hovered = ImGui.IsItemHovered()
		
		if hovered and entity["helper"]~= nil  then
			CPS:CPToolTip1Begin(200, 700)
			
			
			
			local splitContentRequ = splitByChunk(getLang(entity["helper"]),20)
			
			for i,v in ipairs(splitContentRequ) do
				ImGui.TextColored(0.36, 0.96, 1, 1, v)--content
			end
			
			
			
			
			CPS:CPToolTip1End()
		end
		
		ImGui.Text("Selected : "..entity["name"])
		
		ImGui.Spacing()
		
		if(
			entity["name"] ~= "spawn_vehicule_v2" and
			entity["name"] ~= "play_entity_facial" and
			entity["name"] ~= "play_group_facial" and
			entity["name"] ~= "spawn_npc" and
			entity["name"] ~= "applyEffect_entity" and
			entity["name"] ~= "removeEffect_entity" and
			entity["name"] ~= "set_mappin" and
			entity["name"] ~= "spawn_camera" and
			entity["name"] ~= "move_camera" and
			entity["name"] ~= "play_game_sound" and
			entity["name"] ~= "stop_game_sound"
		) then
		
		for i=1,#actionorder do
			for key,vaz in pairs(entity) do
				
				
				
				if(actionorder[i] == key) then
					
					if(key ~= "name" and string.find(key, "help") == nil) then
						
						
						ImGui.Text(key) 
						ImGui.SameLine()
						if('number' == type(entity[key])) then
							entity[key] = ImGui.InputFloat("##"..key, entity[key], 1, 10, "%.1f", ImGuiInputTextFlags.None)
							
							
							
							elseif(key == "npc") then
							
							
							
							if ImGui.BeginCombo("##My Combo Box2ssss", entity[key]) then -- Remove the ## if you'd like for the title to display above combo box
								
								
								
								for i,v in ipairs(arrayPnjDb) do
									
									if ImGui.Selectable(v.Names, (activeEditedDialog.speaker.way == v.Names)) then
										
										
										entity[key] = v.Names
										
										npcchara = v.Names
										ImGui.SetItemDefaultFocus()
									end
									
									
								end
								
								ImGui.EndCombo()
							end
							
							elseif(entity["name"] == "npc_affinity" and key == "value") then
							
							
							
							if ImGui.BeginCombo("##My Combo Box2ssss", entity[key]) then -- Remove the ## if you'd like for the title to display above combo box
								
								
								
								for i,v in ipairs(arrayPnjDb) do
									
									if ImGui.Selectable(v.Names, (activeEditedDialog.speaker.way == v.Names)) then
										
										
										entity[key] = v.Names
										
										npcchara = v.Names
										ImGui.SetItemDefaultFocus()
									end
									
									
								end
								
								ImGui.EndCombo()
							end
							
							elseif ('string' == type(entity[key])) then
							entity[key] = ImGui.InputText("##"..key, entity[key], 100, ImGuiInputTextFlags.None)
							
							elseif ('boolean' == type(entity[key])) then
							entity[key] = ImGui.Checkbox("##"..key, entity[key])
							
							
							
							elseif ('table' == type(entity[key])) then
							if(key == "trigger") then
								triggerActionNode("Trigger",entity, key,"trigger",1)
								-- if openTriggerItem == false and haschanged == false then
								-- currentParentItem = entity[key]
								
								
								
								-- openTriggerItem = true
								-- end
								
								
								-- entity[key] = currentParentItem
								
								-- if(entity[key] ~= nil)then
								-- for v,k in pairs(entity[key]) do
								-- ImGui.Text(v.." : "..tostring(k))
								-- end
								
								-- if (ImGui.Button("Edit Trigger", 300, 0)) then
								-- haschanged = false
								-- if openTriggerItem == false and haschanged == false then
								-- currentParentItem = entity[key]
								
								
								
								-- openTriggerItem = true
								-- end
								
								-- end
								
								-- end
								
								elseif(key == "reaction")then
								
								entity[key].category = ImGui.InputFloat("Category", entity[key].category, 1, 10, "%.1f", ImGuiInputTextFlags.None)
								entity[key].idle = ImGui.InputFloat("Idle", entity[key].idle, 1, 10, "%.1f", ImGuiInputTextFlags.None)
								
								
								
								
								
								
								elseif(key == "if_action" or key ==  "else_action" or key ==  "action" or key ==  "answer_action" or key ==  "rejected_action" )then
								
								actionsubNode(key,entity,key)
								--ImGui.Text("Soon in editor, for now you can do it in notepad++")
								
								else
								
								makeListString(entity[key])
								
								local resumeString = ""
								
								
								if(#entity[key] >0)then
									for i = 1,#entity[key] do 
										
										
										local virgule = ""
										if(i > 1) then
											virgule = ","
										end
										
										local entiy = '"'..entity[key][i]..'"'
										
										resumeString = resumeString..virgule..entiy
									end
								end
								ImGui.Text(resumeString)
								
							end
							
						end
						
						else
						
						if(key ~= "name") and string.find(key, "helper") == nil then
							ImGui.Text(entity[key])
							
						end
						
					end
					
				end
			end
		end
		
		if(entity["x"] ~= nil) then
			
			if ImGui.Button("Copy Player's XYZ", 300, 0) then
				
				local vec4 = Game.GetPlayer():GetWorldPosition()
				entity["x"] = vec4.x
				entity["y"] = vec4.y
				entity["z"] = vec4.z
				
				
			end
			
		end
		
		
		
		else
		if(entity["name"] == "spawn_vehicule_v2" ) then
			entity = SpawnVehicleUI(entity)
			
		end
		
		if(entity["name"] == "spawn_npc" ) then
			
			entity = SpawnNPCUI(entity)
		end
		
		if(entity["name"] == "move" ) then
			
			entity = MoveEntityUI(entity)
		end
		
		if(entity["name"] == "teleport" ) then
			
			entity = TeleportEntityUI(entity)
		end
		
		if(entity["name"] == "spawn_item" ) then
			
			entity = SpawnItemUI(entity)
		end
		
		if(entity["name"] == "spawn_camera" or entity["name"] == "move_camera") then
			
			entity = SpawnCamera(entity)
		end
		
		if(entity["name"] == "set_mappin" ) then
			
			entity = SetMappinUI(entity)
		end
		
		if(entity["name"] == "applyEffect_entity" or entity["name"] == "removeEffect_entity" ) then
			EffectUI(entity)
		end
		if(entity["name"] == "play_group_facial" or entity["name"] == "play_entity_facial" ) then
			ExpressionUI(entity)
		end
		
		if(entity["name"] == "start_effect" or entity["name"] == "stop_effect" ) then
			FXUI(entity)
		end
		
		
		if(entity["name"] == "play_game_sound" or entity["name"] == "stop_game_sound" ) then
			if ImGui.BeginCombo("##Gamesound", entity["value"]) then -- Remove the ## if you'd like for the title to display above combo box
				
				
				
				for i,v in ipairs(arrayGameSounds) do
					
					if ImGui.Selectable(v, (entity["value"] == v)) then
						
						
						entity["value"] = v
						
						
						ImGui.SetItemDefaultFocus()
					end
					
					
				end
				
				ImGui.EndCombo()
			end
		end
		
		
		end
		
		
		if ImGui.Button("Test Action", 300, 0) then
			local actiontemp = {}
			table.insert(actiontemp,entity)
			runActionList(actiontemp, "editor_test", "interact",false,"nothing",false)
			editor_check_action_test = true
		end
		
		if editor_check_action_test then
			if ImGui.Button("Clean the tested stuff (need to be out of an car)", 300, 0) then
				
				workerTable = {}
				despawnAll()
				
			end
		end
	end
	
	return entity
	
end





function triggerUI(entity,index)
	
	
	
	
	index = ImGui.Combo("Label", index, arraytriggertemplate,#arraytriggertemplate)
	local test = arraytriggertemplate[index]
	
	if(entity.name == nil or entity.name ~= test) then
		for k,v in pairs(triggertemplate) do 
			if(triggertemplate[k].name == test)then
				entity={}
				for key,vaz in pairs(triggertemplate[k]) do
					entity[key] = vaz
				end
				
				
			end
		end
	end
	
	
	if(entity ~= nil and entity.name ~= nil) then
		
		if ImGui.Button("?", 300, 0) then
			
		end
		
		local hovered = ImGui.IsItemHovered()
		
		if hovered and entity["helper"]~= nil then
			CPS:CPToolTip1Begin(200, 700)
			
			
			
			local splitContentRequ = splitByChunk(entity["helper"],20)
			
			for i,v in ipairs(splitContentRequ) do
				ImGui.TextColored(0.36, 0.96, 1, 1, v)--content
			end
			
			
			
			
			CPS:CPToolTip1End()
		end
		
		for key,vaz in pairs(entity) do
			
			if(key ~= "name" and string.find(key, "help") == nil) then
				
				
				if('number' == type(entity[key])) then
					entity[key] = ImGui.InputFloat(key, entity[key], 1, 10, "%.1f", ImGuiInputTextFlags.None)
					
					
					elseif ('string' == type(entity[key])) then
					entity[key] = ImGui.InputText(key, tostring(entity[key]), 100, ImGuiInputTextFlags.AutoSelectAll)
					
					elseif ('boolean' == type(entity[key])) then
					entity[key] = ImGui.Checkbox(key, entity[key])
					
					
					
					elseif ('table' == type(entity[key])) then
					
					if(key == "trigger") then
						
						ImGui.Text(entity[key].name)
						
						
						if ImGui.Button("Edit "..entity[key].name, 300, 0) then
							currentParentItem = entity[key]
							
							
							openNewTrigger = true
						end
						
						
						
						elseif(key == "triggers")then
						
						for i=1,#entity[key] do
							
							if ImGui.Button("Edit "..entity[key][i].name, 300, 0) then
								currentParentItem = entity[key][i]
								
								
								openNewTrigger = true
							end
						end
						
						
						
						
						elseif(key == "reaction")then
						
						entity[key].category = ImGui.InputFloat(key, entity[key].category, 1, 10, "%.1f", ImGuiInputTextFlags.None)
						entity[key].idle = ImGui.InputFloat(key, entity[key].idle, 1, 10, "%.1f", ImGuiInputTextFlags.None)
						
						
						
						
						
						elseif(key == "if_action" or key ==  "else_action" or key ==  "for_action")then
						--makeListAction(entity[key])
						ImGui.Text("Soon in editor, for now you can do it in notepad++")
						
						
						
						
						elseif(string.find(key, "helper") == nil) then
						ImGui.Text(entity[key])
						
						
						else 
						
						makeListString(entity[key])
						
						local resumeString = ""
						
						if(#entity[key] >0)then
							for i = 1,#entity[key] do 
								
								
								local virgule = ""
								if(i > 1) then
									virgule = ","
								end
								
								resumeString = resumeString..virgule..entity[key][i]
							end
						end
						ImGui.Text(resumeString)
						
					end	
				end
				
				
			end
			
		end
		
		
	end
	
end





function SpawnNPCUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Spawn level group (useful for delete an level of entities) : ") 
	ImGui.SameLine()
	entity["spawnlevel"] = ImGui.InputInt("##spawnlevel", entity["spawnlevel"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Amount : ") 
	ImGui.SameLine()
	entity["amount"] = ImGui.InputInt("##amount", entity["amount"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Use Police Prevention System ? if false, it use experimental spawner, with it, you can set an appeareance directly, use carefully, it can have bug: ") 
	ImGui.SameLine()
	entity["use_police_prevention_system"] =ImGui.Checkbox("##use_police_prevention_system", entity["use_police_prevention_system"])
	
	ImGui.Spacing()
	
	ImGui.Text("Group : ") 
	ImGui.SameLine()
	entity["group"] = ImGui.InputText("##group", entity["group"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Create the group if it doesn't exist yet : ") 
	ImGui.SameLine()
	entity["create_group_if_not_exist"] = ImGui.Checkbox("##create_group_if_not_exist", entity["create_group_if_not_exist"])
	
	ImGui.Spacing()
	
	ImGui.Text("Source of the spawn : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##npcsource", entity["source"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(npcsource) do
			
			if ImGui.Selectable(v, (entity["source"] == v)) then
				
				
				entity["source"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	if(
		entity["source"] ~= "current_star" 
		and entity["source"] ~= "from_list" 
		and entity["source"] ~= "random" 
		and entity["source"] ~= "npc" 
		and entity["source"] ~= "district_leader" 
		and entity["source"] ~= "faction" 
		and entity["source"] ~= "subdistrict_leader"
		and entity["source"] ~= "district_rival" 
		and entity["source"] ~= "subdistrict_rival"
		and entity["source"] ~= "current_district_rival" 
		and entity["source"] ~= "current_subdistrict_rival"
	)then
	
	ImGui.Text("Source Tag : ") 
	entity["source_tag"] = ImGui.InputText("##source_tag", entity["source_tag"], 100, ImGuiInputTextFlags.None)
	
	
	
	ImGui.Spacing()
	end
	
	if(entity["source"] == "npc") then
		
		ImGui.Text("NPC : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcenpc", entity["source_tag"]) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(arrayPnjDb) do
				
				if ImGui.Selectable(v.Names, (entity["source_tag"] == v.TweakIDs)) then
					
					
					entity["source_tag"] = v.TweakIDs
					
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		if(entity["use_police_prevention_system"] == false) then
			ImGui.Spacing()
			
			entity["appearance"] = ImGui.InputText("##appearance", entity["appearance"], 100, ImGuiInputTextFlags.None)
			ImGui.Spacing()
			else
			entity["appearance"] = ""
		end
	end
	
	if(entity["source"] == "from_list") then
		
		listStringNode("List :","list of possible npc",entity,"source_list",false)
		
	end
	
	if(entity["source"] == "faction") then
		
		ImGui.Text("Faction : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcefaction", entity["source_tag"]) then
			
			
			for k,v in pairs(arrayFaction) do
				
				if ImGui.Selectable(v.faction.Name, (entity["source_tag"]  == k)) then
					entity["source_tag"] = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	if(entity["source"] == "district_rival" or entity["source"] =="subdistrict_rival" or entity["source"] == "current_district_rival" or entity["source"] == "current_subdistrict_rival" )then
		
		ImGui.Text("Put in Source Gang the Gang tag you want test. If you put 'player' it will take Player's current Faction. ") 
		ImGui.Spacing()
		
		
		ImGui.Text("Source Gang : ") 
		ImGui.SameLine()
		entity["source_gang"] =ImGui.InputText("##source_gang", entity["source_gang"], 100, ImGuiInputTextFlags.None)
		
		
		
	end
	
	if(entity["source"] == "district_leader" or entity["source"] == "district_rival") then
		
		ImGui.Text("District : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcedistrict", entity["source_tag"]) then
			
			
			for i,v in ipairs(arrayDistricts) do
				
				if ImGui.Selectable(v.Name, (entity["source_tag"] == v.Tag)) then
					entity["source_tag"] = v.Tag
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	if(entity["source"] == "subdistrict_leader" or entity["source"] == "subdistrict_rival") then
		
		ImGui.Text("SubDistrict : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcesubdistrict", entity["source_tag"]) then
			
			
			for i,v in ipairs(arraySubDistrict) do
				
				if ImGui.Selectable(v.Name, (entity["source_tag"] == v)) then
					entity["source_tag"] = v
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	if(entity["source"] == "faction" or entity["source"] =="current_district_leader" or entity["source"] == "current_subdistrict_leader" or entity["source"] == "district_leader" or entity["source"] == "subdistrict_leader")then
		
		ImGui.Text("Use Rival of this faction instead of this faction ? : ") 
		ImGui.SameLine()
		entity["source_use_rival"] =ImGui.Checkbox("##source_use_rival", entity["source_use_rival"])
		ImGui.Spacing()
		
		ImGui.Text("Use Faction's VIP list ? If No, it will take the default SpawnableNPC List : ") 
		ImGui.SameLine()
		entity["source_use_vip"] =ImGui.Checkbox("##source_use_vip", entity["source_use_vip"])
		ImGui.Spacing()
		
		
	end
	
	
	
	
	entity =  PositionUI(entity)
	
	
	
	
	return entity
end

function SpawnVehicleUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Spawn level group (useful for delete an level of entities) : ") 
	ImGui.SameLine()
	entity["spawnlevel"] = ImGui.InputInt("##spawnlevel", entity["spawnlevel"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Amount : ") 
	ImGui.SameLine()
	entity["amount"] = ImGui.InputInt("##amount", entity["amount"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	
	ImGui.Spacing()
	
	ImGui.Text("Spawn System : (From Garage : safe way to use for players | Beta: more option but use carefully, it can have bug | Prevention : use only if you spawn npc with prevention in same XYZ or it can corrupt saves): ") 
	ImGui.Spacing()
	
	if ImGui.BeginCombo("##spawnsystem", vehiclespawnsystemeditordefault) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(vehiclespawnsystem) do
			
			if ImGui.Selectable(v, (entity["spawn_system"] == i)) then
				
				
				entity["spawn_system"] = i
				vehiclespawnsystemeditordefault = v
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	if(entity["spawn_system"] == 1)then
		ImGui.Text("Appears from behind ") 
		ImGui.SameLine()
		entity["appears_from_behind"] =ImGui.Checkbox("##appears_from_behind", entity["appears_from_behind"])
		ImGui.Spacing()
		ImGui.Text("Wait that the vehicule comes to you ? ") 
		ImGui.SameLine()
		entity["wait_for_vehicle"] =ImGui.Checkbox("##wait_for_vehicle", entity["wait_for_vehicle"])
		ImGui.Spacing()
	end
	
	ImGui.Text("Is an AV (flying machine)? : ") 
	ImGui.SameLine()
	entity["isAV"] =ImGui.Checkbox("##isAV", entity["isAV"])
	
	ImGui.Spacing()
	
	
	ImGui.Text("Group : ") 
	ImGui.SameLine()
	entity["group"] = ImGui.InputText("##group", entity["group"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Create the group if it doesn't exist yet : ") 
	ImGui.SameLine()
	entity["create_group_if_not_exist"] = ImGui.Checkbox("##create_group_if_not_exist", entity["create_group_if_not_exist"])
	
	ImGui.Spacing()
	
	ImGui.Text("Source of the spawn : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##vehiclesource", entity["source"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(vehiclesource) do
			
			if ImGui.Selectable(v, (entity["source"] == v)) then
				
				
				entity["source"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	if(entity["source"] ~= "random" and
		entity["source"] ~= "from_list" and 
		entity["source"] ~= "vehicle" and 
		entity["source"] ~= "district_leader" and 
		entity["source"] ~= "faction" and 
		entity["source"] ~= "subdistrict_leader"
		and entity["source"] ~= "district_rival" 
		and entity["source"] ~= "subdistrict_rival"
		and entity["source"] ~= "current_district_rival" 
		and entity["source"] ~= "current_subdistrict_rival"
	)
	then
	
	ImGui.Text("Source Tag : ") 
	entity["source_tag"] = ImGui.InputText("##source_tag", entity["source_tag"], 100, ImGuiInputTextFlags.None)
	
	
	
	ImGui.Spacing()
	end
	if(entity["source"] == "from_list") then
		
		listStringNode("List :","list of possible vehicle",entity,"source_list",false)
		
	end
	
	if(entity["source"] == "vehicle") then
		
		ImGui.Text("Vehicle : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##vehisourcenpc", entity["source_tag"]) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(arrayVehicles) do
				
				if ImGui.Selectable(v, (entity["source_tag"] == v)) then
					
					
					entity["source_tag"] = v
					
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		if(entity["spawn_system"] == 1) then
			ImGui.Spacing()
			ImGui.Text("Appearance (empty if not needed) :") 
			ImGui.Spacing()
			entity["appearance"] = ImGui.InputText("##appearance", entity["appearance"], 100, ImGuiInputTextFlags.None)
			ImGui.Spacing()
			else
			entity["appearance"] = ""
		end
		
	end
	
	if(entity["source"] == "faction") then
		
		ImGui.Text("Faction : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##vehisourcefaction",entity["source_tag"]) then
			
			
			for k,v in pairs(arrayFaction) do
				
				if ImGui.Selectable(v.faction.Name, (entity["source_tag"]  == k)) then
					entity["source_tag"] = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	if(entity["source"] == "district_rival" or entity["source"] =="subdistrict_rival" or entity["source"] == "current_district_rival" or entity["source"] == "current_subdistrict_rival" )then
		
		ImGui.Text("Put in Source Gang the Gang tag you want test. If you put 'player' it will take Player's current Faction. ") 
		ImGui.Spacing()
		
		
		ImGui.Text("Source Gang : ") 
		ImGui.SameLine()
		entity["source_gang"] =ImGui.InputText("##source_gang", entity["source_gang"], 100, ImGuiInputTextFlags.None)
		
		
		
	end
	
	if(entity["source"] == "district_leader" or entity["source"] == "district_rival") then
		
		ImGui.Text("District : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcedistrict", entity["source_tag"]) then
			
			
			for i,v in ipairs(arrayDistricts) do
				
				if ImGui.Selectable(v.Name, (entity["source_tag"] == v.Tag)) then
					entity["source_tag"] = v.Tag
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	if(entity["source"] == "subdistrict_leader" or entity["source"] == "subdistrict_rival") then
		
		ImGui.Text("SubDistrict : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcesubdistrict", entity["source_tag"]) then
			
			
			for i,v in ipairs(arraySubDistrict) do
				
				if ImGui.Selectable(v.Name, (entity["source_tag"] == v)) then
					entity["source_tag"] = v
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	
	if(entity["source"] == "faction" or entity["source"] =="current_district_leader" or entity["source"] == "current_subdistrict_leader" or entity["source"] == "district_leader" or entity["source"] == "subdistrict_leader")then
		
		ImGui.Text("Use Rival of this faction instead of this faction ? : ") 
		ImGui.SameLine()
		entity["source_use_rival"] =ImGui.Checkbox("##source_use_rival", entity["source_use_rival"])
		ImGui.Spacing()
		
		
		
		
	end
	
	entity =  PositionUI(entity)
	
	return entity
end

function SetMappinUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Type of Mappin : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##mappinTypeEnum", entity["typemap"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(mappinTypeEnum) do
			
			if ImGui.Selectable(v, (entity["typemap"] == v)) then
				
				
				entity["typemap"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	ImGui.Text("See throught wall ? ") 
	ImGui.SameLine()
	entity["wall"] =ImGui.Checkbox("##wall", entity["wall"])
	
	ImGui.Spacing()
	
	ImGui.Text("Active ? ") 
	ImGui.SameLine()
	entity["active"] =ImGui.Checkbox("##active", entity["active"])
	
	ImGui.Spacing()
	
	
	ImGui.Text("Group : ") 
	ImGui.SameLine()
	entity["mapgroup"] = ImGui.InputText("##mapgroup", entity["mapgroup"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Title : ") 
	ImGui.SameLine()
	entity["title"] = ImGui.InputText("##title", entity["title"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Description : ") 
	ImGui.SameLine()
	entity["desc"] = ImGui.InputText("##desc", entity["desc"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	
	entity =  PositionUI(entity)
	return entity
end

function MoveEntityUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Is a Group ? : ") 
	ImGui.SameLine()
	entity["group"] = ImGui.Checkbox("##group", entity["group"])
	
	ImGui.Text("Movement : ") 
	ImGui.SameLine()
	entity["move"] = ImGui.InputText("##move", entity["move"], 100, ImGuiInputTextFlags.None)
	
	
	ImGui.Text("Use Move V2 method? ") 
	ImGui.SameLine()
	entity["moveV2"] =ImGui.Checkbox("##move2", entity["moveV2"])
	
	
	ImGui.Spacing()
	if(entity["moveV2"] == true )then
		ImGui.Text("Destination Rotation") 
		ImGui.Spacing()
		
		ImGui.Text("Roll : ") 
		ImGui.SameLine()
		entity["roll"] = ImGui.InputFloat("##xnpcroll", entity["roll"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Pitch : ") 
		ImGui.SameLine()
		entity["pitch"] = ImGui.InputFloat("##xnpcpitch", entity["pitch"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Yaw : ") 
		ImGui.SameLine()
		entity["yaw"] = ImGui.InputFloat("##xnpcyaw", entity["yaw"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		
		ImGui.Text("Distance : ") 
		ImGui.SameLine()
		entity["distance"] = ImGui.InputFloat("##xnpcdistance", entity["distance"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		
		ImGui.Text("Distance Tolerance : ") 
		ImGui.SameLine()
		entity["distancetolerance"] = ImGui.InputFloat("##xnpcdistancetolerance", entity["distancetolerance"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Ignore Navigation ?") 
		ImGui.SameLine()
		entity["ignorenavigation"] =ImGui.Checkbox("##ignorenavigation", entity["ignorenavigation"])
		
		ImGui.Text("Stop On Obstacle ?") 
		ImGui.SameLine()
		entity["stoponobstacle"] =ImGui.Checkbox("##stoponobstacle", entity["stoponobstacle"])
		
		ImGui.Text("Out of Way ?") 
		ImGui.SameLine()
		entity["outofway"] =ImGui.Checkbox("##outofway", entity["outofway"])
		
		
		
	end
	
	
	entity =  PositionUI(entity)
	
	return entity
end

function TeleportEntityUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Is a Group ? : ") 
	ImGui.SameLine()
	entity["group"] = ImGui.Checkbox("##group", entity["group"])
	
	
	
	entity =  PositionUI(entity)
	
	return entity
end

function SpawnItemUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	
	ImGui.Text("Amount : ") 
	ImGui.SameLine()
	entity["amount"] = ImGui.InputInt("##amount", entity["amount"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Path : ") 
	ImGui.SameLine()
	for i=1, #arrayDBitems do
		
		if ImGui.Selectable(arrayDBitems[i].Title) then
			
			entity["path"] = arrayDBitems[i].Path
			
			ImGui.SetItemDefaultFocus()
		end
		
		
		
	end
	
	
	
	
	
	
	
	ImGui.Text("Yaw : ") 
	ImGui.SameLine()
	entity["yaw"] = ImGui.InputFloat("##xnpcyaw", entity["yaw"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Pitch : ") 
	ImGui.SameLine()
	entity["pitch"] = ImGui.InputFloat("##xnpcpitch", entity["pitch"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Roll : ") 
	ImGui.SameLine()
	entity["roll"] = ImGui.InputFloat("##xnpcroll", entity["roll"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	
	if ImGui.Button("Copy Player's Rotation", 300, 0) then
		
		local v = Vector4.new(-Game.GetCameraSystem():GetActiveCameraForward().x, -Game.GetCameraSystem():GetActiveCameraForward().y, -Game.GetCameraSystem():GetActiveCameraForward().z, -Game.GetCameraSystem():GetActiveCameraForward().w)
		local euler = GetSingleton('Vector4'):ToRotation(v)
		
		entity["roll"] = euler.pitch
		entity["pitch"] = euler.roll
		entity["yaw"] = euler.yaw + 180
		
		
		
		
	end
	
	entity =  PositionUI(entity)
	
	return entity
end



function PositionUI(entity)
	
	ImGui.Text("Position source : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##npcposition", entity["position"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(npcposition) do
			
			if ImGui.Selectable(v, (entity["position"] == v)) then
				
				
				entity["position"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	
	if(
		entity["position"] == "relative_to_entity" or 
		entity["position"] =="poi" or 
		entity["position"] =="node" or 
		entity["position"] == "mappin" or 
		entity["position"] == "fasttravel" or 
		entity["position"] == "custom_place" or
		entity["position"] == "custom_room"
		
	)then
	
	ImGui.Text("Position Tag : ") 
	entity["position_tag"] = ImGui.InputText("##position_tag", entity["position_tag"], 100, ImGuiInputTextFlags.None)
	ImGui.Text(entity["position_change_helper"]) 
	
	
	ImGui.Spacing()
	end
	
	
	if(entity["position"] == "relative_to_entity")then
		
		ImGui.Text("Position Way : ") 
		if ImGui.BeginCombo("##npcpositionway", entity["position_way"]) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(npcpositionway) do
				
				if ImGui.Selectable(v, (entity["position_way"] == v)) then
					
					
					entity["position_way"] = v
					
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		ImGui.Spacing()
		
		ImGui.Text("Distance : ") 
		ImGui.SameLine()
		entity["position_distance"] = ImGui.InputInt("##position_distance", entity["position_distance"], 1, 10, ImGuiInputTextFlags.None)
		
		ImGui.Spacing()
	end
	
	if(entity["position"] == "poi")then
		
		
		
		ImGui.Text("Leave Position Tag to empty if you don't need to find an precise POI or Location ") 
		ImGui.SameLine()
		
		ImGui.Text("District Enum Name : (leave blank if unused, put current for get current District, put random for get a random District)") 
		ImGui.SameLine()
		entity["position_poi_district"] = ImGui.InputText("##position_poi_district", entity["position_poi_district"], 100, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("SubDistrict Enum Name : (leave blank if unused, put current for get current SubDistrict if you are in, put random for get a random subDistrict)") 
		ImGui.SameLine()
		entity["position_poi_subdistrict"] = ImGui.InputText("##position_poi_subdistrict", entity["position_poi_subdistrict"], 100, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Is For Car ? ") 
		ImGui.SameLine()
		entity["position_poi_is_for_car"] =ImGui.Checkbox("##is_for_car", entity["position_poi_is_for_car"])
		ImGui.Spacing()
		
		ImGui.Text("Use Location Tag instead of POI Tag (for an precise location) ? ") 
		ImGui.SameLine()
		entity["position_poi_use_location_tag"] =ImGui.Checkbox("##position_poi_use_location_tag", entity["position_poi_use_location_tag"])
		ImGui.Spacing()
		
		ImGui.Text("POI Detection Range : ") 
		ImGui.SameLine()
		entity["position_range"] = ImGui.InputInt("##poirange01", entity["position_range"], 1, 10, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("POI Detection From Position : ") 
		ImGui.SameLine()
		entity["position_poi_from_position"] = ImGui.Checkbox("##poirange02", entity["position_poi_from_position"])
		ImGui.Spacing()
		
		ImGui.Text("POI type : ") 
		ImGui.SameLine()
		entity["position_poi_type"] =ImGui.InputInt("##position_poi_type", entity["position_poi_type"], 1, 10, ImGuiInputTextFlags.None)
		
		ImGui.Spacing()
	end
	
	if(entity["position"] == "node")then
		
		ImGui.Text("Node Detection Range : ") 
		ImGui.SameLine()
		entity["position_range"] = ImGui.InputInt("##position_range2", entity["position_range"], 1, 10, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		ImGui.Text("Use Gameplay Position instead of Default Position : ") 
		ImGui.SameLine()
		entity["position_node_usegameplay"] =ImGui.Checkbox("##position_node_usegameplay", entity["position_node_usegameplay"])
		
	end
	
	if(entity["position"] == "custom_place")then
		
		ImGui.Text("Position House Way : ") 
		if ImGui.BeginCombo("##npcpositionhouseway", entity["position_house_way"]) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(npcpositionhouseway) do
				
				if ImGui.Selectable(v, (entity["position_house_way"] == v)) then
					
					
					entity["position_house_way"] = v
					
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		ImGui.Spacing()
	end
	
	
	
	
	
	if(entity["position"] == "player_look_at" )then
		ImGui.Text("Distance : ") 
		entity["position_lookatdistance"] = ImGui.InputInt("##position_player_look_at_distance", entity["position_lookatdistance"], 1, 10, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
	end
	
	
	
	
	
	if(entity["position"] == "at" )then
		ImGui.Text("Coordinates") 
		else
		ImGui.Text("Relative Coordinates to the selected position") 
		
	end
	
	ImGui.Spacing()
	
	
	ImGui.Text("X : ") 
	ImGui.SameLine()
	entity["x"] = ImGui.InputFloat("##xnpcx", entity["x"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Y : ") 
	ImGui.SameLine()
	entity["y"] = ImGui.InputFloat("##xnpcy", entity["y"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Z : ") 
	ImGui.SameLine()
	entity["z"] = ImGui.InputFloat("##xnpcz", entity["z"], 1, 10, "%.1f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	if ImGui.Button("Copy Player's XYZ", 300, 0) then
		
		local vec4 = Game.GetPlayer():GetWorldPosition()
		entity["x"] = vec4.x
		entity["y"] = vec4.y
		entity["z"] = vec4.z
		
		
	end
	
	return entity
	
	
	
	
end


function SpawnCamera(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	
	
	if ImGui.BeginCombo("POV Type", scenepovtype) then -- Remove the ## if you'd like for the title to display above combo box
		
		for i=1, #scenepov do
			
			if ImGui.Selectable(scenepov[i]) then
				entity["type"] = scenepov[i]
				
				scenepovtype = scenepovtype
				ImGui.SetItemDefaultFocus()
			end
			
			
			
		end
		
		ImGui.EndCombo()
	end
	
	if(entity["type"] == "entity")then
		
		ImGui.Text("Entity : ") 
		ImGui.SameLine()
		entity["entity"] = ImGui.InputText("##tag", entity["entity"], 100, ImGuiInputTextFlags.None)
		
	end
	ImGui.Text("Use Surveillance Camera ? : ") 
	ImGui.SameLine()
	entity["surveillance"] = ImGui.Checkbox("##surveillance", entity["surveillance"])
	
	
	entity["x"] =  ImGui.DragFloat("##povx", entity["x"], 0.01, -9999, 9999, "%.3f X")
	entity["y"] =  ImGui.DragFloat("##povy", entity["y"], 0.01, -9999, 9999, "%.3f Y")
	entity["z"] =  ImGui.DragFloat("##povz", entity["z"], 0.01, -9999, 9999, "%.3f Z")
	
	
	entity["roll"] =  ImGui.DragFloat("##povx", entity["roll"], 0.01, -9999, 9999, "%.3f yaw")
	entity["pitch"] =  ImGui.DragFloat("##povy", entity["pitch"], 0.01, -9999, 9999, "%.3f pitch")
	entity["yaw"] =  ImGui.DragFloat("##povz", entity["yaw"], 0.01, -9999, 9999, "%.3f roll")
	
	
	
	if ImGui.Button("Copy Player's XYZ", 300, 0) then
		
		local vec4 = Game.GetPlayer():GetWorldPosition()
		entity["x"] = vec4.x
		entity["y"] = vec4.y
		entity["z"] = vec4.z
		
		
		
		
	end
	
	if ImGui.Button("Copy Player's Rotation", 300, 0) then
		
		local v = Vector4.new(-Game.GetCameraSystem():GetActiveCameraForward().x, -Game.GetCameraSystem():GetActiveCameraForward().y, -Game.GetCameraSystem():GetActiveCameraForward().z, -Game.GetCameraSystem():GetActiveCameraForward().w)
		local euler = GetSingleton('Vector4'):ToRotation(v)
		
		entity["roll"] = euler.pitch
		entity["pitch"] = euler.roll
		entity["yaw"] = euler.yaw + 180
		
		
		
		
	end
	
	
	if ImGui.Button("Copy Looked Entity's XYZ", 300, 0) then
		
		if(objLook ~= nil)then
			local vec4 = objLook:GetWorldPosition()
			entity["x"] = vec4.x
			entity["y"] = vec4.y
			entity["z"] = vec4.z
		end
		
		
		
	end
	
	if ImGui.Button("Copy Looked Entity's Rotation", 300, 0) then
		
		if(objLook ~= nil)then
			local qat = objLook:GetWorldOrientation()
			local euler = GetSingleton('Quaternion'):ToEulerAngles(qat)
			
			
			entity["roll"] = euler.pitch
			entity["pitch"] = euler.roll
			entity["yaw"] = euler.yaw + 180
		end
		
		
		
	end
	
	
	if ImGui.Button("Try Camera", 300, 0) and entity["tag"] ~= "" then
		
		local obj = getEntityFromManager(entity["tag"])
		local enti = Game.FindEntityByID(obj.id)
		
		local position = {}
		position.x = entity["x"]
		position.y = entity["y"]
		position.z = entity["z"]
		
		local angle = {}
		angle.yaw = entity["yaw"]
		angle.pitch = entity["pitch"]
		angle.roll = entity["roll"]
		
		
		if(enti ~= nil) then
			
			spawnCamera(entity["tag"],entity["type"],entity["entity"],position,angle,false)
			enableCamera(entity["tag"])
			else
			moveCamera(entity["tag"],entity["type"],entity["entity"],position,angle,false)
		end
		
		
		
	end
	
	
	if ImGui.Button("Stop Camera", 300, 0) and currentSelectSceneStep.pov.tag ~= "" then
		
		
		despawnEntity(entity["tag"])
		
		
	end
	
	
	
	
	
	
	
	
	return entity
end

function EffectUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Effect : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##statutEffect", entity["value"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(statutEffect) do
			
			if ImGui.Selectable(v, (entity["value"] == v)) then
				
				
				entity["value"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
end


function ExpressionUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	if(entity["value"] == nil) then entity["value"]="Neutral"end
	ImGui.Text("Expressions : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##statutEffect", entity["value"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(reactionlist) do
			
			if ImGui.Selectable(v.name, (entity["value"] == v.name)) then
				
				
				entity["value"] = v.name
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
end


function FXUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 100, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Source FX : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##Fxobjectlist", defaultFXlist) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(Fxobjectlist) do
			
			if ImGui.Selectable(v, (defaultFXlist == v)) then
				
				
				defaultFXlist = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	if(defaultFXlist == "player") then
		
		ImGui.Text("Effect : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##transistionFX",defaukltFX) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(transistionFX) do
				
				if ImGui.Selectable(v, (entity["value"] == v)) then
					
					
					entity["value"] = v
					defaukltFX = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	if(defaultFXlist == "npc") then
		
		ImGui.Text("Effect : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcFX",defaukltFX) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(npcFX) do
				
				if ImGui.Selectable(v, (entity["value"] == v)) then
					
					
					entity["value"] = v
					defaukltFX = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	
	if(defaultFXlist == "car") then
		
		ImGui.Text("Effect : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##carFX",defaukltFX) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(carFX) do
				
				if ImGui.Selectable(v, (entity["value"] == v)) then
					
					
					entity["value"] = v
					defaukltFX = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	
	if(defaultFXlist == "all") then
		
		ImGui.Text("Effect : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##listFX",defaukltFX) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(listFX) do
				
				if ImGui.Selectable(v, (entity["value"] == v)) then
					
					
					entity["value"] = v
					defaukltFX = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
end



function makeListString(enti)
	
	ImGui.Text("Add an value :") 
	defaulttag =  ImGui.InputText("##makeListString",defaulttag, 100, ImGuiInputTextFlags.AutoSelectAll)
	if ImGui.Button("Add this tag") then
		
		table.insert(enti,defaulttag)
		
	end
	
	if ImGui.Button("Delete Last value") then
		
		table.remove(enti,#enti)
		
	end
	
	
end

function makeListAction(enti)
	
	
	local actionToAdd = {}
	
	actionFactory(actionToAdd)
	
	if ImGui.Button("Add this action") then
		
		table.insert(enti,actionToAdd)
		
	end
	
	local resumeString = ""
	
	if(#enti >0)then
		for i = 1,#enti do 
			
			
			local virgule = ""
			if(i > 1) then
				virgule = ","
			end
			
			resumeString = resumeString..virgule..enti[i].name
		end
	end
	
	ImGui.Text(resumeString)
	
	
	
	
	
end

function openJson()
	
	
	
	
	ImGui.SetNextWindowPos(200, 150, ImGuiCond.Appearing) -- set window position x, y
	ImGui.SetNextWindowSize(1200, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Json Editor") then
		
		editor_json_tag = ImGui.InputText("Filename", editor_json_tag, 100, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Spacing()
		
		editor_json = ImGui.InputTextMultiline("Content", editor_json, 99999 , 1000, 400, ImGuiInputTextFlags.None)
		
		ImGui.Spacing()
		
		if(editor_json_malformatted == true)then
			
			ImGui.InputTextMultiline("##Error", editor_json_malformatted_error, 99999 , 1000, 400, ImGuiInputTextFlags.ReadOnly)
			else
			ImGui.Text(editor_json_malformatted_error)
		end
		
		
		ImGui.Spacing()
		
		if ImGui.Button(getLang("editor_export")) then
			editor_json_malformatted = false
			editor_json_malformatted_error = ""
			try {
				function()
					json.decode(editor_json)
					local file = assert(io.open("json/report/"..editor_json_tag..".json", "w"))
					local stringg = editor_json
					
					file:write(stringg)
					file:close()
					
					editor_json_malformatted_error = "File saved !"
				end,
				
				catch {
					function(error)
						debugPrint(1,'caught error: (file :'..editor_json..error)
						
						obj = temp
						editor_json_malformatted_error = 'caught error: (file :'..editor_json..error
					end
				}
			}
			
			
			
		end
		ImGui.SameLine()
		if ImGui.Button("Save to Editor") then
			editor_json_malformatted = false
			editor_json_malformatted_error = ""
			local temp = editor_json_obj
			try {
				function()
					
					if(editor_json_obj_name == "activeEditedQuest") then
						activeEditedQuest = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedPOI") then
						activeEditedPOI = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedInteract") then
						activeEditedInteract = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedDialog") then
						activeEditedDialog = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedFixer") then
						activeEditedFixer = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedPlace") then
						activeEditedPlace = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedFunction") then
						activeEditedFunction = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedFaction") then
						activeEditedFaction = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedRadio") then
						activeEditedRadio = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedNode") then
						activeEditedNode = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedCircuit") then
						activeEditedCircuit = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedPath") then
						activeEditedPath = json.decode(editor_json)
					end
					
					
					if(editor_json_obj_name == "activeEditedEvent") then
						activeEditedEvent = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedLang") then
						activeEditedLang = json.decode(editor_json)
					end
					
					
					if(editor_json_obj_name == "activeEditHelp") then
						activeEditHelp = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedTheme") then
						activeEditedTheme = json.decode(editor_json)
					end
					
					
					if(editor_json_obj_name == "activeEditedInterfaces") then
						activeEditedInterfaces = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedCustomNPC") then
						activeEditedCustomNPC = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedShard") then
						activeEditedShard = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedPhoneDialog") then
						activeEditedPhoneDialog = json.decode(editor_json)
					end
					
					if(editor_json_obj_name == "activeEditedScene") then
						activeEditedScene = json.decode(editor_json)
					end
					
				end,
				
				catch {
					function(error)
						debugPrint(1,'caught error: (file :'..editor_json..error)
						
						obj = temp
						editor_json_malformatted = true
						editor_json_malformatted_error = 'caught error: (file :'..editor_json..error
					end
				}
			}
			
			
		end
		
		
		
		ImGui.SameLine()
		if ImGui.Button("Close") then
			
			editor_json_malformatted = false
			editor_json_malformatted_error = ""	
			editor_json = ""
			editor_json_tag = ""
			editor_json_obj = nil
			editor_json_obj_name = ""
			editor_json_view = false
			
		end
		
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.PopStyleVar(2)
	ImGui.End()
	
	
	
end
