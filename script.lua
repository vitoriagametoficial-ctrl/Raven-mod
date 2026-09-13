-- 1. CONFIGURAÇÃO DA INTERFACE PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
local FramePrincipal = Instance.new("Frame")
local CantosMenu = Instance.new("UICorner") 
local Titulo = Instance.new("TextLabel")

-- Janela com Scroll
local ContainerScroll = Instance.new("ScrollingFrame")
local LayoutBotoes = Instance.new("UIListLayout")

-- Botões e Campos de Função (Speed, Jump, Fly)
local BotaoSpeed = Instance.new("TextButton")
local CaixaSpeed = Instance.new("TextBox")

local BotaoJump = Instance.new("TextButton")
local CaixaJump = Instance.new("TextBox")

local BotaoFly = Instance.new("TextButton")
local CaixaFly = Instance.new("TextBox")

-- Waypoints
local BotaoSalvar1 = Instance.new("TextButton")
local BotaoTP1 = Instance.new("TextButton")

local BotaoSalvar2 = Instance.new("TextButton")
local BotaoTP2 = Instance.new("TextButton")

-- Botões de Alternância Únicos
local BotaoNoclip = Instance.new("TextButton")
local BotaoInfJump = Instance.new("TextButton")
local BotaoFullbright = Instance.new("TextButton")
local BotaoESP = Instance.new("TextButton")
local BotaoWalkFling = Instance.new("TextButton")
local BotaoTPTool = Instance.new("TextButton")

-- Ações Rápidas
local BotaoReset = Instance.new("TextButton")
local BotaoDiscord = Instance.new("TextButton")

-- Elementos de Abrir/Fechar
local BotaoFechar = Instance.new("TextButton") 
local BotaoAbrir = Instance.new("TextButton") 
local CantosIcone = Instance.new("UICorner")

-- Ativa a interface
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- --- ESTILO DO MENU PRINCIPAL ---
FramePrincipal.Parent = ScreenGui
FramePrincipal.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
FramePrincipal.Position = UDim2.new(0.1, 0, 0.2, 0)
FramePrincipal.Size = UDim2.new(0, 220, 0, 300)
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

-- Botão Fechar ("X")
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

-- --- SCROLLING FRAME ---
ContainerScroll.Parent = FramePrincipal
ContainerScroll.Size = UDim2.new(1, 0, 1, -40)
ContainerScroll.Position = UDim2.new(0, 0, 0, 35)
ContainerScroll.BackgroundTransparency = 1
ContainerScroll.BorderSizePixel = 0
ContainerScroll.ScrollBarThickness = 4
ContainerScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 50, 180)
ContainerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContainerScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

LayoutBotoes.Parent = ContainerScroll
LayoutBotoes.Padding = UDim.new(0, 8)
LayoutBotoes.HorizontalAlignment = Enum.HorizontalAlignment.Center

local EspacoFim = Instance.new("Frame")
EspacoFim.Parent = ContainerScroll
EspacoFim.Size = UDim2.new(1, 0, 0, 10)
EspacoFim.BackgroundTransparency = 1

-- --- ÍCONE REDONDO DE ABRIR (60x60) ---
BotaoAbrir.Parent = ScreenGui
BotaoAbrir.Size = UDim2.new(0, 60, 0, 60)
BotaoAbrir.Position = UDim2.new(0.02, 0, 0.25, 0) 
BotaoAbrir.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
BotaoAbrir.Text = "R"
BotaoAbrir.TextColor3 = Color3.fromRGB(220, 150, 255)
BotaoAbrir.Font = Enum.Font.SourceSansBold
BotaoAbrir.TextSize = 24
BotaoAbrir.Visible = false 
BotaoAbrir.Active = true
BotaoAbrir.Draggable = true 

CantosIcone.Parent = BotaoAbrir
CantosIcone.CornerRadius = UDim.new(1, 0)

-- --- FUNÇÕES DE AUXÍLIO E ESTILO ---
local function criarParLadoALado(elemEsq, elemDir, layoutOrder)
    local ContainerGrupo = Instance.new("Frame")
    ContainerGrupo.Parent = ContainerScroll
    ContainerGrupo.Size = UDim2.new(0.9, 0, 0, 35)
    ContainerGrupo.BackgroundTransparency = 1
    ContainerGrupo.LayoutOrder = layoutOrder

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
    cantos.CornerRadius = UDim.new(0, 8)
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
    cantos.CornerRadius = UDim.new(0, 8)
    cantos.Parent = caixa
end

local function estilizarBotaoLargo(botao, texto, corFundo, layoutOrder)
    botao.Parent = ContainerScroll
    botao.Size = UDim2.new(0.9, 0, 0, 35)
    botao.LayoutOrder = layoutOrder
    estilizarBotao(botao, texto, corFundo)
