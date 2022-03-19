-------------------------- 5�� ------------------------------------
CREATE TABLE NEW_TABLE (
    NO    NUMBER(3)
  , NAME  VARCHAR2(10)
  , BIRTH DATE
);

CREATE TABLE TT02 (
    NO       NUMBER(3, 1) DEFAULT 0,
    NAME     VARCHAR2(10) DEFAULT 'NO Name',
    HIREDATE DATE DEFAULT SYSDATE
);

INSERT INTO TT02 ( NO ) VALUES ( 1 );

CREATE TABLE �ѱ����̺� (
    �÷�1 NUMBER,
    �÷�2 VARCHAR2(10),
    �÷�3 DATE
);

COMMIT;

CREATE GLOBAL TEMPORARY TABLE TEMP01 (
    NO   NUMBER,
    NAME VARCHAR2(10)
) ON COMMIT DELETE ROWS;

SELECT
    *
FROM
    TEMP01;

SELECT
    TEMPORARY AS "TEMPORARY",
    DURATION AS "DURATION"
FROM
    USER_TABLES
WHERE
    TABLE_NAME = 'TEMP01';

CREATE TABLE DEPT3
    AS
        SELECT
            *
        FROM
            DEPT2;

CREATE TABLE DEPT4
    AS
        SELECT
            DCODE,
            DNAME
        FROM
            DEPT2;

CREATE TABLE DEPT5
    AS
        SELECT
            *
        FROM
            DEPT2
        WHERE
            1 = 2;

CREATE TABLE DEPT6
    AS
        SELECT
            DCODE,
            DNAME
        FROM
            DEPT2
        WHERE
            DCODE IN ( 1000, 1001, 1002 );

SELECT
    *
FROM
    DEPT6;

ALTER TABLE DEPT6 ADD (
    LOC VARCHAR2(10)
);

SELECT
    *
FROM
    DEPT6;

ALTER TABLE DEPT6 ADD (
    LOCATION VARCHAR2(10)
);

SELECT
    *
FROM
    DEPT6;

ALTER TABLE DEPT6 ADD (
    LOCATION2 VARCHAR2(10) DEFAULT 'SEOUL'
);

SELECT
    *
FROM
    DEPT6;

ALTER TABLE DEPT6 RENAME COLUMN LOCATION2 TO LOC;

RENAME DEPT6 TO DEPT7;

DESC DEPT7;

ALTER TABLE DEPT7 MODIFY (
    LOC VARCHAR2(20)
);

DESC DEPT7;

ALTER TABLE DEPT7 DROP COLUMN LOC;

ALTER TABLE DEPT7 DROP COLUMN LOC CASCADE CONSTRAINTS;

TRUNCATE TABLE DEPT7;

SELECT
    *
FROM
    DEPT7;

DROP TABLE DEPT7;

CREATE TABLE T_READONLY (
    NO   NUMBER,
    NAME VARCHAR2(10)
);

INSERT INTO T_READONLY VALUES (
    1,
    'AAA'
);

COMMIT;

SELECT
    *
FROM
    T_READONLY;

ALTER TABLE T_READONLY READ ONLY;

INSERT INTO T_READONLY VALUES (
    2,
    'BBB'
);

ALTER TABLE T_READONLY READ WRITE;

DROP TABLE T_READONLY;

COMMIT;

CREATE TABLE VT1 (
    COL1 NUMBER,
    COL2 NUMBER,
        COL3 NUMBER GENERATED ALWAYS AS ( COL1 + COL2 )
);

INSERT INTO VT1 VALUES (
    1,
    2,
    3
);

INSERT INTO VT1 (
    COL1,
    COL2
) VALUES (
    1,
    2
);

SELECT
    *
FROM
    VT1;

UPDATE VT1
SET
    COL1 = 5;

ALTER TABLE VT1 ADD (
    COL4 GENERATED ALWAYS AS ( ( COL1 * 12 ) + COL2 )
);

SELECT
    *
FROM
    VT1;

SELECT
    COLUMN_NAME AS "COLUMN_NAME",
    DATA_TYPE AS "DATA_TYPE",
    DATA_DEFAULT AS "DATA_DEFAULT"
FROM
    USER_TAB_COLUMNS
WHERE
    TABLE_NAME = 'VT1'
ORDER BY
    COLUMN_ID;


