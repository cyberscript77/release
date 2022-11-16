debugPrint(3,"CyberScript: modpack module loaded")
cyberscript.module = cyberscript.module +1


local function exportDatapackArray(t, max, depth, result)
	if type(t) ~= 'table' then
		return '{}'
	end
	max = max or 63
	depth = depth or 0
	local indent = string.rep('\t', depth)
	local output = result or {}
	table.insert(output, '{\n')
	for k, v in pairs(t) do
		local ktype = type(k)
		local vtype = type(v)
		local kstr = ''
		if ktype == 'string' then
			kstr = string.format('[%q] = ', k)
		end
		local vstr = ''
		if vtype == 'string' then
			vstr = string.format('%q', v)
			elseif vtype == 'table' then
			if depth < max then
				table.insert(output, string.format('\t%s%s', indent, kstr))
				exportDatapackArray(v, max, depth + 1, output)
				table.insert(output, ',\n')
			end
			elseif vtype == 'userdata' then
			vstr = tostring(v)
			if vstr:find('^userdata:') or vstr:find('^sol%.') then
				if not sessionDataRelaxed then
					--vtype = vstr:match('^sol%.(.+):')
					if ktype == 'string' then
						debugPrint(10,('Cannot store userdata in the %q field.'):format(k))
						--raiseError(('Cannot store userdata of type %q in the %q field.'):format(vtype, k))
						else
						debugPrint(10,('Cannot store userdata in the list.'))
						--raiseError(('Cannot store userdata of type %q.'):format(vtype))
					end
					else
					vstr = ''
				end
			end
			elseif vtype == 'function' or vtype == 'thread' then
			if not sessionDataRelaxed then
				if ktype == 'string' then
					debugPrint(10,('Cannot store %s in the %q field.'):format(vtype, k))
					else
					debugPrint(10,('Cannot store %s.'):format(vtype))
				end
				end
			else
			vstr = tostring(v)
		end
		if vstr ~= '' then
			table.insert(output, string.format('\t%s%s%s,\n', indent, kstr, vstr))
		end
	end
	if not result and #output == 1 then
		return '{}'
	end
	table.insert(output, indent .. '}')
	if not result then
		return table.concat(output)
	end
end

function exportCompiledDatapack(msg)
	
	local directories = {}
	local reader = dir("datapack")
	for i=1, #reader do 
		if(tostring(reader[i].type) == "directory") then
			
			table.insert(directories,reader[i].name)
		end
	end
	
	
	for i=1, #directories do
		exportCompiledDatapackFolder(k,msg)
	end
end


function exportCompiledDatapackFolder(directories,msg)
	
		local k = directories
		local file = io.open("cache/"..k..".lua", "w")	
		--file:write('debugPrint(10,'..k..' Cache Loaded) return ')
		if(file ~= nil) then
		file:write('return ')
		file:write(exportDatapackArray(arrayDatapack[k]))
		file:close()
		
		logme(1,k)
		logme(1,getLang("datapack_datapack_created")..msg)
		end
	
end

function ImportDataPackFolder(directories)

		local path = "datapack/"..directories.."/desc.json"
		local flo = io.open(path)
		local lines = flo:read("*a")
		local jsonf = trydecodeJSOn(lines,flo,path)
		flo:close()
		arrayDatapack[directories] = {}
		arrayDatapack[directories].metadata=jsonf
		
		arrayDatapack[directories].cachedata={}
		arrayDatapack[directories].cachedata.CacheVersion=cacheVersion
		arrayDatapack[directories].cachedata.modVersion=cyberscript.version
		
		if(DatapackChecker(jsonf) == true) then
			try {
				function()
					loadDatapackObject(directories)
					debugPrint(2,"Creating cache for "..directories)
					
					
					
				end,
				catch {
					function(error)
						debugPrint(1,getLang("datapack_error_import")..directories..') '..error)
						
						arrayDatapack[directories] = nil
					end
				}
			}
		end

end



function ImportDataPack()
	--debugPrint(1,"Registering MissionPack...")
	local count = 0
	res = false
	
	local directories = {}
	
	
	
	local reader = dir("datapack")
	if(reader ~= nil) then
	for i=1, #reader do 
		if(tostring(reader[i].type) == "directory") then
			
			table.insert(directories,reader[i].name)
		end
	end
	
	arrayDatapack = {}
	
	
	
	
	for i = 1, #directories do
		
		ImportDataPackFolder(directories[i])
		exportCompiledDatapackFolder(directories[i],"From Create")
		
	end
	
	
	end


end

function RecoverDatapack()
	
	arrayDatapack = {}
	
	arrayDatapack.CacheVersion = cacheVersion
	arrayDatapack.modVersion = cyberscript.version
	
	local path = "datapack/default/desc.json"
	local flo = io.open(path)
	local lines = flo:read("*a")
	local jsonf = trydecodeJSOn(lines,flo,path)
	flo:close()
	
	
	if(DatapackChecker(jsonf) == true) then
	try {
		function()
			loadDatapackObject("default")
			
			arrayDatapack["default"].enabled = true
			
			
			exportCompiledDatapack("From Recover")
			
			
			
			LoadDataPackCache()
			
			
			debugPrint(1,getLang("datapack_recover"))
			
			
		end,
		catch {
			function(error)
				debugPrint(1,getLang("datapack_recover_fail")..error)
				
			end
		}
	}
	else
	debugPrint(1,getLang("datapack_wrong_default")..tostring(lines))
	error(getLang("datapack_wrong_default")..tostring(lines))
	
	end
	
	
	
	
	
