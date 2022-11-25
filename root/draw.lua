--
-- Developer Extras v3
-- 2022 by FreakaZ
--
-- https://rootpunk.com/mod/#developerextras
-- https://github.com/rp-freakaz/DeveloperExtras
-- hello@rootpunk.com
--
local DRAW = {}

-- libraries
local UTIL = require("root/util.lua"):Prelude()

--
--// DRAW:GetColor(<STRING>,<STRING>,<INT>)
--
function DRAW:GetColor(color, style, state)

	-- catch non set
	local color = color or "Transparent"
	local style = style or "Normal"
	local state = state or 0

	-- transparency
	if color == "Transparent" 	 			then return ImGui.GetColorU32(0, 0, 0, 0) end

	-- black
	if color == "Black" and style == "Normal"		then return ImGui.GetColorU32(0.04, 0.04, 0.06, DRAW:GetState(state, 0.85)) end
	if color == "Black" and style == "Light"		then return ImGui.GetColorU32(0.1, 0.1, 0.12, DRAW:GetState(state, 0.5)) end
	if color == "Black" and style == "Dark"			then return ImGui.GetColorU32(0.01, 0.01, 0.03, DRAW:GetState(state, 0.9)) end

	-- white
	if color == "White" and style == "Normal"		then return ImGui.GetColorU32(0.9, 0.9, 1, DRAW:GetState(state, 0.9)) end
	if color == "White" and style == "Light"		then return ImGui.GetColorU32(0.9, 0.9, 1, DRAW:GetState(state, 1)) end
	if color == "White" and style == "Dark"			then return ImGui.GetColorU32(0.8, 0.8, 0.85, DRAW:GetState(state, 0.8)) end

	-- orange
	if color == "Orange" and style == "Normal"		then return ImGui.GetColorU32(1, 0.56, 0.13, DRAW:GetState(state, 0.85)) end
	if color == "Orange" and style == "Light"		then return ImGui.GetColorU32(1, 0.56, 0.13, DRAW:GetState(state, 1)) end
	if color == "Orange" and style == "Dark"		then return ImGui.GetColorU32(1, 0.56, 0.13, DRAW:GetState(state, 0.70)) end

	if color == "Orange" and style == "Border"		then return ImGui.GetColorU32(0.2, 0.2, 0.23, 0.5) end


	-- grey
	if color == "Grey" and style == "Normal"		then return ImGui.GetColorU32(0.4, 0.4, 0.43, DRAW:GetState(state, 0.7)) end

	if color == "Grey" and style == "Light"			then return ImGui.GetColorU32(0.5, 0.5, 0.53, DRAW:GetState(state, 0.7)) end
	if color == "Grey" and style == "Lighter"		then return ImGui.GetColorU32(0.6, 0.6, 0.63, DRAW:GetState(state, 0.8)) end
	if color == "Grey" and style == "Lightest"		then return ImGui.GetColorU32(0.7, 0.7, 0.73, DRAW:GetState(state, 0.9)) end

	if color == "Grey" and style == "Dark"			then return ImGui.GetColorU32(0.3, 0.3, 0.33, DRAW:GetState(state, 0.7)) end
	if color == "Grey" and style == "Darker"		then return ImGui.GetColorU32(0.2, 0.2, 0.23, DRAW:GetState(state, 0.7)) end
	if color == "Grey" and style == "Darkest"		then return ImGui.GetColorU32(0.1, 0.1, 0.13, DRAW:GetState(state, 0.7)) end


	-- logo
	if color == "Orange" and style == "Logo"		then return ImGui.GetColorU32(1, 0.56, 0.13, state) end
	if color == "White" and style == "Logo"			then return ImGui.GetColorU32(0.9, 0.9, 1, state) end
	if color == "Grey" and style == "Logo"			then return ImGui.GetColorU32(0.4, 0.4, 0.43, state) end

	-- graph overlay definitions
	--if color == "graph_black"				then return ImGui.GetColorU32(0, 0, 0.03, state) end
	--if color == "graph_white"				then return ImGui.GetColorU32(1, 1, 1, state) end
	--if color == "graph_orange"				then return ImGui.GetColorU32(1, 0.56, 0.13, state) end

	--if color == "graph_grey_normal"				then return ImGui.GetColorU32(0.5, 0.5, 0.52, state) end
	--if color == "graph_grey_dark"				then return ImGui.GetColorU32(0.2, 0.2, 0.22, state) end
	--if color == "graph_grey_light"				then return ImGui.GetColorU32(0.7, 0.7, 0.72, state) end

	-- logo animation definitions
	--if color == "logo_orange"				then return ImGui.GetColorU32(1, 0.56, 0.13, state) end
	--if color == "logo_white"				then return ImGui.GetColorU32(1, 1, 1, state) end
	--if color == "logo_grey"					then return ImGui.GetColorU32(0.4, 0.4, 0.43, state) end
end

--
--// DRAW:GetState(<INT>,<FLOAT>)
--
function DRAW:GetState(state, trans)
	if state > 0 then
		return UTIL:ShortenFloat(trans / 1.5)
	else
		return trans
	end
