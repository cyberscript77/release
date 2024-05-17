
--Messages

--load the conversation header
function NewHudPhoneGameController_ToggleShowAllMessages(this,types) 
	if(observerthread4  == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))    then return end
	GameController["NewHudPhoneGameController"] = this
	local dots = ContactData.new()
	local messages = {}
	if(types == nil) then
		types = this.screenType
	end
	this.screenType = types;
    
	if( this.screenType == PhoneScreenType.Unread) then
		messages = MessengerUtils.GetSimpleContactDataArray(this.journalMgr, true, true, this.isShowingAllMessages);
		
		
		for k,v in pairs(cyberscript.cache["phone_dialog"]) do
			local phoneConversation = v.data
			
			-- if(getScoreKey(phoneConversation.tag,"unlocked") == nil or getScoreKey(phoneConversation.tag,"unlocked") == 1) then
			if(true) then
				
				if phoneConversation.hash == nil then
					cyberscript.cache["phone_dialog"][k].data.hash = 0 - tonumber("1308"..math.random(1,999))
					
					phoneConversation.hash = cyberscript.cache["phone_dialog"][k].data.hash
				end
				
				
				for z=1,#phoneConversation.conversation do
				
					unreadcount = 0
					local unreadMessages  = {}
					local latestmessage  = {}
					local playerCanReply  = 0
					local conversation = phoneConversation.conversation[z]
					if(getScoreKey(conversation.tag,"unlocked") == nil or getScoreKey(conversation.tag,"unlocked") == 1) then
						if(conversation.message ~= nil and #conversation.message>0) then
							for y=1,#conversation.message do
								if((getScoreKey(conversation.message[y].tag,"unlocked") == nil or getScoreKey(conversation.message[y].tag,"unlocked") == 1)) then
									latestmessage   =  conversation.message[y]
								
									if((getScoreKey(conversation.message[y].tag,"readed") == nil or getScoreKey(conversation.message[y].tag,"readed") == 0)) then
										unreadcount = unreadcount + 1
										table.insert(unreadMessages ,unreadcount)
										
									end
								end
							end
						end
						
						
						local itemData = ContactData.new()
						itemData.id = conversation.tag
						
					
					
						
					
						itemData.contactId = phoneConversation.speaker;

						
						itemData.localizedName  =  getLang(phoneConversation.speaker)
						itemData.localizedPreview  =  conversation.name
						itemData.avatarID = TweakDBID.new("PhoneAvatars.Avatar_Unknown")
						itemData.questRelated  =  false
						itemData.hasQuestImportantReply  =  false
						itemData.hasMessages   =  false
						itemData.isCallable = false
						itemData.unreadMessegeCount  = unreadcount
						itemData.unreadMessages  = unreadMessages
						itemData.playerCanReply   =  (latestmessage.choices and #latestmessage.choices > 0)
						itemData.playerIsLastSender   =  latestmessage.sender == 1
						itemData.lastMesssagePreview  =  conversation.name
						itemData.threadsCount  = 0
						cyberscript.cache["phone_dialog"][k].data.conversation[z].hash =0 - tonumber(tostring(phoneConversation.hash)..math.random(1,100))
						cyberscript.cache["phone_dialog"][k].data.conversation[z].conversationHash =0 - tonumber(tostring(phoneConversation.hash)..math.random(1,100))
						itemData.conversationHash=cyberscript.cache["phone_dialog"][k].data.conversation[z].conversationHash
						itemData.hash  =cyberscript.cache["phone_dialog"][k].data.conversation[z].hash
						itemData.type = MessengerContactType.MultiThread
						itemData.timeStamp = Game.GetTimeSystem():GetGameTime()

						if(this.isShowingAllMessages) then
						
							
								if((getScoreKey(latestmessage.tag,"readed") == nil or getScoreKey(latestmessage.tag,"readed") == 1 or getScoreKey(latestmessage.tag,"readed") == 0)) then
									table.insert(messages, itemData)
									
								end
							
						
					else
						
							if((getScoreKey(latestmessage.tag,"readed") == nil or getScoreKey(latestmessage.tag,"readed") == 0)) then
								table.insert(messages, itemData)
								
							end
						
						end
					end
				end
			end
		end
		
	
		if(#messages > 0 and this.contactListLogicController ~= nil) then
			this.contactListLogicController:UpdateShowAllButton(this.isShowingAllMessages);
			this.contactListLogicController:SetSortMethod(ContactsSortMethod.ByTime);
			this.contactListLogicController:PopulateListData(messages, this.indexToSelect, this.messageToOpenHash);
			this.contactListLogicController:SwtichTabs(PhoneDialerTabs.Unread);
			this:HideThreads();
		end
		
	end
	
    
	
end

--handle change of contact conversation
function NewHudPhoneGameController_OnContactSelectionChanged(this,evt)
	if(observerthread4  == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))    then return end
	GameController["NewHudPhoneGameController"] = this
	print("NewHudPhoneGameController_OnContactSelectionChanged")
	
	currentPhoneConversation = nil
	
	if(evt.ContactData ~= nil) then
		for k,v in pairs(cyberscript.cache["phone_dialog"]) do
			local phoneConversation = v.data
			for z=1,#phoneConversation.conversation do
				local conversation = phoneConversation.conversation[z]
				
				if(conversation.tag == evt.ContactData.id)then
					
					currentPhoneConversation = conversation
					currentPhoneConversation.currentchoices = {}
					currentPhoneConversation.speaker = phoneConversation.speaker
					
					currentPhoneConversation.loaded = 0
					
					
				end
			end
		end
	end
end

--load of message UI item when open conversation of contact
function MessengerDialogViewController_SetVisited(thos, records) 
	if(observerthread4 == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))   then return end
	
	local messages = thos.messages
	local choices = thos.replyOptions
	
	
	GameController["MessengerDialogViewController"]  = thos
	
		
		if(currentPhoneConversation ~= nil ) then
		
			
			for i=1,#currentPhoneConversation.message do
				local msgexist = false
				local chcexist = false
				local sms = currentPhoneConversation.message[i]
				
				if( getScoreKey(sms.tag,"unlocked") == 1) then
					if(sms.unlocknext ~= nil and sms.unlocknext ~= "" and (waitingforanswer == nil or (waitingforanswer ~= nil and waitingforanswer.unlocknext ~= sms.unlocknext)) ) then
							setScore(sms.unlocknext,"unlocked",1)
							
					end	
					setScore(sms.tag,"readed",1)
					if(GameController["PhoneHotkeyController"] ~= nil)then
						PhoneHotkeyController_UpdateData(GameController["PhoneHotkeyController"])
					end
					local test = gameJournalPhoneMessage.new()
					test.sender = sms.sender
					test.text = getLang(sms.text)
					test.delay = -9999
					test.id = sms.tag
					for y=1,#messages do
						
						if(test.id == messages[y].id) then
							msgexist = true
						end
					end
					if(msgexist == false) then
						table.insert(messages,test)
						
					end
					if(#sms.choices > 0) then
						if(getScoreKey(sms.tag,"unlocked") == 1) then
							for z=1,#sms.choices do
								local reply = sms.choices[z]
								
								if((getScoreKey(reply.tag,"unlocked") == 0 or getScoreKey(reply.tag,"unlocked") == nil ) and checkTriggerRequirement(reply.requirement,reply.trigger)) then
									local test2 = gameJournalPhoneMessage.new()
									test2.sender = 1
									test2.text = getLang(reply.text)
									test2.delay = -9999
									test2.id = reply.tag
									reply.parent = sms.tag

									for y=1,#choices do
										
										if(test2.id == choices[y].id) then
											chcexist = true
										end
									end
									if(chcexist == false) then
										table.insert(currentPhoneConversation.currentchoices,reply)
										table.insert(choices,test2)
									end

									
								end
							end
						end
					end
					
				end
			end
		
			thos.messages = messages
			thos.replyOptions = choices


			thos.messagesListController:Clear()
			thos.messagesListController:PushEntries(thos.messages)

			thos.choicesListController:Clear()
			thos.choicesListController:PushEntries(thos.replyOptions)

				if #(thos.replyOptions) > 0 then
					thos.choicesListController:SetSelectedIndex(0)
				end

				if IsDefined(thos.newMessageAninmProxy) then
					thos.newMessageAninmProxy:Stop()
				end

				countMessages = thos.messagesListController:Size()

				if records and countMessages > 0 then
					lastMessageWidget = thos.messagesListController:GetItemAt(countMessages - 1)
				end

				if IsDefined(lastMessageWidget) then
					thos.newMessageAninmProxy = thos:PlayLibraryAnimationOnAutoSelectedTargets("new_message", lastMessageWidget)
				end

				thos.scrollController:SetScrollPosition(1.00)
		end
	
end

--load the entry of message and the refresh of typing
function MessengerDialogViewController_UpdateData(self,animateLastMessage,setVisited)
	
	
	if(observerthread4  == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))    then return end
	Cron.After(0.5,function()
	
		if(observerthread4 == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))   then return end
		
		
		
		if waitingforanswer ~= nil and loadsms ~= true then
			
			local speaker = currentPhoneConversation.speaker
			
			self.typingIndicatorController:SetName(speaker);
			self.typingIndicatorController:SetPlayerTypingStyle(false,true);
			
			self:PlayDotsAnimation();
			
			loadsms = true
			
				if(waitingforanswer.unlocknext ~= nil and waitingforanswer.unlocknext ~= "" and getScoreKey(waitingforanswer.unlocknext,"unlocked") ~= 1) then
					local messages = GameController["MessengerDialogViewController"].messages
					
				
					setScore(waitingforanswer.unlocknext,"unlocked",1)
					if(GameController["PhoneHotkeyController"] ~= nil)then
						PhoneHotkeyController_UpdateData(GameController["PhoneHotkeyController"])
					end
					local test = gameJournalPhoneMessage.new()
					test.sender = 1
					test.text = "aaa"
					test.delay = -9999
					test.id = waitingforanswer.tag

					table.insert(messages,test)
					GameController["MessengerDialogViewController"].messages = messages
				
					GameController["MessengerDialogViewController"].messagesListController:Clear()
					GameController["MessengerDialogViewController"].messagesListController:PushEntries(GameController["MessengerDialogViewController"].messages)
					local countMessages = GameController["MessengerDialogViewController"].messagesListController:Size()
					local lastMessageWidget = GameController["MessengerDialogViewController"].messagesListController:GetItemAt(countMessages - 1);
					GameController["MessengerDialogViewController"]:PlayLibraryAnimationOnAutoSelectedTargets("reply_sent", lastMessageWidget);
				end
				
			
			local writingtime = math.random(1,5)
			Cron.After(writingtime, function()
				for i = 1, #currentPhoneConversation.currentchoices do
					
					setScore(currentPhoneConversation.currentchoices[i].tag,"unlocked",1)
					
				end
				
				currentPhoneConversation.currentchoices = {}
					for i=1,#currentPhoneConversation.message do
						local msgexist = false
						local sms = currentPhoneConversation.message[i]
						
						if( getScoreKey(sms.tag,"unlocked") == 1 or getScoreKey(sms.tag,"unlocked") == 3) then
							if(sms.unlocknext ~= nil and sms.unlocknext ~= "") then
								setScore(sms.unlocknext,"unlocked",3)
								
							end
							if(getScoreKey(sms.tag,"unlocked") == 3) then
							
								setScore(sms.tag,"unlocked",1)
							end
							if(#sms.choices > 0) then
								

									for z=1,#sms.choices do
										local reply = sms.choices[z]
										
										if((getScoreKey(reply.tag,"unlocked") == 0 or getScoreKey(reply.tag,"unlocked") == nil ) and checkTriggerRequirement(reply.requirement,reply.trigger)) then
											
											table.insert(currentPhoneConversation.currentchoices,reply)
											
										end
									end
								
							end
							
						end
					end
					
					
				self.choicesList:SetVisible(true)
				self:StopDotsAnimation()
				waitingforanswer = nil
				GameController["MessengerDialogViewController"]:UpdateData(true,true)
				loadsms = false
				
			end)
			
		end
		
	end)
end


--load the ui of messages UI items
function MessangerItemRenderer_OnJournalEntryUpdated(self,entry,extraData)
	
	
	if(observerthread4 == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))   then return end
	Cron.After(0.1,function()
		local message = entry
		local txt = ""
		local typo =  1
		
		--	----printmessage.id.."titi")
		if(message.delay == -9999 and currentPhoneConversation ~= nil) then
			for i=1,#currentPhoneConversation.message do
				local sms = currentPhoneConversation.message[i]
				
				
				
				
					
					if(sms.tag == message.id) then
						checkContext(sms)
						txt = getLang(sms.text)
						if(sms.sender == 0) then
							typo = MessageViewType.Received 
							else
							typo = MessageViewType.Sent
						end
						self:SetMessageView(txt, typo, "")
						if(sms.action ~= nil and #sms.action > 0) then
							runActionList(sms.action, sms.tag, "interact",false,"nothing",sms.action_bypassmenu_execution)
						end
					end
					if(#sms.choices > 0) then
						for z=1,#sms.choices do
						
						
							if(checkTriggerRequirement(sms.choices[z].requirement,sms.choices[z].trigger)) then
								logme(2,getScoreKey(sms.choices[z].tag,"unlocked"))
								logme(2,sms.choices[z].tag)
								
								
								if(sms.choices[z].tag == message.id) then
									checkContext(sms.choices[z].tag)
									
									
									
									txt = sms.choices[z].text
									txt = getLang(txt)
									
									self:SetMessageView(txt, MessageViewType.Sent, "")
									--	self:SetMessageView(sms.choices[z].text, typo, "")
									inkTextRef.SetText(self.fluffText, sms.choices[z].tag)
									inkTextRef.SetText(self.labelPathRef, txt)
									--				inkTextRef.SetText(thos.m_fluffText, "CHKSUM_" + IntToString(contact.hash));
								end
							end
						end
					end
				
			end
		end
		if(GameController["PhoneHotkeyController"] ~= nil)then
			PhoneHotkeyController_UpdateData(GameController["PhoneHotkeyController"])
		end
		
	end)
end

--load the ui of reply UI items
function MessangerReplyItemRenderer_OnJournalEntryUpdated(self,entry,extraData)
	Cron.After(0.1,function()
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	
		local message = entry
		local txt = ""
		local typo =  1
		
		
		--print"test")
		
		
		if(message.delay == -9999) then
			
			for i=1,#currentPhoneConversation.message do
				
				
				local sms = currentPhoneConversation.message[i]
				
				
				
				if( getScoreKey(sms.tag,"unlocked") == 1) then
					

					if(#sms.choices > 0) then
						
						for z=1,#sms.choices do
							if((getScoreKey(sms.choices[z].tag,"unlocked") == 0 or getScoreKey(sms.choices[z].tag,"unlocked") == nil) and checkTriggerRequirement(sms.choices[z].requirement,sms.choices[z].trigger)) then
								
								
								
								if(sms.choices[z].tag == message.id) then
									
									checkContext(sms.choices[z])
									
									
									txt = sms.choices[z].text
									txt = getLang(txt)
									
								
									inkTextRef.SetText(self.labelPathRef,txt)
									self:SetActive(true)
									
								end
							end
						end
					end
				end
			end
		end
		if(GameController["PhoneHotkeyController"] ~= nil)then
			PhoneHotkeyController_UpdateData(GameController["PhoneHotkeyController"])
		end
	end)
end

--fire the reply
function MessengerDialogViewController_ActivateReply(self,target)
	
	if(observerthread4 == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))   then return end
	local choicepress = false
	if(currentPhoneConversation ~= nil) then
		for i = 1, #currentPhoneConversation.currentchoices do
			
			setScore(currentPhoneConversation.currentchoices[i].tag,"unlocked",1)
			
			if(tostring(getLang(currentPhoneConversation.currentchoices[i].text)) == tostring(target.labelPathRef:GetText())) then
				
				choicepress = true
				
				if choicepress == true then
					
					
					
					
					waitingforanswer = deepcopy(currentPhoneConversation.currentchoices[i],nil)
					self.choicesList:SetVisible(false)
					
					break
				end
			end
			
		end
		if(GameController["PhoneHotkeyController"] ~= nil)then
			PhoneHotkeyController_UpdateData(GameController["PhoneHotkeyController"])
		end
	end
