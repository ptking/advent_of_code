import sys
import re

input_file = sys.argv[1]


instructions = []

file_handle = open(input_file, 'r')

for line in file_handle:
    line = line.rstrip('\n')

    match = re.match('(?P<inst>\w+)\s(?P<sign>[+-])(?P<count>\d+)',line)
    inst = match.group('inst')
    sign = match.group('sign')
    count = int(match.group('count'))

    if(sign == "-"):
        count = 0 - count
    
    command = (inst, count)

    instructions.append(command)


fix_commands = []
i = 0
for command in instructions:
    if(command[0] == 'jmp'):
        fix_commands.append(i)
    if(command[0] == 'nop'):
        fix_commands.append(i)
    i = i + 1

def try_code(instructions):
    indexes = {}
    index = 0
    accumulator = 0

    command = instructions[index]

    while(True):   
        # instruction seen before
        if(index in indexes):
            return 0


        indexes[index] = True

        inst = command[0]
        value = command[1]

        if(inst == "nop"):
            index = index + 1
                
        # jump to the new instruction relative to itself
        if(inst == "jmp"):
            index = index + value

        if(inst == "acc"):
            index = index + 1
            accumulator = accumulator + value

        if(index >= len(instructions)):
            #something went wrong, no loop?
            print("got to the end")
            return accumulator

        command = instructions[index]


## part 2 - brute force it...
for fix_index in fix_commands:
    isnt_copy = list(instructions)
    command = isnt_copy[fix_index]

    if(command[0] == 'nop'):
        command = ('jmp',command[1])
    else:
        command = ('nop',command[1])

    isnt_copy[fix_index] = command

    
    acc = try_code(isnt_copy)

    if(acc != 0):
        print(acc)
        break

    