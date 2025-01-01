local x, y = 400, 500
local z , t = 800, 700
local speedZ, speedT = 300, 300
local speedX, speedY = 300, 300
local speed = 3000
local radius = 50
local start = love.timer.getTime()
local timeover = 0 -- Tempo que o jogador ficou vivo
local gameover = false
local windowWidth, windowHeight = love.graphics.getDimensions()

--- nome do jogo 
function love.load()
    love.window.setTitle("Bolinha")

    centerX = windowWidth / 2
    centerY = windowHeight / 2

    defaultFont = love.graphics.newFont(14)

    fonte = love.graphics.newFont(24)
end
--- bolas que se movem em direções diferentes
function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", x, y, radius)


    love.graphics.setColor(0, 0, 1)
    love.graphics.circle("fill", z, t, radius)

    -- Mostra o tempo de jogo
    local time = 0
    if not gameover then
        time = love.timer.getTime() - start
    end
    
    local minutes = math.floor(time / 60)
    local seconds = math.floor(time % 60)
    time = string.format("%02d:%02d", minutes, seconds)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Tempo: " .. time, 10, 10)


    if gameover then
        -- Calcula o tempo de jogo
        local minutes = math.floor(timeover / 60)
        local seconds = math.floor(timeover % 60)
        local timeover = string.format("%02d:%02d", minutes, seconds)

        love.graphics.setColor(1, 1, 1)  -- Cor branca para o texto
        love.graphics.setFont(defaultFont)  -- Fonte padrão
        love.graphics.print("Fim de jogo", 10, 50)
        love.graphics.print("Tempo Vivo: " .. timeover, 10, 70)
        
        -- Muda para a cor vermelha e fonte maior para o "You Lose"
        love.graphics.setColor(1, 0, 0)  -- Cor vermelha
        love.graphics.setFont(fonte)  -- Aplica a fonte maior
        love.graphics.print("You Lose", centerX, centerY)
        
        -- Volta à fonte padrão e cor branca para as mensagens de reinício
        love.graphics.setFont(defaultFont)  -- Fonte padrão
        love.graphics.setColor(1, 1, 1)  -- Cor branca
        love.graphics.print("Pressione R para reiniciar", 10, 90)
    end
end



function checkcollision()
    local dx = z - x
    local dy = t - y
    local distance = math.sqrt(dx * dx + dy * dy)
    
    if distance <= radius * 2 then
        gameover = true
        timeover = love.timer.getTime() - start
    end
end


-- quando a bola bater na parede, ela muda de direção 
--[[function love.update(dt)
    x = x + speedX * dt
    z = z + speedZ * dt
    y = y + speedY * dt
    t = t + speedT * dt

    if x > windowwidth - radius then
        x = windowwidth - radius
        speedX = -speedX
    elseif x < radius then
        x = radius
        speedX = -speedX
    end

    if z > windowwidth - radius then
        z = windowwidth - radius
        speedZ= -speedZ
    elseif z < radius then
        z = radius
        speedZ = -speedZ
    end

    if y > windowheight - radius then
        y = windowheight - radius
        speedY = -speedY
    elseif y < radius then
        y = radius
        speedY = -speedY
    end

    if t > windowheight - radius then
        t = windowheight - radius
        speedT = -speedT
    elseif t < radius then
        t = radius
        speedT = -speedT
    end
    
end--]]
--[[function love.keypressed(key, scancode, isrepeat)
    -- Move a bolinha com as setas do teclado
    if key == "w" then
        y = y - 100
    elseif key == "s" then
        y = y + 100
    elseif key == "a" then
        x = x - 100
    elseif key == "d" then
        x = x + 100
    end
end--]]

-- Atualiza as posições das bolas
function love.update(dt)
    if not gameover then
        -- Movimento contínuo das bolas
        x = x + speedX * dt
        y = y + speedY * dt
        z = z + speedZ * dt
        t = t + speedT * dt

        -- Colisão com as bordas para a bolinha branca
        if x > windowWidth - radius then
            x = windowWidth - radius
            speedX = -speedX
        elseif x < radius then
            x = radius
            speedX = -speedX
        end

        if y > windowHeight - radius then
            y = windowHeight - radius
            speedY = -speedY
        elseif y < radius then
            y = radius
            speedY = -speedY
        end

        -- Colisão com as bordas para a bolinha azul
        if z > windowWidth - radius then
            z = windowWidth - radius
            speedZ = -speedZ
        elseif z < radius then
            z = radius
            speedZ = -speedZ
        end

        if t > windowHeight - radius then
            t = windowHeight - radius
            speedT = -speedT
        elseif t < radius then
            t = radius
            speedT = -speedT
        end

        -- Verifica a colisão entre as bolas
        checkcollision()

        -- Movimento contínuo da bolinha branca com as teclas WASD
        if love.keyboard.isDown("w") then
            y = y - speed * dt
        elseif love.keyboard.isDown("s") then
            y = y + speed * dt
        end

        if love.keyboard.isDown("a") then
            x = x - speed * dt
        elseif love.keyboard.isDown("d") then
            x = x + speed * dt
        end
    end
end

-- tecla para reniciar o jogo
function love.keypressed(key)
    if key == "r" then
        resetGame()
    end
end

-- Função para reiniciar o jogo
function resetGame()
   x, y = 400, 500
   z, t = 800, 700
   speedX, speedY = 300, 300
   speedZ, speedT = 300, 300
   start = love.timer.getTime()  -- Reinicia o tempo
   gameover = false  -- O jogo não acabou mais
end