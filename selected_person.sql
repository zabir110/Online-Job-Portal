set serveroutput on
declare
    f utl_file.file_type;
    cursor c is select * from selection;
     
begin
    f :=utl_file.fopen('DATABASE', 'selected.csv', 'w');
    utl_file.put(f, 'job_id' || ',' ||  'com_name' || ',' || 'user_id');
    utl_file.new_line(f);
    for c_record in c
    
        loop
        --DBMS_OUTPUT.PUT_LINE (c_record.job_id || ',' ||  c_record.com_name || ',' || c_record.user_id);
             utl_file.put(f, c_record.job_id || ',' ||  c_record.com_name || ',' || c_record.user_id);
             utl_file.new_line(f);
             end loop;
    
    utl_file.fclose(f);
   end;
    /