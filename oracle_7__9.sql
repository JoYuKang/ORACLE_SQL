------------------------ 7�� -------------------------

       CREATE TABLE NEW_EMP1 ( NO NUMBER(4) CONSTRAINT EMP1_NO_PK PRIMARY KEY, NAME VARCHAR2(20) CONSTRAINT EMP1_NAME_NN NOT NULL, JUMIN VARCHAR2(13) CONSTRAINT EMP1_JUMIN_NN NOT NULL CONSTRAINT EMP1_JUMIN_UK UNIQUE, LOC_CODE NUMBER(1) CONSTRAINT EMP1_AREA_CK CHECK(LOC_CODE < 5), DEPTNO VARCHAR2(6) CONSTRAINT EMP1_DEPTNO_KF REFERENCES DEPT2(DCODE));
 CREATE TABLE NEW_EMP2 ( NO NUMBER(4) PRIMARY KEY , NAME VARCHAR2(20) NOT NULL , JUMIN VARCHAR2(13) NOT NULL UNIQUE , LOC_CODE NUMBER(1) CHECK (LOC_CODE<5) , DEPTNO VARCHAR2(6) REFERENCES DEPT2(DCODE) );
 
-- 2.2 ���̺� ���� �� �߰��ϱ�
       ALTER TABLE NEW_EMP2 ADD CONSTRAINT EMP2_NAME_UK UNIQUE(NAME);
 ALTER TABLE NEW_EMP2 MODIFY (LOC_CODE CONSTRAINT EMP2_LOCCODE_NN NOT NULL);
 ALTER TABLE NEW_EMP2 ADD CONSTRAINT EMP2_NO_FK FOREIGN KEY(NO) REFERENCES EMP2(EMPNO);
 ALTER TABLE EMP2 ADD CONSTRAINT EMP2_NAME_UK UNIQUE(NAME);
 ALTER TABLE NEW_EMP2 ADD CONSTRAINT EMP2_NAME_FK FOREIGN KEY(NAME) REFERENCES EMP2(NAME);
 CREATE TABLE C_TEST1 ( NO NUMBER , NAME VARCHAR2(6) , DEPTNO NUMBER );
 CREATE TABLE C_TEST2 ( NO NUMBER , NAME VARCHAR2(10) );
 ALTER TABLE C_TEST1 ADD CONSTRAINT CTEST1_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES C_TEST2(NO);
 ALTER TABLE C_TEST2 ADD CONSTRAINT CTEST2_NO_UK UNIQUE(NO);
 ALTER TABLE C_TEST1 ADD CONSTRAINT CTEST1_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES C_TEST2(NO) ON 
DELETE CASCADE;
 
INSERT
  INTO C_TEST2
VALUES(10
             ,'AAAA');
 
INSERT
  INTO C_TEST2
VALUES(20
             ,'BBBB');
 
INSERT
  INTO C_TEST2
VALUES(30
             ,'CCCC');
 COMMIT;
 
SELECT *
  FROM C_TEST2;
 
INSERT
  INTO C_TEST1
VALUES(1
             ,'apple'
             ,10);
 
INSERT
  INTO C_TEST1
VALUES(2
             ,'banana'
             ,20);
 
INSERT
  INTO C_TEST1
VALUES(2
             ,'cherry'
             ,30);
 
INSERT
  INTO C_TEST1
VALUES(4
             ,'peach'
             ,40);
 
SELECT *
  FROM C_TEST1;
 
DELETE
  FROM C_TEST2
 WHERE NO=10;
 ALTER TABLE C_TEST1 DROP CONSTRAINT CTEST1_DEPTNO_FK;
 ALTER TABLE C_TEST1 ADD CONSTRAINT CTEST1_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES C_TEST2(NO) ON 
DELETE
   SET NULL;
 
SELECT *
  FROM C_TEST1;
 
SELECT *
  FROM C_TEST2;
 
DELETE
  FROM C_TEST2
 WHERE NO=20;
 
SELECT *
  FROM C_TEST1;
 ALTER TABLE C_TEST1 MODIFY ( DEPTNO CONSTRAINT CTEST1_DEPTNO_NN NOT NULL);
 
UPDATE C_TEST1
   SET DEPTNO=30
 WHERE NO=2;
 COMMIT;
 
SELECT *
  FROM C_TEST1;
 ALTER TABLE C_TEST1 MODIFY ( DEPTNO CONSTRAINT CTEST1_DEPTNO_NN NOT NULL);
 SELECT *
  FROM C_TEST2;
 
