-- round�� �ݿø� trunc�� ����
-- dual�� �Ѱ��� �����͸� Ȯ�ΰ���
-- mod�� ������ ���ϱ�
select trunc(456.789), trunc(456.789,0),trunc(456.789,-1),round(456.789,-2),round(456.789,1),round(456.789,2)
from dual;

--
alter session set nls_date_format = 'yyyy/mm/dd hh24:mi:ss'; -- �ð� ���� ����
alter session set nls_date_format = 'DD-MON-RR'; -- �ð� ���� ����

select first_name, hire_date
from employees;

-- sysdate-1/24 : -1�ð�
-- sysdate+1 : +1��
select sysdate, sysdate+1, sysdate-1, sysdate-1/24
from dual;
-- sysdate+sysdate ��¥ ����, ����, ������ ������ �Ұ����ϴ�. ������ ������ ����
select sysdate +10 - sysdate
from dual;
-- ��¥�� �ݿø� dd�� �ð����� �ݿø��ϸ� ���� �ٲ��, mm�� �Ͽ��� �ݿø��ϸ� ���� �ٲ��, yyyy�� ������ �ݿø��ϸ� �⵵�� �ٲ��.
select sysdate+2/24, round(sysdate+2/24,'dd'),
round(sysdate+2/24,'mm'), round(sysdate+2/24, 'yyyy')
from dual;

select sysdate+2/24, trunc(sysdate+2/24,'dd'),
trunc(sysdate+2/24,'mm'), trunc(sysdate+2/24, 'yyyy')
from dual;

-- ��¥ ������ ���ƾ� �۵��� �ȴ�.
select first_name, hire_date
from employees
where hire_date = '07-JUN-02';
where hire_date = '2002/06/07';

-- ��¥�����ǵ����Ϳ� ���������ǵ����Ͱ� �˾Ƽ� ġȯ�ȴ�. 
select add_months('07-JUN-02', 3)
from dual;

-- 1
select employee_id, last_name, salary, trunc(salary*1.155) as "New Salary"
from employees;
-- 2
select 'the salary of ' || last_name || ' after a 10% raise ' || round(salary*1.1)
from employees
where commission_pct is null;
-- 3 --mod �������� �̿��Ͽ� ���� ���� �����ش�.
alter session set nls_date_format = 'MON-RR'; -- �ð� ���� ����
select first_name, trunc((sysdate-hire_date)/365) "Year", trunc(mod(months_between(sysdate,hire_date),12)) "Month"
from employees
order by hire_date;
-- ����Ŭ������ ���ڰ� ���ڶ� ���Ҽ��ִµ� ����Ŭ�� ���ڸ� ���ڷ� ġȯ�Ͽ� �����ش�.
select *
from employees
where department_id like '1%';
-- �⺻���˸��� �ٲ��ش�.
select sysdate, to_char(sysdate, 'yyyy/mm/dd') ymd1, to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') ymd2,
        to_char(sysdate, 'yyyy/mm/dd hh:mi:ss am') ymd3
from dual;

select sysdate, to_char(sysdate, 'MONTH Month month') mon1, to_char(sysdate, 'MON Mon mon') mon2
from dual;

select sysdate, to_char(sysdate, 'DAY/Day/day') day1, to_char(sysdate,'DY Dy dy') day2
from dual;
--���� �� �������̶�� 4
select sysdate,to_char(sysdate, 'd')
from dual;
--dd �� ���� �� �̹Ƿ� 1���̸� 1
select sysdate,to_char(sysdate, 'dd ddsp ddspth')
from dual;
--fm�� ���̸� 0�� ������� �е��Ѱ��� �����ش�.
select hire_date, to_char(hire_date,'fmyyyy/mm/dd') ymdl, to_char(hire_date,'fmdd MONTH Day') ymd2
from employees;
-- to_char �� �̿��Ͽ� ���ڸ� ����ȭ��.
select salary*100,to_char(salary*100, '$999,999,999,999') sall, to_char(salary*100, 'L099,999,999,999') sall,
to_char(salary*100, '000,000,000,000') sall
from employees;

--------------
-- ��,��,���� ���ϱ����ؼ��� �ú��ʰ� ���̺� �������Ƿ�, �Ʒ��Ͱ��� ���ǽ��� �־� �̾Ƴ����Ѵ�.
select employee_id, first_name,to_char(hire_date,'yyyy/mm/dd hh24:mi:ss')
from employees
where hire_date >= to_date('2018/08/01', 'yyyy-mm-dd')
and  hire_date < to_date('2018/08/02', 'yyyy-mm-dd');
-- to_char�� �̿��� ��¥�� ���ڷ� ġȯ�Ͽ� ���Ѵ�.
select employee_id, first_name,to_char(hire_date,'yyyy/mm/dd hh24:mi:ss')
from employees
where to_char(hiredate, 'yyyymmdd') = '20180801';
-- nvl (input1, input2) input1�� null�̸� input2 ��� �ƴϸ� input1 �״�� ��� ���� input1�� input2�� Ÿ���� ���ƾ� �Ѵ�.
select salary, commission_pct, salary+commission_pct tot1, nvl(salary,0) + nvl(commission_pct,0) tot2
from employees;

--ù��° input���� null�� �ƴϸ� �ι�° ��ǲ�� ���
--ù��° input���� null�̸� ����° ��ǲ�� ���
select nvl2(100,1,2), nvl2(null,1,2)
from dual;

-- ���� ������ null�� ���� �ƴϸ� ó���� ����
select nullif('a', 'b'), nullif(10,10)
from dual;

-- ���ʷ� null�� �ƴ� input ���� ����Ѵ�.
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