import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

count = 0
previous = []

previous_sum = ''

with open(args.input,'r') as file_in:
    for line in file_in:

        print('line: %s' % line)
        
        

        if(len(previous) < 3):
            previous.append(int(line))

        if(len(previous) < 3):
            continue

        print(previous)

        sum = previous[0] + previous[1] + previous[2]
        
        if(previous_sum == ''):
            previous_sum = sum
            previous.pop(0)
            continue

        if(previous_sum < sum):
            count = count + 1
                
        removed = previous.pop(0)
        previous_sum = sum

print(count)
