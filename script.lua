local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeamsService = game:GetService("Teams")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

-- PROTEÇÃO ANTI-DUPLICAÇÃO E LIMPEZA DE CONEXÕES
if PlayerGui:FindFirstChild("RavenModFull") then
    PlayerGui.RavenModFull:Destroy()
end

if _G.RavenConnections then
    for _, conexao in pairs(_G.RavenConnections) do
        if conexao then conexao:Disconnect() end
    end
end
_G.RavenConnections = {}

-- CONFIGURAÇÕES GLOBAIS DE TELEPORTE E ESTILO
local ModoTP = "Instantâneo"
local pontoSalvo1, pontoSalvo2 = nil, nil
local externalTPAtivo = false

-- TABELA DE TEMAS E CONFIGURAÇÕES DE TAMANHO
local Temas = {
    {Nome = "Roxo Padrão", Fundo = Color3.fromRGB(15, 12, 22), SubFundo = Color3.fromRGB(20, 15, 30), Texto = Color3.fromRGB(180, 100, 255)},
    {Nome = "Azul Neon", Fundo = Color3.fromRGB(10, 15, 30), SubFundo = Color3.fromRGB(15, 22, 45), Texto = Color3.fromRGB(0, 210, 255)},
    {Nome = "Vermelho Carmim", Fundo = Color3.fromRGB(25, 10, 15), SubFundo = Color3.fromRGB(35, 15, 20), Texto = Color3.fromRGB(255, 80, 100)},
    {Nome = "Verde Hacker", Fundo = Color3.fromRGB(10, 20, 15), SubFundo = Color3.fromRGB(15, 30, 20), Texto = Color3.fromRGB(50, 255, 120)},
    {Nome = "Dark Puro", Fundo = Color3.fromRGB(15, 15, 15), SubFundo = Color3.fromRGB(22, 22, 22), Texto = Color3.fromRGB(220, 220, 220)}
}
local temaAtualIndex = 1
local niveisTransparencia = {0, 0.25, 0.50}
local transpIndex = 1
local tamanhosIcone = {UDim2.new(0, 38, 0, 38), UDim2.new(0, 50, 0, 50), UDim2.new(0, 62, 0, 62)}
local tamanhoIconeIndex = 2

-- TAMANHOS DO MENU PRINCIPAL (PEQUENO, MÉDIO, GRANDE)
local tamanhosMenu = {
    UDim2.new(0, 240, 0, 360), -- Pequeno
    UDim2.new(0, 280, 0, 420), -- Médio (Padrão)
    UDim2.new(0, 320, 0, 480)  -- Grande
}
local tamanhoMenuIndex = 2

-- GUI PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RavenModFull"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- JANELA PRINCIPAL
local FramePrincipal = Instance.new("Frame")
FramePrincipal.Parent = ScreenGui
FramePrincipal.BackgroundColor3 = Temas[1].Fundo
FramePrincipal.Position = UDim2.new(0.05, 0, 0.18, 0)
FramePrincipal.Size = tamanhosMenu[tamanhoMenuIndex]
FramePrincipal.Active = true
FramePrincipal.Draggable = true 

local CantosMenu = Instance.new("UICorner")
CantosMenu.CornerRadius = UDim.new(0, 12) 
CantosMenu.Parent = FramePrincipal

local Titulo = Instance.new("TextLabel")
Titulo.Parent = FramePrincipal
Titulo.Size = UDim2.new(1, 0, 0, 35)
Titulo.BackgroundTransparency = 1
Titulo.Text = "👑 Raven Mod"
Titulo.TextColor3 = Temas[1].Texto
Titulo.Font = Enum.Font.SourceSansBold
Titulo.TextSize = 18

local BotaoFechar = Instance.new("TextButton")
BotaoFechar.Parent = FramePrincipal
BotaoFechar.Size = UDim2.new(0, 25, 0, 25)
BotaoFechar.Position = UDim2.new(1, -30, 0, 5)
BotaoFechar.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
BotaoFechar.Text = "❌"
BotaoFechar.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoFechar.Font = Enum.Font.SourceSansBold
BotaoFechar.TextSize = 12

local CantosFechar = Instance.new("UICorner")
CantosFechar.CornerRadius = UDim.new(0, 6)
CantosFechar.Parent = BotaoFechar

