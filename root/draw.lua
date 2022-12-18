--
-- Developer Extras v3
-- 2022 by FreakaZ
--
-- https://rootpunk.com/mod/#developerextras
-- https://github.com/rp-freakaz/DeveloperExtras
-- hello@rootpunk.com
--
-- CHILD FLAGS "ImGuiWindowFlags.NoTitleBar + ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoResize + ImGuiWindowFlags.NoCollapse + ImGuiWindowFlags.NoMove + ImGuiWindowFlags.NoBackground + ImGuiWindowFlags.AlwaysAutoResize"
--
local DRAW = {}

-- libraries
local UTIL = require("root/util.lua"):Pre()

--
--
--//////////////////// COLORS ////////////////////
--
--

--
--// DRAW:GetColor(<STRING>,<INT>)
--
function DRAW:GetColor(color, state)

	-- catch unset
	local color = color or false
	local state = state or 0

	--
	--// GetStatus(<BOOL>,<FLOAT>)
	--
	local function GetStatus(state, value)
		if state > 0 then return UTIL:ShortenFloat(value / 1.75) end
		return value
	end

	--
	--// GetShared(<STRING>,<INT>)
	--
	local function GetShared(color, state)

		-- fallback
		if color == "fallback"						then return ImGui.GetColorU32(1, 0, 0, 0.5) end
		if color == "transparency"					then return ImGui.GetColorU32(0, 0, 0, 0) end

		-- solids
		if color == "generic/white"					then return ImGui.GetColorU32(1, 1, 1, GetStatus(state, 1)) end
		if color == "generic/black"					then return ImGui.GetColorU32(0, 0, 0, GetStatus(state, 1)) end
		if color == "generic/orange"					then return ImGui.GetColorU32(1, 0.56, 0.13, GetStatus(state, 1)) end
		if color == "generic/grey"					then return ImGui.GetColorU32(0.5, 0.5, 0.5, GetStatus(state, 1)) end
		if color == "generic/cyan"					then return ImGui.GetColorU32(0, 0.92, 0.92, GetStatus(state, 1)) end
		if color == "generic/pink"					then return ImGui.GetColorU32(0.89, 0, 0.98, GetStatus(state, 1)) end
		if color == "generic/red"					then return ImGui.GetColorU32(1, 0, 0, GetStatus(state, 1)) end

		-- variations
		if color == "generic/white/dark"				then return ImGui.GetColorU32(0.8, 0.8, 0.85, GetStatus(state, 0.8)) end
		if color == "generic/white/light"				then return ImGui.GetColorU32(0.9, 0.9, 1, GetStatus(state, 1)) end
		if color == "generic/white/normal"				then return ImGui.GetColorU32(0.9, 0.9, 1, GetStatus(state, 0.9)) end

		if color == "generic/black/dark"				then return ImGui.GetColorU32(0.01, 0.01, 0.03, GetStatus(state, 0.9)) end
		if color == "generic/black/light"				then return ImGui.GetColorU32(0.1, 0.1, 0.12, GetStatus(state, 0.5)) end
		if color == "generic/black/normal"				then return ImGui.GetColorU32(0.04, 0.04, 0.06, GetStatus(state, 0.85)) end

		if color == "generic/cyan/dark"					then return ImGui.GetColorU32(0, 0.52, 0.52, GetStatus(state, 1)) end
		if color == "generic/cyan/light"				then return ImGui.GetColorU32(0, 0.72, 0.72, GetStatus(state, 1)) end
		if color == "generic/cyan/normal"				then return ImGui.GetColorU32(0, 0.92, 0.92, GetStatus(state, 1)) end

		if color == "generic/pink/dark"					then return ImGui.GetColorU32(0.69, 0, 0.78, GetStatus(state, 1)) end
		if color == "generic/pink/light"				then return ImGui.GetColorU32(0.69, 0, 0.78, GetStatus(state, 1)) end
		if color == "generic/pink/normal"				then return ImGui.GetColorU32(0.69, 0, 0.78, GetStatus(state, 1)) end

		if color == "generic/orange/dark"				then return ImGui.GetColorU32(1, 0.56, 0.13, GetStatus(state, 0.7)) end
		if color == "generic/orange/darker"				then return ImGui.GetColorU32(1, 0.56, 0.13, GetStatus(state, 0.5)) end
		if color == "generic/orange/darkest"				then return ImGui.GetColorU32(1, 0.56, 0.13, GetStatus(state, 0.3)) end
		if color == "generic/orange/light"				then return ImGui.GetColorU32(1, 0.56, 0.13, GetStatus(state, 1)) end
		if color == "generic/orange/normal"				then return ImGui.GetColorU32(1, 0.56, 0.13, GetStatus(state, 0.85)) end

		if color == "generic/grey/dark"					then return ImGui.GetColorU32(0.3, 0.3, 0.33, GetStatus(state, 0.7)) end
		if color == "generic/grey/darker"				then return ImGui.GetColorU32(0.2, 0.2, 0.23, GetStatus(state, 0.7)) end
		if color == "generic/grey/darkest"				then return ImGui.GetColorU32(0.1, 0.1, 0.13, GetStatus(state, 0.7)) end
		if color == "generic/grey/light"				then return ImGui.GetColorU32(0.5, 0.5, 0.53, GetStatus(state, 0.7)) end
		if color == "generic/grey/lighter"				then return ImGui.GetColorU32(0.6, 0.6, 0.63, GetStatus(state, 0.8)) end
		if color == "generic/grey/lightest"				then return ImGui.GetColorU32(0.7, 0.7, 0.73, GetStatus(state, 0.9)) end
		if color == "generic/grey/normal"				then return ImGui.GetColorU32(0.4, 0.4, 0.43, GetStatus(state, 0.7)) end
	end

	-- no color
	if not color							then return ImGui.GetColorU32(0, 0, 0, 0) end

	-- theme: default
	if DRAW.Runtime.Themes.Select == 0
	then
		-- window
		if color == "window/main/text"				then return GetShared("generic/white/light", state) end
		if color == "window/main/border"			then return ImGui.GetColorU32(0.2, 0.2, 0.23, 0.3) end
		if color == "window/main/background"			then return GetShared("generic/black/dark", state) end
		if color == "window/main/title/background"		then return GetShared("generic/black/dark", state) end
		if color == "window/main/title/background/active"	then return GetShared("generic/black/dark", state) end
		if color == "window/main/title/background/collapsed"	then return GetShared("generic/black/dark", state) end
		if color == "window/main/resize"			then return GetShared("generic/grey/dark", state) end
		if color == "window/main/resize/active"			then return GetShared("generic/orange/normal", state) end
		if color == "window/main/resize/hovered"		then return GetShared("generic/orange/light", state) end
		if color == "window/main/separator"			then return GetShared("generic/grey/darkest", state) end
		if color == "window/main/scrollbar"			then return GetShared("generic/orange/dark", state) end
		if color == "window/main/scrollbar/hovered"		then return GetShared("generic/orange/normal", state) end
		if color == "window/main/scrollbar/background"		then return GetShared("transparency", state) end

		-- tabbar
		if color == "tabbar/text"				then return GetShared("generic/white/normal", state) end
		if color == "tabbar/tab"				then return GetShared("generic/grey/darker", state) end
		if color == "tabbar/tab/active"				then return GetShared("generic/orange/normal", state) end
		if color == "tabbar/tab/hovered"			then return GetShared("generic/orange/light", state) end
		if color == "tabbar/bottomline"				then return GetShared("generic/orange/normal", state) end

		-- collapse
		if color == "collapse/text"				then return GetShared("generic/white/normal", state) end
		if color == "collapse/header"				then return GetShared("generic/grey/darker", state) end
		if color == "collapse/header/active"			then return GetShared("generic/orange/normal", state) end
		if color == "collapse/header/hovered"			then return GetShared("generic/orange/light", state) end

		-- generic
		if color == "element/title"				then return GetShared("generic/white/normal", state) end
		if color == "element/notice"				then return GetShared("generic/white/dark", state) end
		if color == "element/description"			then return GetShared("generic/grey/lighter", state) end
		if color == "element/decoration"			then return GetShared("generic/orange/normal", state) end

		-- graph
		if color == "graph/text/name"				then return ImGui.GetColorU32(0.6, 0.6, 0.63, state) end
		if color == "graph/text/value"				then return ImGui.GetColorU32(0.8, 0.8, 0.85, state) end
		if color == "graphbar/background"			then return ImGui.GetColorU32(0.1, 0.1, 0.13, state) end
		if color == "graphbar/progessbar"			then return ImGui.GetColorU32(1, 0.56, 0.13, state) end

		-- slider
		if color == "slider/minmax"				then return GetShared("generic/grey/light", state) end
		if color == "slider/text"				then return GetShared("generic/white/normal", state) end
		if color == "slider/grab"				then return GetShared("generic/orange/normal", state) end
		if color == "slider/grab/active"			then return GetShared("generic/orange/light", state) end
		if color == "slider/background"				then return GetShared("generic/grey/darker", state) end
		if color == "slider/background/active"			then return GetShared("generic/grey/darker", state) end
		if color == "slider/background/hovered"			then return GetShared("generic/grey/darker", state) end

		-- checkbox
		if color == "checkbox/checkmark"			then return GetShared("generic/white/normal", state) end
		if color == "checkbox/on/title"				then return GetShared("generic/orange/normal", state) end
		if color == "checkbox/on/background"			then return GetShared("generic/grey/darker", state) end
		if color == "checkbox/on/background/active"		then return GetShared("generic/orange/dark", state) end
		if color == "checkbox/on/background/hovered"		then return GetShared("generic/orange/normal", state) end
		if color == "checkbox/off/title"			then return GetShared("generic/white/normal", state) end
		if color == "checkbox/off/background"			then return GetShared("generic/grey/darker", state) end
		if color == "checkbox/off/background/active"		then return GetShared("generic/grey/darker", state) end
		if color == "checkbox/off/background/hovered"		then return GetShared("generic/grey/darker", state) end

		-- quickshift
		if color == "quickshift/background"			then return GetShared("generic/grey/darker", state) end
		if color == "quickshift/background/active"		then return GetShared("generic/grey/darker", state) end
		if color == "quickshift/background/hovered"		then return GetShared("generic/grey/darker", state) end
		if color == "quickshift/on/border"			then return GetShared("generic/orange/darkest", state) end
		if color == "quickshift/on/grab/normal"			then return GetShared("generic/orange/normal", state) end
		if color == "quickshift/on/grab/active"			then return GetShared("generic/orange/light", state) end
		if color == "quickshift/off/border"			then return GetShared("generic/grey/dark", state) end
		if color == "quickshift/off/grab/normal"		then return GetShared("generic/grey/light", state) end
		if color == "quickshift/off/grab/active"		then return GetShared("generic/grey/lighter", state) end

		-- combobox
		if color == "combobox/border"				then return GetShared("generic/grey/dark", state) end
		if color == "combobox/background"			then return GetShared("generic/grey/darker", state) end
		if color == "combobox/popup/background"			then return GetShared("generic/grey/darker", state) end
		if color == "combobox/button"				then return GetShared("generic/orange/normal", state) end
		if color == "combobox/button/active"			then return GetShared("generic/orange/normal", state) end
		if color == "combobox/button/hovered"			then return GetShared("generic/orange/light", state) end
		if color == "combobox/header"				then return GetShared("generic/grey/normal", state) end
		if color == "combobox/header/active"			then return GetShared("generic/orange/light", state) end
		if color == "combobox/header/hovered"			then return GetShared("generic/orange/normal", state) end

		-- notification
		if color == "notification/text"				then return GetShared("generic/white/dark", state) end
		if color == "notification/background"			then return GetShared("generic/grey/darkest", state) end
		if color == "notification/decoration"			then return GetShared("generic/orange/normal", state) end

		-- animations
		if color == "animations/logo/default"			then return ImGui.GetColorU32(1, 0.56, 0.13, state) end
		if color == "animations/logo/highlight"			then return ImGui.GetColorU32(0.9, 0.9, 1, state) end
		if color == "animations/logo/decoration"		then return ImGui.GetColorU32(0.4, 0.4, 0.43, state) end

		-- debug
		if color == "debug/table/background"			then return GetShared("generic/grey/darker", state) end





		-- fallback
		return GetShared("fallback")
	end



	-- theme: default (backup)
	if DRAW.Runtime.Themes.Select == 1
	then
		-- window
		if color == "window/main/text"				then return GetShared("generic/white/light", state) end
		if color == "window/main/border"			then return ImGui.GetColorU32(0.2, 0.2, 0.23, 0.3) end
		if color == "window/main/background"			then return GetShared("generic/black/dark", state) end
		if color == "window/main/title/background"		then return GetShared("generic/black/dark", state) end
		if color == "window/main/title/background/active"	then return GetShared("generic/black/dark", state) end
		if color == "window/main/title/background/collapsed"	then return GetShared("generic/black/dark", state) end
		if color == "window/main/resize"			then return GetShared("generic/grey/dark", state) end
		if color == "window/main/resize/active"			then return GetShared("generic/orange/normal", state) end
		if color == "window/main/resize/hovered"		then return GetShared("generic/orange/light", state) end
		if color == "window/main/separator"			then return GetShared("generic/grey/darkest", state) end
		if color == "window/main/scrollbar"			then return GetShared("generic/orange/dark", state) end
		if color == "window/main/scrollbar/hovered"		then return GetShared("generic/orange/normal", state) end
		if color == "window/main/scrollbar/background"		then return GetShared("transparency", state) end

		-- tabbar
		if color == "tabbar/text"				then return GetShared("generic/white/normal", state) end
		if color == "tabbar/tab"				then return GetShared("generic/grey/darker", state) end
		if color == "tabbar/tab/active"				then return GetShared("generic/orange/normal", state) end
		if color == "tabbar/tab/hovered"			then return GetShared("generic/orange/light", state) end
		if color == "tabbar/bottomline"				then return GetShared("generic/orange/normal", state) end

		-- collapse
		if color == "collapse/text"				then return GetShared("generic/white/normal", state) end
		if color == "collapse/header"				then return GetShared("generic/grey/darker", state) end
		if color == "collapse/header/active"			then return GetShared("generic/orange/normal", state) end
		if color == "collapse/header/hovered"			then return GetShared("generic/orange/light", state) end

		-- generic
		if color == "element/title"				then return GetShared("generic/white/normal", state) end
		if color == "element/notice"				then return GetShared("generic/white/dark", state) end
		if color == "element/description"			then return GetShared("generic/grey/lighter", state) end
		if color == "element/decoration"			then return GetShared("generic/orange/normal", state) end

		-- graph
		if color == "graph/text/name"				then return ImGui.GetColorU32(0.6, 0.6, 0.63, state) end
		if color == "graph/text/value"				then return ImGui.GetColorU32(0.8, 0.8, 0.85, state) end
		if color == "graphbar/background"			then return ImGui.GetColorU32(0.1, 0.1, 0.13, state) end
		if color == "graphbar/progessbar"			then return ImGui.GetColorU32(1, 0.56, 0.13, state) end

		-- slider
		if color == "slider/minmax"				then return GetShared("generic/grey/light", state) end
		if color == "slider/text"				then return GetShared("generic/white/normal", state) end
		if color == "slider/grab"				then return GetShared("generic/orange/normal", state) end
		if color == "slider/grab/active"			then return GetShared("generic/orange/light", state) end
		if color == "slider/background"				then return GetShared("generic/grey/darker", state) end
		if color == "slider/background/active"			then return GetShared("generic/grey/darker", state) end
		if color == "slider/background/hovered"			then return GetShared("generic/grey/darker", state) end

		-- checkbox
		if color == "checkbox/checkmark"			then return GetShared("generic/white/normal", state) end
		if color == "checkbox/on/title"				then return GetShared("generic/orange/normal", state) end
		if color == "checkbox/on/background"			then return GetShared("generic/grey/darker", state) end
		if color == "checkbox/on/background/active"		then return GetShared("generic/orange/dark", state) end
		if color == "checkbox/on/background/hovered"		then return GetShared("generic/orange/normal", state) end
		if color == "checkbox/off/title"			then return GetShared("generic/white/normal", state) end
		if color == "checkbox/off/background"			then return GetShared("generic/grey/darker", state) end
		if color == "checkbox/off/background/active"		then return GetShared("generic/grey/darker", state) end
		if color == "checkbox/off/background/hovered"		then return GetShared("generic/grey/darker", state) end

		-- quickshift
		if color == "quickshift/background"			then return GetShared("generic/grey/darker", state) end
		if color == "quickshift/background/active"		then return GetShared("generic/grey/darker", state) end
		if color == "quickshift/background/hovered"		then return GetShared("generic/grey/darker", state) end
		if color == "quickshift/on/border"			then return GetShared("generic/orange/darkest", state) end
		if color == "quickshift/on/grab/normal"			then return GetShared("generic/orange/normal", state) end
		if color == "quickshift/on/grab/active"			then return GetShared("generic/orange/light", state) end
		if color == "quickshift/off/border"			then return GetShared("generic/grey/dark", state) end
		if color == "quickshift/off/grab/normal"		then return GetShared("generic/grey/light", state) end
		if color == "quickshift/off/grab/active"		then return GetShared("generic/grey/lighter", state) end

		-- combobox
		if color == "combobox/border"				then return GetShared("generic/grey/dark", state) end
		if color == "combobox/background"			then return GetShared("generic/grey/darker", state) end
		if color == "combobox/popup/background"			then return GetShared("generic/grey/darker", state) end
		if color == "combobox/button"				then return GetShared("generic/orange/normal", state) end
		if color == "combobox/button/active"			then return GetShared("generic/orange/normal", state) end
		if color == "combobox/button/hovered"			then return GetShared("generic/orange/light", state) end
		if color == "combobox/header"				then return GetShared("generic/grey/normal", state) end
		if color == "combobox/header/active"			then return GetShared("generic/orange/light", state) end
		if color == "combobox/header/hovered"			then return GetShared("generic/orange/normal", state) end

		-- notification
		if color == "notification/text"				then return GetShared("generic/white/dark", state) end
		if color == "notification/background"			then return GetShared("generic/grey/darkest", state) end
		if color == "notification/decoration"			then return GetShared("generic/orange/normal", state) end

		-- animations
		if color == "animations/logo/default"			then return ImGui.GetColorU32(1, 0.56, 0.13, state) end
		if color == "animations/logo/highlight"			then return ImGui.GetColorU32(0.9, 0.9, 1, state) end
		if color == "animations/logo/decoration"		then return ImGui.GetColorU32(0.4, 0.4, 0.43, state) end

		-- debug
		if color == "debug/table/background"			then return GetShared("generic/grey/darker", state) end





		-- fallback
		return GetShared("fallback")
	end












	-- theme: white satin
	if DRAW.Runtime.Themes.Select == 2
	then
		-- window
		if color == "window/main/text"				then return GetShared("generic/grey/darker") end
		if color == "window/main/border"			then return ImGui.GetColorU32(0.95, 0.95, 1, GetStatus(state, 1)) end
		if color == "window/main/background"			then return ImGui.GetColorU32(0.95, 0.95, 1, GetStatus(state, 0.85)) end
		if color == "window/main/title/background"		then return ImGui.GetColorU32(0.95, 0.95, 1, GetStatus(state, 0.85)) end
		if color == "window/main/title/background/active"	then return ImGui.GetColorU32(0.95, 0.95, 1, GetStatus(state, 0.85)) end
		if color == "window/main/title/background/collapsed"	then return ImGui.GetColorU32(0.95, 0.95, 1, GetStatus(state, 0.85)) end
		if color == "window/main/resize"			then return GetShared("generic/grey/light") end
		if color == "window/main/resize/active"			then return GetShared("generic/grey/normal") end
		if color == "window/main/resize/hovered"		then return GetShared("generic/grey/dark") end
		if color == "window/main/separator"			then return GetShared("generic/white/dark") end

		-- tabbar
		if color == "tabbar/text"				then return GetShared("generic/black/normal") end
		if color == "tabbar/tab"				then return GetShared("generic/white/dark") end
		if color == "tabbar/tab/active"				then return GetShared("generic/grey/lightest") end
		if color == "tabbar/tab/hovered"			then return GetShared("generic/grey/lighter") end
		if color == "tabbar/bottomline"				then return GetShared("generic/grey/lightest") end

		-- elements
		if color == "element/title"				then return GetShared("generic/black/normal") end
		if color == "element/notice"				then return GetShared("generic/black/light") end
		if color == "element/description"			then return GetShared("generic/grey/dark") end
		if color == "element/decoration"			then return GetShared("generic/grey/dark") end

		-- slider
		if color == "slider/minmax"				then return GetShared("generic/grey/light") end
		if color == "slider/text"				then return GetShared("generic/white/normal") end
		if color == "slider/grab"				then return GetShared("generic/orange/normal") end
		if color == "slider/grab/active"			then return GetShared("generic/orange/light") end
		if color == "slider/background"				then return GetShared("generic/grey/darker") end
		if color == "slider/background/active"			then return GetShared("generic/grey/darker") end
		if color == "slider/background/hovered"			then return GetShared("generic/grey/darker") end


		-- quickshift
		if color == "quickshift/background"			then return GetShared("generic/white/dark") end
		if color == "quickshift/background/active"		then return GetShared("generic/white/dark") end
		if color == "quickshift/background/hovered"		then return GetShared("generic/white/dark") end
		if color == "quickshift/on/border"			then return GetShared("generic/grey/lightest") end
		if color == "quickshift/on/grab/normal"			then return GetShared("generic/white/light") end
		if color == "quickshift/on/grab/active"			then return GetShared("generic/white/light") end
		if color == "quickshift/off/border"			then return GetShared("generic/grey/lightest") end
		if color == "quickshift/off/grab/normal"		then return GetShared("generic/grey/darker") end
		if color == "quickshift/off/grab/active"		then return GetShared("generic/grey/darker") end

		-- combobox
		if color == "combobox/border"				then return GetShared("generic/grey/lightest") end
		if color == "combobox/background"			then return GetShared("generic/white/dark") end
		if color == "combobox/popup/background"			then return GetShared("generic/white/dark") end
		if color == "combobox/button"				then return GetShared("generic/white/normal") end
		if color == "combobox/button/active"			then return GetShared("generic/white/normal") end
		if color == "combobox/button/hovered"			then return GetShared("generic/white/light") end
		if color == "combobox/header"				then return GetShared("generic/grey/normal") end
		if color == "combobox/header/active"			then return GetShared("generic/orange/light") end
		if color == "combobox/header/hovered"			then return GetShared("generic/orange/normal") end



		-- animations
		if color == "animations/logo/default"			then return ImGui.GetColorU32(0, 0.5, 0.75, state) end
		if color == "animations/logo/highlight"			then return ImGui.GetColorU32(0.3, 0.3, 0.33, state) end
		if color == "animations/logo/decoration"		then return ImGui.GetColorU32(0.5, 0.5, 0.53, state) end


		-- fallback
		return GetShared("fallback")
	end


	-- theme: mox destiny
	if DRAW.Runtime.Themes.Select == 3
	then
		-- window
		if color == "window/main/text"				then return GetShared("generic/pink") end
		if color == "window/main/border"			then return GetShared("generic/cyan") end
		if color == "window/main/background"			then return ImGui.GetColorU32(0.15, 0.15, 0.2, GetStatus(state, 0.85)) end
		if color == "window/main/title/background"		then return ImGui.GetColorU32(0.15, 0.15, 0.2, GetStatus(state, 0.85)) end
		if color == "window/main/title/background/active"	then return ImGui.GetColorU32(0.15, 0.15, 0.2, GetStatus(state, 0.85)) end
		if color == "window/main/title/background/collapsed"	then return ImGui.GetColorU32(0.15, 0.15, 0.2, GetStatus(state, 0.85)) end
		if color == "window/main/resize"			then return GetShared("generic/grey/light") end
		if color == "window/main/resize/active"			then return GetShared("generic/grey/normal") end
		if color == "window/main/resize/hovered"		then return GetShared("generic/grey/dark") end
		if color == "window/main/separator"			then return GetShared("generic/white/dark") end

		-- tabbar
		if color == "tabbar/text"				then return GetShared("generic/black/normal") end
		if color == "tabbar/tab"				then return GetShared("generic/white/dark") end
		if color == "tabbar/tab/active"				then return GetShared("generic/grey/lightest") end
		if color == "tabbar/tab/hovered"			then return GetShared("generic/grey/lighter") end
		if color == "tabbar/bottomline"				then return GetShared("generic/grey/lightest") end

		if color == "quickshift/title"				then return GetShared("generic/black/normal") end
		if color == "quickshift/description"			then return GetShared("generic/black/light") end
		if color == "quickshift/background"			then return GetShared("generic/white/dark") end
		if color == "quickshift/background/active"		then return GetShared("generic/white/dark") end
		if color == "quickshift/background/hovered"		then return GetShared("generic/white/dark") end
		if color == "quickshift/on/border"			then return GetShared("generic/grey/lightest") end
		if color == "quickshift/on/grab/normal"			then return GetShared("generic/white/light") end
		if color == "quickshift/on/grab/active"			then return GetShared("generic/white/light") end
		if color == "quickshift/off/border"			then return GetShared("generic/grey/lightest") end
		if color == "quickshift/off/grab/normal"		then return GetShared("generic/grey/darker") end
		if color == "quickshift/off/grab/active"		then return GetShared("generic/grey/darker") end

		if color == "combobox/title"				then return GetShared("generic/black/normal") end
		if color == "combobox/description"			then return GetShared("generic/black/light") end
		if color == "combobox/border"				then return GetShared("generic/grey/lightest") end
		if color == "combobox/background"			then return GetShared("generic/white/dark") end
		if color == "combobox/popup/background"			then return GetShared("generic/white/dark") end
		if color == "combobox/button"				then return GetShared("generic/white/normal") end
		if color == "combobox/button/active"			then return GetShared("generic/white/normal") end
		if color == "combobox/button/hovered"			then return GetShared("generic/white/light") end
		if color == "combobox/button/decoration"		then return GetShared("generic/grey/darker") end
		if color == "combobox/header"				then return GetShared("generic/grey/normal") end
		if color == "combobox/header/active"			then return GetShared("generic/orange/light") end
		if color == "combobox/header/hovered"			then return GetShared("generic/orange/normal") end

		-- fallback
		return GetShared("fallback")
	end
