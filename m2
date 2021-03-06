#!/usr/bin/python

# Peter Jablonski
# Sesilly Cruz

import sys

if len(sys.argv) != 2:
	exit(1)

f = open(sys.argv[1], 'r')

n = int(f.readline())
men = {}
women = {}
engagedMen = {}
engagedWomen = {}
unengaged = []

count = 0

# Initialization: f is a file containing individuals with their preferences, with the cursor located at the head of the file.
# Maintenance: Each iteration, our cursor proceeds to the next line
# Termination: <EOF> has been reached
for line in f:
    names = line.rstrip().split(' ')
    if count < n:
        men[names[0]] = names[1:n+1]
        engagedMen[names[0]] = None
        unengaged.append(names[0])
    else:
        women[names[0]] = names[1:n+1]
        engagedWomen[names[0]] = None
    count = count + 1

# Initialization: As no men are initially engaged, every man in engagedMen maps to None
# Maintenance: Men gradually become engaged, with some gaining engagements while others lose their status
# Termination: When every man is engaged simultaneously, a stable matching has been achieved
while unengaged:
# Initialization: The dictionary men contains mappings of every man to his list of preferences
# Maintenance: Perform operations on every man in men
# Termination: Every man in men has been operated upon
    unengagedTemp = []
    for man in unengaged:
# Initialization: The man has some engagement status
# Maintenance: The man proposes to a woman and may or may not become engaged
# Termination: The man is engaged
        while engagedMen[man] == None:
            woman = men[man].pop(0)
            if engagedWomen[woman] == None:
                engagedWomen[woman] = man
                engagedMen[man] = woman
            elif women[woman].index(man) < women[woman].index(engagedWomen[woman]):
                engagedMen[engagedWomen[woman]] = None
                unengagedTemp.append(engagedWomen[woman])
                engagedWomen[woman] = man
                engagedMen[man] = woman
    unengaged = unengagedTemp
    unengagedTemp = []


# Initialization: The dictionary engagedMen contains mappings of every man to his fiance in a stable matching
# Maintenance: Each man and his fiance are printed.
# Termination: Every man and his fiance have been printed, and none remain unprinted.
for man in engagedMen:
    print(man + " " + engagedMen[man])