CREATE TABLE SALES10
(
 NO NUMBER,
 PCODE CHAR(4),
 PDATE CHAR(8),
 PQTY NUMBER,
 PBUNGI NUMBER(1)
 GENERATED ALWAYS AS
  (
   CASE
    WHEN SUBSTR(PDATE,5,2) IN ('01','02','03') THEN 1
    WHEN SUBSTR(PDATE,5,2) IN ('04','05','06') THEN 2
    WHEN SUBSTR(PDATE,5,2) IN ('07','08','09') THEN 3
    ELSE 4
   END
  ) VIRTUAL 
);

INSERT INTO SALES10 (NO, PCODE, PDATE, PQTY)
VALUES(1, '100', '20110112', 10);

INSERT INTO SALES10 (NO, PCODE, PDATE, PQTY)
VALUES(2, '200', '20110505', 20);

INSERT INTO SALES10 (NO, PCODE, PDATE, PQTY)
VALUES(3, '300', '20110812', 30);

INSERT INTO SALES10 (NO, PCODE, PDATE, PQTY)
VALUES(4, '400', '20111024', 40);

COMMIT;

SELECT  * FROM SALES10 ;


CREATE TABLE ST_TABLE (
    NO NUMBER
);

BEGIN
    FOR I IN 1..1000 LOOP
        INSERT INTO ST_TABLE VALUES ( I );

    END LOOP;

    COMMIT;
END;
/

SELECT
    COUNT(*)
FROM
    ST_TABLE;
    
SELECT NUM_ROWS
     , BLOCKS
 FROM USER_TABLES
 WHERE TABLE_NAME = 'ST_TABLE';
 
 ANALYZE TABLE ST_TABLE COMPUTE STATISTICS;
 
 SELECT NUM_ROWS AS "NUM_ROWS"
      , BLOCKS AS "BLOCKS"
 FROM USER_TABLES
 WHERE TABLE_NAME='ST_TABLE';

------------------------ �������� ----------------------------------
--1��
CREATE TABLE NEW_EMP (
    NO       NUMBER(5),
    NANE     VARCHAR(20),
    HIREDATE DATE,
    BONUS    NUMBER(6, 2)
);
  
--2��
CREATE TABLE NEW_EMP2
    AS
        SELECT
            NO AS "NO",
            NANE AS "NAME",  
            HIREDATE AS "HIREDATE"
        FROM
            NEW_EMP;
            
--3��
CREATE TABLE NEW_EMP3
    AS
        SELECT
            *
        FROM
            NEW_EMP2
        WHERE
            0 = 1;

--4��
ALTER TABLE NEW_EMP2 ADD (
    BIRTHDAY DATE DEFAULT SYSDATE
);

--5��
ALTER TABLE NEW_EMP2 RENAME COLUMN BIRTHDAY TO BIRTH;

--6��
ALTER TABLE NEW_EMP2 MODIFY (
    NO NUMBER(7)
);

--7��
ALTER TABLE NEW_EMP2 DROP COLUMN BIRTH;

--8��
TRUNCATE TABLE NEW_EMP2;

--9��
DROP TABLE NEW_EMP2;

--10��
-- ������ ��ųʸ��� �����ͺ��̽��� ���� �߿��� �κ� ���� �ϳ��� �����ͺ��̽��� ���õ� ������ ����
-- �⺻ ���̺�� ��ųʸ� ���� �� ���� ���·� ����
-- �⺻ ���̺��� �����ͺ��̽��� ���� ������ ���� �ִ� ���̺�μ� ����Ŭ ������ ����� �� �ְ� �����Ͱ� ����Ǿ� �����Ƿ� ����ڰ� ���� ������ �� ����.
-- ��ųʸ� ��� �⺻ ���̺��� ������ �� �����ϰ� �����ֱ� ���ؼ� �⺻ ���̺��� ����� �����̴�.
-- ������ ��ųʸ� Ư¡ ����ڰ� ���̺��� �����ϰų� �����ϴ� ���� �۾��� �� ��, �����ͺ��̽� ������ ���� �ڵ����� ���ŵǴ� ���̺��̴�.
-- ������ ��ųʸ� �� Ư¡ ����Ŭ�� ������ ��ųʸ��� ������ ����ڰ� ������ �� �ִ� �������� ��ȯ�Ͽ� �����Ѵ�.

------------------------ 6�� --------------------------------------
INSERT INTO DEPT2 VALUES (
    9000,
    'temp_1',
    1006,
    'Temp Area'
);

