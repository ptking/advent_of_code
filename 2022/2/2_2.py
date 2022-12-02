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

# X = Lose
# Y = Draw
# Z = Win

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
}

result_map = {
    'X' : 'L',
    'Y' : 'D',
    'Z' : 'W'
}

combo_result_map = {
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

combo_result_move_map = {
    'RW' : 'P',
    'RD' : 'R',
    'RL' : 'S',
    'PW' : 'S',
    'PD' : 'P',
    'PL' : 'R',
    'SW' : 'R',
    'SD' : 'S',
    'SL' : 'P'
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
        right_result = result_map[values[1]]

        print(values)

        combo_result_move = '%s%s'% (left_move,right_result)

        print(combo_result_move)

        right_move = combo_result_move_map[combo_result_move]

        combo_move = '%s%s' % (left_move,right_move)

        print(combo_move)

        result = combo_result_map[combo_move]

        print(result)

        move_score = move_score_map[right_move]

        print(move_score)

        score = result + move_score

        total_score = total_score + score

        print("%s %s %s %s" %(combo_move, result, move_score, score))

print(total_score)

