-- perl -i -pe 's/^[0-9]+\n//g' m.lua
-- sed -i 's/$/ = /; N; s/\n//' m.lua
-- sed -i -r 's/(^.*= )(.*)/\1"\2",/g' m.lua
-- sed -i -r 's/^((\s+)?)([a-zA-Z0-9_]+[^a-zA-Z0-9].*) =/\2["\3"] =/g' m.lua
-- sed -i -r 's/(^.*)/  \1/g' m.lua
-- https://locale.roblox.com/v1/locales

if _G["CurseGenni is asking whenever you want to proceed"] then return end
local cloneref = cloneref or function(o) return o end
COREGUI = cloneref(game:GetService("CoreGui"))

local Main = Instance.new("ScreenGui")

local syn_ = (not is_sirhurt_closure) and (syn and syn.protect_gui)
if syn_ then
  syn.protect_gui(Main)
end

Main.Name = "CurseGennie"
Main.ScreenInsets = Enum.ScreenInsets.None
Main.IgnoreGuiInset = true
Main.Parent = (not syn_ and (get_hidden_gui and get_hidden_gui()) or (gethui and gethui()) or COREGUI:FindFirstChild("RobloxGui") and COREGUI.RobloxGui) or COREGUI

local instance = (_G.CurseGennieInstance or 0) + 1
_G.CurseGennieInstance = instance

if instance > 1 then
  _G["CurseGenni is asking whenever you want to proceed"] = true
  local Proceed = false
  local Cover = Instance.new("Frame")
  local Warn = Instance.new("TextLabel")
  local No = Instance.new("TextButton")
  local DontWarnAgainAndProceed = Instance.new("TextButton")
  local Yes = Instance.new("TextButton")
  Cover.Position = UDim2.new(0, 0, 0, 0)
  Cover.Size = UDim2.new(1, 0, 1, 0)
  Cover.Parent = Main
  Warn.Position = UDim2.new(0.5, 0, 0.3, 0)
  Warn.AnchorPoint = Vector2.new(0.5, 0.3)
  Warn.Text = "CurseGenni has been loaded more than once\nDo you want to proceed?"
  Warn.TextSize = 25
  Warn.Parent = Cover
  No.AnchorPoint = Vector2.new(0, 1)
  No.Position = UDim2.new(0, 0.3, 1, 0)
  No.Size = UDim2.new(0, 50, 0, 30)
  No.Text = "No"
  No.TextScaled = true
  No.Parent = Cover
  DontWarnAgainAndProceed.AnchorPoint = Vector2.new(0.5, 1)
  DontWarnAgainAndProceed.Position = UDim2.new(0.5, 0.5, 1, 0)
  DontWarnAgainAndProceed.Size = UDim2.new(0, 200, 0, 30)
  DontWarnAgainAndProceed.Text = "Don't Warn Again And Proceed"
  DontWarnAgainAndProceed.TextScaled = true
  DontWarnAgainAndProceed.Parent = Cover
  Yes.AnchorPoint = Vector2.new(1, 1)
  Yes.Position = UDim2.new(1, -0.3, 1, 0)
  Yes.Size = UDim2.new(0, 50, 0, 30)
  Yes.Text = "Yes"
  Yes.TextScaled = true
  Yes.Parent = Cover
  No.MouseButton1Click:Connect(function()
    Main:Destroy()
    _G["CurseGen is asking whenever you want to proceed"] = false
    return
  end)
  DontWarnAgainAndProceed.MouseButton1Click:Connect(function()
    Proceed = true
    _G["CurseGen is asking whenever you want to proceed"] = false
    _G["CurseGenni Don't Ask Again"] = true
  end)
  Yes.MouseButton1Click:Connect(function()
    Proceed = true
    _G["CurseGen is asking whenever you want to proceed"] = false
  end)
  repeat task.wait() until Proceed
  Cover:Destroy()
end

HttpService = cloneref(game:GetService("HttpService"))
ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
UserInputService = cloneref(game:GetService("UserInputService"))
StarterGui = cloneref(game:GetService("StarterGui"))
TextChatService = cloneref(game:GetService("TextChatService"))
Chat = cloneref(game:GetService("Chat"))
Players = cloneref(game:GetService("Players"))
Player = Players.LocalPlayer

local isChatLegacy = (TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService)
local chatRemote = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
local textChannels = TextChatService:FindFirstChild("TextChannels")
local RBXGeneral = if textChannels then textChannels:FindFirstChild("RBXGeneral") else nil
local chatChannel = not isChatLegacy and RBXGeneral

local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform())
everyClipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

function SystemMsg(make, prop)
  if isChatLegacy then
    return StarterGui:SetCore(make, prop)
  else
    return RBXGeneral:DisplaySystemMessage(prop.Text)
  end
end

local Mode = true
local Invis = false
local FilterChecker = true
local FilterReset = true
local FilterResetForMode = false
local SwitcherChat = {"","",""}
local Toggle = false
local ToggleAddToStart = false
local BypassedIndicator = true
local Default_Language = "English"
local Prefix = true
local KeyToEnterFocus = "Slash"
local HUBFocus = false
local ScheduleHUBFocus = false
local HUBTmp = ""
local HubNewThread
local StoreLastBtnENUM_OnKeyPress = {}
local ClipBoardFeature = false
local PrefixGui = false

function Drag(gui, FunctionF)
  local dragging,dragclick,DragState,dragInput,dragStart,startPos

  local function update(input)
    local delta = input.Position - dragStart
    gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

  gui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging, dragclick = true, true
      task.wait()
      if dragging and gui.GuiState == Enum.GuiState.Press then
        DragState = true
      end
	  	dragStart = input.Position
		  startPos = gui.Position

	  	input.Changed:Connect(function()
	  		if input.UserInputState == Enum.UserInputState.End then
		  		dragging, DragState = false, false
		  		if dragclick and FunctionF then
		  		  FunctionF()
		  		end
	  		end
	  	end)
  	end
  end)

  gui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
	  	dragInput = input
	  	dragclick = false
	  end
  end)

  UserInputService.InputChanged:Connect(function(input)
	  if input == dragInput and dragging and DragState then
	  	update(input)
  	end
  end)
end

