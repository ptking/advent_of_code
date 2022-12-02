import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

count = 0
previous_line = ''

zero = []
one = []

with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.strip()
        values = list(line)
        index = 0
        for value in values:
            value = int(value)

            if(len(zero) <= index):
                zero.append(0)

            if(len(one) <= index):
                one.append(0)

        
            zero_count = zero[index]
            one_count = one[index]
            
            if(value == 0):
                zero_count = zero_count + 1
            
            if(value == 1):
                one_count = one_count + 1
            
            zero[index] = zero_count
            one[index] = one_count

            index = index + 1

        print(zero)
        print(one)

index = 0
result = []
inverse_result = []

while (index < len(zero)):
    zero_value = zero[index]
    one_value = one[index]

    most_common_value = '1'
    least_common_value = '0'
    if(zero_value > one_value):
        most_common_value = '0'
        least_common_value = '1'

    result.append(most_common_value)
    inverse_result.append(least_common_value)

    index = index + 1

print(result)

gamma_rate_str = ''.join(result)
epsilon_rate_str = ''.join(inverse_result)

gamma_rate = int(gamma_rate_str,2)
epsilon_rate = int(epsilon_rate_str,2)

print(gamma_rate)
print(epsilon_rate)

print(gamma_rate * epsilon_rate)

