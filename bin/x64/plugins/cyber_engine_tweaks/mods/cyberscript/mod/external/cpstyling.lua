-- MIT License
--
-- CPStyling.lua https://github.com/Nats-ji/CPStyling.lua
--
-- This file is a part of CPStyling.lua
--
-- Copyright (c) 2021 Mingming Cui
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.


--edited version by donk



local CPStyle = {}
local currentFilePath = "mod/external/"
-- CPStyle.theme = require(currentFilePath.."theme")
local styles = require("mod/external/styles")
local ImGuiStyleNames = styles.ImGuiStyleNames
CPStyle.color = styles.color

local png = ""

local function ToImGuiStyleName(style, which)
	if which == "Col" then
		for i in pairs(ImGuiStyleNames.Col) do
			if style == ImGuiStyleNames.Col[i].ImGuiStyleShort then
				return ImGuiStyleNames.Col[i].ImGuiStyle
			end
		end
	elseif which == "Var" then
		for i in pairs(ImGuiStyleNames.Var) do
			if style == ImGuiStyleNames.Var[i].ImGuiStyleShort then
				return ImGuiStyleNames.Var[i].ImGuiStyle
			end
		end
	end
end

local function hex2rgb(hex)
    local hex = hex:gsub("#","")
    if hex:len() == 3 then
      return (tonumber("0x"..hex:sub(1,1))*17)/255, (tonumber("0x"..hex:sub(2,2))*17)/255, (tonumber("0x"..hex:sub(3,3))*17)/255
    else
      return tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255
    end
end

local function loadTheme(theme)
	local chunk = loadfile(currentFilePath..theme..".lua") -- Need to convert to json
	return chunk()
end

local function trimLabel(label)
	local trimed_label = string.gsub(label, "##.+", "")
	return trimed_label
end

local function rounding(num)
	return math.floor(num + 0.5)
end

function CPStyle:New(mod_name)
	local o = {}
	if mod_name then
		o.theme = loadTheme(mod_name)
	else
		o.theme = loadTheme("cpstyling_default")
	end
	setmetatable(o, self)
	self.__index = self
	return o
end

function CPStyle.colorBegin(style, color)
  if type(color) == "number" then
    ImGui.PushStyleColor(ToImGuiStyleName(style, "Col"), color)
	elseif type(color) == "string" then
		local r, g, b = hex2rgb(color)
		ImGui.PushStyleColor(ToImGuiStyleName(style, "Col"), r, g, b, 1)
	elseif type(color) == "table" then
		if type(color[1]) == "string" and type(color[2]) == "number" then
			local r, g, b = hex2rgb(color[1])
			ImGui.PushStyleColor(ToImGuiStyleName(style, "Col"), r, g, b, color[2])
		elseif type(color[1]) == "number" and type(color[2]) == "number" and type(color[3]) == "number" then
			if color[4] == nil then
				ImGui.PushStyleColor(ToImGuiStyleName(style, "Col"), color[1], color[2], color[3], 1)
			else
				ImGui.PushStyleColor(ToImGuiStyleName(style, "Col"), color[1], color[2], color[3], color[4])
			end
		end
	end
end

function CPStyle.colorEnd(count)
  if count == nil then
    ImGui.PopStyleColor()
  else
    ImGui.PopStyleColor(count)
  end
end
--
function CPStyle.styleBegin(style, var1, var2)
	if var2 == nil then
		ImGui.PushStyleVar(ToImGuiStyleName(style, "Var"), var1)
	else
		ImGui.PushStyleVar(ToImGuiStyleName(style, "Var"), var1, var2)
	end
end

function CPStyle.styleEnd(count)
  if count == nil then
    ImGui.PopStyleVar()
  else
    ImGui.PopStyleVar(count)
  end
end

