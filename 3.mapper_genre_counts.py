



#!/usr/bin/env python

import sys


#key : genre
#value: 1

for line in sys.stdin:
    for genre in line.strip().split(":")[-1].split("|"):
        print "{x}\t1".format(x=genre)