end

--
--
--//////////////////// BASE ELEMENTS ////////////////////
--
--

--
--// DRAW:WindowStart()
--
function DRAW:WindowStart(resize)

	-- first position
	ImGui.SetNextWindowPos(100, 100, ImGuiCond.FirstUseEver)

	-- allow window resize
	if DRAW.isDebug and resize then
		ImGui.SetNextWindowSizeConstraints(UTIL:ScreenScale(456), UTIL:ScreenScale(600), DRAW.Scaling.Screen.Usable, DRAW.Scaling.Screen.Height - 100)
	else
		ImGui.SetNextWindowSizeConstraints(UTIL:ScreenScale(456), UTIL:ScreenScale(600), UTIL:ScreenScale(456), DRAW.Scaling.Screen.Height - 100)
	end

	-- add stacks (global)
	ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarSize, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarRounding, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FrameBorderSize, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing, UTIL:WindowScale(2), 0)
	ImGui.PushStyleVar(ImGuiStyleVar.GrabRounding, UTIL:ScreenScale(2))
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.ChildBorderSize, 0)

	-- add stacks (window)
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("window/main/text"))
	ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColor("window/main/border"))
	ImGui.PushStyleColor(ImGuiCol.WindowBg, DRAW:GetColor("window/main/background"))
	ImGui.PushStyleColor(ImGuiCol.TitleBg, DRAW:GetColor("window/main/title/background"))
	ImGui.PushStyleColor(ImGuiCol.TitleBgActive, DRAW:GetColor("window/main/title/background/active"))
	ImGui.PushStyleColor(ImGuiCol.TitleBgCollapsed, DRAW:GetColor("window/main/title/background/collapsed"))
	ImGui.PushStyleColor(ImGuiCol.ResizeGrip, DRAW:GetColor("window/main/resize"))
	ImGui.PushStyleColor(ImGuiCol.ResizeGripActive, DRAW:GetColor("window/main/resize/active"))
	ImGui.PushStyleColor(ImGuiCol.ResizeGripHovered, DRAW:GetColor("window/main/resize/hovered"))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor())
	ImGui.PushStyleVar(ImGuiStyleVar.WindowBorderSize, UTIL:BorderScale(DRAW.Runtime.Window.Border))
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, UTIL:ScreenScale(6))
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:WindowScale(8), UTIL:WindowScale(10))
	ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing, UTIL:WindowScale(7), 0)

	-- trigger
	local _trigger

	-- native scaling
	if DRAW.Scaling.Enable
	then
		-- create window
		_trigger = ImGui.Begin("~ "..string.upper(DRAW.Project).." ~", ImGuiWindowFlags.NoScrollbar)
		ImGui.SetWindowFontScale(DRAW.Scaling.Window.Factor)
	else
		-- create window
		_trigger = ImGui.Begin(UTIL:SpaceBetween(DRAW.Project.." v"..DRAW.Version.String, "CET "..DRAW.Version.Cet.String.." // PATCH "..DRAW.Version.Game.String, ImGui.GetWindowWidth() - 36, UTIL:TextWidth(" ")), ImGuiWindowFlags.NoScrollbar)
	end

	-- drop stacks (window)
	ImGui.PopStyleVar(5)
	ImGui.PopStyleColor(12)

	return _trigger
