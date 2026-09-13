local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeamsService = game:GetService("Teams")
local Camera = workspace.CurrentCamera

-- PROTEÇÃO ANTI-DUPLICAÇÃO
if PlayerGui:FindFirstChild("RavenModFull") then
    PlayerGui.RavenModFull:Destroy()
end

if _G.RavenConnections then
    for _, conexao in pairs(_G.RavenConnections) do
        if conexao then conexao:Disconnect() end
    end
end
_G.RavenConnections = {}

-- ScreenGui Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RavenModFull"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Frames dos Menus
local FramePrincipal = Instance.new("Frame")
local FrameTPPlayers = Instance.new("Frame")

-- Estilização da Janela Principal
FramePrincipal.Parent = ScreenGui
FramePrincipal.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
FramePrincipal.Position = UDim2.new(0.05, 0, 0.2, 0)
FramePrincipal.Size = UDim2.new(0, 220, 0, 320)
FramePrincipal.Active = true
FramePrincipal.Draggable = true 

local CantosMenu = Instance.new("UICorner")
CantosMenu.CornerRadius = UDim.new(0, 16) 
CantosMenu.Parent = FramePrincipal

local Titulo = Instance.new("TextLabel")
Titulo.Parent = FramePrincipal
Titulo.Size = UDim2.new(1, 0, 0, 35)
Titulo.BackgroundTransparency = 1
Titulo.Text = "Raven Mod"
Titulo.TextColor3 = Color3.fromRGB(180, 100, 255)
Titulo.Font = Enum.Font.SourceSansBold
Titulo.TextSize = 17

local BotaoFechar = Instance.new("TextButton")
BotaoFechar.Parent = FramePrincipal
BotaoFechar.Size = UDim2.new(0, 25, 0, 25)
BotaoFechar.Position = UDim2.new(1, -30, 0, 5)
BotaoFechar.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
BotaoFechar.Text = "X"
BotaoFechar.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoFechar.Font = Enum.Font.SourceSansBold
BotaoFechar.TextSize = 14
local CantosFechar = Instance.new("UICorner")
CantosFechar.CornerRadius = UDim.new(0, 6)
CantosFechar.Parent = BotaoFechar

-- Submenu TP Players
FrameTPPlayers.Parent = ScreenGui
FrameTPPlayers.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
FrameTPPlayers.Position = UDim2.new(0.27, 0, 0.2, 0)
FrameTPPlayers.Size = UDim2.new(0, 230, 0, 320)
FrameTPPlayers.Active = true
FrameTPPlayers.Draggable = true
FrameTPPlayers.Visible = false 

local CantosTP = Instance.new("UICorner")
CantosTP.CornerRadius = UDim.new(0, 16)
CantosTP.Parent = FrameTPPlayers

local TituloTP = Instance.new("TextLabel")
TituloTP.Parent = FrameTPPlayers
TituloTP.Size = UDim2.new(1, 0, 0, 35)
TituloTP.BackgroundTransparency = 1
TituloTP.Text = "TP Players & Lista"
TituloTP.TextColor3 = Color3.fromRGB(180, 100, 255)
TituloTP.Font = Enum.Font.SourceSansBold
TituloTP.TextSize = 16

local BotaoFecharTP = Instance.new("TextButton")
BotaoFecharTP.Parent = FrameTPPlayers
BotaoFecharTP.Size = UDim2.new(0, 25, 0, 25)
BotaoFecharTP.Position = UDim2.new(1, -30, 0, 5)
BotaoFecharTP.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
BotaoFecharTP.Text = "X"
BotaoFecharTP.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoFecharTP.Font = Enum.Font.SourceSansBold
BotaoFecharTP.TextSize = 14
local CantosFecharTP = Instance.new("UICorner")
CantosFecharTP.CornerRadius = UDim.new(0, 6)
CantosFecharTP.Parent = BotaoFecharTP

