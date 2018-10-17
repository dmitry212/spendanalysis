--set propoer dt format in trans_dt
update transactions set trans_dt =
case 
when length(Date) < 10 then
substr(Date,6) || '-0' || substr(Date,1,1) || '-' || substr(Date,3,2)
else
substr(Date,7) || '-' || substr(Date,1,2) || '-' || substr(Date,4,2)
end; 

select * from transactions where OriginalDescription like 'Payment%' AND OriginalDescription not like '%PAYPAL%' AND LABEL = '' order by 5 desc;

select * from transactions where category = 'Transfer' and description IN  ('Venmo','Inst Xfer') and label != 'IGNORE' AND AMOUNT > 150 AND TRANS_DT > '2018-02-01' ORDER BY 1; 
UPDATE transactions SET LABEL = 'IGNORE' where category = 'Transfer' and description NOT IN  ('Venmo','Inst Xfer') and label != 'IGNORE';

UPDATE transactions SET LABEL = 'BALEN' WHERE category = 'Transfer' and description IN  ('Venmo','Inst Xfer') and label != 'IGNORE' 
AND AMOUNT > 150 
AND TRANS_DT > '2018-02-01' 
AND ACCOUNTNAME = 'SHARED CHECKING';

UPDATE transactions set label = 'IGNORE' WHERE OriginalDescription like 'Payment%' AND 
OriginalDescription not like '%PAYPAL%' AND LABEL = '';

SELECT SUM(AMOUNT) FROM transactions WHERE LABEL = '' ORDER BY AMOUNT desc;

select SUBSTR(TRANS_DT,6,2) || '/' || SUBSTR(TRANS_DT,3,2) as 'mm/yy',  label, sum(-1 * amount) AS 'TOTAL' from transactions WHERE LABEL NOT IN  ('IGNORE','INCOME') 
group by SUBSTR(TRANS_DT,6,2) || '/' || SUBSTR(TRANS_DT,3,2), label 
--order by 1,2 desc 
UNION
select SUBSTR(TRANS_DT,6,2) || '/' || SUBSTR(TRANS_DT,3,2) as 'mm/yy',  label, sum(amount) from transactions WHERE LABEL != 'IGNORE'  AND LABEL = 'INCOME'
group by SUBSTR(TRANS_DT,6,2) || '/' || SUBSTR(TRANS_DT,3,2), label
order by 1,2 desc ;

select SUBSTR(TRANS_DT,6,2) || '/' || SUBSTR(TRANS_DT,3,2) as 'mm/yy', sum(-1 * amount) AS 'TOTAL' from transactions WHERE LABEL NOT IN  ('IGNORE','INCOME') 
group by SUBSTR(TRANS_DT,6,2) || '/' || SUBSTR(TRANS_DT,3,2) 
--order by 1,2 desc 
UNION
select SUBSTR(TRANS_DT,6,2) || '/' || SUBSTR(TRANS_DT,3,2) as 'mm/yy', sum(amount) from transactions WHERE LABEL != 'IGNORE'  AND LABEL = 'INCOME'
group by SUBSTR(TRANS_DT,6,2) || '/' || SUBSTR(TRANS_DT,3,2)
order by 1,2 desc ;

update 
--CASH
UPDATE transactions set LABEL = 'LIFESTYLE' WHERE UPPER(DESCRIPTION) LIKE '%AMAZON%' AND LABEL = '';-- ORDER BY 5 desc;

UPDATE transactions set LABEL = 'FOOD' WHERE UPPER(CATEGORY) LIKE '%COFFEE%' AND LABEL = '';-- ORDER BY 5 desc;
UPDATE transactions SET LABEL = 'CASH' WHERE upper(DESCRIPTION) LIKE 'CASH%ATM%';
UPDATE transactions SET LABEL = 'IGNORE' WHERE ORIGINALDESCRIPTION LIKE 'Preauthorized Deposit from BANK';

UPDATE transactions set label = 'IGNORE' WHERE ACCOUNTNAME= 'DMITRY CC' AND DESCRIPTION LIKE 'Capital%';

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