end

--
--// DRAW:WindowEnd()
--
function DRAW:WindowEnd()

	-- drop stacks (global)
	ImGui.PopStyleVar(10)

	-- end window
	ImGui.End()
end

--
--// DRAW:TabbarStart()
--
function DRAW:TabbarStart()

	-- add stacks (tabbar)
	ImGui.PushStyleColor(ImGuiCol.TabActive, DRAW:GetColor("tabbar/bottomline"))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:WindowScale(4), UTIL:WindowScale(6))

	-- fix left border size
	if UTIL:BorderScale(DRAW.Runtime.Window.Border) > 0
	then
		DRAW:Spacing(UTIL:BorderScale(DRAW.Runtime.Window.Border),1)
	end

	-- create tabbar
	local _trigger = ImGui.BeginTabBar("DE_TB")

	-- drop stacks (tabbar)
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(1)

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

	-- add stacks (tabitem)
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("tabbar/text"))
	ImGui.PushStyleColor(ImGuiCol.Tab, DRAW:GetColor("tabbar/tab"))
	ImGui.PushStyleColor(ImGuiCol.TabActive, DRAW:GetColor("tabbar/tab/active"))
	ImGui.PushStyleColor(ImGuiCol.TabHovered, DRAW:GetColor("tabbar/tab/hovered"))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:WindowScale(7), UTIL:WindowScale(6))

	-- create tabitem
	local _trigger = ImGui.BeginTabItem("¨"..title)

	-- drop stacks (tabitem)
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

	-- add stacks (tabchild)
	ImGui.PushStyleColor(ImGuiCol.ScrollbarBg, DRAW:GetColor("window/main/scrollbar/background"))
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrab, DRAW:GetColor("window/main/scrollbar"))
	ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabHovered, DRAW:GetColor("window/main/scrollbar/hovered"))
	-- add stacks (conditional)
	if scroll then ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarSize, UTIL:WindowScale(10)) end

	-- create tabchild
	local _trigger = ImGui.BeginChild("DE_TC", width, height, false, ImGuiWindowFlags.AlwaysVerticalScrollbar + ImGuiWindowFlags.NoBackground)

	-- drop stacks (conditional)
	if scroll then ImGui.PopStyleVar(1) end
	-- drop stacks (tabchild)
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

	-- add stacks (collapse)
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("collapse/text"))
	ImGui.PushStyleColor(ImGuiCol.Header, DRAW:GetColor("collapse/header"))
	ImGui.PushStyleColor(ImGuiCol.HeaderActive, DRAW:GetColor("collapse/header/active"))
	ImGui.PushStyleColor(ImGuiCol.HeaderHovered, DRAW:GetColor("collapse/header/hovered"))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:WindowScale(8), UTIL:WindowScale(11))

	-- top space
	DRAW:Spacer(1,UTIL:WindowScale(3))

	-- create collapse
	local _trigger = ImGui.CollapsingHeader(title)

	-- drop stacks (collapse)
	ImGui.PopStyleVar(2)
	ImGui.PopStyleColor(4)

	return _trigger
end

--
--
--//////////////////// STYLE ELEMENTS ////////////////////
--
--

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
function DRAW:Separator(height, color)

	-- catch unset
	local color = color or "window/main/separator"

	-- add stacks (separator)
	ImGui.PushStyleColor(ImGuiCol.Separator, DRAW:GetColor(color))
	ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 0, 1)

	-- multiple if wanted
	if height > 0 then
		for i=1, height do
			ImGui.Separator()
		end
	end

	-- drop stacks (separator)
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(1)
end

--
--
--//////////////////// RENDER ELEMENTS ////////////////////
--
--