end

--
--// DRAW:WindowStart()
--
function DRAW:WindowStart()

	-- absolute position
	ImGui.SetNextWindowPos(100, 100, ImGuiCond.FirstUseEver)
	ImGui.SetNextWindowSizeConstraints(UTIL:ScaleSwitch(456, true), UTIL:ScaleSwitch(600, true), UTIL:ScaleSwitch(1500, true), DRAW.Scaling.Screen.Height - 100)

	-- global styles
	ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarSize, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarRounding, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing, UTIL:ScaleSwitch(2), 0)
	ImGui.PushStyleVar(ImGuiStyleVar.GrabRounding, UTIL:ScaleSwitch(2))

	--
	-- window decoration
	--

	-- define colors
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Light"))
	ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColor("Orange","Border"))
	ImGui.PushStyleColor(ImGuiCol.WindowBg, DRAW:GetColor("Black","Dark"))

	ImGui.PushStyleColor(ImGuiCol.TitleBg, DRAW:GetColor("Black","Dark"))
	ImGui.PushStyleColor(ImGuiCol.TitleBgActive, DRAW:GetColor("Black","Dark"))
	ImGui.PushStyleColor(ImGuiCol.TitleBgCollapsed, DRAW:GetColor("Black","Dark"))

	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor())

	ImGui.PushStyleColor(ImGuiCol.ResizeGrip, DRAW:GetColor("Grey","Dark"))
	ImGui.PushStyleColor(ImGuiCol.ResizeGripActive, DRAW:GetColor("Orange","Normal"))
	ImGui.PushStyleColor(ImGuiCol.ResizeGripHovered, DRAW:GetColor("Orange","Light"))

	-- define styles
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, UTIL:ScaleSwitch(4))
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:ScaleSwitch(8), UTIL:ScaleSwitch(10))
	ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing, UTIL:ScaleSwitch(7), 0)

	-- trigger
	local _trigger

	-- native scaling
	if DRAW.Scaling.Enable
	then
		-- create window
		_trigger = ImGui.Begin("~ "..string.upper(DRAW.Project).." ~", ImGuiWindowFlags.NoScrollbar)
		ImGui.SetWindowFontScale(DRAW.Scaling.Font)
	else
		-- create window
		_trigger = ImGui.Begin(UTIL:SpaceBetween(DRAW.Project.." v"..DRAW.Version.String, "CET "..DRAW.Version.Cet.String.." // PATCH "..DRAW.Version.Game.String, ImGui.GetWindowWidth() - 36, UTIL:TextWidth(" ")), ImGuiWindowFlags.NoScrollbar)
	end

	-- drop stacks
	ImGui.PopStyleVar(4)
	ImGui.PopStyleColor(12)

	return _trigger
end

--
--// DRAW:WindowEnd()
--
function DRAW:WindowEnd()

	-- global styles
	ImGui.PopStyleVar(7)

	-- end window
	ImGui.End()
end

--
--// DRAW:TabbarStart()
--
function DRAW:TabbarStart()

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Tab, DRAW:GetColor("Grey","Darker"))
	ImGui.PushStyleColor(ImGuiCol.TabActive, DRAW:GetColor("Orange","Normal"))
	ImGui.PushStyleColor(ImGuiCol.TabHovered, DRAW:GetColor("Orange","Light"))

	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:ScaleSwitch(4), UTIL:ScaleSwitch(6))

	-- fix left align
	DRAW:Spacer(1,1)

	-- create tabbar
	local _trigger = ImGui.BeginTabBar("DE_Tabbar")

	-- drop stacks
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(3)

	return _trigger
end

--
--// DRAW:TabbarEnd()
--
function DRAW:TabbarEnd()
	ImGui.EndTabBar()
end

--
--// DRAW:TabitemStart()
--
function DRAW:TabitemStart(title)

	-- catch non set
	local title = title or "Unknown"

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal"))
	ImGui.PushStyleColor(ImGuiCol.Tab, DRAW:GetColor("Grey","Darker"))
	ImGui.PushStyleColor(ImGuiCol.TabActive, DRAW:GetColor("Orange","Normal"))
	ImGui.PushStyleColor(ImGuiCol.TabHovered, DRAW:GetColor("Orange","Light"))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:ScaleSwitch(7), UTIL:ScaleSwitch(6))

	-- create tabitem
	local _trigger = ImGui.BeginTabItem("¨"..title)

	-- drop stacks
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(4)

	return _trigger
end

--
--// DRAW:TabitemEnd()
--
function DRAW:TabitemEnd()

	ImGui.EndTabItem()
end

