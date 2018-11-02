import mysql.connector
from mysql.connector import errorcode

cursor = conn.cursor()
cursor.execute ("SELECT thing , legs , arms FROM limbs")
while True :
    row = cursor.fetchone()
    if row is None :
        break
    print ("Thing : %s , legs : %s , arms : % s" % (row [0], row[1], row[2]))
print ("Number of rows returned : %d" % cursor.rowcount)
cursor.close ()