INSERT INTO DEPT2 VALUES (
    9001,
    'temp_2',
    1006,
    'Temp Area'
);

INSERT INTO DEPT2 (
    DCODE,
    DNAME,
    PDEPT
) VALUES (
    9002,
    'temp_3',
    1006
);

INSERT INTO PROFESSOR (
    PROFNO,
    NAME,
    ID,
    POSITION,
    PAY,
    HIREDATE
) VALUES (
    5001,
    'James Bond',
    'Love_me',
    'a full professor',
    500,
    '2014-10-23'
);

ALTER SESSION SET NLS_DATE_FORMAT='RRRR-MM-DD:HH24:MI:SS';
    
    
INSERT INTO PROFESSOR(PROFNO, NAME, ID, POSITION, PAY, HIREDATE)
VALUES(5001, 'James Bond', 'Love_me', 'a full professor', 500, '2014-10-23');


CREATE TABLE T_MINUS (
    NO1 NUMBER,
    NO2 NUMBER(3),
    NO3 NUMBER(3, 2)
);

INSERT INTO T_MINUS VALUES (
    1,
    1,
    1
);

INSERT INTO T_MINUS VALUES (
    1.1,
    1.1,
    1.1
);

INSERT INTO T_MINUS VALUES (
    - 1.1,
    - 1.1,
    - 1.1
);

SELECT
    *
FROM
    T_MINUS;

CREATE TABLE PROFESSOR3
    AS
        SELECT
            *
        FROM
            PROFESSOR
        WHERE
            1 = 2;

SELECT
    *
FROM
    PROFESSOR3;

INSERT INTO PROFESSOR3
    SELECT
        *
    FROM
        PROFESSOR;

CREATE TABLE PROFESSOR4
AS
  SELECT PROFNO, NAME, PAY
  FROM PROFESSOR
  WHERE 1 = 2 ;

INSERT INTO PROFESSOR4
SELECT PROFNO, NAME, PAY
FROM PROFESSOR
WHERE PROFNO > 4000 ;


CREATE TABLE PROF_3 (
    PROFNO NUMBER,
    NAME   VARCHAR2(25)
);

CREATE TABLE PROF_4 (
    PROFNO NUMBER,
    NAME   VARCHAR2(25)
);

INSERT
    ALL WHEN PROFNO BETWEEN 1000 AND 1999 THEN
        INTO PROF_3
        VALUES (
            PROFNO,
            NAME
        )
        WHEN PROFNO BETWEEN 2000 AND 2999 THEN
            INTO PROF_4
            VALUES (
                PROFNO,
                NAME
            )
SELECT
    PROFNO,
    NAME
FROM
    PROFESSOR;

SELECT
    *
FROM
    PROF_3;

SELECT
    *
FROM
    PROF_4;

TRUNCATE TABLE PROF_3;

TRUNCATE TABLE PROF_4;

INSERT ALL INTO PROF_3 VALUES (
    PROFNO,
    NAME
) INTO PROF_4 VALUES (
    PROFNO,
    NAME
) SELECT
      PROFNO,
      NAME
  FROM
      PROFESSOR
  WHERE
      PROFNO BETWEEN 3000 AND 3999;

UPDATE PROFESSOR
SET
    BONUS = 200
WHERE
    POSITION = 'assistant professor';

UPDATE PROFESSOR
SET
    PAY = PAY * 1.15
WHERE
        POSITION = (
            SELECT
                POSITION
            FROM
                PROFESSOR
            WHERE
                NAME = 'Sharon Stone'
        )
    AND PAY < 250;

DELETE FROM DEPT2
WHERE
        DCODE >= 9000
    AND DCODE <= 9999;

SELECT
    *
FROM
    DEPT2;

CREATE TABLE CHARGE_01 (
    U_DATE  VARCHAR2(6),
    CUST_NO NUMBER,
    U_TIME  NUMBER,
    CHARGE  NUMBER
);

CREATE TABLE CHARGE_02 (
    U_DATE  VARCHAR2(6),
    CUST_NO NUMBER,
    U_TIME  NUMBER,
    CHARGE  NUMBER
);

INSERT INTO CHARGE_01 VALUES (
    '141001',
    1000,
    2,
    1000
);

INSERT INTO CHARGE_01 VALUES (
    '141001',
    1001,
    2,
    1000
);

