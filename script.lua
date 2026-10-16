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
local pontoSalvo1, pontoSalvo2, pontoSalvo3, pontoSalvo4 = nil, nil, nil, nil
local quantidadeExternalTP = 0
local autoTPPosAtivo = false
local ARQUIVO_SAVE_ALL = "RavenMod_AllWP.json"

-- TABELA DE ESTILOS E TAMANHOS
local Temas = {
    {Nome = "Roxo Padrão", Fundo = Color3.fromRGB(15, 12, 22), SubFundo = Color3.fromRGB(20, 15, 30), Texto = Color3.fromRGB(180, 100, 255)}
}
local tamanhosIcone = {UDim2.new(0, 38, 0, 38), UDim2.new(0, 50, 0, 50), UDim2.new(0, 62, 0, 62)}
local tamanhosMenu = { UDim2.new(0, 240, 0, 360), UDim2.new(0, 280, 0, 420), UDim2.new(0, 320, 0, 480) }
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
BotaoFechar.ZIndex = 150

local CantosFechar = Instance.new("UICorner")
CantosFechar.CornerRadius = UDim.new(0, 6)
CantosFechar.Parent = BotaoFechar

-- SUBMENU CONFIGURAÇÕES
local FrameConfig = Instance.new("Frame")
FrameConfig.Parent = ScreenGui
FrameConfig.BackgroundColor3 = Temas[1].SubFundo
FrameConfig.Position = UDim2.new(0.32, 0, 0.20, 0)
FrameConfig.Size = UDim2.new(0, 260, 0, 220)
FrameConfig.Active = true
FrameConfig.Draggable = true
FrameConfig.Visible = false
FrameConfig.ZIndex = 50

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
TituloConfig.ZIndex = 55

local BotaoFecharConfig = Instance.new("TextButton")
BotaoFecharConfig.Parent = FrameConfig
BotaoFecharConfig.Size = UDim2.new(0, 25, 0, 25)
BotaoFecharConfig.Position = UDim2.new(1, -30, 0, 5)
BotaoFecharConfig.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
BotaoFecharConfig.Text = "❌"
BotaoFecharConfig.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoFecharConfig.Font = Enum.Font.SourceSansBold
BotaoFecharConfig.TextSize = 12
BotaoFecharConfig.ZIndex = 150

local CantosFecharConfig = Instance.new("UICorner")
CantosFecharConfig.CornerRadius = UDim.new(0, 6)
CantosFecharConfig.Parent = BotaoFecharConfig

-- SCROLL CONTAINER DO SUBMENU CONFIGURAÇÕES
local ContainerConfigScroll = Instance.new("ScrollingFrame")
ContainerConfigScroll.Parent = FrameConfig
ContainerConfigScroll.Size = UDim2.new(1, 0, 1, -40)
ContainerConfigScroll.Position = UDim2.new(0, 0, 0, 35)
ContainerConfigScroll.BackgroundTransparency = 1
ContainerConfigScroll.BorderSizePixel = 0
ContainerConfigScroll.ScrollBarThickness = 4
ContainerConfigScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 50, 180)
ContainerConfigScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContainerConfigScroll.ZIndex = 55

local LayoutConfigBotoes = Instance.new("UIListLayout")
LayoutConfigBotoes.Parent = ContainerConfigScroll
LayoutConfigBotoes.Padding = UDim.new(0, 8)
LayoutConfigBotoes.HorizontalAlignment = Enum.HorizontalAlignment.Center
LayoutConfigBotoes.SortOrder = Enum.SortOrder.LayoutOrder

-- BOTÕES DE CONFIGURAÇÃO FILTRADOS
local BotaoToggleExternalTP = Instance.new("TextButton")
BotaoToggleExternalTP.Parent = ContainerConfigScroll
BotaoToggleExternalTP.Size = UDim2.new(0.9, 0, 0, 34)
BotaoToggleExternalTP.LayoutOrder = 1
BotaoToggleExternalTP.ZIndex = 55