end

--fire reload from reply
function MessangerItemRenderer_GetData(self)
	if(observerthread4 == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))   then return end
	Cron.NextTick(function()
		local choicepress = false
		
		if(currentPhoneConversation ~= nil) then
			for i = 1, #currentPhoneConversation.currentchoices do
				
				if(tostring(getLang(currentPhoneConversation.currentchoices[i].text)) == tostring(self.labelPathRef:GetText())) then
					choicepress = true
					
					if choicepress == true then
						
						GameController["MessengerDialogViewController"]:UpdateData()
						
						break
					end
				end
			end
			
		end
		if(GameController["PhoneHotkeyController"] ~= nil)then
			PhoneHotkeyController_UpdateData(GameController["PhoneHotkeyController"])
		end
	end)
end




--Phone

--Add contact
function PhoneDialerGameController_PopulateData(thos,contactDataArray, selectIndex, itemHash)
	
	
	
	if(GameController["NewHudPhoneGameController"].screenType ==  PhoneScreenType.Contacts) then
		refreshContact()
		
		
		
        if(#contactList > 0) then
            for i = 1, #contactList do
                local itemData = ContactData.new()
                itemData.id = contactList[i].id
                itemData.localizedName  = contactList[i].name
                itemData.avatarID = TweakDBID.new(contactList[i].avatarID)
                itemData.questRelated  =  false
                itemData.hasMessages   =  true
                itemData.isCallable = true
                itemData.unreadMessegeCount  = 0
                itemData.unreadMessages  = {}
                itemData.playerCanReply   =  false
                itemData.playerIsLastSender   =  false
                itemData.lastMesssagePreview  =  "CyberScript"
                itemData.threadsCount  = 0
                
                itemData.hash  = 0
                itemData.type = MessengerContactType.Contact
                
                local canaddcontact = true
                
                for k,v in ipairs(contactDataArray) do
                    if(v.id ==  contactList[i].id) then
                        canaddcontact = false
                    end
                    
                end
                
                if(canaddcontact)then table.insert(contactDataArray,itemData) end
            end
        
        
        end
	
	
        if GetMod('corruptNCPD') then 
            
            local corruptNCPD= GetMod('corruptNCPD')			
            
            for name, data in pairs(corruptNCPD.messenger.contacts) do
                local c = ContactData.new()
                c.id = "trainer_fred"
                c.avatarID = TweakDBID.new("PhoneAvatars.Avatar_Unknown")
                c.localizedName = CorruptNCPDLang.getText(data.name)
                c.hash = data.hash
                c.timeStamp = Game.GetTimeSystem():GetGameTime()
                c.questRelated = EnumInt(Game.GetScriptableSystemsContainer():Get("PreventionSystem"):GetHeatStage()) ~= 0
                table.insert(contactDataArray, c)
            end
            
            
        end
	
	
		thos.dataView:EnableSorting();
		thos.dataSource:Reset(contactDataArray);
		thos.dataView:DisableSorting();

	
	end
	
end

--selected contact call
function PhoneDialerGameController_CallSelectedContact_Observer(thos,contactData)
	
	GameController["NewHudPhoneGameController"] = thos
	if(observerthread4 == true or moddisabled  == true)   then return end
	
	
	if(#contactList > 0) then
		for i = 1, #contactList do
			----printcontactData.id)
			if(contactList[i].id == contactData.id) then
				if(contactList[i].phonetype == "NPC") then
					
					
					
					currentNPC = findPhonedNPCByName(contactList[i].truename)
					
					if(currentNPC ~= nil) then
						
						local actionlist = {}
						local action = {}
						action.title = {}
						
						
						local title = getLang("observer_callselectedcontact_msg01")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg02")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg03")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg04")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg05")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg06")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg07")
						
						table.insert(action.title,title)
						
						action.name = "random_subtitle"
						action.speaker = contactList[i].truename
						
						action.type = 1
						action.target = "player"
						action.duration = 3
						
						table.insert(actionlist,action)
						
						
						
						action = {}
						
						
						
						action.title = getLang("observer_callselectedcontact_v_answer")
						
						
						action.name = "subtitle"
						action.speaker = contactList[i].truename
						
						action.type = 1
						action.target = "player"
						action.duration = 3
						
						table.insert(actionlist,action)
						
						
						action = {}
						
						action.name = "speak_npc"
						action.way = "phone"
						action.speaker = "current_phone_npc"
						
						
						table.insert(actionlist,action)
						
						
						
						runActionList(actionlist,"call_"..contactData.id,"phone",false,"player")
						
						else
						
						logme(10,"can't find currentNPC ".. contactList[i].truename)
						Game.GetPlayer():SetWarningMessage(getLang("observer_callselectedcontact_unknown"))
					end
					
				end
				if(contactList[i].phonetype == "Service") then
					local interact = cyberscript.cache["interact"][contactList[i].id].data
					runActionList(interact.action,interact.tag,"interact",false,"player")
				end
				if(contactList[i].phonetype == "Fixer") then
					local phoned = getFixerByTag(contactData.id)
					if(phoned ~= nil) then
						phonedFixer = true
						phoneAnimFixer = true
						currentfixer = phoned
						
						local actionlist = {}
						local action = {}
						
						action.name = "hacking_notification"
						action.title =  getLang("observer_callselectedcontact_v_answer")
						action.title = getLang("download_quest_from_01")..phoned.name..getLang("download_quest_from_02")
						action.duration = 3
						
						table.insert(actionlist,action)
						
						
						
					end
				end
			end
		end
	end
	
	thos:CloseContactList()
	
	
