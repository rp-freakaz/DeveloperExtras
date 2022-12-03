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
local UTIL = require("root/util.lua"):Pre()

--
--// DRAW:GetColor(<STRING>,<STRING>,<INT>)
--
function DRAW:GetColor(color, style, state)

	-- catch unset
	local color = color or "Transparent"
	local style = style or "Normal"
	local state = state or 0

	if color == "Alarm" 	 				then return ImGui.GetColorU32(1, 0, 0, 1) end

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
--// DRAW:GetColor(<STRING>,<STRING>,<INT>)
--
function DRAW:GetColorNew(theme, color, state)

	-- catch unset
	local theme = theme or 0
	local color = color or "nocolor"
	local state = state or 0

	-- no color
	if color == "nocolor"						then return ImGui.GetColorU32(0, 0, 0, 0) end

	-- theme: default
	if theme == 0
	then
		-- window
		if color == "window/main/text"				then return DRAW:GetGeneric("generic/white/light") end
		if color == "window/main/border"			then return ImGui.GetColorU32(0.2, 0.2, 0.23, 0.5) end
		if color == "window/main/background"			then return DRAW:GetGeneric("generic/black/dark") end
		if color == "window/main/title/background"		then return DRAW:GetGeneric("generic/black/dark") end
		if color == "window/main/title/background/active"	then return DRAW:GetGeneric("generic/black/dark") end
		if color == "window/main/title/background/collapsed"	then return DRAW:GetGeneric("generic/black/dark") end
		if color == "window/main/resize"			then return DRAW:GetGeneric("generic/grey/dark") end
		if color == "window/main/resize/active"			then return DRAW:GetGeneric("generic/orange/normal") end
		if color == "window/main/resize/hovered"		then return DRAW:GetGeneric("generic/orange/light") end

		if color == "quickshift/title"				then return DRAW:GetGeneric("generic/white/normal") end
		if color == "quickshift/description"			then return DRAW:GetGeneric("generic/white/dark") end
		if color == "quickshift/background"			then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "quickshift/background/active"		then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "quickshift/background/hovered"		then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "quickshift/on/border"			then return DRAW:GetGeneric("generic/orange/darkest") end
		if color == "quickshift/on/grab/normal"			then return DRAW:GetGeneric("generic/orange/normal") end
		if color == "quickshift/on/grab/active"			then return DRAW:GetGeneric("generic/orange/light") end
		if color == "quickshift/off/border"			then return DRAW:GetGeneric("generic/grey/dark") end
		if color == "quickshift/off/grab/normal"		then return DRAW:GetGeneric("generic/grey/light") end
		if color == "quickshift/off/grab/active"		then return DRAW:GetGeneric("generic/grey/lighter") end

		if color == "combobox/title"				then return DRAW:GetGeneric("generic/white/normal") end
		if color == "combobox/description"			then return DRAW:GetGeneric("generic/white/dark") end
		if color == "combobox/border"				then return DRAW:GetGeneric("generic/grey/dark") end
		if color == "combobox/background"			then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "combobox/popup/background"			then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "combobox/button"				then return DRAW:GetGeneric("generic/orange/normal") end
		if color == "combobox/button/active"			then return DRAW:GetGeneric("generic/orange/normal") end
		if color == "combobox/button/hovered"			then return DRAW:GetGeneric("generic/orange/light") end
		if color == "combobox/button/decoration"		then return DRAW:GetGeneric("generic/orange/normal") end
		if color == "combobox/header"				then return DRAW:GetGeneric("generic/grey/normal") end
		if color == "combobox/header/active"			then return DRAW:GetGeneric("generic/orange/light") end
		if color == "combobox/header/hovered"			then return DRAW:GetGeneric("generic/orange/normal") end

		-- fallback
		return DRAW:GetGeneric()
	end

	-- theme: white satin
	if theme == 1
	then
		-- window
		if color == "window/main/text"				then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "window/main/border"			then return ImGui.GetColorU32(0.95, 0.95, 1, 1) end
		if color == "window/main/background"			then return ImGui.GetColorU32(0.95, 0.95, 1, 0.85) end
		if color == "window/main/title/background"		then return ImGui.GetColorU32(0.95, 0.95, 1, 0.85) end
		if color == "window/main/title/background/active"	then return ImGui.GetColorU32(0.95, 0.95, 1, 0.85) end
		if color == "window/main/title/background/collapsed"	then return ImGui.GetColorU32(0.95, 0.95, 1, 0.85) end
		if color == "window/main/resize"			then return DRAW:GetGeneric("generic/grey/light") end
		if color == "window/main/resize/active"			then return DRAW:GetGeneric("generic/grey/normal") end
		if color == "window/main/resize/hovered"		then return DRAW:GetGeneric("generic/grey/dark") end

		if color == "quickshift/title"				then return DRAW:GetGeneric("generic/black/normal") end
		if color == "quickshift/description"			then return DRAW:GetGeneric("generic/black/light") end
		if color == "quickshift/background"			then return DRAW:GetGeneric("generic/white/dark") end
		if color == "quickshift/background/active"		then return DRAW:GetGeneric("generic/white/dark") end
		if color == "quickshift/background/hovered"		then return DRAW:GetGeneric("generic/white/dark") end
		if color == "quickshift/on/border"			then return DRAW:GetGeneric("generic/grey/lightest") end
		if color == "quickshift/on/grab/normal"			then return DRAW:GetGeneric("generic/white/light") end
		if color == "quickshift/on/grab/active"			then return DRAW:GetGeneric("generic/white/light") end
		if color == "quickshift/off/border"			then return DRAW:GetGeneric("generic/grey/lightest") end
		if color == "quickshift/off/grab/normal"		then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "quickshift/off/grab/active"		then return DRAW:GetGeneric("generic/grey/darker") end

		if color == "combobox/title"				then return DRAW:GetGeneric("generic/black/normal") end
		if color == "combobox/description"			then return DRAW:GetGeneric("generic/black/light") end
		if color == "combobox/border"				then return DRAW:GetGeneric("generic/grey/lightest") end
		if color == "combobox/background"			then return DRAW:GetGeneric("generic/white/dark") end
		if color == "combobox/popup/background"			then return DRAW:GetGeneric("generic/white/dark") end
		if color == "combobox/button"				then return DRAW:GetGeneric("generic/white/normal") end
		if color == "combobox/button/active"			then return DRAW:GetGeneric("generic/white/normal") end
		if color == "combobox/button/hovered"			then return DRAW:GetGeneric("generic/white/light") end
		if color == "combobox/button/decoration"		then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "combobox/header"				then return DRAW:GetGeneric("generic/grey/normal") end
		if color == "combobox/header/active"			then return DRAW:GetGeneric("generic/orange/light") end
		if color == "combobox/header/hovered"			then return DRAW:GetGeneric("generic/orange/normal") end

		-- fallback
		return DRAW:GetGeneric()
	end


	-- theme: mox destiny
	if theme == 2
	then
		-- window
		if color == "window/main/text"				then return DRAW:GetGeneric("generic/cyan") end
		if color == "window/main/border"			then return ImGui.GetColorU32(0.95, 0.95, 1, 0.5) end
		if color == "window/main/background"			then return ImGui.GetColorU32(0.2, 0.32, 0.32, 0.75) end
		if color == "window/main/title/background"		then return ImGui.GetColorU32(0.2, 0.32, 0.32, 0.75) end
		if color == "window/main/title/background/active"	then return ImGui.GetColorU32(0.2, 0.32, 0.32, 0.75) end
		if color == "window/main/title/background/collapsed"	then return ImGui.GetColorU32(0.2, 0.32, 0.32, 0.75) end
		if color == "window/main/resize"			then return DRAW:GetGeneric("generic/white") end
		if color == "window/main/resize/active"			then return DRAW:GetGeneric("generic/orange") end
		if color == "window/main/resize/hovered"		then return DRAW:GetGeneric("generic/orange") end


		if color == "quickshift/title"				then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "quickshift/description"			then return DRAW:GetGeneric("generic/grey/darker") end

		if color == "quickshift/background"			then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "quickshift/background/active"		then return DRAW:GetGeneric("generic/grey/darker") end
		if color == "quickshift/background/hovered"		then return DRAW:GetGeneric("generic/grey/darker") end

		if color == "quickshift/on/border"			then return DRAW:GetGeneric("generic/orange/darkest") end
		if color == "quickshift/on/grab/normal"			then return DRAW:GetGeneric("generic/orange/normal") end
		if color == "quickshift/on/grab/active"			then return DRAW:GetGeneric("generic/orange/light") end

		if color == "quickshift/off/border"			then return DRAW:GetGeneric("generic/grey/dark") end
		if color == "quickshift/off/grab/normal"		then return DRAW:GetGeneric("generic/grey/light") end
		if color == "quickshift/off/grab/active"		then return DRAW:GetGeneric("generic/grey/lighter") end

		-- fallback
		return DRAW:GetGeneric()
	end