DELETE
  FROM C_TEST2;
 
-- 3. ���� ���� �����ϱ�
       CREATE TABLE T_NOVALIDATE (NO NUMBER PRIMARY KEY, NAME VARCHAR2(10) NOT NULL);
 
INSERT
  INTO T_NOVALIDATE
VALUES(1
             ,'AAA');
 
INSERT
  INTO T_NOVALIDATE
VALUES(2
             ,'BBB');
 
INSERT
  INTO T_NOVALIDATE
VALUES(3
             ,'CCC');
 COMMIT;
 CREATE TABLE T_VALIDATE (NO NUMBER CONSTRAINT TV_NO_PK PRIMARY KEY, NAME VARCHAR2(10) CONSTRAINT TV_NAME_NN NOT NULL);
 
INSERT
  INTO T_VALIDATE
VALUES(1
             ,'AAA');
 
INSERT
  INTO T_VALIDATE
VALUES(2
             ,'BBB');
 
INSERT
  INTO T_VALIDATE
VALUES(3
             ,'CCC');
 COMMIT;
 CREATE TABLE T_ENABLE (NO NUMBER CONSTRAINT TE_NO_PK PRIMARY KEY, NAME VARCHAR2(10) CONSTRAINT TE_NAME_NN NOT NULL);
 
-- 3.1 ���� ���� DISABLE �ϱ�

-- 3.1.1 DISABLE NOVALIDATE ����ϱ�
INSERT
  INTO T_NOVALIDATE
VALUES(1
             ,'DDD');
 ALTER TABLE T_NOVALIDATE DISABLE NOVALIDATE CONSTRAINT SYS_C0014418;
 
INSERT
  INTO T_NOVALIDATE
VALUES(1
             ,'DDD');
 
-- 3.1.2 DISABLE VALIDATE ����ϱ�
INSERT
  INTO T_VALIDATE
VALUES(4
             ,NULL);
 ALTER TABLE T_VALIDATE DISABLE VALIDATE CONSTRAINT TV_NAME_NN;
 
INSERT
  INTO T_VALIDATE
VALUES(4
             ,NULL);
 
-- 3.1.3 DISABLE VALIDATE �ɼ� ���� �� �ٸ� �÷� ���� �����ϱ�
INSERT
  INTO T_VALIDATE
VALUES(4
             ,'DDD');
 
INSERT
  INTO T_VALIDATE
VALUES(4
             ,NULL);
 
INSERT
  INTO T_VALIDATE(NO)
VALUES(4);
 
-- 3.2 ���� ���� ENABLE �ϱ�
INSERT
  INTO T_ENABLE
VALUES(1
             ,'AAA');
 
INSERT
  INTO T_ENABLE
VALUES(2
             ,'BBB');
 
INSERT
  INTO T_ENABLE
VALUES(3
             ,NULL);
 ALTER TABLE T_ENABLE DISABLE CONSTRAINT TE_NAME_NN;
 
INSERT
  INTO T_ENABLE
VALUES(3
             ,NULL);
 
-- 3.2.1 ENABLE NOVALIDATE�� name �÷� ���� ���� ENABLE�ϱ�
       ALTER TABLE T_ENABLE ENABLE NOVALIDATE CONSTRAINT TE_NAME_NN;
 
SELECT *
  FROM T_ENABLE;
 
INSERT
  INTO T_ENABLE
VALUES(4
             ,NULL);
 
-- 3.2.2 ENABLE VALIDATE�� name �÷� ���� ���� ENABLE�ϱ�
       ALTER TABLE T_ENABLE DISABLE CONSTRAINT TE_NAME_NN;
 ALTER TABLE T_ENABLE ENABLE VALIDATE CONSTRAINT TE_NAME_NN;
 
-- 3.3 EXCEPTIONS ���̺��� ����Ͽ� ENABLE VALIDATE �ϱ�
       CREATE TABLE SCOTT.TT500 (NO NUMBER CONSTRAINT TT500_CK CHECK(NO>5));
 ALTER TABLE SCOTT.TT500 DISABLE CONSTRAINT TT500_CK;
 
INSERT
  INTO SCOTT.TT500
VALUES(1);
 
INSERT
  INTO SCOTT.TT500
VALUES(6);
 
INSERT
  INTO SCOTT.TT500