local CaixaNomePlayer = Instance.new("TextBox")
local BotaoIrParaPlayer = Instance.new("TextButton")
local BotaoLoopTP = Instance.new("TextButton")
local BotaoAtualizarLista = Instance.new("TextButton")
local ContainerListaPlayers = Instance.new("ScrollingFrame")
local LayoutListaPlayers = Instance.new("UIListLayout")

CaixaNomePlayer.Parent = FrameTPPlayers
CaixaNomePlayer.Size = UDim2.new(0.9, 0, 0, 26)
CaixaNomePlayer.Position = UDim2.new(0.05, 0, 0.12, 0)

BotaoIrParaPlayer.Parent = FrameTPPlayers
BotaoIrParaPlayer.Size = UDim2.new(0.43, 0, 0, 26)
BotaoIrParaPlayer.Position = UDim2.new(0.05, 0, 0.22, 0)

BotaoLoopTP.Parent = FrameTPPlayers
BotaoLoopTP.Size = UDim2.new(0.43, 0, 0, 26)
BotaoLoopTP.Position = UDim2.new(0.52, 0, 0.22, 0)

BotaoAtualizarLista.Parent = FrameTPPlayers
BotaoAtualizarLista.Size = UDim2.new(0.9, 0, 0, 22)
BotaoAtualizarLista.Position = UDim2.new(0.05, 0, 0.32, 0)

ContainerListaPlayers.Parent = FrameTPPlayers
ContainerListaPlayers.Size = UDim2.new(0.9, 0, 0, 180)
ContainerListaPlayers.Position = UDim2.new(0.05, 0, 0.40, 0)
ContainerListaPlayers.BackgroundTransparency = 1
ContainerListaPlayers.BorderSizePixel = 0
ContainerListaPlayers.ScrollBarThickness = 4
ContainerListaPlayers.ScrollBarImageColor3 = Color3.fromRGB(120, 50, 180)
ContainerListaPlayers.AutomaticCanvasSize = Enum.AutomaticSize.Y

LayoutListaPlayers.Parent = ContainerListaPlayers
LayoutListaPlayers.Padding = UDim.new(0, 3)
LayoutListaPlayers.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ScrollingFrame Principal
local ContainerScroll = Instance.new("ScrollingFrame")
ContainerScroll.Parent = FramePrincipal
ContainerScroll.Size = UDim2.new(1, 0, 1, -40)
ContainerScroll.Position = UDim2.new(0, 0, 0, 35)
ContainerScroll.BackgroundTransparency = 1
ContainerScroll.BorderSizePixel = 0
ContainerScroll.ScrollBarThickness = 4
ContainerScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 50, 180)
ContainerScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local LayoutBotoes = Instance.new("UIListLayout")
LayoutBotoes.Parent = ContainerScroll
LayoutBotoes.Padding = UDim.new(0, 8)
LayoutBotoes.HorizontalAlignment = Enum.HorizontalAlignment.Center

local EspacoFim = Instance.new("Frame")
EspacoFim.Parent = ContainerScroll
EspacoFim.Size = UDim2.new(1, 0, 0, 10)
EspacoFim.BackgroundTransparency = 1

-- Ícone Flutuante
local BotaoAbrir = Instance.new("TextButton")
BotaoAbrir.Parent = ScreenGui
BotaoAbrir.Size = UDim2.new(0, 50, 0, 50)
BotaoAbrir.Position = UDim2.new(0.02, 0, 0.2, 0) 
BotaoAbrir.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
BotaoAbrir.Text = "R"
BotaoAbrir.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoAbrir.Font = Enum.Font.SourceSansBold
BotaoAbrir.TextSize = 24
BotaoAbrir.Visible = false 
BotaoAbrir.Active = true
BotaoAbrir.Draggable = true 

local CantosIcone = Instance.new("UICorner")
CantosIcone.CornerRadius = UDim.new(1, 0)
CantosIcone.Parent = BotaoAbrir

