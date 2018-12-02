import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

frequency = 0

check = {}

lines = []
with open(args.input,'r') as file_in:
    lines = file_in.readlines()

found = False
while(not found):
    for line in lines:
        sign = line[:1]
        length = len(line)

        increment = int(line[1:])

        if(sign == '-'):
            frequency = frequency - increment
        else:
            frequency = frequency + increment

        print(frequency)

        if frequency in check:
            found = True
            break

        check[frequency] = 1


print('Found: ' + str(frequency))

