from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
from flask_mail import Mail
import json
import datetime
import random
import pprint

local_server= True
app = Flask(__name__)
app.secret_key='tamimnadheef'

# app.config['SQLALCHEMY_DATABASE_URI']='mysql://username:password@localhost/databas_table_name'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/rms'
db = SQLAlchemy(app)

login_manager = LoginManager(app)
login_manager.login_view = 'signin'

@login_manager.user_loader
def load_user(id):
    return Accounts.query.get(id)

class Owner(db.Model):
    O_ID = db.Column(db.Integer, db.ForeignKey('accounts.id'), primary_key=True)
    O_NAME = db.Column(db.String(20))
    O_PHNO = db.Column(db.String(20))
    O_ADDRESS = db.Column(db.String(20))



class Clients(db.Model):
    C_ID = db.Column(db.Integer, db.ForeignKey('accounts.id'), primary_key=True)
    C_NAME = db.Column(db.String(20))
    C_PHNO = db.Column(db.String(20),unique=True)
    C_EMAIL = db.Column(db.String(20),unique=True)
    C_AGE = db.Column(db.Integer)
    C_ADDRESS = db.Column(db.String(20))

class Property(db.Model):
    P_ID = db.Column(db.Integer, primary_key=True)
    P_NAME = db.Column(db.String(20))
    P_LOC = db.Column(db.String(20))
    P_TYPE = db.Column(db.String(20))
    P_BHK = db.Column(db.Integer, nullable=True)
    P_SQFT = db.Column(db.Integer)
    A_ID = db.Column(db.Integer, db.ForeignKey('agents.A_ID'), primary_key=True)
    O_ID = db.Column(db.Integer, db.ForeignKey('owner.O_ID'), primary_key=True)

class Agents(db.Model):
    A_ID = db.Column(db.Integer, db.ForeignKey('accounts.id'), primary_key=True)
    A_NAME = db.Column(db.String(20))
    A_PHNO = db.Column(db.String(20))
    A_ADDRESS = db.Column(db.String(20))

class Buys(db.Model):
    C_ID = db.Column(db.Integer, db.ForeignKey('clients.c_id'), primary_key=True)
    P_ID = db.Column(db.Integer, db.ForeignKey('property.p_id'), primary_key=True)
    P_NAME = db.Column(db.String(20), db.ForeignKey('property.p_name'))
    Total_Amount = db.Column(db.Integer, nullable= False)

class Listings(db.Model):
    P_ID = db.Column(db.Integer, db.ForeignKey('property.p_id'), primary_key=True)
    A_ID = db.Column(db.Integer, db.ForeignKey('agents.a_id'), primary_key=True)
    Rent_Price = db.Column(db.Integer, nullable=True)
    Sale_Price = db.Column(db.Integer, nullable=True)
    Agreement = db.Column(db.String(20))

class Accounts(db.Model, UserMixin):
    id = db.Column(db.Integer,primary_key = True)
    email = db.Column(db.String(255), nullable = False)
    passw = db.Column(db.String(20), nullable= False)

@app.route('/')
def hello_world():
    return render_template('home.html')

@app.route("/signin", methods=["POST","GET"])
def signin():
    if request.method == "POST":
        email = request.form.get('email')
        passw = request.form.get('passw')
        emailCheck = Accounts.query.filter_by(email=email).first()
        passwCheck = emailCheck.passw
        print(emailCheck,passwCheck,email,passw)

        if emailCheck and passwCheck == passw:
            login_user(emailCheck)
            return redirect(url_for('hello_world'))
        else:
            print('ulta seeda kya ki likhe')
            return render_template('signin.html')

    return render_template('signin.html')

@app.route("/signup",methods=["POST","GET"])
def signup():
    if request.method == "POST":
        personname = request.form.get('name')
        email = request.form.get('email')
        passw = request.form.get('passw')
        typeacc = request.form.get('accType')
        loc = request.form.get('loc')
        age = request.form.get('age')
        phno = request.form.get('phno')
        idno = random.randint(0,1000)
        print(passw,email,personname,typeacc,age,phno,loc)
        newAccount = Accounts(id=idno,email=email,passw=passw)
        if typeacc == 'Trader':
            newOwner = Owner(O_ID=idno,O_NAME=personname,O_ADDRESS=loc,O_PHNO=phno)
            newClient = Clients(C_ID=idno,C_NAME=personname,C_ADDRESS=loc,C_PHNO=phno,C_EMAIL=email,C_AGE=age)
            db.session.add(newOwner)
            db.session.add(newClient)
        elif typeacc == 'Agent':
            newAgent = Agents(A_ID=idno,A_NAME=personname,A_ADDRESS=loc,A_PHNO=phno)
            db.session.add(newAgent)
        db.session.add(newAccount)
        db.session.commit()

    return render_template('signup.html')

