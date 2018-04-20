#!/bin/python3

# This python script sets up the build environment, setting things like the operating system
# and artifact prefixes and suffixes.

import os
import re

__default_makefile = """# This file was generated automatically.

#Current operating system.
CURR_OS=

#Suffix for an archive.
ARCH_SUFF=

#Suffix for an object file.
OBJ_SUFF=

#Suffix for an executable.
EXEC_SUFF=

#Removal command.
RM=
export"""

def make_default() :
    fd = os.open("defs.mk", os.O_CREAT | os.O_RDWR)
    fp = os.fdopen(fd, "r+")
    fp.write(__default_makefile)   
    return fp 

def write_makefile(fs) :
    fs.seek(0);
    curr_os = os.name
    matches = 0
    arch_suff = '.a'
    if curr_os == 'nt' :
        obj_suff = '.obj'
        exec_suff = '.exe'
        rm_command = 'del /f'
    else :
        obj_suff = '.o'
        exec_suff = ''
        rm_command = 'rm -rf'
        
    
    #Get the position of the start of the line.
    pos1 = fs.tell()
    x = None
    while x != '' :
        pos1 = fs.tell()
        x = fs.readline()
        if re.match("^CURR_OS=", x) != None :
            #Get the rest of the file so that we can do an insert.
            rest = fs.read()
    
            fs.seek(pos1)
            fs.write("CURR_OS=%s\n"%(curr_os))
            pos2 = fs.tell()
            fs.write(rest)
            fs.seek(pos2)
            matches += 1
        elif re.match("^ARCH_SUFF=", x) != None :
            #Get the rest of the file so that we can do an insert.
            rest = fs.read()
    
            fs.seek(pos1)
            fs.write("ARCH_SUFF=%s\n"%(arch_suff))
            pos2 = fs.tell()
            fs.write(rest)
            fs.seek(pos2)
            matches += 1
        elif re.match("^OBJ_SUFF=", x) != None :
            #Get the rest of the file so that we can do an insert.
            rest = fs.read()
    
            fs.seek(pos1)
            fs.write("OBJ_SUFF=%s\n"%(obj_suff))
            pos2 = fs.tell()
            fs.write(rest)
            fs.seek(pos2)
            matches += 1
        elif re.match("^EXEC_SUFF=", x) != None :
            #Get the rest of the file so that we can do an insert.
            rest = fs.read()
    
            fs.seek(pos1)
            fs.write("EXEC_SUFF=%s\n"%(exec_suff))
            pos2 = fs.tell()
            fs.write(rest)
            fs.seek(pos2)
            matches += 1
        elif re.match("^RM=", x) != None :
            #Get the rest of the file so that we can do an insert.
            rest = fs.read()
    
            fs.seek(pos1)
            fs.write("RM=%s\n"%(rm_command))
            pos2 = fs.tell()
            fs.write(rest)
            fs.seek(pos2)
            matches += 1    
    if matches != 4 :
        fs.close()
        os.remove("defs.mk")
        fs = make_default()
        write_makefile(fs)


def open_file():
    try :
        defs_mk = open("defs.mk", "r+")
    except FileNotFoundError :
        defs_mk = make_default()
    return defs_mk
defs_mk = open_file()
write_makefile(defs_mk)
defs_mk.close()