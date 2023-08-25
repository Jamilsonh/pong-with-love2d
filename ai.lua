AI = {}

function AI:load()
   self.width = 20
   self.height = 100
   self.x = love.graphics.getWidth() - self.width - 50
   self.y = love.graphics.getHeight() / 2
   self.yVel = 0
   self.speed = 500

   self.timer = 0
   self.rate = 0.1
end

function AI:update(dt)
   self:move(dt)
   self:checkBoundaries()
   self.timer = self.timer + dt
   if self.timer > self.rate then
      self.timer = 0
      self:acquireTarget()

      -- Add random movement here
      local randomMove = love.math.random(-1, 1) -- Generates -1, 0, or 1 randomly
      self.yVel = self.yVel + (randomMove * self.speed * 0.2) -- Adjust the multiplier for randomness intensity
   end
end


function AI:move(dt)
   self.y = self.y + self.yVel * dt
end

function AI:acquireTarget()
   if Ball.y + Ball.height < self.y then
      self.yVel = -self.speed
   elseif Ball.y > self.y + self.height then
      self.yVel = self.speed
   else
      self.yVel = 0
   end
end

function AI:checkBoundaries()
   if self.y < 0 then
      self.y = 0
   elseif self.y + self.height > love.graphics.getHeight() then
      self.y = love.graphics.getHeight() - self.height
   end
end


function AI:draw()
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end