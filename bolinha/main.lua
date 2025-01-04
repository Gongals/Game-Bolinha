local x, y = 200, 350
local z , t = 800, 700
local speedZ, speedT = 300, 300
local speedX, speedY = 300, 300
local speed = 3000
local radius = 60
local start = love.timer.getTime()
local timeover = 0 -- Tempo que o jogador ficou vivo
local gameover = false
local windowWidth, windowHeight = love.graphics.getDimensions()
local nivel = 1
local temposubida = 5 -- tempo para subir de nivel
local levelupsound
local ball
local killerball



--- nome do jogo 
function love.load()
    love.window.setMode(800, 600, {resizable=true, vsync=0, minwidth=400, minheight=300})
    levelupsound = love.audio.newSource("src/sounds/levelup.wav", "static")
    background = love.graphics.newImage("src/imgs/background.png")
    ball = love.graphics.newImage("src/imgs/ball.png")
    killerball = love.graphics.newImage("src/imgs/killerball.png")

    love.window.setTitle("Bolinha")

    centerX = windowWidth / 2
    centerY = windowHeight / 2

    defaultFont = love.graphics.newFont(14)

    fonte = love.graphics.newFont(24)
end

--- bolas que se movem em direções diferentes
function love.draw()

    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end


    love.graphics.draw(ball, x, y, 0, radius / ball:getWidth(), radius / ball:getHeight())
    love.graphics.draw(killerball, z, t, 0, radius / killerball:getWidth(), radius / killerball:getHeight())

    

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
    love.graphics.print("Nivel: " .. nivel, 10, 30)


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
    local dx = (z + 2 / radius) - (x + 2 / radius)  -- Adiciona o radius para o centro
    local dy = (t + 2 / radius) - (y + 2 / radius)  -- Adiciona o radius para o centro
    local distance = math.sqrt(dx * dx + dy * dy)
    
    if distance <= radius * 2 then
        gameover = true
        timeover = love.timer.getTime() - start
    end
end

-- Atualiza as posições das bolas
function love.update(dt)
    if not gameover then
        -- Movimento contínuo das bolas
        x = x + speedX * dt
        y = y + speedY * dt
        z = z + speedZ * dt
        t = t + speedT * dt

        -- Colisão com as bordas para a bolinha branca
        if x >= windowWidth - radius then
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
      
        
    

        local tempocorrido = love.timer.getTime() - start
        if  tempocorrido >= temposubida then
             nivel = nivel + 1
             temposubida = temposubida + 5

            levelupsound:play()
            levelupsound:setVolume(0.5 + (nivel * 0.1))
            levelupsound:setPitch(1 + (nivel * 0.1))
            levelupsound:setLooping(false)
            

                speedZ = speedZ + (40 * nivel)
                speedT = speedT + (40 * nivel)

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
        -- Reseta as posições das bolas
        x, y = 400, 500
        z, t = 800, 700
        speedX, speedY = 300, 300
        speedZ, speedT = 300, 300
        start = love.timer.getTime()  -- Reinicia o tempo
        gameover = false  -- O jogo não acabou mais
        nivel = 1
        temposubida = 5
       
end