-- SUBMENU CONFIGURAÇÕES
local FrameConfig = Instance.new("Frame")
FrameConfig.Parent = ScreenGui
FrameConfig.BackgroundColor3 = Temas[1].SubFundo
FrameConfig.Position = UDim2.new(0.32, 0, 0.20, 0)
FrameConfig.Size = UDim2.new(0, 260, 0, 270)
FrameConfig.Active = true
FrameConfig.Draggable = true
FrameConfig.Visible = false

local CantosConfig = Instance.new("UICorner")
CantosConfig.CornerRadius = UDim.new(0, 12)
CantosConfig.Parent = FrameConfig

local TituloConfig = Instance.new("TextLabel")
TituloConfig.Parent = FrameConfig
TituloConfig.Size = UDim2.new(1, 0, 0, 35)
TituloConfig.BackgroundTransparency = 1
TituloConfig.Text = "⚙️ Configurações"
TituloConfig.TextColor3 = Temas[1].Texto
TituloConfig.Font = Enum.Font.SourceSansBold
TituloConfig.TextSize = 17

local BotaoFecharConfig = Instance.new("TextButton")
BotaoFecharConfig.Parent = FrameConfig
BotaoFecharConfig.Size = UDim2.new(0, 25, 0, 25)
BotaoFecharConfig.Position = UDim2.new(1, -30, 0, 5)
BotaoFecharConfig.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
BotaoFecharConfig.Text = "❌"
BotaoFecharConfig.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoFecharConfig.Font = Enum.Font.SourceSansBold
BotaoFecharConfig.TextSize = 12

local CantosFecharConfig = Instance.new("UICorner")
CantosFecharConfig.CornerRadius = UDim.new(0, 6)
CantosFecharConfig.Parent = BotaoFecharConfig

-- ELEMENTOS DE CONFIGURAÇÃO (BOTÕES)
local BotaoToggleExternalTP = Instance.new("TextButton")
BotaoToggleExternalTP.Parent = FrameConfig
BotaoToggleExternalTP.Size = UDim2.new(0.9, 0, 0, 34)
BotaoToggleExternalTP.Position = UDim2.new(0.05, 0, 0.16, 0)

local BotaoMudarTema = Instance.new("TextButton")
BotaoMudarTema.Parent = FrameConfig
BotaoMudarTema.Size = UDim2.new(0.9, 0, 0, 34)
BotaoMudarTema.Position = UDim2.new(0.05, 0, 0.32, 0)

local BotaoTransparencia = Instance.new("TextButton")
BotaoTransparencia.Parent = FrameConfig
BotaoTransparencia.Size = UDim2.new(0.9, 0, 0, 34)
BotaoTransparencia.Position = UDim2.new(0.05, 0, 0.48, 0)

local BotaoTamanhoIcone = Instance.new("TextButton")
BotaoTamanhoIcone.Parent = FrameConfig
BotaoTamanhoIcone.Size = UDim2.new(0.9, 0, 0, 34)
BotaoTamanhoIcone.Position = UDim2.new(0.05, 0, 0.64, 0)

local BotaoTamanhoMenu = Instance.new("TextButton")
BotaoTamanhoMenu.Parent = FrameConfig
BotaoTamanhoMenu.Size = UDim2.new(0.9, 0, 0, 34)
BotaoTamanhoMenu.Position = UDim2.new(0.05, 0, 0.80, 0)

-- PAINEL FLUTUANTE EXTERNO DE TELEPORTE
local FrameExternalTP = Instance.new("Frame")
FrameExternalTP.Name = "ExternalTPHub"
FrameExternalTP.Parent = ScreenGui
FrameExternalTP.BackgroundColor3 = Temas[1].SubFundo
FrameExternalTP.Position = UDim2.new(0.82, 0, 0.35, 0)
FrameExternalTP.Size = UDim2.new(0, 140, 0, 95)
FrameExternalTP.Active = true
FrameExternalTP.Draggable = true
FrameExternalTP.Visible = false

local CantosExternal = Instance.new("UICorner")
CantosExternal.CornerRadius = UDim.new(0, 10)
CantosExternal.Parent = FrameExternalTP

local ExtP1 = Instance.new("TextButton")
ExtP1.Parent = FrameExternalTP
ExtP1.Size = UDim2.new(0, 60, 0, 38)
ExtP1.Position = UDim2.new(0, 7, 0, 8)

