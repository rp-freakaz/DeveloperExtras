





--
--// Core.Interface()
--
function CORE.Interface()

	-- debug id
	local _DI = "CORE.Interface"

	local _frame = 0

	-- update timings
	if isGraph ~= true
	then
		CORE.Cronjobs()
	end

	-- begin window
	local _trigger = DRAW.BeginWindow()
	if _trigger
	then
		-- begin tabbar
		local _trigger = DRAW.BeginTabbar()
		if _trigger
		then
			-- draw list
			local _list = {"Graphics","Features"}

			-- start pool loop
			for _,_pool in pairs(_list)
			do
				-- begin tabitem
				local _trigger = DRAW.BeginTabitem(_pool)
				if _trigger
				then

					local _added = 0

					if CORE.isGraph == true
					then
						_added = 120
					end


					-- begin tabchild
					local _trigger = DRAW.BeginTabchild(ImGui.GetWindowWidth(), ImGui.GetWindowHeight() - 116 - _added, false)
					if _trigger
					then
						-- start child loop
						for _,_loop in pairs(POOL.Render[_pool])
						do
							-- no regular render
							if _pool ~= "Settings"
							then

								-- begin collapse
								local _trigger = DRAW.BeginCollapse(_loop.name)
								if _trigger
								then

									-- show tab notice
									if SELF.PreGame()
									then
										DRAW.CollapseNotice(ImGui.GetWindowWidth(), "Toggle's are disabled, because you are not in Night City yet.")
									end

									-- some top room
									DRAW.Spacing(1, 6)

									-- start option loop
									for _,entry in pairs(_loop.list)
									do
										-- spacing
										if entry.type == "spacing"
										then
											DRAW.Spacing(1, 6)
										end

										-- separator
										if entry.type == "separator"
										then
											if entry.size == "large"
											then
												DRAW.Separator(5,5,5)
											else
												DRAW.Separator(1,5,5)
											end
										end

										-- slider types
										if entry.type == "int"
										or entry.type == "Int"
										or entry.type == "float"
										or entry.type == "Float"
										then
											--Self.Slider(ePool, eType, ePath, eName, eFlag)
										end

										-- checkbox types
										if entry.type == "bool"
										or entry.type == "Bool"
										then
											SELF.Checkbox(_pool, entry)
										end

										-- start buttonlist types
										if entry.type == "IntList"
										or entry.type == "NameList"
										or entry.type == "StringList"
										then
											SELF.Buttonlist(_pool, entry)
										end
									end

									-- some bottom room
									DRAW.Spacing(1, 7)
								end
							else
									-- some top room
									--Draw.Spacing(1, 6)

									-- start option loop
									--for _,Entry in pairs(tabItem.Class)
									--do
										-- call renderer
										--Self.Renderer(tabPool, Entry.Type, Entry.Path, Entry.Name, Entry.Flag)
									--end

									-- some bottom room
									--Draw.Spacing(1, 7)
							end

						-- end child loop
						end

					-- close tabchild
					DRAW.CloseTabchild()
					end
				-- close tabitem
				DRAW.CloseTabitem()
				end
			-- end pool loop
			end
		end
		-- close tabbar
		DRAW.CloseTabbar()




		--DRAW.Graph(PAST,UTIL.TableLength(PAST), UTIL.ShortenFloat(Good.FastL))



	-- close window
	end

	-- close window
	DRAW.CloseWindow()
end






--
--// SELF.Checkbox()
--
function SELF.Checkbox(_pool, _entry)

	-- set for debug messages
	local _DI = "SELF:Checkbox"

	-- get current
	local _value = SELF.GetToggle(_pool, _entry)

	-- define state
	local _state = "enabled"
	local _cause = ""

	-- check requirements
	if SELF.PreGame()
	then
		_state = "disabled"
	elseif _entry.gmin ~= nil
	then
		if _entry.gmin > SELF.gNumeric
		then
			_state = "disabled"
			_cause = "Not supported in this Version of the Game."
		end
	elseif _entry.need == "Photomode" and CORE.isPhoto == false
	then
		_state = "disabled"
		_cause = "Requires Photomode"
	end









	-- special type of bool
	if _entry.type == 'Bool' and _entry.show == true
	then



	-- regular type of bool
	else
		-- render prepare
		if _entry.spacing then
			DRAW.Spacer(_entry.spacing,1)
		elseif _entry.sameline then
			DRAW.Sameline()
			DRAW.Spacer(_entry.sameline,1)
		else
			DRAW.Spacer(10,1)
		end

		local _value, _trigger = DRAW.Checkbox(_entry, _value, _state, _cause)
		if _trigger
		then
			-- needs to be enabled
			if _state == "enabled"
			then


			--Self.SetToggle(ePool, eType, ePath, eFlag, cValue)

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




		--if ePath == 'DeveloperExtras/BoolTrue'
		--or ePath == 'DeveloperExtras/BoolFalse'
		--then
		--	Draw.Sameline(6)
		--	Draw.BlindButton('grey','normal','(can\'t be toggled)')
		--end

		--if eFlag.Note then
		--	Draw.Sameline(6)
		--	Draw.BlindButton('grey','normal','('..tostring(eFlag.Note)..')')
		--end
	end
