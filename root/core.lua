--
-- Developer Extras v3
-- 2022 by FreakaZ
--
-- https://rootpunk.com/mod/#developerextras
-- https://github.com/rp-freakaz/DeveloperExtras
-- hello@rootpunk.com
--
local CORE = {}

-- libraries
local UTIL = require("root/util.lua")
local DRAW = require("root/draw.lua")

--
--// CORE:Initialize()
--
function CORE:Initialize()

	-- debug id
	local __func__ = "CORE:Initialize"

	-- debug msg
	CORE:DebugConsole(__func__,"Starting ..")

	-- debug msg
	CORE:DebugConsole(__func__,"Detect Versions ..")
	if CORE:DetectVersions()
	then
		-- debug msg
		CORE:DebugConsole(__func__,"Detected: Cyberpunk 2077: "..CORE.Version.Game.String.." ("..CORE.Version.Game.Numeric..")")
		CORE:DebugConsole(__func__,"Detected: Cyber Engine Tweaks: "..CORE.Version.Cet.String.." ("..CORE.Version.Cet.Numeric..")")

		-- native scaling
		if CORE.Version.Cet.Numeric >= 1210
		then
			-- enable scaling
			CORE.Scaling.Enable = true

			-- debug msg
			CORE:DebugConsole(__func__,"Native Scaling: Enabled")
		else
			-- debug msg
			CORE:DebugConsole(__func__,"Native Scaling: Not Supported")
		end

		-- libraries
		UTIL:Pre(CORE.Project, CORE.Version, CORE.Runtime, CORE.Scaling, CORE.isDebug)
		DRAW:Pre(CORE.Project, CORE.Version, CORE.Runtime, CORE.Scaling, CORE.isDebug)

		-- debug msg
		CORE:DebugConsole(__func__,"Loading Options ..")

		-- load options
		if CORE:LoadOption()
		then
			-- debug msg
			CORE:DebugConsole(__func__,"Found "..tostring(UTIL:TableLength(CORE.Option)).." Options")
			CORE:DebugConsole(__func__,"Loading Structure ..")

			-- load list
			local list = {"Graphics","Features","Settings","Experimental"}

			-- looping through
			for _,pool in pairs(list)
			do
				-- load selected
				local exit,data = UTIL:LoadJson("data/"..string.lower(pool)..".json")

				-- validate
				if exit
				then
					-- debug msg
					CORE:DebugConsole(__func__,"Loaded Pool: "..pool)
					CORE.Render[pool] = data.pool
				else
					-- debug msg
					CORE:DebugConsole(__func__,"Failed to Load: "..pool)
				end
			end


			--print(UTIL:DebugDump(UTIL:ThemeList()))


			--for k,v in pairs(UTIL:ThemeList())
			--do
			--	print(UTIL:DebugDump(UTIL:ThemeToInt(v)))
			--	print(UTIL:DebugDump(UTIL:IntToTheme(k)))
			--end



			-- we are done
			CORE.isReady = true

			-- debug msg
			CORE:DebugConsole(__func__,"Finished ..")
		else
			-- debug msg
			CORE:DebugConsole(__func__,"Detected: Cyberpunk 2077: "..CORE.Version.Game.String.." ("..CORE.Version.Game.Numeric..")")
			CORE:DebugConsole(__func__,"Detected: Cyber Engine Tweaks: "..CORE.Version.Cet.String.." ("..CORE.Version.Cet.Numeric..")")
			CORE:DebugConsole(__func__,"Finished ..")

			-- public msg
			CORE:PrintConsole("Failed to initialize, missing or corrupt file")
		end
	else
		-- debug msg
		CORE:DebugConsole(__func__,"Detected: Cyberpunk 2077: "..CORE.Version.Game.String.." ("..CORE.Version.Game.Numeric..")")
		CORE:DebugConsole(__func__,"Detected: Cyber Engine Tweaks: "..CORE.Version.Cet.String.." ("..CORE.Version.Cet.Numeric..")")
		CORE:DebugConsole(__func__,"Finished ..")

		-- public msg
		CORE:PrintConsole("Failed to initialize, unsupported version")
	end
end

--
--// CORE:Cronjobs()
--
function CORE:Cronjobs()

	-- preset
	local _timer

	-- use frame timer
	_timer = ImGui.GetFrameCount()

	if CORE.Timings.Frame ~= _timer
	then
		-- update timing
		CORE.Timings.Frame = _timer

		-- update only if enabled
		if CORE:GetInternal("DeveloperExtras/Graph/Enable")
		then
			-- frame times
			CORE.History.Frametime = CORE:UpdateHistory(CORE.History.Frametime, tonumber(string.format("%.2f", ImGui.GetTime() * 1000)))
		end
	end

	-- use seconds timer
	_timer = UTIL:GetSeconds()

	if CORE.Timings.Second ~= _timer
	then
		-- update timing
		CORE.Timings.Second = _timer

		-- update only if enabled
		if CORE:GetInternal("DeveloperExtras/Graph/Enable")
		then
			-- frame rates
			CORE.History.Framerate = CORE:UpdateHistory(CORE.History.Framerate, ImGui.GetFrameCount())
		end
	end
end

--
--// CORE:Interface()
--
function CORE:Interface()

	-- debug id
	local __func__ = "CORE:Interface"

	-- run cronjobs
	CORE:Cronjobs()

	-- always update
	CORE:UpdateScreen()

	-- start window
	local _trigger = DRAW:WindowStart(CORE:GetToggle("DeveloperExtras/Debug/Resize","bool"))
	if _trigger
	then
		-- always update
		CORE:UpdateWindow()

		-- start tabbar
		local _trigger = DRAW:TabbarStart()
		if _trigger
		then
			-- tab order
			list = CORE:TabOrder()

			-- start tabloop
			for _,pool in pairs(list)
			do
				-- start tabitem
				local _trigger = DRAW:TabitemStart(pool)
				if _trigger
				then
					-- default bottom space
					local bottom = UTIL:WindowScale(116)

					-- add more if graph is enabled
					if CORE:GetInternal("DeveloperExtras/Graph/Enable")
					and not CORE:GetInternal("DeveloperExtras/Graph/Overlay/Enable")
					then
						bottom = UTIL:WindowScale(371)
					end

					-- make the tabbar thicker, before the child
					DRAW:Separator(UTIL:WindowScale(2), "tabbar/bottomline")

					-- start tabchild
					local _trigger = DRAW:TabchildStart(CORE.Scaling.Window.Width, CORE.Scaling.Window.Height - bottom, CORE.Extras["DeveloperExtras/Scrollbar/Enable"])
					if _trigger
					then
						-- page render
						if pool == "About"
						or pool == "Stash"
						or pool == "Debug"
						then
							-- about tab
							if pool == "About"
							then
								local _trigger = DRAW:PageAbout()
								if _trigger
								then
									CORE:ToggleStash()
								end
							end

							-- stash tab
							if pool == "__Stash"
							then
								DRAW:PageStash()
							end

							-- debug tab
							if pool == "Debug"
							then
								DRAW:PageDebug()
							end

						-- option render
						else
							-- start child loop
							for _,loop in pairs(CORE.Render[pool])
							do
								-- no collapse render
								if pool == "Settings"
								then
									-- start option loop
									for _,render in pairs(loop.list)
									do
										-- call renderswitch
										CORE:RenderSwitch(pool, render)
									end

								-- collapsable render
								else
									-- begin collapse
									local _trigger = DRAW:Collapse(loop.name.." ("..UTIL:TableOption(loop.list)..")", scale)
									if _trigger
									then
										-- show tab notice
										if CORE:isPreGame()
										then
											DRAW:Notification("Toggle's are disabled, because you are not in Night City yet.")
										end

										-- start option loop
										for _,render in pairs(loop.list)
										do
											-- call the render switch
											CORE:RenderSwitch(pool, render)
										end
									end
								end

							-- end child loop
							end

						-- end render
						end

					-- end tabchild
					DRAW:TabchildEnd()
					end

				-- end tabitem
				DRAW:TabitemEnd()
				end

			-- end tabloop
			end

		-- end tabbar
		end
		DRAW:TabbarEnd()

		-- tabbar thickness, after the child
		DRAW:Separator(UTIL:WindowScale(2), "tabbar/bottomline")
		DRAW:Separator(1, "tabbar/bottomline")

		if CORE:GetInternal("DeveloperExtras/Graph/Enable")
		then


			--DRAW:GraphWrapperFT(CORE.Overlay.FT.History, CORE.Overlay.FT.Length, UTIL:TableLength(CORE.Overlay.FT.History))
			--DRAW:GraphWrapperFPS(CORE.Overlay.FPS.History, CORE.Overlay.FPS.Length, UTIL:TableLength(CORE.Overlay.FPS.History))

			DRAW:Frametime(CORE.History.Frametime.Store, "%.2f", 5, 50, 2, false, "FRAMETIME:", 1, 1, 1)


			--print(UTIL:DebugDump(ImGui.GetWindowDrawList()))

			--ImGui.ImDrawListAddRect(100,100,200,200, DRAW:GetColorNew(0,"something"))


			--draw_list->AddRect(ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 0.0f,  ImDrawCornerFlags_All, th); x += sz+spacing; 

			-- tabbar thickness, after performance graph
			DRAW:Separator(UTIL:WindowScale(2), "tabbar/bottomline")
			DRAW:Separator(1, "tabbar/bottomline")
		end


	-- end window
	end
	DRAW:WindowEnd()
end

--
--// CORE:RenderSwitch()
--
function CORE:RenderSwitch(pool, render)

	-- needs path
	if render.path
	then
		-- check pool for existence
		if CORE:HasOption(render.path)
		then
			-- fetch option definition
			local option = CORE.Option[render.path]

			-- check option requirements
			local demand = CORE:RenderRequire(pool, option, render)

			--local need = CORE:RenderRequire(pool, option, render)

			--demand = 0
			--cause = ""

			-- slider types
			if option.type == "int"
			or option.type == "Int"
			or option.type == "float"
			or option.type == "Float"
			then
				CORE:RenderSlider(pool, option, render, demand)
			end

			-- button types
			if option.type == "IntList"
			or option.type == "NameList"
			or option.type == "StringList"
			then
				--CORE:RenderButtons(pool, option, render, demand)
			end

			-- checkbox types
			if option.type == "bool"
			or option.type == "Bool"
			then
				if pool == "Settings"
				then
					CORE:RenderQuickshift(pool, option, render, demand)
				else
					CORE:RenderCheckbox(pool, option, render, demand)
				end
			end

			-- combobox types
			if option.type == "select"
			then
				CORE:RenderCombobox(pool, option, render, demand)
			end
		else
			-- something is wrong
			if CORE.isDebug then
				--DRAW.CollapseNotice(ImGui.GetWindowWidth(), "BROKEN ELEMENT: "..render.path)
			end
		end
	elseif render.separator
	then
		DRAW:Spacer(1,UTIL:WindowScale(10))
		DRAW:Separator(UTIL:WindowScale(render.separator))

		--DRAW:FlexButton(CORE.Scaling.Window.Usable * 0.75,5)
		--DRAW:FlexButton(CORE.Scaling.Window.Usable * 0.5,5)
		--DRAW:FlexButton(CORE.Scaling.Window.Usable * 0.25,5)

		DRAW:Spacer(1,UTIL:WindowScale(10))
	elseif render.spacing
	then
		DRAW:Spacer(1,UTIL:WindowScale(render.spacing))
	else
		-- something is wrong
		if CORE.isDebug then
			DRAW:Notification("BROKEN ELEMENT (no path)")
		end
	end
end



--
--// CORE:RenderRequire(<POOL>,<ENTRY>)
--
function CORE:Require()
	return 0
end


--
--// CORE:RenderRequire(<POOL>,<ENTRY>)
--
function CORE:RenderRequire(pool, option, render)

	-- defaults
	local demand = 0

	-- check requirements
	if CORE:isPreGame() and pool ~= "Settings"
	then
		-- pregame
		demand = 0
	end

	-- is enabled?
	if option.is == false and demand == 0
	then
		-- disable
		demand = 2
	end

	-- check cet
	if option.cet and demand == 0
	then
		-- disable
		demand = 3

		if option.cet.min <= CORE.Version.Cet.Numeric and option.cet.max >= CORE.Version.Cet.Numeric
		then
			-- reenable
			demand = 0
		end
	end

	-- check photomode
	if option.need == "Photomode" and CORE.isPhoto == false and demand == 0
	then
		demand = 9
	end

	-- return
	return 0
end

--
--// CORE:RenderSlider()
--
function CORE:RenderSlider(pool, option, render, state)

	-- debug id
	local __func__ = "CORE:RenderSlider"

	-- get current
	local value = CORE:GetToggle(render.path, option.type)

	-- create slider
	local value, trigger, spacing = DRAW:Slider(render, option, demand, value)
	if trigger
	then
		CORE:SetToggle(render.path, option.type, value)

		-- needs to be enabled
		--if state == "enabled"
		--then
			--POOL.SetToggle(_entry.path, _entry.type, _value)
			--if eFlag.Draw ~= nil then
			--	Self.DelayRedraw(eFlag.Draw)
			--end
		--end
	end

	-- has default
	if option.def
	then
		-- always
		DRAW:Sameline()
		DRAW:Spacing(UTIL:WindowScale(4),1)
		DRAW:Sameline()

		local trigger = DRAW:Button(render, option, state, "Reset", "Reset")
		if trigger
		then

		end
	end

	-- has list
	if option.list
	then
		DRAW:Spacer(UTIL:WindowScale(5),UTIL:WindowScale(5))

		if render.spacing
		then
			DRAW:Spacing(render.spacing + 15,1)
		else
			DRAW:Spacing(28+15,1)
		end

		-- start loop of steps
		for num,piece in pairs(option.list)
		do
			-- space between
			if num ~= 1
			then
				DRAW:Spacing(5,1)
			end

			-- fix ugly floats
			if option.type == "float" or option.type == "Float"
			then
				piece = UTIL:ShortenFloat(piece)
				value = UTIL:ShortenFloat(value)
			end

			-- create button
			local trigger = DRAW:Button(render, option, demand, piece, value)
			if trigger
			then


			end

			DRAW:Sameline()
		end

		DRAW:Spacer(1,1) -- clear sameline
	end


	-- description
	if render.desc then
		--DRAW:Description(render, spacing + UTIL:WindowScale(11), state)
	end

end





