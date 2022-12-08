import os
import sys
import re

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--input')

args = parser.parse_args()

class Directory:
    def __init__(self, name, prev_dir, cwd):
        self.name = name
        self.sub_dirs = []
        self.files = {}
        self.prev_dir = prev_dir
        self.cwd = cwd

        self.size = 0
        self.size_calculated = False

        #self.print_dir()

    def add_file(self, name, size):
        self.files[name] = size

        self.print_dir()
    
    def add_directory(self,directory):
        self.sub_dirs.append(directory)

    def print_dir(self):
        print("Dir Name: %s" % self.name)
        print(self.cwd)
        print("Directories:")
        for dir in self.sub_dirs:
            print(dir.get_name())

        print("Files:")
        print(self.files)
    
    def get_name(self):
        return self.name
        
    def walk(self):
        self.print_dir()

        for dir in self.sub_dirs:
            dir.walk()
   
    def calc_dir_size(self):

        size = 0
        for file in self.files:
            #print(self.files)
            size = size + self.files[file]

        for dir in self.sub_dirs:
            size = size + dir.calc_dir_size()
        
        self.size = size
        self.size_calculated = True

        #print("Dir: %s Size: %s" %(self.name, self.size))

        return self.size


    def get_prev_dir(self):
        return self.prev_dir

    def dir_size_is_less_than(self, size, sizes):
        if(self.size <= size ):
            sizes.append(self.size)

        for dir in self.sub_dirs:
            dir.dir_size_is_less_than(size, sizes)



cwd = []
top_dir = None
current_dir = None
prev_dir = None

with open(args.input,'r') as file_in:
    for line in file_in:
        line = line.rstrip()

        #print(line)
        #print(cwd)

        cd_dot_dot = re.search("^\$ cd \.\.$", line)

        if(cd_dot_dot):
           #print("cd_dot_dot")
            cwd.pop(len(cwd) -1)

            current_dir = current_dir.get_prev_dir()

            prev_dir = current_dir.get_prev_dir()
            continue
        
        cd_command = re.search("\$ cd ([\w\/]+)", line)
        if(cd_command):
            #print("cd command")
            dir = cd_command.group(1)
            cwd.append(dir)

            prev_dir = current_dir
            
            current_dir = Directory(dir, prev_dir, "/".join(cwd))

            if(prev_dir is not None):
                prev_dir.add_directory(current_dir)

            if(top_dir is None):
                top_dir = current_dir
            
            continue

        ls_command = re.search("\$ ls", line)
        if(ls_command):
            continue
        dir_listing = re.search("^dir (\w+)",line)
        if(dir_listing):
            continue

        file_listing = re.search("^(.+)\s(.*)$",line)
        #print(file_listing)

        if(file_listing):
            #print("file_listing")
            file_size = int(file_listing.group(1))
            file_name = file_listing.group(2)

            print("Name: %s Size: %s" % (file_name, file_size))
            current_dir.add_file(file_name, file_size)
            continue

        print("Shouldn't get here...")
        quit()

print("-----")

#top_dir.walk()

top_dir.calc_dir_size()

print(top_dir.size)

global sizes
sizes = []

top_dir.dir_size_is_less_than(100000,sizes)

total_sum = 0
for size in sizes:
    total_sum = total_sum + size

print(total_sum)




        
    

