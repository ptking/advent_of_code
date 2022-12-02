import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

depth = 0
horizontal = 0

with open(args.input,'r') as file_in:
    for line in file_in:
        values = line.split(' ')
        keyword = values[0]
        value = int(values[1])

        if(keyword == 'up'):
            depth = depth - value
        elif(keyword == 'down'):
            depth = depth + value
        elif(keyword == 'forward'):
            horizontal = horizontal + value
        else:
            print('Error....!')
            print(keyword)
            print(value)
            quit()

print(depth * horizontal)