VALUES(7);
 COMMIT;
 SELECT *
  FROM SCOTT.TT500;
 ALTER TABLE SCOTT.TT500 ENABLE VALIDATE CONSTRAINT TT500_CK EXCEPTIONS 
  INTO SYS.EXCEPTIONS;
 
SELECT ROWID
     , NO
  FROM SCOTT.TT500
 WHERE ROWID IN (SELECT ROW_ID
          FROM EXCEPTIONS);
 
UPDATE SCOTT.TT500
   SET NO=8
 WHERE ROWID='AAANExAAEAAAAVMAAB' COMMIT;
 TRUNCATE TABLE SYS.EXCEPTIONS;
 ALTER TABLE SCOTT.TT500 ENABLE VALIDATE CONSTRAINT TT500_CK;
 
SELECT *
  FROM SCOTT.TT500;

INSERT INTO SCOTT.TT500 VALUES(1);

CONN SCOTT/TIGER;
@?/rdbms/admin/utlexcpt.sql

CREATE TABLE TT551
(NO NUMBER, NAME VARCHAR2(10) CONSTRAINT TT551_NAME_UK UNIQUE );

ALTER TABLE TT551 DISABLE CONSTRAINT TT551_NAME_UK;

INSERT INTO TT551 VALUES(1,'AAA');
INSERT INTO TT551 VALUES(2,'AAA');
INSERT INTO TT551 VALUES(3,'AAA');
COMMIT;
SELECT * FROM TT551;

ALTER TABLE TT551
ENABLE VALIDATE CONSTRAINT TT551_NAME_UK
EXCEPTIONS INTO EXCEPTIONS;

SELECT ROWID, NAME
FROM TT551
WHERE ROWID IN(SELECT ROW_ID FROM EXCEPTIONS);

UPDATE TT551
SET NAME='BBB'
WHERE ROWID='AAASVkAAEAAAAQjAAB';

UPDATE TT551 SET NAME='CCC'
WHERE ROWID='AAASVkAAEAAAAQjAAC';

COMMIT;

SELECT ROWID, NAME
FROM TT551
WHERE ROWID IN (SELECT ROW_ID FROM EXCEPTIONS);

TRUNCATE TABLE EXCEPTIONS;

ALTER TABLE TT551
ENABLE VALIDATE CONSTRAINT TT551_NAME_UK
EXCEPTIONS INTO EXCEPTIONS;

SELECT * FROM TT551;

SELECT OWNER, CONSTRAINT_AME, CONSTRAINT_TYPE, STATUS
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='NEW_EMP2';

SELECT OWNER, CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME='EMP';

COL CHILD_TABLE FOR A15
COL CHILD_COLUMN FOR A15
COL CHILD_CONS_NAME FOR A15
COL PARENT_TABLE FOR A15
COL PARENT_CONS_NAME FOR A15
COL PARENT_COLUMN FOR A15
SELECT A.TABLE_NAME "Child_table",
	C.COLUMN_NAME "Child_Column",
	A.CONSTRAINT_NAME "Child_Cons_name",
	B.TABLE_NAME "Parent_Table",
	A.R_CONSTRAINT_NAME "Parent_Cons_name",
	D.COLUMN_NAME "Parent_Column"
FROM USER_CONSTRAINTS A , USER_CONSTRAINTS B, USER_CONS_COLUMNS C,
	(SELECT CONSTRAINT_NAME, COLUMN_NAME, TABLE_NAME
	FROM USER_CONS_COLUMNS) D
WHERE A.R_CONSTRAINT_NAME = B.CONSTRAINT_NAME
AND	A.CONSTRAINT_NAME=C.CONSTRAINT_NAME
AND	A.R_CONSTRAINT_NAME=D.CONSTRAINT_NAME
AND 	A.CONSTRAINT_TYPE='R';

ALTER TABLE NEW_EMP2
DROP CONSTRAINT EMP2_NAME_FK;
 
-------------------- �������� --------------------------------------------

-- 1��
       CREATE TABLE TCONS ( NO NUMBER(5) CONSTRAINT TCONS_NO_PK PRIMARY KEY , NAME VARCHAR2(20) CONSTRAINT TCONS_NAME_NN NOT NULL , JUMIN VARCHAR2(13) CONSTRAINT TCONS_JUMIN_NN NOT NULL CONSTRAINT TCONS_JUMIN_UK UNIQUE , AREA NUMBER(1) CONSTRAINT TCONS_AREA_CK CHECK (AREA>=1
                   AND AREA<=4) , DEPTNO VARCHAR2(6) CONSTRAINT TCONS_DEPTNO_FK REFERENCES DEPT2(DCODE) );
 
