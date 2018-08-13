-- round는 반올림 trunc는 버림
-- dual은 한건의 데이터만 확인가능
-- mod는 나머지 구하기
select trunc(456.789), trunc(456.789,0),trunc(456.789,-1),round(456.789,-2),round(456.789,1),round(456.789,2)
from dual;

--
alter session set nls_date_format = 'yyyy/mm/dd hh24:mi:ss'; -- 시간 형식 변경
alter session set nls_date_format = 'DD-MON-RR'; -- 시간 형식 변경

select first_name, hire_date
from employees;

-- sysdate-1/24 : -1시간
-- sysdate+1 : +1일
select sysdate, sysdate+1, sysdate-1, sysdate-1/24
from dual;
-- sysdate+sysdate 날짜 덧셈, 곱셈, 나눗셈 연산은 불가능하다. 하지만 뺄셈은 가능
select sysdate +10 - sysdate
from dual;
-- 날짜의 반올림 dd는 시간에서 반올림하면 일이 바뀌고, mm는 일에서 반올림하면 월이 바뀌고, yyyy는 월에서 반올림하면 년도가 바뀐다.
select sysdate+2/24, round(sysdate+2/24,'dd'),
round(sysdate+2/24,'mm'), round(sysdate+2/24, 'yyyy')
from dual;

select sysdate+2/24, trunc(sysdate+2/24,'dd'),
trunc(sysdate+2/24,'mm'), trunc(sysdate+2/24, 'yyyy')
from dual;

-- 날짜 형식이 같아야 작동이 된다.
select first_name, hire_date
from employees
where hire_date = '07-JUN-02';
where hire_date = '2002/06/07';

-- 날짜형식의데이터와 문자형식의데이터가 알아서 치환된다. 
select add_months('07-JUN-02', 3)
from dual;

-- 1
select employee_id, last_name, salary, trunc(salary*1.155) as "New Salary"
from employees;
-- 2
select 'the salary of ' || last_name || ' after a 10% raise ' || round(salary*1.1)
from employees
where commission_pct is null;
-- 3 --mod 나머지를 이용하여 개월 수를 구해준다.
alter session set nls_date_format = 'MON-RR'; -- 시간 형식 변경
select first_name, trunc((sysdate-hire_date)/365) "Year", trunc(mod(months_between(sysdate,hire_date),12)) "Month"
from employees
order by hire_date;
-- 오라클에서는 문자가 숫자랑 비교할수있는데 오라클이 문자를 숫자로 치환하여 비교해준다.
select *
from employees
where department_id like '1%';
-- 기본포맷모델을 바꿔준다.
select sysdate, to_char(sysdate, 'yyyy/mm/dd') ymd1, to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') ymd2,
        to_char(sysdate, 'yyyy/mm/dd hh:mi:ss am') ymd3
from dual;

select sysdate, to_char(sysdate, 'MONTH Month month') mon1, to_char(sysdate, 'MON Mon mon') mon2
from dual;

select sysdate, to_char(sysdate, 'DAY/Day/day') day1, to_char(sysdate,'DY Dy dy') day2
from dual;
--주의 일 수요일이라면 4
select sysdate,to_char(sysdate, 'd')
from dual;
--dd 는 월의 일 이므로 1일이면 1
select sysdate,to_char(sysdate, 'dd ddsp ddspth')
from dual;
--fm을 붙이면 0이 사라지고 패딩한것을 없애준다.
select hire_date, to_char(hire_date,'fmyyyy/mm/dd') ymdl, to_char(hire_date,'fmdd MONTH Day') ymd2
from employees;
-- to_char 를 이용하여 숫자를 문자화함.
select salary*100,to_char(salary*100, '$999,999,999,999') sall, to_char(salary*100, 'L099,999,999,999') sall,
to_char(salary*100, '000,000,000,000') sall
from employees;

--------------
-- 년,월,일을 구하기위해서는 시분초가 테이블에 들어가있으므로, 아래와같이 조건식을 넣어 뽑아내야한다.
select employee_id, first_name,to_char(hire_date,'yyyy/mm/dd hh24:mi:ss')
from employees
where hire_date >= to_date('2018/08/01', 'yyyy-mm-dd')
and  hire_date < to_date('2018/08/02', 'yyyy-mm-dd');
-- to_char을 이용해 날짜를 문자로 치환하여 비교한다.
select employee_id, first_name,to_char(hire_date,'yyyy/mm/dd hh24:mi:ss')
from employees
where to_char(hiredate, 'yyyymmdd') = '20180801';
-- nvl (input1, input2) input1이 null이면 input2 출력 아니면 input1 그대로 출력 또한 input1과 input2가 타입이 같아야 한다.
select salary, commission_pct, salary+commission_pct tot1, nvl(salary,0) + nvl(commission_pct,0) tot2
from employees;

--첫번째 input값이 null이 아니면 두번째 인풋값 출력
--첫번째 input값이 null이면 세번째 인풋값 출력
select nvl2(100,1,2), nvl2(null,1,2)
from dual;

-- 둘이 같으면 null값 리턴 아니면 처음값 리턴
select nullif('a', 'b'), nullif(10,10)
from dual;

-- 최초로 null이 아닌 input 값을 출력한다.
select coalesce(10,20,30), coalesce(null, 20, 30), coalesce(null, null, 30), coalesce(null, null, null)
from dual;

-- 1
select last_name || ' earns ' || to_char(salary, '$999,999,999,999') || ' monthly but wants ' || to_char(salary * 3, '$999,999,999,999') as "Dream Salaries"
from employees;

-- 2
select last_name, hire_date, NEXT_DAY(add_months(hire_date, 6),'MON') as REVIEW
from employees;

-- 3
select last_name , commission_pct, nvl(to_char(commission_pct), 'No Commission') 
from employees;

-- 4
select last_name, hire_date, to_char(hire_date, 'DAY') as "DAY"
from employees
order by to_char(hire_date-1, 'd');