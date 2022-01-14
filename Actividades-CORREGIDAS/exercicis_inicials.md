### Consultes bàsiques
**Mostreu el codi d’empleat, salari, comissió, n o de departament i data de la taula EMP.**
scott=# SELECT empno, sal, comm, deptno, hiredate FROM emp;
 empno |   sal   |  comm   | deptno |  hiredate  
-------+---------+---------+--------+------------
  7369 |  800.00 |         |     20 | 1980-10-17
  7499 | 1600.00 |  300.00 |     30 | 1981-02-20
  7521 | 1250.00 |  500.00 |     30 | 1981-02-22
  7566 | 2975.00 |         |     20 | 1981-04-02
  7654 | 1250.00 | 1400.00 |     30 | 1981-09-28
  7698 | 2850.00 |         |     30 | 1981-05-01
  7782 | 2450.00 |         |     10 | 1981-06-09
  7788 | 3000.00 |         |     20 | 1982-12-09
  7839 | 5000.00 |         |     10 | 1981-11-17
  7844 | 1500.00 |    0.00 |     30 | 1981-09-08
  7876 | 1100.00 |         |     20 | 1983-01-12
  7900 |  950.00 |         |     30 | 1981-12-03
  7902 | 3000.00 |         |     20 | 1981-12-03
  7934 | 1300.00 |         |     10 | 1982-01-23
(14 rows)

**Mostra tota la informació de la taula departaments.**
scott=# SELECT * FROM dept;
 deptno |   dname    |   loc    
--------+------------+----------
 10 | ACCOUNTING | NEW YORK
 20 | RESEARCH   | DALLAS
 30 | SALES      | CHICAGO
 40 | OPERATIONS | BOSTON
(4 rows)

**Mostreu el nom i l’ocupació d’aquells que siguin salesman.**
scott=# SELECT ename FROM emp WHERE job = 'SALESMAN';
 ename  
--------
 ALLEN
 WARD
 MARTIN
 TURNER
(4 rows)

**Mostreu el nom i el codi de departament d’aquells empleats que no treballen en el departament 30.**
scott=# SELECT dname, deptno FROM dept WHERE deptno != 30;
   dname    | deptno
------------+--------
 ACCOUNTING |     10
 RESEARCH   |     20
 OPERATIONS |     40
(3 rows)

**Mostreu els empleats que treballen en els departaments 10 y 20 (es vol les dues solucions).**
scott=# SELECT dname, deptno FROM dept WHERE deptno = 10 OR deptno = 20;
   dname    | deptno
------------+--------
 ACCOUNTING |     10
 RESEARCH   |     20
(2 rows)

**Mostreu el nom i salari d’aquells empleats que guanyin més de 2000.**
scott=# SELECT ename, deptno FROM emp WHERE deptno = 10 OR deptno = 20;
 ename  | deptno
--------+--------
 SMITH  |     20
 JONES  |     20
 CLARK  |     10
 SCOTT  |     20
 KING   |     10
 ADAMS  |     20
 FORD   |     20
 MILLER |     10
(8 rows)

**Mostreu el nom i la data de contractació d’aquells empleats que hagin entrat abans de l’1/1/82.**
scott=# SELECT ename, hiredate FROM emp WHERE hiredate < '1982-01-01';
 ename  |  hiredate  
--------+------------
 SMITH  | 1980-10-17
 ALLEN  | 1981-02-20
 WARD   | 1981-02-22
 JONES  | 1981-04-02
 MARTIN | 1981-09-28
 BLAKE  | 1981-05-01
 CLARK  | 1981-06-09
 KING   | 1981-11-17
 TURNER | 1981-09-08
 JAMES  | 1981-12-03
 FORD   | 1981-12-03
(11 rows)
-------------------------------------------------------------------------------------------------------
scott=# SELECT ename, to_char(hiredate, 'YYYY') "Any" FROM emp WHERE to_char(hiredate, 'YYYY') < '1982';
 ename  | Any  
--------+------
 SMITH  | 1980
 ALLEN  | 1981
 WARD   | 1981
 JONES  | 1981
 MARTIN | 1981
 BLAKE  | 1981
 CLARK  | 1981
 KING   | 1981
 TURNER | 1981
 JAMES  | 1981
 FORD   | 1981
(11 rows)

