--3Àå

SELECT COUNT(*)     AS "COUNT"
     , COUNT(COMM)  AS "COMM"
  FROM EMP;
 
SELECT ENAME    AS "ENAME"
     , COMM     AS "COMM"
  FROM EMP;

SELECT COUNT(COMM)  AS "CNT_COMM"
     , SUM(COMM)    AS "SUM_COMM"
  FROM EMP;
 
SELECT COUNT(COMM)  AS "CNT_COMM"
     , SUM(COMM)    AS "SUM_COMM"
     , AVG(COMM)    AS "AVG_COMM"
  FROM EMP;
 
SELECT COUNT(*)         AS "COUNT"
     , SUM(COMM)        AS "SUM_COMM"
     , AVG(NVL(COMM,0)) AS "AVG_COMM"
  FROM EMP;

SELECT MAX(SAL)     AS "SAL_MAX"
     , MIN(SAL)     AS "SAL_MIN"
  FROM EMP;
 
SELECT MAX(HIREDATE)    AS "MAX"
     , MIN(HIREDATE)    AS "MIN"
  FROM EMP;
 
 
SELECT STDDEV(SAL)      AS "STDDEV_SAL"
     , VARIANCE(SAL)    AS "VARIANCE_SAL"
  FROM EMP;
 
SELECT DEPTNO           AS "DEPTNO"
     , AVG(NVL(SAL,0))  AS "AVG_SAL"
  FROM EMP
 GROUP BY DEPTNO;
 
SELECT DEPTNO           AS "DEPTNO"
     , JOB              AS "JOB"
     , AVG(NVL(SAL,0))  AS "AVG_SAL"
  FROM EMP
 GROUP BY DEPTNO
     , JOB;
 
SELECT DEPTNO           AS "DEPTNO"
     , JOB              AS "JOB"
     , AVG(NVL(SAL,0))  AS "AVG_SAL"
  FROM EMP
 GROUP BY DEPTNO
     , JOB
 ORDER BY 1
     , 2;
 
SELECT DEPTNO               AS "DEPTNO"
     , AVG(NVL(SAL,0))      AS "AVG_SAL"
  FROM EMP
 WHERE DEPTNO > 10
 GROUP BY DEPTNO
HAVING AVG(NVL(SAL,0)) > 2000;
 
 SELECT DEPTNO           AS "DEPTNO"
     , NULL              AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*)          AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
 UNION ALL
SELECT DEPTNO            AS "DEPTNO" 
     , JOB               AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*)          AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
     , JOB
 UNION ALL  
SELECT NULL               AS "DEPTNO"
     , NULL               AS "JOB"
     , ROUND(AVG(SAL),1)  AS "AVG_SAL"  
     , COUNT(*)           AS "CNT_EMP"
  FROM EMP
 ORDER BY DEPTNO
     , JOB;
 
SELECT DEPTNO            AS "DEPTNO"
     , JOB               AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*)          AS "CNT_EMP" 
  FROM EMP
 GROUP BY ROLLUP (DEPTNO, JOB);
 
 SELECT DEPTNO          AS "DEPTNO"
     , POSITION         AS "POSITION"
     , COUNT(*)         AS "COUNT"
     , SUM(PAY)         AS "SUM_PAY"
  FROM PROFESSOR
 GROUP BY POSITION
     , ROLLUP(DEPTNO);
        
 SELECT DEPTNO          AS "DEPTNO"
     , POSITION         AS "POSITION"
     , COUNT(*)         AS "COUNT"
     , SUM(PAY)         AS "SUM_PAY"
  FROM PROFESSOR
 GROUP BY DEPTNO
     , ROLLUP(POSITION);
     
 SELECT *
  FROM PROFESSOR2
 ORDER BY DEPTNO
     , POSITION;
 
SELECT DEPTNO       AS "DEPTNO"
     , POSITION     AS "POSITION"
     , SUM(PAY)     AS "SUM_PAY" 
  FROM PROFESSOR2
 GROUP BY DEPTNO
     , ROLLUP(POSITION);
     
SELECT DEPTNO            AS "DEPTNO"
     , NULL              AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*) CNT_EMP
  FROM EMP
 GROUP BY DEPTNO
 UNION ALL
SELECT DEPTNO            AS "DEPTNO"
     , JOB               AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*)          AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
     , JOB
 UNION ALL
SELECT NULL              AS "DEPTNO"
     , NULL              AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*)          AS "CNT_EMP"
  FROM EMP
 ORDER BY DEPTNO
     , JOB ;
     
SELECT DEPTNO             AS "DEPTNO"
     , JOB                AS "JOB"
     , ROUND(AVG(SAL),1)  AS "AVG_SAL"
     , COUNT(*)           AS "CNT_EMP"
 FROM EMP   
 GROUP BY ROLLUP(DEPTNO,JOB);