--
--// DRAW:TabchildStart()
--
function DRAW:TabchildStart(width, height, scroll)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.ScrollbarBg, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrab, DRAW:GetColor("Orange","Dark"))
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabHovered, DRAW:GetColor("Orange","Normal"))

	-- add scrollbar
	if scroll
	then
		ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarSize, UTIL:ScaleSwitch(10))
	end

	-- child flags
	--local _flags = "ImGuiWindowFlags.NoTitleBar + ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoResize + ImGuiWindowFlags.NoCollapse + ImGuiWindowFlags.NoMove + ImGuiWindowFlags.NoBackground + ImGuiWindowFlags.AlwaysAutoResize"

	-- create child
	local _trigger = ImGui.BeginChild("DE_Tabchild", width, height, false, ImGuiWindowFlags.AlwaysVerticalScrollbar + ImGuiWindowFlags.NoBackground)

	-- del scroll
	if scroll
	then
		ImGui.PopStyleVar(1)
	end

	-- del stacks
	ImGui.PopStyleColor(3)

	return _trigger
end

--
--// DRAW:TabchildEnd()
--
function DRAW:TabchildEnd()
	ImGui.EndChild()
end

--
--// DRAW:Collapse()
--
function DRAW:Collapse(title, scale)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal"))
	ImGui.PushStyleColor(ImGuiCol.Header, DRAW:GetColor("Grey","Darker"))
	ImGui.PushStyleColor(ImGuiCol.HeaderActive, DRAW:GetColor("Orange","Normal"))
	ImGui.PushStyleColor(ImGuiCol.HeaderHovered, DRAW:GetColor("Orange","Light"))

	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:ScaleSwitch(8), UTIL:ScaleSwitch(11))



	-- space before
	DRAW:Spacing(1,UTIL:ScaleSwitch(3))

	-- create collapse
	local _trigger = ImGui.CollapsingHeader(title)

	-- drop stacks
	ImGui.PopStyleVar(2)
	ImGui.PopStyleColor(4)

	return _trigger
end

--
--// DRAW:CollapseNotice()
--
function DRAW:CollapseNotice(text)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Orange","Normal"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Orange","Normal"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Orange","Normal"))

	ImGui.PushID("Button"..tostring("CollapseNoticeSign"))
	local _blind = ImGui.Button("", UTIL:ScaleSwitch(5), UTIL:ScaleSwitch(30))
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleColor(3)

	-- sameline
	DRAW:Sameline()

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark"))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Grey","Darkest"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Grey","Darkest"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Grey","Darkest"))

	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:ScaleSwitch(6), UTIL:ScaleSwitch(6))
	ImGui.PushStyleVar(ImGuiStyleVar.ButtonTextAlign, 0, 0)

	ImGui.PushID("Button"..tostring("CollapseNoticeText"))
	local _blind = ImGui.Button(tostring(text), UTIL:ScaleSwitch(456), UTIL:ScaleSwitch(30))
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(2)
	ImGui.PopStyleColor(4)
end



















































--
--// DRAW:Spacer(<INT>,<INT>)
--
function DRAW:Spacer(width, height)

	-- catch non set
	local width = width or 0
	local height = height or 0

	ImGui.Dummy(width, height)
	DRAW:Sameline()
end

--
--// DRAW:Spacing(<INT>,<INT>)
--
function DRAW:Spacing(width, height)

	-- catch non set
	local width = width or 0
	local height = height or 0

	ImGui.Dummy(width, height)
end

--
--// DRAW:Sameline(<INT>,<INT>)
--
function DRAW:Sameline(width, height)

	-- catch non set
	local width = width or 0
	local height = height or 0

	ImGui.SameLine()
end

--
--// DRAW:Separator()
--
function DRAW:Separator(height, top, bot, color, style)

	-- catch non set
	local top = top or 0
	local bot = bot or 0
	local color = color or false
	local style = style or false

	-- select color
	if color
	then
		-- select style
		if style
		then
			ImGui.PushStyleColor(ImGuiCol.Separator, DRAW:GetColor(color, style))
		else
			ImGui.PushStyleColor(ImGuiCol.Separator, DRAW:GetColor(color, "Normal"))
		end
	else
		ImGui.PushStyleColor(ImGuiCol.Separator, DRAW:GetColor("Grey", "Darkest"))
	end

	-- needed for display
	ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 0, 1)

	-- top spacing
	if top > 0 then
		ImGui.Dummy(10, top)
	end

	-- multiple if wanted
	if height > 0 then
		for i=1, height do
			ImGui.Separator()
		end
	end

	if bot > 0 then
		ImGui.Dummy(10, bot)
	end

	-- needed somehow
	--ImGui.Dummy(10, 3)

	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(1)
end










--
--// DRAW:Title()
--
function DRAW:RenderTitle(demand, title, min, max)

	-- catch non set
	local min = min or false
	local max = max or false

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Dark",demand))
	ImGui.Text("»")
	ImGui.PopStyleColor(1)
	ImGui.SameLine()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))

	if min and max
	then
		DRAW:Spacer(8,1)
		ImGui.Text(title)
		ImGui.SameLine()
		DRAW:Spacer(8,1)
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Normal",demand))
		ImGui.Text(tostring(min)..' to '..tostring(max))
		ImGui.PopStyleColor(1)
	else
		DRAW:Spacer(8,1)
		ImGui.Text(title)
	end
	ImGui.PopStyleColor(1)
	DRAW:Spacing(1,1)
