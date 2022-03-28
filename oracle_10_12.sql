------------------------ 10장 ------------------------- 
SELECT ENAME, COMM
  COMM EMP
 EMP COMM < ( SELECT COMM
                  COMM EMP
                 EMP ENAME = 'WARD' );
                 
-- 단일행 서브쿼리 연습문제 1 
SELECT S.NAME STUDE_NAME, D.DNAME DEPT_NAME
  FROM STUDENT S, DEPARTMENT D
 WHERE S.DEPTNO1 = ( SELECT DEPTNO1
                       FROM STUDENT
                      WHERE NAME = 'Anthony Hopkins')
   AND S.DEPTNO1 = D.DEPTNO;
   
-- 단일행 서브쿼리 연습문제 2 
SELECT P.NAME PROF_NAME, P.HIREDATE, D.DNAME DEPT_NAME
  FROM PROFESSOR P, DEPARTMENT D
 WHERE P.DEPTNO = D.DEPTNO
   AND P.HIREDATE > ( SELECT HIREDATE
                        FROM PROFESSOR
                       WHERE NAME = 'Meg Ryan');
                       
-- 단일행 서브쿼리 연습문제 3 
SELECT S.NAME, S.WEIGHT
  FROM STUDENT S
 WHERE S.WEIGHT > ( SELECT AVG(WEIGHT)
                      FROM STUDENT
                     WHERE DEPTNO1 = 201); 
                    
SELECT EMPNO, NAME, DEPTNO
  FROM EMP2
 WHERE DEPTNO IN ( SELECT DCODE
                     FROM DEPT2
                    WHERE AREA = 'Pohang Main Office' );

SELECT *
  FROM DEPT
 WHERE EXISTS ( SELECT DEPTNO
                  FROM DEPT
                 WHERE DEPTNO = &DNO );
                 
SELECT *
  FROM DEPT
 WHERE DEPTNO IN ( SELECT DEPTNO
                     FROM DEPT
                    WHERE DEPTNO = &DNO );
                    
-- 다중행 서브쿼리 연습문제 1 --
SELECT NAME, POSITION, TO_CHAR(PAY, '$999,999,999') SALARY
  FROM EMP2
 WHERE PAY > ANY ( SELECT PAY
                     FROM EMP2
                    WHERE POSITION = 'Section head' );
                    
-- 다중행 서브쿼리 연습문제 2 --
SELECT NAME, GRADE, WEIGHT
  FROM STUDENT
 WHERE WEIGHT < ALL ( SELECT WEIGHT
                        FROM STUDENT
                       WHERE GRADE = 2 );
                       
-- 다중행 서브쿼리 연습문제 3 --
SELECT D.DNAME, E.NAME, TO_CHAR(E.PAY, '$999,999,999') SALARY
  FROM DEPT2 D, EMP2 E
 WHERE D.DCODE = E.DEPTNO
   AND E.PAY < ALL ( SELECT AVG(PAY)
                       FROM EMP2 
                   GROUP BY DEPTNO )
ORDER BY SALARY;

SELECT GRADE, NAME, WEIGHT
  FROM STUDENT
 WHERE ( GRADE, WEIGHT ) IN ( SELECT GRADE, MAX(WEIGHT)
                                FROM STUDENT
                            GROUP BY GRADE )
ORDER BY 1;

-- 다중컬럼 서브쿼리 연습문제 1 --
SELECT P.PROFNO, P.NAME PROF_NAME, P.HIREDATE, D.DNAME DEPT_NAME
  FROM PROFESSOR P, DEPARTMENT D
 WHERE P.DEPTNO = D.DEPTNO
   AND ( P.DEPTNO, P.HIREDATE ) IN ( SELECT DEPTNO, MIN(HIREDATE)
                                       FROM PROFESSOR
                                   GROUP BY DEPTNO )
ORDER BY P.HIREDATE;

-- 다중컬럼 서브쿼리 연습문제 2 
SELECT NAME, POSITION, TO_CHAR(PAY, '$999,999,999') SALARY
  FROM EMP2
 WHERE (POSITION, PAY) IN ( SELECT POSITION, MAX(PAY)
                              FROM EMP2
                          GROUP BY POSITION )
ORDER BY 3 ASC;

SELECT NAME, POSITION, TO_CHAR(PAY, '$999,999,999') SALARY
 FROM EMP2 A
WHERE PAY >= ( SELECT AVG(PAY)
                 FROM EMP2 B
                WHERE A.POSITION = B.POSITION );
                
SELECT NAME,
       ( SELECT DNAME
           FROM DEPT2 D
          WHERE E.DEPTNO = D.DCODE ) DNAME
FROM EMP2 E;

