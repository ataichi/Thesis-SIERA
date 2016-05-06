#!/usr/bin/python
import base64
#import Tkinter
import sys
#sys.stderr = open('/dev/null')       # Hides warnings - paramiko
#import paramiko as paramiko
#sys.stderr = sys.__stderr__
import os
import MySQLdb

import datetime
from datetime import timedelta, time

#filename = '/home/siera/Desktop/pexpect.py'
def file_get_contents(filename):
    with open(filename) as f:
        return f.read()

# for GUI
#top = Tkinter.Tk()
#B = Tkinter.Button(top, text ="Unblock")
#B.pack()
#top.mainloop()

# call this function for the unblock page
def unblock(ACLentry):
	stdin.write('''ip access-list extended out_to_in 
no %s''' % ACLentry)

# ingress filtering
def defaultACL():
	stdin.write('''int f0/0
ip access-group out_to_in in''')

# no need. current acl will be the only one put to the interface.
#def noACL():
#	print '''int f0/0
#		no ip access-group out_to_in in'''

#if may name kaya iremove per line.. if numbered acl mabubura whole acl
def tempACL():
	print '''ip access-list extended tempout_to_in in 
permit tcp any host 209.165.164.163
'''

def insertTempACL():
	print '''int f0/0
ip access-group tempout_to_in in'''

# bring back print to return after printftests
def ACLblock (sourceip, destip, timerange):
	return '''ip access-list extended out_to_in 
deny tcp %s 0.0.0.0 %s 0.0.0.0 %s''' % (sourceip, destip, timerange)

def tcplow(startdate, enddate):
	return '''time-range tcplow
absolute start 00:00:00 %s end 24:00:00 %s
''' % (startdate, enddate)
	
def tcpmedium(startdate, enddate):
	return '''time-range tcpmedium
absolute start 00:00:00 %s end 24:00:00 %s
''' % (startdate, enddate)

# flexible to convert to create time range per new time
def timerange (attack_rate_id, sourceip, destip, startdate):
	if attack_rate_id == 3: # high
		timerangestring = ''' ''';
	elif attack_rate_id == 1: # low
		#end_date = now + timedelta(days=num_days_low)
		timerangestring = '''time-range tcplow''';
		#tcplow(startdate, str(end_date.strftime('%d %B %Y')))
	else: # medium
		#end_date = now + timedelta(days=num_days_medium)
		timerangestring = '''time-range tcpmedium''';
		#tcpmedium(startdate, str(end_date.strftime('%d %B %Y')))
	timerangestring = ACLblock(sourceip, destip, timerangestring)
	print timerangestring

#class AllowAllKeys(paramiko.MissingHostKeyPolicy):
#    def missing_host_key(self, client, hostname, key):
#        return

IPADDRESS = '64.100.251.254' #ipaddress of local router gateway
USERNAME = 'adminssh'
PASSWORD = 's$hi'

#delete content of ~/.ssh/known_hosts if exist - prevents connection if there's an entry, recognized as different connection
#ssh = paramiko.SSHClient()
#ssh.load_system_host_keys()
#ssh.load_host_keys(os.path.expanduser('~/.ssh/known_hosts'))
#ssh.set_missing_host_key_policy(AllowAllKeys())
#ssh.connect(IPADDRESS, username=USERNAME, password=PASSWORD)

# need if there are two or more commands to execute
# exec_command() for one line command only
#channel = ssh.invoke_shell()
#stdin = channel.makefile('wb')
#stdout = channel.makefile('rb')

#stdin.write('''
#terminal length 0
#enable
#class
#conf t
#''')


# current date getter
now = datetime.datetime.now()
# connect to db
db = MySQLdb.connect(host="localhost", user="root", passwd="root", db="siera_final")

# create cursor
cursor = db.cursor()

# is this not used? comment out ko muna
# get latest attack interval
#cursor.execute("SELECT tl.interval_number from time_persistence_interval tl order by tl.timestamp desc limit 1")
#numdays=cursor.fetchall()
#for row1 in numdays:
#	interval = row1[0]


