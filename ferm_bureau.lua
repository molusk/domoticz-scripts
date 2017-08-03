commandArray = {}
if (devicechanged['Fermeture_bureau'] == 'On') then
    print('Fermeture du volet du bureau en position intermediaire')
    commandArray[0]={['OpenURL']="http://pi2r/json.htm?type=command&param=switchlight&idx=13&switchcmd=Stop"}
end
return commandArray
