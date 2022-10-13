Paddle = Class{}

PADDLE_SPEED = 150

function Paddle:init(x, y, upKey, downKey)
  self.x = x 
  self.y = y 
  self.upKey = upKey
  self.downKey = downKey
  self.width = 5
  self.height = 20

  self:render(y)
end

function Paddle:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:update(dt)
  if love.keyboard.isDown(self.upKey) then
    self.y = math.max(0, self.y - PADDLE_SPEED * dt)
  elseif love.keyboard.isDown(self.downKey) then
    self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + PADDLE_SPEED * dt)
  end
end
