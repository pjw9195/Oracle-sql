update emp1 set deptno = 300
where deptno is null;

create table emp1
(empno number primary key,
ename varchar2(30) not null,
deptno number references dept_test(deptno) on delete cascade);


create table emp2
(empno number primary key,
ename varchar2(30) not null,
deptno number references dept_test(deptno) on delete set null);


insert into emp1 select employee_id, first_name, department_id from employees;

insert into emp2 select employee_id, first_name, department_id from employees;

delete emp1 where empno = 102;

insert into dept_test values(300,'Testing',null);
update dept_test set deptno = 350
where deptno =10;
-- primary foriegn 은 delete는 자유롭다.
-- primary 에서 insert into 할때는 전혀 foriegn 에 영향을 받지 않는다.
-- update 는 foriegn 에 영향을 받는다. 왜냐하면 primary 에서 foriegn 에 있는 값을 update 해버리면 에러가 난다. 
delete dept_test where deptno = 50;

-- as는 구조를 복제한 후 내용을 복제한다.
create table sample1
as
select * from employees;

-- select으로 칼럼의 이름을 정할 수 있다.
create table sample2
as
select department_id deptno, job_id job, avg(salary) avg_sal
from employees
group by department_id, job_id
order by department_id, job_id;

-- alter table 은 add를 통해 칼럼을 추가한다.
alter table sample2 add(emp_cnt number);
-- modify 로 칼럼의 타입을 바꿀 수 있다.
alter table sample2 modify(job varchar2(20));
desc sample2;

-- default는 
alter table dept_test add(create_dt date default sysdate);
-- 칼럼 드랍
alter table dept_test drop column create_dt;
-- 칼럼의 이름 변경
alter table dept_test rename column deptno to dept_id;


-- 읽기 전용상태 
select * from sample2;

alter table sample2 read only;
/* 테이블을 select만 허용하게 하였음 (읽기전용)
   모든 ddl 작업이 먹히지 않는다..! */
delete sample2;
/* delete가 되지 않는다..! */

alter table sample2 read write;
/* 다시 편집 전용으로 변경함. */

-- table level에서 한 제약조건
create table member
(member_id number(10) not null,
first_name   varchar2(25) not null,
last_name varchar2(25),
address varchar2(100),
city varchar2(30),
phone varchar2(15),
join_date date default sysdate not null,
constraint member_id_pk primary key(member_id),
constraint last_name_uk unique(last_name));

-- collum level에서 한 제약조건
create table title
(title_id number(10) primary key,
title varchar2(60) not null,
description varchar2(400) not null,
rating varchar2(4),
category VARCHAR2(20) check(category in ('DRAMA', 'COMEDY','ACTION','CHILD','DOCU')),
release_date date);

-- 여러개의 칼럼이 primary key가 구성되어있으면 에러가 난다. 해결하기위해선 무조건 table level에서 제약조건을 해주어야한다.
create table reservation
(res_date date,
member_id number(10),
title_id number(10),
constraint reservation_pk primary key (res_date,member_id,title_id),
constraint member_fk foreign key(member_id) references member(member_id),
constraint title_fk foreign key(title_id) references title(title_id)
);


select *
from sal_top_v
where rownum <=10;

select *
from (select department_id, job_id, avg(salary)
from employees
group by department_id,job_id
order by avg(salary) desc)
where rownum <=3;

-- view를 사용하여 복잡한 query 를 단순화한다.
create view sal_top_v
as
select employee_id, first_name, salary from employees order by salary desc;

-- avg 함수같은 함수를 view 에서 사용하고싶으면 as로 이름을 따로 해준다음 사용해야 한다.
create view avg_sal_top
as
select department_id, job_id, avg(salary) avg_sal
from employees
group by department_id, job_id
order by avg(salary) desc;

select department_id, job_id avg_sal
from avg_sal_top;

-- 모든 view들은 웬만해서는 DML이 불가능하다

-- with check option constraint 에 의해 50번으로 바꿀수가 없다. null값이 되므로 또한 insert할땐 20번만 넣을수 있다.
create or replace view empvu20
as select *
from employees
where department_id = 20
with check option constraint empvu20_ck;

update empvu20 set department_id = 50;
select *from empvu20;

-- sequence는 내가 원하는 함수를 만들 수 있다.
-- insert 할때 사용한다.
create sequence seq1;

create sequence seq2
start with 10
increment by 5
maxvalue 200
cycle;

create sequence dept_seq
start with 400
increment by 10;

select seq1.nextval from dual;
select seq2.nextval from dual;
-- 빈공간에 저절로 들어간다. 그래서 순서가 차례대로 들어가지 않는다.
insert into dept_test
values(dept_seq.nextval, 'BBB',null);

select*from dept_test;

-- alter sequence 로 시퀀스 수정을 할 수 있는데 start with는 바꿀수가없다.

-- 4
create sequence member_id_seq
start with 101;

-- 5
create sequence title_id_seq
start with 92;

-- 6
insert into member
values(member_id_seq.nextval, 'Carmen', 'Velasquez','283 King Street','Seattle','206-899-6666',to_date('08-MAR-1990', 'DD-MON-RR'));

insert into member
values(member_id_seq.nextval, 'LaDoris', 'Nago','5 Modrany','Bratislava','586-355-8882',to_date('08-MAR-1990', 'DD-MON-RR'));

insert into member
values(member_id_seq.nextval, 'Molly', 'Urguhart','3035 Laurier','Quebec','419-542-9988',to_date('18-JAN-1991', 'DD-MON-RR'));

select *
from member;

-- 7
alter table title drop column description;

select *
from title;

insert into title
values(title_id_seq.nextval, 'My Day Off', 'PG','COMEDY','12-JUL-1995');

insert into title
values(title_id_seq.nextval, 'Miracles on Ice', 'PG','DRAMA','12-SEP-1995');

insert into title
values(title_id_seq.nextval, 'Soda Gang', 'NR','ACTION','01-JUN-1995');

-- 8

select *
from reservation;

insert into reservation
values(sysdate, 103 , 94);
commit;