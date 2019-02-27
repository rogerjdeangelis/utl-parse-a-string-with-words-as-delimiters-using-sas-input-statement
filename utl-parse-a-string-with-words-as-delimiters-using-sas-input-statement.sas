Parse a string with words as delimiters using sas input statement                                             
                                                                                                              
This is not a general solution but does produce the defined output.                                           
                                                                                                              
I think the SAS input statement is underused.                                                                 
                                                                                                              
SAS Forum                                                                                                     
https://tinyurl.com/yxne6ucc                                                                                  
https://communities.sas.com/t5/SAS-Programming/Parse-a-string-with-words-as-delimiters/m-p/538763             
                                                                                                              
github                                                                                                        
https://tinyurl.com/y28sm2r8                                                                                  
https://github.com/rogerjdeangelis/utl-parse-a-string-with-words-as-delimiters-using-sas-input-statement      
                                                                                                              
*_                   _                                                                                        
(_)_ __  _ __  _   _| |_                                                                                      
| | '_ \| '_ \| | | | __|                                                                                     
| | | | | |_) | |_| | |_                                                                                      
|_|_| |_| .__/ \__,_|\__|                                                                                     
        |_|                                                                                                   
;                                                                                                             
                                                                                                              
cards4;                                                                                                       
111 xxx,xxcn=test1,yyy,zz,cn=test2,dfd                                                                        
222 xadfds , xx,xxcn=test3,yyy,zz,cn=test2,dfd                                                                
;;;;                                                                                                          
                                                                                                              
*           _                                                                                                 
 _ __ _   _| | ___  ___                                                                                       
| '__| | | | |/ _ \/ __|                                                                                      
| |  | |_| | |  __/\__ \                                                                                      
|_|   \__,_|_|\___||___/                                                                                      
                                                                                                              
;                                                                                                             
                                                                                                              
 WORK.WANT total obs=2               |                                                                        
                                     | RULES  (test1, test2 and test3 follow 'cnn=')                          
  LINE    TEST1    TEST2    TEST3    |                                                                        
                                     |              -----           -----                                     
   111      1        1        .      | 111 xxx,xxcn=test1,yyy,zz,cn=test2,dfd                                 
                                                                                                              
                                                            -----           ----                              
   222      .        1        1      | 222 xadfds , xx,xxcn=test3,yyy,zz,cn=test2,dfd                         
                                                                                                              
*            _               _                                                                                
  ___  _   _| |_ _ __  _   _| |_                                                                              
 / _ \| | | | __| '_ \| | | | __|                                                                             
| (_) | |_| | |_| |_) | |_| | |_                                                                              
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                             
                |_|                                                                                           
;                                                                                                             
                                                                                                              
 WORK.WANT total obs=2                                                                                        
                                                                                                              
  LINE    TEST1    TEST2    TEST3                                                                             
                                                                                                              
   111      1        1        .                                                                               
   222      .        1        1                                                                               
                                                                                                              
*          _       _   _                                                                                      
 ___  ___ | |_   _| |_(_) ___  _ __                                                                           
/ __|/ _ \| | | | | __| |/ _ \| '_ \                                                                          
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                         
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                         
                                                                                                              
;                                                                                                             
                                                                                                              
data have;                                                                                                    
 infile cards line=lyn;                                                                                       
 input @'cn=' txt $5. @@;                                                                                     
 line=lyn*111;                                                                                                
 lagLine=lag(line);                                                                                           
 if line < lagLine then line=lagLine;                                                                         
 num=1;                                                                                                       
 drop lagline;                                                                                                
cards4;                                                                                                       
111 xxx,xxcn=test1,yyy,zz,cn=test2,dfd                                                                        
222 xadfds , xx,xxcn=test3,yyy,zz,cn=test2,dfd                                                                
;;;;                                                                                                          
run;quit;                                                                                                     
                                                                                                              
/* this is a more usefull data structure? */                                                                  
WORK.HAVE total obs=4                                                                                         
                                                                                                              
  TXT     LINE    NUM                                                                                         
                                                                                                              
 test1     111     1                                                                                          
 test2     111     1                                                                                          
 test3     222     1                                                                                          
 test2     222     1                                                                                          
*/                                                                                                            
                                                                                                              
proc transpose data=have out=want(drop=_name_);                                                               
  by line;                                                                                                    
  var num;                                                                                                    
  id txt;                                                                                                     
run;quit;                                                                                                     
                                                                                                              
/*                                                                                                            
WORK.WANT total obs=2                                                                                         
                                                                                                              
  LINE    TEST1    TEST2    TEST3                                                                             
                                                                                                              
   111      1        1        .                                                                               
   222      .        1        1                                                                               
*/                                                                                                            
                                                                                                              
