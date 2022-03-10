 --3장
SELECT COUNT(*) AS "COUNT"
     , COUNT(COMM) AS "COMM"
  FROM EMP;
 
SELECT ENAME AS "ENAME"
     , COMM AS "COMM"
  FROM EMP;
 
SELECT COUNT(COMM) AS "CNT_COMM"
     , SUM(COMM) AS "SUM_COMM"
  FROM EMP;
 
SELECT COUNT(COMM) AS "CNT_COMM"
     , SUM(COMM) AS "SUM_COMM"
     , AVG(COMM) AS "AVG_COMM"
  FROM EMP;
 
SELECT COUNT(*) AS "COUNT"
     , SUM(COMM) AS "SUM_COMM"
     , AVG(NVL(COMM,0)) AS "AVG_COMM"
  FROM EMP;
 
SELECT MAX(SAL) AS "SAL_MAX"
     , MIN(SAL) AS "SAL_MIN"
  FROM EMP;
 
SELECT MAX(HIREDATE) AS "MAX"
     , MIN(HIREDATE) AS "MIN"
  FROM EMP;
 
SELECT STDDEV(SAL) AS "STDDEV_SAL"
     , VARIANCE(SAL) AS "VARIANCE_SAL"
  FROM EMP;
 
SELECT DEPTNO AS "DEPTNO"
     , AVG(NVL(SAL,0)) AS "AVG_SAL"
  FROM EMP
 GROUP BY DEPTNO;
 
SELECT DEPTNO AS "DEPTNO"
     , JOB AS "JOB"
     , AVG(NVL(SAL,0)) AS "AVG_SAL"
  FROM EMP
 GROUP BY DEPTNO
     , JOB;
 
SELECT DEPTNO AS "DEPTNO"
     , JOB AS "JOB"
     , AVG(NVL(SAL,0)) AS "AVG_SAL"
  FROM EMP
 GROUP BY DEPTNO
     , JOB
 ORDER BY 1
     , 2;
 
SELECT DEPTNO AS "DEPTNO"
     , AVG(NVL(SAL,0)) AS "AVG_SAL"
  FROM EMP
 WHERE DEPTNO > 10
 GROUP BY DEPTNO
HAVING AVG(NVL(SAL,0)) > 2000;
 SELECT DEPTNO AS "DEPTNO"
     , NULL AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
 UNION ALL
SELECT DEPTNO AS "DEPTNO"
     , JOB AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
     , JOB
 UNION ALL
SELECT NULL AS "DEPTNO"
     , NULL AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 ORDER BY DEPTNO
     , JOB;
 
SELECT DEPTNO AS "DEPTNO"
     , JOB AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 GROUP BY ROLLUP (DEPTNO, JOB);
 SELECT DEPTNO AS "DEPTNO"
     , POSITION AS "POSITION"
     , COUNT(*) AS "COUNT"
     , SUM(PAY) AS "SUM_PAY"
  FROM PROFESSOR
 GROUP BY POSITION
     , ROLLUP(DEPTNO);
 SELECT DEPTNO AS "DEPTNO"
     , POSITION AS "POSITION"
     , COUNT(*) AS "COUNT"
     , SUM(PAY) AS "SUM_PAY"
  FROM PROFESSOR
 GROUP BY DEPTNO
     , ROLLUP(POSITION);
 SELECT *
  FROM PROFESSOR2
 ORDER BY DEPTNO
     , POSITION;
 
SELECT DEPTNO AS "DEPTNO"
     , POSITION AS "POSITION"
     , SUM(PAY) AS "SUM_PAY"
  FROM PROFESSOR2
 GROUP BY DEPTNO
     , ROLLUP(POSITION);
 SELECT DEPTNO AS "DEPTNO"
     , NULL AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) CNT_EMP
  FROM EMP
 GROUP BY DEPTNO
 UNION ALL
SELECT DEPTNO AS "DEPTNO"
     , JOB AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
     , JOB
 UNION ALL
