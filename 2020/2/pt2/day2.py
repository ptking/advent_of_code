import sys
import re

input_file = sys.argv[1]

file_handle = open(input_file, 'r') 

passwords = []

valid = 0

for line in file_handle:

    line = line.rstrip('\n')
    #print(line)
    
    match = re.search('(?P<range_start>\d+)\-(?P<range_end>\d+)\s(?P<letter>\w)\:\s(?P<password>\w+)', line)

    #minus one to put into 0 base
    first = int(match.group('range_start')) -1
    second = int(match.group('range_end')) -1
    letter = match.group('letter')
    password = match.group('password')

    print("%s %s %s %s" % (first, second, letter, password))


    if(password[first] is letter and password[second] is not letter) or (password[first] is not letter and password[second] is letter):
        valid += 1
    
print(valid)

    