end

--IncomingCall
function PhoneSystem_OnTriggerCall(thos, request)
	if(observerthread4 == true or moddisabled  == true)   then return end
	
	local contactName = request.addressee
	
	if IsNameValid(contactName) == false then
		
		
		thos:TriggerCall(questPhoneCallMode.Video,
         false, 
         "CyberScript",
          false, 
          questPhoneCallPhase.IncomingCall, 
          false,
           false,
          false,
          questPhoneCallVisuals.Default
        )

       
	end
	
end

-- don't call if it's CS contact
function PhoneDialerGameController_CallSelectedContact(thos, wrappedMethod)
    return wrappedMethod()
	-- if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod() end
	-- local callRequest = nil
	-- local item = thos.listController:GetSelectedItem()
	-- local contactData = item:GetContactData()
	
	-- if IsDefined(contactData) and contactData.lastMesssagePreview ~= "CyberScript" then
		
	-- 	return wrappedMethod()
		
	-- end
end




--Popup


function MessengerNotification_OnAction(self,action, consumer)
	
	if(currentPhoneConversation ~= nil and currentPhoneConversation == "cs_nothing") then
	
	else
        GameController["NewHudPhoneGameController"].PhoneSystem:QueueRequest( UsePhoneRequest.new());
	
	end
	
