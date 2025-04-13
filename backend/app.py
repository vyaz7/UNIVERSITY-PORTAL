from flask import Flask, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity, JWTManager
from flask_cors import CORS
from class_login import login_route, update_profile, view_profile,insert_profile
from class_data import attendence, marks,seminfo,timetable

app = Flask(__name__)
CORS(app, origins='*', methods=['GET', 'POST', 'PUT', 'DELETE'], allow_headers=['Content-Type', 'Authorization'])
app.config['SECRET_KEY'] = 'y123'  # Replace with your actual secret key
app.config['JWT_TOKEN_LOCATION'] = ['headers', 'query_string']  # Corrected configuration
jwt = JWTManager(app)


@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    return response


@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    result = login_route(data.get('regid'), data.get('password'))
    return jsonify(result)


@app.route('/insert_profile', methods=['POST'])
@jwt_required()
def insert_profile_r():
    data = request.get_json()
    reg_id = get_jwt_identity()
    result = insert_profile(reg_id, data.get('address'), data.get('phone'), data.get('blood_group'),
                            data.get('department'), data.get('cgpa'), data.get('dob'))
    return jsonify(result)

@app.route('/update_profile', methods=['POST'])
@jwt_required()
def update_profile_r():
    data = request.get_json()
    reg_id = get_jwt_identity()
    result = update_profile(reg_id, data.get('address'), data.get('phone'), data.get('blood_group'),
                            data.get('department'), data.get('cgpa'), data.get('dob'))
    return jsonify(result)


@app.route('/view_profile', methods=['POST'])
@jwt_required()
def view_profile_r():
    reg_id = get_jwt_identity()
    data = request.get_json()
    result = view_profile(reg_id, data.get('semid'))
    return jsonify(result)



@app.route('/attendence', methods=['GET'])
@jwt_required()
def attendence_r():
    reg_id = get_jwt_identity()
    semid = request.args.get('semid')
    result = attendence(reg_id, semid)
    return jsonify(result)


@app.route('/marks', methods=['GET'])
@jwt_required()
def marks_r():
    reg_id = get_jwt_identity()
    semid = request.args.get('semid')
    result = marks(reg_id, semid)
    return jsonify(result)

@app.route('/seminfo')
@jwt_required()
def sem():
    sem=seminfo()
    return jsonify(sem)

@app.route('/timetable', methods=['GET'])
@jwt_required()
def timetable_r():
    semid = request.args.get('semid')
    result = timetable(semid)
    return jsonify(result)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=1123)
