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
		local file = io.open("user/cache/"..k..".lua", "w")	
		--file:write('logme(10,'..k..' Cache Loaded) return ')
		if(file ~= nil) then
		file:write('return ')
		file:write(exportDatapackArray(arrayDatapack[k]))
		file:close()
		
		
		logme(1,k.." "..getLang("datapack_datapack_created")..msg,true)
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
					logme(2,"Creating cache for "..directories)
					
					
					
				end,
				catch {
					function(error)
						logme(1,getLang("datapack_error_import")..directories..') '..error,true)
						
						arrayDatapack[directories] = nil
					end
				}
			}
		end

end



function ImportDataPack()
	--logme(1,"Registering MissionPack...")
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
	
	
	
	if(#directories > 0) then
		for i = 1, #directories do
			
			ImportDataPackFolder(directories[i])
			exportCompiledDatapackFolder(directories[i],"From Create")
			
		end
	
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
			
			
			logme(1,getLang("datapack_recover"),true)
			
			
		end,
		catch {
			function(error)
				logme(1,getLang("datapack_recover_fail")..error,true)
				
			end
		}
	}
	else
	logme(1,getLang("datapack_wrong_default")..tostring(lines),true)
	error(getLang("datapack_wrong_default")..tostring(lines))
	
	end
	
	
	
	
	
end

function CheckandUpdateDatapack()

	if(arrayDatapack ~= nil) then 
	local directories = {}
	loadAssetsObject()
	if(arrayDatapack["default"] ~= nil) then 
	
	end
	
	if(nativeSettings ~= nil and nativeSettings.data["CMDT"] ~= nil  ) then
		nativeSettings.data["CMDT"].options = {}
		else
		nativeSettings.addTab("/CMDT", "CyberScript Mods Manager") -- Add our mods tab (path, label)
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
			
			
			
			else
			
			logme(1,"No DESC FOR "..k,true)
			arrayDatapack[k] = nil
		end
		
		
		
		
		if(
			jsondesc ~= nil 
			
			and 
			
			(
					
					(
						(arrayDatapack[k] ~= nil and (
							(arrayDatapack[k].metadata ~= nil and jsondesc.version ~= arrayDatapack[k].metadata.version) 
							or (arrayDatapack[k].metadata ~= nil and table_contains(arrayDatapack[k].metadata.flags,"compile",false) == true and 
								DatapackChecker(arrayDatapack[k].metadata) == true ) or 
								arrayDatapack[k].state == "new"))
					
					or
						arrayDatapack[k] == nil 
					
					
					)
			)
		) 
		then
			
			local isenabled = false
			haveupdate = true
			arrayDatapack[k].metadata=jsondesc
			if((arrayDatapack[k] ~= nil and arrayDatapack[k].enabled == true)) then
				
				isenabled = true
				
			end
			
			
			
			
			
		
				try {
					function()
						loadDatapackObject(k)
						arrayDatapack[k].enabled = isenabled
						arrayDatapack[k].state = nil
						logme(1,getLang("datapack_updated_01")..k..getLang("datapack_updated_02"),true)
						arrayDatapack[k].cachedata={}
						arrayDatapack[k].cachedata.CacheVersion=cacheVersion
						arrayDatapack[k].cachedata.modVersion=cyberscript.version
						exportCompiledDatapackFolder(k,"Updated cache")
							
						
					end,
					catch {
						function(error)
							logme(1,getLang("datapack_error_import")..k..') '..error,true)
							arrayDatapack[k] = nil
							
						end
					}
				}
			
			else
			
		
			
			
				local test1 = jsondesc ~= nil 
				local test2 = (arrayDatapack[k] ~= nil and ((table_contains(arrayDatapack[k].metadata.flags,"compile",false) == true and DatapackChecker(arrayDatapack[k].metadata) == true ) ))
				local test3 = arrayDatapack[k] == nil 
				
				logme(1,"Can't load "..k.." from the cache : \n | jsondesc is not null : "..tostring(test1).." \n | datapack have required flag: "..tostring(test2).." \n | datapack is null : "..tostring(test3),true)
				
			 
		end
		
		
	
	end
	
	local i = 1
	for k,v in pairs(arrayDatapack) do
		
		local status, retval = pcall(function()
		if('table' == type(v)) then
			if(nativeSettings ~= nil and nativeSettings.data["CMDT"] ~= nil and (table_contains(arrayDatapack[k].metadata.flags,"essential",false) == false)) then
		
				nativeSettings.addSwitch("/CMDT", k, arrayDatapack[k].metadata.version, arrayDatapack[k].enabled, arrayDatapack[k].enabled, function(state)
					if (state == false) then
						
						DisableDatapack(k)
						UnloadDataPackCacheSingle(k)
						else
						
						local enabled = arrayDatapack[k].enabled
						loadDatapackObject(k)
						arrayDatapack[k].enabled = true
						arrayDatapack[k].state = nil
						arrayDatapack[k].cachedata={}
						arrayDatapack[k].cachedata.CacheVersion=cacheVersion
						arrayDatapack[k].cachedata.modVersion=cyberscript.version
						EnableDatapack(k)
						LoadDataPackCacheSingle(k)
					end
				end)
			end
			
			if((table_contains(arrayDatapack[k].metadata.flags,"essential",false) == true)) then
				EnableDatapack(k)
				LoadDataPackCacheSingle(k)
			end
			
			i = i +1
		end
			
		end)
		
		if status == false then
											
											
								
											logme(1,getLang("Modpack Setting Error") .. retval.." Modpack : "..k.."value : "..tostring(arrayDatapack[k].enabled))
											--Game.GetPlayer():SetWarningMessage("CyberScript Scripting error, check the log for more detail")
											
										end
										
		
		end
	end
	
	
	
	
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
				if(objtype == "texture") then
					
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
					imageobj.file="datapack/"..namespace.."/"..objtype.."/"..reader[i].name
					imageobj.namespace = namespace
					
					
					
					arrayDatapack[namespace][objtype][tostring(reader[i].name)] = {}
					arrayDatapack[namespace][objtype][tostring(reader[i].name)] = imageobj
					
					end
					
					
					
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