function CPStyle:setThemeBegin()
	CPStyle.colorBegin("Text"                           , self.theme.Text)
	CPStyle.colorBegin("TextDisabled"                   , self.theme.TextDisabled)
	CPStyle.colorBegin("WindowBg"                       , self.theme.WindowBg)
	CPStyle.colorBegin("ChildBg"                        , self.theme.ChildBg)
	CPStyle.colorBegin("PopupBg"                        , self.theme.PopupBg)
	CPStyle.colorBegin("Border"                         , self.theme.Border)
	CPStyle.colorBegin("BorderShadow"                   , self.theme.BorderShadow)
	CPStyle.colorBegin("FrameBg"                        , self.theme.FrameBg)
	CPStyle.colorBegin("FrameBgHovered"                 , self.theme.FrameBgHovered)
	CPStyle.colorBegin("FrameBgActive"                  , self.theme.FrameBgActive)
	CPStyle.colorBegin("TitleBg"                        , self.theme.TitleBg)
	CPStyle.colorBegin("TitleBgActive"                  , self.theme.TitleBgActive)
	CPStyle.colorBegin("TitleBgCollapsed"               , self.theme.TitleBgCollapsed)
	CPStyle.colorBegin("MenuBarBg"                      , self.theme.MenuBarBg)
	CPStyle.colorBegin("ScrollbarBg"                    , self.theme.ScrollbarBg)
	CPStyle.colorBegin("ScrollbarGrab"                  , self.theme.ScrollbarGrab)
	CPStyle.colorBegin("ScrollbarGrabHovered"           , self.theme.ScrollbarGrabHovered)
	CPStyle.colorBegin("ScrollbarGrabActive"            , self.theme.ScrollbarGrabActive)
	CPStyle.colorBegin("CheckMark"                      , self.theme.CheckMark)
	CPStyle.colorBegin("SliderGrab"                     , self.theme.SliderGrab)
	CPStyle.colorBegin("SliderGrabActive"               , self.theme.SliderGrabActive)
	CPStyle.colorBegin("Button"                         , self.theme.Button)
	CPStyle.colorBegin("ButtonHovered"                  , self.theme.ButtonHovered)
	CPStyle.colorBegin("ButtonActive"                   , self.theme.ButtonActive)
	CPStyle.colorBegin("Header"                         , self.theme.Header)
	CPStyle.colorBegin("HeaderHovered"                  , self.theme.HeaderHovered)
	CPStyle.colorBegin("HeaderActive"                   , self.theme.HeaderActive)
	CPStyle.colorBegin("Separator"                      , self.theme.Separator)
	CPStyle.colorBegin("SeparatorHovered"               , self.theme.SeparatorHovered)
	CPStyle.colorBegin("SeparatorActive"                , self.theme.SeparatorActive)
	CPStyle.colorBegin("ResizeGrip"                     , self.theme.ResizeGrip)
	CPStyle.colorBegin("ResizeGripHovered"              , self.theme.ResizeGripHovered)
	CPStyle.colorBegin("ResizeGripActive"               , self.theme.ResizeGripActive)
	CPStyle.colorBegin("Tab"                            , self.theme.Tab)
	CPStyle.colorBegin("TabHovered"                     , self.theme.TabHovered)
	CPStyle.colorBegin("TabActive"                      , self.theme.TabActive)
	CPStyle.colorBegin("TabUnfocused"                   , self.theme.TabUnfocused)
	CPStyle.colorBegin("TabUnfocusedActive"             , self.theme.TabUnfocusedActive)
	-- CPStyle.colorBegin("PlotLines"                      , self.theme.PlotLines)
	-- CPStyle.colorBegin("PlotLinesHovered"               , self.theme.PlotLinesHovered)
	-- CPStyle.colorBegin("PlotHistogram"                  , self.theme.PlotHistogram)
	-- CPStyle.colorBegin("PlotHistogramHovered"           , self.theme.PlotHistogramHovered)
	-- CPStyle.colorBegin("TableHeaderBg"                  , self.theme.TableHeaderBg)
	-- CPStyle.colorBegin("TableBorderStrong"              , self.theme.TableBorderStrong)
	-- CPStyle.colorBegin("TableBorderLight"               , self.theme.TableBorderLight)
	-- CPStyle.colorBegin("TableRowBg"                     , self.theme.TableRowBg)
	-- CPStyle.colorBegin("TableRowBgAlt"                  , self.theme.TableRowBgAlt)
	CPStyle.colorBegin("TextSelectedBg"                 , self.theme.TextSelectedBg)
	-- CPStyle.colorBegin("DragDropTarget"                 , self.theme.DragDropTarget)
	CPStyle.colorBegin("NavHighlight"                   , self.theme.NavHighlight)
	CPStyle.colorBegin("NavWindowingHighlight"          , self.theme.NavWindowingHighlight)
	CPStyle.colorBegin("NavWindowingDimBg"              , self.theme.NavWindowingDimBg)
	CPStyle.colorBegin("ModalWindowDimBg"               , self.theme.ModalWindowDimBg)
  CPStyle.styleBegin("WindowRounding"                 , 0)
	CPStyle.styleBegin("ScrollbarSize"                  , 9)