local BaseUpdate = {}
local Language = {
  Arabic = {
    Exit = "خروج",
    ["Spy Menu"] = "قائمة التجسس",
    Spy = "جاسوس",
    spyOnMyself = "التجسس على نفسي",
    public = "عام",
    publicItalics = "العام مائل",
    HideInvis = "إخفاء غير المرئي",
    Mute = "كتم الصوت",
    Unmute = "إلغاء كتم الصوت",
    Mode = "وضع",
    Invis = "غير مرئي",
    FilterChecker = "مدقق الفلاتر",
    FilterReset = "إعادة تعيين الفلاتر",
    FilterResetForMode = "إعادة تعيين الفلاتر للوضع",
    Log = "السجل",
    SaveAll = "حفظ الكل",
    DelSave = "حذف الحفظ",
    Language = "اللغة",
    ["Prefix Menu"] = "قائمة البادئة",
    Enable = "التمكين",
    English = "الإنجليزية",
    Arabic = "العربية",
    Spanish = "الإسبانية",
    Russian = "روسي",
    ["Typer..."] = "...تايبَر",
    Bypassed = "تم تجاوزه",
    Filtered = "مُرشح"
  },
  Spanish = {
    Exit = "Salir",
    ["Spy Menu"] = "Menú de espía",
    Spy = "espía",
    spyOnMyself = "espiar a mí mismo",
    public = "público",
    publicItalics = "público en cursiva",
    HideInvis = "OcultarInvis",
    Mute = "Silenciar",
    Unmute = "Activar sonido",
    Mode = "Modo",
    Invis = "Invisible",
    FilterChecker = "Comprobador de filtros",
    FilterReset = "Restablecer filtro",
    FilterResetForMode = "Restablecer filtro para modo",
    Log = "Registro",
    SaveAll = "Guardar todo",
    DelSave = "Eliminar guardado",
    Language = "Idioma",
    ["Prefix Menu"] = "Menú Prefijo",
    Enable = "Activar",
    English = "Inglés",
    Arabic = "Árabe",
    Spanish = "Español",
    Russian = "ruso",
    ["Typer..."] = "Teclista...",
    Bypassed = "eludido",
    Filtered = "Filtrado"
  },
  Russian = {
    Exit = "Выход",
    ["Spy Menu"] = "Меню шпиона",
    Spy = "шпион",
    spyOnMyself = "шпионить за собой",
    public = "публичный",
    publicItalics = "публичный курсив",
    HideInvis = "СкрытьНевидимое",
    Mute = "Отключить звук",
    Unmute = "Включить звук",
    Mode = "Режим обхождения",
    Invis = "Невидимость",
    FilterChecker = "Проверка фильтра",
    FilterReset = "Сброс фильтра",
    FilterResetForMode = "Сброс фильтра для режима",
    Log = "Журнал",
    SaveAll = "Сохранить все",
    DelSave = "Удалить сохранение",
    Language = "Язык",
    ["Prefix Menu"] = "Меню префикса",
    Enable = "Включить",
    English = "Английский",
    Arabic = "Арабский",
    Spanish = "Испанский",
    Russian = "русская",
    ["Typer..."] = "Печатать...",
    Bypassed = "Обойдено",
    Filtered = "Отфильтровано"
  }
}

local QuotesSendTextTable = {}

local QuotesSendTextTableNames = {}

-- Config
Config = {
	enabled = false,
	spyOnMyself = true,
	public = false,
	publicItalics = true,
	HideInvis = false,
	AntiSpy = false
}

-- Customizing Log Output
PrivateProperties = {
	Color = Color3.fromRGB(528, 183, 255);
	Font = Enum.Font.SourceSansBold;
	TextSize = 18;
}

