
import sys
import re
import math

input_file = sys.argv[1]

#binary space partitioning
#128 rows 7 characters
#8 seats in a row 3 characters
# BFFFBBFRRR

file_handle = open(input_file, 'r') 


def is_upper(char):
    return (char == "F" or char == "L")

def is_lower(char):
    return (char == "B" or char == "R")


def split(word, start, end):
    #print("word %s start %s end %s" % (word, start, end))
    char = word[0:1]

    if(len(word) == 1):
        if(is_upper(char)):
            return start
        else:
            return end
    
    middle = ((end - start) /2) + start

    new_word = word[1:]

    #print("word %s start %s end %s char %s middle %s new_word %s" %(word, start, end, char, middle, new_word))
    if(is_upper(char)):
        
        return split(new_word,start,math.floor(middle))
    else:
        return split(new_word,math.ceil(middle),end)

seats = {}

highest_seat_id = 0

for line in file_handle:
    boarding_pass = line.rstrip('\n')
    row_data = boarding_pass[0:7]
    seat_data = boarding_pass[-3:]

    #print("%s %s" %(row_data, seat_data))
    row = split(row_data,0,127)
    seat = split(seat_data,0,7)

    seat_id = (row * 8) + seat

    seats[seat_id] = True
    #print("%s %s %s" % (row, seat, seat_id))
    
    if(seat_id > highest_seat_id):
        highest_seat_id = seat_id

print("Highest Seat ID: %s" %highest_seat_id)

for seat in seats:
    my_seat = seat + 1
    next_seat = seat + 2

    if(my_seat not in seats and next_seat in seats ):
        print("My Seat is: %s" % my_seat)





    