end

function CheckandUpdateDatapack()
	
	if(arrayDatapack ~= nil) then 
	local directories = {}
	
	if(arrayDatapack["default"] ~= nil) then 
	
	end
	
	if(nativeSettings ~= nil and nativeSettings.data["CMDT"] ~= nil  ) then
		nativeSettings.data["CMDT"].options = {}
		else
		nativeSettings.addTab("/CMDT", "CyberScript Datapack Manager") -- Add our mods tab (path, label)
		nativeSettings.data["CMDT"].options = {}
	end
	
	local reader = dir("datapack")
	if(reader ~= nil) then
	for i=1, #reader do 
		if(tostring(reader[i].type) == "directory") then
			
			table.insert(directories,reader[i].name)
		
		end
	end
	
	local haveupdate = false 
	
	for i=1, #directories do
		local k = directories[i]
		
		
		
	
		
		local jsondesc = nil
		
		
		if(arrayDatapack[k] == nil)then
			arrayDatapack[k] = {}
			arrayDatapack[k].state = "new"
		end
		
		
		
		if( file_exists("datapack/"..k.."/desc.json") ) then
			local path = "datapack/"..k.."/desc.json"
			local desc = io.open(path)
			lines = desc:read("*a")
			jsondesc = trydecodeJSOn(lines,desc,path)
			
			desc:close()
			arrayDatapack[k].metadata=jsondesc
			
			
			else
			
			logme(1,"No DESC FOR "..k)
			spdlog.error("No DESC FOR "..k)
			arrayDatapack[k] = nil
		end
		
		
		
		
		if(
			jsondesc ~= nil 
			
			and 
			
			(
					
					(
						(arrayDatapack[k] ~= nil and ((table_contains(arrayDatapack[k].metadata.flags,"compile",false) == true and DatapackChecker(arrayDatapack[k].metadata) == true ) or arrayDatapack[k].state == "new"))
					
					or
						arrayDatapack[k] == nil 
						
					
					)
			)
		) 
		then
			
			local isenabled = false
			haveupdate = true
			
			if((arrayDatapack[k] ~= nil and arrayDatapack[k].enabled == true)) then
				
				isenabled = true
				
			end
			
			
			
			
			
		
				try {
					function()
						loadDatapackObject(k)
						arrayDatapack[k].enabled = isenabled
						arrayDatapack[k].state = nil
						logme(1,getLang("datapack_updated_01")..k..getLang("datapack_updated_02"))
						arrayDatapack[k].cachedata={}
						arrayDatapack[k].cachedata.CacheVersion=cacheVersion
						arrayDatapack[k].cachedata.modVersion=cyberscript.version
						exportCompiledDatapackFolder(k,"Updated cache")
							
						
					end,
					catch {
						function(error)
							logme(1,getLang("datapack_error_import")..k..') '..error)
							spdlog.error(getLang("datapack_error_import")..k..') '..error)
							arrayDatapack[k] = nil
							
						end
					}
				}
			
			else
			
		
			
			
				local test1 = jsondesc ~= nil 
				local test2 = (arrayDatapack[k] ~= nil and ((table_contains(arrayDatapack[k].metadata.flags,"compile",false) == true and DatapackChecker(arrayDatapack[k].metadata) == true ) ))
				local test3 = arrayDatapack[k] == nil 
				
				logme(1,"Can't load "..k.." from the cache : \n | jsondesc is not null : "..tostring(test1).." \n | datapack have required flag: "..tostring(test2).." \n | datapack is null : "..tostring(test3))
				
			 
		end
		
		
	
	end
	
	local i = 1
	for k,v in pairs(arrayDatapack) do
		
		local status, retval = pcall(function()
		if('table' == type(v)) then
			if(nativeSettings ~= nil and nativeSettings.data["CMDT"] ~= nil and (table_contains(arrayDatapack[k].metadata.flags,"essential",false) == false)) then
			
				nativeSettings.addSwitch("/CMDT", k, "index :"..i, arrayDatapack[k].enabled, arrayDatapack[k].enabled, function(state)
					if (state == false) then
						
						DisableDatapack(k)
						else
						EnableDatapack(k)
					end
				end)
			end
			
			if((table_contains(arrayDatapack[k].metadata.flags,"essential",false) == true)) then
				EnableDatapack(k)
			end
			
			i = i +1
		end
			
		end)
		
		if status == false then
											
											
								
											--spdlog.error(getLang("Modpack Setting Error") .. retval.." Modpack : "..k.."value : "..tostring(arrayDatapack[k].enabled))
											--Game.GetPlayer():SetWarningMessage("CyberScript Scripting error, check the log for more detail")
											
										end
										
		
		end
	end
	
	buildnativesetting()
	
	
	end
