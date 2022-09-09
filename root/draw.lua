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
function DRAW:WindowStart(width, height)

	-- catch non set
	local width = width or 456
	local height = height or 600

	-- get resolution
	local x, y = GetDisplayResolution()

	-- defaults
	ImGui.SetNextWindowPos(100, 100, ImGuiCond.FirstUseEver)
	ImGui.SetNextWindowSizeConstraints(width, height, width, y - 100)

	-- global styles
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing, 2, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarSize, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarRounding, 0)


	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark"))
	ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColor("Black","Normal"))
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



	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 4)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 8, 12)
	ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing, 7, 0)

	-- create window
	local _trigger = ImGui.Begin(UTIL:SpaceBetween(DRAW.Project.." v"..DRAW.Version.String, "CET "..DRAW.Version.Cet.String.." // PATCH "..DRAW.Version.Game.String, width, DRAW.SpaceWidth), ImGuiWindowFlags.NoScrollbar)

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
	ImGui.PopStyleVar(5)

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

	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 3, 7)

	-- fix left align
	DRAW:Spacer(1,1)

	-- create tabbar
	local _trigger = ImGui.BeginTabBar("DE_Tabbar")

	-- drop stacks
	ImGui.PopStyleVar(1)
	--ImGui.PopStyleColor(3)

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
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 6, 7)

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
		ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarSize, 12)
	end

	-- child flags
	--local _flags = "ImGuiWindowFlags.NoTitleBar + ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoResize + ImGuiWindowFlags.NoCollapse + ImGuiWindowFlags.NoMove + ImGuiWindowFlags.NoBackground + ImGuiWindowFlags.AlwaysAutoResize"

	-- create child
	local _trigger = ImGui.BeginChild("DE_Tabchild", width, height, false, ImGuiWindowFlags.AlwaysVerticalScrollbar + ImGuiWindowFlags.NoBackground)

	-- del scroll
	if _scroll
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
function DRAW:Collapse(title)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal"))
	ImGui.PushStyleColor(ImGuiCol.Header, DRAW:GetColor("Grey","Darker"))
	ImGui.PushStyleColor(ImGuiCol.HeaderActive, DRAW:GetColor("Orange","Normal"))
	ImGui.PushStyleColor(ImGuiCol.HeaderHovered, DRAW:GetColor("Orange","Light"))

	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 8, 11)

	-- space before
	DRAW:Spacing(1,3)

	-- create collapse
	local _trigger = ImGui.CollapsingHeader(title)

	-- drop stacks
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(4)

	return _trigger
end

--
--// DRAW:CollapseNotice()
--
function DRAW:CollapseNotice(width, text)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Orange","Normal"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Orange","Normal"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Orange","Normal"))

	ImGui.PushID("Button"..tostring("CollapseNoticePre"))
	local _blind = ImGui.Button("", 5, 28)
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

	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 10, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.ButtonTextAlign, 0, 0)

	ImGui.PushID("Button"..tostring("CollapseNoticeText"))
	local _blind = ImGui.Button(tostring(text), width, 28)
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
--// DRAW:Spacing()
--
function DRAW:Spacing(width, height)

	-- catch non set
	local width = width or 0
	local height = height or 0

	ImGui.Dummy(width, height)
end

--
--// DRAW:Sameline()
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
		ImGui.Dummy(1, top)
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
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 4, 4)

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

	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 2)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 5, 5)
	ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing, 10, 0)


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
--// DRAW:About()
--
function DRAW:About()

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
	DRAW:AboutVersion("DE 3.0")
	DRAW:AboutChange("rewrote entire core for improved option handling")
	DRAW:AboutChange("switched description file format to JSON")
	DRAW:AboutChange("split up Option and Render definitions")
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
	--local _madewith = "Visual Studio Code, Notepad++ and some Brain ;)"
	--DRAW.Spacer(CenterText(ImGui.GetWindowWidth(), _madewith),1)
	--SELF.AboutText("grey_dark", _madewith, false)



	-- print github
	line = "https://github.com/rp-freakaz/DeveloperExtras"
	DRAW:Spacer(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line, false)



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
	DRAW:PageText("Grey", "Lightest", which, false)
	DRAW:Spacing(1,3)
