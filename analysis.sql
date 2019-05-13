CREATE TABLE "transactions_TMP" ( `trans_dt` TEXT, `Date` TEXT, `Description` TEXT, `OriginalDescription` TEXT, `Amount` NUMERIC, `TransactionType` TEXT, `Category` TEXT, `AccountName` TEXT, `Label` TEXT, `key` TEXT )

select  label, sum(amount) from transactions where label != 'IGNORE' AND TRANS_DT > '2018-01-01' GROUP BY LABEL order by 1

select  label, sum(amount) from transactions where label != 'IGNORE' AND strftime('%m',TRANS_DT) = '09' and trans_dt >  '2018-01-01' GROUP BY LABEL order by 1;

select  strftime('%m %Y', trans_dt) from transactions;

INSERT INTO transactions
SELECT DISTINCT * FROM transactions_TMP

delete from transactions

select DISTINCT LABEL FROM transactions

SELECT COUNT(*) FROM transactions

select ROW_NUMBER() OVER (order by key) rowNumberRank, key from transactions; 

select strftime('%m', trans_dt), sum(amount) from transactions where label NOT IN ('IGNORE','INCOME') AND TRANS_DT > '2018-01-01' and accouNtname = 'SHARED CHECKING'
 GROUP BY strftime('%m', trans_dt) order by 1;



update transactions set label = 'MAZIE' WHERE LABEL ='MAZE';