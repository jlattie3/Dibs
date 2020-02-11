#
# Firebase support
#

# conda install -c anaconda pip
# conda activate py2
	# any VENV with python 2
# pip install python-firebase
# python firebase_ping.py

from firebase import firebase
#from firebase_admin import db

firebase = firebase.FirebaseApplication('https://dibs-a0ffe.firebaseio.com/')
data = {'1':'abc'}, {'occupied':True}
result = firebase.post('parent/chair_id', data)

re = firebase.get('parent/chair_id', '1')
print(re)
