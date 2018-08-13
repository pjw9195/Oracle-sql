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
-- primary foriegn �� delete�� �����Ӵ�.
-- primary ���� insert into �Ҷ��� ���� foriegn �� ������ ���� �ʴ´�.
-- update �� foriegn �� ������ �޴´�. �ֳ��ϸ� primary ���� foriegn �� �ִ� ���� update �ع����� ������ ����. 
delete dept_test where deptno = 50;

-- as�� ������ ������ �� ������ �����Ѵ�.
create table sample1
as
select * from employees;

-- select���� Į���� �̸��� ���� �� �ִ�.
create table sample2
as
select department_id deptno, job_id job, avg(salary) avg_sal
from employees
group by department_id, job_id
order by department_id, job_id;

-- alter table �� add�� ���� Į���� �߰��Ѵ�.
alter table sample2 add(emp_cnt number);
-- modify �� Į���� Ÿ���� �ٲ� �� �ִ�.
alter table sample2 modify(job varchar2(20));
desc sample2;

-- default�� 
alter table dept_test add(create_dt date default sysdate);
-- Į�� ���
alter table dept_test drop column create_dt;
-- Į���� �̸� ����
alter table dept_test rename column deptno to dept_id;


-- �б� ������� 
select * from sample2;

alter table sample2 read only;
/* ���̺��� select�� ����ϰ� �Ͽ��� (�б�����)
   ��� ddl �۾��� ������ �ʴ´�..! */
delete sample2;
/* delete�� ���� �ʴ´�..! */

alter table sample2 read write;
/* �ٽ� ���� �������� ������. */

-- table level���� �� ��������
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

-- collum level���� �� ��������
create table title
(title_id number(10) primary key,
title varchar2(60) not null,
description varchar2(400) not null,
rating varchar2(4),
category VARCHAR2(20) check(category in ('DRAMA', 'COMEDY','ACTION','CHILD','DOCU')),
release_date date);

-- �������� Į���� primary key�� �����Ǿ������� ������ ����. �ذ��ϱ����ؼ� ������ table level���� ���������� ���־���Ѵ�.
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

-- view�� ����Ͽ� ������ query �� �ܼ�ȭ�Ѵ�.
create view sal_top_v
as
select employee_id, first_name, salary from employees order by salary desc;

-- avg �Լ����� �Լ��� view ���� ����ϰ������ as�� �̸��� ���� ���ش��� ����ؾ� �Ѵ�.
create view avg_sal_top
as
select department_id, job_id, avg(salary) avg_sal
from employees
group by department_id, job_id
order by avg(salary) desc;

select department_id, job_id avg_sal
from avg_sal_top;

-- ��� view���� �����ؼ��� DML�� �Ұ����ϴ�

-- with check option constraint �� ���� 50������ �ٲܼ��� ����. null���� �ǹǷ� ���� insert�Ҷ� 20���� ������ �ִ�.
create or replace view empvu20
as select *
from employees
where department_id = 20
with check option constraint empvu20_ck;

update empvu20 set department_id = 50;
select *from empvu20;

-- sequence�� ���� ���ϴ� �Լ��� ���� �� �ִ�.
-- insert �Ҷ� ����Ѵ�.
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
-- ������� ������ ����. �׷��� ������ ���ʴ�� ���� �ʴ´�.
insert into dept_test
values(dept_seq.nextval, 'BBB',null);

select*from dept_test;

-- alter sequence �� ������ ������ �� �� �ִµ� start with�� �ٲܼ�������.

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