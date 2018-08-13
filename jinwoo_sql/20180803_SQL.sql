select * from emp;
select * from dept;
/* 앞으로 employees 말고 또 사용할 2개의 테이블 
   join을 알기 위해서 작은 데이터를 가진 테이블들 */
 
insert into emp
values(500,'Mike',2000,null);
commit;

/* 원래는 엄청 큰 엑셀파일로 만들어져 있었지만 '데이터의 정규화'를 위해 여러개의 엑셀파일(emp,dept)로 나누는 과정이 필요 */


-- 1.조인할때 전통적 방법 : where절-----------------------------------------------------------------------------------------------
select empno, ename, emp.deptno, dept.deptno, dname
from   emp, dept
where  emp.deptno = dept.deptno;
--and emp.sal >=3000;

/* 여러개의 테이블에서 데이터를 비교했을때는 where 절에서 emp의 deptno와 ddept의 deptno가 같다는것을
   반드시 명시해주어야한다.!!!!!!!!!!!!!!!!! */
   
-- 1.조인할때 ANSII로 변경하는 방법 1( join, on절) -----------------------------------------------------------------------------------------------
select empno, ename, emp.deptno, dept.deptno, dname
from   emp join dept
on     emp.deptno = deptno
where  emp.sal >= 3000;

/* ANSII에서는 콤마(,) 대신 join을 !! where 대신에 on절을 !! 사용한다.*/


-- 2. 조인할때 ANSII로 변경하는 방법2 ( join, using절) -----------------------------------------------------------------------------------------------
select emp.empno, emp.ename, deptno, deptno, dept.dname
from emp join dept
using(deptno);

-- 3. 조인할때 ANSII로 변경하는 방법3 ( natural 키워드, join, using절) -----------------------------------------------------------------------------------------------
select emp.empno, emp.ename, deptno, deptno, dept.dname
from emp natural join dept;
/* natural join : 데이터의 이름이 똑같을 뿐 아니라 데이터의 타입 역시 같아야 !!! join을 한다는 키워드이다. */

-- 4. 테이블에 AS의 강력한 특징 !!!-----------------------------------------------------------------------------------------------
select empno, ename, e.deptno, d.deptno, dname
from emp e, dept d
where e.deptno = d.deptno;

/* 테이블에서 as는 colum에서의 as와 달리 테이블을 대신 명칭으로 사용이 가능하다.!!!!!!!!!!!!!!!!!!
   where 절에서 e.deptno */

--5. 3개의 테이블 join -----------------------------------------------------------------------------------------------
select * from departments;
select * from locations;

select employee_id, first_name, 
       e.department_id, d.department_id, department_name,
       d.location_id, l.lcation_id, city
from employees e, departments d, locations l
where e.department_id = d.departmnet_id
and d.location_id = l.location_id;



--6. 순환적 테이블(employees)에서 서로 join하기 !! <<<<self join>>>> (매우중요) (난이도 상)--------------------------------------------------------------------
select w.employee_id, w.first_name, w.manager_id, m.name
from employees w, emp_test m
/* employees에서 employee id, first_name, manager id를 불러오고 
   그 employee의 manager의 이름 (m.name)을 다른 테이블(emp_test)에서 불러온다..! 
   (emp_test는 manager_id와 name이 저장된 별도의 테이블이라고 가정한다)*/
where w.manager_id = m.empno;
/* 그리고 employees의 테이블(w)에서의 manager_id 와 emp_test(m)에서 manger_id에 해당하는 empno를
   where절을 통해서 대응시켜준다...!!! 
    
    그러나, 이것은 어디까지나 emp_test라는 테이블이 있다고 가정한것... 그래서 오류가 날게 당연하다..
    employees 테이블은 사원이름 -> 매니저ID -> 매니저도 사원이니깐 매니저의 이름도 같은 table에 있음. ... 이런식으로 순환적 구조이다....!!*/

select w.employee_id, w.first_name, w.manager_id, m.first_name
from employees w, employees m
where w.manager_id = m.employee_id;
/*그러므로 다른 테이블이라고 가정했던 emp_test, m.name, m.empno를 employees테이블에 맞게 다시 바꿔준다...!!!!!!*/


--7.Nonequijoin ( 범위를 대응시켜주는 join) --------------------------------------------------------------------------------------------------
-- 일단 나중에 배우지만 salgrad라는 테이블을 임의로 만들어줌
insert into salgrade values(0,5000,'low');
insert into salgrade values(5001,10000,'low-med');
insert into salgrade values(10001,15000,'med');
insert into salgrade values(15001,20000,'low');
insert into salgrade values(20001,99999,'high');
commit;

create table salgrade
( losal number,
  hisal number,
  grade varchar2(30)  );
-- salgrad 테이블 완성 ( salary의 범위가 low인지, med인지 , higt인지 판단하는 테이블 )
  
select empno,ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

/*from절에 2개의 테이블이 오면 반드시 where절에서 어떤 colum과 어떤 colum이 대응되는지 적어주어야함..!!
  그러나, 여기서는 2개의 테이블에서 각각의 대응되는 같은 colum이 없는 경우이다. !!
  
  여기서, 알고 싶은 것은 사원의 salary가 있고 이 salary가 <salgrade> 테이블에가서 어떤 범위에 속하는지를 알고 싶은 것이다. 
  그러므로, where절에서 대응되는 = 표시가 아닌 범위 표시인 between ~ and 를 사용해주어 대응시켜 준다...!!! */

-- 8. outer join : 관련없는 2개의 테이블 join하기 --------------------------------------------------------------------------------------------------------------------------------------
--여태까지는 2개의 테이블이 각각 대응되는것을 join했는데, 이제는 대응되는 않은 관련 없는 2개의 테이블을 join한다..!

--outer join은 ansii 방법이 편리하므로 ansii방법을 사용한다..!

-- 8.1 키워드 : outer join , left , right ,  full
select empno, ename, e.deptno, d.deptno, dname 
from   emp e left outer join dept d 
on     e.deptno = d.deptno;
/* 일반적인 join이 아니므로 outer join을 해주고 
   emp테이블을 기준으로 일치되는것만 출력할지 dept 테이블을 기준으로 일치되는것말 출력할것인지 정해준다..!
   emp테이블을 기준으로 정렬할꺼니깐 left 사용 ! */

select empno, ename, e.deptno, d.deptno, dname 
from   emp e right outer join dept d 
on     e.deptno = d.deptno;

select empno, ename, e.deptno, d.deptno, dname 
from   emp e full outer join dept d 
on     e.deptno = d.deptno;
/* 양쪽 테이블에 대해서 일치가 되는것을 모두 출력해줄려면, full 사용 !! */

select *
from locations;
select *
from employees;
select *
from departments;
select *
from countries;

-- 연습문제1 ---------------------------------------------------------------------------------------------------------------------
select location_id, street_address, city, state_province, country_name
from locations l, countries c
where l.country_id = c.country_id; 

-- 연습문제2 ---------------------------------------------------------------------------------------------------------------------
select d.department_id, department_name, location_id, 
       count(employee_id)
from departments d left outer join employees e
on d.department_id = e.department_id
group by d.department_id, department_name, location_id
order by 1;

-- 연습문제3 ---------------------------------------------------------------------------------------------------------------------
select d.department_id, department_name, count(*)
from departments d, employees e
where d.department_id = e.department_id
group by d.department_id, department_name
having count(*) < 3;