local ExtTP1 = Instance.new("TextButton")
ExtTP1.Parent = FrameExternalTP
ExtTP1.Size = UDim2.new(0, 60, 0, 38)
ExtTP1.Position = UDim2.new(0, 73, 0, 8)

local ExtP2 = Instance.new("TextButton")
ExtP2.Parent = FrameExternalTP
ExtP2.Size = UDim2.new(0, 60, 0, 38)
ExtP2.Position = UDim2.new(0, 7, 0, 50)

local ExtTP2 = Instance.new("TextButton")
ExtTP2.Parent = FrameExternalTP
ExtTP2.Size = UDim2.new(0, 60, 0, 38)
ExtTP2.Position = UDim2.new(0, 73, 0, 50)

-- SUBMENU TP PLAYERS
local FrameTPPlayers = Instance.new("Frame")
FrameTPPlayers.Parent = ScreenGui
FrameTPPlayers.BackgroundColor3 = Temas[1].SubFundo
FrameTPPlayers.Position = UDim2.new(0.32, 0, 0.18, 0)
FrameTPPlayers.Size = UDim2.new(0, 280, 0, 420)
FrameTPPlayers.Active = true
FrameTPPlayers.Draggable = true
FrameTPPlayers.Visible = false 

local CantosTP = Instance.new("UICorner")
CantosTP.CornerRadius = UDim.new(0, 12)
CantosTP.Parent = FrameTPPlayers

local TituloTP = Instance.new("TextLabel")
TituloTP.Parent = FrameTPPlayers
TituloTP.Size = UDim2.new(1, 0, 0, 35)
TituloTP.BackgroundTransparency = 1
TituloTP.Text = "🎯 Target Teleport Hub"
TituloTP.TextColor3 = Temas[1].Texto
TituloTP.Font = Enum.Font.SourceSansBold
TituloTP.TextSize = 17

local BotaoFecharTP = Instance.new("TextButton")
BotaoFecharTP.Parent = FrameTPPlayers
BotaoFecharTP.Size = UDim2.new(0, 25, 0, 25)
BotaoFecharTP.Position = UDim2.new(1, -30, 0, 5)
BotaoFecharTP.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
BotaoFecharTP.Text = "❌"
BotaoFecharTP.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoFecharTP.Font = Enum.Font.SourceSansBold
BotaoFecharTP.TextSize = 12
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
CaixaNomePlayer.Size = UDim2.new(0.9, 0, 0, 28)
CaixaNomePlayer.Position = UDim2.new(0.05, 0, 0.10, 0)

BotaoIrParaPlayer.Parent = FrameTPPlayers
BotaoIrParaPlayer.Size = UDim2.new(0.43, 0, 0, 28)
BotaoIrParaPlayer.Position = UDim2.new(0.05, 0, 0.18, 0)

BotaoLoopTP.Parent = FrameTPPlayers
BotaoLoopTP.Size = UDim2.new(0.43, 0, 0, 28)
BotaoLoopTP.Position = UDim2.new(0.52, 0, 0.18, 0)

BotaoAtualizarLista.Parent = FrameTPPlayers
BotaoAtualizarLista.Size = UDim2.new(0.9, 0, 0, 26)
BotaoAtualizarLista.Position = UDim2.new(0.05, 0, 0.26, 0)

ContainerListaPlayers.Parent = FrameTPPlayers
ContainerListaPlayers.Size = UDim2.new(0.9, 0, 0, 280)
ContainerListaPlayers.Position = UDim2.new(0.05, 0, 0.33, 0)
ContainerListaPlayers.BackgroundTransparency = 1
ContainerListaPlayers.BorderSizePixel = 0
ContainerListaPlayers.ScrollBarThickness = 4
ContainerListaPlayers.ScrollBarImageColor3 = Color3.fromRGB(120, 50, 180)
ContainerListaPlayers.CanvasSize = UDim2.new(0, 0, 0, 0)

LayoutListaPlayers.Parent = ContainerListaPlayers
LayoutListaPlayers.Padding = UDim.new(0, 3)
LayoutListaPlayers.HorizontalAlignment = Enum.HorizontalAlignment.Center

LayoutListaPlayers:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContainerListaPlayers.CanvasSize = UDim2.new(0, 0, 0, LayoutListaPlayers.AbsoluteContentSize.Y + 10)
end)