end

function CPStyle:setThemeEnd()
	CPStyle.styleEnd(2)
	CPStyle.colorEnd(43)
end

function CPStyle:setFrameThemeBegin()
	CPStyle.colorBegin("FrameBg"                        , self.theme.CPFrameBg)
	CPStyle.colorBegin("FrameBgHovered"                 , self.theme.CPFrameBgHovered)
	CPStyle.colorBegin("FrameBgActive"                  , self.theme.CPFrameBgActive)
	CPStyle.colorBegin("SliderGrab"                     , self.theme.CPSliderGrab)
	CPStyle.colorBegin("SliderGrabActive"               , self.theme.CPSliderGrabActive)
	CPStyle.colorBegin("Border"                         , self.theme.CPFrameBorder)
	CPStyle.colorBegin("TextSelectedBg"                 , self.theme.CPTextSelectedBg)
	CPStyle.styleBegin("FrameBorderSize"                , 1)
end

function CPStyle:setFrameThemeEnd()
	CPStyle.styleEnd(1)
	CPStyle.colorEnd(7)
end

-- Invisible Button (workaround for getting framepadding value)
function CPStyle:InvisibleButton(label, sizex, sizey)
	if sizex == nil or sizey == nil then
		sizex = 0
		sizey = 0
	end
	CPStyle.colorBegin("Button", self.color.hidden)
	CPStyle.colorBegin("ButtonHovered", self.color.hidden)
	CPStyle.colorBegin("ButtonActive", self.color.hidden)
	CPStyle.colorBegin("Text", self.color.hidden)
	local pressed = ImGui.Button(label, sizex, sizey)
	CPStyle.colorEnd(4)
	return pressed
end

-- CPButton

function CPStyle:CPButton(label, sizex, sizey)
	local drawList = ImGui.GetWindowDrawList()
	local winX, winY = ImGui.GetWindowPos()
	local cursorX, cursorY = ImGui.GetCursorPos()
	local scrollX = ImGui.GetScrollX()
  local scrollY = ImGui.GetScrollY()

	local pressed = self:InvisibleButton(label, sizex, sizey)
	local size_x, size_y = ImGui.GetItemRectSize()
	local active = ImGui.IsItemActive()
  local hovered = ImGui.IsItemHovered()

	local color = {}
	color.border = self.theme.CPButtonBorder
	color.background = self.theme.CPButton
	if hovered then
		color.border = self.theme.CPButtonBorderHovered
		color.background = self.theme.CPButtonHovered
	end
	if active then
		color.background = self.theme.CPButtonActive
	end

	local p_minX = winX + cursorX - scrollX
  local p_minY = winY + cursorY - scrollY
	local p_maxX = p_minX + size_x
	local p_maxY = p_minY + size_y
	local label_width, label_height = ImGui.CalcTextSize(label, true)
	local label_x = (size_x - label_width) * 0.5 + p_minX
	local label_y = (size_y - label_height) * 0.5 + p_minY
	local corner_size = rounding(ImGui.GetFontSize() * 0.5)
	-- draw background
	ImGui.ImDrawListAddRectFilled(drawList, p_minX, p_minY, p_maxX - corner_size, p_maxY, ImGui.ColorConvertFloat4ToU32(color.background))
	ImGui.ImDrawListAddRectFilled(drawList, p_minX, p_minY, p_maxX, p_maxY - corner_size, ImGui.ColorConvertFloat4ToU32(color.background))
	ImGui.ImDrawListAddTriangleFilled(drawList, p_maxX - corner_size, p_maxY - corner_size, p_maxX, p_maxY - corner_size, p_maxX - corner_size, p_maxY, ImGui.ColorConvertFloat4ToU32(color.background))
	-- draw border
	ImGui.ImDrawListAddLine(drawList, p_minX, p_minY, p_maxX, p_minY, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, p_maxX, p_minY, p_maxX, p_maxY - corner_size, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, p_maxX, p_maxY - corner_size, p_maxX- corner_size, p_maxY, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, p_maxX- corner_size, p_maxY, p_minX, p_maxY, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, p_minX, p_maxY, p_minX, p_minY, ImGui.ColorConvertFloat4ToU32(color.border))
	-- draw text
	ImGui.ImDrawListAddText(drawList, label_x, label_y, ImGui.ColorConvertFloat4ToU32(self.theme.CPButtonText), trimLabel(label))
	return pressed
