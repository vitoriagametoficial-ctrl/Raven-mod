-- 1. CONFIGURAÇÃO DA INTERFACE PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
local FramePrincipal = Instance.new("Frame")
local CantosMenu = Instance.new("UICorner") 
local Titulo = Instance.new("TextLabel")

-- Janela com Scroll
local ContainerScroll = Instance.new("ScrollingFrame")
local LayoutBotoes = Instance.new("UIListLayout")

-- Botões e Campos de Função
local BotaoSpeed = Instance.new("TextButton")
local CaixaSpeed = Instance.new("TextBox")

-- Waypoint 1
local BotaoSalvar1 = Instance.new("TextButton")
local BotaoTP1 = Instance.new("TextButton")

-- Waypoint 2
local BotaoSalvar2 = Instance.new("TextButton")
local BotaoTP2 = Instance.new("TextButton")

-- Noclip
local BotaoNoclip = Instance.new("TextButton")

-- Discord
local BotaoDiscord = Instance.new("TextButton")

-- Elementos de Abrir/Fechar
local BotaoFechar = Instance.new("TextButton") 
local BotaoAbrirIcone = Instance.new("ImageButton") 
local CantosIcone = Instance.new("UICorner")

-- Ativa a interface
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- --- ESTILO DO MENU PRINCIPAL (TEMA PRETO E ROXO) ---
FramePrincipal.Parent = ScreenGui
FramePrincipal.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
FramePrincipal.Position = UDim2.new(0.1, 0, 0.25, 0)
FramePrincipal.Size = UDim2.new(0, 170, 0, 300)
FramePrincipal.Active = true
FramePrincipal.Draggable = true 

CantosMenu.Parent = FramePrincipal
CantosMenu.CornerRadius = UDim.new(0, 16) 

-- Título do Menu
Titulo.Parent = FramePrincipal
Titulo.Size = UDim2.new(1, 0, 0, 35)
Titulo.BackgroundTransparency = 1
Titulo.Text = "Raven Mod"
Titulo.TextColor3 = Color3.fromRGB(180, 100, 255)
Titulo.Font = Enum.Font.SourceSansBold
Titulo.TextSize = 17

-- Botão de Fechar ("X")
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

-- --- CONFIGURAÇÃO DO SCROLLING FRAME ---
ContainerScroll.Parent = FramePrincipal
ContainerScroll.Size = UDim2.new(1, 0, 1, -40)
ContainerScroll.Position = UDim2.new(0, 0, 0, 35)
ContainerScroll.BackgroundTransparency = 1
ContainerScroll.BorderSizePixel = 0
ContainerScroll.ScrollBarThickness = 4
ContainerScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 50, 180)
ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContainerScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Organizador dos botões
LayoutBotoes.Parent = ContainerScroll
LayoutBotoes.Padding = UDim.new(0, 8)
LayoutBotoes.HorizontalAlignment = Enum.HorizontalAlignment.Center

local EspacoFim = Instance.new("Frame")
EspacoFim.Parent = ContainerScroll
EspacoFim.Size = UDim2.new(1, 0, 0, 10)
EspacoFim.BackgroundTransparency = 1

-- --- ÍCONE REDONDO DE ABRIR ---
BotaoAbrirIcone.Parent = ScreenGui
BotaoAbrirIcone.Size = UDim2.new(0, 50, 0, 50) 
BotaoAbrirIcone.Position = UDim2.new(0.02, 0, 0.25, 0) 
BotaoAbrirIcone.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
BotaoAbrirIcone.Image = "rbxassetid://110303498557598"
BotaoAbrirIcone.Visible = false 
BotaoAbrirIcone.Active = true
BotaoAbrirIcone.Draggable = true 

CantosIcone.Parent = BotaoAbrirIcone
CantosIcone.CornerRadius = UDim.new(1, 0)

-- --- FUNÇÃO DOS BOTÕES INTERNOS ---
local function criarBotaoPro(botao, texto, corFundo)
    botao.Parent = ContainerScroll
    botao.Size = UDim2.new(0.85, 0, 0, 38)
    botao.BackgroundColor3 = corFundo
    botao.Text = texto
    botao.TextColor3 = Color3.fromRGB(255, 255, 255)
    botao.Font = Enum.Font.SourceSansSemibold
    botao.TextSize = 14
    
    local cantos = Instance.new("UICorner")
    cantos.CornerRadius = UDim.new(0, 10) 
    cantos.Parent = botao
end

-- Criando os botões
criarBotaoPro(BotaoSpeed, "Aplicar Speed", Color3.fromRGB(90, 40, 140))

criarBotaoPro(BotaoSalvar1, "Set Waypoint 1", Color3.fromRGB(50, 30, 90))
criarBotaoPro(BotaoTP1, "Teleport (TP 1)", Color3.fromRGB(120, 45, 120))

