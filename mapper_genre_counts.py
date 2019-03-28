
# coding: utf-8

# In[2]:


#!/usr/bin/python

import sys

for line in sys.stdin:
    for genre in line.strip().split(":")[-1].split("|"):
        print "{x}\t1".format(x=genre)