end

-- CPToggle
function CPStyle:CPToggle(label, label_off, label_on, value, sizex, sizey)
	local drawList = ImGui.GetWindowDrawList()
	local winX, winY = ImGui.GetWindowPos()
	local cursorX, cursorY = ImGui.GetCursorPos()
	local scrollX = ImGui.GetScrollX()
  local scrollY = ImGui.GetScrollY()
	local pressed_off, pressed_on, pressed

	-- insert btn
	ImGui.BeginGroup()

	ImGui.BeginGroup()
	ImGui.SetCursorPos(cursorX, cursorY)

	local btn_width = rounding(sizex/2 - 2)
	local btn_height = sizey

	pressed_off = self:InvisibleButton(label_off, btn_width, sizey)
	if sizey == 0 then
		btn_width, btn_height = ImGui.GetItemRectSize()
	end
	ImGui.SetCursorPos(cursorX + sizex/2 + 1, cursorY)
	pressed_on = self:InvisibleButton(label_on, btn_width, sizey)
	ImGui.EndGroup()
	local active = ImGui.IsItemActive()
	local hovered = ImGui.IsItemHovered()

	ImGui.SetCursorPos(cursorX + sizex + 4, cursorY)
	ImGui.AlignTextToFramePadding()
	ImGui.Text(trimLabel(label))
	ImGui.EndGroup()

	-- calc postion
	local btn_off_posX = winX + cursorX - scrollX
	local btn_on_posX = rounding(btn_off_posX + sizex/2 + 1)
	local btn_posY = winY + cursorY - scrollY
	local corner_size = rounding(ImGui.GetFontSize() * 0.5)

	local btn_off_pos = {
		p1 = { x = btn_off_posX, y = btn_posY },
		p2 = { x = btn_off_posX + btn_width, y = btn_posY },
		p3 = { x = btn_off_posX + btn_width, y = btn_posY + btn_height },
		p4 = { x = btn_off_posX + corner_size, y = btn_posY + btn_height },
		p5 = { x = btn_off_posX, y = btn_posY + btn_height - corner_size }
	}
	local btn_on_pos = {
		p1 = { x = btn_on_posX, y = btn_posY },
		p2 = { x = btn_on_posX + btn_width, y = btn_posY },
		p3 = { x = btn_on_posX + btn_width, y = btn_posY + btn_height - corner_size },
		p4 = { x = btn_on_posX + btn_width - corner_size, y = btn_posY + btn_height },
		p5 = { x = btn_on_posX, y = btn_posY + btn_height }
	}
	local label_off_width, label_height = ImGui.CalcTextSize(label_off, true)
	local label_on_width = ImGui.CalcTextSize(label_on, true)
	local label_off_x = (btn_width  - label_off_width) * 0.5 + btn_off_posX
	local label_on_x = (btn_width - label_on_width) * 0.5 + btn_on_posX
	local label_y = (btn_height - label_height) * 0.5 + btn_posY

	-- color
	local color = {}
	if value then
		if not hovered or active then
			color.btn_off_background = self.theme.CPToggleOffDisabled
			color.btn_off_border = self.theme.CPToggleOffDisabledBorder
			color.btn_off_text = self.theme.CPToggleOffDisabledText
			color.btn_on_background = self.theme.CPToggleOn
			color.btn_on_border = self.theme.CPToggleOnBorder
			color.btn_on_text = self.theme.CPToggleOnText
		else
			color.btn_off_background = self.theme.CPToggleOffDisabledHovered
			color.btn_off_border = self.theme.CPToggleOffDisabledBorderHovered
			color.btn_off_text = self.theme.CPToggleOffDisabledTextHovered
			color.btn_on_background = self.theme.CPToggleOnHovered
			color.btn_on_border = self.theme.CPToggleOnBorderHovered
			color.btn_on_text = self.theme.CPToggleOnTextHovered
		end
	else
		if not hovered or active then
			color.btn_off_background = self.theme.CPToggleOff
			color.btn_off_border = self.theme.CPToggleOffBorder
			color.btn_off_text = self.theme.CPToggleOffText
			color.btn_on_background = self.theme.CPToggleOnDisabled
			color.btn_on_border = self.theme.CPToggleOnDisabledBorder
			color.btn_on_text = self.theme.CPToggleOnDisabledText
		else
			color.btn_off_background = self.theme.CPToggleOffHovered
			color.btn_off_border = self.theme.CPToggleOffBorderHovered
			color.btn_off_text = self.theme.CPToggleOffTextHovered
			color.btn_on_background = self.theme.CPToggleOnDisabledHovered
			color.btn_on_border = self.theme.CPToggleOnDisabledBorderHovered
			color.btn_on_text = self.theme.CPToggleOnDisabledTextHovered
		end
	end

	-- draw background
	ImGui.ImDrawListAddRectFilled(drawList, btn_off_pos.p4.x, btn_off_pos.p1.y, btn_off_pos.p3.x, btn_off_pos.p3.y, ImGui.ColorConvertFloat4ToU32(color.btn_off_background))
	ImGui.ImDrawListAddRectFilled(drawList, btn_off_pos.p1.x, btn_off_pos.p1.y, btn_off_pos.p4.x, btn_off_pos.p5.y, ImGui.ColorConvertFloat4ToU32(color.btn_off_background))
	ImGui.ImDrawListAddTriangleFilled(drawList, btn_off_pos.p5.x, btn_off_pos.p5.y, btn_off_pos.p4.x, btn_off_pos.p5.y, btn_off_pos.p4.x, btn_off_pos.p4.y, ImGui.ColorConvertFloat4ToU32(color.btn_off_background))
	ImGui.ImDrawListAddRectFilled(drawList, btn_on_pos.p1.x, btn_on_pos.p1.y, btn_on_pos.p4.x, btn_on_pos.p4.y, ImGui.ColorConvertFloat4ToU32(color.btn_on_background))
	ImGui.ImDrawListAddRectFilled(drawList, btn_on_pos.p4.x, btn_on_pos.p1.y, btn_on_pos.p3.x, btn_on_pos.p3.y, ImGui.ColorConvertFloat4ToU32(color.btn_on_background))
	ImGui.ImDrawListAddTriangleFilled(drawList, btn_on_pos.p4.x, btn_on_pos.p3.y, btn_on_pos.p2.x, btn_on_pos.p3.y, btn_on_pos.p4.x, btn_on_pos.p4.y, ImGui.ColorConvertFloat4ToU32(color.btn_on_background))
	-- draw border
	ImGui.ImDrawListAddLine(drawList, btn_off_pos.p1.x, btn_off_pos.p1.y, btn_off_pos.p2.x, btn_off_pos.p2.y, ImGui.ColorConvertFloat4ToU32(color.btn_off_border))
	ImGui.ImDrawListAddLine(drawList, btn_off_pos.p2.x, btn_off_pos.p2.y, btn_off_pos.p3.x, btn_off_pos.p3.y, ImGui.ColorConvertFloat4ToU32(color.btn_off_border))
	ImGui.ImDrawListAddLine(drawList, btn_off_pos.p3.x, btn_off_pos.p3.y, btn_off_pos.p4.x, btn_off_pos.p4.y, ImGui.ColorConvertFloat4ToU32(color.btn_off_border))
	ImGui.ImDrawListAddLine(drawList, btn_off_pos.p4.x, btn_off_pos.p4.y, btn_off_pos.p5.x, btn_off_pos.p5.y, ImGui.ColorConvertFloat4ToU32(color.btn_off_border))
	ImGui.ImDrawListAddLine(drawList, btn_off_pos.p5.x, btn_off_pos.p5.y, btn_off_pos.p1.x, btn_off_pos.p1.y, ImGui.ColorConvertFloat4ToU32(color.btn_off_border))
	ImGui.ImDrawListAddLine(drawList, btn_on_pos.p1.x, btn_on_pos.p1.y, btn_on_pos.p2.x, btn_on_pos.p2.y, ImGui.ColorConvertFloat4ToU32(color.btn_on_border))
	ImGui.ImDrawListAddLine(drawList, btn_on_pos.p2.x, btn_on_pos.p2.y, btn_on_pos.p3.x, btn_on_pos.p3.y, ImGui.ColorConvertFloat4ToU32(color.btn_on_border))
	ImGui.ImDrawListAddLine(drawList, btn_on_pos.p3.x, btn_on_pos.p3.y, btn_on_pos.p4.x, btn_on_pos.p4.y, ImGui.ColorConvertFloat4ToU32(color.btn_on_border))
	ImGui.ImDrawListAddLine(drawList, btn_on_pos.p4.x, btn_on_pos.p4.y, btn_on_pos.p5.x, btn_on_pos.p5.y, ImGui.ColorConvertFloat4ToU32(color.btn_on_border))
	ImGui.ImDrawListAddLine(drawList, btn_on_pos.p5.x, btn_on_pos.p5.y, btn_on_pos.p1.x, btn_on_pos.p1.y, ImGui.ColorConvertFloat4ToU32(color.btn_on_border))
	-- draw text
	ImGui.ImDrawListAddText(drawList, label_off_x, label_y, ImGui.ColorConvertFloat4ToU32(color.btn_off_text), trimLabel(label_off))
	ImGui.ImDrawListAddText(drawList, label_on_x, label_y, ImGui.ColorConvertFloat4ToU32(color.btn_on_text), trimLabel(label_on))

	if pressed_off and value == false then
		value = true
	elseif pressed_off and value == true then
		value = false
	elseif pressed_on and value == true then
		value = false
	elseif pressed_on and value == false then
		value = true
	end
	if pressed_off or pressed_on then pressed = true else pressed = false end
	return value, pressed
