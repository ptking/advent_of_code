import sys


def find_match(sum_find):
# now that they're all in the dictionary
# loop through all the values and figure out the value we're looking for
# x + y = sum_find
# if we have x and value_sum, we can deduce what y should be and see if it exists
    for value in numbers.keys():
        value_looking_for = sum_find - value
        if(value_looking_for < 0):
            continue

        print("%s,%s,%s" %(value,value_looking_for,sum_find))
        
        if(value_looking_for in numbers):
            # found the value, lets multiply and print!
            print(value * value_looking_for)
            return(value*value_looking_for)
    return 0


print("this is the argv array: ")
print(sys.argv)

input_file = sys.argv[1]
value_sum = int(sys.argv[2])

file_handle = open(input_file, 'r') 

numbers = {}

# put all the values in a dictionary first
# this means we can check if a given value exists later on or not
for line in file_handle:
    value = int(line.rstrip('\n'))
    
    numbers[value] = True


for value in numbers.keys():
    value_looking_for = value_sum - value
    if(value_looking_for < 0):
        continue
    print("%s,%s,%s" %(value,value_looking_for,value_sum))
    match_product = find_match(value_looking_for)
    if(match_product is not 0):
        print(match_product * value)
        break



