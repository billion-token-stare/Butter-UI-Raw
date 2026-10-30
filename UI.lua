--[[
    Compkiller Interface (Modified)
--]]

--- Export Types ---

export type cloneref = (target: Instance) -> Instance;

export type Window = {
	Name: string,
	Keybind: string | Enum.KeyCode,
	Logo: string,
	Scale: UDim2,
	TextSize: number
};

export type ConfigManager = {
	Directory: string,
	Config: string,
};

export type WriteConfig = {
	Name: string,
	Author: string,
};

export type WindowUpdate = {
	Username: string,
	ExpireDate: string,
	Logo: string,
	WindowName: string,
	UserProfile: string
};

export type ConfigFunctions = {
	Directory: string,
	WriteConfig: (self: ConfigFunctions , Config: WriteConfig) -> any?,
	ReadInfo: (self: ConfigFunctions , ConfigName: string) -> any?,
	DeleteConfig: (self: ConfigFunctions , ConfigName: string) -> any?,
	LoadConfig: (self: ConfigFunctions , ConfigName: string) -> any?,
	GetConfigs: (self: ConfigFunctions , ConfigName: string) -> {string},
	GetConfigCount: (self: ConfigFunctions) -> number,
	GetFullConfigs: (self: ConfigFunctions , ConfigName: string) -> {
		{
			Name: string,
			Info: {
				Type: string,
				Author: string,
				Name: string,
				CreatedDate: string,
			}
		}	
	},
};

export type Notify = {
	Icon: string,
	Title: string,
	Content: string,
	Duration: number
};

export type NotifyPayback = {
	SetProgress: (self: Notify , time: number) -> any?,
	Content: (self: Notify , str: string) -> any?,
	Title: (self: Notify , str: string) -> any?,
	Close: () -> any?,
}

export type Watermark = {
	Icon: string,
	Text: string,
	ShowIcon: boolean?,
	ShowText: boolean?,
	TextColor: Color3?,
	IconColor: Color3?,
	Font: Enum.Font?,
	TextSize: number?,
	StableWidth: boolean?,
	MinWidth: number?,
	WidthSample: string?,
};

export type TabConfig = {
	Name: string,
	Icon: string,
	Type: string,
	EnableScrolling: boolean
};

export type TabConfigManager = {
	Name: string,
	Icon: string,
	Config: ConfigFunctions
}

export type ContainerTab = {
	Name: string,
	Icon: string,
	EnableScrolling: boolean
};

export type Category = {
	Name: string
};

export type Section = {
	Name: string,
	Position: string
};

export type Toggle = {
	Icon: string?,
	Name: string,
	Default: boolean,
	Flag: string | nil,
	Risky: boolean,
	Callback: (Value: boolean) -> any?
};

export type MiniToggle = {
	Default: boolean,
	Flag: string | nil,
	Callback: (Value: boolean) -> any?
};

export type TextBoxConfig = {
	Icon: string?,
	Name: string,
	Default: string,
	Placeholder: string,
	Flag: string | nil,
	Numeric: boolean,
	Callback: (Text: string) -> any?
};

export type ColorPicker = {
	Icon: string?,
	Name: string,
	Default: Color3,
	Flag: string | nil,
	Transparency: number,
	Callback: (Value: Color3 , Trans: number) -> any?
};

export type MiniColorPicker = {
	Default: Color3,
	Transparency: number,
	Flag: string | nil,
	Callback: (Value: Color3 , Trans: number) -> any?
};

export type Slider = {
	Icon: string?,
	Name: string,
	Min: number,
	Max: number,
	Default: number,
	Type: string,
	Round: number,
	Callback: (Value: number) -> any?
};

export type Dropdown = {
	Icon: string?,
	Name: string,
	Default: string | {string},
	Values: {string},
	Multi: boolean,
	Preview: ((Value: any, IsActive: () -> boolean, Index: number?) -> (Instance?, string?, number?, number?))?,
	PreviewOptions: {Default: string?, Persistent: boolean?}?,
	ItemIcon: ((Value: string) -> string)?,
	Callback: (Value: string | {[string]: boolean}) -> any?
};

export type Button = {
	Icon: string?,
	Name: string,
	Cooldown: number?,
	AllowConcurrent: boolean?,
	Callback: () -> any?
};

export type Keybind = {
	Icon: string?,
	Name: string,
	Default: string | Enum.KeyCode,
	Callback: (Value: string) -> any,
	Blacklist: {string | Enum.KeyCode}
};

export type MiniKeybind = {
	Default: string | Enum.KeyCode,
	Callback: (Value: string) -> any,
	Blacklist: {string | Enum.KeyCode}
};

export type Helper = {
	Text: string
};

export type Paragraph = {
	Title: string,
	Content: string,
	Image: string?
}

pcall(function()
	local Constant = table.concat({"LP","H_NO"}).."_VI".."RTU".."AL".."IZE";
	getfenv()[Constant] = getfenv()[Constant] or function(f) return f end; 
	-- LPH_NO_VIRTUALIZE
end);

getgenv = getgenv or getfenv;

-- Please ignore the ugly code. [Custom File System] --
if game:GetService('RunService'):IsStudio() then
	local BaseWorkspace = Instance.new('Folder',game:GetService("ReplicatedFirst"));

	BaseWorkspace.Name = tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));

	local __get_path_c = function(path)
		return (string.find(path,'/',1,true) and string.split(path,'/')) or (string.find(path,'\\',1,true) and string.split(path,'\\')) or {path};
	end

	local __get_path = function(path)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			block = block[v];
		end;

		return block;
	end;

	getgenv().readfile = function(path)
		local path : StringValue = __get_path(path);

		return path.Value;
	end;

	getgenv().isfile = function(path)
		local success , message = pcall(function()
			return __get_path(path);
		end);

		if success and not message:IsA("Folder") then
			return true;
		end;

		return false;
	end;

	getgenv().isfolder = function(path)
		local success , message = pcall(function()
			return __get_path(path);
		end);

		if success and message:IsA("Folder") then
			return true;
		end;

		return false;
	end;

	getgenv().writefile = function(path,content)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			local item = block:FindFirstChild(v);
			if not item then
				local c = Instance.new('StringValue',block);

				c.Name = tostring(v);
				c.Value = content;
			else
				if item:IsA('StringValue') and tostring(item) == v then
					item.Name = tostring(v);
					item.Value = content;
				end;

				block = item;
			end;
		end;
	end;

	getgenv().listfiles = function(path)
		local fold = __get_path(path);
		local pa = {};

		for i,v in next , fold:GetChildren() do
			if v:IsA('StringValue') then
				table.insert(pa,path..'/'..tostring(v));
			end;
		end;

		return pa;
	end;

	getgenv().makefolder = function(path)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			local item = block:FindFirstChild(v);
			if not item then
				local c = Instance.new('Folder',block);

				c.Name = tostring(v);
			else
				block = item;
			end;
		end;
	end;

	getgenv().delfile = function(path)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			local item = block:FindFirstChild(v);
			if item and item:IsA('StringValue') then
				item:Destroy();
			else
				block = item;
			end;
		end;
	end;
end;

--- Local Variables ---
local cloneref: cloneref = cloneref or function(f) return f end;
local TweenService: TweenService = cloneref(game:GetService('TweenService'));
local UserInputService: UserInputService = cloneref(game:GetService('UserInputService'));
local TextService: TextService = cloneref(game:GetService('TextService'));
local RunService: RunService = cloneref(game:GetService('RunService'));
local Players: Players = cloneref(game:GetService('Players'));
local HttpService: HttpService = cloneref(game:GetService('HttpService'));
local LocalPlayer: Player = Players.LocalPlayer;
local CoreGui: PlayerGui = (gethui and gethui()) or cloneref(game:FindFirstChild('CoreGui')) or LocalPlayer.PlayerGui;
local Mouse: Mouse = LocalPlayer:GetMouse();
local CurrentCamera: Camera? = workspace.CurrentCamera;

local Compkiller = {
	Version = '1.0',
	Logo = "rbxassetid://102337949802265",
	Windows = {},
	Scale = {
		Window = UDim2.new(0, 456,0, 499),
		Mobile = UDim2.new(0, 450,0, 375),
		TabOpen = 185,
		TabClose = 85,
	},
	ArcylicParent = CurrentCamera,
	ProtectGui = protect_gui or protectgui or (syn and syn.protect_gui) or function(s) return s; end,
};

Compkiller.Colors = {
	Highlight = Color3.fromRGB(17, 238, 253),
	Toggle = Color3.fromRGB(14, 203, 213),
	Risky = Color3.fromRGB(251, 255, 39),
	BGDBColor = Color3.fromRGB(22, 24, 29),
	BlockColor = Color3.fromRGB(28, 29, 34),
	StrokeColor = Color3.fromRGB(37, 38, 43),
	SwitchColor = Color3.fromRGB(255, 255, 255),
	DropColor = Color3.fromRGB(33, 35, 39),
	MouseEnter = Color3.fromRGB(55, 58, 65),
	BlockBackground = Color3.fromRGB(39, 40, 47),
	LineColor = Color3.fromRGB(65, 65, 65),
	HighStrokeColor = Color3.fromRGB(55, 56, 63),
};

Compkiller.Elements = {
	Polish = {},
	Highlight = {},
	DropHighlight = {},
	Risky = {},
	BGDBColor = {},
	BlockColor = {},
	StrokeColor = {},
	SwitchColor = {},
	DropColor = {},
	BlockBackground = {},
	LineColor = {},
	HighStrokeColor = {},
};

Compkiller.DragBlacklist = {};
Compkiller.IaDrag = false;
Compkiller.LastDrag = tick();
Compkiller.Flags = {};

-- One estimator for every task progress display. Renderers keep their raw labels.
Compkiller.ProgressETA = {}
do
    local eta = Compkiller.ProgressETA
    function eta.New(started)
        return {Started = started or os.clock()}
    end
    function eta.Format(seconds)
        seconds = math.max(0, math.ceil(seconds))
        if seconds < 60 then return tostring(seconds) .. "s" end
        if seconds < 3600 then return string.format("%dm %ds", math.floor(seconds / 60), seconds % 60) end
        return string.format("%dh %dm", math.floor(seconds / 3600), math.floor(seconds / 60) % 60)
    end
    function eta.Update(state, label, fraction, current, total)
        label = tostring(label or "")
        label = label:match("^(.-)%s*•%s*ETA:.*$") or label
        if current == nil or total == nil then
            local done, count = label:match("%(%s*(%d+)%s*/%s*(%d+)")
            if not done then done, count = label:match("(%d+)%s*/%s*(%d+)") end
            current, total = tonumber(done), tonumber(count)
        end
        if current == nil or total == nil then
            if type(fraction) ~= "number" or fraction ~= fraction then return label end
            current, total = math.clamp(fraction > 1 and fraction / 100 or fraction, 0, 1), 1
        end
        if current ~= current or total ~= total or total == math.huge or current == math.huge then return label end
        current, total = math.max(0, current), math.max(0, total)
        if total == 1 and label:lower():match("^get tree%s*%(") then
            state.Completed, state.Total, state.Suffix = current, total, ""
            return label
        end
        if state.Total and state.Completed and state.Completed >= state.Total and current == 0 and total > 0 then
            state.Started, state.Suffix = os.clock(), nil
        end
        if total == 0 or current >= total then
            state.Completed, state.Total, state.Suffix = current, total, ""
            return label
        end
        -- Re-rendering, status updates and mirrored bars do not move the estimate.
        -- Refresh it only when the completed count or work total changes.
        if current ~= state.Completed or total ~= state.Total or not state.Suffix then
            state.Completed, state.Total = current, total
            if current == 0 then state.Suffix = " • ETA: calculating..."
            else
                local elapsed = math.max(0, os.clock() - state.Started)
                state.Suffix = " • ETA: " .. eta.Format((elapsed / current) * (total - current))
            end
        end
        return label .. state.Suffix
    end
end
-- Derive small presentation adjustments from the current palette. Presets and
-- saved theme values stay unchanged, including user-supplied accent colors.
local PolishBlends = {
	RestoreIcon = {"Highlight", "SwitchColor", 0.12},
	Popup = {"BGDBColor", "DropColor", 0.35},
	Hover = {"DropColor", "MouseEnter", 0.28},
	MutedText = {"SwitchColor", "BGDBColor", 0.18},
	Placeholder = {"SwitchColor", "BGDBColor", 0.42},
};

function Compkiller:_PolishColor(Role, BaseColor)
	local Blend = PolishBlends[Role];
	if Blend then
		return (BaseColor or self.Colors[Blend[1]]):Lerp(self.Colors[Blend[2]], Blend[3]);
	end;
	return assert(self.Colors[Role], "Unknown UI color role: " .. tostring(Role));
end;

function Compkiller:_PolishBinding(Element)
	local Bindings = self.Elements.Polish;
	if not Bindings[Element] then
		Bindings[Element] = {Properties = {}};
		Element.Destroying:Connect(function()
			Bindings[Element] = nil;
		end);
	end;
	return Bindings[Element];
end;

function Compkiller:_BindPolishColor(Element, Property, Role)
	self:_PolishBinding(Element).Properties[Property] = Role;
	Element[Property] = self:_PolishColor(Role);
end;

function Compkiller:_BindPolishUpdate(Element, Update)
	self:_PolishBinding(Element).Update = Update;
end;

function Compkiller:_RefreshPolishColors()
	for Element, Binding in pairs(self.Elements.Polish) do
		for Property, Role in pairs(Binding.Properties) do
			Element[Property] = self:_PolishColor(Role);
		end;
		if Binding.Update then Binding.Update(); end;
	end;
end;

local BrandIcons = setmetatable({}, {__mode = "k"});

function Compkiller:_CreateBrandIcon(Parent, Asset)
	local Image = Instance.new("ImageLabel");
	Image.BackgroundTransparency = 1;
	Image.Image = Asset or self.Logo;
	Image.Parent = Parent;
	BrandIcons[Image] = true;
	self:_BindPolishColor(Image, "ImageColor3", "Highlight");
	return Image;
end;

function Compkiller:_RestoreBrandBindings()
	-- Progress/notification icons may precede new(), which clears theme buckets.
	for Image in pairs(BrandIcons) do
		if Image.Parent then self:_BindPolishColor(Image, "ImageColor3", "Highlight"); end;
	end;
end;

Compkiller.Lucide = {
	['lucide-mouse-2'] = "rbxassetid://10088146939",
	['lucide-internet'] = "rbxassetid://12785195438",
	['lucide-earth'] = "rbxassetid://115986292591138",
	['lucide-settings-3'] = "rbxassetid://14007344336",
	["lucide-accessibility"] = "rbxassetid://10709751939",
	["lucide-activity"] = "rbxassetid://10709752035",
	["lucide-air-vent"] = "rbxassetid://10709752131",
	["lucide-airplay"] = "rbxassetid://10709752254",
	["lucide-alarm-check"] = "rbxassetid://10709752405",
	["lucide-alarm-clock"] = "rbxassetid://10709752630",
	["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
	["lucide-alarm-minus"] = "rbxassetid://10709752732",
	["lucide-alarm-plus"] = "rbxassetid://10709752825",
	["lucide-album"] = "rbxassetid://10709752906",
	["lucide-alert-circle"] = "rbxassetid://10709752996",
	["lucide-alert-octagon"] = "rbxassetid://10709753064",
	["lucide-alert-triangle"] = "rbxassetid://10709753149",
	["lucide-align-center"] = "rbxassetid://10709753570",
	["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
	["lucide-align-center-vertical"] = "rbxassetid://10709753421",
	["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
	["lucide-align-end-vertical"] = "rbxassetid://10709753808",
	["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
	["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
	["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
	["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
	["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
	["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
	["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
	["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
	["lucide-align-justify"] = "rbxassetid://10709759610",
	["lucide-align-left"] = "rbxassetid://10709759764",
	["lucide-align-right"] = "rbxassetid://10709759895",
	["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
	["lucide-align-start-vertical"] = "rbxassetid://10709760244",
	["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
	["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
	["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
	["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
	["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
	["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
	["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
	["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
	["lucide-anchor"] = "rbxassetid://10709761530",
	["lucide-angry"] = "rbxassetid://10709761629",
	["lucide-annoyed"] = "rbxassetid://10709761722",
	["lucide-aperture"] = "rbxassetid://10709761813",
	["lucide-apple"] = "rbxassetid://10709761889",
	["lucide-archive"] = "rbxassetid://10709762233",
	["lucide-archive-restore"] = "rbxassetid://10709762058",
	["lucide-armchair"] = "rbxassetid://10709762327",
	["lucide-arrow-big-down"] = "rbxassetid://10747796644",
	["lucide-arrow-big-left"] = "rbxassetid://10709762574",
	["lucide-arrow-big-right"] = "rbxassetid://10709762727",
	["lucide-arrow-big-up"] = "rbxassetid://10709762879",
	["lucide-arrow-down"] = "rbxassetid://10709767827",
	["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
	["lucide-arrow-down-left"] = "rbxassetid://10709767656",
	["lucide-arrow-down-right"] = "rbxassetid://10709767750",
	["lucide-arrow-left"] = "rbxassetid://10709768114",
	["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
	["lucide-arrow-left-right"] = "rbxassetid://10709768019",
	["lucide-arrow-right"] = "rbxassetid://10709768347",
	["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
	["lucide-arrow-up"] = "rbxassetid://10709768939",
	["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
	["lucide-arrow-up-down"] = "rbxassetid://10709768538",
	["lucide-arrow-up-left"] = "rbxassetid://10709768661",
	["lucide-arrow-up-right"] = "rbxassetid://10709768787",
	["lucide-asterisk"] = "rbxassetid://10709769095",
	["lucide-at-sign"] = "rbxassetid://10709769286",
	["lucide-award"] = "rbxassetid://10709769406",
	["lucide-axe"] = "rbxassetid://10709769508",
	["lucide-axis-3d"] = "rbxassetid://10709769598",
	["lucide-baby"] = "rbxassetid://10709769732",
	["lucide-backpack"] = "rbxassetid://10709769841",
	["lucide-baggage-claim"] = "rbxassetid://10709769935",
	["lucide-banana"] = "rbxassetid://10709770005",
	["lucide-banknote"] = "rbxassetid://10709770178",
	["lucide-bar-chart"] = "rbxassetid://10709773755",
	["lucide-bar-chart-2"] = "rbxassetid://10709770317",
	["lucide-bar-chart-3"] = "rbxassetid://10709770431",
	["lucide-bar-chart-4"] = "rbxassetid://10709770560",
	["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
	["lucide-barcode"] = "rbxassetid://10747360675",
	["lucide-baseline"] = "rbxassetid://10709773863",
	["lucide-bath"] = "rbxassetid://10709773963",
	["lucide-battery"] = "rbxassetid://10709774640",
	["lucide-battery-charging"] = "rbxassetid://10709774068",
	["lucide-battery-full"] = "rbxassetid://10709774206",
	["lucide-battery-low"] = "rbxassetid://10709774370",
	["lucide-battery-medium"] = "rbxassetid://10709774513",
	["lucide-beaker"] = "rbxassetid://10709774756",
	["lucide-bed"] = "rbxassetid://10709775036",
	["lucide-bed-double"] = "rbxassetid://10709774864",
	["lucide-bed-single"] = "rbxassetid://10709774968",
	["lucide-beer"] = "rbxassetid://10709775167",
	["lucide-bell"] = "rbxassetid://10709775704",
	["lucide-bell-minus"] = "rbxassetid://10709775241",
	["lucide-bell-off"] = "rbxassetid://10709775320",
	["lucide-bell-plus"] = "rbxassetid://10709775448",
	["lucide-bell-ring"] = "rbxassetid://10709775560",
	["lucide-bike"] = "rbxassetid://10709775894",
	["lucide-binary"] = "rbxassetid://10709776050",
	["lucide-bitcoin"] = "rbxassetid://10709776126",
	["lucide-bluetooth"] = "rbxassetid://10709776655",
	["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
	["lucide-bluetooth-off"] = "rbxassetid://10709776344",
	["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
	["lucide-bold"] = "rbxassetid://10747813908",
	["lucide-bomb"] = "rbxassetid://10709781460",
	["lucide-bone"] = "rbxassetid://10709781605",
	["lucide-book"] = "rbxassetid://10709781824",
	["lucide-book-open"] = "rbxassetid://10709781717",
	["lucide-bookmark"] = "rbxassetid://10709782154",
	["lucide-bookmark-minus"] = "rbxassetid://10709781919",
	["lucide-bookmark-plus"] = "rbxassetid://10709782044",
	["lucide-bot"] = "rbxassetid://10709782230",
	["lucide-box"] = "rbxassetid://10709782497",
	["lucide-box-select"] = "rbxassetid://10709782342",
	["lucide-boxes"] = "rbxassetid://10709782582",
	["lucide-briefcase"] = "rbxassetid://10709782662",
	["lucide-brush"] = "rbxassetid://10709782758",
	["lucide-bug"] = "rbxassetid://10709782845",
	["lucide-building"] = "rbxassetid://10709783051",
	["lucide-building-2"] = "rbxassetid://10709782939",
	["lucide-bus"] = "rbxassetid://10709783137",
	["lucide-cake"] = "rbxassetid://10709783217",
	["lucide-calculator"] = "rbxassetid://10709783311",
	["lucide-calendar"] = "rbxassetid://10709789505",
	["lucide-calendar-check"] = "rbxassetid://10709783474",
	["lucide-calendar-check-2"] = "rbxassetid://10709783392",
	["lucide-calendar-clock"] = "rbxassetid://10709783577",
	["lucide-calendar-days"] = "rbxassetid://10709783673",
	["lucide-calendar-heart"] = "rbxassetid://10709783835",
	["lucide-calendar-minus"] = "rbxassetid://10709783959",
	["lucide-calendar-off"] = "rbxassetid://10709788784",
	["lucide-calendar-plus"] = "rbxassetid://10709788937",
	["lucide-calendar-range"] = "rbxassetid://10709789053",
	["lucide-calendar-search"] = "rbxassetid://10709789200",
	["lucide-calendar-x"] = "rbxassetid://10709789407",
	["lucide-calendar-x-2"] = "rbxassetid://10709789329",
	["lucide-camera"] = "rbxassetid://10709789686",
	["lucide-camera-off"] = "rbxassetid://10747822677",
	["lucide-car"] = "rbxassetid://10709789810",
	["lucide-carrot"] = "rbxassetid://10709789960",
	["lucide-cast"] = "rbxassetid://10709790097",
	["lucide-charge"] = "rbxassetid://10709790202",
	["lucide-check"] = "rbxassetid://10709790644",
	["lucide-check-circle"] = "rbxassetid://10709790387",
	["lucide-check-circle-2"] = "rbxassetid://10709790298",
	["lucide-check-square"] = "rbxassetid://10709790537",
	["lucide-chef-hat"] = "rbxassetid://10709790757",
	["lucide-cherry"] = "rbxassetid://10709790875",
	["lucide-chevron-down"] = "rbxassetid://10709790948",
	["lucide-chevron-first"] = "rbxassetid://10709791015",
	["lucide-chevron-last"] = "rbxassetid://10709791130",
	["lucide-chevron-left"] = "rbxassetid://10709791281",
	["lucide-chevron-right"] = "rbxassetid://10709791437",
	["lucide-chevron-up"] = "rbxassetid://10709791523",
	["lucide-chevrons-down"] = "rbxassetid://10709796864",
	["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
	["lucide-chevrons-left"] = "rbxassetid://10709797151",
	["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
	["lucide-chevrons-right"] = "rbxassetid://10709797382",
	["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
	["lucide-chevrons-up"] = "rbxassetid://10709797622",
	["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
	["lucide-chrome"] = "rbxassetid://10709797725",
	["lucide-circle"] = "rbxassetid://10709798174",
	["lucide-circle-dot"] = "rbxassetid://10709797837",
	["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
	["lucide-circle-slashed"] = "rbxassetid://10709798100",
	["lucide-citrus"] = "rbxassetid://10709798276",
	["lucide-clapperboard"] = "rbxassetid://10709798350",
	["lucide-clipboard"] = "rbxassetid://10709799288",
	["lucide-clipboard-check"] = "rbxassetid://10709798443",
	["lucide-clipboard-copy"] = "rbxassetid://10709798574",
	["lucide-clipboard-edit"] = "rbxassetid://10709798682",
	["lucide-clipboard-list"] = "rbxassetid://10709798792",
	["lucide-clipboard-signature"] = "rbxassetid://10709798890",
	["lucide-clipboard-type"] = "rbxassetid://10709798999",
	["lucide-clipboard-x"] = "rbxassetid://10709799124",
	["lucide-clock"] = "rbxassetid://10709805144",
	["lucide-clock-1"] = "rbxassetid://10709799535",
	["lucide-clock-10"] = "rbxassetid://10709799718",
	["lucide-clock-11"] = "rbxassetid://10709799818",
	["lucide-clock-12"] = "rbxassetid://10709799962",
	["lucide-clock-2"] = "rbxassetid://10709803876",
	["lucide-clock-3"] = "rbxassetid://10709803989",
	["lucide-clock-4"] = "rbxassetid://10709804164",
	["lucide-clock-5"] = "rbxassetid://10709804291",
	["lucide-clock-6"] = "rbxassetid://10709804435",
	["lucide-clock-7"] = "rbxassetid://10709804599",
	["lucide-clock-8"] = "rbxassetid://10709804784",
	["lucide-clock-9"] = "rbxassetid://10709804996",
	["lucide-cloud"] = "rbxassetid://10709806740",
	["lucide-cloud-cog"] = "rbxassetid://10709805262",
	["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
	["lucide-cloud-fog"] = "rbxassetid://10709805477",
	["lucide-cloud-hail"] = "rbxassetid://10709805596",
	["lucide-cloud-lightning"] = "rbxassetid://10709805727",
	["lucide-cloud-moon"] = "rbxassetid://10709805942",
	["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
	["lucide-cloud-off"] = "rbxassetid://10709806060",
	["lucide-cloud-rain"] = "rbxassetid://10709806277",
	["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
	["lucide-cloud-snow"] = "rbxassetid://10709806374",
	["lucide-cloud-sun"] = "rbxassetid://10709806631",
	["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
	["lucide-cloudy"] = "rbxassetid://10709806859",
	["lucide-clover"] = "rbxassetid://10709806995",
	["lucide-code"] = "rbxassetid://10709810463",
	["lucide-code-2"] = "rbxassetid://10709807111",
	["lucide-codepen"] = "rbxassetid://10709810534",
	["lucide-codesandbox"] = "rbxassetid://10709810676",
	["lucide-coffee"] = "rbxassetid://10709810814",
	["lucide-cog"] = "rbxassetid://10709810948",
	["lucide-coins"] = "rbxassetid://10709811110",
	["lucide-columns"] = "rbxassetid://10709811261",
	["lucide-command"] = "rbxassetid://10709811365",
	["lucide-compass"] = "rbxassetid://10709811445",
	["lucide-component"] = "rbxassetid://10709811595",
	["lucide-concierge-bell"] = "rbxassetid://10709811706",
	["lucide-connection"] = "rbxassetid://10747361219",
	["lucide-contact"] = "rbxassetid://10709811834",
	["lucide-contrast"] = "rbxassetid://10709811939",
	["lucide-cookie"] = "rbxassetid://10709812067",
	["lucide-copy"] = "rbxassetid://10709812159",
	["lucide-copyleft"] = "rbxassetid://10709812251",
	["lucide-copyright"] = "rbxassetid://10709812311",
	["lucide-corner-down-left"] = "rbxassetid://10709812396",
	["lucide-corner-down-right"] = "rbxassetid://10709812485",
	["lucide-corner-left-down"] = "rbxassetid://10709812632",
	["lucide-corner-left-up"] = "rbxassetid://10709812784",
	["lucide-corner-right-down"] = "rbxassetid://10709812939",
	["lucide-corner-right-up"] = "rbxassetid://10709813094",
	["lucide-corner-up-left"] = "rbxassetid://10709813185",
	["lucide-corner-up-right"] = "rbxassetid://10709813281",
	["lucide-cpu"] = "rbxassetid://10709813383",
	["lucide-croissant"] = "rbxassetid://10709818125",
	["lucide-crop"] = "rbxassetid://10709818245",
	["lucide-cross"] = "rbxassetid://10709818399",
	["lucide-crosshair"] = "rbxassetid://10709818534",
	["lucide-crown"] = "rbxassetid://10709818626",
	["lucide-cup-soda"] = "rbxassetid://10709818763",
	["lucide-curly-braces"] = "rbxassetid://10709818847",
	["lucide-currency"] = "rbxassetid://10709818931",
	["lucide-database"] = "rbxassetid://10709818996",
	["lucide-delete"] = "rbxassetid://10709819059",
	["lucide-diamond"] = "rbxassetid://10709819149",
	["lucide-dice-1"] = "rbxassetid://10709819266",
	["lucide-dice-2"] = "rbxassetid://10709819361",
	["lucide-dice-3"] = "rbxassetid://10709819508",
	["lucide-dice-4"] = "rbxassetid://10709819670",
	["lucide-dice-5"] = "rbxassetid://10709819801",
	["lucide-dice-6"] = "rbxassetid://10709819896",
	["lucide-dices"] = "rbxassetid://10723343321",
	["lucide-diff"] = "rbxassetid://10723343416",
	["lucide-disc"] = "rbxassetid://10723343537",
	["lucide-divide"] = "rbxassetid://10723343805",
	["lucide-divide-circle"] = "rbxassetid://10723343636",
	["lucide-divide-square"] = "rbxassetid://10723343737",
	["lucide-dollar-sign"] = "rbxassetid://10723343958",
	["lucide-download"] = "rbxassetid://10723344270",
	["lucide-download-cloud"] = "rbxassetid://10723344088",
	["lucide-droplet"] = "rbxassetid://10723344432",
	["lucide-droplets"] = "rbxassetid://10734883356",
	["lucide-drumstick"] = "rbxassetid://10723344737",
	["lucide-edit"] = "rbxassetid://10734883598",
	["lucide-edit-2"] = "rbxassetid://10723344885",
	["lucide-edit-3"] = "rbxassetid://10723345088",
	["lucide-egg"] = "rbxassetid://10723345518",
	["lucide-egg-fried"] = "rbxassetid://10723345347",
	["lucide-electricity"] = "rbxassetid://10723345749",
	["lucide-electricity-off"] = "rbxassetid://10723345643",
	["lucide-equal"] = "rbxassetid://10723345990",
	["lucide-equal-not"] = "rbxassetid://10723345866",
	["lucide-eraser"] = "rbxassetid://10723346158",
	["lucide-euro"] = "rbxassetid://10723346372",
	["lucide-expand"] = "rbxassetid://10723346553",
	["lucide-external-link"] = "rbxassetid://10723346684",
	["lucide-eye"] = "rbxassetid://10723346959",
	["lucide-eye-off"] = "rbxassetid://10723346871",
	["lucide-factory"] = "rbxassetid://10723347051",
	["lucide-fan"] = "rbxassetid://10723354359",
	["lucide-fast-forward"] = "rbxassetid://10723354521",
	["lucide-feather"] = "rbxassetid://10723354671",
	["lucide-figma"] = "rbxassetid://10723354801",
	["lucide-file"] = "rbxassetid://10723374641",
	["lucide-file-archive"] = "rbxassetid://10723354921",
	["lucide-file-audio"] = "rbxassetid://10723355148",
	["lucide-file-audio-2"] = "rbxassetid://10723355026",
	["lucide-file-axis-3d"] = "rbxassetid://10723355272",
	["lucide-file-badge"] = "rbxassetid://10723355622",
	["lucide-file-badge-2"] = "rbxassetid://10723355451",
	["lucide-file-bar-chart"] = "rbxassetid://10723355887",
	["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
	["lucide-file-box"] = "rbxassetid://10723355989",
	["lucide-file-check"] = "rbxassetid://10723356210",
	["lucide-file-check-2"] = "rbxassetid://10723356100",
	["lucide-file-clock"] = "rbxassetid://10723356329",
	["lucide-file-code"] = "rbxassetid://10723356507",
	["lucide-file-cog"] = "rbxassetid://10723356830",
	["lucide-file-cog-2"] = "rbxassetid://10723356676",
	["lucide-file-diff"] = "rbxassetid://10723357039",
	["lucide-file-digit"] = "rbxassetid://10723357151",
	["lucide-file-down"] = "rbxassetid://10723357322",
	["lucide-file-edit"] = "rbxassetid://10723357495",
	["lucide-file-heart"] = "rbxassetid://10723357637",
	["lucide-file-image"] = "rbxassetid://10723357790",
	["lucide-file-input"] = "rbxassetid://10723357933",
	["lucide-file-json"] = "rbxassetid://10723364435",
	["lucide-file-json-2"] = "rbxassetid://10723364361",
	["lucide-file-key"] = "rbxassetid://10723364605",
	["lucide-file-key-2"] = "rbxassetid://10723364515",
	["lucide-file-line-chart"] = "rbxassetid://10723364725",
	["lucide-file-lock"] = "rbxassetid://10723364957",
	["lucide-file-lock-2"] = "rbxassetid://10723364861",
	["lucide-file-minus"] = "rbxassetid://10723365254",
	["lucide-file-minus-2"] = "rbxassetid://10723365086",
	["lucide-file-output"] = "rbxassetid://10723365457",
	["lucide-file-pie-chart"] = "rbxassetid://10723365598",
	["lucide-file-plus"] = "rbxassetid://10723365877",
	["lucide-file-plus-2"] = "rbxassetid://10723365766",
	["lucide-file-question"] = "rbxassetid://10723365987",
	["lucide-file-scan"] = "rbxassetid://10723366167",
	["lucide-file-search"] = "rbxassetid://10723366550",
	["lucide-file-search-2"] = "rbxassetid://10723366340",
	["lucide-file-signature"] = "rbxassetid://10723366741",
	["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
	["lucide-file-symlink"] = "rbxassetid://10723367098",
	["lucide-file-terminal"] = "rbxassetid://10723367244",
	["lucide-file-text"] = "rbxassetid://10723367380",
	["lucide-file-type"] = "rbxassetid://10723367606",
	["lucide-file-type-2"] = "rbxassetid://10723367509",
	["lucide-file-up"] = "rbxassetid://10723367734",
	["lucide-file-video"] = "rbxassetid://10723373884",
	["lucide-file-video-2"] = "rbxassetid://10723367834",
	["lucide-file-volume"] = "rbxassetid://10723374172",
	["lucide-file-volume-2"] = "rbxassetid://10723374030",
	["lucide-file-warning"] = "rbxassetid://10723374276",
	["lucide-file-x"] = "rbxassetid://10723374544",
	["lucide-file-x-2"] = "rbxassetid://10723374378",
	["lucide-files"] = "rbxassetid://10723374759",
	["lucide-film"] = "rbxassetid://10723374981",
	["lucide-filter"] = "rbxassetid://10723375128",
	["lucide-fingerprint"] = "rbxassetid://10723375250",
	["lucide-flag"] = "rbxassetid://10723375890",
	["lucide-flag-off"] = "rbxassetid://10723375443",
	["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
	["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
	["lucide-flame"] = "rbxassetid://10723376114",
	["lucide-flashlight"] = "rbxassetid://10723376471",
	["lucide-flashlight-off"] = "rbxassetid://10723376365",
	["lucide-flask-conical"] = "rbxassetid://10734883986",
	["lucide-flask-round"] = "rbxassetid://10723376614",
	["lucide-flip-horizontal"] = "rbxassetid://10723376884",
	["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
	["lucide-flip-vertical"] = "rbxassetid://10723377138",
	["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
	["lucide-flower"] = "rbxassetid://10747830374",
	["lucide-flower-2"] = "rbxassetid://10723377305",
	["lucide-focus"] = "rbxassetid://10723377537",
	["lucide-folder"] = "rbxassetid://10723387563",
	["lucide-folder-archive"] = "rbxassetid://10723384478",
	["lucide-folder-check"] = "rbxassetid://10723384605",
	["lucide-folder-clock"] = "rbxassetid://10723384731",
	["lucide-folder-closed"] = "rbxassetid://10723384893",
	["lucide-folder-cog"] = "rbxassetid://10723385213",
	["lucide-folder-cog-2"] = "rbxassetid://10723385036",
	["lucide-folder-down"] = "rbxassetid://10723385338",
	["lucide-folder-edit"] = "rbxassetid://10723385445",
	["lucide-folder-heart"] = "rbxassetid://10723385545",
	["lucide-folder-input"] = "rbxassetid://10723385721",
	["lucide-folder-key"] = "rbxassetid://10723385848",
	["lucide-folder-lock"] = "rbxassetid://10723386005",
	["lucide-folder-minus"] = "rbxassetid://10723386127",
	["lucide-folder-open"] = "rbxassetid://10723386277",
	["lucide-folder-output"] = "rbxassetid://10723386386",
	["lucide-folder-plus"] = "rbxassetid://10723386531",
	["lucide-folder-search"] = "rbxassetid://10723386787",
	["lucide-folder-search-2"] = "rbxassetid://10723386674",
	["lucide-folder-symlink"] = "rbxassetid://10723386930",
	["lucide-folder-tree"] = "rbxassetid://10723387085",
	["lucide-folder-up"] = "rbxassetid://10723387265",
	["lucide-folder-x"] = "rbxassetid://10723387448",
	["lucide-folders"] = "rbxassetid://10723387721",
	["lucide-form-input"] = "rbxassetid://10723387841",
	["lucide-forward"] = "rbxassetid://10723388016",
	["lucide-frame"] = "rbxassetid://10723394389",
	["lucide-framer"] = "rbxassetid://10723394565",
	["lucide-frown"] = "rbxassetid://10723394681",
	["lucide-fuel"] = "rbxassetid://10723394846",
	["lucide-function-square"] = "rbxassetid://10723395041",
	["lucide-gamepad"] = "rbxassetid://10723395457",
	["lucide-gamepad-2"] = "rbxassetid://10723395215",
	["lucide-gauge"] = "rbxassetid://10723395708",
	["lucide-gavel"] = "rbxassetid://10723395896",
	["lucide-gem"] = "rbxassetid://10723396000",
	["lucide-ghost"] = "rbxassetid://10723396107",
	["lucide-gift"] = "rbxassetid://10723396402",
	["lucide-gift-card"] = "rbxassetid://10723396225",
	["lucide-git-branch"] = "rbxassetid://10723396676",
	["lucide-git-branch-plus"] = "rbxassetid://10723396542",
	["lucide-git-commit"] = "rbxassetid://10723396812",
	["lucide-git-compare"] = "rbxassetid://10723396954",
	["lucide-git-fork"] = "rbxassetid://10723397049",
	["lucide-git-merge"] = "rbxassetid://10723397165",
	["lucide-git-pull-request"] = "rbxassetid://10723397431",
	["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
	["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
	["lucide-glass"] = "rbxassetid://10723397788",
	["lucide-glass-2"] = "rbxassetid://10723397529",
	["lucide-glass-water"] = "rbxassetid://10723397678",
	["lucide-glasses"] = "rbxassetid://10723397895",
	["lucide-globe"] = "rbxassetid://10723404337",
	["lucide-globe-2"] = "rbxassetid://10723398002",
	["lucide-grab"] = "rbxassetid://10723404472",
	["lucide-graduation-cap"] = "rbxassetid://10723404691",
	["lucide-grape"] = "rbxassetid://10723404822",
	["lucide-grid"] = "rbxassetid://10723404936",
	["lucide-grip-horizontal"] = "rbxassetid://10723405089",
	["lucide-grip-vertical"] = "rbxassetid://10723405236",
	["lucide-hammer"] = "rbxassetid://10723405360",
	["lucide-hand"] = "rbxassetid://10723405649",
	["lucide-hand-metal"] = "rbxassetid://10723405508",
	["lucide-hard-drive"] = "rbxassetid://10723405749",
	["lucide-hard-hat"] = "rbxassetid://10723405859",
	["lucide-hash"] = "rbxassetid://10723405975",
	["lucide-haze"] = "rbxassetid://10723406078",
	["lucide-headphones"] = "rbxassetid://10723406165",
	["lucide-heart"] = "rbxassetid://10723406885",
	["lucide-heart-crack"] = "rbxassetid://10723406299",
	["lucide-heart-handshake"] = "rbxassetid://10723406480",
	["lucide-heart-off"] = "rbxassetid://10723406662",
	["lucide-heart-pulse"] = "rbxassetid://10723406795",
	["lucide-help-circle"] = "rbxassetid://10723406988",
	["lucide-hexagon"] = "rbxassetid://10723407092",
	["lucide-highlighter"] = "rbxassetid://10723407192",
	["lucide-history"] = "rbxassetid://10723407335",
	["lucide-home"] = "rbxassetid://10723407389",
	["lucide-hourglass"] = "rbxassetid://10723407498",
	["lucide-ice-cream"] = "rbxassetid://10723414308",
	["lucide-image"] = "rbxassetid://10723415040",
	["lucide-image-minus"] = "rbxassetid://10723414487",
	["lucide-image-off"] = "rbxassetid://10723414677",
	["lucide-image-plus"] = "rbxassetid://10723414827",
	["lucide-import"] = "rbxassetid://10723415205",
	["lucide-inbox"] = "rbxassetid://10723415335",
	["lucide-indent"] = "rbxassetid://10723415494",
	["lucide-indian-rupee"] = "rbxassetid://10723415642",
	["lucide-infinity"] = "rbxassetid://10723415766",
	["lucide-info"] = "rbxassetid://10723415903",
	["lucide-inspect"] = "rbxassetid://10723416057",
	["lucide-italic"] = "rbxassetid://10723416195",
	["lucide-japanese-yen"] = "rbxassetid://10723416363",
	["lucide-joystick"] = "rbxassetid://10723416527",
	["lucide-key"] = "rbxassetid://10723416652",
	["lucide-keyboard"] = "rbxassetid://10723416765",
	["lucide-lamp"] = "rbxassetid://10723417513",
	["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
	["lucide-lamp-desk"] = "rbxassetid://10723417016",
	["lucide-lamp-floor"] = "rbxassetid://10723417131",
	["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
	["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
	["lucide-landmark"] = "rbxassetid://10723417608",
	["lucide-languages"] = "rbxassetid://10723417703",
	["lucide-laptop"] = "rbxassetid://10723423881",
	["lucide-laptop-2"] = "rbxassetid://10723417797",
	["lucide-lasso"] = "rbxassetid://10723424235",
	["lucide-lasso-select"] = "rbxassetid://10723424058",
	["lucide-laugh"] = "rbxassetid://10723424372",
	["lucide-layers"] = "rbxassetid://10723424505",
	["lucide-layout"] = "rbxassetid://10723425376",
	["lucide-layout-dashboard"] = "rbxassetid://10723424646",
	["lucide-layout-grid"] = "rbxassetid://10723424838",
	["lucide-layout-list"] = "rbxassetid://10723424963",
	["lucide-layout-template"] = "rbxassetid://10723425187",
	["lucide-leaf"] = "rbxassetid://10723425539",
	["lucide-library"] = "rbxassetid://10723425615",
	["lucide-life-buoy"] = "rbxassetid://10723425685",
	["lucide-lightbulb"] = "rbxassetid://10723425852",
	["lucide-lightbulb-off"] = "rbxassetid://10723425762",
	["lucide-line-chart"] = "rbxassetid://10723426393",
	["lucide-link"] = "rbxassetid://10723426722",
	["lucide-link-2"] = "rbxassetid://10723426595",
	["lucide-link-2-off"] = "rbxassetid://10723426513",
	["lucide-list"] = "rbxassetid://10723433811",
	["lucide-list-checks"] = "rbxassetid://10734884548",
	["lucide-list-end"] = "rbxassetid://10723426886",
	["lucide-list-minus"] = "rbxassetid://10723426986",
	["lucide-list-music"] = "rbxassetid://10723427081",
	["lucide-list-ordered"] = "rbxassetid://10723427199",
	["lucide-list-plus"] = "rbxassetid://10723427334",
	["lucide-list-start"] = "rbxassetid://10723427494",
	["lucide-list-video"] = "rbxassetid://10723427619",
	["lucide-list-x"] = "rbxassetid://10723433655",
	["lucide-loader"] = "rbxassetid://10723434070",
	["lucide-loader-2"] = "rbxassetid://10723433935",
	["lucide-locate"] = "rbxassetid://10723434557",
	["lucide-locate-fixed"] = "rbxassetid://10723434236",
	["lucide-locate-off"] = "rbxassetid://10723434379",
	["lucide-lock"] = "rbxassetid://10723434711",
	["lucide-log-in"] = "rbxassetid://10723434830",
	["lucide-log-out"] = "rbxassetid://10723434906",
	["lucide-luggage"] = "rbxassetid://10723434993",
	["lucide-magnet"] = "rbxassetid://10723435069",
	["lucide-mail"] = "rbxassetid://10734885430",
	["lucide-mail-check"] = "rbxassetid://10723435182",
	["lucide-mail-minus"] = "rbxassetid://10723435261",
	["lucide-mail-open"] = "rbxassetid://10723435342",
	["lucide-mail-plus"] = "rbxassetid://10723435443",
	["lucide-mail-question"] = "rbxassetid://10723435515",
	["lucide-mail-search"] = "rbxassetid://10734884739",
	["lucide-mail-warning"] = "rbxassetid://10734885015",
	["lucide-mail-x"] = "rbxassetid://10734885247",
	["lucide-mails"] = "rbxassetid://10734885614",
	["lucide-map"] = "rbxassetid://10734886202",
	["lucide-map-pin"] = "rbxassetid://10734886004",
	["lucide-map-pin-off"] = "rbxassetid://10734885803",
	["lucide-maximize"] = "rbxassetid://10734886735",
	["lucide-maximize-2"] = "rbxassetid://10734886496",
	["lucide-medal"] = "rbxassetid://10734887072",
	["lucide-megaphone"] = "rbxassetid://10734887454",
	["lucide-megaphone-off"] = "rbxassetid://10734887311",
	["lucide-meh"] = "rbxassetid://10734887603",
	["lucide-menu"] = "rbxassetid://10734887784",
	["lucide-message-circle"] = "rbxassetid://10734888000",
	["lucide-message-square"] = "rbxassetid://10734888228",
	["lucide-mic"] = "rbxassetid://10734888864",
	["lucide-mic-2"] = "rbxassetid://10734888430",
	["lucide-mic-off"] = "rbxassetid://10734888646",
	["lucide-microscope"] = "rbxassetid://10734889106",
	["lucide-microwave"] = "rbxassetid://10734895076",
	["lucide-milestone"] = "rbxassetid://10734895310",
	["lucide-minimize"] = "rbxassetid://10734895698",
	["lucide-minimize-2"] = "rbxassetid://10734895530",
	["lucide-minus"] = "rbxassetid://10734896206",
	["lucide-minus-circle"] = "rbxassetid://10734895856",
	["lucide-minus-square"] = "rbxassetid://10734896029",
	["lucide-monitor"] = "rbxassetid://10734896881",
	["lucide-monitor-off"] = "rbxassetid://10734896360",
	["lucide-monitor-speaker"] = "rbxassetid://10734896512",
	["lucide-moon"] = "rbxassetid://10734897102",
	["lucide-more-horizontal"] = "rbxassetid://10734897250",
	["lucide-more-vertical"] = "rbxassetid://10734897387",
	["lucide-mountain"] = "rbxassetid://10734897956",
	["lucide-mountain-snow"] = "rbxassetid://10734897665",
	["lucide-mouse"] = "rbxassetid://10734898592",
	["lucide-mouse-pointer"] = "rbxassetid://10734898476",
	["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
	["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
	["lucide-move"] = "rbxassetid://10734900011",
	["lucide-move-3d"] = "rbxassetid://10734898756",
	["lucide-move-diagonal"] = "rbxassetid://10734899164",
	["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
	["lucide-move-horizontal"] = "rbxassetid://10734899414",
	["lucide-move-vertical"] = "rbxassetid://10734899821",
	["lucide-music"] = "rbxassetid://10734905958",
	["lucide-music-2"] = "rbxassetid://10734900215",
	["lucide-music-3"] = "rbxassetid://10734905665",
	["lucide-music-4"] = "rbxassetid://10734905823",
	["lucide-navigation"] = "rbxassetid://10734906744",
	["lucide-navigation-2"] = "rbxassetid://10734906332",
	["lucide-navigation-2-off"] = "rbxassetid://10734906144",
	["lucide-navigation-off"] = "rbxassetid://10734906580",
	["lucide-network"] = "rbxassetid://10734906975",
	["lucide-newspaper"] = "rbxassetid://10734907168",
	["lucide-octagon"] = "rbxassetid://10734907361",
	["lucide-option"] = "rbxassetid://10734907649",
	["lucide-outdent"] = "rbxassetid://10734907933",
	["lucide-package"] = "rbxassetid://10734909540",
	["lucide-package-2"] = "rbxassetid://10734908151",
	["lucide-package-check"] = "rbxassetid://10734908384",
	["lucide-package-minus"] = "rbxassetid://10734908626",
	["lucide-package-open"] = "rbxassetid://10734908793",
	["lucide-package-plus"] = "rbxassetid://10734909016",
	["lucide-package-search"] = "rbxassetid://10734909196",
	["lucide-package-x"] = "rbxassetid://10734909375",
	["lucide-paint-bucket"] = "rbxassetid://10734909847",
	["lucide-paintbrush"] = "rbxassetid://10734910187",
	["lucide-paintbrush-2"] = "rbxassetid://10734910030",
	["lucide-palette"] = "rbxassetid://10734910430",
	["lucide-palmtree"] = "rbxassetid://10734910680",
	["lucide-paperclip"] = "rbxassetid://10734910927",
	["lucide-party-popper"] = "rbxassetid://10734918735",
	["lucide-pause"] = "rbxassetid://10734919336",
	["lucide-pause-circle"] = "rbxassetid://10735024209",
	["lucide-pause-octagon"] = "rbxassetid://10734919143",
	["lucide-pen-tool"] = "rbxassetid://10734919503",
	["lucide-pencil"] = "rbxassetid://10734919691",
	["lucide-percent"] = "rbxassetid://10734919919",
	["lucide-person-standing"] = "rbxassetid://6022668898",
	["lucide-phone"] = "rbxassetid://10734921524",
	["lucide-phone-call"] = "rbxassetid://10734920305",
	["lucide-phone-forwarded"] = "rbxassetid://10734920508",
	["lucide-phone-incoming"] = "rbxassetid://10734920694",
	["lucide-phone-missed"] = "rbxassetid://10734920845",
	["lucide-phone-off"] = "rbxassetid://10734921077",
	["lucide-phone-outgoing"] = "rbxassetid://10734921288",
	["lucide-pie-chart"] = "rbxassetid://10734921727",
	["lucide-piggy-bank"] = "rbxassetid://10734921935",
	["lucide-pin"] = "rbxassetid://10734922324",
	["lucide-pin-off"] = "rbxassetid://10734922180",
	["lucide-pipette"] = "rbxassetid://10734922497",
	["lucide-pizza"] = "rbxassetid://10734922774",
	["lucide-plane"] = "rbxassetid://10734922971",
	["lucide-play"] = "rbxassetid://10734923549",
	["lucide-play-circle"] = "rbxassetid://10734923214",
	["lucide-plus"] = "rbxassetid://10734924532",
	["lucide-plus-circle"] = "rbxassetid://10734923868",
	["lucide-plus-square"] = "rbxassetid://10734924219",
	["lucide-podcast"] = "rbxassetid://10734929553",
	["lucide-pointer"] = "rbxassetid://10734929723",
	["lucide-pound-sterling"] = "rbxassetid://10734929981",
	["lucide-power"] = "rbxassetid://10734930466",
	["lucide-power-off"] = "rbxassetid://10734930257",
	["lucide-printer"] = "rbxassetid://10734930632",
	["lucide-puzzle"] = "rbxassetid://10734930886",
	["lucide-quote"] = "rbxassetid://10734931234",
	["lucide-radio"] = "rbxassetid://10734931596",
	["lucide-radio-receiver"] = "rbxassetid://10734931402",
	["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
	["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
	["lucide-recycle"] = "rbxassetid://10734932295",
	["lucide-redo"] = "rbxassetid://10734932822",
	["lucide-redo-2"] = "rbxassetid://10734932586",
	["lucide-refresh-ccw"] = "rbxassetid://10734933056",
	["lucide-refresh-cw"] = "rbxassetid://10734933222",
	["lucide-refrigerator"] = "rbxassetid://10734933465",
	["lucide-regex"] = "rbxassetid://10734933655",
	["lucide-repeat"] = "rbxassetid://10734933966",
	["lucide-repeat-1"] = "rbxassetid://10734933826",
	["lucide-reply"] = "rbxassetid://10734934252",
	["lucide-reply-all"] = "rbxassetid://10734934132",
	["lucide-rewind"] = "rbxassetid://10734934347",
	["lucide-rocket"] = "rbxassetid://10734934585",
	["lucide-rocking-chair"] = "rbxassetid://10734939942",
	["lucide-rotate-3d"] = "rbxassetid://10734940107",
	["lucide-rotate-ccw"] = "rbxassetid://10734940376",
	["lucide-rotate-cw"] = "rbxassetid://10734940654",
	["lucide-rss"] = "rbxassetid://10734940825",
	["lucide-ruler"] = "rbxassetid://10734941018",
	["lucide-russian-ruble"] = "rbxassetid://10734941199",
	["lucide-sailboat"] = "rbxassetid://10734941354",
	["lucide-save"] = "rbxassetid://10734941499",
	["lucide-scale"] = "rbxassetid://10734941912",
	["lucide-scale-3d"] = "rbxassetid://10734941739",
	["lucide-scaling"] = "rbxassetid://10734942072",
	["lucide-scan"] = "rbxassetid://10734942565",
	["lucide-scan-face"] = "rbxassetid://10734942198",
	["lucide-scan-line"] = "rbxassetid://10734942351",
	["lucide-scissors"] = "rbxassetid://10734942778",
	["lucide-screen-share"] = "rbxassetid://10734943193",
	["lucide-screen-share-off"] = "rbxassetid://10734942967",
	["lucide-scroll"] = "rbxassetid://10734943448",
	["lucide-search"] = "rbxassetid://10734943674",
	["lucide-send"] = "rbxassetid://10734943902",
	["lucide-separator-horizontal"] = "rbxassetid://10734944115",
	["lucide-separator-vertical"] = "rbxassetid://10734944326",
	["lucide-server"] = "rbxassetid://10734949856",
	["lucide-server-cog"] = "rbxassetid://10734944444",
	["lucide-server-crash"] = "rbxassetid://10734944554",
	["lucide-server-off"] = "rbxassetid://10734944668",
	["lucide-settings"] = "rbxassetid://10734950309",
	["lucide-settings-2"] = "rbxassetid://10734950020",
	["lucide-share"] = "rbxassetid://10734950813",
	["lucide-share-2"] = "rbxassetid://10734950553",
	["lucide-sheet"] = "rbxassetid://10734951038",
	["lucide-shield"] = "rbxassetid://10734951847",
	["lucide-shield-alert"] = "rbxassetid://10734951173",
	["lucide-shield-check"] = "rbxassetid://10734951367",
	["lucide-shield-close"] = "rbxassetid://10734951535",
	["lucide-shield-off"] = "rbxassetid://10734951684",
	["lucide-shirt"] = "rbxassetid://10734952036",
	["lucide-shopping-bag"] = "rbxassetid://10734952273",
	["lucide-shopping-cart"] = "rbxassetid://10734952479",
	["lucide-shovel"] = "rbxassetid://10734952773",
	["lucide-shower-head"] = "rbxassetid://10734952942",
	["lucide-shrink"] = "rbxassetid://10734953073",
	["lucide-shrub"] = "rbxassetid://10734953241",
	["lucide-shuffle"] = "rbxassetid://10734953451",
	["lucide-sidebar"] = "rbxassetid://10734954301",
	["lucide-sidebar-close"] = "rbxassetid://10734953715",
	["lucide-sidebar-open"] = "rbxassetid://10734954000",
	["lucide-sigma"] = "rbxassetid://10734954538",
	["lucide-signal"] = "rbxassetid://10734961133",
	["lucide-signal-high"] = "rbxassetid://10734954807",
	["lucide-signal-low"] = "rbxassetid://10734955080",
	["lucide-signal-medium"] = "rbxassetid://10734955336",
	["lucide-signal-zero"] = "rbxassetid://10734960878",
	["lucide-siren"] = "rbxassetid://10734961284",
	["lucide-skip-back"] = "rbxassetid://10734961526",
	["lucide-skip-forward"] = "rbxassetid://10734961809",
	["lucide-skull"] = "rbxassetid://10734962068",
	["lucide-slack"] = "rbxassetid://10734962339",
	["lucide-slash"] = "rbxassetid://10734962600",
	["lucide-slice"] = "rbxassetid://10734963024",
	["lucide-sliders"] = "rbxassetid://10734963400",
	["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
	["lucide-smartphone"] = "rbxassetid://10734963940",
	["lucide-smartphone-charging"] = "rbxassetid://10734963671",
	["lucide-smile"] = "rbxassetid://10734964441",
	["lucide-smile-plus"] = "rbxassetid://10734964188",
	["lucide-snowflake"] = "rbxassetid://10734964600",
	["lucide-sofa"] = "rbxassetid://10734964852",
	["lucide-sort-asc"] = "rbxassetid://10734965115",
	["lucide-sort-desc"] = "rbxassetid://10734965287",
	["lucide-speaker"] = "rbxassetid://10734965419",
	["lucide-sprout"] = "rbxassetid://10734965572",
	["lucide-square"] = "rbxassetid://10734965702",
	["lucide-star"] = "rbxassetid://10734966248",
	["lucide-star-half"] = "rbxassetid://10734965897",
	["lucide-star-off"] = "rbxassetid://10734966097",
	["lucide-stethoscope"] = "rbxassetid://10734966384",
	["lucide-sticker"] = "rbxassetid://10734972234",
	["lucide-sticky-note"] = "rbxassetid://10734972463",
	["lucide-stop-circle"] = "rbxassetid://10734972621",
	["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
	["lucide-stretch-vertical"] = "rbxassetid://10734973130",
	["lucide-strikethrough"] = "rbxassetid://10734973290",
	["lucide-subscript"] = "rbxassetid://10734973457",
	["lucide-sun"] = "rbxassetid://10734974297",
	["lucide-sun-dim"] = "rbxassetid://10734973645",
	["lucide-sun-medium"] = "rbxassetid://10734973778",
	["lucide-sun-moon"] = "rbxassetid://10734973999",
	["lucide-sun-snow"] = "rbxassetid://10734974130",
	["lucide-sunrise"] = "rbxassetid://10734974522",
	["lucide-sunset"] = "rbxassetid://10734974689",
	["lucide-superscript"] = "rbxassetid://10734974850",
	["lucide-swiss-franc"] = "rbxassetid://10734975024",
	["lucide-switch-camera"] = "rbxassetid://10734975214",
	["lucide-sword"] = "rbxassetid://10734975486",
	["lucide-swords"] = "rbxassetid://10734975692",
	["lucide-syringe"] = "rbxassetid://10734975932",
	["lucide-table"] = "rbxassetid://10734976230",
	["lucide-table-2"] = "rbxassetid://10734976097",
	["lucide-tablet"] = "rbxassetid://10734976394",
	["lucide-tag"] = "rbxassetid://10734976528",
	["lucide-tags"] = "rbxassetid://10734976739",
	["lucide-target"] = "rbxassetid://10734977012",
	["lucide-tent"] = "rbxassetid://10734981750",
	["lucide-terminal"] = "rbxassetid://10734982144",
	["lucide-terminal-square"] = "rbxassetid://10734981995",
	["lucide-text-cursor"] = "rbxassetid://10734982395",
	["lucide-text-cursor-input"] = "rbxassetid://10734982297",
	["lucide-thermometer"] = "rbxassetid://10734983134",
	["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
	["lucide-thermometer-sun"] = "rbxassetid://10734982771",
	["lucide-thumbs-down"] = "rbxassetid://10734983359",
	["lucide-thumbs-up"] = "rbxassetid://10734983629",
	["lucide-ticket"] = "rbxassetid://10734983868",
	["lucide-timer"] = "rbxassetid://10734984606",
	["lucide-timer-off"] = "rbxassetid://10734984138",
	["lucide-timer-reset"] = "rbxassetid://10734984355",
	["lucide-toggle-left"] = "rbxassetid://10734984834",
	["lucide-toggle-right"] = "rbxassetid://10734985040",
	["lucide-tornado"] = "rbxassetid://10734985247",
	["lucide-toy-brick"] = "rbxassetid://10747361919",
	["lucide-train"] = "rbxassetid://10747362105",
	["lucide-trash"] = "rbxassetid://10747362393",
	["lucide-trash-2"] = "rbxassetid://10747362241",
	["lucide-tree-deciduous"] = "rbxassetid://10747362534",
	["lucide-tree-pine"] = "rbxassetid://10747362748",
	["lucide-trees"] = "rbxassetid://10747363016",
	["lucide-trending-down"] = "rbxassetid://10747363205",
	["lucide-trending-up"] = "rbxassetid://10747363465",
	["lucide-triangle"] = "rbxassetid://10747363621",
	["lucide-trophy"] = "rbxassetid://10747363809",
	["lucide-truck"] = "rbxassetid://10747364031",
	["lucide-tv"] = "rbxassetid://10747364593",
	["lucide-tv-2"] = "rbxassetid://10747364302",
	["lucide-type"] = "rbxassetid://10747364761",
	["lucide-umbrella"] = "rbxassetid://10747364971",
	["lucide-underline"] = "rbxassetid://10747365191",
	["lucide-undo"] = "rbxassetid://10747365484",
	["lucide-undo-2"] = "rbxassetid://10747365359",
	["lucide-unlink"] = "rbxassetid://10747365771",
	["lucide-unlink-2"] = "rbxassetid://10747397871",
	["lucide-unlock"] = "rbxassetid://10747366027",
	["lucide-upload"] = "rbxassetid://10747366434",
	["lucide-upload-cloud"] = "rbxassetid://10747366266",
	["lucide-usb"] = "rbxassetid://10747366606",
	["lucide-user"] = "rbxassetid://10747373176",
	["lucide-user-check"] = "rbxassetid://10747371901",
	["lucide-user-cog"] = "rbxassetid://10747372167",
	["lucide-user-minus"] = "rbxassetid://10747372346",
	["lucide-user-plus"] = "rbxassetid://10747372702",
	["lucide-user-x"] = "rbxassetid://10747372992",
	["lucide-users"] = "rbxassetid://10747373426",
	["lucide-utensils"] = "rbxassetid://10747373821",
	["lucide-utensils-crossed"] = "rbxassetid://10747373629",
	["lucide-venetian-mask"] = "rbxassetid://10747374003",
	["lucide-verified"] = "rbxassetid://10747374131",
	["lucide-vibrate"] = "rbxassetid://10747374489",
	["lucide-vibrate-off"] = "rbxassetid://10747374269",
	["lucide-video"] = "rbxassetid://10747374938",
	["lucide-video-off"] = "rbxassetid://10747374721",
	["lucide-view"] = "rbxassetid://10747375132",
	["lucide-voicemail"] = "rbxassetid://10747375281",
	["lucide-volume"] = "rbxassetid://10747376008",
	["lucide-volume-1"] = "rbxassetid://10747375450",
	["lucide-volume-2"] = "rbxassetid://10747375679",
	["lucide-volume-x"] = "rbxassetid://10747375880",
	["lucide-wallet"] = "rbxassetid://10747376205",
	["lucide-wand"] = "rbxassetid://10747376565",
	["lucide-wand-2"] = "rbxassetid://10747376349",
	["lucide-watch"] = "rbxassetid://10747376722",
	["lucide-waves"] = "rbxassetid://10747376931",
	["lucide-webcam"] = "rbxassetid://10747381992",
	["lucide-wifi"] = "rbxassetid://10747382504",
	["lucide-wifi-off"] = "rbxassetid://10747382268",
	["lucide-wind"] = "rbxassetid://10747382750",
	["lucide-wrap-text"] = "rbxassetid://10747383065",
	["lucide-wrench"] = "rbxassetid://10747383470",
	["lucide-x"] = "rbxassetid://10747384394",
	["lucide-x-circle"] = "rbxassetid://10747383819",
	["lucide-x-octagon"] = "rbxassetid://10747384037",
	["lucide-x-square"] = "rbxassetid://10747384217",
	["lucide-zoom-in"] = "rbxassetid://10747384552",
	["lucide-zoom-out"] = "rbxassetid://10747384679",
};

Compkiller.FontAwesome = {
	a = "rbxassetid://74244459944328",
	['accessible-icon'] = "rbxassetid://135242143909610",
	accusoft = "rbxassetid://94057545767519",
	['address-book'] = "rbxassetid://129578640498728",
	['address-card'] = 'rbxassetid://102106715141928',
	['align-center'] = "rbxassetid://84408132800466",
	['align-justify'] = "rbxassetid://125569339749500",
	['align-left'] = "rbxassetid://110008004178539",
	['align-right'] = "rbxassetid://79774893981710",
	alipay = "rbxassetid://134274199490629",
	anchor = "rbxassetid://94979524088900",
	['anchor-circle-check'] = "rbxassetid://91871463373335",
	['anchor-circle-exclamation'] = "rbxassetid://72303311082053",
	['anchor-circle-xmark'] = "rbxassetid://106917001300524",
	['anchor-lock'] = "rbxassetid://109198662645391",
	android = "rbxassetid://93605821179752",
	['angle-down'] = "rbxassetid://122395101934469",
	['angle-left'] = "rbxassetid://132632410309959",
	['angle-right'] = "rbxassetid://105971664068240",
	['angles-down'] = "rbxassetid://96703500127872",
	['angles-left'] = "rbxassetid://70595546989447",
	['angles-right'] = "rbxassetid://131176182882747",
	['angles-up'] = "rbxassetid://96847020381396",
	['angle-up'] = "rbxassetid://136517226470297",
	['arrow-down'] = "rbxassetid://100174052036797",
	['arrow-left'] = "rbxassetid://133922718486450",
	['arrow-pointer'] = "rbxassetid://128639550333559",
	['arrow-right'] = 'rbxassetid://105166519175969',
	['arrow-right-arrow-left'] = "rbxassetid://87405428139040",
	['arrow-right-from-bracket'] = "rbxassetid://111722018253482",
	['arrow-right-to-bracket'] = "rbxassetid://79400903745367",
	['arrow-rotate-left'] = "rbxassetid://127876635051023",
	['arrow-rotate-right'] = "rbxassetid://82773599534347",
	['arrows-left-right'] = "rbxassetid://85625938291926",
	['arrows-rotate'] = "rbxassetid://109882153776270",
	['arrows-up-down'] = "rbxassetid://88240470530518",
	['arrows-up-down-left-right'] = "rbxassetid://136830364721572",
	['arrow-trend-down'] = "rbxassetid://138593805214121",
	['arrow-trend-up'] = "rbxassetid://121301107868410",
	['arrow-up'] = "rbxassetid://116473498857626",
	['arrow-up-from-bracket'] = "rbxassetid://77716847027695",
	['arrow-up-right-from-square'] = "rbxassetid://101883941536459",
	at = "rbxassetid://116468402170315",
	atom = "rbxassetid://136905279132440",
	['audio-description'] = 'rbxassetid://137490376195308',
	award = "rbxassetid://134322732056464",
	backward = "rbxassetid://115437448962693",
	['backward-fast'] = "rbxassetid://133478473989228",
	['backward-step'] = "rbxassetid://118301206125870",
	ban = "rbxassetid://89004310664420",
	bandage = "rbxassetid://109104902535966",
	bars = "rbxassetid://127661324755454",
	['bars-progress'] = "rbxassetid://77774174241071",
	['bars-staggered'] = "rbxassetid://97337529919486",
	baseball = "rbxassetid://87677782809968",
	basketball = "rbxassetid://71403045563776",
	['basket-shopping'] = "rbxassetid://129578273645224",
	['battery-empty'] = "rbxassetid://99777750808099",
	['battery-full'] = "rbxassetid://93999278270214",
	['battery-half'] = "rbxassetid://87762099115036",
	['battery-quarter'] = "rbxassetid://96680551535938",
	['battery-three-quarters'] = "rbxassetid://130840615974067",
	bell = "rbxassetid://109971903438934",
	['bell-slash'] = "rbxassetid://101758939103378",
	bilibili = "rbxassetid://85834752961243",
	biohazard = "rbxassetid://102610067899783",
	bitcoin = "rbxassetid://131632152157382",
	['bitcoin-sign'] = "rbxassetid://127809070259506",
	['bluetooth-b'] = "rbxassetid://96522278309021",
	bluetooth = "rbxassetid://113081372628241",
	bolt = "rbxassetid://89858717966393",
	bomb = "rbxassetid://113184250292244",
	book = "rbxassetid://134006112957521",
	['book-open'] = "rbxassetid://109774137257967",
	bug = "rbxassetid://105314179657552",
	['bug-slash'] = "rbxassetid://133973969610093",
	broom = "rbxassetid://95267009545395",
	bullhorn = "rbxassetid://87251830910561",
	['bullseye'] = "rbxassetid://83080500555400",
	bus = "rbxassetid://126579638968493",
	calculator = "rbxassetid://119527046782470",
	camera = "rbxassetid://133029797251962",
	['cc-amazon-pay'] = "rbxassetid://108859760370504",
	['cc-amex'] = "rbxassetid://138233598058785",
	['cc-apple-pay'] = "rbxassetid://133747941882534",
	['cc-diners-club'] = "rbxassetid://99626539664553",
	['cc-mastercard'] = "rbxassetid://118541621561504",
	['cc-visa'] = "rbxassetid://120055576031063",
	['cc-paypal'] = "rbxassetid://87250418163030",
	check = "rbxassetid://129443092324752",
	['chevron-down'] = "rbxassetid://109535175596957",
	['chevron-left'] = "rbxassetid://129113930144228",
	['chevron-right'] = "rbxassetid://105723602996553",
	['chevron-up'] = "rbxassetid://117264500851637",
	chromecast = "rbxassetid://71543589030583",
	circle = "rbxassetid://131274957777266",
	['circle-check'] = "rbxassetid://98678528147000",
	['circle-info'] = "rbxassetid://97519285421665",
	clipboard = 'rbxassetid://111512950362265',
	['clipboard-check'] = "rbxassetid://118535733506457",
	clock = "rbxassetid://98767608471295",
	code = "rbxassetid://91882036126433",
	['computer-mouse'] = "rbxassetid://114752565381440",
	cookie = "rbxassetid://101854685117513",
	copy = "rbxassetid://76996819137437",
	copyright = "rbxassetid://131736117717053",
	['credit-card'] = "rbxassetid://85213342061383",
	['crosshairs'] = "rbxassetid://133441774847498",
	database = "rbxassetid://109882554524389",
	discord = "rbxassetid://75871011309830",
	display = "rbxassetid://101851152220134",
	download = "rbxassetid://122321311031549",
	['earth-africa'] = "rbxassetid://107029199584204",
	['earth-americas'] = "rbxassetid://105574352653407",
	['earth-asia'] = "rbxassetid://138155660327900",
	['earth-europe'] = "rbxassetid://134638370907021",
	['earth-oceania'] = "rbxassetid://121780690380624",
	envelope = "rbxassetid://136184483524922",
	['envelope-open'] = "rbxassetid://132492127839357",
	envira = "rbxassetid://75781570526788",
	equals = "rbxassetid://134271902308970",
	eraser = "rbxassetid://128970640154301",
	ethereum = "rbxassetid://103421769879532",
	exclamation = "rbxassetid://125718656366676",
	eye = "rbxassetid://95235861336970",
	feather = "rbxassetid://135995843954302",
	fingerprint = "rbxassetid://125379360015007",
	fire = "rbxassetid://122498238725085",
	['floppy-disk'] = "rbxassetid://101374426361499",
	folder = "rbxassetid://131374292202389",
	['folder-open'] = "rbxassetid://78238714442180",
	forward = "rbxassetid://107937467448020",
	['forward-fast'] = "rbxassetid://83735840669276",
	['forward-step'] = "rbxassetid://104040171143566",
	gear = "rbxassetid://137945854328407",
	gift = "rbxassetid://129718366414314",
	git = "rbxassetid://117711060446092",
	github = "rbxassetid://123783733365919",
	globe = "rbxassetid://102861769355196",
	['hand-holding-hand'] = "rbxassetid://120797412134954",
	headphones = "rbxassetid://86076153665072",
	headset = "rbxassetid://108070801288944",
	['headphones-simple'] = "rbxassetid://97516570978183",
	house = "rbxassetid://86540166012974",
	['house-chimney'] = "rbxassetid://90066192203346",
	image = "rbxassetid://107205506080751",
	infinity = "rbxassetid://129024756905166",
	info = "rbxassetid://113157514619684",
	keyboard = "rbxassetid://97417417526948",
	list = "rbxassetid://87155993544457",
	['location-arrow'] = "rbxassetid://72621673664457",
	['location-crosshairs'] = "rbxassetid://93887450723164",
	lock = 'rbxassetid://80031239225283',
	palette = "rbxassetid://81372281623830",
	paste = "rbxassetid://88846256867074",
	paw = "rbxassetid://80005916079930",
	pen = "rbxassetid://97404859124912",
	pencil = "rbxassetid://76590960968733",
	['pen-nib'] = "rbxassetid://91232219924341",
	['pen-ruler'] = "rbxassetid://138407458813207",
	phone = "rbxassetid://72814141651992",
	plane = "rbxassetid://136248807279679",
	plus = "rbxassetid://133137619535544",
	['right-left'] = "rbxassetid://91273051324368",
	['right-to-bracket'] = "rbxassetid://137132451900886",
	rotate = "rbxassetid://95883878890200",
	['rotate-right'] = "rbxassetid://93357988077552",
	['rotate-left'] = "rbxassetid://96753646113822",
	shield = "rbxassetid://73441026473893",
	['shield-halved'] = "rbxassetid://114554606211174",
	user = "rbxassetid://98376828270066",
	unlock = "rbxassetid://99060354229117",
	trash = "rbxassetid://82859108629080",
	['trash-can'] = "rbxassetid://81463703129214",
	skull = "rbxassetid://99276754296574",
	robot = "rbxassetid://134497060038109",
	tag = "rbxassetid://129024358125754",
	thumbtack = "rbxassetid://119847869089109",
	['thumbs-up'] = "rbxassetid://74340984021785",
	['thumbs-down'] = "rbxassetid://86090492737223",
	['user-gear'] = "rbxassetid://137604201056497",
	video = "rbxassetid://112274059143251",
	virus = "rbxassetid://91843339206686",
	volleyball = "rbxassetid://73870192536894",
	['magnifying-glass'] = "rbxassetid://74387839235930",
};

Compkiller.IconAliases = {["house"]="home",["grid-2x2"]="grid",["arrow-down-up"]="arrow-up-down",["circle-check"]="check-circle-2",["circle-x"]="x-circle",["triangle-alert"]="alert-triangle",["loader-circle"]="loader-2",["lock-keyhole"]="lock",["wand-sparkles"]="wand-2"};
function Compkiller:_GetIcon(name : string , font_aws) : string
	if font_aws then
		return Compkiller.FontAwesome[name] or name;
	end;

	local plain = tostring(name):gsub("^lucide%-", "");
	name = Compkiller.IconAliases[plain] or name;
	return Compkiller.Lucide['lucide-'..tostring(name)] or Compkiller.Lucide[name] or Compkiller.Lucide[tostring(name)] or Compkiller.FontAwesome[name] or name;
end;

-- Land Plot, adapted from https://lucide.dev/icons/land-plot (24x24, stroke 2).
-- ISC License: Copyright (c) 2026 Lucide Icons and Contributors
-- Permission to use, copy, modify, and/or distribute this software for any purpose
-- with or without fee is hereby granted, provided that the above copyright notice
-- and this permission notice appear in all copies.
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
-- REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
-- FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
-- INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
-- OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
-- TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
-- THIS SOFTWARE.
function Compkiller:_DrawLandPlotIcon(icon)
    icon.Image = "";
    local outline = Instance.new("Frame");
    outline.Name, outline.BackgroundTransparency = "LucideOutline", 1;
    outline.Size, outline.Parent = UDim2.fromScale(1,1), icon;
    local strokes = {};
    -- Flag, plot boundary (rounded arc samples), and the two plot grid lines.
    local paths = {
        {{12,8},{18,5},{12,2},{12,12}},
        {{8,11.99},{2.5,15.13},{2.13,15.5},{1.99,16},{2.13,16.5},{2.5,16.87},
            {11,21.73},{11.48,21.93},{12,22},{12.52,21.93},{13,21.73},
            {21.5,16.87},{21.87,16.5},{22.01,16},{21.87,15.5},{21.5,15.13},{16,12}},
        {{6.49,12.85},{17.51,19.15}},
        {{17.51,12.85},{6.5,19.15}},
    };
    for _, path in ipairs(paths) do
        for index = 2, #path do
            local a, b = path[index-1], path[index];
            local dx, dy = b[1]-a[1], b[2]-a[2];
            local stroke = Instance.new("Frame");
            stroke.Name = "LandPlotStroke";
            stroke.AnchorPoint = Vector2.new(0.5,0.5);
            stroke.Position = UDim2.fromScale((a[1]+b[1])/48,(a[2]+b[2])/48);
            stroke.Size = UDim2.fromScale((math.sqrt(dx*dx+dy*dy)+2)/24,2/24);
            stroke.Rotation = math.deg(math.atan2(dy,dx));
            stroke.BackgroundColor3 = icon.ImageColor3;
            stroke.BorderSizePixel = 0;
            stroke.ZIndex = icon.ZIndex;
            stroke.Parent = outline;
            local corner = Instance.new("UICorner",stroke);
            corner.CornerRadius = UDim.new(1,0);
            table.insert(strokes,stroke);
        end;
    end;
    local function sync()
        outline.ZIndex = icon.ZIndex;
        for _, stroke in ipairs(strokes) do
            stroke.BackgroundColor3, stroke.BackgroundTransparency, stroke.ZIndex = icon.ImageColor3, icon.ImageTransparency, icon.ZIndex;
        end;
    end;
    local connections = {};
    for _, property in ipairs({"ImageColor3","ImageTransparency","ZIndex"}) do
        table.insert(connections,icon:GetPropertyChangedSignal(property):Connect(sync));
    end;
    outline.Destroying:Connect(function() for _, connection in ipairs(connections) do connection:Disconnect(); end; end);
    sync();
end;

-- Additional Lucide outlines: blend, group, square-dashed, circle-dollar-sign
-- and badge-dollar-sign. Same ISC license above; official geometry sampled once.
Compkiller.NativeIconPaths = {
    ["blend"] = {{{22,9},{21.657,11.163},{20.663,13.114},{19.114,14.663},{17.163,15.657},{15,16},{12.837,15.657},{10.886,14.663},{9.337,13.114},{8.343,11.163},{8,9},{8.343,6.837},{9.337,4.886},{10.886,3.337},{12.837,2.343},{15,2},{17.163,2.343},{19.114,3.337},{20.663,4.886},{21.657,6.837},{22,9}},{{16,15},{15.657,17.163},{14.663,19.114},{13.114,20.663},{11.163,21.657},{9,22},{6.837,21.657},{4.886,20.663},{3.337,19.114},{2.343,17.163},{2,15},{2.343,12.837},{3.337,10.886},{4.886,9.337},{6.837,8.343},{9,8},{11.163,8.343},{13.114,9.337},{14.663,10.886},{15.657,12.837},{16,15}}},
    ["group"] = {{{3,7},{3,5},{3.15,4.23},{3.59,3.59},{4.23,3.15},{5,3},{7,3}},{{17,3},{19,3},{19.77,3.15},{20.41,3.59},{20.85,4.23},{21,5},{21,7}},{{21,17},{21,19},{20.85,19.77},{20.41,20.41},{19.77,20.85},{19,21},{17,21}},{{7,21},{5,21},{4.23,20.85},{3.59,20.41},{3.15,19.77},{3,19},{3,17}},{{13,7},{13.5,7.134},{13.866,7.5},{14,8},{14,11},{13.866,11.5},{13.5,11.866},{13,12},{8,12},{7.5,11.866},{7.134,11.5},{7,11},{7,8},{7.134,7.5},{7.5,7.134},{8,7},{13,7}},{{16,12},{16.5,12.134},{16.866,12.5},{17,13},{17,16},{16.866,16.5},{16.5,16.866},{16,17},{11,17},{10.5,16.866},{10.134,16.5},{10,16},{10,13},{10.134,12.5},{10.5,12.134},{11,12},{16,12}}},
    ["square-dashed"] = {{{3,5},{3.152,4.235},{3.586,3.586},{4.235,3.152},{5,3}},{{19,3},{19.765,3.152},{20.414,3.586},{20.848,4.235},{21,5}},{{21,19},{20.848,19.765},{20.414,20.414},{19.765,20.848},{19,21}},{{5,21},{4.235,20.848},{3.586,20.414},{3.152,19.765},{3,19}},{{9,3},{10,3}},{{9,21},{10,21}},{{14,3},{15,3}},{{14,21},{15,21}},{{3,9},{3,10}},{{21,9},{21,10}},{{3,14},{3,15}},{{21,14},{21,15}}},
    ["circle-dollar-sign"] = {{{22,12},{21.749,14.225},{21.01,16.339},{19.818,18.235},{18.235,19.818},{16.339,21.01},{14.225,21.749},{12,22},{9.775,21.749},{7.661,21.01},{5.765,19.818},{4.182,18.235},{2.99,16.339},{2.251,14.225},{2,12},{2.251,9.775},{2.99,7.661},{4.182,5.765},{5.765,4.182},{7.661,2.99},{9.775,2.251},{12,2},{14.225,2.251},{16.339,2.99},{18.235,4.182},{19.818,5.765},{21.01,7.661},{21.749,9.775},{22,12}},{{16,8},{10,8},{9.235,8.152},{8.586,8.586},{8.152,9.235},{8,10},{8.152,10.765},{8.586,11.414},{9.235,11.848},{10,12},{14,12},{14.765,12.152},{15.414,12.586},{15.848,13.235},{16,14},{15.848,14.765},{15.414,15.414},{14.765,15.848},{14,16},{8,16}},{{12,18},{12,6}}},
    ["badge-dollar-sign"] = {{{3.85,8.62},{3.822,7.023},{4.421,5.543},{5.552,4.415},{7.033,3.819},{8.63,3.85},{8.63,3.85},{9.738,2.706},{11.204,2.085},{12.796,2.085},{14.262,2.706},{15.37,3.85},{15.37,3.85},{16.969,3.818},{18.453,4.416},{19.584,5.547},{20.182,7.031},{20.15,8.63},{20.15,8.63},{21.294,9.738},{21.915,11.204},{21.915,12.796},{21.294,14.262},{20.15,15.37},{20.15,15.37},{20.181,16.967},{19.585,18.448},{18.457,19.579},{16.977,20.178},{15.38,20.15},{15.38,20.15},{14.272,21.299},{12.803,21.923},{11.207,21.923},{9.738,21.299},{8.63,20.15},{8.63,20.15},{7.033,20.181},{5.552,19.585},{4.421,18.457},{3.822,16.977},{3.85,15.38},{3.85,15.38},{2.697,14.272},{2.07,12.8},{2.07,11.2},{2.697,9.728},{3.85,8.62}},{{16,8},{10,8},{9.235,8.152},{8.586,8.586},{8.152,9.235},{8,10},{8.152,10.765},{8.586,11.414},{9.235,11.848},{10,12},{14,12},{14.765,12.152},{15.414,12.586},{15.848,13.235},{16,14},{15.848,14.765},{15.414,15.414},{14.765,15.848},{14,16},{8,16}},{{12,18},{12,6}}},
};

-- Sets an icon without carrying atlas crop rectangles into the new pack.
-- Native fallbacks share image tint, fade and layer state; no polling or HTTP.
function Compkiller:_SetIcon(icon, name)
    local previous = icon:FindFirstChild("LucideOutline");
    if previous then previous:Destroy(); end;
    local plain = tostring(name):gsub("^lucide%-", "");
    icon.ImageRectOffset, icon.ImageRectSize = Vector2.zero, Vector2.zero;
    icon.ScaleType = Enum.ScaleType.Fit;
    icon:SetAttribute("LucideIcon", plain);
    if plain == "land-plot" then
        self:_DrawLandPlotIcon(icon);
        return;
    end;
    local paths = self.NativeIconPaths[plain];
    if not paths then icon.Image = self:_GetIcon(name); return; end;
    icon.Image = "";
    local outline = Instance.new("Frame");
    outline.Name, outline.BackgroundTransparency = "LucideOutline", 1;
    outline.Size, outline.Parent = UDim2.fromScale(1,1), icon;
    local strokes = {};
    for _, path in ipairs(paths) do
        for index = 2, #path do
            local a, b = path[index-1], path[index];
            local dx, dy = b[1]-a[1], b[2]-a[2];
            local stroke = Instance.new("Frame");
            stroke.AnchorPoint = Vector2.new(0.5,0.5);
            stroke.Position = UDim2.fromScale((a[1]+b[1])/48,(a[2]+b[2])/48);
            stroke.Size = UDim2.fromScale((math.sqrt(dx*dx+dy*dy)+1)/24,2/24);
            stroke.Rotation = math.deg(math.atan2(dy,dx));
            stroke.BorderSizePixel, stroke.Parent = 0, outline;
            Instance.new("UICorner",stroke).CornerRadius = UDim.new(1,0);
            table.insert(strokes,stroke);
        end;
    end;
    local function sync()
        outline.ZIndex = icon.ZIndex;
        for _, stroke in ipairs(strokes) do
            stroke.BackgroundColor3, stroke.BackgroundTransparency = icon.ImageColor3, icon.ImageTransparency;
            stroke.ZIndex = icon.ZIndex;
        end;
    end;
    local connections = {};
    for _, property in ipairs({"ImageColor3","ImageTransparency","ZIndex"}) do
        table.insert(connections,icon:GetPropertyChangedSignal(property):Connect(sync));
    end;
    outline.Destroying:Connect(function()
        for _, connection in ipairs(connections) do connection:Disconnect(); end;
    end);
    sync();
end;

-- Optional leading action icon; bind to the label so palette and fades agree.
function Compkiller:_ControlIcon(label, name, centered)
    if not name then return; end;
    local icon = Instance.new("ImageLabel");
    icon.Name, icon.BackgroundTransparency = "ActionIcon", 1;
    icon.AnchorPoint = Vector2.new(0,label.AnchorPoint.Y);
    icon.Position = UDim2.new(0,centered and 8 or 12,label.Position.Y.Scale,
        label.Position.Y.Offset + (0.5-label.AnchorPoint.Y)*(label.Size.Y.Offset-16));
    icon.Size, icon.Parent = UDim2.fromOffset(16,16), label.Parent;
    local function sync()
        icon.ImageColor3, icon.ImageTransparency, icon.ZIndex = label.TextColor3, label.TextTransparency, label.ZIndex;
    end;
    local connections = {};
    for _, property in ipairs({"TextColor3","TextTransparency","ZIndex"}) do
        table.insert(connections,label:GetPropertyChangedSignal(property):Connect(sync));
    end;
    icon.Destroying:Connect(function()
        for _, connection in ipairs(connections) do connection:Disconnect(); end;
    end);
    sync();
    self:_SetIcon(icon,name);
    label.Position = centered and UDim2.new(0,32,0.5,0) or UDim2.new(0,36,label.Position.Y.Scale,label.Position.Y.Offset);
    label.AnchorPoint = Vector2.new(0, label.AnchorPoint.Y);
    label.TextXAlignment = Enum.TextXAlignment.Left;
    return icon;
end;


-- Optional icon for compact text buttons; keep the original input target/callback.
function Compkiller:_TextButtonIcon(button, name, iconOnly, cancelIcon)
    if not name then return; end;
    local icon = Instance.new("ImageLabel");
    icon.Name, icon.BackgroundTransparency = "ButtonLucideIcon", 1;
    icon.AnchorPoint, icon.Size = Vector2.new(0,0.5), UDim2.fromOffset(14,14);
    icon.Parent = button.Parent;
    if iconOnly then
        button:SetAttribute("IconLabel",button.Text);
        button.Text = "";
    else
        local padding = button:FindFirstChildOfClass("UIPadding") or Instance.new("UIPadding",button);
        padding.PaddingLeft, padding.PaddingRight = UDim.new(0,24), UDim.new(0,4);
    end;
    local current;
    local function sync()
        local size, anchor, position = button.Size, button.AnchorPoint, button.Position;
        icon.Position = position + UDim2.new(size.X.Scale * ((iconOnly and 0.5 or 0)-anchor.X),
            size.X.Offset * ((iconOnly and 0.5 or 0)-anchor.X) + (iconOnly and -7 or 6),
            size.Y.Scale * (0.5-anchor.Y), size.Y.Offset * (0.5-anchor.Y));
        icon.ImageColor3, icon.ImageTransparency = button.TextColor3, button.TextTransparency;
        icon.ZIndex, icon.Visible = button.ZIndex+1, button.Visible;
        local desired = cancelIcon and button.Text == "Cancel" and "x" or name;
        if current ~= desired then self:_SetIcon(icon,desired); current = desired; end;
    end;
    local connections = {};
    for _, property in ipairs({"Position","Size","AnchorPoint","TextColor3","TextTransparency","ZIndex","Visible","Text"}) do
        table.insert(connections,button:GetPropertyChangedSignal(property):Connect(sync));
    end;
    table.insert(connections,button.Destroying:Connect(function() icon:Destroy(); end));
    icon.Destroying:Connect(function()
        for _, connection in ipairs(connections) do connection:Disconnect(); end;
    end);
    sync();
    return icon;
end;

function Compkiller:_RandomString() : string
	return "CK="..string.char(math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102));	
end;

function Compkiller:_IsMouseOverFrame(Frame : Frame) : boolean
	if not Frame or not Frame.Parent or not Frame.Visible then
		return false;
	end;

	local AbsPos: Vector2, AbsSize: Vector2 = Frame.AbsolutePosition, Frame.AbsoluteSize;

	if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
		return true;
	end;
	return false;
end;


-- Approved Butter action roles; other controls keep their existing presentation.
Compkiller.ActionIcons = {
    ["Lasso Selector (Drag)"]="lasso-select",
    ["Click Group Selection"]="group",
    ["Click Selection"]="mouse-pointer-2",
    ["Deselect"]="square-dashed",
    ["Group Selection Owner"]="users",
    ["Owner Filter"]="users",
    ["Open Selected Boxes"]="package-open",
    ["Sell Selected Plank"]="circle-dollar-sign",
    ["Teleport (Selected)"]="map-pin",
    ["Teleport Position"]="map-pin",
    ["Start Stacker"]="layers",
    ["Stop Stacker"]="square",
    ["Stop"]="square",
    ["Abort"]="square",
    ["Truck Bed Stacker"]="truck",
    ["Get Tree"]="axe",
    ["Get Wood"]="axe",
    ["Mod Wood"]="wand-sparkles",
    ["Dismember Tree"]="scissors",
    ["One Unit Cutter"]="ruler",
    ["Mod Sawmill"]="settings-2",
    ["Auto Sawmill"]="settings-2",
    ["Tree Sell Calculator"]="calculator",
    ["Use Calculator On Logs"]="calculator",
    ["Use Calculator On Planks"]="calculator",
    ["Sell Tree (Click)"]="badge-dollar-sign",
    ["Save"]="save",
    ["Load"]="folder-open",
};
-- ── Shared input dispatchers ────────────────────────────────────────────────
-- Persist across re-executions so loadstring() does not stack global connections.
local __ButterUI = getgenv().__ButterUI
if not __ButterUI then
	__ButterUI = {
		ClickListeners = {},
		InputChangedListeners = {},
		KeybindHandlers = {},
		WindowState = {},
	}
	getgenv().__ButterUI = __ButterUI

	__ButterUI.MasterInputBegan = UserInputService.InputBegan:Connect(function(Input, gameProcessed)
		if Input.UserInputType == Enum.UserInputType.MouseButton1
			or Input.UserInputType == Enum.UserInputType.Touch then
			for _, fn in next, __ButterUI.ClickListeners do
				if fn then fn(Input) end;
			end;
		end;

		for _, handler in next, __ButterUI.KeybindHandlers do
			if handler then handler(Input, gameProcessed) end;
		end;
	end);

	__ButterUI.MasterInputChanged = UserInputService.InputChanged:Connect(function(Input)
		if Input.UserInputType ~= Enum.UserInputType.MouseMovement
			and Input.UserInputType ~= Enum.UserInputType.Touch then
			return;
		end;

		for _, fn in next, __ButterUI.InputChangedListeners do
			if fn then fn(Input) end;
		end;
	end);
else
	table.clear(__ButterUI.ClickListeners)
	table.clear(__ButterUI.InputChangedListeners)
	table.clear(__ButterUI.KeybindHandlers)
end;

Compkiller._ClickListeners = __ButterUI.ClickListeners;
Compkiller._InputChangedListeners = __ButterUI.InputChangedListeners;

function Compkiller:_CleanupPreviousWindows()
	for _, state in next, __ButterUI.WindowState do
		if state.LoopThread then pcall(task.cancel, state.LoopThread) end;
		if state.MobileThread then pcall(task.cancel, state.MobileThread) end;

		for _, thread in next, state.Threads or {} do
			if type(thread) == "thread" then
				pcall(task.cancel, thread);
			end;
		end;
	end;

	table.clear(__ButterUI.WindowState);
	table.clear(__ButterUI.ClickListeners);
	table.clear(__ButterUI.InputChangedListeners);
	table.clear(__ButterUI.KeybindHandlers);
	Compkiller.Windows = {};
	Compkiller.Flags = {};

	for _, bucket in next, Compkiller.Elements do
		table.clear(bucket);
	end;
end;

function Compkiller:_RegisterClickListener(fn, owner)
	local key = {};
	Compkiller._ClickListeners[key] = fn;
	local destroyed;
	local function unregister()
		if destroyed then destroyed:Disconnect(); destroyed = nil; end;
		Compkiller._ClickListeners[key] = nil;
	end;
	if owner then destroyed = owner.Destroying:Connect(unregister); end;
	return unregister;
end;

function Compkiller:_RegisterInputChangedListener(fn, owner)
	local key = {};
	Compkiller._InputChangedListeners[key] = fn;
	local destroyed;
	local function unregister()
		if destroyed then destroyed:Disconnect(); destroyed = nil; end;
		Compkiller._InputChangedListeners[key] = nil;
	end;
	if owner then destroyed = owner.Destroying:Connect(unregister); end;
	return unregister;
end;

function Compkiller:_RegisterKeybindHandler(fn, owner)
	local key = {};
	__ButterUI.KeybindHandlers[key] = fn;
	local destroyed;
	local function unregister()
		if destroyed then destroyed:Disconnect(); destroyed = nil; end;
		__ButterUI.KeybindHandlers[key] = nil;
	end;
	if owner then destroyed = owner.Destroying:Connect(unregister); end;
	return unregister;
end;

function Compkiller:_TrackWindowState(id, state)
	__ButterUI.WindowState[id] = state;
end;
-- ────────────────────────────────────────────────────────────────────────────

local RippleButtons = setmetatable({}, {__mode = "k"});

function Compkiller:_ClickRipple(Button)
	if not Button.Parent or not Button.Visible or self:_IsDropdownHoverBlocked(Button) then return; end;
	local Size = Button.AbsoluteSize;
	if Size.X <= 0 or Size.Y <= 0 then return; end;
	local Previous = Button:FindFirstChild("ButterClickFeedback");
	if Previous then Previous:Destroy(); end;

	local Holder = Instance.new("Frame");
	Holder.Name = "ButterClickFeedback";
	Holder.BackgroundTransparency = 1;
	Holder.BorderSizePixel = 0;
	Holder.Size = UDim2.fromScale(1, 1);
	Holder.ClipsDescendants = true;
	Holder.ZIndex = Button.ZIndex + 1;
	Holder.Parent = Button;
	local SourceCorner = Button:FindFirstChildOfClass("UICorner") or Button.Parent:FindFirstChildOfClass("UICorner");
	local Corner = Instance.new("UICorner", Holder);
	Corner.CornerRadius = SourceCorner and SourceCorner.CornerRadius or UDim.new(0, 4);

	local Circle = Instance.new("Frame");
	Circle.AnchorPoint = Vector2.new(0.5, 0.5);
	Circle.Position = UDim2.fromScale(0.5, 0.5);
	Circle.Size = UDim2.fromOffset(0, 0);
	Circle.BackgroundColor3 = self.Colors.Highlight:Lerp(self.Colors.SwitchColor, 0.2);
	Circle.BackgroundTransparency = 0.65;
	Circle.BorderSizePixel = 0;
	Circle.ZIndex = Holder.ZIndex + 1;
	Circle.Parent = Holder;
	Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0);

	local Diameter = math.ceil(math.sqrt(Size.X * Size.X + Size.Y * Size.Y)) + 4;
	local Tween = self:_Animation(Circle, TweenInfo.new(0.3), {
		Size = UDim2.fromOffset(Diameter, Diameter),
		BackgroundTransparency = 1,
	});
	Tween.Completed:Once(function() Holder:Destroy(); end);
end;

function Compkiller:_BindClickRipple(Button)
	if RippleButtons[Button] then return; end;
	RippleButtons[Button] = true;
	-- Use the same accepted-click event as the action, never raw InputBegan.
	-- A mouse press used only to focus the window must not imitate an action.
	Button.MouseButton1Click:Connect(function() self:_ClickRipple(Button); end);
end;

-- Each action button owns its running callback and explicitly spawned workers.
-- No global task hooks, queued clicks, or polling loops are needed.
function Compkiller:_WithButtonContext(Context, Callback, ...)
	self._ButtonContexts = self._ButtonContexts or setmetatable({}, {__mode = "k"});
	local Thread = coroutine.running();
	local Previous = self._ButtonContexts[Thread];
	local WasOwned = Context.Threads[Thread];
	self._ButtonContexts[Thread] = Context;
	Context.Threads[Thread] = true;
	local Result = table.pack(xpcall(Callback, debug.traceback, ...));
	Context.Threads[Thread] = WasOwned;
	self._ButtonContexts[Thread] = Previous;
	if not Result[1] then error(Result[2], 0); end;
	return table.unpack(Result, 2, Result.n);
end;

function Compkiller:_SpawnButtonTask(Callback, ...)
	local Context = self._ButtonContexts and self._ButtonContexts[coroutine.running()];
	if not Context then return task.spawn(Callback, ...); end;
	return task.spawn(function(...)
		return self:_WithButtonContext(Context, Callback, ...);
	end, ...);
end;

function Compkiller:_GuardButtonCallback(Callback, Options)
	Options = Options or {};
	local Cooldown = math.max(0, tonumber(Options.Cooldown) or 0.35);
	local LastClick = -math.huge;
	local Active;
	local function IsBusy()
		if not Active then return false; end;
		-- A cancelled task cannot run its finally-style cleanup. Prune it on demand.
		for Thread in pairs(Active.Threads) do
			if coroutine.status(Thread) == "dead" then Active.Threads[Thread] = nil; end;
		end;
		return next(Active.Threads) ~= nil;
	end;
	local function Run(...)
		if Options.AllowConcurrent ~= true and IsBusy() then return; end;
		local Now = os.clock();
		if Now - LastClick < Cooldown then return; end;
		LastClick = Now;
		-- Explicit start/abort buttons already own their operation lifetime.
		if Options.AllowConcurrent == true then return Callback(...); end;
		Active = {Threads = {}};
		return self:_WithButtonContext(Active, Callback, ...);
	end;
	return Run, IsBusy;
end;
function Compkiller:_Rounding(num: number, numDecimalPlaces: number) : number
	local mult: number = 10 ^ (numDecimalPlaces or 0);
	return math.floor(num * mult + 0.5) / mult;
end;

function Compkiller:_Animation(Self: Instance , Info: TweenInfo , Property :{[K] : V})
	local Tween = TweenService:Create(Self , Info or TweenInfo.new(0.25) , Property);

	Tween:Play();

	return Tween;
end;

function Compkiller:_Input(Frame : Frame , Callback : () -> ()) : TextButton
	local Button = Instance.new('TextButton',Frame);

	Button.ZIndex = Frame.ZIndex + 10;
	Button.Size = UDim2.fromScale(1,1);
	Button.BackgroundTransparency = 1;
	Button.TextTransparency = 1;
	self:_BindClickRipple(Button);

	if Callback then
		Button.MouseButton1Click:Connect(Callback);
	end;

	return Button;
end;

function Compkiller:GetCalculatePosition(planePos: number, planeNormal: number, rayOrigin: number, rayDirection: number) : number
	local n = planeNormal;
	local d = rayDirection;
	local v = rayOrigin - planePos;

	local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z);
	local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
	local a = -num / den;

	return rayOrigin + (a * rayDirection);
end;

function Compkiller:_Blur(element : Frame , WindowRemote) : RBXScriptSignal
	local Part = Instance.new('Part',Compkiller.ArcylicParent);
	local DepthOfField = Instance.new('DepthOfFieldEffect',cloneref(game:GetService('Lighting')));
	local BlockMesh = Instance.new("BlockMesh");
	local userSettings = UserSettings():GetService("UserGameSettings");

	BlockMesh.Parent = Part;

	Part.Material = Enum.Material.Glass;
	Part.Transparency = 1;
	Part.Reflectance = 1;
	Part.CastShadow = false;
	Part.Anchored = true;
	Part.CanCollide = false;
	Part.CanQuery = false;
	Part.CollisionGroup = Compkiller:_RandomString();
	Part.Size = Vector3.new(1, 1, 1) * 0.01;
	Part.Color = Color3.fromRGB(0,0,0);

	DepthOfField.Enabled = true;
	DepthOfField.FarIntensity = 0;
	DepthOfField.FocusDistance = 0;
	DepthOfField.InFocusRadius = 1000;
	DepthOfField.NearIntensity = 1;
	DepthOfField.Name = Compkiller:_RandomString();

	Part.Name = Compkiller:_RandomString();

	local LastWindowActive;
	local UpdateFunction = function()
		local IsWindowActive = WindowRemote:GetValue();

        -- Camera/geometry updates can run every frame. Tween only an actual
        -- visibility transition, not each ray projection or periodic refresh.
        if IsWindowActive ~= LastWindowActive then
            LastWindowActive = IsWindowActive;
            DepthOfField.Enabled = IsWindowActive;
            if IsWindowActive then
                Compkiller:_Animation(DepthOfField,TweenInfo.new(0.1),{NearIntensity = 1});
                Compkiller:_Animation(Part,TweenInfo.new(0.1),{
                    Transparency = 0.97, Size = Vector3.new(1, 1, 1) * 0.01;
                });
            else
                Compkiller:_Animation(DepthOfField,TweenInfo.new(0.1),{NearIntensity = 0});
                Compkiller:_Animation(Part,TweenInfo.new(0.1),{Size = Vector3.zero, Transparency = 1.5});
            end;
        end;
        if not IsWindowActive then return false; end;

		if IsWindowActive then
			local corner0 = element.AbsolutePosition;
			local corner1 = corner0 + element.AbsoluteSize;

			local ray0 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner0.X, corner0.Y, 1);
			local ray1 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner1.X, corner1.Y, 1);

			local planeOrigin = CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * (0.05 - CurrentCamera.NearPlaneZ);

			local planeNormal = CurrentCamera.CFrame.LookVector;

			local pos0 = Compkiller:GetCalculatePosition(planeOrigin, planeNormal, ray0.Origin, ray0.Direction);
			local pos1 = Compkiller:GetCalculatePosition(planeOrigin, planeNormal, ray1.Origin, ray1.Direction);

			pos0 = CurrentCamera.CFrame:PointToObjectSpace(pos0);
			pos1 = CurrentCamera.CFrame:PointToObjectSpace(pos1);

			local size   = pos1 - pos0;
			local center = (pos0 + pos1) / 2;

			BlockMesh.Offset = center
			BlockMesh.Scale  = size / 0.0101;
			Part.CFrame = CurrentCamera.CFrame;
		end;
	end;

	local rbxsignal = CurrentCamera:GetPropertyChangedSignal('CFrame'):Connect(UpdateFunction)
	local unregisterInput = Compkiller:_RegisterInputChangedListener(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			pcall(UpdateFunction);
		end;
	end);

	local THREAD = task.spawn(function()
		while true do task.wait(0.1)
			pcall(UpdateFunction);
		end;
	end);

	element.Destroying:Connect(function()
		rbxsignal:Disconnect();
		unregisterInput();
		task.cancel(THREAD);
		Part:Destroy();
		DepthOfField:Destroy();
	end);

	return rbxsignal;
end;

-- Opening any dropdown locks hover/press highlights outside dropdown contents.
-- Keep the set so closing one menu cannot unlock another still-open menu.
local DropdownHoverBlockers = {};
local DropdownHoverTargets = {};
Compkiller.DropdownOpen = false;
local DropdownDismissers = {};
function Compkiller:_RegisterDropdownDismiss(Popup, Window, Close)
    DropdownDismissers[Popup] = {Window = Window, Close = Close};
    Popup.Destroying:Connect(function() DropdownDismissers[Popup] = nil end);
end;
function Compkiller:_CloseWindowDropdowns(Window)
    -- Closing invokes each backend's real ToggleUI, clearing its state, shield,
    -- hover lock and preview. Reopening the menu must not resurrect a popup.
    local callbacks = {};
    for _, entry in pairs(DropdownDismissers) do
        if entry.Window == Window then table.insert(callbacks, entry.Close) end;
    end;
    for _, close in ipairs(callbacks) do close(false); end;
end;


local function RefreshDropdownHover()
	Compkiller.DropdownOpen = next(DropdownHoverBlockers) ~= nil;
	for _, Update in pairs(DropdownHoverTargets) do
		Update();
	end;
end;

function Compkiller:_IsDropdownHoverBlocked(Frame)
	if not Compkiller.DropdownOpen then
		return false;
	end;
	for Popup in pairs(DropdownHoverBlockers) do
		if Frame == Popup or Frame:IsDescendantOf(Popup) then
			return false;
		end;
	end;
	return true;
end;

-- An actual input surface blocks all underlying controls, including controls
-- using raw mouse/touch callbacks rather than the button/hover helpers.
function Compkiller:_CreateDropdownInputShield(Window, Popup, IsInside)
    local shield = Instance.new("TextButton")
    shield.Name, shield.Text = "DropdownInputShield", ""
    shield.BackgroundTransparency, shield.AutoButtonColor = 1, false
    shield.Active, shield.Visible = true, false
    shield.Size, shield.Position = UDim2.fromScale(1, 1), UDim2.fromScale(0, 0)
    shield.ZIndex, shield.Parent = Popup.ZIndex - 1, Window
    local open, pressedOutside = false, false
    shield.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            -- Some GuiObjects pass button input to this surface underneath.
            -- Remember where the gesture started, even if its release is outside.
            pressedOutside = not (IsInside and IsInside())
        end
    end)
    local function update()
        shield.Visible = open and Popup.Parent ~= nil and Popup.Visible
    end
    Popup:GetPropertyChangedSignal("Visible"):Connect(update)
    Popup.Destroying:Connect(function() open = false;shield:Destroy() end)
    return shield, function(value)
        open, pressedOutside = value, false
        update()
    end, function()
        return pressedOutside and not (IsInside and IsInside())
    end
end;

function Compkiller:_RegisterDropdownHoverBlocker(Popup)
	local IsOpen = false;
	local function Update()
		if not IsOpen and not DropdownHoverBlockers[Popup] then return; end;
		DropdownHoverBlockers[Popup] = (IsOpen and Popup.Parent and Popup.Visible) and true or nil;
		RefreshDropdownHover();
	end;
	Popup:GetPropertyChangedSignal("Visible"):Connect(Update);
	Popup.Destroying:Connect(function()
		IsOpen = false;
		DropdownHoverBlockers[Popup] = nil;
		RefreshDropdownHover();
	end);
	return function(Open)
		IsOpen = Open;
		Update();
	end;
end;

function Compkiller:_BindDropdownHover(Frame, OnHover, Release)
	local Inside, Highlighted = false, false;
	local function Update()
		local Hover = Inside and not Compkiller:_IsDropdownHoverBlocked(Frame);
		if Hover == Highlighted then return; end;
		Highlighted = Hover;
		if Hover then OnHover(); else Release(); end;
	end;
	Frame.MouseEnter:Connect(function()
		Inside = true;
		DropdownHoverTargets[Frame] = Update;
		Update();
	end);
	Frame.MouseLeave:Connect(function()
		Inside = false;
		DropdownHoverTargets[Frame] = nil;
		Update();
	end);
	Frame.Destroying:Connect(function()
		DropdownHoverTargets[Frame] = nil;
	end);
end;

function Compkiller:_BindColor(bucket, binding)
    table.insert(bucket, binding)
    binding.PaletteIndex = #bucket
    binding.Element.Destroying:Connect(function()
        local index = binding.PaletteIndex
        if bucket[index] ~= binding then return end
        local last = bucket[#bucket]
        bucket[index], bucket[#bucket] = last, nil
        if last ~= binding then last.PaletteIndex = index end
        binding.Element, binding.PaletteIndex = nil, nil
    end)
    return binding
end

function Compkiller:_AddDragBlacklist(Frame: Frame)
	local IsAdded = false;
	local BASE_TIME = 0.01;

	local SET_BLACKLIST = function(value)
		local index = table.find(Compkiller.DragBlacklist , Frame);

		if value and not Compkiller.IS_DRAG_MOVE then
			if not index then
				table.insert(Compkiller.DragBlacklist,Frame);
			end;
		else
			if index then
				table.remove(Compkiller.DragBlacklist,index);
			end;
		end;
	end;

	Frame.InputBegan:Connect(function(input)
		if Compkiller:_IsMouseOverFrame(Frame) then
			SET_BLACKLIST(true)
		end;
	end);

	Frame.InputEnded:Connect(function(input)
		SET_BLACKLIST(false);
	end);

	local unregisterInput = Compkiller:_RegisterInputChangedListener(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return;
		end;

		if not Compkiller:_IsMouseOverFrame(Frame) then
			SET_BLACKLIST(false);
		end;
	end, Frame);
	Frame.Destroying:Connect(function()
		unregisterInput();
		SET_BLACKLIST(false);
	end);
end;

function Compkiller:_GetWindowFromElement(Element)
	for i,v : ScreenGui in next , Compkiller.Windows do
		if v and Element:IsDescendantOf(v) then
			return v;
		end;
	end;
end;

function Compkiller.__SIGNAL(default)
	local Bindable = Instance.new('BindableEvent');

	Bindable.Name = string.sub(tostring({}),7);

	Bindable:SetAttribute('Value',default);

	local Binds = {
		__signals = {}	
	};

	function Binds:Connect(event)
		event(Bindable:GetAttribute("Value"));

		local signal = Bindable.Event:Connect(event);

		-- Drop disconnected records on each subscription (row refreshes disconnect
		-- the previous batch before subscribing again).
		for index = #Binds.__signals, 1, -1 do
			if Binds.__signals[index].Connected == false then table.remove(Binds.__signals, index); end;
		end;
		table.insert(Binds.__signals,signal);

		return signal;
	end;

	function Binds:Fire(value)
		local IsSame = Bindable:GetAttribute("Value") == value;

		Bindable:SetAttribute('Value',value);

		if not IsSame then
			Bindable:Fire(value);
		end;
	end;

	function Binds:GetValue()
		return Bindable:GetAttribute("Value");
	end;

	return Binds;
end;

function Compkiller:_Hover(Frame: Frame , OnHover: () -> any?, Release: () -> any?, RespectDropdowns: boolean?)
	if RespectDropdowns ~= false then
		return Compkiller:_BindDropdownHover(Frame, OnHover, Release);
	end;

	Frame.MouseEnter:Connect(OnHover);

	Frame.MouseLeave:Connect(Release);
end;

local _translationCache = {}
local _activeTranslations = {}
local _targetLoc = nil
local _saveCacheDebounce = false

local function SaveCache()
	if not _targetLoc then return end
	if writefile then
		pcall(function()
			local HttpService = game:GetService("HttpService")
			local data = HttpService:JSONEncode(_translationCache)
			writefile("Compkiller_TransCache_" .. tostring(_targetLoc) .. ".json", data)
		end)
	end
end

local function TriggerSaveCache()
	if _saveCacheDebounce then return end
	_saveCacheDebounce = true
	task.spawn(function()
		task.wait(2)
		SaveCache()
		_saveCacheDebounce = false
	end)
end

local function LoadCache()
	if not _targetLoc then return end
	if isfile and isfile("Compkiller_TransCache_" .. tostring(_targetLoc) .. ".json") then
		pcall(function()
			local HttpService = game:GetService("HttpService")
			local data = readfile("Compkiller_TransCache_" .. tostring(_targetLoc) .. ".json")
			_translationCache = HttpService:JSONDecode(data) or {}
		end)
	end
end

local function InitializeTranslationSystem()
	local HttpService = game:GetService("HttpService")
	local loc = game:GetService("LocalizationService").RobloxLocaleId
	--local loc = "ru-ru"
	if not loc or string.sub(loc, 1, 2) == "en" then return end
	
	local PrefsFile = "Compkiller_TransPrefs.json"
	if isfile and isfile(PrefsFile) then
		local success, result = pcall(function()
			local data = readfile(PrefsFile)
			return HttpService:JSONDecode(data)
		end)
		if success and type(result) == "table" then
			if result.Translate == true then
				_targetLoc = loc
				LoadCache()
			end
			return
		end
	end

	-- Must prompt user
	local promptText = "Would you like to translate the UI to your language?"
	local yesText = "Yes"
	local noText = "No"

	local function translateWord(word)
		local success, result = pcall(function()
			local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" .. tostring(loc) .. "&dt=t&q=" .. HttpService:UrlEncode(word)
			local response = game:HttpGet(url)
			local decoded = HttpService:JSONDecode(response)
			if decoded and decoded[1] and decoded[1][1] and decoded[1][1][1] then
				return decoded[1][1][1]
			end
			return word
		end)
		return success and result or word
	end
	
	promptText = translateWord(promptText)
	yesText = translateWord(yesText)
	noText = translateWord(noText)

	local sg = Instance.new("ScreenGui")
	sg.Name = "Compkiller_TranslationPrompt"
	sg.Parent = CoreGui
	
	local bg = Instance.new("Frame", sg)
	bg.Size = UDim2.new(0, 320, 0, 160)
	bg.Position = UDim2.new(0.5, -160, 0.5, -80)
	Compkiller:_BindPolishColor(bg, "BackgroundColor3", "Popup");
	bg.BorderSizePixel = 0
	
	local corner = Instance.new("UICorner", bg)
	corner.CornerRadius = UDim.new(0, 8)
	
	local uiStroke = Instance.new("UIStroke", bg)
	Compkiller:_BindPolishColor(uiStroke, "Color", "HighStrokeColor");
	uiStroke.Thickness = 1
	
	local label = Instance.new("TextLabel", bg)
	label.Size = UDim2.new(1, -20, 0, 80)
	label.Position = UDim2.new(0, 10, 0, 10)
	label.BackgroundTransparency = 1
	label.Text = promptText
	Compkiller:_BindPolishColor(label, "TextColor3", "SwitchColor");
	label.TextWrapped = true
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 18
	
	local btnYes = Instance.new("TextButton", bg)
	btnYes.Size = UDim2.new(0.4, 0, 0, 40)
	btnYes.Position = UDim2.new(0.05, 0, 1, -50)
	Compkiller:_BindPolishColor(btnYes, "BackgroundColor3", "Toggle");
	btnYes.Text = yesText
	Compkiller:_BindPolishColor(btnYes, "TextColor3", "SwitchColor");
	btnYes.Font = Enum.Font.GothamBold
	btnYes.TextSize = 16
	Instance.new("UICorner", btnYes).CornerRadius = UDim.new(0, 6)
	
	local btnNo = Instance.new("TextButton", bg)
	btnNo.Size = UDim2.new(0.4, 0, 0, 40)
	btnNo.Position = UDim2.new(0.55, 0, 1, -50)
	Compkiller:_BindPolishColor(btnNo, "BackgroundColor3", "BlockBackground");
	btnNo.Text = noText
	Compkiller:_BindPolishColor(btnNo, "TextColor3", "SwitchColor");
	btnNo.Font = Enum.Font.GothamBold
	btnNo.TextSize = 16
	Instance.new("UICorner", btnNo).CornerRadius = UDim.new(0, 6)

	local bindable = Instance.new("BindableEvent")
	Compkiller:_BindClickRipple(btnYes);
	btnYes.MouseButton1Click:Connect(function() bindable:Fire(true) end)
	Compkiller:_BindClickRipple(btnNo);
	btnNo.MouseButton1Click:Connect(function() bindable:Fire(false) end)
	
	local result = bindable.Event:Wait()
	sg:Destroy()
	
	if writefile then
		pcall(function()
			writefile(PrefsFile, HttpService:JSONEncode({Translate = result}))
		end)
	end
	
	if result then
		_targetLoc = loc
		LoadCache()
	end
end

InitializeTranslationSystem()

local function GetTranslationSync(text, loc)
	local key = tostring(loc) .. "|" .. text
	if _translationCache[key] then return _translationCache[key] end
	local HttpService = game:GetService("HttpService")
	local success, result = pcall(function()
		local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" .. tostring(loc) .. "&dt=t&q=" .. HttpService:UrlEncode(text)
		local response = game:HttpGet(url)
		local decoded = HttpService:JSONDecode(response)
		if decoded and decoded[1] and decoded[1][1] and decoded[1][1][1] then
			return decoded[1][1][1]
		end
		return text
	end)
	if success and result and result ~= "" and result ~= text then
		_translationCache[key] = result
		TriggerSaveCache()
		return result
	end
	return text
end

local function AsyncTranslate(originalText, loc)
	if not originalText or originalText == "" then return end
	local key = tostring(loc) .. "|" .. originalText
	if _translationCache[key] or _activeTranslations[key] then return end
	
	_activeTranslations[key] = true
	
	task.spawn(function()
		local success, result = pcall(function()
			local HttpService = game:GetService("HttpService")
			local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" .. tostring(loc) .. "&dt=t&q=" .. HttpService:UrlEncode(originalText)
			local response = game:HttpGet(url)
			local decoded = HttpService:JSONDecode(response)
			if decoded and decoded[1] and decoded[1][1] and decoded[1][1][1] then
				return decoded[1][1][1]
			end
			return originalText
		end)
		
		_activeTranslations[key] = nil
		
		if success and result and result ~= "" and result ~= originalText then
			_translationCache[key] = result
			TriggerSaveCache()
			
			if Compkiller and Compkiller.Windows then
				for _, window in ipairs(Compkiller.Windows) do
					if typeof(window) == "Instance" then
						for _, desc in ipairs(window:GetDescendants()) do
							if desc:IsA("TextLabel") or desc:IsA("TextButton") then
								if desc.Text == originalText then
									desc.Text = result
								end
							elseif desc:IsA("TextBox") then
								if desc.Text == originalText then
									desc.Text = result
								end
								if desc.PlaceholderText == originalText then
									desc.PlaceholderText = result
								end
							end
						end
					end
				end
			end
		end
	end)
end

function Compkiller.__CONFIG(config , default)
	config = config or {};

	for i,v in next , default do
		if config[i] == nil then
			config[i] = v;
		end;
	end;

	local loc = _targetLoc
	if loc then
		local fieldsToTranslate = {"Name", "Title", "Content", "Placeholder", "Text"}
		for _, field in ipairs(fieldsToTranslate) do
			local text = config[field]
			if type(text) == "string" and text ~= "" then
				local key = tostring(loc) .. "|" .. text
				if _translationCache[key] then
					config[field] = _translationCache[key]
				else
					AsyncTranslate(text, loc)
				end
			end
		end
	end

	return config;
end;

function Compkiller:Drag(InputFrame: Frame, MoveFrame: Frame, Speed : number)
	local dragToggle: boolean = false;
	local dragStart: Vector3 = nil;
	local startPos: UDim2 = nil;
	local Tween = TweenInfo.new(Speed);
	local dragEndConnection;

	local function updateInput(input)
		local delta = input.Position - dragStart;
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y);

		Compkiller:_Animation(MoveFrame,Tween,{
			Position = position
		});
	end;

	InputFrame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and #Compkiller.DragBlacklist <= 0 then 
			dragToggle = true
			dragStart = input.Position
			startPos = MoveFrame.Position
			if dragEndConnection then dragEndConnection:Disconnect(); end;
			dragEndConnection = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false;
					Compkiller.IS_DRAG_MOVE = false;
					if dragEndConnection then dragEndConnection:Disconnect(); dragEndConnection = nil; end;
				end
			end)
		end

		if not Compkiller.IsDrage and dragToggle then
			Compkiller.LastDrag = tick();
		end;

		Compkiller.IaDrag = dragToggle;
	end)

	Compkiller:_RegisterInputChangedListener(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return;
		end;

		if #Compkiller.DragBlacklist > 0 then
			dragToggle = false
			Compkiller.IS_DRAG_MOVE = false;
			Compkiller.IaDrag = dragToggle;
			return;
		end;

		if dragToggle then
			Compkiller.IS_DRAG_MOVE = true;
			updateInput(input)
		else
			Compkiller.IS_DRAG_MOVE = false;
		end

		Compkiller.IaDrag = dragToggle;
	end, InputFrame);
	InputFrame.Destroying:Connect(function()
		dragToggle = false;
		if dragEndConnection then dragEndConnection:Disconnect(); dragEndConnection = nil; end;
	end);
end;

function Compkiller:_IsMobile()
	return UserInputService.TouchEnabled;
end;

function Compkiller:_AddLinkValue(Name , Default , GlobalBlock , LinkValues , rep , Signal)
	if Name == "Toggle" then
		local Toggle = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ToggleValue = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")

		Toggle.Name = Compkiller:_RandomString()
		Toggle.Parent = LinkValues
		Toggle.BackgroundColor3 = Compkiller.Colors.DropColor
		Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.BorderSizePixel = 0
		Toggle.Size = UDim2.new(0, 30, 0, 16)
		Toggle.ZIndex = GlobalBlock.ZIndex + 1
		Toggle.LayoutOrder = -#LinkValues:GetChildren();

		table.insert(Compkiller.Elements.DropColor , {
			Element = Toggle,
			Property = "BackgroundColor3"
		})

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Toggle

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = Toggle

		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		ToggleValue.Name = Compkiller:_RandomString()
		ToggleValue.Parent = Toggle
		ToggleValue.AnchorPoint = Vector2.new(0.5, 0.5)
		ToggleValue.BackgroundColor3 = Compkiller.Colors.SwitchColor
		ToggleValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ToggleValue.BorderSizePixel = 0
		ToggleValue.Position = UDim2.new(0.25, 0, 0.5, 0)
		ToggleValue.Size = UDim2.new(0.550000012, 0, 0.550000012, 0)
		ToggleValue.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ToggleValue.ZIndex = GlobalBlock.ZIndex + 2

		UICorner_2.CornerRadius = UDim.new(0, 3)
		UICorner_2.Parent = ToggleValue;

		local ToggleElement = function(bool,noChange)
			if not noChange then
				Default = bool;
			end;

			if bool then
				Toggle:SetAttribute('Enabled',true);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					Position = UDim2.new(0.75, 0, 0.5, 0)
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundColor3 = Compkiller.Colors.Toggle
				})
			else
				Toggle:SetAttribute('Enabled',false);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					Position = UDim2.new(0.25, 0, 0.5, 0)
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundColor3 = Compkiller.Colors.DropColor
				})
			end;
		end;

		local Input = Compkiller:_Input(Toggle);

		Compkiller:_Hover(Input , function()
			if not Default then
				Compkiller:_Animation(ToggleValue,rep.Tween,{
					Size = UDim2.new(0.6, 0, 0.6, 0)
				})
			end;
		end , function()
			Compkiller:_Animation(ToggleValue,rep.Tween,{
				Size = UDim2.new(0.550000012, 0, 0.550000012, 0)
			})
		end);

		local ToggleUI = function(bool)
			if bool then
				ToggleElement(Default,true);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 0
				})
			else
				ToggleElement(false,true);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 1
				})
			end;
		end;

		ToggleElement(Default);

		Signal:Connect(ToggleUI)

		return {
			Root = Toggle,
			ChangeValue = ToggleElement,
			Input = Input,
			ToggleUI = ToggleUI,
		};
	elseif Name == "ColorPicker" then
		local ColorPicker = Instance.new("Frame")
		local ColorFrame = Instance.new("Frame")
		local UIScale = Instance.new("UIScale")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")

		ColorPicker.Name = Compkiller:_RandomString()
		ColorPicker.Parent = LinkValues
		ColorPicker.BackgroundTransparency = 1.000
		ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BorderSizePixel = 0
		ColorPicker.Size = UDim2.new(0, 16, 0, 16)
		ColorPicker.ZIndex = GlobalBlock.ZIndex + 1
		ColorPicker.LayoutOrder = -#LinkValues:GetChildren();

		ColorFrame.Name = Compkiller:_RandomString()
		ColorFrame.Parent = ColorPicker
		ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		ColorFrame.BackgroundColor3 = Color3.fromRGB(15, 255, 207)
		ColorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorFrame.BorderSizePixel = 0
		ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		ColorFrame.Size = UDim2.new(1, -1, 1, -1)
		ColorFrame.ZIndex = GlobalBlock.ZIndex + 1

		UIScale.Parent = ColorFrame

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = ColorFrame

		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = ColorFrame

		Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(ColorFrame,TweenInfo.new(0.15),{
					BackgroundTransparency = 0,
				})

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.15),{
					Transparency = 0,
				})
			else
				Compkiller:_Animation(ColorFrame,TweenInfo.new(0.15),{
					BackgroundTransparency = 1,
				})

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.15),{
					Transparency = 1,
				})
			end;
		end)

		Compkiller:_Hover(ColorPicker, function()
			if Signal:GetValue() then
				Compkiller:_Animation(UIScale,TweenInfo.new(0.35),{
					Scale = 1.2
				})
			end;
		end , function()
			if Signal:GetValue() then
				Compkiller:_Animation(UIScale,TweenInfo.new(0.35),{
					Scale = 1
				})
			end;
		end)

		return ColorPicker , ColorFrame;
	elseif Name == "Keybind" then
		local Keys = {
			One = '1',
			Two = '2',
			Three = '3',
			Four = '4',
			Five = '5',
			Six = '6',
			Seven = '7',
			Eight = '8',
			Nine = '9',
			Zero = '0',
			['Minus'] = "-",
			['Plus'] = "+",
			BackSlash = "\\",
			Slash = "/",
			Period = '.',
			Semicolon = ';',
			Colon = ":",
			LeftControl = "LCtrl",
			RightControl = "RCtrl",
			LeftShift = "LShift",
			RightShift = "RShift",
			Return = "Enter",
			LeftBracket = "[",
			RightBracket = "]",
			Quote = "'",
			Comma = ",",
			Equals = "=",
			LeftSuper = "Super",
			RightSuper = "Super",
			LeftAlt = "LAlt",
			RightAlt = "RAlt",
			Escape = "Esc",
		};

		local GetItem = function(item)
			if item then
				if typeof(item) == 'EnumItem' then
					return Keys[item.Name] or item.Name;
				else
					return Keys[tostring(item)] or tostring(item);
				end;
			else
				return 'None';
			end;
		end;

		local Keybind = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local TextLabel = Instance.new("TextLabel")

		Keybind.Name = Compkiller:_RandomString()
		Keybind.Parent = LinkValues
		Keybind.BackgroundColor3 = Compkiller.Colors.DropColor
		Keybind.BackgroundTransparency = 0.8
		Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Keybind.BorderSizePixel = 0
		Keybind.Size = UDim2.new(0, 28, 0, 22)
		Keybind.ZIndex = GlobalBlock.ZIndex + 2
		Keybind.ClipsDescendants = true
		Keybind.LayoutOrder = -#LinkValues:GetChildren();


		table.insert(Compkiller.Elements.DropColor , {
			Element = Keybind,
			Property = "BackgroundColor3"
		})

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Keybind

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = Keybind

		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		TextLabel.Parent = Keybind
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, -16, 1, 0)
		TextLabel.ZIndex = GlobalBlock.ZIndex + 3
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = GetItem(Default or "None");
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 14
		TextLabel.TextXAlignment = Enum.TextXAlignment.Center
		TextLabel.TextYAlignment = Enum.TextYAlignment.Center
		TextLabel.TextTransparency = 000

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = TextLabel,
			Property = "TextColor3"
		});

		local Update = function()
			Keybind.Size = Compkiller:_ControlFieldSize(TextLabel);
		end;

		Update();

		local ToggleUI = function(bool)
			if bool then
				Compkiller:_Animation(Keybind,rep.Tween,{
					BackgroundTransparency = 0.8
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 0
				})

				Compkiller:_Animation(TextLabel,rep.Tween,{
					TextTransparency = 000
				})
			else
				Compkiller:_Animation(Keybind,rep.Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 1
				})

				Compkiller:_Animation(TextLabel,rep.Tween,{
					TextTransparency = 1
				})
			end;
		end;

		Signal:Connect(ToggleUI);

		return {
			SetValue = function(text)
				TextLabel.Text = GetItem(text or "None");

				Update();
			end,
			Root = Keybind,
		};
	elseif Name == "Helper" then
		local InfoButton = Instance.new("ImageButton")
		local UICorner = Instance.new("UICorner")
		local BlockText = Instance.new("TextLabel")
		local UIStroke = Instance.new("UIStroke")
		local UICorner_2 = Instance.new("UICorner")

		InfoButton.Name = Compkiller:_RandomString()
		InfoButton.Parent = LinkValues
		InfoButton.BackgroundTransparency = 1.000
		InfoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InfoButton.BorderSizePixel = 0
		InfoButton.LayoutOrder = -#LinkValues:GetChildren();
		InfoButton.Size = UDim2.new(0, 15, 0, 15)
		InfoButton.ZIndex = GlobalBlock.ZIndex + 25
		Compkiller:_SetIcon(InfoButton,"info")
		InfoButton.ImageTransparency = 0.500

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = InfoButton

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = InfoButton
		BlockText.AnchorPoint = Vector2.new(0, 0)
		BlockText.BackgroundColor3 = Compkiller.Colors.BlockColor

		table.insert(Compkiller.Elements.BlockColor , {
			Element = BlockText,
			Property = "BackgroundColor3"
		});

		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 5, 0, 0)
		BlockText.Size = UDim2.new(0, 250, 0, 15)
		BlockText.ZIndex = GlobalBlock.ZIndex + 26
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = " "
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 15
		BlockText.TextTransparency = 0.300
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = BlockText,
			Property = "TextColor3"
		});

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Parent = BlockText

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner_2.CornerRadius = UDim.new(0, 3)
		UICorner_2.Parent = BlockText

		Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			else
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 1
				})
			end;
		end)

		Compkiller:_Hover(InfoButton, function()
			if Signal:GetValue() then
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.1
				})
			end;
		end , function()
			if Signal:GetValue() then
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			end;
		end)

		return {
			Text = BlockText,
			UIStroke = UIStroke,
			InfoButton = InfoButton,
		};
	elseif Name == "Option" then
		local OptionButton = Instance.new("ImageButton")
		local UICorner = Instance.new("UICorner")

		OptionButton.Name = Compkiller:_RandomString()
		OptionButton.Parent = LinkValues
		OptionButton.BackgroundTransparency = 1.000
		OptionButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		OptionButton.BorderSizePixel = 0
		OptionButton.Size = UDim2.new(0, 15, 0, 15)
		OptionButton.ZIndex = GlobalBlock.ZIndex + 2
		Compkiller:_SetIcon(OptionButton,"settings-2")
		OptionButton.ImageTransparency = 0.500
		OptionButton.LayoutOrder = -#LinkValues:GetChildren();

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = OptionButton

		Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			else
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 1
				})
			end;
		end)

		Compkiller:_Hover(OptionButton, function()
			if Signal:GetValue() then
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.1
				})
			end;
		end , function()
			if Signal:GetValue() then
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			end;
		end)

		return OptionButton;
	end;
end;

-- Logical dimensions keep fields aligned when the window uses UIScale.
function Compkiller:_GetUIScale(root)
    local scale, ancestor = 1, root
    while ancestor do
        local uiScale = ancestor:FindFirstChildOfClass("UIScale")
        if uiScale then scale *= uiScale.Scale end
        ancestor = ancestor.Parent
    end
    return math.max(scale, 0.001)
end
function Compkiller:_ControlFieldSize(label, minimum, maximum)
    local text = label.Text
    if text == "" and label:IsA("TextBox") then text = label.PlaceholderText end
    local measured = TextService:GetTextSize(text, label.TextSize, label.Font, Vector2.new(math.huge, math.huge)).X
    local width = math.max(minimum or 28, math.ceil(measured) + 16)
    if maximum then width = math.min(width, math.max(minimum or 28, math.floor(maximum))) end
    return UDim2.fromOffset(width, 22)
end

-- Measure inline controls in logical pixels, independent of layout/viewport scale.
function Compkiller:_InlineControlWidth(container, layout, scale)
    local width, count = 0, 0
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("GuiObject") and child.Visible then
            width += child.AbsoluteSize.X / scale
            count += 1
        end
    end
    local padding = layout.Padding.Offset + layout.Padding.Scale * container.AbsoluteSize.X / scale
    return width + math.max(0, count - 1) * padding
end

-- Reserve the actual inline-control width, then wrap only labels that need it.
-- Layout runs on changes, never per frame. Text size remains the chosen size.
function Compkiller:_BindControlLabel(root, label, reservedWidth, options)
    options = options or {}
    local baseHeight = options.BaseHeight or root.Size.Y.Offset
    local labelHeight = options.LabelHeight or 25
    local padding = (options.Padding or 24) + (options.Icon and 24 or 0)
    local alive, queued, lastKey = true, false, nil
    local connections = {}
    label.TextWrapped = true
    local function refresh()
        queued = false
        if not alive or not root.Parent then return end
        local scale = Compkiller:_GetUIScale(root)
        local width = root.AbsoluteSize.X / scale
        if width <= padding then return end
        local reserved = math.max(0, reservedWidth and reservedWidth(scale) or 0)
        if reserved > 0 then reserved += options.Gap or 10 end
        local available = math.max(24, width - padding - reserved)
        local text = label.Text:gsub("<[^>]*>", "")
        local key = text .. "|" .. tostring(label.Font) .. "|" .. label.TextSize .. "|" .. available
        if key == lastKey then return end
        lastKey = key
        local measured = text ~= "" and TextService:GetTextSize(text, label.TextSize, label.Font, Vector2.new(available, math.huge)).Y or 0
        local height = math.max(labelHeight, math.ceil(measured))
        local size = UDim2.new(1, -(padding + reserved - (options.ParentInset or 0)), 0, height)
        if label.Size ~= size then label.Size = size end
        local rootSize = UDim2.new(root.Size.X.Scale, root.Size.X.Offset, 0, baseHeight + height - labelHeight)
        if root.Size ~= rootSize then root.Size = rootSize end
    end
    local function request()
        if not alive or queued then return end
        queued = true
        task.defer(refresh)
    end
    local function watch(object, property)
        table.insert(connections, object:GetPropertyChangedSignal(property):Connect(request))
    end
    watch(root, "AbsoluteSize")
    for _, property in ipairs({"Text", "TextSize", "Font"}) do watch(label, property) end
    table.insert(connections, root.AncestryChanged:Connect(request))
    for _, trigger in ipairs(options.Triggers or {}) do watch(trigger[1], trigger[2]) end
    root.Destroying:Connect(function()
        alive = false
        for _, connection in ipairs(connections) do connection:Disconnect() end
    end)
    request()
    return request
end
function Compkiller:_CreateBlock(Signal, iconName)
	local GlobalBlock = Instance.new("Frame")
	local BlockText = Instance.new("TextLabel")
	local LinkValues = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local BlockLine = Instance.new("Frame")

	if Compkiller:_IsMobile() then
		Compkiller:_AddDragBlacklist(GlobalBlock);
	end;

	GlobalBlock.Name = Compkiller:_RandomString()
	GlobalBlock.BackgroundTransparency = 1.000
	GlobalBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GlobalBlock.BorderSizePixel = 0
	GlobalBlock.Size = UDim2.new(1, -1, 0, 36)
	GlobalBlock.ZIndex = 10

	BlockText.Name = Compkiller:_RandomString()
	BlockText.Parent = GlobalBlock
	BlockText.AnchorPoint = Vector2.new(0, 0.5)
	BlockText.BackgroundTransparency = 1.000
	BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BlockText.BorderSizePixel = 0
	BlockText.Position = UDim2.new(0, 12, 0.5, 0)
	BlockText.Size = UDim2.new(1, -20, 0, 25)
	BlockText.ZIndex = 10
	BlockText.Font = Enum.Font.GothamMedium
	BlockText.Text = "Block"
	BlockText.TextColor3 = Compkiller.Colors.SwitchColor
	BlockText.TextSize = 16
	BlockText.TextTransparency = 0.150
	BlockText.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = BlockText,
		Property = 'TextColor3'
	});

	LinkValues.Name = Compkiller:_RandomString()
	LinkValues.Parent = GlobalBlock
	LinkValues.AnchorPoint = Vector2.new(1, 0.5)
	LinkValues.BackgroundTransparency = 1.000
	LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LinkValues.BorderSizePixel = 0
	LinkValues.Position = UDim2.new(1, -12, 0.5, 0)
	LinkValues.Size = UDim2.new(1, 0, 0, 22)
	LinkValues.ZIndex = 11

	UIListLayout.Parent = LinkValues
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 8)

	BlockLine.Name = Compkiller:_RandomString()
	BlockLine.Parent = GlobalBlock
	BlockLine.AnchorPoint = Vector2.new(0.5, 1)
	BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
	BlockLine.BackgroundTransparency = 0.500
	BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BlockLine.BorderSizePixel = 0
	BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
	BlockLine.Size = UDim2.new(1, -26, 0, 1)
	BlockLine.ZIndex = 12

	table.insert(Compkiller.Elements.LineColor,{
		Element = BlockLine,
		Property = "BackgroundColor3"
	});

	local rep = {
		TextTransparency = 0.150,
		Root = GlobalBlock,
		Tween = TweenInfo.new(0.25),
	};

	function rep:SetText(Text)
		BlockText.Text = Text;
	end;

	function rep:SetTextColor(Color)
		local bucket = Compkiller.Elements.SwitchColor;
		for index, binding in ipairs(bucket) do
			if binding.Element == BlockText then
				local last = bucket[#bucket];
				bucket[index], bucket[#bucket] = last, nil;
				if last ~= binding and last.PaletteIndex then last.PaletteIndex = index; end;
				break;
			end;
		end;

		BlockText.TextColor3 = Color;

		table.insert(Compkiller.Elements.Risky , {
			Element = BlockText,
			Property = 'TextColor3'
		});

	end;

	function rep:SetLine(visible)
		BlockLine.Visible = visible;
	end;

	function rep:SetTransparency(num)
		rep.TextTransparency = num;

		Compkiller:_Animation(BlockText,TweenInfo.new(0.3),{
			TextTransparency = rep.TextTransparency
		});
	end;

	function rep:SetParent(parent: Frame)
		GlobalBlock.Parent = parent;

		local ZINDEX = parent.ZIndex;

		GlobalBlock.ZIndex = ZINDEX + 1;
		BlockText.ZIndex = ZINDEX + 2;
		LinkValues.ZIndex = ZINDEX + 2;
		BlockLine.ZIndex = ZINDEX + 2;
	end;

	function rep:SetVisible(bool)
		if bool then
			Compkiller:_Animation(BlockText,rep.Tween,{
				TextTransparency = rep.TextTransparency
			});

			Compkiller:_Animation(BlockLine,rep.Tween,{
				BackgroundTransparency = 0.500
			});
		else
			Compkiller:_Animation(BlockText,rep.Tween,{
				TextTransparency = 1
			});

			Compkiller:_Animation(BlockLine,rep.Tween,{
				BackgroundTransparency = 1
			});
		end;
	end;

	function rep:AddLink(Name , Default)
		return Compkiller:_AddLinkValue(Name , Default , GlobalBlock , LinkValues , rep , Signal);
	end;

    if iconName then Compkiller:_ControlIcon(BlockText, iconName); end;
    Compkiller:_BindControlLabel(GlobalBlock, BlockText, function(scale)
        return Compkiller:_InlineControlWidth(LinkValues, UIListLayout, scale)
    end, {Icon = iconName, Triggers = {{UIListLayout, "AbsoluteContentSize"}}})
	return rep;
end;

function Compkiller:_AddColorPickerPanel(Button: ImageButton , Callback: (Color: Color3) -> any?)
	local Window = Compkiller:_GetWindowFromElement(Button);
	local BaseZ_Index = math.random(1,15) * 100;

	local ColorPickerWindow = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")
	local ColorPickBox = Instance.new("ImageLabel")
	local MouseMovement = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")
	local ColorRedGreenBlue = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local UICorner_3 = Instance.new("UICorner")
	local ColorRGBSlide = Instance.new("Frame")
	local Left = Instance.new("Frame")
	local UIStroke_3 = Instance.new("UIStroke")
	local Right = Instance.new("Frame")
	local UIStroke_4 = Instance.new("UIStroke")
	local ColorOpc = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local ColorOptSlide = Instance.new("Frame")
	local Left_2 = Instance.new("Frame")
	local UIStroke_5 = Instance.new("UIStroke")
	local Right_2 = Instance.new("Frame")
	local UIStroke_6 = Instance.new("UIStroke")
	local UIGradient_2 = Instance.new("UIGradient")
	local UIStroke_7 = Instance.new("UIStroke")
	local TransparentImage = Instance.new("ImageLabel")
	local UICorner_5 = Instance.new("UICorner")
	local HexFrame = Instance.new("Frame")
	local UICorner_6 = Instance.new("UICorner")
	local UIStroke_8 = Instance.new("UIStroke")
	local TextLabel = Instance.new("TextBox")

	ColorPickerWindow.Name = Compkiller:_RandomString()
	ColorPickerWindow.Parent = Window
	ColorPickerWindow.BackgroundColor3 = Compkiller.Colors.BlockBackground
	ColorPickerWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickerWindow.BorderSizePixel = 0
	ColorPickerWindow.Position = UDim2.new(123, 0, 123, 0)
	ColorPickerWindow.Size = UDim2.new(0, 175, 0, 200)
	ColorPickerWindow.ZIndex = BaseZ_Index
	ColorPickerWindow.AnchorPoint = Vector2.new(0.5,0)
	ColorPickerWindow.Active = true;

	Compkiller:_BindPolishColor(ColorPickerWindow, "BackgroundColor3", "Popup");

	Compkiller:_AddDragBlacklist(ColorPickerWindow)

	UIStroke.Color = Compkiller.Colors.HighStrokeColor
	UIStroke.Parent = ColorPickerWindow
	table.insert(Compkiller.Elements.HighStrokeColor , {
		Element = UIStroke,
		Property = "Color"
	})
	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = ColorPickerWindow

	ColorPickBox.Name = Compkiller:_RandomString()
	ColorPickBox.Parent = ColorPickerWindow
	ColorPickBox.BackgroundColor3 = Color3.fromRGB(39, 255, 35)
	ColorPickBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickBox.BorderSizePixel = 0
	ColorPickBox.Position = UDim2.new(0, 7, 0, 7)
	ColorPickBox.Size = UDim2.new(0, 145, 0, 145)
	ColorPickBox.ZIndex = BaseZ_Index + 1
	ColorPickBox.Image = "http://www.roblox.com/asset/?id=112554223509763"

	MouseMovement.Name = Compkiller:_RandomString()
	MouseMovement.Parent = ColorPickBox
	MouseMovement.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MouseMovement.BackgroundTransparency = 1.000
	MouseMovement.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MouseMovement.BorderSizePixel = 0
	MouseMovement.Position = UDim2.new(0.822222233, 0, 0.0592592582, 0)
	MouseMovement.Size = UDim2.new(0, 12, 0, 12)
	MouseMovement.ZIndex = BaseZ_Index + 5
	MouseMovement.AnchorPoint = Vector2.new(0.5,0.5)
	MouseMovement.Image = "rbxassetid://4805639000"

	UICorner_2.CornerRadius = UDim.new(0, 2)
	UICorner_2.Parent = ColorPickBox

	Compkiller:_BindPolishColor(UIStroke_2, "Color", "StrokeColor");
	UIStroke_2.Parent = ColorPickBox

	ColorRedGreenBlue.Name = Compkiller:_RandomString()
	ColorRedGreenBlue.Parent = ColorPickerWindow
	ColorRedGreenBlue.AnchorPoint = Vector2.new(1, 0)
	ColorRedGreenBlue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorRedGreenBlue.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorRedGreenBlue.BorderSizePixel = 0
	ColorRedGreenBlue.ClipsDescendants = true
	ColorRedGreenBlue.Position = UDim2.new(1, -7, 0, 7)
	ColorRedGreenBlue.Size = UDim2.new(0, 10, 0, 145)
	ColorRedGreenBlue.ZIndex = BaseZ_Index + 6

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(203, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(50, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 101, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(50, 0, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
	UIGradient.Rotation = 90
	UIGradient.Parent = ColorRedGreenBlue

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = ColorRedGreenBlue

	ColorRGBSlide.Name = Compkiller:_RandomString()
	ColorRGBSlide.Parent = ColorRedGreenBlue
	ColorRGBSlide.AnchorPoint = Vector2.new(0.5, 0)
	ColorRGBSlide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorRGBSlide.BackgroundTransparency = 1.000
	ColorRGBSlide.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorRGBSlide.BorderSizePixel = 0
	ColorRGBSlide.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorRGBSlide.Size = UDim2.new(1, 0, 0, 2)
	ColorRGBSlide.ZIndex = BaseZ_Index + 7

	Left.Name = Compkiller:_RandomString()
	Left.Parent = ColorRGBSlide
	Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Left.BorderSizePixel = 0
	Left.Size = UDim2.new(0, 2, 1, 0)
	Left.ZIndex = BaseZ_Index + 100

	UIStroke_3.Parent = Left

	Right.Name = Compkiller:_RandomString()
	Right.Parent = ColorRGBSlide
	Right.AnchorPoint = Vector2.new(1, 0)
	Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Right.BorderSizePixel = 0
	Right.Position = UDim2.new(1, 0, 0, 0)
	Right.Size = UDim2.new(0, 2, 1, 0)
	Right.ZIndex = BaseZ_Index + 100

	UIStroke_4.Parent = Right

	ColorOpc.Name = Compkiller:_RandomString()
	ColorOpc.Parent = ColorPickerWindow
	ColorOpc.BackgroundColor3 = Color3.fromRGB(102, 255, 0)
	ColorOpc.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorOpc.BorderSizePixel = 0
	ColorOpc.Position = UDim2.new(0, 7, 0, 160)
	ColorOpc.Size = UDim2.new(1, -30, 0, 9)
	ColorOpc.ZIndex = BaseZ_Index + 6

	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = ColorOpc

	ColorOptSlide.Name = Compkiller:_RandomString()
	ColorOptSlide.Parent = ColorOpc
	ColorOptSlide.AnchorPoint = Vector2.new(0, 0.5)
	ColorOptSlide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorOptSlide.BackgroundTransparency = 1.000
	ColorOptSlide.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorOptSlide.BorderSizePixel = 0
	ColorOptSlide.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorOptSlide.Size = UDim2.new(0, 2, 1, 0)
	ColorOptSlide.ZIndex = BaseZ_Index + 7

	Left_2.Name = Compkiller:_RandomString()
	Left_2.Parent = ColorOptSlide
	Left_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Left_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Left_2.BorderSizePixel = 0
	Left_2.Size = UDim2.new(1, 0, 0, 2)
	Left_2.ZIndex = BaseZ_Index + 100

	UIStroke_5.Parent = Left_2

	Right_2.Name = Compkiller:_RandomString()
	Right_2.Parent = ColorOptSlide
	Right_2.AnchorPoint = Vector2.new(0, 1)
	Right_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Right_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Right_2.BorderSizePixel = 0
	Right_2.Position = UDim2.new(0, 0, 1, 0)
	Right_2.Size = UDim2.new(1, 0, 0, 2)
	Right_2.ZIndex = BaseZ_Index + 100

	UIStroke_6.Parent = Right_2

	UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
	UIGradient_2.Parent = ColorOpc

	UIStroke_7.Transparency = 0.500
	Compkiller:_BindPolishColor(UIStroke_7, "Color", "StrokeColor");
	UIStroke_7.Parent = ColorOpc

	TransparentImage.Name = "TransparentImage"
	TransparentImage.Parent = ColorOpc
	TransparentImage.BackgroundTransparency = 1.000
	TransparentImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TransparentImage.BorderSizePixel = 0
	TransparentImage.Size = UDim2.new(1, 0, 1, 0)
	TransparentImage.ZIndex = BaseZ_Index + 5
	TransparentImage.Image = "rbxassetid://6198493000"
	TransparentImage.ImageColor3 = Color3.fromRGB(206, 206, 206)
	TransparentImage.ScaleType = Enum.ScaleType.Crop

	UICorner_5.CornerRadius = UDim.new(1, 0)
	UICorner_5.Parent = TransparentImage

	HexFrame.Name = Compkiller:_RandomString()
	HexFrame.Parent = ColorPickerWindow
	HexFrame.AnchorPoint = Vector2.new(0.5, 1)
	HexFrame.BackgroundColor3 = Compkiller.Colors.BlockColor
	HexFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HexFrame.BorderSizePixel = 0
	HexFrame.Position = UDim2.new(0.5, 0, 1, -5)
	HexFrame.Size = UDim2.new(1, -16, 0, 20)
	HexFrame.ZIndex = BaseZ_Index + 205

	table.insert(Compkiller.Elements.BlockColor,{
		Element = HexFrame,
		Property = "BackgroundColor3"
	});

	UICorner_6.CornerRadius = UDim.new(0, 4)
	UICorner_6.Parent = HexFrame

	UIStroke_8.Color = Compkiller.Colors.HighStrokeColor
	UIStroke_8.Parent = HexFrame

	table.insert(Compkiller.Elements.HighStrokeColor,{
		Element = UIStroke_8,
		Property = "Color"
	});

	TextLabel.Parent = HexFrame
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	TextLabel.Size = UDim2.new(1, -10, 1, -5)
	TextLabel.ZIndex = BaseZ_Index + 206
	TextLabel.Font = Enum.Font.GothamMedium
	TextLabel.Text = "#FFFFFFF"
	TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
	TextLabel.TextSize = 15
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.ClearTextOnFocus = false

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = TextLabel,
		Property = 'TextColor3'
	});

	local Args = {
		IsHold = false,
		IsVisible = false,
	};

	local Tween = TweenInfo.new(0.2 , Enum.EasingStyle.Quad);
	local Tween2 = TweenInfo.new(0.275 , Enum.EasingStyle.Quad);

	Compkiller:_AddPropertyEvent(ColorPickerWindow,function(v)
		ColorPickerWindow.Visible = v;
	end)

	local ToggleUI = function(bool)
		local IsSame = Args.IsVisible == bool;
		if IsSame then return end;

		Args.IsVisible = bool;

		local MainPosition = UDim2.new(0,Button.AbsolutePosition.X + 95,0,Button.AbsolutePosition.Y + 65);
		local DropPosition = UDim2.new(0,MainPosition.X.Offset,0,MainPosition.Y.Offset + 15);

		local MUL = Window.AbsoluteSize.Y / 2;

		if MainPosition.Y.Offset > MUL then -- go up
			MainPosition = UDim2.fromOffset(Button.AbsolutePosition.X,Button.AbsolutePosition.Y + 45);
			DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset - 25);

			ColorPickerWindow.AnchorPoint = Vector2.new(0.5,1)
		else
			ColorPickerWindow.AnchorPoint = Vector2.new(0.5,0)
		end;

		if bool then

			if not IsSame then
				ColorPickerWindow.Position = DropPosition
			end;

			Compkiller:_Animation(ColorPickerWindow,Tween2,{
				BackgroundTransparency = 0,
				Size = UDim2.new(0, 175, 0, 200)
			});

			Compkiller:_Animation(ColorPickerWindow,Tween,{
				Position = MainPosition,
			});

			Compkiller:_Animation(UIStroke_8,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_7,Tween,{
				Transparency = 0.5
			});

			Compkiller:_Animation(UIStroke_6,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_5,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_4,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_3,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_2,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(ColorPickBox,Tween,{
				BackgroundTransparency = 0,
				ImageTransparency = 0
			});

			Compkiller:_Animation(MouseMovement,Tween,{
				ImageTransparency = 0
			});

			Compkiller:_Animation(ColorOpc,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(TransparentImage,Tween,{
				ImageTransparency = 0
			});

			Compkiller:_Animation(Left,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(Left_2,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(Right,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(Right_2,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(ColorRedGreenBlue,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(HexFrame,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(TextLabel,Tween,{
				TextTransparency = 0
			});
		else
			Compkiller:_Animation(UIStroke_8,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_7,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_6,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_5,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_4,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_3,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_2,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(ColorPickerWindow,Tween2,{
				BackgroundTransparency = 1,
			});

			Compkiller:_Animation(ColorPickerWindow,Tween,{
				Position = DropPosition,
			});

			Compkiller:_Animation(ColorPickBox,Tween,{
				BackgroundTransparency = 1,
				ImageTransparency = 1
			});

			Compkiller:_Animation(MouseMovement,Tween,{
				ImageTransparency = 1
			});

			Compkiller:_Animation(ColorOpc,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(TransparentImage,Tween,{
				ImageTransparency = 1
			});

			Compkiller:_Animation(Left,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(Left_2,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(Right,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(Right_2,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(ColorRedGreenBlue,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(HexFrame,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(TextLabel,Tween,{
				TextTransparency = 1
			});
		end;
	end;

	Button.MouseButton1Click:Connect(function()
		ToggleUI(true);
	end)

	local H , S , V = 0,0,0;
	local Transparency = 0;

	function Args:SetColor(Color: Color3 , TransparencyValue: number)
		H , S , V = Color:ToHSV();
		Transparency = TransparencyValue;
	end;

	function Args:Update(silent)
		local MainColor = Color3.fromHSV(H , S , 1);
		local RealColor = Color3.fromHSV(H , S , V);

		Compkiller:_Animation(ColorPickBox,TweenInfo.new(0.2),{
			BackgroundColor3 = Color3.fromHSV(H , 1 , 1)
		});

		Compkiller:_Animation(ColorOpc,TweenInfo.new(0.2),{
			BackgroundColor3 = RealColor
		});

		Compkiller:_Animation(MouseMovement,TweenInfo.new(0.2),{
			Position = UDim2.fromScale(S , 1 - V)
		});

		Compkiller:_Animation(ColorOptSlide,TweenInfo.new(0.2),{
			Position = UDim2.new(Transparency ,0 , 0.5 ,0)
		});

		Compkiller:_Animation(ColorRGBSlide,TweenInfo.new(0.2),{
			Position = UDim2.new(0.5 ,0 , H ,0)
		});

		TextLabel.Text = "#" .. tostring(RealColor:ToHex())

		if not silent then Callback(RealColor , Transparency) end;
	end;

	local SPAWN_THREAD;

	ColorPickerWindow.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			if SPAWN_THREAD then
				task.cancel(SPAWN_THREAD);
				SPAWN_THREAD = nil;
			end;

			SPAWN_THREAD = task.spawn(function()
				while Args.IsHold do
					Callback(Color3.fromHSV(H , S , V),Transparency);
					task.wait(0.03);
				end;
			end);
		end;
	end)

	ColorPickerWindow.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = false;

			if SPAWN_THREAD then
				task.cancel(SPAWN_THREAD);
				SPAWN_THREAD = nil;
			end;
		end;
	end)

	Compkiller:_RegisterClickListener(function(Input)
		if not Compkiller:_IsMouseOverFrame(ColorPickerWindow) then
			ToggleUI(false);
		end;
	end, ColorPickerWindow);

	ColorPickerWindow.Destroying:Connect(function()
		Args.IsHold = false;
		if SPAWN_THREAD then pcall(task.cancel, SPAWN_THREAD); SPAWN_THREAD = nil; end;
	end);

	TextLabel.FocusLost:Connect(function()
		local hex = TextLabel.Text:gsub("#", "")
		local s, c = pcall(function() return Color3.fromHex(hex) end)
		if s and c then
			Args:SetColor(c, Transparency)
			Args:Update()
		else
			local RealColor = Color3.fromHSV(H, S, V)
			TextLabel.Text = "#" .. tostring(RealColor:ToHex())
		end
	end)

	ColorRedGreenBlue.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			while ColorPickerWindow.Parent and (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or Args.IsHold) do task.wait()
				if not ColorPickerWindow.Parent then break end;
				local ColorY = ColorRedGreenBlue.AbsolutePosition.Y
				local ColorYM = ColorY + ColorRedGreenBlue.AbsoluteSize.Y;
				local Value = math.clamp(Mouse.Y, ColorY, ColorYM)
				local Code = ((Value - ColorY) / (ColorYM - ColorY));

				H = Code;

				Args:Update();
			end;
		end;
	end);

	ColorOpc.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			while ColorPickerWindow.Parent and (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or Args.IsHold) do task.wait()
				if not ColorPickerWindow.Parent then break end;
				local transparency = math.clamp((((Mouse.X) - ColorOpc.AbsolutePosition.X) / ColorOpc.AbsoluteSize.X), 0, 1);
				local RealColor = Color3.fromHSV(H , S , V);

				TextLabel.Text = "#" .. tostring(RealColor:ToHex())

				Transparency = transparency;

				Args:Update();
			end;
		end;
	end);

	ColorPickBox.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			while ColorPickerWindow.Parent and (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or Args.IsHold) do task.wait()
				if not ColorPickerWindow.Parent then break end;
				local PosX = ColorPickBox.AbsolutePosition.X
				local ScaleX = PosX + ColorPickBox.AbsoluteSize.X
				local Value, PosY = math.clamp(Mouse.X, PosX, ScaleX), ColorPickBox.AbsolutePosition.Y
				local ScaleY = PosY + ColorPickBox.AbsoluteSize.Y
				local Vals = math.clamp(Mouse.Y, PosY, ScaleY)
				local RealColor = Color3.fromHSV(H , S , V);

				S = (Value - PosX) / (ScaleX - PosX);
				V = (1 - ((Vals - PosY) / (ScaleY - PosY)));

				TextLabel.Text = "#" .. tostring(RealColor:ToHex())

				Args:Update();
			end
		end
	end)

	return Args;
end;

function Compkiller:_AddPropertyEvent(Target: Frame , Callback: (boolean) -> any)
	Target:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
		Callback(Target.BackgroundTransparency <= 0.9)
	end)
end;

function Compkiller:_LoadOption(Value , TabSignal)
	local Args = {};
	local Window = Compkiller:_GetWindowFromElement(Value.Root);
	local Tween = TweenInfo.new(0.3,Enum.EasingStyle.Quint);

	function Args:AddKeybind(Config: MiniKeybind)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Keybind",
			Default = nil,
			Flag = nil,
			Callback = function() end;
			Blacklist = {}
		});

		local Keybind = Value:AddLink('Keybind' , Config.Default);

		local IsBinding = false;

		local IsBlacklist = function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end;

		Compkiller:_Input(Keybind.Root,function()
			if IsBinding then
				return;
			end;

			Keybind.SetValue("...");

			local Selected = nil;

			while not Selected do
				local Key = UserInputService.InputBegan:Wait();

				if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
					Selected = Key.KeyCode;
				else
					if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("MouseLeft") then
						Selected = "MouseLeft";
					elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("MouseRight") then
						Selected = "MouseRight";
					end;
				end;
			end;

			local KeyName = (typeof(Selected) == "string" and Selected) or Selected.Name;

			Config.Default = KeyName;

			Keybind.SetValue(Selected);

			IsBinding = false;

			Config.Callback(KeyName);
		end);

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value)
			Config.Default = value;

			Keybind.SetValue(Config.Default);

			Config.Callback(Config.Default);
		end;

		function Args:GetValue()
			return (typeof(Config.Default) == "string" and Config.Default) or Config.Default.Name;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddHelper(Config: Helper)
		Config = Compkiller.__CONFIG(Config,{
			Text = "Information."
		});

		local Helper = Value:AddLink("Helper" , Config.Default);
		local Button: ImageButton = Helper.InfoButton;

		Helper.Text.Parent = Window;

		Helper.UIStroke:GetPropertyChangedSignal('Transparency'):Connect(function()
			if Helper.UIStroke.Transparency > 0.9 then
				Helper.Text.Visible = false;
			else
				Helper.Text.Visible = true;
			end;
		end)

		local Update = function()
			local mainText = " "..Config.Text;

			mainText = string.gsub(mainText,'\n','\n ')

			Helper.Text.Text = mainText;

			local scale = TextService:GetTextSize(Helper.Text.Text,Helper.Text.TextSize,Helper.Text.Font,Vector2.new(math.huge,math.huge));

			Compkiller:_Animation(Helper.Text , TweenInfo.new(0.15), {
				Size = UDim2.fromOffset(scale.X + 10, scale.Y + 6)
			})

			return scale;
		end;

		local Release = function()
			local scale = Update()

			Compkiller:_Animation(Helper.Text,TweenInfo.new(0.15),{
				TextTransparency = 1,
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(Button.AbsolutePosition.X,Button.AbsolutePosition.Y + (45))
			});

			Compkiller:_Animation(Helper.UIStroke,TweenInfo.new(0.15),{
				Transparency = 1
			});
		end;

		local Hold = function()
			local scale = Update()

			if not Helper.Text.Visible then
				Helper.Text.Position = UDim2.fromOffset(Button.AbsolutePosition.X,Button.AbsolutePosition.Y + (45))
			end;

			Compkiller:_Animation(Helper.Text,TweenInfo.new(0.15),{
				TextTransparency = 0.35,
				BackgroundTransparency = 0,
				Position = UDim2.fromOffset(Button.AbsolutePosition.X,Button.AbsolutePosition.Y + (40 - (scale.Y / 2)))
			});

			Compkiller:_Animation(Helper.UIStroke,TweenInfo.new(0.15),{
				Transparency = 0
			});

		end;

		Compkiller:_Hover(Button,  Hold, Release);

		Release();

		local Args = {};

		function Args:SetValue(value)
			Config.Text = value;
		end;

		return Args;
	end;

	function Args:AddColorPicker(Config: MiniColorPicker)
		Config = Compkiller.__CONFIG(Config,{
			Default = Color3.fromRGB(255,255,255),
			Transparency = 0,
			Callback = function() end
		});

		local ColorPicker:Frame , ColorFrame: Frame = Value:AddLink('ColorPicker' , Config.Default);

		local Button = Compkiller:_Input(ColorPicker);

		local ColorPicker = Compkiller:_AddColorPickerPanel(Button,function(color,opc)
			Config.Default = color;
			Config.Transparency = opc;

			ColorFrame.BackgroundColor3 = color;
			ColorFrame.BackgroundTransparency = opc;

			Config.Callback(Config.Default , Config.Transparency);
		end);

		ColorPicker:SetColor(Config.Default,Config.Transparency);
		ColorPicker:Update()

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value,opc)
			Config.Default = value;
			Config.Transparency = opc;

			ColorPicker:SetColor(value,opc)

			ColorPicker:Update()

			Config.Callback(value,opc);
		end;

		function Args:GetValue()
			return {
				ColorPicker = {
					Color = Config.Default,
					Transparency = Config.Transparency
				}
			};
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddToggle(Config : MiniToggle)
		Config = Compkiller.__CONFIG(Config,{
			Flag = nil,
			Default = false,
			Callback = function() end;
		});

		local Toggle = Value:AddLink("Toggle" , Config.Default);

		Toggle.Input.MouseButton1Click:Connect(function()
			Config.Default = not Config.Default;

			Toggle.ChangeValue(Config.Default);

			Config.Callback(Config.Default);
		end);

		local Args = {};

		Args.Flag = Config.Flag

		function Args:SetValue(value)
			Config.Default = value;

			Toggle.ChangeValue(Config.Default);

			Config.Callback(Config.Default);
		end;

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddOption()
		local Element: ImageButton = Value:AddLink("Option");
		local BaseZ_Index = math.random(1,15) * 100;

		local Signal = Compkiller.__SIGNAL(false);

		local ExtractElement = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local Elements = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local Toggl = false;

		local ToggleUI = function(bool)
			local IsSameValue = bool == Toggl;
			if IsSameValue then return end;

			Toggl = bool;

			local MainPosition = UDim2.fromOffset(Element.AbsolutePosition.X,Element.AbsolutePosition.Y + 80);
			local DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset + 15);
			local MUL = Window.AbsoluteSize.Y / 2;

			if MainPosition.Y.Offset > MUL then -- go up
				MainPosition = UDim2.fromOffset(Element.AbsolutePosition.X,Element.AbsolutePosition.Y + 45);
				DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset - 25);
				ExtractElement.AnchorPoint = Vector2.new(0,1)
			else
				ExtractElement.AnchorPoint = Vector2.new(0,0)
			end;

			if bool then
				Signal:Fire(true);

				if not IsSameValue then
					ExtractElement.Position = DropPosition
				end;

				Compkiller:_Animation(ExtractElement , Tween , {
					Position = MainPosition,
					BackgroundTransparency = 0,
					Size = UDim2.new(0, 225, 0, UIListLayout.AbsoluteContentSize.Y)
				});

				Compkiller:_Animation(UIStroke , Tween , {
					Transparency = 0
				});

			else
				Signal:Fire(false);

				Compkiller:_Animation(ExtractElement , Tween , {
					Position = DropPosition,
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 225, 0, UIListLayout.AbsoluteContentSize.Y - 10)
				});

				Compkiller:_Animation(UIStroke , Tween , {
					Transparency = 1
				});
			end;
		end;

		Compkiller:_AddPropertyEvent(ExtractElement,function(bool)
			ExtractElement.Visible = bool;
		end);

		Compkiller:_AddDragBlacklist(ExtractElement);

		ExtractElement.Name = Compkiller:_RandomString()
		ExtractElement.Parent = Window
		ExtractElement.BackgroundColor3 = Compkiller.Colors.BlockBackground
		ExtractElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ExtractElement.BorderSizePixel = 0
		ExtractElement.ClipsDescendants = true
		ExtractElement.Position = UDim2.new(123, 0, 123, 0)
		ExtractElement.Size = UDim2.new(0, 225, 0, 35)
		ExtractElement.ZIndex = BaseZ_Index
		ExtractElement.Visible = false
		ExtractElement.ClipsDescendants = true

		table.insert(Compkiller.Elements.BlockBackground,{
			Element = ExtractElement,
			Property = "BackgroundColor3"
		});

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = ExtractElement

		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = ExtractElement

		Elements.Name = Compkiller:_RandomString()
		Elements.Parent = ExtractElement
		Elements.AnchorPoint = Vector2.new(0.5, 0.5)
		Elements.BackgroundTransparency = 1.000
		Elements.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Elements.BorderSizePixel = 0
		Elements.Position = UDim2.new(0.5, 0, 0.5, 0)
		Elements.Size = UDim2.new(1, -5, 1,-1)
		Elements.ZIndex = BaseZ_Index + 20

		UIListLayout.Parent = Elements
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 0)

		ToggleUI(false);

		Element.MouseButton1Click:Connect(function()
			ToggleUI(true);
		end);

		Compkiller:_RegisterClickListener(function(Input)
			if Toggl and not Compkiller:_IsMouseOverFrame(ExtractElement) and not Compkiller:_IsMouseOverFrame(Element) then
				ToggleUI(false);
			end;
		end, ExtractElement);

		return Compkiller:_LoadElement(Elements , true , Signal)
	end;

	return Args;
end;

-- Optional model provider; one lazy viewport and orbit connection per dropdown.
function Compkiller:_CreateDropdownPreview(Window, Popup, Resolve, IsOpen, Options)
    if type(Resolve) ~= "function" then return nil end
    Options = Options or {}
    local ui = self
    local preview = {Generation = 0, Cache = {}, Controls = {}, Zoom = 1, Pitch = 0.18}

    function preview:Hide()
        self.Generation = self.Generation + 1
        self.Row, self.Dragging = nil, nil
        if self.Scene then self.Scene.Parent = nil;self.Scene = nil end
        if self.Thread and self.Thread ~= coroutine.running() then pcall(task.cancel, self.Thread) end
        self.Thread = nil
        if self.PendingScene then self.PendingScene:Destroy();self.PendingScene = nil end
        if self.Render then self.Render:Disconnect();self.Render = nil end
        if self.Panel then self.Panel.Visible = false end
        if self.World then self.World:ClearAllChildren() end
    end

    function preview:Valid(generation)
        if self.Destroyed or generation ~= self.Generation or not IsOpen()
            or not self.Row or not self.Row.Parent or not Popup.Parent or not Popup.Visible then return false end
        local object = self.Row
        while object and object ~= Window do
            if object:IsA("GuiObject") and not object.Visible then return false end
            object = object.Parent
        end
        return object == Window and (not Window:IsA("ScreenGui") or Window.Enabled)
    end

    function preview:Ensure()
        if self.Panel then return end
        local panel = Instance.new("TextButton")
        panel.Text, panel.AutoButtonColor = "", false
        panel.Name, panel.Size, panel.BorderSizePixel = "DropdownModelPreview", UDim2.fromOffset(220, 238), 0
        panel.Active = true
        ui:_AddDragBlacklist(panel)
        panel.ZIndex, panel.Parent = Popup.ZIndex + 20, Window
        local corner = Instance.new("UICorner", panel);corner.CornerRadius = UDim.new(0, 8)
        local stroke = Instance.new("UIStroke", panel);stroke.Transparency = 0.4
        local title = Instance.new("TextLabel", panel)
        title.BackgroundTransparency, title.TextXAlignment = 1, Enum.TextXAlignment.Left
        title.Position, title.Size, title.ZIndex = UDim2.fromOffset(10, 7), UDim2.new(1, -20, 0, 22), panel.ZIndex + 1
        title.Font, title.TextSize, title.TextTruncate = Enum.Font.GothamMedium, 14, Enum.TextTruncate.AtEnd
        local caption = Instance.new("TextLabel", panel)
        caption.BackgroundTransparency, caption.TextXAlignment = 1, Enum.TextXAlignment.Center
        caption.Position, caption.Size, caption.ZIndex = UDim2.new(0, 8, 1, -25), UDim2.new(1, -16, 0, 18), panel.ZIndex + 1
        caption.Font, caption.TextSize, caption.TextTruncate = Enum.Font.Gotham, 12, Enum.TextTruncate.AtEnd
        local viewport = Instance.new("ViewportFrame", panel)
        viewport.Name, viewport.BackgroundTransparency = "Model", 1
        viewport.Position, viewport.Size, viewport.ZIndex = UDim2.fromOffset(28, 33), UDim2.new(1, -56, 1, -63), panel.ZIndex + 1
        viewport.Active = true
        viewport.Ambient, viewport.LightColor = Color3.fromRGB(180, 180, 180), Color3.new(1, 1, 1)
        viewport.LightDirection = Vector3.new(-1, -1, -1)
        local camera = Instance.new("Camera", viewport);camera.FieldOfView = 35
        viewport.CurrentCamera = camera
        local world = Instance.new("WorldModel", viewport)
        ui:_BindPolishColor(panel, "BackgroundColor3", "Popup")
        ui:_BindPolishColor(stroke, "Color", "StrokeColor")
        ui:_BindPolishColor(title, "TextColor3", "SwitchColor")
        ui:_BindPolishColor(caption, "TextColor3", "MutedText")
        self.Panel, self.Title, self.Caption = panel, title, caption
        self.Viewport, self.Camera, self.World = viewport, camera, world
        local function arrow(text, right)
            local button = Instance.new("TextButton", panel)
            button.Name, button.Text = right and "NextTree" or "PreviousTree", text
            button.BackgroundTransparency, button.AutoButtonColor = 1, false
            button.Active = true
            button.Font, button.TextSize, button.ZIndex = Enum.Font.GothamMedium, 28, panel.ZIndex + 2
            button.Size, button.Position = UDim2.fromOffset(26, 48), UDim2.new(right and 1 or 0, right and -26 or 0, 0.5, -24)
            ui:_BindPolishColor(button, "TextColor3", "SwitchColor")
            button.MouseButton1Click:Connect(function() self:Browse(right and 1 or -1) end)
            return button
        end
        self.Previous, self.Next = arrow("‹", false), arrow("›", true)
        self.Previous.Visible, self.Next.Visible = false, false
        self.Caption.Text = "Drag to rotate • Scroll to zoom"
        viewport.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                self.Dragging, self.Pointer = input, input.Position
            end
        end)
        viewport.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseWheel and self.Panel.Visible then
                self.Zoom = math.clamp(self.Zoom * (0.85 ^ input.Position.Z), 0.35, 3)
            end
        end)
        table.insert(self.Controls, UserInputService.InputChanged:Connect(function(input)
            if not self.Dragging or not self.Panel.Visible then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement or input == self.Dragging then
                local delta = input.Position - self.Pointer
                self.Pointer = input.Position
                self.Angle = (self.Angle or 0.5) - delta.X * 0.008
                self.Pitch = math.clamp(self.Pitch + delta.Y * 0.008, -1.3, 1.3)
            end
        end))
        table.insert(self.Controls, UserInputService.InputEnded:Connect(function(input)
            if input == self.Dragging or input.UserInputType == Enum.UserInputType.MouseButton1 then self.Dragging = nil end
        end))
    end

    function preview:Place()
        local origin, screen = Window.AbsolutePosition, Window.AbsoluteSize
        local width, height = self.Panel.AbsoluteSize.X, self.Panel.AbsoluteSize.Y
        local x = Popup.AbsolutePosition.X + Popup.AbsoluteSize.X + 10
        if x + width > origin.X + screen.X - 8 then x = Popup.AbsolutePosition.X - width - 10 end
        x = math.clamp(x, origin.X + 8, math.max(origin.X + 8, origin.X + screen.X - width - 8)) - origin.X
        local y = math.clamp(self.Row.AbsolutePosition.Y, origin.Y + 8,
            math.max(origin.Y + 8, origin.Y + screen.Y - height - 8)) - origin.Y
        if self.X ~= x or self.Y ~= y then
            self.X, self.Y = x, y
            self.Panel.Position = UDim2.fromOffset(x, y)
        end
    end

    function preview:Load(source, active)
        if typeof(source) ~= "Instance" or not source.Parent then return false end
        local archivable = source.Archivable
        local ok, clone = pcall(function() source.Archivable = true;return source:Clone() end)
        pcall(function() source.Archivable = archivable end)
        if not ok or not clone then return false end
        local scene = Instance.new("Model")
        self.PendingScene = scene
        clone.Parent = scene
        local worked, failure = pcall(function()
            local started, count, parts = os.clock(), 0, 0
            for _, object in ipairs(scene:GetDescendants()) do
                if not active() then return false end
                if object:IsA("LuaSourceContainer") or object:IsA("BodyMover") or object:IsA("JointInstance")
                    or object:IsA("Constraint") or object:IsA("Sound") or object:IsA("ClickDetector")
                    or object:IsA("ProximityPrompt") or object:IsA("SelectionBox") or object:IsA("Highlight")
                    or object:IsA("BillboardGui") or object:IsA("SurfaceGui") or object:IsA("ParticleEmitter")
                    or object:IsA("Trail") or object:IsA("Beam") then object:Destroy()
                elseif object:IsA("BasePart") then
                    parts = parts + 1
                    object.Anchored, object.CanCollide, object.CanTouch, object.CanQuery = true, false, false, false
                end
                count = count + 1
                if count >= 512 or os.clock() - started >= 0.0015 then
                    task.wait();started, count = os.clock(), 0
                end
            end
            if parts == 0 or not active() then return false end
            local bounds, size = scene:GetBoundingBox()
            scene:PivotTo(CFrame.new(-bounds.Position) * scene:GetPivot())
            local aspect = math.max(self.Viewport.AbsoluteSize.X, 1) / math.max(self.Viewport.AbsoluteSize.Y, 1)
            local halfFov = math.rad(self.Camera.FieldOfView * 0.5)
            local fit = math.min(halfFov, math.atan(math.tan(halfFov) * aspect))
            self.Distance = math.max(0.5, size.Magnitude * 0.5) / math.sin(fit) * 1.15
            scene.Parent = self.World
            return true
        end)
        if self.PendingScene == scene then self.PendingScene = nil end
        if not worked or not failure then scene:Destroy();return false end
        return true, scene
    end

    function preview:Buttons()
        if self.Previous then self.Previous.Visible = (self.Rank or 1) > 1 end
        if self.Next then self.Next.Visible = (self.Rank or 1) < (self.Total or 0) end
    end

    function preview:Browse(delta)
        local rank = math.clamp((self.Rank or 1) + delta, 1, math.max(1, self.Total or 0))
        if rank ~= self.Rank then self:Show(Popup, self.LastValue, rank) end
    end

    function preview:Open()
        if Options.Default then self:Show(Popup, self.LastValue or Options.Default, self.Rank) end
    end

    function preview:Show(row, value, rank)
        if self.Row and self.LastValue == value and self.Rank == (rank or 1) and self.Panel and self.Panel.Visible then return end
        self:Hide()
        self.Row = Options.Persistent and Popup or row
        self.LastValue, self.Rank = value, rank or 1
        local generation = self.Generation
        if not self:Valid(generation) then return end
        self:Ensure()
        self.Title.Text, self.Caption.Text, self.Panel.Visible = tostring(value), "Loading preview…", true
        self.Distance, self.Angle = nil, 0.5
        self:Buttons()
        self:Place()
        self.Render = RunService.RenderStepped:Connect(function(dt)
            if not self:Valid(generation) then self:Hide();return end
            self:Place()
            if self.Distance then
                if not self.Dragging then self.Angle = self.Angle + math.min(dt, 0.1) * 0.25 end
                local distance = self.Distance * self.Zoom
                self.Camera.CFrame = CFrame.lookAt(Vector3.new(math.sin(self.Angle) * math.cos(self.Pitch) * distance,
                    math.sin(self.Pitch) * distance, math.cos(self.Angle) * math.cos(self.Pitch) * distance), Vector3.zero)
            end
        end)
        local key = tostring(value) .. "#" .. self.Rank
        local cached = self.Cache[key]
        if cached and os.clock() - cached.Time <= 10 and cached.Source.Parent == cached.Parent and cached.Source.Parent and not cached.Source:FindFirstChild("RootCut") then
            cached.Used = os.clock()
            self.Scene, self.Distance, self.Total = cached.Scene, cached.Distance, cached.Total
            self.Scene.Parent = self.World
            self.Caption.Text = cached.Caption
            self:Buttons()
            return
        end
        if cached then cached.Scene:Destroy();self.Cache[key] = nil end
        self.Thread = task.defer(function()
            local function active() return self:Valid(generation) end
            local ok, source, caption, total, actualRank = pcall(Resolve, value, active, self.Rank)
            if not active() then return end
            local loaded, scene
            if ok then loaded, scene = self:Load(source, active) end
            if not active() then return end
            self.Total, self.Rank = total or 0, actualRank or self.Rank
            self.Caption.Text = loaded and (caption or "3D preview") or (ok and not source and caption) or "Preview unavailable"
            if loaded then
                self.Scene = scene
                key = tostring(value) .. "#" .. self.Rank
                if self.Scene then
                    self.Cache[key] = {Scene = self.Scene, Source = source, Parent = source.Parent, Distance = self.Distance,
                        Total = self.Total, Caption = self.Caption.Text, Time = os.clock(), Used = os.clock()}
                    local count, oldestKey, oldest = 0, nil, math.huge
                    for otherKey, entry in pairs(self.Cache) do
                        count = count + 1
                        if otherKey ~= key and entry.Used < oldest then oldestKey, oldest = otherKey, entry.Used end
                    end
                    if count > 6 and oldestKey then self.Cache[oldestKey].Scene:Destroy();self.Cache[oldestKey] = nil end
                end
            end
            self:Buttons()
            self.Thread = nil
        end)
    end

    function preview:Bind(row, value, connections)
        table.insert(connections, row.MouseEnter:Connect(function() self:Show(row, value) end))
        local function hide() if self.Row == row then self:Hide() end end
        if not Options.Persistent then table.insert(connections, row.MouseLeave:Connect(hide)) end
        table.insert(connections, row.Destroying:Connect(hide))
        table.insert(connections, row:GetPropertyChangedSignal("Visible"):Connect(function() if not row.Visible then hide() end end))
    end
    Popup:GetPropertyChangedSignal("Visible"):Connect(function() if not Popup.Visible then preview:Hide() end end)
    Popup.Destroying:Connect(function()
        preview.Destroyed = true;preview:Hide()
        for _, connection in ipairs(preview.Controls) do connection:Disconnect() end
        for _, entry in pairs(preview.Cache) do entry.Scene:Destroy() end
        table.clear(preview.Cache)
        if preview.Panel then preview.Panel:Destroy() end
    end)
    return preview
end
function Compkiller:_LoadDropdown(BaseParent: TextButton , Callback: () -> any, Preview: any, PreviewOptions: any, ItemIcon: any)
	local HoverPreview;
	local Window = Compkiller:_GetWindowFromElement(BaseParent);
	local BaseZ_Index = 100000 + BaseParent.ZIndex + (math.random(1,15) * 100);

	local DropdownWindow = Instance.new("TextButton")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ToggleDb = Compkiller.__SIGNAL(false);
	local EventOut = Compkiller.__SIGNAL(0);

	DropdownWindow.Name = Compkiller:_RandomString()
	DropdownWindow.Parent = Window
	DropdownWindow.ClipsDescendants = true
	DropdownWindow.Active = true
	DropdownWindow.Text = ""
	DropdownWindow.AutoButtonColor = false
	DropdownWindow.BackgroundColor3 = Compkiller.Colors.BGDBColor
	DropdownWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DropdownWindow.BorderSizePixel = 0
	DropdownWindow.Position = UDim2.new(123, 0, 123, 0)
	DropdownWindow.Size = UDim2.new(0, 190, 0, 200)
	DropdownWindow.ZIndex = BaseZ_Index

	Compkiller:_BindPolishColor(DropdownWindow, "BackgroundColor3", "Popup");

	Compkiller:_AddDragBlacklist(DropdownWindow);
	Compkiller:_AddPropertyEvent(DropdownWindow,function(v)
		DropdownWindow.Visible = v and ToggleDb:GetValue();
	end)

	UIStroke.Color = Compkiller.Colors.StrokeColor
	UIStroke.Parent = DropdownWindow

	Compkiller:_BindColor(Compkiller.Elements.StrokeColor , {
		Element = UIStroke,
		Property = "Color"
	})

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = DropdownWindow

	local SearchBox = Instance.new("TextBox")
	SearchBox.Parent = DropdownWindow
	SearchBox.Size = UDim2.new(1, -10, 0, 25)
	SearchBox.Position = UDim2.new(0, 5, 0, 5)
	SearchBox.BackgroundTransparency = 1
	SearchBox.TextColor3 = Compkiller.Colors.SwitchColor
	Compkiller:_BindPolishColor(SearchBox, "PlaceholderColor3", "Placeholder");
	SearchBox.PlaceholderText = "Search..."
	SearchBox.Font = Enum.Font.GothamMedium
	SearchBox.TextSize = 15
	SearchBox.ZIndex = BaseZ_Index + 5

	Compkiller:_BindColor(Compkiller.Elements.SwitchColor, {
		Element = SearchBox,
		Property = "TextColor3"
	})

	local ClearButton = Instance.new("TextButton")
	local ClearCorner = Instance.new("UICorner")
	local ClearStroke = Instance.new("UIStroke")

	ClearButton.Name = Compkiller:_RandomString()
	ClearButton.Parent = DropdownWindow
	ClearButton.AnchorPoint = Vector2.new(1, 0)
	ClearButton.Position = UDim2.new(1, -6, 0, 5)
	ClearButton.Size = UDim2.new(0, 62, 0, 20)
	ClearButton.BackgroundColor3 = Compkiller.Colors.DropColor
	ClearButton.Text = "Clear All"
	ClearButton.TextColor3 = Compkiller.Colors.SwitchColor
	ClearButton.Font = Enum.Font.GothamMedium
	ClearButton.TextSize = 12
	ClearButton.ZIndex = BaseZ_Index + 6
	ClearButton.Visible = false
	ClearButton.AutoButtonColor = false

	ClearCorner.CornerRadius = UDim.new(0, 4)
	ClearCorner.Parent = ClearButton

	ClearStroke.Color = Compkiller.Colors.StrokeColor
	ClearStroke.Thickness = 1
	ClearStroke.Parent = ClearButton
	Compkiller:_BindPolishColor(ClearButton, "BackgroundColor3", "DropColor");
	Compkiller:_BindPolishColor(ClearButton, "TextColor3", "SwitchColor");
	Compkiller:_BindPolishColor(ClearStroke, "Color", "StrokeColor");

	Compkiller:_Hover(ClearButton, function()
		Compkiller:_Animation(ClearButton, TweenInfo.new(0.15), {
			BackgroundColor3 = Compkiller:_PolishColor("Hover")
		})
		Compkiller:_Animation(ClearButton, TweenInfo.new(0.15), {
			TextColor3 = Compkiller.Colors.SwitchColor
		})
	end, function()
		Compkiller:_Animation(ClearButton, TweenInfo.new(0.15), {
			BackgroundColor3 = Compkiller.Colors.DropColor
		})
		Compkiller:_Animation(ClearButton, TweenInfo.new(0.15), {
			TextColor3 = Compkiller.Colors.SwitchColor
		})
	end)

	ScrollingFrame.Parent = DropdownWindow
	ScrollingFrame.Active = true
	ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.5, 0, 0, 30)
	ScrollingFrame.Size = UDim2.new(1, -5, 1, -35)
	ScrollingFrame.ZIndex = BaseZ_Index + 5
	ScrollingFrame.BottomImage = ""
	ScrollingFrame.ScrollBarThickness = 0
	ScrollingFrame.TopImage = ""

	UIListLayout.Parent = ScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 6)

	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X,UIListLayout.AbsoluteContentSize.Y)
	end);

	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		if HoverPreview and not (PreviewOptions and PreviewOptions.Persistent) then HoverPreview:Hide() end;
		local query = string.lower(SearchBox.Text)
		for _, item in ipairs(ScrollingFrame:GetChildren()) do
			if item:IsA("Frame") then
				local textLabel = item:FindFirstChildOfClass("TextLabel")
				if textLabel then
					local text = textLabel.Text
					if query == "" or string.find(string.lower(text), query, 1, true) then
						item.Visible = true
					else
						item.Visible = false
					end
				end
			end
		end
	end)

	DropdownWindow.Visible = false;
	local InputShield, SetDropdownInputOpen, ShouldCloseDropdown = Compkiller:_CreateDropdownInputShield(Window, DropdownWindow, function()
        return Compkiller:_IsMouseOverFrame(DropdownWindow)
            or (HoverPreview and HoverPreview.Panel and Compkiller:_IsMouseOverFrame(HoverPreview.Panel))
    end);
	local SetDropdownHoverOpen = Compkiller:_RegisterDropdownHoverBlocker(DropdownWindow);
	if type(Preview) == "function" then
		HoverPreview = Compkiller:_CreateDropdownPreview(Window, DropdownWindow, Preview, function() return ToggleDb:GetValue() end, PreviewOptions);
		ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() if not (PreviewOptions and PreviewOptions.Persistent) then HoverPreview:Hide() end end);
	end;

	local OrderDropdownRows;
	local ToggleUI = function(bool)
		if not bool and HoverPreview then HoverPreview:Hide() end;
		local IsSame = ToggleDb:GetValue() == bool;
		if IsSame then return end;
		DropdownWindow.Visible = bool;
		SetDropdownInputOpen(bool);

        if bool and OrderDropdownRows then
            OrderDropdownRows();
            ScrollingFrame.CanvasPosition = Vector2.zero;
        end;

		EventOut:Fire(bool);
		ToggleDb:Fire(bool);
		SetDropdownHoverOpen(bool);

		local dropWidth = BaseParent:GetAttribute("DropdownWidth") or (BaseParent.AbsoluteSize.X - 1)
		local offsetX = BaseParent:GetAttribute("DropdownOffsetX") or 0

		local MainPosition = UDim2.fromOffset(BaseParent.AbsolutePosition.X + 1 + offsetX,BaseParent.AbsolutePosition.Y + 80);
		local DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset + 25);

		DropdownWindow.AnchorPoint = Vector2.zero;

		if bool then
			if not IsSame then
				DropdownWindow.Position = DropPosition;
			end;
			SearchBox.Text = "" -- clear search when opening

			task.spawn(function()
				task.wait() -- Allow layout to update absolute size
				Compkiller:_Animation(DropdownWindow,TweenInfo.new(0.2),{
					BackgroundTransparency = 0,
					Position = MainPosition,
					Size = UDim2.new(0, dropWidth, 0, math.clamp(UIListLayout.AbsoluteContentSize.Y + 45, 45, 200))
				})
				if HoverPreview and ToggleDb:GetValue() then HoverPreview:Open() end;
			end)

			Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
				Transparency = 0
			})
		else
			Compkiller:_Animation(DropdownWindow,TweenInfo.new(0.2),{
				BackgroundTransparency = 1,
				Position = DropPosition,
				Size = UDim2.new(0, dropWidth, 0, math.clamp(UIListLayout.AbsoluteContentSize.Y / 1.5, 10 , 200))
			})

			Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
				Transparency = 1
			})
		end;
	end;

	ToggleUI(false)
    Compkiller:_RegisterDropdownDismiss(DropdownWindow, Window, ToggleUI);

	local SpamUpdate,_Delay = false , tick();
	local __signals = {};
	local Default = nil;
	local Values = nil;
	local IsMulti = false;
	local currentDataFrame = nil;
	local currentButtons = {};

	local DrawButton = function()
		local DropdownItem = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")

		DropdownItem.Name = Compkiller:_RandomString()
		DropdownItem.BackgroundTransparency = 1.000
		DropdownItem.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownItem.BorderSizePixel = 0
		DropdownItem.Size = UDim2.new(1, -8, 0, 24)
		DropdownItem.ZIndex = BaseZ_Index + 6
		
		UIStroke.Parent = DropdownItem
		UIStroke.Transparency = 1
		
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = DropdownItem

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = DropdownItem
		BlockText.AnchorPoint = Vector2.new(0, 0.5)
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 5, 0.5, 0)
		BlockText.Size = UDim2.new(1, -10, 0, 25)
		BlockText.ZIndex = BaseZ_Index + 6
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = ""
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 15
		BlockText.TextTransparency = 0.120
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		Compkiller:_BindColor(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = DropdownItem
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.800
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -6, 0, 1)
		BlockLine.ZIndex = BaseZ_Index + 7

		Compkiller:_BindColor(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		return {
			BlockText = BlockText,
			DropdownItem = DropdownItem,
			BlockLine = BlockLine,
			UIStroke = UIStroke
		};
	end;

	local ClearDropdown = function()
		if HoverPreview then HoverPreview:Hide() end;
		for i,v in next , ScrollingFrame:GetChildren() do
			if v:IsA('Frame') then
				v:Destroy();
			end;
		end;

		for i,v in next,  __signals do
			v:Disconnect();
		end;
		table.clear(__signals)
	end;

	local IsDefault = function(v)
		return (typeof(Default) == 'table' and (Default[v] or table.find(Default,v))) or Default == v;
	end;

	local MatchDefault = function(v,DataFrame)
		return (typeof(DataFrame) == 'table' and (DataFrame[v] or table.find(DataFrame,v))) or DataFrame == v;
	end;

    -- Stable selected-first grouping, applied when opening rather than mid-click.
    OrderDropdownRows = function()
        local selectedOrder, otherOrder = 0, 0;
        local selection = currentDataFrame or Default;
        for _, row in ipairs(currentButtons) do
            if IsMulti and MatchDefault(row.Value, selection) then
                selectedOrder = selectedOrder + 1;
                row.DropdownItem.LayoutOrder = selectedOrder;
            else
                otherOrder = otherOrder + 1;
                row.DropdownItem.LayoutOrder = IsMulti and (#currentButtons + otherOrder) or otherOrder;
            end;
        end;
    end;

	local UpdateDropdown = function()
		currentButtons = {};

		if IsMulti then
			currentDataFrame = {};
			ClearButton.Visible = true;
			SearchBox.Size = UDim2.new(1, -74, 0, 22);
			SearchBox.Position = UDim2.new(0, 6, 0, 4);
		else
			currentDataFrame = nil;
			ClearButton.Visible = false;
			SearchBox.Size = UDim2.new(1, -10, 0, 25);
			SearchBox.Position = UDim2.new(0, 5, 0, 5);
		end;

		for i,v in next , Values do
			local bth = DrawButton();

			bth.BlockText.Text = tostring(v);

			bth.DropdownItem.Parent = ScrollingFrame;

            if type(ItemIcon) == "function" then
                local ok, image = pcall(ItemIcon, v)
                local icon = Instance.new("ImageLabel", bth.DropdownItem)
                icon.Name, icon.BackgroundTransparency = "ItemIcon", 1
                icon.Size, icon.Position = UDim2.fromOffset(22, 22), UDim2.new(0, 4, 0.5, -11)
                icon.Image, icon.ScaleType, icon.ZIndex = ok and type(image) == "string" and image or "", Enum.ScaleType.Fit, BaseZ_Index + 7
                bth.BlockText.Position, bth.BlockText.Size = UDim2.new(0, 32, 0.5, 0), UDim2.new(1, -37, 0, 25)
                table.insert(__signals, ToggleDb:Connect(function(open) icon.ImageTransparency = open and 0 or 1 end))
            end
			bth.Value = v;
			if HoverPreview then HoverPreview:Bind(bth.DropdownItem, v, __signals) end;
			table.insert(currentButtons, bth);
            bth.DropdownItem.LayoutOrder = #currentButtons;

			table.insert(__signals , ToggleDb:Connect(function(bool)
				if bool then
					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = ((IsDefault(v) or MatchDefault(v,currentDataFrame or DataFrame)) and 0) or 0.12
					});

					Compkiller:_Animation(bth.BlockLine,TweenInfo.new(0.2),{
						BackgroundTransparency = 0.8
					});
				else
					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = 1
					});

					Compkiller:_Animation(bth.BlockLine,TweenInfo.new(0.2),{
						BackgroundTransparency = 1
					});
				end;
			end));

			if ToggleDb:GetValue() then
				Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
					TextTransparency = ((IsDefault(v) or MatchDefault(v,currentDataFrame or DataFrame)) and 0) or 0.12
				});
			end;

			if IsDefault(v) and not IsMulti then
				DataFrame = bth;
			end;

			local btn;
			if IsMulti then
				if IsDefault(v) or MatchDefault(v,currentDataFrame) then
					currentDataFrame[v] = true;
				else
					currentDataFrame[v] = false;
				end;

				Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
					TextTransparency = ((MatchDefault(v,currentDataFrame)) and 0) or 0.12
				});

				btn = Compkiller:_Input(bth.DropdownItem,function()
					currentDataFrame[v] = not currentDataFrame[v];

					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = ((MatchDefault(v,currentDataFrame)) and 0) or 0.12
					});

					Callback(currentDataFrame)
				end);
			else
				btn = Compkiller:_Input(bth.DropdownItem,function()
					if DataFrame then
						Compkiller:_Animation(DataFrame.BlockText,TweenInfo.new(0.2),{
							TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.12
						});
					end;

					Default = v;

					DataFrame = bth;

					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.12
					});

					Callback(DataFrame.Value)
					ToggleUI(false)
				end);
			end;
			
			local RowHighlighted = false;
			local function applyHighlight(isHighlighted)
				RowHighlighted = isHighlighted;
				if isHighlighted then
					Compkiller:_Animation(bth.DropdownItem,TweenInfo.new(0.2),{
						BackgroundColor3 = Compkiller:_PolishColor("Hover"),
						BackgroundTransparency = 0
					})
					Compkiller:_Animation(bth.UIStroke,TweenInfo.new(0.2),{
						Color = Compkiller.Colors.Highlight,
						Transparency = 0.25
					})
				else
					Compkiller:_Animation(bth.DropdownItem,TweenInfo.new(0.2),{
						BackgroundTransparency = 1
					})
					Compkiller:_Animation(bth.UIStroke,TweenInfo.new(0.2),{
						Transparency = 1
					})
				end
			end
			
			Compkiller:_BindPolishUpdate(bth.DropdownItem, function() applyHighlight(RowHighlighted); end);

			btn.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					applyHighlight(true)
				end
			end)
			btn.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					applyHighlight(false)
				end
			end)
			Compkiller:_Hover(bth.DropdownItem, function()
				applyHighlight(true)
			end, function()
				applyHighlight(false)
			end, true)
		end;
        OrderDropdownRows();
        if HoverPreview and ToggleDb:GetValue() then HoverPreview:Open() end;
	end;

	Compkiller:_BindClickRipple(ClearButton);
	ClearButton.MouseButton1Click:Connect(function()
		if not IsMulti or not currentDataFrame then return end

		for k, _ in pairs(currentDataFrame) do
			currentDataFrame[k] = false
		end
		Default = {}

		for _, bth in ipairs(currentButtons) do
			if bth and bth.BlockText then
				Compkiller:_Animation(bth.BlockText, TweenInfo.new(0.2), {
					TextTransparency = 0.12
				})
			end
		end

		Callback(currentDataFrame)
	end)

	BaseParent.MouseButton1Click:Connect(function()
		if SpamUpdate then
			ClearDropdown();
			UpdateDropdown();
		end;

		ToggleUI(not ToggleDb:GetValue());
	end);

    -- Close on release so the entire outside click belongs to the shield.
    InputShield.MouseButton1Click:Connect(function()
        if ShouldCloseDropdown() then ToggleUI(false); end;
    end);

	local Args = {};

	function Args:SetDefault(v)
		Default = v;
	end;

	function Args:ClearSelection()
		if IsMulti and currentDataFrame then
			for k, _ in pairs(currentDataFrame) do
				currentDataFrame[k] = false
			end
			Default = {}
			for _, bth in ipairs(currentButtons) do
				if bth and bth.BlockText then
					bth.BlockText.TextTransparency = 0.12
				end
			end
			Callback(currentDataFrame)
		end
	end;

	function Args:SetData(Def,Val,Multi,Vis)
		if Vis and ((tick() - _Delay) <= 0.1) then
			_Delay = tick();
			SpamUpdate = true;
		else
			SpamUpdate = false;	
		end;

		IsMulti = Multi;
		Default = Def;
		Values = Val;

		if Vis and not SpamUpdate then
			ClearDropdown();
			UpdateDropdown();
		end;
	end;

	function Args:Refersh()
		ClearDropdown();
		UpdateDropdown();
	end;

	Args.EventOut = EventOut;

	return Args;
end;

-- Image Dropdown backend ─────────────────────────────────────────────────────
function Compkiller:_LoadImageDropdown(BaseParent: TextButton, Callback: () -> any, Preview: any)
	local HoverPreview;
	local Window      = Compkiller:_GetWindowFromElement(BaseParent);
	local BaseZ_Index = 100000 + BaseParent.ZIndex + (math.random(1,15) * 100);

	local DropdownWindow = Instance.new("TextButton");
	local UIStroke       = Instance.new("UIStroke");
	local UICorner       = Instance.new("UICorner");
	local ScrollingFrame = Instance.new("ScrollingFrame");
	local UIListLayout   = Instance.new("UIListLayout");
	local ToggleDb       = Compkiller.__SIGNAL(false);
	local EventOut       = Compkiller.__SIGNAL(0);

	DropdownWindow.Name                 = Compkiller:_RandomString();
	DropdownWindow.Parent               = Window;
	DropdownWindow.Active               = true;
	DropdownWindow.Text                 = "";
	DropdownWindow.AutoButtonColor      = false;
	DropdownWindow.BackgroundColor3     = Compkiller.Colors.BGDBColor;
	DropdownWindow.BorderColor3         = Color3.fromRGB(0,0,0);
	DropdownWindow.BorderSizePixel      = 0;
	DropdownWindow.Position             = UDim2.new(123,0,123,0);
	DropdownWindow.Size                 = UDim2.new(0,190,0,200);
	DropdownWindow.ZIndex               = BaseZ_Index;

	Compkiller:_BindPolishColor(DropdownWindow, "BackgroundColor3", "Popup");
	Compkiller:_AddDragBlacklist(DropdownWindow);
	Compkiller:_AddPropertyEvent(DropdownWindow, function(v) DropdownWindow.Visible = v and ToggleDb:GetValue(); end);

	UIStroke.Color  = Compkiller.Colors.StrokeColor;
	UIStroke.Parent = DropdownWindow;
	Compkiller:_BindColor(Compkiller.Elements.StrokeColor,{Element=UIStroke,Property="Color"});

	UICorner.CornerRadius = UDim.new(0,6);
	UICorner.Parent       = DropdownWindow;

	ScrollingFrame.Parent                 = DropdownWindow;
	ScrollingFrame.Active                 = true;
	ScrollingFrame.AnchorPoint            = Vector2.new(0.5,0.5);
	ScrollingFrame.BackgroundTransparency = 1;
	ScrollingFrame.BorderSizePixel        = 0;
	ScrollingFrame.Position               = UDim2.new(0.5,0,0.5,0);
	ScrollingFrame.Size                   = UDim2.new(1,-5,1,-5);
	ScrollingFrame.ZIndex                 = BaseZ_Index + 5;
	ScrollingFrame.BottomImage            = "";
	ScrollingFrame.ScrollBarThickness     = 0;
	ScrollingFrame.TopImage               = "";

	UIListLayout.Parent              = ScrollingFrame;
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	UIListLayout.SortOrder           = Enum.SortOrder.LayoutOrder;
	UIListLayout.Padding             = UDim.new(0,4);

	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.fromOffset(
			UIListLayout.AbsoluteContentSize.X,
			UIListLayout.AbsoluteContentSize.Y
		);
	end);

	DropdownWindow.Visible = false;
	local InputShield, SetDropdownInputOpen, ShouldCloseDropdown = Compkiller:_CreateDropdownInputShield(Window, DropdownWindow, function()
        return Compkiller:_IsMouseOverFrame(DropdownWindow)
            or (HoverPreview and HoverPreview.Panel and Compkiller:_IsMouseOverFrame(HoverPreview.Panel))
    end);
	local SetDropdownHoverOpen = Compkiller:_RegisterDropdownHoverBlocker(DropdownWindow);
	if type(Preview) == "function" then
		HoverPreview = Compkiller:_CreateDropdownPreview(Window, DropdownWindow, Preview, function() return ToggleDb:GetValue() end);
		ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() HoverPreview:Hide() end);
	end;

	local function ToggleUI(bool)
		if not bool and HoverPreview then HoverPreview:Hide() end;
		local IsSame = ToggleDb:GetValue() == bool;
		if IsSame then return end;
		DropdownWindow.Visible = bool;
		SetDropdownInputOpen(bool);
		EventOut:Fire(bool);
		ToggleDb:Fire(bool);
		SetDropdownHoverOpen(bool);

		local MainPosition = UDim2.fromOffset(BaseParent.AbsolutePosition.X + 1, BaseParent.AbsolutePosition.Y + 80);
		local DropPosition = UDim2.fromOffset(MainPosition.X.Offset, MainPosition.Y.Offset + 25);

		DropdownWindow.AnchorPoint = Vector2.zero;

		local contentH = math.clamp(UIListLayout.AbsoluteContentSize.Y + 10, 10, 240);

		if bool then
			if not IsSame then DropdownWindow.Position = DropPosition; end;
			Compkiller:_Animation(DropdownWindow, TweenInfo.new(0.2), {
				BackgroundTransparency = 0,
				Position = MainPosition,
				Size = UDim2.new(0, BaseParent.AbsoluteSize.X - 1, 0, contentH)
			});
			Compkiller:_Animation(UIStroke, TweenInfo.new(0.2), {Transparency = 0});
		else
			Compkiller:_Animation(DropdownWindow, TweenInfo.new(0.2), {
				BackgroundTransparency = 1,
				Position = DropPosition,
				Size = UDim2.new(0, BaseParent.AbsoluteSize.X - 1, 0, math.clamp(contentH / 1.5, 10, 240))
			});
			Compkiller:_Animation(UIStroke, TweenInfo.new(0.2), {Transparency = 1});
		end;
	end;

	ToggleUI(false);
    Compkiller:_RegisterDropdownDismiss(DropdownWindow, Window, ToggleUI);

	local Default  = nil;
	local Values   = nil;
	local __signals = {};

	-- Draws one image row inside the scrolling list
	local function DrawImageRow(item)
		local ROW_H = 28;

		local Row       = Instance.new("Frame");
		local UIStroke  = Instance.new("UIStroke");
		local UICorner  = Instance.new("UICorner");
		local Thumb     = Instance.new("ImageLabel");
		local Label     = Instance.new("TextLabel");
		local Divider   = Instance.new("Frame");

		Row.Name                 = Compkiller:_RandomString();
		Row.BackgroundTransparency = 1;
		Row.BorderSizePixel      = 0;
		Row.Size                 = UDim2.new(1,-8,0,ROW_H);
		Row.ZIndex               = BaseZ_Index + 6;
		
		UIStroke.Parent = Row
		UIStroke.Transparency = 1
		
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Row

		Thumb.Name                 = Compkiller:_RandomString();
		Thumb.Parent               = Row;
		Thumb.AnchorPoint          = Vector2.new(0,0.5);
		Thumb.BackgroundTransparency = 1;
		Thumb.BorderSizePixel      = 0;
		Thumb.Position             = UDim2.new(0,4,0.5,0);
		Thumb.Size                 = UDim2.new(0,20,0,20);
		Thumb.ZIndex               = BaseZ_Index + 7;
		Thumb.ScaleType            = Enum.ScaleType.Fit;
		Thumb.Image                = item.image or "";
		Thumb.ImageTransparency    = 0.25;

		Label.Name                 = Compkiller:_RandomString();
		Label.Parent               = Row;
		Label.AnchorPoint          = Vector2.new(0,0.5);
		Label.BackgroundTransparency = 1;
		Label.BorderSizePixel      = 0;
		Label.Position             = UDim2.new(0,30,0.5,0);
		Label.Size                 = UDim2.new(1,-36,0,ROW_H);
		Label.ZIndex               = BaseZ_Index + 7;
		Label.Font                 = Enum.Font.GothamMedium;
		Label.Text                 = tostring(item.name or "");
		Label.TextColor3           = Compkiller.Colors.SwitchColor;
		Label.TextSize             = 14;
		Label.TextTransparency     = 0.25;
		Label.TextXAlignment       = Enum.TextXAlignment.Left;
		Label.TextTruncate         = Enum.TextTruncate.AtEnd;
		Compkiller:_BindColor(Compkiller.Elements.SwitchColor,{Element=Label,Property='TextColor3'});

		Divider.Name                 = Compkiller:_RandomString();
		Divider.Parent               = Row;
		Divider.AnchorPoint          = Vector2.new(0.5,1);
		Divider.BackgroundColor3     = Compkiller.Colors.LineColor;
		Divider.BackgroundTransparency = 0.8;
		Divider.BorderSizePixel      = 0;
		Divider.Position             = UDim2.new(0.5,0,1,0);
		Divider.Size                 = UDim2.new(1,-6,0,1);
		Divider.ZIndex               = BaseZ_Index + 7;
		Compkiller:_BindColor(Compkiller.Elements.LineColor,{Element=Divider,Property="BackgroundColor3"});

		return {Row=Row, Thumb=Thumb, Label=Label, Divider=Divider, UIStroke=UIStroke};
	end;

	local function ClearDropdown()
		if HoverPreview then HoverPreview:Hide() end;
		for _,v in next, ScrollingFrame:GetChildren() do
			if v:IsA('Frame') then v:Destroy(); end;
		end;
		for _,v in next, __signals do v:Disconnect(); end;
		table.clear(__signals);
	end;

	local function IsDefault(item)
		if not Default then return false; end;
		if typeof(Default) == 'table' then
			return Default.name == item.name;
		end;
		return false;
	end;

	local function UpdateDropdown()
		if not Values then return; end;

		for _, item in next, Values do
			local row = DrawImageRow(item);
			row.Row.Parent = ScrollingFrame;
			if HoverPreview then HoverPreview:Bind(row.Row, item, __signals) end;

			-- highlight selected
			table.insert(__signals, ToggleDb:Connect(function(bool)
				local isSelected = IsDefault(item);
				local targetT    = (isSelected and 0) or 0.25;
				if bool then
					Compkiller:_Animation(row.Label, TweenInfo.new(0.2), {TextTransparency = targetT});
					Compkiller:_Animation(row.Thumb, TweenInfo.new(0.2), {ImageTransparency = targetT});
					Compkiller:_Animation(row.Divider, TweenInfo.new(0.2), {BackgroundTransparency = 0.8});
				else
					Compkiller:_Animation(row.Label, TweenInfo.new(0.2), {TextTransparency = 1});
					Compkiller:_Animation(row.Thumb, TweenInfo.new(0.2), {ImageTransparency = 1});
					Compkiller:_Animation(row.Divider, TweenInfo.new(0.2), {BackgroundTransparency = 1});
				end;
			end));

			if ToggleDb:GetValue() then
				local isSelected = IsDefault(item);
				row.Label.TextTransparency = isSelected and 0 or 0.25;
				row.Thumb.ImageTransparency = isSelected and 0 or 0.25;
			end;

			-- click to select
			local btn = Compkiller:_Input(row.Row, function()
				Default = item;
				ToggleUI(false);
				Callback(item);
			end);
			
			local RowHighlighted = false;
			local function applyHighlight(isHighlighted)
				RowHighlighted = isHighlighted;
				if isHighlighted then
					Compkiller:_Animation(row.Row,TweenInfo.new(0.2),{
						BackgroundColor3 = Compkiller:_PolishColor("Hover"),
						BackgroundTransparency = 0
					})
					Compkiller:_Animation(row.UIStroke,TweenInfo.new(0.2),{
						Color = Compkiller.Colors.Highlight,
						Transparency = 0.25
					})
				else
					Compkiller:_Animation(row.Row,TweenInfo.new(0.2),{
						BackgroundTransparency = 1
					})
					Compkiller:_Animation(row.UIStroke,TweenInfo.new(0.2),{
						Transparency = 1
					})
				end
			end
			
			Compkiller:_BindPolishUpdate(row.Row, function() applyHighlight(RowHighlighted); end);

			btn.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					applyHighlight(true)
				end
			end)
			btn.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					applyHighlight(false)
				end
			end)
			Compkiller:_Hover(row.Row, function()
				applyHighlight(true)
			end, function()
				applyHighlight(false)
			end, true)
		end;
	end;

	BaseParent.MouseButton1Click:Connect(function()
		ToggleUI(not ToggleDb:GetValue());
	end);

    -- Close on release so the entire outside click belongs to the shield.
    InputShield.MouseButton1Click:Connect(function()
        if ShouldCloseDropdown() then ToggleUI(false); end;
    end);

	local Args = {};

	function Args:SetDefault(v) Default = v; end;

	function Args:SetData(Def, Val)
		Default = Def;
		Values  = Val;
		ClearDropdown();
		UpdateDropdown();
	end;

	function Args:Refresh()
		ClearDropdown();
		UpdateDropdown();
	end;

	Args.EventOut = EventOut;
	return Args;
end;
-- ─────────────────────────────────────────────────────────────────────────────

function Compkiller:_LoadElement(Parent: Frame , EnabledLine: boolean , Signal)
	local Zindex = Parent.ZIndex + 1;
	local Tween = TweenInfo.new(0.25,Enum.EasingStyle.Quint);

	local Args = {};

	function Args:AddToggle(Config : Toggle)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Toggle",
			Default = false,
			Flag = nil,
			Risky = false,
			Callback = function() end;
		});
        Config.Icon = Config.Icon or (Compkiller.ActionIcons or {})[Config.Name];

		local Block = Compkiller:_CreateBlock(Signal, Config.Icon);

		Block:SetParent(Parent);
		Block.Root.Visible = Config.Visible ~= false;

		Block:SetText(Config.Name);

		if Config.Risky then
			Block:SetTextColor(Compkiller.Colors.Risky);
		end;

		Block:SetLine(EnabledLine);

		Block:SetVisible(Signal:GetValue());

		local Toggle = Block:AddLink('Toggle' , Config.Default);

		Toggle.Input.MouseButton1Click:Connect(function()
			Config.Default = not Config.Default;

			Toggle.ChangeValue(Config.Default);

			Block:SetTransparency((Config.Default and 0.05) or 0.15);

			Config.Callback(Config.Default);
		end);

		local Args = {};

		Args.Flag = Config.Flag;
		Args.Root = Block.Root;
		function Args:SetVisible(visible)
			Config.Visible = visible == true;
			Block.Root.Visible = Config.Visible;
		end;

		function Args:SetValue(value)
			Config.Default = value;

			Toggle.ChangeValue(Config.Default);

			Block:SetTransparency((Config.Default and 0.05) or 0.15);

			Config.Callback(Config.Default);
		end;

		Args.Signal = Signal:Connect(function(bool)
			Block:SetVisible(bool);

		end);

		Args.Link = Compkiller:_LoadOption(Block);

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddKeybind(Config : Keybind)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Keybind",
			Default = nil,
			Flag = nil,
			Callback = function() end;
			Blacklist = {}
		});

		local Block = Compkiller:_CreateBlock(Signal, Config.Icon);

		Block:SetParent(Parent);

		Block:SetText(Config.Name);

		Block:SetLine(EnabledLine);

		Block:SetVisible(Signal:GetValue());
		Block.Root.Visible = Config.Visible ~= false;

		local Keybind = Block:AddLink('Keybind' , Config.Default);

		local IsBinding = false;

		local IsBlacklist = function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end;

		Compkiller:_Input(Keybind.Root,function()
			if IsBinding then
				return;
			end;

			IsBinding = true;
			Keybind.SetValue("...");

			local Selected = nil;

			while not Selected do
				local Key = UserInputService.InputBegan:Wait();

				if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
					Selected = Key.KeyCode;
				else
					if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("MouseLeft") then
						Selected = "MouseLeft";
					elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("MouseRight") then
						Selected = "MouseRight";
					end;
				end;
			end;

			local KeyName = typeof(Selected) == "string" and Selected or Selected.Name;

			Config.Default = KeyName;

			Keybind.SetValue(Selected);

			IsBinding = false;

			Config.Callback(KeyName);
		end);

		local Args = {};

		Args.Flag = Config.Flag;
		function Args:SetVisible(visible)
			Config.Visible = visible == true;
			Block.Root.Visible = Config.Visible;
		end;
		function Args:IsBinding()
			return IsBinding;
		end;

		function Args:SetValue(value)
			Config.Default = value;

			Keybind.SetValue(Config.Default);

			Config.Callback(Config.Default);
		end;

		Args.Signal = Signal:Connect(function(bool)
			Block:SetVisible(bool);
		end);

		Args.Link = Compkiller:_LoadOption(Block);

		function Args:GetValue()
			return (typeof(Config.Default) == "string" and Config.Default) or Config.Default.Name;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddColorPicker(Config: ColorPicker)
		Config = Compkiller.__CONFIG(Config,{
			Name = "ColorPicker",
			Default = Color3.fromRGB(255,255,255),
			Flag = nil,
			Transparency = 0,
			Callback = function() end;
		});

		local Block = Compkiller:_CreateBlock(Signal, Config.Icon);

		Block:SetParent(Parent);

		Block:SetText(Config.Name);

		Block:SetLine(EnabledLine);

		Block:SetVisible(Signal:GetValue());

		local ColorPicker:Frame , ColorFrame: Frame = Block:AddLink('ColorPicker' , Config.Default);

		local Button = Compkiller:_Input(ColorPicker);

		local ColorPicker = Compkiller:_AddColorPickerPanel(Button,function(color,opc)
			Config.Default = color;
			Config.Transparency = opc;

			ColorFrame.BackgroundColor3 = color;
			ColorFrame.BackgroundTransparency = opc;

			Config.Callback(Config.Default , Config.Transparency);
		end);

		ColorPicker:SetColor(Config.Default,Config.Transparency);
		ColorPicker:Update()

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value, opc, silent)
            opc = opc or 0
            Config.Default = value
            Config.Transparency = opc
            ColorFrame.BackgroundColor3 = value
            ColorFrame.BackgroundTransparency = opc
            ColorPicker:SetColor(value, opc)
            -- Update already invokes the callback; avoid firing it twice.
            ColorPicker:Update(silent)
        end;

		Args.Signal = Signal:Connect(function(bool)
			Block:SetVisible(bool);
		end);

		Args.Link = Compkiller:_LoadOption(Block);

		function Args:GetValue()
			return {
				ColorPicker = {
					Color = Config.Default,
					Transparency = Config.Transparency
				}
			};
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddButton(Config: Button)
		Config = Compkiller.__CONFIG(Config , {
			Name = 'Button',
			Callback = function() end,
			Color = nil
		});
        Config.Icon = Config.Icon or (Compkiller.ActionIcons or {})[Config.Name];

		local RunCallback, IsBusy = Compkiller:_GuardButtonCallback(Config.Callback, Config);

		local Button = Instance.new("Frame")
		local BlockLine = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local TextLabel = Instance.new("TextLabel")

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(Button);
		end;

		Button.Name = Compkiller:_RandomString()
		Button.Parent = Parent
		Button.BackgroundTransparency = 1.000
		Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Button.BorderSizePixel = 0
		Button.Size = UDim2.new(1, -1, 0, 36)
		Button.ZIndex = Zindex + 5

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = Button
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 6

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		Frame.Parent = Button
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.BackgroundColor3 = Config.Color or Compkiller.Colors.BGDBColor
		Frame.BackgroundTransparency = 0
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		Frame.Size = UDim2.new(1, -24, 1, -5)
		Frame.ZIndex = Zindex + 7;

		table.insert(Compkiller.Elements.BGDBColor,{
			Element = Frame,
			Property = "BackgroundColor3"
		});

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = Frame

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Frame

		TextLabel.Parent = Frame
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.ZIndex = Zindex + 8
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = Config.Name;
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 15
		TextLabel.TextStrokeTransparency = 0.900

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextLabel,
			Property = 'TextColor3'
		});

		local actionIcon;
		local isHovering = false
		local isPressing = false
		
		local function updateVisuals()
			if (isHovering or isPressing) and not Compkiller:_IsDropdownHoverBlocked(Frame) then
				Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
					BackgroundColor3 = Compkiller:_PolishColor("Hover", Config.Color)
				})
				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Color = Compkiller.Colors.Highlight
				})
			else
				Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
					BackgroundColor3 = Config.Color or Compkiller.Colors.BGDBColor
				})
				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Color = Compkiller.Colors.StrokeColor
				})
			end
		end

		Compkiller:_BindPolishUpdate(Frame, updateVisuals);

		Compkiller:_Hover(Frame, function()
			isHovering = true
			updateVisuals()
		end, function()
			isHovering = false
			isPressing = false
			updateVisuals()
		end, true)

		if Config.PopoutInput then
			local popout = Instance.new("Frame")
			popout.Name = Compkiller:_RandomString()
			popout.Parent = Frame
			popout.AnchorPoint = Vector2.new(0.5, 0)
			popout.Position = UDim2.new(0.5, 0, 1, 5)
			popout.Size = UDim2.new(0, 140, 0, 24)
			Compkiller:_BindPolishColor(popout, "BackgroundColor3", "DropColor");
			popout.Visible = false
			popout.ZIndex = Zindex + 10
			
			local popoutCorner = Instance.new("UICorner")
			popoutCorner.CornerRadius = UDim.new(0, 4)
			popoutCorner.Parent = popout
			
			local popoutStroke = Instance.new("UIStroke")
			Compkiller:_BindPolishColor(popoutStroke, "Color", "StrokeColor");
			popoutStroke.Parent = popout
			
			local arrow = Instance.new("Frame")
			arrow.Name = Compkiller:_RandomString()
			arrow.Parent = popout
			arrow.AnchorPoint = Vector2.new(0.5, 0)
			arrow.Position = UDim2.new(0.5, 0, 0, -4)
			arrow.Size = UDim2.new(0, 8, 0, 8)
			Compkiller:_BindPolishColor(arrow, "BackgroundColor3", "DropColor");
			arrow.Rotation = 45
			arrow.ZIndex = Zindex + 9
			
			local inputTb = Instance.new("TextBox")
			inputTb.Name = Compkiller:_RandomString()
			inputTb.Parent = popout
			inputTb.Size = UDim2.new(1, -10, 1, 0)
			inputTb.Position = UDim2.new(0, 5, 0, 0)
			inputTb.BackgroundTransparency = 1
			inputTb.PlaceholderText = "File name + Enter"
			Compkiller:_BindPolishColor(inputTb, "PlaceholderColor3", "Placeholder");
			Compkiller:_BindPolishColor(inputTb, "TextColor3", "SwitchColor");
			inputTb.Text = ""
			inputTb.Font = Enum.Font.GothamMedium
			inputTb.TextSize = 13
			inputTb.ZIndex = Zindex + 11

			local btn = Compkiller:_Input(Frame,function()
				if IsBusy() then return; end;
				popout.Visible = not popout.Visible
				if popout.Visible then
					inputTb:CaptureFocus()
				end
			end)
			
			btn.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isPressing = true
					updateVisuals()
				end
			end)
			
			btn.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isPressing = false
					updateVisuals()
				end
			end)

			inputTb.FocusLost:Connect(function(enterPressed)
				local text = inputTb.Text
				popout.Visible = false
				if text ~= "" then
					inputTb.Text = ""
					RunCallback(text)
				end
			end)
		else
			local btn = Compkiller:_Input(Frame,function()
				RunCallback();
			end);
			
			btn.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isPressing = true
					updateVisuals()
				end
			end)
			
			btn.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isPressing = false
					updateVisuals()
				end
			end)
		end

		local Args = {};

		function Args:IsBusy()
			return IsBusy();
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockLine, TweenInfo.new(0.35),{
					BackgroundTransparency = 0.500
				});

				Compkiller:_Animation(Frame, TweenInfo.new(0.35),{
					BackgroundTransparency = 0
				});

				Compkiller:_Animation(UIStroke, TweenInfo.new(0.35),{
					Transparency = 0
				});

				Compkiller:_Animation(TextLabel, TweenInfo.new(0.35),{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0
				});

			else
				Compkiller:_Animation(BlockLine, TweenInfo.new(0.35),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(Frame, TweenInfo.new(0.35),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(UIStroke, TweenInfo.new(0.35),{
					Transparency = 1
				});

				Compkiller:_Animation(TextLabel, TweenInfo.new(0.35),{
					TextStrokeTransparency = 1,
					TextTransparency = 1
				});
			end;
		end);

		function Args:SetText(t)
			Config.Name = t;
            if actionIcon then Compkiller:_SetIcon(actionIcon, (Compkiller.ActionIcons or {})[t] or Config.Icon); end;
			if _targetLoc then
				local key = tostring(_targetLoc) .. "|" .. t
				if _translationCache[key] then
					TextLabel.Text = _translationCache[key]
				else
					TextLabel.Text = t
					task.spawn(function()
						local result = GetTranslationSync(t, _targetLoc)
						if result ~= t then
							TextLabel.Text = result
						end
					end)
				end
			else
				TextLabel.Text = t
			end
		end;

        if Config.Icon then actionIcon = Compkiller:_ControlIcon(TextLabel, Config.Icon, true); end;
        Compkiller:_BindControlLabel(Button, TextLabel, nil, {Padding = 32, ParentInset = 24, Icon = Config.Icon})
		return Args;
	end;

	function Args:AddPreviewMover(Config)
		Config = Compkiller.__CONFIG(Config , {
			Name = "Preview Offset",
			Callback = function() end
		});

		local Container = Instance.new("Frame")
		Container.Name = Compkiller:_RandomString()
		Container.Parent = Parent
		Container.BackgroundTransparency = 1.000
		Container.Size = UDim2.new(1, -1, 0, 120)
		Container.ZIndex = Zindex + 5
		
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Parent = Container
		TextLabel.AnchorPoint = Vector2.new(0.5, 0)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0.5, 0, 0, 5)
		TextLabel.Size = UDim2.new(1, 0, 0, 20)
		TextLabel.ZIndex = Zindex + 8
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = Config.Name
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 14
		TextLabel.TextStrokeTransparency = 0.900
        if Config.Icons then
            Compkiller:_ControlIcon(TextLabel,"move");
            TextLabel.Size = UDim2.new(1,-44,0,20);
        end;

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextLabel,
			Property = 'TextColor3'
		});
		
		local BlockLine = Instance.new("Frame")
		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = Container
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 6

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		local Frame = Instance.new("Frame")
		Frame.Parent = Container
		Frame.AnchorPoint = Vector2.new(0.5, 1)
		Frame.BackgroundTransparency = 1.000
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 1, -5)
		Frame.Size = UDim2.new(1, -15, 0, 90)
		Frame.ZIndex = Zindex + 7
		
		local currentMoveStep = 2
		local currentRotStep = 90
		
		local function makeBtn(txt, pos, size, callback)
		    local b = Instance.new("TextButton", Frame)
		    b.Size = size
		    b.Position = pos
		    b.Text = txt
		    Compkiller:_BindPolishColor(b, "BackgroundColor3", "DropColor");
		    Compkiller:_BindPolishColor(b, "TextColor3", "SwitchColor");
		    b.Font = Enum.Font.GothamMedium
		    b.TextSize = 14
		    b.ZIndex = Zindex + 9
		    b.AutoButtonColor = false

		    local uic = Instance.new("UICorner", b)
		    uic.CornerRadius = UDim.new(0, 4)
		    
		    local stroke = Instance.new("UIStroke", b)
		    Compkiller:_BindPolishColor(stroke, "Color", "StrokeColor");

		    Compkiller:_BindClickRipple(b);
		    b.MouseButton1Click:Connect(callback)
            
            if Config.Icons then
                local names = {U="arrow-up", D="arrow-down", L="arrow-left", R="arrow-right",
                    F="arrow-up-right", B="arrow-down-left", RL="rotate-ccw", RR="rotate-cw", Reset="rotate-ccw"};
                Compkiller:_TextButtonIcon(b, names[txt], txt ~= "Reset");
            end;
            local Hovered = false;
            local function UpdateButton()
                Compkiller:_Animation(b, TweenInfo.new(0.15), {
                    BackgroundColor3 = Hovered and Compkiller:_PolishColor("Hover") or Compkiller.Colors.DropColor
                });
            end;
            Compkiller:_BindPolishUpdate(b, UpdateButton);
            Compkiller:_Hover(b, function()
                Hovered = true;
                UpdateButton();
            end, function()
                Hovered = false;
                UpdateButton();
            end);

		    return b
		end

        -- WASD + F/B Movement Grid (Left side)
        makeBtn("U", UDim2.new(0, 26, 0, 4), UDim2.new(0, 22, 0, 22), function() Config.Callback("Up", currentMoveStep, currentRotStep) end)
        makeBtn("F", UDim2.new(0, 78, 0, 4), UDim2.new(0, 22, 0, 22), function() Config.Callback("Forward", currentMoveStep, currentRotStep) end)
        
        makeBtn("L", UDim2.new(0, 0, 0, 30), UDim2.new(0, 22, 0, 22), function() Config.Callback("Left", currentMoveStep, currentRotStep) end)
        makeBtn("D", UDim2.new(0, 26, 0, 30), UDim2.new(0, 22, 0, 22), function() Config.Callback("Down", currentMoveStep, currentRotStep) end)
        makeBtn("R", UDim2.new(0, 52, 0, 30), UDim2.new(0, 22, 0, 22), function() Config.Callback("Right", currentMoveStep, currentRotStep) end)
        makeBtn("B", UDim2.new(0, 78, 0, 30), UDim2.new(0, 22, 0, 22), function() Config.Callback("Backward", currentMoveStep, currentRotStep) end)

        -- Rotations (Bottom Left)
        makeBtn("RL", UDim2.new(0, 0, 0, 56), UDim2.new(0, 48, 0, 22), function() Config.Callback("RotLeft", currentMoveStep, currentRotStep) end)
        makeBtn("RR", UDim2.new(0, 52, 0, 56), UDim2.new(0, 48, 0, 22), function() Config.Callback("RotRight", currentMoveStep, currentRotStep) end)

        local function makeInput(lbl, default, pos, callback)
            local t = Instance.new("TextLabel", Frame)
            t.Size = UDim2.new(0, 30, 0, 22)
            t.Position = pos
            t.Text = lbl
            t.BackgroundTransparency = 1
            t.TextColor3 = Compkiller.Colors.Highlight or Color3.fromRGB(0, 255, 255)
            t.Font = Enum.Font.GothamMedium
            t.TextSize = 13
            t.TextXAlignment = Enum.TextXAlignment.Left
            t.ZIndex = Zindex + 9
            
            table.insert(Compkiller.Elements.Highlight, {
                Element = t,
                Property = "TextColor3"
            })
            
            local box = Instance.new("TextBox", Frame)
            box.Size = UDim2.new(0, 50, 0, 22)
            box.Position = UDim2.new(pos.X.Scale, pos.X.Offset + 40, pos.Y.Scale, pos.Y.Offset)
            box.Text = tostring(default)
            Compkiller:_BindPolishColor(box, "BackgroundColor3", "DropColor");
            Compkiller:_BindPolishColor(box, "TextColor3", "SwitchColor");
            box.Font = Enum.Font.GothamMedium
            box.TextSize = 13
            box.ZIndex = Zindex + 9
            Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
            local BoxStroke = Instance.new("UIStroke", box);
            Compkiller:_BindPolishColor(BoxStroke, "Color", "StrokeColor");
            
            box.FocusLost:Connect(function()
                local num = tonumber(box.Text)
                if num then
                    callback(num)
                else
                    box.Text = tostring(default)
                end
            end)
        end
        
        -- Inputs and Reset (Right Column)
        makeInput("Move:", 2, UDim2.new(1, -80, 0, 4), function(v) currentMoveStep = v end)
        makeInput("Rotate:", 90, UDim2.new(1, -80, 0, 30), function(v) currentRotStep = v end)
        makeBtn("Reset", UDim2.new(1, -80, 0, 56), UDim2.new(0, 80, 0, 22), function() Config.Callback("Reset", currentMoveStep, currentRotStep) end)

		local Args = {}
		Args.Root = Container
		return Args
	end;

	function Args:AddSlider(Config: Slider)
		Config = Compkiller.__CONFIG(Config , {
			Name = 'Slider',
			Default = 50,
			Min = 0,
			Max = 100,
			Type = "",
			Round = 0,
			Callback = function() end
		});

		local Slider = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")
		local SliderBar = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local SliderInput = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local Frame = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local ValueText = Instance.new("TextBox")

		Compkiller:_AddDragBlacklist(Slider);

		Slider.Name = Compkiller:_RandomString()
		Slider.Parent = Parent
		Slider.BackgroundTransparency = 1.000
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.Size = UDim2.new(1, -1, 0, 49)
		Slider.ZIndex = Zindex + 1

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = Slider
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0, 1)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 2
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Name
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 16
		BlockText.TextTransparency = 0.100
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = Slider
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 2
		BlockLine.Visible = EnabledLine or false;

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		SliderBar.Name = Compkiller:_RandomString()
		SliderBar.Parent = Slider
		SliderBar.AnchorPoint = Vector2.new(0.5, 1)
		SliderBar.BackgroundColor3 = Compkiller.Colors.DropColor
		SliderBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SliderBar.BorderSizePixel = 0
		SliderBar.ClipsDescendants = false
		SliderBar.Position = UDim2.new(0.5, 0, 1, -9)
		SliderBar.Size = UDim2.new(1, -24, 0, 10)
		SliderBar.ZIndex = Zindex + 3

		table.insert(Compkiller.Elements.DropColor , {
			Element = SliderBar,
			Property = "BackgroundColor3"
		})

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = SliderBar

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = SliderBar

		SliderInput.Name = Compkiller:_RandomString()
		SliderInput.Parent = SliderBar
		SliderInput.AnchorPoint = Vector2.new(0, 0.5)
		SliderInput.BackgroundColor3 = Compkiller.Colors.Highlight
		SliderInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SliderInput.BorderSizePixel = 0
		SliderInput.Position = UDim2.new(0, 0, 0.5, 0)

		local function GetScale(val)
			local denom = Config.Max - Config.Min
			if denom <= 0 then
				return 1
			end
			return math.clamp((val - Config.Min) / denom, 0, 1)
		end

		SliderInput.Size = UDim2.new(GetScale(Config.Default), 0, 1, 0)
		SliderInput.ZIndex = Zindex + 4

		table.insert(Compkiller.Elements.Highlight,{
			Element = SliderInput,
			Property = "BackgroundColor3"
		});

		UICorner_2.CornerRadius = UDim.new(0, 6)
		UICorner_2.Parent = SliderInput

		Frame.Parent = SliderBar
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.BackgroundColor3 = Compkiller.Colors.SwitchColor
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0, 6, 0.5, 0)
		Frame.Size = UDim2.fromOffset(12, 12)
		Frame.ZIndex = Zindex + 6

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = Frame,
			Property = 'BackgroundColor3'
		});

		UICorner_3.CornerRadius = UDim.new(3, 0)
		UICorner_3.Parent = Frame

        -- The thumb stays fully inside both endpoints, independently of fill.
        local function syncKnob()
            local fraction = SliderInput.Size.X.Scale
            Frame.Position = UDim2.new(fraction,6-12*fraction,0.5,0)
        end
        SliderInput:GetPropertyChangedSignal("Size"):Connect(syncKnob)
        syncKnob()

		ValueText.Name = Compkiller:_RandomString()
		ValueText.Parent = Slider
		ValueText.BackgroundColor3 = Compkiller.Colors.DropColor
		ValueText.BackgroundTransparency = 0
		ValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueText.BorderSizePixel = 0
		ValueText.AnchorPoint = Vector2.new(1, 0.5)
		ValueText.Position = UDim2.new(1, -12, 0, 13.5)
		ValueText.Size = UDim2.new(0, 44, 0, 22)
		
		ValueText:GetPropertyChangedSignal("Text"):Connect(function()
			local raw = ValueText.Text
			local clean = raw:gsub("[^%d%.%-]", "")
			if raw ~= clean then
				ValueText.Text = clean
				return
			end
			local n = tonumber(clean)
			if n then
				if n > Config.Max then
					n = Config.Max
					ValueText.Text = tostring(Config.Max)
					return
				end
				if Config.Max <= Config.Min and n < Config.Min then
					n = Config.Min
					ValueText.Text = tostring(Config.Min)
					return
				end
				local visualN = math.clamp(n, Config.Min, Config.Max)
				visualN = Compkiller:_Rounding(visualN, Config.Round)
				Config.Default = visualN
				Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
					Size = UDim2.new(GetScale(visualN), 0, 1, 0)
				})
				Config.Callback(visualN)
			end
		end)
		
		local ValueTextCorner = Instance.new("UICorner")
		ValueTextCorner.CornerRadius = UDim.new(0, 4)
		ValueTextCorner.Parent = ValueText
		ValueText.ZIndex = Zindex + 4
		ValueText.Font = Enum.Font.GothamMedium
		ValueText.Text = tostring(Config.Default)..tostring(Config.Type)
		ValueText.TextColor3 = Compkiller.Colors.SwitchColor
		ValueText.TextSize = 14
		ValueText.TextTransparency = 0
		ValueText.TextXAlignment = Enum.TextXAlignment.Center

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = ValueText,
			Property = 'TextColor3'
		});
		table.insert(Compkiller.Elements.DropColor , {
			Element = ValueText,
			Property = 'BackgroundColor3'
		});

        local function sizeValueField()
            local width = Slider.AbsoluteSize.X / Compkiller:_GetUIScale(Slider)
            if width <= 0 then return end
            local size = Compkiller:_ControlFieldSize(ValueText,44,width*0.5)
            if ValueText.Size ~= size then ValueText.Size = size end
        end
        ValueText:GetPropertyChangedSignal("Text"):Connect(sizeValueField)
        Slider:GetPropertyChangedSignal("AbsoluteSize"):Connect(sizeValueField)
        sizeValueField()

		Compkiller:_Hover(SliderBar,function()
			if Signal:GetValue() then
				Compkiller:_Animation(ValueText,TweenInfo.new(0.2),{
					TextTransparency = 0
				})
			end;
		end,function()
			if Signal:GetValue() then
				Compkiller:_Animation(ValueText,TweenInfo.new(0.2),{
					TextTransparency = 0
				})
			end;
		end)	

		local IsHold = false;

		local Update = function(Input)
            local inset = 6 * Compkiller:_GetUIScale(SliderBar)
            local SizeScale = math.clamp((Input.Position.X-SliderBar.AbsolutePosition.X-inset)
                / math.max(1,SliderBar.AbsoluteSize.X-2*inset),0,1);

			local Main = (Config.Max <= Config.Min and Config.Min) or (((Config.Max - Config.Min) * SizeScale) + Config.Min);

			local Value = Compkiller:_Rounding(Main,Config.Round);

			local PositionX = UDim2.fromScale(SizeScale, 1);

			local Size = GetScale(Value);

			TweenService:Create(SliderInput , TweenInfo.new(0.2),{
				Size = UDim2.new(Size, 0, 1, 0)
			}):Play();

			Config.Default = Value;

			ValueText.Text = tostring(Config.Default)..tostring(Config.Type)

			Config.Callback(Value)
		end;
		
		ValueText.ClearTextOnFocus = true
		ValueText.FocusLost:Connect(function()
			local cleanText = ValueText.Text:gsub("[^%d%.%-]", "")
			local n = tonumber(cleanText)
			if n then
				n = math.clamp(n, Config.Min, Config.Max)
				n = Compkiller:_Rounding(n, Config.Round)
				Args:SetValue(n)
			else
				Args:SetValue(Config.Default or Config.Min or 1)
			end
		end)

		do
			SliderBar.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					IsHold = true
					Update(Input)
				end
			end)

			SliderBar.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if UserInputService.TouchEnabled then
						if not Compkiller:_IsMouseOverFrame(SliderBar) then
							IsHold = false
						end;
					else
						IsHold = false
					end;
				end
			end)

			Compkiller:_RegisterInputChangedListener(function(Input)
				if not IsHold then
					return;
				end;

				if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
					if UserInputService.TouchEnabled then
						if not Compkiller:_IsMouseOverFrame(SliderBar) then
							IsHold = false
						else
							Update(Input)
						end;
					else
						Update(Input)
					end;
				end;
			end, SliderBar);
		end;

		local Args = {};

		Args.Flag = Config.Flag;
		Args.Config = Config;
		Args.Slider = Slider;
		Args.SliderBar = SliderBar;
		Args.SliderInput = SliderInput;
		Args.SliderKnob = Frame;
		Args.ValueText = ValueText;

		function Args:SetMax(newMax)
			Config.Max = math.max(newMax, Config.Min or 1);
			if Config.Default > Config.Max then
				Args:SetValue(Config.Max);
			else
				Args:SetValue(Config.Default);
			end;
		end;

		function Args:SetMinMax(newMin, newMax)
			Config.Min = newMin;
			Config.Max = math.max(newMax, newMin);
			if Config.Default > Config.Max then
				Args:SetValue(Config.Max);
			elseif Config.Default < Config.Min then
				Args:SetValue(Config.Min);
			else
				Args:SetValue(Config.Default);
			end;
		end;

		function Args:SetValue(Value)
			Value = math.clamp(Compkiller:_Rounding(Value, Config.Round), Config.Min, Config.Max)
			Config.Default = Value;

			ValueText.Text = tostring(Config.Default)..tostring(Config.Type)

			Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
				Size = UDim2.new(GetScale(Config.Default), 0, 1, 0)
			});

			Config.Callback(Value);
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
					Size = UDim2.new(GetScale(Config.Default), 0, 1, 0)
				});

				Compkiller:_Animation(ValueText,Tween,{
					TextTransparency = 0
				})

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(SliderInput,Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 0
				})

				Compkiller:_Animation(SliderBar,Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 0.5
				})

				Compkiller:_Animation(BlockText,Tween,{
					TextTransparency = 0.1
				})
			else
				Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
					Size = UDim2.new(0, 0, 1, 0)
				});

				Compkiller:_Animation(ValueText,Tween,{
					TextTransparency = 1
				})

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(SliderInput,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 1
				})

				Compkiller:_Animation(SliderBar,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(BlockText,Tween,{
					TextTransparency = 1
				})
			end;
		end);

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

        if Config.Icon then Compkiller:_ControlIcon(BlockText, Config.Icon); end;
        Compkiller:_BindControlLabel(Slider, BlockText, function(scale) return ValueText.AbsoluteSize.X / scale end,
            {Icon = Config.Icon, Triggers = {{ValueText, "AbsoluteSize"}}})
		return Args;
	end;

	function Args:AddParagraph(Config: Paragraph) -- request by Neptune
		Config = Compkiller.__CONFIG(Config, {
        Title = "Paragraph",
        Content = "",
        Image = nil,
        Model = nil -- Added Model support
    });

    local Paragraph = Instance.new("Frame")
    local BlockText = Instance.new("TextLabel")
    local BlockLine = Instance.new("Frame")
    local DescriptionText = Instance.new("TextLabel")
    -- We define these outside the IF so the functions can see them
    local BlockImage = Instance.new("ImageLabel")
    local BlockViewport = Instance.new("ViewportFrame") 

    if Compkiller:_IsMobile() then
        Compkiller:_AddDragBlacklist(Paragraph);
    end;

    Paragraph.Name = Compkiller:_RandomString()
    Paragraph.Parent = Parent
    Paragraph.BackgroundTransparency = 1.000
    Paragraph.BorderSizePixel = 0
    Paragraph.Size = UDim2.new(1, -1, 0, 40)
    Paragraph.ZIndex = Zindex + 2
    Paragraph.ClipsDescendants = true

    BlockText.Name = Compkiller:_RandomString()
    BlockText.Parent = Paragraph
    BlockText.AnchorPoint = Vector2.new(0, 0.5)
    BlockText.BackgroundTransparency = 1.000
    BlockText.Position = UDim2.new(0, 12, 0, 12)
    BlockText.Size = UDim2.new(1, -50, 0, 25) -- Shrink width to make room for VPF
    BlockText.ZIndex = Zindex + 3
    BlockText.Font = Enum.Font.GothamMedium
    BlockText.Text = Config.Title
    BlockText.TextColor3 = Compkiller.Colors.SwitchColor
    BlockText.TextSize = 17
    BlockText.TextXAlignment = Enum.TextXAlignment.Left
    BlockText.RichText = true

    -- Handle Image OR Viewport
if Config.Model then
    BlockViewport.Name = Compkiller:_RandomString()
    BlockViewport.Parent = Paragraph
    BlockViewport.AnchorPoint = Vector2.new(1, 0.5)
    BlockViewport.BackgroundTransparency = 1.000
    BlockViewport.Position = UDim2.new(1, -12, 0, 20)
    BlockViewport.Size = UDim2.new(0, 30, 0, 30) -- Keep it small
    BlockViewport.ZIndex = Zindex + 5
    
    -- Crucial: This makes the camera/model work
    local WorldModel = Instance.new("WorldModel", BlockViewport)
    local Camera = Instance.new("Camera", BlockViewport)
    BlockViewport.CurrentCamera = Camera
    
    local Clone = Config.Model:Clone()
    Clone:PivotTo(CFrame.new(0,0,0))
    Clone.Parent = WorldModel
    
    Camera.CFrame = CFrame.lookAt(Vector3.new(5,5,5), Vector3.new(0,0,0))
    
    -- IMPORTANT: Increase the paragraph padding so it doesn't get cut off
    Paragraph.Size = UDim2.new(1, -1, 0, 50) 
end

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = Paragraph
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 4

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		-- Block Image (optional)
		if Config.Image then
			BlockImage.Name = Compkiller:_RandomString()
			BlockImage.Parent = Paragraph
			BlockImage.AnchorPoint = Vector2.new(1, 0.5)
			BlockImage.BackgroundTransparency = 1.000
			BlockImage.BorderSizePixel = 0
			BlockImage.Position = UDim2.new(1, -12, 0, 12)
			BlockImage.Size = UDim2.new(0, 24, 0, 24)
			BlockImage.ZIndex = Zindex + 5
			BlockImage.ScaleType = Enum.ScaleType.Fit
			BlockImage.Image = Config.Image
		end

		DescriptionText.RichText = true
		DescriptionText.Name = Compkiller:_RandomString()
		DescriptionText.Parent = Paragraph
		DescriptionText.BackgroundTransparency = 1.000
		DescriptionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DescriptionText.BorderSizePixel = 0
		DescriptionText.Position = UDim2.new(0, 12, 0, 22)
		DescriptionText.Size = UDim2.new(1, -20, 0, 20)
		DescriptionText.ZIndex = Zindex + 5
		DescriptionText.Font = Enum.Font.GothamMedium
		DescriptionText.Text = Config.Content
		Compkiller:_BindPolishColor(DescriptionText, "TextColor3", "MutedText");
		DescriptionText.TextSize = 16
		DescriptionText.TextTransparency = 0.000 -- Full opacity to pop out
		DescriptionText.TextWrapped = true -- Allows text to wrap
		DescriptionText.TextXAlignment = Enum.TextXAlignment.Left
		DescriptionText.TextYAlignment = Enum.TextYAlignment.Top

		if Config.Title == "" then
			BlockText.Visible = false
			BlockLine.Visible = false
			DescriptionText.Position = UDim2.new(0, 12, 0, 0)
			DescriptionText.Size = UDim2.new(1, -20, 1, 0)
			DescriptionText.TextYAlignment = Enum.TextYAlignment.Center
		end

		-- Reading text follows the active theme while retaining its softer tone.

        local HasViewport = Config.Model ~= nil
        local scaleQueued = false
        local UpdateScale = function()
            local titleVisible = BlockText.Text ~= ""
            BlockText.Visible = titleVisible
            BlockLine.Visible = titleVisible
            BlockText.TextWrapped = true
            local scale, ancestor = 1, Paragraph
            while ancestor do
                local fit = ancestor.FindFirstChildOfClass and ancestor:FindFirstChildOfClass("UIScale")
                if fit then scale *= fit.Scale end
                ancestor = ancestor.Parent
            end
            local width = math.max(Paragraph.AbsoluteSize.X / math.max(scale, 0.001), 1)
            if width <= 1 then return end
            local titleHeight = titleVisible and math.ceil(TextService:GetTextSize(
                BlockText.Text:gsub("<[^>]*>", ""), BlockText.TextSize, BlockText.Font,
                Vector2.new(math.max(width - 50, 1), math.huge)).Y) or 0
            local contentHeight = DescriptionText.Text ~= "" and math.ceil(TextService:GetTextSize(
                DescriptionText.Text:gsub("<[^>]*>", ""), DescriptionText.TextSize, DescriptionText.Font,
                Vector2.new(math.max(width - 24, 1), math.huge)).Y) or 0
            BlockText.AnchorPoint = Vector2.new(0, 0)
            BlockText.Position = UDim2.fromOffset(12, 6)
            BlockText.Size = UDim2.new(1, -50, 0, titleHeight)
            local top = titleVisible and (6 + titleHeight + 4) or 6
            DescriptionText.Position = UDim2.fromOffset(12, top)
            DescriptionText.Size = UDim2.new(1, -24, 0, contentHeight)
            DescriptionText.TextYAlignment = Enum.TextYAlignment.Top
            local height = math.max(top + contentHeight + 8, HasViewport and 50 or 24)
            -- Discard cached section fill height before its content layout updates.
            Parent:SetAttribute('Height', nil)
            Paragraph.Size = UDim2.new(1, -1, 0, height)
        end
        local RequestScale = function()
            if scaleQueued then return end
            scaleQueued = true
            task.defer(function()
                scaleQueued = false
                if Paragraph.Parent then UpdateScale() end
            end)
        end
        Paragraph:GetPropertyChangedSignal('AbsoluteSize'):Connect(RequestScale)
        for _, label in ipairs({BlockText, DescriptionText}) do
            for _, property in ipairs({'Text', 'TextSize', 'Font', 'TextBounds'}) do
                label:GetPropertyChangedSignal(property):Connect(RequestScale)
            end
        end
        RequestScale()

		local Args = {};

function Args:SetTitle(title)
	if _targetLoc then
		local key = tostring(_targetLoc) .. "|" .. title
		if _translationCache[key] then
			BlockText.Text = _translationCache[key]
			UpdateScale()
		else
			BlockText.Text = title
			UpdateScale()
			task.spawn(function()
				local result = GetTranslationSync(title, _targetLoc)
				if result ~= title then
					BlockText.Text = result
					UpdateScale()
				end
			end)
		end
	else
		BlockText.Text = title;
		UpdateScale();
	end
end;

function Args:SetContent(content)
	if _targetLoc then
		local key = tostring(_targetLoc) .. "|" .. content
		if _translationCache[key] then
			DescriptionText.Text = _translationCache[key]
			UpdateScale()
		else
			DescriptionText.Text = content
			UpdateScale()
			task.spawn(function()
				local result = GetTranslationSync(content, _targetLoc)
				if result ~= content then
					DescriptionText.Text = result
					UpdateScale()
				end
			end)
		end
	else
		DescriptionText.Text = content;
		UpdateScale();
	end
end;

function Args:SetImage(image)
	if image then
		if not BlockImage.Parent then
			BlockImage.Parent = Paragraph
		end
		BlockImage.Image = image
	else
		BlockImage.Parent = nil
	end
end;

-- NEW: SetVisible method to independently control paragraph visibility
function Args:SetVisible(visible)
	if visible then
		Compkiller:_Animation(BlockText, TweenInfo.new(0.2), {
			TextTransparency = 0.000
		});
		Compkiller:_Animation(DescriptionText, TweenInfo.new(0.2), {
			TextTransparency = 0.050
		});
		Compkiller:_Animation(BlockLine, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.500
		});
		if BlockViewport then
			BlockViewport.BackgroundTransparency = 0
			BlockViewport.Visible = true
		end
		if BlockImage then
			BlockImage.ImageTransparency = 0
		end
	else
		Compkiller:_Animation(BlockText, TweenInfo.new(0.2), {
			TextTransparency = 1
		});
		Compkiller:_Animation(DescriptionText, TweenInfo.new(0.2), {
			TextTransparency = 1
		});
		Compkiller:_Animation(BlockLine, TweenInfo.new(0.2), {
			BackgroundTransparency = 1
		});
		if BlockViewport then
			BlockViewport.BackgroundTransparency = 1
			BlockViewport.Visible = false
		end
		if BlockImage then
			BlockImage.ImageTransparency = 1
		end
	end
end;

Args.Signal = Signal:Connect(function(bool)
	if bool then
		Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
			TextTransparency = 0.000
		});

		Compkiller:_Animation(DescriptionText,TweenInfo.new(0.2),{
			TextTransparency = 0.050
		});

		Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
			BackgroundTransparency = 0.500
		});
	else
		Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
			TextTransparency = 1
		});

		Compkiller:_Animation(DescriptionText,TweenInfo.new(0.2),{
			TextTransparency = 1
		});

		Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
			BackgroundTransparency = 1
		});
	end;
end);

Args.Root = Paragraph  -- Expose the root frame
Args.TitleLabel = BlockText  -- Expose the title label
Args.ContentLabel = DescriptionText  -- Expose the content label

return Args;
	end;

	function Args:AddActionParagraph(Config)
		Config = Compkiller.__CONFIG(Config, {
        Title = "Paragraph",
        Content = "",
        Image = nil,
        Model = nil,
        Button1Text = "Buy",
        Button1Callback = function() end,
        Button2Text = "Replace",
        DropdownValues = {"Option 1", "Option 2"},
        DropdownCallback = function(value) end
    });

    local Paragraph = Instance.new("Frame")
    local BlockText = Instance.new("TextLabel")
    local BlockLine = Instance.new("Frame")
    local DescriptionText = Instance.new("TextLabel")
    local BlockImage = Instance.new("ImageLabel")
    local BlockViewport = Instance.new("ViewportFrame") 

    local ButtonContainer = Instance.new("Frame")
    local UIListLayout_Btns = Instance.new("UIListLayout")

    local Btn1 = Instance.new("Frame")
    local Btn1Corner = Instance.new("UICorner")
    local Btn1Stroke = Instance.new("UIStroke")
    local Btn1Text = Instance.new("TextLabel")

    local Btn2 = Instance.new("Frame")
    local Btn2Corner = Instance.new("UICorner")
    local Btn2Stroke = Instance.new("UIStroke")
    local Btn2Text = Instance.new("TextLabel")

    if Compkiller:_IsMobile() then
        Compkiller:_AddDragBlacklist(Paragraph);
    end;

    Paragraph.Name = Compkiller:_RandomString()
    Paragraph.Parent = Parent
    Paragraph.BackgroundTransparency = 1.000
    Paragraph.BorderSizePixel = 0
    Paragraph.Size = UDim2.new(1, -1, 0, 40)
    Paragraph.ZIndex = Zindex + 2
    Paragraph.ClipsDescendants = true

    BlockText.Name = Compkiller:_RandomString()
    BlockText.Parent = Paragraph
    BlockText.AnchorPoint = Vector2.new(0, 0.5)
    BlockText.BackgroundTransparency = 1.000
    BlockText.Position = UDim2.new(0, 12, 0, 12)
    BlockText.Size = UDim2.new(1, -150, 0, 25) 
    BlockText.ZIndex = Zindex + 3
    BlockText.Font = Enum.Font.GothamMedium
    BlockText.Text = Config.Title
    BlockText.TextColor3 = Compkiller.Colors.SwitchColor
    BlockText.TextSize = 16
    BlockText.TextXAlignment = Enum.TextXAlignment.Left
    BlockText.RichText = true

    table.insert(Compkiller.Elements.SwitchColor , {
        Element = BlockText,
        Property = 'TextColor3'
    });

    BlockLine.Name = Compkiller:_RandomString()
    BlockLine.Parent = Paragraph
    BlockLine.AnchorPoint = Vector2.new(0.5, 1)
    BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
    BlockLine.BackgroundTransparency = 0.500
    BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BlockLine.BorderSizePixel = 0
    BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
    BlockLine.Size = UDim2.new(1, -26, 0, 1)
    BlockLine.ZIndex = Zindex + 4

    table.insert(Compkiller.Elements.LineColor,{
        Element = BlockLine,
        Property = "BackgroundColor3"
    });

    if Config.Image then
        BlockImage.Name = Compkiller:_RandomString()
        BlockImage.Parent = Paragraph
        BlockImage.AnchorPoint = Vector2.new(1, 0.5)
        BlockImage.BackgroundTransparency = 1.000
        BlockImage.BorderSizePixel = 0
        BlockImage.Position = UDim2.new(1, -140, 0, 12)
        BlockImage.Size = UDim2.new(0, 24, 0, 24)
        BlockImage.ZIndex = Zindex + 5
        BlockImage.ScaleType = Enum.ScaleType.Fit
        BlockImage.Image = Config.Image
    end

    if Config.Model then
        BlockViewport.Name = Compkiller:_RandomString()
        BlockViewport.Parent = Paragraph
        BlockViewport.AnchorPoint = Vector2.new(1, 0.5)
        BlockViewport.BackgroundTransparency = 1.000
        BlockViewport.Position = UDim2.new(1, -140, 0, 20)
        BlockViewport.Size = UDim2.new(0, 30, 0, 30) 
        BlockViewport.ZIndex = Zindex + 5
        
        local WorldModel = Instance.new("WorldModel", BlockViewport)
        local Camera = Instance.new("Camera", BlockViewport)
        BlockViewport.CurrentCamera = Camera
        
        local Clone = Config.Model:Clone()
        Clone:PivotTo(CFrame.new(0,0,0))
        Clone.Parent = WorldModel
        
        Camera.CFrame = CFrame.lookAt(Vector3.new(5,5,5), Vector3.new(0,0,0))
        
        Paragraph.Size = UDim2.new(1, -1, 0, 50) 
    end

    DescriptionText.RichText = true
    DescriptionText.Name = Compkiller:_RandomString()
    DescriptionText.Parent = Paragraph
    DescriptionText.BackgroundTransparency = 1.000
    DescriptionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    DescriptionText.BorderSizePixel = 0
    DescriptionText.Position = UDim2.new(0, 12, 0, 22)
    DescriptionText.Size = UDim2.new(1, -150, 0, 20)
    DescriptionText.ZIndex = Zindex + 5
    DescriptionText.Font = Enum.Font.GothamMedium
    DescriptionText.Text = Config.Content
    DescriptionText.TextColor3 = Compkiller.Colors.SwitchColor
    DescriptionText.TextSize = 15
    DescriptionText.TextTransparency = 0.250
    DescriptionText.TextXAlignment = Enum.TextXAlignment.Left
    DescriptionText.TextYAlignment = Enum.TextYAlignment.Top

    table.insert(Compkiller.Elements.SwitchColor , {
        Element = DescriptionText,
        Property = 'TextColor3'
    });

    ButtonContainer.Name = Compkiller:_RandomString()
    ButtonContainer.Parent = Paragraph
    ButtonContainer.AnchorPoint = Vector2.new(1, 1)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Position = UDim2.new(1, -15, 1, -5)
    ButtonContainer.Size = UDim2.new(0, 120, 0, 24)
    ButtonContainer.ZIndex = Zindex + 5

    UIListLayout_Btns.Parent = ButtonContainer
    UIListLayout_Btns.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_Btns.HorizontalAlignment = Enum.HorizontalAlignment.Right
    UIListLayout_Btns.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout_Btns.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_Btns.Padding = UDim.new(0, 5)

    Btn2.Name = Compkiller:_RandomString()
    Btn2.Parent = ButtonContainer
    Btn2.BackgroundColor3 = Compkiller.Colors.DropColor
    Btn2.BorderSizePixel = 0
    Btn2.Size = UDim2.new(0, 48, 0, 18)
    Btn2.ZIndex = Zindex + 6

    Btn2Corner.CornerRadius = UDim.new(0, 3)
    Btn2Corner.Parent = Btn2

    Btn2Stroke.Color = Compkiller.Colors.StrokeColor
    Btn2Stroke.Parent = Btn2

    Btn2Text.Parent = Btn2
    Btn2Text.AnchorPoint = Vector2.new(0.5, 0.5)
    Btn2Text.BackgroundTransparency = 1
    Btn2Text.Position = UDim2.new(0.5, 0, 0.5, 0)
    Btn2Text.Size = UDim2.new(1, 0, 1, 0)
    Btn2Text.Font = Enum.Font.GothamMedium
    Btn2Text.Text = Config.Button2Text
    Btn2Text.TextColor3 = Compkiller.Colors.SwitchColor
    Btn2Text.TextSize = 12
    Btn2Text.ZIndex = Zindex + 7

    Btn1.Name = Compkiller:_RandomString()
    Btn1.Parent = ButtonContainer
    Btn1.BackgroundColor3 = Compkiller.Colors.DropColor
    Btn1.BorderSizePixel = 0
    Btn1.Size = UDim2.new(0, 48, 0, 18)
    Btn1.ZIndex = Zindex + 6

    Btn1Corner.CornerRadius = UDim.new(0, 3)
    Btn1Corner.Parent = Btn1

    Btn1Stroke.Color = Compkiller.Colors.StrokeColor
    Btn1Stroke.Parent = Btn1

    Btn1Text.Parent = Btn1
    Btn1Text.AnchorPoint = Vector2.new(0.5, 0.5)
    Btn1Text.BackgroundTransparency = 1
    Btn1Text.Position = UDim2.new(0.5, 0, 0.5, 0)
    Btn1Text.Size = UDim2.new(1, 0, 1, 0)
    Btn1Text.Font = Enum.Font.GothamMedium
    Btn1Text.Text = Config.Button1Text
    Btn1Text.TextColor3 = Compkiller.Colors.SwitchColor
    Btn1Text.TextSize = 12
    Btn1Text.ZIndex = Zindex + 7

    table.insert(Compkiller.Elements.DropColor , { Element = Btn1, Property = "BackgroundColor3" })
    table.insert(Compkiller.Elements.DropColor , { Element = Btn2, Property = "BackgroundColor3" })
    table.insert(Compkiller.Elements.StrokeColor,{ Element = Btn1Stroke, Property = "Color" });
    table.insert(Compkiller.Elements.StrokeColor,{ Element = Btn2Stroke, Property = "Color" });
    table.insert(Compkiller.Elements.SwitchColor , { Element = Btn1Text, Property = 'TextColor3' });
    table.insert(Compkiller.Elements.SwitchColor , { Element = Btn2Text, Property = 'TextColor3' });

    Compkiller:_Hover(Btn1,function()
        Compkiller:_Animation(Btn1,TweenInfo.new(0.3),{ BackgroundColor3 = Compkiller:_PolishColor("Hover") });
    end,function()
        Compkiller:_Animation(Btn1,TweenInfo.new(0.3),{ BackgroundColor3 = Compkiller.Colors.DropColor });
    end, true);

    Compkiller:_Hover(Btn2,function()
        Compkiller:_Animation(Btn2,TweenInfo.new(0.3),{ BackgroundColor3 = Compkiller:_PolishColor("Hover") });
    end,function()
        Compkiller:_Animation(Btn2,TweenInfo.new(0.3),{ BackgroundColor3 = Compkiller.Colors.DropColor });
    end, true);

    Compkiller:_Input(Btn1, Config.Button1Callback)

    local repi
    local loaded = false
    local Btn2Input = Compkiller:_Input(Btn2, function()
        if not loaded and Config.DropdownValues and #Config.DropdownValues > 0 then
            loaded = true
            repi:SetData(Config.DropdownValues[1], Config.DropdownValues, false, false)
            repi:Refersh()
        end
    end)
    
    Btn2Input:SetAttribute("DropdownWidth", 150)
    Btn2Input:SetAttribute("DropdownOffsetX", -102)
    
    repi = Compkiller:_LoadDropdown(Btn2Input, function(value)
        Config.DropdownCallback(value)
    end)

    local Base = 15;
    local HasViewport = Config.Model ~= nil

    local UpdateScale = function()
        local Height
        if not DescriptionText.Text:byte() then
            local TitleScale = TextService:GetTextSize(
                BlockText.Text, BlockText.TextSize, BlockText.Font, Vector2.new(math.huge, math.huge)
            )
            Height = TitleScale.Y + Base
        else
            local TitleScale = TextService:GetTextSize(
                BlockText.Text, BlockText.TextSize, BlockText.Font, Vector2.new(math.huge, math.huge)
            )
            local ContentScale = TextService:GetTextSize(
                DescriptionText.Text, DescriptionText.TextSize, DescriptionText.Font, Vector2.new(math.huge, math.huge)
            )
            Height = (TitleScale.Y + ContentScale.Y) + Base
        end

        if HasViewport then Height = math.max(Height, 50) end

        Compkiller:_Animation(Paragraph, TweenInfo.new(0.15), {
            Size = UDim2.new(1, -1, 0, Height)
        })
    end;

    UpdateScale();

    local ActionArgs = {};
    ActionArgs.Root = Paragraph
    ActionArgs.TitleLabel = BlockText
    ActionArgs.ContentLabel = DescriptionText
    ActionArgs.BuyButton = Btn1
    ActionArgs.ReplaceButton = Btn2

    function ActionArgs:SetTitle(title)
        if _targetLoc then
            local key = tostring(_targetLoc) .. "|" .. title
            if _translationCache[key] then
                BlockText.Text = _translationCache[key]
                UpdateScale()
            else
                BlockText.Text = title
                UpdateScale()
                task.spawn(function()
                    local result = GetTranslationSync(title, _targetLoc)
                    if result ~= title then
                        BlockText.Text = result
                        UpdateScale()
                    end
                end)
            end
        else
            BlockText.Text = title;
            UpdateScale();
        end
    end;

    function ActionArgs:SetContent(content)
        if _targetLoc then
            local key = tostring(_targetLoc) .. "|" .. content
            if _translationCache[key] then
                DescriptionText.Text = _translationCache[key]
                UpdateScale()
            else
                DescriptionText.Text = content
                UpdateScale()
                task.spawn(function()
                    local result = GetTranslationSync(content, _targetLoc)
                    if result ~= content then
                        DescriptionText.Text = result
                        UpdateScale()
                    end
                end)
            end
        else
            DescriptionText.Text = content;
            UpdateScale();
        end
    end;

    function ActionArgs:SetImage(image)
        if image then
            if not BlockImage.Parent then BlockImage.Parent = Paragraph end
            BlockImage.Image = image
        else
            BlockImage.Parent = nil
        end
    end;

    function ActionArgs:SetVisible(visible)
        if visible then
            Compkiller:_Animation(BlockText, TweenInfo.new(0.2), { TextTransparency = 0.100 });
            Compkiller:_Animation(DescriptionText, TweenInfo.new(0.2), { TextTransparency = 0.250 });
            Compkiller:_Animation(BlockLine, TweenInfo.new(0.2), { BackgroundTransparency = 0.500 });
            if BlockViewport then
                BlockViewport.BackgroundTransparency = 0
                BlockViewport.Visible = true
            end
            if BlockImage then BlockImage.ImageTransparency = 0 end
        else
            Compkiller:_Animation(BlockText, TweenInfo.new(0.2), { TextTransparency = 1 });
            Compkiller:_Animation(DescriptionText, TweenInfo.new(0.2), { TextTransparency = 1 });
            Compkiller:_Animation(BlockLine, TweenInfo.new(0.2), { BackgroundTransparency = 1 });
            if BlockViewport then
                BlockViewport.BackgroundTransparency = 1
                BlockViewport.Visible = false
            end
            if BlockImage then BlockImage.ImageTransparency = 1 end
        end
    end;

    function ActionArgs:UpdateDropdown(values)
        if values and #values > 0 then
            repi:SetData(values[1], values, false, false)
            repi:Refersh()
        end
    end;

    ActionArgs.Signal = Signal:Connect(function(bool)
        if bool then
            Compkiller:_Animation(BlockText, TweenInfo.new(0.2), { TextTransparency = 0.100 });
            Compkiller:_Animation(DescriptionText, TweenInfo.new(0.2), { TextTransparency = 0.250 });
            Compkiller:_Animation(BlockLine, TweenInfo.new(0.2), { BackgroundTransparency = 0.500 });
        else
            Compkiller:_Animation(BlockText, TweenInfo.new(0.2), { TextTransparency = 1 });
            Compkiller:_Animation(DescriptionText, TweenInfo.new(0.2), { TextTransparency = 1 });
            Compkiller:_Animation(BlockLine, TweenInfo.new(0.2), { BackgroundTransparency = 1 });
        end;
    end);

    return ActionArgs;
	end;

	function Args:AddTextBox(Config: TextBoxConfig)
		Config = Compkiller.__CONFIG(Config , {
			Name = "TextBox",
			Default = "",
			Placeholder = "Placeholder",
			Numberic = false,
			Callback = function() end,
		});

		local TextBox = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local LinkValues = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local TextBox_2 = Instance.new("TextBox")
		local BlockLine = Instance.new("Frame")

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(TextBox);
		end;

		TextBox.Name = Compkiller:_RandomString()
		TextBox.Parent = Parent
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Size = UDim2.new(1, -1, 0, 30)
		TextBox.ZIndex = Zindex + 1

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = TextBox
		BlockText.AnchorPoint = Vector2.new(0, 0.5)
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0.5, 0)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 2
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Name
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 16
		BlockText.TextTransparency = 0.300
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = BlockText,
			Property = "TextColor3"
		})

		LinkValues.Name = Compkiller:_RandomString()
		LinkValues.Parent = TextBox
		LinkValues.AnchorPoint = Vector2.new(1, 0.5)
		LinkValues.BackgroundColor3 = Compkiller.Colors.DropColor
		LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LinkValues.BorderSizePixel = 0
		LinkValues.Position = UDim2.new(1, -12, 0.5, 0)
		LinkValues.Size = UDim2.new(0, 95, 0, 22)
		LinkValues.ZIndex = Zindex + 3

		table.insert(Compkiller.Elements.DropColor,{
			Element = LinkValues,
			Property = "BackgroundColor3"
		})

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = LinkValues

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = LinkValues

		TextBox_2.Parent = LinkValues
		TextBox_2.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox_2.BackgroundTransparency = 1.000
		TextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox_2.BorderSizePixel = 0
		TextBox_2.ClipsDescendants = true -- prevent long text overflow
		TextBox_2.TextTruncate = Enum.TextTruncate.AtEnd
		TextBox_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextBox_2.Size = UDim2.new(1, -16, 1, 0)
		TextBox_2.ZIndex = Zindex + 5
		TextBox_2.ClearTextOnFocus = false
		TextBox_2.Font = Enum.Font.GothamMedium
		TextBox_2.PlaceholderText = Config.Placeholder
		Compkiller:_BindPolishColor(TextBox_2, "PlaceholderColor3", "Placeholder");
		TextBox_2.Text = Config.Default
		TextBox_2.TextColor3 = Compkiller.Colors.SwitchColor
		TextBox_2.TextSize = 13

		table.insert(Compkiller.Elements.SwitchColor,{
			Element = TextBox_2,
			Property = "TextColor3"
		})

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = TextBox
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 3;

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		})

		local Update = function()
            local width = TextBox.AbsoluteSize.X / Compkiller:_GetUIScale(TextBox)
            if width <= 0 then return end
            local size = Compkiller:_ControlFieldSize(TextBox_2,28,width*0.5)
            if LinkValues.Size ~= size then LinkValues.Size = size end
		end;

		local parse = function(text)
			if not text then
				return "";	
			end;

			if Config.Numeric then
				local out = string.gsub(tostring(text), '[^0-9.]', '')

				if tonumber(out) then
					return tonumber(out);
				end;

				return nil;
			end;

			return text;
		end;

		Update();

		TextBox_2:GetPropertyChangedSignal('Text'):Connect(Update);
        TextBox:GetPropertyChangedSignal('AbsoluteSize'):Connect(Update);

		TextBox_2:GetPropertyChangedSignal('Text'):Connect(function()
			local value = parse(TextBox_2.Text);

			if value then

				TextBox_2.Text = tostring(value);

				task.spawn(Config.Callback,value);

				Config.Default = value;
			else
				TextBox_2.Text = string.gsub(TextBox_2.Text, '[^0-9.]', '');

				Config.Default = TextBox_2.Text;
			end;
		end);

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(Value)
			Config.Default = Value;

			TextBox_2.Text = tostring(Config.Default);

			Config.Callback(Value);
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 0.3
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.5
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 0
				});

				Compkiller:_Animation(LinkValues,TweenInfo.new(0.2),{
					BackgroundTransparency = 0
				});

			else
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 1
				});

				Compkiller:_Animation(LinkValues,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});

			end;
		end);

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

        if Config.Icon then Compkiller:_ControlIcon(BlockText, Config.Icon); end;
        Compkiller:_BindControlLabel(TextBox, BlockText, function(scale) return LinkValues.AbsoluteSize.X / scale end,
            {Icon = Config.Icon, Triggers = {{LinkValues, "AbsoluteSize"}}})
		return Args;
	end;

	function Args:AddDropdown(Config : Dropdown)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Dropdown",
			Default = nil,
			Values = {"Item 1","Item 2","Item 3"},
			Multi = false,
			Callback = function() end,
			ActionButton = nil,
			ActionButton2 = nil,
			Upwards = false
		});
        Config.Icon = Config.Icon or (Compkiller.ActionIcons or {})[Config.Name];
        local actionWidth = ((Config.ActionButton and Config.ActionButton.Icon) or
            (Config.ActionButton2 and Config.ActionButton2.Icon)) and 100 or 65;

		local DaTabarser = function(value)
			if not value then return ''; end;

			local Out;

			if typeof(value) == 'table' then
				if #value > 0 then
					local x = {};

					for i,v in next , value do
						table.insert(x , tostring(v))
					end;

					Out = table.concat(x,' , ');
				else
					local x = {};

					for i,v in next , value do
						if v == true then
							table.insert(x , tostring(i));
						end			
					end;

					Out = table.concat(x,' , ');
				end;
			else
				Out = tostring(value);
			end;

			return Out;
		end;

		local Dropdown = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")
		local LinkValues = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local ValueItems = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local ValueText = Instance.new("TextBox")
		local MainButton = Instance.new("ImageButton")

		Dropdown.Name = Compkiller:_RandomString()
		Dropdown.Parent = Parent
		Dropdown.BackgroundTransparency = 1.000
		Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Dropdown.BorderSizePixel = 0
		if Config.ActionButton and Config.ActionButton2 then
			Dropdown.Size = UDim2.new(1, -1, 0, 75)
		else
			Dropdown.Size = UDim2.new(1, -1, 0, 55)
		end
		Dropdown.ZIndex = Zindex + 2

		BlockText.Name = Compkiller:_RandomString()
		BlockText.Parent = Dropdown
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0, 1)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 3
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Name
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 16
		BlockText.TextTransparency = 0.100
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		if not BlockText.Text:byte() then
			Dropdown.Size = UDim2.new(1, -1, 0, 31)
		end;

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = Dropdown
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 3

		if Config.ActionButton then
			local actionBtn = Instance.new("TextButton")
			actionBtn.Name = Compkiller:_RandomString()
			actionBtn.Parent = Dropdown
			actionBtn.AnchorPoint = Vector2.new(1, 0)
			actionBtn.Position = UDim2.new(1, -12, 0, 4)
			actionBtn.Size = UDim2.new(0, actionWidth, 0, 18)
			actionBtn.BackgroundColor3 = Config.ActionButton.Color or Compkiller.Colors.Toggle
			if not Config.ActionButton.Color then Compkiller:_BindPolishColor(actionBtn, "BackgroundColor3", "Toggle"); end;
			actionBtn.Text = Config.ActionButton.Text or "Action"
			Compkiller:_BindPolishColor(actionBtn, "TextColor3", "SwitchColor");
			actionBtn.Font = Enum.Font.GothamMedium
			actionBtn.TextSize = 13
			actionBtn.ZIndex = Zindex + 5
			
			if Config.ActionButton.Icon then Compkiller:_TextButtonIcon(actionBtn, Config.ActionButton.Icon); end;
			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0, 4)
			btnCorner.Parent = actionBtn

			local popout = Instance.new("Frame")
			popout.Name = Compkiller:_RandomString()
			popout.Parent = Dropdown
			popout.AnchorPoint = Vector2.new(1, 0.5)
			popout.Position = UDim2.new(1, -20-actionWidth, 0, 13)
			popout.Size = UDim2.new(0, 140, 0, 24)
			Compkiller:_BindPolishColor(popout, "BackgroundColor3", "DropColor");
			popout.Visible = false
			popout.ZIndex = Zindex + 10
			
			local popoutCorner = Instance.new("UICorner")
			popoutCorner.CornerRadius = UDim.new(0, 4)
			popoutCorner.Parent = popout
			
			local popoutStroke = Instance.new("UIStroke")
			Compkiller:_BindPolishColor(popoutStroke, "Color", "StrokeColor");
			popoutStroke.Parent = popout
			
			local arrow = Instance.new("Frame")
			arrow.Name = Compkiller:_RandomString()
			arrow.Parent = popout
			arrow.AnchorPoint = Vector2.new(0, 0.5)
			arrow.Position = UDim2.new(1, -4, 0.5, 0)
			arrow.Size = UDim2.new(0, 8, 0, 8)
			Compkiller:_BindPolishColor(arrow, "BackgroundColor3", "DropColor");
			arrow.Rotation = 45
			arrow.ZIndex = Zindex + 9
			
			local inputTb = Instance.new("TextBox")
			inputTb.Name = Compkiller:_RandomString()
			inputTb.Parent = popout
			inputTb.Size = UDim2.new(1, -10, 1, 0)
			inputTb.Position = UDim2.new(0, 5, 0, 0)
			inputTb.BackgroundTransparency = 1
			inputTb.PlaceholderText = "File name + Enter"
			Compkiller:_BindPolishColor(inputTb, "PlaceholderColor3", "Placeholder");
			Compkiller:_BindPolishColor(inputTb, "TextColor3", "SwitchColor");
			inputTb.Text = ""
			inputTb.Font = Enum.Font.GothamMedium
			inputTb.TextSize = 13
			inputTb.ZIndex = Zindex + 11

			Compkiller:_BindClickRipple(actionBtn);
			actionBtn.MouseButton1Click:Connect(function()
				popout.Visible = not popout.Visible
				if popout.Visible then
					inputTb:CaptureFocus()
				end
			end)

			local SubmitAction = Compkiller:_GuardButtonCallback(function(text)
				if Config.ActionButton.Callback then Config.ActionButton.Callback(text); end;
			end, Config.ActionButton);

			inputTb.FocusLost:Connect(function(enterPressed)
				local text = inputTb.Text
				popout.Visible = false
				if text ~= "" then
					inputTb.Text = ""
					SubmitAction(text)
				end
			end)
		end

		local actionButton2
		if Config.ActionButton2 then
			local actionBtn2 = Instance.new("TextButton")
			actionButton2 = actionBtn2
			if Config.ActionButton2.FollowMulti then
				actionBtn2.Visible = Config.Multi == true
			else
				actionBtn2.Visible = Config.ActionButton2.Visible ~= false
			end
			actionBtn2.Name = Compkiller:_RandomString()
			actionBtn2.Parent = Dropdown
			actionBtn2.AnchorPoint = Vector2.new(1, 0)
			if Config.ActionButton then
				actionBtn2.Position = UDim2.new(1, -12, 0, 24)
			else
				actionBtn2.Position = UDim2.new(1, -12, 0, 4)
			end
			actionBtn2.Size = UDim2.new(0, actionWidth, 0, 18)
			actionBtn2.BackgroundColor3 = Config.ActionButton2.Color or Compkiller.Colors.DropColor
			if not Config.ActionButton2.Color then Compkiller:_BindPolishColor(actionBtn2, "BackgroundColor3", "DropColor"); end;
			actionBtn2.Text = Config.ActionButton2.Text or "Action 2"
			Compkiller:_BindPolishColor(actionBtn2, "TextColor3", "SwitchColor");
			actionBtn2.Font = Enum.Font.GothamMedium
			actionBtn2.TextSize = 13
			actionBtn2.ZIndex = Zindex + 5
			
			if Config.ActionButton2.Icon then Compkiller:_TextButtonIcon(actionBtn2, Config.ActionButton2.Icon); end;
			local btnCorner2 = Instance.new("UICorner")
			btnCorner2.CornerRadius = UDim.new(0, 4)
			btnCorner2.Parent = actionBtn2

			Compkiller:_BindClickRipple(actionBtn2);
			local RunAction = Compkiller:_GuardButtonCallback(function()
				if Config.ActionButton2.Callback then Config.ActionButton2.Callback(); end;
			end, Config.ActionButton2);
			actionBtn2.MouseButton1Click:Connect(RunAction)
		end

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		LinkValues.Name = Compkiller:_RandomString()
		LinkValues.Parent = Dropdown
		LinkValues.AnchorPoint = Vector2.new(1, 0.5)
		LinkValues.BackgroundTransparency = 1.000
		LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LinkValues.BorderSizePixel = 0
		LinkValues.Position = UDim2.new(1, -12, 0, 13.5)
		LinkValues.Size = UDim2.new(1, 0, 0, 22)
		LinkValues.ZIndex = Zindex + 3

		UIListLayout.Parent = LinkValues
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 8)

		ValueItems.Name = Compkiller:_RandomString()
		ValueItems.Parent = Dropdown
		ValueItems.AnchorPoint = Vector2.new(0.5, 1)
		ValueItems.BackgroundColor3 = Compkiller.Colors.BGDBColor
		ValueItems.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueItems.BorderSizePixel = 0
		ValueItems.ClipsDescendants = true
		ValueItems.Position = UDim2.new(0.5, 0, 1, -7)
		ValueItems.Size = UDim2.new(1, -24, 0, 22)
		ValueItems.ZIndex = Zindex + 5

		table.insert(Compkiller.Elements.BGDBColor , {
			Element = ValueItems,
			Property = "BackgroundColor3"
		})

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = ValueItems

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = ValueItems

		ValueText.Name = Compkiller:_RandomString()
		-- This is a display value, not a user input; keep its backing selection untouched.
		ValueText:SetAttribute("ButterStreamerText", true)
		ValueText.TextEditable = false
		ValueText.ClearTextOnFocus = false
		ValueText.Parent = ValueItems
		ValueText.AnchorPoint = Vector2.new(0, 0.5)
		ValueText.BackgroundTransparency = 1.000
		ValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueText.BorderSizePixel = 0
		ValueText.Position = UDim2.new(0, 8, 0.5, 0)
		ValueText.Size = UDim2.new(1, -34, 0, 20)
		ValueText.ZIndex = Zindex + 8
		ValueText.Font = Enum.Font.GothamMedium
		ValueText.Text = DaTabarser(Config.Default)
		ValueText.TextColor3 = Compkiller.Colors.SwitchColor
		ValueText.TextSize = 15
		ValueText.TextXAlignment = Enum.TextXAlignment.Left
		ValueText.TextTruncate = Enum.TextTruncate.AtEnd

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = ValueText,
			Property = 'TextColor3'
		});

		MainButton.Name = Compkiller:_RandomString()
		MainButton.Parent = ValueItems
		MainButton.AnchorPoint = Vector2.new(1, 0.5)
		MainButton.BackgroundTransparency = 1.000
		MainButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainButton.BorderSizePixel = 0
		MainButton.Position = UDim2.new(1, -8, 0.5, 0)
		MainButton.Size = UDim2.new(0, 13, 0, 13)
		MainButton.ZIndex = Zindex + 5
		Compkiller:_SetIcon(MainButton,"chevron-down")

		local isHovering = false
		local isPressing = false
		
		local function updateVisuals()
			if (isHovering or isPressing) and not Compkiller:_IsDropdownHoverBlocked(ValueItems) then
				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundColor3 = Compkiller:_PolishColor("Hover")
				})
				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Color = Compkiller.Colors.Highlight
				})
			else
				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundColor3 = Compkiller.Colors.BGDBColor
				})
				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Color = Compkiller.Colors.StrokeColor
				})
			end
		end

		Compkiller:_BindPolishUpdate(ValueItems, updateVisuals);

		Compkiller:_Hover(ValueItems, function()
			isHovering = true
			updateVisuals()
		end, function()
			isHovering = false
			isPressing = false
			updateVisuals()
		end, true)

		local repi;
		local Button = Compkiller:_Input(ValueItems);
		if Config.Upwards then
			Button:SetAttribute("DropdownUpwards", true)
		end
		
		Button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				isPressing = true
				updateVisuals()
			end
		end)
		
		Button.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				isPressing = false
				updateVisuals()
			end
		end)

		repi = Compkiller:_LoadDropdown(Button,function(value)
			Config.Default = value;

			repi:SetData(Config.Default,Config.Values,Config.Multi,false);
			repi:SetDefault(Config.Default);

			ValueText.Text = DaTabarser(Config.Default);

			Config.Callback(Config.Default);
		end, Config.Preview, Config.PreviewOptions, Config.ItemIcon);

		repi.EventOut:Connect(function(v)
			if v then
				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					Rotation = -180
				})
			else
				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					Rotation = 0
				})
			end;
		end)

		repi:SetData(Config.Default,Config.Values,Config.Multi,false);
		repi:Refersh();

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetMulti(enabled)
			Config.Multi = enabled == true
			if actionButton2 and Config.ActionButton2.FollowMulti then
				actionButton2.Visible = Config.Multi
			end
			local selected = {}
			if typeof(Config.Default) == "table" then
				for _, option in ipairs(Config.Values) do
					if Config.Default[option] == true or table.find(Config.Default, option) then
						table.insert(selected, option)
					end
				end
			elseif Config.Default ~= nil and Config.Default ~= "" then
				table.insert(selected, Config.Default)
			end
			local value
			if Config.Multi then
				value = {}
				for _, option in ipairs(selected) do value[option] = true end
			else
				value = selected[1]
			end
			self:SetValue(value)
			repi:Refersh()
		end

		function Args:SetActionButton2Visible(visible)
			if actionButton2 then actionButton2.Visible = visible == true end
		end

		function Args:SetValue(Value)
			Config.Default = Value;

			ValueText.Text = DaTabarser(Config.Default);

			repi:SetData(Config.Default,Config.Values,Config.Multi,true);

			Config.Callback(Value);
		end;

		function Args:SetValues(v)
			Config.Values = v;

			repi:SetData(Config.Default,Config.Values,Config.Multi,true);
		end;

		function Args:Clear()
			repi:ClearSelection();
		end;

		function Args:ClearSelection()
			repi:ClearSelection();
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 0.100
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.100
				});

				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundTransparency = 0
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 0
				});

				Compkiller:_Animation(ValueText,TweenInfo.new(0.32),{
					TextTransparency = 0
				});

				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					ImageTransparency = 0
				});
			else
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 1 
				});

				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 1
				});

				Compkiller:_Animation(ValueText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					ImageTransparency = 1
				});
			end;
		end);

		Args.Link = Compkiller:_LoadOption({
			AddLink = function(self ,Name , Default)
				return Compkiller:_AddLinkValue(Name , Default , LinkValues , LinkValues , {
					Tween = TweenInfo.new(0.2)	
				} , Signal);
			end,
			Root = Dropdown
		});

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

        if Config.Icon then Compkiller:_ControlIcon(BlockText, Config.Icon); end;
        local labelTriggers = {{UIListLayout, "AbsoluteContentSize"}}
        if actionButton2 then table.insert(labelTriggers, {actionButton2, "Visible"}) end
        Compkiller:_BindControlLabel(Dropdown, BlockText, function(scale)
            local reservedActionWidth = (Config.ActionButton or (actionButton2 and actionButton2.Visible)) and actionWidth or 0
            return math.max(Compkiller:_InlineControlWidth(LinkValues, UIListLayout, scale), reservedActionWidth)
        end, {Icon = Config.Icon, Triggers = labelTriggers})
		return Args;
	end;

	-- Image Dropdown ──────────────────────────────────────────────────────────
	function Args:AddImageDropdown(Config)
		Config = Compkiller.__CONFIG(Config, {
			Name     = "Image Dropdown",
			Default  = nil,
			Values   = {},
			Flag     = nil,
			Callback = function() end,
			Upwards  = false
		});

		local function SelectedName()
			if not Config.Default then return ''; end;
			return tostring(Config.Default.name or '');
		end;

		local function SelectedImage()
			if not Config.Default then return ''; end;
			return tostring(Config.Default.image or '');
		end;

		-- outer frame
		local Dropdown     = Instance.new("Frame");
		local BlockText    = Instance.new("TextLabel");
		local BlockLine    = Instance.new("Frame");
		local LinkValues   = Instance.new("Frame");
		local LLLayout     = Instance.new("UIListLayout");
		-- pill trigger
		local ValueItems   = Instance.new("Frame");
		local UIStroke     = Instance.new("UIStroke");
		local UICorner     = Instance.new("UICorner");
		local ThumbImg     = Instance.new("ImageLabel");
		local ValueText    = Instance.new("TextLabel");
		local ChevronBtn   = Instance.new("ImageButton");

		Dropdown.Name                  = Compkiller:_RandomString();
		Dropdown.Parent                = Parent;
		Dropdown.BackgroundTransparency = 1;
		Dropdown.BorderSizePixel       = 0;
		Dropdown.Size                  = UDim2.new(1,-1,0,55);
		Dropdown.ZIndex                = Zindex + 2;

		BlockText.Name                 = Compkiller:_RandomString();
		BlockText.Parent               = Dropdown;
		BlockText.BackgroundTransparency = 1;
		BlockText.BorderSizePixel      = 0;
		BlockText.Position             = UDim2.new(0,12,0,1);
		BlockText.Size                 = UDim2.new(1,-20,0,25);
		BlockText.ZIndex               = Zindex + 3;
		BlockText.Font                 = Enum.Font.GothamMedium;
		BlockText.Text                 = Config.Name;
		BlockText.TextColor3           = Compkiller.Colors.SwitchColor;
		BlockText.TextSize             = 16;
		BlockText.TextTransparency     = 0.1;
		BlockText.TextXAlignment       = Enum.TextXAlignment.Left;
		table.insert(Compkiller.Elements.SwitchColor,{Element=BlockText,Property='TextColor3'});

		if not BlockText.Text:byte() then
			Dropdown.Size = UDim2.new(1,-1,0,25);
		end;

		BlockLine.Name                 = Compkiller:_RandomString();
		BlockLine.Parent               = Dropdown;
		BlockLine.AnchorPoint          = Vector2.new(0.5,1);
		BlockLine.BackgroundColor3     = Compkiller.Colors.LineColor;
		BlockLine.BackgroundTransparency = 0.5;
		BlockLine.BorderSizePixel      = 0;
		BlockLine.Position             = UDim2.new(0.5,0,1,0);
		BlockLine.Size                 = UDim2.new(1,-26,0,1);
		BlockLine.ZIndex               = Zindex + 3;
		table.insert(Compkiller.Elements.LineColor,{Element=BlockLine,Property="BackgroundColor3"});

		LinkValues.Name               = Compkiller:_RandomString();
		LinkValues.Parent             = Dropdown;
		LinkValues.AnchorPoint        = Vector2.new(1,0.5);
		LinkValues.BackgroundTransparency = 1;
		LinkValues.BorderSizePixel    = 0;
		LinkValues.Position           = UDim2.new(1,-12,0,13.5);
		LinkValues.Size               = UDim2.new(1,0,0,22);
		LinkValues.ZIndex             = Zindex + 3;
		LLLayout.Parent              = LinkValues;
		LLLayout.FillDirection       = Enum.FillDirection.Horizontal;
		LLLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
		LLLayout.SortOrder           = Enum.SortOrder.LayoutOrder;
		LLLayout.VerticalAlignment   = Enum.VerticalAlignment.Center;
		LLLayout.Padding             = UDim.new(0,8);

		ValueItems.Name               = Compkiller:_RandomString();
		ValueItems.Parent             = Dropdown;
		ValueItems.AnchorPoint        = Vector2.new(0.5,1);
		ValueItems.BackgroundColor3   = Compkiller.Colors.DropColor;
		ValueItems.BorderSizePixel    = 0;
		ValueItems.ClipsDescendants   = true;
		ValueItems.Position           = UDim2.new(0.5,0,1,-7);
		ValueItems.Size               = UDim2.new(1,-24,0,22);
		ValueItems.ZIndex             = Zindex + 5;
		table.insert(Compkiller.Elements.BGDBColor,{Element=ValueItems,Property="BackgroundColor3"});

		UIStroke.Color  = Compkiller.Colors.StrokeColor;
		UIStroke.Parent = ValueItems;
		table.insert(Compkiller.Elements.StrokeColor,{Element=UIStroke,Property="Color"});

		UICorner.CornerRadius = UDim.new(0,3);
		UICorner.Parent       = ValueItems;

		ThumbImg.Name                  = Compkiller:_RandomString();
		ThumbImg.Parent                = ValueItems;
		ThumbImg.AnchorPoint           = Vector2.new(0,0.5);
		ThumbImg.BackgroundTransparency = 1;
		ThumbImg.BorderSizePixel       = 0;
		ThumbImg.Position              = UDim2.new(0,8,0.5,0);
		ThumbImg.Size                  = UDim2.new(0,13,0,13);
		ThumbImg.ZIndex                = Zindex + 8;
		ThumbImg.ScaleType             = Enum.ScaleType.Fit;
		ThumbImg.Image                 = SelectedImage();

		ValueText.Name                 = Compkiller:_RandomString();
		ValueText.Parent               = ValueItems;
		ValueText.AnchorPoint          = Vector2.new(0,0.5);
		ValueText.BackgroundTransparency = 1;
		ValueText.BorderSizePixel      = 0;
		ValueText.Position             = UDim2.new(0,26,0.5,0);
		ValueText.Size                 = UDim2.new(1,-52,0,20);
		ValueText.ZIndex               = Zindex + 8;
		ValueText.Font                 = Enum.Font.GothamMedium;
		ValueText.Text                 = SelectedName();
		ValueText.TextColor3           = Compkiller.Colors.SwitchColor;
		ValueText.TextSize             = 13;
		ValueText.TextXAlignment       = Enum.TextXAlignment.Left;
		ValueText.TextTruncate         = Enum.TextTruncate.AtEnd;
		table.insert(Compkiller.Elements.SwitchColor,{Element=ValueText,Property='TextColor3'});

		ChevronBtn.Name                = Compkiller:_RandomString();
		ChevronBtn.Parent              = ValueItems;
		ChevronBtn.AnchorPoint         = Vector2.new(1,0.5);
		ChevronBtn.BackgroundTransparency = 1;
		ChevronBtn.BorderSizePixel     = 0;
		ChevronBtn.Position            = UDim2.new(1,-8,0.5,0);
		ChevronBtn.Size                = UDim2.new(0,13,0,13);
		ChevronBtn.ZIndex              = Zindex + 5;
		ChevronBtn.Image               = "rbxassetid://10709790948";

		local isHovering = false
		local isPressing = false
		
		local function updateVisuals()
			if (isHovering or isPressing) and not Compkiller:_IsDropdownHoverBlocked(ValueItems) then
				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundColor3 = Compkiller:_PolishColor("Hover")
				})
				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Color = Compkiller.Colors.Highlight
				})
			else
				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundColor3 = Compkiller.Colors.BGDBColor
				})
				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Color = Compkiller.Colors.StrokeColor
				})
			end
		end

		Compkiller:_BindPolishUpdate(ValueItems, updateVisuals);

		Compkiller:_Hover(ValueItems, function()
			isHovering = true
			updateVisuals()
		end, function()
			isHovering = false
			isPressing = false
			updateVisuals()
		end, true)

		local Button = Compkiller:_Input(ValueItems);
		if Config.Upwards then
			Button:SetAttribute("DropdownUpwards", true)
		end
		
		Button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				isPressing = true
				updateVisuals()
			end
		end)
		
		Button.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				isPressing = false
				updateVisuals()
			end
		end)

		local repi = Compkiller:_LoadImageDropdown(Button, function(item)
			Config.Default = item;
			ThumbImg.Image = SelectedImage();
			ValueText.Text = SelectedName();
			Config.Callback(item);
		end, Config.Preview);

		repi.EventOut:Connect(function(v)
			if v then
				Compkiller:_Animation(ChevronBtn, TweenInfo.new(0.2), {Rotation = -180});
			else
				Compkiller:_Animation(ChevronBtn, TweenInfo.new(0.2), {Rotation = 0});
			end;
		end);

		repi:SetData(Config.Default, Config.Values);

		local iArgs = {};
		iArgs.Flag  = Config.Flag;

		function iArgs:SetValue(item)
			Config.Default = item;
			ThumbImg.Image = SelectedImage();
			ValueText.Text = SelectedName();
			repi:SetData(Config.Default, Config.Values);
			Config.Callback(item);
		end;

		function iArgs:SetValues(v)
			Config.Values = v;
			repi:SetData(Config.Default, Config.Values);
		end;

		function iArgs:GetValue()
			return Config.Default;
		end;

		iArgs.Signal = Signal:Connect(function(bool)
			local t = bool and 0.1 or 1;
			Compkiller:_Animation(BlockText,  TweenInfo.new(0.2), {TextTransparency      = t});
			Compkiller:_Animation(BlockLine,  TweenInfo.new(0.2), {BackgroundTransparency = t});
			Compkiller:_Animation(ValueItems, TweenInfo.new(0.2), {BackgroundTransparency = bool and 0 or 1});
			Compkiller:_Animation(UIStroke,   TweenInfo.new(0.2), {Transparency           = bool and 0 or 1});
			Compkiller:_Animation(ValueText,  TweenInfo.new(0.2), {TextTransparency       = bool and 0 or 1});
			Compkiller:_Animation(ThumbImg,   TweenInfo.new(0.2), {ImageTransparency      = bool and 0 or 1});
			Compkiller:_Animation(ChevronBtn, TweenInfo.new(0.2), {ImageTransparency      = bool and 0 or 1});
		end);

		iArgs.Link = Compkiller:_LoadOption({
			AddLink = function(self, Name, Default)
				return Compkiller:_AddLinkValue(Name, Default, LinkValues, LinkValues, {Tween=TweenInfo.new(0.2)}, Signal);
			end,
			Root = Dropdown
		});

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = iArgs;
		end;

        if Config.Icon then Compkiller:_ControlIcon(BlockText, Config.Icon); end;
        Compkiller:_BindControlLabel(Dropdown, BlockText, function(scale)
            return Compkiller:_InlineControlWidth(LinkValues, LLLayout, scale)
        end, {Icon = Config.Icon, Triggers = {{LLLayout, "AbsoluteContentSize"}}})
		return iArgs;
	end;
	-- ─────────────────────────────────────────────────────────────────────────

	-- Compatibility wrappers on section level
	function Args:Toggle(elementName, options, callback)
		local location = options and options.location
		local flag = options and options.flag
		local default = (options and options.default ~= nil) and options.default or false

		if location and flag then
			location[flag] = default
		end

		return self:AddToggle({
			Name = elementName,
			Default = default,
			Flag = flag or "",
			Callback = function(value)
				if location and flag then
					location[flag] = value
				end
				if callback then
					pcall(callback, value)
				end
			end
		})
	end

	function Args:Slider(elementName, options, callback)
		local location = options and options.location
		local flag = options and options.flag
		local minVal = options and options.min or 0
		local maxVal = options and options.max or 100
		local defaultVal = options and options.default or minVal

		if location and flag then
			location[flag] = defaultVal
		end

		return self:AddSlider({
			Name = elementName,
			Min = minVal,
			Max = maxVal,
			Default = defaultVal,
			Round = (options and options.precise) and 2 or 0,
			Callback = function(value)
				if location and flag then
					location[flag] = value
				end
				if callback then
					pcall(callback, value)
				end
			end
		})
	end

	function Args:Dropdown(elementName, options, callback)
		local location = options and options.location
		local flag = options and options.flag
		local list = options and options.list or {}

		if options and options.PlayerList then
			list = {}
			for _, player in ipairs(Players:GetPlayers()) do
				table.insert(list, player.Name)
			end
		end

		local default = options and options.default or (list[1] or "")
		if location and flag then
			location[flag] = default
		end

		local dropdown = self:AddDropdown({
			Name = elementName,
			Default = default,
			Values = list,
			Multi = false,
			Callback = function(value)
				if location and flag then
					location[flag] = value
				end
				if callback then
					pcall(callback, value)
				end
			end
		})

		if options and options.PlayerList and dropdown.SetData then
			local function refreshPlayers()
				local currentPlayers = {}
				for _, player in ipairs(Players:GetPlayers()) do
					table.insert(currentPlayers, player.Name)
				end
				dropdown:SetData(location[flag] or currentPlayers[1] or "", currentPlayers, false, true)
			end
			Players.PlayerAdded:Connect(refreshPlayers)
			Players.PlayerRemoving:Connect(refreshPlayers)
		end

		return dropdown
	end

	function Args:ImageDropdown(elementName, options, callback)
		local location = options and options.location
		local flag = options and options.flag
		local list = options and options.list or {}

		local values = {}
		local nameToItem = {}
		for _, item in ipairs(list) do
			if item and item.name then
				table.insert(values, item.name)
				nameToItem[item.name] = item
			end
		end

		local defaultItem = options and options.default
		local defaultName = defaultItem and defaultItem.name or (list[1] and list[1].name) or ""

		if location and flag then
			location[flag] = defaultItem or list[1]
		end

		return self:AddDropdown({
			Name = elementName,
			Default = defaultName,
			Values = values,
			Multi = false,
			Callback = function(selectedName)
				local selectedItem = nameToItem[selectedName]
				if location and flag then
					location[flag] = selectedItem
				end
				if callback then
					pcall(callback, selectedItem)
				end
			end
		})
	end

	function Args:Box(elementName, options, callback)
		local location = options and options.location
		local flag = options and options.flag
		local isNumeric = options and (options.type == "number") or false
		local placeholder = options and (options.hold or options.placeholder) or ""
		local default = options and options.default or ""

		if location and flag then
			location[flag] = default
		end

		return self:AddTextBox({
			Name = elementName,
			Default = tostring(default),
			Placeholder = placeholder,
			Numeric = isNumeric,
			Callback = function(value)
				local typedValue = value
				if isNumeric then
					typedValue = tonumber(value) or 0
				end
				if location and flag then
					location[flag] = typedValue
				end
				if callback then
					pcall(callback, typedValue)
				end
			end
		})
	end

	function Args:Bind(elementName, options, callback)
		local location = options and options.location
		local flag = options and options.flag
		local defaultKey = options and options.default or Enum.KeyCode.F

		if location and flag then
			location[flag] = defaultKey
		end

		return self:AddKeybind({
			Name = elementName,
			Default = defaultKey,
			Callback = function(keyName)
				if location and flag then
					location[flag] = keyName
				end
				if callback then
					pcall(callback, keyName)
				end
			end
		})
	end

	function Args:Button(elementName, callback)
		return self:AddButton({
			Name = elementName,
			Callback = function()
				if callback then
					pcall(callback)
				end
			end
		})
	end

	function Args:Paragraph(title, content)
		return self:AddParagraph({
			Title = title,
			Content = content or ""
		})
	end

	function Args:Search(...)
		return nil
	end

	function Args:String(options)
		if typeof(options) == "table" and options.string then
			return self:AddParagraph({
				Title = options.string,
				Content = ""
			})
		end
		return nil
	end

	return Args;
end;

function Compkiller:GetTheme()
	return Compkiller.Colors;
end;

function Compkiller:SetTheme(name)
	if name == "Dark Green" then
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.0429964, 0.110345, 0.0727226),
			["BlockBackground"] = Color3.new(0.159287, 0.234483, 0.201811),
			["BlockColor"] = Color3.new(0, 0.137931, 0.0951249),
			["DropColor"] = Color3.new(0, 0.227586, 0.100452),
			["Highlight"] = Color3.new(0.0666667, 0.992157, 0.628343),
			["LineColor"] = Color3.new(0.263258, 0.372414, 0.329504),
			["MouseEnter"] = Color3.new(0, 0.841379, 0.51063),
			["Risky"] = Color3.new(1, 0.398296, 0.152941),
			["StrokeColor"] = Color3.new(0.132342, 0.241379, 0.198517),
			["SwitchColor"] = Color3.new(0.927586, 1, 0.980523),
			["Toggle"] = Color3.new(0, 0.613793, 0.220119),
			HighStrokeColor = Color3.new(0, 0.241379, 0.186445),
		};
	elseif name == "Default" then
		Compkiller.Colors = {
			Highlight = Color3.fromRGB(17, 238, 253),
			Toggle = Color3.fromRGB(14, 203, 213),
			Risky = Color3.fromRGB(251, 255, 39),
			BGDBColor = Color3.fromRGB(22, 24, 29),
			BlockColor = Color3.fromRGB(28, 29, 34),
			StrokeColor = Color3.fromRGB(37, 38, 43),
			SwitchColor = Color3.fromRGB(255, 255, 255),
			DropColor = Color3.fromRGB(33, 35, 39),
			MouseEnter = Color3.fromRGB(55, 58, 65),
			BlockBackground = Color3.fromRGB(39, 40, 47),
			LineColor = Color3.fromRGB(65, 65, 65),
			HighStrokeColor = Color3.fromRGB(55, 56, 63),
		};
	elseif name == "Dark Blue" then
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.0393817, 0.0754204, 0.165517),
			["BlockBackground"] = Color3.new(0, 0.0618311, 0.172414),
			["BlockColor"] = Color3.new(0, 0.0172414, 0.103448),
			["DropColor"] = Color3.new(0, 0.0965518, 0.289655),
			["HighStrokeColor"] = Color3.new(0, 0.132604, 0.234483),
			["Highlight"] = Color3.new(0.0666667, 0.781528, 0.992157),
			["LineColor"] = Color3.new(0, 0.110345, 0.275862),
			["MouseEnter"] = Color3.new(0, 0.606896, 1),
			["Risky"] = Color3.new(0.0310345, 0.819572, 1),
			["StrokeColor"] = Color3.new(0, 0.119857, 0.248276),
			["SwitchColor"] = Color3.new(1, 1, 1),
			["Toggle"] = Color3.new(0.054902, 0.463935, 0.835294)
		}
	elseif name == "Purple Rose" then
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.0459068, 0.030321, 0.117241),
			["BlockBackground"] = Color3.new(0.156272, 0.119596, 0.324138),
			["BlockColor"] = Color3.new(0.0948428, 0.0576457, 0.165517),
			["DropColor"] = Color3.new(0.131034, 0, 0.0813317),
			["HighStrokeColor"] = Color3.new(0.136259, 0.101237, 0.296552),
			["Highlight"] = Color3.new(0.992157, 0.0666667, 0.33474),
			["LineColor"] = Color3.new(0.20872, 0.137408, 0.372414),
			["MouseEnter"] = Color3.new(0.365517, 0, 0.120999),
			["Risky"] = Color3.new(1, 0.6086, 0.152941),
			["StrokeColor"] = Color3.new(0.148499, 0.137836, 0.248276),
			["SwitchColor"] = Color3.new(1, 1, 1),
			["Toggle"] = Color3.new(0.835294, 0.054902, 0.248654)
		}
	elseif name == "Skeet" then		
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.114578, 0.125191, 0.151724),
			["BlockBackground"] = Color3.new(0.128181, 0.131124, 0.151724),
			["BlockColor"] = Color3.new(0.0732699, 0.0760008, 0.0896552),
			["DropColor"] = Color3.new(0.0809037, 0.0861197, 0.0965517),
			["HighStrokeColor"] = Color3.new(0.119382, 0.1217, 0.137931),
			["Highlight"] = Color3.new(0, 0.634483, 0.0700119),
			["LineColor"] = Color3.new(0.151724, 0.151724, 0.151724),
			["MouseEnter"] = Color3.new(0.134007, 0.141391, 0.158621),
			["Risky"] = Color3.new(0.984314, 1, 0.152941),
			["StrokeColor"] = Color3.new(0.0769798, 0.0790924, 0.0896552),
			["SwitchColor"] = Color3.new(1, 1, 1),
			["Toggle"] = Color3.new(0, 0.324138, 0.10283)
		}
	end;

	Compkiller:RefreshCurrentColor()
    Compkiller:NotifyThemeChanged()
end;

function Compkiller:RefreshCurrentColor()
	for i,v in next , Compkiller.Elements.Highlight do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.Highlight;
		end;
	end;

	for i,v in next , Compkiller.Elements do
		if v.Element and v.Property and v.Element:GetAttribute('Enabled') then
			v.Element[v.Property] = Compkiller.Colors.Highlight;
		end;
	end;

	for i,v in next , Compkiller.Elements.Risky do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.Risky;
		end;
	end;

	for i,v in next , Compkiller.Elements.BlockColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.BlockColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.BGDBColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.BGDBColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.StrokeColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.StrokeColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.SwitchColor do
		if v.Element and v.Property and v.Element[v.Property] ~= Compkiller.Colors.MouseEnter then
			v.Element[v.Property] = Compkiller.Colors.SwitchColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.BlockBackground do
		if v.Element and v.Property and v.Element[v.Property] then
			v.Element[v.Property] = Compkiller.Colors.BlockBackground;
		end;
	end;

	for i,v in next , Compkiller.Elements.DropColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.DropColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.LineColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.LineColor;
		end;
	end;

	for i,v in next , Compkiller.Elements.HighStrokeColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.HighStrokeColor;
		end;
	end;
	Compkiller:_RefreshPolishColors();
end;

function Compkiller:GetThemeString()
	local t = {}
	for k, v in pairs(Compkiller.Colors) do
		t[k] = {v.R * 255, v.G * 255, v.B * 255}
	end
	return game:GetService("HttpService"):JSONEncode(t)
end

function Compkiller:LoadThemeString(jsonString)
	local s, res = pcall(function() return game:GetService("HttpService"):JSONDecode(jsonString) end)
	if s and type(res) == "table" then
		for k, v in pairs(res) do
			if Compkiller.Colors[k] and type(v) == "table" and #v == 3 then
				Compkiller.Colors[k] = Color3.fromRGB(v[1], v[2], v[3])
			end
		end
		Compkiller:RefreshCurrentColor()
        Compkiller:NotifyThemeChanged()
	end
end

function Compkiller:ChangeHighlightColor(NewColor: Color3)
	local H,S,V = NewColor:ToHSV();

	Compkiller.Colors.Highlight = NewColor;
	Compkiller.Colors.Toggle = Color3.fromHSV(H,S,V - 0.2);

	for i,v in next , Compkiller.Elements.Highlight do
		if v.Element and v.Property then
			v.Element[v.Property] = NewColor;
		end;
	end;

	for i,v in next , Compkiller.Elements do
		if v.Element and v.Property and v.Element:GetAttribute('Enabled') then
			v.Element[v.Property] = NewColor;
		end;
	end;
	Compkiller:_RefreshPolishColors();
end;

function Compkiller.new(Config : Window)

	if not Config.Scale then
		if Compkiller:_IsMobile() then
			Config.Scale = Compkiller.Scale.Mobile;
		else
			Config.Scale = Compkiller.Scale.Window;
		end;
	end;

	Config = Compkiller.__CONFIG(Config , {
		Name = "COMPKILLER",
		Keybind = "Insert",
		Logo = Compkiller.Logo;
		Scale = Compkiller.Scale.Window,
		TextSize = 17
	});

	local TabHover = Compkiller.__SIGNAL(true);
	local WindowOpen = Compkiller.__SIGNAL(true);
	local WindowArgs = {
		SelectedTab = nil,
		Tabs = {},
		LastTab = nil,
		IsOpen = true,
		AlwayShowTab = true,
		THREADS = {},
		PerformanceMode = false,
		Notify = Compkiller.newNotify()
	};

	WindowArgs.Username = LocalPlayer.Name;

	if Compkiller:_IsMobile() then
		WindowArgs.AlwayShowTab = true;
	end;

	Compkiller:_CleanupPreviousWindows();
	Compkiller:_RestoreBrandBindings();

	for _, child in ipairs(CoreGui:GetChildren()) do
		if child:IsA("ScreenGui") and string.find(child.Name, "compkiller") then
			pcall(function() child:Destroy() end)
		end
	end

	local CompKiller = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TabFrame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local LineFrame1 = Instance.new("Frame")
	local CompLogo = Instance.new("ImageLabel")
	local WindowLabel = Instance.new("TextLabel")
	local TabButtons = Instance.new("Frame")
	local SelectionFrame = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local TabButtonScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Userinfo = Instance.new("Frame")
	local UserProfile = Instance.new("ImageLabel")
	local UICorner_4 = Instance.new("UICorner")
	local UserText = Instance.new("TextLabel")
	local ExpireText = Instance.new("TextLabel")
	local TabMainFrame = Instance.new("Frame")

	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        TabButtonScrollingFrame.CanvasSize = UDim2.fromOffset(0,math.ceil(UIListLayout.AbsoluteContentSize.Y / math.max(WindowArgs.ResolutionScale or 1, 0.001)))
	end);

	CompKiller.Name = "u?name=compkiller_"..Compkiller:_RandomString();
	CompKiller.Parent = CoreGui;
	CompKiller.ResetOnSpawn = false
	CompKiller.IgnoreGuiInset = true;
	CompKiller.ZIndexBehavior = Enum.ZIndexBehavior.Global;

	Compkiller.ProtectGui(CompKiller);

	WindowArgs.Root = CompKiller;

	table.insert(Compkiller.Windows , CompKiller);

	MainFrame.Active = true;
	MainFrame.Name = Compkiller:_RandomString()
	MainFrame.Parent = CompKiller
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor

	table.insert(Compkiller.Elements.BGDBColor,{
		Element = MainFrame,
		Property = 'BackgroundColor3'
	});

	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.fromScale(0.5,0.5);
	MainFrame.Size = Config.Scale

	do
		local FitScale = Instance.new("UIScale", MainFrame);
		FitScale.Name = "ViewportFit";
		local function FitViewport()
			local Viewport = CompKiller.AbsoluteSize;
			if Viewport.X <= 0 or Viewport.Y <= 0 then return; end;
			local Width = Viewport.X * Config.Scale.X.Scale + Config.Scale.X.Offset;
			local Height = Viewport.Y * Config.Scale.Y.Scale + Config.Scale.Y.Offset;
			-- Expanded sidebar extends 160 logical pixels left of the main frame.
			-- Keep breathing room instead of filling a small Roblox window edge to edge.
			local Scale = math.min(1, math.max(1, Viewport.X - 24) / math.max(1, Width + 160),
				math.max(1, Viewport.Y - 24) / math.max(1, Height));
			-- Optional user size preference; still never exceeds the visible screen.
			local UserScale = WindowArgs.UserScale or 1;
			if UserScale ~= 1 then
				local Limit = math.min(math.max(1, Viewport.X - 24) / math.max(1, Width + 160),
					math.max(1, Viewport.Y - 24) / math.max(1, Height));
				Scale = math.min(Scale * UserScale, Limit);
			end;
			WindowArgs.ResolutionScale = Scale;
			FitScale.Scale = Scale;
			-- Recenter after rotation/resizing, including the sidebar footprint.
			MainFrame.Position = UDim2.new(0.5, 80 * Scale, 0.5, 0);
		end;
		local Connection = CompKiller:GetPropertyChangedSignal("AbsoluteSize"):Connect(FitViewport);
		CompKiller.Destroying:Connect(function() Connection:Disconnect(); end);
		function WindowArgs:SetUserScale(Value)
			WindowArgs.UserScale = math.clamp(tonumber(Value) or 1, 0.5, 1.5);
			FitViewport();
		end;
		FitViewport();
	end;
	MainFrame.ZIndex = 4

	MainFrame:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
		if MainFrame.BackgroundTransparency > 0.9 then
			MainFrame.Visible = false;
		else
			MainFrame.Visible = true;
		end;
	end)

	Compkiller:_Animation(MainFrame,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
		Size = Config.Scale
	});

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = MainFrame

	local TabFrameBaseTrans = 0.25;

	TabFrame.Active = true
	TabFrame.Name = Compkiller:_RandomString()
	TabFrame.Parent = MainFrame
	TabFrame.AnchorPoint = Vector2.new(1, 0)
	TabFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor

	table.insert(Compkiller.Elements.BGDBColor,{
		Element = TabFrame,
		Property = 'BackgroundColor3'
	});

	TabFrame.BackgroundTransparency = TabFrameBaseTrans
	TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabFrame.BorderSizePixel = 0
	TabFrame.ClipsDescendants = true
	TabFrame.Position = UDim2.new(0, 25, 0, 0)
	TabFrame.Size = UDim2.new(0, 85, 1, 0)

	UICorner_2.CornerRadius = UDim.new(0, 6)
	UICorner_2.Parent = TabFrame

	LineFrame1.Name = Compkiller:_RandomString()
	LineFrame1.Parent = TabFrame
	LineFrame1.AnchorPoint = Vector2.new(1, 0)
	LineFrame1.BackgroundColor3 = Compkiller.Colors.BGDBColor

	table.insert(Compkiller.Elements.BGDBColor,{
		Element = LineFrame1,
		Property = 'BackgroundColor3'
	});

	LineFrame1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame1.BorderSizePixel = 0
	LineFrame1.Position = UDim2.new(1, -5, 0, 0)
	LineFrame1.Size = UDim2.new(0, 20, 1, 0)

	CompLogo.Name = Compkiller:_RandomString()
	CompLogo.Parent = TabFrame
	CompLogo.BackgroundTransparency = 1.000
	CompLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CompLogo.BorderSizePixel = 0
	CompLogo.Position = UDim2.new(0, 9, 0, 7)
	CompLogo.Size = UDim2.new(0, 45, 0, 45)
	CompLogo.Image = Config.Logo
	CompLogo.ImageColor3 = Compkiller.Colors.Highlight
	
	table.insert(Compkiller.Elements.Highlight,{
		Element = CompLogo,
		Property = "ImageColor3"
	});

	WindowLabel.Name = Compkiller:_RandomString()
	WindowLabel.Parent = TabFrame
	WindowLabel.BackgroundTransparency = 1.000
	WindowLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowLabel.BorderSizePixel = 0
	WindowLabel.Position = UDim2.new(0, 60, 0, 13)
	-- The content panel overlaps the sidebar's final 25 logical pixels.
	WindowLabel.Size = UDim2.new(1, -97, 0, 32)
	WindowLabel.Font = Enum.Font.GothamBold
	WindowLabel.Text = Config.TitleText or Config.Name
	WindowLabel.TextColor3 = Compkiller.Colors.SwitchColor
	WindowLabel.TextSize = Config.TextSize
	WindowLabel.TextScaled = true
	WindowLabel.TextWrapped = true
	local TitleSizeConstraint = Instance.new("UITextSizeConstraint")
	TitleSizeConstraint.MinTextSize = 9
	TitleSizeConstraint.MaxTextSize = Config.TextSize
	TitleSizeConstraint.Parent = WindowLabel
	WindowLabel.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = WindowLabel,
		Property = 'TextColor3'
	});

	TabButtons.Name = Compkiller:_RandomString()
	TabButtons.Parent = TabFrame
	TabButtons.BackgroundTransparency = 1.000
	TabButtons.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabButtons.BorderSizePixel = 0
	TabButtons.Position = UDim2.new(0, 0, 0, 60)
	TabButtons.Size = UDim2.new(1, -25, 1, -125)

	SelectionFrame.Name = Compkiller:_RandomString()
	SelectionFrame.Parent = TabButtons
	SelectionFrame.AnchorPoint = Vector2.new(1, 0)
	SelectionFrame.BackgroundColor3 = Compkiller.Colors.Highlight
	SelectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SelectionFrame.BorderSizePixel = 0
	SelectionFrame.Position = UDim2.new(1, 5, 0, 28)
	SelectionFrame.Size = UDim2.new(0, 8, 0, 32)

	table.insert(Compkiller.Elements.Highlight,{
		Element = SelectionFrame,
		Property = "BackgroundColor3"
	});

	UICorner_3.CornerRadius = UDim.new(0, 2)
	UICorner_3.Parent = SelectionFrame

	TabButtonScrollingFrame.Name = Compkiller:_RandomString()
	TabButtonScrollingFrame.Parent = TabButtons
	TabButtonScrollingFrame.Active = true
	TabButtonScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	TabButtonScrollingFrame.BackgroundTransparency = 1.000
	TabButtonScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabButtonScrollingFrame.BorderSizePixel = 0
	TabButtonScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	TabButtonScrollingFrame.Size = UDim2.new(1, -5, 1, -5)
	TabButtonScrollingFrame.BottomImage = ""
    TabButtonScrollingFrame.ScrollBarThickness = 2
    TabButtonScrollingFrame.ScrollBarImageColor3 = Compkiller.Colors.LineColor
    TabButtonScrollingFrame.ScrollBarImageTransparency = 0.45
    table.insert(Compkiller.Elements.LineColor, {
        Element = TabButtonScrollingFrame,
        Property = "ScrollBarImageColor3"
    })
    TabButtonScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabButtonScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    TabButtonScrollingFrame.ClipsDescendants = true
	TabButtonScrollingFrame.TopImage = ""

	UIListLayout.Parent = TabButtonScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)

	Userinfo.Name = Compkiller:_RandomString()
	Userinfo.Parent = TabFrame
	Userinfo.AnchorPoint = Vector2.new(0, 1)
	Userinfo.BackgroundTransparency = 1.000
	Userinfo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Userinfo.BorderSizePixel = 0
	Userinfo.Position = UDim2.new(0, 0, 1, 0)
	Userinfo.Size = UDim2.new(1, -25, 0, 60)

	UserProfile.Name = Compkiller:_RandomString()
	UserProfile.Parent = Userinfo
	UserProfile.BackgroundTransparency = 1.000
	UserProfile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserProfile.BorderSizePixel = 0
	UserProfile.Position = UDim2.new(0, 13, 0, 9)
	UserProfile.Size = UDim2.new(0, 35, 0, 35)
	UserProfile.ZIndex = 2
	UserProfile.Image = "rbxassetid://18518299306"

	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = UserProfile

	UserText.Name = Compkiller:_RandomString()
	UserText.Parent = Userinfo
	UserText.BackgroundTransparency = 1.000
	UserText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserText.BorderSizePixel = 0
	UserText.Position = UDim2.new(0, 55, 0, 8)
	UserText.Size = UDim2.new(0, 200, 0, 20)
	UserText.ZIndex = 2
	UserText.Font = Enum.Font.GothamMedium
	UserText.Text = "Username"
	UserText.TextColor3 = Compkiller.Colors.SwitchColor
	UserText.TextSize = 15
	UserText.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = UserText,
		Property = 'TextColor3'
	});

	ExpireText.Name = Compkiller:_RandomString()
	ExpireText.Parent = Userinfo
	ExpireText.BackgroundTransparency = 1.000
	ExpireText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ExpireText.BorderSizePixel = 0
	ExpireText.Position = UDim2.new(0, 55, 0, 25)
	ExpireText.Size = UDim2.new(0, 200, 0, 20)
	ExpireText.ZIndex = 2
	ExpireText.Font = Enum.Font.GothamMedium
	ExpireText.Text = "0/0/0"
	ExpireText.TextColor3 = Compkiller.Colors.SwitchColor
	ExpireText.TextSize = 15
	ExpireText.TextTransparency = 0.25
	ExpireText.TextXAlignment = Enum.TextXAlignment.Left

	table.insert(Compkiller.Elements.SwitchColor , {
		Element = ExpireText,
		Property = 'TextColor3'
	});

	TabMainFrame.Name = Compkiller:_RandomString()
	TabMainFrame.Parent = MainFrame
	TabMainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	TabMainFrame.BackgroundTransparency = 1.000
	TabMainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabMainFrame.BorderSizePixel = 0
	TabMainFrame.ClipsDescendants = true
	TabMainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	TabMainFrame.Size = UDim2.new(1, 0, 1, 0)
	TabMainFrame.ZIndex = 5

	if Compkiller:_IsMobile() then
		Compkiller:_AddDragBlacklist(TabButtons);
	end;

	WindowOpen:Connect(function(v)
		if WindowArgs.PerformanceMode then
			MainFrame.BackgroundTransparency = (v and 0) or 1;
			return;	
		end;

		if v then
            -- Fade at the native layout size. Resizing this root every animation
            -- frame remeasures every paragraph/section in the window.
            if MainFrame.Size ~= Config.Scale then MainFrame.Size = Config.Scale end

			Compkiller:_Animation(TabButtonScrollingFrame,TweenInfo.new(0.35),{
				Position = UDim2.new(0.5, 0, 0.5, 0)
			})

			Compkiller:_Animation(CompLogo,TweenInfo.new(0.2),{
				ImageTransparency = 0
			})

			Compkiller:_Animation(WindowLabel,TweenInfo.new(0.2),{
				TextTransparency = 0
			})

			Compkiller:_Animation(UserProfile,TweenInfo.new(0.2),{
				ImageTransparency = 0
			})

			Compkiller:_Animation(UserText,TweenInfo.new(0.2),{
				TextTransparency = 0
			})

			Compkiller:_Animation(ExpireText,TweenInfo.new(0.2),{
				TextTransparency = 0.25
			})

			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				BackgroundTransparency = 0
			})

			Compkiller:_Animation(LineFrame1,TweenInfo.new(0.3),{
				BackgroundTransparency = 0,
				Size = UDim2.new(0, 20, 1, 0)
			})

			Compkiller:_Animation(TabFrame,TweenInfo.new(0.2),{
				BackgroundTransparency = TabFrameBaseTrans
			})
		else
            -- Closing uses opacity; keep content widths and scroll layouts stable.

			Compkiller:_Animation(TabButtonScrollingFrame,TweenInfo.new(0.35),{
				Position = UDim2.new(1.5, 100, 0.5, 0)
			})

			Compkiller:_Animation(LineFrame1,TweenInfo.new(0.1),{
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 1, 1, 0)
			})

			Compkiller:_Animation(CompLogo,TweenInfo.new(0.2),{
				ImageTransparency = 1
			})

			Compkiller:_Animation(WindowLabel,TweenInfo.new(0.2),{
				TextTransparency = 1
			})

			Compkiller:_Animation(UserProfile,TweenInfo.new(0.2),{
				ImageTransparency = 1
			})

			Compkiller:_Animation(UserText,TweenInfo.new(0.2),{
				TextTransparency = 1
			})

			Compkiller:_Animation(ExpireText,TweenInfo.new(0.2),{
				TextTransparency = 1
			})

			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				BackgroundTransparency = 1
			})

			Compkiller:_Animation(TabFrame,TweenInfo.new(0.1),{
				BackgroundTransparency = 1
			})
		end;
	end);

	TabHover:Connect(function(value)
		local Style = TweenInfo.new(0.45,Enum.EasingStyle.Quint);

		if value then
			Compkiller:_Animation(TabFrame , Style , {
				Size = UDim2.new(0, 185,1, 0)
			});

			Compkiller:_Animation(WindowLabel , Style , {
				Position = UDim2.new(0, 60,0, 13),
				TextTransparency = 0
			});

			Compkiller:_Animation(UserText , Style , {
				Position = UDim2.new(0, 55,0, 8),
				TextTransparency = 0.1
			});

			Compkiller:_Animation(ExpireText , Style , {
				Position = UDim2.new(0, 55,0, 25),
				TextTransparency = 0.25
			});
		else
			Compkiller:_Animation(TabFrame , Style , {
				Size = UDim2.new(0, 85,1, 0)
			});

			Compkiller:_Animation(WindowLabel , Style , {
				Position = UDim2.new(0, 60 + 25,0, 13),
				TextTransparency = 1
			});

			Compkiller:_Animation(UserText , Style , {
				Position = UDim2.new(0, 55 + 25,0, 8),
				TextTransparency = 1
			});

			Compkiller:_Animation(ExpireText , Style , {
				Position = UDim2.new(0, 55 + 25,0, 25),
				TextTransparency = 1
			});
		end;
	end);

	-- Only the window's polling animations use this cache. Other controls keep
	-- _Animation's existing behavior, including its returned Tween and events.
	local WindowAnimationTargets = {};
	local function AnimateWindowTarget(Element, Duration, Properties)
		local Previous = WindowAnimationTargets[Element];
		local SameTarget = Previous and Previous.Duration == Duration;

		if SameTarget then
			for Property, Value in pairs(Properties) do
				if Previous.Properties[Property] ~= Value then
					SameTarget = false;
					break;
				end;
			end;
			for Property in pairs(Previous.Properties) do
				if Properties[Property] == nil then
					SameTarget = false;
					break;
				end;
			end;
		end;

		if SameTarget then
			if Previous.Tween.PlaybackState == Enum.PlaybackState.Playing then
				return;
			end;
			local AtTarget = true;
			for Property, Value in pairs(Properties) do
				if Element[Property] ~= Value then
					AtTarget = false;
					break;
				end;
			end;
			if AtTarget then
				return;
			end;
		end;

		WindowAnimationTargets[Element] = {
			Duration = Duration,
			Properties = Properties,
			Tween = Compkiller:_Animation(Element, TweenInfo.new(Duration), Properties)
		};
	end;

	function WindowArgs:DrawCategory(config : Category)
		config = config or {};
		config.Name = config.Name or "Category";

		local Category = Instance.new("Frame")
		local CategoryText = Instance.new("TextLabel")
		local Frame = Instance.new("Frame")
		local UIGradient = Instance.new("UIGradient")

		Category.Name = Compkiller:_RandomString()
		Category.Parent = TabButtonScrollingFrame
		Category.BackgroundTransparency = 1.000
		Category.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Category.BorderSizePixel = 0
		Category.ClipsDescendants = true
		Category.Size = UDim2.new(1, -10, 0, 30)

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(Category);
		end;

		CategoryText.Name = Compkiller:_RandomString()
		CategoryText.Parent = Category
		CategoryText.BackgroundTransparency = 1.000
		CategoryText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CategoryText.BorderSizePixel = 0
		CategoryText.Position = UDim2.new(0, 8, 0, 3)
		CategoryText.Size = UDim2.new(1, -16, 0, 22)
		CategoryText.Font = Enum.Font.GothamBold
		CategoryText.Text = config.Name
		CategoryText.TextColor3 = Compkiller.Colors.SwitchColor
		CategoryText.TextSize = 14
		CategoryText.TextTransparency = 0.05
		CategoryText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = CategoryText,
			Property = 'TextColor3'
		});

		Frame.Parent = Category
		Frame.AnchorPoint = Vector2.new(0.5, 1)
		Frame.BackgroundColor3 = Compkiller.Colors.Highlight
		Frame.BackgroundTransparency = 0.750
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 1, 0)
		Frame.Size = UDim2.new(1, 0, 0, 1)

		table.insert(Compkiller.Elements.Highlight,{
			Element = Frame,
			Property = "BackgroundColor3"
		});

		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.05, 0.21), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.96, 0.17), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = Frame

		local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

		TabHover:Connect(function(bool)
			if bool then
				Compkiller:_Animation(CategoryText,Tween,{
					TextTransparency = 0.05
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 0.750
				});
			else
				Compkiller:_Animation(CategoryText,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1
				});
			end;
		end);
	end;

	function WindowArgs:DrawContainerTab(TabConfig : ContainerTab)
		TabConfig = Compkiller.__CONFIG(TabConfig,{
			Name = "Tab",
			Icon = "eye",
		});

		local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);
		local TabOpenSignal = Compkiller.__SIGNAL(false);

		local TabArgs = {
			__Current = nil,
			Tabs = {}
		};

		-- Creating Button --

		local TabButton = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")
		local TabNameLabel = Instance.new("TextLabel")
		local Highlight = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")

		TabButton.Name = Compkiller:_RandomString()
		TabButton.Parent = TabButtonScrollingFrame
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.ClipsDescendants = true
		TabButton.Size = UDim2.new(1, -10, 0, 32)
		TabButton.ZIndex = 3

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(TabButton);
		end;

		Icon.Name = Compkiller:_RandomString()
		Icon.Parent = TabButton
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Compkiller.Colors.Highlight
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 15, 0.5, 0)
		Icon.Size = UDim2.new(0, 22, 0, 22)
		Icon.ZIndex = 3
		Compkiller:_SetIcon(Icon, TabConfig.Icon);
		Icon.ImageColor3 = Compkiller.Colors.Highlight

		table.insert(Compkiller.Elements.Highlight,{
			Element = Icon,
			Property = "ImageColor3"
		});

		TabNameLabel.Name = Compkiller:_RandomString()
		TabNameLabel.Parent = TabButton
		TabNameLabel.AnchorPoint = Vector2.new(0, 0.5)
		TabNameLabel.BackgroundTransparency = 1.000
		TabNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabNameLabel.BorderSizePixel = 0
		TabNameLabel.Position = UDim2.new(0, 43, 0.5, 0)
		TabNameLabel.Size = UDim2.new(0, 200, 0, 25)
		TabNameLabel.ZIndex = 3
		TabNameLabel.Font = Enum.Font.GothamMedium
		TabNameLabel.Text = TabConfig.Name;
		TabNameLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TabNameLabel.TextSize = 16
		TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left
		TabNameLabel.TextScaled = true

		local TabNameLabelConstraint = Instance.new("UITextSizeConstraint")
		TabNameLabelConstraint.MaxTextSize = 16
		TabNameLabelConstraint.Parent = TabNameLabel

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TabNameLabel,
			Property = 'TextColor3'
		});

		Highlight.Name = Compkiller:_RandomString()
		Highlight.Parent = TabButton
		Highlight.AnchorPoint = Vector2.new(0.5, 0.5)
		Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
		Highlight.BackgroundTransparency = 0.925
		Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Highlight.BorderSizePixel = 0
		Highlight.Position = UDim2.new(0.5, 0, 0.5, 0)
		Highlight.Size = UDim2.new(1, -17, 1, 0)
		Highlight.ZIndex = 2

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Highlight

		-- Creating Container --

		local ContainerTab = Instance.new("Frame")
		local MainFrame = Instance.new("Frame")
		local Top = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")

		ContainerTab.Name = Compkiller:_RandomString()
		ContainerTab.Parent = TabMainFrame
		ContainerTab.AnchorPoint = Vector2.new(0.5, 0.5)
		ContainerTab.BackgroundTransparency = 1.000
		ContainerTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContainerTab.BorderSizePixel = 0
		ContainerTab.Position = UDim2.new(0.5, 0, 0.5, 0)
		ContainerTab.Size = UDim2.new(1, -15, 1, -15)
		ContainerTab.ZIndex = 6

		MainFrame.Name = Compkiller:_RandomString()
		MainFrame.Parent = ContainerTab
		MainFrame.AnchorPoint = Vector2.new(0.5, 1)
		MainFrame.BackgroundTransparency = 1.000
		MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainFrame.BorderSizePixel = 0
		MainFrame.Position = UDim2.new(0.5, 0, 1, -5)
		MainFrame.Size = UDim2.new(1, 0, 1, -35)
		MainFrame.ZIndex = 6
		MainFrame.ClipsDescendants = true

		Top.Name = Compkiller:_RandomString()
		Top.Parent = ContainerTab
		Top.BackgroundTransparency = 1.000
		Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Top.BorderSizePixel = 0
		Top.Size = UDim2.new(1, 0, 0, 25)
		Top.ZIndex = 7

		UIListLayout.Parent = Top
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 10)

		local ProgressLabel = Instance.new("TextLabel")
		ProgressLabel.Name = Compkiller:_RandomString()
		ProgressLabel.Parent = ContainerTab
		ProgressLabel.AnchorPoint = Vector2.new(1, 0)
		ProgressLabel.Position = UDim2.new(1, -20, 0, 0)
		ProgressLabel.Size = UDim2.new(0, 200, 0, 25)
		ProgressLabel.BackgroundTransparency = 1
		ProgressLabel.Font = Enum.Font.GothamMedium
		ProgressLabel.Text = ""
		ProgressLabel.TextColor3 = Compkiller.Colors.Highlight
		ProgressLabel.TextSize = 14
		ProgressLabel.TextXAlignment = Enum.TextXAlignment.Right
		ProgressLabel.ZIndex = 15

		table.insert(Compkiller.Elements.Highlight, {
			Element = ProgressLabel,
			Property = 'TextColor3'
		});
		
        -- Keep status below the child tabs instead of painting over their labels.
        local function layoutProgress()
            local visible = ProgressLabel.Text ~= ""
            ProgressLabel.Visible = visible
            ProgressLabel.Position = UDim2.new(0,12,0,30)
            ProgressLabel.Size = UDim2.new(1,-24,0,25)
            MainFrame.Size = UDim2.new(1,0,1,visible and -65 or -35)
        end
        ProgressLabel:GetPropertyChangedSignal("Text"):Connect(layoutProgress)
        layoutProgress()
		TabArgs.ProgressLabel = ProgressLabel
        function TabArgs:SetProgress(text, completed, total)
            if TabArgs.ProgressLabel then
                if not text or text == "" then
                    TabArgs.ProgressETA = nil
                    TabArgs.ProgressLabel.Text = text or ""
                else
                    TabArgs.ProgressETA = TabArgs.ProgressETA or Compkiller.ProgressETA.New()
                    TabArgs.ProgressLabel.Text = Compkiller.ProgressETA.Update(TabArgs.ProgressETA, text, nil, completed, total)
                end
            end
        end

		-- Functions --


		local TabOpen = function(bool)
			ContainerTab.Visible = bool
			if bool then
				WindowArgs.SelectedTab = TabButton;

				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0,
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 0.925
				});

				for i,v in next , TabArgs.Tabs do
					if v.Root == TabArgs.__Current.Root then
						v.Remote:Fire(true);
					end;
				end;
			else
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.25
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 1
				});

				for i,v in next , TabArgs.Tabs do
					v.Remote:Fire(false);
				end;
			end;
		end;

		if not WindowArgs.Tabs[1] then
			TabOpenSignal:Fire(true);
			TabOpen(true);
		else
			TabOpen(false);
		end;

		table.insert(WindowArgs.Tabs , {
			Root = TabButton,
			Remote = TabOpenSignal
		});

		Compkiller:_Hover(TabButton,function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.1
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.1
				});
			end;
		end , function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.25
				});
			end;
		end)

		TabOpenSignal:Connect(TabOpen);

		TabHover:Connect(function(bool)
			if bool then
				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Position = UDim2.new(0, 15, 0.5, 0),
					Size = UDim2.new(0, 22, 0, 22),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(1, -50, 0, 25),
					Position = UDim2.new(0, 43, 0.5, 0)
				});

				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 4)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -17, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			else
				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 10)
				});

				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Position = UDim2.new(0, 12, 0.5, 0),
					Size = UDim2.new(0, 20, 0, 20),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 80, 0.5, 0)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -10,1, 5),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			end;
		end);

		Compkiller:_Input(TabButton,function()
			for i,v in next, WindowArgs.Tabs do
				if v.Root == TabButton then
					v.Remote:Fire(true);
				else
					v.Remote:Fire(false);
				end;
			end;
		end);

		function TabArgs:DrawTab(TabConfig : TabConfig) -- Internal Tab
			TabConfig = Compkiller.__CONFIG(TabConfig,{
				Name = "Tab",
				Type = "Double",
				EnableScrolling = false,
			});

			local InternalSignal = Compkiller.__SIGNAL(false);
			local Frame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local Highlight = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")

			Frame.Parent = Top
			Frame.BackgroundColor3 = Compkiller.Colors.BlockColor

			table.insert(Compkiller.Elements.BlockColor , {
				Element = Frame,
				Property = "BackgroundColor3"
			});

			Frame.BackgroundTransparency = 1.000
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.ClipsDescendants = true
			Frame.Size = UDim2.new(0, 75, 0, 26)
			Frame.ZIndex = 10

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Frame

			UIStroke.Transparency = 1.000
			UIStroke.Color = Compkiller.Colors.StrokeColor
			UIStroke.Parent = Frame

			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke,
				Property = "Color"
			});

			Highlight.Name = Compkiller:_RandomString()
			Highlight.Parent = Frame
			Highlight.AnchorPoint = Vector2.new(1, 0.5)
			Highlight.BackgroundColor3 = Compkiller.Colors.Highlight
			Highlight.BackgroundTransparency = 1.000
			Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Highlight.BorderSizePixel = 0
			Highlight.Position = UDim2.new(0, 3, 0.5, 0)
			Highlight.Size = UDim2.new(0, 5, 0, 10)
			Highlight.ZIndex = 11

			table.insert(Compkiller.Elements.Highlight,{
				Element = Highlight,
				Property = "BackgroundColor3"
			});

			UICorner_2.CornerRadius = UDim.new(1, 0)
			UICorner_2.Parent = Highlight

			TextLabel.Parent = Frame
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0, 10, 0.5, 0)
			TextLabel.Size = UDim2.new(0, 200, 0, 20)
			TextLabel.ZIndex = 12
			TextLabel.Font = Enum.Font.GothamMedium
			TextLabel.Text = TabConfig.Name
			TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
			TextLabel.TextSize = 15
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TextLabel,
				Property = 'TextColor3'
			});

			if TabConfig.Icon then Compkiller:_ControlIcon(TextLabel, TabConfig.Icon); end;

			local UpdateScale = function()
				local scale = TextService:GetTextSize(TextLabel.Text,TextLabel.TextSize,TextLabel.Font,Vector2.new(math.huge,math.huge));

				Frame.Size = UDim2.new(0, scale.X + (TabConfig.Icon and 45 or 19), 0, 26)
			end;

			UpdateScale()

			local ToggleUI = function(bool)

				UpdateScale();

				if bool then

					Compkiller:_Animation(Highlight,TweenInfo.new(0.2),{
						BackgroundTransparency = 0,
						Size = UDim2.new(0, 5, 0, 10)
					})

					Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
						BackgroundTransparency = 0
					})

					Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
						Transparency = 0
					})

					Compkiller:_Animation(TextLabel,TweenInfo.new(0.2),{
						TextTransparency = 0
					})
				else

					Compkiller:_Animation(Highlight,TweenInfo.new(0.2),{
						BackgroundTransparency = 1,
						Size = UDim2.new(0, 5, 0, 2)
					})

					Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
						BackgroundTransparency = 1
					})

					Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
						Transparency = 1
					})

					Compkiller:_Animation(TextLabel,TweenInfo.new(0.2),{
						TextTransparency = 0.25
					})
				end;
			end;


			local Id = {
				Root = Frame,
				Remote = InternalSignal
			};

			InternalSignal:Connect(ToggleUI)


			if not TabArgs.Tabs[1] then
				TabArgs.__Current = Id;

				InternalSignal:Fire(true)
			end;

			table.insert(TabArgs.Tabs,Id)

			Compkiller:_Input(Frame,function()
				for i,v in next , TabArgs.Tabs do
					if v.Root == Frame then
						TabArgs.__Current = v;

						v.Remote:Fire(true);
					else
						v.Remote:Fire(false);
					end;
				end;
			end);

			return WindowArgs:DrawTab(TabConfig , {
				ID = Id,
				Highlight = Highlight,
				Signal = InternalSignal,
				Parent = MainFrame
			});
		end;

		return TabArgs;
	end;

	function WindowArgs:AddDragBlacklist(Frame)
		Compkiller:_AddDragBlacklist(Frame)
	end;

	function WindowArgs:AddUnbind(ListLayout: UIListLayout, Scrolling)
        -- Content drives the scroll range; no polling or viewport-height cap.
        Scrolling.Active = true
        Scrolling.ScrollingEnabled = true
        Scrolling.ScrollingDirection = Enum.ScrollingDirection.Y
        Scrolling.AutomaticCanvasSize = Enum.AutomaticSize.None
        Scrolling.ClipsDescendants = true
        Scrolling.ScrollBarThickness = 2
        Scrolling.ScrollBarImageColor3 = Compkiller.Colors.LineColor
        Scrolling.ScrollBarImageTransparency = 0.45
        table.insert(Compkiller.Elements.LineColor, {
            Element = Scrolling,
            Property = "ScrollBarImageColor3"
        })
        Scrolling.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        ListLayout.VerticalFlex = Enum.UIFlexAlignment.None

        local function update()
            if not Scrolling.Parent then return end
            local scale = math.max(WindowArgs.ResolutionScale or 1, 0.001)
            Scrolling.CanvasSize = UDim2.fromOffset(0, math.ceil(ListLayout.AbsoluteContentSize.Y / scale) + 16)
        end
        local contentConnection = ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update)
        local sizeConnection = Scrolling:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
        Scrolling.Destroying:Connect(function()
            contentConnection:Disconnect()
            sizeConnection:Disconnect()
        end)
        task.defer(update)
    end;

	function WindowArgs:DrawConfig(Configuration : TabConfigManager , Internal)
		Configuration = Compkiller.__CONFIG(Configuration,{
			Name = "Config",
			Icon = "folder",
			Config = nil
		});

		local TabOpenSignal = Compkiller.__SIGNAL(false);
		local TabArgs = {};

		-- Button --
		local TabButton = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")
		local TabNameLabel = Instance.new("TextLabel")
		local Highlight = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(TabButton);
		end;

		TabButton.Name = Compkiller:_RandomString()
		TabButton.Parent = TabButtonScrollingFrame
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.ClipsDescendants = true
		TabButton.Size = UDim2.new(1, -10, 0, 32)
		TabButton.ZIndex = 3

		Icon.Name = Compkiller:_RandomString()
		Icon.Parent = TabButton
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Compkiller.Colors.Highlight
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 15, 0.5, 0)
		Icon.Size = UDim2.new(0, 22, 0, 22)
		Icon.ZIndex = 3
		Compkiller:_SetIcon(Icon,Configuration.Icon);
		Icon.ImageColor3 = Compkiller.Colors.Highlight

		table.insert(Compkiller.Elements.Highlight,{
			Element = Icon,
			Property = "ImageColor3"
		});

		TabNameLabel.Name = Compkiller:_RandomString()
		TabNameLabel.Parent = TabButton
		TabNameLabel.AnchorPoint = Vector2.new(0, 0.5)
		TabNameLabel.BackgroundTransparency = 1.000
		TabNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabNameLabel.BorderSizePixel = 0
		TabNameLabel.Position = UDim2.new(0, 43, 0.5, 0)
		TabNameLabel.Size = UDim2.new(0, 200, 0, 25)
		TabNameLabel.ZIndex = 3
		TabNameLabel.Font = Enum.Font.GothamMedium
		TabNameLabel.Text = Configuration.Name;
		TabNameLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TabNameLabel.TextSize = 15.000
		TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TabNameLabel,
			Property = 'TextColor3'
		});

		Highlight.Name = Compkiller:_RandomString()
		Highlight.Parent = TabButton
		Highlight.AnchorPoint = Vector2.new(0.5, 0.5)
		Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
		Highlight.BackgroundTransparency = 0.925
		Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Highlight.BorderSizePixel = 0
		Highlight.Position = UDim2.new(0.5, 0, 0.5, 0)
		Highlight.Size = UDim2.new(1, -17, 1, 0)
		Highlight.ZIndex = 2

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Highlight

		local TabConfig = Instance.new("Frame")
		local ConfigList = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Header = Instance.new("Frame")
		local SectionText = Instance.new("TextLabel")
		local SectionClose = Instance.new("ImageLabel")
		local ScrollingFrame = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local Space = Instance.new("Frame")
		local AddConfig = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local Header_2 = Instance.new("Frame")
		local SectionText_2 = Instance.new("TextLabel")
		local SectionClose_2 = Instance.new("ImageLabel")
		local Frame = Instance.new("Frame")
		local UIStroke_3 = Instance.new("UIStroke")
		local UICorner_3 = Instance.new("UICorner")
		local TextBox = Instance.new("TextBox")
		local Button = Instance.new("Frame")
		local BlockLine = Instance.new("Frame")
		local Frame_2 = Instance.new("Frame")
		local UIStroke_4 = Instance.new("UIStroke")
		local UICorner_4 = Instance.new("UICorner")
		local TextLabel = Instance.new("TextLabel")

		TabConfig.Name = Compkiller:_RandomString()
		TabConfig.Parent = TabMainFrame
		TabConfig.AnchorPoint = Vector2.new(0.5, 0.5)
		TabConfig.BackgroundTransparency = 1.000
		TabConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabConfig.BorderSizePixel = 0
		TabConfig.Position = UDim2.new(0.5, 0, 0.5, 0)
		TabConfig.Size = UDim2.new(1, 0, 1, 0)
		TabConfig.ZIndex = 6

		ConfigList.Name = Compkiller:_RandomString()
		ConfigList.Parent = TabConfig
		ConfigList.AnchorPoint = Vector2.new(0.5, 0)
		ConfigList.BackgroundColor3 = Compkiller.Colors.BlockColor

		table.insert(Compkiller.Elements.BlockColor , {
			Element = ConfigList,
			Property = "BackgroundColor3"
		});

		ConfigList.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ConfigList.BorderSizePixel = 0
		ConfigList.Position = UDim2.new(0.5, 0, 0, 5)
		ConfigList.Size = UDim2.new(1, -10, 1, -110)
		ConfigList.ZIndex = 9

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = ConfigList

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = ConfigList

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		Header.Name = Compkiller:_RandomString()
		Header.Parent = ConfigList
		Header.BackgroundTransparency = 1.000
		Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Header.BorderSizePixel = 0
		Header.Size = UDim2.new(1, 0, 0, 35)
		Header.ZIndex = 9

		SectionText.Name = Compkiller:_RandomString()
		SectionText.Parent = Header
		SectionText.AnchorPoint = Vector2.new(0, 0.5)
		SectionText.BackgroundTransparency = 1.000
		SectionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionText.BorderSizePixel = 0
		SectionText.Position = UDim2.new(0, 12, 0.5, 0)
		SectionText.Size = UDim2.new(0, 200, 0, 25)
		SectionText.ZIndex = 10
		SectionText.Font = Enum.Font.GothamMedium
		SectionText.Text = "Config List"
		SectionText.TextColor3 = Compkiller.Colors.SwitchColor
		SectionText.TextSize = 14.000
		SectionText.TextTransparency = 0.500
		SectionText.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = SectionText,
			Property = 'TextColor3'
		});

		SectionClose.Name = Compkiller:_RandomString()
		SectionClose.Parent = Header
		SectionClose.AnchorPoint = Vector2.new(1, 0.5)
		SectionClose.BackgroundTransparency = 1.000
		SectionClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionClose.BorderSizePixel = 0
		SectionClose.Position = UDim2.new(1, -12, 0.5, 0)
		SectionClose.Size = UDim2.new(0, 17, 0, 17)
		SectionClose.ZIndex = 10
		Compkiller:_SetIcon(SectionClose,"chevron-down")
		SectionClose.ImageTransparency = 0.500

		ScrollingFrame.Parent = ConfigList
		ScrollingFrame.Active = true
		ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
		ScrollingFrame.BackgroundTransparency = 1.000
		ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScrollingFrame.BorderSizePixel = 0
		ScrollingFrame.Position = UDim2.new(0.5, 0, 0, 35)
		ScrollingFrame.Size = UDim2.new(1, -10, 1, -45)
		ScrollingFrame.ZIndex = 12
		ScrollingFrame.ScrollBarThickness = 0

		UIListLayout.Parent = ScrollingFrame
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 7)

		Space.Name = Compkiller:_RandomString()
		Space.Parent = ScrollingFrame
		Space.BackgroundTransparency = 1.000
		Space.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Space.BorderSizePixel = 0

		AddConfig.Name = Compkiller:_RandomString()
		AddConfig.Parent = TabConfig
		AddConfig.AnchorPoint = Vector2.new(0.5, 1)
		AddConfig.BackgroundColor3 = Compkiller.Colors.BlockColor

		table.insert(Compkiller.Elements.BlockColor , {
			Element = AddConfig,
			Property = "BackgroundColor3"
		});

		AddConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		AddConfig.BorderSizePixel = 0
		AddConfig.Position = UDim2.new(0.5, 0, 1, -5)
		AddConfig.Size = UDim2.new(1, -10, 0, 95)
		AddConfig.ZIndex = 9

		UICorner_2.CornerRadius = UDim.new(0, 6)
		UICorner_2.Parent = AddConfig

		UIStroke_2.Color = Compkiller.Colors.StrokeColor
		UIStroke_2.Parent = AddConfig

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke_2,
			Property = "Color"
		});

		Header_2.Name = Compkiller:_RandomString()
		Header_2.Parent = AddConfig
		Header_2.BackgroundTransparency = 1.000
		Header_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Header_2.BorderSizePixel = 0
		Header_2.Size = UDim2.new(1, 0, 0, 35)
		Header_2.ZIndex = 9

		SectionText_2.Name = Compkiller:_RandomString()
		SectionText_2.Parent = Header_2
		SectionText_2.AnchorPoint = Vector2.new(0, 0.5)
		SectionText_2.BackgroundTransparency = 1.000
		SectionText_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionText_2.BorderSizePixel = 0
		SectionText_2.Position = UDim2.new(0, 12, 0.5, 0)
		SectionText_2.Size = UDim2.new(0, 200, 0, 25)
		SectionText_2.ZIndex = 10
		SectionText_2.Font = Enum.Font.GothamMedium
		SectionText_2.Text = "Add Config"
		SectionText_2.TextColor3 = Compkiller.Colors.SwitchColor
		SectionText_2.TextSize = 14.000
		SectionText_2.TextTransparency = 0.500
		SectionText_2.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = SectionText_2,
			Property = 'TextColor3'
		});

		SectionClose_2.Name = Compkiller:_RandomString()
		SectionClose_2.Parent = Header_2
		SectionClose_2.AnchorPoint = Vector2.new(1, 0.5)
		SectionClose_2.BackgroundTransparency = 1.000
		SectionClose_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionClose_2.BorderSizePixel = 0
		SectionClose_2.Position = UDim2.new(1, -12, 0.5, 0)
		SectionClose_2.Size = UDim2.new(0, 17, 0, 17)
		SectionClose_2.ZIndex = 10
		Compkiller:_SetIcon(SectionClose_2,"chevron-down")
		SectionClose_2.ImageTransparency = 0.500

		Frame.Parent = AddConfig
		Frame.AnchorPoint = Vector2.new(0.5, 0)
		Frame.BackgroundColor3 = Compkiller.Colors.BlockColor

		table.insert(Compkiller.Elements.BlockColor , {
			Element = Frame,
			Property = "BackgroundColor3"
		});

		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 0, 35)
		Frame.Size = UDim2.new(1, -20, 0, 20)
		Frame.ZIndex = 15

		UIStroke_3.Color = Compkiller.Colors.StrokeColor
		UIStroke_3.Parent = Frame

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke_3,
			Property = "Color"
		});

		UICorner_3.CornerRadius = UDim.new(0, 4)
		UICorner_3.Parent = Frame

		TextBox.Parent = Frame
		TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextBox.Size = UDim2.new(1, -15, 1, -2)
		TextBox.ZIndex = 15
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		Compkiller:_BindPolishColor(TextBox, "PlaceholderColor3", "Placeholder");
		TextBox.PlaceholderText = "Config Name..."
		TextBox.Text = ""
		TextBox.TextColor3 = Compkiller.Colors.SwitchColor
		TextBox.TextSize = 12.000
		TextBox.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextBox,
			Property = 'TextColor3'
		});

		Button.Name = Compkiller:_RandomString()
		Button.Parent = AddConfig
		Button.AnchorPoint = Vector2.new(0.5, 1)
		Button.BackgroundColor3 = Compkiller.Colors.SwitchColor
		Button.BackgroundTransparency = 1.000
		Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(0.5, 0, 1, -10)
		Button.Size = UDim2.new(1, -7, 0, 25)
		Button.ZIndex = 10

		BlockLine.Name = Compkiller:_RandomString()
		BlockLine.Parent = AddConfig
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 0.5, 12)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = 12

		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		Frame_2.Parent = Button
		Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame_2.BackgroundColor3 = Compkiller.Colors.Highlight
		Frame_2.BackgroundTransparency = 0.100
		Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame_2.BorderSizePixel = 0
		Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Frame_2.Size = UDim2.new(1, -15, 1, -5)
		Frame_2.ZIndex = 9

		table.insert(Compkiller.Elements.Highlight,{
			Element = Frame_2,
			Property = "BackgroundColor3"
		});

		UIStroke_4.Color = Compkiller.Colors.StrokeColor
		UIStroke_4.Parent = Frame_2

		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke_4,
			Property = "Color"
		});

		UICorner_4.CornerRadius = UDim.new(0, 3)
		UICorner_4.Parent = Frame_2

		TextLabel.Parent = Frame_2
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.ZIndex = 10
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = "Add Config"
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 12.000
		TextLabel.TextStrokeTransparency = 0.900

		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextLabel,
			Property = 'TextColor3'
		});

		local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

		local TabOpen = function(bool)
			TabConfig.Visible = bool
			if bool then

				WindowArgs.SelectedTab = TabButton;

				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0,
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 0.925
				});

				--

				Compkiller:_Animation(ConfigList,Tween,{
					BackgroundTransparency = 0,
				});

				Compkiller:_Animation(AddConfig,Tween,{
					BackgroundTransparency = 0,
				});

				Compkiller:_Animation(UIStroke_4,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(UIStroke_3,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(UIStroke_2,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(SectionText,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(TextLabel,Tween,{
					TextTransparency = 0,
					TextStrokeTransparency = 0.9
				});

				Compkiller:_Animation(Frame_2,Tween,{
					BackgroundTransparency = 0.1,
				});

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 0.5,
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 0,
				});

				Compkiller:_Animation(SectionText_2,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(TextBox,Tween,{
					TextTransparency = 0
				});

				Compkiller:_Animation(SectionClose,Tween,{
					ImageTransparency = 0.5,
				});

				Compkiller:_Animation(SectionClose_2,Tween,{
					ImageTransparency = 0.5,
				});
			else

				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(ConfigList,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(AddConfig,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(UIStroke_4,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(UIStroke_3,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(UIStroke_2,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(SectionText,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(TextLabel,Tween,{
					TextTransparency = 1,
					TextStrokeTransparency = 1
				});

				Compkiller:_Animation(Frame_2,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(SectionText_2,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(TextBox,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(SectionClose,Tween,{
					ImageTransparency = 1,
				});

				Compkiller:_Animation(SectionClose_2,Tween,{
					ImageTransparency = 1,
				});
			end;
		end;

		if not WindowArgs.Tabs[1] then
			TabOpenSignal:Fire(true);
			TabOpen(true);
		else
			TabOpen(false);
		end;

		table.insert(WindowArgs.Tabs , {
			Root = TabButton,
			Remote = TabOpenSignal
		});

		Compkiller:_Hover(TabButton,function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.1
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.1
				});
			end;
		end , function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});
			end;
		end)

		TabOpenSignal:Connect(TabOpen);

		TabHover:Connect(function(bool)
			if bool then
				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Position = UDim2.new(0, 15, 0.5, 0),
					Size = UDim2.new(0, 22, 0, 22),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 43, 0.5, 0)
				});

				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 4)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -17, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			else
				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 10)
				});

				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Position = UDim2.new(0, 12, 0.5, 0),
					Size = UDim2.new(0, 20, 0, 20),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 80, 0.5, 0)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -10,1, 5),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			end;
		end);

		Compkiller:_Input(TabButton,function()
			for i,v in next, WindowArgs.Tabs do
				if v.Root == TabButton then
					v.Remote:Fire(true);
				else
					v.Remote:Fire(false);
				end;
			end;
		end);

		function TabArgs:_DrawConfig()
			local ConfigButton = {};

			local ConfigBlock = Instance.new("Frame")
			local ConfigText = Instance.new("TextLabel")
			local LinkValues = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local SaveButton = Instance.new("Frame")
			local Frame = Instance.new("Frame")
			local UIStroke = Instance.new("UIStroke")
			local UICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local Icon = Instance.new("ImageLabel")
			local LoadButton = Instance.new("Frame")
			local Frame_2 = Instance.new("Frame")
			local UIStroke_2 = Instance.new("UIStroke")
			local UICorner_2 = Instance.new("UICorner")
			local TextLabel_2 = Instance.new("TextLabel")
			local Icon_2 = Instance.new("ImageLabel")
			local UIStroke_3 = Instance.new("UIStroke")
			local UICorner_3 = Instance.new("UICorner")
			local AuthorText = Instance.new("TextLabel")
			local DelButton = Instance.new("ImageButton")
			local UICorner = Instance.new("UICorner")
			local UIGradient = Instance.new("UIGradient")

			DelButton.Name = Compkiller:_RandomString()
			DelButton.Parent = LinkValues
			DelButton.BackgroundTransparency = 1.000
			DelButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DelButton.BorderSizePixel = 0
			DelButton.LayoutOrder = -9999
			DelButton.Size = UDim2.new(0, 35, 0, 15)
			DelButton.ZIndex = 14
			Compkiller:_SetIcon(DelButton,"trash-2")
			DelButton.ImageColor3 = Color3.fromRGB(255, 107, 107)
			DelButton.ImageTransparency = 0.500
			DelButton.ScaleType = Enum.ScaleType.Fit

			UICorner.CornerRadius = UDim.new(1, 0)
			UICorner.Parent = DelButton
			ConfigBlock.Name = Compkiller:_RandomString()
			ConfigBlock.Parent = ScrollingFrame
			Compkiller:_BindPolishColor(ConfigBlock, "BackgroundColor3", "DropColor");
			ConfigBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ConfigBlock.BorderSizePixel = 0
			ConfigBlock.BackgroundTransparency = 1
			ConfigBlock.Size = UDim2.new(1, -1, 0, 70)
			ConfigBlock.ZIndex = 10

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(ConfigBlock);
			end;

			ConfigText.Name = Compkiller:_RandomString()
			ConfigText.Parent = ConfigBlock
			ConfigText.AnchorPoint = Vector2.new(0, 0.5)
			ConfigText.BackgroundTransparency = 1.000
			ConfigText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ConfigText.BorderSizePixel = 0
			ConfigText.Position = UDim2.new(0, 12, 0.5, 15)
			ConfigText.Size = UDim2.new(1, -20, 0, 25)
			ConfigText.ZIndex = 10
			ConfigText.Font = Enum.Font.GothamMedium
			ConfigText.RichText = true;
			ConfigText.Text = "Config"
			ConfigText.TextColor3 = Compkiller.Colors.SwitchColor
			ConfigText.TextSize = 13.000
			ConfigText.TextTransparency = 1
			ConfigText.TextXAlignment = Enum.TextXAlignment.Left

			Compkiller:_BindColor(Compkiller.Elements.SwitchColor , {
				Element = ConfigText,
				Property = 'TextColor3'
			});

			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.29, 0.00), NumberSequenceKeypoint.new(0.33, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = ConfigText

			LinkValues.Name = Compkiller:_RandomString()
			LinkValues.Parent = ConfigBlock
			LinkValues.AnchorPoint = Vector2.new(1, 0.540000021)
			LinkValues.BackgroundTransparency = 1.000
			LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LinkValues.BorderSizePixel = 0
			LinkValues.Position = UDim2.new(1, -12, 0.5, 15)
			LinkValues.Size = UDim2.new(1, 0, 0, 18)
			LinkValues.ZIndex = 11

			UIListLayout.Parent = LinkValues
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			UIListLayout.Padding = UDim.new(0, -10)

			SaveButton.Name = Compkiller:_RandomString()
			SaveButton.Parent = LinkValues
			SaveButton.BackgroundTransparency = 1.000
			SaveButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SaveButton.BorderSizePixel = 0
			SaveButton.Size = UDim2.new(0, 77, 0, 30)
			SaveButton.ZIndex = 14

			Frame.Parent = SaveButton
			Frame.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame.BackgroundColor3 = Compkiller.Colors.Highlight
			Frame.BackgroundTransparency = 1
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame.Size = UDim2.new(1, -15, 1, -5)
			Frame.ZIndex = 14

			Compkiller:_BindColor(Compkiller.Elements.Highlight,{
				Element = Frame,
				Property = "BackgroundColor3"
			});

			UIStroke.Transparency = 1
			UIStroke.Color = Compkiller.Colors.StrokeColor
			UIStroke.Parent = Frame

			Compkiller:_BindColor(Compkiller.Elements.StrokeColor,{
				Element = UIStroke,
				Property = "Color"
			});

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Frame

			TextLabel.Parent = Frame
			TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0.5, 27, 0.5, 0)
			TextLabel.Size = UDim2.new(1, 0, 1, 0)
			TextLabel.ZIndex = 14
			TextLabel.Font = Enum.Font.GothamMedium
			TextLabel.Text = "Save"
			TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
			TextLabel.TextSize = 12.000
			TextLabel.TextStrokeTransparency = 1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.TextTransparency = 1

			Compkiller:_BindColor(Compkiller.Elements.SwitchColor , {
				Element = TextLabel,
				Property = 'TextColor3'
			});

			Icon.Name = Compkiller:_RandomString()
			Icon.Parent = Frame
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, 5, 0.5, 0)
			Icon.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
			Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Icon.ZIndex = 15
			Compkiller:_SetIcon(Icon,"save")
			Icon.ImageTransparency = 1;

			LoadButton.Name = Compkiller:_RandomString()
			LoadButton.Parent = LinkValues
			LoadButton.BackgroundTransparency = 1.000
			LoadButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LoadButton.BorderSizePixel = 0
			LoadButton.Size = UDim2.new(0, 77, 0, 30)
			LoadButton.ZIndex = 14

			Frame_2.Parent = LoadButton
			Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame_2.BackgroundColor3 = Compkiller.Colors.Highlight
			Frame_2.BackgroundTransparency = 1
			Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame_2.BorderSizePixel = 0
			Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame_2.Size = UDim2.new(1, -15, 1, -5)
			Frame_2.ZIndex = 14

			Compkiller:_BindColor(Compkiller.Elements.Highlight,{
				Element = Frame_2,
				Property = "BackgroundColor3"
			});

			UIStroke_2.Transparency = 1
			UIStroke_2.Color = Compkiller.Colors.StrokeColor
			UIStroke_2.Parent = Frame_2

			Compkiller:_BindColor(Compkiller.Elements.StrokeColor,{
				Element = UIStroke_2,
				Property = "Color"
			});

			UICorner_2.CornerRadius = UDim.new(0, 3)
			UICorner_2.Parent = Frame_2

			TextLabel_2.Parent = Frame_2
			TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel_2.BackgroundTransparency = 1.000
			TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_2.BorderSizePixel = 0
			TextLabel_2.Position = UDim2.new(0.5, 27, 0.5, 0)
			TextLabel_2.Size = UDim2.new(1, 0, 1, 0)
			TextLabel_2.ZIndex = 14
			TextLabel_2.Font = Enum.Font.GothamMedium
			TextLabel_2.Text = "Load"
			TextLabel_2.TextColor3 = Compkiller.Colors.SwitchColor
			TextLabel_2.TextSize = 12.000
			TextLabel_2.TextStrokeTransparency = 1
			TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel_2.TextTransparency = 1

			Compkiller:_BindColor(Compkiller.Elements.SwitchColor , {
				Element = TextLabel_2,
				Property = 'TextColor3'
			});

			Icon_2.Name = Compkiller:_RandomString()
			Icon_2.Parent = Frame_2
			Icon_2.AnchorPoint = Vector2.new(0, 0.5)
			Icon_2.BackgroundTransparency = 1.000
			Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon_2.BorderSizePixel = 0
			Icon_2.Position = UDim2.new(0, 5, 0.5, 0)
			Icon_2.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
			Icon_2.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Icon_2.ZIndex = 15
			Compkiller:_SetIcon(Icon_2,"folder-open")
			Icon_2.ImageTransparency = 1
			UIStroke_3.Transparency = 1

			UIStroke_3.Color = Compkiller.Colors.StrokeColor
			UIStroke_3.Parent = ConfigBlock

			Compkiller:_BindColor(Compkiller.Elements.StrokeColor,{
				Element = UIStroke_3,
				Property = "Color"
			});

			UICorner_3.CornerRadius = UDim.new(0, 6)
			UICorner_3.Parent = ConfigBlock

			AuthorText.Name = Compkiller:_RandomString()
			AuthorText.Parent = ConfigBlock
			AuthorText.AnchorPoint = Vector2.new(0, 0.5)
			AuthorText.BackgroundTransparency = 1.000
			AuthorText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			AuthorText.BorderSizePixel = 0
			AuthorText.Position = UDim2.new(0.5, -65, 0.5, 15)
			AuthorText.Size = UDim2.new(1, -20, 0, 25)
			AuthorText.ZIndex = 10
			AuthorText.Font = Enum.Font.GothamMedium
			AuthorText.RichText = true;
			AuthorText.Text = "Author: <font color=\"rgb(17, 238, 253)\">NoFi</font>"
			AuthorText.TextColor3 = Compkiller.Colors.SwitchColor
			AuthorText.TextSize = 13.000
			AuthorText.TextTransparency = 1
			AuthorText.TextXAlignment = Enum.TextXAlignment.Left

			Compkiller:_BindColor(Compkiller.Elements.SwitchColor , {
				Element = TabNameLabel,
				Property = 'TextColor3'
			});


            local AutoLabel = Instance.new("TextLabel")
            AutoLabel.Name = "AutoLoadLabel"
            AutoLabel.Parent = ConfigBlock
            AutoLabel.BackgroundTransparency = 1
            AutoLabel.Position = UDim2.fromOffset(12, 1)
            AutoLabel.Size = UDim2.new(1, -64, 0, 16)
            AutoLabel.Font = Enum.Font.Gotham
            AutoLabel.TextSize = 11
            AutoLabel.Text = "Auto Load"
            AutoLabel.TextXAlignment = Enum.TextXAlignment.Left
            AutoLabel.TextColor3 = Compkiller.Colors.SwitchColor
            AutoLabel.ZIndex = 14
            Compkiller:_BindColor(Compkiller.Elements.SwitchColor, {Element = AutoLabel, Property = "TextColor3"})
            local AutoToggle = Instance.new("TextButton")
            AutoToggle.Name = "AutoLoadToggle"
            AutoToggle.Parent = ConfigBlock
            AutoToggle.AnchorPoint = Vector2.new(1, 0)
            AutoToggle.Position = UDim2.new(1, -12, 0, 2)
            AutoToggle.Size = UDim2.fromOffset(30, 16)
            AutoToggle.Text = ""
            AutoToggle.AutoButtonColor = false
            AutoToggle.BorderSizePixel = 0
            AutoToggle.ZIndex = 15
            Instance.new("UICorner", AutoToggle).CornerRadius = UDim.new(1, 0)
            local AutoKnob = Instance.new("Frame")
            AutoKnob.Parent = AutoToggle
            AutoKnob.Size = UDim2.fromOffset(12, 12)
            AutoKnob.BorderSizePixel = 0
            AutoKnob.BackgroundColor3 = Compkiller.Colors.SwitchColor
            AutoKnob.ZIndex = 16
            Instance.new("UICorner", AutoKnob).CornerRadius = UDim.new(1, 0)
            Compkiller:_BindColor(Compkiller.Elements.SwitchColor, {Element = AutoKnob, Property = "BackgroundColor3"})
            function ConfigButton:SetAutoLoad(enabled)
                self.AutoLoad = enabled == true
                AutoToggle.BackgroundColor3 = self.AutoLoad and Compkiller.Colors.Highlight or Compkiller.Colors.DropColor
                AutoKnob.Position = UDim2.fromOffset(self.AutoLoad and 16 or 2, 2)
            end
            ConfigButton:SetAutoLoad(false)
            AutoLabel.Visible, AutoToggle.Visible = false, false
            Compkiller:_BindClickRipple(AutoToggle);
            AutoToggle.MouseButton1Click:Connect(function()
                if ConfigButton.OnAutoLoad then ConfigButton.OnAutoLoad(not ConfigButton.AutoLoad) end
            end)

			function ConfigButton:SetInfo(Author , ConfigName)
				local R,G,B = tostring(math.floor(Compkiller.Colors.Highlight.R * 255)) , tostring(math.floor(Compkiller.Colors.Highlight.G * 255)) , tostring(math.floor(Compkiller.Colors.Highlight.B * 255));

				AuthorText.Text = string.format("Author: <font color=\"rgb(%s, %s, %s)\">%s</font>" ,R,G,B , tostring(Author));
				ConfigText.Text = ConfigName;

				if ConfigBlock.BackgroundTransparency >= 0.7 then
					ConfigButton:Update();
				end;
			end;

			function ConfigButton:Toggle(v)
                AutoLabel.Visible, AutoToggle.Visible = v, v
				if v then
					Compkiller:_Animation(ConfigBlock,Tween,{
						BackgroundTransparency = 0
					});

					Compkiller:_Animation(LinkValues,Tween,{
						Position = UDim2.new(1, -12, 0.5, 0)
					});

					Compkiller:_Animation(ConfigText,Tween,{
						TextTransparency = 0.3,
						Position = UDim2.new(0, 12, 0.5, 0)
					});

					Compkiller:_Animation(Frame,Tween,{
						BackgroundTransparency = 0.100
					});

					Compkiller:_Animation(UIStroke,Tween,{
						Transparency = 0
					});

					Compkiller:_Animation(AuthorText,Tween,{
						TextTransparency = 0.5,
						Position = UDim2.new(0,AuthorText:GetAttribute('SPC'), 0.5, 0)
					});

					Compkiller:_Animation(Icon_2,Tween,{
						ImageTransparency = 0
					});

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0
					});

					Compkiller:_Animation(Frame_2,Tween,{
						BackgroundTransparency = 0.100
					});

					Compkiller:_Animation(UIStroke_2,Tween,{
						Transparency = 0
					});

					Compkiller:_Animation(TextLabel,Tween,{
						TextStrokeTransparency = 0.900,
						TextTransparency = 0
					});

					Compkiller:_Animation(TextLabel_2,Tween,{
						TextStrokeTransparency = 0.900,
						TextTransparency = 0
					});
				else
					Compkiller:_Animation(AuthorText,Tween,{
						TextTransparency = 1,
						Position = UDim2.new(0.5, -65, 0.5, 15)
					});

					Compkiller:_Animation(Icon_2,Tween,{
						ImageTransparency = 1
					});

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 1
					});

					Compkiller:_Animation(LinkValues,Tween,{
						Position = UDim2.new(1, -12, 0.5, 15)
					});

					Compkiller:_Animation(ConfigBlock,Tween,{
						BackgroundTransparency = 1
					});

					Compkiller:_Animation(ConfigText,Tween,{
						TextTransparency = 1,
						Position = UDim2.new(0, 12, 0.5, 15)
					});

					Compkiller:_Animation(Frame,Tween,{
						BackgroundTransparency = 1
					});

					Compkiller:_Animation(UIStroke,Tween,{
						Transparency = 1
					});

					Compkiller:_Animation(Frame_2,Tween,{
						BackgroundTransparency = 1
					});

					Compkiller:_Animation(UIStroke_2,Tween,{
						Transparency = 1
					});

					Compkiller:_Animation(TextLabel,Tween,{
						TextStrokeTransparency = 1,
						TextTransparency = 1
					});

					Compkiller:_Animation(TextLabel_2,Tween,{
						TextStrokeTransparency = 1,
						TextTransparency = 1
					});
				end;
			end;

			function ConfigButton:Update()
				local nameScale = TextService:GetTextSize(ConfigText.Text,ConfigText.TextSize,ConfigText.Font,Vector2.new(math.huge,math.huge));

				AuthorText:SetAttribute('SPC',math.clamp(nameScale.X + 20 , 100,150));

				AuthorText.Position = UDim2.new(0, AuthorText:GetAttribute('SPC'), 0.5, 15)
			end;

			ConfigButton:Update();

			Compkiller:_Input(LoadButton, Compkiller:_GuardButtonCallback(function()
				Compkiller:_SpawnButtonTask(ConfigButton.OnLoad);
			end));

			Compkiller:_Input(SaveButton, Compkiller:_GuardButtonCallback(function()
				Compkiller:_SpawnButtonTask(ConfigButton.OnSave);
			end));

			Compkiller:_BindClickRipple(DelButton);
			DelButton.MouseButton1Click:Connect((Compkiller:_GuardButtonCallback(function()
				Compkiller:_SpawnButtonTask(ConfigButton.OnDelete);
			end)))

			ConfigButton.OnLoad = nil;
			ConfigButton.OnSave = nil;
			ConfigButton.OnDelete = nil;

			return ConfigButton;
		end;

		function TabArgs:Init()
			local __signals = {};
			local Init = {};

			Compkiller:_Input(Button,function()
				if TextBox.Text:byte() then
					WindowArgs.Notify.new({
						Title = "Configs",
						Icon = Compkiller:_GetIcon(Config.Logo),
						Content = "Create config \""..TextBox.Text.."\""
					})

					Configuration.Config:WriteConfig({
						Name = TextBox.Text,
						Author = WindowArgs.Username,
					});
				end;
			end);

			local Refresh = function()
				local FullConfig = Configuration.Config:GetFullConfigs();
                Init.AutoLoadButtons = {}

				for i,v in next, ScrollingFrame:GetChildren() do
					if v:IsA('Frame') and v.Name ~= "Space" then
						v:Destroy();
					end;
				end;

				for i,v in next , __signals do
					v:Disconnect();
				end;

				table.clear(__signals)
				for i,v in next , FullConfig do
					local Button = TabArgs:_DrawConfig();

					Button:SetInfo(v.Info.Author,v.Name);
                    table.insert(Init.AutoLoadButtons, {Button = Button, Name = v.Name})
                    Button:SetAutoLoad(Configuration.Config:GetAutoLoad() == v.Name)
                    Button.OnAutoLoad = function(enabled)
                        if enabled then Configuration.Config:SetAutoLoad(v.Name)
                        elseif Configuration.Config:GetAutoLoad() == v.Name then Configuration.Config:ClearAutoLoad() end
                    end

					table.insert(__signals,TabOpenSignal:Connect(function(v)
						Button:Toggle(v);
					end));

					Button.OnLoad = function()
						WindowArgs.Notify.new({
							Title = "Configs",
							Icon = Compkiller:_GetIcon(Config.Logo),
							Content = "Load config \""..v.Name.."\""
						})

						Configuration.Config:LoadConfig(v.Name);
					end;

					Button.OnSave = function()
						WindowArgs.Notify.new({
							Title = "Configs",
							Icon = Compkiller:_GetIcon(Config.Logo),
							Content = "Save config \""..v.Name.."\""
						})

						Button:SetInfo(v.Info.Author,v.Name);

						Configuration.Config:WriteConfig({
							Name = v.Name,
							Author = v.Info.Author;
						});
					end

					Button.OnDelete = function()
						WindowArgs.Notify.new({
							Title = "Configs",
							Icon = Compkiller:_GetIcon(Config.Logo),
							Content = "Delete config \""..v.Name.."\""
						})

						Configuration.Config:DeleteConfig(v.Name)
					end
				end;
                local function syncAutoLoad()
                    local selected = Configuration.Config:GetAutoLoad()
                    for _, entry in ipairs(Init.AutoLoadButtons) do entry.Button:SetAutoLoad(entry.Name == selected) end
                end
                table.insert(__signals, Configuration.Config.AutoLoadChanged:Connect(syncAutoLoad))
                table.insert(__signals, Compkiller.ThemeLoaded:Connect(syncAutoLoad))
			end;

			Refresh();

			Init.THREAD = task.spawn(function()
				local OldIndex = Configuration.Config:GetConfigCount();

				while true do task.wait(0.125);
					local CountInDirectory = Configuration.Config:GetConfigCount();

					if OldIndex ~= CountInDirectory then
						OldIndex = CountInDirectory;

						Refresh();
					end;
				end;
			end);

            table.insert(WindowArgs.THREADS, Init.THREAD)
            CompKiller.Destroying:Connect(function()
                if Init.THREAD then
                    pcall(task.cancel, Init.THREAD)
                    Init.THREAD = nil
                end
            end)

			return Init;
		end;

		return TabArgs;
	end;

	function WindowArgs:DrawTab(TabConfig : TabConfig , Internal)
		TabConfig = Compkiller.__CONFIG(TabConfig,{
			Name = "Tab",
			Icon = "eye",
			Type = "Double"
		});

		local TabOpenSignal = Compkiller.__SIGNAL(false);
		local TabArgs = {};
		local Upvalue = {};
		local BASE_PADDING = 10;

		if Internal then

			local TabContent = Instance.new("Frame")
			local Left = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Right = Instance.new("ScrollingFrame")
			local UIListLayout_2 = Instance.new("UIListLayout")

			TabContent.Name = Compkiller:_RandomString()
			TabContent.Parent = Internal.Parent;
			TabContent.AnchorPoint = Vector2.new(0.5, 0.5)
			TabContent.BackgroundTransparency = 1.000
			TabContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabContent.BorderSizePixel = 0
			TabContent.Position = UDim2.new(0.5, 0, 0.5, 0)
			TabContent.Size = UDim2.new(1, -5,1, -5)
			TabContent.ZIndex = 6

			Left.Name = Compkiller:_RandomString()
			Left.Parent = TabContent
			Left.Active = true
			Left.AnchorPoint = Vector2.new(0.5, 0.5)
			Left.BackgroundTransparency = 1.000
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.ClipsDescendants = false
			Left.Position = UDim2.new(0.25, -3, 0.5, 0)
			Left.Size = UDim2.new(0.5, -3, 1, 0)
			Left.ZIndex = 8
			Left.BottomImage = ""
			Left.ScrollBarThickness = 0
			Left.TopImage = ""
			--Left.AutomaticCanvasSize = Enum.AutomaticSize.Y;
			Left.CanvasSize = UDim2.new(0, 0, 0, 0)


			UIListLayout.Parent = Left
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalFlex = Enum.UIFlexAlignment.None
			UIListLayout.Padding = UDim.new(0, BASE_PADDING)

			Right.Name = Compkiller:_RandomString()
			Right.Parent = TabContent
			Right.Active = true
			Right.AnchorPoint = Vector2.new(0.5, 0.5)
			Right.BackgroundTransparency = 1.000
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.ClipsDescendants = false
			Right.Position = UDim2.new(0.75, 3, 0.5, 0)
			Right.Size = UDim2.new(0.5, -3, 1, 0)
			Right.ZIndex = 8
			Right.BottomImage = ""
			--Right.AutomaticCanvasSize = Enum.AutomaticSize.Y;
			Right.CanvasSize = UDim2.new(0, 0, 0, 0)
			Right.ScrollBarThickness = 0
			Right.TopImage = ""

			Upvalue.Left = Left;
			Upvalue.Right = Right;
			Upvalue.LeftLayout = UIListLayout;
			Upvalue.RightLayout = UIListLayout_2;
			TabArgs.LeftScrollingFrame = Left;
			TabArgs.RightScrollingFrame = Right;


			UIListLayout_2.Parent = Right
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, BASE_PADDING)
			UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.None

			WindowArgs:AddUnbind(UIListLayout_2 , Right);
			WindowArgs:AddUnbind(UIListLayout , Left);

			if TabConfig.Type == "Single" then
				Right.Visible = false;
				Left.Position = UDim2.new(0.5, 0, 0.5, 0)
				Left.Size = UDim2.new(1,0,1,0)
			end;

			local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

			Internal.Signal:Connect(function(bool)
				TabContent.Visible = bool
			end)

			Upvalue.Left = Left;
			Upvalue.Right = Right;

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(Left);
				Compkiller:_AddDragBlacklist(Right);
			end;

			TabOpenSignal = Internal.Signal;

			if not TabOpenSignal:GetValue() then
				TabContent.Visible = false;
			else
				TabContent.Visible = true;
			end;
		else
			-- Button --
			local TabButton = Instance.new("Frame")
			local Icon = Instance.new("ImageLabel")
			local TabNameLabel = Instance.new("TextLabel")
			local Highlight = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")

			TabButton.Name = Compkiller:_RandomString()
			TabButton.Parent = TabButtonScrollingFrame
			TabButton.BackgroundTransparency = 1.000
			TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabButton.BorderSizePixel = 0
			TabButton.ClipsDescendants = true
			TabButton.Size = UDim2.new(1, -10, 0, 32)
			TabButton.ZIndex = 3

			Icon.Name = Compkiller:_RandomString()
			Icon.Parent = TabButton
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundColor3 = Compkiller.Colors.Highlight
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, 15, 0.5, 0)
			Icon.Size = UDim2.new(0, 22, 0, 22)
			Icon.ZIndex = 3
			Compkiller:_SetIcon(Icon, TabConfig.Icon);
			Icon.ImageColor3 = Compkiller.Colors.Highlight

			table.insert(Compkiller.Elements.Highlight,{
				Element = Icon,
				Property = "ImageColor3"
			});

			TabNameLabel.Name = Compkiller:_RandomString()
			TabNameLabel.Parent = TabButton
			TabNameLabel.AnchorPoint = Vector2.new(0, 0.5)
			TabNameLabel.BackgroundTransparency = 1.000
			TabNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabNameLabel.BorderSizePixel = 0
			TabNameLabel.Position = UDim2.new(0, 43, 0.5, 0)
			TabNameLabel.Size = UDim2.new(1, -50, 0, 25)
			TabNameLabel.ZIndex = 3
			TabNameLabel.Font = Enum.Font.GothamMedium
			TabNameLabel.Text = TabConfig.Name;
			TabNameLabel.TextColor3 = Compkiller.Colors.SwitchColor
			TabNameLabel.TextSize = 16
			TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left
			TabNameLabel.TextWrapped = false
			local TabNameLabelConstraint = Instance.new("UITextSizeConstraint")
			TabNameLabelConstraint.MinTextSize = 8
			TabNameLabelConstraint.MaxTextSize = 16
			TabNameLabelConstraint.Parent = TabNameLabel
			TabNameLabel.TextScaled = true

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TabNameLabel,
				Property = 'TextColor3'
			});

			Highlight.Name = Compkiller:_RandomString()
			Highlight.Parent = TabButton
			Highlight.AnchorPoint = Vector2.new(0.5, 0.5)
			Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
			Highlight.BackgroundTransparency = 0.925
			Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Highlight.BorderSizePixel = 0
			Highlight.Position = UDim2.new(0.5, 0, 0.5, 0)
			Highlight.Size = UDim2.new(1, -17, 1, 0)
			Highlight.ZIndex = 2

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Highlight

			local TabContent = Instance.new("Frame")
			local Left = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Right = Instance.new("ScrollingFrame")
			local UIListLayout_2 = Instance.new("UIListLayout")

			TabContent.Name = Compkiller:_RandomString()
			TabContent.Parent = TabMainFrame;
			TabContent.AnchorPoint = Vector2.new(0.5, 0.5)
			TabContent.BackgroundTransparency = 1.000
			TabContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabContent.BorderSizePixel = 0
			TabContent.Position = UDim2.new(0.5, 0, 0.5, 0)
			TabContent.Size = UDim2.new(1, -15, 1, -15)
			TabContent.ZIndex = 6

			Left.Name = Compkiller:_RandomString()
			Left.Parent = TabContent
			Left.Active = true
			Left.AnchorPoint = Vector2.new(0.5, 0.5)
			Left.BackgroundTransparency = 1.000
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.ClipsDescendants = false
			Left.Position = UDim2.new(0.25, -3, 0.5, 0)
			Left.Size = UDim2.new(0.5, -3, 1, 0)
			Left.ZIndex = 8
			Left.BottomImage = ""
			Left.ScrollBarThickness = 0
			Left.TopImage = ""
			--Left.AutomaticCanvasSize = Enum.AutomaticSize.Y;
			Left.CanvasSize = UDim2.new(0, 0, 0, 0)



			UIListLayout.Parent = Left
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalFlex = Enum.UIFlexAlignment.None
			UIListLayout.Padding = UDim.new(0, BASE_PADDING)

			Right.Name = Compkiller:_RandomString()
			Right.Parent = TabContent
			Right.Active = true
			Right.AnchorPoint = Vector2.new(0.5, 0.5)
			Right.BackgroundTransparency = 1.000
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.ClipsDescendants = false
			Right.Position = UDim2.new(0.75, 3, 0.5, 0)
			Right.Size = UDim2.new(0.5, -3, 1, 0)
			Right.ZIndex = 8
			Right.BottomImage = ""
			Right.ScrollBarThickness = 0
			Right.TopImage = ""
			--Right.AutomaticCanvasSize = Enum.AutomaticSize.Y;
			Right.CanvasSize = UDim2.new(0, 0, 0, 0)

			Upvalue.Left = Left;
			Upvalue.Right = Right;
			Upvalue.LeftLayout = UIListLayout;
			Upvalue.RightLayout = UIListLayout_2;
			TabArgs.LeftScrollingFrame = Left;
			TabArgs.RightScrollingFrame = Right;


			UIListLayout_2.Parent = Right
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, BASE_PADDING)
			UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.None

			WindowArgs:AddUnbind(UIListLayout_2 , Right);
			WindowArgs:AddUnbind(UIListLayout , Left);

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(Left);
				Compkiller:_AddDragBlacklist(Right);
			end;

			if TabConfig.Type == "Single" then
				Right.Visible = false;
				Left.Position = UDim2.new(0.5, 0, 0.5, 0)
				Left.Size = UDim2.new(1, -1, 1, -1)
			end;

			local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

			local TabOpen = function(bool)
				TabContent.Visible = bool
				if bool then

					WindowArgs.SelectedTab = TabButton;

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0,
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0
					});

					Compkiller:_Animation(Highlight,Tween,{
						BackgroundTransparency = 0.925
					});
				else
					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0.5
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0.25
					});

					Compkiller:_Animation(Highlight,Tween,{
						BackgroundTransparency = 1
					});
				end;
			end;

			if not WindowArgs.Tabs[1] then
				TabOpenSignal:Fire(true);
				TabOpen(true);
			else
				TabOpen(false);
			end;

			table.insert(WindowArgs.Tabs , {
				Root = TabButton,
				Remote = TabOpenSignal
			});

			Compkiller:_Hover(TabButton,function()
				if WindowArgs.SelectedTab ~= TabButton then
					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0.1
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0.1
					});
				end;
			end , function()
				if WindowArgs.SelectedTab ~= TabButton then
					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0.5
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0.25
					});
				end;
			end)

			TabOpenSignal:Connect(TabOpen);

			TabHover:Connect(function(bool)
				if bool then
					Compkiller:_Animation(TabButton,Tween,{
						Size = UDim2.new(1, -10, 0, 32)
					});

					Compkiller:_Animation(Icon,Tween,{
						Position = UDim2.new(0, 15, 0.5, 0),
						Size = UDim2.new(0, 22, 0, 22),
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						Size = UDim2.new(1, -50, 0, 25),
						Position = UDim2.new(0, 43, 0.5, 0)
					});

					Compkiller:_Animation(UICorner,Tween,{
						CornerRadius = UDim.new(0, 4)
					});

					Compkiller:_Animation(Highlight,Tween,{
						Size = UDim2.new(1, -17, 1, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0)
					});
				else
					Compkiller:_Animation(UICorner,Tween,{
						CornerRadius = UDim.new(0, 10)
					});

					Compkiller:_Animation(TabButton,Tween,{
						Size = UDim2.new(1, -10, 0, 32)
					});

					Compkiller:_Animation(Icon,Tween,{
						Position = UDim2.new(0, 12, 0.5, 0),
						Size = UDim2.new(0, 20, 0, 20),
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						Size = UDim2.new(1, -87, 0, 25),
						Position = UDim2.new(0, 80, 0.5, 0)
					});

					Compkiller:_Animation(Highlight,Tween,{
						Size = UDim2.new(1, -10,1, 5),
						Position = UDim2.new(0.5, 0, 0.5, 0)
					});
				end;
			end);

			Compkiller:_Input(TabButton,function()
				for i,v in next, WindowArgs.Tabs do
					if v.Root == TabButton then
						v.Remote:Fire(true);
					else
						v.Remote:Fire(false);
					end;
				end;
			end);
		end;

		function TabArgs:_UpdateScrolling(Frame: ScrollingFrame , ListLayout: UIListLayout)
			local frame;

			local last = 0;
			local scale = 0;

			local Offset = ListLayout.Padding.Offset;
			local Childrens = Frame:GetChildren();

			for i,v in next ,Childrens do task.wait();
				if v:IsA('Frame') then
					if v.LayoutOrder > last then
						scale += v.AbsoluteSize.Y + Offset;

						last = v.LayoutOrder;
						frame = v;
					end;
				end;
			end;

			task.wait();

			if frame then
				local originalScale = frame:GetAttribute('OrigninalScale');

				if originalScale then
					task.wait();

					local Maximum = Frame.AbsoluteSize.Y;

					local remainingHeight = Maximum - ((scale) - (frame.AbsoluteSize.Y));

					if originalScale >= Frame.AbsoluteSize.Y then
						Frame:SetAttribute('LayoutStacks',originalScale + 5);
					else
						Frame:SetAttribute('LayoutStacks',((remainingHeight) + 5));
					end

					task.wait();

					local caller = WindowArgs.THREADS[frame];

					if caller then
						caller(true);
					end;
				end;
			end;

			task.wait();
		end;

		TabArgs.SectionInfo = {};

		TabArgs.SectionClose = {
			[Upvalue.Left] = {},
			[Upvalue.Right] = {},
		};

		TabArgs.LeftThread = coroutine.wrap(function()
			task.wait();

			while true do task.wait(0.01)
				TabArgs:_UpdateScrolling(Upvalue.Left , Upvalue.LeftLayout);
			end;
		end);

		TabArgs.RightThread = coroutine.wrap(function()
			task.wait(0.1);

			while true do task.wait(0.01)
				TabArgs:_UpdateScrolling(Upvalue.Right , Upvalue.RightLayout);
			end;
		end);

		--TabArgs.LeftThread();
		--TabArgs.RightThread();

		function TabArgs:DrawSection(config: Section)
			config = Compkiller.__CONFIG(config,{
				Name = "Section",
				Position = "left"
			});

			local Parent = (TabConfig.Type == "Double" and ((string.lower(config.Position) == "left" and Upvalue.Left) or Upvalue.Right)) or Upvalue.Left;
			local ParentLayout = (TabConfig.Type == "Double" and ((string.lower(config.Position) == "left" and Upvalue.LeftLayout) or Upvalue.RightLayout)) or Upvalue.LeftLayout;

			local IsOpen = true;

			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local UIListLayout = Instance.new("UIListLayout")
			local Header = Instance.new("Frame")
			local SectionText = Instance.new("TextLabel")
			local SectionClose = Instance.new("ImageLabel")

			Section.Name = Compkiller:_RandomString()
			Section.Parent = Parent;

			if TabConfig.Type == "Single" then
				Section.Parent = Upvalue.Left;
			end;

			Section.BackgroundColor3 = Compkiller.Colors.BlockColor

			table.insert(Compkiller.Elements.BlockColor , {
				Element = Section,
				Property = "BackgroundColor3"
			});

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(Section);
			end;

			Section.LayoutOrder = #Parent:GetChildren() + 3;
			Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(1, 0, 0, 0)
			Section.ZIndex = 9
			Section.ClipsDescendants = true;

			UICorner.CornerRadius = UDim.new(0, 5)
			UICorner.Parent = Section

			UIStroke.Color = Compkiller.Colors.StrokeColor
			UIStroke.Parent = Section

			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke,
				Property = "Color"
			});

			UIListLayout.Parent = Section
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 7)

			Header.Name = Compkiller:_RandomString()
			Header.Parent = Section
			Header.BackgroundTransparency = 1.000
			Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Header.BorderSizePixel = 0
			Header.LayoutOrder = -100
			Header.Size = UDim2.new(1, 0, 0, 35)
			Header.ZIndex = 9

			SectionText.Name = Compkiller:_RandomString()
			SectionText.Parent = Header
			SectionText.AnchorPoint = Vector2.new(0, 0.5)
			SectionText.BackgroundTransparency = 1.000
			SectionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionText.BorderSizePixel = 0
			SectionText.Position = UDim2.new(0, 12, 0.5, 0)
			SectionText.Size = UDim2.new(1, -52, 0, 25)
            SectionText.TextWrapped = false
            SectionText.TextTruncate = Enum.TextTruncate.AtEnd
			SectionText.ZIndex = 10
			SectionText.Font = Enum.Font.GothamMedium
			SectionText.Text = config.Name;
			SectionText.TextColor3 = Compkiller.Colors.SwitchColor
			SectionText.TextSize = 16
			SectionText.TextTransparency = 0.25
			SectionText.TextXAlignment = Enum.TextXAlignment.Left

			table.insert(Compkiller.Elements.SwitchColor , {
				Element = SectionText,
				Property = 'TextColor3'
			});

			SectionClose.Name = Compkiller:_RandomString()
			SectionClose.Parent = Header
			SectionClose.AnchorPoint = Vector2.new(1, 0.5)
			SectionClose.BackgroundTransparency = 1.000
			SectionClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionClose.BorderSizePixel = 0
			SectionClose.Position = UDim2.new(1, -12, 0.5, 0)
			SectionClose.Size = UDim2.new(0, 17, 0, 17)
			SectionClose.ZIndex = 10
			Compkiller:_SetIcon(SectionClose,"chevron-down")
			SectionClose.ImageTransparency = 0.500

			if not SectionText.Text:byte() then
				Header.Visible = false;
			else
				Header.Visible = true;
			end;

			TabArgs.SectionInfo[Section] = {
				UIListLayout = UIListLayout,
			};

            -- One queued pass per column handles resize/content bursts. Each
            -- section previously registered a listener that refreshed every sibling.
            TabArgs.ColumnLayouts = TabArgs.ColumnLayouts or {};
            local Column = TabArgs.ColumnLayouts[Parent];
            if not Column then
                Column = {Queued = false};
                TabArgs.ColumnLayouts[Parent] = Column;
                function Column.Request()
                    if Column.Queued then return; end;
                    Column.Queued = true;
                    task.defer(function()
                        Column.Queued = false;
                        if not Parent.Parent then return; end;
                        local Summary = {Height = 0, Count = 0, LastOrder = -math.huge};
                        for Sibling, Info in pairs(TabArgs.SectionInfo) do
                            if Sibling.Parent == Parent and Sibling.Visible then
                                local Closed = TabArgs.SectionClose[Parent][Sibling];
                                Summary.Height += Closed and 35 or math.ceil(Info.UIListLayout.AbsoluteContentSize.Y / math.max(WindowArgs.ResolutionScale or 1, 0.001)) + 8;
                                Summary.Count += 1;
                                Summary.LastOrder = math.max(Summary.LastOrder, Sibling.LayoutOrder);
                            end;
                        end;
                        for Sibling, Info in pairs(TabArgs.SectionInfo) do
                            if Sibling.Parent == Parent and Info.Refresh then Info.Refresh(Summary); end;
                        end;
                    end);
                end;
                local Connection = Parent:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(Column.Request);
                Parent.Destroying:Connect(function()
                    Connection:Disconnect();
                    TabArgs.ColumnLayouts[Parent] = nil;
                end);
            end;
            local refresh = function(Summary)
                if not Summary then Column.Request(); return; end;
                Header.Visible = SectionText.Text:byte() ~= nil;
                local ContentHeight = math.ceil(UIListLayout.AbsoluteContentSize.Y / math.max(WindowArgs.ResolutionScale or 1, 0.001));
                Section:SetAttribute('OrigninalScale', ContentHeight);
                Section:SetAttribute('HEIGHTSCALE', IsOpen and (ContentHeight + 8) or 35);
                Section:SetAttribute('Height', nil);
                Section:SetAttribute('Collapsed', not IsOpen);
                local Height = IsOpen and (ContentHeight + 8) or 35;
                if IsOpen and Summary.LastOrder <= Section.LayoutOrder then
                    local OwnHeight = Section.Visible and (ContentHeight + 8) or 0;
                    local OtherCount = Summary.Count - (Section.Visible and 1 or 0);
                    Height = math.max(Height, Parent.AbsoluteWindowSize.Y / math.max(WindowArgs.ResolutionScale or 1, 0.001) - (Summary.Height - OwnHeight)
                        - OtherCount * ParentLayout.Padding.Offset - 16);
                end;
                local Size = UDim2.new(1, 0, 0, Height);
                if Section.Size ~= Size then Section.Size = Size; end;
            end;
            TabArgs.SectionInfo[Section].Refresh = refresh;
            WindowArgs.THREADS[Section] = refresh;
            local refreshScale = Column.Request;
            Section.Destroying:Connect(function()
                WindowArgs.THREADS[Section] = nil;
                TabArgs.SectionInfo[Section] = nil;
                TabArgs.SectionClose[Parent][Section] = nil;
                Column.Request();
            end);
            Section.ChildAdded:Connect(refreshScale);
            Section:GetPropertyChangedSignal("Visible"):Connect(refreshScale);
            UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(refreshScale);

            TabOpenSignal:Connect(function(bool)
                if bool then
                    Column.Request();
                    Compkiller:_Animation(Section,TweenInfo.new(0.21),{BackgroundTransparency = 0});
                    Compkiller:_Animation(SectionText,TweenInfo.new(0.21),{TextTransparency = 0.25});
                    Compkiller:_Animation(SectionClose,TweenInfo.new(0.21),{ImageTransparency = 0.5});
                else
                    Compkiller:_Animation(Section,TweenInfo.new(0.21),{BackgroundTransparency = 1});
                    Compkiller:_Animation(SectionText,TweenInfo.new(0.21),{TextTransparency = 1});
                    Compkiller:_Animation(SectionClose,TweenInfo.new(0.21),{ImageTransparency = 1});
                end;
            end);

			Compkiller:_Input(Header,function()
				IsOpen = not IsOpen;

				if IsOpen then
					Compkiller:_Animation(SectionClose,TweenInfo.new(0.35),{
						Rotation = 0
					});
				else
					Compkiller:_Animation(SectionClose,TweenInfo.new(0.35),{
						Rotation = -180
					});
				end;

                TabArgs.SectionClose[Parent][Section] = not IsOpen and Section or nil;
                refresh();

				refreshScale();
			end);

			return Compkiller:_LoadElement(Section , true , TabOpenSignal)
		end;

		return TabArgs;
	end;

	do
		local CloseWindow = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ImageLabel = Instance.new("ImageLabel")

		CloseWindow.Name = Compkiller:_RandomString()
		CloseWindow.Parent = CompKiller
		CloseWindow.AnchorPoint = Vector2.new(1, 0)
		CloseWindow.BackgroundColor3 = Compkiller.Colors.BGDBColor

		table.insert(Compkiller.Elements.BGDBColor,{
			Element = CloseWindow,
			Property = 'BackgroundColor3'
		});

		CloseWindow.BackgroundTransparency = 1
		CloseWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CloseWindow.BorderSizePixel = 0
		CloseWindow.Position = UDim2.new(1, -10, 0, 10)
		CloseWindow.Size = UDim2.new(0, 0, 0, 23)
		CloseWindow.ZIndex = 150
		CloseWindow.ClipsDescendants = true;

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = CloseWindow

		ImageLabel.Parent = CloseWindow
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ImageLabel.ZIndex = 151
		ImageLabel.Image = Config.Logo
		ImageLabel:SetAttribute("ButterRestoreIcon", true);
		Compkiller:_BindPolishColor(ImageLabel, "ImageColor3", "RestoreIcon");
		ImageLabel.ImageTransparency = 1
		ImageLabel.ClipsDescendants = false;

		local ToggleCloseUI = function(v, imageTransparency)
			ImageLabel.Image = Config.Logo;

			if v then
				ImageLabel.ClipsDescendants = true;

				AnimateWindowTarget(CloseWindow,0.2,{
					Size = UDim2.new(0, 45, 0, 23),
					BackgroundTransparency = 0.025
				})

				AnimateWindowTarget(ImageLabel,0.2,{
					ImageTransparency = imageTransparency or (ImageLabel:GetAttribute('Hover') and 0.02) or 0.12
				})
			else
				ImageLabel.ClipsDescendants = false;

				AnimateWindowTarget(CloseWindow,0.2,{
					Size = UDim2.new(0, 0, 0, 23),
					BackgroundTransparency = 1
				})

				AnimateWindowTarget(ImageLabel,0.2,{
					ImageTransparency = 1
				})
			end;
		end;

		function WindowArgs:Watermark()
			local Watermark = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Logo = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local Frame = Instance.new("Frame")
			local CompLogo = Compkiller:_CreateBrandIcon(nil, Config.Logo)
			local WaternarkList = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")

			Watermark.Name = Compkiller:_RandomString()
			Watermark.Parent = CompKiller
			Watermark.AnchorPoint = Vector2.new(1, 0)
			Watermark.BackgroundColor3 = Compkiller.Colors.BGDBColor

			table.insert(Compkiller.Elements.BGDBColor,{
				Element = Watermark,
				Property = 'BackgroundColor3'
			});

			Watermark.BackgroundTransparency = 0.025
			Watermark.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Watermark.BorderSizePixel = 0
			Watermark.Position = UDim2.new(1, -10, 0, 10)
			Watermark.Size = UDim2.new(0, 45, 0, 23)
			Watermark.ZIndex = 150

			ImageLabel:GetPropertyChangedSignal('ClipsDescendants'):Connect(function()
				if ImageLabel.ClipsDescendants then
					Compkiller:_Animation(Watermark , TweenInfo.new(0.2),{
						Position = UDim2.new(1, -60, 0, 10)
					})
				else
					Compkiller:_Animation(Watermark , TweenInfo.new(0.2),{
						Position = UDim2.new(1, -10, 0, 10)
					})
				end;
			end)

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Watermark

			Logo.Name = Compkiller:_RandomString()
			Logo.Parent = Watermark
			Logo.AnchorPoint = Vector2.new(1, 0.5)
			Logo.BackgroundColor3 = Compkiller.Colors.BGDBColor

			table.insert(Compkiller.Elements.BGDBColor,{
				Element = Logo,
				Property = 'BackgroundColor3'
			});

			Logo.BackgroundTransparency = 0.300
			Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Logo.BorderSizePixel = 0
			Logo.Position = UDim2.new(0, 5, 0.5, 0)
			Logo.Size = UDim2.new(1, 10, 1, 0)
			Logo.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Logo.ZIndex = 149

			UICorner_2.CornerRadius = UDim.new(0, 3)
			UICorner_2.Parent = Logo

			Frame.Parent = Logo
			Frame.AnchorPoint = Vector2.new(0, 0.5)
			Frame.BackgroundColor3 = Compkiller.Colors.Highlight
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(1, -5, 0.5, 0)
			Frame.Size = UDim2.new(0, 2, 1, 0)
			Frame.ZIndex = 151

			table.insert(Compkiller.Elements.Highlight,{
				Element = Frame,
				Property = "BackgroundColor3"
			});

			CompLogo.Name = Compkiller:_RandomString()
			CompLogo.Parent = Logo
			CompLogo.AnchorPoint = Vector2.new(0.5, 0.5)
			CompLogo.BackgroundTransparency = 1.000
			CompLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CompLogo.BorderSizePixel = 0
			CompLogo.Position = UDim2.new(0.5, -2, 0.5, 0)
			CompLogo.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
			CompLogo.SizeConstraint = Enum.SizeConstraint.RelativeYY
			CompLogo.ZIndex = 159
			CompLogo.Image = Config.Logo

			WaternarkList.Name = Compkiller:_RandomString()
			WaternarkList.Parent = Watermark
			WaternarkList.AnchorPoint = Vector2.new(0.5, 0)
			WaternarkList.BackgroundTransparency = 1.000
			WaternarkList.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WaternarkList.BorderSizePixel = 0
			WaternarkList.Position = UDim2.new(0.5, 0, 0, 0)
			WaternarkList.Size = UDim2.new(1, -16, 1, 0)
			WaternarkList.ZIndex = 155
			WaternarkList.ClipsDescendants = true

			UIListLayout.Parent = WaternarkList
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			UIListLayout.Padding = UDim.new(0, 3)

			local BackFrame = Instance.new("Frame")

			BackFrame.Name = Compkiller:_RandomString()
			BackFrame.Parent = Watermark
			BackFrame.AnchorPoint = Vector2.new(1, 0.5)
			BackFrame.BackgroundTransparency = 1.000
			BackFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BackFrame.BorderSizePixel = 0
			BackFrame.Position = UDim2.new(1, 0, 0.5, 0)
			BackFrame.Size = UDim2.new(1, 30, 1, 0)

			local BlurVisible = Compkiller.__SIGNAL(WindowOpen:GetValue());
			Compkiller:_Blur(BackFrame, BlurVisible);
			local BlurWindowConnection = WindowOpen:Connect(function(Open)
				BlurVisible:Fire(Open and Watermark.Visible);
			end);
			Watermark.Destroying:Connect(function() BlurWindowConnection:Disconnect(); end);

			local LastWidth = 45;
			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				local Width = math.max(45, math.ceil(UIListLayout.AbsoluteContentSize.X + 16));
				if Width == LastWidth then return; end;
				LastWidth = Width;
				Compkiller:_Animation(Watermark,TweenInfo.new(0.4),{
					Size = UDim2.new(0, Width, 0, 23)
				});
			end)

			local Args = {Root = Watermark, Logo = CompLogo};

			function Args:SetVisible(Value)
				Watermark.Visible = Value == true;
				BlurVisible:Fire(Watermark.Visible and WindowOpen:GetValue());
			end;

			function Args:GetVisible()
				return Watermark.Visible;
			end;

			function Args:AddText(Watermark : Watermark)
				Watermark = Compkiller.__CONFIG(Watermark, {
					Text = "Watermark",
					Icon = "info"
				});

				local Icon = Instance.new("ImageLabel")
				local TextLabel = Instance.new("TextLabel")

				Icon.Name = Compkiller:_RandomString()
				Icon.Parent = WaternarkList
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Size = UDim2.fromOffset(15,15)
				Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
				Icon.ZIndex = 156
				Compkiller:_SetIcon(Icon, Watermark.Icon);
				Icon.Visible = Watermark.ShowIcon ~= false;
				Icon.ImageColor3 = Watermark.IconColor or Color3.new(1, 1, 1);

				TextLabel.Parent = WaternarkList
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Size = UDim2.new(0, 50, 0.699999988, 0)
				TextLabel.ZIndex = 156
				TextLabel.Font = Watermark.Font or Enum.Font.GothamMedium
				TextLabel.Visible = Watermark.ShowText ~= false;
				TextLabel.Text = Watermark.Text
				TextLabel.TextColor3 = Watermark.TextColor or Compkiller.Colors.SwitchColor
				TextLabel.TextSize = Watermark.TextSize or 10
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left

				if not Watermark.TextColor then
					table.insert(Compkiller.Elements.SwitchColor , {
						Element = TextLabel,
						Property = 'TextColor3'
					});
				end;

				-- Natural sizing keeps status and balance entries compact by default.
				-- StableWidth explicitly opts into retaining the largest width.
				local WidestDigit, DigitWidth = "0", 0;
				if Watermark.StableWidth == true then
					for Digit = 0, 9 do
						local Width = TextService:GetTextSize(tostring(Digit), TextLabel.TextSize, TextLabel.Font, Vector2.new(math.huge, math.huge)).X;
						if Width > DigitWidth then WidestDigit, DigitWidth = tostring(Digit), Width; end;
					end;
				end;
				local function Measure(Text)
					if Watermark.StableWidth == true then Text = Text:gsub("%d", WidestDigit); end;
					return math.ceil(TextService:GetTextSize(Text, TextLabel.TextSize, TextLabel.Font, Vector2.new(math.huge, math.huge)).X) + 2;
				end;
				local MinimumWidth = math.max(0, tonumber(Watermark.MinWidth) or 0, Watermark.WidthSample and Measure(Watermark.WidthSample) or 0);
				local ReservedWidth = MinimumWidth;
				local Update = function()
					local Width = Measure(TextLabel.Text);
					ReservedWidth = Watermark.StableWidth == true and math.max(ReservedWidth, Width) or math.max(MinimumWidth, Width);
					if TextLabel.Size.X.Offset ~= ReservedWidth then
						TextLabel.Size = UDim2.new(0, ReservedWidth, 0.7, 0);
					end;
				end;

				Update()

				local Arg = {};

				function Arg:SetText(text)
					TextLabel.Text = text;
					Update();
				end;

				function Arg:SetIconColor(color)
					Icon.ImageColor3 = color;
				end;

				function Arg:Visible(v)
					Icon.Visible = v and Watermark.ShowIcon ~= false;
					TextLabel.Visible = v and Watermark.ShowText ~= false;
				end;

				return Arg;
			end;

			return Args;
		end;

		function WindowArgs:Toggle(Value: boolean)
			WindowArgs.IsOpen = Value;
            CompKiller:SetAttribute("ButterMenuOpen", Value);
            if not Value then Compkiller:_CloseWindowDropdowns(CompKiller); end;
			if WindowArgs.PerformanceMode then
				MainFrame.Visible = Value;
			end;

			WindowOpen:Fire(Value);

			if Value then
				for i,v in next , WindowArgs.Tabs do
					if v.Root == WindowArgs.SelectedTab then
						v.Remote:Fire(true);
					end;
				end;
			else
				for i,v in next , WindowArgs.Tabs do
					v.Remote:Fire(false);
				end;
			end;
		end;

		function WindowArgs:_ToggleUI()
			WindowArgs.IsOpen = not WindowArgs.IsOpen;

			WindowArgs:Toggle(WindowArgs.IsOpen)
		end;

		local Button = Compkiller:_Input(CloseWindow,function()
			WindowArgs:_ToggleUI()
		end)

		if not Compkiller:_IsMobile() then

			Compkiller:_Hover(Button,function()
				ImageLabel:SetAttribute("Hover",true);
			end , function()
				ImageLabel:SetAttribute("Hover",false);
			end);
		end;

		local mobileThread = task.spawn(function()
			while true do task.wait(0.15)
				if Compkiller:_IsMobile() then
					ToggleCloseUI(true, WindowArgs.IsOpen and 0.12 or 0.02);
				else
					if not WindowArgs.IsOpen then
						ToggleCloseUI(true);
					else
						ToggleCloseUI(false);
					end
				end;
			end
		end);

		table.insert(WindowArgs.THREADS, mobileThread);

		function WindowArgs:SetKeybind(key)
			Config.Keybind = key
		end;

		local unregisterKeybind = Compkiller:_RegisterKeybindHandler(function(Input, Typing)
			if not Typing and (Input.KeyCode == Config.Keybind or Input.KeyCode.Name == Config.Keybind) then
				WindowArgs:_ToggleUI()
			end;
		end);

		WindowArgs._UnregisterKeybind = unregisterKeybind;
	end;

	function WindowArgs:Update(config: WindowUpdate)
		config = config or {};
		local displayTitle = config.WindowName or Config.TitleText or Config.Name;
		config.Logo = config.Logo or Config.Logo;
		config.Username = config.Username or LocalPlayer.DisplayName;
		config.ExpireDate = config.ExpireDate or "@" ..config.Username;
		config.WindowName = config.WindowName or Config.Name;
		config.UserProfile = config.UserProfile or WindowArgs.Profile or string.format("rbxthumb://type=AvatarHeadShot&id=%s&w=150&h=150",tostring(LocalPlayer.UserId));

		UserText.Text = config.Username;
		CompLogo.Image = config.Logo;
		ExpireText.Text = config.ExpireDate;
		WindowLabel.Text = displayTitle;
		UserProfile.Image = config.UserProfile;
		WindowArgs.Username = config.Username;

		Config.Logo = config.Logo or Config.Logo;
		WindowArgs.Username = config.Username or WindowArgs.Username;
		WindowArgs.ExipreDate = config.ExpireDate or WindowArgs.ExipreDate;
		Config.Name = config.WindowName or Config.Name;
		WindowArgs.Profile = config.UserProfile or WindowArgs.Profile;
	end;

	WindowArgs.LOOP_THREAD = task.spawn(function()
		local BlurElement = Instance.new("Frame")

		BlurElement.Name = Compkiller:_RandomString()
		BlurElement.Parent = MainFrame
		BlurElement.AnchorPoint = Vector2.new(1, 0.5)
		BlurElement.BackgroundTransparency = 1.000
		BlurElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlurElement.BorderSizePixel = 0
		BlurElement.Position = UDim2.new(1, -5, 0.5, 0)
		BlurElement.Size = UDim2.new(1, 0, 1, 0)
		BlurElement.ZIndex = -100
		BlurElement.Active = true

		Compkiller:_Blur(BlurElement , WindowOpen);

		local MovementFrame = Instance.new("Frame")

		MovementFrame.Name = Compkiller:_RandomString()
		MovementFrame.Parent = MainFrame
		MovementFrame.AnchorPoint = Vector2.new(1, 0.5)
		MovementFrame.BackgroundTransparency = 1.000
		MovementFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MovementFrame.BorderSizePixel = 0
		MovementFrame.Position = UDim2.new(1, 0, 0.5, 0)
		MovementFrame.Size = UDim2.new(1, 0, 1, 0)
		MovementFrame.ZIndex = 9

		Compkiller:Drag(MovementFrame,MainFrame,0.1)

		table.insert(Compkiller.Elements.Highlight,{
			Element = SelectionFrame,
			Property = "BackgroundColor3"
		});

		while true do task.wait(0.05);
			BlurElement.Size = UDim2.new(1, TabFrame.AbsoluteSize.X / (WindowArgs.ResolutionScale or 1) - 35, 1, 0);
			MovementFrame.Size = UDim2.new(1, TabFrame.AbsoluteSize.X / (WindowArgs.ResolutionScale or 1) - 35, 1, 0);

			SelectionFrame.BackgroundColor3 = Compkiller.Colors.Highlight;

			if WindowArgs.SelectedTab and WindowArgs.IsOpen then
				local vili = -(TabButtons.AbsolutePosition.Y - WindowArgs.SelectedTab.AbsolutePosition.Y) / (WindowArgs.ResolutionScale or 1) + 2;
				local distance = (SelectionFrame.Position.Y.Offset - vili);

				if vili < 0 or vili > TabButtons.AbsoluteSize.Y / (WindowArgs.ResolutionScale or 1) then
					AnimateWindowTarget(SelectionFrame, 0.1, {
						BackgroundTransparency = 1
					});
				else
					if math.abs(distance) <= 10 then
						AnimateWindowTarget(SelectionFrame, 0.1, {
							BackgroundTransparency = 0
						});

						SelectionFrame.Position = UDim2.new(1,5,0,math.ceil(vili));
					else
						AnimateWindowTarget(SelectionFrame, 0.15, {
							BackgroundTransparency = 0,
							Position = UDim2.new(1,5,0,math.ceil(vili))
						});
					end;
				end;
			else
				AnimateWindowTarget(SelectionFrame, 0.15, {
					BackgroundTransparency = 1
				});
			end;

			if WindowArgs.AlwayShowTab then
				TabHover:Fire(true);
			end;
		end;
	end);

	Compkiller:_TrackWindowState(Compkiller:_RandomString(), {
		LoopThread = WindowArgs.LOOP_THREAD,
		Threads = WindowArgs.THREADS,
	});

	WindowArgs:Update();

	local OldDelayThread;
	local DurationTime = tick();

	Compkiller:_Hover(TabFrame , function()
		if OldDelayThread then
			task.cancel(OldDelayThread);
			OldDelayThread = nil;
		end;

		if WindowArgs.AlwayShowTab then
			return;
		end;

		DurationTime = tick();

		TabHover:Fire(true);
	end , function()
		if OldDelayThread then
			task.cancel(OldDelayThread);
			OldDelayThread = nil;
		end;

		if WindowArgs.AlwayShowTab then
			return;
		end;

		OldDelayThread = task.delay(math.clamp((tick() - DurationTime) , 0.01,5),function()
			if TabHover:GetValue() then
				TabHover:Fire(false);
			end
		end);
	end, false); -- Tab expansion is layout behavior, not a control highlight.

	return WindowArgs;
end;

function Compkiller:GetDate(Time)
	Time = Time or tick();

	local val = os.date('*t',Time);

	return string.format("%s/%s/%s",val.day,val.month,val.year);
end;

function Compkiller:GetTimeNow(Time)
	Time = Time or tick();

	local val = os.date('*t',Time);

	return string.format("%s:%s:%s",val.hour,val.min,val.sec);
end;

function Compkiller:GetConfig(Type: string)
	local ConfigFlags = {};

	for i,v in next , Compkiller.Flags do
		local Value = v:GetValue();
		local Suf = {};

		if typeof(Value) == "table" and Value.ColorPicker and typeof(Value.ColorPicker) == 'table' then
			Suf.Color3 = {
				R = Value.ColorPicker.Color.R,
				G = Value.ColorPicker.Color.G,
				B = Value.ColorPicker.Color.B
			};

			Suf.Transparency = Value.ColorPicker.Transparency;

			Suf.Type = "ColorPicker";
		else
			Suf.Value = Value;
			Suf.Type = "NormalElement";
		end;

		if Type == "KV" then
			ConfigFlags[v.Flag] = {
				Flag = v.Flag,
				Value = Suf,
				Functions = v,
			}
		elseif Type == "MK" then
			ConfigFlags[v.Flag] = {
				Flag = v.Flag,
				Value = Suf,
			}
		else
			table.insert(ConfigFlags , {
				Flag = v.Flag,
				Value = Suf
			})
		end;
	end;

	return ConfigFlags;
end;

function Compkiller:_Path(...)
	local args = {...};

	return table.concat(args, "/");
end;

Compkiller.ThemeLoaded = Compkiller.__SIGNAL(0);
function Compkiller:NotifyThemeChanged()
    self.ThemeLoaded:Fire((self.ThemeLoaded:GetValue() or 0) + 1)
end


function Compkiller:ConfigManager(ConfigManager: ConfigManager) : ConfigFunctions
	ConfigManager = Compkiller.__CONFIG(ConfigManager , {
		Directory = "Compkiller",
		Config = "Software"
	});

	if not isfolder(ConfigManager.Directory) then
		makefolder(ConfigManager.Directory);
	end;

	if not isfolder(Compkiller:_Path(ConfigManager.Directory , ConfigManager.Config)) then
		makefolder(Compkiller:_Path(ConfigManager.Directory , ConfigManager.Config));
	end;

	local Args = {
		Directory = Compkiller:_Path(ConfigManager.Directory , ConfigManager.Config);
		EnableNotify = false,
        Ignore = ConfigManager.Ignore or {},
        AutoLoadChanged = Compkiller.__SIGNAL(0),
	};

	local notify = Compkiller.newNotify();

    function Args:ConfigPath(name)
        if type(name) ~= "string" or name == "" or name == "." or name == ".."
            or name:find("[/\\:%c]") or name:lower() == "autoload.txt" then
            error("Invalid config name: expected a filename inside the config folder", 2)
        end
        return Compkiller:_Path(self.Directory, name)
    end

	function Args:WriteConfig(Config: WriteConfig)
		Config = Compkiller.__CONFIG(Config , {
			Name = "Config_" .. HttpService:GenerateGUID(false),
			Author = LocalPlayer.Name,
		});

		local Flags = Compkiller:GetConfig("MK");
        for flag, ignored in pairs(Args.Ignore) do
            if ignored then Flags[flag] = nil end
        end

		Flags["__INFORMATION"] = {
			Type = "Information",
			Author = Config.Author,
			Name = Config.Name,
			CreatedDate = Compkiller:GetDate()
		};

		local themeTable = {}
		for k, v in pairs(Compkiller.Colors) do
			if typeof(v) == "Color3" then
				themeTable[k] = {v.R * 255, v.G * 255, v.B * 255}
			end
		end
		Flags["__THEME"] = themeTable

		if Args.EnableNotify then
			notify.new({
				Title = "Configs",
				Icon = Compkiller:_GetIcon('settings'),
				Content = "Create config \""..Config.Name.."\""
			})
		end

		writefile(Args:ConfigPath(Config.Name) , HttpService:JSONEncode(Flags));
        Args.LastConfigName = Config.Name

	end;

	function Args:LoadConfigFromString(str: string)
		local decoded = HttpService:JSONDecode(str);

		local Flags = Compkiller:GetConfig("KV");

		for i,v in next , decoded do
			if type(v) == "table" and v.Flag and not Args.Ignore[v.Flag] then

				local Value = Flags[v.Flag];

				if Value then

					if v.Value.Type == "NormalElement" then
						Value.Functions:SetValue(v.Value.Value);

					elseif v.Value.Type == "ColorPicker" then

						local Color = Color3.new(v.Value.Color3.R,v.Value.Color3.G,v.Value.Color3.B);

						local Transparency = v.Value.Transparency;

						Value.Functions:SetValue(Color , Transparency);
					end;
				end;
			end
		end;
        if type(decoded.__THEME) == "table" then
            Compkiller:LoadThemeString(HttpService:JSONEncode(decoded.__THEME))
        end
	end;

	function Args:GetCurrentConfig()
		return Compkiller:GetConfig("MK")
	end;

	function Args:ReadInfo(ConfigName: string)
        local path = Args:ConfigPath(ConfigName)
        if not isfile(path) then return false end
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(readfile(path))
        end)
        if ok and type(decoded) == "table" and type(decoded.__INFORMATION) == "table" then
            return decoded.__INFORMATION
        end
        return false
    end;

	function Args:GetConfigs()
        local names = {}
        for _, path in ipairs(listfiles(Args.Directory)) do
            local name = path:match("([^/\\]+)$")
            if name and name:lower() ~= "autoload.txt" then
                local valid = pcall(function() Args:ConfigPath(name) end)
                if valid then table.insert(names, name) end
            end
        end
        return names
    end;

    function Args:GetFullConfigs()
        local configs = {}
        for _, name in ipairs(Args:GetConfigs()) do
            local info = Args:ReadInfo(name)
            if info then table.insert(configs, {Name = name, Info = info}) end
        end
        return configs
    end;

	function Args:DeleteConfig(ConfigName)
        if Args:GetAutoLoad() == ConfigName then Args:ClearAutoLoad() end
		local _path = Args:ConfigPath(ConfigName);

		if Args.EnableNotify then
			notify.new({
				Title = "Configs",
				Icon = Compkiller:_GetIcon('settings'),
				Content = "Delete config \""..ConfigName.."\""
			})
		end

		if isfile(_path) then
			delfile(_path);
		end;
	end;

	function Args:GetConfigCount()
		return #Args:GetConfigs();
	end;

	function Args:SetAutoLoad(ConfigName: string)
        Args:ConfigPath(ConfigName)
		writefile(Compkiller:_Path(Args.Directory, "autoload.txt"), ConfigName)
        Args.AutoLoadChanged:Fire((Args.AutoLoadChanged:GetValue() or 0) + 1)
	end

    function Args:ClearAutoLoad()
        local path = Compkiller:_Path(Args.Directory, "autoload.txt")
        if isfile(path) then delfile(path) end
        Args.AutoLoadChanged:Fire((Args.AutoLoadChanged:GetValue() or 0) + 1)
    end

	function Args:GetAutoLoad()
		local _path = Compkiller:_Path(Args.Directory, "autoload.txt")
		if isfile(_path) then
			return readfile(_path)
		end
		return nil
	end

	function Args:AutoLoad()
		local name = Args:GetAutoLoad()
		if name and name ~= "" then
            local valid, _path = pcall(function() return Args:ConfigPath(name) end)
            if not valid then return false end
			if isfile(_path) then
				return Args:LoadConfig(name)
			end
		end
		return false
	end

	function Args:LoadConfig(ConfigName: string)
		local _path = Args:ConfigPath(ConfigName);

		if isfile(_path) then
			local info = readfile(_path);

			local decoded = HttpService:JSONDecode(info);

			local Flags = Compkiller:GetConfig("KV");

			if Args.EnableNotify then
				notify.new({
					Title = "Configs",
					Icon = Compkiller:_GetIcon('settings'),
					Content = "Load config \""..ConfigName.."\""
				})
			end

			for i,v in next , decoded do
				if type(v) == "table" and v.Flag and not Args.Ignore[v.Flag] then

					local Value = Flags[v.Flag];

					if Value then

						if v.Value.Type == "NormalElement" then
							Value.Functions:SetValue(v.Value.Value);

						elseif v.Value.Type == "ColorPicker" then

							local Color = Color3.new(v.Value.Color3.R,v.Value.Color3.G,v.Value.Color3.B);

							local Transparency = v.Value.Transparency;

							Value.Functions:SetValue(Color , Transparency);
						end;
					end;
				end
			end;
            if type(decoded.__THEME) == "table" then
                Compkiller:LoadThemeString(HttpService:JSONEncode(decoded.__THEME))
            end
            Args.LastConfigName = ConfigName

            return true
		end;
        return false
	end;

	return Args;
end;

function Compkiller:Loader(IconId,Duration)
	local CompKiller = Instance.new("ScreenGui")

	CompKiller.Name = Compkiller:_RandomString()
	CompKiller.Parent = CoreGui
	CompKiller.Enabled = true
	CompKiller.ResetOnSpawn = false
	CompKiller.IgnoreGuiInset = true
	CompKiller.ZIndexBehavior = Enum.ZIndexBehavior.Global

	local Loader = Instance.new("Frame")
	local Icon = Instance.new("ImageLabel")
	local Vignette = Instance.new("ImageLabel")

	Loader.Name = Compkiller:_RandomString()
	Loader.Parent = CompKiller
	Loader.AnchorPoint = Vector2.new(0.5, 0.5)
	Loader.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Loader.BackgroundTransparency = 1
	Loader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Loader.BorderSizePixel = 0
	Loader.Position = UDim2.new(0.5, 0, 0.5, 0)
	Loader.Size = UDim2.new(1, 0, 1, 0)

	Icon.Name = Compkiller:_RandomString()
	Icon.Parent = Loader
	Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon.BackgroundTransparency = 1.000
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.BorderSizePixel = 0
	Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	Icon.Size = UDim2.new(0, 750, 0, 750)
	Icon.ZIndex = 100
	Icon.Image = IconId or "rbxassetid://102337949802265"
	Icon.ImageTransparency = 1

	Vignette.Name = Compkiller:_RandomString()
	Vignette.Parent = Loader
	Vignette.BackgroundTransparency = 1.000
	Vignette.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Vignette.BorderSizePixel = 0
	Vignette.Size = UDim2.new(1, 0, 1, 0)
	Vignette.Image = "rbxassetid://18720640102"
	Vignette.ImageColor3 = Compkiller.Colors.Highlight
	Vignette.ImageTransparency = 1
	Vignette.AnchorPoint = Vector2.new(0.5,0.5)
	Vignette.Position = UDim2.fromScale(0.5,0.5)

	Compkiller:_Animation(Loader,TweenInfo.new(0.55,Enum.EasingStyle.Quint),{
		BackgroundTransparency = 0.5
	});

	local Event = Instance.new('BindableEvent');

	task.delay(0.5,function()
		Compkiller:_Animation(Icon,TweenInfo.new(0.75,Enum.EasingStyle.Quint),{
			ImageTransparency = 0.01,
			Size = UDim2.new(0, 200, 0, 200)
		});

		task.delay(0.25,function()
			Compkiller:_Animation(Vignette,TweenInfo.new(5),{
				ImageTransparency = 0.2
			});

			task.wait(Duration or 4.5)

			Compkiller:_Animation(Vignette,TweenInfo.new(3,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				Size = UDim2.new(2, 0, 2, 0)
			});

			Compkiller:_Animation(Icon,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				ImageTransparency = 1,
			});

			Compkiller:_Animation(Loader,TweenInfo.new(1.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				BackgroundTransparency = 1
			});

			task.delay(0.1,function()
				Compkiller:_Animation(Vignette,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
					ImageTransparency = 1
				});

				task.wait(0.2)

				task.delay(3,function()
					CompKiller:Destroy();
				end)
			end)

			task.delay(0.6,function()
				Event:Fire();
			end)
		end)
	end);

	return {
		yield = function()
			return Event.Event:Wait();
		end	
	};
end;

function Compkiller.newNotify()
	if Compkiller.NOTIFY_CACHE then
		return Compkiller.NOTIFY_CACHE;
	end;

	local Notification = Instance.new("ScreenGui")
	local NotifyContainer = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Notification.Name = Compkiller:_RandomString()
	Notification.Parent = CoreGui
	Notification.ResetOnSpawn = false
	Notification.ZIndexBehavior = Enum.ZIndexBehavior.Global

	NotifyContainer.Name = Compkiller:_RandomString()
	NotifyContainer.Parent = Notification
	NotifyContainer.AnchorPoint = Vector2.new(1, 0)
	NotifyContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NotifyContainer.BackgroundTransparency = 1.000
	NotifyContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NotifyContainer.BorderSizePixel = 0
	NotifyContainer.Position = UDim2.new(1, -10, 0, 1)
	NotifyContainer.Size = UDim2.new(0, 100, 0, 100)

	UIListLayout.Parent = NotifyContainer
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 3)

    local notificationThreads = {};
    local function schedule(seconds, callback)
        local thread;
        thread = task.delay(seconds,function()
            notificationThreads[thread]=nil;
            if Notification.Parent then callback(); end;
        end);
        notificationThreads[thread]=true;
        return thread;
    end;
    Notification.Destroying:Connect(function()
        for thread in pairs(notificationThreads) do pcall(task.cancel,thread); end;
        table.clear(notificationThreads);
        if Compkiller.NOTIFY_CACHE and Compkiller.NOTIFY_CACHE.Root==Notification then Compkiller.NOTIFY_CACHE=nil; end;
    end);
	local LayoutREF = 0;

	Compkiller.NOTIFY_CACHE = {
        Root = Notification,
		new = function(Notify: Notify) : NotifyPayback
			Notify = Compkiller.__CONFIG(Notify, {
				Icon = Compkiller.Logo,
				Title = "Notification",
				Content = "Content",
				Duration = 3,
			});

			LayoutREF -= 5;

			local BlockFrame = Instance.new("Frame")
			local NotifyFrame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local CompLogo = Compkiller:_CreateBrandIcon(nil, Notify.Icon)
			local Header = Instance.new("TextLabel")
			local Body = Instance.new("TextLabel")
			local TimeLeftFrame = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local TimeLeft = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")

			BlockFrame.Name = Compkiller:_RandomString()
			BlockFrame.Parent = NotifyContainer
			BlockFrame.AnchorPoint = Vector2.new(1, 0)
			Compkiller:_BindPolishColor(BlockFrame, "BackgroundColor3", "Popup");
			BlockFrame.BackgroundTransparency = 1.000
			BlockFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BlockFrame.BorderSizePixel = 0
			BlockFrame.ClipsDescendants = false
			BlockFrame.Size = UDim2.new(0, 200, 0, 0)
			BlockFrame.LayoutOrder = LayoutREF;

			NotifyFrame.Name = Compkiller:_RandomString()
			NotifyFrame.Parent = BlockFrame
			Compkiller:_BindPolishColor(NotifyFrame, "BackgroundColor3", "Popup");
			NotifyFrame.BackgroundTransparency = 0.100
			NotifyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NotifyFrame.BorderSizePixel = 0
			NotifyFrame.ClipsDescendants = false
			NotifyFrame.Size = UDim2.new(1, 0, 1, -5)
			NotifyFrame.ZIndex = 2
			NotifyFrame.Position = UDim2.new(1,200,0,0)

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = NotifyFrame

			CompLogo.Name = Compkiller:_RandomString()
			CompLogo.Parent = NotifyFrame
			CompLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			CompLogo.BackgroundTransparency = 1.000
			CompLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CompLogo.BorderSizePixel = 0
			CompLogo.Position = UDim2.new(0, 6, 0, 6)
			CompLogo.Size = UDim2.new(0, 25, 0, 25)
			CompLogo.ZIndex = 4
			Compkiller:_SetIcon(CompLogo, Notify.Icon);

			Header.Name = Compkiller:_RandomString()
			Header.Parent = NotifyFrame
			Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Header.BackgroundTransparency = 1.000
			Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Header.BorderSizePixel = 0
			Header.Position = UDim2.new(0, 40, 0, 10)
			Header.Size = UDim2.new(1, -50, 0, 15)
			Header.ZIndex = 3
			Header.Font = Enum.Font.GothamBold
			Header.Text = Notify.Title
			Compkiller:_BindPolishColor(Header, "TextColor3", "SwitchColor");
			Header.TextSize = 14.000
			Header.TextXAlignment = Enum.TextXAlignment.Left

			Body.Name = Compkiller:_RandomString()
			Body.Parent = NotifyFrame
			Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Body.BackgroundTransparency = 1.000
			Body.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Body.BorderSizePixel = 0
			Body.Position = UDim2.new(0, 10, 0, 33)
			Body.Size = UDim2.new(1, -15, 0, 30)
			Body.ZIndex = 3
			Body.Font = Enum.Font.GothamMedium
			Body.Text = Notify.Content
			Compkiller:_BindPolishColor(Body, "TextColor3", "SwitchColor");
			Body.TextSize = 12.000
			Body.TextTransparency = 0.250
			Body.TextXAlignment = Enum.TextXAlignment.Left
			Body.TextYAlignment = Enum.TextYAlignment.Top

			TimeLeftFrame.Name = Compkiller:_RandomString()
			TimeLeftFrame.Parent = NotifyFrame
			TimeLeftFrame.AnchorPoint = Vector2.new(0, 1)
			TimeLeftFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TimeLeftFrame.BackgroundTransparency = 1.000
			TimeLeftFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TimeLeftFrame.BorderSizePixel = 0
			TimeLeftFrame.Position = UDim2.new(0, 0, 1, 1)
			TimeLeftFrame.Size = UDim2.new(1, 0, 0, 5)
			TimeLeftFrame.ZIndex = 5

			UICorner_2.CornerRadius = UDim.new(0, 4)
			UICorner_2.Parent = TimeLeftFrame

			TimeLeft.Name = Compkiller:_RandomString()
			TimeLeft.Parent = TimeLeftFrame
			TimeLeft.BackgroundColor3 = Compkiller.Colors.Highlight
			TimeLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TimeLeft.BorderSizePixel = 0
			TimeLeft.Size = UDim2.new(0, 0, 1, 0)
			TimeLeft.ZIndex = 5

			UICorner_3.CornerRadius = UDim.new(0, 1)
			UICorner_3.Parent = TimeLeft

            local progressETA = Compkiller.ProgressETA.New()
            local progressLabel, progressFraction = Body.Text, nil
            local function progressText()
                Body.Text = progressFraction ~= nil and Compkiller.ProgressETA.Update(progressETA, progressLabel, progressFraction) or progressLabel
            end

			local UpdateText = function()
				local TitleScale = TextService:GetTextSize(Header.Text,Header.TextSize,Header.Font,Vector2.new(math.huge,math.huge));
				local BodyScale = TextService:GetTextSize(Body.Text,Body.TextSize,Body.Font,Vector2.new(math.huge,math.huge));

				local MainX = (TitleScale.X >= BodyScale.X and TitleScale.X) or BodyScale.X;
				local MainY = TitleScale.Y + ((Body.Text:byte() and BodyScale.Y) or 1);

				if BlockFrame:GetAttribute('Already') then
					Compkiller:_Animation(BlockFrame,TweenInfo.new(0.3),{
						Size = UDim2.new(0,MainX + 55,0,MainY + 35)
					});
				else
					BlockFrame:SetAttribute('Already',true)
					BlockFrame.Size = UDim2.new(0, MainX + 45, 0, 0);

					Compkiller:_Animation(BlockFrame,TweenInfo.new(0.3),{
						Size = UDim2.new(0,MainX + 55,0,MainY + 35)
					});
				end;
			end;

			UpdateText();

			local Close = function()
				Compkiller:_Animation(NotifyFrame,TweenInfo.new(0.65,Enum.EasingStyle.Quint),{
					Position = UDim2.new(1,200,0,0)
				});

				task.wait(0.3);

				Compkiller:_Animation(BlockFrame,TweenInfo.new(0.3),{
					Size = UDim2.new(1,0,0,0)
				});

				task.wait(0.35)
				BlockFrame:Destroy();

			end;

			local Show = function()
				Compkiller:_Animation(NotifyFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint),{
					Position = UDim2.new(0,0,0,0)
				});
			end;

			if typeof(Notify.Duration) == 'number' and Notify.Duration ~= math.huge then
				Compkiller:_Animation(TimeLeft,TweenInfo.new(Notify.Duration + 0.2,Enum.EasingStyle.Linear),{
					Size = UDim2.new(1, 0, 1, 0)
				});

				return schedule(0.25,function()
					Show();

					schedule(Notify.Duration + 0.2,Close)
				end);
			end;

			Show();

			return {
				Title = function(self , new)
					Header.Text = new;
					UpdateText(); 
				end,

				Content = function(self , new)
                    progressLabel = new
                    progressText()
					UpdateText();
				end,

				SetProgress = function(self , new , Time)
                    progressFraction = new > 1 and new / 100 or new
                    progressText()
					if Time and Time <= 0 then
						TimeLeft.Size = UDim2.new(new, 0, 1, 0);

						UpdateText();
						return;
					end;

					if new > 1 then
						new = (new / 100);	
					end;

					Compkiller:_Animation(TimeLeft,TweenInfo.new(Time or 0.85,(Time and Enum.EasingStyle.Linear) or Enum.EasingStyle.Quint),{
						Size = UDim2.new(new, 0, 1, 0)
					});

					UpdateText();
				end,

				Close = Close,
			}
		end,
	};

	return Compkiller.NOTIFY_CACHE;
end;

-- ==========================================
-- BACKWARD COMPATIBILITY WRAPPER LAYER
-- ==========================================
local Players = game:GetService("Players")

function Compkiller:CreateWindow(name, isMulti)
	-- Automatically initialize the main window if it hasn't been initialized yet
	if not Compkiller._MainWindow then
		Compkiller._MainWindow = Compkiller.new({
			Name = name or "BUTTER",
			Keybind = "LeftAlt",
			Logo = "rbxassetid://102337949802265",
			Scale = Compkiller.Scale.Window,
			TextSize = 15
		})
		Compkiller._MainWindowCategory = Compkiller._MainWindow:DrawCategory({ Name = "Main" })
	end

	-- Determine Icon
	local icon = "apple"
	local lowerName = string.lower(name or "")
	if string.find(lowerName, "builder") then
		icon = "hammer"
	elseif string.find(lowerName, "farm") then
		icon = "coins"
	elseif string.find(lowerName, "quest") then
		icon = "target"
	end

	local function createWindowWrapper(tabObj, tabName)
		local windowWrapper = {
			Tab = tabObj,
			CurrentSection = nil,
			Name = tabName
		}

		local function ensureSection(wrapper)
			if not wrapper.CurrentSection then
				wrapper.CurrentSection = wrapper.Tab:DrawSection({
					Name = "Controls",
					Position = "left"
				})
			end
			return wrapper.CurrentSection
		end

		function windowWrapper:Section(sectionName, defaultExpanded)
			self.CurrentSection = self.Tab:DrawSection({
				Name = sectionName,
				Position = "left"
			})
			return self.CurrentSection
		end

		function windowWrapper:Toggle(...) local section = ensureSection(self) return section:Toggle(...) end
		function windowWrapper:Slider(...) local section = ensureSection(self) return section:Slider(...) end
		function windowWrapper:Dropdown(...) local section = ensureSection(self) return section:Dropdown(...) end
		function windowWrapper:ImageDropdown(...) local section = ensureSection(self) return section:ImageDropdown(...) end
		function windowWrapper:Box(...) local section = ensureSection(self) return section:Box(...) end
		function windowWrapper:Bind(...) local section = ensureSection(self) return section:Bind(...) end
		function windowWrapper:Button(...) local section = ensureSection(self) return section:Button(...) end
		function windowWrapper:Search(...) local section = ensureSection(self) return section:Search(...) end
		function windowWrapper:String(...) local section = ensureSection(self) return section:String(...) end

		return windowWrapper
	end

	if isMulti then
		local containerTab = Compkiller._MainWindow:DrawContainerTab({
			Name = name or "Tab",
			Icon = icon
		})

		local containerWrapper = {}
		function containerWrapper:Window(subTabName)
			local subTab = containerTab:DrawTab({
				Name = subTabName,
				Type = "Single",
				EnableScrolling = true
			})
			return createWindowWrapper(subTab, subTabName)
		end

		return containerWrapper
	else
		local tab = Compkiller._MainWindow:DrawTab({
			Name = name or "Tab",
			Icon = icon,
			Type = "Single",
			EnableScrolling = true
		})

		return createWindowWrapper(tab, name)
	end
end

-- Reusable Lumber-style task overlay. Caller owns Root/Destroy and its lifetime.
function Compkiller:CreateTaskProgress(config)
    config = config or {}
    local root = Instance.new("ScreenGui")
    root.Name = "ButterTaskProgress"
    root.ResetOnSpawn = false
    root.IgnoreGuiInset = true
    root.DisplayOrder = 100
    root.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ProtectGui(root)
    root.Parent = CoreGui

    local panel = Instance.new("Frame")
    panel.Name = "TaskProgress"
    panel.AnchorPoint = Vector2.new(0.5, 0)
    panel.Position = UDim2.new(0.5, 0, 0, 16)
    panel.Size = UDim2.new(1, -32, 0, 52)
    panel.BorderSizePixel = 0
    panel.BackgroundTransparency = 0.06
    panel.Visible = false
    panel.Parent = root
    local bounds = Instance.new("UISizeConstraint")
    bounds.MaxSize = Vector2.new(420, 52)
    bounds.Parent = panel
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = panel
    local stroke = Instance.new("UIStroke")
    stroke.Transparency = 0.3
    stroke.Parent = panel
    self:_BindPolishColor(panel, "BackgroundColor3", "Popup")
    self:_BindPolishColor(stroke, "Color", "StrokeColor")

    local icon = self:_CreateBrandIcon(panel)
    icon.Position = UDim2.fromOffset(12, 9)
    icon.Size = UDim2.fromOffset(20, 20)
    icon.AnchorPoint = Vector2.zero
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Position = UDim2.fromOffset(40, 9)
    title.Size = UDim2.new(1, -112, 0, 20)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextTruncate = Enum.TextTruncate.AtEnd
    title.Text = config.Title or "Working"
    title.Parent = panel
    self:_BindPolishColor(title, "TextColor3", "SwitchColor")
    local detail = Instance.new("TextLabel")
    detail.BackgroundTransparency = 1
    detail.AnchorPoint = Vector2.new(1, 0)
    detail.Position = UDim2.new(1, -12, 0, 9)
    detail.Size = UDim2.fromOffset(56, 20)
    detail.Font = Enum.Font.GothamBold
    detail.TextSize = 12
    detail.TextXAlignment = Enum.TextXAlignment.Right
    detail.Text = ""
    detail.Parent = panel
    self:_BindPolishColor(detail, "TextColor3", "Highlight")
    local track = Instance.new("Frame")
    track.Position = UDim2.fromOffset(12, 37)
    track.Size = UDim2.new(1, -24, 0, 5)
    track.BorderSizePixel = 0
    track.ClipsDescendants = true
    track.Parent = panel
    self:_BindPolishColor(track, "BackgroundColor3", "StrokeColor")
    local fill = Instance.new("Frame")
    fill.Size = UDim2.fromScale(0, 1)
    fill.BorderSizePixel = 0
    fill.Parent = track
    self:_BindPolishColor(fill, "BackgroundColor3", "Highlight")
    for _, object in ipairs({track, fill}) do
        local round = Instance.new("UICorner")
        round.CornerRadius = UDim.new(0, 3)
        round.Parent = object
    end

    local api = {Root = root, Panel = panel, Label = title, Detail = detail, Fill = fill}
    local animation, mode, value, destroyed
    local function cancel()
        if animation then animation:Cancel() animation = nil end
    end
    function api:Set(label, fraction, rightText)
        if destroyed then return end
        if label and title.Text ~= label then title.Text = label end
        rightText = rightText or ""
        if detail.Text ~= rightText then detail.Text = rightText end
        local nextMode = fraction == nil and "indeterminate" or "progress"
        local nextValue = fraction and math.clamp(fraction, 0, 1)
        if panel.Visible and mode == nextMode and value == nextValue then return end
        cancel()
        panel.Visible = true
        mode, value = nextMode, nextValue
        if fraction == nil then
            fill.Size = UDim2.fromScale(0.3, 1)
            fill.Position = UDim2.fromScale(-0.3, 0)
            animation = TweenService:Create(fill, TweenInfo.new(1.25, Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut, -1), {Position = UDim2.fromScale(1, 0)})
        else
            fill.Position = UDim2.fromScale(0, 0)
            animation = TweenService:Create(fill, TweenInfo.new(0.25), {Size = UDim2.fromScale(nextValue, 1)})
        end
        animation:Play()
    end
    function api:Hide()
        if destroyed then return end
        cancel()
        panel.Visible = false
        mode, value = nil, nil
    end
    function api:Destroy() root:Destroy() end
    root.Destroying:Connect(function() destroyed = true cancel() end)
    return api
end
return Compkiller;