function loadAssetsObject()
	

	local namespace = "cyberscript"
	arrayDatapack[namespace] = {}
	arrayDatapack[namespace].enabled = true
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




function DeleteDatapackFromCache(tag)
	
	if(arrayDatapack[tag]~= nil) then
		arrayDatapack[tag] = nil
		if(name ~= "default") then
			arrayDatapack[tag] = nil
		end
	end
	
	
	if(file_exists('user/cache/'..tag..'.lua') == true) then
						
			os.remove('user/cache/'..tag..'.lua')
			--print(tag.." datapack no longer exist, deleting cache...")
		
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
	
	
	calculatePOIList()
end

	function LoadDataPackCacheSingle(k)
	
	
	
	
	
			local v = arrayDatapack[k]
			if('table' == type(v) and v.enabled ~= nil and v.enabled == true) then
				
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
				if('table' == type(v) and v.enabled ~= nil and v.enabled == true) then
					
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
			end
			else 
			
		end
		
	
	

	loadQuestsToUI()
	getInteractGroup()
	FillCharacterArchive()
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
									local path = "datapack/"..datapackname.."/"..objtype.."/"..value[i].tag..".json"
									rootpath = path
									makeTypeCachedObject(objtype,value[i],nil,path,datapackname)
									
								end
							else
								if(value.tag ~= nil) then
									local path = "datapack/"..datapackname.."/"..objtype.."/"..key
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
									local path = "datapack/"..datapackname.."/"..objtype.."/"..value[i].tag..".json"
									rootpath = path
									makeTypeCachedObject(objtype,value[i],nil,path,datapackname)
									
									if(cyberscript.cache[objtype][tostring(value[i].tag)]["data"] == nil) then
										cyberscript.cache[objtype][tostring(value[i].tag)]["data"]["havequitoption"] = true
									end
								end
							else
								if(value.tag ~= nil) then
									local path = "datapack/"..datapackname.."/"..objtype.."/"..key
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
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						end
						elseif(objtype == "faction") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "fixer") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "functions") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "help") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "housing") then
						for key, value in pairs(tabl) do 
						
							
							
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
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
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
							cyberscript.cache["interact"][value.tag].data.group = datapackname
							
						end
						elseif(objtype == "interfaces") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "lang") then
						
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							cyberscript.cache["lang"][value.tag] = {}
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						
							
						end
						elseif(objtype == "mission") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
							
						end
						elseif(objtype == "node") then
						for key, value in pairs(tabl) do 
							
							if(#value > 0) then
								for i=1,#value do
									local path = "datapack/"..datapackname.."/"..objtype.."/"..value[i].tag..".json"
									rootpath = path
									makeTypeCachedObject(objtype,value[i],nil,path,datapackname)
									
								end
								
							else
								if(value.tag ~= nil) then
									local path = "datapack/"..datapackname.."/"..objtype.."/"..key
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
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
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
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "phone_dialog") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
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
										setScore(cconversation.tag,"unlocked",1)
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
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "poi") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							if(value.tag == nil) then
								value.tag = key..tostring(math.random(1,99999))
							end
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "radio") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						
							cyberscript.cache["radio"][value.tag].enabled = false
							
						end
						elseif(objtype == "shard") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "sound") then
						for key, value in pairs(tabl) do 
							
							
							if(#value > 0) then
								for i=1,#value do
									local path = "datapack/"..datapackname.."/"..objtype.."/"..value[i].tag..".json"
									rootpath = path
									makeTypeCachedObject(objtype,value[i],nil,path,datapackname)
									
									
								end
								
								
							else
								if(value.tag ~= nil) then
									local path = "datapack/"..datapackname.."/"..objtype.."/"..key
									rootpath = path
									makeTypeCachedObject(objtype,value,nil,path,datapackname)
									
								end
							end
						end
						elseif(objtype == "texture") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							cyberscript.cache[objtype][key] = {}
							
							cyberscript.cache[objtype][key].datapack = datapackname
							cyberscript.cache[objtype][key].scripttype = objtype
							cyberscript.cache[objtype][key].data = path
							cyberscript.cache[objtype][key].file = path
						end
						elseif(objtype == "scene") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						
						end
						elseif(objtype == "housing_template") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "hud") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "setting") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "codex") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						
						elseif(objtype == "webpage") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "email") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "character") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,"name",path,datapackname)
							
						end
						elseif(objtype == "quickhack") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
							
						end
						elseif(objtype == "garage") then
						for key, value in pairs(tabl) do 
							local path = "datapack/"..datapackname.."/"..objtype.."/"..key
							rootpath = path
							
							makeTypeCachedObject(objtype,value,nil,path,datapackname)
						end
						elseif(objtype == "ai") then
							for key, value in pairs(tabl) do 
								local path = "datapack/"..datapackname.."/"..objtype.."/"..key
								rootpath = path
								
								makeTypeCachedObject(objtype,value,nil,path,datapackname)
							end
					elseif(objtype == "aitemplate") then
							for key, value in pairs(tabl) do 
								local path = "datapack/"..datapackname.."/"..objtype.."/"..key
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
	
	for k, ent in pairs(cyberscript.cache["character"]) do
		
		TweakDB:CloneRecord(ent.data.name, ent.data.source)
		TweakDB:SetFlat(ent.data.name..".entityTemplatePath", ent.data.path)
		if(ent.data.model ~= nil) then
				TweakDB:SetFlats(ent.data.name,{
				voiceTag = TweakDB:GetFlat(ent.data.model..".voiceTag"),
				displayName = TweakDB:GetFlat(ent.data.model..".displayName"),
				alternativeDisplayName = TweakDB:GetFlat(ent.data.model..".alternativeDisplayName"),
				alternativeFullDisplayName = TweakDB:GetFlat(ent.data.model..".alternativeFullDisplayName"),
				fullDisplayName = TweakDB:GetFlat(ent.data.model..".fullDisplayName"),
				affiliation =  TweakDB:GetFlat(ent.data.model..".affiliation"),
				statPools =  TweakDB:GetFlat(ent.data.model..".statPools"),
			})
		end
		
		
		print("Making Character "..ent.data.name)
		print("Falt Character "..GameDump(TweakDB:GetFlat(ent.data.name..".entityTemplatePath")))
		local parent = {}
		for i,v in ipairs(cyberscript.entities) do
		
			if(v.entity_tweak == ent.data.source) then parent = deepcopy(v, nil) end
		
		end
					
		
		parent.entity_id = TweakDBID.new(ent.data.name).hash
		parent.entity_entname = ent.data.path
		parent.entity_name = ent.data.name
		parent.entity_entpath = ent.data.path
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
	
	
	function readInstalledDatapack()
		readRegisteredMissionPackFolder()
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
			if('table' == type(v) and v.enabled ~= nil and v.enabled == true) then
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
	
	
	
	
	
	function readToImport() --Obsolete
		local directories = {}
		if(nativeSettings ~= nil and nativeSettings.data["CMDT"] ~= nil  ) then
			nativeSettings.data["CMDT"].options = {}
		end
		local reader = dir("datapack")
		for i=1, #reader do 
			if(tostring(reader[i].type) == "directory") then
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
						
						DisableDatapack(regi.name)
						UnloadDataPackCacheSingle(regi.name)
						else
						EnableDatapack(regi.name)
						LoadDataPackCacheSingle(regi.name)
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
				logme(1,"you have already "..#register.." missionpack registered")
				res=true
				else
				res = false
				register = {}
				logme(1,"register file is empty")
			end
			flo:close()
		end 
		return register
	end
	
	
	
		