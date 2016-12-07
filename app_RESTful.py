#Make sure your SQL service is started before executing

import logging # For sending debug to browser console
import sys

import subprocess
from flask import Flask, request, render_template, jsonify
from flaskext.mysql import MySQL
from flask_restful import Resource, Api, reqparse #Request parsing

#Setup
app = Flask(__name__)
mysql = MySQL()
api = Api(app)

# Config for the SQL server, DON'T push your password to public git
app.config['MYSQL_DATABASE_USER'] = 'root'
## Get password from HTTP server, dont change this
try:
    file = open('/home/www/private/sql_password.txt', 'r')
    try:
        app.config['MYSQL_DATABASE_PASSWORD'] = file.read(17)
    finally:
        file.close()
except IOError:
    file = None

app.config['MYSQL_DATABASE_DB'] = 'Timeless'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

# Homepage
@app.route("/")
def home():
    ##DEBUG info - check database login success
    if file == None:
        print >> sys.stderr, "Password NOT loaded"
    else:
        #app.logger.warning('DB login success')
        print >> sys.stderr, "DB login success"
    ##END DEBUG info
    return render_template('login.html') 

# User Login
@app.route("/Authenticate")
def Authenticate():
    email = request.args.get('email')
    if not email:
	return "No email given"
    password = request.args.get('password')
    if not password:
	return "No password given"

    # Todo: Hash password input
    cursor = mysql.connect().cursor()
    # Warning: SQL injection exploits galore!
    cursor.execute("SELECT * from tbl_user where user_email='" + email + "' and user_password='" + password + "'")
    data = cursor.fetchone()
    if data is None:
     return "Login failed. Check email and password"
    else:
     return "Logged in successfully"


# New User registration
class CreateUser(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('email', type=str, help='Email address to create user')
            parser.add_argument('password', type=str, help='Password to create user')
            parser.add_argument('first_name', type=str, help='User first name')
            args = parser.parse_args()
            _userEmail = args['email']
            _userPassword = args['password']
            _userName = args['first_name']
 
            ####DEBUG
            #return {'email': args['email'], 'password': args['password']}

            if _userEmail is None or _userPassword is None or _userName is None:
		return {'error': "'email','password', or 'first_name' field blank"}

            # Todo: Hash password and sanitize input, check for valid email address form


	    # Run the mysql procedure to create a user, assuming mysql has been set up using db.sql
	    conn = mysql.connect()
	    cursor = conn.cursor()
	    cursor.callproc('spCreateUser',(_userEmail,_userPassword,_userName))
	    data = cursor.fetchall()

	    # Check for success
	    if len(data) is 0:
		conn.commit()
		return {'StatusCode':'200','Message': 'User creation success'}

	    else:
		return{'StatusCode':'1000','Message': str(data[0])}

        except Exception as e:
            return {'error': str(e)}



api.add_resource(CreateUser, '/CreateUser')

# Registration Page
@app.route("/register")
def Register():
    return render_template('register.html')


# Notes Page
@app.route("/notes", methods=['GET', 'POST'])
def Notes():
    if request.method == 'GET':
        return render_template('notes.html')
    else:
        post_input = request.get_json()
        
        # Call functions when json 'action' reads "get" or "save"
        if 'action' not in post_input:
            return "No 'action' given"
        action = post_input['action']
        if action == 'get':
            return getNote(**post_input)
        elif action == 'save':
            return saveNote(**post_input)
        elif action == 'new':
            return newNote(**post_input)
        else:
            return "Invalid 'action'"


        ######## Retrieve note from the database ########
        ######## Arguments: action, note_id
def getNote(**post_input):
        
        # Establish connection
        conn = mysql.connect()
        cursor = conn.cursor()

        note_id = post_input['note_id']
        # Check if note id given 
        if note_id == None:
            return "Error: getNote failed, note_id field blank"
        try: 
            cursor.callproc('spGetNote',(note_id,))
            data = cursor.fetchall()
            return jsonify(data)
        except Exception as e:
            return str(e)


        ######## Save the note to the database#####
        ######## Arguments: action, note_id, note_body
def saveNote(**post_input):

        # Establish connection
        conn = mysql.connect()
        cursor = conn.cursor() 

        note_id = post_input['note_id']
        note_body = post_input['note_body']
        if note_id == None or note_body == None:
            return "Error: 'note_body' or 'note_id' empty"
        try:
            cursor.callproc('spSaveNote',(note_id,note_body))
            data = cursor.fetchall()
            return jsonify(data)
        except Exception as e:
            return str(e)
        ###########################################

        ######## Make a new note #####
        ######## Arguments: action, note_body
def newNote(**post_input):

        # Establish connection
        conn = mysql.connect()
        cursor = conn.cursor() 

        try:
            cursor.callproc('spNewNote',())
            data = cursor.fetchall()
            return jsonify(data)
        except Exception as e:
            return str(e)
        ###########################################

# User Page
@app.route("/user/<name>")
def User(name=None):
    return render_template('user.html', name=name) 



@app.route("/Gitupdate", methods=['GET', 'POST'])
def Gitupdate():
    return subprocess.Popen("./PullAndRestart.sh", shell=True, stdout=subprocess.PIPE).stdout.read() 

# Goes at the bottom
if __name__ == "__main__":
    app.run()

