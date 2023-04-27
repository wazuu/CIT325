-- Run the library files here.
-- @/home/student/Data/cit325/lib/cleanup_oracle.sql
-- @/home/student/Data/cit325/lib/Oracle12cPLSQLCode/Introduction/create_video_store.sql


-- Open log file.
SPOOL man_t.txt

-- ... insert your solution here ...
/********************************************************************************
An man_t object type and type body as a subtype of the base_t object type, and 
a QUIT; statement in a man_t file.
*********************************************************************************/
CREATE OR REPLACE 
    TYPE man_t UNDER base_t
        ( /*oid   NUMBER
        , oname VARCHAR2(30)*/
          name  VARCHAR2(30)
        , genus VARCHAR2(30)
        , CONSTRUCTOR FUNCTION man_t
            ( name  VARCHAR2
            , genus VARCHAR2 DEFAULT 'Men' ) RETURN SELF AS RESULT
        , OVERRIDING MEMBER FUNCTION   get_name RETURN VARCHAR2
        , MEMBER PROCEDURE  set_name (name VARCHAR2)
        , MEMBER FUNCTION   get_genus RETURN VARCHAR2
        , MEMBER PROCEDURE  set_genus (genus VARCHAR2)
        , OVERRIDING MEMBER FUNCTION  to_string RETURN VARCHAR2 ) INSTANTIABLE NOT FINAL;
/

-- SHOW ERRORS

DESC man_t

/********************************************************************************
This is the man_t type body
*********************************************************************************/
CREATE OR REPLACE 
	TYPE BODY man_t IS 
	
	CONSTRUCTOR FUNCTION man_t
	( /*oid      NUMBER
	  oname    VARCHAR2*/
      name     VARCHAR2
	, genus    VARCHAR2 DEFAULT 'Men' ) RETURN SELF AS RESULT IS 
	BEGIN 
		self.oid := tolkien_s.CURRVAL-1000;
		self.name := name;
		self.genus := genus;
        self.oname := 'Man';
		RETURN;
	END man_t;
	
	OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2 IS 
	BEGIN 
		RETURN self.name;
	END get_name;
	
	MEMBER PROCEDURE set_name (name VARCHAR2) IS 
	BEGIN 
		self.name := name;
	END set_name;
		
	MEMBER FUNCTION get_genus RETURN VARCHAR2 IS
	BEGIN 
		return self.genus;
	END get_genus;
	
	MEMBER PROCEDURE set_genus ( genus VARCHAR2 ) IS
	BEGIN 
		self.genus := genus;
	END set_genus;
	
	OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS 
	BEGIN 
		RETURN (self AS base_t).to_string() ||'['||self.name||']['||self.genus||']';
	END to_string;
END;
/

SHOW ERRORS

QUIT;

-- Close log file.
SPOOL OFF