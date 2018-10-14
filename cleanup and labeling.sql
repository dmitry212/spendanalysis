select Date, length(Date), 
case 
when length(Date) < 10 then
substr(Date,6) || '-' || substr(Date,3,2) || '-0' || substr(Date,1,1)
else
substr(Date,7) || '-' || substr(Date,4,2) || '-' || substr(Date,1,2)
end
from transactions

select min(length(Date)) from transactions

update transactions set trans_dt =
case 
when length(Date) < 10 then
substr(Date,6) || '-' || substr(Date,3,2) || '-0' || substr(Date,1,1)
else
substr(Date,7) || '-' || substr(Date,4,2) || '-' || substr(Date,1,2)
end 

commit

select * from transactions when Amount = 