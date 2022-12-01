import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

calories = 0
most_calories = 0


with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()
        if(line == ""):
            if(calories > most_calories):
                most_calories = calories
            calories = 0

            continue

        calories = calories + int(line)

print(most_calories)


        