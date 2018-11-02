import mysql.connector
from mysql.connector import errorcode

try:
    conn = mysql.connector.connect(user = 'user_name', password = 'password',
    host = 'host',
    database = 'db_name', port = 'port')
    print ("Connected")
    cursor = conn.cursor()
    cursor.execute ("SELECT * FROM limbs")
    rows = cursor.fetchall()
    print ('Total Row (s): ', cursor.rowcount)
    for row in rows:
        print (row)

    cursor.execute (" SELECT thing , legs , arms FROM limbs " )
    while True :
        row = cursor.fetchone()
        if row is None :
            break
        print ("Thing : %s , legs : %s , arms : % s" % (row [0], row[1], row[2]))
    print ("Number of rows returned : %d" % cursor.rowcount)

    cursor.execute (" SELECT thing , legs , arms FROM limbs " )
    for (thing, legs, arms) in cursor :
        print (" Thing : %s , legs : %s , arms : % s" % ( thing , legs , arms ))
    print (" Number of rows returned : %d" % cursor.rowcount)

    cursor.execute (" SELECT thing , legs , arms FROM limbs " )
    rows = cursor.fetchall()
    for row in rows:
        print (" Thing : %s , legs : %s , arms : % s" % ( row [0] , row [1] , row [2]))
    print (" Number of rows returned : %d" % cursor . rowcount )

    cursor.execute("SELECT thing , legs , arms FROM limbs WHERE arms = %s and legs = %s", [2,1])
    for ( thing , legs , arms ) in cursor :
        print (" thing : %s , leg : %s , arms : %s " % ( thing , legs , arms ))

    cursor.execute ("SELECT thing , arms , legs FROM limbs")
    for row in cursor:
        row = list(row) # convert nonmutable tuple to mutable list
        for i , value in enumerate(row):
            if value is None : # is the column value NULL ?
                row [i] = "NULL"
        print (" Thing : %s , arms : %s , legs : % s" % (row[0], row[1], row[2]))

except mysql.connector.Error as e:
    print (e)
finally:
    cursor.close ()
    conn.close ()