-- Elementos das Funções Principais
local BotaoSpeed = Instance.new("TextButton")
local CaixaSpeed = Instance.new("TextBox")

local BotaoJump = Instance.new("TextButton")
local CaixaJump = Instance.new("TextBox")

local BotaoFly = Instance.new("TextButton")
local CaixaFly = Instance.new("TextBox")

local BotaoSalvar1 = Instance.new("TextButton")
local BotaoTP1 = Instance.new("TextButton")
local BotaoSalvar2 = Instance.new("TextButton")
local BotaoTP2 = Instance.new("TextButton")

local BotaoAbrirMenuTP = Instance.new("TextButton")
local BotaoESP = Instance.new("TextButton")
local BotaoNoclip = Instance.new("TextButton")
local BotaoInfJump = Instance.new("TextButton")
local BotaoWalkFling = Instance.new("TextButton")
local BotaoReset = Instance.new("TextButton")
local BotaoDiscord = Instance.new("TextButton")

-- Funções de Estilização
local function criarParLadoALado(elemEsq, elemDir, layoutOrder)
    local ContainerGrupo = Instance.new("Frame")
    ContainerGrupo.Parent = ContainerScroll
    ContainerGrupo.Size = UDim2.new(0.9, 0, 0, 35)
    ContainerGrupo.BackgroundTransparency = 1
    if layoutOrder then ContainerGrupo.LayoutOrder = layoutOrder end

    elemEsq.Parent = ContainerGrupo
    elemEsq.Size = UDim2.new(0.48, 0, 1, 0)
    elemEsq.Position = UDim2.new(0, 0, 0, 0)

    elemDir.Parent = ContainerGrupo
    elemDir.Size = UDim2.new(0.48, 0, 1, 0)
    elemDir.Position = UDim2.new(0.52, 0, 0, 0)
end

local function estilizarBotao(botao, texto, corFundo)
    botao.BackgroundColor3 = corFundo
    botao.Text = texto
    botao.TextColor3 = Color3.fromRGB(255, 255, 255)
    botao.Font = Enum.Font.SourceSansSemibold
    botao.TextSize = 12
    local cantos = Instance.new("UICorner")
    cantos.CornerRadius = UDim.new(0, 8)
    cantos.Parent = botao
end

local function estilizarCaixa(caixa, textoPadrao, placeholder)
    caixa.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    caixa.Text = textoPadrao
    caixa.PlaceholderText = placeholder
    caixa.TextColor3 = Color3.fromRGB(220, 180, 255)
    caixa.Font = Enum.Font.SourceSansSemibold
    caixa.TextSize = 12
    local cantos = Instance.new("UICorner")
    cantos.CornerRadius = UDim.new(0, 8)
    cantos.Parent = caixa
end

local function estilizarBotaoLargo(botao, texto, corFundo, layoutOrder)
    botao.Parent = ContainerScroll
    botao.Size = UDim2.new(0.9, 0, 0, 35)
    botao.LayoutOrder = layoutOrder
    estilizarBotao(botao, texto, corFundo)
end

-- Estilização de Elementos
estilizarBotao(BotaoSpeed, "Aplicar Speed", Color3.fromRGB(90, 40, 140))
estilizarCaixa(CaixaSpeed, "100", "Speed...")

estilizarBotao(BotaoJump, "Aplicar Jump", Color3.fromRGB(90, 40, 140))
estilizarCaixa(CaixaJump, "100", "Jump...")

estilizarBotao(BotaoFly, "Fly: OFF", Color3.fromRGB(70, 20, 50))
estilizarCaixa(CaixaFly, "50", "Fly Speed...")

estilizarBotao(BotaoSalvar1, "Set WP 1", Color3.fromRGB(50, 30, 90))
estilizarBotao(BotaoTP1, "TP 1", Color3.fromRGB(120, 45, 120))
estilizarBotao(BotaoSalvar2, "Set WP 2", Color3.fromRGB(50, 30, 90))
estilizarBotao(BotaoTP2, "TP 2", Color3.fromRGB(120, 45, 120))