SELECT NULL AS "DEPTNO"
     , NULL AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 ORDER BY DEPTNO
     , JOB ;
 
SELECT DEPTNO AS "DEPTNO"
     , JOB AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 GROUP BY ROLLUP(DEPTNO,JOB);
 
-- CUBE() 사용
SELECT DEPTNO AS "DEPTNO"
     , NULL AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
 UNION ALL
SELECT NULL AS "DEPTNO"
     , JOB AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 GROUP BY JOB
 UNION ALL
SELECT DEPTNO AS "DEPTNO"
     , JOB AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
     , JOB
 UNION ALL
SELECT NULL AS "DEPTNO"
     , NULL AS "JOB"
     , ROUND(AVG(SAL),1)AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 ORDER BY DEPTNO
     , JOB;
 
SELECT DEPTNO AS "DEPTNO"
     , JOB AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) AS "CNT_EMP"
  FROM EMP
 GROUP BY CUBE (DEPTNO, JOB)
 ORDER BY DEPTNO
     , JOB;
 
SELECT GRADE AS "GRADE"
     , COUNT(*) AS "CNT"
  FROM STUDENT
 GROUP BY GRADE
 UNION
SELECT DEPTNO1 AS "GRADE"
     , COUNT(*) AS "CNT"
  FROM STUDENT
 GROUP BY DEPTNO1;
 
SELECT GRADE       AS "GRADE"
     , DEPTNO1     AS "DEPTNO1"     
     , COUNT(*)    AS "CNT"
  FROM STUDENT
 GROUP BY GROUPING SETS(GRADE, DEPTNO1);
 
 SELECT GRADE      AS "GRADE"
     , DEPTNO1     AS "DEPTNO1"   
     , COUNT(*)    AS "CNT"
     , SUM(HEIGHT) AS "SUM_HEIGJT"
     , SUM(WEIGHT) AS "SUM_WEIGHT"
  FROM STUDENT
 GROUP BY GROUPING SETS(GRADE, DEPTNO1);
 
 SELECT DEPTNO               AS "DEPTNO"
     , LISTAGG(ENAME,'->') WITHIN
 GROUP(
         ORDER BY HIREDATE)  AS "LISTAGG"
  FROM EMP
 GROUP BY DEPTNO;
 
--실행 안됨
SELECT DEPTNO
     , SUBSTR( XMLAGG(XMLELEMENT(X, ',',ENAME)
                 ORDER BY ENAME).EXTRACT('//TEXT()').GETSTRINGVAL() ,2) AS "DEPT_ENAME_LIST"
  FROM EMP A
 GROUP BY DEPTNO;
 
SELECT DEPTNO
     , SUBSTR( XMLAGG(XMLELEMENT(X, ',',ENAME)
                 ORDER BY ENAME) .EXTRACT('//TEXT()').GETCLOBVAL() ,2) AS "DEPT_ENAME_LIST"
  FROM EMP A
 GROUP BY DEPTNO;
 
-- PIVOT() 사용
SELECT MAX(DECODE(DAY,'SUN',DAYNO)) AS "SUN"
     , MAX(DECODE(DAY,'MON',DAYNO)) AS "MON"
     , MAX(DECODE(DAY,'TUE',DAYNO)) AS "TUE"
     , MAX(DECODE(DAY,'WED',DAYNO)) AS "WED"
     , MAX(DECODE(DAY,'THU',DAYNO)) AS "THU"
     , MAX(DECODE(DAY,'FRI',DAYNO)) AS "FRI"
     , MAX(DECODE(DAY,'SAT',DAYNO)) AS "SAT"
  FROM CAL
 GROUP BY WEEKNO
 ORDER BY WEEKNO;
 
