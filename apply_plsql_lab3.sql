/*
||  Name:          Tim Smith
||  Date:          21-January-2023
||  Purpose:       Complete 325 Chapter 4 lab.
*/

-- Call seeding libraries.
@$LIB/cleanup_oracle.sql
@$LIB/Oracle12cPLSQLCode/Introduction/create_video_store.sql

-- Open log file.
SPOOL apply_plsql_lab3.txt

DECLARE
  /* Declare a collection of strings. */
  TYPE list IS TABLE OF VARCHAR2(12);
  /* Declare a variable of the string collection. */
  lv_strings  LIST := list('10','Ten','Twelve12','28-FEB-2016');
BEGIN
  /* Loop through list of values to find only the numbers. */
  FOR i IN 1..lv_strings.COUNT LOOP
    IF REGEXP_LIKE(lv_strings(i),'^[[:digit:]]*$') OR
       REGEXP_LIKE(lv_strings(i),'^[0-9]{2,2}-[[:alpha:]]{3,3}-([0-9]{2,2}|[0-9]{4,4})$') OR
       REGEXP_LIKE(lv_strings(i),'^[[:alnum:]]*$') THEN
       dbms_output.put_line('Print string ['||lv_strings(i)||']');
    END IF;
  END LOOP;
END;
/

CREATE OR REPLACE
  FUNCTION verify_date
  ( pv_date_in  VARCHAR2) RETURN DATE IS
  /* Local return variable. */
  lv_date  DATE;
BEGIN
  /* Check for a DD-MON-RR or DD-MON-YYYY string. */
  IF REGEXP_LIKE(pv_date_in,'^[0-9]{2,2}-[ADFJMNOS][ACEOPU][BCGLNPRTVY]-([0-9]{2,2}|[0-9]{4,4})$') THEN
    /* Case statement checks for 28 or 29, 30, or 31 day month. */
    CASE
      /* Valid 31 day month date value. */
      WHEN SUBSTR(pv_date_in,4,3) IN ('JAN','MAR','MAY','JUL','AUG','OCT','DEC') AND
           TO_NUMBER(SUBSTR(pv_date_in,1,2)) BETWEEN 1 AND 31 THEN 
        lv_date := pv_date_in;
      /* Valid 30 day month date value. */
      WHEN SUBSTR(pv_date_in,4,3) IN ('APR','JUN','SEP','NOV') AND
           TO_NUMBER(SUBSTR(pv_date_in,1,2)) BETWEEN 1 AND 30 THEN 
        lv_date := pv_date_in;
      /* Valid 28 or 29 day month date value. */
      WHEN SUBSTR(pv_date_in,4,3) = 'FEB' THEN
        /* Verify 2-digit or 4-digit year. */
        IF (LENGTH(pv_date_in) = 9 AND MOD(TO_NUMBER(SUBSTR(pv_date_in,8,2)) + 2000,4) = 0 OR
            LENGTH(pv_date_in) = 11 AND MOD(TO_NUMBER(SUBSTR(pv_date_in,8,4)),4) = 0) AND
            TO_NUMBER(SUBSTR(pv_date_in,1,2)) BETWEEN 1 AND 29 THEN
          lv_date := null;
        ELSE /* Not a leap year. */
          IF TO_NUMBER(SUBSTR(pv_date_in,1,2)) BETWEEN 1 AND 28 THEN
            lv_date := null;
          ELSE
            lv_date := null;
          END IF;
        END IF;
      ELSE
        /* Assign a default date. */
        lv_date := null;
    END CASE;
  ELSE
    /* Assign a default date. */
    lv_date := null;
  END IF;
  /* Return date. */
  RETURN lv_date;
END;
/

SET SERVEROUTPUT ON SIZE UNLIMITED

DECLARE
  lv_date    DATE;
  lv_string  VARCHAR2(11) := '15-JAN-2017';
BEGIN
  /* Check and assign valid date. */
  IF verify_date(lv_string) IS NOT NULL THEN
    lv_date := lv_string;
    dbms_output.put_line('Does match date:     ['||lv_string||']['||lv_date||']');
  ELSE
    dbms_output.put_line('Does not match date: ['||lv_string||']['||lv_date||']');
  END IF;
END;
/

DECLARE
  lv_date    DATE;
  lv_string  VARCHAR2(11) := '31-APR-2017';
BEGIN
  /* Check and assign valid date. */
  IF verify_date(lv_string) IS NOT NULL THEN
    lv_date := lv_string;
    dbms_output.put_line('Does match date:     ['||lv_string||']['||lv_date||']');
  ELSE
    dbms_output.put_line('Does not match date: ['||lv_string||']['||lv_date||']');
  END IF;
END;
/



SET VERIFY OFF
SET SERVEROUTPUT ON SIZE UNLIMITED 
DECLARE
    --Declare a type
    TYPE three_type IS RECORD
    (xnum       NUMBER
    , xdate     DATE
    , xstring    VARCHAR2(30)
    );
    
    --Declare a collection of strings
    TYPE list IS TABLE OF VARCHAR2(100);
    
    --Declare variable of the record type
    lv_three_type three_type;
    
    --Declare a list of the collection type
    lv_input LIST;
    
    --Declare indepentent list variables 
    lv_input1 VARCHAR2(100);
    lv_input2 VARCHAR2(100);
    lv_input3 VARCHAR2(100);

BEGIN
    --Assign input variables
    lv_input1 := '&1';
    lv_input2 := '&2';
    lv_input3 := '&3';
    
    --Construct an instance of the input variable
    lv_input := list(lv_input1, lv_input2, lv_input3);
    
    --Loop thru list of values to find only the numbers
    FOR i IN 1..lv_input.COUNT LOOP
        IF  REGEXP_LIKE(lv_input(i), '^[[:digit:]]*$') THEN
            lv_three_type.xnum := lv_input(i);
        ELSIF verify_date(lv_input(i)) IS NOT NULL THEN
            lv_three_type.xdate := lv_input(i);
        ELSIF REGEXP_LIKE(lv_input(i), '^[[:alnum:]]*$') THEN
            lv_three_type.xstring := lv_input(i);
        END IF;
    END LOOP;
    
    --
    dbms_output.put_line('RECORD ['||lv_three_type.xnum||'] ['||lv_three_type.xstring||'] ['||lv_three_type.xdate||']');
    
END;
    /
    
    --Exit SQL*Plus
    
-- Close log file.
--SPOOL OFF
QUIT;

-- Close log file.
SPOOL OFF