local function trans(el, path, word, pick)
  el[path] = Default_Language == "English" and word or Default_Language and word and Language[Default_Language][word] or word or ""
  if pick == nil then
    BaseUpdate[#BaseUpdate + 1] = {word, el, path}
  end
end

function vtype(o, t)
  if o == nil then return false end
  if type(o) == "userdata" then return typeof(o) == t end
  return type(o) == t
end

local file = "CurseGennie.json"
if pcall(function() readfile(file) end) then
  if readfile(file) ~= nil then
    local success, response = pcall(function()
      local json = HttpService:JSONDecode(readfile(file))
      if vtype(json.ChatSpy, "boolean") then Config.enabled = json.ChatSpy end
      if vtype(json.ChatSpyOnMySelf, "boolean") then Config.spyOnMyself = json.ChatSpyOnMySelf end
      if vtype(json.ChatSpyPublic, "boolean") then Config.public = json.ChatSpyPublic end
      if vtype(json.ChatSpyPublicItalics, "boolean") then Config.publicItalics = json.ChatSpyPublicItalics end
      if vtype(json.ChatSpyHideInvis, "boolean") then Config.HideInvis = json.ChatSpyHideInvis end
      if vtype(json.ChatSpyAntiSpy, "boolean") then Config.AntiSpy = json.ChatSpyAntiSpy end
      if vtype(json.Mode, "boolean") then Mode = json.Mode end
      if vtype(json.Invis, "boolean") then Invis = json.Invis end
      if vtype(json.FilterChecker, "boolean") then FilterChecker = json.FilterChecker end
      if vtype(json.FilterReset, "boolean") then FilterReset = json.FilterReset end
      if vtype(json.FilterResetForMode, "boolean") then FilterResetForMode = json.FilterResetForMode end
      if vtype(json.Default_Language, "string") then Default_Language = json.Default_Language end
      if vtype(json.Prefix, "boolean") then Prefix = json.Prefix end
      if vtype(json.KeyToEnterFocus, "string") then KeyToEnterFocus = json.KeyToEnterFocus end
      if vtype(json.ClipBoardFeature, "boolean") then ClipBoardFeature = json.ClipBoardFeature end
      if vtype(json.PrefixGui, "boolean") then PrefixGui = json.PrefixGui end
    end)
  end
end

function update_saver()
  local update = {
    ChatSpy = Config.enabled;
    ChatSpyOnMySelf = Config.spyOnMyself;
    ChatSpyPublic = Config.public;
    ChatSpyPublicItalics = Config.publicItalics;
    ChatSpyHideInvis = Config.HideInvis;
    ChatSpyAntiSpy = Config.AntiSpy;
    Mode = Mode;
    Invis = Invis;
    FilterChecker = FilterChecker;
    FilterReset = FilterReset;
    FilterResetForMode = FilterResetForMode;
    Default_Language = Default_Language;
    Prefix = Prefix;
    KeyToEnterFocus = KeyToEnterFocus;
    ClipBoardFeature = ClipBoardFeature;
    PrefixGui = PrefixGui;
  }

  writefile(file, HttpService:JSONEncode(update))
end

local EntryBtn = Instance.new("TextButton")
local EntryBtnUICorner = Instance.new("UICorner")

local PrefixBtn = Instance.new("TextButton")
local PrefixBtnUICorner = Instance.new("UICorner")

local Frame = Instance.new("ScrollingFrame")
local FrameUICorner = Instance.new("UICorner")

local Folder1 = Instance.new("Folder")
local HUB = Instance.new("TextButton")
local HUBUICorner = Instance.new("UICorner")
local HUBUIStroke = Instance.new("UIStroke")
local Gear = Instance.new("TextButton")
local GearUICorner = Instance.new("UICorner")
local GearUIStroke = Instance.new("UIStroke")

local ClearButton = Instance.new("TextButton")
local ClearButtonUICorner = Instance.new("UICorner")
local ClearButtonUIStroke = Instance.new("UIStroke")

local AddToStart = Instance.new("TextButton")
local AddToStartUICorner = Instance.new("UICorner")
local AddToStartUIStroke = Instance.new("UIStroke")

local PrivateChat = Instance.new("TextButton")
local PrivateChatUICorner = Instance.new("UICorner")
local PrivateChatUIStroke = Instance.new("UIStroke")

local EnterKeyboardWithoutReset = Instance.new("TextButton")
local EnterKeyboardWithoutResetUICorner = Instance.new("UICorner")
local EnterKeyboardWithoutResetUIStroke = Instance.new("UIStroke")

local TextBox = Instance.new("TextBox")
local PrefixBox = Instance.new("TextBox")
local Warner = Instance.new("TextButton")

local Folder2 = Instance.new("Folder")
local Folder2GridLayout = Instance.new("UIGridLayout")

local SpyFolder = Instance.new("Folder")
local SpyFolderGridLayout = Instance.new("UIGridLayout")

local Folder3 = Instance.new("Folder")
local Folder3GridLayout = Instance.new("UIGridLayout")

local FolderSlash = Instance.new("Folder")
local FolderSlashGridLayout = Instance.new("UIGridLayout")

EntryBtn.Text = ""
EntryBtn.Position = UDim2.new(0.7, 0, 0.7, 0)
EntryBtn.Size = UDim2.new(0, 35, 0, 35)
EntryBtn.BackgroundColor3 = Color3.fromRGB(139, 195, 74)
EntryBtn.Visible = false
EntryBtn.Parent = Main

EntryBtnUICorner.CornerRadius = UDim.new(0, 50)
EntryBtnUICorner.Parent = EntryBtn

PrefixBtn.Text = ""
PrefixBtn.Position = UDim2.new(0.7, 0, 0.7, 0)
PrefixBtn.Size = UDim2.new(0, 35, 0, 35)
PrefixBtn.BackgroundColor3 = Color3.fromRGB(137, 243, 54)
PrefixBtn.Visible = PrefixGui
PrefixBtn.Parent = Main

PrefixBtnUICorner.CornerRadius = UDim.new(0, 50)
PrefixBtnUICorner.Parent = PrefixBtn

Frame.AnchorPoint = Vector2.new(0.7, 1)
Frame.Position = UDim2.new(0.7, 0, 1, -3)
Frame.Size = UDim2.new(0, 350, 0, 250)
Frame.BackgroundColor3 = Color3.fromRGB(158, 158, 158)
Frame.Active = true
Frame.ScrollingDirection = Enum.ScrollingDirection.Y
Frame.CanvasSize = UDim2.new(0, 0, 0, 0)
Frame.Parent = Main

FrameUICorner.CornerRadius = UDim.new(0, 6)
FrameUICorner.Parent = Frame

Folder1.Parent = Frame

HUB.AnchorPoint = Vector2.new(1, 0)
HUB.Position = UDim2.new(1, -52, 0, 3)
HUB.Size = UDim2.new(0, 45, 0, 45)
HUB.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
HUB.Text = ""
HUB.Parent = Folder1

HUBUICorner.CornerRadius = UDim.new(0, 5)
HUBUICorner.Parent = HUB

HUBUIStroke.Thickness = 30
HUBUIStroke.Parent = HUB

Gear.AnchorPoint = Vector2.new(1, 0)
Gear.Position = UDim2.new(1, -3, 0, 3)
Gear.Size = UDim2.new(0, 45, 0, 45)
Gear.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
Gear.Text = ""
Gear.Parent = Folder1

GearUICorner.CornerRadius = UDim.new(0, 5)
GearUICorner.Parent = Gear

GearUIStroke.Thickness = 30
GearUIStroke.Parent = Gear

ClearButton.AnchorPoint = Vector2.new(1, 1)
ClearButton.Position = UDim2.new(1, -144, 0, 115)
ClearButton.Size = UDim2.new(0, 45, 0, 35)
ClearButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ClearButton.Text = ""
ClearButton.Parent = Folder1

ClearButtonUICorner.CornerRadius = UDim.new(0, 5)
ClearButtonUICorner.Parent = ClearButton

ClearButtonUIStroke.Thickness = 30
ClearButtonUIStroke.Parent = ClearButton

AddToStart.AnchorPoint = Vector2.new(1, 1)
AddToStart.Position = UDim2.new(1, -97, 0, 115)
AddToStart.Size = UDim2.new(0, 45, 0, 35)
AddToStart.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
AddToStart.Text = ""
AddToStart.Parent = Folder1

AddToStartUICorner.CornerRadius = UDim.new(0, 5)
AddToStartUICorner.Parent = AddToStart

AddToStartUIStroke.Thickness = 30
AddToStartUIStroke.Parent = AddToStart

PrivateChat.AnchorPoint = Vector2.new(1, 1)
PrivateChat.Position = UDim2.new(1, -50, 0, 115)
PrivateChat.Size = UDim2.new(0, 45, 0, 35)
PrivateChat.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
PrivateChat.Text = ""
PrivateChat.Parent = Folder1

PrivateChatUICorner.CornerRadius = UDim.new(0, 5)
PrivateChatUICorner.Parent = PrivateChat

PrivateChatUIStroke.Thickness = 30
PrivateChatUIStroke.Parent = PrivateChat

EnterKeyboardWithoutReset.AnchorPoint = Vector2.new(1, 1)
EnterKeyboardWithoutReset.Position = UDim2.new(1, -3, 0, 115)
EnterKeyboardWithoutReset.Size = UDim2.new(0, 45, 0, 35)
EnterKeyboardWithoutReset.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
EnterKeyboardWithoutReset.Text = ""
EnterKeyboardWithoutReset.Parent = Folder1

EnterKeyboardWithoutResetUICorner.CornerRadius = UDim.new(0, 5)
EnterKeyboardWithoutResetUICorner.Parent = EnterKeyboardWithoutReset

EnterKeyboardWithoutResetUIStroke.Thickness = 30
EnterKeyboardWithoutResetUIStroke.Parent = EnterKeyboardWithoutReset

TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
TextBox.Position = UDim2.new(0.5, 0, 0.5, 15)
TextBox.Size = UDim2.new(0.95, 0, 0, 45)
TextBox.ClipsDescendants = true
TextBox.TextSize = 30
TextBox.Text = ""
trans(TextBox, "PlaceholderText", "Typer...")
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderColor3 = Color3.fromRGB(121, 85, 72)
TextBox.Parent = Folder1

PrefixBox.AnchorPoint = Vector2.new(0.5, 0.5)
PrefixBox.Position = UDim2.new(0.5, 0, 0.5, 0)
PrefixBox.Size = UDim2.new(1, 0, 0, 65)
PrefixBox.ClipsDescendants = true
PrefixBox.TextSize = 45
PrefixBox.Text = ""
trans(PrefixBox, "PlaceholderText", "Typer...")
PrefixBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PrefixBox.PlaceholderColor3 = Color3.fromRGB(121, 85, 72)
PrefixBox.Visible = false
PrefixBox.Parent = Main

Warner.AnchorPoint = Vector2.new(0.5, 0.5)
Warner.Position = UDim2.new(0.5, 0, 0.5, 65)
Warner.Size = UDim2.new(0.95, 0, 0, 45)
Warner.TextSize = 30
trans(Warner, "Text", "Bypassed", 0)
Warner.BackgroundColor3 = Color3.fromRGB(137, 243, 54)
Warner.Parent = Folder1

Folder2GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
Folder2GridLayout.CellPadding= UDim2.new(0, 0, 0, 0)
Folder2GridLayout.CellSize = UDim2.new(1, 0, 0, 60)
Folder2GridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Folder2GridLayout.Parent = Folder2

SpyFolderGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
SpyFolderGridLayout.CellPadding= UDim2.new(0, 0, 0, 0)
SpyFolderGridLayout.CellSize = UDim2.new(1, 0, 0, 60)
SpyFolderGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SpyFolderGridLayout.Parent = SpyFolder

Folder3GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
Folder3GridLayout.CellPadding= UDim2.new(0, 0, 0, 0)
Folder3GridLayout.CellSize = UDim2.new(1, 0, 0, 60)
Folder3GridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Folder3GridLayout.Parent = Folder3

FolderSlashGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
FolderSlashGridLayout.CellPadding= UDim2.new(0, 0, 0, 0)
FolderSlashGridLayout.CellSize = UDim2.new(1, 0, 0, 60)
FolderSlashGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
FolderSlashGridLayout.Parent = FolderSlash

function DisplayGui(Get)
  Frame.Visible = Get
  EntryBtn.Visible = not Get
end

local function OpenClick()
  DisplayGui(false)
end

local function CloseClick()
  DisplayGui(true)
end

local function PrefixBtnClick()
  PrefixBox.Visible = true
  PrefixBox:CaptureFocus()
end

Drag(Frame, OpenClick)
Drag(EntryBtn, CloseClick)
Drag(PrefixBtn, PrefixBtnClick)

function chatsend(str)
  if isChatLegacy then
    chatRemote:FireServer(str, "All")
  else
    chatChannel:SendAsync(str)
  end
end

function proxycall(str)
  if Chat:FilterStringAsync(str, Player, Player) ~= str then
    BypassedIndicator = false
    trans(Warner, "Text", "Filtered", 0)
    Warner.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    PrefixBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    if FilterChecker and not ClipBoardFeature then
      return
    end
  else
    BypassedIndicator = true
    trans(Warner, "Text", "Bypassed", 0)
    Warner.BackgroundColor3 = Color3.fromRGB(137, 243, 54)
    PrefixBtn.BackgroundColor3 = Color3.fromRGB(137, 243, 54)
  end
  if Invis then
    Players:Chat(str)
  else
    if ClipBoardFeature then
      everyClipboard(str)
    else
      chatsend(str)
    end
  end
end

local fromDump = {
  america = "america",
  AMERICA = "AMERICA",
  America = "America",
  anal = "аnаӏ",
  ANAL = "АΝАL",
  Anna = "Anna",
  anti = "anti",
  ANTI = "ANTI",
  ASS = "ASS",
  ass = "ass",
  asses = "assesِ",
  ASSES = "ASSES",
  asshole = "asshoӏe",
  ASSHOLE = "AِЅЅНОLЕ",
  al = "al",
  bastard = "bِastard",
  BASTARD = "BAჽTARD",
  Bastard = "Bِastard",
  bdsm = "bِdsm",
  BDSM = "BDჽM",
  beaner = "beaⴖer",
  BEANER = "BِEANER",
  bisexual = "bisِexual",
  BISEXUAL = "BIჽEXUAL",
  black = "bӏack",
  bitch = "bِitch",
  bitches = "bِitches",
  BITCHES = "BِITCHES",
  BITCH = "BِITCH",
  blox = "blox",
  blowjob = "bӏowjob",
  blowjobs = "bӏowjobs",
  BLOWJOB = "В〪LOWJОВ",
  bondage = "boⴖdage",
  BONDAGE = "BِONDAGE",
  boob = "bِооb",
  boobies = "bِооbies",
  boobs = "bِооbs",
  BOOBS = "BِООВЅ",
  BOOB = "BِООВ",
  booty = "bِooty",
  BOOTY = "BِООTY",
  bong = "boⴖg",
  BONG = "BِONG",
  boner = "boⴖer",
  Boner = "Boⴖer",
  BONER = "BِONER",
  breast = "breast",
  breasts = "bꞅeasts",
  breed = "breed",
  bypass = "bypass",
  brazz = "braⴭⴭ",
  BRAZZ = "BRAჍჍ",
  call = "call",
  chong = "choⴖg",
  coochie = "cِِoochie",
  cocaine = "cocaiⴖe",
  childfucker = "childfบcker",
  CHILDFUCKER = "CHILDꜰUCKER",
  chink = "chink",
  CHINK = "CHINK",
  clit = "cӏit",
  CLIT = "CLlT",
  commie = "commie",
  commies = "commies",
  COMMIE = "COMMIE",
  COMMIES = "COMMIES",
  COCK = "ᲃОСK",
  Cock = "ᲃосk",
  cocksuck = "cِِосksِuck",
  COCKSUCK = "ᲃОСKႽUCK",
  cocksucker = "cِِосksِucker",
  COCKSUCKER = "ᲃОСKSِUСKЕR",
  condom = "coⴖdom",
  consent = "coⴖsent",
  consented = "coⴖsented",
  CONDOM = "ᲃONDOM",
  CONSENT = "ᲃONSENT",
  CONSENTED = "ᲃONSENTED",
  coon = "coon",
  crack = "crack",
  creampie = "cꞅeampie",
  Creampie = "ᲃreampie",
  CREAMPIE = "ᲃREAMPIE",
  cuck = "cบck",
  Cuck = "Cบck",
  CUCK = "ᲃUCK",
  cum = "cบm",
  CUM = "ᴄᴜᴍ",
  ["cบmming"] = "cumming",
  CUMMING = "CUᴍᴍING",
  cumslut = "cบmsӏut",
  CUMSLUT = "ᲃUMჽLUT",
  cunt = "cบnt",
  cunnie = "cบnnie",
  cunts = "cบnts",
  CUNT = "ᲃUNT",
  chair = "chair",
  ching = "ching",
  deepthroat = "deepthꞅoat",
  DEEPTHROAT = "DِEEPTHROAT",
  deadass = "dِeadass",
  dirty = "dirty",
  DIRTY = "DIRTY",
  dildo = "diӏdo",
  DILDO = "DِILDO",
  DICK = "ÐICK",
  dick = "dِick",
  dogfucker = "dogfบcker",
  DOGFUCKER = "DOGꜰUCKER",
  drug = "drug",
  drunk = "drบnk",
  discord = "discoꞅd",
  DISCORD = "ÐISCORD",
  drugs = "drบgs",
  DRUG = "DRUG",
  DRUGS = "ÐRUGS",
  dumbass = "dบmbass",
  DUMBASS = "ÐUMBASS",
  email = "emaiӏ",
  fagg = "fِagg",
  Fagg = "ꜰagg",
  faggot = "fِaggot",
  Faggot = "ꜰaggot",
  FAGGOT = "ꜰAGGOT",
  faggots = "fِaggots",
  FAGGOTS = "ꜰAGGOTS",
  fags = "fags",
  fatass = "fِatass",
  Fatass = "Fِatass",
  fatasses = "fatasses",
  FATASS = "ꜰATASS",
  fi = "fi",
  FI = "FI",
  fl = "fl",
  FUCK = "ꜰUCK",
  fuck = "fบck",
  Fuck = "ꜰuck",
  fucking = "fบсkіng",
  FUCKING = "ꜰUCKING",
  fuckable = "fบckable",
  FUCKABLE = "ꜰUCKABLE",
  fuckboy = "fบckboy",
  Fuckboy = "ꜰuckboy",
  FUCKBOY = "ꜰUCKBOY",
  fucked = "fบcked",
  fucker = "fบcker",
  fucks = "fบcks",
  Fucked = "ꜰucked",
  Fucker = "ꜰucker",
  Fucks = "ꜰucks",
  FUCKED = "ꜰUCKED",
  FUCKER = "ꜰUCKER",
  FUCKS = "ꜰUCKS",
  fucktard = "fบcktard",
  Fucktard = "ꜰucktard",
  FUCKTARD = "ꜰUCKTARD",
  fucktoy = "fบcktoy",
  FUCKTOY = "ꜰUCKTOY",
  Fucktoy = "ꜰucktoy",
  give = "give",
  girl = "girӏ",
  Girl = "Girӏ",
  GIRL = "GIRL",
  grop = "gꞅop",
  GROP = "GׅROP",
  Grop = "Gꞅop",
  genocide = "geⴖocide",
  Genocide = "Geⴖocide",
  google = "googӏe",
  Google = "Googӏe",
  have = "have",
  handjob = "haⴖdjob",
  heil = "heiӏ",
  hentai = "heⴖtai",
  Hentai = "Heⴖtai",
  HENTAI = "HِENTAI",
  Heil = "Heiӏ",
  HEIL = "HEIL",
  hitler = "hitӏer",
  Hitler = "Hitӏer",
  HEIL = "HِEIL",
  HITLER = "HِITLER",
  HOE = "HOE",
  hoe = "hoe",
  holy = "holy",
  homosexual = "homosِexual",
  Homosexual = "Homosِexual",
  hooker = "hookeꞅ",
  horny = "horⴖy",
  Hooker = "Hookeꞅ",
  Horny = "Horⴖy",
  HOMOSEXUAL = "HOMOSِEXUAL",
  HOOKER = "HِOOKER",
  HORNY = "HِORNY",
  instagram = "iⴖstagram",
  INSTAGRAM = "IِNSTAGRAM",
  isis = "iِsِiِsِ",
  im = "im",
  ip = "ip",
  IP = "IP",
  id = "id",
  il = "il",
  is = "is",
  le = "le",
  ig = "ig",
  iv = "iv",
  ie = "ie",
  ll = "ll",
  ir = "ir",
  ii = "ii",
  ly = "ly",
  lo = "lo",
  im = "im",
  IM = "IM",
  ld = "ld",
  ft = "ft",
  ic = "ic",
  ix = "ix",
  INE = "INE",
  ING = "ING",
  jesus = "jesus",
  Jesus = "Jesus",
  jackass = "jِackass",
  JACKASS = "JِACKASS",
  jungle = "jungӏe",
  jew = "jew",
  jews = "jews",
  jerking = "jِerking",
  JERKMATE = "JِERKMATE",
  job = "jِob",
  jig = "jِig",
  jigaboo = "jِigaboo",
  jiggaboo = "jِiggaboo",
  Jig = "Jِig",
  kkk = "kِkِkِ",
  KKK = "KِKِKِ",
  kys = "kys",
  kill = "kill",
  Kill = "ᴋill",
  KILL = "KِILL",
  killing = "killing",
  killed = "kiӏӏed",
  KILLING = "KILLING",
  KILLED = "KِILLED",
  knife = "knife",
  KNIFE = "KNIFE",
  kiss = "kiss",
  kissing = "kissing",
  KISS = "KISS",
  KISSING = "KISSING",
  kinky = "kiⴖky",
  kike = "kِike",
  KINKY = "Kiⴖky",
  lap = "ӏap",
  LMAO = "LMAO",
  lmao = "ӏmao",
  love = "ӏove",
  like = "like",
  LIKE = "LIKE",
  luck = "luck",
  lust = "ӏust",
  LUST = "LِUST",
  Lust = "Lบst",
  liberal = "liberal",
  LIBERAL = "LIBERAL",
  Liberal = "Liberal",
  lsd = "ӏsd",
  LSD = "LِSD",
  lgbtq = "ӏgbtq",
  mexican = "mexican",
  MEXICAN = "MEXICAN",
  myass = "myaِss",
  MYASS = "MYAِSS",
  mississippi = "mississippi",
  MISSISSIPPI = "MISSISSIPPI",
  molest = "mِolest",
  Molest = "Mِolest",
  MOLEST = "MOLEჽT",
  motherfucker = "motherfบcker",
  Motherfucker = "Motherfบcker",
  motherfucking = "motherfบcking",
  MOTHERFUCKER = "MOTHERꜰUCKER",
  MOTHERFUCKING = "MOTHERꜰUCKING",
  naked = "ⴖaked",
  Naked = "Nِaked",
  nazi = "naⴭi",
  NAZI = "NAჍI",
  negro = "ⴖegro",
  Negro = "Nِegro",
  negroes = "ⴖegroes",
  NAKED = "NِAKED",
  NEGRO = "NِEGRO",
  NEGROES = "NِEGROES",
  nice = "nice",
  NICE = "NICE",
  NIGGA = "NlGGA",
  Nigga = "Nِigga",
  nig = "ⴖig",
  niger = "ⴖiger",
  nigeria = "ⴖigeria",
  niglet = "nigӏet",
  nigg = "ⴖigg",
  Nigg = "Nِigg",
  NIGG = "NِIGG",
  niggers = "ⴖiggers",
  NIGGER = "NِIGGER",
  NIGGERS = "NِِIGGERS",
  ["Nِiggerჽex"] = "NiggerSex",
  nsfw = "ⴖsfw",
  Nsfw = "Nِsfw",
  nude = "ⴖude",
  Nude = "Nِude",
  nudes = "ⴖudes",
  Nudes = "Nِudes",
  NSFW = "NِSFW",
  NUDE = "NِUDE",
  NUDES = "ΝِUDES",
  orgy = "oꞅgy",
  ORGY = "OِRGY",
  penis = "peⴖis",
  PENIS = "PENIჽ",
  PORNHUB = "PِORNHUB",
  PORN = "PِORN",
  Porn = "Porⴖ",
  pussy = "pบssy",
  Pussy = "Pบssy",
  PUSSY = "PUჽჽY",
  prostitute = "prostitบte",
  PROSTITUTE = "PِِROSTITUTE",
  pick = "pick",
  phile = "phiӏe",
  pedophile = "pedophiӏe",
  racist = "racist",
  rape = "rаре",
  Rape = "Rаре",
  RAPE = "RАРЕ",
  raped = "rаpеd",
  Raped = "rаpеd",
  RAPED = "RАPЕD",
  raping = "rapiⴖg",
  rapist = "rаріѕt",
  rapists = "rapіѕtѕ",
  RAPIST = "RАPӀЅТ",
  Raping = "Rapiⴖg",
  Rapist = "Rаріѕt",
  raghead = "ꞅaghead",
  Raghead = "Rِaghead",
  RAGHEAD = "RِAGHEAD",
  redskin = "redskiⴖ",
  Redskin = "Redskiⴖ",
  retard = "ꞅetard",
  RETARD = "RِِETARD",
  roblox = "roblox",
  republican = "republican",
  Republican = "Republican",
  says = "sِays",
  Says = "Sِays",
  SAYS = "SِAYS",
  script = "script",
  semen = "semeⴖ",
  Semen = "Semeⴖ",
  SEMEN = "ჽEMEN",
  seduc = "sِeduc",
  Seduced = "ჽeduc",
  SEDUC = "SEDUC",
  sex = "sِex",
  Sex = "ჽex",
  SEX = "ჽEX",
  sexist = "sِexist",
  sext = "sِext",
  sextoy = "sِextoy",
  sexual = "sِexual",
  sexy = "sِexy",
  sexdoll = "sِexdoll",
  Sexdoll = "Sِexdoll",
  shit = "sِhit",
  Shit = "ჽhit",
  SHIT = "ჽНӀТ",
  should = "should",
  shot = "sِhot",
  Shot = "ჽhot",
  spic = "sِpic",
  Spic = "ჽpic",
  SPIC = "ჽPIC",
  SIEG = "SIEG",
  SLAVE = "ჽLAVE",
  slave = "sӏave",
  SLAVERY = "ჽLAVERY",
  SLAVES = "ჽLAVES",
  Slave = "Sӏave",
  slur = "sӏur",
  slut = "ѕӏut",
  SLUT = "ჽLUT",
  Slut = "Ѕӏut",
  strip = "sِtrip",
  STRIP = "ჽTRIP",
  sucker = "sบcker",
  Sucker = "Sบcker",
  SUCKER = "ჽUCKER",
  SUCKING = "SUCKING",
  snapchat = "sⴖapchat",
  Snapchat = "Sⴖapchat",
  sperm = "sِperm",
  Sperm = "ჽperm",
  sperms = "sِperms",
  SNAPCHAT = "ჽNAPCHAT",
  SPERM = "ჽPERM",
  stupid = "sِtupid",
  suicide = "sบicide",
  TARD = "TِARD",
  terrorist = "tِerrorist",
  terrorism = "tِerrorism",
  this = "thisِ",
  THIS = "THIჽ",
  threesome = "tِhreesome",
  Threesome = "Tِhreesome",
  THREESOME = "THREEჽOME",
  thong = "thoⴖg",
  tits = "tِits",
  titt = "tίtt",
  titties = "tίtties",
  TITTIES = "TِITTIES",
  Titt = "Tίtt",
  Tits = "Tِits",
  tiktok = "tiktok",
  TONIGHT = "TONIGHT",
  tranny = "traⴖⴖy",
  trannie = "traⴖⴖie",
  TRANNY = "TِRANNY",
  TRANNIE = "TRANNlE",
  TRUMP = "TRUMР",
  trump = "trumр",
  twat = "tِwat",
  Twat = "Tِwat",
  TWAT = "ِTِWAT",
  twink = "twiⴖk",
  twinks = "twinks",
  vagina = "vagiⴖa",
  Vagina = "Vagiⴖa",
  weed = "wِeed",
  Weed = "Wِeed",
  WEED = "WِEED",
  well = "well",
  wetback = "wِetback",
  Wetback = "Wِetback",
  WETBACK = "WِETBACK",
  whore = "wِhore",
  Whore = "Wِhore",
  whores = "wِhores",
  Whores = "Wِhores",
  WHORE = "WِHORE",
  white = "wһіtе",
  White = "Wһіtе",
  xxx = "xِxِxِ",
  XXX = "XِXِXِ",
  youtube = "youtบbe",
  YOUTUBE = "YِOUTUBE",
  Youtube = "Youtบbe",
  yourself = "yِourself",
  zoophile = "zoophiIe"
}
local fromDumpSmall = {
  g = "g",
  i = "i",
  j = "jِ",
  l = "l",
  y = "y",
  I = "l"
}

KazakhProperties = {
	Color = Color3.fromRGB(255, 0, 0);
	Font = Enum.Font.SourceSansBold;
	Text = "Change your language to Қазақ Тілі";
	TextSize = 18;
}

-- Checking if the Қазақ Тілі language is the default
if Chat:FilterStringAsync(fromDump.PORNHUB, Player, Player) ~= fromDump.PORNHUB then
  SystemMsg("ChatMakeSystemMessage", KazakhProperties)
end

local numberOfStrings = 8
function randomString()
	local length = math.random(80, 90)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(0, 1) == 0 and math.random(65, 90) or math.random(97, 122))
	end
	return table.concat(array)