local BotaoSalvarTodosWPs = Instance.new("TextButton")
BotaoSalvarTodosWPs.Parent = ContainerConfigScroll
BotaoSalvarTodosWPs.Size = UDim2.new(0.9, 0, 0, 34)
BotaoSalvarTodosWPs.LayoutOrder = 2
BotaoSalvarTodosWPs.ZIndex = 55

local BotaoToggleAutoTP = Instance.new("TextButton")
BotaoToggleAutoTP.Parent = ContainerConfigScroll
BotaoToggleAutoTP.Size = UDim2.new(0.9, 0, 0, 34)
BotaoToggleAutoTP.LayoutOrder = 3
BotaoToggleAutoTP.ZIndex = 55

local BotaoTamanhoMenu = Instance.new("TextButton")
BotaoTamanhoMenu.Parent = ContainerConfigScroll
BotaoTamanhoMenu.Size = UDim2.new(0.9, 0, 0, 34)
BotaoTamanhoMenu.LayoutOrder = 4
BotaoTamanhoMenu.ZIndex = 55

local EspacoFimConfig = Instance.new("Frame")
EspacoFimConfig.Parent = ContainerConfigScroll
EspacoFimConfig.Size = UDim2.new(1, 0, 0, 10)
EspacoFimConfig.BackgroundTransparency = 1
EspacoFimConfig.LayoutOrder = 5

-- PAINEL FLUTUANTE EXTERNO (FORA DO MENU)
local FrameExternalTP = Instance.new("Frame")
FrameExternalTP.Name = "ExternalTPHub"
FrameExternalTP.Parent = ScreenGui
FrameExternalTP.BackgroundColor3 = Temas[1].SubFundo
FrameExternalTP.Position = UDim2.new(0.82, 0, 0.35, 0)
FrameExternalTP.Size = UDim2.new(0, 140, 0, 180)
FrameExternalTP.Active = true
FrameExternalTP.Draggable = true
FrameExternalTP.Visible = false

local CantosExternal = Instance.new("UICorner")
CantosExternal.CornerRadius = UDim.new(0, 10)
CantosExternal.Parent = FrameExternalTP

-- BOTÕES DO PAINEL EXTERNO (P1 A P4)
local ExtP1 = Instance.new("TextButton")
ExtP1.Parent = FrameExternalTP
ExtP1.Size = UDim2.new(0, 60, 0, 36)
ExtP1.Position = UDim2.new(0, 7, 0, 8)
local ExtTP1 = Instance.new("TextButton")
ExtTP1.Parent = FrameExternalTP
ExtTP1.Size = UDim2.new(0, 60, 0, 36)
ExtTP1.Position = UDim2.new(0, 73, 0, 8)
local ExtP2 = Instance.new("TextButton")
ExtP2.Parent = FrameExternalTP
ExtP2.Size = UDim2.new(0, 60, 0, 36)
ExtP2.Position = UDim2.new(0, 7, 0, 48)
local ExtTP2 = Instance.new("TextButton")
ExtTP2.Parent = FrameExternalTP
ExtTP2.Size = UDim2.new(0, 60, 0, 36)
ExtTP2.Position = UDim2.new(0, 73, 0, 48)
local ExtP3 = Instance.new("TextButton")
ExtP3.Parent = FrameExternalTP
ExtP3.Size = UDim2.new(0, 60, 0, 36)
ExtP3.Position = UDim2.new(0, 7, 0, 88)
local ExtTP3 = Instance.new("TextButton")
ExtTP3.Parent = FrameExternalTP
ExtTP3.Size = UDim2.new(0, 60, 0, 36)
ExtTP3.Position = UDim2.new(0, 73, 0, 88)
local ExtP4 = Instance.new("TextButton")
ExtP4.Parent = FrameExternalTP
ExtP4.Size = UDim2.new(0, 60, 0, 36)
ExtP4.Position = UDim2.new(0, 7, 0, 128)
local ExtTP4 = Instance.new("TextButton")
ExtTP4.Parent = FrameExternalTP
ExtTP4.Size = UDim2.new(0, 60, 0, 36)
ExtTP4.Position = UDim2.new(0, 73, 0, 128)