criarParLadoALado(CaixaSpeed, BotaoSpeed, 1)
criarParLadoALado(CaixaJump, BotaoJump, 2)
criarParLadoALado(CaixaFly, BotaoFly, 3)
criarParLadoALado(BotaoSalvar1, BotaoTP1, 4)
criarParLadoALado(BotaoSalvar2, BotaoTP2, 5)

estilizarBotaoLargo(BotaoAbrirMenuTP, "🌐 TP Players & Times", Color3.fromRGB(130, 40, 180), 6)
estilizarBotaoLargo(BotaoESP, "ESP Players (Spy): OFF", Color3.fromRGB(70, 20, 50), 7)
estilizarBotaoLargo(BotaoNoclip, "Noclip: OFF", Color3.fromRGB(70, 20, 50), 8)
estilizarBotaoLargo(BotaoInfJump, "Infinite Jump: OFF", Color3.fromRGB(70, 20, 50), 9)
estilizarBotaoLargo(BotaoWalkFling, "Walk Fling: OFF", Color3.fromRGB(70, 20, 50), 10)
estilizarBotaoLargo(BotaoReset, "Reset Character", Color3.fromRGB(120, 30, 30), 11)
estilizarBotaoLargo(BotaoDiscord, "Discord (Copiar)", Color3.fromRGB(88, 101, 242), 12)

EspacoFim.LayoutOrder = 13
LayoutBotoes.SortOrder = Enum.SortOrder.LayoutOrder

-- Estilos do Submenu TP
estilizarCaixa(CaixaNomePlayer, "", "Nick do Player...")
estilizarBotao(BotaoIrParaPlayer, "Teleport (1x)", Color3.fromRGB(120, 45, 120))
estilizarBotao(BotaoLoopTP, "Loop: OFF", Color3.fromRGB(70, 20, 50))
estilizarBotao(BotaoAtualizarLista, "🔄 Atualizar Lista", Color3.fromRGB(50, 30, 90))

-- Controle de Janelas
BotaoFechar.MouseButton1Click:Connect(function()
    FramePrincipal.Visible = false 
    FrameTPPlayers.Visible = false
    BotaoAbrir.Visible = true 
end)

BotaoAbrir.MouseButton1Click:Connect(function()
    FramePrincipal.Visible = true 
    BotaoAbrir.Visible = false 
end)

BotaoAbrirMenuTP.MouseButton1Click:Connect(function()
    FrameTPPlayers.Visible = not FrameTPPlayers.Visible
end)

BotaoFecharTP.MouseButton1Click:Connect(function()
    FrameTPPlayers.Visible = false
end)

-- --- LÓGICAS DO JOGO ---
local pontoSalvo1, pontoSalvo2 = nil, nil
local espAtivo, noclipAtivo, flyAtivo, infJumpAtivo, walkFlingAtivo, loopTPAtivo = false, false, false, false, false, false
local bodyVelocity, bodyGyro = nil, nil

local function obterComponentes()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart"), char:WaitForChild("Humanoid"), char
end

local function buscarPlayerAlvo(texto)
    local textoDigitado = string.lower(texto)
    if textoDigitado == "" then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if string.find(string.lower(p.Name), textoDigitado) or string.find(string.lower(p.DisplayName), textoDigitado) then
                return p
            end
        end
    end
    return nil
end