end














--
--// DRAW:Slider()
--
function DRAW:Slider(render, option, demand, value)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.SliderGrab, DRAW:GetColor("Orange","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, DRAW:GetColor("Orange","Light",demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("Grey","Darker",demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("Grey","Darker",demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("Grey","Darker",demand))

	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 2)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 2, 2)

	-- make them local before
	local _return, _trigger

	-- int slider (no title)
	if option.type == "int" or option.type == "Int"
	then
		ImGui.PushID('DE_SliderInt'..tostring(render.path))
		_return, _trigger = ImGui.SliderInt("", value, option.min, option.max)
		ImGui.PopID()
	end

	if option.type == "float" or option.type == "Float"
	then
		ImGui.PushID('DE_SliderFloat'..tostring(render.path))
		_return, _trigger = ImGui.SliderFloat("", value, option.min, option.max, option.res)
		ImGui.PopID()
	end

	-- drop stacks
	ImGui.PopStyleVar(2)
	ImGui.PopStyleColor(6)

	-- result
	return _return, _trigger
end



--
--// DRAW:SliderTitle()
--
function DRAW:SliderTitle(title, min, max, demand)

	-- catch non set
	local min = min or false
	local max = max or false

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Dark",demand))
	ImGui.Text("»")
	ImGui.PopStyleColor(1)
	ImGui.SameLine()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))

	if min and max
	then
		DRAW:Spacer(8,1)
		ImGui.Text(title)
		ImGui.SameLine()
		DRAW:Spacer(8,1)
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Normal",demand))
		ImGui.Text(tostring(min)..' to '..tostring(max))
		ImGui.PopStyleColor(1)
	else
		ImGui.Text(title)
	end
	ImGui.PopStyleColor(1)
end







--
--// DRAW.Button()
--
function DRAW:Button(render, option, demand, piece, value)

	-- catch non set
	local piece = tostring(piece) or true
	local value = tostring(value) or false

	if UTIL:IntToBool(demand)
	then
		ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Orange","Normal",demand))
		ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Orange","Light",demand))
	else
		ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Grey","Darker",demand))
		ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Grey","Darker",demand))
	end

	-- add stacks
	if piece == value and value ~= "Reset"
	then
		ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Orange","Normal",demand))
	else
		ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Grey","Darker",demand))
	end


	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal",demand))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 2)

	-- convert bool
	if option.type == "Bool"
	then
		if piece == "true" then piece = "On" end
		if piece == "false" then piece = "Off" end
	end

	ImGui.PushID("Button"..tostring(render.path))
	local _trigger = ImGui.Button(piece, UTIL:ButtonWidth(piece), UTIL:ButtonHeight(piece))
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(4)

	return _trigger
end

--
--// DRAW:ButtonTitle()
--
function DRAW:ButtonTitle(title, min, max, demand)

	-- catch non set
	local min = min or false
	local max = max or false

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Dark"))
	ImGui.Text("»")
	ImGui.PopStyleColor(1)
	DRAW:Sameline()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))

	if min and max then
		DRAW:Spacer(8,1)
		ImGui.Text(title)
		DRAW:Sameline()
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Normal",demand))
		ImGui.Text(tostring(min)..' to '..tostring(max))
		ImGui.PopStyleColor(1)
	else
		DRAW:Spacer(8,1)
		ImGui.Text(title)
	end
	ImGui.PopStyleColor(1)
end

--
--// DRAW:ButtonNotes()
--
function DRAW:ButtonNotes(render, pointer, demand)

	-- default
	local text = ""

	-- sameline
	DRAW:Sameline()
	DRAW:Spacer(7, 1)

	-- add color stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Orange","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Orange","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Orange","Light",demand))

	-- add style stacks
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 7)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 4, 1)

	-- draw blind button
	ImGui.PushID("Button"..tostring("ButtonNotes"))
	local _blind = ImGui.Button(tostring(pointer), 15, 15)
	ImGui.PopID()

	-- add tooltip
	if ImGui.IsItemHovered()
	then
		-- add note
		if render.note ~= nil
		then
			text = text..render.note
		end

		if render.rate ~= nil
		then
			-- already?
			if text ~= ""
			then
				text = text.."\n\nRating:"
			else
				text = text.."Rating:"
			end

			-- add perf
			if render.rate.performance
			then
				text = text.."\nPerformance: "..render.rate.performance
			end

			-- add vis
			if render.rate.visual
			then
				text = text.."\nVisual: "..render.rate.visual
			end
		end

		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal"))
		ImGui.BeginTooltip()
		ImGui.SetTooltip(text)
		ImGui.EndTooltip()
		ImGui.PopStyleColor(1)
	end

	-- drop stacks
	ImGui.PopStyleVar(2)
	ImGui.PopStyleColor(4)
end

























