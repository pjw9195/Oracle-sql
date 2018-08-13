--------------------------------------------------------------------------------------------------------------------------
------------------------------------------- 인덱스 ------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

-- 1. index 추가----------------------------------------------------------------------------------------------------------
select * from emp_member
where department_id = 10;

select * from emp_member
where last_name = 'King'
and   first_name = 'Steven';

--create index ~ on : 인덱스 추가 작업
create index lname_fname_ix 
on emp_member(last_name, first_name);

alter table emp_member 
add constraint emp_member_pk primary key(employee_id);

create table emp_member
as
select * from employees;


-- 2. index 삭제 ----------------------------------------------------------------------------------------------------------
/* 하나의 열에는 너무 많은 index가 걸려있는건 속도를 느리게 만든다.
   -> 필요없는 index는 삭제해주자. */
   
drop index lname_fname_ix;
/* 실행은 안 시켰음..*/



--3. synonym : 대체어 -----------------------------------------------------------------------------------------------------------
--hr.employees를 대체하기 위하여
create synonym e1 for hr.employees;  
/* e1으로 대체시켰음 */
select * from e1;
/* 그러나, SCOTT에서 실행되지 않음.. -> 관리자에서 만들어주어야 함..!*/


-- 연습문제 1 -----------------------------------------------------------------------------------------------------------
--2005년 이후 채용되었으며 직무ID(job_id) st_clerk 에 근무하고 있는 사원의 정보를 출력하세요

select * 
from employees
where job_id = 'ST_CLERK'
and hire_date >= to_date('2005/01/01','yyyy/mm/dd');

-- 연습문제 2 -----------------------------------------------------------------------------------------------------------
-- 각 월의 16일 이전에 채용된 사원의 이름(first_name)과 채용일자(hire_date)를 출력합니다.

select first_name, hire_date
from   employees
where to_char(hire_date,'dd') < 16;
 
-- 연습문제 3 -----------------------------------------------------------------------------------------------------------
-- administration 및 executive 부서에서 찾은 직무를 표시하는 보고서를 작성합니다. 직무(job_id)와, 
-- 그 직무ID에 해당되는 사원수도 같이 표시합니다. 사원 수가 가장 많은 직무를 먼저 표시합니다.

select department_id
from departments
where department_name in ('Administration', 'Executive');

select job_id,count(*)
from employees
where department_id in (10,90)
group by job_id;
/* 2문장을 1문장으로 */

--방법1
select job_id,count(*)
from employees
where department_id in (select department_id
                        from departments
                        where department_name in ('Administration', 'Executive') )
group by job_id;

-- 연습문제 4 -----------------------------------------------------------------------------------------------------------
-- 사원 수가 가장 많은 부서에서 근무하는 사원의 부서 번호(department_id), 부서 이름 (department_name) 및 근무하는 사원 수를 표시합니다.

select e.department_id, department_name, count(*)
from   employees e, departments d
where e.department_id = d.department_id
group by e.department_id, department_name
order by 3 desc;
/* 이렇게 가공된 데이터를 */

select *
from (select e.department_id, department_name, count(*)
      from   employees e, departments d
      where e.department_id = d.department_id
      group by e.department_id, department_name
      order by 3 desc)
where rownum = 1;

--방법2
select e.department_id, department_name, count(*)
from   employees e, departments d
where e.department_id = d.department_id
group by e.department_id, department_name
having count(*) = (select max(count(*)) from employees
                   group by department_id);


-- 연습문제 5 -----------------------------------------------------------------------------------------------------------
-- 각 직무별 근무 사원의 정보를 직무 id(job_id), 직무 title(job_title), 사원이름(first_name)순으로 출력합니다. 
-- 그 직무에 해당하는 사원이 없을 경우 사원이름 (first_name)에 '사원없음'으로 출력합니다.

select job_id, job_title
from jobs;

select j.job_id, job_title, nvl(first_name,'사원없음')
from   jobs j, employees e
where  j.job_id = e.job_id;
/*  inner join이므로 jobs와 employees에서 대칭되는것 만 출력돈다. 
    따럿, 이렇게 하면 first_name과 결합되므로 first_name이 매칭되지 않은 job_id는 출력되지 않으므로
    사원없음 행은 아예 출력이 되지 않는다.
    
    -> outer join을 사용해야한다. */

--nvl
select j.job_id, job_title, nvl(first_name,'사원없음')
from   jobs j left outer join employees e
on     j.job_id = e.job_id;
/* outer join을 위해 안시 방법을 사용한다.
   또한, left 를 해줌으로써 jobs 테이블을 기준으로 삼아서 jobs에는 있지만 employees에는 없는 데이터가 출력되면서
   '사원없음'이 출력되게 된다.*/

--decode
select j.job_id, job_title, decode(first_name,null,'사원없음',first_name)
from   jobs j left outer join employees e
on     j.job_id = e.job_id;

--case ~ on
select j.job_id, job_title, 
       case when first_name is null then '사원없음'
            else first_name end
from   jobs j left outer join employees e
on     j.job_id = e.job_id;

select case when salary > 5000 then 30
            else  20 end
from employees;




