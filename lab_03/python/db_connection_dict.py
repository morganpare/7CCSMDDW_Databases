import mysql.connector
from mysql.connector import errorcode

conn_params = {
    "database":"db_name",
    "host":"host",
    "user":"user_name",
    "password":"password",
    "port":"port"
}

try :
    conn = mysql.connector.connect(**conn_params)
    print ("Connected")
except mysql.connector.Error as e:
    print ("Cannot connect to server")
    print ("Error code : % s" % e. errno)
    print ("Error message : %s" % e. msg)
    print ("Error SQLSTATE : %s" % e. sqlstate)
else:
    conn.close()
    print ("Disconnected")
