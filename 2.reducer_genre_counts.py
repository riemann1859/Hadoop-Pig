

#!/usr/bin/env python                                                                                                                                                   
# want to count the number of occurrences of each  genre  in the whole dataset                                                                                                                                                                   
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
                                                                                                                                                                        
a=list(genre_dict.items())                                                                                                                                              
a.sort(key=lambda x:x[1],reverse=True)                                                                                                                                  
                                                                                                                                                                        
for genre,count in a:                                                                                                                                                   
    print("{x}\t{y}".format(x=genre,y=count)) 