--
--// CORE:RenderButtons()
--
function CORE:RenderButtons(pool, option, render, demand)

	-- debug id
	local __func__ = "CORE:RenderButtons"

	-- get current
	local value = nil

	if option.is
	then
		value = CORE:GetToggle(render.path, option.type)
	else
		if option.type == "StringList" and option.list ~= nil
		then
			value = option.list[1]
		end

	end

	-- begin child
	if render.both
	then
		if render.both > 0
		then
			DRAW:Sameline()
		end

		-- draw limiter child
		--ImGui.BeginChild('DE_ListChild'..tostring(render.path), (ImGui.GetWindowWidth() / 2 - 16), 42, false, ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoMove + ImGuiWindowFlags.NoScrollWithMouse)

		ImGui.BeginChild('DE_ListChild'..tostring(render.path), (ImGui.GetWindowWidth() / 2 - 16), 48, false, ImGuiWindowFlags.NoScrollbar + ImGuiWindowFlags.NoMove + ImGuiWindowFlags.NoScrollWithMouse)


		-- version [smooth font renderin added with cet 1210)]
		if DRAW.Version.Cet.Numeric >= 1210
		then
			ImGui.SetWindowFontScale(DRAW.Scaling.Font)
		end
	end


	-- render prepare
	if render.spacing then
		DRAW:Spacing(render.spacing,1)
		DRAW:ButtonTitle(render.name, option.min, option.max, demand)

		-- render info
		if render.note or render.rate
		then
			DRAW:ButtonNotes(render, "?", demand)
		else
			DRAW:Sameline()
			DRAW:Spacer(1,15)
		end

		DRAW:Spacer(1,5)
		DRAW:Spacing(render.spacing + 15,1)
	else
		DRAW:Spacing(28,1)
		DRAW:ButtonTitle(render.name, option.min, option.max, demand)

		-- render info
		if render.note or option.rating
		then
			DRAW:ButtonNotes(render, "?", demand)
		else
			DRAW:Sameline()
			DRAW:Spacer(1,15)
		end

		DRAW:Spacer(1,5)
		DRAW:Spacing(28+15,1)
	end

	-- start loop of options
	for num,piece in pairs(option.list)
	do
		-- space between
		if num ~= 1
		then
			DRAW:Spacing(5,1)
		end

		-- create button
		local trigger = DRAW:Button(render, option, demand, piece, value)
		if trigger
		then
			-- needs to be enabled
			if option.is
			then

				--Self.SetToggle(ePool, eType, ePath, eFlag, uValue)

				--local eLoop = false

				--if uValue ~= Pool.System[ePath]['hasoff'] and eFlag.onTrue ~= nil then
				--	eLoop = Self.LoopChild(ePool, eFlag.onTrue)
				--end

				--if uValue == Pool.System[ePath]['hasoff'] and eFlag.onFalse ~=nil then
				--	eLoop = Self.LoopChild(ePool, eFlag.onFalse)
				--end

				--if eFlag.Draw then
				--	Self.DelayRedraw(eFlag.Draw)
				--elseif eLoop == true then
				--	Self.DelayRedraw(0)
				--end
			end
		end

		DRAW:Sameline(5)
	end

	DRAW:Spacer(1, 0) -- clear sameline

	-- close child
	if render.both
	then
		ImGui.EndChild()
	end
end






--
--// CORE:RenderCheckbox()
--
function CORE:RenderCheckboxOLD(pool, option, render, demand)

	-- debug id
	local __func__ = "CORE:RenderCheckbox"

	-- get current
	local value = CORE:GetToggle(render.path, option.type)

	-- special type of bool
	if option.type == "Bool" and render.show == true
	then
		-- render prepare
		if render.spacing then
			DRAW:Spacing(render.spacing,1)
			DRAW:RenderTitle(demand, render.name)
			DRAW:Spacer(1,5)
			DRAW:Spacing(render.spacing + 16,1)
		else
			DRAW:Spacing(10,1)
			DRAW:RenderTitle(demand, render.name)
			DRAW:Spacer(1,5)
			DRAW:Spacing(10+16,1)
		end

		-- create button
		local trigger = DRAW:Button(render, option, demand, false, value)
		if trigger
		then
			-- needs to be enabled
			if UTIL:IntToBool(demand)
			then
				-- apply it
				CORE:SetToggle(render.path, option.type, value)


				--Self.SetToggle(ePool, eType, ePath, eFlag, uValue)

				--local eLoop = false

				--if uValue ~= Pool.System[ePath]['hasoff'] and eFlag.onTrue ~= nil then
				--	eLoop = Self.LoopChild(ePool, eFlag.onTrue)
				--end

				--if uValue == Pool.System[ePath]['hasoff'] and eFlag.onFalse ~=nil then
				--	eLoop = Self.LoopChild(ePool, eFlag.onFalse)
				--end

				--if eFlag.Draw then
				--	Self.DelayRedraw(eFlag.Draw)
				--elseif eLoop == true then
				--	Self.DelayRedraw(0)
				--end
			end
		end

		DRAW:Sameline()
		DRAW:Spacing(5,1)
		DRAW:Sameline()

		-- create button
		local trigger = DRAW:Button(render, option, demand, true, value)
		if trigger
		then
			-- needs to be enabled
			if option.is
			then

				--Self.SetToggle(ePool, eType, ePath, eFlag, uValue)

				--local eLoop = false

				--if uValue ~= Pool.System[ePath]['hasoff'] and eFlag.onTrue ~= nil then
				--	eLoop = Self.LoopChild(ePool, eFlag.onTrue)
				--end

				--if uValue == Pool.System[ePath]['hasoff'] and eFlag.onFalse ~=nil then
				--	eLoop = Self.LoopChild(ePool, eFlag.onFalse)
				--end

				--if eFlag.Draw then
				--	Self.DelayRedraw(eFlag.Draw)
				--elseif eLoop == true then
				--	Self.DelayRedraw(0)
				--end
			end
		end

	-- regular type of bool
	else
		-- render prepare
		if render.spacing then
			DRAW:Spacing(render.spacing,1)
		elseif render.sameline then
			DRAW:Sameline()
			DRAW:Spacing(render.sameline,1)
		else
			DRAW:Spacing(10,1)
		end

		local value, trigger = DRAW:Checkbox(render, option, demand, value)
		if trigger
		then
			-- needs to be enabled
			if UTIL:IntToBool(demand)
			then
				-- apply it
				CORE:SetToggle(render.path, option.type, value)


				--print(UTIL.DebugDump(_entry))

			--local eLoop = false

			--if cValue == true and eFlag.onTrue then
			--	eLoop = Self.LoopChild(ePool, eFlag.onTrue)
			--end

			--if cValue == false and eFlag.onFalse then
			--	eLoop = Self.LoopChild(ePool, eFlag.onFalse)
			--end

			--if eFlag.Draw then
			--	Self.DelayRedraw(eFlag.Draw)
			--elseif eLoop == true then
			--	Self.DelayRedraw(0)
			--end

			end
		end


		--if _render.path == "DeveloperExtras/BoolTrue"
		--or _render.path == "DeveloperExtras/BoolFalse"
		--then
		--	DRAW.CheckboxInfo("can't be toggled", "!", _state)
		--end



		--if eFlag.Note then
		--	Draw.Sameline(6)
		--	Draw.BlindButton('grey','normal','('..tostring(eFlag.Note)..')')
		--end
	end


	-- render info
	if render.note or render.rate
	then
		DRAW:ButtonNotes(render, "?", demand)
	else
		DRAW:Sameline()
		DRAW:Spacer(1,15)
	end




	-- render info
	--if render.note or option.rating
	--then
	--	DRAW.CheckboxInfo(_render.note, "?", _state, _option.rating)
	--else
	--	DRAW.Sameline()
	--	DRAW.Spacing(22,1)
	--end

	-- render description
	if render.desc then
		DRAW:CheckboxDesc(render, option, demand)
	end
end






--
--// CORE:RenderCombobox()
--
function CORE:RenderCombobox(pool, option, render, demand)

	-- debug id
	local __func__ = "CORE:RenderCombobox"

	-- get current
	local value = CORE:GetToggle(render.path, option.type)

	-- call draw
	local value, trigger = DRAW:Combobox(render, option, demand, CORE.Runtime.Themes.Listing, UTIL:TableLength(CORE.Runtime.Themes.Listing), value)
	if trigger
	then
		--print(tostring(value))
		CORE:SetToggle(render.path, option.type, value)


		--print(UTIL:DebugDump(DRAW.Profile["window/main/background"]))
	end
end




--
--// CORE:RenderQuickshift()
--
function CORE:RenderQuickshift(pool, option, render, demand)

	-- debug id
	local __func__ = "CORE:RenderQuickshift"

	-- get current
	local value = UTIL:BoolToInt(CORE:GetToggle(render.path, option.type))

	-- create minified slider
	local value, trigger = DRAW:Quickshift(render, option, demand, value)
	if trigger
	then
		CORE:SetToggle(render.path, option.type, UTIL:IntToBool(value))
	end
end



--
--// CORE:RenderCheckbox()
--
function CORE:RenderCheckbox(pool, option, render)

	-- debug id
	local __func__ = "CORE:RenderCheckbox"

	-- get state
	local state = CORE:Require(pool, option, render)

	-- get current
	local value = CORE:GetToggle(render.path, option.type)

	-- create checkbox
	local value, trigger = DRAW:Checkbox(render, option, state, value)
	if trigger
	then
		-- needs to be enabled
		if UTIL:IntToBool(state)
		then
			-- apply it
			CORE:SetToggle(render.path, option.type, value)


			--print(UTIL.DebugDump(_entry))

			--local eLoop = false

			--if cValue == true and eFlag.onTrue then
			--	eLoop = Self.LoopChild(ePool, eFlag.onTrue)
			--end

			--if cValue == false and eFlag.onFalse then
			--	eLoop = Self.LoopChild(ePool, eFlag.onFalse)
			--end

			--if eFlag.Draw then
			--	Self.DelayRedraw(eFlag.Draw)
			--elseif eLoop == true then
			--	Self.DelayRedraw(0)
			--end

		end
	end


	--if _render.path == "DeveloperExtras/BoolTrue"
	--or _render.path == "DeveloperExtras/BoolFalse"
	--then
	--	DRAW.CheckboxInfo("can't be toggled", "!", _state)
	--end




end























































function CORE:ResetGraph()

	-- debug id
	local __func__ = "CORE:ResetGraph"

	if CORE:GetInternal("DeveloperExtras/Graph/Enable")
	and not CORE:GetInternal("DeveloperExtras/Graph/Overlay/Enable")
	and not CORE:GetInternal("DeveloperExtras/Graph/BackgroundUpdate")
	then
		CORE.History.Frametime.Previous = 0
		CORE.History.Framerate.Previous = 0
		CORE.History.Frametime.Store = {}
		CORE.History.Framerate.Store = {}

		-- debug msg
		CORE:DebugConsole(__func__,"Executed!")
	end
end



















--
--// CORE:LoadOption()
--
function CORE:LoadOption()

	-- debug id
	local __func__ = "CORE:LoadOption"

	-- define
	local data = nil
	local exit = false

	-- load & convert
	exit, data = UTIL:LoadJson("data/_options.json")

	-- validate
	if exit
	then
		-- common
		CORE:LoadSorted("int", data)
		CORE:LoadSorted("any", data)

		-- get major if no minor present
		if string.len(UTIL:FilterNumbers(CORE.Version.Game.String)) == 3
		then
			CORE:LoadSorted(string.sub(UTIL:FilterNumbers(CORE.Version.Game.String), 1, 2), data)
		end

		-- get major or minor version
		CORE:LoadSorted(UTIL:FilterNumbers(CORE.Version.Game.String), data)
	else
		-- debug msg
		CORE:DebugConsole(__func__,"failed to parse _options.json")
	end

	-- result
	return exit
end


--
--// CORE:LoadSorted()
--
function CORE:LoadSorted(want, data)

	-- debug id
	local __func__ = "CORE:LoadSorted"

	-- debug msg
	if want == "int" or want == "any"
	then
		CORE:DebugConsole(__func__,"Requesting: "..UTIL:FirstToUpper(want))
	else
		CORE:DebugConsole(__func__,"Requesting: Patch "..want)
	end

	-- loop classes
	for ck,cc in pairs(data)
	do
		-- only relevant
		if ck == want
		then
			-- debug msg
			CORE:DebugConsole(__func__,"Reading Records: "..tostring(UTIL:TableLength(cc)))

			-- loop records
			for rk,rc in pairs(cc)
			do
				-- call parser
				CORE:BootOption(rk, rc)
			end
		end
	end
end




