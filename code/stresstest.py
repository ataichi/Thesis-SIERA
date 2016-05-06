#!/usr/bin/python
import MySQLdb
import datetime

# connect to db
db = MySQLdb.connect(host="localhost", user="root", passwd="root", db="siera_final")

# create cursor
cursor = db.cursor()

#get latest attack interval
cursor.execute("SELECT r.timestamp, ap.timestamp, TIMEDIFF(r.timestamp, ap.timestamp) as time from response r, attack_persistence ap WHERE r.persistence_id=ap.persistence_id")
stresstable=cursor.fetchall()

print " responsetimestamp | persistencetimestamp | timediff"

for row1 in stresstable:
	responsetimestamp = row1[0]
	persistencetimestamp = row1[1]
	timediff = row1[2]

	print "%s | %s | %s" % (responsetimestamp, persistencetimestamp, timediff)
