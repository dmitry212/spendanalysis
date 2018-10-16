--set propoer dt format in trans_dt
update transactions set trans_dt =
case 
when length(Date) < 10 then
substr(Date,6) || '-0' || substr(Date,1,1) || '-' || substr(Date,3,2)
else
substr(Date,7) || '-' || substr(Date,1,2) || '-' || substr(Date,4,2)
end; 

select * from transactions where OriginalDescription like 'Payment%' AND OriginalDescription not like '%PAYPAL%' AND LABEL = '' order by 5 desc;

UPDATE transactions set label = 'IGNORE' WHERE OriginalDescription like 'Payment%' AND 
OriginalDescription not like '%PAYPAL%' AND LABEL = '';


SELECT * FROM transactions WHERE ACCOUNTNAME = 'NATASHA CHECKING' AND CATEGORY = 'Credit Card Payment'
AND originalDescription not like 'Gap%';

update transactions set label = 'IGNORE' where ACCOUNTNAME = 'NATASHA CHECKING' AND CATEGORY = 'Credit Card Payment'
AND originalDescription not like 'Gap%';


update transactions set AccountName = upper(AccountName); --set upper
delete from transactions where amount < 1; --remove small stuff

update transactions_v2 set key = trans_dt || OriginalDescription || Amount;

update transactions set AccountName = 
(select transactions_v2.AccountName from transactions_v2
	where transactions_v2.key = transactions.key);


transactions_v2.AccountName 
from transactions join transactions_v2 on transactions.key = transactions_v2.key;

select * from transactions;

commit;

--filter to '17 and beyond
delete from transactions where trans_dt < '2017-01-01';


commit;
--food labels
select * from transactions where Category = 'Fast Food'
update transactions set label = 'FOOD' where Category = 'Fast Food'
commit;
select distinct(OriginalDescription) from transactions where Category like lower('%food%')
and Category not like lower('%ps%9%') and Category not like lower('pet%') order by 1
update transactions set label = 'FOOD' where Category like lower('%food%')
and Category not like lower('%ps%9%') and Category not like lower('pet%');
commit;
--income
update transactions set label = 'INCOME' where Category = 'Paycheck';


select * from transactions where label is '' order by 4;