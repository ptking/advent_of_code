import os
import sys
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

count = 0

# A = Rock
# B = Paper
# C = Scissors

# X = Rock
# Y = Paper
# Z = Scissors

# 0 = Lose
# 3 = Draw
# 6 = Win

LOSE = 0
DRAW = 3
WIN = 6

move_map = {
    'A' : 'R',
    'B' : 'P',
    'C' : 'S',
    'X' : 'R',
    'Y' : 'P',
    'Z' : 'S'
}

result_map = {
    'RR' : DRAW,
    'RP' : WIN,
    'RS' : LOSE,
    'PR' : LOSE,
    'PP' : DRAW,
    'PS' : WIN,
    'SR' : WIN,
    'SP' : LOSE,
    'SS' : DRAW
}

move_score_map = {
    'R' : 1,
    'P' : 2,
    'S' : 3
}

total_score = 0

with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()

        values = line.split(' ')

        left_move = move_map[values[0]]
        right_move = move_map[values[1]]

        combo_move = '%s%s'% (left_move,right_move)

        result = result_map[combo_move]

        move_score = move_score_map[right_move]

        score = result + move_score

        total_score = total_score + score

        print("%s %s %s %s" %(combo_move, result, move_score, score))

print(total_score)

