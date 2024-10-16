logme(1,"CyberScript: modpack module loaded")
cyberscript.module = cyberscript.module +1


 function exportDatapackArray(t, max, depth, result)
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
						logme(10,('Cannot store userdata in the %q field.'):format(k))
						--raiseError(('Cannot store userdata of type %q in the %q field.'):format(vtype, k))
						else
						logme(10,('Cannot store userdata in the list.'))
						--raiseError(('Cannot store userdata of type %q.'):format(vtype))
					end
					else
					vstr = ''
				end
			end
			elseif vtype == 'function' or vtype == 'thread' then
			if not sessionDataRelaxed then
				if ktype == 'string' then
					logme(10,('Cannot store %s in the %q field.'):format(vtype, k))
					else
					logme(10,('Cannot store %s.'):format(vtype))
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


-- function exportCompiledDatapackFolder(directories,msg)
	
-- 		local k = directories
-- 		local file = io.open("user/cache/"..k..".lua", "w")	
-- 		--file:write('logme(10,'..k..' Cache Loaded) return ')
-- 		if(file ~= nil) then
-- 		file:write('return ')
-- 		file:write(exportDatapackArray(arrayDatapack[k]))
-- 		file:close()
		
		
-- 		logme(1,k.." : "..msg,true)
-- 		end
	
-- end



function ImportDataPack()
	

	local directories = {}
		
		
	--we load the directories from datapack registry
	
	for k,v in ipairs(cyberscript.datapackRegistry) do 
		
			table.insert(directories,v)
		
	end



	--for each directories
	for i,u in ipairs(directories) do
				
		-- we check if there is an existing cache
		
		
		local mod =  GetMod(u)
		local datapack = {}

		if mod ~= nil then 
			
			datapack = mod.compile()
			arrayDatapack[u] = datapack
			arrayDatapack[u].enabled= true
			logme(1,"Cyberscript : "..u.." Registred !")
			
		else 
			print("ERROR : "..u.." mod not found !")
				
		end

		
	
		
		
		
	end









end






function ImportDataPackSingle(tag)
	local mod =  GetMod(tag)
	local datapack = {}

	if mod ~= nil then 
		
		datapack = mod.compile()
		arrayDatapack[tag] = datapack
		arrayDatapack[tag].enabled= true
		logme(1,"Cyberscript : "..tag.." Registred !")
		
	else 
		print("ERROR : "..tag.." mod not found !")
			
	end
	
end









--cache manipulation

function loadAssetsObject()
	

	local namespace = "cyberscript"
	arrayDatapack[namespace] = {}
	
	arrayDatapack[namespace].metadata = {}
	arrayDatapack[namespace].metadata.name = "Default Assets"
	arrayDatapack[namespace].metadata.desc = "Default Assets"
	arrayDatapack[namespace].metadata.author = "CyberScript"
	arrayDatapack[namespace].metadata.file = "cyberscript"
	arrayDatapack[namespace].metadata.tag = "cyberscript"
	arrayDatapack[namespace].metadata.version = cyberscript.version
	arrayDatapack[namespace].metadata.flags = {"compile","essential"}
	
	
	for i=1,#datapackObjectType do
		local objtype = datapackObjectType[i]
		
		local reader = dir("assets/"..objtype)
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
					imageobj.path=namespace.."\\texture\\"..reader[i].name
					imageobj.namespace = namespace
					
					
					
					arrayDatapack[namespace][objtype][tostring(reader[i].name)] = {}
					arrayDatapack[namespace][objtype][tostring(reader[i].name)] = imageobj
					
					end
					
					
					else
					
					if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
						
						local foo = io.open("assets/"..objtype.."/"..reader[i].name)
						local lines = foo:read("*a")
						if(lines ~= "") then
							local jsonf = trydecodeJSOn(lines,foo,"assets/"..objtype.."/"..reader[i].name)
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


	


	logme(1,"CyberScript Assets Loaded",true)

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

function UnloadDataPackCacheSingle(k)
	for i,objtype in ipairs(datapackObjectType) do
		spdlog.error(objtype)
		for tag,v in pairs(cyberscript.cache[objtype]) do 
			
			if(v.datapack == k)then
				
				logme(1,"delete "..tag)
			
				cyberscript.cache[objtype][tag] = nil
				
				
			end
		end

	end
	loadQuestsToUI()
	getInteractGroup()
	FillCharacterArchive()
	FillTweakFlatArchive()
	
	calculatePOIList()