end
function loadDatapackObject(namespace)
	
	arrayDatapack[namespace].enabled = false
	
	if(namespace == "default") then
		
		arrayDatapack[namespace].enabled = true
	end
	
	
	
	
	
	for i=1,#datapackObjectType do
		local objtype = datapackObjectType[i]
		
		local reader = dir("datapack/"..namespace.."/"..objtype)
		if(reader ~= nil) then
			arrayDatapack[namespace][objtype] = {}
			for i=1, #reader do 
				if(objtype == "sound") then
					
					if(tostring(reader[i].type) == "file" and (string.match(tostring(reader[i].name), ".mp3") or string.match(tostring(reader[i].name), ".wav"))) then
						
						local soundobj = {}
						soundobj.name = reader[i].name
						soundobj.path=namespace.."\\sound\\"
						soundobj.namespace = namespace
						
						arrayDatapack[namespace][objtype][tostring(reader[i].name)] = {}
						arrayDatapack[namespace][objtype][tostring(reader[i].name)] = soundobj
						
						
					end
					
					
					
					
					
					elseif(objtype == "texture") then
					
					if(tostring(reader[i].type) == "file" and 
						(
							string.match(tostring(reader[i].name), ".jpg") or 
							string.match(tostring(reader[i].name), ".jpeg") or 
							string.match(tostring(reader[i].name), ".png")or 
							string.match(tostring(reader[i].name), ".bmp")
						)
					) then
					
					local imageobj = {}
					
					
					imageobj.name = reader[i].name
					imageobj.path="datapack/"..namespace.."/"..objtype.."/"..reader[i].name
					imageobj.namespace = namespace
					
					
					
					arrayDatapack[namespace][objtype][tostring(reader[i].name)] = {}
					arrayDatapack[namespace][objtype][tostring(reader[i].name)] = imageobj
					
					end
					
					elseif(objtype == "path") then
					
					
					
					else
					
					if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
						
						local foo = io.open("datapack/"..namespace.."/"..objtype.."/"..reader[i].name)
						local lines = foo:read("*a")
						if(lines ~= "") then
							local jsonf = trydecodeJSOn(lines,foo,"datapack/"..namespace.."/"..objtype.."/"..reader[i].name)
							arrayDatapack[namespace][objtype][tostring(reader[i].name)] = {}
							arrayDatapack[namespace][objtype][tostring(reader[i].name)] = jsonf
							
							else
							res = false
							
						end
								foo:close()
					end
					
					
					
				end
			end
		end
	end
end
function DeleteDatapackFromCache(tag)
	
	if(arrayDatapack[tag]~= nil) then
		arrayDatapack[tag] = nil
		if(name ~= "default") then
			arrayDatapack[tag] = nil
		end
	end
	
	
	if(file_exists('cache/'..tag..'.lua') == true) then
						
			os.remove('cache/'..tag..'.lua')
			print(tag.." datapack no longer exist, deleting cache...")
		
	end
end

