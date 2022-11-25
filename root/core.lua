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
		UTIL:Prelude(CORE.Project, CORE.Version, CORE.Scaling, CORE.isDebug)
		DRAW:Prelude(CORE.Project, CORE.Version, CORE.Scaling, CORE.isDebug)

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





end

--
--// CORE:Interface()
--
function CORE:Interface()

	-- debug id
	local __func__ = "CORE:Interface"

	-- run cronjobs
	CORE:Cronjobs()

	-- start window
	local _trigger = DRAW:WindowStart()
	if _trigger
	then
		-- always update
		CORE:UpdateScale()

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
					local bottom = UTIL:ScaleSwitch(116)

					-- add more if graph is enabled
					if CORE.Extras["DeveloperExtras/Graph/Enable"]
					and not CORE.Extras["DeveloperExtras/Graph/Overlay/Enable"]
					then
						bottom = UTIL:ScaleSwitch(371)
					end

					-- start tabchild
					local _trigger = DRAW:TabchildStart(CORE.Scaling.Window.Width, CORE.Scaling.Window.Height - bottom, CORE.Extras["DeveloperExtras/Scrollbar/Enable"])
					if _trigger
					then
						-- page render
						if pool == "About" or pool == "Stash"
						then
							-- about tab
							if pool == "About"
							then
								local _trigger = DRAW:About()
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
											DRAW:CollapseNotice("Toggle's are disabled, because you are not in Night City yet.")
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


		DRAW:Separator(1,0,0,"Orange")


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
				--CORE:RenderSlider(pool, option, render, demand)
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
		else
			-- something is wrong
			if CORE.isDebug then
				--DRAW.CollapseNotice(ImGui.GetWindowWidth(), "BROKEN ELEMENT: "..render.path)
			end
		end
	elseif render.separator
	then
		DRAW:Spacer(1,UTIL:ScaleSwitch(10))
		DRAW:Separator(UTIL:ScaleSwitch(render.separator))
		DRAW:Spacer(1,UTIL:ScaleSwitch(10))
	elseif render.spacing
	then
		DRAW:Spacer(1,UTIL:ScaleSwitch(render.spacing))
	else
		-- something is wrong
		if CORE.isDebug then
			DRAW.CollapseNotice(ImGui.GetWindowWidth(), "BROKEN ELEMENT (no path)")
		end
	end
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
	return demand
end

--
--// CORE:RenderSlider()
--
function CORE:RenderSlider(pool, option, render, demand)

	-- debug id
	local __func__ = "CORE:RenderSlider"

	-- get current
	local value = CORE:GetToggle(render.path, option.type)

	-- render prepare
	if render.spacing
	then
		DRAW:Spacing(render.spacing * CORE.Scaling.Window.Factor.Width,1)
		DRAW:SliderTitle(render.name, option.min, option.max, demand)

		-- render info
		if render.note or render.rate
		then
			DRAW:ButtonNotes(render, "?", demand)
		else
			DRAW:Sameline()
			DRAW:Spacer(1,15)
		end

		DRAW:Spacer(1,3 * CORE.Scaling)
		DRAW:Spacing((render.spacing + 8) * CORE.Scaling.Window.Factor.Width,1)
		ImGui.SetNextItemWidth(ImGui.GetWindowWidth() - render.spacing - (95 * CORE.Scaling.Window.Factor.Width))
	else
		DRAW:Spacing(14 * CORE.Scaling.Window.Factor.Width,1)
		DRAW:SliderTitle(render.name, option.min, option.max, demand)

		-- render info
		if render.note or render.rate
		then
			DRAW:ButtonNotes(render, "?", demand)
		else
			DRAW:Sameline()
			DRAW:Spacer(1,8 * CORE.Scaling.Window.Factor.Width)
		end

		DRAW:Spacer(1,3 * CORE.Scaling.Window.Factor.Width)
		DRAW:Spacing((14 + 15) * CORE.Scaling.Window.Factor.Width,1)
		ImGui.SetNextItemWidth(ImGui.GetWindowWidth() - (14 * CORE.Scaling.Window.Factor.Width) - 95)
	end

	-- create slider
	local value, trigger = DRAW:Slider(render, option, demand, value)
	if trigger
	then

		CORE:SetToggle(render.path, option.type, value)

		-- needs to be enabled
		--if _state == "enabled"
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
		DRAW:Spacing(4 * CORE.Scaling.Window.Factor.Width,1)
		DRAW:Sameline()

		local trigger = DRAW:Button(render, option, demand, "Reset", "Reset")
		if trigger
		then


		end
	end

	-- has list
	if option.list
	then
		DRAW:Spacer(5,5)

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
			ImGui.SetWindowFontScale(1.35)
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
function CORE:RenderCheckbox(pool, option, render, demand)

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
		CORE:DebugConsole(__func__,"failed to parse "..tostring(file))
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

	-- ui toggles
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
--// CORE:TabOrder
--
function CORE:TabOrder()
	local list = {"Graphics","Features","Settings","About"}
	if CORE.isStash then table.insert(list, "Stash") end

	--if _experimental then table.insert(_list, "Experimental") end
	--table.insert(_list, "Experimental")

	return list
end


--
--// CORE:UpdateScale()
--
function CORE:UpdateScale()

	-- update screen
	CORE.Scaling.Screen.Width, CORE.Scaling.Screen.Height = GetDisplayResolution()

	-- update screen factor
	if CORE.Scaling.Enable
	then
		-- we use the screen height to keep the aspect ratio
		CORE.Scaling.Screen.Factor = UTIL:ShortenFloat((CORE.Scaling.Screen.Height / 9 * 16) / 1920)
	end

	-- update window
	CORE.Scaling.Window.Width = ImGui.GetWindowWidth()
	CORE.Scaling.Window.Height = ImGui.GetWindowHeight()

	-- update window factor
	CORE.Scaling.Window.Factor = UTIL:ShortenFloat(CORE.Scaling.Window.Width / 456)

	-- distribute to all
	DRAW.Scaling = CORE.Scaling
	UTIL.Scaling = CORE.Scaling
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
function CORE:Prelude()
	local o = {}
	setmetatable(o, self)
	self.__index = self

	-- identity
	CORE.Project = "Developer Extras"
	CORE.Authors = "FreakaZ"
	CORE.Version = {String="3.0.161",Numeric=30161,Cet={String=nil,Numeric=0},Game={String=nil,Numeric=0}}
	CORE.Scaling = {Enable=false,Screen={Width=1920,Height=1080,Factor=1},Window={Width=456,Height=600,Factor=1},Font=1.38}
	CORE.Timings = {Frame=0,Second=0,Millisecond=0}

	-- new form
	CORE.Trigger = {Saving=0,Export=0,Redraw=0}

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
	CORE.isStash = false

	CORE.isSaving = 0
	CORE.isExport = 0
	CORE.isRedraw = 0

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