end

function LoadDataPackCacheSingle(k)
	
	
	
	
	
			local v = arrayDatapack[k]
			if('table' == type(v)) then
				
				if(DatapackChecker(v.metadata)) then
				
					for y=1,#datapackObjectType do
					
						local objtype = datapackObjectType[y]
						
					
					
						if(arrayDatapack[k][objtype] ~= nil) then
							
							try {
								function()
							FillList(objtype,arrayDatapack[k][objtype],k)
								end,
							
							catch {
								function(error)
									logme(1,'Error during loading cache for datatpack: '..error,true)
									
								end
							}
							}
							else
						--	logme(10,"can't find "..objtype.." for "..k)
							
						end
						
					end
				else
				logme(1,"Output : "..tostring(DatapackChecker(v.metadata)),true)
				logme(1,"can't load : "..k.." data :"..tostring(dump(v.metadata)),true)
				
				end
			end
			
			
		
		
	
	

	loadQuestsToUI()
	getInteractGroup()
	FillCharacterArchive()
	FillTweakFlatArchive()
	
	calculatePOIList()
	
end


	
function LoadDataPackCache()
	
	
	cyberscript.cache = {}
	for y=1,#datapackObjectType do
						
		local objtype = datapackObjectType[y]
		
		cyberscript.cache[objtype] = {}
							
	end
	
	if(arrayDatapack ~= nil) then
	
	
	
			for k,v in pairs(arrayDatapack) do
				if('table' == type(v)) then
					
					if(DatapackChecker(v.metadata)) then
					
						for y=1,#datapackObjectType do
						
							local objtype = datapackObjectType[y]
							
						
						
							if(arrayDatapack[k][objtype] ~= nil) then
								logme(1,"Loading "..objtype.." for "..k,true)
								try {
									function()
								FillList(objtype,arrayDatapack[k][objtype],k)
									end,
								
								catch {
									function(error)
										logme(1,'Error during loading cache for datatpack: '..error,true)
										
									end
								}
								}
								else
							--	logme(10,"can't find "..objtype.." for "..k)
								
							end
							
						end
					else
					logme(1,"Output : "..tostring(DatapackChecker(v.metadata)),true)
					logme(1,"can't load : "..k.." data :"..tostring(dump(v.metadata)),true)
					
					end
				end
			end
			else 
			
		end
		
	
	

	loadQuestsToUI()
	getInteractGroup()
	FillCharacterArchive()
	FillTweakFlatArchive()
	buildnativesetting()
	
	calculatePOIList()

end
	
