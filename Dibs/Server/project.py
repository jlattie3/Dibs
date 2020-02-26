import pyrebase

config = {
  "apiKey": "AIzaSyDYP21VKuaihs9qqNAhELsCXVg9Z4XeRaI",
  "authDomain": "dibs-a0ffe.firebaseapp.com",
  "databaseURL": "https://dibs-a0ffe.firebaseio.com",
  "storageBucket": "dibs-a0ffe.appspot.com"
}

firebase = pyrebase.initialize_app(config)

db = firebase.database()

MAC_ADDR = "AA:BB:DD"


data = {"status": "0", "Building": "Van Leer", "Floor": "2", "Room": "242"}
db.child("chair/" + MAC_ADDR).update(data)
