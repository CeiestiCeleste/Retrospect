-- local cam = require("../../../utils/camera/camera_movements")
-- local cam = require("../../../utils/camera/camera_movements)
local cam = require("Assets.LuaCutscenes.past.youth_valley.1.test")
-- local cam = require("Assets.LuaCutscenes.utils.camera.camera_movements")
-- utils\camera\camera_movements.lua
-- C:\Program Files (x86)\Steam\steamapps\common\Celeste\Mods\Restrospect\Assets\LuaCutscenes\utils\camera\camera_movements.lua
function onBegin()
    -- if celeste.getFlag("youth_valley_1_camera_focus") then
        cam.lerpCamera(720, 288, 2.0, cam.Ease.BackOut)
    -- end
end

--- Callback for when the cutscene ends.
-- Function, no yielding actions allowed.
-- That means no walking, waiting etc.
-- Only "clean up" actions.
-- @tparam #Celeste.Level room Current room.
-- @bool wasSkipped If the cutscene was skipped.
function onEnd(room, wasSkipped)
    
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