SELECT NAME, D.NAME AS "DNAME"
FROM EMP2 E LEFT OUTER JOIN DEPT2 D ON (E.DEPTNO=D.DCODE);

SELECT NAME, D.NAME AS "DNAME"
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE(+);


CREATE TABLE T3 
(  NO       NUMBER,
   NAME     VARCHAR(10),
   DEPTNO   NUMBER  );

CREATE TABLE T4 
(  DEPTNO       NUMBER,
   DNAME     VARCHAR(10)  );
   
INSERT INTO T3
VALUES (1,'AAA',100);

INSERT INTO T3
VALUES (2,'BBB',200);

INSERT INTO T3
VALUES (3,'CCC',300);

COMMIT;

INSERT INTO T4
VALUES (100, 'DDD');

INSERT INTO T4
VALUES (100, 'EEE');

INSERT INTO T4
VALUES (200, 'FFF');

INSERT INTO T4
VALUES (300, 'GGG');

COMMIT;

SELECT T3.NO, T3.NAME, ( SELECT DNAME
                           FROM T4
                          WHERE T3.DEPTNO = T4.DEPTNO )
                          
FROM T3;

SELECT *
  FROM T4;
  
UPDATE T4
   SET DEPTNO = 400
 WHERE DNAME = 'DDD';
 
COMMIT;

SELECT T3.NO, T3.NAME, ( SELECT DNAME
                           FROM T4
                          WHERE T3.DEPTNO = T4.DEPTNO ) DNAME
                          
FROM T3;

SELECT T3.NO, T3.NAME, ( SELECT DNAME, DEPTNO
                           FROM T4
                          WHERE T3.DEPTNO = T4.DEPTNO)
FROM T3;

SELECT T3.NO, T3.NAME, ( SELECT DEPTNO
                           FROM T4
                          WHERE T3.DEPTNO = T4.DEPTNO) DEPTNO
FROM T3;

CREATE TABLE WITH_TEST1(
NO NUMBER,
NAME VARCHAR(10),
PAY NUMBER(6) )
TABLESPACE USERS;

BEGIN
FOR I IN 1..50000000 LOOP
  INSERT INTO WITH_TEST1
  VALUES(I, DBMS_RANDOM.STRING('A',5),
         DBMS_RANDOM.VALUE(6,999999));
 END LOOP;
 COMMIT;
 END;
  
SELECT COUNT(*) FROM WITH_TEST1;

SELECT * FROM WITH_TEST1;

SELECT MAX(PAY)-MIN(PAY)
FROM WITH_TEST1;

CREATE INDEX IDX_WITH_PAY ON WITH_TEST1(PAY);
SELECT MAX(PAY)-MIN(PAY)
FROM WITH_TEST1;

WITH A AS( 
    SELECT /*+index_desc(w idx_with_pay) */ PAY
    FROM WITH_TEST1 W
    WHERE PAY>0
    AND ROWNUM =1),
B AS ( 
    SELECT /*+index_desc(w idx_with_pay) */ PAY
    FROM WITH_TEST1 W
    WHERE PAY>0
    AND ROWNUM = 1)
SELECT A.PAY-B.PAY
FROM A,B;

CREATE INDEX IDX_WITH_NO ON WITH_TEST1(NO);

SELECT COUNT(*) FROM WITH_TEST1
WHERE PAY <ALL(SELECT /*+ index (w idx_with_no) */ PAY
               FROM WITH_TEST1 W
               WHERE NO BETWEEN 120000 AND 130000);

WITH T AS (
    SELECT /*+ index(w ix_with_pay ) */ MIN(PAY) MIN_PAY
    FROM WITH_TEST1 W
    WHERE PAY >0
    AND NO BETWEEN 120000 AND 130000
    AND ROWNUM=1)
SELECT COUNT(*)
FROM WITH_TEST1 W, T
WHERE W.PAY < T.MIN_PAY;

DROP INDEX IDX_WITH_PAY;

SELECT 'MAX PAY' C1, MAX(PAY) MAX_PAY FROM WITH_TEST1
UNION ALL
SELECT 'MIN PAY' C1, MIN(PAY) MIN_PAY FROM WITH_TEST1
UNION ALL
SELECT 'MAX PAY - MIN PAY' C1, (MAX(PAY)-MIN(PAY)) DIFF_PAY FROM WITH_TEST1;

WITH SUB_PAY AS
(
    SELECT MAX(PAY) MAX_PAY, MIN(PAY) MIN_PAY
    FROM WITH_TEST1
)
SELECT 'MAX PAY' C1, MAX_PAY FROM SUB_PAY
UNION ALL
SELECT 'MIN PAY' C1, MIN_PAY FROM SUB_PAY
UNION ALL
SELECT 'MAX PAY - MIN PAY' C1, (MAX_PAY-MIN_PAY) DIFF_PAY FROM SUB_PAY;