-- SUBMENU TP PLAYERS (AJUSTADO E CORRIGIDO)
local FrameTPPlayers = Instance.new("Frame")
FrameTPPlayers.Parent = ScreenGui
FrameTPPlayers.BackgroundColor3 = Temas[1].SubFundo
FrameTPPlayers.Position = UDim2.new(0.32, 0, 0.18, 0)
FrameTPPlayers.Size = UDim2.new(0, 280, 0, 380)
FrameTPPlayers.Active = true
FrameTPPlayers.Draggable = true
FrameTPPlayers.Visible = false
FrameTPPlayers.ZIndex = 50

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
TituloTP.ZIndex = 55

local BotaoFecharTP = Instance.new("TextButton")
BotaoFecharTP.Parent = FrameTPPlayers
BotaoFecharTP.Size = UDim2.new(0, 25, 0, 25)
BotaoFecharTP.Position = UDim2.new(1, -30, 0, 5)
BotaoFecharTP.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
BotaoFecharTP.Text = "❌"
BotaoFecharTP.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoFecharTP.Font = Enum.Font.SourceSansBold
BotaoFecharTP.TextSize = 12
BotaoFecharTP.ZIndex = 150

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
CaixaNomePlayer.Position = UDim2.new(0.05, 0, 0.11, 0)
CaixaNomePlayer.ZIndex = 55

BotaoIrParaPlayer.Parent = FrameTPPlayers
BotaoIrParaPlayer.Size = UDim2.new(0.43, 0, 0, 28)
BotaoIrParaPlayer.Position = UDim2.new(0.05, 0, 0.20, 0)
BotaoIrParaPlayer.ZIndex = 55

BotaoLoopTP.Parent = FrameTPPlayers
BotaoLoopTP.Size = UDim2.new(0.43, 0, 0, 28)
BotaoLoopTP.Position = UDim2.new(0.52, 0, 0.20, 0)
BotaoLoopTP.ZIndex = 55

BotaoAtualizarLista.Parent = FrameTPPlayers
BotaoAtualizarLista.Size = UDim2.new(0.9, 0, 0, 26)
BotaoAtualizarLista.Position = UDim2.new(0.05, 0, 0.29, 0)
BotaoAtualizarLista.ZIndex = 55

ContainerListaPlayers.Parent = FrameTPPlayers
ContainerListaPlayers.Size = UDim2.new(0.9, 0, 0, 230)
ContainerListaPlayers.Position = UDim2.new(0.05, 0, 0.38, 0)
ContainerListaPlayers.BackgroundTransparency = 1
ContainerListaPlayers.BorderSizePixel = 0
ContainerListaPlayers.ScrollBarThickness = 4
ContainerListaPlayers.ScrollBarImageColor3 = Color3.fromRGB(120, 50, 180)
ContainerListaPlayers.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContainerListaPlayers.ZIndex = 55

LayoutListaPlayers.Parent = ContainerListaPlayers
LayoutListaPlayers.Padding = UDim.new(0, 4)
LayoutListaPlayers.HorizontalAlignment = Enum.HorizontalAlignment.Center
LayoutListaPlayers.SortOrder = Enum.SortOrder.LayoutOrder

-- SCROLLING FRAME PRINCIPAL
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
BotaoAbrir.ZIndex = 200

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

-- ORGANIZAÇÃO VISUAL NO MENU PRINCIPAL
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
EspacoFim.LayoutOrder = 14
LayoutBotoes.SortOrder = Enum.SortOrder.LayoutOrder