--// SELF.Checkbox()
end





--
--// SELF.Buttonlist()
--
function SELF.Buttonlist(_pool, _entry)

	-- set for debug messages
	local _DI = "SELF:Buttonlist"

	-- get current
	local _value = SELF.GetToggle(_pool, _entry)

	-- define state
	local _state = "enabled"
	local _cause = ""

	-- check requirements
	if SELF.PreGame()
	then
		_state = "disabled"
	elseif _entry.gmin ~= nil
	then
		if _entry.gmin > SELF.gNumeric
		then
			_state = "disabled"
			_cause = "Not supported in this Version of the Game."
		end
	elseif _entry.need == "Photomode" and CORE.isPhoto == false
	then
		_state = "disabled"
		_cause = "Requires Photomode"
	end


	-- begin child
	if _entry.both ~= nil then
		if _entry.both > 0 then
			DRAW.Sameline()
		end
		ImGui.BeginChild('DE_ListChild'..tostring(_entry.path), (ImGui.GetWindowWidth() / 2 - 16), 42, false, ImGuiWindowFlags.NoScrollbar)
	end


	-- render prepare
	if _entry.spacing then
		DRAW.Spacer(_entry.spacing,1)
		DRAW.ListTitle(_entry.name, _entry.min, _entry.max, _state, _cause)
		DRAW.Spacing(1,2)
		DRAW.Spacer(_entry.spacing + 15,1)
	else
		DRAW.Spacer(28,1)
		DRAW.ListTitle(_entry.name, _entry.min, _entry.max, _state, _cause)
		DRAW.Spacing(1,2)
		DRAW.Spacer(28+15,1)
	end

	-- start loop of options
	for _,_option in pairs(POOL.System[_entry.path]["option"])
	do
		-- create button
		local _trigger = DRAW.ListEntry(_entry.type, _entry.path, _option, _value, _state, _cause)
		if _trigger
		then
			-- needs to be enabled
			if _state == "enabled"
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

		DRAW.Sameline(5)
	end

	DRAW.Spacing(1, 0) -- clear sameline

	-- close child
	if _entry.both
	then
		ImGui.EndChild()
	else
		DRAW.Spacing(1, 6)
	end

--// SELF.Buttonlist()
end

