SELECT * FROM TAB1 WHERE C1 IN (SELECT C1 FROM T2);

SELECT * FROM T1 WHERE EXISTS (SELECT 1 FROM T2 WHERE T2.C1 = T1.C1)

SELECT *
FROM T1, (SELECT DISTINCT C1 FROM T2 ) T2
WHERE T1.C1 = T2.C1;
  
SELECT COUNT(*) FROM CUST_T A
WHERE EXISTS (SELECT 1 FROM ORDER_T B WHERE A.CUST_NO = B.CUST_NO)

SELECT COUNT(*) FROM CUST_T
WHERE CUST_NO IN (SELECT CUST_NO FROM ORDER T)

CREATE TABLE CUST_T
(
 CUST_NO VARCHAR2(1000),
 CUST_NM VARCHAR2(1000)
);

INSERT INTO CUST_T
SELECT LEVEL, 'NM'||TO_CHAR(LEVEL, '000') FROM DUAL CONNECT BY LEVEL <= 1000;
 
CREATE TABLE ORDER_T
(
ORDER_NO VARCHAR2(4000),
CUST_NO VARCHAR2(1000),
ORDERDD VARCHAR2(8),
PRODUCT_NM VARCHAR2(4000)
);

INSERT /*+append*/INTO ORDER_TSLECT LEVEL ORDER_NO, MOD(LEVEL, 500) CUST_NO, TO_CHAR(SYSDATE-MOD(LEVEL,30),'YYYYMMDD')OORDERDD,
'TEST PRODUCT LONG NAME ' FROM  DUAL CONNECT BY LEVEL <=1000000;
COMMIT;

EXEC DBMS_STATS.GATHER_TABLE_STATS(    OWNNAME -> 'SCOTT',   TABNAME => 'CUST_T', CASCADE => TRUE, NO_INVALIDATE => FALSE);
EXEC DBMS_STATS.GATHER_TABLE_STATS(    OWNNAME -> 'SCOTT',   TABNAME => 'ORDER_T', CASCADE => TRUE, NO_INVALIDATE => FALSE);

SELECT TABLE_NAME, NUM_ROWS, BLOCKS, AVG_ROW_LEN, SAMPLE_SIZE
FROM USER_TABLES
WHERE TABLE_NAME IN ('ORDER_T', 'CUST_T');

CREATE INDEX IX_ORDER_T_01 ON ORDER_T (CUST_NO);

SELECT COUNT(*)
FROM CUST_T A
WHERE EXISTS
    (SELECT 1 FROM ORDER_T B WHERE A.CUST_NO=B.CUST_NO);
    
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

DROP INDEX IX_ORDER_T_01;

CREATE INDEX IX_UCST_T_01 ON CUST_T (CUST_NO);

SELECT COUNT(*) AS "COUNT"
FROM CUST_T A
WHERE EXISTS (SELECT 1 FROM ORDER_T B WHERE A.CUST_NO = B.CUST_NO);

SELECT COUNT(*)
FROM CUST_T
WHERE EXISTS (SELECT 1 FROM ORDER_T B WHERE A.CUST_NO = B.CUST_NO);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT COUNT(*)
FROM CUST_T
WHERE EXISTS (SELECT 1 FROM ORDER_T B WHERE A.CUST_NO = B.CUST_NO);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

DROP INDEX IX_ORDER_T_01;
CREATE INDEX IX_CUST_T_01 ON CUST_T(CUST_NO);

EXPLAIN PLAN FOR
SELECT /*+ leading(order_t) use_nl(order_t cust_t) */
      COUNT(*)
FROM CUST_T
WHERE CUST_NO IN (SELECT CUST_NO FROM ORDER_T);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

INSERT INTO EMP2(EMPNO, NAME, BIRTHDAY, DEPTNO, EMP_TYPE, TEL) VALUES
        (2020000219, 'RAY', TO_DATE('1988/03/22','YYYY/MM/DD'), '999','INTERN','02)909-2345');
        
SELECT NAME, (SELECT NVL(DNAME, '## NOT BELOG TO A DEPT..')
FROM DEPT2 D
WHERE E.DEPTNO=D.DCODE) "DNAME"
FROM EMP2 E;

SELECT NAME, NVL((SELECT DNAME
                FROM DEPT2 D
                WHERE E.DEPTNO = D.DCODE
                ), '## NOT BELOG TO A DEPT..') "DNAME"
FROM EMP2 E;