-- BOTÕES DO PAINEL EXTERNO FLUTUANTE
estilizarBotao(ExtP1, "📍 P1", Color3.fromRGB(50, 30, 90))
estilizarBotao(ExtTP1, "🚀 TP1", Color3.fromRGB(120, 45, 120))
estilizarBotao(ExtP2, "📍 P2", Color3.fromRGB(50, 30, 90))
estilizarBotao(ExtTP2, "🚀 TP2", Color3.fromRGB(120, 45, 120))
estilizarBotao(ExtP3, "📍 P3", Color3.fromRGB(50, 30, 90))
estilizarBotao(ExtTP3, "🚀 TP3", Color3.fromRGB(120, 45, 120))
estilizarBotao(ExtP4, "📍 P4", Color3.fromRGB(50, 30, 90))
estilizarBotao(ExtTP4, "🚀 TP4", Color3.fromRGB(120, 45, 120))

estilizarBotao(BotaoToggleExternalTP, "📌 Botões TP na Tela: Oculto", Color3.fromRGB(70, 20, 50))
estilizarBotao(BotaoSalvarTodosWPs, "💾 Salvar Todos os WPs", Color3.fromRGB(50, 30, 90))
estilizarBotao(BotaoToggleAutoTP, "🚀 Auto TP (WP1 ao Entrar): OFF", Color3.fromRGB(70, 20, 50))
estilizarBotao(BotaoTamanhoMenu, "📐 Tamanho do Menu: Médio", Color3.fromRGB(50, 30, 90))

-- BOTÃO DE CONFIGURAÇÕES
local BotaoConfig = Instance.new("TextButton")
BotaoConfig.Parent = FramePrincipal
BotaoConfig.Size = UDim2.new(0, 32, 0, 32)
BotaoConfig.Position = UDim2.new(1, -38, 1, -38)
BotaoConfig.BackgroundColor3 = Color3.fromRGB(35, 20, 50)
BotaoConfig.Text = "⚙️"
BotaoConfig.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoConfig.Font = Enum.Font.SourceSansBold
BotaoConfig.TextSize = 16
BotaoConfig.ZIndex = 150

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

-- LOGICA DO TAMANHO DO MENU
BotaoTamanhoMenu.MouseButton1Click:Connect(function()
    tamanhoMenuIndex = (tamanhoMenuIndex % #tamanhosMenu) + 1
    FramePrincipal.Size = tamanhosMenu[tamanhoMenuIndex]
    local rotulosMenu = {"Pequeno", "Médio", "Grande"}
    BotaoTamanhoMenu.Text = "📐 Tamanho do Menu: " .. rotulosMenu[tamanhoMenuIndex]
end)

-- SISTEMA DE AÇÕES E LÓGICAS SEGURAS
local espAtivo, noclipAtivo, flyAtivo, infJumpAtivo, loopTPAtivo = false, false, false, false, false
local bodyVelocity, bodyGyro = nil, nil

local function obterComponentes()
    local char = LocalPlayer.Character
    if not char then return nil, nil, nil end
    return char:FindFirstChild("HumanoidRootPart"), char:FindFirstChild("Humanoid"), char
end

local function executarTeleporte(cframeAlvo)
    local rootPart, hum, char = obterComponentes()
    if not rootPart or not cframeAlvo then return end
    if ModoTP == "Instantâneo" then
        if char and char.PivotTo then
            char:PivotTo(cframeAlvo)
        else
            rootPart.CFrame = cframeAlvo
        end
    elseif ModoTP == "Tween" then
        local velTween = tonumber(CaixaTweenSpeed.Text) or 150
        local distancia = (rootPart.Position - cframeAlvo.Position).Magnitude
        local tempo = distancia / velTween
        local tweenInfo = TweenInfo.new(tempo, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = cframeAlvo})
        tween:Play()
    end
end

