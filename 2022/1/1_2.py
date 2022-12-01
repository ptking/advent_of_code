import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

elf = 1
calories = 0

data = []

with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()
        if(line == ""):
            
            data.append(calories)


            calories = 0           
            elf = elf + 1
            continue

        calories = calories + int(line)


data.sort(reverse=True)

sum = data[0] + data[1] + data[2]

print(data)

print(sum)

    


        