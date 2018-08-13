---------------------------- 2장
-- where은 비교,조건문
select first_name, department_id, salary, job_id
from employees
where last_name= 'King';

-- 논리 연산자 and와 or 로 두개 이상 조건 가능
select first_name, department_id, salary, job_id
from employees
where department_id= 80 and salary >= 10000 ;

-- 연산자 between 사용
select first_name, department_id, salary, job_id
from employees
where salary between 10000 and 12000 ;

-- 연산자 IN 사용
select first_name, department_id, salary, job_id
from employees
where salary IN( 10000, 11000, 12000 ) ;

select first_name, department_id, salary, job_id
from employees
where job_id IN( 'IT_PROG') ;

-- 연산자 LIKE를 사용하여 문자검색
select first_name, department_id, salary, job_id
from employees
where job_id like '_SA_%' ;

-- 연산자 LIKE를 사용 응용 _는 원래 자리 한자리를 의미하는 데 아래의 구문을사용하므로써 문자로 사용할 수 있다.
select first_name, department_id, salary, job_id
from employees
where job_id like '%T$_%R%' escape '$' ;
----------------------------------
-- not between, not in, not like
-- is not null 이 경우만 중간에 not
----------------------------------
-- order by 로 오름차순 정렬을 할 수 있으며, desc는 내림차순으로 정렬된다.
select first_name, department_id, salary, job_id
from employees
order by department_id desc, salary desc;

-- a를 치환변수로 사용하여 a값을 실행할 때 해서 검색할 수 있다.
-- where, from, select 어디든 사용할 수 있다.
select first_name, department_id, salary, job_id
from employees
where department_id =&a; --만약 문자였다면 '&a'로 해야 한다.

select &a
from employees;

select first_name, department_id, salary, job_id
from employees
where &a;

-- &&이중 앰퍼센트는 &단일 앰퍼센트 치환을 한 값을 그대로 적용시킨다.
-- select, from, where, order by 순서로 사용하는 것은 약속이다.
select first_name, &&dne, salary, job_id
from employees
where &dne in (30, 50, 80)
order by &&dne;
-- 단일 앰퍼센트는 from, where, order by, select 우선순위로 하나만 설정해준다.
undefine dno;
set verify on;

select first_name, &&d, salary, job_id
from employees
order by &d;

-----------------------------------------------------
-----------------------------------------------------
--연습문제
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
order by 2 desc, 3 desc; -- 두번째열과 세번째열로 열단위로 정렬이 가능하다.
-- 5
select last_name
from employees
where last_name like '__a%';
-- 6
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';



---------------------------- 3장
-- 함수 upper lower는 보통 where에서 비교해서 찾을 때 많이 사용되어진다.
select last_name, first_name, upper(last_name), lower(last_name),initcap('ABC DEF'),initcap(last_name)
from employees;

-- concat함수는 || 연산자와 같은역할을 한다.
-- substr(collum, 시작위치 , 시작위치에서부터의 갯수) -> 시작위치~시작위치부터의 갯수 까지의 문자열
select last_name, first_name, concat(last_name,first_name),
substr(concat(last_name,first_name),1,3) as sub1,
substr(concat(last_name,first_name),5,4) as sub2,
substr(concat(last_name,first_name),-4,2) as sub3
from employees;

-- instr(collum, 찾을 문자, 시작위치, n 번째로 나타나는 위치를 리턴하기 위한 값) -> n번째로 나타나는 위치의 값
select last_name, first_name, concat(last_name,first_name),
instr(concat(last_name,first_name),'e',1,1) as instr1,
instr(concat(last_name,first_name),'e',8,1) as instr2,
instr(concat(last_name,first_name),'e',1,2) as instr3
from employees;

-- length(collum) -> 문자열의 크기
select last_name, first_name, concat(last_name,first_name), length(last_name)
from employees;

-- lpad(collum, 자릿수, 가변공간을 채울 문자), rpad는 방향만 바뀌고 나머지는 동일 --padding 해주는 함수
select last_name, first_name, concat(last_name,first_name),
lpad(last_name,20,' '),
rpad(' ',20,' ')
from employees;

-- replace(collum, 바꿔질문자열, 바꿀문자열)
select last_name, first_name, concat(last_name,first_name),
replace(concat(last_name,first_name),'ate', '%%%')
from employees;

-- trim 앞뒤를 자른다.
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