-- SCROLLING FRAME PRINCIPAL
local ContainerScroll = Instance.new("ScrollingFrame")
ContainerScroll.Parent = FramePrincipal
ContainerScroll.Size = UDim2.new(1, 0, 1, -40)
ContainerScroll.Position = UDim2.new(0, 0, 0, 35)
ContainerScroll.BackgroundTransparency = 1
ContainerScroll.BorderSizePixel = 0
ContainerScroll.ScrollBarThickness = 4
ContainerScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 50, 180)
ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local LayoutBotoes = Instance.new("UIListLayout")
LayoutBotoes.Parent = ContainerScroll
LayoutBotoes.Padding = UDim.new(0, 8)
LayoutBotoes.HorizontalAlignment = Enum.HorizontalAlignment.Center

LayoutBotoes:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, LayoutBotoes.AbsoluteContentSize.Y + 45)
end)

-- ÍCONE FLUTUANTE ABRIR MENU
local BotaoAbrir = Instance.new("TextButton")
BotaoAbrir.Parent = ScreenGui
BotaoAbrir.Size = tamanhosIcone[2]
BotaoAbrir.Position = UDim2.new(0.02, 0, 0.2, 0) 
BotaoAbrir.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
BotaoAbrir.Text = "🔮"
BotaoAbrir.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoAbrir.Font = Enum.Font.SourceSansBold
BotaoAbrir.TextSize = 22
BotaoAbrir.Visible = false 
BotaoAbrir.Active = true
BotaoAbrir.Draggable = true 

local CantosIcone = Instance.new("UICorner")
CantosIcone.CornerRadius = UDim.new(1, 0)
CantosIcone.Parent = BotaoAbrir

-- DECLARAÇÃO DOS BOTÕES DO MENU PRINCIPAL
local BotaoSpeed = Instance.new("TextButton")
local CaixaSpeed = Instance.new("TextBox")

local BotaoJump = Instance.new("TextButton")
local CaixaJump = Instance.new("TextBox")

local BotaoFly = Instance.new("TextButton")
local CaixaFly = Instance.new("TextBox")

local BotaoModoTP = Instance.new("TextButton")
local CaixaTweenSpeed = Instance.new("TextBox")

local BotaoSalvar1 = Instance.new("TextButton")
local BotaoTP1 = Instance.new("TextButton")
local BotaoSalvar2 = Instance.new("TextButton")
local BotaoTP2 = Instance.new("TextButton")

local BotaoAbrirMenuTP = Instance.new("TextButton")
local BotaoESP = Instance.new("TextButton")
local BotaoInfJump = Instance.new("TextButton")
local BotaoNoclip = Instance.new("TextButton")

local BotaoServerPoucaGente = Instance.new("TextButton")
local BotaoReset = Instance.new("TextButton")
local BotaoDiscord = Instance.new("TextButton")

-- FUNÇÕES DE DESIGN E ESTILIZAÇÃO
local function criarParLadoALado(elemEsq, elemDir, layoutOrder)
    local ContainerGrupo = Instance.new("Frame")
    ContainerGrupo.Parent = ContainerScroll
    ContainerGrupo.Size = UDim2.new(0.9, 0, 0, 34)
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
    botao.TextSize = 13
    local cantos = Instance.new("UICorner")
    cantos.CornerRadius = UDim.new(0, 6)
    cantos.Parent = botao
end

local function estilizarCaixa(caixa, textoPadrao, placeholder)
    caixa.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    caixa.Text = textoPadrao
    caixa.PlaceholderText = placeholder
    caixa.TextColor3 = Color3.fromRGB(220, 180, 255)
    caixa.Font = Enum.Font.SourceSansSemibold
    caixa.TextSize = 13
    local cantos = Instance.new("UICorner")
    cantos.CornerRadius = UDim.new(0, 6)
    cantos.Parent = caixa
end

local function estilizarBotaoLargo(botao, texto, corFundo, layoutOrder)
    botao.Parent = ContainerScroll
    botao.Size = UDim2.new(0.9, 0, 0, 34)
    botao.LayoutOrder = layoutOrder
    estilizarBotao(botao, texto, corFundo)
end