function calculatePOIList()
	
	poi_district = {}
	poi_subdistrict = {}
	poi_type = {}
	poi_tag = {}
	
	for k,v in pairs(cyberscript.cache["poi"]) do
		
		
		for i,location in ipairs(v.data.locations) do
			
			
			local obj = {}
			obj.tag = location.Tag
			obj.type = v.data.isFor
			obj.district =location.district
			obj.subdistrict = location.subdistrict
			obj.inVehicule = location.inVehicule
			obj.x = location.x
			obj.y = location.y
			obj.z = location.z
			
			
			if(poi_district[obj.district] == nil) then poi_district[obj.district] = {} end
			if(poi_district[obj.district]["inVehicule"] == nil) then poi_district[obj.district]["inVehicule"] = {} end
			if(poi_district[obj.district]["outVehicule"] == nil) then poi_district[obj.district]["outVehicule"] = {} end
			
			if(obj.inVehicule) then
			
				poi_district[obj.district]["inVehicule"][obj.tag] = obj
			
			else
				
				poi_district[obj.district]["outVehicule"][obj.tag] = obj
			
			end
			
			
			
			if(poi_subdistrict[obj.subdistrict] == nil) then poi_subdistrict[obj.subdistrict] = {} end
			if(poi_subdistrict[obj.subdistrict]["inVehicule"] == nil) then poi_subdistrict[obj.subdistrict]["inVehicule"] = {} end
			if(poi_subdistrict[obj.subdistrict]["outVehicule"] == nil) then poi_subdistrict[obj.subdistrict]["outVehicule"] = {} end
			
			if(obj.inVehicule) then
			
				poi_subdistrict[obj.subdistrict]["inVehicule"][obj.tag] = obj
			
			else
				
				poi_subdistrict[obj.subdistrict]["outVehicule"][obj.tag] = obj
			
			end
			
			
			if(poi_type[tostring(obj.type)] == nil) then poi_type[tostring(obj.type)] = {} end
			if(poi_type[tostring(obj.type)]["inVehicule"] == nil) then poi_type[tostring(obj.type)]["inVehicule"] = {} end
			if(poi_type[tostring(obj.type)]["outVehicule"] == nil) then poi_type[tostring(obj.type)]["outVehicule"] = {} end
			
			if(obj.inVehicule) then
			
				poi_type[tostring(obj.type)]["inVehicule"][obj.tag] = obj
			
			else
				
				poi_type[tostring(obj.type)]["outVehicule"][obj.tag] = obj
			
			end
			
		
			poi_tag[obj.tag] = obj
	
	
		end
	
	
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
									local path = "datapack/"..objtype.."/"..value[i].tag..".json"
									rootpath = path
									makeTypeCachedObject(objtype,value[i],nil,path,datapackname)
									
								end
							else
								if(value.tag ~= nil) then
									local path = "datapack/"..objtype.."/"..key
									rootpath = path
									cyberscript.cache["circuit"][value.tag] = {}
									cyberscript.cache["circuit"][value.tag].data = value
									cyberscript.cache["circuit"][value.tag].file = path
									cyberscript.cache["circuit"][value.tag].datapack = datapackname
									cyberscript.cache["circuit"][value.tag].scripttype = objtype
								end
							end
						end
						elseif(objtype == "choice") then
						for key, value in pairs(tabl) do 
							
							if(#value > 0) then
								for i=1,#value do
									local path = "datapack/"..objtype.."/"..value[i].tag..".json"
									rootpath = path
									makeTypeCachedObject(objtype,value[i],nil,path,datapackname)
									
									if(cyberscript.cache[objtype][tostring(value[i].tag)]["data"] == nil) then
										cyberscript.cache[objtype][tostring(value[i].tag)]["data"]["havequitoption"] = true
									end
								end
							else
								if(value.tag ~= nil) then
									local path = "datapack/"..objtype.."/"..key
									rootpath = path
									makeTypeCachedObject(objtype,value,nil,path,datapackname)
									
									if(cyberscript.cache[objtype][tostring(value.tag)]["data"] == nil) then
										cyberscript.cache[objtype][tostring(value.tag)]["data"]["havequitoption"] = true
									end
								
								end
							end
						end
						elseif(objtype == "event") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						end
						elseif(objtype == "faction") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "fixer") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "functions") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "help") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "housing") then
						for key, value in pairs(tabl) do 
						
							
							
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							
							
							
							if(value.customIncluded ~= nil) then --amm template
								logme(1,"Cyberscript : AMM housing founded : "..path..". Converting to CS Housing..")
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
								
								
								makeTypeCachedObject(objtype,newobj,nil,path,datapackname)
								
								
								if(statutfile == true) then logme(1,"Cyberscript : AMM housing : "..path..". Convertion successfull !") else logme(1,"Cyberscript : AMM housing : "..path..". Convertion failed !") end
								
								else
								
								if(value.tag ~= nil) then
							
									makeTypeCachedObject(objtype,value,nil,path,datapackname)
								
								
								else
								
								logme(1,"Cyberscript : old housing format founded : "..path..". Not Loaded, apply modification to allow the loading.")
								
								end
							
								
							
							end
							
							
							
							
							
						end
						elseif(objtype == "interact") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
							cyberscript.cache["interact"][value.tag].data.group = datapackname
							
						end
						elseif(objtype == "interfaces") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "lang") then
						
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							cyberscript.cache["lang"][value.tag] = {}
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						
							
						end
						elseif(objtype == "mission") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
							
						end
						elseif(objtype == "node") then
						for key, value in pairs(tabl) do 
							
							if(#value > 0) then
								for i=1,#value do
									local path = "datapack/"..objtype.."/"..value[i].tag..".json"
									rootpath = path
									makeTypeCachedObject(objtype,value[i],nil,path,datapackname)
									
								end
								
							else
								if(value.tag ~= nil) then
									local path = "datapack/"..objtype.."/"..key
									rootpath = path
									cyberscript.cache["node"][tostring(value.tag)] = {}
									cyberscript.cache["node"][tostring(value.tag)].data = value
									cyberscript.cache["node"][tostring(value.tag)].file = path
									cyberscript.cache["node"][tostring(value.tag)].datapack = datapackname
									cyberscript.cache["node"][tostring(value.tag)].scripttype = objtype
								end
							end
							
						end
						elseif(objtype == "npc") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						
							
							cyberscript.cache["npc"][value.tag].data.isspawn=false
							cyberscript.cache["npc"][value.tag].data.init=false
							cyberscript.cache["npc"][value.tag].data.spawnforced=false
							cyberscript.cache["npc"][value.tag].data.dospawnaction=true
							cyberscript.cache["npc"][value.tag].data.doroutineaction=true
							cyberscript.cache["npc"][value.tag].data.dodeathaction=true
							cyberscript.cache["npc"][value.tag].data.dodespawnaction=true
							cyberscript.cache["npc"][value.tag].data.workinglocation=value.location
							
						end
						elseif(objtype == "path") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "phone_dialog") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						
							setScore(value.tag,"unlocked",1)


							
							for i,conversation in ipairs(cyberscript.cache["phone_dialog"][tostring(value.tag)].data.conversation) do
								if(getScoreKey(conversation.tag,"readed") == nil) then
								
									setScore(conversation.tag,"readed",0)
								end
								if(conversation.unlock == false ) then
									if(getScoreKey(conversation.tag,"unlocked") == 0 or getScoreKey(conversation.tag,"unlocked") == nil ) then
										setScore(conversation.tag,"unlocked",0)
									end
								else
									if(getScoreKey(conversation.tag,"unlocked") == 0 or getScoreKey(conversation.tag,"unlocked") == nil) then
										setScore(conversation.tag,"unlocked",1)
									end
								end
								for j,message in ipairs(conversation.message) do
									if(getScoreKey(message.tag,"readed") == nil) then
								
										setScore(message.tag,"readed",0)
									end
									
									if(message.unlock == false ) then
										if(getScoreKey(message.tag,"unlocked") == 0 or getScoreKey(message.tag,"unlocked") == nil ) then
											setScore(message.tag,"unlocked",0)
										end
									else
										if(getScoreKey(message.tag,"unlocked") == 0 or getScoreKey(message.tag,"unlocked") == nil) then
											setScore(message.tag,"unlocked",1)
										end
									end
								end
									-- if(message.choices ~= nil) then
									-- 	for k,choice in ipairs(message.choices) do
									-- 		if(choice.unlock == false ) then
									-- 			if(getScoreKey(choice.tag,"unlocked") == 0 or getScoreKey(choice.tag,"unlocked") == nil ) then
									-- 				setScore(choice.tag,"unlocked",0)
									-- 			end
									-- 			else
									-- 			if(getScoreKey(choice.tag,"unlocked") == 0 or getScoreKey(choice.tag,"unlocked") == nil) then
									-- 				setScore(choice.tag,"unlocked",1)
									-- 			end
													
												
									-- 		end
									-- 	end
									-- end
							end
						end
						elseif(objtype == "place") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "poi") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							if(value.tag == nil) then
								value.tag = key..tostring(math.random(1,99999))
							end
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "radio") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						
							cyberscript.cache["radio"][value.tag].enabled = false
							
						end
						elseif(objtype == "shard") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "sound") then
						for key, value in pairs(tabl) do 
							
							
							if(#value > 0) then
								for i=1,#value do
									local path = "datapack/"..objtype.."/"..value[i].tag..".json"
									rootpath = path
									makeTypeCachedObject(objtype,value[i],nil,path,datapackname)
									
									
								end
								
								
							else
								if(value.tag ~= nil) then
									local path = "datapack/"..objtype.."/"..key
									rootpath = path
									makeTypeCachedObject(objtype,value,nil,path,datapackname)
									
								end
							end
						end
						elseif(objtype == "texture") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							
							cyberscript.cache[objtype][key] = {}
							
							cyberscript.cache[objtype][key].datapack = datapackname
							cyberscript.cache[objtype][key].scripttype = objtype
							cyberscript.cache[objtype][key].data = path
							cyberscript.cache[objtype][key].file = path
						end
						elseif(objtype == "scene") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						
						end
						elseif(objtype == "housing_template") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "hud") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "setting") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "codex") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						
						elseif(objtype == "webpage") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "email") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "character") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,"name",path,datapackname)
							
						end
						elseif(objtype == "tweakflat") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "quickhack") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "garage") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..objtype.."/"..key
							rootpath = path
							
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						end
						elseif(objtype == "ai") then
							for key, value in pairs(tabl) do 
								local path = "datapack/"..objtype.."/"..key
								rootpath = path
								
								makeTypeCachedObject(objtype,value,nil,path,datapackname)
							end
					elseif(objtype == "aitemplate") then
							for key, value in pairs(tabl) do 
								local path = "datapack/"..objtype.."/"..key
								rootpath = path
								
								makeTypeCachedObject(objtype,value,nil,path,datapackname)
							end
					end
					
				end
			
			
			end,
			catch {
				function(error)
					logme(1,'Error during creating cache for datatpack: '..error.." "..objtype.." "..datapackname.." path : "..rootpath,true)
				
				end
			}
			
		}
		