end




--
--// DRAW:GetGeneric(<STRING>,<INT>)
--
function DRAW:GetGeneric(color, state)

	-- catch unset
	local color = color or "nocolor"
	local state = state or 0

	-- no color
	if color == "nocolor"						then return ImGui.GetColorU32(0, 0, 0, 0) end

	-- solids
	if color == "generic/white"					then return ImGui.GetColorU32(1, 1, 1, 1) end
	if color == "generic/black"					then return ImGui.GetColorU32(0, 0, 0, 1) end
	if color == "generic/orange"					then return ImGui.GetColorU32(1, 0.56, 0.13, 1) end
	if color == "generic/grey"					then return ImGui.GetColorU32(0.5, 0.5, 0.5, 1) end
	if color == "generic/cyan"					then return ImGui.GetColorU32(0, 0.72, 0.72, 1) end


	-- variations
	if color == "generic/white/dark"				then return ImGui.GetColorU32(0.8, 0.8, 0.85, 0.8) end
	if color == "generic/white/light"				then return ImGui.GetColorU32(0.9, 0.9, 1, 1) end
	if color == "generic/white/normal"				then return ImGui.GetColorU32(0.9, 0.9, 1, 0.9) end

	if color == "generic/black/dark"				then return ImGui.GetColorU32(0.01, 0.01, 0.03, 0.9) end
	if color == "generic/black/light"				then return ImGui.GetColorU32(0.1, 0.1, 0.12, 0.5) end
	if color == "generic/black/normal"				then return ImGui.GetColorU32(0.04, 0.04, 0.06, 0.85) end

	if color == "generic/cyan/dark"					then return ImGui.GetColorU32(0, 0.52, 0.52, 1) end
	if color == "generic/cyan/light"				then return ImGui.GetColorU32(0, 0.72, 0.72, 1) end
	if color == "generic/cyan/normal"				then return ImGui.GetColorU32(0, 0.92, 0.92, 1) end

	if color == "generic/orange/dark"				then return ImGui.GetColorU32(1, 0.56, 0.13, 0.7) end
	if color == "generic/orange/darker"				then return ImGui.GetColorU32(1, 0.56, 0.13, 0.5) end
	if color == "generic/orange/darkest"				then return ImGui.GetColorU32(1, 0.56, 0.13, 0.3) end
	if color == "generic/orange/light"				then return ImGui.GetColorU32(1, 0.56, 0.13, 1) end
	if color == "generic/orange/normal"				then return ImGui.GetColorU32(1, 0.56, 0.13, 0.85) end


	if color == "generic/grey/dark"					then return ImGui.GetColorU32(0.3, 0.3, 0.33, 0.7) end
	if color == "generic/grey/darker"				then return ImGui.GetColorU32(0.2, 0.2, 0.23, 0.7) end
	if color == "generic/grey/darkest"				then return ImGui.GetColorU32(0.1, 0.1, 0.13, 0.7) end
	if color == "generic/grey/light"				then return ImGui.GetColorU32(0.5, 0.5, 0.53, 0.7) end
	if color == "generic/grey/lighter"				then return ImGui.GetColorU32(0.6, 0.6, 0.63, 0.8) end
	if color == "generic/grey/lightest"				then return ImGui.GetColorU32(0.7, 0.7, 0.73, 0.9) end
	if color == "generic/grey/normal"				then return ImGui.GetColorU32(0.4, 0.4, 0.43, 0.7) end
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


	--DRAW:CompileColor()

	-- first position
	ImGui.SetNextWindowPos(100, 100, ImGuiCond.FirstUseEver)

	-- native scaling
	if DRAW.Scaling.Enable
	then
		ImGui.SetNextWindowSizeConstraints(UTIL:ScaleSwitch(456, true), UTIL:ScaleSwitch(600, true), (DRAW.Scaling.Screen.Width / 2) - 50, DRAW.Scaling.Screen.Height - 100)
	else
		ImGui.SetNextWindowSizeConstraints(456, 600, 456, DRAW.Scaling.Screen.Height - 100)
	end

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
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColorNew(DRAW.Runtime.Theme, "window/main/text"))
	ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColorNew(DRAW.Runtime.Theme, "window/main/border"))
	ImGui.PushStyleColor(ImGuiCol.WindowBg, DRAW:GetColorNew(DRAW.Runtime.Theme, "window/main/background"))
	ImGui.PushStyleColor(ImGuiCol.TitleBg, DRAW:GetColorNew(DRAW.Runtime.Theme, "window/main/title/background"))
	ImGui.PushStyleColor(ImGuiCol.TitleBgActive, DRAW:GetColorNew(DRAW.Runtime.Theme, "window/main/title/background/active"))
	ImGui.PushStyleColor(ImGuiCol.TitleBgCollapsed, DRAW:GetColorNew(DRAW.Runtime.Theme, "window/main/title/background/collapsed"))
	ImGui.PushStyleColor(ImGuiCol.ResizeGrip, DRAW:GetColorNew(DRAW.Runtime.Theme, "window/main/resize"))
	ImGui.PushStyleColor(ImGuiCol.ResizeGripActive, DRAW:GetColorNew(DRAW.Runtime.Theme, "window/main/resize/active"))
	ImGui.PushStyleColor(ImGuiCol.ResizeGripHovered, DRAW:GetColorNew(DRAW.Runtime.Theme, "window/main/resize/hovered"))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColorNew())
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColorNew())
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColorNew())

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
	DRAW:Spacing(1,1)

	-- create tabbar
	local _trigger = ImGui.BeginTabBar("DE_TB")

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

	-- catch unset
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
	DRAW:Spacer(1,UTIL:ScaleSwitch(3))

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

	-- catch unset
	local width = width or 1
	local height = height or 1

	ImGui.Dummy(width, height)