--
--// DRAW:Checkbox()
--
function DRAW:Checkbox(render, option, demand, value)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.CheckMark, DRAW:GetColor("White", "Normal", demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("Grey","Darker", demand))

	if UTIL:IntToBool(demand)
	then
		ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("Orange","Normal", demand))
		ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("Orange","Light", demand))
	else
		ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("Grey","Darker", demand))
		ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("Grey","Darker", demand))
	end

	-- text color depending on value
	if value
	then
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Orange","Normal", demand))
	else

		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal", demand))
	end

	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:ScaleSwitch(3))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:ScaleSwitch(3), UTIL:ScaleSwitch(3))
	ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing, UTIL:ScaleSwitch(8), 0)


	ImGui.PushID('DE_Checkbox'..tostring(render.path))
	local _return, _trigger = ImGui.Checkbox(render.name, value)
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(3)
	ImGui.PopStyleColor(5)

	-- result
	return _return, _trigger
end

--
--// DRAW:CheckboxDesc()
--
function DRAW:CheckboxDesc(render, option, demand)

	-- some room
	DRAW:Spacing(1,1)

	if render.spacing then
		DRAW:Spacer(render.spacing + 34,1)
	else
		DRAW:Spacer(44,1)
	end

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))
	ImGui.Text(render.desc)
	ImGui.PopStyleColor(1)
end
















--
--// DRAW:Quickswitch()
--
function DRAW:Quickswitch(render, option, demand, value)

	-- default spacing
	local _spacing = UTIL:ScaleSwitch(14)

	-- update spacing if present
	if render.spacing
	then
		_spacing = UTIL:ScaleSwitch(render.spacing)
	end

	-- paint leading spacing
	DRAW:Spacer(_spacing,1)

	ImGui.Text(render.name)
	DRAW:Sameline()


	DRAW:Spacer(DRAW.Scaling.Window.Width - (_spacing + UTIL:TextWidth(render.name) + UTIL:ScaleSwitch(82)),1)





	-- quickswitches has a fixed width
	ImGui.SetNextItemWidth(UTIL:ScaleSwitch(34))



	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.SliderGrab, DRAW:GetColor("Orange","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, DRAW:GetColor("Orange","Light",demand))
	ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColor("Grey","Dark",demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("Grey","Darker",demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("Grey","Darker",demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("Grey","Darker",demand))

	ImGui.PushStyleVar(ImGuiStyleVar.GrabRounding, UTIL:ScaleSwitch(10))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:ScaleSwitch(10))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FrameBorderSize, UTIL:ScaleSwitch(2))

	-- make them local before
	local _return, _trigger

	ImGui.PushID('DE_Quickswitch'..tostring(render.path))
	_return, _trigger = ImGui.SliderInt("", value, 0, 1)
	ImGui.PopID()



	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal",demand))

	DRAW:Sameline()
	DRAW:Spacer(10,1)
	ImGui.Text(UTIL:IntToText(value))

	ImGui.PopStyleColor(1)


	-- drop stacks
	ImGui.PopStyleVar(4)
	ImGui.PopStyleColor(7)



	if render.desc
	then
		DRAW:Spacing(1,UTIL:ScaleSwitch(2))

		if render.spacing then
			DRAW:Spacer(UTIL:ScaleSwitch(render.spacing) + UTIL:ScaleSwitch(14),1)
		else
			DRAW:Spacer(UTIL:ScaleSwitch(14),1)
		end

		-- add stacks
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))
		ImGui.Text(render.desc)
		ImGui.PopStyleColor(1)
	end

	-- result
	return _return, _trigger
end

