-- ORGANIZAÇÃO VISUAL LADO A LADO
estilizarBotao(BotaoSpeed, "Aplicar Speed", Color3.fromRGB(90, 40, 140))
estilizarCaixa(CaixaSpeed, "100", "Speed...")
criarParLadoALado(CaixaSpeed, BotaoSpeed, 1)

estilizarBotao(BotaoJump, "Aplicar Jump", Color3.fromRGB(90, 40, 140))
estilizarCaixa(CaixaJump, "100", "Jump...")
criarParLadoALado(CaixaJump, BotaoJump, 2)

estilizarBotao(BotaoFly, "Fly: OFF", Color3.fromRGB(70, 20, 50))
estilizarCaixa(CaixaFly, "50", "Fly Speed...")
criarParLadoALado(CaixaFly, BotaoFly, 3)

estilizarBotao(BotaoModoTP, "TP: Instantâneo", Color3.fromRGB(50, 30, 90))
estilizarCaixa(CaixaTweenSpeed, "150", "Tween Speed...")
criarParLadoALado(CaixaTweenSpeed, BotaoModoTP, 4)

estilizarBotao(BotaoSalvar1, "📍 Set WP 1", Color3.fromRGB(50, 30, 90))
estilizarBotao(BotaoTP1, "🚀 TP 1", Color3.fromRGB(120, 45, 120))
criarParLadoALado(BotaoSalvar1, BotaoTP1, 5)

estilizarBotao(BotaoSalvar2, "📍 Set WP 2", Color3.fromRGB(50, 30, 90))
estilizarBotao(BotaoTP2, "🚀 TP 2", Color3.fromRGB(120, 45, 120))
criarParLadoALado(BotaoSalvar2, BotaoTP2, 6)

estilizarBotaoLargo(BotaoAbrirMenuTP, "👥 TP Players & Times", Color3.fromRGB(130, 40, 180), 7)
estilizarBotaoLargo(BotaoESP, "👁️ ESP Players: OFF", Color3.fromRGB(70, 20, 50), 8)
estilizarBotaoLargo(BotaoInfJump, "🦘 Infinite Jump: OFF", Color3.fromRGB(70, 20, 50), 9)
estilizarBotaoLargo(BotaoNoclip, "Noclip: OFF", Color3.fromRGB(70, 20, 50), 10)

estilizarBotaoLargo(BotaoServerPoucaGente, "🌐 Server Hop (Low Players)", Color3.fromRGB(90, 40, 140), 11)
estilizarBotaoLargo(BotaoReset, "💀 Respawn Character", Color3.fromRGB(120, 30, 30), 12)
estilizarBotaoLargo(BotaoDiscord, "💬 Join Discord", Color3.fromRGB(88, 101, 242), 13)

estilizarBotao(ExtP1, "📍 P1", Color3.fromRGB(50, 30, 90))
estilizarBotao(ExtTP1, "🚀 TP1", Color3.fromRGB(120, 45, 120))
estilizarBotao(ExtP2, "📍 P2", Color3.fromRGB(50, 30, 90))
estilizarBotao(ExtTP2, "🚀 TP2", Color3.fromRGB(120, 45, 120))

estilizarBotao(BotaoToggleExternalTP, "📌 Botões TP na Tela: OFF", Color3.fromRGB(70, 20, 50))
estilizarBotao(BotaoMudarTema, "🎨 Tema: Roxo Padrão", Color3.fromRGB(50, 30, 90))
estilizarBotao(BotaoTransparencia, "👁️ Transparência: Opaco (0%)", Color3.fromRGB(50, 30, 90))
estilizarBotao(BotaoTamanhoIcone, "🔮 Ícone Flutuante: Médio", Color3.fromRGB(50, 30, 90))
estilizarBotao(BotaoTamanhoMenu, "📐 Tamanho do Menu: Médio", Color3.fromRGB(50, 30, 90))

LayoutBotoes.SortOrder = Enum.SortOrder.LayoutOrder

-- BOTÃO DE CONFIGURAÇÕES CRIADO POR ÚLTIMO COM ZINDEX ALTO PARA GARANTIR ACESSO
local BotaoConfig = Instance.new("TextButton")
BotaoConfig.Parent = FramePrincipal
BotaoConfig.Size = UDim2.new(0, 32, 0, 32)
BotaoConfig.Position = UDim2.new(1, -38, 1, -38)
BotaoConfig.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
BotaoConfig.Text = "⚙️"
BotaoConfig.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoConfig.Font = Enum.Font.SourceSansBold
BotaoConfig.TextSize = 16
BotaoConfig.ZIndex = 50

