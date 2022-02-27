-- 1장 

select * from emp;

SELECT *
FROM tab;

SELECT empno, ename
FROM emp;
  
SELECT name, 'good morning~!' "Good Morning", 'good bye!' "GOOD BYE"
FROM professor;


SELECT dname, ', it''s deptno : ]', deptno "DNAME AND DEPTNO"
FROM dept;

SELECT dname, q'[, it's deptno : ]', deptno "DNAME AND DEPTNO"
FROM dept;

SELECT profno, name, pay
FROM professor;

SELECT profno "Prof'NO", name AS "Prof's NAME", pay Prof_Pay
FROM professor;

SELECT deptno
FROM emp;

SELECT DISTINCT deptno
FROM emp;

SELECT job, ename
FROM emp
ORDER BY 1,2;

SELECT DISTINCT job, ename
FROM emp
ORDER BY 1,2;

SELECT ename, job 
FROM emp;

SELECT ename || job 
FROM emp;

SELECT ename||' ''s job is '|| job "NAME AND JOB" FROM emp;


--연습문제
SELECT NAME || '''s ID : ' || ID || ', WEIGHT is ' || weight || 'Kg' AS "ID AND WEIGHT"
FROM student;

SELECT ename || '(' || job || ') , ' || ename || '''' || job || '''' AS "NAME AND JOB"
FROM emp;

SELECT ename || '''s sal is $' || sal
FROM emp;

SELECT empno, ename
FROM emp
WHERE empno = 7900;

SELECT ename, sal
FROM emp
WHERE sal < 1000;

SELECT empno, ename, sal
FROM emp
WHERE ename = 'SMITH';

SELECT ename, hiredate
FROM emp
where ename = 'SMITH';

SELECT ename, hiredate
FROM emp
WHERE hiredate >= '81/12/25';

SELECT ename, hiredate
FROM emp
WHERE hiredate = '17-DEC-80';

SELECT ename, hiredate
FROM emp
WHERE hiredate = '17-dec-80';

SELECT empno, ename, sal
FROM emp
WHERE deptno = 10;

SELECT ename, sal, sal+100
FROM emp
WHERE deptno = 10;

SELECT ename, sal, sal*1.1
FROM emp
WHERE deptno = 10;

SELECT empno, ename, sal
FROM emp
WHERE sal >= 4000;

SELECT empno, ename, sal
FROM emp
WHERE ename >= 'W';

SELECT ename, hiredate
FROM emp;

SELECT ename, hiredate
FROM emp
WHERE hiredate >= '1981/12/25';

SELECT empno, ename, sal
FROM emp
WHERE sal BETWEEN 2000 AND 3000;

SELECT empno, ename, sal
FROM emp
WHERE sal >= 2000
AND sal <= 3000;

SELECT ename
FROM emp
ORDER BY ename;

SELECT ename
FROM emp
WHERE ename BETWEEN 'JAMES' AND 'MARTIN'
ORDER BY ename;

SELECT empno, ename, deptno
FROM emp
WHERE deptno IN(10,20);

SELECT empno, ename, sal
FROM emp
WHERE sal LIKE '1%';

SELECT empno, ename, sal
FROM emp
WHERE ename LIKE 'A%';

SELECT empno, ename, hiredate
FROM emp
WHERE hiredate LIKE '80%';

SELECT empno, ename, hiredate
FROM emp
WHERE hiredate LIKE '__DEC%';

SELECT empno, ename, hiredate
FROM emp
WHERE hiredate LIKE '12/%';

SELECT empno, ename, hiredate
FROM emp
WHERE deptno IN(20,30);

SELECT empno, ename, comm
FROM emp
WHERE comm IS NULL;

SELECT empno, ename, comm
FROM emp
WHERE comm IS NOT NULL;

SELECT ename, hiredate, sal
FROM emp
WHERE hiredate > '82/01/01'
AND sal >= 1300;

SELECT ename, hiredate, sal
FROM emp
WHERE hiredate > '01/JAN/82'
OR sal >= 1300;

SELECT empno, ename, sal, comm
FROM emp
WHERE sal > 100
AND (comm <1000 OR comm IS NULL);

SELECT empno, ename, sal, comm
FROM emp
WHERE sal > 100
AND comm <1000 OR comm IS NULL;

SELECT empno, ename, sal
FROM emp
WHERE empno = &empno;

SELECT empno, ename, sal
FROM &table
WHERE sal = 3000;

SELECT ename, sal, hiredate
FROM emp;

SELECT ename, sal, hiredate
FROM emp
ORDER BY ename;

SELECT ename, sal, hiredate
FROM emp
ORDER BY deptno ASC, sal DESC;

SELECT ename, sal, hiredate
FROM emp
WHERE sal > 1000
ORDER BY 2, 1;

SELECT studno, name, deptno1, 1 "테이블 병합 구분 번호"
FROM student
WHERE deptno1 = 101
UNION 
SELECT profno, name, deptno, 2
FROM professor
WHERE deptno = 101;

SELECT studno, name, deptno1, 1 "테이블 병합 구분 번호"
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT profno, name, deptno, 2
FROM professor
WHERE deptno = 101;

SELECT studno, name
FROM student
WHERE deptno1 = 101
UNION
SELECT studno, name
FROM student
WHERE deptno2 = 201;

SELECT studno, name
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT studno, name
FROM student
WHERE deptno2 = 201;

SELECT studno, name
FROM student
WHERE deptno1 = 101
INTERSECT
SELECT studno, name
FROM student
WHERE deptno2 = 201;


SELECT empno, ename, sal
FROM emp
MINUS
SELECT empno, ename, sal
FROM emp
WHERE sal > 2500;