--
--// DRAW:About()
--
function DRAW:About()

	if DRAW.isDebug
	then
		-- some top room
		DRAW:Spacing(1, 10)

		ImGui.Text("Scaling is "..tostring(DRAW.Scaling.Enable))
		ImGui.Text("Screen Width: "..tostring(DRAW.Scaling.Screen.Width))
		ImGui.Text("Screen Height: "..tostring(DRAW.Scaling.Screen.Height))
		ImGui.Text("Screen Factor: "..tostring(DRAW.Scaling.Screen.Factor))
		ImGui.Text("Screen Pixels: "..tostring(DRAW.Scaling.Screen.Pixels))

		ImGui.Text("Window Width: "..tostring(DRAW.Scaling.Window.Width))
		ImGui.Text("Window Height: "..tostring(DRAW.Scaling.Window.Height))
		ImGui.Text("Window Factor: "..tostring(DRAW.Scaling.Window.Factor))
		ImGui.Text("Window Pixels: "..tostring(DRAW.Scaling.Window.Pixels))


		-- some bottom room
		DRAW:Spacing(1, 10)
	end

	-- some top room
	DRAW:Spacing(1, 44)

	-- draw animation
	DRAW:LogoAnimation()

	-- more room
	DRAW:Spacing(1,12)

	-- remove spacing between
	ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 0, 0)

	-- predefine
	local line = ""
	local part = {}

	-- print who
	line = "2022 BY FREAKAZ"
	part = UTIL:TextSplit(line)
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("White", "Normal", part[1], true)
	DRAW:PageText("Orange", "Normal", " "..part[2].." ", true)
	DRAW:PageText("White", "Normal", part[3], false)

	-- some room
	DRAW:Spacing(1,7)

	-- print website
	line = "https://rootpunk.com/mod/"
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("White", "Dark", line, false)

	-- some room
	DRAW:Spacing(1,7)

	-- print email
	line = "hello @ rootpunk.com"
	part = UTIL:TextSplit(line)
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Orange", "Dark", part[1], true)
	DRAW:PageText("Grey", "Light", " "..part[2].." ", true)
	DRAW:PageText("Orange", "Dark", part[3], false)

	-- some room
	DRAW:Spacing(1,25)

	-- print random
	line = "made in endless hours at day and night"
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line)
	line = "while struggling with LUA, CET and 2077"
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line)

	-- some room
	DRAW:Spacing(1,3)

	-- print judy
	line = "~ FOR JUDY ~"
	part = UTIL:TextSplit(line)
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", part[1].." ", true)
	local unlock = DRAW:PageButton("Orange", "Normal", part[2].." "..part[3], true)
	DRAW:PageText("Grey", "Lighter", " "..part[4], false)

	-- some room
	DRAW:Spacing(1,10)


	-- special thanks
	DRAW:AboutHeader("SPECIAL THANKS TO")
	DRAW:AboutSpecial("CD PROJEKT RED", "FOR CREATING THIS AWESOME WORLD", "https://cdprojektred.com/")
	DRAW:AboutSpecial("YAMASHI", "CYBER ENGINE TWEAKS", "https://github.com/yamashi/CyberEngineTweaks")
	DRAW:AboutSpecial("PSIBERX", "CET KIT", "https://github.com/psiberx/cp2077-cet-kit")




	-- section
	DRAW:AboutHeader("THANKS TO")
	DRAW:AboutThanks("AnnettK", "for being a friend, even in dark times")
	DRAW:AboutBreak()
	DRAW:AboutThanks("Halvkyrie", "who inspired me to get into modding")
	DRAW:AboutBreak()
	DRAW:AboutThanks("Neurolinked", "https://github.com/Neurolinked/MlsetupBuilder")
	DRAW:AboutBreak()
	DRAW:AboutThanks("WolvenKit Contributors", "https://github.com/WolvenKit/")
	DRAW:AboutBreak()
	DRAW:AboutThanks("Blender Foundation", "https://www.blender.org/")
	DRAW:AboutBreak()
	DRAW:AboutThanks("Cyberpunk 2077 Modding Discord")



	-- section
	DRAW:AboutHeader("CHANGELOG")
	DRAW:AboutVersion("v3.0")
	DRAW:AboutChange("rewrote entire core for improved option handling")
	DRAW:AboutChange("switched description file format to JSON")
	DRAW:AboutChange("split up option and render definitions")
	DRAW:AboutChange("refined user interface")
	DRAW:Spacing(1,5)
	DRAW:AboutAdded("added detection of cet and game versions")
	DRAW:AboutAdded("added detection for available GameSettings", "and GameOptions at startup")
	DRAW:Spacing(1,5)
	DRAW:AboutChange("all settings are disabled when not in the world")
	DRAW:AboutChange("settings are also disabled when not supported", "by the game or cet, with a small info")
	DRAW:Spacing(1,5)
	DRAW:AboutAdded("added fps and frametime graph with several", "settings like position and transparency")
	DRAW:AboutChange("the graph can be bound to a hotkey")
	DRAW:Spacing(1,5)
	DRAW:AboutAdded("added simple fps display to the main windows","with the current city and session time")
	DRAW:AboutChange("the main window can now be vertically scaled","depending on resolution")


	-- section
	DRAW:AboutHeader("MADE WITH")

	line = "Visual Studio Code, Notepad++ and some Brain ;)"
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line)







	-- print github
	line = "https://github.com/rp-freakaz/DeveloperExtras"
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line, false)



	-- restore spacing between
	ImGui.PopStyleVar(1)

end





function DRAW:PageText(color, style, text, same)

	-- catch non set
	local same = same or false

	-- paint it
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor(color, style))
	ImGui.Text(text)
	ImGui.PopStyleColor(1)

	if same then
		DRAW:Sameline()
	end
end



function DRAW:PageButton(color, style, text, same)

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor(color, style))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor())

	ImGui.PushID(text)
	local button = ImGui.Button(text, UTIL:TextWidth(text), UTIL:TextHeight(text))
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleColor(4)

	if same then
		DRAW:Sameline()
	end

	return button
end



function DRAW:AboutHeader(text)

	-- top room
	DRAW:Spacing(1,20)

	-- centering
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), text),1)
	DRAW:PageText("White", "Dark", text)
	DRAW:Spacing(1,2)
	DRAW:Spacer(math.floor(ImGui.GetWindowWidth() - 356) / 2,6)

	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Orange", "Normal"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Orange", "Normal"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Orange", "Normal"))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)

	ImGui.PushID("text")
	local _blind = ImGui.Button("", 356, 1)
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(3)

	DRAW:Spacing(1,5)
