function JumpInFromEdge(p_entity, p_scene, entryXOffset, floorYOffset, walkDistance, jumpPower)
    if not p_entity then return end
    local level = p_scene
    if not player or not p_scene then return end

    local entryOffset = tonumber(entryXOffset) or 0
    local floorOffset = tonumber(floorYOffset) or 0
    local dist = tonumber(walkDistance) or 0
    local power = tonumber(jumpPower) or 0

    local startX = level.Bounds.X + entryOffset
    local targetX = startX + dist
    local floorY = level.Bounds.Y + floorOffset

    player.Speed.Y = 1000
    wait(0.05)

    jump(power)
    -- player.State = 0
    waitUntilOnGround()
end

function PrintEntityProperties(p_entity)
    if not player then return end
    for _key, _value in pairs(p_entity) do
        print("Player property:", _key, _value)
    end
    local Px = p_entity.Position.X
    local Py = p_entity.Position.Y
    print("Entity is at X: " .. Px .. ", Y: " .. Py)
end
function PrintSceneProperties(p_scene)
    if not p_scene then return end
    local _room = p_scene
    local Lbx = _room.Bounds.X
    local Lby = _room.Bounds.Y
    print("Room Bounds: " .. Lbx .. ", " .. Lby)
end
function PrintEntityRoomProperties(p_entity, p_scene)
    if not player or not p_scene then return end
    for _key, _value in pairs(p_entity) do
        print("Player property:", _key, _value)
    end
    local Px = p_entity.Position.X
    local Py = p_entity.Position.Y
    local _room = p_scene
    local Lbx = _room.Bounds.X
    local Lby = _room.Bounds.Y
    local boundsWidth = _room.Bounds.boundsWidth
    local localX = math.floor(Px - Lbx)
    local localY = math.floor(Py - Lby)
    print("Entity is at X: " .. Px .. ", Y: " .. Py)
    print("Room Bounds: " .. Lbx .. ", " .. Lby)
    print("Room Local Position: " .. localX .. ", " .. localY)
end

function onBegin()
    disableMovement()

    -- Call the helper method directly
    PrintEntityRoomProperties(player, player.Scene)
    JumpInFromEdge(player, player.Scene, 0, 0, 20, 20)
    PrintEntityRoomProperties(player, player.Scene)
    -- jumpInFromEdgeOld(-16, 368, 48, 120)
end

--- Callback for when the cutscene ends.
-- Function, no yielding actions allowed.
-- That means no walking, waiting etc.
-- Only "clean up" actions.
-- @tparam #Celeste.Level room Current room.
-- @bool wasSkipped If the cutscene was skipped.
function onEnd(room, wasSkipped)
    enableMovement()
end

--- Callback for when a player enters the trigger.
-- Only works as long as the cutscene is running.
-- @tparam #Celeste.Player player The player that entered the trigger.
function onEnter(player)
    
end

--- Callback for when a player stays in the trigger (once per frame).
-- Only works as long as the cutscene is running.
-- @tparam #Celeste.Player player The player that is staying in the trigger.
function onStay(player)

end

--- Callback for when a player leaves the trigger.
-- Only works as long as the cutscene is running.
-- @tparam #Celeste.Player player The player that exited the trigger.
function onLeave(player)

end


-- Helper method to jump in from the edge
-- function jumpInFromEdge(side, entryXOffset, floorYOffset, walkDistance, jumpPower)
--     -- 1. Validate player and scene
--     if not player or not player.Scene then return end

--     local level = player.Scene
--     local boundsX = level.Bounds.X + 400 + 200
--     local boundsY = level.Bounds.Y + 900+300
--     local boundsWidth = level.Bounds.boundsWidth
--     -- Default fallback values
--     local sideLower = string.lower(side or "left")
--     local entryOffset = entryXOffset or 16
--     local floorOffset = floorYOffset or 0
--     local dist = walkDistance or 48
--     local power = jumpPower or 120

--     local startX, targetX
--     local floorY = boundsY + floorOffset

--     if sideLower == "right" then
--         startX = (boundsX + boundsWidth) + entryOffset
--         targetX = startX - dist
--     else
--         -- Default to left if side is "left" or anything unrecognized
--         startX = boundsX - entryOffset
--         targetX = startX + dist
--     end

--     -- Convert to integers safely
--     local safeX = math.floor(tonumber(startX) or 0)
--     local safeY = math.floor(tonumber(floorY) or 0)
--     local safeTargetX = math.floor(tonumber(targetX) or 0)

--     -- 2. Teleport to start
--     teleportTo(safeX, safeY)
--     wait(0.05)

--     -- 3. Walk inward and jump
--     walkTo(safeTargetX, false, 1)
--     jump(power)
--     waitUntilOnGround()
-- end
function jumpInFromEdgeOld(entryXOffset, floorYOffset, walkDistance, jumpPower)
    local level = player.Scene
    if not player or not level then return end

    local entryOffset = tonumber(entryXOffset) or -16
    local floorOffset = tonumber(floorYOffset) or 264
    local dist = tonumber(walkDistance) or 73
    local power = tonumber(jumpPower) or 120

    local startX = level.Bounds.X + entryOffset
    local targetX = startX + dist
    local floorY = level.Bounds.Y + floorOffset

    -- Modify the vector properties directly
    player.Position.X = startX
    player.Position.Y = floorY
    wait(0.05)

    -- Walk inward and jump
    walkTo(targetX, false, 1)
    jump(power)
    waitUntilOnGround()
end