end

--
--// DRAW:Spacing(<INT>,<INT>)
--
function DRAW:Spacing(width, height)

	-- catch unset
	local width = width or 1
	local height = height or 1

	ImGui.Dummy(width, height)
	DRAW:Sameline()
end

--
--// DRAW:Sameline()
--
function DRAW:Sameline()
	ImGui.SameLine()
end

--
--// DRAW:Separator()
--
function DRAW:Separator(height, top, bot, color, style)

	-- catch unset
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

	-- catch unset
	local min = min or false
	local max = max or false

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Dark",demand))
	ImGui.Text("»")
	ImGui.PopStyleColor(1)
	ImGui.SameLine()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))

	if min and max
	then
		DRAW:Spacing(8,1)
		ImGui.Text(title)
		ImGui.SameLine()
		DRAW:Spacing(8,1)
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Normal",demand))
		ImGui.Text(tostring(min)..' to '..tostring(max))
		ImGui.PopStyleColor(1)
	else
		DRAW:Spacing(8,1)
		ImGui.Text(title)
	end
	ImGui.PopStyleColor(1)
	DRAW:Spacer(1,1)
end



























--
--// DRAW:Slider()
--
function DRAW:Slider(render, option, demand, value)

	-- default
	local _spacing = UTIL:ScaleSwitch(14)

	-- spacing
	if render.spacing
	then
		_spacing = UTIL:ScaleSwitch(render.spacing + _spacing)
	end

	-- lead spacing
	DRAW:Spacing(_spacing,1)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Dark",demand))
	ImGui.Text("»")
	ImGui.PopStyleColor(1)
	ImGui.SameLine()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))

	if option.min and option.max
	then
		DRAW:Spacing(UTIL:ScaleSwitch(8),1)
		ImGui.Text(render.name)
		ImGui.SameLine()
		DRAW:Spacing(UTIL:ScaleSwitch(8),1)
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Normal",demand))
		ImGui.Text(tostring(option.min)..' to '..tostring(option.max))
		ImGui.PopStyleColor(1)
	else
		ImGui.Text(render.name)
	end

	-- drop stacks
	ImGui.PopStyleColor(1)

	-- render info
	if render.note or render.rate
	then
		DRAW:ButtonNotes(render, "?", demand)
	else
		DRAW:Sameline()
		DRAW:Spacer(1,UTIL:ScaleSwitch(15))
	end

	DRAW:Spacer(1,UTIL:ScaleSwitch(5))
	DRAW:Spacing(_spacing + UTIL:ScaleSwitch(14),1)
	ImGui.SetNextItemWidth(ImGui.GetWindowWidth() - _spacing - UTIL:ScaleSwitch(90))

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.SliderGrab, DRAW:GetColor("Orange","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, DRAW:GetColor("Orange","Light",demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("Grey","Darker",demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("Grey","Darker",demand))
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("Grey","Darker",demand))

	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:ScaleSwitch(2))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:ScaleSwitch(2), UTIL:ScaleSwitch(4))

	-- make them local before
	local _return, _trigger

	-- int slider (no title)
	if option.type == "int" or option.type == "Int"
	then
		ImGui.PushID("DE_SI"..UTIL:ElementID(render.path))
		_return, _trigger = ImGui.SliderInt("", value, option.min, option.max)
		ImGui.PopID()
	end

	if option.type == "float" or option.type == "Float"
	then
		ImGui.PushID('DE_SF'..UTIL:ElementID(render.path))
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
--// DRAW:Slider()
--
function DRAW:LegacySlider(render, option, demand, value)

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
		ImGui.PushID("DE_SI"..UTIL:ElementID(render.path))
		_return, _trigger = ImGui.SliderInt("", value, option.min, option.max)
		ImGui.PopID()
	end

	if option.type == "float" or option.type == "Float"
	then
		ImGui.PushID('DE_SF'..UTIL:ElementID(render.path))
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
function DRAW:LegacySliderTitle(title, min, max, demand)

	-- catch unset
	local min = min or false
	local max = max or false

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Dark",demand))
	ImGui.Text("»")
	ImGui.PopStyleColor(1)
	ImGui.SameLine()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))

	if min and max
	then
		DRAW:Spacing(8,1)
		ImGui.Text(title)
		ImGui.SameLine()
		DRAW:Spacing(8,1)
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

	-- catch unset
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

	-- catch unset
	local min = min or false
	local max = max or false

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Dark"))
	ImGui.Text("»")
	ImGui.PopStyleColor(1)
	DRAW:Sameline()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))

	if min and max then
		DRAW:Spacing(8,1)
		ImGui.Text(title)
		DRAW:Sameline()
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey","Normal",demand))
		ImGui.Text(tostring(min)..' to '..tostring(max))
		ImGui.PopStyleColor(1)
	else
		DRAW:Spacing(8,1)
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
	DRAW:Spacing(7, 1)

	-- add color stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Orange","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Orange","Normal",demand))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Orange","Light",demand))

	-- add style stacks
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 7)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 4, 1)

	-- draw blind button
	ImGui.PushID("DE_BT"..UTIL:ElementID("Notes"))
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
		DRAW:Spacing(render.spacing + 34,1)
	else
		DRAW:Spacing(44,1)
	end

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("White","Dark",demand))
	ImGui.Text(render.desc)
	ImGui.PopStyleColor(1)