-- Atualizar Lista de Players
local function atualizarListaMenuTP()
    for _, item in ipairs(ContainerListaPlayers:GetChildren()) do
        if item:IsA("TextLabel") or item:IsA("TextButton") then item:Destroy() end
    end
    local times = TeamsService:GetTeams()
    local function criarBotaoPlayer(p)
        local BotaoPlayer = Instance.new("TextButton")
        BotaoPlayer.Parent = ContainerListaPlayers
        BotaoPlayer.Size = UDim2.new(1, 0, 0, 22)
        BotaoPlayer.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
        BotaoPlayer.Text = "  • " .. p.DisplayName .. " (@" .. p.Name .. ")"
        BotaoPlayer.TextColor3 = Color3.fromRGB(220, 220, 220)
        BotaoPlayer.Font = Enum.Font.SourceSans
        BotaoPlayer.TextSize = 12
        BotaoPlayer.TextXAlignment = Enum.TextXAlignment.Left

        local cantos = Instance.new("UICorner")
        cantos.CornerRadius = UDim.new(0, 4)
        cantos.Parent = BotaoPlayer
        BotaoPlayer.MouseButton1Click:Connect(function() CaixaNomePlayer.Text = p.Name end)
    end

    if #times > 0 then
        for _, time in ipairs(times) do
            local LabelTime = Instance.new("TextLabel")
            LabelTime.Parent = ContainerListaPlayers
            LabelTime.Size = UDim2.new(1, 0, 0, 18)
            LabelTime.BackgroundTransparency = 1
            LabelTime.Text = "--- " .. time.Name .. " ---"
            LabelTime.TextColor3 = time.TeamColor.Color
            LabelTime.Font = Enum.Font.SourceSansBold
            LabelTime.TextSize = 13
            for _, p in ipairs(time:GetPlayers()) do if p ~= LocalPlayer then criarBotaoPlayer(p) end end
        end
    else
        for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then criarBotaoPlayer(p) end end
    end
end
BotaoAtualizarLista.MouseButton1Click:Connect(atualizarListaMenuTP)

-- ESP Players
local function aplicarESP(p)
    if p == LocalPlayer then return end
    local function addHL(char)
        if not char then return end
        local hl = char:FindFirstChild("SpyHighlight") or Instance.new("Highlight")
        hl.Name = "SpyHighlight"
        hl.Adornee = char
        hl.FillTransparency = 0.5
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.Parent = char
    end
    if p.Character then addHL(p.Character) end
    p.CharacterAdded:Connect(function(char) if espAtivo then task.wait(0.5) addHL(char) end end)
end

BotaoESP.MouseButton1Click:Connect(function()
    espAtivo = not espAtivo
    BotaoESP.Text = espAtivo and "ESP Players (Spy): ON" or "ESP Players (Spy): OFF"
    BotaoESP.BackgroundColor3 = espAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    if espAtivo then
        for _, p in ipairs(Players:GetPlayers()) do aplicarESP(p) end
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("SpyHighlight") then p.Character.SpyHighlight:Destroy() end
        end
    end
end)

-- Funções Principais
BotaoSpeed.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    local val = tonumber(CaixaSpeed.Text)
    if hum and val then hum.WalkSpeed = val end
end)

BotaoJump.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    local val = tonumber(CaixaJump.Text)
    if hum and val then hum.UseJumpPower = true hum.JumpPower = val end
end)

BotaoFly.MouseButton1Click:Connect(function()
    local root, hum = obterComponentes()
    flyAtivo = not flyAtivo
    BotaoFly.Text = flyAtivo and "Fly: ON" or "Fly: OFF"
    BotaoFly.BackgroundColor3 = flyAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)

    if flyAtivo then
        hum.PlatformStand = true
        bodyVelocity = Instance.new("BodyVelocity", root)
        bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bodyGyro = Instance.new("BodyGyro", root)
        bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bodyGyro.P = 9e4
        
        _G.RavenConnections["Fly"] = RunService.RenderStepped:Connect(function()
            if flyAtivo and root and hum then
                local vel = tonumber(CaixaFly.Text) or 50
                bodyGyro.CFrame = Camera.CFrame
                bodyVelocity.Velocity = (hum.MoveDirection.Magnitude > 0) and (Camera.CFrame.LookVector * vel) or Vector3.zero
            end
        end)
    else
        hum.PlatformStand = false
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        if _G.RavenConnections["Fly"] then _G.RavenConnections["Fly"]:Disconnect() end
    end
