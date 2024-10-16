


function BrowserController_OnInitialize(self,gameController)
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	GameController["BrowserController"]  = self
	GameController["BrowserGameController"]  = self
end

function SmartWindowInkGameController_InitializeMainLayout(this)
	
	if(observerthread4 == true or moddisabled  == true)  then return  end
	Cron.After(1, function()
		
		
		for k,v in pairs(cyberscript.EntityManager) do
			
			if(v.id ~= nil) then
				
				if(v.id.hash== this:GetOwner():GetEntityID().hash) then
					
					v.widget = this.rootWidget
					
					
					
					break
				end
			end
			
		end
	end)
end


function WebPage_FillPageFromJournal(self,page)
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	
	defaultPage = page
	
	
	if(page.address == "NETdir://ncity.pub") then -- custompage
		
		
		
		LinkController = inkWidgetRef.GetController(self.imageList[1])
		local root = self:GetRootWidget()
		
		
		local page = root:GetWidgetByIndex(0)
		local linkpanel = page:GetWidgetByIndex(0)
		local panel =linkpanel:GetWidgetByIndex(0)
		
		
		local network = panel:GetWidgetByIndex(0)
		local networktext = network:GetWidgetByIndex(4)
		local linkbar01 = panel:GetWidgetByIndex(1)
		local linkbar02 = panel:GetWidgetByIndex(2)
		local link01 = linkbar01:GetWidgetByIndex(0)
		
		
		
		local link02 = linkbar01:GetWidgetByIndex(1)
		local link03 = linkbar01:GetWidgetByIndex(2)
		local link04 = linkbar01:GetWidgetByIndex(3)
		local link05 = linkbar01:GetWidgetByIndex(4)
		local link06 = linkbar02:GetWidgetByIndex(0)
		local link07 = linkbar02:GetWidgetByIndex(1)
		local link08 = linkbar02:GetWidgetByIndex(2)
		local link09 = linkbar02:GetWidgetByIndex(3)
		local link10 = linkbar02:GetWidgetByIndex(4)
		
		
		
		if webcount == 0 then webcount = linkbar01:GetNumChildren() end
		if(webcount == linkbar01:GetNumChildren()) then
			if(isEmpty(cyberscript.cache["webpage"]) == false) then
				
				local linknew = inkVerticalPanelWidget.new()
				linknew:SetName(StringToName("linknew"))
				linknew:SetChildMargin(inkMargin.new({ left = 50.0, top = 30.0, right = 50.0, bottom = 30.0 }))
				
				linknew:SetFitToContent(true)
				
				
				
				
				local imageprop = {}
				imageprop.tag = "link03_img"
				imageprop.tweak = "PhotoModeStickers.dcl_04"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link03_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "CyberScript Network"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = linknew
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScriptWeb"
				action.subaddress = "home"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				linknew:Reparent(linkbar01, linkbar01:GetNumChildren()+1)
			end
			
		end
		
		
		if(CurrentAddress == "CyberScript") then
			
			if(BrowserCybserscript == "loading") then
				
				linkpanel:RemoveAllChildren()
				
				makeCustomInterface(linkpanel,cyberscript.cache["interfaces"]["Keystone_Load"].data)
				
				
				
				
				elseif(BrowserCybserscript == "home") then
				
				
				
				
				
				LinkController = inkWidgetRef.GetController(self.textList[1])
				--header
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("CyberScript")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				
				
				--link redef
				
				
				link01:RemoveAllChildren()
				
				
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "loading"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				
				
				if(CurrentServerModVersion.version ~= "unknown" and CurrentServerModVersion.version ~= "0.16000069") then
					
					if(CurrentServerModVersion.version ~= "unknown" and CurrentServerModVersion.version ~= "0.16000069" and checkVersionNumber(cyberscript.version,CurrentServerModVersion.version))then
						
						
						local container = inkCanvas.new()
						container:SetName(CName.new("need_update_banner"))
						container:SetFitToContent(false)
						
						container:SetSize(Vector2.new({ X = 3150, Y = 200 }))
						container:SetScale(Vector2.new({ X = 1, Y = 1 }))
						container:SetInteractive(true)
						
						container:SetAnchor(15)
						container:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						container:SetOpacity(1)
						container:SetRotation(0)
						container:SetVisible(true)
						
						
						
						
						container:Reparent(panel, 0)
						
						local rectangletitle = inkRectangleWidget.new()
						rectangletitle:SetName(CName.new("need_update_rectangle"))
						rectangletitle:SetFitToContent(false)
						rectangletitle:SetMargin(inkMargin.new({ top = 100 }))
						rectangletitle:SetSize(Vector2.new({ X = 3150, Y = 150 }))
						rectangletitle:SetScale(Vector2.new({ X = 1, Y = 1 }))
						rectangletitle:SetInteractive(true)
						rectangletitle:SetTintColor(gamecolorStyle({red=255,blue=0,green=0}))
						rectangletitle:SetAnchor(0)
						rectangletitle:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						rectangletitle:SetOpacity(1)
						rectangletitle:SetRotation(0)
						rectangletitle:SetVisible(true)
						rectangletitle:Reparent(container, -1)
						
						local texttitle = inkText.new()
						texttitle:SetName(CName.new("need_update_title"))
						texttitle:SetFitToContent(false)
						texttitle:SetMargin(inkMargin.new({ top = 75 }))
						texttitle:SetSize(Vector2.new({ X = 100, Y = 200 }))
						texttitle:SetScale(Vector2.new({ X = 1, Y = 1 }))
						texttitle:SetInteractive(true)
						texttitle:SetText(getLang("ui_keystone_main_update_available"))
						texttitle:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						texttitle:SetFontStyle('Medium')
						texttitle:SetFontSize(50)
						texttitle:SetHorizontalAlignment(1)
						texttitle:SetVerticalAlignment(1)
						texttitle:SetTintColor(gamecolorStyle({red=255,blue=255,green=255}))
						texttitle:SetAnchor(1)
						texttitle:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						texttitle:SetOpacity(1)
						texttitle:SetRotation(0)
						texttitle:SetVisible(true)
						texttitle:Reparent(container, -1)
						
						
						local textversion = inkText.new()
						textversion:SetName(CName.new("need_update_title"))
						textversion:SetFitToContent(false)
						textversion:SetMargin(inkMargin.new({ top = -100 }))
						textversion:SetSize(Vector2.new({ X = 100, Y = 200 }))
						textversion:SetScale(Vector2.new({ X = 1, Y = 1 }))
						textversion:SetInteractive(true)
						textversion:SetText("CyberScript : local version :"..cyberscript.version.." Server version :"..CurrentServerModVersion.version)
						textversion:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						textversion:SetFontStyle('Medium')
						textversion:SetFontSize(30)
						textversion:SetHorizontalAlignment(1)
						textversion:SetVerticalAlignment(1)
						textversion:SetTintColor(gamecolorStyle({red=255,blue=255,green=255}))
						textversion:SetAnchor(0)
						textversion:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						textversion:SetOpacity(1)
						textversion:SetRotation(0)
						textversion:SetVisible(true)
						textversion:Reparent(panel, 4)
						
						EventProxy.RegisterCallback(container, "OnRelease", function(_, evt)
							
							
							if( workerTable["keystone_update_mod"] == nil) then
								
								local actionlist = {}
								
								local action = {}
								
								
								action.name = "refreshBrowser" 
								action.page = page
								action.address = "CyberScript"
								action.subaddress = "keystone_update"
								table.insert(actionlist,action)
								
								runActionList(actionlist, "keystone_update_mod", "interact",false,"nothing",true)
							end
							
							evt:Handle()
						end)
						
						
					end
					
					
				end
				
				
				
				local imageprop = {}
				imageprop.tag = "link01_img"
				imageprop.tweak = "PhotoModeStickers.dcl_02"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link01_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Datapack"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link01
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "datapack"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link02:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link02_img"
				imageprop.tweak = "PhotoModeStickers.dcl_05"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link02_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "My Datapacks"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				
				local link = link02
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "mydatapack"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				link03:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link03_img"
				imageprop.tweak = "PhotoModeStickers.bnd_032"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link03_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "CorpoNetwork"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link03
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_corpo_news"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link04:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link04_img"
				imageprop.tweak = "PhotoModeStickers.dcl_014"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link04_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Stock Market"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				
				local link = link04
				local actionlist = {}
				local action = {}
				action = {}
				action.name = "refresh_market"
				table.insert(actionlist,action)
				action = {}
				action.name = "wait_for_framework"
				table.insert(actionlist,action)
				action = {}
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_stock_market"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link05:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link05_img"
				imageprop.tweak = "PhotoModeStickers.dcl_016"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link05_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Items Market"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link05
				local actionlist = {}
				local action = {}
				
				action.name = "get_itemlist"
				table.insert(actionlist,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(actionlist,action)
				
				action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "item_category"
				table.insert(actionlist,action)
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link06:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link06_img"
				imageprop.tweak = "PhotoModeStickers.dcl_012"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link06_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "My Account"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link06
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_account"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link07:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link07_img"
				imageprop.tweak = "PhotoModeStickers.dcl_06"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link07_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Changelog"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link07
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_changelog"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				
				
				
				
				linkbar02:RemoveChildByIndex(2)
				linkbar02:RemoveChildByIndex(2)
				linkbar02:RemoveChildByIndex(2)
				
				
				
				
				
				elseif(BrowserCybserscript == "datapack") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Datapack")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				
				
				--logme(2,"button")
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				
				local buttonData = {
					name = StringToName("back"),
					text = "Back",
					value = i,
					tag =  "back",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "home"
				table.insert(buttonData.action,action)
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 100,left= 2800},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(panel, 1)
				
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "fetch_data"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "datapack"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				for k,v in ipairs(arrayDatapack3) do 
					
					
					table.insert(templist,v)
					
				end
				
				if(#arrayDatapack3 > 0) then
					for i = 1,#arrayDatapack3 do
						
						if(#obj < 4) then
							table.insert(obj,arrayDatapack3[i])
							if(arrayDatapack3[i+1] == nil) then
								table.insert(arrayList,obj)
							end
							else
							table.insert(arrayList,obj)
							obj = {}
							table.insert(obj,arrayDatapack3[i])
							if(arrayDatapack3[i+1] == nil) then
								table.insert(arrayList,obj)
							end
						end
						
						
						
						
					end
				end
				
				local scrollComponent = UIScroller.Create("datapack_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, 2)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("datapack__vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("datapack_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						local datapack = arrayList[i][y]
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(datapack.tag.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						
						
						local imageprop = {}
						imageprop.tag = datapack.tag.."_img"
						local random = math.random(1, 11)
						if(random == 37 or random == 25) then
							imageprop.tweak =  ('PhotoModeStickers.crc_%d'):format(random)
							else
							imageprop.tweak =  ('PhotoModeStickers.crc_0%d'):format(random)
						end
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = datapack.tag.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = datapack.name
						if(isDatapackDownloaded(datapack.tag)) then
							
							textprop.text = "(Downloaded) "..datapack.name
							local localversion = CurrentDownloadedVersion(datapack.tag)
							if(localversion~=datapack.version and checkVersionNumber(localversion,datapack.version) == true) then
								
								textprop.text = "(Update) "..datapack.name
								
							end
						end
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "set_selected_keystone_datapack" 
						action.value = datapack.tag
						table.insert(actionlist,action)
						action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScript"
						action.subaddress = "datapack_detail"
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist)
					end
				end
				
				
				
				
				
				elseif(BrowserCybserscript == "mydatapack") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Datapack")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				local buttonData = {
					name = StringToName("back"),
					text = "Back",
					value = i,
					tag =  "back",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "home"
				table.insert(buttonData.action,action)
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 100,left= 2800},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(panel, 1)
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "fetch_data"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "datapack"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				for k,v in pairs(arrayDatapack) do 
					
					if(#obj < 4) then
						table.insert(obj,v.metadata)
						
						table.insert(arrayList,obj)
						
						else
						table.insert(arrayList,obj)
						obj = {}
						table.insert(obj,v.metadata)
						
						table.insert(arrayList,obj)
						
					end
					
					
				end
				
				
				
				local scrollComponent = UIScroller.Create("datapack_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, -1)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("datapack__vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("datapack_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						local datapack = arrayList[i][y]
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(datapack.tag.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						
						
						local imageprop = {}
						imageprop.tag = datapack.tag.."_img"
						local random = math.random(1, 11)
						if(random == 37 or random == 25) then
							imageprop.tweak =  ('PhotoModeStickers.crc_%d'):format(random)
							else
							imageprop.tweak =  ('PhotoModeStickers.crc_0%d'):format(random)
						end
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = datapack.tag.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = datapack.name
						if(isDatapackDownloaded(datapack.tag)) then
							
							textprop.text = "(Downloaded) "..datapack.name
							local localversion = CurrentDownloadedVersion(datapack.tag)
							if(localversion~=datapack.version and checkVersionNumber(localversion,datapack.version) == true) then
								
								textprop.text = "(Update) "..datapack.name
								
							end
						end
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "set_selected_keystone_datapack" 
						action.value = datapack.tag
						table.insert(actionlist,action)
						action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScript"
						action.subaddress = "datapack_detail"
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist)
					end
				end
				
				
				
				
				
				elseif(BrowserCybserscript == "datapack_detail" and Keystone_currentSelectedDatapack ~= nil) then
				
				local datapack = Keystone_currentSelectedDatapack
				panel:RemoveAllChildren()
				
				makeCustomInterface(panel,cyberscript.cache["interfaces"]["keystone_datapack_detail"].data)
				
				
				elseif(BrowserCybserscript == "item_category") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Item Category")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				local buttonData = {
					name = StringToName("back"),
					text = "Back",
					value = i,
					tag =  "back",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "home"
				table.insert(buttonData.action,action)
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 100,left= 2800},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(panel, 1)
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "fetch_data"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(buttonData.action,action)
				
				
				
				
				action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "item_category"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				if(#possiblecategory > 0) then
					for i = 1,#possiblecategory do
						
						if(#obj < 4) then
							table.insert(obj,possiblecategory[i])
							if(possiblecategory[i+1] == nil) then
								table.insert(arrayList,obj)
							end
							else
							table.insert(arrayList,obj)
							obj = {}
							table.insert(obj,possiblecategory[i])
							if(possiblecategory[i+1] == nil) then
								table.insert(arrayList,obj)
							end
						end
						
						
						
						
					end
				end
				
				
				
				
				local scrollComponent = UIScroller.Create("datapack_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, -1)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("datapack__vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("datapack_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						local datapack = arrayList[i][y]
						
						
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(datapack.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						
						
						local imageprop = {}
						imageprop.tag = datapack.."_img"
						local random = math.random(1, 11)
						if(random == 37 or random == 25) then
							imageprop.tweak =  ('PhotoModeStickers.crc_%d'):format(random)
							else
							imageprop.tweak =  ('PhotoModeStickers.crc_0%d'):format(random)
						end
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = datapack.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = datapack
						
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "set_selected_item_category" 
						action.value = datapack
						table.insert(actionlist,action)
						action = {}
						action.name = "set_current_item_page" 
						action.value = 1
						table.insert(actionlist,action)
						action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScript"
						action.subaddress = "keystone_item_market"
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist)
					end
				end
				
				elseif(BrowserCybserscript == "keystone_item_market") then
				
				local interface = cyberscript.cache["interfaces"]["keystone_item_market"].data
				
				local copyinterface = deepcopy(interface, nil)
				
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				if CurrentItemPage == nil then CurrentItemPage = 1 setScore("Item_Market","CurrentItemPage",CurrentItemPage) end
				
				
				
				
				if arrayMarketItem ~= nil  then
					if CurrentItemPage > #arrayMarketItem[Keystone_currentSelectedItemCategory] then CurrentItemPage = 1 setScore("Item_Market","CurrentItemPage",CurrentItemPage)  end
					
					local items = arrayMarketItem[Keystone_currentSelectedItemCategory][CurrentItemPage]
					
					
					
					
					if(#items > 0) then
						for i = 1,#items do
							
							if(#obj < 5) then
								table.insert(obj,items[i])
								if(items[i+1] == nil) then
									table.insert(arrayList,obj)
								end
								else
								table.insert(arrayList,obj)
								obj = {}
								table.insert(obj,items[i])
								if(items[i+1] == nil) then
									table.insert(arrayList,obj)
								end
							end
							
							
							
							
						end
					end
					
					if(#arrayList >0) then
						for i=1,#arrayList do 
							local horizontalarea = deepcopy(GetInterfaceChildren(interface,"horizontal_area_01"), nil)
							horizontalarea.tag = "datapack_horizontal_"..i
							
							table.insert(copyinterface.controls,horizontalarea)
							for y=1,#arrayList[i] do
								local item = arrayList[i][y]
								
								local stock_vertical_item =  deepcopy(GetInterfaceChildren(interface,"stock_vertical_item_01"), nil)
								stock_vertical_item.parent = horizontalarea.tag
								stock_vertical_item.tag = "stock_vertical_item_"..i.."_"..y
								
								local bckg_01 =  deepcopy(GetInterfaceChildren(interface,"bckg_01"), nil)
								bckg_01.parent = stock_vertical_item.tag
								bckg_01.tag = "bckg_"..i.."_"..y
								
								local stock_vertical_item_container =  deepcopy(GetInterfaceChildren(interface,"stock_vertical_item_container_01"), nil)
								stock_vertical_item_container.parent = stock_vertical_item.tag
								stock_vertical_item_container.tag = "stock_vertical_item_container_"..i.."_"..y
								
								local lbl_name =  deepcopy(GetInterfaceChildren(interface,"lbl_name_01"), nil)
								lbl_name.parent = stock_vertical_item_container.tag
								lbl_name.tag = "lbl_name_"..i.."_"..y
								lbl_name.context = nil
								lbl_name.text = item.Title
								
								local lbl_price =  deepcopy(GetInterfaceChildren(interface,"lbl_price_1"), nil)
								lbl_price.parent = stock_vertical_item_container.tag
								lbl_price.tag = "lbl_price_"..i.."_"..y
								lbl_price.context = nil
								lbl_price.text = "Price : "..item.Price
								
								local owned =  deepcopy(GetInterfaceChildren(interface,"owned_01"), nil)
								owned.parent = stock_vertical_item_container.tag
								owned.tag = "owned"..i.."_"..y
								
								local playerItems = getPlayerItemsbyTag(item.Tag)
								
								if playerItems == nil then 
									
									setScore("owned_item",item.Tag,0)
									
									
								end
								
								owned.context[1].prop.text.values.loadingmsg.type = "score"
								owned.context[1].prop.text.values.loadingmsg.variable = "owned_item"
								owned.context[1].prop.text.values.loadingmsg.key = item.Tag
								owned.context[1].prop.text.values.loadingmsg.tag = nil
								
								
								local incart =  deepcopy(GetInterfaceChildren(interface,"incart_01"), nil)
								incart.parent = stock_vertical_item_container.tag
								incart.tag = "incart"..i.."_"..y
								incart.context[1].prop.text.values.loadingmsg.type = "score"
								incart.context[1].prop.text.values.loadingmsg.variable = "Item_MarketCart"
								incart.context[1].prop.text.values.loadingmsg.key = item.Tag
								incart.context[1].prop.text.values.loadingmsg.tag = nil
								
								
								local horizontal_area_btn =  deepcopy(GetInterfaceChildren(interface,"horizontal_area_btn_01"), nil)
								horizontal_area_btn.parent = stock_vertical_item_container.tag
								horizontal_area_btn.tag = "horizontal_area_btn_"..i.."_"..y
								
								local btn_buy =  deepcopy(GetInterfaceChildren(interface,"btn_buy_01"), nil)
								btn_buy.parent = horizontal_area_btn.tag
								btn_buy.tag = "btn_buy_"..i.."_"..y
								btn_buy.context[1].trigger.auto.target = item.Price
								btn_buy.action[1].tag = item.Tag
								
								local btn_sell =  deepcopy(GetInterfaceChildren(interface,"btn_sell_01"), nil)
								btn_sell.parent = horizontal_area_btn.tag
								btn_sell.tag = "btn_sell_"..i.."_"..y
								btn_sell.context[2].trigger.auto.context[1].prop.value.values.loadingmsg.key = item.Tag
								btn_sell.context[3].trigger.auto.context[1].prop.value.values.loadingmsg.key = item.Tag
								btn_sell.action[1].tag = item.Tag
								
								
								table.insert(copyinterface.controls,stock_vertical_item)
								table.insert(copyinterface.controls,bckg_01)
								table.insert(copyinterface.controls,stock_vertical_item_container)
								table.insert(copyinterface.controls,lbl_name)
								table.insert(copyinterface.controls,lbl_price)
								table.insert(copyinterface.controls,owned)
								table.insert(copyinterface.controls,incart)
								table.insert(copyinterface.controls,horizontal_area_btn)
								table.insert(copyinterface.controls,btn_buy)
								table.insert(copyinterface.controls,btn_sell)
								
								
								
							end
						end
						panel:RemoveAllChildren()
						--	logme(10,JSON:encode_pretty(copyinterface))
						makeCustomInterface(panel,copyinterface)
					end
					
					
				end
				elseif(BrowserCybserscript ~= "loading" and BrowserCybserscript ~= "home" and BrowserCybserscript ~= "datapack" and BrowserCybserscript ~= "mydatapack" and BrowserCybserscript ~= "datapack_detail" and BrowserCybserscript ~= "stock_market" and BrowserCybserscript ~= "item_category" and BrowserCybserscript ~= "item_market") then
				
				--------print(BrowserCybserscript)
				panel:RemoveAllChildren()
				
				makeCustomInterface(panel,cyberscript.cache["interfaces"][BrowserCybserscript].data)
				
				
				
				
				
			end
		end
		if(CurrentAddress == "CyberScriptWeb") then
			if(BrowserCybserscript == nil) then BrowserCybserscript = "home" end
			if(BrowserCybserscript == "home") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Web")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				
				
				--logme(2,"button")
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				
				
				
				
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				for k,wpage in pairs(cyberscript.cache["webpage"]) do 
					
					if(checkTriggerRequirement(wpage.data.requirement,wpage.data.trigger))then
						table.insert(templist,wpage)
					end
				end
				
				
				for i,wpage in ipairs(templist) do 
					
					
					if(#obj < 4) then
						
						
						table.insert(obj,wpage)
						
						if(templist[i+1] == nil) then
							table.insert(arrayList,obj)
						end
						
						
						else
						
						table.insert(arrayList,obj)
						
						
						obj = {}
						table.insert(obj,wpage)
						
						if(templist[i+1] == nil) then
							table.insert(arrayList,obj)
						end
						
					end
					
					
				end
				
				
				
				local scrollComponent = UIScroller.Create("webpage_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, 2)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("webpage_vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("webpage_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						
						local webpage = arrayList[i][y].data
						--------print(dump(webpage))
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(webpage.tag.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						local customimage = false
						
						local imageprop = {}
						imageprop.tag = webpage.tag.."_img"
						
						if(webpage.tweak ~= nil and webpage.texture ~= nil and webpage.tweak ~= "" and webpage.texture ~= "") then
							
							imageprop.tweak = webpage.tweak
							imageprop.texture = webpage.texture
							customimage = true
							else
							
							imageprop.tweak = ('PhotoModeStickers.dcl_016')
						end
						
						
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = webpage.tag.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = webpage.name
						
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScriptWeb"
						action.subaddress = webpage.target
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist,customimage)
					end
				end
				
				
				
				else
				
				panel:RemoveAllChildren()
				
				makeCustomInterface(panel,cyberscript.cache["interfaces"][BrowserCybserscript].data)
				
				
			end
		end
		
		
	end
	if(CurrentAddress == "NETdir://ezestates.web/for_rent") then --place and housing
		
		
		local root = self:GetRootWidget()
		
		pcall(function()
			printChild(root)
		end)
		
		
		
		LinkController = inkWidgetRef.GetController(self.textList[1])
		local root = self.textList[1].widget.parentWidget.parentWidget
		logme(2,"obs6")
		
		root:SetVisible(true)
		local texts = page:GetTexts()
		logme(2,"obs6")
		local buttonData = {
			name = StringToName("testButton"),
			text = "CyberScript Estates",
			value = 1,
			tag =  "testButton"
		}
		local fontsize = uifont
		local black = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local yellow = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		local buttonComponent = UIButton.Create(buttonData.name, buttonData.text,50, self.textList[1].widget.parentWidget:GetSize().X,  self.textList[1].widget.parentWidget:GetSize().Y,{top=600,left=475},yellow,black)
		buttonComponent:Reparent(root, -1)
		buttonComponent:RegisterCallback('OnRelease', function(button, evt)
			if(self.textList ~= nil) then
				local linkController = LinkController
				if linkController ~= nil then
					linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
					self.lastClickedLinkAddress = linkController:GetLinkAddress()
					self:CallCustomCallback("OnLinkPressed")
					CurrentAddress = "NETdir://ezestates.web/makeovers"
					BrowserCustomPlace = "main"
					else 
					logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
				end
			end  
			evt:Handle()
		end)
		local root2 = self.imageList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget
		
		root2:SetVisible(true)
		local nightcity01 = self.textList[11].widget
		nightcity01:SetVisible(false)
		local nightcity02 = self.textList[11].widget.parentWidget
		nightcity02:SetVisible(false)
	end
	if(CurrentAddress == "NETdir://ezestates.web/makeovers" and BrowserCustomPlace ~= nil) then
		LinkController = inkWidgetRef.GetController(self.textList[1])
		local root = self.textList[1].widget.parentWidget.parentWidget
		logme(2,tostring(GameDump(root)))
		local texts = page:GetTexts()
		logme(2,"obs6")
		local buttonData = {
			name = StringToName("testButton"),
			text = "CyberScript Estates",
			value = 1,
			tag =  "testButton"
		}
		local fontsize = uifont
		local black = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local yellow = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		local buttonComponent = UIButton.Create(buttonData.name, buttonData.text,50, self.textList[1].widget.parentWidget:GetSize().X,  self.textList[1].widget.parentWidget:GetSize().Y,{top=600,left=475},yellow,black)
		buttonComponent:Reparent(root, -1)
		buttonComponent:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				self:CallCustomCallback("OnLinkPressed")
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "main"
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		local anquestion = self.textList[15].widget.parentWidget
		local anquestion_margin = anquestion:GetMargin()
		anquestion_margin.top = anquestion_margin.top+250
		anquestion:SetMargin(anquestion_margin)
		local anquestion_height = anquestion:GetHeight()
		anquestion_height = anquestion_height-150
		anquestion:SetHeight(anquestion_height)
		local texts = page:GetTexts()
		local textcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local bgcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		self.textList[2].widget:SetTintColor(bgcolor)
		self.textList[2].widget.parentWidget:SetTintColor(bgcolor)
		self.imageList[2].widget:SetTintColor(textcolor)
		local itemcontainer = self.textList[3].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[5].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[6].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[7].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[8].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local anquestionPics = self.textList[15].widget
		anquestionPics:SetText("An Bug ? An Suggestions ?")
		anquestionPics:SetFontSize(35)
		local contactUs = self.textList[16].widget
		contactUs:SetText("Go to CyberScript Discord for Help !")
		contactUs:SetFontSize(35)
	end
	if(CurrentAddress == "NETdir://ezestates.web/makeovers" and BrowserCustomPlace == "main") then
		------print("YOHOHOHO")
		local texts = page:GetTexts()
		logme(2,"obs6")
		local fontsize = uifont
		local black = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local yellow = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		local textList = #self.textList
		local root2 = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
		local heigh = 100
		local width = 2800
		local fontsize = uifont
		local black = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local yellow = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		local leftm = 500
		local btn_house = UIButton.Create("btn_house", "Our Houses",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_house:Reparent(root2, 0)
		btn_house:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "house"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[3])) + "]")
			end
			evt:Handle()
		end)
		local btn_bar = UIButton.Create("btn_bar", "Our bars",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_bar:Reparent(root2, 0)
		btn_bar:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "bar"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		local btn_nightclub = UIButton.Create("btn_nightclub", "Our nightclubs",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_nightclub:Reparent(root2, 1)
		btn_nightclub:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "nightclub"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		local btn_shops = UIButton.Create("btn_shops", "Our Shops",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_shops:Reparent(root2, 2)
		btn_shops:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "shopping"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		local btn_restaurant = UIButton.Create("btn_restaurant", "Our restaurants",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_restaurant:Reparent(root2, 3)
		btn_restaurant:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "restaurant"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		
		
		
		if(currentHouse ~= nil) then
			local housestatut = getVariableKey(currentHouse.tag,"Statut")
			if(housestatut ~= nil and housestatut > 0) then
				
				local btn_template = UIButton.Create("btn_template", "Our Renovations",50, width, heigh ,{top=150,left=leftm},black,yellow)
				btn_template:Reparent(root2, 4)
				btn_template:RegisterCallback('OnRelease', function(button, evt)
					local linkController = LinkController
					if linkController ~= nil then
						linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
						self.lastClickedLinkAddress = linkController:GetLinkAddress()
						CurrentAddress = "NETdir://ezestates.web/makeovers"
						BrowserCustomPlace = "template"
						self:CallCustomCallback("OnLinkPressed")
						else 
						logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
					end
					evt:Handle()
				end)
				
				if(currentHouse.step ~= nil and #currentHouse.step > 0) then
					local housesttep = getVariableKeyWithDefault(currentHouse.tag,"step",0)
					
					
					
					local btn_upgrade = UIButton.Create("btn_upgrade", "Upgrade your home !",50, width, heigh ,{top=150,left=leftm},black,yellow)
					btn_upgrade:Reparent(root2, 5)
					btn_upgrade:RegisterCallback('OnRelease', function(button, evt)
						local linkController = LinkController
						if linkController ~= nil then
							linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
							self.lastClickedLinkAddress = linkController:GetLinkAddress()
							CurrentAddress = "NETdir://ezestates.web/makeovers"
							BrowserCustomPlace = "upgrade"
							self:CallCustomCallback("OnLinkPressed")
							else 
							logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
						end
						evt:Handle()
					end)
					
				end
				
			end
		end
		
	end
	
	
	if(CurrentAddress == "NETdir://ezestates.web/makeovers" and BrowserCustomPlace ~= "main") then
		-- local textList = #self.textList
		-- logme(2,"textList "..textList)
		--Hide current Items
		------print("YAHAHAHA")
		if (BrowserCustomPlace == "house" or BrowserCustomPlace == "bar" or BrowserCustomPlace == "nightclub" or BrowserCustomPlace == "restaurant" or BrowserCustomPlace == "shopping") then
			local textink = self.textList[4].widget
			local textcontainer = self.textList[4].widget.parentWidget
			local buttonink = self.textList[4].widget.parentWidget.parentWidget
			local itemcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget
			local rowcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget
			local verticalarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
			local scrollarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
			local tempcount = 0
			local temparrayHouse = {}
			local obj = {}
			local templist = {}
			local housetype = 0
			if(BrowserCustomPlace == "house") then
				housetype = 0
			end
			if(BrowserCustomPlace == "bar") then
				housetype = 1
			end
			if(BrowserCustomPlace == "nightclub") then
				housetype = 2
			end
			if(BrowserCustomPlace == "restaurant") then
				housetype = 3
			end
			if(BrowserCustomPlace == "shopping") then
				housetype = 4
			end
			for k,v in pairs(cyberscript.cache["place"]) do 
				if(v.data.type == housetype) then
					table.insert(templist,v.data)
				end
			end
			logme(10,"House count :"..#templist)
			if(#templist > 0) then
				for i = 1,#templist do
					
					
					if(#obj < 2) then
						table.insert(obj,templist[i])
						if(templist[i+1] == nil) then
							table.insert(temparrayHouse,obj)
						end
						else
						table.insert(temparrayHouse,obj)
						obj = {}
						table.insert(obj,templist[i])
						if(templist[i+1] == nil) then
							table.insert(temparrayHouse,obj)
						end
					end
					
					
					
					
				end
			end
			logme(10,"House count :"..#temparrayHouse)
			local marginleft = 50
			local topleft = 0
			for i=1,#temparrayHouse do 
				local rowcontainerhouse = inkHorizontalPanelWidget.new()
				rowcontainerhouse:SetName(CName.new("rowcontainer_house_"..i))
				rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
				rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
				rowcontainerhouse:Reparent(verticalarea)
				-- local rowcontainerhouse = inkCanvasWidget.new()
				-- rowcontainerhouse:SetName(CName.new("rowcontainer_house_"..i))
				-- rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
				-- rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
				-- rowcontainerhouse:SetMargin(inkMargin.new({ bottom = 50 }))
				-- rowcontainerhouse:Reparent(verticalarea)
				for y=1,#temparrayHouse[i] do
					local house = temparrayHouse[i][y]
					local score = getHouseStatut(house.tag)
					
					local canvas = inkCanvasWidget.new()
					canvas:SetName(CName.new("canvas_house_"..house.tag))
					canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
					canvas:SetMargin(inkMargin.new({ bottom = 50 }))
					canvas:Reparent(rowcontainerhouse)
					local bg = inkImage.new()
					bg:SetName(CName.new("bg_house_"..house.tag))
					bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					bg:SetTexturePart('cell_bg')
					bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
					bg:SetOpacity(0.8)
					bg:SetAnchor(inkEAnchor.Fill)
					bg.useNineSliceScale = true
					bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					bg:SetInteractive(false)
					bg:Reparent(canvas, -1)
					local fill = inkImage.new()
					fill:SetName("fill_house_"..house.tag)
					fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					fill:SetTexturePart('cell_bg')
					fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
					fill:SetOpacity(0.0)
					fill:SetAnchor(inkEAnchor.Fill)
					fill.useNineSliceScale = true
					fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					fill:SetInteractive(false)
					fill:Reparent(canvas, -1)
					local frame = inkImage.new()
					frame:SetName("frame_house_"..house.tag)
					frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					frame:SetTexturePart('cell_fg')
					frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
					frame:SetOpacity(0.3)
					frame:SetAnchor(inkEAnchor.Fill)
					frame.useNineSliceScale = true
					frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					frame:SetInteractive(false)
					frame:Reparent(canvas, -1)
					local textinkhousename = inkText.new()
					textinkhousename:SetName(CName.new("text_house_"..house.tag.."_Name"))
					if (score == nil or score == 0) then
						textinkhousename:SetText("Name : "..house.name)
						else
						textinkhousename:SetText("(Owned) Name : "..house.name)
						textinkhousename:SetTintColor(gamecolor(0,255,0,1))
					end
					textinkhousename:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textinkhousename:SetFontStyle('Medium')
					textinkhousename:SetFontSize(35)
					textinkhousename:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
					textinkhousename:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textinkhousename:SetVerticalAlignment(textVerticalAlignment.Center)
					textinkhousename:SetMargin(inkMargin.new({ left = 50, top = 0 }))
					textinkhousename:Reparent(canvas,-1)
					local textinkhouseprice = inkText.new()
					textinkhouseprice:SetName(CName.new("text_house_"..house.tag.."_price"))
					textinkhouseprice:SetText("Price : "..house.price.." €$")
					textinkhouseprice:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textinkhouseprice:SetFontStyle('Medium')
					textinkhouseprice:SetFontSize(35)
					textinkhouseprice:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
					textinkhouseprice:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textinkhouseprice:SetVerticalAlignment(textVerticalAlignment.Center)
					textinkhouseprice:SetMargin(inkMargin.new({ left = 50, top = 50 }))
					textinkhouseprice:Reparent(canvas,-1)
					local textinkhousedesc = inkText.new()
					textinkhousedesc:SetName(CName.new("text_house_"..house.tag.."_desc"))
					if(house.desc == nil) then
						textinkhousedesc:SetText("No description about thos place. Come back later !")
						else
						local splitContentRequ = splitByChunk(house.desc,50)
						local result = splitContentRequ
						textinkhousedesc:SetText(result)
					end
					textinkhousedesc:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textinkhousedesc:SetFontStyle('Medium')
					textinkhousedesc:SetFontSize(35)
					textinkhousedesc:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
					textinkhousedesc:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textinkhousedesc:SetVerticalAlignment(textVerticalAlignment.Center)
					textinkhousedesc:SetMargin(inkMargin.new({ left = 50, top = 100 }))
					textinkhousedesc:Reparent(canvas,-1)
					if (house.isbuyable == true) then
						if ((score == nil or score == 0)) then
							local buttonData = {
								name = "text_house_"..house.tag.."_buy",
								text = "Buy",
								value = 1,
								tag =  "text_house_"..house.tag.."_buy"
							}
							local fontsize = uifont
							local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
							local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
							local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
							buy_btn:Reparent(canvas, -1)
							buy_btn:RegisterCallback('OnRelease', function(button, evt)
								local onenter_action = {}
								local action = {}
								action.name = "buyHouse"
								action.tag = house.tag
								table.insert(onenter_action,action)
								local action = {}
								action.name = "notify"
								action.value = "Place Buyed !"
								table.insert(onenter_action,action)
								local action = {}
								action.name = "set_mappin"
								action.position = "custom_place"
								action.position_tag = house.tag
								action.position_house_way = "default"
								action.tag =  house.tag
								action.typemap = "Zzz05_ApartmentToPurchaseVariant"
								action.wall =  true
								action.active =  false
								action.x = 0
								action.y = 0
								action.z = 0
								table.insert(onenter_action,action)
								runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
								local linkController = LinkController
								if linkController ~= nil then
									linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
									self.lastClickedLinkAddress = linkController:GetLinkAddress()
									CurrentAddress = "NETdir://ezestates.web/for_rent"
									BrowserCustomPlace = nil
									self:CallCustomCallback("OnLinkPressed")
									else 
									logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
								end
								evt:Handle()
							end)
							else
							local buttonData = {
								name = "text_house_"..house.tag.."_sell",
								text = "Sell",
								value = 1,
								tag =  "text_house_"..house.tag.."_sell"
							}
							local fontsize = uifont
							local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
							local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 16, Blue = 16, Alpha = 1.0 }))
							local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
							buy_btn:Reparent(canvas, -1)
							buy_btn:RegisterCallback('OnRelease', function(button, evt)
								local onenter_action = {}
								local action = {}
								action.name = "sellHouse"
								action.tag = house.tag
								table.insert(onenter_action,action)
								local action = {}
								action.name = "notify"
								action.value = "Place Selled !"
								table.insert(onenter_action,action)
								
								runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
								local linkController = LinkController
								if linkController ~= nil then
									linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
									self.lastClickedLinkAddress = linkController:GetLinkAddress()
									CurrentAddress = "NETdir://ezestates.web/for_rent"
									BrowserCustomPlace = nil
									self:CallCustomCallback("OnLinkPressed")
									else 
									logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
								end
								evt:Handle()
							end)
						end
					end
				end
			end
			
			
		end
		if(BrowserCustomPlace == "template") then
			if(currentHouse ~= nil) then
				
				local textink = self.textList[4].widget
				local textcontainer = self.textList[4].widget.parentWidget
				local buttonink = self.textList[4].widget.parentWidget.parentWidget
				local itemcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget
				local rowcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget
				local verticalarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
				local scrollarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
				local tempcount = 0
				local temparrayHouse = {}
				local obj = {}
				local templist = {}
				
				local marginleft = 50
				local topleft = 0
				
				for k,v in pairs(cyberscript.cache["housing_template"]) do 
					
					if(v.data.target == currentHouse.tag) then
						table.insert(templist,v.data)
					end
				end
				
				if(#templist > 0) then
					for i = 1,#templist do
						
						if(#obj < 2) then
							table.insert(obj,templist[i])
							if(templist[i+1] == nil) then
								table.insert(temparrayHouse,obj)
							end
							else
							table.insert(temparrayHouse,obj)
							obj = {}
							table.insert(obj,templist[i])
							if(templist[i+1] == nil) then
								table.insert(temparrayHouse,obj)
							end
						end
						
						
						
						
					end
				end
				
				logme(10,dump(temparrayHouse))
				
				for i=1,#temparrayHouse do 
					local rowcontainerhouse = inkHorizontalPanelWidget.new()
					rowcontainerhouse:SetName(CName.new("rowcontainer_house_"..i))
					rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
					rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					rowcontainerhouse:Reparent(verticalarea)
					
					for y=1,#temparrayHouse[i] do
						local template = temparrayHouse[i][y]
						local currenttemplate = getVariableKey(currentHouse.tag,"current_template")
						
						local canvas = inkCanvasWidget.new()
						canvas:SetName(CName.new("canvas_house_"..template.tag))
						canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
						canvas:SetMargin(inkMargin.new({ bottom = 50 }))
						canvas:Reparent(rowcontainerhouse)
						local bg = inkImage.new()
						bg:SetName(CName.new("bg_house_"..template.tag))
						bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
						bg:SetTexturePart('cell_bg')
						bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
						bg:SetOpacity(0.8)
						bg:SetAnchor(inkEAnchor.Fill)
						bg.useNineSliceScale = true
						bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
						bg:SetInteractive(false)
						bg:Reparent(canvas, -1)
						local fill = inkImage.new()
						fill:SetName("fill_house_"..template.tag)
						fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
						fill:SetTexturePart('cell_bg')
						fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
						fill:SetOpacity(0.0)
						fill:SetAnchor(inkEAnchor.Fill)
						fill.useNineSliceScale = true
						fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
						fill:SetInteractive(false)
						fill:Reparent(canvas, -1)
						local frame = inkImage.new()
						frame:SetName("frame_house_"..template.tag)
						frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
						frame:SetTexturePart('cell_fg')
						frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
						frame:SetOpacity(0.3)
						frame:SetAnchor(inkEAnchor.Fill)
						frame.useNineSliceScale = true
						frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
						frame:SetInteractive(false)
						frame:Reparent(canvas, -1)
						local textinkhousename = inkText.new()
						textinkhousename:SetName(CName.new("text_house_"..template.tag.."_Name"))
						
						if(currenttemplate ~= nil and currenttemplate == template.tag) then
							textinkhousename:SetText("(Applied) Name : "..template.name)
							textinkhousename:SetTintColor(gamecolor(0,255,0,1))
							else
							textinkhousename:SetText("Name : "..template.name)
							textinkhousename:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
						end
						
						textinkhousename:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						textinkhousename:SetFontStyle('Medium')
						textinkhousename:SetFontSize(35)
						
						textinkhousename:SetHorizontalAlignment(textHorizontalAlignment.Center)
						textinkhousename:SetVerticalAlignment(textVerticalAlignment.Center)
						textinkhousename:SetMargin(inkMargin.new({ left = 50, top = 0 }))
						textinkhousename:Reparent(canvas,-1)
						local textinkhouseprice = inkText.new()
						textinkhouseprice:SetName(CName.new("text_house_"..template.tag.."_price"))
						textinkhouseprice:SetText("Price : "..template.price.." €$")
						textinkhouseprice:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						textinkhouseprice:SetFontStyle('Medium')
						textinkhouseprice:SetFontSize(35)
						textinkhouseprice:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
						textinkhouseprice:SetHorizontalAlignment(textHorizontalAlignment.Center)
						textinkhouseprice:SetVerticalAlignment(textVerticalAlignment.Center)
						textinkhouseprice:SetMargin(inkMargin.new({ left = 50, top = 50 }))
						textinkhouseprice:Reparent(canvas,-1)
						local textinkhousedesc = inkText.new()
						textinkhousedesc:SetName(CName.new("text_house_"..template.tag.."_desc"))
						if(template.desc == nil) then
							textinkhousedesc:SetText("No description about thos place. Come back later !")
							else
							local splitContentRequ = splitByChunk(template.desc,50)
							local result = splitContentRequ
							
							textinkhousedesc:SetText(result)
						end
						textinkhousedesc:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						textinkhousedesc:SetFontStyle('Medium')
						textinkhousedesc:SetFontSize(35)
						textinkhousedesc:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
						textinkhousedesc:SetHorizontalAlignment(textHorizontalAlignment.Center)
						textinkhousedesc:SetVerticalAlignment(textVerticalAlignment.Center)
						textinkhousedesc:SetMargin(inkMargin.new({ left = 50, top = 100 }))
						textinkhousedesc:Reparent(canvas,-1)
						local buttonData = {
							name = "text_house_"..template.tag.."_buy",
							text = "Buy",
							value = 1,
							tag =  "text_house_"..template.tag.."_buy"
						}
						local fontsize = uifont
						local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
						local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
						local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
						buy_btn:Reparent(canvas, -1)
						buy_btn:RegisterCallback('OnRelease', function(button, evt)
							local onenter_action = {}
							local action = {}
							action.name = "remove_money"
							action.value = template.price
							table.insert(onenter_action,action)
							local action = {}
							action.name = "notify"
							action.value = "Renovation Buyed !"
							table.insert(onenter_action,action)
							local action = {}
							action.name = "current_place_clear_all_template"
							table.insert(onenter_action,action)
							local action = {}
							action.name = "set_variable"
							action.variable = currentHouse.tag
							action.key = "current_template"
							action.value = template.tag
							table.insert(onenter_action,action)
							local action = {}
							action.name = "current_place_apply_template"
							action.tag = template.tag
							action.x = 0
							action.y = 0
							action.z = 0
							table.insert(onenter_action,action)
							runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
							local linkController = LinkController
							if linkController ~= nil then
								linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
								self.lastClickedLinkAddress = linkController:GetLinkAddress()
								CurrentAddress = "NETdir://ezestates.web/for_rent"
								BrowserCustomPlace = nil
								self:CallCustomCallback("OnLinkPressed")
								else 
								logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
							end
							evt:Handle()
						end)
						
					end
				end
				
				local rowcontainerhouse = inkHorizontalPanelWidget.new()
				rowcontainerhouse:SetName(CName.new("rowcontainer_house_clear"))
				rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
				rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
				rowcontainerhouse:Reparent(verticalarea)
				
				local canvas = inkCanvasWidget.new()
				canvas:SetName(CName.new("canvas_house_clear"))
				canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
				canvas:SetMargin(inkMargin.new({ bottom = 50 }))
				canvas:Reparent(rowcontainerhouse)
				local bg = inkImage.new()
				bg:SetName(CName.new("bg_house_clear"))
				bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
				bg:SetTexturePart('cell_bg')
				bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
				bg:SetOpacity(0.8)
				bg:SetAnchor(inkEAnchor.Fill)
				bg.useNineSliceScale = true
				bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
				bg:SetInteractive(false)
				bg:Reparent(canvas, -1)
				local fill = inkImage.new()
				fill:SetName("fill_house_clear")
				fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
				fill:SetTexturePart('cell_bg')
				fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				fill:SetOpacity(0.0)
				fill:SetAnchor(inkEAnchor.Fill)
				fill.useNineSliceScale = true
				fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
				fill:SetInteractive(false)
				fill:Reparent(canvas, -1)
				local frame = inkImage.new()
				frame:SetName("frame_house_clear")
				frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
				frame:SetTexturePart('cell_fg')
				frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
				frame:SetOpacity(0.3)
				frame:SetAnchor(inkEAnchor.Fill)
				frame.useNineSliceScale = true
				frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
				frame:SetInteractive(false)
				frame:Reparent(canvas, -1)
				local textinkhousename = inkText.new()
				textinkhousename:SetName(CName.new("text_house_clear_Name"))
				textinkhousename:SetText("Clear current renovations")
				textinkhousename:SetTintColor(gamecolor(255,0,0,1))
				textinkhousename:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
				textinkhousename:SetFontStyle('Medium')
				textinkhousename:SetFontSize(35)
				
				textinkhousename:SetHorizontalAlignment(textHorizontalAlignment.Center)
				textinkhousename:SetVerticalAlignment(textVerticalAlignment.Center)
				textinkhousename:SetMargin(inkMargin.new({ left = 50, top = 0 }))
				textinkhousename:Reparent(canvas,-1)
				local textinkhouseprice = inkText.new()
				textinkhouseprice:SetName(CName.new("text_house_clear_price"))
				textinkhouseprice:SetText("Price : 500 €$")
				textinkhouseprice:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
				textinkhouseprice:SetFontStyle('Medium')
				textinkhouseprice:SetFontSize(35)
				textinkhouseprice:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
				textinkhouseprice:SetHorizontalAlignment(textHorizontalAlignment.Center)
				textinkhouseprice:SetVerticalAlignment(textVerticalAlignment.Center)
				textinkhouseprice:SetMargin(inkMargin.new({ left = 50, top = 50 }))
				textinkhouseprice:Reparent(canvas,-1)
				local textinkhousedesc = inkText.new()
				textinkhousedesc:SetName(CName.new("text_house_clear_desc"))
				textinkhousedesc:SetText("It will clear the current renovation.")
				
				textinkhousedesc:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
				textinkhousedesc:SetFontStyle('Medium')
				textinkhousedesc:SetFontSize(35)
				textinkhousedesc:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
				textinkhousedesc:SetHorizontalAlignment(textHorizontalAlignment.Center)
				textinkhousedesc:SetVerticalAlignment(textVerticalAlignment.Center)
				textinkhousedesc:SetMargin(inkMargin.new({ left = 50, top = 100 }))
				textinkhousedesc:Reparent(canvas,-1)
				local buttonData = {
					name = "text_house_clear_buy",
					text = "Buy",
					value = 1,
					tag =  "text_house_clear_buy"
				}
				local fontsize = uifont
				local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
				local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
				local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
				buy_btn:Reparent(canvas, -1)
				buy_btn:RegisterCallback('OnRelease', function(button, evt)
					local onenter_action = {}
					local action = {}
					action.name = "remove_money"
					action.value = 500
					table.insert(onenter_action,action)
					local action = {}
					action.name = "notify"
					action.value = "Renovation Cleared !"
					table.insert(onenter_action,action)
					local action = {}
					action.name = "current_place_clear_all_template"
					table.insert(onenter_action,action)
					local action = {}
					action.name = "set_variable"
					action.variable = currentHouse.tag
					action.key = "current_template"
					action.value = ""
					table.insert(onenter_action,action)
					
					runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
					local linkController = LinkController
					if linkController ~= nil then
						linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
						self.lastClickedLinkAddress = linkController:GetLinkAddress()
						CurrentAddress = "NETdir://ezestates.web/for_rent"
						BrowserCustomPlace = nil
						self:CallCustomCallback("OnLinkPressed")
						else 
						logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
					end
					evt:Handle()
				end)
				
			end
			
			
		end
		
		
		if(BrowserCustomPlace == "upgrade") then
			if(currentHouse ~= nil) then
				
				local textink = self.textList[4].widget
				local textcontainer = self.textList[4].widget.parentWidget
				local buttonink = self.textList[4].widget.parentWidget.parentWidget
				local itemcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget
				local rowcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget
				local verticalarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
				local scrollarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
				local tempcount = 0
				local temparrayHouse = {}
				local obj = {}
				local templist = {}
				
				local marginleft = 50
				local topleft = 0
				
				
				local housesttep = getVariableKeyWithDefault(currentHouse.tag,"step",0)
				
				if (housesttep > 0) then
					
					local currentstep = currentHouse.step[housesttep]
					
					local rowcontainerhouse = inkHorizontalPanelWidget.new()
					rowcontainerhouse:SetName(CName.new("rowcontainer_house_clear"))
					rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
					rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					rowcontainerhouse:Reparent(verticalarea)
					
					local canvas = inkCanvasWidget.new()
					canvas:SetName(CName.new("canvas_house_clear"))
					canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
					canvas:SetMargin(inkMargin.new({ bottom = 50 }))
					canvas:Reparent(rowcontainerhouse)
					local bg = inkImage.new()
					bg:SetName(CName.new("bg_house_clear"))
					bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					bg:SetTexturePart('cell_bg')
					bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
					bg:SetOpacity(0.8)
					bg:SetAnchor(inkEAnchor.Fill)
					bg.useNineSliceScale = true
					bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					bg:SetInteractive(false)
					bg:Reparent(canvas, -1)
					local fill = inkImage.new()
					fill:SetName("fill_house_clear")
					fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					fill:SetTexturePart('cell_bg')
					fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
					fill:SetOpacity(0.0)
					fill:SetAnchor(inkEAnchor.Fill)
					fill.useNineSliceScale = true
					fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					fill:SetInteractive(false)
					fill:Reparent(canvas, -1)
					local frame = inkImage.new()
					frame:SetName("frame_house_clear")
					frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					frame:SetTexturePart('cell_fg')
					frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
					frame:SetOpacity(0.3)
					frame:SetAnchor(inkEAnchor.Fill)
					frame.useNineSliceScale = true
					frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					frame:SetInteractive(false)
					frame:Reparent(canvas, -1)
					
					
					
					local textc01 = inkText.new()
					textc01:SetName(CName.new("text_house_clear_title"))
					textc01:SetText("Current Upgrade : "..currentstep.title)
					textc01:SetTintColor(gamecolor(255,0,0,1))
					textc01:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textc01:SetFontStyle('Medium')
					textc01:SetFontSize(45)
					
					
					
					
					textc01:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textc01:SetVerticalAlignment(textVerticalAlignment.Center)
					textc01:SetMargin(inkMargin.new({ left = 50, top = 0 }))
					textc01:Reparent(canvas,-1)
					
					local textc02 = inkText.new()
					textc02:SetName(CName.new("text_house_clear_desc"))
					textc02:SetText(splitByChunk(currentstep.desc,50))
					
					textc02:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textc02:SetFontStyle('Medium')
					textc02:SetFontSize(35)
					textc02:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
					textc02:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textc02:SetVerticalAlignment(textVerticalAlignment.Center)
					textc02:SetMargin(inkMargin.new({ left = 50, top = 100 }))
					textc02:Reparent(canvas,-1)
					
					local fontsize = uifont
					local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
					local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
					
				end
				
				local nextstep = currentHouse.step[housesttep+1]
				if(nextstep ~= nil) then
					
					local rowcontainerhouse = inkHorizontalPanelWidget.new()
					rowcontainerhouse:SetName(CName.new("rowcontainer_house_newstep"))
					rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
					rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					rowcontainerhouse:Reparent(verticalarea)
					
					local canvas = inkCanvasWidget.new()
					canvas:SetName(CName.new("canvas_house_newstep"))
					canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
					canvas:SetMargin(inkMargin.new({ bottom = 50 }))
					canvas:Reparent(rowcontainerhouse)
					local bg = inkImage.new()
					bg:SetName(CName.new("bg_house_new"))
					bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					bg:SetTexturePart('cell_bg')
					bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
					bg:SetOpacity(0.8)
					bg:SetAnchor(inkEAnchor.Fill)
					bg.useNineSliceScale = true
					bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					bg:SetInteractive(false)
					bg:Reparent(canvas, -1)
					local fill = inkImage.new()
					fill:SetName("fill_house_new")
					fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					fill:SetTexturePart('cell_bg')
					fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
					fill:SetOpacity(0.0)
					fill:SetAnchor(inkEAnchor.Fill)
					fill.useNineSliceScale = true
					fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					fill:SetInteractive(false)
					fill:Reparent(canvas, -1)
					local frame = inkImage.new()
					frame:SetName("frame_house_new")
					frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					frame:SetTexturePart('cell_fg')
					frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
					frame:SetOpacity(0.3)
					frame:SetAnchor(inkEAnchor.Fill)
					frame.useNineSliceScale = true
					frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					frame:SetInteractive(false)
					frame:Reparent(canvas, -1)
					
					
					local text01 = inkText.new()
					text01:SetName(CName.new("text_house_new_Name"))
					text01:SetText(nextstep.title)
					
					text01:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					text01:SetFontStyle('Medium')
					text01:SetFontSize(45)
					
					text01:SetHorizontalAlignment(textHorizontalAlignment.Center)
					text01:SetVerticalAlignment(textVerticalAlignment.Center)
					text01:SetMargin(inkMargin.new({ left = 50, top = 0 }))
					text01:SetTintColor(gamecolor(255,169,0,1))
					text01:Reparent(canvas,-1)
					
					
					
					local text02 = inkText.new()
					text02:SetName(CName.new("text_house_new_price"))
					text02:SetText("Price : "..nextstep.price.."€$")
					text02:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					text02:SetFontStyle('Medium')
					text02:SetFontSize(35)
					text02:SetTintColor(gamecolor(255,255,255,1))
					text02:SetHorizontalAlignment(textHorizontalAlignment.Center)
					text02:SetVerticalAlignment(textVerticalAlignment.Center)
					text02:SetMargin(inkMargin.new({ left = 50, top = 100 }))
					text02:Reparent(canvas,-1)
					
					
					
					local text03 = inkText.new()
					text03:SetName(CName.new("text_house_new_desc"))
					text03:SetText(splitByChunk(nextstep.desc,50))
					
					text03:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					text03:SetFontStyle('Medium')
					text03:SetFontSize(35)
					text03:SetTintColor(gamecolor(255,255,255,1))
					text03:SetHorizontalAlignment(textHorizontalAlignment.Center)
					text03:SetVerticalAlignment(textVerticalAlignment.Center)
					text03:SetMargin(inkMargin.new({ left = 50, top = 150 }))
					text03:Reparent(canvas,-1)
					
					
					
					
					local buttonData = {
						name = "text_house_new_buy",
						text = "Upgrade !",
						value = 1,
						tag =  "text_house_new_buy"
					}
					local fontsize = uifont
					local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
					local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
					local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
					buy_btn:Reparent(canvas, -1)
					buy_btn:RegisterCallback('OnRelease', function(button, evt)
						local onenter_action = {}
						local action = {}
						action.name = "remove_money"
						action.value = nextstep.price
						table.insert(onenter_action,action)
						local action = {}
						action.name = "notify"
						action.value = "Upgrade installed !"
						table.insert(onenter_action,action)
						local action = {}
						action.name = "current_place_clear_all_template"
						table.insert(onenter_action,action)
						local action = {}
						action.name = "set_variable"
						action.variable = currentHouse.tag
						action.key = "step"
						action.value = housesttep+1
						table.insert(onenter_action,action)
						local action = {}
						action.name = "current_place_apply_template"
						action.tag = nextstep.template
						action.x = nextstep.anchor.x
						action.y = nextstep.anchor.y
						action.z = nextstep.anchor.z
						table.insert(onenter_action,action)
						
						runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
						local linkController = LinkController
						if linkController ~= nil then
							linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
							self.lastClickedLinkAddress = linkController:GetLinkAddress()
							CurrentAddress = "NETdir://ezestates.web/for_rent"
							BrowserCustomPlace = nil
							self:CallCustomCallback("OnLinkPressed")
							else 
							logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
						end
						evt:Handle()
					end)
				end
			end
			
			
		end
		
	end
end	


function WebPage_FillPageFromJournalWebExt(self)
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	--print("dd")
	
	LinkController = inkWidgetRef.GetController(self.imageList[1])
	local root = self:GetRootWidget()
	
	
	local page = root:GetWidgetByIndex(0)
	local linkpanel = page:GetWidgetByIndex(0)
	local panel =linkpanel:GetWidgetByIndex(0)
	
	
	local network = panel:GetWidgetByIndex(0)
	local networktext = network:GetWidgetByIndex(4)
	local linkbar01 = panel:GetWidgetByIndex(1)
	local linkbar02 = panel:GetWidgetByIndex(2)
	local link01 = linkbar01:GetWidgetByIndex(0)
	
	--print(GameDump(linkbar02))
	
	local link02 = linkbar01:GetWidgetByIndex(1)
	local link03 = linkbar01:GetWidgetByIndex(2)
	local link04 = linkbar01:GetWidgetByIndex(3)
	local link05 = linkbar01:GetWidgetByIndex(4)
	local link06 = linkbar02:GetWidgetByIndex(0)
	local link07 = linkbar02:GetWidgetByIndex(1)
	local link08 = linkbar02:GetWidgetByIndex(2)
	local link09 = linkbar02:GetWidgetByIndex(3)
	local link10 = linkbar02:GetWidgetByIndex(4)
	
	
	
	if webcount == 0 then webcount = linkbar01:GetNumChildren() end
	if(webcount == linkbar01:GetNumChildren()) then
		
		
		
		
		
		
		if(isEmpty(cyberscript.cache["webpage"]) == false) then
			
			local linknew = inkVerticalPanelWidget.new()
			linknew:SetName(StringToName("linknew"))
			linknew:SetChildMargin(inkMargin.new({ left = 50.0, top = 30.0, right = 50.0, bottom = 30.0 }))
			
			linknew:SetFitToContent(true)
			
			
			
			
			local imageprop = {}
			imageprop.tag = "link03_img"
			imageprop.tweak = "PhotoModeStickers.dcl_04"
			imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
			imageprop.size = {}
			imageprop.size.x = 200
			imageprop.size.y = 200
			imageprop.fittocontent = false
			imageprop.scale = {}
			imageprop.scale.x = 1.3
			imageprop.scale.y = 1.3
			
			local textprop = {}
			textprop.tag = "link03_text"
			textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
			textprop.size = {}
			textprop.size.x = 100
			textprop.size.y = 32
			textprop.text = "CyberScript Network"
			textprop.fontsize = 32
			textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
			textprop.scale = {}
			textprop.scale.x = 1.0
			textprop.scale.y = 1.0
			
			local link = linknew
			local actionlist = {}
			local action = {}
			
			action.name = "refreshBrowser" 
			action.page = page
			action.address = "CyberScriptWeb"
			action.subaddress = "home"
			table.insert(actionlist,action)
			
			
			
			buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
			linknew:Reparent(linkbar01, linkbar01:GetNumChildren()+1)
		end
		
		
		
		
		if(CurrentAddress == "CyberScript") then
			
			if(BrowserCybserscript == "loading") then
				
				linkpanel:RemoveAllChildren()
				
				makeCustomInterface(linkpanel,cyberscript.cache["interfaces"]["Keystone_Load"].data)
				
				
				
				
				elseif(BrowserCybserscript == "home") then
				
				
				
				
				
				LinkController = inkWidgetRef.GetController(self.textList[1])
				--header
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("CyberScript")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				
				
				--link redef
				
				
				link01:RemoveAllChildren()
				
				
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "loading"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				
				
				if(CurrentServerModVersion.version ~= "unknown" and CurrentServerModVersion.version ~= "0.16000069") then
					
					if(CurrentServerModVersion.version ~= "unknown" and CurrentServerModVersion.version ~= "0.16000069" and checkVersionNumber(cyberscript.version,CurrentServerModVersion.version))then
						
						
						local container = inkCanvas.new()
						container:SetName(CName.new("need_update_banner"))
						container:SetFitToContent(false)
						
						container:SetSize(Vector2.new({ X = 3150, Y = 200 }))
						container:SetScale(Vector2.new({ X = 1, Y = 1 }))
						container:SetInteractive(true)
						
						container:SetAnchor(15)
						container:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						container:SetOpacity(1)
						container:SetRotation(0)
						container:SetVisible(true)
						
						
						
						
						container:Reparent(panel, 0)
						
						local rectangletitle = inkRectangleWidget.new()
						rectangletitle:SetName(CName.new("need_update_rectangle"))
						rectangletitle:SetFitToContent(false)
						rectangletitle:SetMargin(inkMargin.new({ top = 100 }))
						rectangletitle:SetSize(Vector2.new({ X = 3150, Y = 150 }))
						rectangletitle:SetScale(Vector2.new({ X = 1, Y = 1 }))
						rectangletitle:SetInteractive(true)
						rectangletitle:SetTintColor(gamecolorStyle({red=255,blue=0,green=0}))
						rectangletitle:SetAnchor(0)
						rectangletitle:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						rectangletitle:SetOpacity(1)
						rectangletitle:SetRotation(0)
						rectangletitle:SetVisible(true)
						rectangletitle:Reparent(container, -1)
						
						local texttitle = inkText.new()
						texttitle:SetName(CName.new("need_update_title"))
						texttitle:SetFitToContent(false)
						texttitle:SetMargin(inkMargin.new({ top = 75 }))
						texttitle:SetSize(Vector2.new({ X = 100, Y = 200 }))
						texttitle:SetScale(Vector2.new({ X = 1, Y = 1 }))
						texttitle:SetInteractive(true)
						texttitle:SetText(getLang("ui_keystone_main_update_available"))
						texttitle:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						texttitle:SetFontStyle('Medium')
						texttitle:SetFontSize(50)
						texttitle:SetHorizontalAlignment(1)
						texttitle:SetVerticalAlignment(1)
						texttitle:SetTintColor(gamecolorStyle({red=255,blue=255,green=255}))
						texttitle:SetAnchor(1)
						texttitle:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						texttitle:SetOpacity(1)
						texttitle:SetRotation(0)
						texttitle:SetVisible(true)
						texttitle:Reparent(container, -1)
						
						
						local textversion = inkText.new()
						textversion:SetName(CName.new("need_update_title"))
						textversion:SetFitToContent(false)
						textversion:SetMargin(inkMargin.new({ top = -100 }))
						textversion:SetSize(Vector2.new({ X = 100, Y = 200 }))
						textversion:SetScale(Vector2.new({ X = 1, Y = 1 }))
						textversion:SetInteractive(true)
						textversion:SetText("CyberScript : local version :"..cyberscript.version.." Server version :"..CurrentServerModVersion.version)
						textversion:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						textversion:SetFontStyle('Medium')
						textversion:SetFontSize(30)
						textversion:SetHorizontalAlignment(1)
						textversion:SetVerticalAlignment(1)
						textversion:SetTintColor(gamecolorStyle({red=255,blue=255,green=255}))
						textversion:SetAnchor(0)
						textversion:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						textversion:SetOpacity(1)
						textversion:SetRotation(0)
						textversion:SetVisible(true)
						textversion:Reparent(panel, 4)
						
						EventProxy.RegisterCallback(container, "OnRelease", function(_, evt)
							
							
							if( workerTable["keystone_update_mod"] == nil) then
								
								local actionlist = {}
								
								local action = {}
								
								
								action.name = "refreshBrowser" 
								action.page = page
								action.address = "CyberScript"
								action.subaddress = "keystone_update"
								table.insert(actionlist,action)
								
								runActionList(actionlist, "keystone_update_mod", "interact",false,"nothing",true)
							end
							
							evt:Handle()
						end)
						
						
					end
					
					
				end
				
				
				
				local imageprop = {}
				imageprop.tag = "link01_img"
				imageprop.tweak = "PhotoModeStickers.dcl_02"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link01_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Datapack"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link01
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "datapack"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link02:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link02_img"
				imageprop.tweak = "PhotoModeStickers.dcl_05"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link02_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "My Datapacks"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				
				local link = link02
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "mydatapack"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				link03:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link03_img"
				imageprop.tweak = "PhotoModeStickers.bnd_032"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link03_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "CorpoNetwork"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link03
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_corpo_news"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link04:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link04_img"
				imageprop.tweak = "PhotoModeStickers.dcl_014"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link04_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Stock Market"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				
				local link = link04
				local actionlist = {}
				local action = {}
				action = {}
				action.name = "refresh_market"
				table.insert(actionlist,action)
				action = {}
				action.name = "wait_for_framework"
				table.insert(actionlist,action)
				action = {}
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_stock_market"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link05:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link05_img"
				imageprop.tweak = "PhotoModeStickers.dcl_016"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link05_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Items Market"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link05
				local actionlist = {}
				local action = {}
				
				action.name = "get_itemlist"
				table.insert(actionlist,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(actionlist,action)
				
				action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "item_category"
				table.insert(actionlist,action)
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link06:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link06_img"
				imageprop.tweak = "PhotoModeStickers.dcl_012"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link06_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "My Account"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link06
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_account"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link07:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link07_img"
				imageprop.tweak = "PhotoModeStickers.dcl_06"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link07_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Changelog"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link07
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_changelog"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				
				
				
				
				linkbar02:RemoveChildByIndex(2)
				linkbar02:RemoveChildByIndex(2)
				linkbar02:RemoveChildByIndex(2)
				
				
				
				
				
				elseif(BrowserCybserscript == "datapack") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Datapack")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				
				
				--logme(2,"button")
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				
				local buttonData = {
					name = StringToName("back"),
					text = "Back",
					value = i,
					tag =  "back",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "home"
				table.insert(buttonData.action,action)
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 100,left= 2800},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(panel, 1)
				
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "fetch_data"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "datapack"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				for k,v in ipairs(arrayDatapack3) do 
					
					
					table.insert(templist,v)
					
				end
				
				if(#arrayDatapack3 > 0) then
					for i = 1,#arrayDatapack3 do
						
						if(#obj < 4) then
							table.insert(obj,arrayDatapack3[i])
							if(arrayDatapack3[i+1] == nil) then
								table.insert(arrayList,obj)
							end
							else
							table.insert(arrayList,obj)
							obj = {}
							table.insert(obj,arrayDatapack3[i])
							if(arrayDatapack3[i+1] == nil) then
								table.insert(arrayList,obj)
							end
						end
						
						
						
						
					end
				end
				
				local scrollComponent = UIScroller.Create("datapack_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, 2)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("datapack__vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("datapack_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						local datapack = arrayList[i][y]
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(datapack.tag.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						
						
						local imageprop = {}
						imageprop.tag = datapack.tag.."_img"
						local random = math.random(1, 11)
						if(random == 37 or random == 25) then
							imageprop.tweak =  ('PhotoModeStickers.crc_%d'):format(random)
							else
							imageprop.tweak =  ('PhotoModeStickers.crc_0%d'):format(random)
						end
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = datapack.tag.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = datapack.name
						if(isDatapackDownloaded(datapack.tag)) then
							
							textprop.text = "(Downloaded) "..datapack.name
							local localversion = CurrentDownloadedVersion(datapack.tag)
							if(localversion~=datapack.version and checkVersionNumber(localversion,datapack.version) == true) then
								
								textprop.text = "(Update) "..datapack.name
								
							end
						end
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "set_selected_keystone_datapack" 
						action.value = datapack.tag
						table.insert(actionlist,action)
						action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScript"
						action.subaddress = "datapack_detail"
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist)
					end
				end
				
				
				
				
				
				elseif(BrowserCybserscript == "mydatapack") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Datapack")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				local buttonData = {
					name = StringToName("back"),
					text = "Back",
					value = i,
					tag =  "back",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "home"
				table.insert(buttonData.action,action)
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 100,left= 2800},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(panel, 1)
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "fetch_data"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "datapack"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				for k,v in pairs(arrayDatapack) do 
					
					if(#obj < 4) then
						table.insert(obj,v.metadata)
						
						table.insert(arrayList,obj)
						
						else
						table.insert(arrayList,obj)
						obj = {}
						table.insert(obj,v.metadata)
						
						table.insert(arrayList,obj)
						
					end
					
					
				end
				
				
				
				local scrollComponent = UIScroller.Create("datapack_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, -1)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("datapack__vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("datapack_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						local datapack = arrayList[i][y]
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(datapack.tag.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						
						
						local imageprop = {}
						imageprop.tag = datapack.tag.."_img"
						local random = math.random(1, 11)
						if(random == 37 or random == 25) then
							imageprop.tweak =  ('PhotoModeStickers.crc_%d'):format(random)
							else
							imageprop.tweak =  ('PhotoModeStickers.crc_0%d'):format(random)
						end
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = datapack.tag.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = datapack.name
						if(isDatapackDownloaded(datapack.tag)) then
							
							textprop.text = "(Downloaded) "..datapack.name
							local localversion = CurrentDownloadedVersion(datapack.tag)
							if(localversion~=datapack.version and checkVersionNumber(localversion,datapack.version) == true) then
								
								textprop.text = "(Update) "..datapack.name
								
							end
						end
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "set_selected_keystone_datapack" 
						action.value = datapack.tag
						table.insert(actionlist,action)
						action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScript"
						action.subaddress = "datapack_detail"
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist)
					end
				end
				
				
				
				
				
				elseif(BrowserCybserscript == "datapack_detail" and Keystone_currentSelectedDatapack ~= nil) then
				
				local datapack = Keystone_currentSelectedDatapack
				panel:RemoveAllChildren()
				
				makeCustomInterface(panel,cyberscript.cache["interfaces"]["keystone_datapack_detail"].data)
				
				
				elseif(BrowserCybserscript == "item_category") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Item Category")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				local buttonData = {
					name = StringToName("back"),
					text = "Back",
					value = i,
					tag =  "back",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "home"
				table.insert(buttonData.action,action)
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 100,left= 2800},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(panel, 1)
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "fetch_data"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(buttonData.action,action)
				
				
				
				
				action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "item_category"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				if(#possiblecategory > 0) then
					for i = 1,#possiblecategory do
						
						if(#obj < 4) then
							table.insert(obj,possiblecategory[i])
							if(possiblecategory[i+1] == nil) then
								table.insert(arrayList,obj)
							end
							else
							table.insert(arrayList,obj)
							obj = {}
							table.insert(obj,possiblecategory[i])
							if(possiblecategory[i+1] == nil) then
								table.insert(arrayList,obj)
							end
						end
						
						
						
						
					end
				end
				
				
				
				
				local scrollComponent = UIScroller.Create("datapack_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, -1)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("datapack__vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("datapack_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						local datapack = arrayList[i][y]
						
						
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(datapack.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						
						
						local imageprop = {}
						imageprop.tag = datapack.."_img"
						local random = math.random(1, 11)
						if(random == 37 or random == 25) then
							imageprop.tweak =  ('PhotoModeStickers.crc_%d'):format(random)
							else
							imageprop.tweak =  ('PhotoModeStickers.crc_0%d'):format(random)
						end
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = datapack.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = datapack
						
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "set_selected_item_category" 
						action.value = datapack
						table.insert(actionlist,action)
						action = {}
						action.name = "set_current_item_page" 
						action.value = 1
						table.insert(actionlist,action)
						action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScript"
						action.subaddress = "keystone_item_market"
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist)
					end
				end
				
				elseif(BrowserCybserscript == "keystone_item_market") then
				
				local interface = cyberscript.cache["interfaces"]["keystone_item_market"].data
				
				local copyinterface = deepcopy(interface, nil)
				
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				if CurrentItemPage == nil then CurrentItemPage = 1 setScore("Item_Market","CurrentItemPage",CurrentItemPage) end
				
				
				
				
				if arrayMarketItem ~= nil  then
					if CurrentItemPage > #arrayMarketItem[Keystone_currentSelectedItemCategory] then CurrentItemPage = 1 setScore("Item_Market","CurrentItemPage",CurrentItemPage)  end
					
					local items = arrayMarketItem[Keystone_currentSelectedItemCategory][CurrentItemPage]
					
					
					
					
					if(#items > 0) then
						for i = 1,#items do
							
							if(#obj < 5) then
								table.insert(obj,items[i])
								if(items[i+1] == nil) then
									table.insert(arrayList,obj)
								end
								else
								table.insert(arrayList,obj)
								obj = {}
								table.insert(obj,items[i])
								if(items[i+1] == nil) then
									table.insert(arrayList,obj)
								end
							end
							
							
							
							
						end
					end
					
					if(#arrayList >0) then
						for i=1,#arrayList do 
							local horizontalarea = deepcopy(GetInterfaceChildren(interface,"horizontal_area_01"), nil)
							horizontalarea.tag = "datapack_horizontal_"..i
							
							table.insert(copyinterface.controls,horizontalarea)
							for y=1,#arrayList[i] do
								local item = arrayList[i][y]
								
								local stock_vertical_item =  deepcopy(GetInterfaceChildren(interface,"stock_vertical_item_01"), nil)
								stock_vertical_item.parent = horizontalarea.tag
								stock_vertical_item.tag = "stock_vertical_item_"..i.."_"..y
								
								local bckg_01 =  deepcopy(GetInterfaceChildren(interface,"bckg_01"), nil)
								bckg_01.parent = stock_vertical_item.tag
								bckg_01.tag = "bckg_"..i.."_"..y
								
								local stock_vertical_item_container =  deepcopy(GetInterfaceChildren(interface,"stock_vertical_item_container_01"), nil)
								stock_vertical_item_container.parent = stock_vertical_item.tag
								stock_vertical_item_container.tag = "stock_vertical_item_container_"..i.."_"..y
								
								local lbl_name =  deepcopy(GetInterfaceChildren(interface,"lbl_name_01"), nil)
								lbl_name.parent = stock_vertical_item_container.tag
								lbl_name.tag = "lbl_name_"..i.."_"..y
								lbl_name.context = nil
								lbl_name.text = item.Title
								
								local lbl_price =  deepcopy(GetInterfaceChildren(interface,"lbl_price_1"), nil)
								lbl_price.parent = stock_vertical_item_container.tag
								lbl_price.tag = "lbl_price_"..i.."_"..y
								lbl_price.context = nil
								lbl_price.text = "Price : "..item.Price
								
								local owned =  deepcopy(GetInterfaceChildren(interface,"owned_01"), nil)
								owned.parent = stock_vertical_item_container.tag
								owned.tag = "owned"..i.."_"..y
								
								local playerItems = getPlayerItemsbyTag(item.Tag)
								
								if playerItems == nil then 
									
									setScore("owned_item",item.Tag,0)
									
									
								end
								
								owned.context[1].prop.text.values.loadingmsg.type = "score"
								owned.context[1].prop.text.values.loadingmsg.variable = "owned_item"
								owned.context[1].prop.text.values.loadingmsg.key = item.Tag
								owned.context[1].prop.text.values.loadingmsg.tag = nil
								
								
								local incart =  deepcopy(GetInterfaceChildren(interface,"incart_01"), nil)
								incart.parent = stock_vertical_item_container.tag
								incart.tag = "incart"..i.."_"..y
								incart.context[1].prop.text.values.loadingmsg.type = "score"
								incart.context[1].prop.text.values.loadingmsg.variable = "Item_MarketCart"
								incart.context[1].prop.text.values.loadingmsg.key = item.Tag
								incart.context[1].prop.text.values.loadingmsg.tag = nil
								
								
								local horizontal_area_btn =  deepcopy(GetInterfaceChildren(interface,"horizontal_area_btn_01"), nil)
								horizontal_area_btn.parent = stock_vertical_item_container.tag
								horizontal_area_btn.tag = "horizontal_area_btn_"..i.."_"..y
								
								local btn_buy =  deepcopy(GetInterfaceChildren(interface,"btn_buy_01"), nil)
								btn_buy.parent = horizontal_area_btn.tag
								btn_buy.tag = "btn_buy_"..i.."_"..y
								btn_buy.context[1].trigger.auto.target = item.Price
								btn_buy.action[1].tag = item.Tag
								
								local btn_sell =  deepcopy(GetInterfaceChildren(interface,"btn_sell_01"), nil)
								btn_sell.parent = horizontal_area_btn.tag
								btn_sell.tag = "btn_sell_"..i.."_"..y
								btn_sell.context[2].trigger.auto.context[1].prop.value.values.loadingmsg.key = item.Tag
								btn_sell.context[3].trigger.auto.context[1].prop.value.values.loadingmsg.key = item.Tag
								btn_sell.action[1].tag = item.Tag
								
								
								table.insert(copyinterface.controls,stock_vertical_item)
								table.insert(copyinterface.controls,bckg_01)
								table.insert(copyinterface.controls,stock_vertical_item_container)
								table.insert(copyinterface.controls,lbl_name)
								table.insert(copyinterface.controls,lbl_price)
								table.insert(copyinterface.controls,owned)
								table.insert(copyinterface.controls,incart)
								table.insert(copyinterface.controls,horizontal_area_btn)
								table.insert(copyinterface.controls,btn_buy)
								table.insert(copyinterface.controls,btn_sell)
								
								
								
							end
						end
						panel:RemoveAllChildren()
						--	logme(10,JSON:encode_pretty(copyinterface))
						makeCustomInterface(panel,copyinterface)
					end
					
					
				end
				elseif(BrowserCybserscript ~= "loading" and BrowserCybserscript ~= "home" and BrowserCybserscript ~= "datapack" and BrowserCybserscript ~= "mydatapack" and BrowserCybserscript ~= "datapack_detail" and BrowserCybserscript ~= "stock_market" and BrowserCybserscript ~= "item_category" and BrowserCybserscript ~= "item_market") then
				
				--------print(BrowserCybserscript)
				panel:RemoveAllChildren()
				
				makeCustomInterface(panel,cyberscript.cache["interfaces"][BrowserCybserscript].data)
				
				
				
				
				
			end
		end
		if(CurrentAddress == "CyberScriptWeb") then
			if(BrowserCybserscript == nil) then BrowserCybserscript = "home" end
			if(BrowserCybserscript == "home") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Web")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				
				
				--logme(2,"button")
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				
				
				
				
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				for k,wpage in pairs(cyberscript.cache["webpage"]) do 
					
					if(checkTriggerRequirement(wpage.data.requirement,wpage.data.trigger))then
						table.insert(templist,wpage)
					end
				end
				
				
				for i,wpage in ipairs(templist) do 
					
					
					if(#obj < 4) then
						
						
						table.insert(obj,wpage)
						
						if(templist[i+1] == nil) then
							table.insert(arrayList,obj)
						end
						
						
						else
						
						table.insert(arrayList,obj)
						
						
						obj = {}
						table.insert(obj,wpage)
						
						if(templist[i+1] == nil) then
							table.insert(arrayList,obj)
						end
						
					end
					
					
				end
				
				
				
				local scrollComponent = UIScroller.Create("webpage_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, 2)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("webpage_vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("webpage_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						
						local webpage = arrayList[i][y].data
						--------print(dump(webpage))
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(webpage.tag.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						local customimage = false
						
						local imageprop = {}
						imageprop.tag = webpage.tag.."_img"
						
						if(webpage.tweak ~= nil and webpage.texture ~= nil and webpage.tweak ~= "" and webpage.texture ~= "") then
							
							imageprop.tweak = webpage.tweak
							imageprop.texture = webpage.texture
							customimage = true
							else
							
							imageprop.tweak = ('PhotoModeStickers.dcl_016')
						end
						
						
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = webpage.tag.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = webpage.name
						
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScriptWeb"
						action.subaddress = webpage.target
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist,customimage)
					end
				end
				
				
				
				else
				
				panel:RemoveAllChildren()
				
				makeCustomInterface(panel,cyberscript.cache["interfaces"][BrowserCybserscript].data)
				
				
			end
		end
		
	end
	
end	


function BrowserController_OnPageSpawned(thos, widget, userData)
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	GameController["BrowserController"]  = thos
	-- if(CurrentAddress == "CyberScript") then
	-- inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod");
	-- end
	--print("BrowserController_OnPageSpawned")
	-- if(CurrentAddress == "CyberScript" and BrowserCybserscript ~= nil) then
	-- inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/"..BrowserCybserscript);
	-- end
	
	if(CurrentAddress == "CyberScriptWeb") then
		inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/search");
	end
	
	if(CurrentAddress == "CyberScriptWeb" and BrowserCybserscript ~= nil) then
		inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/search/site/"..BrowserCybserscript);
	end
	if(CurrentAddress == "NETdir://ezestates.web/makeovers" and BrowserCustomPlace ~= nil) then
		if(BrowserCustomPlace == "template") then
			inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/makeovers")
			else
			inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/estates")
		end
		
	end
	
end


function ComputerInkGameController_ShowMenuByName(thos, elementName, wrappedMethod)
	
	if(observerthread5 == true or moddisabled  == true)   then return wrappedMethod(elementName) end
	-- if(elementName == "CyberScript") then
	-- local internetData = (thos:GetOwner():GetDevicePS()):GetInternetData()
	-- thos:GetMainLayoutController():ShowInternet("CyberScript")
	
	-- thos:RequestMainMenuButtonWidgetsUpdate()
	-- CurrentAddress = "CyberScript"
	-- BrowserCybserscript = "loading"
	-- else
	-- wrappedMethod(elementName)
	-- end
	------print("ShowMenuByName "..elementName)
	if(elementName == "CyberScriptWeb") then
		------print("ShowMenuByName2 "..elementName)
		local internetData = (thos:GetOwner():GetDevicePS()):GetInternetData()
		thos:GetMainLayoutController():ShowInternet("CyberScriptWeb")
		thos:RequestMainMenuButtonWidgetsUpdate()
		CurrentAddress = "CyberScriptWeb"
		BrowserCybserscript = "home"
		else
		wrappedMethod(elementName)
	end
end


function BrowserController_LoadWebPage(self,address,wrappedMethod)
	--	CurrentAddress = address
	if(observerthread5 == true or moddisabled  == true)   then return wrappedMethod(address) end
	--print("LoadWebPage : "..address)
	
	if(address == "NETdir://ncity.pub") then
		webcount = 0
	end
	
	if(address == "CyberScript" or address == "CyberScriptWeb" or  address == "NETdir://ezestates.web/makeovers" or  address == "NETdir://ezestates.web/for_rent") then
		if(BrowserController == nil) then BrowserController = self end
		
		
		if(address == "CyberScript" or address == "CyberScriptWeb" or  address == "NETdir://ezestates.web/makeovers" or  address == "NETdir://ezestates.web/for_rent") then
			
			CurrentAddress = address
			
			else
			CurrentAddress = nil
			
			
		end
		
		if(CurrentAddress == nil) then
			
			BrowserCybserscript = nil
			BrowserCustomPlace = nil
			
		end
		
		if(CurrentAddress == "CyberScript" and BrowserCybserscript == nil) then
			BrowserCybserscript = "loading"
			BrowserCustomPlace = nil
		end
		
		if(CurrentAddress == "CyberScriptWeb" and BrowserCybserscript == nil) then
			BrowserCybserscript = "home"
			BrowserCustomPlace = nil
		end
		
		-- Cron.NextTick(function()
		if(CurrentAddress ~= "NETdir://ezestates.web/makeovers") then
			BrowserCustomPlace = nil
			
		end
		
		
		if(address == "CyberScript" or address == "CyberScriptWeb" ) then
			------print("testlogic0")
			return wrappedMethod("NETdir://ncity.pub")
			
			else
			------print("testlogic1")
			return wrappedMethod(address)
			
		end
		
		else
		CurrentAddress = nil
		BrowserCybserscript = nil
		BrowserCustomPlace = nil
		
		return wrappedMethod(address)
		
	end
	
end