-- SISTEMA UNIFICADO DE SALVAR TODOS OS 4 WAYPOINTS NO CELULAR
local function salvarTodosOsWaypoints()
    pcall(function()
        if writefile then
            local dados = {
                AutoTP = autoTPPosAtivo,
                P1 = pontoSalvo1 and {X = pontoSalvo1.Position.X, Y = pontoSalvo1.Position.Y, Z = pontoSalvo1.Position.Z} or nil,
                P2 = pontoSalvo2 and {X = pontoSalvo2.Position.X, Y = pontoSalvo2.Position.Y, Z = pontoSalvo2.Position.Z} or nil,
                P3 = pontoSalvo3 and {X = pontoSalvo3.Position.X, Y = pontoSalvo3.Position.Y, Z = pontoSalvo3.Position.Z} or nil,
                P4 = pontoSalvo4 and {X = pontoSalvo4.Position.X, Y = pontoSalvo4.Position.Y, Z = pontoSalvo4.Position.Z} or nil
            }
            writefile(ARQUIVO_SAVE_ALL, HttpService:JSONEncode(dados))
        end
    end)
end

-- VINCULAÇÃO DOS WAYPOINTS (P1, P2, P3, P4)
local function salvarPonto1() local root = obterComponentes() if root then pontoSalvo1 = root.CFrame salvarTodosOsWaypoints() end end
local function tpPonto1() if pontoSalvo1 then executarTeleporte(pontoSalvo1) end end
local function salvarPonto2() local root = obterComponentes() if root then pontoSalvo2 = root.CFrame salvarTodosOsWaypoints() end end
local function tpPonto2() if pontoSalvo2 then executarTeleporte(pontoSalvo2) end end
local function salvarPonto3() local root = obterComponentes() if root then pontoSalvo3 = root.CFrame salvarTodosOsWaypoints() end end
local function tpPonto3() if pontoSalvo3 then executarTeleporte(pontoSalvo3) end end
local function salvarPonto4() local root = obterComponentes() if root then pontoSalvo4 = root.CFrame salvarTodosOsWaypoints() end end
local function tpPonto4() if pontoSalvo4 then executarTeleporte(pontoSalvo4) end end

-- BOTAO CONFIG: SALVAR E TOGGLE AUTO TP
BotaoSalvarTodosWPs.MouseButton1Click:Connect(function()
    salvarTodosOsWaypoints()
    BotaoSalvarTodosWPs.Text = "✅ Todos WPs Salvos!"
    task.wait(1.5)
    BotaoSalvarTodosWPs.Text = "💾 Salvar Todos os WPs"
end)

BotaoToggleAutoTP.MouseButton1Click:Connect(function()
    autoTPPosAtivo = not autoTPPosAtivo
    BotaoToggleAutoTP.Text = autoTPPosAtivo and "🚀 Auto TP (WP1 ao Entrar): ON" or "🚀 Auto TP (WP1 ao Entrar): OFF"
    BotaoToggleAutoTP.BackgroundColor3 = autoTPPosAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    salvarTodosOsWaypoints()
end)

-- CARREGAR TODOS OS 4 WAYPOINTS DO ARQUIVO LOCAL AO ENTRAR
task.spawn(function()
    pcall(function()
        if isfile and isfile(ARQUIVO_SAVE_ALL) then
            local conteudo = readfile(ARQUIVO_SAVE_ALL)
            local dados = HttpService:JSONDecode(conteudo)
            if dados then
                if dados.P1 then pontoSalvo1 = CFrame.new(dados.P1.X, dados.P1.Y, dados.P1.Z) end
                if dados.P2 then pontoSalvo2 = CFrame.new(dados.P2.X, dados.P2.Y, dados.P2.Z) end
                if dados.P3 then pontoSalvo3 = CFrame.new(dados.P3.X, dados.P3.Y, dados.P3.Z) end
                if dados.P4 then pontoSalvo4 = CFrame.new(dados.P4.X, dados.P4.Y, dados.P4.Z) end
                
                if dados.AutoTP ~= nil then
                    autoTPPosAtivo = dados.AutoTP
                    BotaoToggleAutoTP.Text = autoTPPosAtivo and "🚀 Auto TP (WP1 ao Entrar): ON" or "🚀 Auto TP (WP1 ao Entrar): OFF"
                    BotaoToggleAutoTP.BackgroundColor3 = autoTPPosAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
                end
                
                if autoTPPosAtivo and pontoSalvo1 then
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart", 10)
                    if root then
                        task.wait(1.5)
                        for i = 1, 3 do
                            executarTeleporte(pontoSalvo1)
                            task.wait(0.3)
                        end
                    end
                end
            end
        end
    end)
end)

