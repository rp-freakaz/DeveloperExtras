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
--// UTIL:BuildPath(<STRING>,<STRING>)
--
function UTIL:BuildPath(root, name)
	return root.."/"..name
end

--
--// UTIL:SplitPath(<STRING>)
--
function UTIL:SplitPath(path)
	return path:match('^(.+)/([A-Za-z0-9_]+)$')
end

--
--// UTIL:IntToBool(<INT>)
--
function UTIL:IntToBool(data)

	if data > 0 then
		return false
	else
		return true
	end
end

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
--// UTIL:TextWidth(<STRING>)
--
function UTIL:TextWidth(text)
	x, y = ImGui.CalcTextSize(tostring(text))
	return x
end

--
--// UTIL:TextHeight(<STRING>)
--
function UTIL:TextHeight(text)
	x, y = ImGui.CalcTextSize(tostring(text))
	return y
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
--// UTIL:ButtonWidth()
--
function UTIL:ButtonWidth(text)
	x, y = ImGui.CalcTextSize(tostring(text))
	return (x + 12)
end

--
--// UTIL:ButtonHeight()
--
function UTIL:ButtonHeight(text)
	x, y = ImGui.CalcTextSize(tostring(text))
	return (y + 8)
end





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
--// UTIL:SpaceBetween(<STRING>,<STRING>,<INT>,<INT>)
--
function UTIL:SpaceBetween(left, right, width, size)

	-- base value
	local total = width - UTIL:TextWidth(left..right) - 42
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















-- load any file
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

-- load any json
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




-- debugging only
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
function UTIL:Prelude(project, version, debug)
	local o = {}
	setmetatable(o, self)
	self.__index = self

	-- identity
	UTIL.Project = project
	UTIL.Version = version
	UTIL.isDebug = debug

	return o
end

-- return
return UTIL