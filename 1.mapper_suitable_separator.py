


#!/usr/bin/env python

# In our three datasets, movies, ratings, tags, columns are  separated by ::
# In loading data via Pig Storage this may cause some difficulties
# By means of this mapper we replace the delimiter :: by :
# In this MapReduce process we do not need any reducer

import sys

for line in sys.stdin:
    print(line.strip().replace("::",":"))