end

















--
--// DRAW:Combobox()
--
function DRAW:Combobox(render, option, demand, names, length, value)

	-- default
	local _spacing = UTIL:ScaleSwitch(16)

	-- spacing
	if render.spacing
	then
		_spacing = UTIL:ScaleSwitch(render.spacing + _spacing)
	end

	-- top spacer
	DRAW:Spacer(1,UTIL:ScaleSwitch(5))

	-- lead spacing
	DRAW:Spacing(_spacing + UTIL:ScaleSwitch(1),1)

	-- deco paint
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:ScaleSwitch(6))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/button/decoration"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/button/decoration"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/button/decoration"))

	-- deco title
	DRAW:FlexButton(UTIL:ScaleSwitch(5), UTIL:ScaleSwitch(19))

	ImGui.PopStyleColor(3)
	ImGui.PopStyleVar(1)
	DRAW:Sameline()
	DRAW:Spacing(UTIL:ScaleSwitch(5),1)
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/title"))
	ImGui.Text(render.name)
	ImGui.PopStyleColor(1)

	-- bottom spacer
	DRAW:Spacer(1,UTIL:ScaleSwitch(8))

	-- lead spacing
	DRAW:Spacing(_spacing,1)

	-- quickshifts have a fixed width
	ImGui.SetNextItemWidth(DRAW.Scaling.Window.Width - (_spacing * 2) - UTIL:ScaleSwitch(1))

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/title"))

	ImGui.PushStyleColor(ImGuiCol.PopupBg, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/popup/background"))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/background"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/background"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/background"))

	ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/border"))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/button"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/button/active"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/button/hovered"))

	ImGui.PushStyleColor(ImGuiCol.Header, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/header"))
	ImGui.PushStyleColor(ImGuiCol.HeaderActive, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/header/active"))
	ImGui.PushStyleColor(ImGuiCol.HeaderHovered, DRAW:GetColorNew(DRAW.Runtime.Theme, "combobox/header/hovered"))


	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:ScaleSwitch(8), UTIL:ScaleSwitch(4))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:ScaleSwitch(3))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameBorderSize, UTIL:ScaleSwitch(2))

	ImGui.PushStyleVar(ImGuiStyleVar.PopupRounding, 10)
	ImGui.PushStyleVar(ImGuiStyleVar.PopupBorderSize, UTIL:ScaleSwitch(1))

	-- draw combobox
	ImGui.PushID("DE_CO"..UTIL:ElementID(render.path))
	local _return, _trigger = ImGui.Combo("", value, names, length)
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(5)
	ImGui.PopStyleColor(12)

	-- bottom spacer
	DRAW:Spacer(1,UTIL:ScaleSwitch(5))

	-- result
	return _return, _trigger
end





