EXPLAIN PLAN FOR
SELECT CUST_NO,
    NVL(
    (SELECT MAX(OPRDERDD)
FROM ORDER_T C
        WHERE C.CUST_NO = A.CUST_NO
        _, '99991231') LAST_ORDER_DD
FROM CUST_T A;

SELECT *FROM TABLE(DBMS_XPLAN.DISPALY);

 
-- 11장  
CREATE SEQUENCE JNO_SEQ
INCREMENT BY 1
start with 100
MAXVALUE 110
MINVALUE 90
CYCLE
CACHE 2;

CREATE TABLE S_ORDER
(ORD_NO      NUMBER(4)
 ORD_NAME  VARCHAR2(10),
 P_NAME     VARCHAR2(20),
 P_QTY       NUMBER);

INSERT INTO S_ORDER
VALUES(JNO_SEQ.NEXTVAL, 'JAMES','APPLE',5);

INSERT INTO S_ORDER
VALUES(JNO_SEQ.NEXTVAL, 'FORD','BERRY',3);

SELECT * FROM S_ORDER;

SELECT JNO_SEQ.CURRVAL FROM DUAL;

BEGIN
FOR I IN 1..9 LOOP
  INSERT INTO S_ORDER VALUES(JNO_SEQ.NEXTVAL, 'ALLEN','BANANA', 5);
  END LOOP;
 COMMIT;
END;
 


INSERT INTO S_ORDER VALUES(JNO_SEQ.NEXTVAL, 'SMITH', 'GRAPE',3);

SELECT * FROM S_ORDER;

CREATE SEQUENCE JNO_SEQ_REV
INCREMENT BY -2
MINVALUE 0
MAXVALUE 20
start with 10;

CREATE TABLE S_REV1 (NO NUMBER);

INSERT INTO S_REV1 VALUES(JNO_SEQ_REV.NEXTVAL);

CREATE OR REPLACE PROCEDURE RE_SEQ
(
 SNAME IN VARCHAR2
)
IS
 VAL NUMBER;
 
BEGIN
 EXECUTE IMMEDIATE 'SELECT ' || SNAME || '.NEXTVAL FROM DUAL' INTO VAL;
 EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || SNAME || ' INCREMENT BY -' || VAL ||' MINVALUE 0';
 EXECUTE IMMEDIATE 'SELECT ' || SNAME || '.NEXTVAL FROM DUAL ' INTO VAL;
 EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || SNAME || ' INCREMENT BY 1 MINVALUE 0';
END;
 
CREATE SEQUENCE SEQ_TEST;
SELECT SEQ_TEST.NEXTVAL FROM DUAL;

EXEC RE_SEQ('SEQ_TEST');

SELECT SEQ_TEST.CURRVAL FROM DUAL;
COL NAME FOR 15;
SELECT SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY,
        CYCLE_FLAG, ORDER_FLAG, CACHE_SIZE, LAST_NUMBER
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='JNO_SEQ';

ALTER SEQUENCE JNO_SEQ
MAXVALUE 120
CACHE 10;

DROP SEQUENCE JNO_SEQ;

GRANT CREATE SYNONYM TO SCOTT;
GRANT CREATE PUBLIC SYNONYM TO SCOTT;

CONN SCOTT/TIGER

CREATE SYNONYM E FOR EMP;
CREATE PUBLIC SYNONYM D2 FOR DEPT;

SELECET SYNONYM_NAME, TABLE_OWNER, TABLE_NAME
FROM USER_SYNONYMS
WHERE TABLE_NAME='EMP';

CONN / AS SYSDBA;

SELECET SYNONYM_NAME, TABLE_OWNER, TABLE_NAME
FROM DBA_SYNONYMS
WHERE TABLE_NAME = 'DEPT';
 
COL ENAME FOR A20
SELECT LPAD(ENAME, LEVEL*4, '*') "ENAME"
FROM EMP
CONNECT BY PRIOR EMPNO = MGR
START WITH EMPNO = 7839;

SELECT LPAD(ENAME, LEVEL*4, '*') "ENAME"
FROM EMP
CONNECT BY PRIOR EMPNO = MGR
START WITH EMPNO = 7839;

SELECT LPAD(ENAME, LEVEL*5,'-') ENAME
FROM EMP
CONNECT BY EMPNO = PRIOR MGR
START WITH EMPNO=7369;

SELECT EMPNO, ENAME, JOB, MGR
       , PRIOR ENAME AS MGR_NAME
       , LEVEL
       , LPAD(' ', (LEVEL-1)*2,' ') || ENAME AS DEPTH_ENAME
       , SYS_CONNECT_BY_PATH(ENAME,'-') AS ENAME_LIST
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO=MGR
ORDER SIBLINGS BY EMPNO;

SELECT EMPNO, JOB, MGR, LEVEL LV, LPAD(' ', (LEVEL-1)*2, ' ') || ENAME AS DEPTH_ENAME, SYS_CONNECT_BY_PATH(ENAME, '-') AS ENAMELIST
FROM SCOTT.EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO=MGR
AND ENAME <> 'JONES'
ORDER SIBLINGS BY ENAME;

SELECT EMPNO, JOB, MGR, LEVEL LV, LPAD(' ', (LEVEL-1)*2, ' ') || ENAME AS DEPTH_ENAME, SYS_CONNECT_BY_PATH(ENAME, '-') AS ENAMELIST
FROM EMP
WHERE ENAME <> 'JONES'
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO=MGR
ORDER SIBLINGS BY ENAME;

SELECT LPAD(ENAME, LEVEL*5, '*') ENAME
        ,SYS_CONNECT_BY_PATH(PATH, '->') "order(low->high)"
FROM EMP
START WITH EMPNO=7369
CONNECT BY EMPNO=PRIOR MGR;

SELECT LPAD(ENAME, LEVEL*5, '*') ENAME
        ,SYS_CONNECT_BY_PATH(PATH, '->') "order(low->high)"
FROM EMP
WHERE CONNECT_BY_ISLEAF=0
START WITH EMPNO=7369
CONNECT BY EMPNO=PRIOR MGR;

SELECT LPAD(ENAME, LEVEL*5, '*') ENAME
        ,SYS_CONNECT_BY_PATH(PATH, '->') "order(low->high)"
FROM EMP
WHERE CONNECT_BY_ISLEAF=1
START WITH EMPNO=7369
CONNECT BY EMPNO=PRIOR MGR;

SELECT EMPNO, ENAME, CONNECT_BY_ROOT EMPNO "Root EMPNO",
         SYS_CONNECT_BY_PATH(NAME, '<-') "ROOT <- LEAF"
FROM EMP
WHERE LEVEL>1
AND EMPNO=7369
CONNECT BY PRIOR EMPNO=MGR;

SELECT EMPNO, ENAME, CONNECT_BY_ROOT EMPNO "Root EMPNO",
         SYS_CONNECT_BY_PATH(NAME, '<-') "ROOT <- LEAF"
FROM EMP
WHERE LEVEL=1
AND EMPNO=7369
CONNECT BY PRIOR EMPNO=MGR;

SELECT EMPNO, ENAME, CONNECT_BY_ROOT EMPNO "Root EMPNO",
         SYS_CONNECT_BY_PATH(NAME, '<-') "ROOT <- LEAF"
FROM EMP
WHERE LEVEL=2
AND EMPNO=7369
CONNECT BY PRIOR EMPNO=MGR;

SELECT EMPNO, ENAME, CONNECT_BY_ROOT EMPNO "Root EMPNO",
         SYS_CONNECT_BY_PATH(NAME, '<-') "ROOT <- LEAF"
FROM EMP
WHERE LEVEL=3
AND EMPNO=7369
CONNECT BY PRIOR EMPNO=MGR;
 
SELECT LPAD(E.NAME||'-'||D.DNAME||'-'||NVL(E.POSITION, 'TEAM WORKER'), LEVEL*27, '-') "NAME AND POSITION"
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
START WITH PEMPNO IS NULL
CONNECT BY PRIOR E.EMPNO = E.PEMPNO
ORDER SIBLINGS BY E.NAME;
 
SELECT LPAD(E.NAME||'-'||D.DNAME||'-'||NVL(E.POSITION, 'TEAM WORKER'), LEVEL*48, '-') "Name And Position"
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
CONNECT BY PRIOR E.EMPNO = E.PEMPNO
START WITH E.EMPNO = 19966102;
 
SELECT LPAD(E.NAME||'-'||D.DNAME||'-'||NVL(E.POSITION, 'TEAM WORKER'), LEVEL*37, '-') "Name And Position"
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
CONNECT BY E.EMPNO = PRIOR E.PEMPNO
START WITH E.EMPNO = 20000334;
 
SELECT E.NAME, PRIOR E.NAME MGR_NAME
FROM   EMP2 E
START WITH E.PEMPNO IS NULL
CONNECT BY PRIOR E.EMPNO = E.PEMPNO
ORDER SIBLINGS BY E.EMPNO;
 
SELECT E.EMPNO, E.NAME||'-'||D.DNAME||'-'||NVL(E.POSITION, 'TEAM WORKER') "ENAME AND POSITION",
       ( SELECT COUNT(*)
           FROM EMP2
         START WITH EMPNO = E.EMPNO
         CONNECT BY PRIOR EMPNO = PEMPNO
       )-1 "COUNT"
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
ORDER BY 3 DESC;
 
SELECT LPAD(E.NAME||' '||D.DNAME||' '||NVL(E.POSITION, 'TEAM WORKER'), LEVEL*48, '-') "ENAME AND POSITION"
     , SYS_CONNECT_BY_PATH(E.NAME, '-') PATH
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
START WITH E.EMPNO = 19966102
CONNECT BY PRIOR E.EMPNO = E.PEMPNO;

SELECT D.DNAME "학과이름", S.MAX_HEIGHT "최대키", ST.NAME "학생이름",
ST.HEIGHT "키"
FROM ( SELECT DEPTNO1, MAX(HEIGHT) MAX_HEIGHT
        FROM STUDENT
        GROUP BY DEPTNO1 ) S, DEPARTMENT D, STUDENT ST
WHERE D.DEPTNO=S.DEPTNO1
AND S.MAX_HEIGHT=ST.HEIGHT
AND S.DEPTNO1=ST.DEPTNO1

SELECT S.GRADE "학년", ST.NAME"이름", ST.HEIGHT "키", S.AVG_HEIGHT "평균키"
FROM (SELECT GRADE, AVG(HEIGHT) AVG_HEIGHT
        FROM STUDENT
        GROUP BY GRADE)S, STUDENT ST
WHERE S.GRADE=ST.GRADE
AND S.AVG_HEIGHT < ST.HEIGHT
ORDER BY S.GRADE

SELECT  ROWNUM "급여순위" ,NAME "이름", PAY "급여"
FROM (SELECT NAME, PAY
        FROM PROFESSOR
        ORDER BY PAY DESC)
WHERE ROWNUM BETWEEN 1 AND 5



 ORDER_T B WHERE A.CUST_NO=B.CUST_NO);
    
