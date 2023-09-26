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