end

function DRAW:AboutAdded(what, add)

	local add = add or false

	DRAW:Spacer(52,1)
	DRAW:PageText("Orange", "Normal", "+ ", true)
	DRAW:PageText("Grey", "Light", what, false)

	if add
	then
		DRAW:Spacer(66,1)
		DRAW:PageText("Grey", "Light", add, false)
	end

	DRAW:Spacing(1,3)
end

function DRAW:AboutChange(what, add)

	local add = add or false

	DRAW:Spacer(52,1)
	DRAW:PageText("Grey", "Normal", "* ", true)
	DRAW:PageText("Grey", "Light", what, false)

	if add
	then
		DRAW:Spacer(66,1)
		DRAW:PageText("Grey", "Light", add, false)
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

	-- loop matrix rows
	for _,_row in pairs(DRAW.Logo.Matrix)
	do
		-- left room
		DRAW:Spacer(50,6)

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
				DRAW:Spacer(1,6)
				DRAW:Sameline()
			-- or not
			else
				DRAW:Spacer(7,6)
			end
		end

		-- right end
		DRAW:Spacing(1,6)

		-- space between
		DRAW:Spacing(1,1)
	end
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
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 1)
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor(_color, "Logo", DRAW.Logo.Colors[_transparency]))
	local _blind = ImGui.BeginChildFrame(_id, 6, 6, ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoScrollWithMouse)
	ImGui.PopStyleColor(1)
	ImGui.PopStyleVar(1)

	-- close child
	ImGui.EndChildFrame()
end


























--
-- constructor
--
function DRAW:Prelude(project, version, debug)
	local o = {}
	setmetatable(o, self)
	self.__index = self

	-- identity
	DRAW.Project = project
	DRAW.Version = version
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

	-- color definition
	--DRAW.Colors = {
	--	Window = {R=0,G=0,B=0.02},
	--	Marked = {R=0.9,G=0.9,B=0.92},
	--	Accent = {R=1,G=0.56,B=0.13},
	--	Text = {R=0.97,G=0.97,B=1}
	--}



	DRAW.Colors = {
		Black = {
			Normal = {R=0.04,G=0.04,B=0.06,T=0.85},
			Light = {R=0.1,G=0.1,B=0.12,T=0.5},
			Dark = {R=0.01,G=0.01,B=0.03,T=0.9}
		},
		White = {
			Normal = {R=0.9,G=0.9,B=1,T=0.9},
			Light = {R=0.9,G=0.9,B=1,T=1},
			Dark = {R=0.8,G=0.8,B=0.85,T=0.8}
		},

		--Orange = {
		--	Normal = {R=0.28,G=0.68,B=0.85,T=0.7},
		--	Light = {R=0.28,G=0.68,B=0.85,T=0.9},
		--	Dark = {R=0.28,G=0.68,B=0.85,T=0.5},
		--},


		Orange = {
			Normal = {R=1,G=0.56,B=0.13,T=0.75},
			Light = {R=1,G=0.56,B=0.13,T=0.95},
			Dark = {R=1,G=0.56,B=0.13,T=0.55},
		},
		Grey = {
			Normal = {R=0.4,G=0.4,B=0.43,T=0.7},

			Dark = {R=0.3,G=0.3,B=0.33,T=0.6},
			Darker = {R=0.2,G=0.2,B=0.23,T=0.6},
			Darkest = {R=0.1,G=0.1,B=0.13,T=0.6},

			Light = {R=0.5,G=0.5,B=0.53,T=0.7},
			Lighter = {R=0.6,G=0.6,B=0.63,T=0.7},
			Lightest = {R=0.7,G=0.7,B=0.73,T=0.7},
		}
	}






	-- useful stuff
	DRAW.SpaceWidth = UTIL:TextWidth(" ")



	-- return
	return o
end

-- return
return DRAW