--
--// DRAW:Quickshift()
--
function DRAW:Quickshift(render, option, demand, value, align)

	-- catch unset
	local align = align or false

	-- default
	local _spacing = UTIL:ScaleSwitch(16)

	-- spacing
	if render.spacing
	then
		_spacing = UTIL:ScaleSwitch(render.spacing + _spacing)
	end

	-- top spacer
	DRAW:Spacer(1,UTIL:ScaleSwitch(4))

	-- lead spacing
	DRAW:Spacing(_spacing,1)

	-- alignment
	if align
	then
		-- paint title
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/title"))
		ImGui.Text(render.name)
		ImGui.PopStyleColor(1)
		DRAW:Sameline()

		-- fill space between
		DRAW:Spacing(DRAW.Scaling.Window.Width - (_spacing + UTIL:TextWidth(render.name) + UTIL:ScaleSwitch(50)),1)
	end

	-- quickshifts have a fixed width
	ImGui.SetNextItemWidth(UTIL:ScaleSwitch(34))





	-- add stacks
	if value == 0
	then
		ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/off/border"))
		ImGui.PushStyleColor(ImGuiCol.SliderGrab, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/off/grab/normal"))
		ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/off/grab/active"))
	else
		ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/on/border"))
		ImGui.PushStyleColor(ImGuiCol.SliderGrab, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/on/grab/normal"))
		ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/on/grab/active"))
	end

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/background"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/background/active"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/background/hovered"))

	ImGui.PushStyleVar(ImGuiStyleVar.GrabRounding, UTIL:ScaleSwitch(10))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:ScaleSwitch(10))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FrameBorderSize, UTIL:ScaleSwitch(2))

	-- draw minified slider
	ImGui.PushID("DE_QS"..UTIL:ElementID(render.path))
	local _return, _trigger = ImGui.SliderInt("", value, 0, 1)
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(4)
	ImGui.PopStyleColor(7)

	-- alignment
	if not align
	then
		DRAW:Sameline()
		DRAW:Spacing(UTIL:ScaleSwitch(8),1)
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/title"))
		ImGui.Text(render.name)
		ImGui.PopStyleColor(1)
	end

	-- debug info
	if DRAW.isDebug
	then
		-- top spacer
		DRAW:Spacer(1,UTIL:ScaleSwitch(2))

		-- left spacing
		DRAW:Spacing(_spacing,1)

		-- alignment
		if not align
		then
			DRAW:Spacing(UTIL:ScaleSwitch(42),1)
		end

		-- add stacks
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Orange","Dark",demand))
		ImGui.Text(render.path)
		ImGui.PopStyleColor(1)
	end


	-- description
	if render.desc
	then
		-- top spacer
		DRAW:Spacer(1,UTIL:ScaleSwitch(8))

		-- left spacing
		DRAW:Spacing(_spacing,1)

		-- alignment
		if not align
		then
			DRAW:Spacing(UTIL:ScaleSwitch(42),1)
		end

		-- add stacks
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColorNew(DRAW.Runtime.Theme, "quickshift/description"))

		if not align
		then
			ImGui.Text(UTIL:WordWrap(render.desc,_spacing + 42))
		else
			ImGui.Text(UTIL:WordWrap(render.desc,_spacing))
		end
		ImGui.PopStyleColor(1)
	end

	-- result
	return _return, _trigger
end








