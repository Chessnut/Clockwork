--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local Clockwork = Clockwork;

Clockwork.theme = Clockwork.kernel:NewLibrary("Theme");

--[[ Use a debug hack to get the panel factory. --]]
local sTabName, tPanelFactory = debug.getupvalue(vgui.Create, 1);

if (sTabName == "PanelFactory" and type(tPanelFactory) == "table") then
	Clockwork.theme.factory = tPanelFactory;
else
	Clockwork.theme.factory = {};
end;

-- A function to begin the theme.
function Clockwork.theme:Begin()
	return {
		factory = self.factory,
		module = {},
		hooks = {},
		skin = {}
	};
end;

-- A function to get the theme.
function Clockwork.theme:Get()
	return self.active;
end;

-- A function to copy the theme to the Derma skin.
function Clockwork.theme:CopySkin()
	local skinTable = derma.GetNamedSkin("Clockwork");
	
	if (self.active and skinTable) then
		for k, v in pairs(self.active.skin) do
			skinTable[k] = v;
		end;
	end;
	
	derma.RefreshSkins();
end;

-- A function to create the theme fonts.
function Clockwork.theme:CreateFonts()
	if (self.active and self.active.CreateFonts) then
		self.active:CreateFonts();
	end;
end;

-- A function to initialize the theme.
function Clockwork.theme:Initialize()
	if (self.active and self.active.Initialize) then
		self.active:Initialize();
	end;
end;

-- A function to finish the theme.
function Clockwork.theme:Finish(themeTable)
	Clockwork.plugin:Add("Theme", themeTable.module);
	self.active = themeTable;
end;

-- A function to call a theme hook.
function Clockwork.theme:Call(hookName, ...)
	if (self.active and self.active.hooks[hookName]) then
		return self.active.hooks[hookName](self.active.hooks, ...);
	end;
end;

--[[ 
	The following are available hooks for Clockwork.theme library:
	
	Hooks with a [/] after them mean that returning true
	overrides the default action.
	
	PreCharacterMenuInit(panel) [/]
	PostCharacterMenuInit(panel)
	
	PreCharacterMenuThink(panel) [/]
	PostCharacterMenuThink(panel)
	
	PreCharacterMenuPaint(panel) [/]
	PostCharacterMenuPaint(panel)
	
	PreCharacterMenuOpenPanel(panel, vguiName, childData, Callback) [/]
	PostCharacterMenuOpenPanel(panel)
	
	PreMainMenuInit(panel) [/]
	PostMainMenuInit(panel)
	
	PreMainMenuRebuild(panel) [/]
	PostMainMenuRebuild(panel)
	
	PreMainMenuOpenPanel(panel, panelToOpen) [/]
	PostMainMenuOpenPanel(panel, panelToOpen)
	
	PreMainMenuPaint(panel) [/]
	PostMainMenuPaint(panel)
	
	PreMainMenuThink(panel) [/]
	PostMainMenuThink(panel)
--]]