Powerups = Class{}

function Powerups:init(x, y, keyValid)
    self.x = x
    self.y = y
    self.width = 16
    self.height = 16
    self.dy = 0
    self.dx = 0
    if keyValid then
		self.type = 10
	else
		self.type = math.random(1, 9)
	end
    self.collided = false
    self.blinkTimer = 0
	self.startupTimer = 0
	self.visible = true
end

function Powerups.renderBar(key)
	local x = 4
	local y = VIRTUAL_HEIGHT - 20
	if key then
		love.graphics.draw(gTextures['main'], gFrames['powerups'][10], x, y)
		x = x + 16
	end

end

function Powerups:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function Powerups:update(dt)
    if self.startupTimer < 3.4285 then
		self.startupTimer = self.startupTimer + dt
		self.blinkTimer = self.blinkTimer + dt
		if self.blinkTimer > 0.4285 then
			self.blinkTimer = self.blinkTimer - 0.4285
			self.visible = not self.visible
		end
	else
		self.y = self.y + 1
	end
end

function Powerups:render()
    if self.visible then
        love.graphics.draw(gTextures['main'], gFrames['powerups'][self.type],self.x, self.y)
    end
end