-- 2��
       ALTER TABLE EMP2 ADD CONSTRAINT EMP2_NAME_UK2 UNIQUE(NAME);
 ALTER TABLE TCONS ADD CONSTRAINT TCONS_NAME_FK FOREIGN KEY(NAME) REFERENCES EMP2(NAME);
 
-- 3��
       ALTER TABLE TCONS DISABLE VALIDATE CONSTRAINT TCONS_JUMIN_UK;
 
-- 4��
       ALTER TABLE TCONS ENABLE VALIDATE CONSTRAINT TCONS_JUMIN_UK;
 
-- 5��
SELECT A.TABLE_NAME
     , A.COLUMN_NAME
     , A.CONSTRAINT_NAME
  FROM USER_CONS_COLUMNS A
     , USER_CONSTRAINTS B
 WHERE A.CONSTRAINT_NAME = B.CONSTRAINT_NAME(+)
   AND A.TABLE_NAME='TCONS'
   AND B.CONSTRAINT_TYPE != 'R';
   
------------------------ 8�� -------------------------

 CREATE UNIQUE INDEX IDX_DEPT2_DNAME ON DEPT2(DNAME);
INSERT INTO DEPT2 VALUES(9100,'TEMP01','1006','SEOUL BRANCH');
INSERT INTO DEPT2 VALUES(9101,'TEMP01','1006','BUSAN BRANCH');

CREATE INDEX IDX_DEPT2_AREA ON DEPT2(AREA);

CREATE INDEX IDX_PROF_PAY_FBI ON PROFESSOR(PAY+1000);
CREATE INDEX IDX_PROF_PAY  ON PROFESSOR(PAY DESC);

SELECT ENAME, SAL FROM EMP WHERE ENAME = 'SMITH' AND SEX='M';
CREATE INDEX IDX_EMP_COMP ON EMP(ENAME, SEX);

CREATE BITMAP INDEX IDX_EMP_SEX_BIT ON EMP(SEX);

SELECT TABLE_NAME, COLUMN_NAME, INDEX_NAME FROM USER_IND_COLUMNS WHERE TABLE_NAME='EMP2';
SELECT TABLE_NAME, INDEX_NAME FROM USER_INDEXES WHERE TABLE_NAME='DEPT2';

ALTER INDEX IDX_EMP_ENAME MONITORING USAGE;
ALTER INDEX IDX_EMP_ENAME NOMONITORING USAGE;

SELECT INDEX_NAME, USED FROM V$OBJECT_USAGE WHERE INDEX_NAME='IDX_EMP_ENAME';

CREATE OR REPLACE VIEW V$ALL_INDEX_USAGE
(
INDEX_NAME,
TABLE_NAME,
OWER_NAME,
MONITORING,
USED,
START_MONITORING,
END_MONITORING)
AS
SELECT A.NAME, B.NAME, E.NAME, DECODE(BITAND(C.FLAGS,65536),0,'NO','YES'),
                               DECODE(BITAND(D.FLAGS,1),0,'NO','YES'),
                               D.START_MONITORING,
                               D.END_MONITORING
  FROM SYS.OBJ$ A, SYS.OBJ$ B, SYS.IND$ C, SYS.USER$ E, SYS.OBJECT_USAGE D
 WHERE C.OBJ# = D.OBJ#
   AND A.OBJ# = D.OBJ#
   AND B.OBJ# = C.BO#
   AND E.USER# = A.OWNER#;
   
SELECT * FROM V$ALL_INDEX_USAGE;

SELECT TABLE_NAME AS "TABLE_NAME" , INDEX_NAME AS "INDEX_NAME"
FROM DBA_INDEXES
WHERE TABLE_NAME ='PPOFESSOR';

ALTER INDEX SCOTT.SYS_ MONITORING USAGE;

CREATE TABLE INX_TEST(NO NUMBER);
 
CREATE INDEX IDX_INXTEST_NO ON INX_TEST(NO);

ANALYZE INDEX IDX_INXTEST_NO VALIDATE STRUCTURE;

SELECT (DEL_LF_ROWS_LEN/LF_ROWS_LEN)+100 AS "BALANCE"
FROM INDEX_STATS 
WHERE NAME='IDX_INXTEST_NO';