local CantosConfigBtn = Instance.new("UICorner")
CantosConfigBtn.CornerRadius = UDim.new(0, 8)
CantosConfigBtn.Parent = BotaoConfig

-- ESTILOS SUBMENU TP PLAYERS
estilizarCaixa(CaixaNomePlayer, "", "Player Nickname...")
estilizarBotao(BotaoIrParaPlayer, "⚡ Instant TP", Color3.fromRGB(120, 45, 120))
estilizarBotao(BotaoLoopTP, "🔄 Loop TP: OFF", Color3.fromRGB(70, 20, 50))
estilizarBotao(BotaoAtualizarLista, "🔄 Refresh Players", Color3.fromRGB(50, 30, 90))

-- CONTROLE DAS JANELAS
BotaoFechar.MouseButton1Click:Connect(function()
    FramePrincipal.Visible = false 
    FrameTPPlayers.Visible = false
    FrameConfig.Visible = false
    BotaoAbrir.Visible = true 
end)

BotaoAbrir.MouseButton1Click:Connect(function()
    FramePrincipal.Visible = true 
    BotaoAbrir.Visible = false 
end)

BotaoConfig.MouseButton1Click:Connect(function()
    FrameConfig.Visible = not FrameConfig.Visible
end)

BotaoFecharConfig.MouseButton1Click:Connect(function()
    FrameConfig.Visible = false
end)

BotaoAbrirMenuTP.MouseButton1Click:Connect(function()
    FrameTPPlayers.Visible = not FrameTPPlayers.Visible
end)

BotaoFecharTP.MouseButton1Click:Connect(function()
    FrameTPPlayers.Visible = false
end)

-- LOGICA DAS CONFIGURAÇÕES DE PERSONALIZAÇÃO
BotaoMudarTema.MouseButton1Click:Connect(function()
    temaAtualIndex = (temaAtualIndex % #Temas) + 1
    local tema = Temas[temaAtualIndex]
    
    FramePrincipal.BackgroundColor3 = tema.Fundo
    FrameConfig.BackgroundColor3 = tema.SubFundo
    FrameTPPlayers.BackgroundColor3 = tema.SubFundo
    FrameExternalTP.BackgroundColor3 = tema.SubFundo

    Titulo.TextColor3 = tema.Texto
    TituloConfig.TextColor3 = tema.Texto
    TituloTP.TextColor3 = tema.Texto

    BotaoMudarTema.Text = "🎨 Tema: " .. tema.Nome
end)

BotaoTransparencia.MouseButton1Click:Connect(function()
    transpIndex = (transpIndex % #niveisTransparencia) + 1
    local val = niveisTransparencia[transpIndex]

    FramePrincipal.BackgroundTransparency = val
    FrameConfig.BackgroundTransparency = val
    FrameTPPlayers.BackgroundTransparency = val
    FrameExternalTP.BackgroundTransparency = val

    BotaoTransparencia.Text = "👁️ Transparência: " .. (val == 0 and "Opaco (0%)" or math.floor(val * 100) .. "%")
end)

BotaoTamanhoIcone.MouseButton1Click:Connect(function()
    tamanhoIconeIndex = (tamanhoIconeIndex % #tamanhosIcone) + 1
    BotaoAbrir.Size = tamanhosIcone[tamanhoIconeIndex]

    local rotulos = {"Pequeno", "Médio", "Grande"}
    BotaoTamanhoIcone.Text = "🔮 Ícone Flutuante: " .. rotulos[tamanhoIconeIndex]
end)

BotaoTamanhoMenu.MouseButton1Click:Connect(function()
    tamanhoMenuIndex = (tamanhoMenuIndex % #tamanhosMenu) + 1
    FramePrincipal.Size = tamanhosMenu[tamanhoMenuIndex]

    local rotulosMenu = {"Pequeno", "Médio", "Grande"}
    BotaoTamanhoMenu.Text = "📐 Tamanho do Menu: " .. rotulosMenu[tamanhoMenuIndex]
end)

-- SISTEMA DE AÇÕES E LÓGICAS
local espAtivo, noclipAtivo, flyAtivo,
