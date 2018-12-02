import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

frequency = 0
with open(args.input,'r') as file_in:
    for line in file_in:
        sign = line[:1]
        length = len(line)

        increment = int(line[1:])

        if(sign == '-'):
            frequency = frequency - increment
        else:
            frequency = frequency + increment

print(frequency)

