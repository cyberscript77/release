logme(1,"CyberScript: saves module loaded")
cyberscript.module = cyberscript.module +1



function initGangDistrictScore()
	
	
for k,v in pairs(cyberscript.cache["faction"]) do
	
	if(cyberscript.cache["faction"][k].data.haveterritory == nil or cyberscript.cache["faction"][k].data.haveterritory == true) then 
	
	if(currentSave.Variable[k] == nil) then
	
	currentSave.Variable[k] = {}
	
	
	end
	
	
	for j=1,#arrayDistricts do 
	
	
		local isOwner = false
		
		if(cyberscript.cache["faction"][k].data.district_tag == arrayDistricts[j].Tag) then
		
		currentSave.Variable[k][arrayDistricts[j].Tag] = 100
		 isOwner = true
		else
		
		currentSave.Variable[k][arrayDistricts[j].Tag] = 0
		
		end
		
		if(#arrayDistricts[j].SubDistrict > 0) then
			for z=1,#arrayDistricts[j].SubDistrict do
				
				if(isOwner) then
				currentSave.Variable[k][arrayDistricts[j].SubDistrict[z]] = 100
			
				else
				
				currentSave.Variable[k][arrayDistricts[j].SubDistrict[z]] = 0
				
				end
			end
		end
		
		
	end
	
	end
end


end

function initGangRelation()
	
	
	
for k,v in pairs(cyberscript.cache["faction"]) do
	
	
	
	if(currentSave.Variable[k] == nil) then
	
		currentSave.Variable[k] = {}
	
	
	end
	
	
	for x,y in pairs(cyberscript.cache["faction"]) do
	
		local isrival = false
		for i=1, #v.data.rivals do
		
			if(v.data.rivals[i] == x) then
			isrival = true
			break
			end
		end
		
		if(isrival == true) then
			currentSave.Variable[k][x] = -100
			else
			currentSave.Variable[k][x] = 0
		end
	
	end
end
	
	
end



function getUserSetting(tag)
	
	
	return arrayUserSetting[tag]
	
	
end

function getUserSettingWithDefault(tag,default)
	
	
	if( arrayUserSetting[tag] == nil) then
		
		arrayUserSetting[tag] = default
	
	end
	
	return arrayUserSetting[tag]
	
end


function updateUserSetting(tag,value)
	
	
	
	
	arrayUserSetting[tag] = value
	
	
	
	
end




function saveHousing(item)
	item.Id = item.HouseTag.."_"..item.Tag.."_"..tostring(math.random(1,99999))
	
	local exist = false
	for i=1,#currentSave.arrayHousing do
	
		if(currentSave.arrayHousing[i].Id == item.Id) then
			exist = true
		end
	
	end
	
	if(exist == true) then
	
		item.Id = item.HouseTag.."_"..item.Tag.."_"..tostring(math.random(1,99999)).."_A"
	
	else
	
	table.insert(currentSave.arrayHousing, item)
	end
	
	
	
	
	
end

function deleteHousing(id)
	local index = nil
	
	for i=1,#currentSave.arrayHousing do
	
		if(currentSave.arrayHousing[i].Id == id) then
			index = i
		end
	
	end
	
	if(index ~= nil) then
		table.remove(currentSave.arrayHousing, index)
	
	end
	
end


function updateHousing(item)
	
	logme(4,item.Id)
	local res = false 
	for i=1,#currentSave.arrayHousing do
	
		if(currentSave.arrayHousing[i].Tag == item.Tag) then
			currentSave.arrayHousing[i].X = item.X
			currentSave.arrayHousing[i].Y = item.Y
			currentSave.arrayHousing[i].Z = item.Z
			currentSave.arrayHousing[i].Yaw = item.Yaw
			currentSave.arrayHousing[i].Pitch = item.Pitch
			currentSave.arrayHousing[i].Roll = item.Roll
			
			res = true
		end
	
	end
	return res
	
end

function getHousing(tag,x,y,z)
	
	for i = 1, #currentSave.arrayHousing do
	
	local item = currentSave.arrayHousing[i]
		
	if(tostring(item.Tag) == tostring(tag)) then
		logme(4,item.Tag)
		return item
	
	end
	
	end
end

function updatePlayerItemsQuantity(item,quantity)
	
	
	
	local tag = item.tag or item.Tag
	local title = item.title or item.Title
	local path = item.path or item.Path
	
	local newdata = true
	
	for i=1,#currentSave.arrayPlayerItems do
	
		if(currentSave.arrayPlayerItems[i].Tag == tag) then
			currentSave.arrayPlayerItems[i].Quantity = currentSave.arrayPlayerItems[i].Quantity + quantity
			newdata = false
		end
	
	end
	
	if(newdata == true) then
	
		local data = {}
		data.Tag = tag
		data.Title = title
		data.Path = path
		data.Quantity = quantity
		table.insert(currentSave.arrayPlayerItems, data)
	
	end
	
	
end





function addAffinityScoreByNPCId(tag)
	
	
		local scores = getScoreKey("Affinity",tag)
		if(scores == nil) then scores = 0 end
	
		scores = scores +1
		setScore("Affinity",tag,scores)
	
end

function addAffinityScoreByNPCIdScore(tag,changescore)
	
	local scores = getScoreKey("Affinity",tag)
		if(scores == nil) then scores = 0 end
	
		scores = scores +changescore
		setScore("Affinity",tag,scores)
	
	
end

function getNPCCallableByAffinity()
	
	contactList = {}
	arrayPhoneNPC = {}


	
	for k,v in pairs(cyberscript.entitieshash) do
	
			local score = getScoreKey("Affinity",v.entity_name)
			
			if(score ~= nil) then
				local quest = {}
				quest.ID= v.entity_id
				quest.TweakIDs= v.entity_name
				quest.Names= v.entity_name
				quest.Score = score
				table.insert(arrayPhoneNPC, quest)
				
				if(score >= 5)then
					local contactdata = {}
					contactdata.name =   getLang("save_phone_cmaffinity")..v.entity_name
					contactdata.id =   "cm_"..v.entity_name
					contactdata.avatarID = v.entity_tweak
					contactdata.phonetype = "NPC"
					contactdata.truename =  v.entity_name
					
					table.insert(contactList,contactdata)
				end
				
			end
			
	
		
	
	end
	
	
	for k,v in pairs(cyberscript.cache["interact"]) do 
							
	
			if(v.data.display == "phone_service" and checkTriggerRequirement(v.data.requirement,v.data.trigger))then
			print(v.data.name)
				local contactdata = {}
				contactdata.name =  getLang(v.data.name)
				contactdata.id =  v.data.tag
				contactdata.avatarID = "PhoneAvatars.Avatar_Unknown"
				contactdata.phonetype = "Service"
				
				table.insert(contactList,contactdata)
				
			end
		
		
		

	end
	
	
	for k,v in pairs(cyberscript.cache["fixer"]) do
			
			local score = getScoreKey("Affinity",cyberscript.cache["fixer"][k].data.Faction)
			if score ~= nil and score > 50 then 
				
				
			
				local contactdata = {}
				contactdata.name =  getLang("save_phone_cmfixer")..cyberscript.cache["fixer"][k].data.name
				contactdata.id =  k
				contactdata.avatarID = cyberscript.cache["fixer"][k].data.tweakid
				contactdata.phonetype = "Fixer"
				
				table.insert(contactList,contactdata)
			
			
				
			end
			
			
			
		end
	
	
	
end
	



function updateQuestStatut(tag,statut)
	
	local newdata = true
	
	for i=1,#currentSave.arrayQuestStatut do
	
		if(currentSave.arrayQuestStatut[i].Tag == tag) then
			currentSave.arrayQuestStatut[i].Statut = statut
			newdata = false
		end
	
	end
	
	if(newdata == true) then
	
		local data = {}
		data.Tag = tag
		data.Statut = statut
		data.Quantity = nil
		table.insert(currentSave.arrayQuestStatut, data)
	
	end
	
	
end	




function updateQuestQuantity(tag,quantity)
	
	local newdata = true
	
	for i=1,#currentSave.arrayQuestStatut do
	
		if(currentSave.arrayQuestStatut[i].Tag == tag) then
			currentSave.arrayQuestStatut[i].Quantity = quantity
			newdata = false
		end
	
	end
	
	if(newdata == true) then
	
		local data = {}
		data.Tag = tag
		data.Statut = 0
		data.Quantity = Quantity
		table.insert(currentSave.arrayQuestStatut, data)
	
	end
	
	
end	

function AddQuestQuantity(tag,quantity)
	
	local newdata = true
	
	for i=1,#currentSave.arrayQuestStatut do
	
		if(currentSave.arrayQuestStatut[i].Tag == tag) then
			currentSave.arrayQuestStatut[i].Quantity = currentSave.arrayQuestStatut[i].Quantity+quantity
			newdata = false
		end
	
	end
	
	if(newdata == true) then
	
		local data = {}
		data.Tag = tag
		data.Statut = 0
		data.Quantity = Quantity
		table.insert(currentSave.arrayQuestStatut, data)
	
	end
	
	
end

function RemoveQuestQuantity(tag,quantity)
	
	local newdata = true
	
	for i=1,#currentSave.arrayQuestStatut do
	
		if(currentSave.arrayQuestStatut[i].Tag == tag) then
			currentSave.arrayQuestStatut[i].Quantity = currentSave.arrayQuestStatut[i].Quantity-quantity
			newdata = false
		end
	
	end
	
	if(newdata == true) then
	
		local data = {}
		data.Tag = tag
		data.Statut = 0
		data.Quantity = 0-Quantity
		table.insert(currentSave.arrayQuestStatut, data)
	
	end
	
	
end
	

	
	
function updateFactionScore(tag,score)
	
	
	local scores = getScoreKey("Affinity",tag)
	if(scores == nil) then scores = 0 end
	
	scores = score
	setScore("Affinity",tag,scores)

	
	
end	
	
function addFactionScoreByTagScore(tag,score)
	
	local scores = getScoreKey("Affinity",tag)
	if(scores == nil) then scores = 0 end
	
	scores = scores + score
	setScore("Affinity",tag,scores)

	
	
end	
	
	

function setFactionRelation(factiontag,otherfactiontag,score)
	
	
	local scores = getScoreKey(factiontag,otherfactiontag)
	if(scores == nil) then scores = 0 end
	
	scores = score
	
	setScore(factiontag,otherfactiontag,scores)

	
	
end	

function addFactionRelation(factiontag,otherfactiontag,score)
	
	
	local scores = getScoreKey(factiontag,otherfactiontag)
	if(scores == nil) then scores = 0 end
	
	scores = scores + score
	
	setScore(factiontag,otherfactiontag,scores)

	
	
end	

function getFactionRelation(factiontag,otherfactiontag)
	local score = currentSave.Variable[factiontag][otherfactiontag]
	
	if(score ~= nil) then
	
	return score
	else
	return 0
	end
	
	
end	


	

	
	
	
	
	
--obsolete	
function setScore(tag,key,score)
	
	
	 setVariable(tag,key,score)
end
--obsolete
function getScoreKey(tag,key)
	
	return getVariableKey(tag,key)
	
	
end
--obsolete
function getScoreKeyWithDefault(tag,key,default)
	
	return getVariableKeyWithDefault(tag,key,default)
	
end
--obsolete
function getScore(tag)
	
	return getVariable(tag)
		
	
end




function setVariable(tag,key,score)
	if(currentSave.Variable[tag] == nil) then
		
		currentSave.Variable[tag] = {}
		
	end
	currentSave.Variable[tag][key] = {}
	currentSave.Variable[tag][key] = score
	-- if(type(score) == "string") then
		
		
	-- 	currentSave.Variable[tag][key] = score
	-- end
	
	-- if(type(score) == "number") then
	
		
		
	-- 	currentSave.Variable[tag][key] = score

	-- end
	
	-- if(type(score) == "boolean") then
		
		
	-- 	currentSave.Variable[tag][key] = score
	-- end
	
	-- if(type(score) ~= "string" and type(score) ~= "number" and type(score) ~= "boolean" ) then
		
	-- 	currentSave.Variable[tag][key] = score
	-- end
end

function getVariableKey(tag,key)
	local score = currentSave.Variable[tag]
	
	if(score ~= nil) then
	
		return currentSave.Variable[tag][key]
	
	end
	
	
end

function getVariableKeyWithDefault(tag,key,default)
	local score = currentSave.Variable[tag]
	
	if(tag ~= nil and key ~= nil) then
	if(score ~= nil) then
		 score = currentSave.Variable[tag][key]
		 if(score ~= nil) then
			return currentSave.Variable[tag][key]
		else
			currentSave.Variable[tag][key] = default
			return currentSave.Variable[tag][key]
		 end
	else
		currentSave.Variable[tag] = {}
		currentSave.Variable[tag][key] = default
		return currentSave.Variable[tag][key]
	end
	
	else

		return 0
	
	end
	
	
end

function getVariable(tag)
	
	return currentSave.Variable[tag]
		
	
end