end

CPStyle.CPCollapsingHeader_state = {}

function CPStyle:SetCPCollapsingHeaderState(label, state)
	if type(state) == "boolean" then
		self.CPCollapsingHeader_state[label] = state
	end
end

function CPStyle:CPCollapsingHeader(label, sizex, sizey)
	local drawList = ImGui.GetWindowDrawList()
	local winX, winY = ImGui.GetWindowPos()
	local cursorX, cursorY = ImGui.GetCursorPos()
	local scrollX = ImGui.GetScrollX()
  local scrollY = ImGui.GetScrollY()

	if sizex == nil or sizey == nil then
		sizex = ImGui.GetContentRegionAvail() - 4
		sizey = 0
	elseif sizex == 0 then
		sizex = ImGui.GetContentRegionAvail() - 4
	end

	-- insert button
	local pressed = self:InvisibleButton(label, sizex, sizey)
	local active = ImGui.IsItemActive()
	local hovered = ImGui.IsItemHovered()
	local header_width, header_height = ImGui.GetItemRectSize()
	-- color
	local color = {}
	color.text = self.theme.CPCollapsingHeaderText
	if not hovered or active then
		color.background = self.theme.CPCollapsingHeaderBg
		color.border = self.theme.CPCollapsingHeaderBorder
	else
		color.background = self.theme.CPCollapsingHeaderBgHovered
		color.border = self.theme.CPCollapsingHeaderBorderHovered
	end

	-- calc postion
	local fontsize = ImGui.GetFontSize()
	local leftrect_posX = winX + cursorX - scrollX
	local leftrect_width = rounding(fontsize * 0.4)
	local mainrect_posX = leftrect_posX + leftrect_width + 2
	local mainrect_width = header_width - leftrect_width - 2
	local corner_size = rounding(fontsize * 0.5)
	local header_posY = winY + cursorY - scrollY

	local label_width, label_height = ImGui.CalcTextSize(label, true)
	local label_x = 10 * fontsize/13 + mainrect_posX
	local label_y = (header_height - label_height) * 0.5 + header_posY

	local leftrect_pos = {
		p1 = { x = leftrect_posX, y = header_posY },
		p2 = { x = leftrect_posX + leftrect_width, y = header_posY },
		p3 = { x = leftrect_posX + leftrect_width, y = header_posY + header_height },
		p4 = { x = leftrect_posX, y = header_posY + header_height },
	}
	local mainrect_pos = {
		p1 = { x = mainrect_posX, y = header_posY },
		p2 = { x = mainrect_posX + mainrect_width, y = header_posY },
		p3 = { x = mainrect_posX + mainrect_width, y = header_posY + header_height - corner_size },
		p4 = { x = mainrect_posX + mainrect_width - corner_size, y = header_posY + header_height },
		p5 = { x = mainrect_posX, y = header_posY + header_height },
	}
	-- draw background
	ImGui.ImDrawListAddRectFilled(drawList, leftrect_pos.p1.x, leftrect_pos.p1.y, leftrect_pos.p3.x, leftrect_pos.p3.y, ImGui.ColorConvertFloat4ToU32(color.background))
	ImGui.ImDrawListAddRectFilled(drawList, mainrect_pos.p1.x, mainrect_pos.p1.y, mainrect_pos.p4.x, mainrect_pos.p4.y, ImGui.ColorConvertFloat4ToU32(color.background))
	ImGui.ImDrawListAddRectFilled(drawList, mainrect_pos.p4.x, mainrect_pos.p1.y, mainrect_pos.p3.x, mainrect_pos.p3.y, ImGui.ColorConvertFloat4ToU32(color.background))
	ImGui.ImDrawListAddTriangleFilled(drawList, leftrect_pos.p4.x, leftrect_pos.p3.y, leftrect_pos.p3.x, leftrect_pos.p3.y, leftrect_pos.p4.x, leftrect_pos.p4.y, ImGui.ColorConvertFloat4ToU32(color.background))

	-- draw border
	ImGui.ImDrawListAddLine(drawList, leftrect_pos.p1.x, leftrect_pos.p1.y, leftrect_pos.p2.x, leftrect_pos.p2.y, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, leftrect_pos.p2.x, leftrect_pos.p2.y, leftrect_pos.p3.x, leftrect_pos.p3.y, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, leftrect_pos.p3.x, leftrect_pos.p3.y, leftrect_pos.p4.x, leftrect_pos.p4.y, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, leftrect_pos.p4.x, leftrect_pos.p4.y, leftrect_pos.p1.x, leftrect_pos.p1.y, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, mainrect_pos.p1.x, mainrect_pos.p1.y, mainrect_pos.p2.x, mainrect_pos.p2.y, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, mainrect_pos.p2.x, mainrect_pos.p2.y, mainrect_pos.p3.x, mainrect_pos.p3.y, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, mainrect_pos.p3.x, mainrect_pos.p3.y, mainrect_pos.p4.x, mainrect_pos.p4.y, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, mainrect_pos.p4.x, mainrect_pos.p4.y, mainrect_pos.p5.x, mainrect_pos.p5.y, ImGui.ColorConvertFloat4ToU32(color.border))
	ImGui.ImDrawListAddLine(drawList, mainrect_pos.p5.x, mainrect_pos.p5.y, mainrect_pos.p1.x, mainrect_pos.p1.y, ImGui.ColorConvertFloat4ToU32(color.border))

	--draw text
	ImGui.ImDrawListAddText(drawList, label_x, label_y, ImGui.ColorConvertFloat4ToU32(color.text), trimLabel(label))

	if pressed then
		self.CPCollapsingHeader_state[label] = not self.CPCollapsingHeader_state[label]
	end
	return self.CPCollapsingHeader_state[label]
