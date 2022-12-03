			-- debug msg
			CORE:DebugConsole(__func__,"Loading Colors ..")

			-- load colors
			if CORE:LoadColors()
			then
				-- debug msg
				CORE:DebugConsole(__func__,"Found "..tostring(UTIL:TableLength(CORE.Profile)).." Profiles")
			end


			-- debug msg
			CORE:DebugConsole(__func__,"ImGui is ready: "..tostring(CORE:ImGuiReady()))

			--while CORE:ImGuiReady()
			--do
				-- debug msg
			--	CORE:DebugConsole(__func__,"Waiting for ImGui ..")

			--	while os.clock - os.clock <= 1 do end

				--print(UTIL:DebugDump(tostring(exit)))
				--print(UTIL:DebugDump(tostring(data)))
			--end











--
--// CORE:LoadColors()
--
function CORE:LoadColorsNew()

	-- debug id
	local __func__ = "CORE:LoadColors"

	-- define
	local data = nil
	local exit = false

	-- load & convert
	local exit, data = UTIL:LoadJson("data/_profiles.json")

	-- validate
	if exit
	then
		-- number based
		local id = 0
		local count = 1

		-- loop profiles
		for style,items in pairs(data)
		do
			-- always zero
			if style == "default"
			then
				id = 0
			else
				-- use count
				id = count

				-- also increase
				count = count + 1
			end

			-- debug msg
			CORE:DebugConsole(__func__,"Reading Records: "..tostring(UTIL:TableLength(items)))



			-- distribute
			DRAW.Profile = CORE.Profile
			UTIL.Profile = CORE.Profile
		end


		--print(UTIL:DebugDump(CORE.Profile))
		--print(UTIL:DebugDump(DRAW.Profile))

	else
		-- debug msg
		CORE:DebugConsole(__func__,"failed to parse _profiles.json")
	end

	-- result
	return exit
end





--
--// CORE:LoadColors()
--
function CORE:LoadColors()

	-- debug id
	local __func__ = "CORE:LoadColors"

	-- define
	local data = nil
	local exit = false

	-- load & convert
	local exit, data = UTIL:LoadJson("data/_profiles.json")

	-- validate
	if exit
	then
		-- id based
		local id = 0

		-- loop profiles
		for style,items in pairs(data)
		do
			-- debug msg
			CORE:DebugConsole(__func__,"Reading Records: "..tostring(UTIL:TableLength(items)))

			-- create profile
			if not CORE.Profile[UTIL:WordsToUpper(style)]
			then
				CORE.Profile[UTIL:WordsToUpper(style)] = {}
				CORE.Profile[UTIL:WordsToUpper(style)]["deID"] = id

				-- debug msg
				CORE:DebugConsole(__func__,"Create Profile: "..UTIL:WordsToUpper(style))
			end

			-- resolve references
			for entry,color in pairs(items)
			do
				-- convert reference
				while type(data[style][entry]) == "string"
				do
					-- debug msg
					CORE:DebugConsole(__func__,"Reference: "..tostring(entry).." >> "..tostring(color))

					-- rewrite element
					data[style][entry] = data[style][color]
				end

				-- assignment if right type
				if type(data[style][entry][1]) == "number" and type(data[style][entry][2]) == "number" and type(data[style][entry][3]) == "number" and type(data[style][entry][4]) == "number"
				then
					CORE.Profile[UTIL:WordsToUpper(style)][entry] = data[style][entry]
				else
					-- debug msg
					CORE:DebugConsole(__func__,"Element in '"..UTIL:WordsToUpper(style).."' seens to be broken ("..tostring(entry)..")")
				end
			end

			-- something was wrong while parsing
			if (UTIL:TableLength(CORE.Profile[UTIL:WordsToUpper(style)]) - 1) ~= UTIL:TableLength(data[style])
			then
				-- debug msg
				CORE:DebugConsole(__func__,"Disabled: '"..UTIL:WordsToUpper(style).."' (element number mismatch)")

				-- disable profile
				CORE.Profile[UTIL:WordsToUpper(style)] = nil
			else
				id = id + 1
			end
		end

		-- distribute
		DRAW.Profile = CORE.Profile
		UTIL.Profile = CORE.Profile

		--print(UTIL:DebugDump(CORE.Profile))
		print(UTIL:DebugDump(DRAW.Profile))

	else
		-- debug msg
		CORE:DebugConsole(__func__,"failed to parse _profiles.json")
	end

	-- result
	return exit
end















function DRAW:CompileColor()

	if DRAW.Compile == nil
	then
		DRAW.Compile = {}

		-- loop elements
		for element,content in pairs(DRAW.Profile[DRAW.Runtime.Profile]["list"])
		do
			local r = content["r"]
			local g = content["g"]
			local b = content["b"]
			local a = content["a"]

			DRAW.Compile[element] = ImGui.GetColorU32(r, g, b, a)
		end
	end
end



function DRAW:SetColor(color)

	return ImGui.ColorConvertFloat4ToU32(DRAW.Profile["Default"][color])



		--return ImGui.GetColorU32(DRAW.Profile[0][color][1], DRAW.Profile[0][color][2], DRAW.Profile[0][color][3], DRAW.Profile[0][color][4])

		--ImGui.PushStyleColor(element, DRAW.Profile[0][color][1], DRAW.Profile[0][color][2], DRAW.Profile[0][color][3], DRAW.Profile[0][color][4])
		--ImGui.PushStyleColor(element, DRAW.Profile[DRAW.Runtime.Profile][color][1], DRAW.Profile[DRAW.Runtime.Profile][color][2], DRAW.Profile[DRAW.Runtime.Profile][color][3], DRAW.Profile[DRAW.Runtime.Profile][color][4])

end



function DRAW:ColorSwitch(color, state)

	-- catch unset
	local color = color or "fallback"
	local state = state or 0

	if color == "fallback"
	then
		print("color not set")
		return DRAW:GetColor("Alarm")
	end


	if DRAW.Compile[color]
	then
		return DRAW.Compile[color]
	else
		print("color not found")
	end

	--if type(DRAW.Profile[DRAW.Runtime.Profile]["list"][color]["r"]) == "number"
	--and type(DRAW.Profile[DRAW.Runtime.Profile]["list"][color]["g"]) == "number"
	--and type(DRAW.Profile[DRAW.Runtime.Profile]["list"][color]["b"]) == "number"
	--and type(DRAW.Profile[DRAW.Runtime.Profile]["list"][color]["a"]) == "number"
	--then
	--	return ImGui.GetColorU32(DRAW.Profile[DRAW.Runtime.Profile]["list"][color]["r"], DRAW.Profile[DRAW.Runtime.Profile]["list"][color]["g"], DRAW.Profile[DRAW.Runtime.Profile]["list"][color]["b"], DRAW.Profile[DRAW.Runtime.Profile]["list"][color]["a"])
	--end



	--print(tostring(ImGui.GetColorU32(DRAW.Profile.Colors[DRAW.Profile.Select][color][1], DRAW.Profile.Colors[DRAW.Profile.Select][color][2], DRAW.Profile.Colors[DRAW.Profile.Select][color][3], DRAW.Profile.Colors[DRAW.Profile.Select][color][4])))

	--return ImGui.GetColorU32(DRAW.Profile.Colors[DRAW.Profile.Select][color][1], DRAW.Profile.Colors[DRAW.Profile.Select][color][2], DRAW.Profile.Colors[DRAW.Profile.Select][color][3], DRAW.Profile.Colors[DRAW.Profile.Select][color][4])



	return DRAW:GetColor("Alarm")

end