SELECT DECODE(DAY,'SUN',DAYNO) AS "SUN"
     , DECODE(DAY,'MON',DAYNO) AS "MON"
     , DECODE(DAY,'TUE',DAYNO) AS "TUE"
     , DECODE(DAY,'WED',DAYNO) AS "WED"
     , DECODE(DAY,'THU',DAYNO) AS "THU"
     , DECODE(DAY,'FRI',DAYNO) AS "FRI"
     , DECODE(DAY,'SAT',DAYNO) AS "SAT"
  FROM CAL;
 
SELECT MAX(DECODE(DAY,'SUN',DAYNO)) AS "SUN"
     , MAX(DECODE(DAY,'MON',DAYNO)) AS "MON"
     , MAX(DECODE(DAY,'TUE',DAYNO)) AS "TUE"
     , MAX(DECODE(DAY,'WED',DAYNO)) AS "WED"
     , MAX(DECODE(DAY,'THU',DAYNO)) AS "THU"
     , MAX(DECODE(DAY,'FRI',DAYNO)) AS "FRI"
     , MAX(DECODE(DAY,'SAT',DAYNO)) AS "SAT"
  FROM CAL;
 
SELECT ASCII('2')
  FROM DUAL;
 
SELECT ASCII('29')
  FROM DUAL;
 
SELECT ASCII('8')
  FROM DUAL;
 
SELECT MAX(DECODE(DAY,'SUN',DAYNO)) AS "SUN"
     , MAX(DECODE(DAY,'MON',DAYNO)) AS "MON"
     , MAX(DECODE(DAY,'TUE',DAYNO)) AS "TUE"
     , MAX(DECODE(DAY,'WED',DAYNO)) AS "WED"
     , MAX(DECODE(DAY,'THU',DAYNO)) AS "THU"
     , MAX(DECODE(DAY,'FRI',DAYNO)) AS "FRI"
     , MAX(DECODE(DAY,'SAT',DAYNO)) AS "SAT"
  FROM CAL
 GROUP BY WEEKNO;
 
SELECT MAX(DECODE(DAY,'SUN',DAYNO)) AS "SUN"
     , MAX(DECODE(DAY,'MON',DAYNO)) AS "MON"
     , MAX(DECODE(DAY,'TUE',DAYNO)) AS "TUE"
     , MAX(DECODE(DAY,'WED',DAYNO)) AS "WED"
     , MAX(DECODE(DAY,'THU',DAYNO)) AS "THU"
     , MAX(DECODE(DAY,'FRI',DAYNO)) AS "FRI"
     , MAX(DECODE(DAY,'SAT',DAYNO)) AS "SAT"
  FROM CAL
 GROUP BY WEEKNO
 ORDER BY WEEKNO;
 
SELECT *
  FROM (SELECT WEEKNO AS "WEEK"
             , DAY    AS "DAY"
             , DAYNO  AS "DAYNO"
          FROM CAL) PIVOT (MAX(DAYNO) FOR DAY IN ('SUN' AS "SUN"
                     , 'MON' AS "MON"
                     , 'TUE' AS "TUE"
                     , 'WED' AS "WED"
                     , 'THU' AS "THU"
                     , 'FRI' AS "FRI"
                     , 'SAT' AS "SAT" ) )
 ORDER BY "WEEK";
 
SELECT DEPTNO
     , COUNT(DECODE(JOB, 'CLERK', '0')) AS"CLERK"
     , COUNT(DECODE(JOB, 'MANAGER', '0')) AS"MANAGER"
     , COUNT(DECODE(JOB, 'PRESIDENT', '0')) AS"PRESIDENT"
     , COUNT(DECODE(JOB, 'ANALYST', '0')) AS "ANALYST"
     , COUNT(DECODE(JOB, 'SALESMAN', '0')) AS "SALESMAN"
  FROM EMP
 GROUP BY DEPTNO
 ORDER BY DEPTNO;
 
