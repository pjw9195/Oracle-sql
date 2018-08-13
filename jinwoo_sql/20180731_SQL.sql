---------------------------- 2��
-- where�� ��,���ǹ�
select first_name, department_id, salary, job_id
from employees
where last_name= 'King';

-- �� ������ and�� or �� �ΰ� �̻� ���� ����
select first_name, department_id, salary, job_id
from employees
where department_id= 80 and salary >= 10000 ;

-- ������ between ���
select first_name, department_id, salary, job_id
from employees
where salary between 10000 and 12000 ;

-- ������ IN ���
select first_name, department_id, salary, job_id
from employees
where salary IN( 10000, 11000, 12000 ) ;

select first_name, department_id, salary, job_id
from employees
where job_id IN( 'IT_PROG') ;

-- ������ LIKE�� ����Ͽ� ���ڰ˻�
select first_name, department_id, salary, job_id
from employees
where job_id like '_SA_%' ;

-- ������ LIKE�� ��� ���� _�� ���� �ڸ� ���ڸ��� �ǹ��ϴ� �� �Ʒ��� ����������ϹǷν� ���ڷ� ����� �� �ִ�.
select first_name, department_id, salary, job_id
from employees
where job_id like '%T$_%R%' escape '$' ;
----------------------------------
-- not between, not in, not like
-- is not null �� ��츸 �߰��� not
----------------------------------
-- order by �� �������� ������ �� �� ������, desc�� ������������ ���ĵȴ�.
select first_name, department_id, salary, job_id
from employees
order by department_id desc, salary desc;

-- a�� ġȯ������ ����Ͽ� a���� ������ �� �ؼ� �˻��� �� �ִ�.
-- where, from, select ���� ����� �� �ִ�.
select first_name, department_id, salary, job_id
from employees
where department_id =&a; --���� ���ڿ��ٸ� '&a'�� �ؾ� �Ѵ�.

select &a
from employees;

select first_name, department_id, salary, job_id
from employees
where &a;

-- &&���� ���ۼ�Ʈ�� &���� ���ۼ�Ʈ ġȯ�� �� ���� �״�� �����Ų��.
-- select, from, where, order by ������ ����ϴ� ���� ����̴�.
select first_name, &&dne, salary, job_id
from employees
where &dne in (30, 50, 80)
order by &&dne;
-- ���� ���ۼ�Ʈ�� from, where, order by, select �켱������ �ϳ��� �������ش�.
undefine dno;
set verify on;

select first_name, &&d, salary, job_id
from employees
order by &d;

-----------------------------------------------------
-----------------------------------------------------
--��������
-- 1
select last_name, salary
from employees
where salary >12000;
-- 2
select first_name, salary
from employees
where salary not between 5000 and 12000;
-- 3
select last_name, job_id, hire_date
from employees
where last_name = 'Matos' or last_name = 'Taylor'
order by hire_date;
-- 4
select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by 2 desc, 3 desc; -- �ι�°���� ����°���� �������� ������ �����ϴ�.
-- 5
select last_name
from employees
where last_name like '__a%';
-- 6
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';



---------------------------- 3��
-- �Լ� upper lower�� ���� where���� ���ؼ� ã�� �� ���� ���Ǿ�����.
select last_name, first_name, upper(last_name), lower(last_name),initcap('ABC DEF'),initcap(last_name)
from employees;

-- concat�Լ��� || �����ڿ� ���������� �Ѵ�.
-- substr(collum, ������ġ , ������ġ���������� ����) -> ������ġ~������ġ������ ���� ������ ���ڿ�
select last_name, first_name, concat(last_name,first_name),
substr(concat(last_name,first_name),1,3) as sub1,
substr(concat(last_name,first_name),5,4) as sub2,
substr(concat(last_name,first_name),-4,2) as sub3
from employees;

-- instr(collum, ã�� ����, ������ġ, n ��°�� ��Ÿ���� ��ġ�� �����ϱ� ���� ��) -> n��°�� ��Ÿ���� ��ġ�� ��
select last_name, first_name, concat(last_name,first_name),
instr(concat(last_name,first_name),'e',1,1) as instr1,
instr(concat(last_name,first_name),'e',8,1) as instr2,
instr(concat(last_name,first_name),'e',1,2) as instr3
from employees;

-- length(collum) -> ���ڿ��� ũ��
select last_name, first_name, concat(last_name,first_name), length(last_name)
from employees;

-- lpad(collum, �ڸ���, ���������� ä�� ����), rpad�� ���⸸ �ٲ�� �������� ���� --padding ���ִ� �Լ�
select last_name, first_name, concat(last_name,first_name),
lpad(last_name,20,' '),
rpad(' ',20,' ')
from employees;

-- replace(collum, �ٲ������ڿ�, �ٲܹ��ڿ�)
select last_name, first_name, concat(last_name,first_name),
replace(concat(last_name,first_name),'ate', '%%%')
from employees;

-- trim �յڸ� �ڸ���.
select last_name, first_name, concat(last_name,first_name),
trim('D' from upper( concat(last_name,first_name)))
from employees;

-- 1
select last_name
from employees
where instr(last_name,'J',1,1) = 1
or instr(last_name,'K',1,1) = 1
or instr(last_name,'M',1,1) = 1
or instr(last_name,'L',1,1) = 1;

-- 2
select last_name, salary, rpad(' ',salary/1000+1,'*') as EMPLYESS_AND_THEIR_SALARIES
from employees
order by salary desc;

