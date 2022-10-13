--libraries
push = require 'push'
Class = require 'class'

--classes
require 'Ball'
require 'Paddle'

--global variables
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


--[[ Love functions ]]

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  math.randomseed(os.time())

  smallFont = love.graphics.newFont('font.ttf', 8)
  love.graphics.setFont(smallFont)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  --[[ Using push library instead --^
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
      fullscreen = false,
      resizable = false,
      vsync = true
    })
  ]]

  player1 = Paddle(10, 30, 'w', 's')
  player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 50, 'up', 'down')

  --ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
  ball = Ball(214, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

  gameState = 'start'
end


function love.draw()
  push:apply('start')

  --background
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  --title
  love.window.setTitle('PONG')
  if gameState == 'start' then
    love.graphics.printf('READY...', 0, 20, VIRTUAL_WIDTH, 'center')
  else
    love.graphics.printf('BEGIN!!!', 0, 20, VIRTUAL_WIDTH, 'center')
  end

  --left paddle
  player1:render()

  --right paddle
  player2:render()

  --ball
  ball:render()

  displayFPS()

  push:apply('end')
end


function love.update(dt)

  if gameState == 'play' then

    --collision detection
    if ball:collides(player1) or ball:collides(player2) then

      -- x direction
      ball.dx = -ball.dx * 1.03     

      --y direction
      if ball.dy < 0 then
        ball.dy = -math.random(10, 150)
      else
        ball.dy = math.random(10, 150)
      end
    end

    --detect collision with top and bottom of screen
    if ball.y > VIRTUAL_HEIGHT or ball.y < 0 then
      ball.dy = -ball.dy
    end

    ball:update(dt)
  end 

  player1:update(dt)
  player2:update(dt)
end


function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'

      ball:reset()
    end
  end
end


--[[ Helper functions ]]

function displayFPS()
  love.graphics.setFont(smallFont)
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
  --love.graphics.print(type(ball.x), 20, 20)
  --love.graphics.print(tostring(ball.x) .. tostring(ball.width) .. tostring(player1.x) .. tostring(player1.width), 20, 20)
end