end

function CPStyle:CPToolTip1Begin(sizex, sizey)
	CPStyle.styleBegin("WindowRounding", 0)
	CPStyle.styleBegin("PopupBorderSize", 0)
	CPStyle.styleBegin("ChildBorderSize", 1)
	CPStyle.colorBegin("PopupBg", self.theme.Hidden)
	CPStyle.colorBegin("ChildBg", self.theme.CPFrameBg)
	ImGui.BeginTooltip()
	CPStyle:CPRect("##SideRect", 8, sizey, self.theme.CPFrameBg, self.theme.CPFrameBorder, 1, 0)
	ImGui.SameLine(20)
	ImGui.BeginGroup()
	ImGui.BeginChild("ToolTipMain", sizex, sizey, true)
end

function CPStyle:CPToolTip1End()
	ImGui.EndChild()
	ImGui.EndGroup()
	ImGui.EndTooltip()
	CPStyle.colorEnd(2)
	CPStyle.styleEnd(3)
end

function CPStyle:CPToolTip2Begin(sizex, sizey)
	CPStyle.styleBegin("WindowRounding", 0)
	CPStyle.styleBegin("PopupBorderSize", 0)
	CPStyle.styleBegin("ChildBorderSize", 1)
	CPStyle.colorBegin("PopupBg", self.theme.Hidden)
	CPStyle.colorBegin("ChildBg", self.theme.CPToolTip2Bg)
	CPStyle.colorBegin("Border", self.theme.CPToolTip2Border)
	CPStyle.colorBegin("Separator", self.theme.CPToolTip2Separator)
	ImGui.BeginTooltip()
	CPStyle:CPRect("##SideRect", 8, sizey, self.theme.CPToolTip2SideBg, self.theme.CPToolTip2Border, 1, 0)
	ImGui.SameLine(16)
	ImGui.BeginGroup()
	ImGui.BeginChild("ToolTip2Main", sizex, sizey, true)
