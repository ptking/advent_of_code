# 1,1 = 67
# 3,1 = 211
# 5,1 = 77
# 7,1 = 89
# 1,2 = 37

result = 67 * 211 * 77 * 89 * 37
print(result)

import sys
import re

input_file = sys.argv[1]
x_alter = int(sys.argv[2])
y_alter = int(sys.argv[3])

file_handle = open(input_file, 'r') 

slope = []
max_x = 0
max_y = 0

i = 0
j = 0
for line in file_handle:
    line = line.rstrip('\n')
    for char in line:
        if(j == 0):
            sub_slope = []
            sub_slope.append(char)
            slope.append(sub_slope)
        else:
            sub_slope = slope[i]
            sub_slope.append(char)
            slope[i] = sub_slope

        j += 1

    i += 1
    max_x = j
    j = 0

max_y = i

def sled(x,y,x_alter,y_alter):
    # right 3, down 1
    x = x + x_alter
    y = y + y_alter

    return (x,y)

# starting co-ordinates
x=0
y=0

trees = 0

while(y < max_y):

    new_coords = sled(x,y,x_alter,y_alter)
    x = new_coords[0]
    y = new_coords[1]

    if(y >= max_y):
        # we made it to the end of the slope so don't go any further
        break

    # make sure we don't overflow the array, loop back around to the start as per the question
    x = x % (max_x)
    
    if(slope[y][x] == "#"):
        # We've found a tree
        trees += 1

print("Trees found: %s" % trees)
