set serveroutput on
declare 
f utl_file.file_type;
cursor c1 is select * from selection;

begin
  f:=utl_file.fopen('DATABASE','ss.csv','w');
  utl_file.put(f,'j'||','||'com'||','||'us');
  utl_file.new_line(f);
  for record in c1
  loop
  DBMS_OUTPUT.PUT_LINE (record.job_id || ',' ||  record.com_name || ',' || record.user_id);
  --utl_file.put(f,record.job_id||','||record.com_name||','||record.user_id);
 utl_file.new_line(f);
  
  end loop;
  
end;