--
--// CORE:BootOption(<STRING>,<TABLE>)
--
function CORE:BootOption(path, attr)

	-- debug id
	local __func__ = "CORE:BootOption"

	-- does not exist in pool
	if CORE:HasNotOption(path)
	then
		-- prepare
		local unit = {}

		-- defaults
		unit.is = false
		unit.type = attr.type

		-- record values
		if attr.def ~= nil then unit.def = attr.def end
		if attr.min ~= nil then unit.min = attr.min end
		if attr.max ~= nil then unit.max = attr.max end

		-- slider res
		if attr.res ~= nil
		then
			unit.res = attr.res
		else
			unit.res = "%.1f"
		end

		-- cet vesion
		if attr.cet ~= nil then
			unit.cet = attr.cet
		end

		-- has ontrue
		if attr.ontrue ~= nil then
			unit.ontrue = attr.ontrue
		end

		-- has onfalse
		if attr.onfalse ~= nil then
			unit.onfalse = attr.onfalse
		end

		-- redraw delay
		if attr.draw ~= nil then
			unit.draw = attr.draw
		end

		-- get group + option
		local group, option = UTIL:SplitPath(path)

		-- internal
		if CORE:IsInternal(path)
		then
			-- set enabled
			unit.is = true

			-- assign it
			CORE.Option[path] = unit

			-- just set it
			if attr.boot ~= nil
			then
				CORE.Extras[path] = attr.boot
			end

			-- debug msg
			CORE:DebugConsole(__func__, "Registered: "..tostring(path))

			--print(path)
			--print(UTIL:DebugDump(CORE.Option[path]))
			--print(UTIL:DebugDump(CORE.Extras[path]))

		end

		-- option
		if CORE:IsNotInternal(path) and (unit.type == "int" or unit.type == "bool" or unit.type == "float")
		then
			-- exist here (like an .Has)
			if GameOptions.Get(group, option) ~= ""
			then
				-- get current value
				local value = CORE:GetToggle(path, attr.type)

				-- set enabled
				unit.is = true

				-- check default flag
				if unit.def ~= nil
				then
					if unit.type == "float"
					then
						if UTIL:ShortenFloat(value) ~= UTIL:ShortenFloat(unit.def)
						then
							-- set current
							CORE.Config[path] = UTIL:ShortenFloat(value)

							-- set different default
							unit.old = unit.def
							unit.def = CORE.Config[path]

							-- assign option
							CORE.Option[path] = unit

							-- debug msg
							CORE:DebugConsole(__func__, "Registered: "..tostring(path).." (from ini)")
						else
							-- set current
							CORE.Config[path] = UTIL:ShortenFloat(unit.def)

							-- assign option
							CORE.Option[path] = unit

							-- debug msg
							CORE:DebugConsole(__func__, "Registered: "..tostring(path))
						end
					else
						if unit.def ~= value
						then
							-- set current
							CORE.Config[path] = value

							-- set different default
							unit.old = unit.def
							unit.def = CORE.Config[path]

							-- assign option
							CORE.Option[path] = unit

							-- debug msg
							CORE:DebugConsole(__func__, "Registered: "..tostring(path).." (from ini)")
						else
							-- set current
							CORE.Config[path] = unit.def

							-- assign option
							CORE.Option[path] = unit

							-- debug msg
							CORE:DebugConsole(__func__, "Registered: "..tostring(path))
						end
					end
				else
					if unit.type == "float"
					then
						-- set current
						CORE.Config[path] = UTIL:ShortenFloat(value)

						-- assign option
						CORE.Option[path] = unit
					else
						-- set current
						CORE.Config[path] = value

						-- assign option
						CORE.Option[path] = unit
					end

					-- debug msg
					CORE:DebugConsole(__func__, "Registered: "..tostring(path))
				end
			else
				-- assign disabled option
				CORE.Option[path] = unit

				-- debug msg
				CORE:DebugConsole(__func__, "Failed to Register: "..tostring(path))
			end
		end

		-- system
		if CORE:IsNotInternal(path) and (unit.type == "Int" or unit.type == "Bool" or unit.type == "Float" or unit.type == "IntList" or unit.type == "NameList" or unit.type == "StringList")
		then
			-- proceed if exist
			if Game.GetSettingsSystem():HasVar("/"..group, option)
			then
				local value = CORE:GetToggle(path, attr.type)

				-- loop over lists
				if unit.type == "IntList"
				or unit.type == "NameList"
				or unit.type == "StringList"
				then
					-- get system identifier
					local system = Game.GetSettingsSystem():GetVar('/'..group, option)

					-- get all options
					local options = system:GetValues()

					-- something is needed
					if options ~= nil
					then
						-- set enabled
						unit.is = true

						-- define list
						unit.list = {}

						-- loop over them
						for _,entry in pairs(options)
						do
							-- convert name value
							if unit.type == "NameList"
							then
								entry = Game.NameToString(entry)
							end

							-- register if it has an off option
							if entry == "Off" and option ~= "FSR"
							or entry == "Off" and option ~= "DLSS"
							then
								unit.has = entry
							end

							-- keep OFF in DLSS and RT Light ;-)
							if entry ~= "Off" and entry ~= "Auto"
							or entry == "Off" and option == "FSR"
							or entry == "Off" and option == "DLSS"
							or entry == 'Off' and option == "RayTracedLighting"
							then
								-- insert option into list
								table.insert(unit.list, entry)
							end
						end

						-- set current
						CORE.Config[path] = value

						-- assign option
						CORE.Option[path] = unit

						-- debug msg
						CORE:DebugConsole(__func__, "Registered: "..tostring(path))

					-- something wrong?
					else
						-- assign option
						CORE.Option[path] = unit

						-- debug msg
						CORE:DebugConsole(__func__, "Failed to Register: "..tostring(path).." (empty options)")
					end
				end

				-- bools just flat
				if unit.type == "Bool"
				then
					-- set enabled
					unit.is = true

					-- assign option
					CORE.Option[path] = unit

					-- debug msg
					CORE:DebugConsole(__func__, "Registered: "..tostring(path))
				end

				-- floats usally have min/max
				if unit.type == "Int"
				or unit.type == "Float"
				then
					-- get system identifier
					local system = Game.GetSettingsSystem():GetVar('/'..group, option)

					local min = system:GetMinValue()
					local max = system:GetMaxValue()

					-- needs min/max
					if min ~= nil and max ~= nil
					then
						-- set enabled
						unit.is = true

						-- assign
						unit.min = min
						unit.max = max

						-- override?
						if attr.override then
							if attr.override["min"] ~= nil then unit.min = attr.override["min"] end
							if attr.override["max"] ~= nil then unit.max = attr.override["max"] end
							if attr.override["list"] ~= nil then unit.list = attr.override["list"] end
						end

						-- assign option
						CORE.Option[path] = unit

						-- debug msg
						CORE:DebugConsole(__func__, "Registered: "..tostring(path))
					else
						-- debug msg
						CORE:DebugConsole(__func__, "Failed to Register: "..tostring(path).." (empty min,max)")
					end
				end

			-- do we have an fallback?
			else
				-- only need for this type
				if unit.type == "StringList"
				then
					if attr.fallback ~= nil
					then
						-- define list
						unit.list = attr.fallback

						-- assign option
						CORE.Option[path] = unit
					end
				end

				-- debug msg
				CORE:DebugConsole(__func__, "Failed to Register: "..tostring(path).." (not existing)")
			end

			if option == "FSR" then
				print(UTIL:DebugDump(CORE.Option[path]))
			end

			if option == "SRS_Resolution" then
				print(UTIL:DebugDump(CORE.Option[path]))
			end

		end
	else
		CORE:DebugConsole(__func__, "Failed to Register: "..tostring(unit.path).." (unknown option)")
	end
end

--
--// CORE:GetToggle(<STRING>,<STRING>)
--
function CORE:GetToggle(path, type)

	-- split first
	local group, option = UTIL:SplitPath(path)

	-- DevEx Internal
	if CORE:IsInternal(path)
	then
		return CORE:GetInternal(path)
	else
		-- int
		if type == "int" then
			return GameOptions.GetInt(group, option)
		end

		-- bool
		if type == "bool" then
			return GameOptions.GetBool(group, option)
		end

		-- float
		if type == "float" then
			return GameOptions.GetFloat(group, option)
		end

		-- system int
		if type == "Int" or type == "IntList" then
			system = Game.GetSettingsSystem():GetVar("/"..group, option)
			return system:GetValue()
		end

		-- system bool
		if type == "Bool" then
			system = Game.GetSettingsSystem():GetVar("/"..group, option)
			return system:GetValue()
		end

		-- system name
		if type == "NameList" then
			local system = Game.GetSettingsSystem():GetVar("/"..group, option)
			return Game.NameToString(system:GetValue())
		end

		-- system string
		if type == "StringList"
		then
			local system = Game.GetSettingsSystem():GetVar("/"..group, option)
			return system:GetValue()
		end
	end
end

--
--// CORE:SetToggle(<STRING>,<STRING>,<MIXED>)
--
function CORE:SetToggle(path, type, set)

	-- split first
	local group, option = UTIL:SplitPath(path)

	-- DevEx Internal
	if CORE:IsInternal(path)
	then
		CORE:SetInternal(path, set)
	else
		-- update config
		CORE.Config[path] = set

		-- int
		if type == "int" and CORE:HasOption(path)
		then
			GameOptions.SetInt(group, option, set)
		end

		-- bool
		if type == "bool" and CORE:HasOption(path)
		then
			GameOptions.SetBool(group, option, set)
		end

		-- float
		if type == "float" and CORE:HasOption(path)
		then
			GameOptions.SetFloat(group, option, set)
		end

		-- system vars
		if type == "Int"
		or type == "Bool"
		or type == "Float"
		then
			local system = Game.GetSettingsSystem():GetVar("/"..group, option)
			system:SetValue(set)
		end

		if type == "IntList"
		then
			local system = Game.GetSettingsSystem():GetVar("/"..group, option)
			system:SetValue(set)
		end

		if type == "NameList"
		or type == "StringList"
		then
			local system = Game.GetSettingsSystem():GetVar("/"..group, option)
			local recast = system:GetIndexFor(set)
			if recast then
				system:SetIndex(recast)
			else
				system:SetValue(set)
			end
		end
	end
end

--
--// CORE:GetInternal(<STRING>)
--
function CORE:GetInternal(path)

	-- always true & false
	if path == "DeveloperExtras/BoolTrue" then return true	end
	if path == "DeveloperExtras/BoolFalse" then return false end

	-- time dilation
	if path == "DeveloperExtras/TimeTick/World"
	or path == "DeveloperExtras/TimeTick/Player"
	then
		return CORE.Extras[path]
	end


	if path == "DeveloperExtras/Color/Preset" then return CORE.Extras[path] end


	-- ui toggles
	if path == "DeveloperExtras/Debug/Enable" then return CORE.isDebug end
	if path == "DeveloperExtras/Debug/Resize" then return CORE.Extras[path] end

	if path == "DeveloperExtras/Scrollbar/Enable" then return CORE.Extras[path] end

	-- ui scaling
	if path == "DeveloperExtras/Scale/Enable" then return CORE.Extras[path] end
	if path == "DeveloperExtras/Scale/Factor" then return CORE.Extras[path] end

	-- graph toggles (flexi)
	if path == "DeveloperExtras/Graph/Enable" then return CORE.Extras[path] end
	if path == "DeveloperExtras/Graph/BackgroundUpdate" then return CORE.Extras[path] end

	-- graph overlay toggles
	if path == "DeveloperExtras/Graph/Overlay/Enable"
	or path == "DeveloperExtras/Graph/Overlay/Position"
	or path == "DeveloperExtras/Graph/Overlay/Transparency"
	or path == "DeveloperExtras/Graph/Overlay/Transparency/Bar"
	or path == "DeveloperExtras/Graph/Overlay/Transparency/Bar/Background"
	or path == "DeveloperExtras/Graph/Overlay/Transparency/Text"
	then
		return CORE.Extras[path]
	end
end

--
--// CORE:SetInternal(<STRING>,<MIXED>)
--
function CORE:SetInternal(path, set)

	-- feature: time dilation
	if path == 'DeveloperExtras/TimeTick/Player' then
		CORE.Extras[path] = set
	end
	if path == 'DeveloperExtras/TimeTick/World' then
		CORE.Extras[path] = set
	end

	-- debug me
	if path == "DeveloperExtras/Debug/Enable" then
		CORE.isDebug = set
		DRAW.isDebug = set
		UTIL.isDebug = set
	end
	if path == "DeveloperExtras/Debug/Resize" then CORE.Extras[path] = set end


	-- color theme
	if path == "DeveloperExtras/Color/Preset" then
		CORE.Extras[path] = set
		CORE.Runtime.Themes.Select = set
		DRAW.Runtime.Themes.Select = set
		UTIL.Runtime.Themes.Select = set
	end

	-- ui toggles
	if path == "DeveloperExtras/Scrollbar/Enable" then CORE.Extras[path] = set end

	-- ui scaling
	if path == "DeveloperExtras/Scale/Enable" then CORE.Extras[path] = set end
	if path == "DeveloperExtras/Scale/Factor" then
		CORE.Extras[path] = set
		CORE.Scaling = set
		DRAW.Scaling = set
		UTIL.Scaling = set
	end

	-- graph toggles (flexi)
	if path == "DeveloperExtras/Graph/Enable" then
		CORE.Extras[path] = set

		if not CORE:GetInternal("DeveloperExtras/Graph/BackgroundUpdate")
		and not CORE:GetInternal("DeveloperExtras/Graph/Overlay/Enable")
		then
			CORE:ResetGraph()
		end
	end
	if path == "DeveloperExtras/Graph/BackgroundUpdate" then
		CORE.Extras[path] = set
	end

	-- graph overlay toggles
	if path == "DeveloperExtras/Graph/Overlay/Enable"
	or path == "DeveloperExtras/Graph/Overlay/Position"
	or path == "DeveloperExtras/Graph/Overlay/Transparency"
	or path == "DeveloperExtras/Graph/Overlay/Transparency/Bar"
	or path == "DeveloperExtras/Graph/Overlay/Transparency/Bar/Background"
	or path == "DeveloperExtras/Graph/Overlay/Transparency/Text"
	then
		CORE.Extras[path] = set
	end
end

--
--// CORE:IsInternal(<STRING>)
--
function CORE:IsInternal(path)
	local exit = false
	local root = path:match("[^/]*")
	if root == "DeveloperExtras" then exit = true end
	return exit
end

--
--// CORE:IsNotInternal(<STRING>)
--
function CORE:IsNotInternal(path)
	local exit = false
	local root = path:match("[^/]*")
	if root ~= "DeveloperExtras" then exit = true end
	return exit
end

--
--// CORE:HasOption(<STRING>)
--
function CORE:HasOption(path)
	local exit = false
	if CORE.Option[path] ~= nil then exit = true end
	return exit
end

--
--// CORE:HasNotOption(<STRING>)
--
function CORE:HasNotOption(path)
	local exit = false
	if CORE.Option[path] == nil then exit = true end
	return exit
end





















--
--// CORE:UpdateHistory(<TABLE>,<INT>)
--
function CORE:UpdateHistory(t,v)

	-- catch non set
	local t = t or nil
	local v = v or nil

	-- catch wrong call
	if t ~= nil and v ~= nil
	then
		t.Current = v
		if t.Previous == 0 then t.Previous = t.Current end

		-- update everything else
		if t.Current > t.Previous
		then
			t.Difference = t.Current - t.Previous
			t.Previous = t.Current

			-- update table
			if t.Difference > 0
			then
				table.insert(t.Store, t.Difference)
			else
				table.insert(t.Store, 0)
			end

			-- trim to long table
			if UTIL:TableLength(t.Store) > t.Limit
			then
				table.remove(t.Store,1)
			end
		end

		-- result
		return t
	end
end
























--
--// CORE:TabOrder
--
function CORE:TabOrder()
	local list = {"Graphics","Features","Settings","About"}
	if CORE.isStash then table.insert(list, "Stash") end
	if CORE.isDebug then table.insert(list, "Debug") end

	--if _experimental then table.insert(_list, "Experimental") end
	--table.insert(_list, "Experimental")

	return list
end