end

--open phone for custom phone notif 
function PhoneMessagePopupGameController_SetupData(this,wrappedMethod)
	if(observerthread4 == true or moddisabled == true or (phonetest ~= true and phonetest ~= nil))   then return end
	
	GameController["PhoneMessagePopupGameController"] = this
	if(currentPhoneConversation ~= nil and currentPhoneConversation ~= "cs_nothing"	and GameController["NewHudPhoneGameController"]:IsPhoneActive() == false) then
	
	
	local test = gameJournalPhoneMessage.new()
	Cron.After(0.1,function()
		logme(1,"Open phone")
		GameController["PhoneMessagePopupGameController"]:UnregisterFromGlobalInputCallback("OnPostOnRelease", GameController["PhoneMessagePopupGameController"], "OnHandleMenuInput");
		PopupStateUtils.SetBackgroundBlur(GameController["PhoneMessagePopupGameController"], true);
		GameController["PhoneMessagePopupGameController"].uiSystem:PopGameContext(UIGameContext.ModalPopup);
		GameController["PhoneMessagePopupGameController"].uiSystem:RestorePreviousVisualState("inkModalPopupState");
		GameController["PhoneMessagePopupGameController"]:SetTimeDilatation(true);
		GameController["PhoneMessagePopupGameController"]:RequestUnfocus()
		GameController["PhoneMessagePopupGameController"]:HandleCommonInputActions("cancel")
		GameController["PhoneMessagePopupGameController"]:ClosePopup()
		Cron.After(0.1,function()
			GameController["NewHudPhoneGameController"].PhoneSystem:QueueRequest( UsePhoneRequest.new());
			uiActionPerformed= DPADActionPerformed.new()
            uiActionPerformed.successful = true;
            uiActionPerformed.state = EUIActionState.COMPLETED;
            GameController["NewHudPhoneGameController"].buttonPressed = false;
            Game.GetUISystem():QueueEvent(uiActionPerformed);
			
		end)
		
	end)
	
	
	
	
	else
	
	if(currentPhoneConversation ~= nil and currentPhoneConversation == "cs_nothing") then
		logme(1,"load coSSSnv")
		GameController["PhoneMessagePopupGameController"]:HandleCommonInputActions("cancel")
		GameController["PhoneMessagePopupGameController"]:ClosePopup()
		
		end
		
		
		if(currentPhoneConversation ~= nil and currentPhoneConversation ~= "cs_nothing" and GameController["NewHudPhoneGameController"]:IsPhoneActive() == true
		)then
		logme(1,"load conv")
		
		local test = gameJournalPhoneMessage.new()
		this.dialogViewController:ShowThread(test)
		else
		logme(1,"wrappedMethod")
		wrappedMethod()
		end
		
	end
	
	
	