end

function CPStyle:CPToolTip2End()
	ImGui.EndChild()
	ImGui.EndGroup()
	ImGui.EndTooltip()
	CPStyle.colorEnd(4)
	CPStyle.styleEnd(3)
end

function CPStyle:CPRect(label, sizex, sizey, color, border_color, border_size, border_rounding, textalignx, textaligny)
	if border_color == nil then border_color = self.theme.Border end
	if border_size == nil then border_size = 0 end
	if border_rounding == nil then border_rounding = 0 end
	if textalignx == nil then textalignx = 0.5 end
	if textaligny == nil then textaligny = 0.5 end
	CPStyle.colorBegin("Border", border_color)
	CPStyle.colorBegin("Button", color)
	CPStyle.colorBegin("ButtonActive", color)
	CPStyle.colorBegin("ButtonHovered", color)
	CPStyle.styleBegin("FrameBorderSize", border_size)
	CPStyle.styleBegin("FrameRounding", border_rounding)
	CPStyle.styleBegin("ButtonTextAlign", textalignx, textaligny)
	local press = ImGui.Button(label, sizex, sizey)
	CPStyle.styleEnd(3)
	CPStyle.colorEnd(4)
	return press
end

function CPStyle:CPRect2(label, sizex, sizey, color)
	CPStyle.colorBegin("ChildBg", color)
	ImGui.BeginChild(label, sizex, sizey)
  ImGui.EndChild()
	CPStyle.colorEnd(1)
