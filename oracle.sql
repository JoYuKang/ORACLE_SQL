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
--WHERE REGEXP_LIKE(tel, '^[0-9]{2}[^0-9]');

SELECT name, id
FROM student 
WHERE REGEXP_LIKE(id, '^...r.');

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

--  공백이 ( ) 한칸이지만 뒤 {2}가 두번 반복 이상이면 작동 뒤에 {2,}이거는 ,가 뭐지? 업어도 가능한데
SELECT REGEXP_REPLACE('aaa bbb','(){2,}','') "One" ,
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
