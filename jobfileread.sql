set serveroutput on
declare
    f utl_file.file_type;
    line varchar(1000);
    userid jobapply.user_id%type;
    jobid jobapply.job_id%type;
begin
    f :=utl_file.fopen('DATABASE', 'jobcondition.csv', 'r');
    if utl_file.is_open(f) then 
        utl_file.get_line(f, line, 1000);
            loop begin
            utl_file.get_line(f, line, 1000);
            if line is null then exit;
            end if;
           userid:=regexp_substr(line, '[^,]+',1,1);
           jobid:=regexp_substr(line, '[^,]+',1,2);
            
           INSERT INTO jobapply VALUES(userid,jobid);
           commit;
           
            --dbms_output.put_line(userid||' '||jobid);
            exception when no_data_found then exit;
            end;
            end loop;
    end if;
   
    utl_file.fclose(f);
   end;
    /