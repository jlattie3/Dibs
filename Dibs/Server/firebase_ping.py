#
# Firebase support
#

# conda install -c anaconda pip
# conda activate py2
	# any VENV with python 2
# pip install python-firebase
# python firebase_ping.py

from firebase import firebase

firebase = firebase.FirebaseApplication('https://dibs-a0ffe.firebaseio.com/')

result = firebase.post('chair_id', {'occupied':True})