--
--// DRAW:Checkbox(<TABLE>,<TABLE>,<INT>,<BOOL>)
--
function DRAW:Checkbox(render, option, state, value)

	-- default spacing
	local _left = UTIL:WindowScale(10)
	local _right = UTIL:WindowScale(10)

	-- add spacing to left
	if render.spacing then _left = UTIL:WindowScale(render.spacing) end
	if render.sameline then DRAW:Sameline() end
	if render.sameline then _left = UTIL:WindowScale(render.sameline) end

	-- paint spacing
	DRAW:Spacing(_left,1)

	-- add stacks (checkbox)
	ImGui.PushStyleColor(ImGuiCol.CheckMark, DRAW:GetColor("checkbox/checkmark", state))

	-- add stacks (conditional)
	if value then
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("checkbox/on/title", state))
	else
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("checkbox/off/title", state))
	end

	-- add stacks (conditional)
	if value then
		ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("checkbox/on/background", state))
		ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("checkbox/on/background/active", state))
		ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("checkbox/on/background/hovered", state))
	else
		ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("checkbox/off/background", state))
		ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("checkbox/off/background/active", state))
		ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("checkbox/off/background/hovered", state))
	end

	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(3))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:WindowScale(3), UTIL:WindowScale(3))
	ImGui.PushStyleVar(ImGuiStyleVar.ItemInnerSpacing, UTIL:WindowScale(8), 0)

	-- draw checkbox
	ImGui.PushID("DE_CB"..UTIL:ElementID(render.path))
	local _return, _trigger = ImGui.Checkbox(render.name, value)
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(3)
	ImGui.PopStyleColor(5)

	-- notice
	if render.note
	then
		DRAW:Notice(render, state)
	else
		DRAW:Sameline()
		DRAW:Spacer(UTIL:WindowScale(14))
	end

	-- description (not on sameline)
	if render.desc and not render.sameline
	then
		_left = _left + UTIL:WindowScale(32)
		DRAW:Description(render.desc, _left, _right, state)
	end

	-- result
	return _return, _trigger
end



--
--
--//////////////////// ADDITIONS ////////////////////
--
--

--
--// DRAW:Notice(<TABLE>,<INT>)
--
function DRAW:Notice(render, state)

	-- sameline
	DRAW:Sameline()
	DRAW:Spacing(UTIL:WindowScale(6), 1)

	-- add stacks (notice)
	ImGui.PushStyleColor(ImGuiCol.PlotHistogram, DRAW:GetColor("element/decoration", state))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(6))

	-- we use the progressbar, because its the fastest in rendering
	ImGui.ProgressBar(1, UTIL:WindowScale(8), UTIL:WindowScale(8), "")

	-- add tooltip
	if ImGui.IsItemHovered()
	then
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/notice"))
		ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, UTIL:WindowScale(6), UTIL:WindowScale(6))
		ImGui.BeginTooltip()
		ImGui.SetTooltip(render.note)
		ImGui.EndTooltip()
		ImGui.PopStyleVar(1)
		ImGui.PopStyleColor(1)
	end

	-- drop stacks (notice)
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(1)
end
























--//////////////////////////////////////////////////////////// OLD STUFF ////////////////////////////////////////////////////////////





























































































--
--
--//////////////////// HELPER ELEMENTS ////////////////////
--
--

--
--// DRAW:Notification(<STRING>)
--
function DRAW:Notification(text)

	-- add stacks (notification)
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("notification/text"))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("notification/background"))
	ImGui.PushStyleColor(ImGuiCol.PlotHistogram, DRAW:GetColor("notification/decoration"))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:WindowScale(6), UTIL:WindowScale(6))
	ImGui.PushStyleVar(ImGuiStyleVar.ButtonTextAlign, 0, 0)

	-- we use the progressbar, because its the fastest in rendering
	ImGui.ProgressBar(0.013, UTIL:WindowScale(456), UTIL:TextHeight(text) + (UTIL:WindowScale(6) * 2), "  "..tostring(text))

	-- drop stacks (notification)
	ImGui.PopStyleVar(2)
	ImGui.PopStyleColor(3)
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
	local _spacing = UTIL:WindowScale(16)

	-- update
	if render.spacing then _spacing = UTIL:WindowScale(render.spacing) + _spacing end

	-- top spacer
	DRAW:Spacer(1,UTIL:WindowScale(5))

	-- lead spacing
	DRAW:Spacing(_spacing,1)

	-- deco paint
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(6))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("element/decoration"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("element/decoration"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("element/decoration"))

	-- deco title
	DRAW:FlexButton(UTIL:WindowScale(5), UTIL:WindowScale(19))

	ImGui.PopStyleColor(3)
	ImGui.PopStyleVar(1)
	DRAW:Sameline()
	DRAW:Spacing(UTIL:WindowScale(5),1)
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/title"))
	ImGui.Text(render.name)
	ImGui.PopStyleColor(1)

	-- additional paint
	if option.min and option.max
	then
		ImGui.SameLine()
		DRAW:Spacing(UTIL:WindowScale(8),1)
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("slider/minmax"))
		ImGui.Text(tostring(option.min)..' to '..tostring(option.max))
		ImGui.PopStyleColor(1)
	end

	-- render info
	if render.note
	then
		DRAW:Notice(render, demand)
	end

	DRAW:Spacer(1,UTIL:WindowScale(6))
	DRAW:Spacing(_spacing + UTIL:WindowScale(10),1)
	ImGui.SetNextItemWidth(DRAW.Scaling.Window.Width - (_spacing + UTIL:ButtonWidth("Reset") + UTIL:WindowScale(32)))

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/title"))
	ImGui.PushStyleColor(ImGuiCol.SliderGrab, DRAW:GetColor("slider/grab"))
	ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, DRAW:GetColor("slider/grab/active"))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("slider/background"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("slider/background/active"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("slider/background/hovered"))

	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(2))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:WindowScale(2), UTIL:WindowScale(4))

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
	return _return, _trigger, _spacing
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
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(2))

	-- convert bool
	if option.type == "Bool"
	then
		if piece == "true" then piece = "On" end
		if piece == "false" then piece = "Off" end
	end

	ImGui.PushID("Button"..tostring(render.path))
	local _trigger = ImGui.Button(piece, UTIL:ButtonWidth(piece), UTIL:ButtonHeight(piece) + UTIL:WindowScale(1))
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
--// DRAW:Description()
--
function DRAW:DescriptionOLD(render, space, state)

	-- catch unset
	local space = space or 0
	local state = state or 0

	-- top spacer
	DRAW:Spacer(1,UTIL:WindowScale(4))

	-- left spacing
	DRAW:Spacing(space,1)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/description"))
	ImGui.Text(UTIL:WordWrap(render.desc,space))
	ImGui.PopStyleColor(1)
end




















--
--// DRAW:Quickshift(<TABLE>,<TABLE>,<INT>,<BOOL>)
--
function DRAW:Quickshift(render, option, state, value)

	-- default spacing
	local _left = UTIL:WindowScale(16)
	local _right = UTIL:WindowScale(16)

	-- add spacing to left
	if render.spacing then _left = UTIL:WindowScale(render.spacing) end

	-- paint spacing
	DRAW:Spacing(_left,1)

	-- alignment
	if render.align
	then
		-- paint title
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/title"))
		ImGui.Text(render.name)
		ImGui.PopStyleColor(1)
		DRAW:Sameline()

		-- fill space between
		DRAW:Spacing(DRAW.Scaling.Window.Usable - (_left + UTIL:TextWidth(render.name) + UTIL:WindowScale(50)),1)
	end

	-- fixed width to keep aspect ratio
	ImGui.SetNextItemWidth(UTIL:WindowScale(32))

	-- add stacks
	if UTIL:IntToBool(value) then
		ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColor("quickshift/on/border"))
		ImGui.PushStyleColor(ImGuiCol.SliderGrab, DRAW:GetColor("quickshift/on/grab/normal"))
		ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, DRAW:GetColor("quickshift/on/grab/active"))
	else
		ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColor("quickshift/off/border"))
		ImGui.PushStyleColor(ImGuiCol.SliderGrab, DRAW:GetColor("quickshift/off/grab/normal"))
		ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, DRAW:GetColor("quickshift/off/grab/active"))
	end

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor())
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("quickshift/background"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("quickshift/background/active"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("quickshift/background/hovered"))

	ImGui.PushStyleVar(ImGuiStyleVar.GrabRounding, UTIL:WindowScale(10))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(10))
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FrameBorderSize, UTIL:WindowScale(2))

	-- draw minified slider
	ImGui.PushID("DE_QS"..UTIL:ElementID(render.path))
	local _return, _trigger = ImGui.SliderInt("", value, 1, 0)
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(4)
	ImGui.PopStyleColor(7)

	-- alignment
	if not render.align
	then
		DRAW:Sameline()
		DRAW:Spacing(UTIL:WindowScale(10),1)
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/title"))
		ImGui.Text(render.name)
		ImGui.PopStyleColor(1)
	end

	-- description
	if render.desc
	then
		-- top spacer
		DRAW:Spacer(1,UTIL:WindowScale(4))

		-- left spacing
		--DRAW:Spacing(_spacing,1)

		-- alignment
		if render.align
		then
			DRAW:Spacing(_left,1)
		else
			DRAW:Spacing(_left + UTIL:WindowScale(42),1)
		end

		-- add stacks
		ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/description"))

		if render.align
		then
			ImGui.Text(UTIL:WordWrap(render.desc,_left))
		else
			if render.spacing
			then
				ImGui.Text(UTIL:WordWrap(render.desc,UTIL:WindowScale(render.spacing) + UTIL:WindowScale(60)))
			else
				ImGui.Text(UTIL:WordWrap(render.desc,_left + UTIL:WindowScale(60)))
			end
		end
		ImGui.PopStyleColor(1)
	end

	-- result
	return _return, _trigger
end



--
--// DRAW:Description()
--
function DRAW:Description(text, left, right, state)

	-- catch unset
	local left = left or 0
	local right = right or 0
	local state = state or 0

	-- top spacer
	DRAW:Spacer(1,UTIL:WindowScale(3))

	-- left spacing
	DRAW:Spacing(left,1)

	-- add stacks
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/description", state))
	ImGui.Text(UTIL:WordWrap(text, left + right))
	ImGui.PopStyleColor(1)
end


























--
--// DRAW:Combobox()
--
function DRAW:Combobox(render, option, demand, names, length, value)

	-- default
	local _spacing = UTIL:WindowScale(16)

	-- spacing
	if render.spacing
	then
		_spacing = UTIL:WindowScale(render.spacing + _spacing)
	end

	-- top spacer
	DRAW:Spacer(1,UTIL:WindowScale(5))

	-- lead spacing
	DRAW:Spacing(_spacing + UTIL:WindowScale(1),1)

	-- deco paint
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(6))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("element/decoration"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("element/decoration"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("element/decoration"))

	-- deco title
	DRAW:FlexButton(UTIL:WindowScale(5), UTIL:WindowScale(19))

	ImGui.PopStyleColor(3)
	ImGui.PopStyleVar(1)
	DRAW:Sameline()
	DRAW:Spacing(UTIL:WindowScale(5),1)
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/title"))
	ImGui.Text(render.name)
	ImGui.PopStyleColor(1)

	-- bottom spacer
	DRAW:Spacer(1,UTIL:WindowScale(8))

	-- lead spacing
	DRAW:Spacing(_spacing,1)

	-- comboboxes have a fixed width
	ImGui.SetNextItemWidth(DRAW.Scaling.Window.Width - (_spacing * 2) - UTIL:WindowScale(2))

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/title"))

	ImGui.PushStyleColor(ImGuiCol.PopupBg, DRAW:GetColor("combobox/popup/background"))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("combobox/background"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgActive, DRAW:GetColor("combobox/background"))
	ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, DRAW:GetColor("combobox/background"))

	ImGui.PushStyleColor(ImGuiCol.Border, DRAW:GetColor("combobox/border"))
	ImGui.PushStyleColor(ImGuiCol.Button, DRAW:GetColor("combobox/button"))
	ImGui.PushStyleColor(ImGuiCol.ButtonActive, DRAW:GetColor("combobox/button/active"))
	ImGui.PushStyleColor(ImGuiCol.ButtonHovered, DRAW:GetColor("combobox/button/hovered"))

	ImGui.PushStyleColor(ImGuiCol.Header, DRAW:GetColor("combobox/header"))
	ImGui.PushStyleColor(ImGuiCol.HeaderActive, DRAW:GetColor("combobox/header/active"))
	ImGui.PushStyleColor(ImGuiCol.HeaderHovered, DRAW:GetColor("combobox/header/hovered"))


	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, UTIL:WindowScale(8), UTIL:WindowScale(4))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(3))
	ImGui.PushStyleVar(ImGuiStyleVar.FrameBorderSize, UTIL:WindowScale(2))

	ImGui.PushStyleVar(ImGuiStyleVar.PopupRounding, 10)
	ImGui.PushStyleVar(ImGuiStyleVar.PopupBorderSize, UTIL:WindowScale(1))

	-- draw combobox
	ImGui.PushID("DE_CO"..UTIL:ElementID(render.path))
	local _return, _trigger = ImGui.Combo("", value, names, length)
	ImGui.PopID()

	-- drop stacks
	ImGui.PopStyleVar(5)
	ImGui.PopStyleColor(12)

	-- bottom spacer
	DRAW:Spacer(1,UTIL:WindowScale(5))

	-- result
	return _return, _trigger
