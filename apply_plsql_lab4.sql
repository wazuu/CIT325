SQL> 
SQL> -BEGIN
SP2-0042: unknown command "-BEGIN" - rest of line ignored.
SQL> --     --Read forward through a range of values
SQL> --     FOR i IN 1..10 LOOP
SQL> --         IF i < 10 THEN
SQL> --             dbms_output.put_line('Value of "i" is: ['||i||']');
SQL> --         ELSE
SQL> --             dbms_output.put_line('Value of "i" is: ['||i||']');
SQL> --         END IF;
SQL> --     END LOOP;
SQL> -- END;
SQL> -- /
SQL> 
SQL> 
SQL> -- BEGIN
SQL> --     --Read backward through a range of values
SQL> --     FOR i IN REVERSE 1..10 LOOP
SQL> --         IF i < 10 THEN
SQL> --             dbms_output.put_line('Value of "i" is: ['||i||']');
SQL> --         ELSE
SQL> --             dbms_output.put_line('Value of "i" is: ['||i||']');
SQL> --         END IF;
SQL> --     END LOOP;
SQL> -- END;
SQL> -- /
SQL> 
SQL> --You declare a days object type of a number and string in SQL with the following syntx
SQL> -- CREATE OR REPLACE
SQL> --     TYPE weekday IS OBJECT
SQL> --     (xnumber    number
SQL> --     ,xtext      VARCHAR2(9)
SQL> --     );
SQL> --     /
SQL> 
SQL> -- --You would implement the anonymous PL/SQL block with the following code
SQL> -- DECLARE
SQL> --     --Declare an array of days and gifts
SQL> --     TYPE days IS TABLE OF weekday;
SQL> --
SQL> --     --Initialize the collection of days
SQL> --     lv_days DAYS := days( weekday(1, 'Sunday')
SQL> --                         , weekday(2, 'Monday')
SQL> --                         , weekday(3, 'Tuesday')
SQL> --                         , weekday(4, 'Wednesday')
SQL> --                         , weekday(5, 'Thursday')
SQL> --                         , weekday(6, 'Friday')
SQL> --                         , weekday(7, 'Saturday')
SQL> --                         );
SQL> --
SQL> -- BEGIN
SQL> --     --Read forward through the contents of the loop
SQL> --     FOR i IN 1..lv_days.COUNT LOOP
SQL> --         dbms_output.put_line('Value of "day" is: ['||lv_days(i).xtext||']');
SQL> --     END LOOP;
SQL> -- END;
SQL> -- /
SQL> 
SQL> -- DECLARE
SQL> --     --Declare an array of days and gifts
SQL> --     TYPE days IS TABLE OF weekday;
SQL> --     TYPE weekdays IS TABLE OF weekday;
SQL> --
SQL> --     --Initialize the collection of days
SQL> --     lv_days DAYS := days( weekday(1, 'Sunday')
SQL> --                         , weekday(2, 'Monday')
SQL> --                         , weekday(3, 'Tuesday')
SQL> --                         , weekday(4, 'Wednesday')
SQL> --                         , weekday(5, 'Thursday')
SQL> --                         , weekday(6, 'Friday')
SQL> --                         , weekday(7, 'Saturday')
SQL> --                         );
SQL> --                         lv_weekdays WEEKDAYS := weekdays();
SQL> --
SQL> -- BEGIN
SQL> --     --Remove the weekend elements, which alters the collection
SQL> --     FOR i IN 1..lv_days.COUNT LOOP
SQL> --         IF lv_days(i).xtext IN ('Saturday','Sunday') THEN
SQL> --             lv_days.DELETE(i);
SQL> --         END IF;
SQL> --     END LOOP;
SQL> --
SQL> --     --Read forward through the contents of the loop
SQL> --     FOR i IN 1..lv_days.LAST LOOP
SQL> --         IF lv_days.EXISTS(i) THEN
SQL> --             dbms_output.put_line('Value of "day" is: ['||i||']['||lv_days(i).xnumber||']['||lv_days(i).xtext||']');
SQL> --         END IF;
SQL> --     END LOOP;
SQL> -- END;
SQL> -- /
SQL> 
SQL> --Show the input
SQL> SET SERVEROUTPUT ON SIZE UNLIMITED
SQL> SET VERIFY OFF
SQL> SET ECHO ON;
SQL> 
SQL> --Create the day and gift objects
SQL> CREATE OR REPLACE
  2      TYPE day_name IS OBJECT
  3          ( xtext     VARCHAR2(8)
  4          );
  5          /

Type created.

SQL> 
SQL> CREATE OR REPLACE
  2      TYPE gift_name IS OBJECT
  3          ( xqty      VARCHAR2(8)
  4          , xgift     VARCHAR2(24)
  5          );
  6          /

Type created.