@app.route('/logout',methods=["POST","GET"])
@login_required
def logout():
    if Accounts.is_authenticated:
        logout_user()
        flash("Logout SuccessFul","warning")
        print(current_user)
        return redirect(url_for('signin'))
    print(current_user)
    return redirect(url_for('signup'))

@app.route("/add",methods=["POST","GET"])
@login_required
def addListing():
    if not Accounts.is_authenticated:
        flash('Please login')
        return redirect(url_for('signin'))
    else:

        print('test233232')
        print('test1')
        p_id = random.randint(0, 1000)
        agent_ids = db.engine.execute(f"SELECT `A_ID` FROM `agents`;").all()
        print(agent_ids)
        tuple(agent_ids)
        print(agent_ids)
        if request.method == "POST":
            print('test2')
            print(current_user.id,current_user)
            p_name = request.form.get('p_name')
            p_address = request.form.get('p_address')
            p_bhk = request.form.get('p_bhk')
            p_sqft = request.form.get('p_sqft')
            p_type = request.form.get('p_type')
            test = current_user.id
            print(p_name, p_address, p_sqft, p_bhk, p_type)
            newProp = Property(P_ID=p_id, P_NAME=p_name, P_LOC=p_address, P_BHK=p_bhk, P_SQFT=p_sqft, P_TYPE=p_type,A_ID=1,O_ID=test)
            db.session.add(newProp)
            db.session.commit()
        return render_template('add.html')


@app.route("/search",methods=['POST',"GET"])
def searchListings():
    if request.method == 'POST':
        P_SQFT = request.form.get('psqft_s')
        P_TYPE = request.form.get('ptype_s')
        P_LOC = request.form.get('ploc_s')
        P_NAME = request.form.get('pname_s')
        P_BHK = request.form.get('pbhk_s')
        O_NAME = request.form.get('oname_s')
        print(P_SQFT,P_LOC,P_NAME,P_TYPE,O_NAME,P_BHK)
        result = db.engine.execute(f"SELECT `agents`.`A_NAME`, `property`.* FROM `agents` LEFT JOIN `property` ON `agents`.`A_ID` = `property`.`A_ID`;").all()
        # result = db.engine.execute(f"SELECT property.*,agents.A_NAME FROM `property`,'agents' WHERE `P_TYPE` = '{P_TYPE}' AND `P_BHK` = '{P_BHK}' AND `P_LOC` LIKE '%{P_LOC}%' AND 'property.A_ID'='agents.A_ID'")
        # if P_LOC != '':
        #     result = db.engine.execute(f"SELECT * FROM `property` WHERE `P_LOC` LIKE '%{P_LOC}%'").all()
        # if P_NAME != '':
        #     result = db.engine.execute(f"SELECT * FROM `property` WHERE `P_NAME' LIKE '%{P_NAME}%'").all()
        # if P_BHK != '':
        #     result = db.engine.execute(f"SELECT * FROM `property` WHERE `P_BHK` = '{P_BHK}'").all()
        #     print(result)

            # f"SELECT * FROM `property` WHERE `P_NAME' LIKE '%{P_NAME}%' OR `P_TYPE` = '{P_TYPE}' OR `P_BHK` = '{P_BHK}' OR `P_LOC` LIKE '%{P_LOC}%'").all()
        return render_template('display.html',no_of=len(result),result=result)
    return render_template('search.html')

# @app.route("/display",methods=['POST',"GET"])
# def dispListings():
#     if request.method == 'POST':
#         print('test')
#         return render_template('display.html')


@app.route("/profile")
def display():
    test = current_user.id
    print(test)
    # result = db.engine.execute(F"SELECT * FROM `property` WHERE `O_ID` = '{test}';").all()
    result = db.engine.execute(f"SELECT `agents`.`A_NAME`,`agents`.`A_PHNO`,`property`. * FROM `property` JOIN `agents` ON `agents`.`A_ID` = `property`.`A_ID` AND `property`.`O_ID`={test};").all()
    print(result)
    return render_template('profile.html',no_of=len(result) ,result=result)

@app.route("/delete/<string:P_ID>",methods=['POST','GET'])
@login_required
def delete(P_ID):
    db.engine.execute(F"DELETE FROM `property` WHERE `P_ID`='{P_ID}';")
    print("test")
    flash("Slot Deleted Successful","danger")
    return redirect('/profile')

@app.route("/test",methods=['POST','GET'])
def test():
    return render_template('index.html')


app.run(debug=True)