end

















--
--// DRAW:PageDebug(<TABLE>,<STRING>)
--
function DRAW:DebugTable(input,name)

	-- some room
	DRAW:Spacer(1, 5)

	-- format table
	ImGui.PushStyleColor(ImGuiCol.TableHeaderBg, DRAW:GetColor("debug/table/background"))
	ImGui.PushStyleColor(ImGuiCol.TableRowBg, DRAW:GetColor("debug/table/background"))
	ImGui.PushStyleVar(ImGuiStyleVar.CellPadding, 6, 5)

	if ImGui.BeginTable(name,2, ImGuiTableFlags.Borders + ImGuiTableFlags.RowBg)
	then
		for _,item in pairs(input)
		do
			if ImGui.TableNextColumn()
			then
				ImGui.Text(item)
			end
		end
		ImGui.EndTable()
	end

	-- drop colors
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(2)
end


--
--// DRAW:PageDebug()
--
function DRAW:PageDebug()

	-- default
	local debug

	debug = {
		"Scaling:",
		UTIL:FirstToUpper(tostring(DRAW.Scaling.Enable))
	}
	DRAW:DebugTable(debug,"Debug Scaling #1")

	debug = {
		"Screen Width",
		tostring(DRAW.Scaling.Screen.Width),
		"Screen Height",
		tostring(DRAW.Scaling.Screen.Height),
		"Screen Factor",
		tostring(DRAW.Scaling.Screen.Factor),
		"Screen Usable",
		tostring(DRAW.Scaling.Screen.Usable)
	}
	DRAW:DebugTable(debug,"Debug Scaling #2")

	debug = {
		"Window Width (min · max)",
		tostring(DRAW.Scaling.Window.Width).." ("..tostring(UTIL:ScreenScale(456)).." · "..tostring(DRAW.Scaling.Screen.Usable)..")",
		"Window Height (min · max)",
		tostring(DRAW.Scaling.Window.Height).." ("..tostring(UTIL:ScreenScale(600)).." · "..tostring(DRAW.Scaling.Screen.Height - 100)..")",
		"Window Factor",
		tostring(DRAW.Scaling.Window.Factor),
		"Window Usable",
		tostring(DRAW.Scaling.Window.Usable)
	}
	DRAW:DebugTable(debug,"Debug Scaling #3")

	debug = {
		"Window Border (scaled)",
		tostring(DRAW.Runtime.Window.Border).." ("..tostring(UTIL:ScreenScale(DRAW.Runtime.Window.Border))..")",
		"Remaining Pixels (scaled)",
		tostring(DRAW.Scaling.Window.Usable).." ("..tostring(UTIL:ScreenScale(DRAW.Scaling.Window.Usable))..")"
	}

	DRAW:DebugTable(debug,"Debug Scaling #4")

	debug = {
		"Calculated Fontsize",
		tostring(ImGui.GetFontSize())
	}
	DRAW:DebugTable(debug,"Debug Scaling #5")



	debug = {
		"FrameTimes",
		""
	}
	DRAW:DebugTable(debug,"Debug FrameTimes #1")

	local temp1 = 7
	local temp2 = math.floor(DRAW.Scaling.Window.Usable / UTIL:ScreenScale(temp1))

	debug = {
		"Barsize",
		tostring(temp1),

		"Calculated Number of Bars",
		tostring(temp2),
		"Combined Size",
		tostring(math.floor(UTIL:ScreenScale((temp1) * temp2))),
		"Spacing left for centering",
		tostring(math.floor(((DRAW.Scaling.Window.Usable + 2) - (UTIL:ScreenScale((temp1) * temp2))) / 2))
	}
	DRAW:DebugTable(debug,"Debug FrameTimes #1")









	DRAW:Spacer(1, 5)
	DRAW:Separator(1, "tabbar/bottomline")
	DRAW:Spacer(1, 5)



	local _spacing = UTIL:WindowScale(14)


	--DRAW:SaveAnimation("nothing")

	-- some room
	DRAW:Spacer(1, _spacing)



	DRAW:Separator(UTIL:WindowScale(5),14,10)

	-- logo animation
	DRAW:Spacing(_spacing, 1)
	ImGui.Text("Logo Painter:")
	DRAW:Spacer(1, 3)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("Blocksize: "..tostring(UTIL:WindowScale(6)).." // Rounding: "..tostring(math.floor(UTIL:WindowScale(6))).." // Center: "..tostring(DRAW.Logo.Center).." // Pixels: "..tostring(DRAW.Logo.Pixels))

	DRAW:Separator(UTIL:WindowScale(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (no underline)")
	DRAW:TextTitle("Left", {space=_spacing,underline={paint=false}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline text sized)")
	DRAW:TextTitle("Left", {space=_spacing,underline={paint=true}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline window sized)")
	DRAW:TextTitle("Left", {space=_spacing,underline={paint=true,limit=false}})

	DRAW:Separator(UTIL:WindowScale(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (no underline)")
	DRAW:TextTitle("Center", {space=_spacing,align="center",underline={paint=false}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline text sized)")
	DRAW:TextTitle("Center", {space=_spacing,align="center",underline={paint=true}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline window sized)")
	DRAW:TextTitle("Center", {space=_spacing,align="center",underline={paint=true,limit=false}})

	DRAW:Separator(UTIL:WindowScale(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (no underline)")
	DRAW:TextTitle("Right", {space=_spacing,align="right",underline={paint=false}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline text sized)")
	DRAW:TextTitle("Right", {space=_spacing,align="right",underline={paint=true}})

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("DRAW:TextTitle (underline window sized)")
	DRAW:TextTitle("Right", {space=_spacing,align="right",underline={paint=true,limit=false}})







	DRAW:Separator(UTIL:WindowScale(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("UTIL:WordWrap")
	DRAW:Spacing(_spacing, 1)
	ImGui.Text(UTIL:WordWrap("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.", _spacing))

	DRAW:Separator(UTIL:WindowScale(5),14,10)

	DRAW:Spacing(_spacing, 1)
	ImGui.Text("ImGui.TextWrapped")
	DRAW:Spacing(_spacing, 1)
	ImGui.TextWrapped("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")

	DRAW:Separator(UTIL:WindowScale(5),14,10)

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
			local _blind = ImGui.Button("", UTIL:TextWidth(input), UTIL:WindowScale(1))
		else
			local _blind = ImGui.Button("", DRAW.Scaling.Window.Width - (_space * 2), UTIL:WindowScale(1))
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
	DRAW:Spacer(1, UTIL:WindowScale(44))


	DRAW:Picture(DRAW.Matrix.Mox, 0.88, 0.29, 0.49)

	-- make room
	DRAW:Spacer(1, UTIL:WindowScale(44))

	-- draw animation
	---DRAW:LogoAnimation()

	--DRAW:AnimLogo()


	-- paint version
	DRAW:PageAbout_Version("v"..DRAW.Version.String)

	-- make room
	DRAW:Spacer(1,UTIL:WindowScale(15))






	-- predefine
	local line = ""
	local part = {}

	-- print who
	DRAW:Spacing(UTIL:TextCenter(DRAW.Scaling.Window.Width, "2022 by FREAKAZ"),1)
	DRAW:PageText("White", "Normal", "2022", true)
	DRAW:PageText("Orange", "Normal", " by ", true)
	DRAW:PageText("White", "Normal", "FREAKAZ", false)


	-- make room
	DRAW:Spacer(1,UTIL:WindowScale(10))





	-- print random
	line = "made in endless hours at day and night"
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line)
	line = "while struggling with LUA, CET and 2077"
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", line)

	-- make room
	DRAW:Spacer(1,UTIL:WindowScale(3))

	-- print judy
	line = "~ FOR JUDY ~"
	part = UTIL:TextSplit(line)
	DRAW:Spacing(UTIL:TextCenter(ImGui.GetWindowWidth(), line),1)
	DRAW:PageText("Grey", "Lighter", part[1].." ", true)
	local unlock = DRAW:PageButton("Orange", "Normal", part[2].." "..part[3], true)
	DRAW:PageText("Grey", "Lighter", " "..part[4], false)

	-- make room
	DRAW:Spacer(1,UTIL:WindowScale(15))

	-- print modpage
	DRAW:Spacing(UTIL:TextCenter(DRAW.Scaling.Window.Width, "https://rootpunk.com/mod"),1)
	DRAW:PageText("Grey", "Light", "https://", true)
	DRAW:PageText("Grey", "Lighter", "rootpunk.com/", true)
	DRAW:PageText("Orange", "Dark", "mod", false)

	-- make room
	DRAW:Spacer(1,UTIL:WindowScale(3))

	-- print github
	DRAW:Spacing(UTIL:TextCenter(DRAW.Scaling.Window.Width, "https://github.com/rp-freakaz/DeveloperExtras"),1)
	DRAW:PageText("Grey", "Light", "https://", true)
	DRAW:PageText("Grey", "Lighter", "github.com/rp-freakaz/", true)
	DRAW:PageText("Orange", "Dark", "DeveloperExtras", false)

	-- make room
	DRAW:Spacer(1,UTIL:WindowScale(20))







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
	DRAW:Spacer(1,UTIL:WindowScale(20))

	-- centering text
	DRAW:Spacing(UTIL:TextCenter(DRAW.Scaling.Window.Width, text),1)

	DRAW:PageText("Grey", "Lightest", text)

	-- force underline
	DRAW:Underline(DRAW.Logo.Pixels,UTIL:WindowScale(1),0,"center")

	-- make room
	DRAW:Spacer(1,UTIL:WindowScale(5))
end





function DRAW:PageAbout_Version(text)

	-- push to the right side of the logo animation
	DRAW:Spacing((DRAW.Scaling.Window.Width / 2) + ((DRAW.Logo.Pixels / 2) - UTIL:TextWidth(text)) + UTIL:WindowScale(3),1)

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
	local height = height or UTIL:WindowScale(1)
	local padding = padding or UTIL:WindowScale(14)
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
function DRAW:FlexButton(width, height)

	-- catch unset
	local width = width or 1
	local height = height or 1

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
--// DRAW:Picture()
--
function DRAW:Picture(_matrix, _r, _g, _b)

	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(1))

	-- loop matrix rows
	for _,row in pairs(_matrix)
	do
		-- loop matrix columns
		for _,col in pairs(row)
		do
			-- paint it
			if col > 0
			then
				ImGui.PushStyleColor(ImGuiCol.PlotHistogram, _r, _g, _b, col)
				ImGui.ProgressBar(1, 1, 1, "")
				ImGui.PopStyleColor(1)
				DRAW:Sameline()
				DRAW:Spacing(1,1)
			-- or not
			else
				-- draw only a space
				DRAW:Spacing(2,1)
			end
		end

		-- linebreak
		DRAW:Spacer(1,1)

		-- linebreak
		DRAW:Spacer(1,1)
	end

	ImGui.PopStyleVar(1)

end










--
--// DRAW:AnimLogo()
--
function DRAW:AnimLogo()

	--
	--// Painter(<INT>,<INT>,<INT>.<FLOAT>)
	--
	local function Painter(_id, _size, _transparency)

		-- base
		local _color = "animations/logo/default"

		-- highlight
		if _id > 1000 and _id < 1002
		or _id > 1210 and _id < 1212
		or _id > 1235 and _id < 1241
		or _id > 1256 and _id < 1259
		or _id > 1281 and _id < 1287
		or _id > 1302 and _id < 1307
		or _id > 1326 and _id < 1333
		or _id > 1356 and _id < 1364
		then
			_color = "animations/logo/highlight"
		end

		-- decoration
		if _id > 1363 and _id < 1415
		then
			_color = "animations/logo/decoration"
		end

		-- paint child
		ImGui.PushStyleColor(ImGuiCol.PlotHistogram, DRAW:GetColor(_color, DRAW.Anim.Logo.Colors[_transparency]))
		ImGui.ProgressBar(1, _size, _size, "")
		ImGui.PopStyleColor(1)

		--ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor(_color, DRAW.Anim.Logo.Colors[_transparency]))
		--local _blind = ImGui.BeginChildFrame(_id, _size, _size, ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoScrollWithMouse)
		--ImGui.PopStyleColor(1)

		-- close child
		--ImGui.EndChildFrame()
	end

	-- frame id's
	local _frames = 1000

	-- needed for animation
	local _timings = UTIL:Get25thSeconds()

	-- transparency switch
	if DRAW.Anim.Logo.Cycles ~= _timings
	then
		-- update timing
		DRAW.Anim.Logo.Cycles = _timings

		-- get table length
		local _length = UTIL:TableLength(DRAW.Anim.Logo.Colors)

		-- rotate transparency table
		table.insert(DRAW.Anim.Logo.Colors, DRAW.Anim.Logo.Colors[1])

		-- cut to long table
		if UTIL:TableLength(DRAW.Anim.Logo.Colors) > _length
		then
			table.remove(DRAW.Anim.Logo.Colors,1)
		end
	end

	-- number of elements
	DRAW.Anim.Logo.Pieces = UTIL:TableLength(DRAW.Anim.Logo.Matrix[1])

	-- calculate element size
	DRAW.Anim.Logo.Single = math.ceil((DRAW.Scaling.Window.Usable - (DRAW.Anim.Logo.Pieces - 1) - UTIL:WindowScale(100)) / DRAW.Anim.Logo.Pieces)

	-- update pixel size
	DRAW.Anim.Logo.Pixels = (DRAW.Anim.Logo.Single * DRAW.Anim.Logo.Pieces) + (DRAW.Anim.Logo.Pieces - 1)

	-- update center spacer
	DRAW.Anim.Logo.Spacer = math.floor((DRAW.Scaling.Window.Usable - DRAW.Anim.Logo.Pixels) / 2)

	-- pre stack
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor())
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(1))

	-- loop matrix rows
	for _,_row in pairs(DRAW.Anim.Logo.Matrix)
	do
		-- centering row
		DRAW:Spacing(DRAW.Anim.Logo.Spacer)

		-- loop matrix columns
		for _,_col in pairs(_row)
		do
			-- paint
			if _col > 0
			then
				-- increase
				_frames = _frames + 1

				-- seeding so its sticks
				math.randomseed(_frames)

				-- call painter
				Painter(_frames, DRAW.Anim.Logo.Single, math.random(1,UTIL:TableLength(DRAW.Anim.Logo.Colors)))
				DRAW:Sameline()
				DRAW:Spacing(1,1)
			-- or not
			else
				-- draw only a space
				DRAW:Spacing(DRAW.Anim.Logo.Single + 1,1)
			end
		end

		-- linebreak
		DRAW:Spacer(1,1)

		-- space between
		DRAW:Spacer(1,1)
	end

	-- post stack
	ImGui.PopStyleVar(1)
	ImGui.PopStyleColor(1)

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
	DRAW.Logo.Pixels = (51 * math.floor(UTIL:WindowScale(6))) + 50

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
	local _blind = ImGui.BeginChildFrame(_id, UTIL:WindowScale(6), UTIL:WindowScale(6), ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoScrollWithMouse)
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
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, UTIL:WindowScale(1))
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor(_color, "Logo", DRAW.Logo.Colors[_transparency]))
	local _blind = ImGui.BeginChildFrame(_id, UTIL:WindowScale(6), UTIL:WindowScale(6), ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoScrollWithMouse)
	ImGui.PopStyleColor(1)
	ImGui.PopStyleVar(1)

	-- close child
	ImGui.EndChildFrame()
end



--
--// DRAW:SaveAnimation()
--
function DRAW:SaveAnimation(text)

	-- needed for logo animation
	local _timings = UTIL:Get25thSeconds()

	-- only if needed
	if DRAW.Anim.Cycles ~= _timings
	then
		-- update timing
		DRAW.Anim.Cycles = _timings

		-- get table length
		local _length = UTIL:TableLength(DRAW.Anim.Colors)

		-- rotate color table
		table.insert(DRAW.Anim.Colors, DRAW.Anim.Colors[1])

		-- cut to long table
		if UTIL:TableLength(DRAW.Anim.Colors) > _length
		then
			table.remove(DRAW.Anim.Colors,1)
		end
	end

	-- frame id's
	local _frames = 3000

	-- update pixel size
	--DRAW.Logo.Pixels = (51 * math.floor(UTIL:WindowScale(6))) + 50

	-- update center spacer
	--DRAW.Logo.Center = (DRAW.Scaling.Window.Width - DRAW.Logo.Pixels) / 2

	-- loop matrix rows
	for _rn,_rc in pairs(DRAW.Anim.Matrix.Save)
	do
		-- centering row
		--DRAW:Spacing(DRAW.Logo.Center)

		local _fields = UTIL:TableLength(_rc)

		-- loop matrix columns
		for _cn,_cc in pairs(_rc)
		do
			-- inc frames
			_frames = _frames + 1

			-- seeding so its sticks
			--math.randomseed(_frames)

			--local _opacity = math.random(1,UTIL:TableLength(DRAW.Anim.Colors))


			local _opacity = DRAW.Anim.Colors[1]


			--if _num == 1 then _opacity = UTIL:ShortenFloat(math.random(1,UTIL:TableLength(DRAW.Anim.Colors)) / 3) end
			--if _num == 2 then _opacity = UTIL:ShortenFloat(math.random(1,UTIL:TableLength(DRAW.Anim.Colors)) / 2) end
			--if _num == 4 then _opacity = UTIL:ShortenFloat(math.random(1,UTIL:TableLength(DRAW.Anim.Colors)) / 2) end
			--if _num == 5 then _opacity = UTIL:ShortenFloat(math.random(1,UTIL:TableLength(DRAW.Anim.Colors)) / 3) end

			-- seeding so its sticks
			--math.randomseed(_frames)

			-- call painter
			DRAW:AnimPainter(_frames, UTIL:WindowScale(15), UTIL:WindowScale(15), _opacity)
			DRAW:Sameline()
			DRAW:Spacer(2,1)
			DRAW:Sameline()
		end

		-- right end
		DRAW:Spacer(1,1)

		-- space between
		--DRAW:Spacing(UTIL:WindowWidth(0.25),UTIL:WindowWidth(0.25))
		DRAW:Spacer(1,1)
	end


	--ImGui.EndChild()

end

function DRAW:AnimPainter(id, width, height, opacity, rounding)

	-- catch unset
	local width = width or 1
	local height = height or 1
	local opacity = opacity or 0
	local rounding = rounding or UTIL:WindowScale(1)

	-- paint child
	ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, rounding)
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("Orange", "Logo", opacity))
	local _blind = ImGui.BeginChildFrame(id, width, height, ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoScrollWithMouse)
	ImGui.PopStyleColor(1)
	ImGui.PopStyleVar(1)

	-- close child
	ImGui.EndChildFrame()
end










--
--
--//////////////////// PERFORMANCE ////////////////////
--
--


--
--// DRAW.Graph()
--
function DRAW:GraphOLD(_child, _table, _should, _length, _format, _color, _title, _space, _width, _height, _scale, _show, _trans_bar, _trans_barbg, _trans_text)

	-- graph table
	local _graph = {}

	-- fill empty spots
	if _length < _should
	then
		local _remain = _should - _length

		for i=1,_remain
		do
			table.insert(_graph, 0)
		end
	end

	-- preset values
	local _avg = 0
	local _max = 0
	local _min = 1000

	-- fill values
	for _id,_value in pairs(_table)
	do
		-- we round them for display
		table.insert(_graph, math.floor(_value))

		-- collect avg
		if _value < 1000
		then
			_avg = _avg + _value
		end

		-- get max
		if _value < 1000
		then
			if _value > _max then _max = _value end
		end

		-- get min
		if _value < 1000
		then
			if _value < _min then _min = _value end
		end
	end

	-- calculate and format
	if _length > 0
	then
		_cur = string.format(_format, _table[#_table])
		_avg = string.format(_format, _avg / _length)
		_max = string.format(_format, _max)
		_min = string.format(_format, _min)
	else
		_cur = "N/A"
		_avg = "N/A"
		_max = "N/A"
		_min = "N/A"
	end


	-- add stacks
	if _trans_bar >= 0 and _trans_bar <= 10
	then
		_trans_bar = _trans_bar / 10
	else
		_trans_bar = 0.75
	end

	if _trans_barbg >= 0 and _trans_barbg <= 10
	then
		_trans_barbg = _trans_barbg / 10
	else
		_trans_barbg = 0.35
	end

	if _trans_text >= 0 and _trans_text <= 10
	then
		_trans_text = _trans_text / 10
	else
		_trans_text = 0.75
	end





	-- top spacing
	DRAW:Spacing(5,3)

	-- left spacing
	DRAW:Spacing(5,1)

	-- print title
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/title", _trans_text))
	ImGui.Text(_title)
	ImGui.PopStyleColor(1)





	-- left spacing
	DRAW:Spacing(5,1)

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/name", _trans_text))
	ImGui.Text("CUR:")
	ImGui.PopStyleColor(1)

	DRAW:Sameline()

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _trans_text))
	ImGui.Text(tostring(_cur))
	ImGui.PopStyleColor(1)

	DRAW:Sameline()


	-- left spacing
	DRAW:Spacing(10,1)

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/name", _trans_text))
	ImGui.Text("AVG:")
	ImGui.PopStyleColor(1)

	DRAW:Sameline()

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _trans_text))
	ImGui.Text(tostring(_avg))
	ImGui.PopStyleColor(1)

	DRAW:Sameline()

	-- left spacing
	DRAW:Spacing(10,1)


	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/name", _trans_text))
	ImGui.Text("MIN:")
	ImGui.PopStyleColor(1)

	DRAW:Sameline()

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _trans_text))
	ImGui.Text(tostring(_min))
	ImGui.PopStyleColor(1)

	DRAW:Sameline()

	-- left spacing
	DRAW:Spacing(10,1)
	DRAW:Sameline()

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/name", _trans_text))
	ImGui.Text("MAX:")
	ImGui.PopStyleColor(1)

	DRAW:Sameline()

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _trans_text))
	ImGui.Text(tostring(_max))
	ImGui.PopStyleColor(1)




	DRAW:Spacer(5,1)
	--DRAW.Sameline()

	-- draw values
	for _,_value in pairs(_graph)
	do
		-- push on line
		DRAW:Sameline()

		-- draw graph bars
		DRAW:GraphBar(_child, _width, _height, _scale, _value, _show, _trans_bar, _trans_barbg, _trans_text)

		-- increase child
		_child = _child + 1

		-- push on line
		DRAW:Sameline()

		-- some spacing
		DRAW:Spacer(_space,1)
	end

	DRAW:Sameline()
	DRAW:Spacer(5,1)



	DRAW:Spacer(5,3)
	--DRAW.Spacing(10,10)
