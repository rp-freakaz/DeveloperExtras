--
-- Developer Extras v3
-- 2022 by FreakaZ
--

-- required
local UTIL = {}

-- pool:exposed
local POOL = {}

-- pool:internal
local SELF = {
	Render = {},	-- render definition
	Record = {},	-- internal records
	Option = {},	-- option definition
	Extras = {},	--
	Export = {},	-- export table
}

-- pool:internal
local Project = nil
local Version = nil
local _DEBUG = false
local _GAME = nil
local _CET = nil

--
-- record handling
--

-- get record
function POOL.GetRecord(_key)
	return SELF.Record[_key]
end

-- set record
function POOL.SetRecord(_key, _set)
	SELF.Record[_key] = _set
end

-- loads records.json
function POOL.LoadRecord()

	-- debug id
	local _DI = "POOL:LoadRecord"

	-- define
	local rows = 0
	local data = nil
	local exit = false

	-- load & convert
	exit, data = UTIL.LoadJson("data/_records.json")

	-- validate
	if exit
	then
		-- loop records
		for _key,_set in pairs(data)
		do
			-- increase
			rows = rows + 1

			-- assign record
			SELF.Record[_key] = _set
		end

		-- update myself
		POOL.SetRecord("init/records/loaded", rows)
	else
		-- debug msg
		SELF.DebugConsole(_DI,"failed to parse _records.json")
	end

	-- result
	return exit
end

-- loads options.json
function POOL.LoadOption()

	-- debug id
	local _DI = "POOL:LoadOption"

	-- define
	local rows = 0
	local data = nil
	local exit = false

	-- load & convert
	exit, data = UTIL.LoadJson("data/_options.json")

	-- validate
	if exit
	then
		-- loop records
		for _key,_set in pairs(data)
		do
			-- increase
			rows = rows + 1

			--print(_key)
			--print(DebugDump(_key))
			--print(DebugDump(_set))

			-- call parser
			SELF.BootOption(_key, _set)




		end

		-- update myself
		POOL.SetRecord("init/options/loaded", rows)
	else
		-- debug msg
		SELF.DebugConsole(_DI,"failed to parse _options.json")
	end

	-- result
	return exit
end


















