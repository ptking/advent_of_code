import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

depth = 0
horizontal = 0
aim = 0

iter = 0
with open(args.input,'r') as file_in:
    for line in file_in:
        iter = iter + 1
        values = line.split(' ')
        keyword = values[0]
        value = int(values[1])

        print('%s - %s' % (keyword,value))
        print ('aim: %s depth: %s horizontal: %s' %(aim, depth, horizontal))

        if(keyword == 'up'):
            aim = aim - value
        elif(keyword == 'down'):
            aim = aim + value
        elif(keyword == 'forward'):
            depth = (value * aim) + depth
            horizontal = horizontal + value

            
        else:
            print('Error....!')
            print(keyword)
            print(value)
            quit()

        print ('aim: %s depth: %s horizontal: %s' %(aim, depth, horizontal))
        #if(iter > 10):
        #    quit()

print(depth * horizontal)


