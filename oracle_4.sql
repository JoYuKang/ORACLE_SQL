---------------------------- 4장 -----------------------------------------

-- Cartesion Product
SELECT A.NAME   AS "NAME"
     , B.NAME   AS "NAME"
  FROM CAT_A A
     , CAT_B B
 WHERE A.NO = B.NO;
 
SELECT A.NAME   AS "NAME"
     , B.NAME   AS "NAME"
  FROM CAT_A A
     , CAT_B B;
 
SELECT A.NAME   AS "NAME"
     , B.NAME   AS "NAME"
     , C.NAME   AS "NAME"
  FROM CAT_A A
     , CAT_B B
     , CAT_C C
 WHERE A.NO = B.NO
   AND A.NO = C.NO;
 
SELECT A.NAME    AS "NAME"
     , B.NAME    AS "NAME"
     , C.NAME    AS "NAME"
  FROM CAT_A A
     , CAT_B B
     , CAT_C C
 WHERE A.NO = B.NO;
 
SELECT EMPNO    AS "EMPNO"
     , ENAME    AS "ENAME"
     , JOB      AS "JOB"
     , SAL      AS "SAL"
  FROM EMP
 WHERE DEPTNO = 10;
 
SELECT LEVEL C1
  FROM DUAL CONNECT BY LEVEL <=3;
 
SELECT *
  FROM (SELECT EMPNO        AS "EMPNO"
             , ENAME        AS "ENAME"
             , JOB          AS "JOB"
             , SAL          AS "SAL"
          FROM EMP
         WHERE DEPTNO = 10 )
     , (SELECT LEVEL C1
          FROM DUAL CONNECT BY LEVEL <=3);
          
SELECT EMPNO                                                                                                                                                   
     , CASE                                                                                                                                                    
         WHEN C1 =1 THEN 'ENAME'                                                                                                                               
         WHEN C1 =2 THEN 'JOB'                                                                                                                                 
         WHEN C1 =3 THEN 'HIREDATE'                                                                                                                            
       END                                     AS "TITLE"                                                                                                                                               
     , CASE                                                                                                                                                    
         WHEN C1 =1 THEN 'ENAME'                                                                                                                                 
         WHEN C1 =2 THEN 'JOB'                                                                                                                                   
         WHEN C1 =3 THEN 'HIREDATE'                                                                                                                              
       END                                     AS "CONTENTS"                                                                                                                                            
  FROM (SELECT EMPNO                           AS "EMPNO"                                                                                                                              
             , ENAME                           AS "ENAME"                                                                                                                              
             , JOB                             AS "JOB"                                                                                                                                  
             , SAL                             AS "SAL"                                                                                                                                  
             , TO_CHAR(HIREDATE, 'YYYY/MM/DD') AS "HIREDATE"                                                                                                 
          FROM SCOTT.EMP                                                                                                                                    
         WHERE DEPTNO = 10 )                                                                                                                                   
     , (SELECT LEVEL C1                                                                                                                                        
          FROM DUAL CONNECT BY LEVEL <= 3)                                                                                                                     
 ORDER BY 1, 2;          
 
-- EQUI Join
SELECT E.EMPNO  AS "EMPNO"
     , E.ENAME  AS "ENAME"
     , D.DNAME  AS "DNAME"
  FROM EMP E
     , DEPT D
 WHERE E.DEPTNO = D.DEPTNO
 ORDER BY DNAME
     , EMPNO DESC;
 
SELECT S.NAME  AS "STU_NAME"
     , P.NAME  AS "PROF_NAE"
  FROM STUDENT S
     , PROFESSOR P
 WHERE S.PROFNO = P.PROFNO;
 
SELECT S.NAME AS "STU_NAME"
     , P.NAME AS "PROF_NAE"
  FROM STUDENT S JOIN PROFESSOR P ON S.PROFNO = P.PROFNO;
 
 
SELECT S.NAME    AS "STU_NAME"
     , D.DNAME   AS "DEPT_NAME"
     , P.NAME    AS "PROF_NAME"
  FROM STUDENT S
     , DEPARTMENT D
     , PROFESSOR P
 WHERE S.DEPTNO1 = D.DEPTNO
   AND S.PROFNO = P.PROFNO;
 
SELECT S.NAME  AS "STU_NAME"
     , D.DNAME AS "DEPT_NAME"
     , P.NAME  AS "PROF_NAME"
  FROM STUDENT S JOIN DEPARTMENT D ON S.DEPTNO1 = D.DEPTNO JOIN PROFESSOR P ON S.PROFNO = P.PROFNO;
 