SELECT *FROM TABLE(DBMS_XPLAN.DISPLAY);

DROP INDEX IX_ORDER_T_01;
CREATE INDEX IX_UCST_T_01 ON CUST_T (CUST_NO);

SELECT /*+ leading(order_t) use_nl(order_t cust_t) */
      COUNT(*)
FROM CUST_T
WHERE CUST_NO IN (SELECT CUST_NO FROM ORDER_T);

EXPLAIN PLAN FOR
SELECT /*+ leading(order_t) use_nl(order_t cust_t) */
      COUNT(*)
FROM CUST_T
WHERE CUST_NO IN (SELECT CUST_NO FROM ORDER_T);

SELECT *FROM TABLE(DBMS_XPLAN.DISPLAY);

INSERT INTO EMP2(EMPNO, NAME, BIRTHDAY, DEPTNO, EMP_TYPE, TEL) VALUES
        (2020000219, 'RAY', TO_DATE('1988/03/22','YYYY/MM/DD'), '999','INTERN','02)909-2345');
        
SELECT NAME, (SELECT NVL(DNAME, '## NOT BELOG TO A DEPT..')
FROM DEPT2 D
WHERE E.DEPTNO=D.DCODE) "DNAME"
FROM EMP2 E;

SELECT NAME, NVL((SELECT DNAME
                FROM DEPT2 D
                WHERE E.DEPTNO = D.DCODE
                ), '## NOT BELOG TO A DEPT..') "DNAME"