--
--// SELF.BootOption(<PATH>,<ATTRIBUTES>)
--
function SELF.BootOption(_path, _attr)

	-- debug id
	local _DI = "SELF.BootOption"

	-- does not exist in pool
	if POOL.HasNotOption(_path)
	then

		-- _entry

		-- .is		true, false (enabled or not)
		-- .type	entry type
		-- .draw	redraw delay

		-- .def		default value (original or ini)
		-- .old		default value (original)
		-- .cur		current value
		-- .opt		options list
		-- .min		minimum value
		-- .max		maximum value
		-- .cet		min, max cet version


		-- prepare
		local _entry = {}

		-- set type
		_entry.type = _attr.type

		-- set defaults
		_entry.is = false

		-- all versions
		if _attr.any ~= nil
		then
			-- set default
			if _attr.any["def"] ~= nil then
				_entry.def = _attr.any["def"]
			end

			-- int/float min
			if _attr.any["min"] ~= nil then
				_entry.min = _attr.any["min"]
			end

			-- int/float min
			if _attr.any["max"] ~= nil then
				_entry.max = _attr.any["max"]
			end
		end

		-- specific version
		if _attr[tostring(POOL.GetRecord("versions/game/numeric"))] ~= nil
		then
			-- set default
			if _attr[tostring(POOL.GetRecord("versions/game/numeric"))]["def"] ~= nil then
				_entry.def = _attr[tostring(POOL.GetRecord("versions/game/numeric"))]["def"]
			end

			-- int/float min
			if _attr[tostring(POOL.GetRecord("versions/game/numeric"))]["min"] ~= nil then
				_entry.min = _attr[tostring(POOL.GetRecord("versions/game/numeric"))]["min"]
			end

			-- int/float min
			if _attr[tostring(POOL.GetRecord("versions/game/numeric"))]["max"] ~= nil then
				_entry.max = _attr[tostring(POOL.GetRecord("versions/game/numeric"))]["max"]
			end
		end

		-- has ontrue
		if _attr.ontrue ~= nil then
			_entry.ontrue = _attr.ontrue
		end

		-- has onfalse
		if _attr.onfalse ~= nil then
			_entry.onfalse = _attr.onfalse
		end

		-- cet version
		if _attr.cet ~= nil then
			_entry.cet = _attr.cet
		end

		-- redraw delay
		if _attr.draw ~= nil then
			_entry.draw = _attr.draw
		end

		-- get group + option
		local _group, _option = UTIL.SplitPath(_path)


		-- DevEx Internal
		if POOL.IsInternal(_path)
		then
		end




		-- option
		if POOL.IsNotInternal(_path) and (_entry.type == "int" or _entry.type == "bool" or _entry.type == "float")
		then
			-- exist here (like an .Has)
			if GameOptions.Get(_group, _option) ~= ""
			then
				-- get current value
				local _value = POOL.GetToggle(_path, _attr.type)

				-- set enabled
				_entry.is = true

				-- check default flag
				if _entry.def ~= nil
				then
					if _entry.type == "float"
					then
						if UTIL.ShortenFloat(_value) ~= UTIL.ShortenFloat(_entry.def)
						then
							-- set current
							_entry.cur = UTIL.ShortenFloat(_value)

							-- set different default
							_entry.old = _entry.def
							_entry.def = _entry.cur

							-- set enabled option
							POOL.SetOption(_path, _entry)

							-- debug msg
							SELF.DebugConsole(_DI, "LOAD: Registered: "..tostring(_path).." (ini default)")
						else
							-- set current
							_entry.cur = UTIL.ShortenFloat(_entry.def)

							-- set enabled option
							POOL.SetOption(_path, _entry)

							-- debug msg
							SELF.DebugConsole(_DI, "LOAD: Registered: "..tostring(_path))
						end
					else
						if _entry.def ~= _value
						then
							-- set current
							_entry.cur = _value

							-- set different default
							_entry.old = _entry.def
							_entry.def = _entry.cur

							-- set enabled option
							POOL.SetOption(_path, _entry)

							-- debug msg
							SELF.DebugConsole(_DI, "LOAD: Registered: "..tostring(_path).." (ini default)")
						else
							-- set current
							_entry.cur = _entry.def

							-- set enabled option
							POOL.SetOption(_path, _entry)

							-- debug msg
							SELF.DebugConsole(_DI, "LOAD: Registered: "..tostring(_path))
						end
					end
				else
					if _entry.type == "float"
					then
						-- set current
						_entry.cur = UTIL.ShortenFloat(_value)

						-- set enabled option
						POOL.SetOption(_path, _entry)
					else
						-- set current
						_entry.cur = _value

						-- set enabled option
						POOL.SetOption(_path, _entry)
					end

					-- debug msg
					SELF.DebugConsole(_DI, "LOAD: Registered: "..tostring(_path))
				end
			else
				-- set disabled option
				POOL.SetOption(_path, _entry)

				-- debug msg
				SELF.DebugConsole(_DI, "LOAD: Failed to Register: "..tostring(_path))
			end
		end

		-- system
		if POOL.IsNotInternal(_path) and (_entry.type == "Int" or _entry.type == "Bool" or _entry.type == "Float" or _entry.type == "IntList" or _entry.type == "NameList" or _entry.type == "StringList")
		then
			-- proceed if exist
			if Game.GetSettingsSystem():HasVar("/".._group, _option)
			then
				-- get current value
				_entry.cur = POOL.GetToggle(_path, _attr.type)

				-- loop over lists
				if _entry.type == "IntList"
				or _entry.type == "NameList"
				or _entry.type == "StringList"
				then
					-- get system identifier
					local system = Game.GetSettingsSystem():GetVar('/'.._group, _option)

					-- get all options
					local options = system:GetValues()

					-- something is needed
					if options ~= nil
					then
						-- set enabled
						_entry.is = true

						-- define list
						_entry.opt = {}

						-- loop over them
						for _,value in pairs(options)
						do
							-- convert name value
							if _entry.type == "NameList"
							then
								value = Game.NameToString(value)
							end

							-- register if it has an off option
							if value == "Off" and _option ~= "FSR"
							or value == "Off" and _option ~= "DLSS"
							then
								_entry.has = value
							end

							-- keep OFF in DLSS and RT Light ;-)
							if value ~= "Off" and value ~= "Auto"
							or value == "Off" and _option == "FSR"
							or value == "Off" and _option == "DLSS"
							or value == 'Off' and _option == "RayTracedLighting"
							then
								-- first option is usally the lowest setting
								if _entry.min == nil and _option ~= "FSR" and _option ~= "DLSS"
								then
									_entry.min = value
								else
									-- last option is usally the highest setting
									if _option ~= "FSR" and _option ~= "DLSS"
									then
										_entry.max = value
									end
								end

								-- insert option into list
								table.insert(_entry.opt, value)
							end
						end


						-- set enabled option
						POOL.SetOption(_path, _entry)

						-- debug msg
						SELF.DebugConsole(_DI, "LOAD: Registered: "..tostring(_path))

					-- do we have a fallback?
					else
						-- all versions
						if _attr.any ~= nil
						then
							-- define list
							_entry.opt = _attr.any
						end

						-- specific version
						if _attr[tostring(POOL.GetRecord("versions/game/numeric"))] ~= nil
						then
							-- define list
							_entry.opt = _attr[tostring(POOL.GetRecord("versions/game/numeric"))]
						end

						-- check on it
						if _entry.opt ~= nil
						then
							-- set enabled
							_entry.is = true

							-- set enabled option
							POOL.SetOption(_path, _entry)

							-- debug msg
							SELF.DebugConsole(_DI, "LOAD: Registered: "..tostring(_path).." (fallback)")
						else
							-- set disabled option
							POOL.SetOption(_path, _entry)

							-- debug msg
							SELF.DebugConsole(_DI, "LOAD: Failed to Register: "..tostring(_path).." (empty options)")
						end
					end
				end

				-- bools just flat
				if _entry.type == "Bool"
				then
					-- set enabled
					_entry.is = true

					-- set enabled option
					POOL.SetOption(_path, _entry)

					-- debug msg
					SELF.DebugConsole(_DI, "LOAD: Registered: "..tostring(_path))
				end

				-- floats usally have min/max
				if _entry.type == "Int"
				or _entry.type == "Float"
				then
					-- get system identifier
					local system = Game.GetSettingsSystem():GetVar('/'.._group, _option)

					local min = system:GetMinValue()
					local max = system:GetMaxValue()

					-- needs min/max
					if min ~= nil and max ~= nil
					then
						-- set enabled
						_entry.is = true

						-- assign
						_entry.min = min
						_entry.max = max

						-- set enabled option
						POOL.SetOption(_path, _entry)

						-- debug msg
						SELF.DebugConsole(_DI, "LOAD: Registered: "..tostring(_path))
					else

						-- debug msg
						SELF.DebugConsole(_DI, "LOAD: Failed to Register: "..tostring(_path).." (empty min,max)")
					end
				end
			else
				-- set disabled option
				POOL.SetOption(_path, _entry)

				-- debug msg
				SELF.DebugConsole(_DI, "LOAD: Failed to Register: "..tostring(_path).." (not existing)")
			end
		end
	else
		SELF.DebugConsole(_DI, 'POOL: '..tostring(pool)..' - Failed to Register (unknown): '..tostring(unit.path))
	end