**Mostreu el nom dels salesmans que guanyin més de 1500.**
scott=# SELECT ename FROM emp WHERE job = 'SALESMAN' AND sal > 1500;
 ename
-------
 ALLEN
(1 row)

**Mostreu el nom d’aquells que siguin ‘Clerk’ o treballin en el departament 30.**
scott=# SELECT ename, deptno FROM emp WHERE job = 'CLERK' OR deptno = 30;
 ename  | deptno
--------+--------
 SMITH  |     20
 ALLEN  |     30
 WARD   |     30
 MARTIN |     30
 BLAKE  |     30
 TURNER |     30
 ADAMS  |     20
 JAMES  |     30
 MILLER |     10
(9 rows)

**Mostreu aquells que es diguin ‘SMITH’, ‘ALLEN’ o ‘SCOTT’.**
scott=# SELECT ename FROM emp WHERE ename = 'SMITH' OR ename = 'ALLEN' OR ename = 'SCOTT';
 ename
-------
 SMITH
 ALLEN
 SCOTT
(3 rows)

**Mostreu aquells que no es diguin ‘SMITH’, ‘ALLEN’ o ‘SCOTT’.**
scott=# SELECT ename FROM emp WHERE ename != 'SMITH' AND ename != 'ALLEN' AND ename != 'SCOTT';
 ename  
--------
 WARD
 JONES
 MARTIN
 BLAKE
 CLARK
 KING
 TURNER
 ADAMS
 JAMES
 FORD
 MILLER
(11 rows)

**Mostreu aquells el salari estigui entre 2000 i 3000.**
scott=# SELECT ename, sal FROM emp WHERE sal BETWEEN 2000 AND 3000;
 ename |   sal   
-------+---------
 JONES | 2975.00
 BLAKE | 2850.00
 CLARK | 2450.00
 SCOTT | 3000.00
 FORD  | 3000.00
(5 rows)

**Mostreu aquells empleats que treballin en el departament 10 o 20.**
scott=> SELECT ename, deptno FROM emp WHERE deptno = 10 OR deptno = 20;
 ename  | deptno
--------+--------
 SMITH  |     20
 JONES  |     20
 CLARK  |     10
 SCOTT  |     20
 KING   |     10
 ADAMS  |     20
 FORD   |     20
 MILLER |     10
(8 rows)

**Mostreu aquells empleats el nom comenci per ‘A’.**
scott=# SELECT ename FROM emp WHERE ename LIKE 'A%';
 ename
-------
 ALLEN
 ADAMS
(2 rows)

**Mostreu aquells empleats el nom tingui com a segona lletra una “D”.**
scott=# SELECT ename FROM emp WHERE ename LIKE '\_D%;
 ename
-------
 ADAMS
(1 row)

**Mostreu els diferents departaments que hi ha a la taula EMP.**
scott=# SELECT DISTINCT deptno FROM emp;
 deptno
--------
 30
 10
 20
(3 rows)

**Mostreu el departament i el treball dels empleats (evitant repeticions).**
scott=# SELECT DISTINCT deptno, job FROM emp;
 deptno |    job    
--------+-----------
     20 | CLERK
     30 | MANAGER
     10 | MANAGER
     10 | PRESIDENT
     20 | ANALYST
     30 | SALESMAN
     10 | CLERK
     20 | MANAGER
     30 | CLERK
(9 rows) 

**Mostreu aquells empleats que hagin entrat al 1981.**
scott=# SELECT ename, hiredate FROM emp WHERE hiredate > '1980-12-31' AND hiredate < '1982-01-01';
 ename  |  hiredate  
--------+------------
 ALLEN  | 1981-02-20
 WARD   | 1981-02-22
 JONES  | 1981-04-02
 MARTIN | 1981-09-28
 BLAKE  | 1981-05-01
 CLARK  | 1981-06-09
 KING   | 1981-11-17
 TURNER | 1981-09-08
 JAMES  | 1981-12-03
 FORD   | 1981-12-03
(10 rows)
------------------------------------------------------------------------
scott=# SELECT ename, to_char(hiredate, 'YYYY') "Any" FROM emp WHERE to_char(hiredate, 'YYYY') = '1981';
 ename  | Any  
