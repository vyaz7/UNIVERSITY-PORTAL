import mysql.connector
import bcrypt,jsonify
import secrets
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity, JWTManager
from argon2 import PasswordHasher
from argon2.exceptions import VerifyMismatchError

# Create a password hasher object
ph = PasswordHasher()

def conn():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="root",
            database="clg"
        )
        return connection
    except mysql.connector.Error as err:
        print("Error connecting to MySQL:", err)
        return None
    
def login_route(regid, password): 
    with conn() as connection:
        cursor = connection.cursor()
        cursor.execute("SELECT password FROM Credentials WHERE reg_id = %s", (regid,))
        user = cursor.fetchone()

        if user:
            hashed_password_from_db = user[0].encode('utf-8')  # Ensure it's in bytes
            try:
                if ph.verify(hashed_password_from_db, password):
                    access_token = create_access_token(identity=regid)
                    return {"access_token": access_token}
                else:
                    return {"error": "Invalid password. Please try again."}, 401
            except VerifyMismatchError:
                return {"error": "Invalid password. Please try again."}, 401
        else:
            return {"error": "User not found. Please check your email."}, 401

def insert_profile(reg_id, address, phone, blood_group, department, cgpa, dob):        
    with conn() as connection:
        cursor = connection.cursor()
        sql_query = """INSERT INTO `Profile` 
        (`reg_id`, `Address`, `Phone`, `Blood_Group`, `Department`, `CGPA`, `Dob`)
        VALUES (%s, %s, %s, %s, %s, %s, %s)"""
        values = (reg_id, address, phone, blood_group, department, cgpa, dob)
        
        try:
            cursor.execute(sql_query, values)
            connection.commit()
            return {"status": "success"}
        except mysql.connector.Error as err:
            return {"error": str(err)}

def view_profile(regid):
    with conn() as connection:
        cursor = connection.cursor()
        sql_query = "SELECT * FROM Profile WHERE reg_id=%s"
        values = (regid,)
        try:
            cursor.execute(sql_query, values)
            user = cursor.fetchone()
            if user:
                json_result = {
                    "reg_id": user[0],
                    "address": user[1],
                    "phone": user[2],
                    "blood_group": user[3],
                    "department": user[4],
                    "cgpa": user[5],
                    "dob": user[6]
                }
                return json_result
            else:
                return {"error": "User profile not found."}, 404
        except mysql.connector.Error as err:
            return {"error": str(err)}


def update_profile(reg_id, address, phone, blood_group, department, cgpa, dob):        
    with conn() as connection:
        cursor = connection.cursor()
        sql_query = """UPDATE `Profile` SET 
                       `Address` = %s,
                       `Phone` = %s,
                       `Blood_Group` = %s,
                       `Department` = %s,
                       `CGPA` = %s,
                       `Dob` = %s
                       WHERE `reg_id` = %s"""
        values = (address, phone, blood_group, department, cgpa, dob, reg_id)
        
        try:
            cursor.execute(sql_query, values)
            connection.commit()
            if cursor.rowcount > 0:
                return {"status": "success"}
            else:
                return {"status": "No records updated"}
        except mysql.connector.Error as err:
            return {"error": str(err)} 
