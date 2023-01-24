logme(1,"CyberScript: db module loaded")
cyberscript.module = cyberscript.module +1




function loadCharacters(arrayPnjDb)
	local stat = string.format("SELECT * FROM Characters")
	
	for row in db:nrows(stat) do
		local quest = {}
		quest.ID= row.ID
		quest.TweakIDs= row.TweakIDs
		quest.Names= row.Names
		table.insert(arrayPnjDb, quest)
		
		-- ----logme(2,arrayQuest[row.Id].Id) 
		
	end
	
end


function loadItems(arrayItems)
	local stat = string.format("SELECT * FROM Items")
	
	for row in db:nrows(stat) do
		local item = {}
		item.Id= row.Id
		item.TweakId= row.TweakId
		item.Name= row.Name
		table.insert(arrayItems, item)
		
		-- ----logme(2,arrayQuest[row.Id].Id) 
		
	end
	
end


function readDBOutput(res)
	
	if(res == 0) then
		
		logme(2,"DB saved")
		
		else
		logme(2,"Error in DB : "..res)
		error("db error code " .. res)
		error (db:errmsg())
		db:interrupt()
	end
	
	
end

function reloadDB()
	
	--arrayQuest = initQuest()
	
	

	loadCharacters(arrayPnjDb)
	loadItems(arrayItems)
	
	
	
end