DELETE FROM INX_TEST 
WHERE NO BETWEEN 1 AND 4000;

SELECT COUNT(*) AS "COUNT" FROM INX_TEST;

SELECT (DEL_LF_ROWS_LEN/LF_ROWS_LEN)+100 AS "BALANCE" FROM INDEX_STATS WHERE NAME='IDX_INXTEST_NO'; /*0*/
ANALYZE INDEX IDX_INXTEST_NO VALIDATE STRUCTURE;
SELECT (DEL_LF_ROWS_LEN/LF_ROWS_LEN)+100 BALANCE FROM INDEX_STATS WHERE NAME='IDX_INXTEST_NO';/*39.96*/
ALTER INDEX IDX_INXTEST_NO REBUILD;
ANALYZE INDEX IDX_INXTEST_NO VALIDATE STRUCTURE;
SELECT (DEL_LF_ROWS_LEN/LF_ROWS_LEN)+100 BALANCE FROM INDEX_STATS WHERE NAME='IDX_INXTEST_NO'/*0*/;


CREATE INDEX IDX_EMP_SAL ON EMP(SAL);
SELECT TABLE_NAME, INDEX_NAME,VISIBILITY FROM USER_INDEXES WHERE TABLE_NAME ='EMP';
ALTER INDEX IDX_EMP_SAL INVISIBLE;
SELECT TABLE_NAME, INDEX_NAME,VISIBILITY FROM USER_INDEXES WHERE TABLE_NAME ='EMP';

ALTER INDEX IDX_EMP_SAL VISIBLE;
SELECT TABLE_NAME, INDEX_NAME,VISIBILITY FROM USER_INDEXES WHERE TABLE_NAME ='EMP';
SELECT /*+INDEX (EMP IDX_EMP_SAL)*/ ENAME FROM EMP WHERE ENAME >'0';

CREATE TABLE NEW_EMP4(
NO NUMBER,
NAME VARCHAR2(10),
SAL NUMBER);

INSERT INTO NEW_EMP4 VALUES(1000,'SMITH',300);

INSERT INTO NEW_EMP4 VALUES(1002,'KING',430);

INSERT INTO NEW_EMP4 VALUES(1001,'ALLEN',250);

INSERT INTO NEW_EMP4 VALUES(1003,'BLAKE',220);

INSERT INTO NEW_EMP4 VALUES(1004,'JAMES',620);

INSERT INTO NEW_EMP4 VALUES(1005,'MILLER',810);

SELECT *FROM NEW_EMP4;

CREATE INDEX IDX_NEWEMP4_NAME ON NEW_EMP4(NAME);
SELECT NAME FROM NEW_EMP4 WHERE NAME >'0';
SELECT MIN(NAME) FROM NEW_EMP4;
SELECT NAME FROM NEW_EMP4 WHERE NAME >'0' AND ROWNUM=1;
SELECT MAX(NAME) FROM NEW_EMP4;
SELECT  /*+INDEX_DESC(E IDX_NEWEMP4_NAME) */NAME FROM NEW_EMP4 E WHERE NAME >'0' AND ROWNUM=1;
SELECT /*+INDEX_DESC(E IDX_NEWEMP4_NAME) */MAX(NAME) FROM NEW_EMP4 E WHERE NAME >'0';
SELECT ROWID, EMPNO, ENAME FROM EMP WHERE EMPNO=7902;  
   


------------------------ 9�� -------------------------
CREATE TABLE O_TABLE (
    A   NUMBER,
    B   NUMBER);

CREATE VIEW VIEW1
AS
SELECT A,B FROM O_TABLE;

INSERT INTO VIEW1 VALUES(1,2);

SELECT * FROM VIEW1;

SELECT * FROM O_TABLE;

ROLLBACK;

SELECT * FROM VIEW1;

CREATE VIEW VIEW2
AS
SELECT A,B 
FROM O_TABLE
WITH READ ONLY;

INSERT INTO VIEW2 VALUES(3,4);
INSERT INTO VIEW1 VALUES(3,4);

SELECT * FROM VIEW2;

-- WITH CHECK OPTION �׽�Ʈ�ϱ�
INSERT INTO VIEW1 VALUES(5,6);
SELECT * FROM VIEW1;

CREATE VIEW VIEW3
AS
SELECT A,B 
FROM O_TABLE
WHERE A=3
WITH CHECK OPTION;

SELECT * FROM VIEW3;

UPDATE VIEW3 
SET A=5
WHERE B=4;