end



function DRAW:AboutSpecial(who, why, web)

	-- centering
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), "~ "..who.." ~"),1)
	DRAW:PageText("Orange", "Normal", "~ ", true)
	DRAW:PageText("White", "Normal", who, true)
	DRAW:PageText("Orange", "Normal", " ~", false)

	-- some room
	DRAW:Spacing(1,3)

	-- centering
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), why),1)
	DRAW:PageText("Grey", "Lighter", why, false)

	-- some room
	DRAW:Spacing(1,2)

	-- centering
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), web),1)
	DRAW:PageText("Grey", "Normal", web, false)

	DRAW:Spacing(1,10)
end



function DRAW:AboutThanks(who, why, add)

	-- catch non set
	local why = why or false
	local add = add or false

	-- centering
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), who),1)
	DRAW:PageText("Grey", "Lightest", who, false)

	-- optional
	if why
	then
		DRAW:Spacing(1,2)
		DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), why),1)
		DRAW:PageText("Grey", "Lighter", why, false)
	end

	-- optional
	if add
	then
		DRAW:Spacing(1,2)
		DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), add),1)
		DRAW:PageText("Grey", "Lighter", add, false)
	end
end



function DRAW:AboutVersion(which)
	DRAW:Spacer(52,1)
	DRAW:PageText("White", "Dark", which)
	DRAW:Spacing(1,1)
	DRAW:Spacer(52,1)

	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Orange", "Normal"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Orange", "Normal"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Orange", "Normal"))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)

	ImGui.PushID("__text")
	local _blind = ImGui.Button("", UTIL:TextWidth(which), 1)
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(3)

	DRAW:Spacing(1,3)
end

function DRAW:AboutAdded(what, add)

	local add = add or false

	DRAW:Spacer(52,1)
	DRAW:PageText("Orange", "Normal", "+ ", true)
	DRAW:PageText("Grey", "Lighter", what, false)

	if add
	then
		DRAW:Spacer(66,1)
		DRAW:PageText("Grey", "Lighter", add, false)
	end

	DRAW:Spacing(1,3)
end

function DRAW:AboutChange(what, add)

	local add = add or false

	DRAW:Spacer(52,1)
	DRAW:PageText("Grey", "Normal", "* ", true)
	DRAW:PageText("Grey", "Lighter", what, false)

	if add
	then
		DRAW:Spacer(66,1)
		DRAW:PageText("Grey", "Lighter", add, false)
	end

	DRAW:Spacing(1,3)
end






function DRAW:AboutBreak()

	-- centering
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), "___"),1)
	DRAW:PageText("Grey", "Dark", "___", false)
	DRAW:Spacing(1,8)
end





























--
--// DRAW:LogoAnimation()
--
function DRAW:LogoAnimation()

	-- needed for logo animation
	local _timings = UTIL:Get25thSeconds()

	-- only if needed
	if DRAW.Logo.Cycles ~= _timings
	then
		-- update timing
		DRAW.Logo.Cycles = _timings

		-- get table length
		local _length = UTIL:TableLength(DRAW.Logo.Colors)

		-- rotate color table
		table.insert(DRAW.Logo.Colors, DRAW.Logo.Colors[1])

		-- cut to long table
		if UTIL:TableLength(DRAW.Logo.Colors) > _length
		then
			table.remove(DRAW.Logo.Colors,1)
		end
	end

	-- frame id's
	local _frames = 1000
	local _blanks = 2000



	ImGui.BeginChild("DE_LogoChild", math.floor(UTIL:ScaleSwitch(51 * 6) + 50), UTIL:ScaleSwitch((16 * 6) + 15), true, ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoMove + ImGuiWindowFlags.NoScrollWithMouse)





