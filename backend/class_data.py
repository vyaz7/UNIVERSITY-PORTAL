import mysql.connector
import json
from class_login import conn

def attendence(regid, semid):
    # Establishing connection to the database
    with conn() as connection:
        # Creating a cursor object
        cursor = connection.cursor()

        # Executing the query
        query = """
            SELECT 
                c.Course_id,
                c.Course,
                a.tot_classes AS `TOT NO CLASS`,
                a.tot_present AS `TOT PRESENT`
            FROM 
                Attendance a
            INNER JOIN 
                Class cl ON a.class_id = cl.id
            INNER JOIN 
                Course c ON cl.Course_id = c.Course_id
            WHERE 
                cl.Semester_id = %s AND
                a.reg_id = %s;
        """
        values = (semid, regid)
        cursor.execute(query, values)

        # Fetching results and building JSON response
        results = []
        for row in cursor.fetchall():
            result_dict = {
                "Course_id": row[0],
                "Course": row[1],
                "TOT NO CLASS": row[2],
                "TOT PRESENT": row[3],
                "PERSENTAGE": (row[3]/row[2])*100
            }
            results.append(result_dict)

        # Closing the cursor and connection
        cursor.close()
        connection.close()

        # Returning JSON response
        return results

def marks(regid, semid):
    # Establishing connection to the database
    with conn() as connection:
        # Creating a cursor object
        cursor = connection.cursor()

        # Executing the query
        query = """
            SELECT 
                Marks.Exam_id AS courseid,
                Course.Course AS course,
                Marks.tot_mark AS `TOT MARKS`,
                Marks.mark AS `MARKS SCORED`
            FROM 
                Marks
            JOIN 
                Exam ON Marks.Exam_id = Exam.ID
            JOIN 
                Course ON Exam.Course_id = Course.Course_id
            WHERE 
                Exam.Semester_id = %s AND Marks.reg_id = %s;
        """
        values = (semid, regid)
        cursor.execute(query, values)

        # Fetching results and building JSON response
        results = []
        for row in cursor.fetchall():
            result_dict = {
                "Course_id": row[0],
                "Course": row[1],
                "TOT MARKS": row[2],
                "MARKS SCORED": row[3]
            }
            results.append(result_dict)

        # Closing the cursor and connection
        cursor.close()
        connection.close()

        # Returning JSON response
        return results





def seminfo():
    with conn() as connection:
        cursor = connection.cursor(dictionary=True)

        
        query = "SELECT * FROM Semester"
        cursor.execute(query)

        # Fetch results and build JSON response
        sem = cursor.fetchall()

        # Closing the cursor and connection
        cursor.close()
        connection.close()

        # Returning JSON response
        return sem


def timetable(semid):
    # Establishing connection to the database
    with conn() as connection:
        # Creating a cursor object
        cursor = connection.cursor()

        # Executing the query
        query = """
    -- Query with Semester ID
SELECT 
    Exam.Name AS Exam_Name,
    Course.Course AS Course_Name,
    Exam.date_of_exam AS Exam_Date
FROM 
    Exam
JOIN 
    Course ON Exam.Course_id = Course.Course_id
WHERE 
    Exam.Semester_id = %s;

        """
        values = (semid,)
        cursor.execute(query, values)

        # Fetching results and building JSON response
        results = []
        for row in cursor.fetchall():
            result_dict = {
                "EXAM": row[0],
                "Course": row[1],
                "DATE": row[2],
            }
            results.append(result_dict)

        # Closing the cursor and connection
        cursor.close()
        connection.close()

        # Returning JSON response
        return results

