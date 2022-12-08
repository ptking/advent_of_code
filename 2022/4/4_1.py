import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

def check_contains(range_1, range_2):
    lower_1 = int(range_1[0])
    lower_2 = int(range_2[0])

    upper_1 = int(range_1[1])
    upper_2 = int(range_2[1])

    first_check = ((lower_1 >= lower_2) and (upper_1 <= upper_2))
    second_check = ((lower_2 >= lower_1) and (upper_2 <= upper_1))

    return (first_check or second_check)


count=0

with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()
        
        pairs = line.split(',')
        
        range_1 = pairs[0].split('-')
        range_2 = pairs[1].split('-')

        print("----")
        print(line)
        print(range_1)
        print(range_2)

        contain = check_contains(range_1, range_2)
        print(contain)
        if(contain):
            count = count + 1

        print(count)
        #quit()

print(count)
