-----------------------------------------------
------------- Variables à éditer --------------
-----------------------------------------------
 local reference = 'Dehors'  --Sonde extérieure
 local hysteresis = 0.5 --Valeur seuil pour éviter que le relai ne cesse de commuter dans les 2 sens
 local sonde = 'Salon' --Nom de la sonde de température
 local volet = 'Volet salon'
 local actioneur = 'Fermeture_salon'
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
        if (otherdevices['Porte'] == 'Closed' and otherdevices['Presence'] == "Off") then
                local temperature = devicechanged[string.format('%s_Temperature', sonde)]
                local exterieur = mysplit(otherdevices_svalues[string.format(reference)],";")
                local statut = otherdevices[volet]
        --      print ('Température du salon :' .. temperature)
        --      print ('Température de dehors :' .. exterieur[1])

                if (tonumber(exterieur[1]) > temperature ) then
        --              print('Il fait plus chaud dehors de dedans, il faut fermer le salon')
                        if ( statut == 'Stopped' or statut == 'Closed' ) then
        --                      print('Le volet est déjà fermé')
                        else
        --                      print('On ferme !')
                                commandArray[0]={[actioneur]='On'}
                        end
                end
        end
end
return commandArray