SELECT DEPTNO
     , DECODE(JOB, 'CLERK', '0') AS "CLERK"
     , DECODE(JOB, 'MANAGER', '0') AS "MANAGER"
     , DECODE(JOB, 'PRESIDENT', '0')AS "PRESIDENT"
     , DECODE(JOB, 'ANALYST', '0') AS "ANALYST"
     , DECODE(JOB, 'SALESMAN', '0') AS "SALESMAN"
  FROM EMP;
 
SELECT DEPTNO
     , DECODE(JOB, 'CLERK', '9') AS "CLERK"
     , DECODE(JOB, 'MANAGER', '9') AS "MANAGER"
     , DECODE(JOB, 'PRESIDENT', '9')AS "PRESIDENT"
     , DECODE(JOB, 'ANALYST', '9') AS "ANALYST"
     , DECODE(JOB, 'SALESMAN', '9') AS "SALESMAN"
  FROM EMP;
 
SELECT DEPTNO
     , COUNT(DECODE(JOB, 'CLERK', '0')) AS "CLERK"
     , COUNT(DECODE(JOB, 'MANAGER', '0')) AS "MANAGER"
     , COUNT(DECODE(JOB, 'PRESIDENT', '0')) AS "PRESIDENT"
     , COUNT(DECODE(JOB, 'ANALYST', '0')) AS "ANALYST"
     , COUNT(DECODE(JOB, 'SALESMAN', '0')) AS "SALESMAN"
  FROM EMP
 GROUP BY DEPTNO;
 
SELECT *
  FROM (SELECT DEPTNO
             , JOB
             , EMPNO
          FROM EMP) PIVOT (COUNT(EMPNO) FOR JOB IN ('CLERK' AS "CLERK"
                     , 'MANAGER' AS "MANAGER"
                     , 'PRESIDENT' AS "PRESIDENT"
                     , 'ANALYST' AS "ANALYST"
                     , 'SALESMAN' AS "SALESMAN") )
 ORDER BY DEPTNO;
 
SELECT *
  FROM (SELECT DEPTNO AS "DEPTNO"
             , JOB AS "JOB"
             , EMPNO AS "EMPNO"
             , SAL AS "SAL"
          FROM EMP) PIVOT ( COUNT(EMPNO) AS COUNT, SUM(NVL(SAL,0)) AS SUM FOR JOB IN ('CLERK' AS "C"
                     , 'MANAGER' AS "M"
                     , 'PRESIDENT' AS "P"
                     , 'ANALYST' AS "A"
                     , 'SALESMAN' AS "S") )
 ORDER BY DEPTNO;
 
-- UNPIVOT() 사용
SELECT *
  FROM (SELECT DEPTNO AS "DEPTNO"
             , JOB AS "JOB"
             , EMPNO AS "EMPNO"
          FROM EMP) PIVOT ( COUNT(EMPNO) FOR JOB IN ('CLERK' AS "CLERK"
                     , 'MANAGER' AS "MANAGER"
                     , 'PRESIDENT' AS "PRESIDENT"
                     , 'ANALYST' AS "ANALYST"
                     , 'SALESMAN' AS "SALESMAN") );
 
SELECT *
  FROM UPIVOT;
 
SELECT *
  FROM UPIVOT UNPIVOT ( EMPNO FOR JOB IN (CLERK
                     , MANAGER 
                     , PRESIDENT
                     , ANALYST
                     , SALESMAN) );
 -- LAG()
SELECT ENAME                AS "ENAME"
     , HIREDATE             AS "HIREDATE"
     , SAL                  AS "SAL"
     , LAG(SAL,1,0) OVER (
         ORDER BY HIREDATE) AS "LAG"
  FROM EMP;
 
SELECT ENAME                AS "ENAME"
     , HIREDATE             AS "HIREDATE"
     , SAL                  AS "SAL"
     , LAG(SAL,3,2) OVER (
         ORDER BY HIREDATE) AS "LAG"
  FROM EMP;
 
-- LEAD()
SELECT ENAME                AS "ENAME"
     , HIREDATE             AS "HIREDATE"
     , SAL                  AS "SAL"
     , LEAD(SAL,2,1) OVER (
         ORDER BY HIREDATE) AS "LEAD"
  FROM EMP;
 