UPDATE VIEW3 
SET B=6
WHERE A=3;

DELETE FROM VIEW3 
WHERE A=3;


-- ���� VIEW

CREATE OR REPLACE VIEW V_EMP
AS
SELECT E.ENAME, D.DANME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT * FROM V_EMP;

-- �ζ��� VIEW

SELECT E.DEPTNO, D.DNAME, E.SAL
FROM (SELECT DEPTNO, MAX(SAL) SAL
        FROM EMP
      GROUP BY DEPTNO) E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT DEPTNO, MAX(SAL) SAL
FROM EMP
GROUP BY DEPTNO;


SELECT DEPTNO, PROFNOM NAME
FROM PROFESSOR;

-- ��ȸ �� �����ϱ�

SELECT VIEW_NAME, TEXT, READ_ONLY
FROM USER_VIEWS;

DROP VIEW V_EMP;

-- MVIEW ����

CREATE MATERIALIZED VIEW M_PROF
BUILD IMMEDIATE
REFRESH
ON DEMAND
COMPLETE
ENABLE QUERY REWRITE 
AS
SELECT PROFNO, NAME, PAY
FROM PROFESSOR;

-- �信 �ε��� ���� ����
CREATE INDEX IDX_M_PROF_PAY
ON M_PROF(PAY);

-- MVIEW �����ϱ�
DELETE FROM PROFESSOR 
WHERE PROFNO = 5001;

COMMIT;

SELECT COUNT(*) FROM PROFESSOR;
SELECT COUNT(*) FROM M_PROF;

--DBMS_MVIEW
BEGIN DBMS_MVIEW.REFRESH('M_PROF');
END;

--��� MVIEW ����ȭ
--EXEC DBMS_MVIEW.REFRESH_ALL_MVIEWS;

SELECT MVIEW_NAME, QUERY 
FROM USE_MVIEWS
WHERE MVIEW_NAME = 'M_PROF';

DROP MATERIALIZED VIEW M_PROF;


-------------------- �������� --------------------------------------------
-- 1��
CREATE OR VIEW V_PROF_DEPT2
AS
SELECT P.PROFNO, P.NAME, DNAME
FROM PROFESSOR P, DEPARTMENT D
WHERE P.DEPTNO = D.DEPTNO;  


-- 2��
SELECT D.DNAME, S.MAX_HEIGHT, S.MAX_WEIGHT
FROM ( SELECT MAX(HEIGHT) MAX_HEIGHT, MAX(WEIGHT) MAX_WEIGHT, DEPTNO1
       FROM STUDENT
       GROUP BY DEPTNO1 ) S, DEPARTMENT D
WHERE D.DEPTNO = S.DEPTNO1;

-- 3��
SELECT D.DNAME, M.MAX_HEIGHT, S.NAME, S.HEIGHT
FROM ( SELECT DEPTNO1, MAX(HEIGHT) MAX_HEIGHT
       FROM STUDENT
       GROUP BY DEPTNO1 ) M, DEPARTMENT D, STUDENT S
WHERE D.DEPTNO = M.DEPTNO1
AND   D.DEPTNO = S.DEPTNO1
AND   M.MAX_HEIGHT = S.HEIGHT;

-- 4��
SELECT S1.GRADE, S1.NAME, S1.HEIGHT, S2.AVG_HEIGHT
FROM ( SELECT GRADE, AVG(HEIGHT) AVG_HEIGHT
       FROM STUDENT
       GROUP BY GRADE ) S2, STUDENT S1
WHERE S1.GRADE = S2.GRADE
AND   S1.HEIGHT > S2.AVG_HEIGHT
ORDER BY S1.GRADE;

-- 5��
SELECT R.RANKING, P.NAME, P.PAY
FROM ( SELECT PROFNO, RANK() OVER (ORDER BY PAY DESC) RANKING
       FROM PROFESSOR
       WHERE ROWNUM <= 5 ) R, PROFESSOR P
WHERE R.PROFNO = P.PROFNO
ORDER BY RANKING;

-- 6��
SELECT NUM, PROFNO, NAME, PAY, SUM(PAY), ROUND(AVG(PAY),1)
FROM ( SELECT ROWNUM NUM,
              PROFNO,
              NAME,
              PAY
       FROM PROFESSOR )
GROUP BY CEIL(NUM/3), ROLLUP((NUM,PROFNO,NAME,PAY))
ORDER BY CEIL(NUM/3);