end

-- Estilização
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

-- Montar Pares Lado a Lado
criarParLadoALado(CaixaSpeed, BotaoSpeed, 1)
criarParLadoALado(CaixaJump, BotaoJump, 2)
criarParLadoALado(CaixaFly, BotaoFly, 3)
criarParLadoALado(BotaoSalvar1, BotaoTP1, 4)
criarParLadoALado(BotaoSalvar2, BotaoTP2, 5)

-- Botões Largos
estilizarBotaoLargo(BotaoTPTool, "Obter Teleport Tool", Color3.fromRGB(90, 40, 140), 6)
estilizarBotaoLargo(BotaoNoclip, "Noclip: OFF", Color3.fromRGB(70, 20, 50), 7)
estilizarBotaoLargo(BotaoInfJump, "Infinite Jump: OFF", Color3.fromRGB(70, 20, 50), 8)
estilizarBotaoLargo(BotaoFullbright, "Fullbright: OFF", Color3.fromRGB(70, 20, 50), 9)
estilizarBotaoLargo(BotaoESP, "ESP Players: OFF", Color3.fromRGB(70, 20, 50), 10)
estilizarBotaoLargo(BotaoWalkFling, "Walk Fling: OFF", Color3.fromRGB(70, 20, 50), 11)
estilizarBotaoLargo(BotaoReset, "Reset Character", Color3.fromRGB(120, 30, 30), 12)
estilizarBotaoLargo(BotaoDiscord, "Discord (Copiar)", Color3.fromRGB(88, 101, 242), 13)

EspacoFim.LayoutOrder = 14
LayoutBotoes.SortOrder = Enum.SortOrder.LayoutOrder

-- 2. LÓGICA DE ABRIR E FECHAR
BotaoFechar.MouseButton1Click:Connect(function()
    FramePrincipal.Visible = false 
    BotaoAbrir.Visible = true 
end)

BotaoAbrir.MouseButton1Click:Connect(function()
    FramePrincipal.Visible = true 
    BotaoAbrir.Visible = false 
end)

-- 3. CÓDIGO DAS FUNÇÕES DO JOGO
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local pontoSalvo1 = nil
local pontoSalvo2 = nil

local noclipAtivo = false
local noclipConexao = nil

local flyAtivo = false
local bodyVelocity = nil
local bodyGyro = nil
local flyConexao = nil

local infJumpAtivo = false
local infJumpConexao = nil

local fullbrightAtivo = false
local iluminacaoOriginal = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient
}

local espAtivo = false
local espConexao = nil

local walkFlingAtivo = false
local walkFlingConexao = nil

local function obterComponentes()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart"), char:WaitForChild("Humanoid"), char
end

-- Speed
BotaoSpeed.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    local novaVelocidade = tonumber(CaixaSpeed.Text)
    if hum and novaVelocidade then hum.WalkSpeed = novaVelocidade end
end)

-- JumpPower
BotaoJump.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    local novoPulo = tonumber(CaixaJump.Text)
    if hum and novoPulo then
        hum.UseJumpPower = true
        hum.JumpPower = novoPulo
    end
end)

-- Fly
BotaoFly.MouseButton1Click:Connect(function()
    local root, hum, _ = obterComponentes()
    flyAtivo = not flyAtivo

    if flyAtivo then
        BotaoFly.BackgroundColor3 = Color3.fromRGB(130, 40, 180)
        BotaoFly.Text = "Fly: ON"
        hum.PlatformStand = true

        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = root

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bodyGyro.P = 9e4
        bodyGyro.CFrame = root.CFrame
        bodyGyro.Parent = root

        flyConexao = game:GetService("RunService").RenderStepped:Connect(function()
            if flyAtivo and root and hum then
                local camera = workspace.CurrentCamera
                local velFly = tonumber(CaixaFly.Text) or 50
                bodyGyro.CFrame = camera.CFrame
                
                if hum.MoveDirection.Magnitude > 0 then
                    bodyVelocity.Velocity = camera.CFrame.LookVector * velFly
                else
                    bodyVelocity.Velocity = Vector3.zero
                end
            end
        end)
    else
        BotaoFly.BackgroundColor3 = Color3.fromRGB(70, 20, 50)
        BotaoFly.Text = "Fly: OFF"
        hum.PlatformStand = false
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        if flyConexao then flyConexao:Disconnect() flyConexao = nil end
    end
end)

-- Waypoints
BotaoSalvar1.MouseButton1Click:Connect(function()
    local root, _ = obterComponentes()
    pontoSalvo1 = root.CFrame
end)

BotaoTP1.MouseButton1Click:Connect(function()
    local root, _ = obterComponentes()
    if pontoSalvo1 then root.CFrame = pontoSalvo1 end
end)

