--as로 이름 치환
select  employee_id, last_name, job_id, hire_date as "startdate"
from    employees;

--|| 을 이용한 문자열 병합
select  last_name ||', '|| job_id as "Employee and Title" 
from    employees;


--table 생성
create table    emp
as
select  employee_id empno,
        first_name ename,
        salary sal,
        department_id deptno
from employees
where employee_id in(119,200,201,202);

create table    dept
as
select  department_id deptno,
        department_name dname
from    departments
where   department_id in (10,20,30,40);