function DatapackChecker(desc)
	local result = true
	
	if(desc ~= nil) then
	if(desc.flags ~= nil and #desc.flags > 0) then
		
		for i=1,#desc.flags do
			
			result = flagChecker(desc.flags[i])
			local myflag = string.lower(desc.flags[i])
			
			
			
			if((string.match(tostring(flag), "cm_version:") or string.match(tostring(flag), "cm_version_strict:")) and table_contains(desc.flags,"beta",false) == true and string.match(tostring(cyberscript.version), "9999."))then
				
				result = true
				
			end
				
		end
		
	
	
		
	else
		
		
		
		if(
			
			(
				(desc.explicits == nil or (desc.explicits ~= nil and((GameSettings.Get("/gameplay/misc/CensorNudity") == true and desc.explicits == false) or GameSettings.Get("/gameplay/misc/CensorNudity") == false))))
			and
			
			(
				desc.requirement == nil 
				or 
				(
					desc.requirement ~= nil 
					
					and 
					(
						checkVersionNumber(cyberscript.version,desc.requirement) == false 
						
						or
						
						(string.match(tostring(cyberscript.version), "9999.")) 
					)
				)
			) 
				
			
		)
		
		
		then
		
		result = true
		else
		result = false
		end
		
	end
	
	else
	
	result = false
	end
	
	
	return result
end


function flagChecker(myflag)
	
	local result = true
	
	local flag = string.lower(myflag)
	
	if(flag == "amm") then
		
		if(AMM ~= nil) then
			
			result = true
			
			else
			
			result = false
			
		end
		
	end
	
	if(string.match(tostring(flag), "amm_version:")) then
		
		if(AMM ~= nil and AMMversion ~= nil) then
			local splitted = split(flag, ":")
			
			if #splitted > 1 then
				
				if (checkVersionNumber(tostring(AMMversion),tostring(splitted[2])) == false) then
					result = true
					else 
					
					result = false
				end
				else 
				
				result = false
			end
			
			else 
			
			result = false
		end
		
	end
	
	if(string.match(tostring(flag), "amm_version_strict:")) then
		
		if(AMM ~= nil and AMMversion ~= nil) then
			local splitted = split(flag, ":")
			
			if #splitted > 1 then
				
				if (AMMversion == tostring(splitted[2])) then
					result = true
					else 
					
					result = false
				end
				else 
				
				result = false
			end
			
			else 
			
			result = false
		end
		
	end
	
	if(string.match(tostring(flag), "cm_version:")) then
		
		
		local splitted = split(flag, ":")
		
		if #splitted > 1 then
			
			result = (checkVersionNumber(tostring(cyberscript.version),tostring(splitted[2])) == false)
			
			else 
			
			result = false
		end
		
		
		
		
	end
	
	if(string.match(tostring(flag), "cm_version_strict:")) then
		
		
		local splitted = split(flag, ":")
		
		if #splitted > 1 then
			
			result = cyberscript.version == tostring(splitted[2])
			
			else 
			
			result = false
		end
		
		
		
		
	end
	
	if(string.match(tostring(flag), "mod:")) then
		
		
		local splitted = split(flag, ":")
		
		if #splitted > 1 then
			
			result = (GetMod(splitted[2]) ~= nil)
			
			else 
			
			result = false
		end
		
		
		
		
	end
	
	if(flag == "nsfw") then
		
		result = (GameSettings.Get("/gameplay/misc/CensorNudity") == false)
		
	end
	
	if(string.match(tostring(flag), "datapack:")) then
		local splitted = split(flag, ":")
		result = (arrayDatapack[splitted[2]] ~= nil)
		
	end
	
	if(string.match(tostring(flag), "datapack_version:")) then
		local splitted = split(flag, ":")
	result = (arrayDatapack[splitted[2]] ~= nil and (checkVersionNumber(tostringarrayDatapack[splitted[2]].metadata.version,tostring(splitted[3]))) == false)
		
	end
	
	if(string.match(tostring(flag), "datapack_version_strict:")) then
		local splitted = split(flag, ":")
		result = (arrayDatapack[splitted[2]] ~= nil and arrayDatapack[splitted[2]].metadata.version == splitted[3])
		
	end
	
	if(flag == "compile") then
		
		result = true
		
	end
	
	
	
	return result
end





	
	function LoadDataPackCache()
	
	arrayQuest2 = {}
	arrayInteract = {}
	arrayDialog = {}
	arrayHouse = {}
	arrayFixer = {}
	arrayScene = {}
	arrayHUD = {}
	arrayFaction = {}
	arrayPOI = {}
	arrayEvent = {}
	arrayCodex = {}
	arrayWebpage = {}
	arrayEmail = {}
	
	arrayFunction = {}
	arrayHousing = {}
	arrayHelp = {}
	arrayInterfaces = {}
	arrayCustomNPC = {}
	arrayPhoneConversation = {}
	arrayShard = {}
	arrayNode = {}
	arrayPath = {}
	arrayCircuit = {}
	arrayRadio = {}
	arraySound = {}
	arrayTexture = {}
	arrayCorpo = {}
	arraySetting = {}
	arrayHousingTemplate = {}
	arrayCharacterArchive = {}
	arrayquickhack = {}
	
	if(arrayDatapack ~= nil) then
	
	try {
		function()
			for k,v in pairs(arrayDatapack) do
				if('table' == type(v) and v.enabled ~= nil and v.enabled == true) then
					
					if(DatapackChecker(v.metadata)) then
					
						for y=1,#datapackObjectType do
							local objtype = datapackObjectType[y]
							if(arrayDatapack[k][objtype] ~= nil) then
								
								FillList(objtype,arrayDatapack[k][objtype],k)
								
								else
							--	debugPrint(10,"can't find "..objtype.." for "..k)
								
							end
							
						end
					else
					debugPrint(1,"Output : "..tostring(DatapackChecker(v.metadata)))
					debugPrint(1,"can't load : "..k.." data :"..tostring(dump(v.metadata)))
					
					end
				end
			end
		end,
		catch {
			function(error)
				debugPrint(1,'Error during loading cache for datatpack: '..error)
				RecoverDatapack()
			end
		}
	}
	

	
	
	initPath()
	
	addNewCustomNPC()
	loadQuestsToUI()
	getInteractGroup()
	FillCharacterArchive()
	
	
	end
	end
	
	function FillList(objtype,tabl, datapackname)
		local rootpath = ""
		try {
			function()
				if(tabl ~= nil ) then
					if(objtype == "circuit") then
						for key, value in pairs(tabl) do 
							
							if(#value > 0) then
								for i=1,#value do
									local path = "datapack/"..datapackname.."/"..objtype.."/"..key
									rootpath = path
									arrayCircuit[value[i].tag] = {}
									arrayCircuit[value[i].tag].circuit = value[i]
									arrayCircuit[value[i].tag].file = path
									arrayCircuit[value[i].tag].datapack = datapackname
								end
							end
						end
						elseif(objtype == "dialog") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							if(#value > 0) then
								for i=1,#value do
									arrayDialog[tostring(value[i].Tag)] = {}
									arrayDialog[tostring(value[i].Tag)].dialog = value[i]
									arrayDialog[tostring(value[i].Tag)].path = path
									arrayDialog[tostring(value[i].Tag)].datapack = datapackname
									if(arrayDialog[tostring(value[i].Tag)]["dialog"] == nil) then
										arrayDialog[tostring(value[i].Tag)]["dialog"]["havequitoption"] = true
									end
								end
							end
						end
						elseif(objtype == "event") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayEvent[value.tag] = {}
							arrayEvent[value.tag].event = value
							arrayEvent[value.tag].file = path
							arrayEvent[value.tag].datapack = datapackname
						end
						elseif(objtype == "faction") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayFaction[value.Tag] = {}
							arrayFaction[value.Tag].faction = value
							arrayFaction[value.Tag].file = path
							arrayFaction[value.Tag].datapack = datapackname
						end
						elseif(objtype == "fixer") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayFixer[value.Tag] = {}
							arrayFixer[value.Tag].fixer = value
							arrayFixer[value.Tag].file = path
							arrayFixer[value.Tag].datapack = datapackname
						end
						elseif(objtype == "function") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayFunction[value.tag] = {}
							arrayFunction[value.tag].func = value
							arrayFunction[value.tag].file = path
							arrayFunction[value.tag].datapack = datapackname
						end
						elseif(objtype == "help") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayHelp[value.tag] = {}
							arrayHelp[value.tag].help = value
							arrayHelp[value.tag].file = path
							arrayHelp[value.tag].datapack = datapackname
						end
						elseif(objtype == "housing") then
						for key, value in pairs(tabl) do 
						
							
							
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							
							
							if(value.customIncluded ~= nil) then --amm template
								print("Cyberscript : AMM housing founded : "..path..". Converting to CS Housing..")
								local statutfile = true
								
								local newobj = {}
								newobj.target = value.props[1].tag
								newobj.trigger = {}
								newobj.tag = value.props[1].tag
								newobj.trigger.auto = {}
								newobj.trigger.auto.name = "auto"
								newobj.requirement = {}
								local requirement = { "auto" }
								
								table.insert(newobj.requirement,requirement)
								
								newobj.items = {}
								newobj.gameid = "fb721b23723385bfd5cb959ad14961d6"
								
								
								for i,prop in ipairs(value.props) do
									
									
									
									local csprop = {}
									csprop.HouseTag = prop.tag
									
									
									local testtt = amm_entities[prop.entity_id]
									if(testttt ~= nil) then
									
										csprop.Tag = amm_entities[prop.entity_id].entity_path
										csprop.Id = prop.tag.."_"..amm_entities[prop.entity_id].entity_path.."_"..prop.uid
									
									else
									
										csprop.Tag = prop.tag
										csprop.Id = prop.tag.."_".."unknown".."_"..prop.uid
									
									end
									csprop.Title = prop.name
									csprop.ItemPath = prop.template_path
									csprop.appearance = prop.app
									
									local pos = loadstring("return "..prop.pos, '')()
								
									csprop.X = pos.x
									csprop.Y = pos.y
									csprop.Z = pos.z
									
									csprop.Yaw = pos.yaw
									csprop.Pitch = pos.pitch
									csprop.Roll = pos.roll
									csprop.gameid = "fb721b23723385bfd5cb959ad14961d6"
									csprop.scale =loadstring("return "..prop.scale, '')()
								
									
									for y,light in ipairs(value.lights) do
										
										if(light.uid == prop.uid) then
											
											csprop.color = loadstring("return "..light.color, '')() 
											csprop.angles = loadstring("return "..light.angles, '')() 
											
											
											
											csprop.radius = light.radius
											csprop.intensity = light.intensity
											
										
										end
								
									end
									
									
									
									table.insert(newobj.items,csprop)
									
								end
								
								
								
								arrayHousing[newobj.tag] = {}
								arrayHousing[newobj.tag].housing = newobj
								arrayHousing[newobj.tag].file = path
								arrayHousing[newobj.tag].datapack = datapackname
								
								if(statutfile == true) then print("Cyberscript : AMM housing : "..path..". Convertion successfull !") else print("Cyberscript : AMM housing : "..path..". Convertion failed !") end
								
								else
								
								if(value.tag ~= nil) then
							--	print(value.tag)
								arrayHousing[value.tag] = {}
								arrayHousing[value.tag].housing = value
								arrayHousing[value.tag].file = path
								arrayHousing[value.tag].datapack = datapackname
								
								else
								
								print("Cyberscript : old housing format founded : "..path..". Not Loaded, apply modification to allow the loading.")
								
								end
							
								
							
							end
							
							
							
							
							
						end
						elseif(objtype == "interact") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arrayInteract[value.tag] = {}
							arrayInteract[value.tag].interact = value
							arrayInteract[value.tag].interact.group = datapackname
							arrayInteract[value.tag].file = path
							arrayInteract[value.tag].datapack = datapackname
						end
						elseif(objtype == "interfaces") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayInterfaces[value.tag] = {}
							arrayInterfaces[value.tag].ui = value
							arrayInterfaces[value.tag].file = path
							arrayInterfaces[value.tag].datapack = datapackname
						end
						elseif(objtype == "lang") then
						local path = "datapack/"..datapackname.."/"..objtype.."/"
						rootpath = path
						for key, value in pairs(tabl) do 
							for k, v in pairs(value) do 
								
								lang[k] = v
							end
						end
						elseif(objtype == "mission") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayQuest2[value.tag] = {}
							arrayQuest2[value.tag].quest = value
							arrayQuest2[value.tag].file = path
							arrayQuest2[value.tag].datapack = datapackname
							
						end
						elseif(objtype == "node") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							if(#value > 0) then
								for i=1,#value do
									arrayNode[tostring(value[i].tag)] = {}
									arrayNode[tostring(value[i].tag)].node = value[i]
									arrayNode[tostring(value[i].tag)].file = path
									arrayNode[tostring(value[i].tag)].datapack = datapackname
								end
							end
						end
						elseif(objtype == "npc") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayCustomNPC[value.tag] = {}
							arrayCustomNPC[value.tag].npc = value
							arrayCustomNPC[value.tag].npc.isspawn=false
							arrayCustomNPC[value.tag].npc.init=false
							arrayCustomNPC[value.tag].npc.spawnforced=false
							arrayCustomNPC[value.tag].npc.dospawnaction=true
							arrayCustomNPC[value.tag].npc.doroutineaction=true
							arrayCustomNPC[value.tag].npc.dodeathaction=true
							arrayCustomNPC[value.tag].npc.dodespawnaction=true
							arrayCustomNPC[value.tag].npc.workinglocation=value.location
							arrayCustomNPC[value.tag].datapack = datapackname
							arrayCustomNPC[value.tag].file = path
						end
						elseif(objtype == "path") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayPath[value.tag] = {}
							arrayPath[value.tag].gamepath = value
							arrayPath[value.tag].file = path
							arrayPath[value.tag].datapack = datapackname
						end
						elseif(objtype == "phone_dialog") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayPhoneConversation[value.tag] = {}
							arrayPhoneConversation[value.tag].conv = value
							arrayPhoneConversation[value.tag].file = path
							arrayPhoneConversation[value.tag].datapack = datapackname
							if(arrayPhoneConversation[tostring(value.tag)].conv.unlock == false ) then
								if(getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.tag,"unlocked") == 0 or getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.tag,"unlocked") == nil ) then
									setScore(arrayPhoneConversation[tostring(value.tag)].conv.tag,"unlocked",0)
								end
								else
								if(getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.tag,"unlocked") == 0 or getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.tag,"unlocked") == nil ) then
									setScore(arrayPhoneConversation[tostring(value.tag)].conv.tag,"unlocked",1)
								end
							end
							for z =1, #arrayPhoneConversation[tostring(value.tag)].conv.conversation do
								if(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].unlock == false ) then
									if(getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].tag,"unlocked") == 0 or getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].tag,"unlocked") == nil ) then
										setScore(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].tag,"unlocked",0)
									end
									else
									if(getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].tag,"unlocked") == 0 or getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].tag,"unlocked") == nil) then
										setScore(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].tag,"unlocked",1)
									end
								end
								for y=1, #arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].message do
									if(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].message[y].unlock == false ) then
										if(getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].message[y].tag,"unlocked") == 0 or getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].message[y].tag,"unlocked") == nil ) then
											setScore(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].message[y].tag,"unlocked",0)
										end
										else
										if(getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].message[y].tag,"unlocked") == 0 or getScoreKey(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].message[y].tag,"unlocked") == nil) then
											setScore(arrayPhoneConversation[tostring(value.tag)].conv.conversation[z].message[y].tag,"unlocked",1)
										end
									end
								end
							end
						end
						elseif(objtype == "place") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayHouse[value.tag] = {}
							arrayHouse[value.tag].house = value
							arrayHouse[value.tag].file = path
							arrayHouse[value.tag].datapack = datapackname
						end
						elseif(objtype == "poi") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							if(value.tag == nil) then
								value.tag = key..tostring(math.random(1,99999))
							end
							arrayPOI[value.tag] = {}
							arrayPOI[value.tag].poi = value
							arrayPOI[value.tag].file = path
							arrayPOI[value.tag].datapack = datapackname
						end
						elseif(objtype == "radio") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayRadio[value.tag] = {}
							arrayRadio[value.tag].radio = value
							arrayRadio[value.tag].file = path
							arrayRadio[value.tag].datapack = datapackname
							arrayRadio[value.tag].namespace = datapackname
							arrayRadio[value.tag].enabled = false
						end
						elseif(objtype == "shard") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayShard[value.tag] = {}
							arrayShard[value.tag].shard = value
							arrayShard[value.tag].file = path
							arrayShard[value.tag].datapack = datapackname
						end
						elseif(objtype == "sound") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arraySound[key] = {}
							arraySound[key].sound = value
							arraySound[key].file = path
						end
						elseif(objtype == "texture") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arrayTexture[key] = {}
							arrayTexture[key].texture = path
							arrayTexture[key].file = path
						end
						elseif(objtype == "scene") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arrayScene[value.tag] = {}
							arrayScene[value.tag].scene = value
							arrayScene[value.tag].file = path
							arrayScene[value.tag].datapack = datapackname
						end
						elseif(objtype == "housing_template") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arrayHousingTemplate[value.tag] = {}
							arrayHousingTemplate[value.tag].template = value
							arrayHousingTemplate[value.tag].file = path
							arrayHousingTemplate[value.tag].datapack = datapackname
						end
						elseif(objtype == "hud") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arrayHUD[value.tag] = {}
							arrayHUD[value.tag].hud = value
							arrayHUD[value.tag].file = path
							arrayHUD[value.tag].datapack = datapackname
						end
						elseif(objtype == "setting") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arraySetting[value.tag] = {}
							arraySetting[value.tag].setting = value
							arraySetting[value.tag].file = path
							arraySetting[value.tag].datapack = datapackname
						end
						elseif(objtype == "codex") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arrayCodex[value.tag] = {}
							arrayCodex[value.tag].entry = value
							arrayCodex[value.tag].file = path
							arrayCodex[value.tag].datapack = datapackname
						end
						
						elseif(objtype == "webpage") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arrayWebpage[value.tag] = {}
							arrayWebpage[value.tag].entry = value
							arrayWebpage[value.tag].file = path
							arrayWebpage[value.tag].datapack = datapackname
						end
						elseif(objtype == "email") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arrayEmail[value.tag] = {}
							arrayEmail[value.tag].entry = value
							arrayEmail[value.tag].file = path
							arrayEmail[value.tag].datapack = datapackname
						end
						elseif(objtype == "character") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							arrayCharacterArchive[value.name] = {}
							arrayCharacterArchive[value.name].obj = value
							arrayCharacterArchive[value.name].file = path
							arrayCharacterArchive[value.name].datapack = datapackname
						end
						elseif(objtype == "quickhack") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							arrayquickhack[value.tag] = {}
							arrayquickhack[value.tag].entry = value
							arrayquickhack[value.tag].file = path
							arrayquickhack[value.tag].datapack = datapackname
						end
					end
				end
			
			
			end,
			catch {
				function(error)
					logme(1,'Error during creating cache for datatpack: '..error.." "..objtype.." "..datapackname.." path : "..rootpath)
					RecoverDatapack()
				end
			}
			
		}
		
	end
	function DisableDatapack(name)
		
		if(name ~= "default") then
			arrayDatapack[name].enabled = false
			
			
			
			exportCompiledDatapackFolder(name,name.." datapack : Update Disable state to cache")
		end
		
	end
	function EnableDatapack(name)
		
		arrayDatapack[name].enabled = true
		
		
		
		exportCompiledDatapackFolder(name,name.." datapack : Update Enable state to cache")
	end
	
	
	
	function FillCharacterArchive()
	
	for k, ent in pairs(arrayCharacterArchive) do
		
		TweakDB:CloneRecord(ent.obj.name, ent.obj.source)
		TweakDB:SetFlat(ent.obj.name..".entityTemplatePath", ent.obj.path)
	end
	
	end
	
	function loadQuestsToUI()
		for k,v in pairs(arrayQuest2) do
			local questos = arrayQuest2[k].quest
			local data = {}
			checkContext(questos)
			
			
			
			data.id = questos.tag
			data.title = getLang(questos.title)
			data.description = getLang(questos.content)
			data.metadata = {}
			data.metadata.level = questos.recommandedlevel
			data.metadata.questType = questos.questtype
			data.metadata.district =  questos.district
			data.objectives = {}
			for i=1,#questos.objectives do 
				local irpobj = questos.objectives[i]
				checkContext(irpobj)
			
				
				local obj = irpobj
				obj.id = irpobj.tag
				obj.title = getLang(irpobj.title)
				obj.isOptional = irpobj.isoptionnal
				obj.state = irpobj.state
				table.insert(data.objectives,obj)
			end
			QuestManager.AddQuest(data)
			QuestManager.MarkQuestAsInactive(questos.tag)
			for i=1,#questos.objectives do 
				local irpobj = questos.objectives[i]
				QuestManager.MarkObjectiveAs(irpobj.tag, irpobj.state)
			end
		end
	end
	function loadQuestToUI(quest)
		local questos = quest
		local data = {}
		checkContext(questos)
		data.id = questos.tag
		data.title = getLang(questos.title)
		data.description = getLang(questos.content)
		data.metadata = {}
		data.metadata.level = questos.recommandedlevel
		data.metadata.questType = questos.questtype
		data.metadata.district =  questos.district
		data.objectives = {}
		for i=1,#questos.objectives do 
			local irpobj = questos.objectives[i]
			checkContext(irpobj)
			local obj = {}
			obj.id = irpobj.tag
			obj.title = getLang(irpobj.title)
			obj.isOptional = irpobj.isoptionnal
			obj.state = irpobj.state
			table.insert(data.objectives,obj)
		end
		QuestManager.AddQuest(data)
		QuestManager.MarkQuestAsInactive(questos.tag)
		for i=1,#questos.objectives do 
			local irpobj = questos.objectives[i]
			QuestManager.MarkObjectiveAs(irpobj.tag, irpobj.state)
		end
	end
	
	
	function readInstalledDatapack()
		readRegisteredMissionPackFolder()
	end
	
	
	function initDistrict()
		--debugPrint(1,"Importing District...")
		local f = assert(io.open("data/districts.json"))
		lines = f:read("*a")
		encdo = lines
		tableDis = {}
		tableDis = trydecodeJSOn(lines,f,"data/districts.json")
		--debugPrint(1,"District Imported")
		f:close()
		return tableDis
	end
	function initVehicles()
		--debugPrint(1,"Importing District...")
		local f = assert(io.open("data/vehicles.json"))
		local lines = f:read("*a")
		local encdo = lines
		local tableDis = {}
		tableDis = trydecodeJSOn(lines,f,"data/vehicles.json")
		--debugPrint(1,"District Imported")
		f:close()
		return tableDis
	end
	function initGameSounds()
		--debugPrint(1,"Importing District...")
		local f = assert(io.open("data/gamesounds.json"))
		local lines = f:read("*a")
		local encdo = lines
		local tableDis = {}
		tableDis = trydecodeJSOn(lines,f,"data/gamesounds.json")
		--debugPrint(1,"District Imported")
		f:close()
		return tableDis
	end
	function initAttitudeGroup()
		local tableDis = {}
		local reader = dir("data/attitudegroup/")
		if(reader ~= nil) then
			for i=1, #reader do 
				if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
					local f = io.open("data/attitudegroup/"..reader[i].name)
					local lines = f:read("*a")
					if(lines ~= "") then
						local jsonf = trydecodeJSOn(lines,f,"data/attitudegroup/"..reader[i].name)
						table.insert(tableDis, jsonf)
					end
					f:close()
				end
			end
		end
		--debugPrint(1,"Importing District...")
		return tableDis
	end
	function initFastTravel()
		
		--debugPrint("Importing District...")
		
		local f = assert(io.open("data/fasttravelmarkref.json"))
		
		lines = f:read("*a")
		
		encdo = lines
		
		tableDis = {}
		
		tableDis = trydecodeJSOn(lines,f,"data/fasttravelmarkref.json")
		
		
		
		
		
		
		
		--debugPrint("District Imported")
		f:close()
		return tableDis
		
		
	end
	
	function initPath()
		for k,v in pairs(arrayDatapack) do
			if('table' == type(v) and v.enabled ~= nil and v.enabled == true) then
				local reader = dir("datapack/"..k.."/path")
				if(reader ~= nil) then
					for i=1, #reader do 
						local f = io.open("datapack/"..k.."/".."path".."/"..reader[i].name)
						local lines = f:read("*a")
						if(lines ~= "") then
							
							local path = "datapack/"..k.."/".."path".."/"..reader[i].name
							
							local jsonf = trydecodeJSOn(lines,f,path)
							
							arrayPath[jsonf.tag] = {}
							arrayPath[jsonf.tag].gamepath = jsonf
							arrayPath[jsonf.tag].file = path
							arrayPath[jsonf.tag].datapack = k
							f:close()
							else
							res = false
							f:close()
						end
						
						
						
					end
					
				end
				
			end
		end
		
		
	end
	
	function addCustomNPC(npc)
		local isexist= false
		for i=1,#arrayPnjDb do
			if npc.name == arrayPnjDb[i].Names then
				isexist = true
			end
		end
		if isexist == false then
			local npcadd = {}
			npcadd.Names = npc.name
			npcadd.Id = #arrayPnjDb+1
			npcadd.TweakIDs =npc.tweakDB
			table.insert(arrayPnjDb,npcadd)
		end
	end
	function addNewCustomNPC()
		for i=1,#arrayCustomNPC do
			addCustomNPC(arrayCustomNPC[i])
		end
	end
	
	
	
	function readToImport() --Obsolete
		local directories = {}
		if(nativeSettings ~= nil and nativeSettings.data["CMDT"] ~= nil  ) then
			nativeSettings.data["CMDT"].options = {}
		end
		local reader = dir("datapack")
		for i=1, #reader do 
			if(tostring(reader[i].type) == "directory") then
				debugPrint(1,reader[i].name)
				-- debugPrint(1,fname[i].type)
				table.insert(directories,reader[i].name)
			end
		end
		for i=1, #directories do
			local isnew = true
			local registeritem = nil
			for z=1,#register do
				if(register[z].name == directories[i]) then
					registeritem = register[z]
				end
			end
			local regi = {}
			if(registeritem == nil) then
				regi.name = directories[i]
				regi.enabled = false
				table.insert(register,regi)
				else
				regi = registeritem
			end
			if(regi.enabled == nil) then
				regi.enabled = false
			end
			if(nativeSettings ~= nil and nativeSettings.data["CMDT"] ~= nil) then
				nativeSettings.addSwitch("/CMDT", regi.name, "index :"..i, regi.enabled, regi.enabled, function(state)
					if (state == false) then
						
						DisableDatapack(name)
						UnloadSpecificDatapack(regi.name)
						else
						EnableDatapack(regi.name)
						LoadSpecificDataPack(regi.name)
					end
				end)
			end
		end
		local toremove = {}
		for z=1,#register do
			local exist = false
			for i=1, #directories do
				if(register[z].name == directories[i]) then
					exist = true
				end
			end
			if(exist == false) then
				table.insert(toremove,register[z].name)
			end
		end
		for i=1,#toremove do
			local candoit = true
			for z=1,#register do
				if(candoit == true) then
					if(register[z].name == toremove[i]) then
						table.remove(register,z)
						candoit = false
					end
				end
			end
		end
		local file2 = assert(io.open("datapack/register.json", "w"))
		local stringg2 = JSON:encode_pretty(register)
		file2:write(stringg2)
		file2:close()
	end	
	
	function readRegisteredMissionPackFolder()
		local register = {}
		if( file_exists("datapack/register.json") ) then
			local flo = io.open("datapack/register.json")
			lines = flo:read("*a")
			if(lines ~= "") then
				register = trydecodeJSOn(lines,flo,"datapack/register.json")
				debugPrint(1,"you have already "..#register.." missionpack registered")
				res=true
				else
				res = false
				register = {}
				debugPrint(1,"register file is empty")
			end
			flo:close()
		end 
		return register
	end
	
	
	
		