local ImGuiExtension = {}



-- Draws a ImGui text to the window
function ImGuiExtension.ObjectToText(objectName, object)
	local text = objectName .. ": " .. tostring(object or "nil")
	
		ImGui.Text(text)
	end

-- Draws a node
function ImGuiExtension.ObjectToTextNil(name)
	ImGuiExtension.ObjectToText(name, "nil")
end

-- Draws a node
function ImGuiExtension.TextToTreeNode(text)
	return ImGui.TreeNode(text) 
end

-- Draws a TreeNode given certain information
function ImGuiExtension.DrawNodeTree(name, className, object, func)
	if object ~= nil then 
		if ImGuiExtension.TextToTreeNode(name .. " - " .. className) then 
			func(object)
			ImGui.Separator()
			ImGui.Unindent()
		end
	else
		ImGuiExtension.ObjectToTextNil(name)
	end
end

-- Draws a Vector4 to the window given the vector4 name and the vector itself
function ImGuiExtension.DisplayVector4(vectorName, vector4)
    ImGuiExtension.DrawNodeTree(vectorName, "Vector4", vector4, 
		function() 
            ImGuiExtension.ObjectToText("X", vector4.x)
			ImGuiExtension.ObjectToText("Y", vector4.y)
			ImGuiExtension.ObjectToText("Z", vector4.z)
            ImGuiExtension.ObjectToText("W", vector4.w)
        end
	)
end

-- Draw objects as an array and run a given func on the object
function ImGuiExtension.DisplayObjectArray(name, className, object, func) 
	ImGuiExtension.DrawNodeTree(name, className, object, 
		function() 
			for key, value in ipairs(object) do
				func(key, value)
			end
		end
	)
end

return ImGuiExtension