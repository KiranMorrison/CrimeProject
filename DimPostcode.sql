/*
Creating a dimension for Longitude and Latitude from postcode.
Specific location (long and lat) could not be found for schools,
however many schools have their own post code. A table has been
found of postcodes with their long and lat. Joining this to the
longs and lats of the school table creates the perfect dimension
for postcode, enriched with school long and lat, [DimPostcode].
*/

/*
It has been decided to add LSOA to the postcode dimension, this
will be achieved using a join.
*/

use CrimeProject
go

drop table [DimPostcode]
select distinct
	s.[Post Code]
	,p.[Latitude]
	,p.[Longitude]
	,l.lsoa11cd [LSOA Code]
into [DimPostcode]
from CleanSchoolData s
join UKPostcodes p
	on p.postcode = s.[Post Code]
join postcodeLSOA l
	on l.pcds = s.[Post Code]

alter table DimPostcode
alter column [Post Code] varchar(50) not null

alter table DimPostcode
add primary key ([Post Code]) 