INSERT INTO CHARGE_01 VALUES (
    '141001',
    1002,
    1,
    500
);

INSERT INTO CHARGE_02 VALUES (
    '141002',
    1000,
    3,
    1500
);

INSERT INTO CHARGE_02 VALUES (
    '141002',
    1001,
    4,
    2000
);

INSERT INTO CHARGE_02 VALUES (
    '141002',
    1003,
    2,
    500
);

CREATE TABLE CH_TOTAL (
    U_DATE  VARCHAR2(6),
    CUST_NO NUMBER,
    U_TIME  NUMBER,
    CHARGE  NUMBER
);

MERGE INTO CH_TOTAL TOTAL
USING CHARGE_01 CH01 ON ( TOTAL.U_DATE = CH01.U_DATE )
WHEN MATCHED THEN UPDATE
SET TOTAL.CUST_NO = CH01.CUST_NO
WHEN NOT MATCHED THEN
INSERT
VALUES
    ( CH01.U_DATE,
      CH01.CUST_NO,
      CH01.U_TIME,
      CH01.CHARGE );

MERGE INTO CH_TOTAL TOTAL
USING CHARGE_02 CH02 ON ( TOTAL.U_DATE = CH02.U_DATE )
WHEN MATCHED THEN UPDATE
SET TOTAL.CUST_NO = CH02.CUST_NO
WHEN NOT MATCHED THEN
INSERT
VALUES
    ( CH02.U_DATE,
      CH02.CUST_NO,
      CH02.U_TIME,
      CH02.CHARGE );

SELECT * FROM CH_TOTAL;

UPDATE EMP
SET
    SAL = ( SAL + SAL * 0.1 )
WHERE
    JOB = 'CLERK';

UPDATE EMP E
SET
    SAL = ( SAL + SAL * 0.1 )
WHERE
    EXISTS (
        SELECT
            1
        FROM
            DEPT D
        WHERE
                D.LOC = 'DALLAS'
            AND E.DEPTNO = D.DEPTNO
    );

CREATE TABLE DEPT_HIST (    -- �μ��߷��̷�
    EMPNO        NUMBER(4), -- �����ȣ PK1
    APPOINTSEQNO NUMBER(4), -- �߷ɼ��� PK2
    DEPTNO       NUMBER(2), -- �μ���ȣ
    APPOINTDD    DATE       -- �߷�����
);

INSERT INTO DEPT_HIST
    SELECT
        EMPNO,
        1       APPOINTSEQNO,
        99      DEPTNO,
        SYSDATE APPOINTDD
    FROM
        EMP
    WHERE
        DEPTNO = 20;

COMMIT;

INSERT INTO DEPT_HIST VALUES (
    9322,
    1,
    99,
    SYSDATE
);

INSERT INTO DEPT_HIST VALUES (
    9414,
    1,
    99,
    SYSDATE
);

COMMIT;

UPDATE DEPT_HIST D
SET
    D.DEPTNO = (
        SELECT
            E.DEPTNO
        FROM
            EMP E
        WHERE
            E.EMPNO = D.EMPNO
    );

SELECT * FROM DEPT_HIST;

UPDATE DEPT_HIST D
SET D.DEPTNO = (
                 SELECT E.DEPTNO FROM EMP E
                 WHERE E.EMPNO = D.EMPNO
               )
WHERE
EXISTS
  (
    SELECT 1 FROM EMP E
    WHERE E.EMPNO = D.EMPNO
  )
;

SELECT * FROM DEPT_HIST;

MERGE INTO DEPT_HIST D
USING EMP E
ON
(
  E.EMPNO = D.EMPNO
)
WHEN MATCHED THEN
 UPDATE SET D.DEPTNO = E.DEPTNO
;

COMMIT;

SELECT * FROM DEPT_HIST;

------------------------ �������� -------------------------------
--1��
INSERT INTO DEPT2 VALUES (
    9010,
    'temp_10',
    1006,
    'temp area'
);

--2��
INSERT INTO DEPT2 (
    DCODE,
    DNAME,
    PDEPT
) VALUES (
    9020,
    'temp_20',
    1006
);

--3��
INSERT INTO PROFESSOR4
    SELECT
        PROFNO,
        NAME,
        PAY
    FROM
        PROFESSOR
    WHERE
        PROFNO <= 3000;

--4��
UPDATE PROFESSOR
SET
    BONUS = 100
WHERE
    NAME = 'Sharon Stone';