-- ATUALIZAÇÃO DA EXIBIÇÃO DE TPS FLUTUANTES NA TELA (0 a 4)
local function atualizarModoExternalTP()
    if quantidadeExternalTP == 0 then
        FrameExternalTP.Visible = false
        BotaoToggleExternalTP.Text = "📌 Botões TP na Tela: Oculto"
        BotaoToggleExternalTP.BackgroundColor3 = Color3.fromRGB(70, 20, 50)
    else
        FrameExternalTP.Visible = true
        BotaoToggleExternalTP.Text = "📌 Botões TP na Tela: " .. quantidadeExternalTP .. " WP(s)"
        BotaoToggleExternalTP.BackgroundColor3 = Color3.fromRGB(130, 40, 180)
        ExtP1.Visible = (quantidadeExternalTP >= 1)
        ExtTP1.Visible = (quantidadeExternalTP >= 1)
        ExtP2.Visible = (quantidadeExternalTP >= 2)
        ExtTP2.Visible = (quantidadeExternalTP >= 2)
        ExtP3.Visible = (quantidadeExternalTP >= 3)
        ExtTP3.Visible = (quantidadeExternalTP >= 3)
        ExtP4.Visible = (quantidadeExternalTP >= 4)
        ExtTP4.Visible = (quantidadeExternalTP >= 4)
        FrameExternalTP.Size = UDim2.new(0, 140, 0, (quantidadeExternalTP * 40) + 15)
    end
end

BotaoToggleExternalTP.MouseButton1Click:Connect(function()
    quantidadeExternalTP = (quantidadeExternalTP + 1) % 5
    atualizarModoExternalTP()
end)

BotaoModoTP.MouseButton1Click:Connect(function()
    if ModoTP == "Instantâneo" then
        ModoTP = "Tween"
        BotaoModoTP.Text = "TP: Tween"
        BotaoModoTP.BackgroundColor3 = Color3.fromRGB(130, 40, 180)
    else
        ModoTP = "Instantâneo"
        BotaoModoTP.Text = "TP: Instantâneo"
        BotaoModoTP.BackgroundColor3 = Color3.fromRGB(50, 30, 90)
    end
end)

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

-- GERENCIADOR OTIMIZADO DE CRIAÇÃO DA LISTA DE PLAYERS
local function atualizarListaMenuTP()
    for _, item in ipairs(ContainerListaPlayers:GetChildren()) do
        if item:IsA("TextLabel") or item:IsA("TextButton") then
            item:Destroy()
        end
    end
    
    local times = TeamsService:GetTeams()
    local function criarBotaoPlayer(p)
        local BotaoPlayer = Instance.new("TextButton")
        BotaoPlayer.Parent = ContainerListaPlayers
        BotaoPlayer.Size = UDim2.new(0.95, 0, 0, 26)
        BotaoPlayer.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
        BotaoPlayer.Text = " 👤 " .. p.DisplayName .. " (@" .. p.Name .. ")"
        BotaoPlayer.TextColor3 = Color3.fromRGB(220, 220, 220)
        BotaoPlayer.Font = Enum.Font.SourceSans
        BotaoPlayer.TextSize = 13
        BotaoPlayer.TextScaled = true -- Ajusta automaticamente o texto se o nome for gigante
        BotaoPlayer.TextXAlignment = Enum.TextXAlignment.Left
        
        local cantos = Instance.new("UICorner")
        cantos.CornerRadius = UDim.new(0, 4)
        cantos.Parent = BotaoPlayer
        
        BotaoPlayer.MouseButton1Click:Connect(function()
            CaixaNomePlayer.Text = p.Name
        end)
    end
    
    if #times > 0 then
        for _, time in ipairs(times) do
            local jogadoresDoTime = time:GetPlayers()
            if #jogadoresDoTime > 0 then
                local LabelTime = Instance.new("TextLabel")
                LabelTime.Parent = ContainerListaPlayers
                LabelTime.Size = UDim2.new(0.95, 0, 0, 20)
                LabelTime.BackgroundTransparency = 1
                LabelTime.Text = "--- " .. time.Name .. " ---"
                LabelTime.TextColor3 = time.TeamColor.Color
                LabelTime.Font = Enum.Font.SourceSansBold
                LabelTime.TextSize = 13
                
                for _, p in ipairs(jogadoresDoTime) do
                    if p ~= LocalPlayer then criarBotaoPlayer(p) end
                end
            end
        end
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then criarBotaoPlayer(p) end
        end
    end