SELECT S.NAME AS "STU_NAME"
     , P.NAME AS "PROF_NAME"
  FROM STUDENT S
     , PROFESSOR P
 WHERE S.PROFNO = P.PROFNO
   AND S.DEPTNO1 = 101;
 
SELECT S.NAME AS "STU_NAME"
     , P.NAME AS "PROF_NAME"
  FROM STUDENT S JOIN PROFESSOR P ON S.PROFNO = P.PROFNO
   AND S.DEPTNO1 = 101;
 
-- NON-EQUI Join
SELECT C.GNAME                      AS "CUST_NAME"
     , TO_CHAR(C.POINT,'999,999')   AS "POINT"
     , G.GNAME                      AS "GIFT_NAME"
  FROM CUSTOMER C
     , GIFT G
 WHERE C.POINT BETWEEN G.G_START AND G.G_END;
 
SELECT C.GNAME                      AS "CUST_NAME"
     , TO_CHAR(C.POINT,'999,999')   AS "POINT"
     , G.GNAME                      AS "GIFT_NAME"
  FROM CUSTOMER C JOIN GIFT G ON C.POINT >= G.G_START
   AND C.POINT <= G.G_END;
 
SELECT S.NAME  AS "STU_NAME"
     , O.TOTAL AS "SCORE"
     , H.GRADE AS "CREDIT"
  FROM STUDENT S
     , SCORE O
     , HAKJUM H
 WHERE S.STUDNO = O.STUDNO
   AND O.TOTAL >= H.MIN_POINT
   AND O.TOTAL <= H.MAX_POINT;
 
-- OUTER Join
SELECT S.NAME  AS "STU_NAME"
     , P.NAME  AS "PROF_NAME"
  FROM STUDENT S
     , PROFESSOR P
 WHERE S.PROFNO = P.PROFNO(+);
 
 SELECT S.NAME AS "STU_NAME"
     , P.NAME  AS "PROF_NAME"
  FROM STUDENT S LEFT OUTER JOIN PROFESSOR P ON S.PROFNO = P.PROFNO;
 
SELECT S.NAME AS "STU_NAME"
     , P.NAME AS "PROF_NAME"
  FROM STUDENT S
     , PROFESSOR P
 WHERE S.PROFNO(+) = P.PROFNO;
 
 SELECT S.NAME AS "STU_NAME"
     , P.NAME  AS "PROF_NAME"
  FROM STUDENT S RIGHT OUTER JOIN PROFESSOR P ON S.PROFNO = P.PROFNO;
 
SELECT S.NAME AS "STU_NAME"
     , P.NAME AS "PROF_NAME"
  FROM STUDENT S
     , PROFESSOR P
 WHERE S.PROFNO(+) = P.PROFNO
 UNION
SELECT S.NAME AS "STU_NAME"
     , P.NAME AS "PROF_NAME"
  FROM STUDENT S
     , PROFESSOR P
 WHERE S.PROFNO = P.PROFNO(+);
 
 SELECT S.NAME AS "STU_NAME"
     , P.NAME  AS "PROF_NAME"
  FROM STUDENT S FULL OUTER JOIN PROFESSOR P ON S.PROFNO = P.PROFNO;
 
SELECT D.DEPTNO AS "DEPTNO"
     , D.DNAME  AS "DNAME"
     , D.LOC    AS "LOC"
     , E.EMPNO  AS "EMPNO"
     , E.ENAME  AS "ENAME"
     , E.SAL    AS "SAL"
  FROM DEPT D
     , EMP E
 WHERE D.DEPTNO = E.DEPTNO(+)
   AND E.DEPTNO(+) = 20
 ORDER BY 1;
 
SELECT E.EMPNO  AS "EMPNO"                                                                                  
     , E.ENAME  AS "ENAME"                                                                                  
     , E.JOB    AS "JOB"                                                                                    
     , D.DEPTNO AS "DEPTNO"                                                                                 
     , D.DNAME  AS "DNAME"                                                                                  
     , D.LOC    AS "LOC"                                                                                    
  FROM EMP E LEFT OUTER JOIN DEPT D ON ( E.DEPTNO = D.DEPTNO                                                
           AND D.LOC = 'CHICAGO'                                                                            
           AND E.JOB = 'CLERK' );                                                                           
 
-- SELF Join
SELECT EMPNO  AS "EMPNO"
     , ENAME  AS "ENAME"
     , MGR    AS "MGR"
  FROM EMP;
 
SELECT E1.ENAME AS "ENAME"
     , E2.ENAME AS "MGR_ENAME"
  FROM EMP E1
     , EMP E2
 WHERE E1.MGR = E2.EMPNO;
 