--
--// CORE:UpdateScreen()
--
function CORE:UpdateScreen()

	-- get dimension
	local width, height = GetDisplayResolution()

	-- update only if something has changed
	if CORE.Scaling.Screen.Width ~= width or CORE.Scaling.Screen.Height ~= height
	then
		-- update dimension
		CORE.Scaling.Screen.Width = width
		CORE.Scaling.Screen.Height = height
		CORE.Scaling.Screen.Usable = math.floor(width / 2)

		-- scaling enabled?
		if CORE.Scaling.Enable
		then
			-- we use the screen height to keep the aspect ratio
			CORE.Scaling.Screen.Factor = UTIL:ShortenFloat((CORE.Scaling.Screen.Height / 9 * 16) / 1920)
		end

		-- distribute to all
		DRAW.Scaling = CORE.Scaling
		UTIL.Scaling = CORE.Scaling
	end
end

--
--// CORE:UpdateWindow()
--
function CORE:UpdateWindow()

	-- get dimension
	local width = ImGui.GetWindowWidth()
	local height = ImGui.GetWindowHeight()

	-- update only if something has changed
	if CORE.Scaling.Window.Width ~= width or CORE.Scaling.Window.Height ~= height
	then
		-- update dimension
		CORE.Scaling.Window.Width = width
		CORE.Scaling.Window.Height = height
		CORE.Scaling.Window.Usable = width - (CORE.Runtime.Window.Border * 2)

		-- scaling enabled?
		if CORE.Scaling.Enable
		then
			-- update window factor
			CORE.Scaling.Window.Factor = UTIL:ShortenFloat(CORE.Scaling.Window.Width / (456 * CORE.Scaling.Screen.Factor))
		end

		-- distribute to all
		DRAW.Scaling = CORE.Scaling
		UTIL.Scaling = CORE.Scaling
	end
end

--
--// CORE:DetectVersions
--
function CORE:DetectVersions()

	-- return
	local exit = false

	-- set cet version
	CORE.Version.Cet.String = tostring(GetVersion():gsub("v", ""))
	CORE.Version.Cet.Numeric = tonumber(UTIL:FilterNumbers(GetVersion()))

	-- set game version (1.20.0+ is 1.6 Branch)
	if CORE.Version.Cet.Numeric >= 1200
	then
		-- (string) version, (numeric) branch - call doesn't exist pre 1.3
		CORE.Version.Game.String = GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():GetGameVersion()
		CORE.Version.Game.Numeric = tonumber(UTIL:FilterNumbers(string.format("%.1f", GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():GetGameVersion())))

	-- set game version (1.19.0+ is 1.5 Branch)
	elseif CORE.Version.Cet.Numeric >= 1190
	then
		-- (string) version, (numeric) branch - call doesn't exist pre 1.3
		CORE.Version.Game.String = GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():GetGameVersion()
		CORE.Version.Game.Numeric = tonumber(UTIL:FilterNumbers(string.format("%.1f", GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():GetGameVersion())))

	-- set game version (1.16.0+ is 1.3 Branch)
	elseif CORE.Version.Cet.Numeric >= 1160 and CORE.Version.Cet.Numeric <= 1183
	then
		-- (string) version, (numeric) branch - call doesn't exist pre 1.3
		CORE.Version.Game.String = GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():GetGameVersion()
		CORE.Version.Game.Numeric = tonumber(UTIL:FilterNumbers(string.format("%.1f", GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():GetGameVersion())))

	-- set game version (1.12.0+ is 1.2 Branch)
	elseif CORE.Version.Cet.Numeric >= 1120 and CORE.Version.Cet.Numeric <= 1150
	then
		-- (string) version, (numeric) branch
		CORE.Version.Game.String = "1.2"
		CORE.Version.Game.Numeric = 12

		-- patch versions
		if CORE.Version.Cet.Numeric >= 1122 then CORE.Version.Game.String = "1.21" end
		if CORE.Version.Cet.Numeric >= 1130 then CORE.Version.Game.String = "1.22" end
		if CORE.Version.Cet.Numeric >= 1140 then CORE.Version.Game.String = "1.23" end

	-- set game version (1.9.0+ is 1.1 Branch)
	elseif CORE.Version.Cet.Numeric >= 190 and CORE.Version.Cet.Numeric <= 1114
	then
		-- (string) version, (numeric) branch
		CORE.Version.Game.String = "1.1"
		CORE.Version.Game.Numeric = 11

		-- patch versions
		if CORE.Version.Cet.Numeric >= 195 then CORE.Version.Game.String = "1.11" end
		if CORE.Version.Cet.Numeric >= 1100 then CORE.Version.Game.String = "1.12" end
	end

	-- validate
	if CORE.Version.Cet.Numeric > 0 and CORE.Version.Game.Numeric > 0 then
		exit = true
	end

	-- return
	return exit
end



--
--// CORE:isPreGame()
--
function CORE:isPreGame()
	return GetSingleton("inkMenuScenario"):GetSystemRequestsHandler():IsPreGame()
end

--
--// CORE:PrintConsole(<STRING>)
--
function CORE:PrintConsole(msg)
	print('*** '..CORE.Project..' (v'..CORE.Version.String..') '..tostring(msg))
end

--
--// CORE:DebugConsole(<STRING>, <STRING>)
--
function CORE:DebugConsole(id, msg)
	if CORE.isDebug	then
		CORE:PrintConsole('- ['..tostring(id)..'] '..tostring(msg))
	end
end

