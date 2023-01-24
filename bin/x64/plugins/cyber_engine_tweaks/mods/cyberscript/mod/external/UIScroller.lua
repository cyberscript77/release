
---@return inkCanvasWidget, inkSliderController
local function createWidget(cname)
	local scrollArea = inkCanvas.new()
	scrollArea:SetName(StringToName(cname))
	scrollArea:SetAnchor(inkEAnchor.Fill)
	scrollArea:SetInteractive(true)

	local scrollBg = inkRectangle.new()
	scrollBg:SetName(StringToName('scrollBg'))
	scrollBg:SetAnchor(inkEAnchor.Fill)
	scrollBg:SetTintColor(HDRColor.new({ Red = 0.301961, Green = 0.690196, Blue = 0.647059, Alpha = 1.0 }))
	scrollBg:SetOpacity(0.025)
	scrollBg:Reparent(scrollArea, -1)

	local scrollContent = inkScrollArea.new()
	scrollContent:SetName(StringToName('scrollContent'))
	scrollContent:SetAnchor(inkEAnchor.Fill)
	scrollContent:SetMargin(inkMargin.new({ right = 16.0 }))
	scrollContent:SetSize(Vector2.new({ X = 800.0, Y = 200.0 }))
	scrollContent.fitToContentDirection = inkFitToContentDirection.Horizontal
	scrollContent.useInternalMask = true
	scrollContent:Reparent(scrollArea, -1)

	local sliderArea = inkCanvas.new()
	sliderArea:SetName(StringToName('sliderArea'))
	sliderArea:SetAnchor(inkEAnchor.RightFillVerticaly)
	sliderArea:SetSize(Vector2.new({ X = 12.0 }))
	sliderArea:Reparent(scrollArea, -1)

	local sliderFill = inkRectangle.new()
	sliderFill:SetName(StringToName('sliderFill'))
	sliderFill:SetAnchor(inkEAnchor.Fill)
	sliderFill:SetTintColor(HDRColor.new({ Red = 0.301961, Green = 0.690196, Blue = 0.647059, Alpha = 1.0 }))
	sliderFill:SetOpacity(0.5)
	sliderFill:Reparent(sliderArea, -1)

	local sliderHandle = inkRectangle.new()
	sliderHandle:SetName(StringToName('sliderHandle'))
	sliderHandle:SetAnchor(inkEAnchor.TopFillHorizontaly)
	sliderHandle:SetSize(Vector2.new({ X = 12.0, Y = 40.0 }))
	sliderHandle:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
	sliderHandle:Reparent(sliderArea, -1)

	local sliderController = inkSliderController.new()
	sliderController.slidingAreaRef = inkWidgetRef.new({ widget = sliderArea })
	sliderController.handleRef = inkWidgetRef.new({ widget = sliderHandle })
	sliderController.direction = inkESliderDirection.Vertical
	sliderController.autoSizeHandle = true
	sliderController.percentHandleSize = 0.4
	sliderController.minHandleSize = 40.0
	sliderController:Setup(0, 1, 0, 0)

	scrollArea.logicController = sliderController

	return scrollArea
end

---@param scrollArea inkCompoundWidget
---@return inkScrollAreaWidget
local function getScrollContent(scrollArea)
	return scrollArea:GetWidgetByPathName(StringToName('scrollContent'))
end

---@param scrollArea inkCompoundWidget
---@return inkSliderController
local function getSliderController(scrollArea)
	return scrollArea:GetController()
end

---@param scrollArea inkCanvasWidget
---@return number
local function getScrollPosition(scrollArea)
	return getScrollContent(scrollArea):GetVerticalScrollPosition()
end

---@param scrollArea inkCompoundWidget
---@param scrollPosition number
local function setScrollPosition(scrollArea, scrollPosition)
	local scrollContent = getScrollContent(scrollArea)
	local sliderController = getSliderController(scrollArea)

	scrollContent:ScrollVertical(scrollPosition)
	sliderController:ChangeProgress(scrollPosition)
end

---@param scrollArea inkCanvasWidget
local function updateScrollBar(scrollArea, preservePosition)
	local scrollContent = getScrollContent(scrollArea)
	local sliderController = getSliderController(scrollArea)

	local areaSize = scrollArea:GetSize()
	local contentSize = scrollContent:GetContentSize()

	if contentSize.Y > 0 then
		sliderController.percentHandleSize = (areaSize.Y / contentSize.Y)
		sliderController:Setup(0, 1, preservePosition and getScrollPosition(scrollArea) or 0, 0)
	end
end

---@param _ IScriptable
local function onWheelScroll(_, evt)
---@param evt inkPointerEvent

  
  

	if (evt:IsAction('mouse_wheel') or evt:IsAction('right_stick_y_scroll')) and evt:GetAxisData() ~= 0 then
		---@type inkCanvasWidget
		local scrollArea = evt:GetCurrentTarget()
		local scrollPosition = getScrollPosition(scrollArea)
		
		local myScrollSpeed = getUserSetting("ScrollSpeed")
		if(myScrollSpeed == nil) then
			myScrollSpeed = 0.020
		end
			
		scrollPosition = scrollPosition - myScrollSpeed *  evt:GetAxisData()
		scrollPosition = math.max(scrollPosition, 0)
		scrollPosition = math.min(scrollPosition, 1)
		
		
		setScrollPosition(scrollArea, scrollPosition)
	end
end

---@param scrollArea inkCompoundWidget
local function regisrerCallbacks(scrollArea)
	EventProxy.RegisterCallback(scrollArea, 'OnRelative', onWheelScroll)
	EventProxy.RegisterCallback(scrollArea, 'OnAxis', onWheelScroll)
end

---@param scrollArea inkCompoundWidget
local function unregisrerCallbacks(scrollArea)
	EventProxy.UnregisterCallback(scrollArea, 'OnRelative', onWheelScroll)
	EventProxy.UnregisterCallback(scrollArea, 'OnAxis', onWheelScroll)
end

---@class UIScroller
---@field root inkCanvasWidget
local UIScroller = {}
UIScroller.__index = UIScroller

---@return UIScroller, inkCanvasWidget
function UIScroller.Create(cname)
	local root = createWidget(cname)

	regisrerCallbacks(root)

	return setmetatable({ root = Ref.Weak(root) }, UIScroller), root
end

---@return inkCanvasWidget
function UIScroller:GetRootWidget()
	return self.root
end

---@return inkScrollAreaWidget
function UIScroller:GetContentWidget()
	return getScrollContent(self.root)
end

---@return number [0-1]
function UIScroller:GetPosition()
	return setScrollPosition(self.root)
end

---@param position number [0-1]
function UIScroller:SetPosition(position)
	setScrollPosition(self.root, position)
end

---@param preservePosition boolean
function UIScroller:UpdateContent(preservePosition)
	updateScrollBar(self.root, preservePosition)
end

---@param event string
---@param callback function
function UIScroller:RegisterCallback(event, callback)
	EventProxy.RegisterCallback(self.root, event, callback)
end

---@param event string
---@param callback function
function UIScroller:UnregisterCallback(event, callback)
	EventProxy.UnregisterCallback(self.root, event, callback)
end

---@param parent inkCompoundWidget
---@param index Int32
function UIScroller:Reparent(parent, index)
	if Ref.IsDefined(self.root) then
		self.root:Reparent(parent, index or -1)
	end
end

function UIScroller:Destroy()
	if Ref.IsDefined(self.root) then
		unregisrerCallbacks(self.root)
		
		self.root.logicController = nil
		self.root = nil
	end
end

return UIScroller