--------+------
 ALLEN  | 1981
 WARD   | 1981
 JONES  | 1981
 MARTIN | 1981
 BLAKE  | 1981
 CLARK  | 1981
 KING   | 1981
 TURNER | 1981
 JAMES  | 1981
 FORD   | 1981
(10 rows)

**Mostreu aquells empleats que tenen comissió, mostrant nom i comissió.**
scott=> SELECT ename FROM emp where comm IS NOT NULL;
 ename  
--------
 ALLEN
 WARD
 MARTIN
 TURNER
(4 rows)

**Mostreu aquells empleats que guanyin més de 1500, ordenats per ocupació.**
scott=# SELECT ename, job FROM emp WHERE sal > 1500 ORDER BY 2;
 ename |    job    
-------+-----------
 FORD  | ANALYST
 SCOTT | ANALYST
 BLAKE | MANAGER
 CLARK | MANAGER
 JONES | MANAGER
 KING  | PRESIDENT
 ALLEN | SALESMAN
(7 rows)

**Calcular el salari anual a percebre per cada empleat (tingueu en compte 14 pagues).**
scott=> SELECT empno, ename, sal, (sal * 14) AS "Salari anual" FROM emp;
 empno | ename  |   sal   | Salari anual 
-------+--------+---------+---------------
  7369 | SMITH  |  800.00 |      11200.00
  7499 | ALLEN  | 1600.00 |      22400.00
  7521 | WARD   | 1250.00 |      17500.00
  7566 | JONES  | 2975.00 |      41650.00
  7654 | MARTIN | 1250.00 |      17500.00
  7698 | BLAKE  | 2850.00 |      39900.00
  7782 | CLARK  | 2450.00 |      34300.00
  7788 | SCOTT  | 3000.00 |      42000.00
  7839 | KING   | 5000.00 |      70000.00
  7844 | TURNER | 1500.00 |      21000.00
  7876 | ADAMS  | 1100.00 |      15400.00
  7900 | JAMES  |  950.00 |      13300.00
  7902 | FORD   | 3000.00 |      42000.00
  7934 | MILLER | 1300.00 |      18200.00
(14 rows)

**Mostreu el nom de l’empleat, el salari i l’increment de l’15% de l’salari.**
scott=# SELECT ename, (sal * 0.15) AS "Increment" FROM emp;
 ename  | Increment
--------+-----------
 SMITH  |  120.0000
 ALLEN  |  240.0000
 WARD   |  187.5000
 JONES  |  446.2500
 MARTIN |  187.5000
 BLAKE  |  427.5000
 CLARK  |  367.5000
 SCOTT  |  450.0000
 KING   |  750.0000
 TURNER |  225.0000
 ADAMS  |  165.0000
 JAMES  |  142.5000
 FORD   |  450.0000
 MILLER |  195.0000
(14 rows)

**Mostreu el nom de l’empleat, el salari, l’increment de l’15% de l’salari i el salari augmentat un 15%.**
scott=> SELECT ename, sal, (sal * 0.15) AS "Increment", (sal * 1.15) AS "Salario incrementat" FROM emp;
 ename  |   sal   | Increment  | Salari incrementat 
--------+---------+------------+----------------------
 SMITH  |  800.00 |   120.0000 |             920.0000
 ALLEN  | 1600.00 |   240.0000 |            1840.0000
 WARD   | 1250.00 |   187.5000 |            1437.5000
 JONES  | 2975.00 |   446.2500 |            3421.2500
 MARTIN | 1250.00 |   187.5000 |            1437.5000
 BLAKE  | 2850.00 |   427.5000 |            3277.5000
 CLARK  | 2450.00 |   367.5000 |            2817.5000
 SCOTT  | 3000.00 |   450.0000 |            3450.0000
 KING   | 5000.00 |   750.0000 |            5750.0000
 TURNER | 1500.00 |   225.0000 |            1725.0000
 ADAMS  | 1100.00 |   165.0000 |            1265.0000
 JAMES  |  950.00 |   142.5000 |            1092.5000
 FORD   | 3000.00 |   450.0000 |            3450.0000
 MILLER | 1300.00 |   195.0000 |            1495.0000
(14 rows)

### EXERCICI EXTRA:
scott=# SELECT DISTINCT deptno, comm FROM emp WHERE comm IS NULL;
 deptno | comm
--------+------
     10 |     
     20 |     
     30 |     
(3 rows)
