import sys
import re


def byr_check(value):
    return (int(value) <= 2002 and int(value) >= 1920)

def iyr_check(value):
    return (int(value) <= 2020 and int(value) >= 2010)

def eyr_check(value):
    return(int(value) <= 2030 and int(value) >= 2010)

def hgt_check(value):
    match = re.search('(?P<amount>\d+)(?P<scale>cm|in)', value)
    if(match is None):
        return False
    
    amount = int(match.group('amount'))
    scale = match.group('scale')

    if(scale == "cm"):
        return (amount >= 150 and amount <= 193)
    return(amount >= 59 and amount <= 76)

def hcl_check(value):
    match = re.match('^#[0-9a-f]{6}$',value)
    if(match is None):
        return False
    return True

def ecl_check(value):
    match = re.search('^(amb|blu|brn|gry|grn|hzl|oth)$',value)

    if(match is None):
        return False
    return True

def pid_check(value):
    match = re.search('^\d{9}$',value)
    if(match is None):
        return False
    return True   

required_fields = {
    'byr' : byr_check,
    'iyr': iyr_check,
    'eyr': eyr_check,
    'hgt': hgt_check,
    'hcl': hcl_check,
    'ecl': ecl_check,
    'pid': pid_check
    }
    
def check_passport(_passport):
    
    valid = True
    for req in required_fields:
        if(req not in _passport):
            valid = False
            continue
        # use function pointer to check all the different required fields
        check = required_fields[req](_passport[req])
        if(not check):
            valid = False
    return valid

#########################################################

input_file = sys.argv[1]

file_handle = open(input_file, 'r') 

optional_fields = ['cid']

passport = {}
valid_count = 0

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