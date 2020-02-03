set serveroutput on;


--------------------------------View company------------------------------
create or replace procedure  view_company is 
com company.com_name%type;
address company.com_address%type;
service company.services%type;
contact company.com_contact_no%type;
v integer;
cm integer;
begin

select count(com_id) into v from company;
cm:=1000;
for counter in 1..v
loop

select com_name,com_address,services,com_contact_no into com,address,service,contact from company where com_id=cm;
dbms_output.put_line('Company id :'||cm||' Company Name: '|| com||'  Address : '||address||' services: '||service||' Contact no : '||contact);
cm:=cm+1;

end loop;


end;

---------------------------View Job-------------------------------------------
create or replace procedure view_job is
post job.post%type;
v job.vacancy%type;
s job.salary%type;
c_name company.com_name%type;
jobno integer;
cm integer;
begin

select count(job_id) into jobno from job;
cm:=1;
for counter in 1..jobno
loop

select com_name into c_name from company where com_id in( select com_id from job where job_id=cm);
select post,vacancy,salary into post,v,s from job where job_id=cm;
dbms_output.put_line('Job id:'||cm||' Comapny : '|| c_name ||' Post : '|| post||' Vacancy : '|| v||' Salary : '||s);
cm:=cm+1;

end loop;
end;
/

------------------------------------view_applied------------------------------

create or replace procedure view_applied(js_id JOBSEKEER.USER_ID%type)is 
cursor js_info is select job_id from jobapply where user_id=js_id;
js_record js_info%ROWtype;
post job.post%type;
des job.description%type;

begin
open js_info;

loop
fetch js_info into js_record;
exit when js_info%notfound;
select post,description into post ,des from job where job_id=js_record.job_id ;
DBMS_OUTPUT.PUT_LINE ('Job id : '||js_record.job_id || '  ' ||'Post :'||post||'    Description : '||des);
end loop;
close js_info;
end;

/
----------------------view profile---------------------------

create or replace procedure view_profile(js_id integer) is
age jobsekeer.age%type;
addr jobsekeer.address%type;
nam jobsekeer.name%type;
qual jobsekeer.qualification%type;
ex jobsekeer.experience%type;
con jobsekeer.contact_no%type;
begin

select name,age,address,qualification,experience,contact_no into nam,age,addr,qual,ex,con from jobsekeer where user_id=js_id;
DBMS_OUTPUT.PUT_LINE ('Name = '||nam || '    ' ||' age = '||age|| '     ' ||'Address = '||addr||' Qualification = '||qual|| '    ' ||' Experience = '||ex|| '     ' ||' Contact no = '||con);

end;
/

------------------------Sign_in----------------------------------------

create or replace procedure sign_in(us_id integer,nam varchar,age varchar,ad varchar,q varchar,ex varchar,con varchar) is
ch integer;
begin 
select count(nam) into ch from jobsekeer where user_id=us_id;

if(ch>0) then dbms_output.put_line(' You are already register in Online Job portal !!');
else 
INSERT INTO jobsekeer(user_id,name,age,address,qualification,experience,contact_no)
	VALUES(us_id,nam,age,ad,q,ex,con );
	dbms_output.put_line('Successfully registration in Online Job portal');
end if;
end;
/
---------------------Apply Job----------------------------------------
create or replace procedure apply_job(us_id integer,jid integer) is
ch integer;
begin
select count(job_id) into ch from jobapply where user_id=us_id and job_id=jid;

if(ch>0) then dbms_output.put_line(' You are already apply for this job');

else
INSERT INTO jobapply(user_id,job_id) VALUES(us_id,jid);
dbms_output.put_line('You are successfully apply for this job ');
end if;

end;
/
-------------------job_offer_by_company------------------
create or replace procedure com_offer(comid job.com_id%type) is

cursor com_post is select post,vacancy from job where com_id=comid;
com_record com_post%ROWtype;
com_name COMPANY.COM_NAME%type;
begin
select com_name into com_name from company where com_id=comid;
DBMS_OUTPUT.PUT_LINE ('--------'||com_name||' Job offers --------- ');
open com_post;

loop

fetch com_post into com_record;
exit when com_post%notfound;
DBMS_OUTPUT.PUT_LINE ('Post = '||com_record.post || '  ' ||'vacancy = '||com_record.vacancy);
end loop;
close com_post;
end;
/
--------------------------------Home search-------------------------------------------

create or replace procedure home_search(des job.description%type) is
cursor keyword is select * from job join company on COMPANY.COM_ID=job.com_id where description like '%'||des||'%' or com_name like '%'||des||'%';
com_record keyword%ROWtype;
com_name COMPANY.COM_NAME%type;
begin
open keyword;
loop

fetch keyword into com_record;
select com_name  into com_name from company where com_id in(select com_id from job where job_id = com_record.job_id);

