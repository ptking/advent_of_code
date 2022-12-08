import os
import sys
import re
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()


stacks = []


def add_to_stack(stack_index, char):

    if(char == ' '):
        return

    if(re.match("^[0-9]+$", char)):
        return

    stack = []
    print(len(stacks))
    if(len(stacks) > stack_index):
        stack = stacks[stack_index]
    else:
        for i in range(len(stacks)-1,stack_index,1):
            stack = []
            stacks.append(stack)


    stack.append(char)
    stacks[stack_index] = stack
    

def parse_stack_line(line):
    length = len(line)
    char_count = 0
    stack_index = 0

    print(stacks)

    for char in line:
        char_count = char_count + 1

        print( "char count: %s" % char_count)
        print("char: %s" % char)
        print("stack index %s" % stack_index)
        print(stacks)


        if(char_count == 2):
            add_to_stack(stack_index,char)
            stack_index = stack_index + 1
            continue

        if((char_count - 2) % 4 == 0 ):
            print(char)
            add_to_stack(stack_index, char)
            stack_index = stack_index + 1
            continue

stack_structure = True

def parse_move_line(line):
    result = re.search("move (\d+) from (\d+) to (\d+)", line)
    move_amount = int(result.group(1))
    from_stack = int(result.group(2)) -1 # -1 to move to index 0
    to_stack = int(result.group(3)) -1 # -1 to move to index 0

    temp_stack = []

    print("Move amount: %s from %s to %s" % (move_amount, from_stack, to_stack))
    
    #print(stacks[from_stack])
    #print(stacks[to_stack])

    temp_stack = []
    for i in range(0,move_amount,1):
        temp_stack.insert(0,stacks[from_stack].pop(0))

    #print(temp_stack)

    for crate in temp_stack:
        stacks[to_stack].insert(0,crate)

    #print(stacks[from_stack])
    #print(stacks[to_stack])
   

with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()

        # fill data structure    
        if(line == ''):
            stack_structure = False
            continue

        if(stack_structure):
            parse_stack_line(line)
            continue

        parse_move_line(line)

top_stack = ''
for stack in stacks:
    
    top_stack = top_stack + stack[0]

print(top_stack)
