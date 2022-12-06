--
-- Developer Extras v3
-- 2022 by FreakaZ
--
-- https://rootpunk.com/mod/#developerextras
-- https://github.com/rp-freakaz/DeveloperExtras
-- hello@rootpunk.com
--
local UTIL = {}

--
--
--//////////////////// CORE ////////////////////
--
--

--
--// UTIL:ElementID(<STRING>)
--   used for:
--   DRAW:Quickshift
--
function UTIL:ElementID(input)
	return string.gsub(tostring(input), "/", "")
end

--
--// UTIL:BuildPath(<STRING>,<STRING>)
--
function UTIL:BuildPath(root, name)
	return root.."/"..name
end

--
--// UTIL:SplitPath(<STRING>)
--
function UTIL:SplitPath(path)
	return path:match("^(.+)/([A-Za-z0-9_]+)$")
end

--
--
--//////////////////// TIMINGS ////////////////////
--
--

--
-- default timings
--
function UTIL:GetSeconds()
	return math.floor(ImGui.GetTime())
end

function UTIL:GetMilliseconds()
	return math.floor(ImGui.GetTime() * 1000)
end

--
-- additional timings
--
function UTIL:Get10thSeconds()
	return math.floor(ImGui.GetTime() * 10)
end

function UTIL:Get25thSeconds()
	return math.floor(ImGui.GetTime() * 25)
end

function UTIL:Get50thSeconds()
	return math.floor(ImGui.GetTime() * 50)
end

function UTIL:Get100thSeconds()
	return math.floor(ImGui.GetTime() * 100)
end

--
--
--//////////////////// SCALING ////////////////////
--
--

--
--// UTIL:ScreenScale(<FLOAT>,<FLOAT>)
--
function UTIL:ScreenScale(pixels, factor)

	-- catch non set
	local pixels = pixels or 0
	local factor = factor or UTIL.Scaling.Screen.Factor

	if UTIL.Scaling.Enable and pixels > 0
	then
		return UTIL:ShortenFloat(UTIL.Scaling.Screen.Factor * pixels)
	end
	return pixels
end

--
--// UTIL:WindowScale(<FLOAT>,<FLOAT>)
--
function UTIL:WindowScale(pixels, factor)

	-- catch non set
	local pixels = pixels or 0
	local factor = factor or UTIL.Scaling.Window.Factor

	if UTIL.Scaling.Enable and pixels > 0
	then
		return UTIL:ShortenFloat((UTIL.Scaling.Screen.Factor * UTIL.Scaling.Window.Factor) * pixels)
	end
	return pixels
end












--
--// UTIL:ScaleSwitch(<INT>,<BOOL>)
--
function UTIL:ScaleSwitch(pixels, screen)

	-- catch non set
	local pixels = pixels or 0
	local screen = screen or false

	if UTIL.Scaling.Enable and pixels > 0
	then
		if screen
		then
			return UTIL:ShortenFloat(UTIL.Scaling.Screen.Factor * pixels)
		end
		return UTIL:ShortenFloat((UTIL.Scaling.Screen.Factor * UTIL.Scaling.Window.Factor) * pixels)
		--return UTIL:ShortenFloat(UTIL.Scaling.Window.Factor * pixels)
		--return UTIL:ShortenFloat((ImGui.GetFontSize() / 18) * pixels)
	end
	return pixels
end






--
--// UTIL:FontScale(<INT>)
--
function UTIL:FontScale(pixels)

	-- catch non set
	local pixels = pixels or 0

	if UTIL.Scaling.Enable and pixels > 0
	then
		return UTIL:ShortenFloat((ImGui.GetFontSize() / 18) * pixels)
	end
	return pixels
end


--
--
--//////////////////// CONVERSIONS ////////////////////
--
--

--
--// UTIL:IntToBool(<INT>)
--   used for:
--   CORE:RenderQuickshift
--
function UTIL:IntToBool(input)
	if input == 1 then return true end
	return false
