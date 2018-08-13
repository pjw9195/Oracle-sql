--------------------------------------------------------------------------------------------------------------------------
------------------------------------------- �ε��� ------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

-- 1. index �߰�----------------------------------------------------------------------------------------------------------
select * from emp_member
where department_id = 10;

select * from emp_member
where last_name = 'King'
and   first_name = 'Steven';

--create index ~ on : �ε��� �߰� �۾�
create index lname_fname_ix 
on emp_member(last_name, first_name);

alter table emp_member 
add constraint emp_member_pk primary key(employee_id);

create table emp_member
as
select * from employees;


-- 2. index ���� ----------------------------------------------------------------------------------------------------------
/* �ϳ��� ������ �ʹ� ���� index�� �ɷ��ִ°� �ӵ��� ������ �����.
   -> �ʿ���� index�� ����������. */
   
drop index lname_fname_ix;
/* ������ �� ������..*/



--3. synonym : ��ü�� -----------------------------------------------------------------------------------------------------------
--hr.employees�� ��ü�ϱ� ���Ͽ�
create synonym e1 for hr.employees;  
/* e1���� ��ü������ */
select * from e1;
/* �׷���, SCOTT���� ������� ����.. -> �����ڿ��� ������־�� ��..!*/


-- �������� 1 -----------------------------------------------------------------------------------------------------------
--2005�� ���� ä��Ǿ����� ����ID(job_id) st_clerk �� �ٹ��ϰ� �ִ� ����� ������ ����ϼ���

select * 
from employees
where job_id = 'ST_CLERK'
and hire_date >= to_date('2005/01/01','yyyy/mm/dd');

-- �������� 2 -----------------------------------------------------------------------------------------------------------
-- �� ���� 16�� ������ ä��� ����� �̸�(first_name)�� ä������(hire_date)�� ����մϴ�.

select first_name, hire_date
from   employees
where to_char(hire_date,'dd') < 16;
 
-- �������� 3 -----------------------------------------------------------------------------------------------------------
-- administration �� executive �μ����� ã�� ������ ǥ���ϴ� ������ �ۼ��մϴ�. ����(job_id)��, 
-- �� ����ID�� �ش�Ǵ� ������� ���� ǥ���մϴ�. ��� ���� ���� ���� ������ ���� ǥ���մϴ�.

select department_id
from departments
where department_name in ('Administration', 'Executive');

select job_id,count(*)
from employees
where department_id in (10,90)
group by job_id;
/* 2������ 1�������� */

--���1
select job_id,count(*)
from employees
where department_id in (select department_id
                        from departments
                        where department_name in ('Administration', 'Executive') )
group by job_id;

-- �������� 4 -----------------------------------------------------------------------------------------------------------
-- ��� ���� ���� ���� �μ����� �ٹ��ϴ� ����� �μ� ��ȣ(department_id), �μ� �̸� (department_name) �� �ٹ��ϴ� ��� ���� ǥ���մϴ�.

select e.department_id, department_name, count(*)
from   employees e, departments d
where e.department_id = d.department_id
group by e.department_id, department_name
order by 3 desc;
/* �̷��� ������ �����͸� */

select *
from (select e.department_id, department_name, count(*)
      from   employees e, departments d
      where e.department_id = d.department_id
      group by e.department_id, department_name
      order by 3 desc)
where rownum = 1;

--���2
select e.department_id, department_name, count(*)
from   employees e, departments d
where e.department_id = d.department_id
group by e.department_id, department_name
having count(*) = (select max(count(*)) from employees
                   group by department_id);


-- �������� 5 -----------------------------------------------------------------------------------------------------------
-- �� ������ �ٹ� ����� ������ ���� id(job_id), ���� title(job_title), ����̸�(first_name)������ ����մϴ�. 
-- �� ������ �ش��ϴ� ����� ���� ��� ����̸� (first_name)�� '�������'���� ����մϴ�.

select job_id, job_title
from jobs;

select j.job_id, job_title, nvl(first_name,'�������')
from   jobs j, employees e
where  j.job_id = e.job_id;
/*  inner join�̹Ƿ� jobs�� employees���� ��Ī�Ǵ°� �� ��µ���. 
    ����, �̷��� �ϸ� first_name�� ���յǹǷ� first_name�� ��Ī���� ���� job_id�� ��µ��� �����Ƿ�
    ������� ���� �ƿ� ����� ���� �ʴ´�.
    
    -> outer join�� ����ؾ��Ѵ�. */

--nvl
select j.job_id, job_title, nvl(first_name,'�������')
from   jobs j left outer join employees e
on     j.job_id = e.job_id;
/* outer join�� ���� �Ƚ� ����� ����Ѵ�.
   ����, left �� �������ν� jobs ���̺��� �������� ��Ƽ� jobs���� ������ employees���� ���� �����Ͱ� ��µǸ鼭
   '�������'�� ��µǰ� �ȴ�.*/

--decode
select j.job_id, job_title, decode(first_name,null,'�������',first_name)
from   jobs j left outer join employees e
on     j.job_id = e.job_id;

--case ~ on
select j.job_id, job_title, 
       case when first_name is null then '�������'
            else first_name end
from   jobs j left outer join employees e
on     j.job_id = e.job_id;

select case when salary > 5000 then 30
            else  20 end
from employees;




