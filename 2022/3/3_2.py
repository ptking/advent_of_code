import os
import sys
import re

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

elf = 1
calories = 0

data = []

def get_char_priority(char):
    print("get_char_priority %s" % char)
    value = ord(char)

    result =re.match("^[a-z]*$", char) 

    if(result):
        value = value - 96
    else:
        value = value - 38
    return value



print(get_char_priority('a'))
print(get_char_priority('b'))
print(get_char_priority('A'))
print(get_char_priority('B'))
print(get_char_priority('C'))
print(get_char_priority('z'))
print(get_char_priority('Z'))


priority_sum = 0

first = None
second = None
third = None

with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()
        print(line)

        # load in the lines until we have 3 to compare
        if(first is None):
            first = line
            continue
        
        if(second is None):
            second = line
            continue
            
        third = line


        print("First %s" % first)
        print("Second %s" % second)
        print("Third %s" % third)
        for char in first:
            if(char in second and char in third):
                priority_sum = priority_sum + get_char_priority(char)
                break

        # clear them to get the next group
        first = None
        second = None
        third = None

print(priority_sum)


