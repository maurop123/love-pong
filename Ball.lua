Ball = Class{}

function Ball:init(x, y, width, height)
  self.initX = x
  self.initY = y

  self.width = width
  self.height = height
  
  --set init position and velocity
  self:reset()
end

function Ball:reset()
  self.x = self.initX
  self.y = self.initY
  self.dx = math.random(2) == 1 and 100 or -100
  self.dy = math.random(-55, 55)
end

--AABB collision detection
function Ball:collides(paddle)
  if self.x > paddle.x + paddle.width or self.x + self.width < paddle.x then
    return false
  end
  if self.y > paddle.y + paddle.height or self.y + self.height < paddle.y then
    return false
  end

  return true
end

function Ball:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

function Ball:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
