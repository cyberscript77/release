
function PlayerPuppet_ReactToHitProcess(thos,hitEvent)
	if(observerthread3  == true or moddisabled == true)    then return end
	
	--targetGodMode = GetImmortality(hitEvent.target)
	if  hitEvent.target:IsPlayer() == true then
		--if (targetGodMode == gameGodModeType.Invulnerable or hitEvent.attackData:HasFlag(hitFlag.WasBlocked) or hitEvent.attackData:HasFlag(hitFlag.WasDeflected) or hitEvent.attackData:HasFlag(hitFlag.DealNoDamage) or hitEvent.attackData:HasFlag(hitFlag.DisableNPCHitReaction)) then
		if (hitEvent.attackData:HasFlag(hitFlag.WasBlocked) or hitEvent.attackData:HasFlag(hitFlag.WasDeflected) or hitEvent.attackData:HasFlag(hitFlag.DealNoDamage) or hitEvent.attackData:HasFlag(hitFlag.DisableNPCHitReaction)) then
			PlayerisHitten = false
			else
			PlayerisHitten = true
			
		end
	end
	
	
end



function PlayerPuppet_SetEntityNoticedPlayerBBValue(thos,b)
	if(observerthread3  == true or moddisabled == true)    then return end
	playerNoticed = b
	--logme(10,"playerNoticed "..tostring(b))
end

function PlayerPuppet_OnBeingTarget(thos,evt)
	if(observerthread3  == true or moddisabled == true)    then return end
	
	if(evt.noLongerTarget == true) then
		
		local indextoremove = 0
		for i,v in ipairs(entityTargetPlayer) do
			
			if(evt.objectThatTargets:IsA("entEntity") and evt.objectThatTargets:GetEntityID()==v:GetEntityID()) then
				
				indextoremove = i
				break
				
			end
			
		end
		if indextoremove > 0 then
			table.remove(entityTargetPlayer,indextoremove)
		end
		
		
		else
		
		local isalreadyinsert = true
		pcall(function()
			for i,v in ipairs(entityTargetPlayer) do
				
				
				if(evt.objectThatTargets:IsA("entEntity") and evt.objectThatTargets:GetEntityID()==v:GetEntityID())then
					isalreadyinsert = false
					break
				end
				
				
			end
		end)
		if isalreadyinsert == true then
			table.insert(entityTargetPlayer,evt.objectThatTargets)
		end
	end
	
	
	playerTargeted = #entityTargetPlayer>0
	--logme(10,"playerTargeted "..tostring(playerTargeted))
end 

function PlayerPuppet_OnGameAttached(thos)
	if(observerthread4  == true or moddisabled == true)    then return end
	GameController["PlayerPuppet"]  = thos
	startListeners(thos)
end



function PlayerPuppet_OnDeath()
	if(observerthread4 == true or moddisabled  == true)   then return end
	isdead = true
end
