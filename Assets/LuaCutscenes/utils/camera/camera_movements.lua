local CameraUtils = {}

---@alias EaseType
---| 'cam.Ease.Linear'
---| 'cam.Ease.SineIn'
---| 'cam.Ease.SineOut'
---| 'cam.Ease.SineInOut'
---| 'cam.Ease.QuadIn'
---| 'cam.Ease.QuadOut'
---| 'cam.Ease.QuadInOut'
---| 'cam.Ease.BackOut'
---| 'cam.Ease.BounceOut'

---@enum Ease
CameraUtils.Ease = {
    Linear = "linear",
    SineIn = "sineIn",
    SineOut = "sineOut",
    SineInOut = "sineInOut",
    QuadIn = "quadIn",
    QuadOut = "quadOut",
    QuadInOut = "quadInOut",
    BackOut = "backOut",
    BounceOut = "bounceOut"
}

-- Freeze table to make it read-only
setmetatable(CameraUtils.Ease, {
    __newindex = function()
        error("Attempt to modify read-only Ease enum", 2)
    end
})

local Easing = {
    linear = function(t) return t end,
    sineIn = function(t) return 1 - math.cos((t * math.pi) / 2) end,
    sineOut = function(t) return math.sin((t * math.pi) / 2) end,
    sineInOut = function(t) return -(math.cos(math.pi * t) - 1) / 2 end,
    quadIn = function(t) return t * t end,
    quadOut = function(t) return 1 - (1 - t) * (1 - t) end,
    quadInOut = function(t) return t < 0.5 and 2 * t * t or 1 - math.pow(-2 * t + 2, 2) / 2 end,
    backOut = function(t)
        local c1 = 1.70158
        return 1 + (c1 + 1) * math.pow(t - 1, 3) + c1 * math.pow(t - 1, 2)
    end,
    bounceOut = function(t)
        local n1, d1 = 7.5625, 2.75
        if t < 1 / d1 then return n1 * t * t
        elseif t < 2 / d1 then t = t - 1.5 / d1; return n1 * t * t + 0.75
        elseif t < 2.5 / d1 then t = t - 2.25 / d1; return n1 * t * t + 0.9375
        else t = t - 2.625 / d1; return n1 * t * t + 0.984375 end
    end
}

---Moves the camera over time with easing.
---@param targetX number Target X position in pixels
---@param targetY number Target Y position in pixels
---@param duration number Duration in seconds
---@param easeType EaseType|string Ease algorithm to use
function CameraUtils.lerpCamera(targetX, targetY, duration, easeType)
    local startX = celeste.getCameraX()
    local startY = celeste.getCameraY()
    local elapsed = 0
    local easeFunc = Easing[easeType] or Easing.sineInOut

    while elapsed < duration do
        elapsed = elapsed + dt
        local t = math.min(elapsed / duration, 1.0)
        local progress = easeFunc(t)

        local currentX = startX + (targetX - startX) * progress
        local currentY = startY + (targetY - startY) * progress

        celeste.setCamera(currentX, currentY)
        wait(0)
    end
end

return CameraUtils