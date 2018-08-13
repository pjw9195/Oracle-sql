-- subquery ���
select first_name, salary, (select avg(salary) from employees) avg_sal
from employees;
-- where���� ���� ���������� �ʿ��Ѱ��� �̾����� �ʴ´�.
select rowid, rownum, first_name, salary
from employees
where rownum <=5 
order by salary desc;

-- where ������ ���� from �� ����ǹǷ� subquery �� �̿��Ͽ� ǥ���� �� �ִ�.
select *
from (select first_name, salary 
        from employees
        order by salary desc)
where rownum <= 10;

-- subquery �� where���� ���� ���� ��������.
select first_name, salary
from employees
where salary > (select avg(salary) from employees);

select first_name, salary, job_id
from employees
where job_id = ( select job_id
                from employees
                where last_name = 'Abel');
-- ���� ����ϴ� case �������� ���� �������� in�� ����Ͽ� �� �� �ִ�.                
select first_name, salary, job_id
from employees
where salary in (select salary
                from employees
                where last_name = 'Taylor');
-- �� ��������ʴ� case                
select first_name, salary, job_id
from employees
where salary = any (select salary
                from employees
                where last_name = 'Taylor');
                
-- exist ���

select * 
from departments
where exists ( select 1
                from employees
                where employees.department_id = departments.department_id );

-- not in �� ����ϰ� �Ǹ� null���� ���� �񱳴� �� �� �����Ƿ� ���������ʴ�. �׷��Ƿ� �Ѱǵ� ��µ��� �ʴ´�.
select * 
from departments
where department_id not in (select distinct department_id
                            from employees);
                            
select *
from departments;
            
-- 1
select employee_id, first_name, salary
from employees
where salary > (select avg(salary) from employees) and
                        department_id in (select department_id
                        from employees
                        where last_name like '%u%');
                        
-- 2

select last_name, salary
from employees
where manager_id in (select employee_id
                    from employees
                    where last_name = 'King');
                    
-- 3
select first_name, e.department_id, job_id
from employees e, departments d
where e.department_id = d.department_id and
                        e.department_id = (select department_id
                        from departments
                        where department_name = 'Sales');
                        
-- 4 �߿�!

select d.department_id, d.department_name, count(*)
from departments d, employees e
where d.department_id = e.department_id
group by d.department_id, d.department_name
having count(*) = (select max(count(*)) from employees
                    group by department_id);
                    
-- 5
select first_name, hire_date
from employees
where department_id in (select department_id from employees
                        where first_name = '&b')

and first_name<> &&b;

-- union all�� ���������� ��Ÿ���� �ߺ��� ���յ� �����ش�.
-- union�� �ߺ��� �����ϴ� �۾��� �� �� �����ش�.
select first_name, last_name, department_id , salary
from employees
where department_id = 110
union
select first_name, last_name, employee_id, commission_pct
from employees
where salary>= 15000
order by salary;

-- intersect �� ������
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

-- minus �� ������

select employee_id, job_id
from employees
minus
select employee_id, job_id
from job_history;

--
select location_id, department_name
from departments
union
select location_id, null
from locations;

-- 1
select distinct job_id, department_id
from employees
where department_id = 10
union all
select distinct job_id, department_id
from employees
where department_id = 50
union all
select distinct job_id, department_id
from employees
where department_id = 30