end







function POOL.Debug()

	print(UTIL.DebugDump(SELF.Option))

end








--
--// POOL.GetToggle(<PATH>,<TYPE>)
--
function POOL.GetToggle(_path, _type)

	-- catch non set
	--local _type = _type or "none"

	-- split first
	local _group, _option = UTIL.SplitPath(_path)

	-- DevEx Internal
	if POOL.IsInternal(_path)
	then
		return SELF.GetInternal(_path)
	else
		-- int
		if _type == "int" then
			return GameOptions.GetInt(_group, _option)
		end

		-- bool
		if _type == "bool" then
			return GameOptions.GetBool(_group, _option)
		end

		-- float
		if _type == "float" then
			return GameOptions.GetFloat(_group, _option)
		end

		-- system int
		if _type == "Int" or _type == "IntList" then
			system = Game.GetSettingsSystem():GetVar("/".._group, _option)
			return system:GetValue()
		end

		-- system bool
		if _type == "Bool" then
			system = Game.GetSettingsSystem():GetVar("/".._group, _option)
			return system:GetValue()
		end

		-- system name
		if _type == "NameList" then
			local system = Game.GetSettingsSystem():GetVar("/".._group, _option)
			return Game.NameToString(system:GetValue())
		end

		-- system string
		if _type == "StringList"
		then
			local system = Game.GetSettingsSystem():GetVar("/".._group, _option)
			return system:GetValue()
		end
	end
