set serveroutput on;

create or replace function total_income return number is
total number(5);
begin
    select sum(paid) into total from manager;
    return total;
end total_income;




create or replace procedure show_rest is
total_bought_that_type TYPE_DETAILS.EGGS_GIVEN%type;
tmp manager.bought%type;
type restarray is varray(12) of MANAGER.BOUGHT%type;
total_rest restarray:=restarray();

begin
for counter in 1..10
loop
    total_rest.extend;
        select sum(bought) into total_bought_that_type from manager where type_id=counter;
        select sum(eggs_given) into tmp from type_details where type_id=counter;
        total_rest(counter):=tmp - total_bought_that_type;
    end loop;
    
    for counter in 1..10
    loop
    dbms_output.put_line('Rest eggs of type '||counter || ' is ' || total_rest(counter) );
    end loop;
end show_rest;





create or replace procedure total_rest is
m_bought number(4);
tmp number(4);
begin
    for counter in 1..100
    loop
        select sum(bought) into m_bought from manager;
        select sum(eggs_given) into tmp from type_details;
    end loop;
    tmp:=tmp-m_bought;
    dbms_output.put_line('Unsold eggs are '|| tmp);
end total_rest;

create or replace procedure dues(c_id manager.customer_id%type) is
cursor c1 is select egg_price from chicken where id in(select type_id from manager where customer_id=c_id);
cursor c2 is select bought,paid from manager where customer_id=c_id;

e_price chicken.egg_price%type;
total MANAGER.BOUGHT%type:=0;
tmp MANAGER.PAID%type:=0;
var_cur c2%rowtype;

begin
    open c1;
    open c2;
loop
    fetch c1 into e_price;
    fetch c2 into var_cur;
exit when c1%notfound or c2%notfound;
    total:=total+(e_price*var_cur.bought);
    tmp:=tmp+(var_cur.paid);
    
end loop;
total:=total-tmp;
dbms_output.put_line('Dues of Customer '||c_id|| ' is ' ||total);
end dues;

drop procedure donot_give;
drop table unwanted_customers;

create or replace procedure donot_give(c_id customer.CUSTOMER_ID%type) is
cursor c1 is select egg_price from chicken where id in(select type_id from manager where customer_id=c_id);
cursor c2 is select bought,paid,transaction_on from manager where customer_id=c_id;

e_price chicken.egg_price%type;
total MANAGER.BOUGHT%type:=0;
tmp MANAGER.PAID%type:=0;
var_cur c2%rowtype;
var1 varchar(200);
begin
    open c1;
    open c2;
    var1:='create table unwanted_customers(
        customer_id number(3),
        dues_amount number(6,3),
        foreign key(customer_id) references customer(customer_id))';
    execute immediate var1;
    
    loop
    fetch c1 into e_price;
    fetch c2 into var_cur;
exit when c1%notfound or c2%notfound;
    total:=total+(e_price*var_cur.bought);
    tmp:=tmp+(var_cur.paid);
    
end loop;

dbms_output.put_line(total ||' '|| tmp ||' ' || total*4/5);
if(total*4/5>tmp)
then    
    total:=total-tmp;
    /*insert into unwanted_customers values(c_id,total);    */
    dbms_output.put_line('This customer have dues greater than 20% of his total purchase');
else
   dbms_output.put_line('This customer is safe for the next month');
   end if;
end donot_give;

declare
   
begin
    dbms_output.put_line('Total Income tk. ' || total_income);

    show_rest(); /*Array Wise rest of the eggs with type*/
    total_rest(); /*total resto of the eggs*/
    dues(6);/*shows dues of a customer with his id*/
    donot_give(1);
end;
/
