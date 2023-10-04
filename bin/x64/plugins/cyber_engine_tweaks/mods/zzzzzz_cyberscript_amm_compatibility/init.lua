registerForEvent("onTweak", function()
	
		
print("CyberScript : AMM Compatibility Patch")
		TweakDB:SetFlat("PreventionSystem.setup.totalEntitiesLimit", 999999)
	


	
end)

registerForEvent("onInit", function()
	

Override("ShardsNestedListDataView", "SortItems", function (this, compareBuilder, left, right, wrapped)
		print("nested")
			local leftData = ShardEntryData.new()
			local rightData = ShardEntryData.new()
			leftData = left.data
			rightData = right.data
			if IsDefined(leftData) and IsDefined(rightData) then
			compareBuilder:BoolTrue(leftData.isNew, rightData.isNew):GameTimeDesc(leftData.timeStamp, rightData.timeStamp)
			end
	end)


	
end)