end

function makeTypeCachedObject(objtype,value,field,path,datapackname)

	local tag = value.tag
	
	if(field ~= nil) then
		
		tag = value[field]

	end
	if(cyberscript.cache[objtype] == nil) then cyberscript.cache[objtype] = {} end
		cyberscript.cache[objtype][tag] = {}
		cyberscript.cache[objtype][tag].data = value
		cyberscript.cache[objtype][tag].file = path
		cyberscript.cache[objtype][tag].datapack = datapackname
		cyberscript.cache[objtype][tag].scripttype = objtype

		if(objtype == "setting") then
			logme(1,dump(value),true)
		end

end

function FillTweakFlatArchive()

	for k, tweak in pairs(cyberscript.cache["tweakflat"]) do
	

		for source, object in pairs(tweak.data.tweak) do
			
			if(object.type == "set") then
			
				TweakDB:SetFlat(source, object.value)
			end

			if(object.type == "setnoupdate") then
			
				TweakDB:SetFlatNoUpdate(source, object.value)
			end

			if(object.type == "update") then
			
				TweakDB:Update(source)
			end

			if(object.type == "setbyget") then
			
				TweakDB:SetFlat(source, TweakDB:GetFlat(object.value))
			end

			if(object.type == "setbygetnoupdate") then
			
				TweakDB:SetFlatNoUpdate(source, object.value)
			end
			
			if(object.type == "clone") then
			
				TweakDB:CloneRecord(source, object.value)
			end

			if(object.type == "create") then
			
				TweakDB:CreateRecord(source, object.value)
			end

			if(object.type == "delete") then
			
				TweakDB:DeleteRecord(source)
			end
			
			logme(1,"Cyberscript - Mod "..k.." : Applied tweak for "..source)	
			
		end
	
		
	end
