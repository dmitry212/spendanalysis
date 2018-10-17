select  label, sum(amount) from transactions where label != 'IGNORE' AND TRANS_DT < '2018-01-01' GROUP BY LABEL order by 1

select  label, sum(amount) from transactions where label != 'IGNORE' AND strftime('%m',TRANS_DT) = '09' and trans_dt >  '2018-01-01' GROUP BY LABEL order by 1;

select  strftime('%m %Y', trans_dt) from transactions;




select strftime('%m', trans_dt), sum(amount) from transactions where label NOT IN ('IGNORE','INCOME') AND TRANS_DT > '2018-01-01' and accouNtname = 'SHARED CHECKING'
 GROUP BY strftime('%m', trans_dt) order by 1;



update transactions set label = 'MAZIE' WHERE LABEL ='MAZE';