import sys
import re

input_file = sys.argv[1]

file_handle = open(input_file, 'r') 

required_fields = ['byr','iyr','eyr','hgt','hcl','ecl','pid']
optional_fields = ['cid']

passport = {}
valid_count = 0
valid = True

def check_passport(_passport):
    valid = True
    for req in required_fields:
        if(req not in _passport):
            valid = False
    return valid

for line in file_handle:
    line = line.rstrip('\n')

    match = re.search('^$', line)
    if(match):
        print(passport)

        valid = check_passport(passport)
        
        if(valid):
            valid_count += 1
        
        passport = {}
        fields = {}
        continue
    
    fields = line.split(" ")
    for field in fields:
        values = field.split(":")
        passport[values[0]] = values[1]
    

# final check for end of file passport
print(passport)
valid = check_passport(passport)

if(valid):
    valid_count += 1


print(valid_count)