end

--
--// UTIL:BoolToInt(<BOOL>)
--   used for:
--   CORE:RenderQuickshift
--
function UTIL:BoolToInt(input)
	if input == true then return 1 end
	return 0
end

--
--// UTIL:FirstToUpper(<STRING>)
--
function UTIL:FirstToUpper(input)
	return (input:gsub("^%l", string.upper))
end

--
--// UTIL:WordsToUpper(<STRING>)
--
function UTIL:WordsToUpper(input)
	local result = ""
	for part in string.gmatch(input, "([^%s]+)")
	do
		if result == ""
		then
			result = UTIL:FirstToUpper(part)
		else
			result = result.." "..UTIL:FirstToUpper(part)
		end
	end
	return result
end

--
--
--//////////////////// STYLING ////////////////////
--
--

--
--// UTIL:ThemeToInt(<STRING>)
--
function UTIL:ThemeToInt(input)
	for k,v in pairs(UTIL.Runtime.Themes)
	do
		if v == input then return (k - 1) end
	end
	return false
end

--
--// UTIL:ThemeToInt(<INT>)
--
function UTIL:IntToTheme(input)
	for k,v in pairs(UTIL.Runtime.Themes)
	do
		if (k - 1) == input then return v end
	end
	return false
end

--
--
--//////////////////// FILTERING ////////////////////
--
--

--
--// UTIL:FilterNumbers(<STRING>)
--
function UTIL:FilterNumbers(data)
	local result = ""
	string.gsub(data,"%d+",function(found)
		result = result..found
	end)
	return result;
end

--
--// UTIL:ShortenFloat(<FLOAT>)
--
function UTIL:ShortenFloat(data)
	return tonumber(string.format("%.3f", data))
end

--
--
--//////////////////// COUNTING ////////////////////
--
--

--
--// UTIL:TableLength(<TABLE>)
--
function UTIL:TableLength(table)
	local count = 0
	for _ in pairs(table)
	do
		count = count + 1
	end
	return count
end

--
--// UTIL:TableOption(<TABLE>)
--
function UTIL:TableOption(table)
	local count = 0
	for i,v in pairs(table)
	do
		if v.path
		then
			count = count + 1
		end
	end
	return count
end

--
--
--//////////////////// INTERFACE ////////////////////
--
--

--
--// UTIL:TextWidth(<STRING>)
--
function UTIL:TextWidth(text)
	local x, y = ImGui.CalcTextSize(tostring(text))
	return x
end

--
--// UTIL:TextHeight(<STRING>)
--
function UTIL:TextHeight(text)
	local x, y = ImGui.CalcTextSize(tostring(text))
	return y
end

--
--// UTIL:ButtonWidth()
--
function UTIL:ButtonWidth(text)
	x, y = ImGui.CalcTextSize(tostring(text))
	return x + UTIL:ScaleSwitch(12)
end

--
--// UTIL:ButtonHeight()
--
function UTIL:ButtonHeight(text)
	x, y = ImGui.CalcTextSize(tostring(text))
	return y + UTIL:ScaleSwitch(7)
end









--
--// UTIL:TextSplit(<STRING>)
--
function UTIL:TextSplit(text)
	local result = {}
	for part in string.gmatch(text, "([^%s]+)")
	do
		table.insert(result, part)
	end
	return result
end

--
--// UTIL:TextCenter(<INT>,<STRING>)
--
function UTIL:TextCenter(width, text)
	return math.floor((width - UTIL:TextWidth(text)) / 2)
end























--
--// UTIL:WordWrap(<STRING>,<INT>)
--
function UTIL:WordWrap(input, space)

	-- catch non set
	local space = space or 0

	-- whats left
	local limit = UTIL.Scaling.Window.Width - (space * 2)
	local lines = ""

	-- split text
	for word in input:gmatch("%S+")
	do
		if UTIL:TextWidth(lines.." "..word) > limit
		then
			-- break line
			lines = lines.."\n"..word
		else
			if lines == ""
			then
				-- add first
				lines = word
			else
				-- add to line
				lines = lines.." "..word
			end
		end
	end

	-- result
	return lines
