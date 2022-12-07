--
-- Developer Extras v3
-- 2022 by FreakaZ
--
-- https://rootpunk.com/mod/#developerextras
-- https://github.com/rp-freakaz/DeveloperExtras
-- hello@rootpunk.com
--

-- load core
local devEx = require("root/core.lua"):Pre()

-- force debug
--devEx.isDebug = true
--devEx.isGraph = true
--devEx.isRenew = true

-- init trigger
registerForEvent("onInit", function()
	devEx:Initialize()

	-- observe photomode
	--Observe('gameuiPhotoModeMenuController', 'OnShow', function()
	--	devEx.isPhoto = true
	--end)
	--Observe('gameuiPhotoModeMenuController', 'OnHide', function()
	--	devEx.isPhoto = false
	--end)
end)

--registerForEvent("onUpdate", function()
	--if devEx.isReady and devEx.isRenew
	--then
	--	devEx.Cronjobs()
	--end
--end)

registerForEvent("onShutdown", function()
	devEx.isReady = false
end)

registerForEvent("onOverlayOpen", function()
	if devEx.isReady
	then
		-- reset always
		devEx.ResetGraph()

		-- paint interface
		devEx.isPaint = true
	end
end)

registerForEvent("onOverlayClose", function()
	if devEx.isReady
	then


		devEx.isPaint = false
	end
end)

registerForEvent("onDraw", function()

		--print(devEx.isReady)
	if devEx.isReady
	then

		-- window
		if devEx.isPaint then devEx.Interface() end




		-- overlay
		--if devEx.isGraph then devEx.ShowGraph() end
	end
end)



--registerHotkey("DE_Overlay", "Developer Extras: Show Overlay", function()
--	if devEx.isReady
--	then
		-- reset always
		--devEx.ResetOverlay()

		-- toggle overlay
		--devEx.ToggleOverlay()
--	end
--end)

-- EOF