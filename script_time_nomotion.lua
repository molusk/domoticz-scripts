-- script_time_nomotion.lua
-- This script flips a switch when no motion has been detected for more than 30 minutes

--Change the values below to reflect to your own setup
local motion_switch             = 'Presence cuisine'
local nomotion_uservar          = 'decompte_cuisine'
local status_switch1            = 'Lumiere cuisine'
local status_switch2            = 'Lumiere plafonier cuisine'
local status_switch3            = 'Lumiere evier'

--local energy_consumption      = 'Lumiere cuisine'  --Name of Z-Wave plug that contains actual consumption of washingmachine (in Watts)
--local consumption_lower       = 10.0                 --If usage is higher than this value (Watts), the TV is playing/radio is on
local nomotion_timeout          = 4     --Amount of minutes that no motion should be detected to assume nobody is home anymore
--sWatt, sTotalkWh                      = otherdevices_svalues[energy_consumption]:match("([^;]+);([^;]+)")

commandArray = {}

no_motion_minutes = tonumber(uservariables[nomotion_uservar])
remaining = nomotion_timeout - no_motion_minutes

if (otherdevices[motion_switch] == 'Off') then
        no_motion_minutes = no_motion_minutes + 1
else
        no_motion_minutes = 0
end

commandArray['Variable:' .. nomotion_uservar] = tostring(no_motion_minutes)

--if otherdevices[status_switch] == 'On' and no_motion_minutes > 30 then
--if otherdevices[status_switch] == 'On' and no_motion_minutes > tonumber(nomotion_timeout) and tonumber(sWatt) < consumption_lower then
if ( otherdevices[status_switch1] == 'On' or otherdevices[status_switch2] == 'On' or otherdevices[status_switch3] == 'On') and no_motion_minutes > tonumber(nomotion_timeout) then
        commandArray[status_switch2]='Off'
        commandArray[status_switch3]='Off'
        commandArray[status_switch1]='Off'
end

return commandArray
