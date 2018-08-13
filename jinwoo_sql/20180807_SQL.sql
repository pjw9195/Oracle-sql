-- 2
select country_id, country_name
from countries
minus
select c.country_id, country_name
from countries c, locations l, departments d, employees e
where c.country_id = l.country_id
and l.location_id = d.location_id
and d.department_id = e.department_id;

--
select * from emp;
select * from dept;


-- 칼럼에대한 데이터타입을 꼭 맞춰줘야 한다.
insert into emp
values(501, 'Smith', 5000, 50);
commit; -- 저장

insert into emp(ename, sal, empno)
values();



insert into emp
select employee_id first_name, salary, department_id
from employees
where employee_id<= 110;

update emp
set deptno = 70;
where deptno is null;

update emp
set deptno = 110
where sal = (select sal from emp where empno =104 ) and empno =! 104;


-- 저장하지않고 빠져나오겟다. commit하기전에 데이터가 원래대로 돌아온다.
rollback;

update emp
set sal = (select sal from emp
            where empno = 110)
where empno = 119;

commit;

delete dept
where deptno = 10;

delete emp
where deptno in (select deptno from emp
                where sal = 8200);
                
update dept set create_dt = to_date('2018/01/01' ,'yyyy/mm/dd')
where deptno>+ 100;

savepoint upd;

rollback to saverpoint upd;

-- table emp에 칼럼 추가
alter table emp add(dname varchar2(50));

select * from emp;

update eno
set dname = (select dname from dept
            where dept.deptno = emp.deptno);
            
--새로운 테이블생성

create table emp_sample
( emp_id number,
  lname char(30),
  fname varchar2(30),
  hiredate date,
  dept_id number);

-- emp_sample table 에 employees table을 복사
insert into emp_sample 
select employee_id,last_name,first_name,null,department_id
from employees
where department_id <= 30;

rollback;

select *
from emp_sample;

select lname||fname, fname||lname
from emp_sample;

select* from emp_sample
where lname = 'Fay';

select sysdate, systimestamp
from dual;

create table dept_test
( deptno number constraint deptno_pk primary key,
  dname varchar2(30) not null,
  loc varchar2(30));

-- table 삭제
drop table dept_test purge;

create table emp_test
(empno number,
lname varchar2(25) not null,
fname varchar2(25) not null,
salary number constraint salary_ch check (salary> 5000), -- check 는 참이어야 하는 조건
deptno number,
constraint empno_pk primary key(empno), -- 테이블의 각 행이 값이 다 달라야 한다.
constraint deptno_fk foreign key(deptno) references dept_test(deptno)); -- 한테이블의 값이 다른테이블의 값과 같아야 한다

insert into emp_test
select employee_id, last_name, first_name, salary, department_id
from employees
where salary>10000;

insert into dept_test (deptno, dname)
select department_id, department_name
from departments;


select *
from dept_test;

commit;
drop table dept_test purge;