end




function POOL.SetToggle(_path, _type, _set)

	-- split first
	local _root, _name = UTIL.SplitPath(_path)

	-- DevEx Internal
	if POOL.IsInternal(_path)
	then
		SELF.SetInternal(_path, _set)
	else
		-- int
		if _type == "int" and POOL.HasOption(_path)
		then
			POOL.SetOption(_path, _set)
			GameOptions.SetInt(_root, _name, _set)
		end

		-- bool
		if _type == "bool" and POOL.HasOption(_path)
		then
			POOL.SetOption(_path, _set)
			GameOptions.SetBool(_root, _name, _set)
		end

		-- float
		if _type == "float" and POOL.HasOption(_path)
		then
			POOL.SetOption(_path, _set)
			GameOptions.SetFloat(_root, _name, _set)
		end

		-- system vars
		if _type == "Int"
		or _type == "Bool"
		or _type == "Float"
		then
			local system = Game.GetSettingsSystem():GetVar("/".._root, _name)
			system:SetValue(_set)
		end

		if _type == "IntList"
		then
			local system = Game.GetSettingsSystem():GetVar("/".._root, _name)
			system:SetValue(_set)
		end

		if _type == "NameList"
		or _type == "StringList"
		then
			local system = Game.GetSettingsSystem():GetVar("/".._root, _name)
			local recast = system:GetIndexFor(_set)
			if recast then
				system:SetIndex(recast)
			else
				system:SetValue(_set)
			end
		end
	end
end

--
--// SELF.GetInternal()
--
function SELF.GetInternal(_path)

	-- always true & false
	if _path == "DeveloperExtras/BoolTrue" then return true	end
	if _path == "DeveloperExtras/BoolFalse" then return false end

	-- time dilation
	if _path == "DeveloperExtras/TimeTick/World"
	or _path == "DeveloperExtras/TimeTick/Player"
	then
		return SELF.Extras[_path]
	end

	-- ui toggles
	if _path == "DeveloperExtras/Scrollbar/Enable" then return SELF.Extras[_path] end

	-- graph toggles (flexi)
	if _path == "DeveloperExtras/Graph/Enable" then return SELF.Extras[_path] end
	if _path == "DeveloperExtras/Graph/BackgroundUpdate" then return SELF.Extras[_path] end

	-- graph overlay toggles
	if _path == "DeveloperExtras/Graph/Overlay/Enable"
	or _path == "DeveloperExtras/Graph/Overlay/Position"
	or _path == "DeveloperExtras/Graph/Overlay/Transparency"
	or _path == "DeveloperExtras/Graph/Overlay/Transparency/Bar"
	or _path == "DeveloperExtras/Graph/Overlay/Transparency/Bar/Background"
	or _path == "DeveloperExtras/Graph/Overlay/Transparency/Text"
	then
		return SELF.Extras[_path]
	end
