#!/usr/bin/env python

import sys

@outputSchema('variance:double')

# fuction returns standard deviation and this should be double, float type may lead to some problems 

def finding_variance(x):

# x is a bag of pig, i.e., list of tuples, in our case all  tuples have one components

    sum=0
    num=0
    for tuple_ in x:
        num=num+1
        sum=sum+tuple_[0]
    if num==1:
        return 0.0
    else:
        
        avg= sum/num
        sum=0
    
        for tuple_ in x:
            sum=sum+(tuple_[0]-avg)**2
        return (sum/(num-1))**0.5    	