end

function CPStyle:CPDraw(name, image, scale)
  ImGui.BeginGroup()
  local basex, basey = ImGui.GetCursorPos()
  local pixelx = 1
  local pixely = 1
  local cursorx = basex
  local cursory = basey
  local totalPixel = image.width*image.height
  for i = 1, totalPixel do
    ImGui.SetCursorPos(cursorx, cursory)
    if image.pixels[pixely][pixelx][4] ~= 0 then
      CPStyle:CPRect2("##"..name..i, scale*1.2, scale*1.2, image.pixels[pixely][pixelx])
    end
    pixelx = pixelx + 1
    if pixelx > image.width then pixelx = 1 pixely = pixely + 1 end
    cursorx = basex+(pixelx-1)*scale
    cursory = basey+(pixely-1)*scale
  end
  ImGui.EndGroup()
end

function CPStyle:CPDraw2(drawlist, posX, posY, image, scale)
  ImGui.BeginGroup()
  local pixelx = 1
  local pixely = 1
  local cursorx = posX
  local cursory = posY
  local totalPixel = image.width*image.height
  for i = 1, totalPixel do
    if image.pixels[pixely][pixelx][4] ~= 0 then
			ImGui.ImDrawListAddRectFilled(drawlist, cursorx, cursory, cursorx+scale, cursory+scale, ImGui.GetColorU32(table.unpack(image.pixels[pixely][pixelx])))
    end
    pixelx = pixelx + 1
    if pixelx > image.width then pixelx = 1 pixely = pixely + 1 end
    cursorx = posX+(pixelx-1)*scale
    cursory = posY+(pixely-1)*scale
  end
  ImGui.EndGroup()
end



CPStyle.Input = { enable = false }

function CPStyle.Input:Enable(state)
	if state == nil then
		self.enable = not self.enbale
	else
		self.enable = state
	end
end

function CPStyle.Input:Register()
	if self.enable then
		CPS.colorBegin("WindowBg", CPStyle.color.hidden)
		CPS.colorBegin("FrameBg", CPStyle.color.hidden)
		CPS.colorBegin("Text", CPStyle.color.hidden)
		CPS.colorBegin("NavHighlight", CPStyle.color.hidden)
		CPS.colorBegin("Border", CPStyle.color.hidden)
		ImGui.Begin("##CPStyle.Input", bit32.bor(ImGuiWindowFlags.NoTitleBar, ImGuiWindowFlags.NoResize))
		ImGui.SetKeyboardFocusHere()
		self.keypress, self.pressed = ImGui.InputText("##keyboardinput", "", 100)
		if self.pressed then ImGui.SetKeyboardFocusHere() end
		ImGui.InputText("##dummy", "", 100)
		ImGui.End()
		CPS.colorEnd(5)
	end
end

function CPStyle.Input:GetKeyPress()
	if self.keypress == "" then
		return nil
	else
		return self.keypress
	end
end

return CPStyle
