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

    range_start = int(match.group('range_start'))
    range_end = int(match.group('range_end'))
    letter = match.group('letter')
    password = match.group('password')

    #print("%s %s %s %s" % (range_start, range_end, letter, password))

    char_counts = {}
    for char in password:
        count = 0
        if(char in char_counts):
            count = char_counts[char]
        char_counts[char] = count + 1
    
    #print(char_counts)

    for char in char_counts:
        if(char is not letter):
            continue

        count = char_counts[char]
        if(count >= range_start and count <= range_end):
            valid += 1
    
print("Valid passwords; %s" % valid)