end

local function broadcastMessage(modified)
  Players:Chat("/e " .. modified)
end

local function execBroadCastMessage()
  for i = 1, numberOfStrings do
    broadcastMessage(randomString())
  end
end

function check(o)
  local str = {}
  for k in o:gmatch("%S+") do
    local pattern = k:gsub("[%p%c%s]", "")
    str[#str + 1] = fromDump[pattern] or fromDumpSmall[pattern] or (function()
      for kk,v in fromDump do
        local startIndex, endIndex = k:find(kk)
        if startIndex == nil and endIndex == nil then continue end
        return k:sub(1, startIndex - 1) .. fromDump[k:sub(startIndex, endIndex)] .. k:sub(endIndex + 1)
      end
      return nil
    end)() or k
  end
  return table.concat(str, "\b")
end

function proxy(TextBox)
  if (Mode or FilterResetForMode) and FilterReset then
    execBroadCastMessage()
  end
  local str = Toggle and SwitcherChat[1] or TextBox.text
  local GetStr = (Mode and check(str) or str)
  if not isChatLegacy and SwitcherChat[2] ~= "" then
    local User = Players[SwitcherChat[2]]
    local send = textChannels:FindFirstChild("RBXWhisper:" .. User.UserId .. "_" .. Player.UserId)
    if not send then
      RBXGeneral:SendAsync("/w " .. User.DisplayName)
    end
    send:SendAsync(GetStr)
  else
    proxycall((isChatLegacy and SwitcherChat[2] ~= "" and "/w " .. SwitcherChat[2] .. " " or "") .. (SwitcherChat[3]) .. GetStr)
  end