BotaoSalvar2.MouseButton1Click:Connect(function()
    local root, _ = obterComponentes()
    pontoSalvo2 = root.CFrame
end)

BotaoTP2.MouseButton1Click:Connect(function()
    local root, _ = obterComponentes()
    if pontoSalvo2 then root.CFrame = pontoSalvo2 end
end)

-- Teleport Tool
BotaoTPTool.MouseButton1Click:Connect(function()
    local tool = Instance.new("Tool")
    tool.Name = "TP Tool"
    tool.RequiresHandle = false
    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local root, _, _ = obterComponentes()
        if mouse.Hit and root then
            root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end)
    tool.Parent = player.Backpack
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

-- Infinite Jump
BotaoInfJump.MouseButton1Click:Connect(function()
    infJumpAtivo = not infJumpAtivo
    if infJumpAtivo then
        BotaoInfJump.BackgroundColor3 = Color3.fromRGB(130, 40, 180)
        BotaoInfJump.Text = "Infinite Jump: ON"
        infJumpConexao = UserInputService.JumpRequest:Connect(function()
            local _, hum = obterComponentes()
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        BotaoInfJump.BackgroundColor3 = Color3.fromRGB(70, 20, 50)
        BotaoInfJump.Text = "Infinite Jump: OFF"
        if infJumpConexao then infJumpConexao:Disconnect() infJumpConexao = nil end
    end
end)

-- Fullbright
BotaoFullbright.MouseButton1Click:Connect(function()
    fullbrightAtivo = not fullbrightAtivo
    if fullbrightAtivo then
        BotaoFullbright.BackgroundColor3 = Color3.fromRGB(130, 40, 180)
        BotaoFullbright.Text = "Fullbright: ON"
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        BotaoFullbright.BackgroundColor3 = Color3.fromRGB(70, 20, 50)
        BotaoFullbright.Text = "Fullbright: OFF"
        Lighting.Brightness = iluminacaoOriginal.Brightness
        Lighting.ClockTime = iluminacaoOriginal.ClockTime
        Lighting.GlobalShadows = iluminacaoOriginal.GlobalShadows
        Lighting.Ambient = iluminacaoOriginal.Ambient
    end
end)

-- ESP Players (Highlight)
local function aplicarHighlight(p)
    if p ~= player and p.Character then
        if not p.Character:FindFirstChild("RavenESP") then
            local hl = Instance.new("Highlight")
            hl.Name = "RavenESP"
            hl.FillColor = Color3.fromRGB(180, 100, 255)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.FillTransparency = 0.5
            hl.Parent = p.Character
        end
    end
end

BotaoESP.MouseButton1Click:Connect(function()
    espAtivo = not espAtivo
    if espAtivo then
        BotaoESP.BackgroundColor3 = Color3.fromRGB(130, 40, 180)
        BotaoESP.Text = "ESP Players: ON"
        
        for _, p in ipairs(game.Players:GetPlayers()) do aplicarHighlight(p) end
        
        espConexao = game.Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function()
                task.wait(0.5)
                if espAtivo then aplicarHighlight(p) end
            end)
        end)
    else
        BotaoESP.BackgroundColor3 = Color3.fromRGB(70, 20, 50)
        BotaoESP.Text = "ESP Players: OFF"
        if espConexao then espConexao:Disconnect() espConexao = nil end
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("RavenESP") then
                p.Character.RavenESP:Destroy()
            end
        end
    end
end)

-- Walk Fling
BotaoWalkFling.MouseButton1Click:Connect(function()
    local root, _, _ = obterComponentes()
    walkFlingAtivo = not walkFlingAtivo

    if walkFlingAtivo then
        BotaoWalkFling.BackgroundColor3 = Color3.fromRGB(130, 40, 180)
        BotaoWalkFling.Text = "Walk Fling: ON"
        
        walkFlingConexao = game:GetService("RunService").Heartbeat:Connect(function()
            if walkFlingAtivo and root then
                local velOriginal = root.AssemblyLinearVelocity
                root.AssemblyLinearVelocity = Vector3.new(10000, 10000, 10000)
                game:GetService("RunService").RenderStepped:Wait()
                root.AssemblyLinearVelocity = velOriginal
            end
        end)
    else
        BotaoWalkFling.BackgroundColor3 = Color3.fromRGB(70, 20, 50)
        BotaoWalkFling.Text = "Walk Fling: OFF"
        if walkFlingConexao then walkFlingConexao:Disconnect() walkFlingConexao = nil end
    end
end)

-- Reset Character
BotaoReset.MouseButton1Click:Connect(function()
    local _, hum = obterComponentes()
    if hum then hum.Health = 0 end
end)

-- Copiar Discord
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