end

BotaoAtualizarLista.MouseButton1Click:Connect(atualizarListaMenuTP)

BotaoIrParaPlayer.MouseButton1Click:Connect(function()
    local alvo = buscarPlayerAlvo(CaixaNomePlayer.Text)
    if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
        executarTeleporte(alvo.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
    end
end)

BotaoLoopTP.MouseButton1Click:Connect(function()
    loopTPAtivo = not loopTPAtivo
    BotaoLoopTP.Text = loopTPAtivo and "🔄 Loop TP: ON" or "🔄 Loop TP: OFF"
    BotaoLoopTP.BackgroundColor3 = loopTPAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    if loopTPAtivo then
        _G.RavenConnections["LoopTP"] = RunService.Heartbeat:Connect(function()
            local alvo = buscarPlayerAlvo(CaixaNomePlayer.Text)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                executarTeleporte(alvo.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2))
            end
        end)
    else
        if _G.RavenConnections["LoopTP"] then _G.RavenConnections["LoopTP"]:Disconnect() end
    end
end)

-- MOVEMENT HANDLERS
BotaoSpeed.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    local val = tonumber(CaixaSpeed.Text)
    if hum and val then hum.WalkSpeed = val end
end)

BotaoJump.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    local val = tonumber(CaixaJump.Text)
    if hum and val then
        hum.UseJumpPower = true
        hum.JumpPower = val
    end
end)