end




--
--// DRAW.GraphBar() --- child for painting bars
--
function DRAW:GraphBarOLD(_child, _width, _height, _scale, _value, _show, _trans_bar, _trans_barbg, _trans_text)

	-- defaults
	local _bar = math.floor(_value)
	local _txt = tostring(_value)

	-- scale if not false
	if _scale ~= false
	then
		_bar = math.floor(_value / _scale)
	end

	-- calculate remaining
	local _top = _height - _bar

	-- exception if zero
	if _bar == 0
	then
		_top = _height - 1
		_bar = 1
		_txt = "N/A"
	end


	--ImGui.PushStyleColor(ImGuiCol.FrameBg, GetColors("grey_darker", "disabled"))

	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("graphbar/background", _trans_barbg))
	ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarSize, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)

	if _show ~= false
	then
		_height = _height + 22
	end

	-- create frame
	local _trigger = ImGui.BeginChildFrame(_child, _width, _height, ImGuiWindowFlags.NoScrollWithMouse)

	-- drop stacks
	ImGui.PopStyleVar(2)
	ImGui.PopStyleColor(1)

	if _trigger
	then
		DRAW:Spacer(1,_top)

		ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor())
		ImGui.PushStyleColor(ImGuiCol.PlotHistogram, DRAW:GetColor("graphbar/progessbar", _trans_bar))

		ImGui.ProgressBar(1, _width, _bar, "")
		ImGui.PopStyleColor(2)

		-- draw text if wanted
		if _show ~= false
		then
			DRAW:Spacer(1,1)

			DRAW:Spacer(2,1)
			DRAW:Sameline()

			if string.len(_txt) < 3
			then
				DRAW:Spacer(4,1)
				DRAW:Sameline()
			end

			if string.len(_txt) < 2
			then
				DRAW:Spacer(3,1)
				DRAW:Sameline()
			end

			ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _trans_text))
			ImGui.Text(_txt)
			ImGui.PopStyleColor(1)

			DRAW:Spacer(1,3)
		end

		ImGui.EndChildFrame()
	end