--
--// SELF.Cronjobs()
--
function CORE.Cronjobs()

	-- update frame count
	SELF.isFrame = ImGui.GetFrameCount()

	-- only if graph
	if isGraph == true
	then
		-- use milliseconds timer
		local _timings = UTIL.GetMilliseconds()

		if SELF.Records["msTime"] ~= _timings
		then
			-- get differende
			SELF.Records["msLast"] = _timings - SELF.Records["msTime"]

			-- update core timer
			SELF.Records["msTime"] = _timings
		end
	end

	-- use seconds timer
	local _timings = UTIL.GetSeconds()

	if SELF.isTimer ~= _timings
	then
		-- update core timer
		SELF.isTimer = _timings

		-- update block time
		--SELF.Blocking = timer

		-- update game time

		-- update city time
		if SELF.PreGame()
		then
			if SELF.gNumeric > 11 -- (doesn't exist pre 1.2)
			then

		--Good.TimeH = Game.GetTimeSystem():GetGameTime():Hours()
		--Good.TimeM = Game.GetTimeSystem():GetGameTime():Minutes()



		-- update current frame
		Good.FrameC = SELF.isFrame

		-- update last frame if zero
		if Good.FrameL == 0
		then
			Good.FrameL = SELF.isFrame
		end


		-- calculate frames
		if Good.FrameC > Good.FrameL
		then
			local diffFrame = Good.FrameC - Good.FrameL

			-- update last frame
			Good.FrameL = Good.FrameC

			-- set display frame
			Good.FrameD = diffFrame
		end


		if Good.FrameD > 0
		then
			table.insert(PAST, Good.FrameD)
		else
			table.insert(PAST, 0)
		end

		if UTIL.TableLength(PAST) > 15
		then
			table.remove(PAST,1)
		end



	end



	-- use milliseconds timer
	local _milliseconds = UTIL.GetMilliseconds()

	if Good.FastT ~= _milliseconds
	then
		-- get differende
		Good.FastL = UTIL.GetMilliseconds2() - Good.FastT

		-- update core timer
		Good.FastT = UTIL.ShortenFloat2(tostring(UTIL.GetMilliseconds2()))

		--print(UTIL.DebugDump(UTIL.ShortenFloat(Good.FastL)))

	end

	--UTIL.GetMilliseconds()



		--print(UTIL.DebugDump(UTIL.GetMilliseconds()))

	-- force delayed redraw
	--if Self.reDelay == Self.isFrame
	--then
		-- reset delay
	--	Self.reDelay = 0

		-- call redraw
	--	Self.ForceRedraw()
	--end
--// Self.Cronjobs()
end







--
--// SELF.Cronjobs()
--
function CORE.Cronjs()

	-- update frame count
	SELF.isFrame = ImGui.GetFrameCount()

	-- use seconds timer
	local timer = UTIL.GetSeconds()

	if SELF.isTimer ~= timer
	then
		-- update core timer
		SELF.isTimer = timer

		-- update block time
		--SELF.Blocking = timer

		-- update game time
		--Good.TimeH = Game.GetTimeSystem():GetGameTime():Hours()
		--Good.TimeM = Game.GetTimeSystem():GetGameTime():Minutes()



		-- update current frame
		Good.FrameC = SELF.isFrame

		-- update last frame if zero
		if Good.FrameL == 0
		then
			Good.FrameL = SELF.isFrame
		end


		-- calculate frames
		if Good.FrameC > Good.FrameL
		then
			local diffFrame = Good.FrameC - Good.FrameL

			-- update last frame
			Good.FrameL = Good.FrameC

			-- set display frame
			Good.FrameD = diffFrame
		end

		if Good.FrameD > 0
		then
			table.insert(PAST, Good.FrameD)
		else
			table.insert(PAST, 0)
		end

		if UTIL.TableLength(PAST) > 15
		then
			table.remove(PAST,1)
		end

	end

end



































--
--// SELF.GetToggle(<POOL>,<TYPE>,<PATH>)
--
function SELF.GetToggle(pool, unit)

	-- split first
	local _root, _name = UTIL.SplitPath(unit.path)

	-- DevEx Internal
	if UTIL.IsInternal(unit.path)
	then
		return SELF.GetInternal(unit.path)
	else
		-- int
		if unit.type == 'int' then
			return GameOptions.GetInt(_root, _name)
		end

		-- bool
		if unit.type == 'bool' then
			return GameOptions.GetBool(_root, _name)
		end

		-- float
		if unit.type == 'float' then
			return GameOptions.GetFloat(_root, _name)
		end

		-- system int
		if unit.type == 'Int' or unit.type == 'IntList' then
			local exist = Game.GetSettingsSystem():HasVar('/'.._root, _name)
			if exist then
				local system = Game.GetSettingsSystem():GetVar('/'.._root, _name)
				return system:GetValue()
			end
		end

		-- system bool
		if unit.type == 'Bool' then
			local exist = Game.GetSettingsSystem():HasVar('/'.._root, _name)
			if exist then
				local system = Game.GetSettingsSystem():GetVar('/'.._root, _name)
				return system:GetValue()
			end
		end

		-- system name
		if unit.type == 'NameList' then
			local exist = Game.GetSettingsSystem():HasVar('/'.._root, _name)
			if exist then
				local system = Game.GetSettingsSystem():GetVar('/'.._root, _name)
				return Game.NameToString(system:GetValue())
			end
		end

		-- system string
		if unit.type == 'StringList' then
			local exist = Game.GetSettingsSystem():HasVar('/'.._root, _name)
			if exist then
				local system = Game.GetSettingsSystem():GetVar('/'.._root, _name)
				return system:GetValue()
			end
		end
	end
end








--
--// SELF.GetInternal()
--
function SELF.GetInternal(ePath)

	-- always true & false
	if ePath == 'DeveloperExtras/BoolTrue' then
		return true
	end
	if ePath == 'DeveloperExtras/BoolFalse' then
		return false
	end

	-- game time system
	if ePath == 'DeveloperExtras/GameTimeHour' then
		return Game.GetTimeSystem():GetGameTime():Hours()
	end
	if ePath == 'DeveloperExtras/GameTimeMinute' then
		return Game.GetTimeSystem():GetGameTime():Minutes()
	end

	-- time dilation
	if ePath == 'DeveloperExtras/TimeTickPlayer' then
		return Pool.Extras[ePath]
	end
	if ePath == 'DeveloperExtras/TimeTickWorld' then
		return Pool.Extras[ePath]
	end

	-- settings
	if ePath == 'DeveloperExtras/EnableScrollbar'
	or ePath == 'DeveloperExtras/ShowExperimental'
	or ePath == 'DeveloperExtras/ExportExperimental'
	then
		return Pool.Extras[ePath]
	end
--// Self.GetInternal()
end









































--
--// SELF.BootOption(<POOL>,<UNIT>)
--
function SELF.BootOption(pool,unit)

	-- debug id
	local _DI = "SELF.BootOption"

	-- get current value
	local _value = SELF.GetToggle(pool,unit)

	-- needs to have something
	if _value ~= nil
	then
		if UTIL.IsNotInternal(unit.path)
		then
			if POOL.Option[unit.path] == nil
			then
				-- check default flag
				if unit.def ~= nil
				then
					if unit.type == 'float'
					then
						if UTIL.ShortenFloat(_value) ~= UTIL.ShortenFloat(unit.def)
						then
							POOL.Option[unit.path] = UTIL.ShortenFloat(_value)
							DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Registered (different default) '..tostring(unit.path))
						else
							POOL.Option[unit.path] = UTIL.ShortenFloat(unit.def)
							DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Registered: '..tostring(unit.path))
						end
					else
						POOL.Option[unit.path] = _value
						DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Registered (different default) '..tostring(unit.path))
					end
				else
					if unit.type == 'float'
					then
						POOL.Option[unit.path] = UTIL.ShortenFloat(_value)
					else
						POOL.Option[unit.path] = _value
					end

					DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Registered: '..tostring(unit.path))
				end
			else
				DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Already Registered: '..tostring(unit.path))
			end
		else
			DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Not Registered '..tostring(unit.path))
		end
	else
		DebugConsole(_DI, 'Failed: '..tostring(pool)..' - Path:'..tostring(unit.path)..' - Data:'..tostring(_value))
	end
--// SELF.BootOption
end

--
--// SELF.BootSystem(<POOL>,<UNIT>)
--
function SELF.BootSystem(pool,unit)

	-- debug id
	local _DI = "SELF.BootSystem"

	-- split first
	local _root, _name = UTIL.SplitPath(unit.path)

	-- proceed if exist
	if Game.GetSettingsSystem():HasVar('/'.._root, _name)
	then
		if POOL.System[unit.path] == nil
		then
			-- loop over lists
			if unit.type == 'IntList'
			or unit.type == 'NameList'
			or unit.type == 'StringList'
			then
				-- get system identifier
				local system = Game.GetSettingsSystem():GetVar('/'.._root, _name)

				-- get all options
				local option = system:GetValues()

				-- something is needed
				if option ~= nil
				then
					-- option list
					POOL.System[unit.path] = {}
					POOL.System[unit.path]['option'] = {}

					-- loop over them
					for _,value in pairs(option)
					do
						-- convert name value
						if unit.type == 'NameList'
						then
							value = Game.NameToString(value)
						end

						-- register if it has an off option
						if value == 'Off' and _name ~= 'DLSS'
						then
							POOL.System[unit.path]['hasoff'] = value
						end

						-- keep OFF in DLSS and RT Light ;-)
						if value ~= 'Off' and value ~= 'Auto'
						or value == 'Off' and _name == 'DLSS'
						or value == 'Off' and _name == 'RayTracedLighting'
						then
							-- first option is usally the lowest setting
							if POOL.System[unit.path]['lowest'] == nil and _name ~= 'DLSS'
							then
								POOL.System[unit.path]['lowest'] = value
							else
								-- last option is usally the highest setting
								if _name ~= 'DLSS'
								then
									POOL.System[unit.path]['highest'] = value
								end
							end

							-- insert option into list
							table.insert(POOL.System[unit.path]['option'], value)
						end
					end
					DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Registered: '..tostring(unit.path))
				else
					DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Failed to Register (empty options): '..tostring(unit.path))
				end
			end

			-- bools just flat
			if unit.type == 'Bool'
			then
				-- option list
				POOL.System[unit.path] = {}
				POOL.System[unit.path]['option'] = {}

				-- manually set lowest and list
				POOL.System[unit.path]['lowest'] = false
				POOL.System[unit.path]['highest'] = true

				-- insert option into list
				table.insert(POOL.System[unit.path]['option'], false)
				table.insert(POOL.System[unit.path]['option'], true)

				DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Registered: '..tostring(unit.path))
			end

			-- floats usally have min/max
			if unit.type == 'Int'
			or unit.type == 'Float'
			then
				-- get system identifier
				local system = Game.GetSettingsSystem():GetVar('/'.._root, _name)

				local min = system:GetMinValue()
				local max = system:GetMaxValue()

				if min ~= nil and max ~= nil
				then
					POOL.System[unit.path] = {}
					POOL.System[unit.path]['lowest'] = min
					POOL.System[unit.path]['highest'] = max

					DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Registered: '..tostring(unit.path))
				else
					DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Failed to Register (empty options): '..tostring(unit.path))
				end
			end
		else
			DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Already Registered: '..tostring(unit.path))
		end
	else
		DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Failed to Register (unknown): '..tostring(unit.path))
	end
--// SELF.BootSystem
end






