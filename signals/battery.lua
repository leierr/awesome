-- Check if there is actually a BAT0
local battery_check = io.open("/sys/class/power_supply/BAT0","r")
local aspawn = require('awful.spawn')
local gtimer = require('gears.timer')

-- Battery Fetching and Signal Emitting
---------------------------------------
-- Battery information script
local battery_script = "bash -c 'echo $(cat /sys/class/power_supply/BAT0/capacity) echo $(cat /sys/class/power_supply/BAT0/status)'"

local function battery_emit()
    aspawn.easy_async_with_shell(
    battery_script, function(stdout)
    local level = string.match(stdout:match('(%d+)'), '(%d+)')
    local level_int = tonumber(level) -- integer
    local power = not stdout:match('Discharging') -- boolean
    awesome.emit_signal('signal::battery', level_int, power)
  end)
end

-- Refreshing
-------------
if battery_check ~= nil then
    io.close(battery_check)

    gtimer {
        timeout = 20,
        call_now = true,
        autostart = true,
        callback = function()
            battery_emit()
        end
    }
end