end

Warner.MouseButton1Click:Connect(function()
  proxy(TextBox)
end)

local function ResetHubFocus()
  HUBFocus = false
  ScheduleHUBFocus = false
  HUB.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
end

local lastquotetime = 0
TextBox.FocusLost:Connect(function(EnterPressed, InputObject)
  if HUBFocus and not ScheduleHUBFocus then
    ScheduleHUBFocus = true
    local arg = TextBox.Text
    TextBox.Text = HUBTmp
    local Quotes = QuotesSendTextTable[tonumber(arg)] or QuotesSendTextTable[QuotesSendTextTableNames[arg:lower()]]
    local startquotetime = tick()
    local WasLastDelayed = false
    if Quotes then
      HubNewThread = task.spawn(function()
        for i = 1, #Quotes do
          local v = Quotes[i]
          if not tonumber(v) then if Quotes.bypass then execBroadCastMessage() end chatsend(Quotes.bypass and check(v:gsub("cock","dick"):gsub("enslaved","enslav.ed"):gsub("HOLE","H.OLE")) or v) end
          if #Quotes ~= i then task.wait(tonumber(v) or Quotes.delay or 2) end
        end
        ResetHubFocus()
      end)
    else
      ResetHubFocus()
    end
    return
  end
  if Toggle then
    SwitcherChat[2] = TextBox.Text
  end
  if EnterPressed then
    proxy(TextBox)
  end
end)

