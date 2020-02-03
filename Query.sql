select * from jobsekeer;
select * from company;
select * from job;

select * from jobapply;
-----column add---------
alter table jobsekeer add nickname integer;
-------------column type modify-----
alter table jobsekeer modify nickname varchar(10);
------
alter table jobsekeer rename column nickname to nick;
alter table jobsekeer drop column nick;




update jobsekeer set  name='Zabirul' where  user_id =110;
select  name,jobsekeer.user_id ,job_id from jobsekeer ,jobapply  where jobsekeer.user_id=jobapply.user_id;
select * from jobsekeer;
select  (age*5),name as agex5 from jobsekeer where name like '%a%';
select name , age,user_id,qualification from jobsekeer order by age desc;
select count(distinct age) as sameage from jobsekeer ;
select sum (age) as totalage from jobsekeer;
select avg (age) as avgage from jobsekeer;
select min (age) as minage from jobsekeer;
select max (age) as maxage from jobsekeer;
select name,sum(age) from jobsekeer group by name ;
update jobsekeer set age=age+4 where user_id >111;
select * from jobsekeer;
select * from age_view;
select js.name,js.age ,js.qualification,ja.job_id from jobsekeer js join jobapply ja using (user_id);


