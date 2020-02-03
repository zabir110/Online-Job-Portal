set serveroutput on;

declare 
cursor c_name is select name,user_id from jobsekeer;
 c_record c_name%rowtype;
   
 begin
 open c_name;
 loop
 fetch c_name into c_record;
 exit when c_name %notfound;
 dbms_output.put_line('id '|| c_record.user_id||' name: '||c_record.name);
 end loop;
 close c_name;
 end;             
 /--------------------------------------------
 
 
 declare 
cursor c_name is select name,user_id from jobsekeer;
 begin
 for   c_record in c_name
 loop
 
 dbms_output.put_line('id '|| c_record.user_id||' name: '||c_record.name);
 end loop;

 end;  