exit when keyword%notfound;
DBMS_OUTPUT.PUT_LINE ('Job id = '||com_record.job_id|| '    ' ||'Company Name = '||com_name || '    ' ||' vacancy = '||com_record.vacancy|| '     ' ||' Salary= '||com_record.salary|| '     ' ||' Post = '||com_record.post|| '     ' ||' Description = '||com_record.description||' City = '||com_record.city);
end loop;
close keyword;
end;
/
---------------delete job--------------------------
create or replace procedure delete_job(jobid integer) is

begin
delete from job where job_id=jobid;
DBMS_OUTPUT.PUT_LINE ('Successfully deleted job id  '||jobid);
end;
/
---------------------ADD job-------------------------
create or replace procedure add_job(job_id integer ,com_id varchar ,s integer,post varchar , v integer,des varchar,city varchar) is

begin 
INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(job_id,com_id,s,post,v,des,city);
DBMS_OUTPUT.PUT_LINE ('Successfully Inserted job id  '||job_id);
end;
/
-------------------Register company--------------------

create or replace procedure register_company(comid integer ,comname varchar ,address varchar,service varchar ,con varchar) is
ch integer ;
begin
select count(com_name) into ch from company where com_id=comid and com_name=comname;
if(ch>0) then dbms_output.put_line('This company is  already register  here !!!'|| ch);
else
    INSERT INTO company(com_id,com_name,com_address,services,com_contact_no)
	VALUES(comid,comname,address,service,con );
	DBMS_OUTPUT.PUT_LINE ('Successfully register in Online Job portal');
end if;
end;

/
---------------------------Update Job-------------------
create or replace procedure update_job(jobid integer,comid integer,v integer)is
begin
update job set  vacancy=v where  job_id =jobid and com_id=comid;
DBMS_OUTPUT.PUT_LINE ('Successfully updated job id :'||jobid);
end;
/

---------------------------------------------------------------------------
create or replace procedure process_select(jobid integer) is
cursor applier is select user_id from jobapply where job_id=jobid;
js_record applier%ROWtype;
ex varchar(20);
comname varchar(20);
max_ex varchar(20);
cg number(3,2);
max_usid integer;
v integer;
vacan integer;
total number(3,2);
qual varchar(20);
qrate integer;


begin
select vacancy into v from job where job_id=jobid;
vacan:=v;
select com_name into comname from company where com_id in (select com_id from job where job_id=jobid);
max_ex:=0;

open applier;

loop

fetch applier into js_record;
exit when applier%notfound ;

select experience into ex from jobsekeer where user_id=js_record.user_id; 
select cgpa into cg from jobsekeer where user_id=js_record.user_id; 
select qualification into qual from jobsekeer where user_id=js_record.user_id;

if(qual like 'B.S.C%') then qrate:=1;
elsif (qual like 'M.S.C%')  then qrate:=2;
elsif(qual like 'P.H.D%') then qrate:=3;
end if;
total:=(ex*.3)+(cg*.7)+(qrate*.5);

DBMS_OUTPUT.PUT_LINE (total||' ');

if (total>=max_ex) then 
max_ex:=total;
max_usid:=js_record.user_id;
end if;
end loop;

close applier;

if(max_ex>0 and vacan>0) then
insert into selection values(jobid,comname,max_usid);
delete from jobapply where user_id=max_usid and job_id=jobid;
DBMS_OUTPUT.PUT_LINE ('User id : '||max_usid||' Successfully selected for job no : '||jobid);
vacan:=vacan-1;
DBMS_OUTPUT.PUT_LINE ('VAcan : '||vacan);
update job set  vacancy=vacan where  job_id =jobid;

end if;
end;
/

---------------selection process----------------------------------

create or replace procedure process_selection(jobid integer) is
v integer;


begin
select vacancy into v from job where job_id=jobid;
DBMS_OUTPUT.PUT_LINE ('----Selected Applicants --------- ');

for counter in 1..v
loop

process_select(jobid);

end loop;   
    
end;
/


------------------view selected--------------------
create or replace procedure view_selected(usid integer) is

cursor applier is select * from selection where user_id=usid; 
js_record applier%ROWtype;


begin
open applier;
DBMS_OUTPUT.PUT_LINE ('----------You are selected for below jobs--------');

loop

fetch applier into js_record;
exit when applier%notfound ;

DBMS_OUTPUT.PUT_LINE ('Job id : '||js_record.job_id||'   '||js_record.com_name);

end loop;
close applier;
end;
/

--------------------------Delete Accounnt-------------------
create or replace procedure delete_account(usid integer) is
begin
delete  from jobsekeer  where user_id=usid;
DBMS_OUTPUT.PUT_LINE ('Successfully deleted juser account  '||usid); 
end;
/

------------------------Confirm Job---------------------


create or replace procedure confirm_job(usid integer,jobid integer) is
cursor c1 is select job_id from selection where user_id=usid;
begin

for multiple_job in c1
loop

if (jobid!=multiple_job.job_id) then 
delete_from_selection(multiple_job.job_id,usid);

end if;

end loop;

end;


create or replace procedure delete_from_selection(jobid integer,usid integer) is
begin
delete from selection where job_id=jobid and user_id=usid;
end;