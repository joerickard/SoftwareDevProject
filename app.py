from flask import Flask, render_template, request, json
from flask.ext.mysql import MySQL
app = Flask(__name__)

@app.route('/trapdoor')
def enterPID():
	return render_template('loginRegister.html')

@app.route('/trapdoor', methods=['GET', 'POST'])
def loginOrCreate():
	return render_template('loginRegister.html')
	#our login stuff here, I'm working on it.


@app.route('/')
def main():
	return render_template('front.html')

if __name__=="__main__":
	app.run(debug=True)