--
--// DRAW:PageDebug()
--
function DRAW:PageDebug()

	local _spacing = UTIL:ScaleSwitch(14)

	-- some room
	DRAW:Spacer(1, _spacing)

	-- scaling specs
	DRAW:Spacing(_spacing, 1)
	ImGui.Text("Scaling is: "..UTIL:FirstToUpper(tostring(DRAW.Scaling.Enable)).." // Fontsize: "..tostring(ImGui.GetFontSize()))
	DRAW:Spacer(1, 3)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("Screen Size: "..tostring(DRAW.Scaling.Screen.Width).."x"..tostring(DRAW.Scaling.Screen.Height).." // Factor: "..tostring(DRAW.Scaling.Screen.Factor))

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("Window Size: "..tostring(DRAW.Scaling.Window.Width).."x"..tostring(DRAW.Scaling.Window.Height).." // Factor: "..tostring(DRAW.Scaling.Window.Factor))

	DRAW:Separator(UTIL:ScaleSwitch(5),14,10)

	-- logo animation
	DRAW:Spacing(_spacing, 1)
	ImGui.Text("Logo Painter:")
	DRAW:Spacer(1, 3)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("Blocksize: "..tostring(UTIL:ScaleSwitch(6)).." // Rounding: "..tostring(math.floor(UTIL:ScaleSwitch(6))).." // Center: "..tostring(DRAW.Logo.Center).." // Pixels: "..tostring(DRAW.Logo.Pixels))

	DRAW:Separator(UTIL:ScaleSwitch(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (no underline)")
	DRAW:TextTitle("Left", {space=_spacing,underline={paint=false}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline text sized)")
	DRAW:TextTitle("Left", {space=_spacing,underline={paint=true}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline window sized)")
	DRAW:TextTitle("Left", {space=_spacing,underline={paint=true,limit=false}})

	DRAW:Separator(UTIL:ScaleSwitch(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (no underline)")
	DRAW:TextTitle("Center", {space=_spacing,align="center",underline={paint=false}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline text sized)")
	DRAW:TextTitle("Center", {space=_spacing,align="center",underline={paint=true}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline window sized)")
	DRAW:TextTitle("Center", {space=_spacing,align="center",underline={paint=true,limit=false}})

	DRAW:Separator(UTIL:ScaleSwitch(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (no underline)")
	DRAW:TextTitle("Right", {space=_spacing,align="right",underline={paint=false}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline text sized)")
	DRAW:TextTitle("Right", {space=_spacing,align="right",underline={paint=true}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline window sized)")
	DRAW:TextTitle("Right", {space=_spacing,align="right",underline={paint=true,limit=false}})







	DRAW:Separator(UTIL:ScaleSwitch(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("UTIL:WordWrap")
	DRAW:Spacing(_spacing, 1)
	ImGui.Text(UTIL:WordWrap("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.", _spacing))

	DRAW:Separator(UTIL:ScaleSwitch(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("ImGui.TextWrapped")
	DRAW:Spacing(_spacing, 1)
	ImGui.TextWrapped("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")

	DRAW:Separator(UTIL:ScaleSwitch(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("ImGui.BulletText")
	DRAW:Spacing(_spacing, 1)
	ImGui.BulletText("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")








end


























--
--// DRAW:TextTitle(<STRING>,<TABLE>)
--
function DRAW:TextTitle(input, flags)

	-- catch unset
	local flags = flags or {}

	-- defaulting flags
	local _space = 0
	local _color = "Orange"
	local _style = "Normal"
	local _align = "left"
	local _underline = {paint=true,limit=true,color="Grey",style="Normal"}

	-- parse flags if any
	if flags.space then _space = flags.space end
	if flags.color then _color = flags.color end
	if flags.style then _style = flags.style end
	if flags.align then _align = flags.align end
	if flags.underline then
		if flags.underline.paint ~= nil then _underline.paint = flags.underline.paint end
		if flags.underline.limit ~= nil then _underline.limit = flags.underline.limit end
		if flags.underline.color ~= nil then _underline.color = flags.underline.color end
		if flags.underline.style ~= nil then _underline.style = flags.underline.style end
	end

	-- spacing
	if _space > 0 then DRAW:Spacing(_space,1) end

	-- alignment
	if _align == "center" then DRAW:Spacing((DRAW.Scaling.Window.Width / 2) - (UTIL:TextWidth(input) / 2) - _space,1) end
	if _align == "right" then DRAW:Spacing(DRAW.Scaling.Window.Width - UTIL:TextWidth(input) - (_space * 2),1) end

	-- format text
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor(_color,_style))
	ImGui.Text(input)
	ImGui.PopStyleColor(1)

	--
	-- underline
	--

	if _underline.paint
	then
		-- spacing
		if _space > 0 then DRAW:Spacing(_space,1) end

		-- alignment
		if _underline.limit
		then
			if _align == "center" then DRAW:Spacing((DRAW.Scaling.Window.Width / 2) - (UTIL:TextWidth(input) / 2) - _space,1) end
			if _align == "right" then DRAW:Spacing(DRAW.Scaling.Window.Width - UTIL:TextWidth(input) - (_space * 2),1) end
		end

		-- add stacks
		ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor(_underline.color,_underline.style))
		ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor(_underline.color,_underline.style))
		ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor(_underline.color,_underline.style))
		ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)

		ImGui.PushID("deco"..input)
		-- underline size
		if _underline.limit
		then
			local _blind = ImGui.Button("", UTIL:TextWidth(input), UTIL:ScaleSwitch(1))
		else
			local _blind = ImGui.Button("", DRAW.Scaling.Window.Width - (_space * 2), UTIL:ScaleSwitch(1))
		end
		ImGui.PopID()

		-- drop stacks
		ImGui.PopStyleVar(1)
		ImGui.PopStyleColor(3)
	end
end


function DRAW:Wrapper_AboutTitle(input, space)
	DRAW:TextTitle(input, {space=(DRAW.Scaling.Window.Width - DRAW.Logo.Pixels),color="Grey",style="Normal",align="center",underline={paint=true,limit=false,color="Orange",style="Normal"}})
end































--
--
--//////////////////// ABOUT PAGE ////////////////////
--
--

--
--// DRAW:PageAbout()
--
function DRAW:PageAbout()

	-- make room
	DRAW:Spacer(1, UTIL:ScaleSwitch(44))

	-- draw animation
	DRAW:LogoAnimation()

	-- paint version
	DRAW:PageAbout_Version("v"..DRAW.Version.String)

	-- make room
	DRAW:Spacer(1,UTIL:ScaleSwitch(15))






	-- predefine
	local line = ""
	local part = {}

	-- print who
	DRAW:Spacing(UTIL:TextCenter(DRAW.Scaling.Window.Width, "2022 by FREAKAZ"),1)
	DRAW:PageText("White", "Normal", "2022", true)
	DRAW:PageText("Orange", "Normal", " by ", true)
	DRAW:PageText("White", "Normal", "FREAKAZ", false)


	-- make room
	DRAW:Spacer(1,UTIL:ScaleSwitch(10))





	-- print random
	line = "made in endless hours at day and night"
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line)
	line = "while struggling with LUA, CET and 2077"
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line)

	-- make room
	DRAW:Spacer(1,UTIL:ScaleSwitch(3))

	-- print judy
	line = "~ FOR JUDY ~"
	part = UTIL:TextSplit(line)
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", part[1].." ", true)
	local unlock = DRAW:PageButton("Orange", "Normal", part[2].." "..part[3], true)
	DRAW:PageText("Grey", "Lighter", " "..part[4], false)

	-- make room
	DRAW:Spacer(1,UTIL:ScaleSwitch(15))

	-- print modpage
	DRAW:Spacing(UTIL:TextCenter(DRAW.Scaling.Window.Width, "https://rootpunk.com/mod"),1)
	DRAW:PageText("Grey", "Light", "https://", true)
	DRAW:PageText("Grey", "Lighter", "rootpunk.com/", true)
	DRAW:PageText("Orange", "Dark", "mod", false)

	-- make room
	DRAW:Spacer(1,UTIL:ScaleSwitch(3))

	-- print github
	DRAW:Spacing(UTIL:TextCenter(DRAW.Scaling.Window.Width, "https://github.com/rp-freakaz/DeveloperExtras"),1)
	DRAW:PageText("Grey", "Light", "https://", true)
	DRAW:PageText("Grey", "Lighter", "github.com/rp-freakaz/", true)
	DRAW:PageText("Orange", "Dark", "DeveloperExtras", false)

	-- make room
	DRAW:Spacer(1,UTIL:ScaleSwitch(20))







	-- special thanks
	DRAW:PageAbout_Header("SPECIAL THANKS TO")

	DRAW:AboutSpecial("CD PROJEKT RED", "FOR CREATING THIS AWESOME WORLD", "https://cdprojektred.com/")
	DRAW:AboutSpecial("YAMASHI, PSIBERX, WSSDUDE", "CYBER ENGINE TWEAKS", "https://github.com/yamashi/CyberEngineTweaks")



	-- section
	DRAW:PageAbout_Header("THANKS TO")


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
	DRAW:PageAbout_Header("CHANGELOG")
	DRAW:AboutVersion("v3.0")
	DRAW:AboutChange("rewrote entire core for improved option handling")
	DRAW:AboutChange("switched description file format to JSON")
	DRAW:AboutChange("split up option and render definitions")
	DRAW:AboutChange("refined user interface")
	DRAW:Spacer(1,5)
	DRAW:AboutAdded("added detection of cet and game versions")
	DRAW:AboutAdded("added detection for available GameSettings", "and GameOptions at startup")
	DRAW:Spacer(1,5)
	DRAW:AboutChange("all settings are disabled when not in the world")
	DRAW:AboutChange("settings are also disabled when not supported", "by the game or cet, with a small info")
	DRAW:Spacer(1,5)
	DRAW:AboutAdded("added fps and frametime graph with several", "settings like position and transparency")
	DRAW:AboutChange("the graph can be bound to a hotkey")
	DRAW:Spacer(1,5)
	DRAW:AboutAdded("added simple fps display to the main windows","with the current city and session time")
	DRAW:AboutChange("the main window can now be vertically scaled","depending on resolution")


	-- section
	DRAW:PageAbout_Header("MADE WITH")

	line = "Visual Studio Code, Notepad++ and some Brain ;)"
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line)







end





--
--
--//////////////////// ABOUT PAGE - SPECIFIC ELEMENTS ////////////////////
--
--

--
--// DRAW:PageAbout_Text(<STRING>,<STRING>,<STRING>,<BOOL>)
--
function DRAW:PageAbout_Text(text, color, style, sameline)

	-- catch unset
	local sameline = sameline or false

	-- paint it
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor(color, style))
	ImGui.Text(text)
	ImGui.PopStyleColor(1)

	if sameline then
		DRAW:Sameline()
	end
end



function DRAW:PageAbout_Header(text)

	-- make room
	DRAW:Spacer(1,UTIL:ScaleSwitch(20))

	-- centering text
	DRAW:Spacing(UTIL:TextCenter(DRAW.Scaling.Window.Width, text),1)

	DRAW:PageText("Grey", "Lightest", text)

	-- force underline
	DRAW:Underline(DRAW.Logo.Pixels,UTIL:ScaleSwitch(1),0,"center")

	-- make room
	DRAW:Spacer(1,UTIL:ScaleSwitch(5))
end





function DRAW:PageAbout_Version(text)

	-- push to the right side of the logo animation
	DRAW:Spacing((DRAW.Scaling.Window.Width / 2) + ((DRAW.Logo.Pixels / 2) - UTIL:TextWidth(text)) + UTIL:ScaleSwitch(3),1)

	-- paint it
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("Grey", "Normal"))
	ImGui.Text(text)
	ImGui.PopStyleColor(1)
end




function DRAW:PageAbout_Special(who, why, web)

	-- centering
	DRAW:Spacing(UTIL:TextCenter(DRAW.Scaling.Window.Width, "~ "..who.." ~"),1)
	DRAW:PageText("Orange", "Normal", "~ ", true)
	DRAW:PageText("White", "Normal", who, true)
	DRAW:PageText("Orange", "Normal", " ~", false)

	-- some room
	DRAW:Spacer(1,3)

	-- centering
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), why),1)
	DRAW:PageText("Grey", "Lighter", why, false)

	-- some room
	DRAW:Spacer(1,2)

	-- centering
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), web),1)
	DRAW:PageText("Grey", "Normal", web, false)

	DRAW:Spacer(1,10)
end





















--
--// DRAW:Underline(<NUMBER>,<NUMBER>,<NUMBER>,<STRING>)
--
function DRAW:Underline(width,height,padding,alignment)

	-- catch unset
	local width = width or DRAW.Scaling.Window.Width
	local height = height or UTIL:ScaleSwitch(1)
	local padding = padding or UTIL:ScaleSwitch(14)
	local alignment = alignment or "left"

	-- padding/aligment only if smaller
	if DRAW.Scaling.Window.Width > width
	then
		-- padding left (right not needed)
		if padding > 0 then DRAW:Spacing(padding,1) end

		-- align center or right (left is default)
		if alignment == "center" then DRAW:Spacing((DRAW.Scaling.Window.Width / 2) - (width / 2) - padding,1) end
		if alignment == "right" then DRAW:Spacing(DRAW.Scaling.Window.Width - width - (padding * 2),1) end
	end

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("Orange", "Dark"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("Orange", "Dark"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("Orange", "Dark"))

	-- use a blind button
	DRAW:FlexButton(width,height)

	-- drop stacks
	ImGui.PopStyleColor(3)
end
















--
--
--//////////////////// FLEX ELEMENTS ////////////////////
--
--

--
--// DRAW:FlexButton(<NUMBER>,<NUMBER>)
--
function DRAW:FlexButtonOLD(width, height)

	-- catch unset
	local width = width or UTIL:ScaleSwitch(1)
	local height = height or UTIL:ScaleSwitch(1)

	-- add stack
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)

	-- element id
	ImGui.PushID("DE_StyleButton")
	local _blind = ImGui.Button("", width, height)
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(1)
end


--
--// DRAW:FlexButton(<NUMBER>,<NUMBER>)
--
function DRAW:FlexButton(width, height)

	-- catch unset
	local width = width or UTIL:ScaleSwitch(1)
	local height = height or UTIL:ScaleSwitch(1)

	-- element id
	ImGui.PushID("DE_StyleButton")
	local _blind = ImGui.Button("", width, height)
	ImGui.PopID()
end





















function DRAW:PageText(color, style, text, same)

	-- catch unset
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
	DRAW:Spacer(1,20)

	-- centering
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), text),1)
	DRAW:PageText("White", "Dark", text)
	DRAW:Spacer(1,2)
	DRAW:Spacing(math.floor(ImGui.GetWindowWidth() - 356) / 2,6)

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

	DRAW:Spacer(1,5)
