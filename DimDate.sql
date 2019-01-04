/*
This recursive CTE quickly generates a list of potentially useful
date parts from the given data: month, quarter and year.
*/

use CrimeProject
go

drop table DimDate												--Dropping the table before running the script allows the dimension
go																--to be refreshed whenever it's ran without duplicating data

with cte
as
(
select
	cast('2015-11-01' as date) [Date]								--November 2015 is the earliest date we have crime data for
	,datename(mm, cast('2015-11-01' as date)) [Month]		
	,datename(qq, cast('2015-11-01' as date)) [Quarter]
	,datename(yy, cast('2015-11-01' as date)) [Year]		    
	union all
select
	dateadd(mm,1,[Date]) [Date]
	,datename(mm, cast(dateadd(mm,1,[Date]) as date)) [Month]		
	,datename(qq, cast(dateadd(mm,1,[Date]) as date)) [Quarter]
	,datename(yy, cast(dateadd(mm,1,[Date]) as date)) [Year]

from cte
where dateadd(mm,1,[Date]) <= getdate()
)
select
	*
into DimDate													--DimDate is our date dimension
from cte
option (maxrecursion 0)											--This avoids the max 100 loops before the recursive cte shuts itself down

alter table DimDate												--Alter the table to not accept nulls
alter column [Date] Date NOT NULL

alter table DimDate												--Set [Date] as the primary key
add primary key ([Date]);