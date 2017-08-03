-----------------------------------------------
------------- Variables à éditer --------------
-----------------------------------------------
 local reference = 'Dehors'  --Sonde extérieure
 local hysteresis = 0.5 --Valeur seuil pour éviter que le relai ne cesse de commuter dans les 2 sens
 local sonde = 'Bureau' --Nom de la sonde de température
 local volet = 'Volet bureau'
 local actioneur = 'Fermeture_bureau'
-----------------------------------------------
--------- Fin des variables à éditer ----------
-----------------------------------------------

-----------------------------------------------
------- Fonction de découpage de string -------
-----------------------------------------------
function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t,str)
        end
        return t
end
-----------------------------------------------
-- Fin de la fonction de découpage de string --
-----------------------------------------------
commandArray = {}

if (devicechanged[sonde]) then
    local temperature = devicechanged[string.format('%s_Temperature', sonde)]
    local exterieur = mysplit(otherdevices_svalues[string.format(reference)],";")
    local statut = otherdevices[volet]
--    print ('Température du bureau :' .. temperature)
--    print ('Température de dehors :' .. exterieur[1])

    hour = os.date("%H")
    if (tonumber(hour) > 9 and tonumber(hour) < 19 and otherdevices['Presence'] == "Off") then
        if (tonumber(exterieur[1]) > temperature ) then
    --        print('Il fait plus chaud dehors de dedans, il faut fermer le bureau')
            if (tonumber(exterieur[1]) > temperature + 2 ) then
                if ( statut ~= 'Closed' ) then
                    commandArray[0]={[volet]='On'}
                end
            else
                if ( statut ~= 'Closed' and statut ~= 'Stopped' ) then
    --              print('On ferme !')
                    commandArray[0]={[actioneur]='On'}
                end
            end
        end
    else
  --      print("Après l'heure, c'est plus l'heure !")
    end
end
return commandArray
