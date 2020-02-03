set serveroutput on;
declare
type namearray is varray(5) of jobsekeer.name%type;
sekeer_name namearray := namearray();
coun number(2);
n varchar(10);

begin

for coun in 1..5
loop
sekeer_name.extend;
select name into sekeer_name(coun) from jobsekeer where  user_id=110+coun;
dbms_output.put_line(sekeer_name(coun));
end loop;

end;