FROM EMP2 E;

EXPLAIN PLAN FOR
TEAM WORKER,
    NVL(
    (SELECT MAX(TEAM)
FROM ORDER_T C
        WHERE C.CUST_NO = WORKER.CUST_NO
        _, '99991231') LAST_ORDER_DD
TEAM WORKER A;

SELECT *WORKER TABLE(DBMS_XPLAN.DISPALY);

 
 11장  
CREATE SEQUENCE JNO_SEQ
INCREMENT BY 1
start with 100
MAXVALUE 110
MINVALUE 90
CYCLE
CACHE 2;

CREATE TABLE S_ORDER
(ORD_NO      NUMBER(4)
 ORD_NAME  VARCHAR2(10),
 P_NAME     VARCHAR2(20),
 P_QTY       NUMBER);

INSERT INTO S_ORDER
VALUES(JNO_SEQ.NEXTVAL, 'JAMES','APPLE',5);

INSERT INTO S_ORDER
VALUES(JNO_SEQ.NEXTVAL,'FORD','BERRY',3);

SELECT *FROM S_ORDER;
SELECT JNO_SEQ.CURRVAL FROM DUAL;

BEGIN
FOR I IN 1..9 LOOP
  INSERT INTO S_ORDER VALUES(JNO_SEQ.NEXTVAL, 'ALLEN','BANANA', 5);
  END LOOP;
 COMMIT;
END;
 

SELECT *FROM S_ORDER;

INSERT INTO S_ORDER VALUES(JNO_SEQ.NEXTVAL, 'SMITH', 'GRAPE',3);

CREATE SEQUENCE JNO_SEQ_REV
INCREMENT BY -2
MINVALUE 0
MAXVALUE 20
start with 10;

CREATE TABLE S_REV1 (NO NUMBER);
INSERT INTO S_REV1 VALUES(JNO_SEQ_REV.NEXTVAL);

CREATE OR REPLACE PROCEDURE RE_SEQ
(
 SNAME IN VARCHAR2
)
IS
 VAL NUMBER;
BEGIN
 EXECUTE IMMEDIATE 'SELECT ' || SNAME || '.NEXTVAL FROM DUAL 'INTO VAL;
 EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || SNAME || ' INCREMENT BY -' || VAL ||' MINVALUE 0;
 EXECUTE IMMEDIATE 'SELECT ' || SNAME || '.NEXTVAL FROM DUAL ' INTO VAL;
 EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || SNAME || ' INCREMENT BY 1 MINVALUE 0';
END;
 
CREATE SEQUENCE SEQ_TEST;
SELECT SEQ_TEST.NEXTVAL FROM DUAL;

EXEC RE_SEQ('SEQ_TEST');

SELECT SEQ_TEST.CURRVAL FROM DUAL;
COL NAME FOR 15;
SELECT SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY,
        CYCLE_FLAG, ORDER_FLAG, CACHE_SIZE, LAST_NUMBER
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='JNO_SEQ';

ALTER SEQUENCE JNO_SEQ
MAXVALUE 120
CACHE 10;

DROP SEQUENCE JNO_SEQ;

GRANT CREATE SYNONYM TO SCOTT;
GRANT CREATE PUBLIC SYNONYM TO SCOTT;

CONN SCOTT/TIGER

CREATE SYNONYM E FOR EMP;
CREATE PUBLIC SYNONYM D2 FOR DEPT;

SELECET SYNONYM_NAME, TABLE_OWNER, TABLE_NAME
FROM USER_SYNONYMS
WHERE TABLE_NAME='EMP';

CONN / AS SYSDBA;

SELECET SYNONYM_NAME, TABLE_OWNER, TABLE_NAME
FROM DBA_SYNONYMS
WHERE TABLE_NAME = 'DEPT';
 
COL ENAME FOR A20
SELECT LPAD(ENAME, LEVEL*4, '*') "ENAME"
FROM EMP
CONNECT BY PRIOR EMPNO = MGR
start with empno = 7839;

SELECT LPAD(ENAME, LEVEL*4, '*') "ENAME"
FROM EMP
CONNECT BY PRIOR EMPNO = MGR
start with empno = 7839;

SELECT LPAD(ENAME, LEVEL*5,'-') ENAME
FROM EMP
CONNECT BY EMPNO = PRIOR MGR
start with empno=7369;

SELECT EMPNO, ENAME, JOB, MGR
       , PRIOR ENAME AS MGR_NAME
       , LEVEL
       , LPAD(' ', (LEVEL-1)*2,' ') || ENAME AS DEPTH_ENAME
       , SYS_CONNECT_BY_PATH(ENAME,'-') AS ENAME_LIST
FROM EMP
start with mgr is null
CONNECT BY PRIOR EMPNO=MGR
ORDER SIBLINGS BY EMPNO;

SELECT EMPNO, JOB, MGR, LEVEL LV, LPAD(' ', (LEVEL-1)*2, ' ') || ENAME AS DEPTH_ENAME, SYS_CONNECT_BY_PATH(ENAME, '-') AS ENAMELIST
FROM SCOTT.EMP
start with mgr is null
CONNECT BY PRIOR EMPNO=MGR
AND ENAME <> 'JONES'
ORDER SIBLINGS BY ENAME;

SELECT EMPNO, JOB, MGR, LEVEL LV, LPAD(' ', (LEVEL-1)*2, ' ') || ENAME AS DEPTH_ENAME, SYS_CONNECT_BY_PATH(ENAME, '-') AS ENAMELIST
FROM EMP
WHERE ENAME <> 'JONES'
start with mgr is null
CONNECT BY PRIOR EMPNO=MGR
ORDER SIBLINGS BY ENAME;

SELECT LPAD(ENAME, LEVEL*5, '*') ENAME
        ,SYS_CONNECT_BY_PATH(PATH, '->') "order(low->high)"
FROM EMP
start with empno=7369
CONNECT BY EMPNO=PRIOR MGR;

SELECT LPAD(ENAME, LEVEL*5, '*') ENAME
        ,SYS_CONNECT_BY_PATH(PATH, '->') "order(low->high)"
FROM EMP
WHERE CONNECT_BY_ISLEAF=0
start with empno=7369
CONNECT BY EMPNO=PRIOR MGR;

SELECT LPAD(ENAME, LEVEL*5, '*') ENAME
        ,SYS_CONNECT_BY_PATH(PATH, '->') "order(low->high)"
FROM EMP
WHERE CONNECT_BY_ISLEAF=1
start with empno=7369
CONNECT BY EMPNO=PRIOR MGR;

SELECT EMPNO, ENAME, CONNECT_BY_ROOT EMPNO "Root EMPNO",
         SYS_CONNECT_BY_PATH(NAME, '<-') "ROOT <- LEAF"
FROM EMP
WHERE LEVEL>1
AND EMPNO=7369
CONNECT BY PRIOR EMPNO=MGR;

SELECT EMPNO, ENAME, CONNECT_BY_ROOT EMPNO "Root EMPNO",
         SYS_CONNECT_BY_PATH(NAME, '<-') "ROOT <- LEAF"
FROM EMP
WHERE LEVEL=1
AND EMPNO=7369
CONNECT BY PRIOR EMPNO=MGR;

SELECT EMPNO, ENAME, CONNECT_BY_ROOT EMPNO "Root EMPNO",
         SYS_CONNECT_BY_PATH(NAME, '<-') "ROOT <- LEAF"
FROM EMP
WHERE LEVEL=2
AND EMPNO=7369
CONNECT BY PRIOR EMPNO=MGR;

SELECT EMPNO, ENAME, CONNECT_BY_ROOT EMPNO "Root EMPNO",
         SYS_CONNECT_BY_PATH(NAME, '<-') "ROOT <- LEAF"
FROM EMP
WHERE LEVEL=3
AND EMPNO=7369
CONNECT BY PRIOR EMPNO=MGR;
 
SELECT LPAD(E.NAME||'-'||D.DNAME||'-'||NVL(E.POSITION, 'TEAM WORKER'), LEVEL*27, '-') "NAME AND POSITION"
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
START WITH PEMPNO IS NULL
CONNECT BY PRIOR E.EMPNO = E.PEMPNO
ORDER SIBLINGS BY E.NAME;
 
SELECT LPAD(E.NAME||'-'||D.DNAME||'-'||NVL(E.POSITION, 'TEAM WORKER'), LEVEL*48, '-') "Name And Position"
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
CONNECT BY PRIOR E.EMPNO = E.PEMPNO
START WITH E.EMPNO = 19966102;
 
SELECT LPAD(E.NAME||'-'||D.DNAME||'-'||NVL(E.POSITION, 'TEAM WORKER'), LEVEL*37, '-') "Name And Position"
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
CONNECT BY E.EMPNO = PRIOR E.PEMPNO
START WITH E.EMPNO = 20000334;
 
SELECT E.NAME, PRIOR E.NAME MGR_NAME
FROM   EMP2 E
START WITH E.PEMPNO IS NULL
CONNECT BY PRIOR E.EMPNO = E.PEMPNO
ORDER SIBLINGS BY E.EMPNO;
 
SELECT E.EMPNO, E.NAME||'-'||D.DNAME||'-'||NVL(E.POSITION, 'TEAM WORKER') "ENAME AND POSITION",
       ( SELECT COUNT(*)
           FROM EMP2
         START WITH EMPNO = E.EMPNO
         CONNECT BY PRIOR EMPNO = PEMPNO
       )-1 "COUNT"
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
ORDER BY 3 DESC;
 
SELECT LPAD(E.NAME||' '||D.DNAME||' '||NVL(E.POSITION, 'TEAM WORKER'), LEVEL*48, '-') "ENAME AND POSITION"
     , SYS_CONNECT_BY_PATH(E.NAME, '-') PATH
FROM EMP2 E, DEPT2 D
WHERE E.DEPTNO = D.DCODE
START WITH E.EMPNO = 19966102
CONNECT BY PRIOR E.EMPNO = E.PEMPNO;

SELECT D.DNAME "학과이름", S.MAX_HEIGHT "최대키", ST.NAME "학생이름",
ST.HEIGHT "키"
FROM ( SELECT DEPTNO1, MAX(HEIGHT) MAX_HEIGHT
        FROM STUDENT
        GROUP BY DEPTNO1 ) S, DEPARTMENT D, STUDENT ST
WHERE D.DEPTNO=S.DEPTNO1
AND S.MAX_HEIGHT=ST.HEIGHT
AND S.DEPTNO1=ST.DEPTNO1

SELECT S.GRADE "학년", ST.NAME"이름", ST.HEIGHT "키", S.AVG_HEIGHT "평균키"
FROM (SELECT GRADE, AVG(HEIGHT) AVG_HEIGHT
        FROM STUDENT
        GROUP BY GRADE)S, STUDENT ST
WHERE S.GRADE=ST.GRADE
AND S.AVG_HEIGHT < ST.HEIGHT
ORDER BY S.GRADE

SELECT  ROWNUM "급여순위" ,NAME "이름", PAY "급여"
FROM (SELECT NAME, PAY
        FROM PROFESSOR
        ORDER BY PAY DESC)
WHERE ROWNUM BETWEEN 1 AND 5