BotaoInfJump.MouseButton1Click:Connect(function()
    infJumpAtivo = not infJumpAtivo
    BotaoInfJump.Text = infJumpAtivo and "🦘 Infinite Jump: ON" or "🦘 Infinite Jump: OFF"
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

BotaoNoclip.MouseButton1Click:Connect(function()
    noclipAtivo = not noclipAtivo
    BotaoNoclip.Text = noclipAtivo and "Noclip: ON" or "Noclip: OFF"
    BotaoNoclip.BackgroundColor3 = noclipAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    if noclipAtivo then
        _G.RavenConnections["Noclip"] = RunService.Stepped:Connect(function()
            if not noclipAtivo then return end
            local _, _, char = obterComponentes()
            if char then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    else
        if _G.RavenConnections["Noclip"] then _G.RavenConnections["Noclip"]:Disconnect() end
    end
end)

BotaoFly.MouseButton1Click:Connect(function()
    flyAtivo = not flyAtivo
    BotaoFly.Text = flyAtivo and "Fly: ON" or "Fly: OFF"
    BotaoFly.BackgroundColor3 = flyAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    local root, hum = obterComponentes()
    if flyAtivo then
        if root and hum then
            hum.PlatformStand = true
            bodyVelocity = Instance.new("BodyVelocity", root)
            bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bodyGyro = Instance.new("BodyGyro", root)
            bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            bodyGyro.P = 9e4
            _G.RavenConnections["Fly"] = RunService.RenderStepped:Connect(function()
                if not flyAtivo then return end
                local curRoot, curHum = obterComponentes()
                if curRoot and curHum then
                    local vel = tonumber(CaixaFly.Text) or 50
                    bodyGyro.CFrame = Camera.CFrame
                    bodyVelocity.Velocity = (curHum.MoveDirection.Magnitude > 0) and (Camera.CFrame.LookVector * vel) or Vector3.zero
                end
            end)
        end
    else
        if hum then hum.PlatformStand = false end
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        if _G.RavenConnections["Fly"] then _G.RavenConnections["Fly"]:Disconnect() end
    end
end)

-- VISUALS (ESP)
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
    p.CharacterAdded:Connect(function(char)
        if espAtivo then
            task.wait(0.5)
            addHL(char)
        end
    end)
end

BotaoESP.MouseButton1Click:Connect(function()
    espAtivo = not espAtivo
    BotaoESP.Text = espAtivo and "👁️ ESP Players: ON" or "👁️ ESP Players: OFF"
    BotaoESP.BackgroundColor3 = espAtivo and Color3.fromRGB(130, 40, 180) or Color3.fromRGB(70, 20, 50)
    if espAtivo then
        for _, p in ipairs(Players:GetPlayers()) do aplicarESP(p) end
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("SpyHighlight") then
                p.Character.SpyHighlight:Destroy()
            end
        end
    end
end)

BotaoSalvar1.MouseButton1Click:Connect(salvarPonto1)
BotaoTP1.MouseButton1Click:Connect(tpPonto1)
BotaoSalvar2.MouseButton1Click:Connect(salvarPonto2)
BotaoTP2.MouseButton1Click:Connect(tpPonto2)

ExtP1.MouseButton1Click:Connect(salvarPonto1)
ExtTP1.MouseButton1Click:Connect(tpPonto1)
ExtP2.MouseButton1Click:Connect(salvarPonto2)
ExtTP2.MouseButton1Click:Connect(tpPonto2)
ExtP3.MouseButton1Click:Connect(salvarPonto3)
ExtTP3.MouseButton1Click:Connect(tpPonto3)
ExtP4.MouseButton1Click:Connect(salvarPonto4)
ExtTP4.MouseButton1Click:Connect(tpPonto4)

-- UTILITIES (SERVER HOP, RESET, DISCORD)
local isHopando = false
BotaoServerPoucaGente.MouseButton1Click:Connect(function()
    if isHopando then return end
    isHopando = true
    BotaoServerPoucaGente.Text = "🌐 Searching Server..."
    local placeId = game.PlaceId
    local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    local sucesso, resultado = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    local serverEncontrado = nil
    if sucesso and resultado and resultado.data then
        for _, server in ipairs(resultado.data) do
            if server.playing and server.playing < server.maxPlayers and server.id ~= game.JobId then
                serverEncontrado = server.id
                break
            end
        end
    end
    if serverEncontrado then
        BotaoServerPoucaGente.Text = "🌐 Connecting..."
        TeleportService:TeleportToPlaceInstance(placeId, serverEncontrado, LocalPlayer)
    else
        BotaoServerPoucaGente.Text = "⚠️ No Server Found!"
        task.wait(2)
        BotaoServerPoucaGente.Text = "🌐 Server Hop (Low Players)"
        isHopando = false
    end
end)

BotaoReset.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    if hum then hum.Health = 0 end
end)

local linkDiscord = "https://discord.gg/9gucZSexX"
local discordCopiado = false
BotaoDiscord.MouseButton1Click:Connect(function()
    if discordCopiado then return end
    discordCopiado = true
    pcall(function()
        if setclipboard then
            setclipboard(linkDiscord)
            BotaoDiscord.Text = "📋 Link Copied!"
            task.wait(2)
            BotaoDiscord.Text = "💬 Join Discord"
        else
            BotaoDiscord.Text = "⚠️ Not Supported!"
            task.wait(2)
            BotaoDiscord.Text = "💬 Join Discord"
        end
    end)
    discordCopiado = false
end)

atualizarListaMenuTP()