end


function PopupsManager_OnMessagePopupUseCloseRequest(self)
	if(observerthread5 == true or moddisabled  == true)   then return end
	if(currentPhoneConversation ~= nil) then
		
		currentPhoneConversation = nil
	end
	
	
end


-- HUD

function PhoneHotkeyController_UpdateData(self)

	if(self ~= nil) then
		local unreadcount = 0

		for k,v in pairs(cyberscript.cache["phone_dialog"]) do
			local phoneConversation = v.data
			
			
			if(true) then
				
				
				
				
				for z=1,#phoneConversation.conversation do
				
					
					
					local conversation = phoneConversation.conversation[z]
					
					if(getScoreKey(conversation.tag,"unlocked") ~= 0) then
						if(conversation.message ~= nil and #conversation.message>0) then
							for y=1,#conversation.message do
								if((getScoreKey(conversation.message[y].tag,"unlocked")== 1)) then
									
								
									if((getScoreKey(conversation.message[y].tag,"readed") ~= 1)) then
										unreadcount = unreadcount + 1
									--	print("add "..conversation.message[y].tag)
										
									end
								end
							end
						end
						
						
						
							
						
					
				end
			end
		end
		end
	
		local counter = 0
		

		local currentcount = self.messageCounter:GetText()

		
		local questMessagesCount = 0
		local unreadMessagesCount = 0

		if (self.journalManager ~= nil) then
		
			local contacts = MessengerUtils.GetSimpleContactDataArray(self.journalManager, true, true, false);
		
		
			for i,contactEntry in ipairs(contacts) do
				
				unreadMessagesCount = unreadMessagesCount + #contactEntry.unreadMessages
				
			end
			currentcount = unreadMessagesCount
		end

		
		local rescount = currentcount+unreadcount

		if(rescount>0) then
			if(self.messageCounterLabel.widget.visible == false) then
				inkTextRef.SetVisible(self.messageCounterLabel, true);
			end
		else
			if(self.messageCounterLabel.widget.visible == true) then
				inkTextRef.SetVisible(self.messageCounterLabel, false);
			end
		end

		if(currentcount ~= "9+") then
			
			
			if(rescount>9) then
				
				inkTextRef.SetText(self.messageCounter, "9+");
			else
				inkTextRef.SetText(self.messageCounter, rescount);
			end

		else
			inkTextRef.SetText(self.messageCounter, "9+");

		end
		

	end
end


function PhoneHotkeyController_CountMessages(self)
	GameController["PhoneHotkeyController"] = self
	

end