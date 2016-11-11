#Make sure your SQL service is started before executing

import subprocess
from flask import Flask, request, redirect, url_for, current_app
from flaskext.mysql import MySQL
from flask_restful import Resource, Api, reqparse #Request parsing

#Setup
app = Flask(__name__)
mysql = MySQL()
api = Api(app)

# Config for the SQL server, DON'T push your password to public git
app.config['MYSQL_DATABASE_USER'] = 'root'
## Get password from HTTP server, dont change this
file = open('/home/www/private/sql_password.txt', 'r')
app.config['MYSQL_DATABASE_PASSWORD'] = file.read(17)
file.close()
app.config['MYSQL_DATABASE_DB'] = 'Timeless'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

# Homepage
@app.route("/")
def home():
    return "Welcome to our nice Timeless Flask app!"
#EXPERIMENTS:
    #return redirect(url_for('static', filename='index.html'))
    #return current_app.send_static_file('index.html')

# User Login
@app.route("/Authenticate")
def Authenticate():
    username = request.args.get('Username')
    if not username:
	return "No username given"
    password = request.args.get('Password')
    if not password:
	return "No password given"

    # Todo: Hash password input
    cursor = mysql.connect().cursor()
    cursor.execute("SELECT * from tbl_user where user_email='" + username + "' and user_password='" + password + "'")
    data = cursor.fetchone()
    if data is None:
     return "Username or Password is wrong"
    else:
     return "Logged in successfully"


# New User registration
class CreateUser(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('email', type=str, help='Email address to create user')
            parser.add_argument('password', type=str, help='Password to create user')
            args = parser.parse_args()
            _userEmail = args['email']
            _userPassword = args['password']
            
            ####DEBUG
            #return {'email': args['email'], 'password': args['password']}

            if _userEmail is None or _userPassword is None:
		return {'error': "'email' or 'password' field blank"}

            # Todo: Hash password and sanitize input, check for valid email address form


	    # Run the mysql procedure to create a user, assuming mysql has been set up using db.sql
	    conn = mysql.connect()
	    cursor = conn.cursor()
	    cursor.callproc('spCreateUser',(_userEmail,_userPassword))
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

@app.route("/Gitupdate", methods=['GET', 'POST'])
def Gitupdate():
    return subprocess.Popen("./PullAndRestart.sh", shell=True, stdout=subprocess.PIPE).stdout.read() 

# Goes at the bottom
if __name__ == "__main__":
    app.run()