end



function DRAW:AboutSpecial(who, why, web)

	-- centering
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), "~ "..who.." ~"),1)
	DRAW:PageText("Orange", "Normal", "~ ", true)
	DRAW:PageText("White", "Normal", who, true)
	DRAW:PageText("Orange", "Normal", " ~", false)

	-- some room
	DRAW:Spacer(1,3)

	-- centering
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), why),1)
	DRAW:PageText("Grey", "Lighter", why, false)

	-- some room
	DRAW:Spacer(1,2)

	-- centering
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), web),1)
	DRAW:PageText("Grey", "Normal", web, false)

	DRAW:Spacer(1,10)
end



function DRAW:AboutThanks(who, why, add)

	-- catch unset
	local why = why or false
	local add = add or false

	-- centering
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), who),1)
	DRAW:PageText("Grey", "Lightest", who, false)

	-- optional
	if why
	then
		DRAW:Spacer(1,2)
		DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), why),1)
		DRAW:PageText("Grey", "Lighter", why, false)
	end

	-- optional
	if add
	then
		DRAW:Spacer(1,2)
		DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), add),1)
		DRAW:PageText("Grey", "Lighter", add, false)
	end
end



function DRAW:AboutVersion(which)
	DRAW:Spacing(52,1)
	DRAW:PageText("White", "Dark", which)
	DRAW:Spacer(1,1)
	DRAW:Spacing(52,1)

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

	DRAW:Spacer(1,3)
