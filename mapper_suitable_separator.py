
# coding: utf-8

# In[1]:


#!/usr/bin/python

import sys

for line in sys.stdin:
    print(line.strip().replace("::",":"))

