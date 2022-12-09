import os
import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

trees = []
visible = []

max_x = 0
max_y = 0

with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()

        max_y = max_y + 1
        max_x = len(line)

        row = []
        visible_row = []

        for value in line:
            row.append(int(value))
            visible_row.append(0)

        trees.append(row)
        visible.append(visible_row) 

print("Max X: %s Max Y: %s" % (max_x, max_y))

#print(trees)
#print(visible)

range_x = max_x
range_y = max_y

#  X --------- >
# Y
# |
# |
# |
# V
# trees[y][x]  - Y is the rows, X is the columns.

# scan down from the top to see which trees are visible
def top_visible():
    print("top")
    for x in range(0,range_x, 1):
        highest_tree = 0
        for y in range(0,range_y,1):
            #print(" X %s Y %s" % (x,y))
            
            if(visible[y][x] == 1):
                continue         

            tree = trees[y][x]
            if(tree > highest_tree):
                visible[y][x] = 1
                highest_tree = tree

# scan up from bottom
def bottom_visible():
    print("bottom")
    for x in range(0,range_x,1):
        highest_tree = 0
        for y in range(range_y-1,-1,-1):
            #print(" X %s Y %s" % (x,y))
        
            if(visible[y][x] == 1):
                continue

            

            tree = trees[y][x]
            if(tree > highest_tree):
                visible[y][x] = 1
                highest_tree = tree

# scan right from the left
def left_visible():
    print("left")
    for y in range (0,range_y,1):
        highest_tree = 0
        for x in range (0,range_x, 1):
            #print(" X %s Y %s" % (x,y))

            if(visible[y][x] == 1):
                continue

            

            tree = trees[y][x]
            if(tree > highest_tree):
                visible[y][x] = 1
                highest_tree = tree

# scan left from the right
def right_visible():
    print("right")
    for y in range (0,range_y, 1):
        highest_tree = 0
        for x in range (range_x-1,-1,-1):
            #print(" X %s Y %s" % (x,y))

            tree = trees[y][x]
            if(tree > highest_tree):
                visible[y][x] = 1
                highest_tree = tree



top_visible()
bottom_visible()
left_visible()
right_visible()

#print(visible)

count = 0
for rows in visible:
    for tree in rows:
        if(tree == 1):
            count = count + 1

print(count)




        
        
    
        

