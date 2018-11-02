import mysql.connector
from mysql.connector import errorcode

try:
    conn = mysql.connector.connect(user = 'user_name', password = 'password',
    host = 'host',
    database = 'db_name', port = 'port')
    print ("Connected")
except:
    print ("Cannot connect to server")
else:
    conn.close()
    print ("Disconnected")

# mysql -u user_name -p password -h host -P port db_name