--
-- CONSTRUCTOR
--
function CORE:Pre()
	local o = {}
	setmetatable(o, self)
	self.__index = self

	-- who i am
	CORE.Project = "Developer Extras"
	CORE.Authors = "FreakaZ"
	CORE.Version = {String="3.0.0-161",Numeric=300161,Cet={String=nil,Numeric=0},Game={String=nil,Numeric=0}}

	-- shared var
	CORE.Scaling = {Enable=false,Screen={Width=0,Height=0,Factor=1,Usable=0},Window={Width=456,Height=600,Factor=1,Usable=0}}
	CORE.Runtime = {Window={Border=2,Padding=10},Themes={Select=0,Listing={"Default","White Satin"}}}

	-- non shared
	CORE.Timings = {Frame=0,Second=0,Millisecond=0}
	CORE.Trigger = {Saving=0,Export=0,Redraw=0}
	CORE.History = {
		Frametime = {Store={},Limit=256,Current=0,Previous=0,Difference=0},
		Framerate = {Store={},Limit=64,Current=0,Previous=0,Difference=0}
	}

	-- pooling
	CORE.Render = {}
	CORE.Option = {}
	CORE.Config = {}
	CORE.Export = {}
	CORE.Extras = {}

	-- trigger
	CORE.isReady = false
	CORE.isPaint = false
	CORE.isPhoto = false
	CORE.isDebug = true
	CORE.isScale = true
	CORE.isStash = false

	CORE.isSaving = 0
	CORE.isExport = 0
	CORE.isRedraw = 0



	CORE.Picture = {
		Mox = {
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.02,0.03,0.02,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.07,0.08,0.07,0.06,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.07,0.1,0.12,0.13,0.13,0.11,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.1,0.14,0.17,0.18,0.17,0.16,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.05,0.09,0.13,0.17,0.21,0.23,0.22,0.2,0.16,0.13,0.09,0.06,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.08,0.12,0.16,0.2,0.23,0.76,0.62,0.23,0.2,0.17,0.13,0.1,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.11,0.15,0.19,0.23,0.59,1,1,0.61,0.23,0.2,0.17,0.14,0.1,0.07,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.02,0.03,0.04,0.03,0.02,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.09,0.14,0.18,0.22,0.43,1,1,1,1,0.68,0.23,0.21,0.17,0.14,0.11,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.06,0.07,0.08,0.09,0.08,0.07,0.06,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.08,0.12,0.17,0.2,0.27,0.88,1,1,1,1,1,0.76,0.24,0.22,0.18,0.15,0.11,0.08,0.04,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.07,0.09,0.1,0.12,0.13,0.14,0.13,0.12,0.09,0.07,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.11,0.15,0.19,0.23,0.7,1,1,1,1,1,1,1,0.82,0.26,0.22,0.18,0.16,0.12,0.09,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.07,0.09,0.11,0.14,0.16,0.17,0.18,0.19,0.18,0.17,0.14,0.11,0.08,0.05,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.05,0.09,0.14,0.18,0.22,0.46,1,1,1,1,1,1,1,1,1,0.88,0.31,0.22,0.19,0.16,0.12,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.06,0.09,0.11,0.14,0.17,0.18,0.2,0.22,0.23,0.24,0.23,0.21,0.18,0.16,0.12,0.08,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.08,0.12,0.17,0.2,0.26,0.89,1,1,1,1,1,1,1,1,1,1,0.94,0.36,0.23,0.19,0.16,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.07,0.1,0.13,0.16,0.18,0.2,0.23,0.27,0.54,0.76,0.85,0.72,0.32,0.23,0.19,0.15,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.1,0.15,0.19,0.23,0.65,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.44,0.23,0.2,0.16,0.13,0.09,0.06,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.09,0.12,0.14,0.17,0.2,0.23,0.28,0.64,0.97,1,1,1,1,0.95,0.37,0.22,0.18,0.13,0.09,0.06,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.08,0.12,0.17,0.21,0.39,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.51,0.23,0.2,0.17,0.13,0.1,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.07,0.1,0.13,0.16,0.19,0.22,0.24,0.52,0.96,1,1,1,1,1,1,1,0.87,0.25,0.2,0.17,0.12,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.1,0.15,0.19,0.24,0.78,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.59,0.23,0.2,0.17,0.14,0.1,0.07,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.11,0.14,0.17,0.2,0.23,0.33,0.83,1,1,1,1,1,1,1,1,1,1,0.66,0.23,0.19,0.14,0.09,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.08,0.13,0.17,0.22,0.46,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.67,0.23,0.21,0.17,0.14,0.11,0.08,0.04,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.07,0.09,0.12,0.16,0.18,0.21,0.24,0.57,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.35,0.2,0.17,0.11,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.1,0.16,0.2,0.24,0.83,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.76,0.24,0.22,0.18,0.15,0.11,0.08,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.08,0.11,0.13,0.17,0.2,0.23,0.3,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.65,0.23,0.18,0.13,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.08,0.13,0.17,0.22,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.83,0.28,0.22,0.18,0.16,0.12,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.09,0.12,0.15,0.18,0.2,0.23,0.48,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0.25,0.2,0.15,0.1,0.06,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.1,0.15,0.2,0.24,0.84,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0.31,0.23,0.19,0.16,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.07,0.1,0.13,0.16,0.19,0.22,0.24,0.7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.45,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.08,0.12,0.17,0.21,0.49,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.39,0.23,0.2,0.16,0.13,0.09,0.06,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.09,0.12,0.14,0.17,0.2,0.23,0.39,0.9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.67,0.23,0.18,0.13,0.08,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.06,0.09,0.15,0.19,0.24,0.79,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.49,0.23,0.2,0.17,0.13,0.1,0.07,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.07,0.1,0.13,0.16,0.19,0.21,0.24,0.58,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.12,0.17,0.2,0.4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.57,0.23,0.2,0.17,0.14,0.11,0.08,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.06,0.09,0.12,0.14,0.17,0.2,0.23,0.31,0.82,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.32,0.2,0.16,0.1,0.06,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.18,0.23,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.69,0.24,0.21,0.18,0.15,0.12,0.09,0.06,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.08,0.1,0.13,0.16,0.19,0.21,0.24,0.54,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.48,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.1,0.16,0.2,0.27,0.93,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.81,0.28,0.22,0.19,0.16,0.13,0.1,0.07,0.04,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.07,0.09,0.12,0.15,0.18,0.2,0.23,0.31,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.61,0.22,0.17,0.12,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.07,0.12,0.17,0.22,0.53,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.92,0.38,0.23,0.2,0.17,0.14,0.11,0.08,0.06,0.03,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.05,0.07,0.09,0.12,0.14,0.17,0.19,0.22,0.24,0.56,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.7,0.23,0.18,0.13,0.08,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.18,0.23,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.24,0.21,0.18,0.16,0.13,0.1,0.08,0.06,0.03,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.06,0.07,0.09,0.12,0.14,0.17,0.19,0.21,0.23,0.39,0.86,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.81,0.24,0.19,0.13,0.09,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.06,0.1,0.16,0.2,0.29,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.77,0.28,0.23,0.2,0.17,0.14,0.13,0.1,0.08,0.07,0.05,0.04,0.03,0.02,0.02,0.02,0.02,0.02,0.02,0.03,0.04,0.06,0.07,0.08,0.09,0.12,0.14,0.17,0.19,0.2,0.23,0.3,0.73,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.12,0.17,0.21,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.49,0.24,0.22,0.19,0.17,0.15,0.13,0.11,0.1,0.09,0.08,0.07,0.07,0.07,0.07,0.07,0.07,0.08,0.09,0.1,0.11,0.13,0.15,0.17,0.19,0.2,0.23,0.28,0.64,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.28,0.2,0.15,0.1,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.08,0.13,0.18,0.23,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.83,0.39,0.24,0.21,0.19,0.18,0.17,0.15,0.14,0.13,0.13,0.12,0.12,0.12,0.12,0.13,0.13,0.14,0.15,0.17,0.18,0.2,0.21,0.23,0.31,0.65,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.32,0.2,0.16,0.1,0.06,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.19,0.24,0.88,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.43,0.24,0.22,0.21,0.2,0.19,0.18,0.17,0.17,0.17,0.17,0.17,0.17,0.18,0.19,0.2,0.21,0.23,0.24,0.43,0.75,0.99,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.38,0.2,0.16,0.1,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.06,0.1,0.16,0.2,0.32,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.88,0.63,0.43,0.27,0.24,0.23,0.23,0.22,0.22,0.22,0.22,0.22,0.23,0.24,0.28,0.46,0.67,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.4,0.21,0.16,0.11,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.12,0.17,0.21,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.82,0.71,0.64,0.57,0.54,0.54,0.56,0.63,0.72,0.83,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.47,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.13,0.17,0.22,0.63,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.08,0.13,0.18,0.23,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.13,0.19,0.24,0.82,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.19,0.24,0.89,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.47,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.28,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.29,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.39,0.2,0.16,0.11,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.1,0.16,0.2,0.35,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.38,0.2,0.16,0.1,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.11,0.16,0.2,0.39,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.31,0.2,0.15,0.1,0.06,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.11,0.16,0.2,0.38,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.28,0.2,0.15,0.1,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.11,0.16,0.2,0.39,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.06,0.1,0.16,0.2,0.32,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.79,0.24,0.18,0.13,0.09,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.29,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.68,0.23,0.18,0.13,0.08,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.29,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.6,0.22,0.17,0.12,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.29,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.29,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.31,0.2,0.15,0.1,0.06,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.27,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.83,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.19,0.24,0.89,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.65,0.23,0.17,0.13,0.08,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.19,0.24,0.86,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.09,0.13,0.18,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.93,0.27,0.2,0.15,0.1,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.08,0.13,0.18,0.23,0.74,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.69,0.23,0.18,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.13,0.17,0.23,0.65,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.41,0.21,0.17,0.12,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.12,0.17,0.22,0.55,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.79,0.24,0.19,0.15,0.09,0.06,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.1,0.16,0.2,0.38,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.43,0.21,0.17,0.12,0.08,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.09,0.14,0.19,0.24,0.88,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.68,0.23,0.19,0.15,0.1,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.08,0.13,0.18,0.22,0.62,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.73,0.23,0.2,0.17,0.12,0.08,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.11,0.16,0.2,0.28,0.91,1,1,1,1,1,1,1,0.91,0.92,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.79,0.63,0.48,0.33,0.23,0.21,0.17,0.13,0.09,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.09,0.14,0.18,0.22,0.36,0.9,1,1,1,1,0.87,0.47,0.5,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.71,0.6,0.44,0.27,0.24,0.22,0.21,0.2,0.19,0.17,0.14,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.11,0.15,0.19,0.22,0.25,0.43,0.53,0.49,0.35,0.24,0.35,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.43,0.24,0.21,0.2,0.18,0.17,0.17,0.16,0.14,0.12,0.09,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.08,0.12,0.15,0.18,0.2,0.21,0.22,0.21,0.23,0.38,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.78,0.31,0.23,0.2,0.17,0.14,0.11,0.09,0.08,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.08,0.11,0.13,0.15,0.16,0.19,0.23,0.37,0.95,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.53,0.24,0.21,0.18,0.15,0.12,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.09,0.12,0.16,0.19,0.23,0.37,0.95,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.77,0.28,0.22,0.19,0.16,0.13,0.09,0.07,0.03,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.09,0.12,0.16,0.19,0.23,0.39,0.95,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.4,0.23,0.2,0.17,0.14,0.1,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.12,0.16,0.19,0.23,0.44,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.57,0.23,0.21,0.17,0.15,0.11,0.08,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.13,0.16,0.2,0.23,0.44,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.72,0.24,0.22,0.18,0.15,0.12,0.09,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.13,0.16,0.2,0.23,0.48,0.99,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.84,0.29,0.22,0.19,0.16,0.12,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.13,0.16,0.2,0.23,0.52,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.93,0.36,0.23,0.19,0.16,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.07,0.09,0.13,0.17,0.2,0.23,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.46,0.23,0.2,0.16,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.07,0.1,0.14,0.17,0.2,0.23,0.6,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.52,0.23,0.2,0.17,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.08,0.11,0.14,0.17,0.21,0.23,0.68,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.6,0.23,0.2,0.17,0.13,0.09,0.06,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.08,0.11,0.15,0.18,0.21,0.24,0.73,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.65,0.23,0.2,0.17,0.13,0.1,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.09,0.11,0.15,0.18,0.22,0.25,0.79,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.68,0.23,0.2,0.17,0.14,0.1,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.09,0.12,0.16,0.18,0.22,0.29,0.85,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.7,0.23,0.21,0.17,0.14,0.1,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.12,0.16,0.19,0.23,0.34,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.76,0.23,0.21,0.17,0.14,0.1,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.09,0.13,0.16,0.2,0.23,0.4,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.76,0.23,0.21,0.17,0.14,0.1,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.07,0.09,0.13,0.17,0.2,0.23,0.48,0.99,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.76,0.23,0.21,0.17,0.14,0.1,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.07,0.1,0.14,0.17,0.2,0.23,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.76,0.23,0.21,0.17,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.08,0.11,0.14,0.17,0.21,0.23,0.65,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.75,0.23,0.2,0.17,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.09,0.12,0.15,0.18,0.22,0.24,0.75,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.68,0.23,0.2,0.17,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.12,0.16,0.19,0.22,0.28,0.83,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.68,0.23,0.2,0.17,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.09,0.13,0.16,0.19,0.23,0.35,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.23,0.2,0.16,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.07,0.1,0.13,0.17,0.2,0.23,0.44,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.6,0.23,0.2,0.16,0.13,0.09,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.08,0.1,0.14,0.17,0.2,0.23,0.54,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.55,0.23,0.2,0.16,0.12,0.09,0.05,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.08,0.11,0.15,0.18,0.21,0.23,0.64,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.5,0.23,0.19,0.16,0.12,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.12,0.15,0.18,0.22,0.24,0.75,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0.23,0.19,0.15,0.11,0.08,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.13,0.16,0.19,0.22,0.3,0.85,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.39,0.22,0.18,0.15,0.11,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.07,0.09,0.13,0.16,0.2,0.23,0.37,0.93,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.92,0.32,0.22,0.18,0.14,0.1,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.08,0.1,0.14,0.17,0.2,0.23,0.49,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0.27,0.21,0.17,0.14,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.08,0.11,0.15,0.17,0.21,0.23,0.61,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.81,0.24,0.21,0.17,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.12,0.16,0.18,0.22,0.24,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.73,0.23,0.2,0.17,0.13,0.09,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.09,0.13,0.16,0.19,0.22,0.29,0.84,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.23,0.2,0.16,0.12,0.09,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.07,0.1,0.13,0.17,0.2,0.23,0.39,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.55,0.23,0.19,0.16,0.12,0.08,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.08,0.11,0.14,0.17,0.2,0.23,0.51,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0.23,0.19,0.15,0.11,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.09,0.11,0.15,0.18,0.21,0.24,0.64,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.36,0.22,0.18,0.14,0.1,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.12,0.16,0.18,0.22,0.25,0.77,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.75,0.64,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.88,0.28,0.21,0.17,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0.03,0.06,0.09,0.13,0.16,0.19,0.23,0.35,0.9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.48,0.24,0.88,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.24,0.2,0.17,0.13,0.09,0.05,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0.01,0.04,0.07,0.1,0.13,0.17,0.2,0.23,0.46,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.97,0.29,0.22,0.46,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.7,0.23,0.2,0.16,0.12,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0.01,0.04,0.08,0.11,0.14,0.17,0.2,0.23,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.85,0.24,0.19,0.23,0.73,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.57,0.23,0.19,0.16,0.11,0.08,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0.01,0.04,0.08,0.11,0.15,0.18,0.21,0.24,0.7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.74,0.23,0.18,0.21,0.31,0.92,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.45,0.23,0.18,0.15,0.11,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0.04,0.08,0.11,0.15,0.18,0.22,0.25,0.79,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.93,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.66,0.23,0.17,0.18,0.22,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.35,0.22,0.18,0.14,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0.03,0.07,0.11,0.15,0.18,0.22,0.3,0.86,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.75,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.23,0.17,0.16,0.2,0.24,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.86,0.25,0.21,0.17,0.13,0.09,0.05,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0.02,0.06,0.1,0.14,0.18,0.22,0.31,0.9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.92,0.24,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.58,0.22,0.17,0.13,0.17,0.21,0.32,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.74,0.23,0.2,0.16,0.12,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0.01,0.06,0.09,0.13,0.17,0.22,0.29,0.89,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.47,0.23,0.74,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.22,0.17,0.12,0.14,0.18,0.22,0.49,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.61,0.23,0.19,0.16,0.11,0.08,0.03,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0.04,0.08,0.12,0.17,0.2,0.24,0.83,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.99,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,0.73,0.23,0.24,0.87,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.57,0.22,0.17,0.12,0.11,0.15,0.2,0.23,0.68,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.22,0.18,0.15,0.1,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0},
			{0,0.01,0.06,0.1,0.15,0.19,0.23,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.49,0.88,1,1,1,1,1,1,1,1,1,1,1,0.91,0.29,0.21,0.29,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.52,0.22,0.17,0.12,0.08,0.13,0.17,0.2,0.23,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.85,0.43,0.71,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.34,0.22,0.17,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0},
			{0,0.03,0.08,0.13,0.17,0.21,0.46,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.92,0.24,0.4,1,1,1,1,1,1,1,1,1,1,1,0.46,0.22,0.21,0.43,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.06,0.09,0.13,0.17,0.21,0.23,0.73,1,1,1,1,1,1,1,1,1,1,1,0.91,0.64,0.36,0.24,0.22,0.59,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.84,0.24,0.2,0.17,0.13,0.09,0.05,0.01,0,0,0,0,0,0,0,0,0},
			{0,0.05,0.09,0.15,0.19,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.73,0.23,0.23,0.52,1,1,1,1,1,1,1,1,1,0.58,0.23,0.19,0.22,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.4,0.2,0.16,0.11,0.11,0.12,0.12,0.14,0.17,0.21,0.23,0.49,0.9,1,1,1,1,1,1,0.87,0.63,0.4,0.24,0.23,0.2,0.19,0.21,0.44,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.7,0.23,0.2,0.16,0.12,0.08,0.04,0,0,0,0,0,0,0,0,0},
			{0.01,0.06,0.11,0.16,0.2,0.4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.72,0.93,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.61,0.22,0.2,0.23,0.45,0.97,1,1,1,1,1,1,0.65,0.23,0.2,0.17,0.23,0.66,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.29,0.2,0.15,0.13,0.16,0.17,0.17,0.16,0.14,0.17,0.2,0.22,0.24,0.4,0.55,0.61,0.58,0.51,0.35,0.24,0.22,0.2,0.19,0.18,0.17,0.15,0.2,0.31,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.23,0.19,0.15,0.11,0.07,0.02,0,0,0,0,0,0,0,0},
			{0.02,0.07,0.12,0.17,0.22,0.61,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.69,0.52,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.41,0.21,0.16,0.19,0.23,0.31,0.73,1,1,1,0.92,0.48,0.23,0.2,0.17,0.18,0.24,0.79,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.71,0.23,0.18,0.14,0.18,0.2,0.22,0.22,0.2,0.19,0.17,0.16,0.18,0.19,0.2,0.22,0.22,0.22,0.21,0.2,0.19,0.18,0.17,0.15,0.13,0.11,0.14,0.19,0.24,0.88,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.99,0.4,0.22,0.18,0.14,0.09,0.06,0.02,0,0,0,0,0,0,0},
			{0.03,0.08,0.13,0.18,0.23,0.7,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.27,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.28,0.2,0.15,0.16,0.18,0.21,0.23,0.31,0.46,0.41,0.25,0.22,0.2,0.17,0.15,0.2,0.26,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.84,0.28,0.2,0.17,0.15,0.2,0.25,0.57,0.54,0.28,0.24,0.22,0.21,0.2,0.18,0.17,0.17,0.17,0.17,0.17,0.16,0.14,0.13,0.11,0.09,0.08,0.08,0.13,0.18,0.23,0.74,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0.26,0.21,0.17,0.13,0.09,0.05,0.01,0,0,0,0,0,0},
			{0.03,0.08,0.13,0.18,0.23,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,0.49,0.24,0.95,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.75,0.23,0.18,0.14,0.11,0.14,0.17,0.19,0.2,0.21,0.21,0.2,0.18,0.15,0.12,0.16,0.2,0.36,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.99,0.84,0.54,0.24,0.22,0.18,0.14,0.13,0.18,0.23,0.76,1,0.98,0.81,0.62,0.42,0.24,0.23,0.22,0.2,0.19,0.17,0.16,0.14,0.13,0.1,0.08,0.07,0.04,0.07,0.13,0.17,0.22,0.62,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.73,0.23,0.2,0.16,0.12,0.08,0.03,0,0,0,0,0,0},
			{0.02,0.07,0.13,0.17,0.22,0.62,1,1,1,1,1,1,1,1,1,1,1,1,0.76,0.24,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.61,0.22,0.17,0.14,0.15,0.15,0.15,0.14,0.15,0.17,0.16,0.15,0.13,0.11,0.11,0.16,0.21,0.41,0.84,0.82,0.8,0.87,0.9,0.89,0.89,0.88,0.91,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.97,0.98,0.94,0.88,0.91,0.85,0.8,0.76,0.69,0.59,0.46,0.31,0.24,0.22,0.2,0.17,0.15,0.11,0.14,0.18,0.23,0.74,1,1,1,1,1,0.94,0.73,0.55,0.33,0.24,0.22,0.2,0.19,0.17,0.16,0.13,0.11,0.08,0.06,0.12,0.17,0.21,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.55,0.23,0.19,0.15,0.1,0.06,0.02,0,0,0,0,0},
			{0.01,0.06,0.11,0.17,0.21,0.46,1,1,1,1,1,1,1,1,1,1,1,0.94,0.31,0.23,0.73,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.41,0.21,0.16,0.18,0.2,0.2,0.2,0.19,0.18,0.18,0.17,0.17,0.17,0.17,0.16,0.16,0.19,0.22,0.24,0.24,0.24,0.24,0.24,0.24,0.24,0.24,0.25,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.29,0.3,0.27,0.24,0.24,0.24,0.24,0.24,0.23,0.22,0.21,0.2,0.19,0.17,0.16,0.13,0.1,0.11,0.16,0.2,0.26,0.91,1,1,1,1,1,1,1,1,1,0.83,0.59,0.34,0.24,0.22,0.2,0.18,0.15,0.12,0.09,0.1,0.16,0.2,0.33,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.38,0.22,0.17,0.13,0.09,0.06,0.01,0,0,0,0},
			{0,0.05,0.1,0.15,0.2,0.26,0.91,1,1,1,1,1,1,1,1,1,1,0.49,0.22,0.31,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.28,0.2,0.17,0.21,0.28,0.31,0.25,0.24,0.24,0.23,0.23,0.22,0.22,0.21,0.2,0.2,0.2,0.19,0.19,0.19,0.18,0.19,0.19,0.19,0.19,0.19,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.19,0.19,0.19,0.18,0.18,0.18,0.17,0.17,0.15,0.14,0.13,0.1,0.1,0.13,0.15,0.18,0.22,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,0.83,0.5,0.24,0.22,0.19,0.17,0.13,0.1,0.15,0.2,0.27,0.93,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.85,0.24,0.2,0.17,0.12,0.08,0.04,0,0,0,0},
			{0,0.04,0.09,0.14,0.18,0.22,0.63,1,1,1,1,1,1,1,1,1,0.73,0.23,0.22,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.75,0.23,0.18,0.2,0.24,0.78,1,0.91,0.84,0.78,0.72,0.65,0.59,0.52,0.46,0.39,0.32,0.27,0.24,0.24,0.24,0.23,0.23,0.22,0.22,0.21,0.21,0.2,0.2,0.2,0.19,0.19,0.18,0.18,0.17,0.17,0.17,0.17,0.17,0.16,0.16,0.16,0.15,0.15,0.15,0.15,0.15,0.14,0.14,0.14,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.14,0.15,0.17,0.19,0.22,0.32,0.92,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0.46,0.23,0.2,0.17,0.13,0.14,0.18,0.24,0.78,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.67,0.23,0.19,0.15,0.11,0.07,0.02,0,0,0},
			{0,0.02,0.07,0.11,0.17,0.2,0.31,0.94,1,1,1,1,1,1,1,0.9,0.28,0.21,0.24,0.86,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.61,0.22,0.18,0.22,0.52,1,1,1,1,1,1,1,1,1,1,1,0.98,0.95,0.89,0.83,0.76,0.72,0.67,0.59,0.54,0.49,0.43,0.36,0.31,0.27,0.24,0.24,0.24,0.23,0.23,0.22,0.22,0.22,0.21,0.21,0.2,0.2,0.2,0.2,0.19,0.19,0.19,0.19,0.18,0.18,0.18,0.17,0.17,0.17,0.17,0.17,0.18,0.18,0.19,0.2,0.21,0.24,0.42,0.93,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.65,0.23,0.2,0.16,0.13,0.17,0.23,0.65,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.22,0.18,0.14,0.09,0.06,0,0,0},
			{0,0,0.05,0.09,0.14,0.18,0.22,0.56,1,1,1,1,1,1,1,0.46,0.22,0.21,0.48,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.41,0.21,0.2,0.24,0.87,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.93,0.87,0.83,0.78,0.72,0.68,0.62,0.57,0.52,0.47,0.43,0.39,0.33,0.28,0.27,0.24,0.24,0.24,0.24,0.23,0.23,0.23,0.23,0.22,0.23,0.22,0.22,0.23,0.23,0.24,0.29,0.49,0.79,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.91,1,1,1,0.62,0.23,0.19,0.15,0.17,0.22,0.54,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.28,0.2,0.17,0.12,0.07,0.03,0,0},
			{0,0,0.03,0.07,0.11,0.16,0.2,0.24,0.8,1,1,1,1,1,0.68,0.23,0.19,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.28,0.2,0.22,0.57,1,1,1,0.98,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.98,0.93,0.88,0.87,0.8,0.8,0.74,0.72,0.73,0.67,0.63,0.64,0.64,0.63,0.69,0.75,0.85,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.33,0.41,1,1,1,1,0.42,0.21,0.17,0.16,0.2,0.39,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.67,0.23,0.19,0.14,0.09,0.05,0,0},
			{0,0,0,0.05,0.09,0.13,0.17,0.21,0.35,0.95,1,1,1,0.87,0.24,0.2,0.21,0.46,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.81,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.75,0.23,0.2,0.24,0.89,1,1,1,0.85,0.31,0.71,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.29,0.23,0.24,0.85,1,1,1,0.74,0.23,0.19,0.15,0.2,0.28,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.34,0.2,0.16,0.11,0.07,0.03,0},
			{0,0,0,0.02,0.06,0.1,0.14,0.18,0.23,0.48,1,1,1,0.43,0.22,0.2,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0.23,0.63,1,1,1,1,1,1,1,1,1,1,1,1,1,0.61,0.22,0.22,0.53,1,1,1,1,0.72,0.23,0.23,0.4,0.85,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.61,0.24,0.21,0.18,0.22,0.58,1,1,1,0.97,0.31,0.2,0.16,0.19,0.24,0.83,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.56,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.6,0.22,0.18,0.14,0.09,0.04,0},
			{0,0,0,0,0.03,0.07,0.11,0.16,0.2,0.23,0.62,1,0.65,0.23,0.19,0.22,0.48,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.76,0.23,0.23,0.67,1,1,1,1,1,1,1,1,1,1,1,1,1,0.41,0.21,0.24,0.82,1,1,1,1,0.62,0.22,0.19,0.22,0.24,0.5,0.93,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.43,0.23,0.2,0.17,0.16,0.2,0.33,0.98,1,1,1,0.53,0.22,0.17,0.18,0.23,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.72,0.23,0.59,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.31,0.2,0.16,0.1,0.06,0},
			{0,0,0,0,0,0.04,0.08,0.12,0.16,0.2,0.27,0.54,0.31,0.2,0.2,0.24,0.85,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.38,0.21,0.26,0.92,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.28,0.2,0.4,1,1,1,1,1,0.5,0.21,0.17,0.17,0.2,0.22,0.25,0.62,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.81,0.28,0.23,0.19,0.16,0.13,0.14,0.19,0.24,0.8,1,1,1,0.67,0.23,0.17,0.17,0.22,0.59,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.43,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.46,0.21,0.17,0.11,0.06,0.01},
			{0,0,0,0,0,0.01,0.05,0.09,0.14,0.18,0.2,0.22,0.2,0.18,0.23,0.58,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.67,0.23,0.21,0.44,1,1,1,1,1,1,1,1,1,1,1,1,1,0.75,0.23,0.23,0.65,1,1,1,1,1,0.39,0.2,0.16,0.13,0.15,0.18,0.2,0.23,0.31,0.75,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.24,0.21,0.18,0.16,0.12,0.09,0.13,0.17,0.22,0.62,1,1,1,0.84,0.24,0.19,0.16,0.21,0.43,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.81,0.24,0.31,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.22,0.17,0.12,0.07,0.02},
			{0,0,0,0,0,0,0.02,0.07,0.11,0.14,0.16,0.17,0.17,0.21,0.35,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.92,0.29,0.2,0.23,0.65,1,1,1,1,1,1,1,1,1,1,1,1,1,0.62,0.22,0.24,0.88,1,1,1,1,0.98,0.31,0.2,0.15,0.1,0.11,0.13,0.16,0.19,0.21,0.23,0.4,0.85,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.46,0.23,0.2,0.17,0.14,0.11,0.08,0.06,0.11,0.16,0.21,0.44,1,1,1,0.96,0.29,0.2,0.15,0.2,0.3,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.5,0.23,0.49,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.56,0.22,0.17,0.12,0.07,0.02},
			{0,0,0,0,0,0,0,0.04,0.07,0.09,0.1,0.15,0.19,0.23,0.75,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.56,0.22,0.19,0.24,0.86,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0.21,0.39,1,1,1,1,1,0.93,0.27,0.2,0.15,0.1,0.07,0.09,0.12,0.14,0.17,0.19,0.22,0.24,0.5,0.92,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.83,0.3,0.23,0.19,0.17,0.13,0.1,0.07,0.04,0.06,0.1,0.15,0.2,0.29,0.97,1,1,1,0.41,0.21,0.16,0.19,0.24,0.87,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.84,0.24,0.23,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.56,0.22,0.17,0.12,0.07,0.02},
			{0,0,0,0,0,0,0,0,0.03,0.08,0.12,0.17,0.21,0.43,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.85,0.24,0.2,0.2,0.35,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.28,0.22,0.61,1,1,1,1,1,0.87,0.24,0.19,0.14,0.09,0.04,0.05,0.07,0.1,0.12,0.15,0.17,0.2,0.22,0.24,0.61,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.67,0.24,0.22,0.18,0.16,0.12,0.09,0.06,0.03,0,0.04,0.09,0.14,0.19,0.24,0.88,1,1,1,0.56,0.22,0.17,0.18,0.23,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.22,0.24,0.87,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.52,0.22,0.17,0.12,0.06,0.02},
			{0,0,0,0,0,0,0,0,0.05,0.09,0.14,0.19,0.24,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.49,0.22,0.17,0.22,0.59,1,1,1,1,1,1,1,1,1,1,1,1,1,0.78,0.24,0.23,0.75,1,1,1,1,1,0.82,0.24,0.19,0.13,0.09,0.04,0,0.03,0.06,0.08,0.1,0.13,0.15,0.18,0.2,0.23,0.3,0.73,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.49,0.23,0.2,0.17,0.14,0.11,0.09,0.05,0.02,0,0,0.03,0.09,0.13,0.18,0.24,0.8,1,1,1,0.65,0.23,0.17,0.17,0.22,0.62,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0.24,0.22,0.42,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.44,0.21,0.16,0.11,0.06,0.01},
			{0,0,0,0,0,0,0,0.02,0.06,0.11,0.17,0.2,0.38,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.79,0.24,0.2,0.19,0.24,0.79,1,1,1,1,1,1,1,1,1,1,1,1,1,0.62,0.22,0.26,0.91,1,1,1,1,1,0.8,0.24,0.18,0.13,0.09,0.03,0,0,0.01,0.03,0.06,0.08,0.11,0.13,0.16,0.19,0.21,0.23,0.39,0.83,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.88,0.33,0.23,0.2,0.17,0.13,0.1,0.07,0.04,0.02,0,0,0,0.03,0.08,0.13,0.18,0.23,0.73,1,1,1,0.78,0.24,0.18,0.17,0.21,0.48,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.22,0.23,0.58,1,1,1,1,1,1,1,1,1,1,1,1,0.81,0.33,0.2,0.16,0.1,0.06,0},
			{0,0,0,0,0,0,0,0.03,0.07,0.13,0.17,0.22,0.63,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.42,0.21,0.17,0.2,0.31,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0.21,0.34,0.98,1,1,1,1,1,0.8,0.24,0.19,0.13,0.09,0.03,0,0,0,0,0.02,0.04,0.07,0.09,0.12,0.14,0.17,0.19,0.22,0.24,0.49,0.92,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.73,0.24,0.22,0.19,0.16,0.13,0.09,0.06,0.03,0,0,0,0,0,0.03,0.08,0.13,0.18,0.23,0.71,1,1,1,0.92,0.26,0.2,0.16,0.2,0.32,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0.24,0.2,0.24,0.79,1,1,1,1,1,1,1,1,1,1,1,0.66,0.23,0.18,0.14,0.09,0.04,0},
			{0,0,0,0,0,0,0,0.04,0.09,0.14,0.19,0.24,0.83,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.72,0.23,0.19,0.17,0.22,0.55,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.28,0.21,0.46,1,1,1,1,1,1,0.8,0.24,0.18,0.13,0.09,0.03,0,0,0,0,0,0,0.02,0.05,0.07,0.09,0.12,0.14,0.17,0.2,0.22,0.24,0.61,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.57,0.23,0.21,0.18,0.15,0.12,0.09,0.06,0.02,0,0,0,0,0,0,0.03,0.08,0.13,0.18,0.23,0.72,1,1,1,0.98,0.32,0.2,0.16,0.2,0.26,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.22,0.21,0.31,0.93,1,1,1,1,1,1,1,1,1,1,0.44,0.21,0.17,0.11,0.07,0.03,0},
			{0,0,0,0,0,0,0,0.06,0.1,0.15,0.2,0.29,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.34,0.21,0.17,0.18,0.23,0.75,1,1,1,1,1,1,1,1,1,1,1,1,1,0.78,0.24,0.22,0.55,1,1,1,1,1,1,0.83,0.24,0.19,0.13,0.09,0.04,0,0,0,0,0,0,0,0,0.03,0.06,0.08,0.1,0.13,0.15,0.18,0.2,0.23,0.3,0.73,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.43,0.23,0.2,0.17,0.14,0.11,0.08,0.05,0.02,0,0,0,0,0,0,0,0.03,0.09,0.13,0.18,0.24,0.8,1,1,1,1,0.46,0.21,0.17,0.18,0.23,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0.26,0.2,0.22,0.48,1,1,1,1,1,1,1,1,1,0.87,0.24,0.19,0.15,0.1,0.06,0,0},
			{0,0,0,0,0,0,0.01,0.06,0.1,0.16,0.2,0.38,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.62,0.23,0.18,0.16,0.2,0.28,0.95,1,1,1,1,1,1,1,1,1,1,1,1,1,0.62,0.22,0.22,0.62,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0.01,0.03,0.06,0.08,0.11,0.13,0.16,0.19,0.21,0.23,0.39,0.83,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.88,0.31,0.23,0.19,0.16,0.13,0.09,0.07,0.04,0.01,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.19,0.24,0.87,1,1,1,1,0.61,0.22,0.17,0.17,0.23,0.65,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.58,0.22,0.2,0.23,0.68,1,1,1,1,1,1,1,1,0.58,0.22,0.18,0.13,0.08,0.04,0,0},
			{0,0,0,0,0,0,0.01,0.06,0.11,0.16,0.2,0.4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.25,0.2,0.16,0.17,0.22,0.52,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0.21,0.23,0.64,1,1,1,1,1,1,0.94,0.28,0.2,0.15,0.1,0.05,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.07,0.09,0.12,0.14,0.17,0.19,0.22,0.24,0.47,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.84,0.25,0.22,0.18,0.16,0.12,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0.06,0.1,0.15,0.2,0.29,0.97,1,1,1,1,0.72,0.23,0.18,0.17,0.22,0.52,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0.27,0.2,0.2,0.24,0.85,1,1,1,1,1,1,0.94,0.29,0.2,0.16,0.11,0.06,0.02,0,0},
			{0,0,0,0,0,0,0,0.06,0.1,0.16,0.2,0.33,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.53,0.22,0.18,0.14,0.18,0.23,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.28,0.2,0.23,0.71,1,1,1,1,1,1,0.99,0.35,0.2,0.16,0.1,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.07,0.09,0.12,0.14,0.17,0.2,0.22,0.24,0.59,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0.31,0.22,0.18,0.15,0.11,0.09,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.11,0.17,0.21,0.46,1,1,1,1,1,0.86,0.24,0.19,0.16,0.2,0.37,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.57,0.22,0.18,0.22,0.39,0.99,1,1,1,1,1,0.61,0.22,0.18,0.14,0.09,0.05,0,0,0},
			{0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.25,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.82,0.24,0.2,0.16,0.16,0.2,0.28,0.95,1,1,1,1,1,1,1,1,1,1,1,1,1,0.78,0.24,0.18,0.23,0.74,1,1,1,1,1,1,1,0.49,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.08,0.1,0.13,0.15,0.18,0.2,0.23,0.29,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.45,0.22,0.18,0.15,0.11,0.08,0.04,0.02,0,0,0,0,0,0,0,0,0,0,0,0.04,0.08,0.13,0.18,0.23,0.65,1,1,1,1,1,0.98,0.31,0.2,0.15,0.2,0.27,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0.24,0.2,0.19,0.23,0.57,1,1,1,1,0.89,0.25,0.2,0.16,0.11,0.07,0.02,0,0,0},
			{0,0,0,0,0,0,0,0.04,0.09,0.13,0.18,0.23,0.68,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.22,0.17,0.13,0.17,0.22,0.52,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.62,0.22,0.18,0.23,0.69,1,1,1,1,1,1,1,0.61,0.22,0.17,0.13,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.06,0.08,0.11,0.13,0.16,0.19,0.21,0.23,0.37,0.83,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.69,0.23,0.19,0.15,0.11,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.1,0.15,0.19,0.24,0.88,1,1,1,1,1,1,0.46,0.21,0.17,0.19,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,0.97,0.87,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.22,0.18,0.2,0.24,0.77,1,1,1,0.49,0.22,0.18,0.13,0.09,0.05,0,0,0,0},
			{0,0,0,0,0,0,0,0.02,0.07,0.12,0.17,0.2,0.39,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.76,0.23,0.19,0.15,0.14,0.18,0.23,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0.21,0.17,0.23,0.64,1,1,1,1,1,1,1,0.78,0.24,0.18,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.07,0.09,0.12,0.14,0.17,0.19,0.22,0.24,0.4,0.87,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.31,0.2,0.17,0.12,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.08,0.12,0.17,0.21,0.46,1,1,1,1,1,1,1,0.6,0.22,0.17,0.17,0.23,0.67,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0.24,0.56,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.87,0.24,0.2,0.17,0.21,0.31,0.92,1,0.72,0.23,0.2,0.15,0.11,0.07,0.02,0,0,0,0},
			{0,0,0,0,0,0,0,0,0.06,0.09,0.15,0.19,0.23,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.39,0.21,0.17,0.12,0.16,0.2,0.28,0.95,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.28,0.2,0.17,0.22,0.61,1,1,1,1,1,1,1,0.95,0.28,0.2,0.16,0.1,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.07,0.09,0.12,0.16,0.18,0.22,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.23,0.18,0.14,0.09,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.1,0.15,0.19,0.24,0.76,1,1,1,1,1,1,1,0.69,0.23,0.18,0.17,0.22,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,0.39,0.24,0.85,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.49,0.21,0.17,0.18,0.22,0.54,0.9,0.29,0.21,0.17,0.13,0.08,0.04,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0.03,0.08,0.12,0.17,0.2,0.27,0.87,1,1,1,1,1,1,1,1,1,1,1,1,1,0.67,0.23,0.19,0.14,0.12,0.17,0.22,0.53,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.78,0.24,0.18,0.17,0.21,0.51,1,1,1,1,1,1,1,1,0.53,0.22,0.17,0.12,0.08,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.07,0.09,0.13,0.16,0.19,0.23,0.34,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.31,0.2,0.17,0.11,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.09,0.13,0.17,0.22,0.43,1,1,1,1,1,1,1,1,0.82,0.24,0.19,0.16,0.21,0.41,1,1,1,1,1,1,1,1,1,1,1,1,1,0.71,0.23,0.46,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.71,0.23,0.18,0.16,0.2,0.27,0.29,0.22,0.18,0.14,0.09,0.06,0.01,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0.01,0.06,0.09,0.14,0.18,0.22,0.37,0.95,1,1,1,1,1,1,1,1,1,1,1,0.93,0.3,0.2,0.17,0.12,0.14,0.19,0.23,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.63,0.22,0.17,0.16,0.2,0.4,1,1,1,1,1,1,1,1,0.79,0.24,0.19,0.15,0.1,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.08,0.11,0.14,0.17,0.2,0.23,0.44,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.69,0.23,0.18,0.14,0.09,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.05,0.09,0.12,0.16,0.2,0.24,0.82,1,1,1,1,1,1,1,1,0.91,0.25,0.2,0.15,0.2,0.29,0.96,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.28,0.23,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.92,0.26,0.2,0.15,0.18,0.2,0.2,0.18,0.15,0.11,0.07,0.02,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0.02,0.07,0.11,0.15,0.19,0.23,0.37,0.95,1,1,1,1,1,1,1,1,1,1,0.56,0.22,0.18,0.14,0.11,0.16,0.2,0.32,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.15,0.2,0.29,0.96,1,1,1,1,1,1,1,1,0.43,0.21,0.17,0.13,0.09,0.05,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.06,0.09,0.12,0.15,0.18,0.21,0.23,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.36,0.2,0.17,0.13,0.1,0.07,0.04,0.01,0,0,0,0,0,0,0,0,0,0.02,0.05,0.08,0.12,0.16,0.19,0.23,0.62,1,1,1,1,1,1,1,1,1,0.97,0.29,0.2,0.15,0.19,0.24,0.85,1,1,1,1,1,1,1,1,1,1,1,1,1,0.56,0.22,0.36,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.35,0.2,0.16,0.14,0.15,0.15,0.14,0.11,0.08,0.04,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0.04,0.08,0.12,0.16,0.19,0.23,0.35,0.92,1,1,1,1,1,1,1,1,0.87,0.24,0.2,0.16,0.11,0.13,0.17,0.22,0.57,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.29,0.2,0.15,0.14,0.19,0.24,0.83,1,1,1,1,1,1,1,1,0.79,0.24,0.2,0.16,0.12,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.08,0.11,0.13,0.16,0.19,0.22,0.25,0.74,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.23,0.2,0.17,0.14,0.11,0.08,0.05,0.02,0,0,0,0,0,0,0,0.02,0.05,0.09,0.12,0.16,0.19,0.23,0.46,1,1,1,1,1,1,1,1,1,1,1,0.36,0.2,0.16,0.18,0.23,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,0.82,0.24,0.23,0.61,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.1,0.1,0.09,0.07,0.04,0.01,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0.01,0.05,0.08,0.12,0.16,0.18,0.22,0.29,0.8,1,1,1,1,1,1,1,0.49,0.22,0.18,0.13,0.09,0.14,0.19,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.24,0.19,0.14,0.13,0.17,0.23,0.65,1,1,1,1,1,1,1,1,1,0.51,0.23,0.19,0.15,0.11,0.08,0.04,0.02,0,0,0,0,0,0,0.01,0.03,0.05,0.07,0.09,0.12,0.15,0.18,0.2,0.23,0.39,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.24,0.21,0.18,0.16,0.12,0.09,0.07,0.04,0.01,0,0,0,0.02,0.04,0.07,0.09,0.12,0.16,0.19,0.23,0.37,0.95,1,1,1,1,1,1,1,1,1,1,1,0.4,0.2,0.16,0.17,0.22,0.61,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.41,0.21,0.24,0.87,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.48,0.21,0.17,0.11,0.06,0.06,0.04,0.03,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0.01,0.05,0.08,0.12,0.15,0.18,0.21,0.24,0.59,1,1,1,1,1,0.8,0.24,0.2,0.15,0.1,0.11,0.17,0.2,0.38,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.23,0.17,0.13,0.11,0.17,0.21,0.45,1,1,1,1,1,1,1,1,1,0.97,0.37,0.22,0.18,0.15,0.12,0.09,0.06,0.03,0.02,0.01,0.02,0.02,0.04,0.06,0.07,0.09,0.12,0.14,0.17,0.19,0.22,0.24,0.61,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.98,1,1,1,1,1,1,1,0.8,0.29,0.23,0.19,0.17,0.13,0.11,0.08,0.06,0.04,0.04,0.05,0.07,0.08,0.11,0.13,0.16,0.19,0.23,0.37,0.95,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.17,0.21,0.46,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.68,0.23,0.22,0.48,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.47,0.21,0.17,0.11,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.08,0.11,0.14,0.17,0.2,0.23,0.38,0.87,1,1,1,0.43,0.21,0.17,0.13,0.08,0.13,0.18,0.23,0.64,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.1,0.15,0.2,0.25,0.91,1,1,1,1,1,1,1,1,1,0.9,0.31,0.22,0.19,0.16,0.13,0.1,0.08,0.06,0.06,0.06,0.07,0.08,0.09,0.12,0.14,0.17,0.19,0.21,0.23,0.39,0.87,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.4,0.74,1,1,1,1,1,1,1,1,0.94,0.43,0.23,0.2,0.18,0.15,0.12,0.1,0.09,0.09,0.1,0.11,0.13,0.15,0.18,0.2,0.23,0.43,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,0.48,0.21,0.17,0.16,0.2,0.32,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,0.93,0.27,0.2,0.23,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.37,0.2,0.16,0.1,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.07,0.1,0.13,0.16,0.19,0.22,0.24,0.58,1,0.76,0.23,0.19,0.15,0.1,0.1,0.15,0.19,0.24,0.89,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.29,0.2,0.15,0.1,0.09,0.13,0.18,0.23,0.66,1,1,1,1,1,1,1,1,1,1,0.91,0.34,0.23,0.2,0.17,0.14,0.13,0.11,0.11,0.11,0.12,0.13,0.15,0.17,0.19,0.2,0.23,0.3,0.72,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0.23,0.44,1,1,1,1,1,1,1,1,1,1,0.65,0.24,0.22,0.19,0.17,0.15,0.14,0.14,0.15,0.17,0.18,0.2,0.22,0.24,0.61,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.47,0.21,0.17,0.14,0.19,0.24,0.89,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.22,0.21,0.38,0.99,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.28,0.2,0.15,0.1,0.05,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.09,0.12,0.15,0.18,0.2,0.23,0.36,0.35,0.21,0.17,0.12,0.08,0.12,0.17,0.21,0.46,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.24,0.19,0.14,0.09,0.07,0.11,0.17,0.2,0.38,1,1,1,1,1,1,1,1,1,1,1,0.98,0.5,0.24,0.21,0.19,0.17,0.17,0.16,0.17,0.17,0.18,0.2,0.21,0.23,0.31,0.65,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.44,0.23,0.19,0.23,0.7,1,1,1,1,1,1,1,1,1,1,0.88,0.39,0.23,0.21,0.2,0.19,0.19,0.2,0.21,0.22,0.24,0.48,0.88,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.41,0.21,0.16,0.13,0.18,0.23,0.74,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.24,0.19,0.23,0.63,1,1,1,1,1,1,1,1,1,1,1,1,0.72,0.23,0.18,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.08,0.1,0.13,0.16,0.19,0.2,0.2,0.18,0.14,0.1,0.09,0.14,0.18,0.23,0.7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.23,0.17,0.13,0.07,0.06,0.09,0.14,0.19,0.24,0.76,1,1,1,1,1,1,1,1,1,1,1,1,0.82,0.38,0.24,0.22,0.21,0.21,0.21,0.22,0.23,0.24,0.43,0.74,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.23,0.19,0.17,0.2,0.28,0.89,1,1,1,1,1,1,1,1,1,1,1,0.76,0.46,0.29,0.24,0.24,0.27,0.41,0.63,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.99,0.35,0.2,0.16,0.13,0.17,0.22,0.63,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.38,0.2,0.2,0.24,0.87,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.12,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.06,0.09,0.12,0.14,0.16,0.16,0.14,0.11,0.07,0.1,0.15,0.2,0.27,0.93,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.06,0.03,0.08,0.12,0.17,0.21,0.43,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.82,0.59,0.47,0.44,0.48,0.57,0.72,0.92,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.53,0.23,0.19,0.16,0.14,0.18,0.22,0.46,1,1,1,1,1,1,1,1,1,1,1,1,1,0.97,0.88,0.88,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.29,0.2,0.15,0.12,0.17,0.21,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.66,0.23,0.18,0.22,0.49,1,1,1,1,1,1,1,1,1,1,0.8,0.24,0.19,0.15,0.1,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.08,0.09,0.1,0.1,0.09,0.07,0.06,0.11,0.16,0.21,0.41,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.29,0.2,0.15,0.1,0.06,0.01,0.06,0.1,0.15,0.19,0.23,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.63,0.23,0.2,0.16,0.12,0.11,0.15,0.19,0.23,0.68,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.85,0.24,0.19,0.14,0.1,0.16,0.2,0.35,0.99,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0.26,0.2,0.2,0.24,0.78,1,1,1,1,1,1,1,1,1,0.43,0.21,0.17,0.13,0.08,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.04,0.06,0.06,0.04,0.03,0.07,0.12,0.17,0.22,0.61,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.24,0.19,0.14,0.09,0.04,0,0.04,0.08,0.12,0.17,0.21,0.38,0.99,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.77,0.24,0.2,0.17,0.13,0.09,0.08,0.12,0.17,0.2,0.27,0.9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.69,0.23,0.18,0.13,0.1,0.15,0.2,0.27,0.93,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.51,0.21,0.17,0.21,0.38,0.99,1,1,1,1,1,1,1,0.61,0.23,0.19,0.15,0.1,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.01,0,0.03,0.08,0.13,0.18,0.23,0.7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.23,0.17,0.13,0.07,0.03,0,0.01,0.06,0.1,0.14,0.19,0.23,0.61,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0.31,0.21,0.17,0.13,0.09,0.06,0.06,0.09,0.14,0.18,0.22,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.53,0.22,0.17,0.12,0.09,0.14,0.18,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.72,0.23,0.18,0.19,0.23,0.63,1,1,1,1,1,1,0.71,0.23,0.2,0.16,0.12,0.08,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.09,0.13,0.19,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.46,0.21,0.17,0.11,0.06,0.02,0,0,0.03,0.07,0.12,0.16,0.2,0.24,0.82,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.5,0.22,0.18,0.14,0.1,0.06,0.02,0.02,0.07,0.11,0.16,0.2,0.24,0.81,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.29,0.2,0.16,0.1,0.08,0.13,0.17,0.23,0.66,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.28,0.2,0.17,0.2,0.25,0.88,1,1,1,1,0.72,0.23,0.2,0.17,0.13,0.09,0.05,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.09,0.13,0.19,0.24,0.81,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.29,0.2,0.15,0.1,0.06,0,0,0,0,0.05,0.09,0.13,0.17,0.22,0.36,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.82,0.24,0.2,0.15,0.11,0.07,0.03,0,0,0.04,0.08,0.13,0.17,0.22,0.52,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.71,0.23,0.18,0.14,0.09,0.07,0.12,0.17,0.22,0.55,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.43,0.21,0.16,0.18,0.22,0.5,1,1,1,0.62,0.23,0.21,0.17,0.13,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.09,0.13,0.19,0.24,0.82,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.8,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0.02,0.06,0.1,0.14,0.19,0.23,0.5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.57,0.22,0.17,0.13,0.08,0.04,0,0,0,0.01,0.06,0.1,0.16,0.2,0.27,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.39,0.2,0.17,0.12,0.07,0.06,0.11,0.16,0.2,0.4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.6,0.22,0.17,0.15,0.2,0.24,0.83,1,0.43,0.23,0.2,0.17,0.14,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.09,0.13,0.18,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.65,0.23,0.17,0.13,0.07,0.03,0,0,0,0,0,0.03,0.07,0.12,0.16,0.2,0.23,0.63,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.54,0.22,0.17,0.13,0.09,0.06,0.02,0,0,0,0.04,0.09,0.14,0.18,0.24,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.66,0.23,0.19,0.15,0.09,0.06,0.05,0.1,0.15,0.2,0.29,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.68,0.23,0.17,0.13,0.17,0.22,0.33,0.31,0.23,0.19,0.16,0.13,0.09,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.08,0.13,0.17,0.23,0.68,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.5,0.21,0.17,0.12,0.06,0.02,0,0,0,0,0,0,0.04,0.09,0.13,0.17,0.2,0.23,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.78,0.24,0.2,0.16,0.13,0.09,0.06,0.03,0.01,0,0.02,0.07,0.13,0.17,0.23,0.65,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.83,0.24,0.2,0.17,0.12,0.08,0.03,0.04,0.09,0.14,0.19,0.24,0.84,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.75,0.23,0.18,0.13,0.14,0.18,0.2,0.2,0.19,0.16,0.12,0.09,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.12,0.17,0.22,0.52,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.31,0.2,0.15,0.1,0.06,0,0,0,0,0,0,0,0.02,0.06,0.09,0.13,0.17,0.2,0.23,0.75,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.55,0.23,0.2,0.17,0.13,0.1,0.08,0.06,0.02,0.02,0.08,0.13,0.17,0.23,0.67,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.9,0.31,0.22,0.17,0.13,0.09,0.06,0.01,0.02,0.08,0.13,0.17,0.23,0.68,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.81,0.24,0.19,0.13,0.11,0.14,0.16,0.16,0.14,0.12,0.09,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.06,0.1,0.16,0.2,0.27,0.92,1,1,1,1,1,1,1,1,1,1,1,1,0.83,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.13,0.17,0.21,0.23,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.52,0.23,0.2,0.18,0.15,0.12,0.09,0.07,0.05,0.09,0.14,0.18,0.24,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.85,0.3,0.22,0.18,0.14,0.1,0.06,0.02,0,0.02,0.07,0.12,0.17,0.22,0.6,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.76,0.23,0.18,0.13,0.08,0.09,0.1,0.1,0.09,0.08,0.05,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.18,0.22,0.61,1,1,1,1,1,1,1,1,1,1,1,1,0.65,0.23,0.17,0.13,0.08,0.03,0,0,0,0,0,0,0,0,0,0.02,0.06,0.1,0.14,0.17,0.21,0.23,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,0.83,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.65,0.24,0.22,0.19,0.17,0.14,0.11,0.09,0.1,0.15,0.2,0.26,0.92,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.64,0.24,0.22,0.18,0.15,0.11,0.08,0.03,0,0,0.01,0.06,0.11,0.16,0.21,0.43,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.69,0.23,0.18,0.13,0.08,0.04,0.06,0.06,0.04,0.03,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.11,0.16,0.2,0.24,0.84,1,1,1,1,1,1,1,1,1,1,1,0.5,0.21,0.17,0.12,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0.03,0.07,0.1,0.14,0.17,0.2,0.23,0.63,1,1,1,1,1,1,1,1,1,0.87,0.62,0.35,0.24,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.86,0.35,0.23,0.2,0.18,0.16,0.14,0.13,0.17,0.21,0.46,1,1,1,1,1,1,1,1,0.88,0.46,0.68,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,0.98,0.71,0.35,0.23,0.2,0.17,0.15,0.11,0.08,0.04,0.01,0,0,0,0.06,0.1,0.15,0.2,0.31,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.61,0.22,0.17,0.12,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.09,0.13,0.17,0.22,0.32,0.92,1,1,1,1,1,1,1,1,1,0.98,0.31,0.2,0.15,0.1,0.06,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.07,0.1,0.13,0.17,0.2,0.23,0.5,1,1,1,1,1,0.87,0.62,0.37,0.24,0.22,0.2,0.23,0.76,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.66,0.28,0.23,0.2,0.18,0.16,0.2,0.24,0.78,1,1,1,1,1,1,1,1,0.88,0.24,0.23,0.24,0.36,0.56,0.7,0.83,0.92,0.98,1,1,1,1,0.91,0.74,0.54,0.29,0.23,0.2,0.19,0.17,0.13,0.1,0.08,0.04,0.01,0,0,0,0,0.04,0.09,0.14,0.19,0.24,0.87,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.43,0.21,0.16,0.11,0.06,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.1,0.15,0.18,0.22,0.31,0.86,1,1,1,1,1,1,1,1,0.83,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.06,0.09,0.13,0.17,0.2,0.23,0.38,0.91,0.89,0.62,0.37,0.24,0.22,0.2,0.19,0.18,0.18,0.23,0.71,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.95,0.58,0.26,0.23,0.2,0.23,0.5,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.2,0.2,0.22,0.23,0.24,0.25,0.31,0.39,0.38,0.39,0.33,0.24,0.23,0.22,0.2,0.19,0.17,0.14,0.12,0.09,0.06,0.03,0.01,0,0,0,0,0,0.03,0.08,0.13,0.18,0.23,0.74,1,1,1,1,1,1,1,1,1,1,1,1,1,0.91,0.25,0.2,0.15,0.1,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.08,0.11,0.15,0.18,0.22,0.24,0.63,1,1,1,1,1,1,1,0.65,0.23,0.17,0.13,0.08,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.13,0.16,0.19,0.22,0.26,0.25,0.22,0.2,0.19,0.18,0.16,0.14,0.13,0.17,0.23,0.65,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.94,0.6,0.24,0.35,0.97,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.16,0.17,0.18,0.19,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.18,0.17,0.16,0.14,0.12,0.09,0.08,0.05,0.02,0,0,0,0,0,0,0,0.02,0.07,0.13,0.17,0.22,0.61,1,1,1,1,1,1,1,1,1,1,1,1,1,0.65,0.23,0.18,0.13,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.08,0.11,0.15,0.18,0.2,0.23,0.31,0.68,0.96,1,1,1,1,0.5,0.21,0.17,0.12,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.12,0.15,0.18,0.2,0.2,0.18,0.16,0.14,0.13,0.11,0.09,0.12,0.17,0.22,0.6,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.93,0.92,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.1,0.12,0.13,0.13,0.15,0.16,0.16,0.16,0.16,0.16,0.14,0.13,0.12,0.1,0.09,0.07,0.06,0.03,0.01,0,0,0,0,0,0,0,0,0.02,0.06,0.11,0.17,0.21,0.49,1,1,1,1,1,1,1,1,1,1,1,1,0.96,0.33,0.2,0.17,0.11,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.08,0.1,0.13,0.17,0.19,0.2,0.23,0.27,0.5,0.72,0.95,0.97,0.31,0.2,0.15,0.1,0.06,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.08,0.11,0.14,0.15,0.15,0.13,0.11,0.09,0.08,0.06,0.07,0.12,0.17,0.22,0.54,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.07,0.08,0.09,0.1,0.1,0.11,0.11,0.11,0.1,0.09,0.08,0.07,0.06,0.04,0.02,0.01,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.1,0.16,0.2,0.34,0.98,1,1,1,1,1,1,1,1,1,1,1,0.59,0.23,0.18,0.14,0.09,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.06,0.09,0.12,0.14,0.17,0.18,0.2,0.21,0.23,0.26,0.32,0.26,0.2,0.15,0.1,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.07,0.09,0.1,0.1,0.09,0.07,0.05,0.03,0.02,0.06,0.12,0.17,0.21,0.49,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0.03,0.04,0.05,0.06,0.06,0.06,0.06,0.06,0.04,0.03,0.02,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.26,0.92,1,1,1,1,1,1,1,1,1,1,0.8,0.24,0.2,0.16,0.11,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.05,0.08,0.09,0.12,0.14,0.15,0.17,0.18,0.2,0.2,0.2,0.18,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.05,0.05,0.04,0.02,0,0,0.01,0.06,0.11,0.16,0.21,0.43,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0.01,0.01,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.18,0.24,0.77,1,1,1,1,1,1,1,1,1,0.89,0.29,0.21,0.17,0.13,0.09,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.03,0.06,0.07,0.09,0.1,0.12,0.14,0.15,0.16,0.15,0.14,0.11,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.11,0.16,0.2,0.39,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.13,0.17,0.23,0.65,1,1,1,1,1,1,1,1,0.9,0.31,0.22,0.18,0.14,0.1,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.06,0.07,0.09,0.1,0.1,0.1,0.09,0.07,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.06,0.1,0.16,0.2,0.32,0.98,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.12,0.17,0.22,0.54,1,1,1,1,1,1,1,0.85,0.3,0.22,0.18,0.15,0.11,0.07,0.03,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.02,0.04,0.05,0.06,0.05,0.04,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.29,0.96,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.06,0.1,0.16,0.2,0.38,1,1,1,1,1,1,0.67,0.24,0.22,0.18,0.15,0.11,0.08,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.25,0.91,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.1,0.15,0.2,0.28,0.95,1,1,1,0.87,0.41,0.23,0.2,0.17,0.15,0.11,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.19,0.24,0.84,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.14,0.19,0.24,0.82,1,0.88,0.5,0.24,0.22,0.19,0.17,0.13,0.1,0.08,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.09,0.13,0.18,0.24,0.79,1,1,1,1,1,0.93,0.97,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.13,0.17,0.22,0.52,0.54,0.24,0.22,0.2,0.18,0.15,0.12,0.09,0.06,0.03,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.08,0.13,0.18,0.23,0.75,1,1,1,1,0.82,0.24,0.69,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.1,0.16,0.2,0.22,0.22,0.2,0.18,0.15,0.13,0.11,0.08,0.06,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.08,0.13,0.18,0.23,0.69,1,1,1,0.68,0.24,0.21,0.38,0.99,1,1,1,1,1,1,1,1,1,0.81,0.94,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.09,0.13,0.16,0.17,0.17,0.16,0.13,0.11,0.08,0.06,0.04,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.13,0.17,0.23,0.64,1,1,0.51,0.23,0.2,0.19,0.23,0.63,1,1,1,1,1,1,1,1,0.88,0.24,0.68,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.09,0.1,0.12,0.12,0.1,0.09,0.07,0.04,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.08,0.13,0.17,0.23,0.68,1,0.36,0.23,0.2,0.17,0.17,0.2,0.24,0.86,1,1,1,1,1,1,1,0.48,0.22,0.3,0.91,1,1,1,1,1,1,1,1,0.99,1,1,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.06,0.06,0.07,0.06,0.04,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.06,0.12,0.17,0.2,0.37,0.35,0.23,0.19,0.16,0.13,0.13,0.18,0.22,0.41,1,1,1,1,1,1,0.65,0.23,0.2,0.22,0.49,1,1,1,1,1,1,1,0.94,0.37,0.54,0.98,1,1,1,0.89,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.02,0.02,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.06,0.09,0.14,0.19,0.2,0.2,0.19,0.16,0.12,0.09,0.1,0.15,0.19,0.23,0.51,1,1,1,1,0.75,0.23,0.2,0.17,0.2,0.24,0.76,1,1,1,1,1,1,0.49,0.23,0.23,0.27,0.67,1,1,0.9,0.24,0.19,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.07,0.12,0.14,0.16,0.16,0.14,0.12,0.09,0.05,0.08,0.12,0.16,0.2,0.23,0.46,0.9,0.94,0.59,0.23,0.21,0.17,0.13,0.17,0.21,0.32,0.94,1,1,1,1,0.61,0.23,0.2,0.19,0.2,0.23,0.31,0.8,0.91,0.27,0.2,0.15,0.1,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.05,0.07,0.09,0.1,0.1,0.09,0.08,0.05,0.02,0.05,0.09,0.13,0.16,0.19,0.22,0.24,0.24,0.22,0.2,0.17,0.14,0.1,0.14,0.18,0.22,0.53,1,1,1,0.74,0.23,0.2,0.16,0.14,0.17,0.19,0.21,0.24,0.34,0.28,0.2,0.15,0.1,0.05,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.03,0.05,0.06,0.06,0.04,0.03,0.01,0,0.02,0.06,0.09,0.12,0.15,0.18,0.19,0.2,0.18,0.16,0.13,0.09,0.07,0.11,0.16,0.2,0.24,0.79,1,0.86,0.25,0.21,0.17,0.13,0.09,0.12,0.14,0.17,0.18,0.2,0.2,0.18,0.14,0.09,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.01,0,0,0,0,0,0.02,0.05,0.08,0.11,0.13,0.14,0.14,0.13,0.11,0.09,0.06,0.04,0.09,0.13,0.17,0.21,0.4,0.9,0.39,0.22,0.18,0.14,0.09,0.06,0.08,0.1,0.13,0.14,0.16,0.15,0.14,0.11,0.07,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0.04,0.07,0.08,0.09,0.09,0.08,0.07,0.05,0.02,0.02,0.06,0.1,0.15,0.2,0.27,0.39,0.26,0.2,0.15,0.11,0.07,0.02,0.03,0.06,0.07,0.09,0.1,0.1,0.09,0.07,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.03,0.04,0.05,0.03,0.02,0,0,0,0.04,0.09,0.14,0.18,0.2,0.2,0.2,0.18,0.14,0.09,0.04,0,0,0.01,0.03,0.04,0.06,0.05,0.04,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.07,0.11,0.14,0.15,0.16,0.15,0.14,0.11,0.07,0.02,0,0,0,0,0,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.04,0.07,0.09,0.1,0.11,0.1,0.09,0.07,0.04,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.04,0.05,0.06,0.05,0.04,0.02,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
		}
	}



	-- ui extras, frametimes, frames per second, playtime, nc time
	CORE.UI = {
		FTS={Current=0,Previous=0,Difference=0,Length=64,History={}},
		FPS={Current=0,Previous=0,Difference=0,Length=15,History={}},
		TAG={Playtime=0,NightCity={Hour=0,Minute=0}}
	}

	-- return
	return o
end

-- return
return CORE