-- standard libraries
local awful = require("awful")
local naughty = require("naughty")

local redshift = {}
redshift.state    = 1  -- state = red-gamma(color warmness) active or not
redshift.brightness = 1.0 -- brightness = light/dark ajustment 


-- Apply brightness via redshift
function redshift.apply(value)
    if value < 0.4 then value = 0.4 end --avoid absolute darkness through mashing
    if value > 1.0 then value = 1.0 end
    redshift.brightness = value
    -- redshift -x resets redshift to neutral
    -- the other command adjusts warmness & brightness
    if redshift.state == 1 then
        awful.spawn.with_shell("redshift -x && sleep 0.01 &&" ..
            string.format("redshift -O 2700 -b %.2f", redshift.brightness))
    else 
        awful.spawn.with_shell("redshift -x && sleep 0.01 &&" ..
            string.format("redshift -O 6500 -b %.2f", redshift.brightness))
    end

    naughty.notify {
        title = "Redshift:".. tostring(redshift.state),
        text = string.format("Brightness :%.0f%%", redshift.brightness * 100),
        timeout = 5,   -- duration in seconds
        position = "top_right",
        margin=1,
        height=50,
        fg = "#ffffff",
        bg = "#333333"
    }
end 

-- Convenience functions


-- Adjust brightness
function redshift.darken()
    redshift.apply(redshift.brightness -0.1) 
end

function redshift.brighten()
    redshift.apply(redshift.brightness +0.1)  
end

-- Toggle warmness 
function redshift.toggle()
    if redshift.state == 1 then
        redshift.state = 0
    else
        redshift.state = 1
    end
    redshift.apply(redshift.brightness)
end


return redshift