-- RANK()
SELECT RANK('SMITH') WITHIN
 GROUP (
         ORDER BY ENAME) "RANK"
  FROM EMP;
 
SELECT EMPNO                  AS "ENAME"
     , ENAME                  AS "HIREDATE"
     , SAL                    AS "SAL"
     , RANK() OVER (
         ORDER BY SAL)        AS RANK_ASC
     , RANK() OVER ( 
         ORDER BY SAL DESC)   AS RANK_DESC
  FROM EMP;
 
SELECT EMPNO                    AS "ENAME"
     , ENAME                    AS "ENAME"
     , SAL                      AS "SAL"
     , RANK() OVER(
         ORDER BY SAL DESC)     AS "RANK"
  FROM EMP
 WHERE DEPTNO = 10;
 
SELECT EMPNO                    AS "EMPNO"
     , ENAME                    AS "EMPNO"
     , SAL                      AS "SAL"                     
     , DEPTNO                   AS "DEPTNO"
     , RANK() OVER (PARTITION BY DEPTNO
         ORDER BY SAL DESC)     AS "RANK"
  FROM EMP;
 
SELECT EMPNO                 AS "EMPNO"
     , ENAME                 AS "ENAME"
     , SAL                   AS "SAL"
     , DEPTNO                AS "DEPTNO"
     , RANK() OVER(PARTITION BY DEPTNO, JOB
         ORDER BY SAL DESC)  AS"RANK"
  FROM EMP;
 
-- DENSE_RANK()
SELECT EMPNO                AS "EMPNO"
     , ENAME                AS "ENAME"
     , SAL					AS "SAL"
     , RANK() OVER(
         ORDER BY SAL DESC) AS "SAL_RANK"
     , DENSE_RANK() OVER(
         ORDER BY SAL DESC) AS "SAL_DENSE_RANK"
  FROM EMP;
 
-- ROW_NUMBER()
SELECT EMPNO                AS "EMPNO"
     , ENAME                AS "ENAME"
     , JOB                  AS "JOB"
     , SAL                  AS "SAL"
     , RANK() OVER(
         ORDER BY SAL DESC) AS "SAL_RANK"
     , DENSE_RANK() OVER(						   
         ORDER BY SAL DESC) AS "SAL_DENSE_RANK"
     , ROW_NUMBER() OVER(		
         ORDER BY SAL DESC) AS "SAL_ROW_NUM"
  FROM EMP;
 
SELECT DEPTNO                AS "DEPTNO"
     ,SAL                    AS "SAL"
     ,EMPNO                  AS "EMPNO"
     ,ROW_NUMBER() OVER(PARTITION BY DEPTNO
         ORDER BY SAL)       AS "ROW_NUMBER1"
     ,RANK() OVER(PARTITION BY DEPTNO
         ORDER BY SAL)       AS "RANK1"
     ,DENSE_RANK() OVER(PARTITION BY DEPTNO
         ORDER BY SAL)       AS "DENSE_RANK1"
     ,ROW_NUMBER() OVER(PARTITION BY DEPTNO
         ORDER BY SAL,EMPNO) AS "ROW_NUMBER2"
     ,RANK() OVER(PARTITION BY DEPTNO
         ORDER BY SAL,EMPNO) AS "RANK2"
     ,DENSE_RANK() OVER(PARTITION BY DEPTNO
         ORDER BY SAL,EMPNO) AS "DENSE_RANK2"
  FROM EMP
 WHERE DEPTNO IN ('10'
             ,'20')
 ORDER BY DEPTNO
     , SAL
     , EMPNO;
 
-- SUM() OVER()
SELECT P_DATE              AS "P_DATE"
     , P_CODE              AS "P_CODE"
     , P_QTY               AS "P_QTY"
     , P_TOTAL             AS "P_TOTAL"
     , SUM(P_TOTAL) OVER (
         ORDER BY P_TOTAL) AS "TOTAL"
  FROM PANMAE
 WHERE P_STORE = 1000;
 
