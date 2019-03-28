
# coding: utf-8

# In[ ]:


#!/usr/bin/python

import sys

genre_dict={}
for line in sys.stdin:
    data=line.strip().split("\t")
    if len(data)!=2:
        continue
    else:
        if data[0] not in genre_dict.keys():
            genre_dict[data[0]]=1
        else:
            genre_dict[data[0]]+=1

for genre,count list(in genre_dict.items()).sort(key=lambda x:x[1],reverse=True):
    print "{x}\t{y}"(x=genre,y=count)