SQL> 
SQL> DECLARE
  2  --Declare tables of days and gifts
  3      TYPE days IS TABLE OF day_name;
  4      TYPE gifts IS TABLE OF gift_name;
  5  
  6  
  7  --Initialize days
  8      lv_days DAYS := days(day_name('First')
  9                          , day_name('Second')
 10                          , day_name('Third')
 11                          , day_name('Fourth')
 12                          , day_name('Fifth')
 13                          , day_name('Sixth')
 14                          , day_name('Seventh')
 15                          , day_name('Eighth')
 16                          , day_name('Ninth')
 17                          , day_name('Tenth')
 18                          , day_name('Eleventh')
 19                          , day_name('Twelfth')
 20                          );
 21  
 22  --Initialize gifts
 23      lv_gifts GIFTS := gifts(gift_name('-and a', 'Partridge in a pear tree')
 24                          , gift_name('-Two', 'Turtle doves')
 25                          , gift_name('-three', 'French hens')
 26                          , gift_name('-Four', 'Calling birds')
 27                          , gift_name('-Five', 'Golden rings')
 28                          , gift_name('-Six', 'Geese a laying')
 29                          , gift_name('-Seven', 'Swans a swimming')
 30                          , gift_name('-Eight', 'Maids a milking')
 31                          , gift_name('-Nine', 'Ladies dancing')
 32                          , gift_name('-Ten', 'Lords a leaping')
 33                          , gift_name('-Eleven', 'Pipers piping')
 34                          , gift_name('-Twelve', 'Drummers drumming')
 35                          );
 36  
 37  BEGIN
 38  --Read forward
 39      FOR i IN 1..lv_days.COUNT LOOP
 40          dbms_output.put_line('On the ' || lv_days(i).xtext || ' day of Christmas');
 41          dbms_output.put_line('my true love gave to me:');
 42  --Read backward
 43      FOR x IN REVERSE 1..i LOOP
 44  
 45  --Print "Twelve Days of Christmas"
 46      IF i > 1 THEN
 47          dbms_output.put_line('' ||lv_gifts(x).xqty|| ' ' ||lv_gifts(x).xgift|| '');
 48      ELSE
 49          dbms_output.put_line('-A ' ||lv_gifts(x).xgift|| '');
 50      END IF;
 51  
 52      END LOOP;
 53          dbms_output.put_line(CHR(13));
 54      END LOOP;
 55  END;
 56  /
On the First day of Christmas                                                   
my true love gave to me:                                                        
-A Partridge in a pear tree                                                     
                                                                               
On the Second day of Christmas                                                  
my true love gave to me:                                                        
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Third day of Christmas                                                   
my true love gave to me:                                                        
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Fourth day of Christmas                                                  
my true love gave to me:                                                        
-Four Calling birds                                                             
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Fifth day of Christmas                                                   
my true love gave to me:                                                        
-Five Golden rings                                                              
-Four Calling birds                                                             
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Sixth day of Christmas                                                   
my true love gave to me:                                                        
-Six Geese a laying                                                             
-Five Golden rings                                                              
-Four Calling birds                                                             
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Seventh day of Christmas                                                 
my true love gave to me:                                                        
-Seven Swans a swimming                                                         
-Six Geese a laying                                                             
-Five Golden rings                                                              
-Four Calling birds                                                             
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Eighth day of Christmas                                                  
my true love gave to me:                                                        
-Eight Maids a milking                                                          
-Seven Swans a swimming                                                         
-Six Geese a laying                                                             
-Five Golden rings                                                              
-Four Calling birds                                                             
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Ninth day of Christmas                                                   
my true love gave to me:                                                        
-Nine Ladies dancing                                                            
-Eight Maids a milking                                                          
-Seven Swans a swimming                                                         
-Six Geese a laying                                                             
-Five Golden rings                                                              
-Four Calling birds                                                             
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Tenth day of Christmas                                                   
my true love gave to me:                                                        
-Ten Lords a leaping                                                            
-Nine Ladies dancing                                                            
-Eight Maids a milking                                                          
-Seven Swans a swimming                                                         
-Six Geese a laying                                                             
-Five Golden rings                                                              
-Four Calling birds                                                             
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Eleventh day of Christmas                                                
my true love gave to me:                                                        
-Eleven Pipers piping                                                           
-Ten Lords a leaping                                                            
-Nine Ladies dancing                                                            
-Eight Maids a milking                                                          
-Seven Swans a swimming                                                         
-Six Geese a laying                                                             
-Five Golden rings                                                              
-Four Calling birds                                                             
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               
On the Twelfth day of Christmas                                                 
my true love gave to me:                                                        
-Twelve Drummers drumming                                                       
-Eleven Pipers piping                                                           
-Ten Lords a leaping                                                            
-Nine Ladies dancing                                                            
-Eight Maids a milking                                                          
-Seven Swans a swimming                                                         
-Six Geese a laying                                                             
-Five Golden rings                                                              
-Four Calling birds                                                             
-three French hens                                                              
-Two Turtle doves                                                               
-and a Partridge in a pear tree                                                 
                                                                               

PL/SQL procedure successfully completed.

SQL> 
SQL> 
SQL> -- Close log file.
SQL> SPOOL OFF