SELECT P_DATE               AS "P_DATE"
     , P_CODE               AS "P_CODE"
     , P_QTY                AS "P_QTY"
     , P_TOTAL              AS "P_TOTAL"
     , SUM(P_TOTAL) OVER(PARTITION BY P_CODE
         ORDER BY P_TOTAL)  AS "TOTAL"
  FROM PANMAE
 WHERE P_STORE = 1000;
 
SELECT P_DATE               AS "P_DATE"
     , P_CODE               AS "P_CODE"
     , P_DATE               AS "P_DATE"
     , P_QTY                AS "P_QTY"
     , P_TOTAL              AS "P_TOTAL"
     , SUM(P_TOTAL) OVER(PARTITION BY P_CODE , P_STORE
         ORDER BY P_DATE) "TOTAL"
  FROM PANMAE;
 
--RATIO_TO_REPOORT()
SELECT P_CODE
     , SUM(SUM(P_QTY)) OVER()                               AS "TOTAL_QTY"
     , SUM(SUM(P_TOTAL)) OVER()                             AS "TOTAL_PRICE"
     , P_STORE                                              AS "P_STORE"
     , P_QTY                                                AS "P_QTY"
     , P_TOTAL                                              AS "P_TOTAL"
     , ROUND((RATIO_TO_REPORT(SUM(P_QTY)) OVER())*100,2)    AS "QTY_%"
     , ROUND((RATIO_TO_REPORT(SUM(P_TOTAL)) OVER())*100,2)  AS "TOTAL_%"
  FROM PANMAE
 WHERE P_CODE = 100
 GROUP BY P_CODE
     , P_STORE
     , P_QTY
     , P_TOTAL;
 
-- LAG()
SELECT P_STORE            AS "P_STORE"
     , P_DATE             AS "P_DATE"
     , P_CODE             AS "P_CODE"
     , P_QTY              AS "P_QTY"
     , LAG(P_QTY,1) OVER(
         ORDER BY P_DATE) AS "D-1 QTY"
     , P_QTY - LAG(P_QTY,1) OVER(
         ORDER BY P_DATE) AS "DIFF-QTY"
     , P_TOTAL
     , LAG(P_TOTAL,1) OVER(
         ORDER BY P_DATE) AS "D-1 PRICE"
     , P_TOTAL - LAG(P_TOTAL,1) OVER(
         ORDER BY P_DATE) AS "DIFF0PRICE"
  FROM PANMAE
 WHERE P_STORE = 1000;
 
SELECT P_STORE                  AS "P_STORE"
     , P_DATE                   AS "P_DATE"
     , P_CODE                   AS "P_CODE"
     , P_QTY                    AS "P_QTY"
     , LAG(P_QTY,1) OVER(PARTITION BY P_STORE
         ORDER BY P_DATE)       AS "D-1 QTY"
     , P_QTY - LAG(P_QTY,1) OVER(PARTITION BY P_STORE
         ORDER BY P_DATE)       AS "DIFF-QTY"
     , P_TOTAL
     , LAG(P_TOTAL,1) OVER(PARTITION BY P_STORE
         ORDER BY P_DATE)       AS "D-1 PRICE"
     , P_TOTAL - LAG(P_TOTAL,1) OVER(PARTITION BY P_STORE
         ORDER BY P_DATE)       AS "DIFF0PRICE"
  FROM PANMAE;
 
------------------------------- 연습문제 ---------------------------------------
SELECT MAX(SAL + NVL(COMM,0))           AS "MAX"
     , MIN(SAL + NVL(COMM,0))           AS "MIN"
     , ROUND(AVG(SAL + NVL(COMM,0)),1)  AS "AVG"
  FROM EMP;

 --2
