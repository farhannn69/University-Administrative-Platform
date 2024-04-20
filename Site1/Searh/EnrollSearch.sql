CLEAR Screen;
SET SERVEROUTPUT ON;
SET Verify OFF;
ACCEPT A PROMPT "Enter ID Number :";

CREATE OR REPLACE PACKAGE enrs1_p AS
	PROCEDURE Srch;
END enrs1_p;
/

CREATE OR REPLACE PACKAGE BODY enrs1_p AS

	PROCEDURE Srch
	IS
	n NUMBER;
	ID Enrollment1.SID%TYPE;
	eeid Enrollment1.EID%TYPE;
	ccid Enrollment1.CID%TYPE;
	myExp EXCEPTION;

	BEGIN
		n:=0;
		ID:=&A;
		SELECT COUNT(*) into n FROM Enrollment1 WHERE SID =ID;
		IF (n>0) THEN
			DBMS_OUTPUT.PUT_LINE('FOUND');
			FOR I in(SELECT EID,CID From Enrollment1 where Enrollment1.SID =ID)LOOP
				eeid:=I.EID;
				ccid:=I.CID;
				DBMS_OUTPUT.PUT_LINE('EID: '||eeid ||'	CID: '||ccid);
			END LOOP;
				
		ELSE
			RAISE myExp;
		END IF;
		EXCEPTION
		WHEN myExp THEN DBMS_OUTPUT.PUT_LINE('NOT FOUND');
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Other errors');

	END Srch;
END enrs1_p;
/
BEGIN
	enrs1_p.Srch;
END;
/