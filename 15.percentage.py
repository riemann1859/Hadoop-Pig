#!/usr/bin/env python                                                                                                                                                   
                                                                                                                                                                        
# Pig UDF returns a bag of 3-element tuples                                                                                                                             
                                                                                                                                                                        
@outputSchema('result:{t:(genre:chararray,decade:int,perc:double)}')                                                                                                    
                                                                                                                                                                        
def percentage(bag):                                                                                                                                                    
                                                                                                                                                                        
    result = []                                                                                                                                                         
    sum=0.0                                                                                                                                                             
    for tuple_ in bag:                                                                                                                                                  
                                                                                                                                                                        
        sum+=tuple_[2]                                                                                                                                                  
    for tuple_ in bag:                                                                                                                                                  
        result.append((tuple_[0],tuple_[1],tuple_[2]/sum))                                                                                                              
    return result                                                                                                                                                       
                    
