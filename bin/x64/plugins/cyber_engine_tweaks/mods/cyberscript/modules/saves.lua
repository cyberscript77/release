debugPrint(3,"CyberScript: saves module loaded")
cyberscript.module = cyberscript.module +1



function migrateFromDB()
reloadDB()

currentSave.arrayPlayerData = arrayPlayerData
currentSave.arrayPlayerItems = arrayPlayerItems












for i=1,#arrayAffinity do
	local item = arrayAffinity[i]
	local pnj = getNPCById(item.NpcId)
	
	currentSave.Variable["Affinity"][pnj.Names] = item.Score
	
end

for i=1,#arrayFactionScore do
	local item = arrayFactionScore[i]
	
	
	currentSave.Variable["Affinity"][item.Tag] = item.Score
	
end



end

function migrateFromOldScore()

for i=1,#arrayPnjDb do
	local pnj = arrayPnjDb[i]
	if(currentSave.Score[pnj.Names]~= nil and currentSave.Score[pnj.Names]["Score"] ~= nil) then
		if(currentSave.Variable["Affinity"] == nil) then
		
		currentSave.Variable["Affinity"] = {}
		
		end
		
		debugPrint(2,"Old Score Migration NPC : migrate "..pnj.Names)
		currentSave.Variable["Affinity"][pnj.Names] = currentSave.Score[pnj.Names]["Score"]
		currentSave.Score[pnj.Names]["Score"] = nil
	end
end


for k,v in pairs(arrayFaction) do
	
	if(currentSave.Score[k]~= nil and currentSave.Score[k]["Score"] ~= nil) then
		debugPrint(2,"Old Score Migration Gang : migrate "..k)
		currentSave.Variable["Affinity"][k] = currentSave.Score[k]["Score"]
		currentSave.Score[k]["Score"] = nil
	end
	
	
	for j=1,#arrayDistricts do 
		
		if(currentSave.arrayFactionDistrict ~= nil and currentSave.arrayFactionDistrict[k]~= nil and currentSave.arrayFactionDistrict[k][arrayDistricts[j].Tag] ~= nil) then
			debugPrint(10,"Old Score Migration District : migrate "..k)
			currentSave.Variable[k][arrayDistricts[j].Tag] = currentSave.arrayFactionDistrict[k][arrayDistricts[j].Tag]
			currentSave.arrayFactionDistrict[k][arrayDistricts[j].Tag] = nil
		end
		
		
	end
	
	
	
end









	
end

function initGangDistrictScore()
	
	
for k,v in pairs(arrayFaction) do
	
	if(arrayFaction[k].faction.haveterritory == nil or arrayFaction[k].faction.haveterritory == true) then 
	
	if(currentSave.Variable[k] == nil) then
	
	currentSave.Variable[k] = {}
	
	
	end
	
	
	for j=1,#arrayDistricts do 
	
	
		local isOwner = false
		
		if(arrayFaction[k].faction.DistrictTag == arrayDistricts[j].Tag) then
		
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
	
	
	
for k,v in pairs(arrayFaction) do
	
	
	
	if(currentSave.Variable[k] == nil) then
	
		currentSave.Variable[k] = {}
	
	
	end
	
	
	for x,y in pairs(arrayFaction) do
	
		local isrival = false
		for i=1, #v.faction.Rivals do
		
			if(v.faction.Rivals[i] == x) then
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
	
	
	return currentSave.arrayUserSetting[tag]
	
	
end

function getUserSettingWithDefault(tag,default)
	
	
	if( currentSave.arrayUserSetting[tag] == nil) then
		
		currentSave.arrayUserSetting[tag] = default
	
	end
	
	return currentSave.arrayUserSetting[tag]
	
end