# get num_days low attack
cursor.execute("select * from time_based_range where level='Low'")
low_num_all = cursor.fetchall()

for row in low_num_all:
	time_based_range_id_low = row[0]
	level_low = row[1]
	num_days_low = row[2]

# get num_days medium
cursor.execute("select * from time_based_range where level='Medium'")
medium_num_all = cursor.fetchall()

for row in medium_num_all:
	time_based_range_id_medium = row[0]
	level_medium = row[1]
	num_days_medium = row[2]

# timeranges for the day
startdate = str(now.strftime('%d %m %Y'))
end_date = now + timedelta(days=num_days_low)
#stdin.write(tcplow(startdate, end_date.strftime('%d %B %Y')))
print tcplow(startdate, end_date.strftime('%d %B %Y'))
end_date = now + timedelta(days=num_days_medium)
#stdin.write(tcpmedium(startdate, end_date.strftime('%d %B %Y')))
print tcpmedium(startdate, end_date.strftime('%d %B %Y'))

while (1):
	db = MySQLdb.connect(host="localhost", user="root", passwd="root", db="siera_final")
	cursor = db.cursor()

	try:
		cursor.execute("select response_id from response order by response_id desc limit 1")
		pivot = cursor.fetchone()
		pivot = pivot[0]
		cursor.execute("SELECT al.attack_log_id, al.timestamp, al. source_ip, al.source_port, al.destination_ip, al.destination_port, al.attack_id, al.role_id FROM attack_log al, time_persistence_interval tpi where al.timestamp < date_add(al.timestamp, interval tpi.interval_number day) and al.attack_log_id > "+ str(pivot) + ";")
	except:
		e = sys.exc_info()[0]
	# select ALL attacks within timerange
		cursor.execute("SELECT al.attack_log_id, al.timestamp, al. source_ip, al.source_port, al.destination_ip, al.destination_port, al.attack_id, al.role_id FROM attack_log al, time_persistence_interval tpi where al.timestamp < date_add(al.timestamp, interval tpi.interval_number day);")

	all_attack_log=cursor.fetchall()

	for row in all_attack_log:
		attack_log_id=row[0]
		timestamp=row[1]
		source_ip=row[2]
		source_port=row[3]
		destination_ip=row[4]
		destination_port=row[5]
		attack_id=row[6]
		role_id=row[7]
			 
		#print source_ip
		cursor.execute("set @date = (select timestamp from attack_log where attack_log_id="+str(attack_log_id)+ "); ")
		cursor.execute("select count(al.attack_id) from attack_log al, time_persistence_interval tpi where al.timestamp between date_sub(@date, interval tpi.interval_number day) and @date " + "and al.source_ip='"+ str(source_ip) + "' and al.attack_log_id<"+str(attack_log_id) +" and al.attack_id=" +str(attack_id))
		persistence_list=cursor.fetchall()

		# insert into attack_persistence
		for row in persistence_list:
			value = row[0]+1
			# double check if may entry na
			cursor.execute("select * from attack_persistence where attack_log_id=" + str(attack_log_id) )
			check_entry = cursor.fetchall()
		
			if len(check_entry)==0:
				a = "insert into attack_persistence (attack_log_id, persistence_count) values (" + str(attack_log_id) + ", " + str(value) + ")"
				cursor.execute(a)
				#print a 
				db.commit()

			# compute for attack_rate
			cursor.execute("select * from time_persistence_interval order by interval_id desc limit 1")
			interval_record = cursor.fetchone()
			interval_id = interval_record[0]
			timestamp = interval_record[1]
			interval = interval_record[2]

			# attack rate value
			attack_rate = float(value)/float(interval)

			#print attack_rate
			# persistence_id
			cursor.execute("select persistence_id from attack_persistence where attack_log_id=" + str(attack_log_id) )
			persistence_id = cursor.fetchone()
			persistence_id=persistence_id[0]

			# attack_rate_id
			cursor.execute("select attack_rate_id from attack_rate where value_from <=" + str(attack_rate) + " and value_to >=" + str(attack_rate) )
			attack_rate_id = cursor.fetchone()
			attack_rate_id = attack_rate_id[0]
			
			# print str(attack_rate_id)
			# get protocol_type
			cursor.execute("select protocol_type from attack where attack_id=" + str(attack_id) )
			protocol_type = cursor.fetchone()
			protocol_type = protocol_type[0]

			response = 0
			metric_id=0

			cursor.execute("select metric_id from metric_conjunction where role_id='"+str(role_id)+"' and attack_rate_id='"+str(attack_rate_id)+"' and protocol_type='"+str(protocol_type)+"'")
			metric_id = cursor.fetchone()
			metric_id = metric_id[0]

	# check if acl block required
			cursor.execute("select acl_block from metric_conjunction WHERE role_id='"+str(role_id)+"' and attack_rate_id='"+str(attack_rate_id)+"' and protocol_type='"+str(protocol_type)+"'")
			acl_block_present = cursor.fetchone()
			acl_block_present = acl_block_present[0]

	#check time if have to renew timeranges in every attack responded and create new timeranges if necessary
			startdate = str(now.strftime('%d %m %Y'))
			now_time = now.time()
			if now_time >= time(23,59): 
				end_date = now + timedelta(days=num_days_low)
				#stdin.write(tcplow(startdate, end_date.strftime('%d %B %Y')))
				print tcplow(startdate, end_date.strftime('%d %B %Y'))
				end_date = now + timedelta(days=num_days_medium)
				#stdin.write(tcpmedium(startdate, end_date.strftime('%d %B %Y')))
				print tcpmedium(startdate, end_date.strftime('%d %B %Y'))

			if acl_block_present == 1:
# remove # after this line when testing na 
				#stdin.write(timerange (attack_rate_id, source_ip, destination_ip, str(now.strftime('%d %m %Y'))))
				timerange (attack_rate_id, source_ip, destination_ip, str(now.strftime('%d %m %Y')))
		

			#print metric_id
			# check there is existing response id
			cursor.execute("select response_id from response where persistence_id="+str(persistence_id))
			response_id=cursor.fetchall()
		

	#what is the checking of length of response id for?
			if len(response_id)==0:
				#print "NEW"
				cursor.execute("insert into response (timestamp, persistence_id, interval_id, attack_rate_id, metric_id, status) values (CURRENT_TIMESTAMP, " + str(persistence_id) + ", " + str(interval_id) + ", " + str(attack_rate_id) + " , " + str(metric_id) + ", '0' )")
				db.commit()
			
				# get current response id
				cursor.execute("select response_id from response where persistence_id="+str(persistence_id))
				response_id=cursor.fetchall()
				for x in response_id:
					x = response_id[0]

				if metric_id == 1 or metric_id == 2: # tcp reset + 2 days
					# create TCP Reset
					cursor.execute("insert into tcp_reset (response_id) values (" + str(x[0]) + ")")
					db.commit()

				if metric_id == 1 or metric_id == 7:
					# create 2 Days ACL
					cursor.execute("insert into time_based (response_id, num_days, block_start, block_end) values (" + str(x[0]) + ", " + str(time_based_range_id_low) + ", NOW(), DATE_ADD(NOW(), INTERVAL " + str(num_days_low) + " DAY) )")
					db.commit()
				elif metric_id == 2 or metric_id == 8: # 5 days
					# create 5 Days ACL
					cursor.execute("insert into time_based (response_id, num_days, block_start, block_end) values (" + str(x[0]) + "," + str(time_based_range_id_medium) + ", NOW(), DATE_ADD(NOW(), INTERVAL " + str(num_days_medium) + " DAY) )")
					db.commit()

				else: # metric_id = 3, 4, 5, 6, 9, 10, 11, 12 (ACL Block)
					cursor.execute("insert into permanent_block (response_id, is_block, last_modified) values (" + str(x[0]) + ", 1, CURRENT_TIMESTAMP)")
					db.commit()
				
				
