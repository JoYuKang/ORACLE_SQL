-- 2장

SELECT ename, INITCAP(ename) "INITCAP" 
FROM emp 
WHERE deptno = 10;

SELECT name, INITCAP(name) "INITCAP" 
FROM professor 
WHERE deptno = 101;

SELECT ename, LOWER(ename) "LOWER" , UPPER(ename) "UPPER" 
FROM emp
WHERE deptno = 10;


SELECT ename, LENGTH(ename) "LENGTH", LENGTHB(ename) "LENGTH"
FROM emp 
WHERE deptno = 20;

SELECT '서진수' "NAME", LENGTH('서진수') "LENGTH", LENGTHB('서진수') "LENGTHB" 
FROM dual;

SELECT ename, LENGTH(ename)
FROM emp 
WHERE LENGTH(ename) > LENGTH('smith');

SELECT CONCAT(ename, job) 
FROM emp 
WHERE deptno=10;

SELECT SUBSTR('abcde',3,2) "3,2", SUBSTR('abcde',-3,2) "-3,2", SUBSTR('abcde',-3,4) "-3,4" 
FROM dual;

SELECT name, SUBSTR(jumin,3,4) "Birthday", SUBSTR(jumin,3,4) -1 "Birthday - 1" 
FROM student 
WHERE deptno1 = 101;

SELECT '서진수' "NAME", SUBSTR('서진수',1,2) "SUBSTR", SUBSTRB('서진수',1,3) "SUBSTRB" 
FROM dual;

SELECT 'A-B-C-D', INSTR('A-B-C-D', '-',1,3) "INSTR" 
FROM dual;

SELECT 'A-B-C-D', INSTR('A-B-C-D', '-',3,1) "INSTR" 
FROM dual;

SELECT 'A-B-C-D', INSTR('A-B-C-D', '-',-1,3) "INSTR" 
FROM dual;

SELECT 'A-B-C-D', INSTR('A-B-C-D', '-',-6,2) "INSTR" 
FROM dual;

SELECT name, tel, INSTR(tel,')') 
FROM student 
WHERE deptno1 = 201;

SELECT name, tel, INSTR(tel,'3') 
FROM student 
WHERE deptno1 = 101;

SELECT name, id, LPAD(id,10,'*') 
FROM student 
WHERE deptno1 = 201;

SELECT RPAD(ename, 10, '-') "RPAD"
FROM emp 
WHERE deptno =10;

SELECT ename 
FROM emp 
WHERE deptno = 10;

SELECT LTRIM(ename, 'C') 
FROM emp 
WHERE deptno = 10;

SELECT ename,RTRIM(ename, 'R') "RTRIM"
FROM emp 
WHERE deptno = 10;

SELECT ename,REPLACE(ename, SUBSTR(ename,1,2),'**') "REPLACE" 
FROM emp 
WHERE deptno = 10;

SELECT ename,REPLACE(ename, SUBSTR(ename,3,2),'--') "REPLACE" 
FROM emp
WHERE deptno = 20;

SELECT name, jumin, REPLACE(jumin, SUBSTR(jumin,-7,7),'-/-/-/-') "REPLACE" 
FROM student
WHERE deptno1 = 101;

SELECT name, tel, REPLACE(tel, SUBSTR(tel,5,3),'***') "REPLACE" 
FROM student
WHERE deptno1 = 102;

SELECT name, tel, REPLACE(tel, SUBSTR(tel,-4,4),'****') "REPLACE" 
FROM student
WHERE deptno1 = 102;

SELECT ROUND(987.654,2) "ROUND1", ROUND(987.654,0) "ROUND2", ROUND(987.654,-1) "ROUND3" 
FROM dual;

SELECT TRUNC(987.654,2) "TRUNC1", TRUNC(987.654,0) "TRUNC2", TRUNC(987.654,-1) "TRUNC3" 
FROM dual;