end

function DRAW:AboutAdded(what, add)

	local add = add or false

	DRAW:Spacing(52,1)
	DRAW:PageText("Orange", "Normal", "+ ", true)
	DRAW:PageText("Grey", "Lighter", what, false)

	if add
	then
		DRAW:Spacing(66,1)
		DRAW:PageText("Grey", "Lighter", add, false)
	end

	DRAW:Spacer(1,3)
end

function DRAW:AboutChange(what, add)

	local add = add or false

	DRAW:Spacing(52,1)
	DRAW:PageText("Grey", "Normal", "* ", true)
	DRAW:PageText("Grey", "Lighter", what, false)

	if add
	then
		DRAW:Spacing(66,1)
		DRAW:PageText("Grey", "Lighter", add, false)
	end

	DRAW:Spacer(1,3)
end






function DRAW:AboutBreak()

	-- centering
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), "___"),1)
	DRAW:PageText("Grey", "Dark", "___", false)
	DRAW:Spacer(1,8)
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

	-- update pixel size
	DRAW.Logo.Pixels = (51 * math.floor(UTIL:ScaleSwitch(6))) + 50

	-- update center spacer
	DRAW.Logo.Center = (DRAW.Scaling.Window.Width - DRAW.Logo.Pixels) / 2

	-- loop matrix rows
	for _,_row in pairs(DRAW.Logo.Matrix)
	do
		-- centering row
		DRAW:Spacing(DRAW.Logo.Center)

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

				-- call painter
				DRAW:LogoPainter(_frames, math.random(1,UTIL:TableLength(DRAW.Logo.Colors)))
				DRAW:Sameline()
				DRAW:Spacer(1,1)
				DRAW:Sameline()
			-- or not
			else
				-- inc blanks
				_blanks = _blanks + 1

				-- call painter
				DRAW:LogoBlanker(_blanks)
				DRAW:Sameline()
				DRAW:Spacer(1,1)
				DRAW:Sameline()
			end
		end

		-- right end
		DRAW:Spacer(1,1)

		-- space between
		--DRAW:Spacing(UTIL:WindowWidth(0.25),UTIL:WindowWidth(0.25))
		DRAW:Spacer(1,1)
	end


	--ImGui.EndChild()

end


function DRAW:LogoBlanker(_id)

	-- paint child
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor())
	local _blind = ImGui.BeginChildFrame(_id, UTIL:ScaleSwitch(6), UTIL:ScaleSwitch(6), ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoScrollWithMouse)
	ImGui.PopStyleColor(1)

	-- close child
	ImGui.EndChildFrame()
end



function DRAW:LogoPainter(_id, _transparency)

	-- base color
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
function DRAW:Pre(project, version, runtime, scaling, debug)
	local o = {}
	setmetatable(o, self)
	self.__index = self

	-- identity
	DRAW.Project = project
	DRAW.Version = version
	DRAW.Runtime = runtime
	DRAW.Scaling = scaling
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
		Pixels = 0,
		Center = 0,
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

	return o
end

-- return
return DRAW