import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

chars = []

def check_unique():
    unique = True
    for i in range(0,len(chars),1):
        for j in range(0, len(chars),1):
            if(i==j):
                continue
            
            if(chars[i] == chars[j]):
                unique = False
    return unique

        

count = 0

unique_count = 0
with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()

        for char in line:
            count = count + 1

            if(len(chars) == 14):
                chars.pop(0)
            
            chars.append(char)
            
            if(len(chars) < 14):
                continue

            if(check_unique()):
                break

print(chars)
print(count)




