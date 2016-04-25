#!/usr/bin/python
#import sys
#sys.stderr = open('/dev/null')       # Hides warnings - paramiko
#import paramiko as paramiko
#sys.stderr = sys.__stderr__
#import os
import MySQLdb
import datetime
from datetime import timedelta


# bring back print to return after printftests
def ACLblock (sourceip, destip, timerange):
	print '''ip access-list 101 deny tcp %s 0.0.0.0 %s 0.0.0.0 %s''' % (sourceip, destip, timerange)

def tcplow(startdate, enddate):
	print '''time-range tcplow
			absolute start 00:00 %s end 24:00 %s
				''' % (startdate, enddate)
	
def tcpmedium(startdate, enddate):
	print '''time-range tcpmedium
			absolute start 00:00 %s end 24:00 %s
				''' % (startdate, enddate)

def timerange (attackrate, sourceip, destip, startdate, enddate):
	if attackrate > 1: # high
		timerangestring = ''' ''';
		ACLblock(sourceip, destip, timerangestring)
	elif attackrate < 0.5: # low
		timerangestring = '''time-range tcplow''';
		tcplow(startdate, enddate)
		ACLblock(sourceip, destip, timerangestring)
	else:
		timerangestring = '''time-range tcpmedium''';
		tcpmedium(startdate, enddate)
		ACLblock(sourceip, destip, timerangestring)
	return timerangestring

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

# get number of days set by admin for low and medium attacks in db
cursor.execute("SELECT tbr.num_days from time_based_range tbr WHERE tbr.level = 'Low'")
lowinterval = cursor.fetchall()
cursor.execute("SELECT tbr.num_days from time_based_range tbr WHERE tbr.level = 'Medium'")
mediuminterval = cursor.fetchall()

# get latest attack interval
cursor.execute("SELECT tl.interval_number from time_persistence_interval tl order by tl.timestamp desc limit 1")
numdays=cursor.fetchall()

for row1 in numdays:
	interval = row1[0]

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

# select ALL attacks within timerange
cursor.execute("SELECT al.attack_log_id, al.timestamp, al. source_ip, al.source_port, al.destination_ip, al.destination_port, al.attack_id, al.role_id FROM attack_log al, time_persistence_interval tpi where al.timestamp < date_add(al.timestamp, interval tpi.interval_number day);")

all_attack_log=cursor.fetchall()

for row in all_attack_log:
	i=0

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

		if acl_block_present == 1:
# acl response is here, before insert in response table and time based table to get time delay in stress test
# remove # after this line when testing na 
			if attack_rate < 0.5:
				end_date = now + timedelta(days=num_days_low)
			elif attack_rate < 1 and attack_rate >= 0.5:
				end_date = now + timedelta(days=num_days_medium)
	
			#stdin.write(timerange (attack_rate, source_ip, destination_ip))
			
			print timerange (attack_rate, source_ip, destination_ip, str(now.strftime('%d %B %Y')), str(end_date.strftime('%d %B %Y')))
		

		#print metric_id
		# check there is existing response id
		cursor.execute("select response_id from response where persistence_id="+str(persistence_id))
		response_id=cursor.fetchall()
		
		if len(response_id)==0:
			#print "NEW"
			cursor.execute("insert into response (timestamp, persistence_id, interval_id, attack_rate_id, metric_id, status) values (CURRENT_TIMESTAMP, " + str(persistence_id) + ", " + str(interval_id) + ", " + str(attack_rate_id) + " , " + str(metric_id) + ", '0' )")
			db.commit()
			
			# get current response id
			cursor.execute("select response_id from response where persistence_id="+str(persistence_id))
			response_id=cursor.fetchall()
			for x in response_id:
				x = response_id[0]

			if metric_id==1: # tcp reset + 2 days
				# create TCP Reset
				cursor.execute("insert into tcp_reset (response_id) values (" + str(x[0]) + ")")
				db.commit()

				# create 2 Days ACL
				cursor.execute("insert into time_based (response_id, num_days, block_start, block_end) values (" + str(x[0]) + ", " + str(time_based_range_id_low) + ", NOW(), DATE_ADD(NOW(), INTERVAL " + str(num_days_low) + " DAY) )")
				db.commit()
	
			elif metric_id==2: # tcp reset + 5 days
				# create TCP Reset
				cursor.execute("insert into tcp_reset (response_id) values (" + str(x[0]) + ")")
				db.commit()

				# create 5 Days ACL
				cursor.execute("insert into time_based (response_id, num_days, block_start, block_end) values (" + str(x[0]) + "," + str(time_based_range_id_medium) + ", NOW(), DATE_ADD(NOW(), INTERVAL " + str(num_days_medium) + " DAY) )")
				db.commit()
	
			elif metric_id==7: # 2 days
				# create 2 Days ACL
				cursor.execute("insert into time_based (response_id, num_days, block_start, block_end) values (" + str(x[0]) + ", " + str(time_based_range_id_low) + ", NOW(), DATE_ADD(NOW(), INTERVAL " + str(num_days_low) + " DAY) )")
				db.commit()

			elif metric_id==8: # 5 days
				# create 5 Days ACL
				cursor.execute("insert into time_based (response_id, num_days, block_start, block_end) values (" + str(x[0]) + "," + str(time_based_range_id_medium) + ", NOW(), DATE_ADD(NOW(), INTERVAL " + str(num_days_medium) + " DAY) )")
				db.commit()

			else: # metric_id = 3, 4, 5, 6, 9, 10, 11, 12 (ACL Block)
				cursor.execute("insert into permanent_block (response_id, is_block, last_modified) values (" + str(x[0]) + ", 1, CURRENT_TIMESTAMP)")
				db.commit()

