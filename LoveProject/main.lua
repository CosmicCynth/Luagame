function love.load()
    love.window.setTitle("Racoon Explores")
    --Libaries--
    anim8 = require 'libaries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    --Map--
    sti = require 'libaries.sti'
    gameMap = sti('maps/Island1.lua')
    
    --Player & Animations
    player = {}
    player.x = 400
    player. y = 300
    player.speed = 170
    player.spriteSheet = love.graphics.newImage('sprites/Spritesheet.png')
    player.grid = anim8.newGrid(32,32,player.spriteSheet:getWidth(),player.spriteSheet:getHeight())

    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-8',1), 0.1)
    player.animations.left = anim8.newAnimation(player.grid('1-8',2), 0.1)
    player.animations.up = anim8.newAnimation(player.grid('1-8',3), 0.1)
    player.animations.right = anim8.newAnimation(player.grid('1-8',4), 0.1)
    
    player.anim = player.animations.down

    background = love.graphics.newImage('sprites/grass.png')
end

function love.update(dt)
    local isMoving = false

    --Movement, when key is press move in that direction
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed * dt
        player.anim = player.animations.right
        isMoving = true
    end

    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed * dt
        player.anim = player.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed * dt
        player.anim = player.animations.down
        isMoving = true
    end

    if love.keyboard.isDown("w") then 
        player.y = player.y - player.speed * dt
        player.anim = player.animations.up
        isMoving = true
    end

    if isMoving == false then --This function does so when we are standing still our frame goes to number 1
        player.anim:gotoFrame(2)
    end

    player.anim:update(dt)
end

function love.draw()
    gameMap:draw()
    player.anim:draw(player.spriteSheet,player.x,player.y,nil, 3)
end