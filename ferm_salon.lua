commandArray = {}
if (devicechanged['Fermeture_salon'] == 'On' ) then
    if (otherdevices['Fenetre Salon'] == 'Closed' ) then
        print('Fermeture des volets du salon et de l escalier en position intermediaire')
        commandArray[1]={['OpenURL']="http://pi2r/json.htm?type=command&param=switchlight&idx=16&switchcmd=Stop"}
    end
    commandArray[0]={['OpenURL']="http://pi2r/json.htm?type=command&param=switchlight&idx=15&switchcmd=Stop"}
end
return commandArray
