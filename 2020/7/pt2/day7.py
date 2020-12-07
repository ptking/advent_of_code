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
outer_to_inner_rules = {}

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

        #### this is part 1
        colours = []
        if(colour in inner_to_outer_rules):
            colours = inner_to_outer_rules[colour]
                
        colours.append(outer_colour)

        inner_to_outer_rules[colour] = colours

        #### this is for part 2
        colour_count = {}
        if(outer_colour in outer_to_inner_rules):
            colour_count = outer_to_inner_rules[outer_colour]
        
        colour_count[colour] = int(count)

        outer_to_inner_rules[outer_colour] = colour_count


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

##### solve part 2 #####

def recurse_bags_part2(outer_colour):
    count = 1
    print(outer_colour)
    if(outer_colour not in outer_to_inner_rules):
        print("%s not in rules" % outer_colour)
        return 1
    
    inner_colours = outer_to_inner_rules[outer_colour]

    for colour in inner_colours:
        multiply = inner_colours[colour] 
        deep_count = recurse_bags_part2(colour)
        pre_count = count
        count = count + (multiply * deep_count)
        print("%s ===> %s : %s = %s +  (%s * %s)" %(outer_colour, colour, count, pre_count, multiply, deep_count ))
    return count


#recurse_bags("shiny gold")
#print(len(valid_bags))

print(outer_to_inner_rules)

count = recurse_bags_part2("shiny gold")
print(count -1) #minus one as we included the shiny gold in the calc




    
    
