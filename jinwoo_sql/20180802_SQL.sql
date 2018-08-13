-- decode �� �̿��Ͽ� if�� ���� ������ = �񱳹ۿ� �ȵȴ�.
select first_name, salary, decode(salary, 6000, 'low', 11000, 'med', 15000, 'high', 'others')
from employees;
-- case when then ������ if�� ����.
select first_name, salary, ( case 
when salary= 6000 then 'low'
when salary=11000 then 'med'
when salary=15000 then 'high' 
else 'others' end ) case1
from employees;
-- �������� �Ƚ��൵�ǰ� ù��° ���ǿ� �ϸ� �ι�°���ǿ� ����ȴ�??
-- when salary<5000
-- when salary<10000
-- �̷����̴�.
select first_name, salary, ( case 
when salary >0  and salary <5000 then 'not bad'
when salary>5000 and salary <10000 then 'good'
when salary <20000 and salary >10000 then 'best' 
when salary >20000 then 'excellent' end ) case1
from employees;

-- 1
select job_id , decode(job_id, 'AD_PRES', 'A','ST_MAN', 'B','IT_PROG', 'C', 'SA_REP', 'D', 'ST_CLERK', 'E' , 'O') as grade
from employees;

-- 2-1
select first_name, salary, nvl2(commission_pct,'Yes','No')
from employees;

-- 2-2
select first_name, salary, case when commission_pct is null then 'No'
                                else 'Yes' end
from employees;

select first_name, salary, commission_pct,
decode(commission_pct, null, 'No' , 'Yes') decode_nm,
(case when commssion_pct is null then 'No' else 'Yes' end)case1,
(case when commssion_pct is null then 'No'
        when commission_pct is not null then 'Yes' end)case2
from employees;

------------------------------------------------------
------------------------------------------------------
-- count, min, max �Լ��� ���� �� ��¥ �����Ϳ��� ��� �� �� �ִ�.
select count(salary), sum(salary), avg(salary) ,min(salary), max(salary)
from employees;

select count(commission_pct), sum(commission_pct), avg(commission_pct) ,min(commission_pct), max(commission_pct)
from employees;

-- distinct �� �ߺ��Ȱ��� ���� ���ش�.
select count(*), count(commission_pct), count(job_id), count(distinct job_id)
from employees;
-- avg(nvl (commission_pct,0)) �̷������� �ϸ� null���� 0���� �ν��ؼ� ������ش�.
select count(commission_pct), sum(commission_pct),avg(commission_pct), avg(nvl(commission_pct,0))
from employees;

select count(1), count('a'),count(0), count(100), count(null)
from dual;

-- group by �� �׷����� ���� ����Ѵ�.
select department_id, count(*), avg(salary)
from employees
group by department_id
order by department_id;

select count(*), avg(salary)
from employees
group by department_id
order by department_id;

-- having�� where�� ����� ����ϸ� �Լ��� �̿��ϸ� group �Լ��� ���� ����� �� ��½����ش�.
select department_id, job_id, count(*), avg(salary)
from employees
having count(*)>=5
group by department_id, job_id
order by department_id;
-- having ������ �׷��Լ��� ����� �����ϴ�.
select department_id, job_id, count(*), avg(salary)
from employees
having sum(salary) >=30000;
group by department_id, job_id
order by department_id;

select max(avg(salary))
from employees
group by department_id;

-- 1
select min(salary), max(salary), sum(salary),avg(salary) , count(*)
from employees
group by job_id;

-- 2
select manager_id, min(salary)
from employees
where manager_id is not null
having min(salary) > 6000
group by manager_id
order by 2 desc;

-- 3
select count(*)
from employees
where last_name like '%n' ;

--substr�� �̿��� ���
select count(*)
from employees
where substr(last_name, -1, 1) = 'n';
-- 4
-- hire_date ���� �ѹ������� �״��� ���� �ϴ½����� count�� �ȴ�.
-- counting ���
select count(*),
count(decode(to_char(hire_date, 'yyyy'), '2002','abc', null)) as "2002",
count(decode(to_char(hire_date, 'yyyy'), '2003','abc', null)) as "2003",
count(decode(to_char(hire_date, 'yyyy'), '2004','abc', null)) as "2004",
count(decode(to_char(hire_date, 'yyyy'), '2005','abc', null)) as "2005"
from employees;

select first_name, salary
from employees
order by department_id;

select distinct department_id , count(*)
from employees
group by department_id
order by 1;

select department_id , job_id
from employees
group by department_id, job_id
order by 1,2;

select department_id , count(*)
from employees
group by department_id
having avg(salary) >5000
order by avg(salary) ;

--5
select job_id, sum(decode(department_id, 20, salary,'0')) as "Dept20",
            sum(decode(department_id, 50, salary,'0')) as "Dept50",
            sum(decode(department_id, 80, salary,'0')) as "Dept80",
            sum(decode(department_id, 90, salary,'0')) as "Dept90",
             as total
from employees
group by job_id
order by job_id;