SELECT E1.ENAME AS "ENAME"
     , E2.ENAME AS "MGR_ENAME"
  FROM EMP E1 JOIN EMP E2 ON E1.MGR = E2.EMPNO;
 
----------------------------------연습문제---------------------------------------------
-- 1
SELECT S.NAME    AS "STU_NAME"
     , S.DEPTNO1 AS "DEPTNO1"
     , D.DNAME   AS "DEPT_NAME"
  FROM STUDENT S
     , DEPARTMENT D
 WHERE S.DEPTNO1 = D.DEPTNO;
 
SELECT S.NAME    AS "STU_NAME"
     , S.DEPTNO1 AS "DEPTNO1"
     , D.DNAME   AS "DEPT_NAME"
  FROM STUDENT S JOIN DEPARTMENT D ON S.DEPTNO1 = D.DEPTNO;
 
-- 2
SELECT E.NAME                        AS "NAME"
     , E.POSITION                    AS "POSITION"
     , TO_CHAR(E.PAY,'99,999,999')   AS "PAY"
     , TO_CHAR(P.S_PAY,'99,999,999') AS "LOW PAY"
     , TO_CHAR(P.E_PAY,'99,999,999') AS "HIGH PAY"
  FROM EMP2 E
     , P_GRADE P
 WHERE LOWER(E.POSITION) = LOWER(P.POSITION);
 
-- 3
SELECT E.NAME                                                   AS "NAME"
     , (TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(E.BIRTHDAY, 'YYYY')) AS "AGE"
     , E.POSITION                                               AS "CURR_POSITION"
     , DECODE(E.POSITION, 'BOSS', NULL , C.POSITION)            AS "BE_POSITION"
  FROM EMP2 E
     , P_GRADE P
     , P_GRADE C
 WHERE LOWER(E.POSITION) = LOWER(P.POSITION(+))
   AND (TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(E.BIRTHDAY, 'YYYY')) >= C.S_AGE
   AND (TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(E.BIRTHDAY, 'YYYY')) <= C.E_AGE
 ORDER BY "AGE" ;
 
--  4
SELECT C.GNAME  AS "GNAME"
     , C.POINT  AS "POINT"
     , G.GNAME  AS "GNAME"
  FROM CUSTOMER C
     , GIFT G
 WHERE C.POINT >= G.G_START
   AND G.GNAME = 'Notebook';
 
-- 5
SELECT A.PROFNO                               AS "PROFNO"
     , A.NAME                                 AS "NAME"
     , A.HIREDATE                             AS "HIREDATE"
     , COUNT(NVL2(B.PROFNO, A.PROFNO, NULL))  AS "COUNT"
  FROM PROFESSOR A
     , PROFESSOR B
 WHERE A.HIREDATE > B.HIREDATE(+)
 GROUP BY A.PROFNO
     , A.NAME
     , A.HIREDATE
 ORDER BY "COUNT";
 
SELECT A.PROFNO                               AS "PROFNO"
     , A.NAME                                 AS "NAME"
     , A.HIREDATE                             AS "HIREDATE"
     , COUNT(NVL2(B.PROFNO, A.PROFNO, NULL))  AS "COUNT"
  FROM PROFESSOR A LEFT JOIN PROFESSOR B ON A.HIREDATE > B.HIREDATE
 GROUP BY A.PROFNO
     , A.NAME
     , A.HIREDATE
 ORDER BY "COUNT";
 
-- 6
SELECT A.EMPNO                              AS "EMPNO"
     , A.ENAME                              AS "ENAME"
     , TO_CHAR(A.HIREDATE, 'YY/MM/DD')      AS "HIREDATE"
     , COUNT(NVL2(B.EMPNO, A.EMPNO, NULL))  AS "COUNT"
  FROM EMP A
     , EMP B
 WHERE A.HIREDATE > B.HIREDATE(+)
 GROUP BY A.EMPNO
     , A.ENAME
     , A.HIREDATE
 ORDER BY "HIREDATE";
 
SELECT A.EMPNO                              AS "EMPNO"
     , A.ENAME                              AS "ENAME"
     , TO_CHAR(A.HIREDATE, 'YY/MM/DD')      AS "HIREDATE"
     , COUNT(NVL2(B.EMPNO, A.EMPNO, NULL))  AS "COUNT"
  FROM EMP A LEFT JOIN EMP B ON A.HIREDATE > B.HIREDATE
 GROUP BY A.EMPNO
     , A.ENAME
     , A.HIREDATE
 ORDER BY "HIREDATE";