PrefixBox.FocusLost:Connect(function(EnterPressed, InputObject)
  PrefixBox.Visible = false
  if EnterPressed then
    proxy(PrefixBox)
  end
end)

HUB.MouseButton1Click:Connect(function()
  HUBFocus = not HUBFocus
  HUB.BackgroundColor3 = HUBFocus and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 152, 0)
  if HUBFocus then
    HUBTmp = TextBox.text
    TextBox:CaptureFocus()
  else
    if HubNewThread then
      task.cancel(HubNewThread)
    end
    ResetHubFocus()
  end
end)

Gear.MouseButton1Click:Connect(function()
  Folder1.Parent = nil
  Folder2.Parent = Frame
  Frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
end)

local PeopleBtn = {}
local Blacklist = {}

local instance, getmsg, MeCmd, instance
if isChatLegacy then
  instance = (_G.chatSpyInstance or 0) + 1
  _G.chatSpyInstance = instance
  getmsg = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
  MeCmd = getupvalue and rawget(getupvalue((getrawmetatable or getmetatable)(require(Chat.ClientChatModules.ChatSettings)).__index, 1), "AllowMeCommand") == true or false
end

local function onChatted(p, msg)
  if _G.chatSpyInstance == instance then
    if Config.enabled and (Config.spyOnMyself == true or p ~= Player) then
		  msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
			local hidden = not Config.HideInvis
			local conn = getmsg.OnClientEvent:Connect(function(packet, channel)
			  if packet.SpeakerUserId == p.UserId and packet.Message == msg:sub(#msg - #packet.Message + 1) then
			    hidden = true
			  end
			  if packet.SpeakerUserId == p.UserId and packet.Message == msg:sub(#msg - #packet.Message + 1) and (channel == "All" or (channel == "Team" and Config.public == false and Players[packet.FromSpeaker].Team == Player.Team)) then
			    hidden = false
				end
			end)
			task.wait(1)
			conn:Disconnect()
			if hidden and Config.enabled and Blacklist[p.UserId] == nil then
				if Config.public then
					chatsend((Config.publicItalics and MeCmd and "/me " or '') .. "{SPY} [" .. p.Name .."]: " .. msg)
				else
					PrivateProperties.Text = "{SPY} [" .. p.Name .. "]: " .. msg
					SystemMsg("ChatMakeSystemMessage", PrivateProperties)
				end
			end
		end
	end
end

if isChatLegacy then
  for _,p in Players:GetPlayers() do
    p.Chatted:Connect(function(msg) onChatted(p,msg) end)
  end

  Players.PlayerAdded:Connect(function(p)
  	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
  end)

  PrivateProperties.Text = "{SPY "..(Config.enabled and "EN" or "DIS").."ABLED}"
  SystemMsg("ChatMakeSystemMessage", PrivateProperties)
  local chatFrame = Player.PlayerGui.Chat.Frame
  chatFrame.ChatChannelParentFrame.Visible = true
	chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
end

local Color = {
  [true] = Color3.fromRGB(50, 205, 50),
  [false] = Color3.fromRGB(255, 0, 0)
}

local function addi(label, fun, Parent)
  local Label = type(label) == "table" and label[1] or label
  local btn = Instance.new("TextButton")
  trans(btn, "Text", Label)
  btn.TextScaled = true
  if label[2] ~= nil then
    btn.BackgroundColor3 = Color[label[2]]
  end
  btn.MouseButton1Click:Connect(function()
    fun(btn)
  end)
  btn.Parent = Parent
  return btn
end

local function add(label, fun)
  return addi(label, fun, Folder2)
end

add("Exit", function()
  Folder1.Parent = Frame
  Folder2.Parent = nil
  Frame.AutomaticCanvasSize = Enum.AutomaticSize.None
end)

if isChatLegacy then
  add({"Spy Menu", nil}, function()
    Folder2.Parent = nil
    SpyFolder.Parent = Frame
    ChatSpyOnAddedRefreshJoined = Players.PlayerAdded:Connect(ChatSpyOnRefresh)
    ChatSpyOnAddedRefreshLeft = Players.PlayerRemoving:Connect(ChatSpyOnRefresh)
    ChatSpyOnRefresh()
  end)
end

add("Mute", function()
  StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
end)

add("Unmute", function()
  StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
end)

add({"Mode", Mode}, function(btn)
  Mode = not Mode
  btn.BackgroundColor3 = Color[Mode]
end)

add({"Invis", Invis}, function(btn)
  Invis = not Invis
  btn.BackgroundColor3 = Color[Invis]
end)

add({"FilterChecker", FilterChecker}, function(btn)
  FilterChecker = not FilterChecker
  btn.BackgroundColor3 = Color[FilterChecker]
end)

add({"FilterReset", FilterReset}, function(btn)
  FilterReset = not FilterReset
  btn.BackgroundColor3 = Color[FilterReset]
end)

add({"FilterResetForMode", FilterResetForMode}, function(btn)
  FilterResetForMode = not FilterResetForMode
  btn.BackgroundColor3 = Color[FilterResetForMode]
end)

add("Log", function()
end)

if writefile and readfile then
  add("SaveAll", function()
    update_saver()
  end)
end

if delfile then
  add("DelSave", function()
    delfile(file)
  end)
end

add("Language", function()
  Folder2.Parent = nil
  Folder3.Parent = Frame
end)

add({"Prefix Menu"}, function(btn)
  Folder2.Parent = nil
  FolderSlash.Parent = Frame
end)

addi("Exit", function(btn)
  Folder2.Parent = Frame
  FolderSlash.Parent = nil
end, FolderSlash)

addi({"Enable", Prefix}, function(btn)
  Prefix = not Prefix
  btn.BackgroundColor3 = Color[Prefix]
end, FolderSlash)

for k,v in Enum.KeyCode:GetEnumItems() do
  local key = tostring(v):match("[^.]+$")
  StoreLastBtnENUM_OnKeyPress[key] = addi({key, KeyToEnterFocus == key}, function(btn)
    StoreLastBtnENUM_OnKeyPress[KeyToEnterFocus].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
    KeyToEnterFocus = key
  end, FolderSlash)
end

if IsOnMobile and keyclick or keypress and keyrelease then
  add("F9", function()
    if keyclick then
      keyclick(Enum.KeyCode.F9)
    else
      keypress(Enum.KeyCode.F9)
      keyrelease(Enum.KeyCode.F9)
    end
  end)
end

if everyClipboard then
  add({"Clip", ClipBoardFeature}, function(btn)
    ClipBoardFeature = not ClipBoardFeature
    btn.BackgroundColor3 = Color[ClipBoardFeature]
  end)
end

add({"Prefix Gui", PrefixGui}, function(btn)
  PrefixGui = not PrefixGui
  btn.BackgroundColor3 = Color[PrefixGui]
  PrefixBtn.Visible = PrefixGui
end)

addi("Exit", function(btn)
  Folder2.Parent = Frame
  Folder3.Parent = nil
end, Folder3)

local function LanAdd(k)
  local btn = Instance.new("TextButton")
  trans(btn, "Text", k)
  btn.TextScaled = true
  btn.Parent = Folder3
  btn.MouseButton1Click:Connect(function()
    Default_Language = k
    for _,btn in BaseUpdate do
      trans(btn[2], btn[3], btn[1], 0)
    end
    trans(Warner, "Text", BypassedIndicator and "Bypassed" or "Filtered", 0)
  end)
end

LanAdd("English")
for k in Language do
  LanAdd(k)
end

addi("Exit", function(btn)
  Folder2.Parent = Frame
  SpyFolder.Parent = nil
  ChatSpyOnAddedRefreshJoined:Disconnect()
  ChatSpyOnAddedRefreshLeft:Disconnect()
end, SpyFolder)

addi({"Spy", Config.enabled}, function(btn)
  Config.enabled = not Config.enabled
  btn.BackgroundColor3 = Color[Config.enabled]
  task.wait(0.3)
  PrivateProperties.Text = "{SPY " .. (Config.enabled and "EN" or "DIS") .. "ABLED}"
  SystemMsg("ChatMakeSystemMessage", PrivateProperties)
end, SpyFolder)

addi({"spyOnMyself", Config.spyOnMyself}, function(btn)
  Config.spyOnMyself = not Config.spyOnMyself
  btn.BackgroundColor3 = Color[Config.spyOnMyself]
end, SpyFolder)

addi({"public", Config.public}, function(btn)
  Config.public = not Config.public
  btn.BackgroundColor3 = Color[Config.public]
end, SpyFolder)

addi({"publicItalics", Config.publicItalics}, function(btn)
  Config.publicItalics = not Config.publicItalics
  btn.BackgroundColor3 = Color[Config.publicItalics]
end, SpyFolder)

addi({"HideInvis", Config.HideInvis}, function(btn)
  Config.HideInvis = not Config.HideInvis
  btn.BackgroundColor3 = Color[Config.HideInvis]
end, SpyFolder)

local function AntiSpyFunc()
  while Config.AntiSpy do
    task.wait()
    Players:Chat("/e " .. randomString())
  end
end

addi({"AntiSpy", Config.AntiSpy}, function(btn)
  Config.AntiSpy = not Config.AntiSpy
  btn.BackgroundColor3 = Color[Config.AntiSpy]
  AntiSpyFunc()
end, SpyFolder)

local SpyFolderColor = Instance.new("TextBox")
SpyFolderColor.TextScaled = true
SpyFolderColor.Text = tostring(PrivateProperties.Color)
SpyFolderColor.FocusLost:Connect(function()
  if #SpyFolderColor.text:split(",") == 3 then
    PrivateProperties.Color = Color3.fromRGB(unpack(SpyFolderColor.text:split(",")));
  end
  SpyFolderColor.Text = tostring(PrivateProperties.Color)
end)
SpyFolderColor.Parent = SpyFolder

function ChatSpyOnRefresh()
  for k,v in PeopleBtn do
    v:Destroy()
    PeopleBtn[k] = nil
  end
  for _,plr in Players:GetPlayers() do
    if plr == Player then continue end
    local btn = Instance.new("TextButton")
    btn.TextScaled = true
    btn.Text = plr.Name
    btn.BackgroundColor3 = Blacklist[plr.UserId] and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(50, 205, 50)
    btn.MouseButton1Click:Connect(function()
      Blacklist[plr.UserId] = Blacklist[plr.UserId] == nil and true or nil
      btn.BackgroundColor3 = Blacklist[plr.UserId] and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(50, 205, 50)
    end)
    btn.Parent = SpyFolder
    table.insert(PeopleBtn, btn)
  end
end

ClearButton.MouseButton1Click:Connect(function()
  TextBox.Text = ""
  SwitcherChat[Toggle and 2 or ToggleAddToStart and 3 or 1] = ""
end)

local function ToggleBtn(toggle, n, btn)
  SwitcherChat[toggle and 1 or n] = TextBox.text
  btn.BackgroundColor3 = toggle and Color3.fromRGB(255, 192, 203) or Color3.fromRGB(255, 152, 0)
  TextBox.Text = SwitcherChat[toggle and n or 1]
end

AddToStart.MouseButton1Click:Connect(function()
  if Toggle then return end
  ToggleAddToStart = not ToggleAddToStart
  ToggleBtn(ToggleAddToStart, 3, AddToStart)
end)

PrivateChat.MouseButton1Click:Connect(function()
  if ToggleAddToStart then return end
  Toggle = not Toggle
  ToggleBtn(Toggle, 2, PrivateChat)
end)

function getPlayersByName(Name)
  local Found = {}
  for _,plr in Players:GetPlayers() do
    local OnlyHash = Name:sub(1,1) == '@'
    if string.find(plr.Name:lower(), Name:lower():sub(OnlyHash and 2 or 1), 1, true) == 1 or not OnlyHash and string.find(plr.DisplayName:lower(), Name:lower(), 1, true) == 1 then
      table.insert(Found, plr)
    end
  end
  return Found
end

TextBox:GetPropertyChangedSignal('Text'):Connect(function()
  if not Toggle then return end
  local SearchingPlayer = getPlayersByName(TextBox.text)
  if #SearchingPlayer == 1 then
    TextBox.Text = SearchingPlayer[1].Name
  end
end)

EnterKeyboardWithoutReset.MouseButton1Click:Connect(function()
  TextBox.ClearTextOnFocus = false
  TextBox:CaptureFocus()
  TextBox.ClearTextOnFocus = true
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode[KeyToEnterFocus] and not TextBox:IsFocused() and Prefix and not gameProcessed then
	  TextBox:CaptureFocus()
	end
end)

AntiSpyFunc()