function updateUserSetting(tag,value)
	
	
	
	
	currentSave.arrayUserSetting[tag] = value
	
	
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
	
	debugPrint(4,item.Id)
	local res = false 
	for i=1,#currentSave.arrayHousing do
	
		if(currentSave.arrayHousing[i].Id == item.Id) then
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
		debugPrint(4,item.Tag)
		debugPrint(4,tag)
		
		debugPrint(4,item.X)
		debugPrint(4,x)
		
		debugPrint(4,item.Y)
		debugPrint(4,y)
		
		debugPrint(4,item.Z)
		debugPrint(4,z)
	if(tostring(item.X) == tostring(x) and tostring(item.Y) == tostring(y) and tostring(item.Z) == tostring(z) and tostring(item.Tag) == tostring(tag)) then
		debugPrint(4,item.Tag)
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


	
	for i=1,#arrayPnjDb do
	
			local score = getScoreKey("Affinity",arrayPnjDb[i].Names)
			
			if(score ~= nil) then
				local quest = {}
				quest.ID= arrayPnjDb[i].ID
				quest.TweakIDs= arrayPnjDb[i].TweakIDs
				quest.Names= arrayPnjDb[i].Names
				quest.Score = score
				table.insert(arrayPhoneNPC, quest)
				
				if(score >= 5)then
					local contactdata = {}
					contactdata.name =   getLang("save_phone_cmaffinity")..arrayPnjDb[i].Names
					contactdata.id =   "cm_"..arrayPnjDb[i].Names
					contactdata.avatarID = arrayPnjDb[i].TweakIDs
					contactdata.phonetype = "NPC"
					contactdata.truename =  arrayPnjDb[i].Names
					
					table.insert(contactList,contactdata)
				end
				
			end
			
	
		
	
	end
	
	
	for k,v in pairs(arrayInteract) do 
							
	
			if(v.interact.display == "phone_service")then
			
				local contactdata = {}
				contactdata.name =  getLang("save_phone_cmservice")..v.interact.name
				contactdata.id =  v.interact.tag
				contactdata.avatarID = "Character.Delamain"
				contactdata.phonetype = "Service"
				
				table.insert(contactList,contactdata)
				
			end
		
		
		

	end
	
	
	for k,v in pairs(arrayFixer) do
			
			local score = getScoreKey("Affinity",arrayFixer[k].fixer.Faction)
			if score ~= nil and score > 50 then 
				
				
			
				local contactdata = {}
				contactdata.name =  getLang("save_phone_cmfixer")..arrayFixer[k].fixer.Name
				contactdata.id =  k
				contactdata.avatarID = arrayFixer[k].fixer.NPCId
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
	if(type(score) == "string") then
		if(currentSave.Variable[tag] == nil) then
		
		currentSave.Variable[tag] = {}
		currentSave.Variable[tag][key] = ""
		
		end
		
		currentSave.Variable[tag][key] = score
	end
	
	if(type(score) == "number") then
	
		if(currentSave.Variable[tag] == nil) then
		
		
		currentSave.Variable[tag] = {}
		currentSave.Variable[tag][key] = 0
		
		end 
		
		currentSave.Variable[tag][key] = score

	end
	
	if(type(score) == "boolean") then
		if(currentSave.Variable[tag] == nil) then
		
		currentSave.Variable[tag] = {}
		currentSave.Variable[tag][key] = ""
		end
		
		currentSave.Variable[tag][key] = score
	end
end

function getVariableKey(tag,key)
	local score = currentSave.Variable[tag]
	
	if(score ~= nil) then
	
		return currentSave.Variable[tag][key]
	
	end
	
	
end

function getVariableKeyWithDefault(tag,key,default)
	local score = currentSave.Variable[tag]
	
	if(score ~= nil) then
	
		return currentSave.Variable[tag][key]
	else
		currentSave.Variable[tag] = {}
		currentSave.Variable[tag][key] = default
		return currentSave.Variable[tag][key]
	end
	
	
end

function getVariable(tag)
	
	return currentSave.Variable[tag]
		
	
end