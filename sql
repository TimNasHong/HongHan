insert into tb_emp(id,name,count,password,entrydate,updatetime) values (1,'hyn','123456','123456P',now(),now());
insert into tb_emp values (2,'lwd','qwe123','as123',now(),now());
insert into tb_emp values (null,'ldd','rwe123','as123',now(),now());

update tb_emp set name='马牛逼',updatetime=now() where id=1;
update tb_emp set entrydate='2023-09-25 16:00:00';
update tb_emp set updatetime=now();

delete from tb_emp where id=1;

select * from tb_emp02;
select username,password,job from tb_emp02 ;
select id ID,name 名字 from tb_emp02;
select distinct job from tb_emp02;
select *from tb_emp02 where job=1;
select*from tb_emp02 where job is null;
select *from tb_emp02 where password!='123456';
select *from tb_emp02 where job in (1,2,3);
select *from tb_emp02 where job=1 or job=2 or job=3;
select *from tb_emp02 where entrydate between '2000-01-01' and'2010-01-01';
select *from tb_emp02 where name like '___';
select *from tb_emp02 where name like '张%';
select distinct job from tb_emp02 where name like '张%';
select avg(id) from tb_emp02 where id>25;
select max(id) from tb_emp02 where job=1;
select sum(id) from tb_emp02;
select min(id) from tb_emp02 where name like('__');
select count(*) from tb_emp02 where name like('___');
select job,count(*) from tb_emp02  where id<=20 group by job having count(*)>=2;
select *from tb_emp02 order by entrydate,update_time desc ;
select*from tb_emp02 limit 0,10;
select *from tb_emp02 limit 10,10;
select *from tb_emp02 limit 20,10;
select if(gender=1,'男生','女生') 性别,count(*) 人数 from tb_emp02 group by gender;
select (case job when 1 then'老师' when 2 then'学生' when 3 then '教导主任' when 4 then '校长' else '未知职位' end) 职位,count(*) 人数
from tb_emp02 group by job;

-- 员工管理(带约束)
create table tb_emp02 (
                        id int unsigned primary key auto_increment comment 'ID',
                        username varchar(20) not null unique comment '用户名',
                        password varchar(32) default '123456' comment '密码',
                        name varchar(10) not null comment '姓名',
                        gender tinyint unsigned not null comment '性别, 说明: 1 男, 2 女',
                        image varchar(300) comment '图像',
                        job tinyint unsigned comment '职位, 说明: 1 班主任,2 讲师, 3 学工主管, 4 教研主管',
                        entrydate date comment '入职时间',
                        create_time datetime not null comment '创建时间',
                        update_time datetime not null comment '修改时间'
) comment '员工表';



select *from tb_emp;
select *from tb_dept;
select *from tb_dept,tb_emp;
select*from tb_emp,tb_dept where tb_emp.dept_id=tb_dept.id;
 -- 内连接
select e.name ,d.name from tb_emp e,tb_dept d where e.dept_id=d.id;
select e.name ,d.name from tb_emp e inner join tb_dept d on e.dept_id=d.id;
 -- 外连接
-- 左外连接
select e.name,d.name from tb_emp e left join tb_dept d on e.dept_id = d.id;
-- 右外连接
select e.name,d.name from tb_emp e right join tb_dept d on e.dept_id=d.id;
select tb_emp.name  from tb_emp where dept_id=(select id from tb_dept where name='学工部');
select *from tb_emp where dept_id in (select id from tb_dept where name='学工部' or name='人事部');
select*from tb_emp where (entrydate,job)=(select entrydate ,job from tb_emp where name='韦一笑' );
select e.*,d.name 部门 from (select*from tb_emp where entrydate>'2001-01-01') e,tb_dept d where e.dept_id=d.id;
select e.name,if(e.gender=1,'男','女') 性别,e.entrydate,d.name from (select*from tb_emp where name like'___' and entrydate between '2001-01-01' and '2020-01-01') e,tb_dept d where e.dept_id=d.id;
select d.name ,d.id ,e.id,e.dept_id from tb_dept d,tb_emp e where d.name='学工部' and e.entrydate between '2001-01-01' and '2020-01-01' and e.dept_id=d.id;
select e.id,e.name 姓名,e.dept_id 部门编号,d.name 部门 from tb_emp e,tb_dept d  where e.dept_id=d.id;

-- 1. 查询价格低于 10元 的菜品的名称 、价格 及其 菜品的分类名称 .
select d.name,d.price,c.name  from dish d,category c where d.price<10 and c.id=d.category_id;

-- 2. 查询所有价格在 10元(含)到50元(含)之间 且 状态为'起售'的菜品名称、价格 及其 菜品的分类名称 (即使菜品没有分类 , 也需要将菜品查询出来).
select d.name '菜品名称',d.price '菜品价格',c.name '菜品分类' from dish d ,category c where d.price between 10 and 50 and d.status=1 and d.category_id=c.id;

-- 3. 查询每个分类下最贵的菜品, 展示出分类的名称、最贵的菜品的价格 .
select c.name '菜品', max(d.price) '最贵' from dish d,category c where d.category_id=c.id group by c.name;

-- 4. 查询各个分类下 状态为 '起售' , 并且 该分类下菜品总数量大于等于3 的 分类名称 .
select c.name,count(*)  from dish d, category c where d.category_id=c.id and  d.status=1 group by c.name having count(*)>=3;

-- 5. 查询出 "商务套餐A" 中包含了哪些菜品 （展示出套餐名称、价格, 包含的菜品名称、价格、份数）.
select s.name,s.price,d.name,d.price,sd.copies  from dish d,setmeal s,setmeal_dish sd where d.id=sd.dish_id and s.id=sd.setmeal_id and s.name='商务套餐A';

-- 6. 查询出低于菜品平均价格的菜品信息 (展示出菜品名称、菜品价格).
select d.name,d.price from dish d where d.price<(select avg(price) from dish);
select avg(price) from dish