criarBotaoPro(BotaoSalvar2, "Set Waypoint 2", Color3.fromRGB(50, 30, 90))
criarBotaoPro(BotaoTP2, "Teleport (TP 2)", Color3.fromRGB(120, 45, 120))

criarBotaoPro(BotaoNoclip, "Noclip: OFF", Color3.fromRGB(70, 20, 50))

-- Botão do Discord (Azul/Roxo do Discord)
criarBotaoPro(BotaoDiscord, "Discord (Copiar)", Color3.fromRGB(88, 101, 242))

-- Caixa de Speed
CaixaSpeed.Parent = ContainerScroll
CaixaSpeed.Size = UDim2.new(0.85, 0, 0, 35)
CaixaSpeed.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
CaixaSpeed.Text = "100"
CaixaSpeed.PlaceholderText = "Digite a Speed..."
CaixaSpeed.TextColor3 = Color3.fromRGB(220, 180, 255)
CaixaSpeed.Font = Enum.Font.SourceSansSemibold
CaixaSpeed.TextSize = 14
local CantosCaixa = Instance.new("UICorner")
CantosCaixa.CornerRadius = UDim.new(0, 10)
CantosCaixa.Parent = CaixaSpeed

-- Ordem do layout dentro do scroll
LayoutBotoes.SortOrder = Enum.SortOrder.LayoutOrder
CaixaSpeed.LayoutOrder = 1
BotaoSpeed.LayoutOrder = 2
BotaoSalvar1.LayoutOrder = 3
BotaoTP1.LayoutOrder = 4
BotaoSalvar2.LayoutOrder = 5
BotaoTP2.LayoutOrder = 6
BotaoNoclip.LayoutOrder = 7
BotaoDiscord.LayoutOrder = 8 -- Fica no final!
EspacoFim.LayoutOrder = 9

-- 2. LÓGICA DE ABRIR E FECHAR
BotaoFechar.MouseButton1Click:Connect(function()
    FramePrincipal.Visible = false 
    BotaoAbrirIcone.Visible = true 
end)

BotaoAbrirIcone.MouseButton1Click:Connect(function()
    FramePrincipal.Visible = true 
    BotaoAbrirIcone.Visible = false 
end)

-- 3. CÓDIGO DAS FUNÇÕES DO JOGO
local player = game.Players.LocalPlayer
local pontoSalvo1 = nil
local pontoSalvo2 = nil
local noclipAtivo = false
local noclipConexao = nil

local function obterComponentes()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart"), char:WaitForChild("Humanoid"), char
end

-- Speed
BotaoSpeed.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    local novaVelocidade = tonumber(CaixaSpeed.Text)
    if hum and novaVelocidade then
        hum.WalkSpeed = novaVelocidade
    end
end)

-- Waypoint 1
BotaoSalvar1.MouseButton1Click:Connect(function()
    local root, _ = obterComponentes()
    pontoSalvo1 = root.CFrame
end)

BotaoTP1.MouseButton1Click:Connect(function()
    local root, _ = obterComponentes()
    if pontoSalvo1 then root.CFrame = pontoSalvo1 end
end)

-- Waypoint 2
BotaoSalvar2.MouseButton1Click:Connect(function()
    local root, _ = obterComponentes()
    pontoSalvo2 = root.CFrame
end)

BotaoTP2.MouseButton1Click:Connect(function()
    local root, _ = obterComponentes()
    if pontoSalvo2 then root.CFrame = pontoSalvo2 end
end)

-- Noclip
BotaoNoclip.MouseButton1Click:Connect(function()
    local _, _, char = obterComponentes()
    noclipAtivo = not noclipAtivo

    if noclipAtivo then
        BotaoNoclip.BackgroundColor3 = Color3.fromRGB(130, 40, 180)
        BotaoNoclip.Text = "Noclip: ON"
        noclipConexao = game:GetService("RunService").Stepped:Connect(function()
            if char then
                for _, parte in ipairs(char:GetDescendants()) do
                    if parte:IsA("BasePart") then parte.CanCollide = false end
                end
            end
        end)
    else
        BotaoNoclip.BackgroundColor3 = Color3.fromRGB(70, 20, 50)
        BotaoNoclip.Text = "Noclip: OFF"
        if noclipConexao then noclipConexao:Disconnect() noclipConexao = nil end
    end
end)

-- LÓGICA DE COPIAR O DISCORD
local linkDiscord = "https://discord.gg/9gucZSexX"

BotaoDiscord.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(linkDiscord)
        BotaoDiscord.Text = "Copiado!"
        task.wait(2)
        BotaoDiscord.Text = "Discord (Copiar)"
    else
        BotaoDiscord.Text = "Erro ao copiar"
        task.wait(2)
        BotaoDiscord.Text = "Discord (Copiar)"
    end
end)
