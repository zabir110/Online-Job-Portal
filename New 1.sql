set serveroutput on
declare 
f utl_file.file_type;
line varchar(100);
user_id jobapply.user_id%type;
job_id jobapply.job_id%type;
begin 
f:=utl_file.fopen('JOBPORTAL','jobcondition.csv','r');
if utl_file.isopen(f) then
utl_file.get_line(f,line,100);
loop
utl_file.get_line(f,line,100);
dbms_output.put_line(line);
end loop;
end if;