SELECT MOD(121,10) "MOD", CEIL(123.45) "CEIL", FLOOR(123.45) "FLOOR" 
FROM dual;

SELECT rownum "ROWNO", CEIL(rownum/3) "TEAMNO", ename
FROM emp;

SELECT POWER(2,3) 
FROM dual;

SELECT SYSDATE 
FROM dual;

SELECT MONTHS_BETWEEN('14/09/30','14/08/31')
FROM dual;

SELECT MONTHS_BETWEEN('14/08/31','14/09/30') 
FROM dual;

SELECT MONTHS_BETWEEN('12/02/29','12/02/01') 
FROM dual;

SELECT MONTHS_BETWEEN('14/04/30','14/04/01')
FROM dual;

SELECT MONTHS_BETWEEN('14/05/31','14/05/01')
FROM dual;

SELECT MONTHS_BETWEEN('12/03/01','12/02/28')
FROM dual;

SELECT MONTHS_BETWEEN('14/03/01','14/02/28')
FROM dual;

SELECT SYSDATE, MONTHS_BETWEEN('15/05/31','15/04/30')
FROM dual;

SELECT ename, hiredate, ROUND(MONTHS_BETWEEN(TO_DATE('04/05/31'),hiredate),1) "DATE1",
                        ROUND(((TO_DATE('04/05/31') - hiredate)/31),1) "DATE2"
FROM emp
WHERE deptno = 10;

SELECT SYSDATE, ADD_MONTHS(SYSDATE,1)
FROM dual;

SELECT SYSDATE, NEXT_DAY(SYSDATE,'월') 
FROM dual;

-- 해당 요일 기준 요일을 기준으로 월화수목금 추가 
-- EX) 당일이 화요일 
-- 일 5 월 6 화 7 수 1 목 2 금 3 토 4
SELECT SYSDATE, NEXT_DAY('14/05/01','월')
FROM dual;

SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY('14/05/01') 
FROM dual;

SELECT SYSDATE, ROUND(SYSDATE), TRUNC(SYSDATE) 
FROM dual;

SELECT 2+'2'
FROM dual;

SELECT 2+TO_NUMBER('2')
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY') "YYYY",
                TO_CHAR(SYSDATE, 'RRRR') "RRRR",
                TO_CHAR(SYSDATE, 'YY') "YY",
                TO_CHAR(SYSDATE, 'RR') "RR",
                TO_CHAR(SYSDATE, 'YEAR') "YEAR"
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'MM') "MM",
                TO_CHAR(SYSDATE, 'MON') "MON",
                TO_CHAR(SYSDATE, 'MONTH') "MONTH"
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD') "DD",
                TO_CHAR(SYSDATE, 'DAY') "DAY",
                TO_CHAR(SYSDATE, 'DDTH') "DDTH"
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE,'RRRR-MM-DD:HH24:MI:SS')
FROM dual;

SELECT empno, ename, sal, comm, TO_CHAR((sal*12)+comm, '999,999') "SALARY"
FROM emp
WHERE ename = 'ALLEN';

SELECT name, pay, bonus, TO_CHAR((pay*12)+bonus, '999,999') "TOTAL"
FROM professor 
WHERE deptno = 201;

SELECT TO_NUMBER('5')
FROM dual;

SELECT ASCII('A') 
FROM dual;

SELECT TO_DATE('14/05/31') 
FROM dual;

SELECT TO_DATE('2014/05/31') 
FROM dual;

SELECT ename, comm, NVL(comm,0), NVL(comm,100) 
FROM emp 
WHERE deptno =30;

SELECT empno, ename, sal, comm, NVL2(comm, sal+comm, sal * 0) "NVL2" 
FROM emp 
WHERE deptno =30;

SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering') "DNAME" 
FROM professor;

SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering', 'ETC') "DNAME" 
FROM professor;

SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering', 
                                    102, 'Multimedia Engineering',
                                    103, 'Software Engineering', 
                                         'ETC') "DNAME" 