end
	
	
function FillCharacterArchive()

	for k, ent in pairs(cyberscript.cache["character"]) do
	
	TweakDB:CloneRecord(ent.data.name, ent.data.source)
	
	
	if(ent.data.model ~= nil) then
			TweakDB:SetFlats(ent.data.name,{
			voiceTag = TweakDB:GetFlat(ent.data.model..".voiceTag"),
			displayName = TweakDB:GetFlat(ent.data.model..".displayName"),
			alternativeDisplayName = TweakDB:GetFlat(ent.data.model..".alternativeDisplayName"),
			alternativeFullDisplayName = TweakDB:GetFlat(ent.data.model..".alternativeFullDisplayName"),
			fullDisplayName = TweakDB:GetFlat(ent.data.model..".fullDisplayName"),
			affiliation =  TweakDB:GetFlat(ent.data.model..".affiliation"),
			statPools =  TweakDB:GetFlat(ent.data.model..".statPools")
		})
	end

	if(ent.data.path ~= nil) then

		TweakDB:SetFlat(ent.data.name..".entityTemplatePath", ent.data.path)

	end

	if(ent.data.rarity ~= nil) then

		TweakDB:SetFlat(ent.data.name..".rarity", "NPCRarity."..ent.data.rarity)

	end
	
	
	print("Making Character "..ent.data.name)
	print("Falt Character "..GameDump(TweakDB:GetFlat(ent.data.name..".entityTemplatePath")))
	local parent = {}
	for i,v in ipairs(cyberscript.entities) do
	
		if(v.entity_tweak == ent.data.source) then parent = deepcopy(v, nil) break end
	
	end
				
	
	parent.entity_id = TweakDBID.new(ent.data.name).hash
	parent.entity_entname = ent.data.path
	parent.entity_name = ent.data.name
	if(ent.data.path ~= nil)then
		parent.entity_entpath = ent.data.path
	end
	parent.entity_tweak = ent.data.name
	
	local caninsert = true
	
	for i,v in ipairs(cyberscript.entities) do
	
		if(v.entity_id == parent.entity_id) then caninsert = false end
	
	end
	
	if caninsert == true then table.insert(cyberscript.entities,parent)end
	
				
				
			
	end
	
