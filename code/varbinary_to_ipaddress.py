# for binary(16) and varbinary(16) data type conversion to ip address
import socket
import struct

# In hex values from acid_event
test = '4064FB96' # ossim's ip
test2 = '4064FB0A' #ip ni giodee
test3 = '00000000' # 0.0.0.0
test4 = 'C0A81603' # local ni danica
test5 = 'C0A81604' # local ni danica 

arraylistIP = ['25CC9692', '79362C5A', '79362C5F'] #wildcard mask example = 0.0.0.2, 0.0.0.7
for row in arraylistIP:
	result = int(row[0],16)
	result = socket.inet_ntoa(struct.pack('>I', result))
	print result


#arraylist2 = ['29B2186B172B11E6A8BD000CDA81FA60'] #0.0.0.2
#for row in arraylist2:
#	result = int(row[0])
#	result = socket.inet_ntoa(struct.pack('>I', result))
#	print result


