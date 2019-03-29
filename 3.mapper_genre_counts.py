



#!/usr/bin/env python

import sys

# want to count the number of occurrences of each genre

for line in sys.stdin:
    for genre in line.strip().split(":")[-1].split("|"):
        print "{x}\t1".format(x=genre)

