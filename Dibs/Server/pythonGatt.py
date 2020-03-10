
from gattlib import DiscoveryService
import pyrebase
import configparser

configfile = configparser.ConfigParser()
configfile.read('DIBS.config')

config = {
  "apiKey": configfile['Configuration']['apiKey'],
  "authDomain": configfile['Configuration']['authDomain'],
  "databaseURL": configfile['Configuration']['databaseURL'],
  "storageBucket": configfile['Configuration']['storageBucket']
}

firebase = pyrebase.initialize_app(config)

db = firebase.database()

service = DiscoveryService("hci0")

# MAC_ADDR = ['FD:B3:DF:4A:A1:02']
MAC_ADDR = configfile.sections()
MAC_ADDR.pop(0)
print(MAC_ADDR)
# MAC_ADDR_INFO = {'FD:B3:DF:4A:A1:02': {"status": "", "Building": configfile['FD:B3:DF:4A:A1:02']['Building'], "Floor": configfile['FD:B3:DF:4A:A1:02']['Floor'], "Room" : configfile['FD:B3:DF:4A:A1:02']['Room'], "Chair":configfile['FD:B3:DF:4A:A1:02']['Chair']}}
# Each chair is associated with a specific MAC Address
# Preferably put in a config file, so each user does not have access to code
# FD:B3:DF:4A:A1:02 Bluetooth chip
MAC_ADDR_INFO = {}
for mac in MAC_ADDR:
    info = {"status": "0", "Building": configfile[mac]['Building'], "Floor": configfile[mac]['Floor'], "Room" : configfile[mac]['Room'], "Chair":configfile[mac]['Chair'],"Counter": 0 }
    MAC_ADDR_INFO.update({mac : info})
print (MAC_ADDR_INFO)
# MAC_ADDR_INFO = {'FD:B3:DF:4A:A1:02': {"status": "0", "Building": configfile['FD:B3:DF:4A:A1:02']['Building'], "Floor": configfile['FD:B3:DF:4A:A1:02']['Floor'], "Room" : configfile['FD:B3:DF:4A:A1:02']['Room'], "Chair":configfile['FD:B3:DF:4A:A1:02']['Chair'],"Counter": 0 }}
while True:
    devices = service.discover(2)
    #for address, name in devices.items():
    #    print("name: {}, address: {}".format(name, address))
        
    configfile.read('DIBS.config')
#     MAC_ADDR_INFO = {'FD:B3:DF:4A:A1:02': {"status": "0", "Building": configfile['FD:B3:DF:4A:A1:02']['Building'], "Floor": configfile['FD:B3:DF:4A:A1:02']['Floor'], "Room" : configfile['FD:B3:DF:4A:A1:02']['Room'], "Chair":configfile['FD:B3:DF:4A:A1:02']['Chair'],
#                                            "Counter": MAC_ADDR_INFO['FD:B3:DF:4A:A1:02']["Counter"]}}
    for mac in MAC_ADDR:
        info = {"status": "0", "Building": configfile[mac]['Building'], "Floor": configfile[mac]['Floor'], "Room" : configfile[mac]['Room'], "Chair":configfile[mac]['Chair'],"Counter": MAC_ADDR_INFO[mac]["Counter"] }
        MAC_ADDR_INFO.update({mac : info})

    # implement counter
    
    for mac in MAC_ADDR:
#         if True:
        if mac in devices:
            #Call DB with ID set to 1
            updateValue = {"status": "1"}
            data = MAC_ADDR_INFO.get(mac)
            print(data.get("Counter"))
            data.update(updateValue)
            MAC_ADDR_INFO[mac]["Counter"] = 0
            print("found nRF chip with id: " + mac)
            db.child("chair/" + mac).update(data)
        else:
            print("Did not find nRF chip with id: " + mac)
            #Call DB with ID set to 0
            updateValue = {"status": "0"}
            data = MAC_ADDR_INFO.get(mac)
            MAC_ADDR_INFO[mac]["Counter"] += 1
            print(MAC_ADDR_INFO[mac])
            #MAC_ADDR_INFO[mac] = data
            #print(MAC_ADDR_INFO[mac]["Counter"])
            if MAC_ADDR_INFO[mac]["Counter"]== 10:
                db.child("chair/" + mac).update(data)
                MAC_ADDR_INFO[mac]["Counter"] = 0
                
                #data.update(updateValue)
                #data.update(updateCounter)
        
# for address, name in list(devices.items()):
#     print("name: {}, address: {}".format(name, address))
# 
# print("Done.")
