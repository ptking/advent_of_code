import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

count = 0
previous_line = ''
with open(args.input,'r') as file_in:
    for line in file_in:
        print('previous line: %s' % previous_line)
        print('line: %s' % line)
        
        if(previous_line == ''):
            previous_line = line
            continue
        
        

        if(int(previous_line) < int(line)):
            count = count + 1

        previous_line = line

print(count)