end
















--
--// DRAW.GraphFT() --- wrapper for DRAW.Graph
--
function DRAW:GraphWrapperFT(_table, _should, _length, _bartrans, _barbgtrans, _texttrans)

	--return DRAW.Graph(100, _table, _should, _length, "%.2f", "orange_normal", "FRAME TIMES", 1, 4, 50, false, false)

	-- catch non set
	local _bartrans =_bartrans or 11
	local _barbgtrans = _barbgtrans or 11
	local _texttrans = _texttrans or 11

	DRAW:Graph(100, _table, _should, _length, "%.2f", "orange_normal", "FRAME TIMES", 2, 5, 50, false, false, _bartrans, _barbgtrans, _texttrans)
end

--
--// DRAW.GraphFPS() --- wrapper for DRAW.Graph
--
function DRAW:GraphWrapperFPS(_table, _should, _length, _bartrans, _barbgtrans, _texttrans)

	-- catch non set
	local _bartrans =_bartrans or 11
	local _barbgtrans = _barbgtrans or 11
	local _texttrans = _texttrans or 11

	DRAW:Graph(200, _table, _should, _length, "%.0f", "grey_normal", "FRAMES PER SECOND", 4, 26, 100, 1.5, true, _bartrans, _barbgtrans, _texttrans)

end































--
--// DRAW.Frametime(<TABLE>,<FLOAT>,<FLOAT>,<FLOAT>)
--
-- <TABLE>	history graph table
-- <INT>	length it should have
-- <TABLE>	transparency settings
--
function DRAW:Frametime(_history, _format, _width, _height, _space, _scale, _title, _bar, _back, _text)

	-- bar painter
	local function Painter(_child, _width, _height, _scale, _value, _show, _bar, _back, _text)

		local _show = false

		-- round bar and string value
		local bar = math.floor(_value)
		local txt = tostring(_value)

		-- scale if not false
		if _scale ~= false then bar = math.floor(_value / _scale) end

		-- calculate remaining
		local top = _height - bar

		-- exception if zero
		if bar == 0
		then
			top = _height - 1
			bar = 1
			txt = "N/A"
		end

		-- start painting
		ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("graphbar/background", _back))
		ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarSize, 0)
		ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)

		if _show ~= false
		then
			_height = _height + 22
		end

		-- create frame
		local blind = ImGui.BeginChildFrame(_child, _width, _height, ImGuiWindowFlags.NoScrollWithMouse)

		-- drop stacks
		ImGui.PopStyleVar(2)
		ImGui.PopStyleColor(1)

		if blind
		then
			DRAW:Spacer(1,top)

			ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor())
			ImGui.PushStyleColor(ImGuiCol.PlotHistogram, DRAW:GetColor("graphbar/progessbar", _bar))

			ImGui.ProgressBar(1, UTIL:ScreenScale(_width), bar, "")
			ImGui.PopStyleColor(2)

			-- draw text if wanted
			if _show ~= false
			then
				DRAW:Spacer(1,1)

				DRAW:Spacer(2,1)
				DRAW:Sameline()

				if string.len(txt) < 3
				then
					DRAW:Spacer(4,1)
					DRAW:Sameline()
				end

				if string.len(txt) < 2
				then
					DRAW:Spacer(3,1)
					DRAW:Sameline()
				end

				ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _text))
				ImGui.Text(txt)
				ImGui.PopStyleColor(1)

				DRAW:Spacer(1,3)
			end

			ImGui.EndChildFrame()
		end
	end

	-- paint table
	local paint = {}

	-- calculate number of bars
	local count = UTIL:NumberOfBars(_width, _space)

	-- caluclate remaining space for centering
	local space = UTIL:CenterOfBars(count, _width, _space)

	-- get last entries for display
	local limit = UTIL:TableEntriesLast(_history, count)

	-- fill empty spots if needed
	if UTIL:TableLength(limit) < count
	then
		local remain = count - UTIL:TableLength(limit)
		for i=1,remain do table.insert(paint, 0) end
	end

	-- preset values
	local current = 0
	local average = 0
	local maximum = 0
	local minimum = 1000

	-- fill values
	for id,value in pairs(limit)
	do
		-- we round them for display
		table.insert(paint, math.floor(value))

		-- collect basics / avoid spikes
		if value < 1000 then average = average + value end
		if value < 1000 and value > maximum then maximum = value end
		if value < 1000 and value < minimum then minimum = value end
	end

	-- calculate and format
	if UTIL:TableLength(paint) > 0
	then
		current = string.format(_format, paint[#paint])
		average = string.format(_format, average / UTIL:TableLength(paint))
		maximum = string.format(_format, maximum)
		minimum = string.format(_format, minimum)
	else
		current = "N/A"
		average = "N/A"
		maximum = "N/A"
		minimum = "N/A"
	end

	-- check transparency
	local transparency = {bar=0.75,back=0.35,text=0.75}
	if _bar >= 0 and _bar <= 10 then transparency.bar = _bar / 10 end
	if _back >= 0 and _back <= 10 then transparency.back = _back / 10 end
	if _text >= 0 and _text <= 10 then transparency.text = _text / 10 end

	-- start painting
	DRAW:Spacer(1,UTIL:WindowScale(3))
	DRAW:GraphHeader(_title, current, average, minimum, maximum, _text)

	-- left spacing
	DRAW:Spacing(UTIL:ScreenScale(space),1)
	--DRAW:Sameline()


	-- child start
	local childs = 2000

	-- draw values
	for _,value in pairs(paint)
	do
		--DRAW:Sameline()
		Painter(childs, _width, 50, false, value, false, _bar, _back, _text)
		childs = childs + 1
		DRAW:Sameline()
		DRAW:Spacing(UTIL:ScreenScale(_space),1)
	end

	-- clear sameline
	DRAW:Spacer(1,1)

	-- some more room
	DRAW:Spacer(1,UTIL:WindowScale(3))
end



--
--// DRAW.Graph()
--
function DRAW:GraphNew(_history, _format, _title, _space, _width, _height, _scale, _show, _bar, _back, _text)

	-- defaults
	--local remaining = UTIL:RemainingPixels(DRAW.Scaling.Window.Width, DRAW.Runtime.Window.Border)




	-- child start
	local childs = 100

	-- display table
	local history = {}

	-- calculate number of bars
	local entries = math.floor(DRAW.Scaling.Window.Remain / UTIL:ScreenScale(_width + _space))

	-- caluclate remaining space for centering
	local spacing = math.floor((((DRAW.Scaling.Window.Remain + _space) - (UTIL:ScreenScale((_width + _space) * entries))) / 2) + UTIL:ScreenScale(DRAW.Scaling.Window.Border))

	-- define history depending on scaling
	local limiter = UTIL:TableEntriesLast(_history,entries)

	-- fill empty spots
	if UTIL:TableLength(limiter) < entries
	then
		local remaining = entries - UTIL:TableLength(limiter)
		for i=1,remaining do table.insert(history, 0) end
	end

	-- preset values
	local current = 0
	local average = 0
	local maximum = 0
	local minimum = 1000

	-- fill values
	for id,value in pairs(limiter)
	do
		-- we round them for display
		table.insert(history, math.floor(value))

		-- collect basics / avoid spikes
		if value < 1000 then average = average + value end
		if value < 1000 and value > maximum then maximum = value end
		if value < 1000 and value < minimum then minimum = value end
	end

	-- calculate and format
	if UTIL:TableLength(history) > 0
	then
		current = string.format(_format, history[#history])
		average = string.format(_format, average / UTIL:TableLength(history))
		maximum = string.format(_format, maximum)
		minimum = string.format(_format, minimum)
	else
		current = "N/A"
		average = "N/A"
		maximum = "N/A"
		minimum = "N/A"
	end

	-- check transparency
	local transparency = {bar=0.75,back=0.35,text=0.75}
	if _bar >= 0 and _bar <= 10 then transparency.bar = _bar / 10 end
	if _back >= 0 and _back <= 10 then transparency.back = _back / 10 end
	if _text >= 0 and _text <= 10 then transparency.text = _text / 10 end

	-- start painting
	DRAW:Spacer(1,UTIL:WindowScale(3))
	DRAW:GraphHeader(_title, current, average, minimum, maximum, _text)

	-- left spacing
	DRAW:Spacing(UTIL:ScreenScale(spacing),1)
	--DRAW:Sameline()

	-- draw values
	for _,value in pairs(history)
	do
		--DRAW:Sameline()
		DRAW:GraphPainter(childs, _width, _height, _scale, value, _show, _bar, _back, _text)
		childs = childs + 1
		DRAW:Sameline()
		DRAW:Spacing(UTIL:ScreenScale(_space),1)
	end


	--DRAW:Sameline()
	--DRAW:Spacer(5,1)



	--DRAW:Spacer(5,3)
	--DRAW.Spacing(10,10)
end



--
--// DRAW.GraphHeader(<STRING>,<FLOAT>,<FLOAT>,<FLOAT>,<FLOAT>,<FLOAT>)
--
function DRAW:GraphHeader(_title, _current, _average, _minimum, _maximum, _text)

	-- available space
	local available = DRAW.Scaling.Window.Width - UTIL:WindowScale(10) - UTIL:TextWidth(_title)

	-- left spacing
	DRAW:Spacing(UTIL:WindowScale(5),1)

	-- print title
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("element/title", _text))
	ImGui.Text(_title)
	ImGui.PopStyleColor(1)

	-- always
	DRAW:Sameline()

	-- calculate
	local current = (available / 4) - UTIL:TextWidth("CUR:") - UTIL:TextWidth(tostring(_current))

	-- between spacing
	DRAW:Spacing(current,1)

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/name", _text))
	ImGui.Text("CUR:")
	ImGui.PopStyleColor(1)
	DRAW:Sameline()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _text))
	ImGui.Text(tostring(_current))
	ImGui.PopStyleColor(1)

	-- always
	DRAW:Sameline()

	-- calculate
	local average = (available / 4) - UTIL:TextWidth("AVG:") - UTIL:TextWidth(tostring(_average))

	-- between spacing
	DRAW:Spacing(average,1)

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/name", _text))
	ImGui.Text("AVG:")
	ImGui.PopStyleColor(1)
	DRAW:Sameline()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _text))
	ImGui.Text(tostring(_average))
	ImGui.PopStyleColor(1)

	-- always
	DRAW:Sameline()

	-- calculate
	local minimum = (available / 4) - UTIL:TextWidth("MIN:") - UTIL:TextWidth(tostring(_minimum))

	-- between spacing
	DRAW:Spacing(minimum,1)

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/name", _text))
	ImGui.Text("MIN:")
	ImGui.PopStyleColor(1)
	DRAW:Sameline()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _text))
	ImGui.Text(tostring(_minimum))
	ImGui.PopStyleColor(1)

	-- always
	DRAW:Sameline()

	-- calculate
	local maximum = (available / 4) - UTIL:TextWidth("MAX:") - UTIL:TextWidth(tostring(_maximum))

	-- between spacing
	DRAW:Spacing(maximum,1)

	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/name", _text))
	ImGui.Text("MAX:")
	ImGui.PopStyleColor(1)
	DRAW:Sameline()
	ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _text))
	ImGui.Text(tostring(_maximum))
	ImGui.PopStyleColor(1)
