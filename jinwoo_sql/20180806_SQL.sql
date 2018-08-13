-- subquery 사용
select first_name, salary, (select avg(salary) from employees) avg_sal
from employees;
-- where절이 먼저 읽혀버려서 필요한값이 뽑아지지 않는다.
select rowid, rownum, first_name, salary
from employees
where rownum <=5 
order by salary desc;

-- where 절보다 먼저 from 이 실행되므로 subquery 를 이용하여 표현할 수 있다.
select *
from (select first_name, salary 
        from employees
        order by salary desc)
where rownum <= 10;

-- subquery 는 where절이 제일 많이 쓰여진다.
select first_name, salary
from employees
where salary > (select avg(salary) from employees);

select first_name, salary, job_id
from employees
where job_id = ( select job_id
                from employees
                where last_name = 'Abel');
-- 자주 사용하는 case 여러개의 행이 있을때는 in을 사용하여 쓸 수 있다.                
select first_name, salary, job_id
from employees
where salary in (select salary
                from employees
                where last_name = 'Taylor');
-- 잘 사용하지않는 case                
select first_name, salary, job_id
from employees
where salary = any (select salary
                from employees
                where last_name = 'Taylor');
                
-- exist 사용

select * 
from departments
where exists ( select 1
                from employees
                where employees.department_id = departments.department_id );

-- not in 을 사용하게 되면 null값에 대한 비교는 할 수 없으므로 가능하지않다. 그러므로 한건도 출력되지 않는다.
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
                        
-- 4 중요!

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

-- union all은 순차적으로 나타내며 중복된 집합도 보여준다.
-- union은 중복을 제거하는 작업을 한 후 보여준다.
select first_name, last_name, department_id , salary
from employees
where department_id = 110
union
select first_name, last_name, employee_id, commission_pct
from employees
where salary>= 15000
order by salary;

-- intersect 는 교집합
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

-- minus 는 차집합

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