FROM professor;

SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!')) "ETC" 
FROM professor;

SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!', 'GOOD!')) "ETC" 
FROM professor;

SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!', 'GOOD!'), 'N/A') "ETC" 
FROM professor;

SELECT name, jumin, DECODE(substr(jumin,7, 1), '1', 'MEN','2', 'WOMAN', '3', 'MAN', '4', 'WOMAN') "GENDER"
FROM student
WHERE deptno1 = 101;

SELECT name, tel, DECODE(SUBSTR(tel, 1, INSTR(tel, ')') -1), '02', 'SEOUL', '031', 'GYEONGGI', '051', 'BUSAN', '052', 'ULSAN', '055', 'GYEONGNAM', 'TEC')
FROM student
WHERE deptno1 = 101;

SELECT name, tel,
       CASE(SUBSTR(tel,1,INSTR(tel,')')-1)) WHEN '02' THEN 'SEOUL'
                                            WHEN '031' THEN 'GYEONGGI'
                                            WHEN '051' THEN 'BUSAN'
                                            WHEN '052' THEN 'ULSAN'
                                            WHEN '055' THEN 'GYEONGNAM'
                                                       ELSE 'ETC'
       END "LOC"
FROM student
WHERE deptno1 = 201;

SELECT name, SUBSTR(jumin,3,2) "MONTH",
       CASE WHEN SUBSTR(jumin,3,2) BETWEEN '01' AND '03' THEN '1/4'
            WHEN SUBSTR(jumin,3,2) BETWEEN '04' AND '06' THEN '2/4'
            WHEN SUBSTR(jumin,3,2) BETWEEN '07' AND '09' THEN '3/4'
            WHEN SUBSTR(jumin,3,2) BETWEEN '10' AND '12' THEN '4/4'
       END "Quarter"
FROM student;

SELECT empno, ename, sal, CASE WHEN SAL BETWEEN 0 AND 1000 THEN 'LEVEL 1'
                               WHEN SAL BETWEEN 1001 AND 2000 THEN 'LEVEL 2'
                               WHEN SAL BETWEEN 2001 AND 3000 THEN 'LEVEL 3'
                               WHEN SAL BETWEEN 3001 AND 4000 THEN 'LEVEL 4'
                               WHEN SAL > 4001 THEN 'LEVEL 5' END  "LEVEL"
FROM emp;


SELECT * 
FROM t_reg;

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '[a-z]');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[A-Z]');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '[a-zA-Z]');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[a-z] ');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[a-z] [0-9]');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[[:space:]]');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[A-Z]{2}');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '[A-Z]{3}');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '[A-Z]{4}');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '[0-9]{3}');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[A-Z][0-9]{3}');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '[0-9][A-Z]{3}');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '[A-Z]');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '[[:upper:]]');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '^[A-Za-z]');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '^[0-9A-Z]');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '^[a-z]|^[0-9]');

SELECT name, id 
FROM student 
WHERE REGEXP_LIKE(id, '^M(a|o)');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[a-zA-Z]$');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[[:alpha:]]$');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '^[^a-z]');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '^[^0-9]');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '^[^0-9a-z]');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[^a-z]');

SELECT * FROM t_reg
WHERE NOT REGEXP_LIKE(text, '[a-z]');

SELECT name, tel
FROM student 
WHERE REGEXP_LIKE(tel, '^[0-9]{2}\)[0-9]{4}');

SELECT name, id
FROM student 
WHERE REGEXP_LIKE(id, '^^...r.');

SELECT * FROM t_reg2;

SELECT * FROM t_reg2
WHERE REGEXP_LIKE(ip, '^[10]{2}\.[10]{2}\.[10]{2}');

SELECT * FROM t_reg2 
WHERE REGEXP_LIKE(ip, '^[172]{3}\.[16]{2}\.[168]{3}');

SELECT * FROM t_reg 
WHERE NOT REGEXP_LIKE(text, '[a-zA-Z]');