end

--
--// DRAW.GraphPainter() -- child for painting bars
--
function DRAW:GraphPainter(_child, _width, _height, _scale, _value, _show, _bar, _back, _text)

	-- defaults
	local bar = math.floor(_value)
	local txt = tostring(_value)

	-- scale if not false
	if _scale ~= false
	then
		bar = math.floor(_value / _scale)
	end

	-- calculate remaining
	local top = _height - bar

	-- exception if zero
	if bar == 0
	then
		top = _height - 1
		bar = 1
		txt = "N/A"
	end

	-- start painting
	ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor("graphbar/background", _back))
	ImGui.PushStyleVar(ImGuiStyleVar.ScrollbarSize, 0)
	ImGui.PushStyleVar(ImGuiStyleVar.FramePadding, 0, 0)

	if _show ~= false
	then
		_height = _height + 22
	end

	-- create frame
	local blind = ImGui.BeginChildFrame(_child, _width, _height, ImGuiWindowFlags.NoScrollWithMouse)

	-- drop stacks
	ImGui.PopStyleVar(2)
	ImGui.PopStyleColor(1)

	if blind
	then
		DRAW:Spacer(1,top)

		ImGui.PushStyleColor(ImGuiCol.FrameBg, DRAW:GetColor())
		ImGui.PushStyleColor(ImGuiCol.PlotHistogram, DRAW:GetColor("graphbar/progessbar", _bar))

		ImGui.ProgressBar(1, UTIL:ScreenScale(_width), bar, "")
		ImGui.PopStyleColor(2)

		-- draw text if wanted
		if _show ~= false
		then
			DRAW:Spacer(1,1)

			DRAW:Spacer(2,1)
			DRAW:Sameline()

			if string.len(txt) < 3
			then
				DRAW:Spacer(4,1)
				DRAW:Sameline()
			end

			if string.len(txt) < 2
			then
				DRAW:Spacer(3,1)
				DRAW:Sameline()
			end

			ImGui.PushStyleColor(ImGuiCol.Text, DRAW:GetColor("graph/text/value", _text))
			ImGui.Text(txt)
			ImGui.PopStyleColor(1)

			DRAW:Spacer(1,3)
		end

		ImGui.EndChildFrame()
	end
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

	-- animations
	DRAW.Anim = {
		Logo = {
			Single = 0,
			Pieces = 0,
			Pixels = 0,
			Spacer = 0,
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
				{1,1,1,1,1,0,1,1,0,1,1,0,0,1,1,1,0,1,1,0,0,0,0,1,1,1,1,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,0,1,1,1,1,1}
			}
		}

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






	DRAW.Matrix = {
		Mox = {
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.17,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0.72,1,1,1,0.18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.61,1,0.72,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0.23,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0.02,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0.68,1,1,1,1,1,1,0.41,0,0,0,0,0,0,0,0,0,0,0,0.39,1,1,1,1,1,0.5,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0.78,0,0,0,0,0,0,0,0,0.08,1,1,1,1,1,1,1,0.78,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.21,1,1,1,1,1,1,1,1,1,1,0.3,0,0,0,0,0,0.82,1,1,1,1,1,1,1,1,0.91,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.52,1,1,1,1,1,1,1,1,1,1,1,1,0.88,0.85,1,1,1,1,1,1,1,1,1,1,1,0.94,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.74,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.69,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.67,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.35,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.18,1,1,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.42,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0.33,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0.04,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.16,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0.36,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.08,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0.68,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.11,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0.93,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0},
			{0,0,0,0,0.13,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0},
			{0,0,0,0.45,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0,0,0,0,0},
			{0,0,0.77,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.56,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.72,0,0,0,0},
			{0,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.93,0.53,1,1,1,1,1,1,1,1,1,0.65,0,0.83,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.25,0,0,0},
			{0.48,1,1,1,0.99,1,1,1,1,1,1,1,1,0.8,0.43,1,1,0,0.82,1,1,1,1,1,1,1,1,1,0.69,0,0,0.58,1,0.87,0.2,0.41,1,1,1,1,1,1,1,1,1,1,0,0,0},
			{1,1,1,0.76,0.71,1,1,1,1,1,1,1,1,0.62,0,0.05,0,0,1,1,1,1,1,1,1,1,1,0.91,0,0,0.57,0,0,0,0,0.13,1,1,1,1,1,1,1,1,1,1,1,0,0},
			{0.72,1,1,0,1,1,1,1,1,1,1,1,1,0.17,0.03,0.27,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0.3,1,1,1,0.59,0,0,1,1,1,1,1,1,1,1,1,1,1,0.87,0},
			{0,1,0.27,0.33,1,1,1,1,1,0.91,1,1,1,0,1,1,1,1,1,1,0.96,0.87,0.76,0.69,0.6,0.54,0.5,0.51,0.76,1,1,1,1,0.9,0.86,0,1,1,1,1,1,1,1,0.98,1,1,1,1,0.33},
			{0,0.07,0,1,1,1,1,1,0.26,0.51,1,1,0.78,0.25,1,0,0.09,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.83,0,0,1,0,0.72,1,1,1,1,1,1,0.54,0.67,1,1,1,0.97},
			{0,0,0.72,1,1,1,1,1,0,1,1,1,0.46,0.71,1,0,0,0,0.48,1,1,1,1,1,1,1,1,1,1,1,0.44,0,0,0,1,0,0.24,1,1,1,1,1,1,1,0,1,1,1,0.99},
			{0,0,1,1,1,1,1,0.21,0,1,1,1,0.17,1,0.98,0,0,0,0,0,0.65,1,1,1,1,1,1,1,1,0.09,0,0,0,0,1,0.32,0,1,1,1,1,1,1,1,0.57,0.07,1,1,0.65},
			{0,0.06,1,1,1,1,1,0,0.72,1,1,1,0,1,1,0,0,0,0,0,0,0,0.77,1,1,1,1,1,0,0,0,0,0,0,1,0.63,0,1,1,1,1,1,1,1,1,0,0.69,1,0},
			{0,0,1,1,1,1,0.2,0,1,1,1,1,0,1,1,0,0,0,0,0,0,0,0,0.39,1,1,1,0.31,0,0,0,0,0,0.06,1,0.87,0,1,1,1,0.49,1,1,1,1,0.69,0,0.58,0},
			{0,0,0,1,1,1,0,0.17,1,1,1,0.73,0,1,1,0.55,0,0,0,0,0,0,0.34,1,1,1,1,0,0,0,0,0,0,1,1,1,0,0.75,1,1,0.8,0,1,1,1,1,0,0,0},
			{0,0,0,0,0.81,0.12,0,0.8,1,1,1,0.35,0,0.61,1,1,0.35,0,0,0,0.02,0.83,1,1,0.99,0.47,1,1,0.19,0,0,0,0.93,1,1,1,0,0.46,1,1,1,0,0.69,1,1,1,0,0,0},
			{0,0,0,0,0,0,0,1,1,1,1,0.03,0,0,1,1,1,0.81,0.35,0.87,1,1,1,1,0,0,0.94,1,1,0.88,0.86,1,1,1,1,1,0,0.2,1,1,1,0.86,0,1,1,0.55,0,0,0},
			{0,0,0,0,0,0,0.11,1,1,1,1,0,0,0,0.57,1,1,1,1,1,1,1,1,0.28,0,0,0,1,1,1,1,1,1,1,1,0.71,0,0,1,1,1,1,0,0.65,1,0,0,0,0},
			{0,0,0,0,0,0,0.01,1,1,1,0.79,0,0,0,0,0.8,1,1,1,1,1,1,1,0.16,0,0,0,0.98,1,1,1,1,1,1,1,0,0,0,1,1,1,1,0.24,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0.83,1,1,0.35,0,0,0,0,0,0.74,1,0.82,0.39,1,1,1,1,0.3,0,0,1,1,0.6,0.87,1,1,0.8,0,0,0,0,0.88,1,1,1,0.17,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0.52,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0.86,0.8,1,1,0,0,0,0,0,0,0,0,0,0.62,1,1,1,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0.11,0,0,0,0,0,0,0,0,0.33,1,1,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0.09,0,0,0,0,0,0,0,0,0.18,0.88,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0.91,1,0.77,1,1,1,1,0.15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0,0,0,0.87,0,0.35,1,0,0.46,0.2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
		}
	}






	return o
end

-- return
return DRAW