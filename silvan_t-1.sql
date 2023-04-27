-- Run the library files here.
-- @/home/student/Data/cit325/lib/cleanup_oracle.sql
-- @/home/student/Data/cit325/lib/Oracle12cPLSQLCode/Introduction/create_video_store.sql

SPOOL silvan_t.txt

CREATE OR REPLACE 
    TYPE silvan_t UNDER base_t
        ( /*oid       NUMBER
        , oname     VARCHAR2(30)*/
         name      VARCHAR2(30)
        , genus     VARCHAR2(30)
        , elfkind   VARCHAR2(30)
        , CONSTRUCTOR FUNCTION noldor_t
            ( name      VARCHAR2
            , genus     VARCHAR2 DEFAULT 'Elves' 
            , elfkind   VARCHAR2 DEFAULT 'Silvan') RETURN SELF AS RESULT
        , OVERRIDING MEMBER FUNCTION   get_name RETURN VARCHAR2
        , MEMBER PROCEDURE  set_name (name VARCHAR2)
        , MEMBER FUNCTION   get_genus RETURN VARCHAR2
        , MEMBER PROCEDURE  set_genus (genus VARCHAR2)
        , MEMBER FUNCTION   get_elfkind RETURN VARCHAR2
        , MEMBER PROCEDURE  set_elfkind (elfkind VARCHAR2)
        , OVERRIDING MEMBER FUNCTION  to_string RETURN VARCHAR2 ) INSTANTIABLE NOT FINAL;
/

-- SHOW ERRORS

DESC silvan_t

/********************************************************************************
This is the noldor_t type body
*********************************************************************************/
CREATE OR REPLACE 
	TYPE BODY silvan_t IS 
	
	CONSTRUCTOR FUNCTION silvan_t
	( /*oid      NUMBER
	, oname    VARCHAR2*/
	  name     VARCHAR2
	, genus    VARCHAR2 DEFAULT 'Elves'
	, elfkind  VARCHAR2 DEFAULT 'Silvan' ) RETURN SELF AS RESULT IS 
	BEGIN 
		self.oid := tolkien_s.CURRVAL-1000;
		self.name := name;
		self.genus := genus;
        self.oname := 'Elf';
        self.elfkind := elfkind;
		RETURN;
	END noldor_t;
	
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
		RETURN self.genus;
	END get_genus;
	
	MEMBER PROCEDURE set_genus ( genus VARCHAR2 ) IS
	BEGIN 
		self.genus := genus;
	END set_genus;
	
	MEMBER FUNCTION get_elfkind RETURN VARCHAR2 IS
	BEGIN 
        RETURN self.elfkind;
	END get_elfkind;
	
	MEMBER PROCEDURE set_elfkind ( elfkind VARCHAR2 ) IS
	BEGIN
        self.elfkind := elfkind;
	END set_elfkind;
	
	OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS 
	BEGIN 
		RETURN (self AS base_t).to_string() ||'['||self.name||']['||self.genus||']['||self.elfkind||']';
	END to_string;
END;
/

SHOW ERRORS

QUIT;

-- Close log file.
SPOOL OFF