SELECT * FROM t_reg 
WHERE NOT REGEXP_LIKE(text, '[0-9]');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '!');

SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '?');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '*');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '\?');

SELECT * FROM t_reg 
WHERE REGEXP_LIKE(text, '\*');

SELECT * FROM t_reg 
WHERE NOT REGEXP_LIKE(text, '\?');

SELECT text, REGEXP_REPLACE(text, '[[:digit:]]', '*') "NO -> CHAR" 
FROM t_reg;

SELECT text, REGEXP_REPLACE(text, '[0-9]', '\1-*') "Add Char" 
FROM t_reg;

SELECT no, ip, REGEXP_REPLACE(ip, '\.', '') "DOT REMOVE"
FROM t_reg2;

SELECT no, ip, REGEXP_REPLACE(ip, '\.', '/', 1, 1) "REPLACE"
FROM t_reg2;

SELECT REGEXP_REPLACE('aaa bbb','[[:space:]]','') 
FROM dual;

SELECT REGEXP_REPLACE('aaa bbb','( ){2,}','') "One" ,
       REGEXP_REPLACE('aaa  bbb','( ){2,}','') "Two"
FROM dual;

SELECT REGEXP_REPLACE('aaa bbb','( ){2,}','*') "One" ,
       REGEXP_REPLACE('aaa  bbb','( ){2,}','*') "Two" ,
       REGEXP_REPLACE('aaa   bbb','( ){2,}','*') "Two"
FROM dual;

SELECT studno, name, id
FROM student
WHERE id=REGEXP_REPLACE('75 true','( ){1,}','');

SELECT studno, name, id
FROM student
WHERE id=LOWER(REGEXP_REPLACE('75 TRUE','( ){1,}',''));

SELECT REGEXP_REPLACE('20141023',
                      '([[:digit:]]{4})([[:digit:]]{2})([[:digit:]]{2})',
                      '\1-\2-\3')
FROM dual;

SELECT REGEXP_SUBSTR('ABC* *DEF $GHI%KJL','[^ ]+[DEF]') 
FROM dual;

-- ★ alnum은 모든 문자(alpha + digit) 
SELECT name, LTRIM(REGEXP_SUBSTR(hpage,'/([[:alnum:]]+\.?){3,4}?'),'/') "URL" 
FROM professor 
WHERE hpage IS NOT NULL;

SELECT name, LTRIM(REGEXP_SUBSTR(email,'@([[:alnum:]]+\.?){3,4}?'),'@') "domain" 
FROM professor 
WHERE deptno IN (101,201) ;

SELECT REGEXP_SUBSTR('sys/oracle@racdb:1521:racdb','[^:]+',1,3) "result"
FROM dual;

SELECT REGEXP_SUBSTR('sys/oracle@racdb:1521:racdb','[^:]+',1,2) "result"
FROM dual;

SELECT REGEXP_SUBSTR('sys/oracle@racdb:1521:rac','[^/:]+',1,2) "result"
FROM dual;

SELECT REGEXP_SUBSTR('sys/oracle@racdb:1521:rac','[^/:]+',1,1) "result"
FROM dual;

SELECT text, REGEXP_COUNT(text, 'A') 
FROM t_reg;

SELECT text, REGEXP_COUNT(text, 'c', 3)
FROM t_reg;

SELECT text, REGEXP_COUNT(text, 'c') "RESULT 1" ,
             REGEXP_COUNT(text, 'c', 1, 'i') "RESULT 2"
FROM t_reg;

SELECT text, REGEXP_COUNT(text, '.') "RESULT 1" ,
             REGEXP_COUNT(text, '\.') "RESULT 2"
FROM t_reg;

SELECT text, REGEXP_COUNT(text, 'aa') "RESULT 1" ,
             REGEXP_COUNT(text, 'a{2}') "RESULT 2" ,
             REGEXP_COUNT(text, '(a)(a)') "RESULT 3"
FROM t_reg;