--76,25
	--local _spacer = (ImGui.GetWindowWidth() - ((51 * UTIL:WindowWidth(1.25)) + (50 * UTIL:WindowWidth(0.25)))) / 2

	--local _spacer = (ImGui.GetWindowWidth() - (51 * UTIL:ScaleSwitch(6)) - 1)

	--DRAW.Logo.Filler = math.floor(UTIL:ScaleSwitch(7))

	--local _fields = 51

	--local _spacer = UTIL:ScaleSwitch(50)

	--if (_fields * 7) ~= (_fields * math.floor(UTIL:ScaleSwitch(7)))
	--then
	--	_spacer = (ImGui.GetWindowWidth() - (51 * math.floor(UTIL:ScaleSwitch(7))) - 1) / 2
	--end


	-- loop matrix rows
	for _,_row in pairs(DRAW.Logo.Matrix)
	do

		--local rownum = UTIL:TableLength(_row)

		--local _spacer = (ImGui.GetWindowWidth() - ((rownum * UTIL:ScaleSwitch(5)) + ((rownum - 1) * 1))) / 2


		--local _spacer = (ImGui.GetWindowWidth() - ((rownum * UTIL:ScaleSwitch(5)) + (rownum - 1))) / 2

		-- left room
		--DRAW:Spacer(UTIL:ScaleSwitch(50),1)
		--DRAW:Spacer(_spacer)



		-- loop matrix columns
		for _,_col in pairs(_row)
		do
			-- paint
			if _col > 0
			then
				-- inc frames
				_frames = _frames + 1

				-- seeding so its sticks
				math.randomseed(_frames)

				-- draw painter
				DRAW:LogoPainter(_frames, math.random(1,UTIL:TableLength(DRAW.Logo.Colors)))
				DRAW:Sameline()
				--DRAW:Spacer(UTIL:WindowWidth(0.25),UTIL:WindowWidth(0.25))
				DRAW:Spacer(1,1)
				DRAW:Sameline()
			-- or not
			else
				-- inc frames
				_blanks = _blanks + 1
				--DRAW:Spacer(UTIL:WindowWidth(1.45),UTIL:WindowWidth(1))

				DRAW:LogoSpacer(_blanks)
				DRAW:Sameline()
				--DRAW:Spacer(UTIL:WindowWidth(0.25),UTIL:WindowWidth(0.25))

				DRAW:Spacer(1,1)

				DRAW:Sameline()

			end
		end

		-- right end
		DRAW:Spacing(1,1)

		-- space between
		--DRAW:Spacing(UTIL:WindowWidth(0.25),UTIL:WindowWidth(0.25))
		DRAW:Spacing(1,1)
	end


	ImGui.EndChild()

end


function DRAW:LogoSpacer(_id)

	-- paint child
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor())
	local _blind = ImGui.BeginChildFrame(_id, UTIL:ScaleSwitch(6), UTIL:ScaleSwitch(6), ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoScrollWithMouse)
	ImGui.PopStyleColor(1)

	-- close child
	ImGui.EndChildFrame()
end



function DRAW:LogoPainter(_id, _transparency)

	local _color = "Orange"

	-- create white highlight
	if _id > 1000 and _id < 1002
	or _id > 1210 and _id < 1212
	or _id > 1235 and _id < 1241
	or _id > 1256 and _id < 1259
	or _id > 1281 and _id < 1287
	or _id > 1302 and _id < 1307
	or _id > 1326 and _id < 1333
	or _id > 1356 and _id < 1364
	then
		_color = "White"
	end

	-- create grey highlight
	if _id > 1363 and _id < 1415
	then
		_color = "Grey"
	end

	-- paint child
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:ScaleSwitch(1))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor(_color, "Logo", DRAW.Logo.Colors[_transparency]))
	local _blind = ImGui.BeginChildFrame(_id, UTIL:ScaleSwitch(6), UTIL:ScaleSwitch(6), ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoScrollWithMouse)
	ImGui.PopStyleColor(1)
	ImGui.PopStyleVar(1)

	-- close child
	ImGui.EndChildFrame()
end


























--
-- constructor
--
function DRAW:Prelude(project, version, scale, debug)
	local o = {}
	setmetatable(o, self)
	self.__index = self

	-- identity
	DRAW.Project = project
	DRAW.Version = version
	DRAW.Scaling = scale
	DRAW.isDebug = debug

	-- messages
	DRAW.Warning = "Toggle's are disabled, because you are not in Night City yet."
	DRAW.Require = {
		[0] = "Enabled",
		[1] = "Disabled, PreGame",
		[2] = "Not supported on this Version of Cyber Engine Tweaks.",
		[3] = "Not supported in this Version of the Cyberpunk 2077.",
		[9] = "Requires Photomode."
	}

	-- logo definition
	DRAW.Logo = {
		Filler = 0,
		Cycles = 0,
		Colors = {0.4,0.5,0.6,0.7,0.8,0.9,0.95,0.97,0.98,0.99,1,1,1,0.99,0.98,0.97,0.95,0.9,0.8,0.7,0.6,0.5},
		Matrix = {
			{1,1,1,1,1,0,1,1,1,1,1,0,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1},
			{1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1},
			{1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,0,0},
			{1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,0,0},
			{1,1,0,1,1,0,1,1,0,0,0,0,1,1,0,1,1,0,1,1,0,0,0,0,1,1,0,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,0,0,0,1,1,0,0,0},
			{1,1,1,1,0,0,1,1,1,1,1,0,0,1,1,1,1,0,1,1,1,1,1,0,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{1,1,1,1,1,0,1,1,0,1,1,0,0,1,1,0,0,1,1,1,1,1,0,0,1,1,1,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
			{1,1,0,0,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,0,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
			{1,1,1,1,0,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,0,0,0,1,1,1,1,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
			{1,1,0,0,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,0,0,1,1,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,1,1},
			{1,1,0,1,1,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,0,0,1,1,0,1,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,1,0,1,0,1,1,0,1,1},
			{1,1,1,1,1,0,1,1,0,1,1,0,0,1,1,1,0,1,1,0,0,0,0,1,1,1,1,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1,1},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
		}
	}

	-- return
	return o
end

-- return
return DRAW