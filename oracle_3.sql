--3장

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

--------------------------- CUBE
SELECT DEPTNO             AS "DEPTNO"
     , NULL               AS "JOB"
     , ROUND(AVG(SAL),1)  AS "AVG_SAL"
     , COUNT(*)           AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
 UNION ALL
SELECT NULL              AS "DEPTNO"
     , JOB               AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*)          AS "CNT_EMP"
  FROM EMP
 GROUP BY JOB
 UNION ALL
SELECT DEPTNO            AS "DEPTNO"
     , JOB               AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*)          AS "CNT_EMP"
  FROM EMP
 GROUP BY DEPTNO
     , JOB
 UNION ALL
SELECT NULL             AS "DEPTNO"
     , NULL             AS "JOB"
     , ROUND(AVG(SAL),1)AS "AVG_SAL"
     , COUNT(*)         AS "CNT_EMP"
  FROM EMP
 ORDER BY DEPTNO
     , JOB;
 
SELECT DEPTNO            AS "DEPTNO"
     , JOB               AS "JOB"
     , ROUND(AVG(SAL),1) AS "AVG_SAL"
     , COUNT(*)          AS "CNT_EMP"
  FROM EMP
 GROUP BY CUBE (DEPTNO, JOB)
 ORDER BY DEPTNO
     , JOB;
 
SELECT GRADE        AS "GRADE"
     , COUNT(*)     AS "CNT"
  FROM STUDENT
 GROUP BY GRADE
 UNION 
SELECT DEPTNO1      AS "GRADE"
     , COUNT(*)     AS "CNT"
  FROM STUDENT
 GROUP BY DEPTNO1;
 
SELECT GRADE
     , DEPTNO1
     , COUNT(*)
  FROM STUDENT
 GROUP BY GROUPING SETS(GRADE, DEPTNO1);
 SELECT GRADE
     , DEPTNO1
     , COUNT(*)
     , SUM(HEIGHT)
     , SUM(WEIGHT)
  FROM STUDENT
 GROUP BY GROUPING SETS(GRADE, DEPTNO1);
 
SELECT DEPTNO
     , LISTAGG(ENAME,'->') WITHIN
 GROUP(
         ORDER BY HIREDATE) "LISTAGG"
  FROM EMP
 GROUP BY DEPTNO;
 
--XMLAGG XML 함수 집에서 실행 안됨
SELECT DEPTNO
     , SUBSTR( XMLAGG(XMLELEMENT(X, ',',ENAME)
                 ORDER BY ENAME).EXTRACT('//TEXT()').GETSTRINGVAL() ,2) AS DEPT_ENAME_LIST
  FROM EMP A
 GROUP BY DEPTNO;
 
SELECT DEPTNO
     , SUBSTR( XMLAGG(XMLELEMENT(X, ',',ENAME)
                 ORDER BY ENAME) .EXTRACT('//TEXT()').GETCLOBVAL() ,2) AS DEPT_ENAME_LIST
  FROM EMP A
 GROUP BY DEPTNO;
 
--4.5 PIVOT() 함수
SELECT MAX(DECODE(DAY,'SUN',DAYNO)) SUN
     , MAX(DECODE(DAY,'MON',DAYNO)) MON
     , MAX(DECODE(DAY,'TUE',DAYNO)) TUE
     , MAX(DECODE(DAY,'WED',DAYNO)) WED
     , MAX(DECODE(DAY,'THU',DAYNO)) THU
     , MAX(DECODE(DAY,'FRI',DAYNO)) FRI
     , MAX(DECODE(DAY,'SAT',DAYNO)) SAT
  FROM CAL
 GROUP BY WEEKNO
 ORDER BY WEEKNO;
 
SELECT DECODE(DAY,'SUN',DAYNO) SUN
     , DECODE(DAY,'MON',DAYNO) MON
     , DECODE(DAY,'TUE',DAYNO) TUE
     , DECODE(DAY,'WED',DAYNO) WED
     , DECODE(DAY,'THU',DAYNO) THU
     , DECODE(DAY,'FRI',DAYNO) FRI
     , DECODE(DAY,'SAT',DAYNO) SAT
  FROM CAL;
 
SELECT MAX(DECODE(DAY,'SUN',DAYNO)) SUN
     , MAX(DECODE(DAY,'MON',DAYNO)) MON
     , MAX(DECODE(DAY,'TUE',DAYNO)) TUE
     , MAX(DECODE(DAY,'WED',DAYNO)) WED
     , MAX(DECODE(DAY,'THU',DAYNO)) THU
     , MAX(DECODE(DAY,'FRI',DAYNO)) FRI
     , MAX(DECODE(DAY,'SAT',DAYNO)) SAT
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
  FROM (SELECT WEEKNO "WEEK"
             , DAY
             , DAYNO
          FROM CAL) PIVOT (MAX(DAYNO) FOR DAY IN ('SUN' AS "SUN"
                     , 'MON' AS "MON"
                     , 'TUE' AS "TUE"
                     , 'WED' AS "WED"
                     , 'THU' AS "THU"
                     , 'FRI' AS "FRI"
                     , 'SAT' AS "SAT" ) )
 ORDER BY "WEEK";
 