end
	
function loadQuestsToUI()
	for k,v in pairs(cyberscript.cache["mission"]) do
		local questos = cyberscript.cache["mission"][k].data
		local data = {}
		checkContext(questos)
		
		print(k)
		
		data.id = questos.tag
		data.title = getLang(questos.title)
		data.description = getLang(questos.content)
		data.extra = questos.extra
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
	data.extra = questos.extra
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
	


function initDistrict()
	--logme(1,"Importing District...")
	local f = assert(io.open("mod/data/districts.json"))
	lines = f:read("*a")
	encdo = lines
	tableDis = {}
	tableDis = trydecodeJSOn(lines,f,"mod/data/districts.json")
	--logme(1,"District Imported")
	f:close()
	return tableDis
end
function initVehicles()
	--logme(1,"Importing District...")
	local f = assert(io.open("mod/data/vehicles.json"))
	local lines = f:read("*a")
	local encdo = lines
	local tableDis = {}
	tableDis = trydecodeJSOn(lines,f,"mod/data/vehicles.json")
	--logme(1,"District Imported")
	f:close()
	
	for i,v in ipairs(tableDis) do
		
		arrayVehicles2[tostring(TweakDBID.new(v))] = v
	
	end
	
	return tableDis
end
function initGameSounds()
	--logme(1,"Importing District...")
	local f = assert(io.open("mod/data/gamesounds.json"))
	local lines = f:read("*a")
	local encdo = lines
	local tableDis = {}
	tableDis = trydecodeJSOn(lines,f,"mod/data/gamesounds.json")
	--logme(1,"District Imported")
	f:close()
	return tableDis
end
function initAttitudeGroup()
	local tableDis = {}
	local reader = dir("mod/data/attitudegroup/")
	if(reader ~= nil) then
		for i=1, #reader do 
			if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
				local f = io.open("mod/data/attitudegroup/"..reader[i].name)
				local lines = f:read("*a")
				if(lines ~= "") then
					local jsonf = trydecodeJSOn(lines,f,"mod/data/attitudegroup/"..reader[i].name)
					table.insert(tableDis, jsonf)
				end
				f:close()
			end
		end
	end
	--logme(1,"Importing District...")
	return tableDis
end
function initFastTravel()
	
	--logme("Importing District...")
	
	local f = assert(io.open("mod/data/fasttravelmarkref.json"))
	
	lines = f:read("*a")
	
	encdo = lines
	
	tableDis = {}
	
	tableDis = trydecodeJSOn(lines,f,"mod/data/fasttravelmarkref.json")
	
	
	
	
	
	
	
	--logme("District Imported")
	f:close()
	return tableDis
	
	
end

function initPath()
	for k,v in pairs(arrayDatapack) do
		if('table' == type(v)) then
			local reader = dir("datapack/"..k.."/path")
			if(reader ~= nil) then
				for i=1, #reader do 
					local f = io.open("datapack/"..k.."/".."path".."/"..reader[i].name)
					local lines = f:read("*a")
					if(lines ~= "") then
						
						local path = "datapack/"..k.."/".."path".."/"..reader[i].name
						
						local jsonf = trydecodeJSOn(lines,f,path)
						
						cyberscript.cache["path"][jsonf.tag] = {}
						cyberscript.cache["path"][jsonf.tag].data = jsonf
						cyberscript.cache["path"][jsonf.tag].file = path
						cyberscript.cache["path"][jsonf.tag].datapack = k
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







	
		