end)

BotaoSalvar1.MouseButton1Click:Connect(function() pontoSalvo1 = obterComponentes().CFrame end)
BotaoTP1.MouseButton1Click:Connect(function() if pontoSalvo1 then obterComponentes().CFrame = pontoSalvo1 end end)
BotaoSalvar2.MouseButton1Click:Connect(function() pontoSalvo2 = obterComponentes().CFrame end)
BotaoTP2.MouseButton1Click:Connect(function() if pontoSalvo2 then obterComponentes().CFrame = pontoSalvo2 end end)

BotaoIrParaPlayer.MouseButton1Click:Connect(function()
    local alvo = buscarPlayerAlvo(CaixaNomePlayer.Text)
    if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
        obterComponentes().CFrame = alvo.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)

BotaoLoopTP.MouseButton1Click:Connect(function()
    loopTPAtivo = not loopTPAtivo
    BotaoLoopTP.Text = loopTPAtivo and "Loop: ON" or "Loop: OFF"
    BotaoLoopTP.BackgroundColor3 = loopTPAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    if loopTPAtivo then
        _G.RavenConnections["LoopTP"] = RunService.Heartbeat:Connect(function()
            local alvo = buscarPlayerAlvo(CaixaNomePlayer.Text)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                obterComponentes().CFrame = alvo.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
            end
        end)
    else
        if _G.RavenConnections["LoopTP"] then _G.RavenConnections["LoopTP"]:Disconnect() end
    end
end)

BotaoNoclip.MouseButton1Click:Connect(function()
    noclipAtivo = not noclipAtivo
    BotaoNoclip.Text = noclipAtivo and "Noclip: ON" or "Noclip: OFF"
    BotaoNoclip.BackgroundColor3 = noclipAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    if noclipAtivo then
        _G.RavenConnections["Noclip"] = RunService.Stepped:Connect(function()
            local _, _, char = obterComponentes()
            if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
    else
        if _G.RavenConnections["Noclip"] then _G.RavenConnections["Noclip"]:Disconnect() end
    end
end)

BotaoInfJump.MouseButton1Click:Connect(function()
    infJumpAtivo = not infJumpAtivo
    BotaoInfJump.Text = infJumpAtivo and "Infinite Jump: ON" or "Infinite Jump: OFF"
    BotaoInfJump.BackgroundColor3 = infJumpAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    if infJumpAtivo then
        _G.RavenConnections["InfJump"] = UserInputService.JumpRequest:Connect(function()
            local _, hum = obterComponentes()
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        if _G.RavenConnections["InfJump"] then _G.RavenConnections["InfJump"]:Disconnect() end
    end
end)

BotaoWalkFling.MouseButton1Click:Connect(function()
    walkFlingAtivo = not walkFlingAtivo
    BotaoWalkFling.Text = walkFlingAtivo and "Walk Fling: ON" or "Walk Fling: OFF"
    BotaoWalkFling.BackgroundColor3 = walkFlingAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    if walkFlingAtivo then
        _G.RavenConnections["WalkFling"] = RunService.Heartbeat:Connect(function()
            local root = obterComponentes()
            if root then
                local velOriginal = root.AssemblyLinearVelocity
                root.AssemblyLinearVelocity = Vector3.new(10000, 10000, 10000)
                RunService.RenderStepped:Wait()
                root.AssemblyLinearVelocity = velOriginal
            end
        end)
    else
        if _G.RavenConnections["WalkFling"] then _G.RavenConnections["WalkFling"]:Disconnect() end
    end
end)

BotaoReset.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    if hum then hum.Health = 0 end
end)

local linkDiscord = "https://discord.gg/9gucZSexX"
BotaoDiscord.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard(linkDiscord)
            BotaoDiscord.Text = "Copiado!"
            task.wait(2)
            BotaoDiscord.Text = "Discord (Copiar)"
        end
    end)
end)

atualizarListaMenuTP()