end



--
--// SELF.SetInternal()
--
-- internal options that should be saveable
--
function SELF.SetInternal(_path, _set)

	-- feature: time dilation
	if _path == 'DeveloperExtras/TimeTick/Player' then
		SELF.Extras[_path] = _set
	end
	if _path == 'DeveloperExtras/TimeTick/World' then
		SELF.Extras[_path] = _set
	end

	-- ui toggles
	if _path == "DeveloperExtras/Scrollbar/Enable" then SELF.Extras[_path] = _set end

	-- graph toggles (flexi)
	if _path == "DeveloperExtras/Graph/Enable" then
		SELF.Extras[_path] = _set
	end
	if _path == "DeveloperExtras/Graph/BackgroundUpdate" then
		SELF.Extras[_path] = _set
	end

	-- graph overlay toggles
	if _path == "DeveloperExtras/Graph/Overlay/Enable"
	or _path == "DeveloperExtras/Graph/Overlay/Position"
	or _path == "DeveloperExtras/Graph/Overlay/Transparency"
	or _path == "DeveloperExtras/Graph/Overlay/Transparency/Bar"
	or _path == "DeveloperExtras/Graph/Overlay/Transparency/Bar/Background"
	or _path == "DeveloperExtras/Graph/Overlay/Transparency/Text"
	then
		SELF.Extras[_path] = _set
	end
end






























--
--// POOL.LoadPool(<POOLNAME>)
--
function POOL.LoadFile(poolName)

	-- define
	local data = nil
	local exit = false

	-- proceed
	exit, data = UTIL.LoadJson("data/"..string.lower(poolName)..".json")

	-- result
	return exit, data
end

--
--// POOL.IsInternal(<OPTION>)
--
function POOL.IsInternal(path)
	local exit = false
	local root = path:match("[^/]*")
	if root == "DeveloperExtras" then exit = true end
	return exit
end

--
--// POOL.IsNotInternal(<OPTION>)
--
function POOL.IsNotInternal(path)
	local exit = false
	local root = path:match("[^/]*")
	if root ~= "DeveloperExtras" then exit = true end
	return exit
end

--
--// POOL.HasOption(<OPTION>)
--
function POOL.HasOption(path)
	local exit = false
	if SELF.Option[path] ~= nil then exit = true end
	return exit
end

--
--// POOL.HasNotOption(<OPTION>)
--
function POOL.HasNotOption(path)
	local exit = false
	if SELF.Option[path] == nil then exit = true end
	return exit
end

--
--// POOL.GetOption(<OPTION>)
--
function POOL.GetOption(path)
	return SELF.Option[path]
end

--
--// POOL.SetOption(<OPTION>,<VALUE>)
--
function POOL.SetOption(path, value)
	SELF.Option[path] = value
end




--
--// POOL.GetOption(<OPTION>)
--
function POOL.GetOptionType(path)
	--return SELF.Option[path]["type"]
end







--
--// POOL.GetRender(<POOL>,<TABLE>)
--
function POOL.GetRender(pool)
	return SELF.Render[pool]
end

--
--// POOL.SetRender(<POOL>,<TABLE>)
--
function POOL.SetRender(pool, table)
	SELF.Render[pool] = table
end








--
-- regular
--
function SELF.PrintConsole(message)
	print('*** '..Project..' (v'..Version..') '..tostring(message))
end

--
-- debugging
--
function SELF.DebugConsole(identifier, message)
	if _DEBUG then
		SELF.PrintConsole('- ['..tostring(identifier)..'] '..tostring(message))
	end
end

--
-- exposed init
--
function POOL.Initialize(u,p,v,d,gv,cv)

	-- util
	UTIL = u

	-- identity
	Project = p
	Version = v
	_DEBUG = d
	_GAME = gv
	_CET = cv

	-- always
	return true
end

-- return
return POOL