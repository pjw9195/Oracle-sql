select * from emp;
select * from dept;
/* ������ employees ���� �� ����� 2���� ���̺� 
   join�� �˱� ���ؼ� ���� �����͸� ���� ���̺�� */
 
insert into emp
values(500,'Mike',2000,null);
commit;

/* ������ ��û ū �������Ϸ� ������� �־����� '�������� ����ȭ'�� ���� �������� ��������(emp,dept)�� ������ ������ �ʿ� */


-- 1.�����Ҷ� ������ ��� : where��-----------------------------------------------------------------------------------------------
select empno, ename, emp.deptno, dept.deptno, dname
from   emp, dept
where  emp.deptno = dept.deptno;
--and emp.sal >=3000;

/* �������� ���̺��� �����͸� ���������� where ������ emp�� deptno�� ddept�� deptno�� ���ٴ°���
   �ݵ�� ������־���Ѵ�.!!!!!!!!!!!!!!!!! */
   
-- 1.�����Ҷ� ANSII�� �����ϴ� ��� 1( join, on��) -----------------------------------------------------------------------------------------------
select empno, ename, emp.deptno, dept.deptno, dname
from   emp join dept
on     emp.deptno = deptno
where  emp.sal >= 3000;

/* ANSII������ �޸�(,) ��� join�� !! where ��ſ� on���� !! ����Ѵ�.*/


-- 2. �����Ҷ� ANSII�� �����ϴ� ���2 ( join, using��) -----------------------------------------------------------------------------------------------
select emp.empno, emp.ename, deptno, deptno, dept.dname
from emp join dept
using(deptno);

-- 3. �����Ҷ� ANSII�� �����ϴ� ���3 ( natural Ű����, join, using��) -----------------------------------------------------------------------------------------------
select emp.empno, emp.ename, deptno, deptno, dept.dname
from emp natural join dept;
/* natural join : �������� �̸��� �Ȱ��� �� �ƴ϶� �������� Ÿ�� ���� ���ƾ� !!! join�� �Ѵٴ� Ű�����̴�. */

-- 4. ���̺� AS�� ������ Ư¡ !!!-----------------------------------------------------------------------------------------------
select empno, ename, e.deptno, d.deptno, dname
from emp e, dept d
where e.deptno = d.deptno;

/* ���̺��� as�� colum������ as�� �޸� ���̺��� ��� ��Ī���� ����� �����ϴ�.!!!!!!!!!!!!!!!!!!
   where ������ e.deptno */

--5. 3���� ���̺� join -----------------------------------------------------------------------------------------------
select * from departments;
select * from locations;

select employee_id, first_name, 
       e.department_id, d.department_id, department_name,
       d.location_id, l.lcation_id, city
from employees e, departments d, locations l
where e.department_id = d.departmnet_id
and d.location_id = l.location_id;



--6. ��ȯ�� ���̺�(employees)���� ���� join�ϱ� !! <<<<self join>>>> (�ſ��߿�) (���̵� ��)--------------------------------------------------------------------
select w.employee_id, w.first_name, w.manager_id, m.name
from employees w, emp_test m
/* employees���� employee id, first_name, manager id�� �ҷ����� 
   �� employee�� manager�� �̸� (m.name)�� �ٸ� ���̺�(emp_test)���� �ҷ��´�..! 
   (emp_test�� manager_id�� name�� ����� ������ ���̺��̶�� �����Ѵ�)*/
where w.manager_id = m.empno;
/* �׸��� employees�� ���̺�(w)������ manager_id �� emp_test(m)���� manger_id�� �ش��ϴ� empno��
   where���� ���ؼ� ���������ش�...!!! 
    
    �׷���, �̰��� �������� emp_test��� ���̺��� �ִٰ� �����Ѱ�... �׷��� ������ ���� �翬�ϴ�..
    employees ���̺��� ����̸� -> �Ŵ���ID -> �Ŵ����� ����̴ϱ� �Ŵ����� �̸��� ���� table�� ����. ... �̷������� ��ȯ�� �����̴�....!!*/

select w.employee_id, w.first_name, w.manager_id, m.first_name
from employees w, employees m
where w.manager_id = m.employee_id;
/*�׷��Ƿ� �ٸ� ���̺��̶�� �����ߴ� emp_test, m.name, m.empno�� employees���̺� �°� �ٽ� �ٲ��ش�...!!!!!!*/


--7.Nonequijoin ( ������ ���������ִ� join) --------------------------------------------------------------------------------------------------
-- �ϴ� ���߿� ������� salgrad��� ���̺��� ���Ƿ� �������
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
-- salgrad ���̺� �ϼ� ( salary�� ������ low����, med���� , higt���� �Ǵ��ϴ� ���̺� )
  
select empno,ename, sal, grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

/*from���� 2���� ���̺��� ���� �ݵ�� where������ � colum�� � colum�� �����Ǵ��� �����־����..!!
  �׷���, ���⼭�� 2���� ���̺��� ������ �����Ǵ� ���� colum�� ���� ����̴�. !!
  
  ���⼭, �˰� ���� ���� ����� salary�� �ְ� �� salary�� <salgrade> ���̺����� � ������ ���ϴ����� �˰� ���� ���̴�. 
  �׷��Ƿ�, where������ �����Ǵ� = ǥ�ð� �ƴ� ���� ǥ���� between ~ and �� ������־� �������� �ش�...!!! */

-- 8. outer join : ���þ��� 2���� ���̺� join�ϱ� --------------------------------------------------------------------------------------------------------------------------------------
--���±����� 2���� ���̺��� ���� �����Ǵ°��� join�ߴµ�, ������ �����Ǵ� ���� ���� ���� 2���� ���̺��� join�Ѵ�..!

--outer join�� ansii ����� ���ϹǷ� ansii����� ����Ѵ�..!

-- 8.1 Ű���� : outer join , left , right ,  full
select empno, ename, e.deptno, d.deptno, dname 
from   emp e left outer join dept d 
on     e.deptno = d.deptno;
/* �Ϲ����� join�� �ƴϹǷ� outer join�� ���ְ� 
   emp���̺��� �������� ��ġ�Ǵ°͸� ������� dept ���̺��� �������� ��ġ�Ǵ°͸� ����Ұ����� �����ش�..!
   emp���̺��� �������� �����Ҳ��ϱ� left ��� ! */

select empno, ename, e.deptno, d.deptno, dname 
from   emp e right outer join dept d 
on     e.deptno = d.deptno;

select empno, ename, e.deptno, d.deptno, dname 
from   emp e full outer join dept d 
on     e.deptno = d.deptno;
/* ���� ���̺� ���ؼ� ��ġ�� �Ǵ°��� ��� ������ٷ���, full ��� !! */

select *
from locations;
select *
from employees;
select *
from departments;
select *
from countries;

-- ��������1 ---------------------------------------------------------------------------------------------------------------------
select location_id, street_address, city, state_province, country_name
from locations l, countries c
where l.country_id = c.country_id; 

-- ��������2 ---------------------------------------------------------------------------------------------------------------------
select d.department_id, department_name, location_id, 
       count(employee_id)
from departments d left outer join employees e
on d.department_id = e.department_id
group by d.department_id, department_name, location_id
order by 1;

-- ��������3 ---------------------------------------------------------------------------------------------------------------------
select d.department_id, department_name, count(*)
from departments d, employees e
where d.department_id = e.department_id
group by d.department_id, department_name
having count(*) < 3;