SELECT COUNT(*) || 'EA' "TOTAL"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'01','0')) || 'EA' AS "JAN"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'02','0')) || 'EA' AS "FEB"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'03','0')) || 'EA' AS "MAR"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'04','0')) || 'EA' AS "APR"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'05','0')) || 'EA' AS "MAY"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'06','0')) || 'EA' AS "JUN"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'07','0')) || 'EA' AS "JUL"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'08','0')) || 'EA' AS "AUG"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'09','0')) || 'EA' AS "SEP"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'10','0')) || 'EA' AS "OCT"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'11','0')) || 'EA' AS "NOV"
     , COUNT(DECODE(SUBSTR(BIRTHDAY,4,2),'12','0')) || 'EA' AS "DEC"
  FROM STUDENT;
 
 --3
SELECT COUNT(*) TOTAL
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'02','0'))  AS "SEOUL"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'031','0')) AS "GYEONGGI"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'051','0')) AS "BUSAN"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'052','0')) AS "ULSAN"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'053','0')) AS "DAEGU"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'055','0')) AS "GYEONGNAM"
  FROM STUDENT;
 
 --4
SELECT *
  FROM (SELECT DEPTNO                    AS "DEPTNO"
             , NVL(JOB, 'TOTAL')         AS "JOB"
             , SUM(SAL)                  AS "SAL"
          FROM EMP
         WHERE JOB IS NOT NULL
         GROUP BY CUBE(DEPTNO, JOB)) PIVOT ( SUM(SAL) FOR JOB IN ('CLERK' AS "CLERK"
                     , 'MANAGER'         AS "MANAGER"
                     , 'PRESIDENT'       AS "PRESIDENT"
                     , 'ANALYST'         AS "ANALYST"
                     , 'SALESMAN'        AS "SALESMAN"
                     , 'TOTAL'           AS "TOTAL") )
 ORDER BY DEPTNO;
 
SELECT DEPTNO
     , SUM(DECODE(JOB, 'CLERK', SAL, 0))     AS "CLERK"
     , SUM(DECODE(JOB, 'MANAGER', SAL, 0))   AS "MANAGER"
     , SUM(DECODE(JOB, 'PRESIDENT', SAL, 0)) AS "PRESIDENT"
     , SUM(DECODE(JOB, 'ANALYST', SAL, 0))   AS "ANALYST"
     , SUM(DECODE(JOB, 'SALESMAN', SAL, 0))  AS "SALESMAN"
     , SUM(SAL)                              AS "TOTAL"
  FROM EMP
 WHERE JOB IS NOT NULL
 GROUP BY CUBE(DEPTNO)
 ORDER BY DEPTNO;
 
-- 5
SELECT DEPTNO           AS "DEPTNO"
     ,ENAME             AS "ENAME"
     , SAL              AS "SAL"
     , SUM(SAL) OVER(
         ORDER BY SAL)  AS "TOTAL"
  FROM EMP;
 
-- 6
SELECT *
  FROM FRUIT PIVOT ( SUM(PRICE) FOR NAME IN ('apple' AS "APPLE"
                     , 'grape' AS "GRAPE"
                     , 'orange' AS "ORANGE") );

--  7
SELECT COUNT(*) || 'EA' ||'  (' || '100' || '%)' TOTAL
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'02','0')) || 'EA' ||'  (' || COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'02','0')) /COUNT(*)*100 || '%)'  AS "SEOUL"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'031','0')) || 'EA' ||'  (' || COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'02','0')) /COUNT(*)*100 || '%)' AS "GYEONGGI"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'051','0')) || 'EA' ||'  (' || COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'02','0')) /COUNT(*)*100 || '%)' AS "BUSAN"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'052','0')) || 'EA' ||'  (' || COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'02','0')) /COUNT(*)*100 || '%)' AS "ULSAN"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'053','0')) || 'EA' ||'  (' || COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'02','0')) /COUNT(*)*100 || '%)' AS "DAEGU"
     , COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'055','0')) || 'EA' ||'  (' || COUNT(DECODE(SUBSTR(TEL,0,INSTR(TEL,')') -1),'02','0')) /COUNT(*)*100 || '%)' AS "GYEONGNAM"
  FROM STUDENT;
 