SELECT DEPTNO
     , COUNT(DECODE(JOB, 'CLERK', '0'))      AS"CLERK"
     , COUNT(DECODE(JOB, 'MANAGER', '0'))    AS"MANAGER"
     , COUNT(DECODE(JOB, 'PRESIDENT', '0'))  AS"PRESIDENT"
     , COUNT(DECODE(JOB, 'ANALYST', '0'))    AS "ANALYST"
     , COUNT(DECODE(JOB, 'SALESMAN', '0'))   AS "SALESMAN"
  FROM EMP
 GROUP BY DEPTNO
 ORDER BY DEPTNO;
 
SELECT DEPTNO
     , DECODE(JOB, 'CLERK', '0')    AS "CLERK"
     , DECODE(JOB, 'MANAGER', '0')  AS "MANAGER"
     , DECODE(JOB, 'PRESIDENT', '0')AS "PRESIDENT"
     , DECODE(JOB, 'ANALYST', '0')  AS "ANALYST"
     , DECODE(JOB, 'SALESMAN', '0') AS "SALESMAN"
  FROM EMP;
 
SELECT DEPTNO
     , DECODE(JOB, 'CLERK', '9')    AS "CLERK"
     , DECODE(JOB, 'MANAGER', '9')  AS "MANAGER"
     , DECODE(JOB, 'PRESIDENT', '9')AS "PRESIDENT"
     , DECODE(JOB, 'ANALYST', '9')  AS "ANALYST"
     , DECODE(JOB, 'SALESMAN', '9') AS "SALESMAN"
  FROM EMP;
 
SELECT DEPTNO
     , COUNT(DECODE(JOB, 'CLERK', '0'))     AS "CLERK"
     , COUNT(DECODE(JOB, 'MANAGER', '0'))   AS "MANAGER"
     , COUNT(DECODE(JOB, 'PRESIDENT', '0')) AS "PRESIDENT"
     , COUNT(DECODE(JOB, 'ANALYST', '0'))   AS "ANALYST"
     , COUNT(DECODE(JOB, 'SALESMAN', '0'))  AS "SALESMAN"
  FROM EMP
 GROUP BY DEPTNO;
 
SELECT *
  FROM (SELECT DEPTNO
             , JOB
             , EMPNO
          FROM EMP) PIVOT (COUNT(EMPNO) FOR JOB IN ('CLERK' AS "CLERK"
                     , 'MANAGER'                            AS "MANAGER"
                     , 'PRESIDENT'                          AS "PRESIDENT"
                     , 'ANALYST'                            AS "ANALYST"
                     , 'SALESMAN'                           AS "SALESMAN") )
 ORDER BY DEPTNO;
 
SELECT *
  FROM (SELECT DEPTNO AS "DEPTNO"
             , JOB    AS "JOB"
             , EMPNO  AS "EMPNO"
             , SAL    AS "SAL"
          FROM EMP) PIVOT ( COUNT(EMPNO) AS COUNT, SUM(NVL(SAL,0)) AS SUM FOR JOB IN ('CLERK' AS "C"
                     , 'MANAGER' AS "M"
                     , 'PRESIDENT' AS "P"
                     , 'ANALYST' AS "A"
                     , 'SALESMAN' AS "S") )
 ORDER BY DEPTNO;
 
--4.6 UNPIVOT() 함수
       
SELECT *
  FROM (SELECT DEPTNO                                               AS "DEPTNO"
             , JOB                                                  AS "JOB"
             , EMPNO                                                AS "EMPNO"
          FROM EMP) PIVOT ( COUNT(EMPNO) FOR JOB IN ('CLERK'        AS "CLERK"
                     , 'MANAGER'                                    AS "MANAGER"
                     , 'PRESIDENT'                                  AS "PRESIDENT"
                     , 'ANALYST'                                    AS "ANALYST"
                     , 'SALESMAN'                                   AS "SALESMAN") );
 
SELECT *
  FROM UPIVOT;
 
SELECT *
  FROM UPIVOT UNPIVOT ( EMPNO FOR JOB IN (CLERK
                     , MANAGER
                     , PRESIDENT
                     , ANALYST
                     , SALESMAN) );

