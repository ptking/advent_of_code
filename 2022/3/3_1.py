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

with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()
        print(line)
        length = len(line)
        print(length)
        
        halfway = int((length) / 2)
        print(halfway)
        first = line[0:halfway]
        second = line[halfway:length]

        print(first)
        print(second)

        if(len(first) != len(second)):
            print("first and second length's are not the same")
            quit()

        for char in second:
            if char in first:
                priority_sum = priority_sum + get_char_priority(char)
                break
        

print(priority_sum)