-- 8
SELECT DEPTNO           AS "DEPTNO"
     , ENAME            AS "ENAME"
     , SAL              AS "SAL"
     , SUM(SAL) OVER(PARTITION BY DEPTNO
         ORDER BY SAL)  AS "TOTAL"
  FROM EMP;
 
-- 9
SELECT DEPTNO                                           AS "DEPTNO"
     , ENAME                                            AS "ENAME"
     , SAL                                              AS "SAL"
     , SUM(SAL) OVER()                                  AS "TOTAL_SAL"
     , ROUND(RATIO_TO_REPORT(SUM(SAL)) OVER() * 100, 2) AS "%"
  FROM EMP
 GROUP BY DEPTNO                                        
     , ENAME                                            
     , SAL                                             
 ORDER BY SAL DESC;
 
--10
SELECT DEPTNO                                                             AS "DEPTNO"
     , ENAME                                                              AS "ENAME"
     , SAL
     , SUM(SAL) OVER(PARTITION BY DEPTNO)                                 AS "SUM_DEPT"
     , ROUND(RATIO_TO_REPORT(SUM(SAL)) OVER(PARTITION BY DEPTNO)* 100, 2) AS "%"
  FROM EMP
 GROUP BY DEPTNO
     , ENAME
     , SAL
 ORDER BY DEPTNO;
 
SELECT *
  FROM LOAN;
 
-- 11
SELECT L_DATE               AS "대출일자"
     , L_CODE               AS "대출종목코드"
     , L_QTY                AS "대출건수"
     , L_TOTAL              AS "대출총액"
     , SUM(L_TOTAL) OVER(
         ORDER BY L_DATE)   AS "누적대출금액"
  FROM LOAN
 WHERE L_STORE = 1000;
 
-- 12
SELECT L_CODE                        AS "대출종목코드"
     , L_STORE                       AS "대출지점"
     , L_DATE                        AS "대출일자"
     , L_QTY                         AS "대출건수"
     , L_TOTAL                       AS "대출액"
     , SUM(L_TOTAL) OVER(PARTITION BY L_CODE, L_STORE
         ORDER BY L_DATE, L_TOTAL)   AS "누적대출금액"
  FROM LOAN;
 
-- 13
SELECT L_DATE                        AS "대출일자"
     , L_CODE                        AS "대출종목코드"
     , L_QTY                         AS "대출건수"
     , L_TOTAL                       AS "대출액"
     , SUM(L_TOTAL) OVER(PARTITION BY L_CODE
         ORDER BY L_CODE, L_TOTAL)   AS "누적대출금액"
  FROM LOAN
 WHERE L_STORE = 1000;
 
-- 14
SELECT DEPTNO                                           AS "DEPTNO"
     , NAME                                             AS "NAME"
     , PAY                                              AS "PAY"
     , SUM(PAY) OVER()                                  AS "TOTAL PAY"
     , ROUND(RATIO_TO_REPORT(SUM(PAY)) OVER() * 100 ,2) AS "RATIO %"
  FROM PROFESSOR
 GROUP BY DEPTNO
     , NAME
     , PAY
 ORDER BY "RATIO %" DESC;
 
-- 15
SELECT DEPTNO                                                           AS "DEPTNO"
     , NAME                                                             AS "NAME"
     , PAY                                                              AS "PAY"
     , SUM(PAY) OVER(PARTITION BY DEPTNO)                               AS "TOTAL_DEPTNO"
     , ROUND(RATIO_TO_REPORT(PAY) OVER(PARTITION BY DEPTNO) * 100 ,2)   AS "RATIO(%)"
  FROM PROFESSOR
 GROUP BY DEPTNO
     , NAME
     , PAY;
