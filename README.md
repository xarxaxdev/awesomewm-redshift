# awesomwm-redshift

Handling brightness + warmth using redshift exclusively in awesomewm.  Avoids dependencies on other programs (brightnessctl, etc).

Just import:
`local redshift = require("redshift")`

Warmth can be 1 or 0, and toggled with:

`awful.key({"Control","Mod1"}, "r", function() redshift.toggle() end),`

Brightness is adjusted in the interval [0.4,1], with:

`awful.key({}, "XF86MonBrightnessUp", function() redshift.brighten() end),
awful.key({}, "XF86MonBrightnessDown", function() redshift.darken()  end),`





