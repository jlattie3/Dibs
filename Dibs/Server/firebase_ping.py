# conda install -c anaconda pip
# pip install firebase-admin
# pip install python-firebase

from firebase import firebase

firebase = firebase.FirebaseApplication('https://dibs-a0ffe.firebaseio.com/')

result = firebase.post('chair_id', {'occupied':True})