end












--
--// UTIL:SpaceBetween(<STRING>,<STRING>,<INT>,<INT>)
--
function UTIL:SpaceBetween(left, right, width, size)

	-- base value
	--local total = width - UTIL:TextWidth(left..right) - (142 * CORE.Scaling.Window.Factor.Width)

	local total = width - UTIL:TextWidth(left..right) - (10 * UTIL.Scaling.Window.Factor)

	local space = ""

	-- loop until
	while total > 0
	do
		space = space.." "
		total = total - size
	end

	-- result
	return left..space..right
end

















--
--// UTIL:ScreenWidth(<FLOAT>), UTIL:ScreenHeight(<FLOAT>)
--
function UTIL:ScreenWidth(percent)
	return UTIL.Scaling.Screen.Factor * percent
end

function UTIL:ScreenHeight(percent)
	return UTIL.Scaling.Screen.Factor * percent
end

--
--// UTIL:WindowWidth(<FLOAT>), UTIL:WindowHeight(<FLOAT>)
--
function UTIL:WindowWidth(percent)
	return UTIL.Scaling.Window.Factor * percent
end

function UTIL:WindowHeight(percent)
	return UTIL.Scaling.Window.Factor * percent
end

function UTIL:GetWindowWidth(percent)
	return ImGui.GetWindowWidth() / 100 * percent
end






















--
--
--//////////////////// FILE ACTIONS ////////////////////
--
--

--
--// UTIL:ReadFile(<STRING>)
--
function UTIL:ReadFile(path)

	-- define
	local data = nil

	-- proceed
	local file = io.open(path, 'r')

	-- validate
	if file ~= nil
	then
		data = file:read("*a")
		file:close()
	end

	-- result
	return data
end

--
--// UTIL:LoadJson(<STRING>)
--
function UTIL:LoadJson(path)

	-- define
	local data = nil
	local exit = false

	-- proceed
	local file = UTIL:ReadFile(path)

	-- validate
	if file ~= nil
	then
		-- convert
		exit, data = pcall(function() return json.decode(file) end)
	end

	-- result
	return exit, data
end

--
--
--//////////////////// DEBUGGING ////////////////////
--
--

--
--// UTIL:DebugDump(<TABLE>)
--
function UTIL:DebugDump(data)
	local tablecache = {}
	local buffer = ""
	local padder = "    "

	local function _dumpvar(d, depth)
	local t = type(d)
	local str = tostring(d)
	if (t == "table") then

            if (tablecache[str]) then
                -- table already dumped before, so we dont
                -- dump it again, just mention it
                buffer = buffer.."<"..str..">\n"
            else
                tablecache[str] = (tablecache[str] or 0) + 1
                buffer = buffer.."("..str..") {\n"
                for k, v in pairs(d) do
                    buffer = buffer..string.rep(padder, depth+1).."["..k.."] => "
                    _dumpvar(v, depth+1)
                end
                buffer = buffer..string.rep(padder, depth).."}\n"
            end
        elseif (t == "number") then
            buffer = buffer.."("..t..") "..str.."\n"
        else
            buffer = buffer.."("..t..") \""..str.."\"\n"
        end
    end
    _dumpvar(data, 0)
    return buffer
end

--
-- constructor
--
function UTIL:Pre(project, version, runtime, scaling, debug)
	local o = {}
	setmetatable(o, self)
	self.__index = self

	-- identity
	UTIL.Project = project
	UTIL.Version = version
	UTIL.Runtime = runtime
	UTIL.Scaling = scaling
	UTIL.isDebug = debug

	return o
end

-- return
return UTIL