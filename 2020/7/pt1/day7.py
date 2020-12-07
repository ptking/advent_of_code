import sys
import re
import math

input_file = sys.argv[1]

#binary space partitioning
#128 rows 7 characters
#8 seats in a row 3 characters
# BFFFBBFRRR

file_handle = open(input_file, 'r') 

def parse_outer_bag(phrase):
    match = re.match('^(?P<colour>[\s\w]+) bags',phrase)
    return match.group('colour')

inner_to_outer_rules = {}

for line in file_handle:
    line = line.rstrip("\n")

    parts = line.split(' contain ')
    outer_bag = parts[0]
    inner_bag_string = parts[1]

    outer_colour = parse_outer_bag(outer_bag)

    if(inner_bag_string == 'no other bags.'):
        inner = None
        continue
    
    inner_bags = inner_bag_string.split(',')

    inner_bags_parsed = {}
    for bag in inner_bags:
        match = re.search('(?P<count>\d+)\s(?P<colour>[\w\s]+)\sbag[s]*',bag)
        count = match.group('count')
        colour = match.group('colour')

        inner_bags_parsed[colour] = count

        colours = []
        if(colour in inner_to_outer_rules):
            colours = inner_to_outer_rules[colour]
        
        
        colours.append(outer_colour)

        inner_to_outer_rules[colour] = colours

##### solve part 1 ##########

valid_bags = {}

def recurse_bags(inner_colour):
    if(inner_colour not in inner_to_outer_rules):
        return
    
    outer_colours = inner_to_outer_rules[inner_colour]
    if(inner_colour in valid_bags):
        return
    
    for outer_colour in outer_colours:
        recurse_bags(outer_colour)
        valid_bags[outer_colour] = True

recurse_bags("shiny gold")
print(len(valid_bags))


    
    
