-- Created a new schema named 'Assignment'
-- Imported `Date` and `Close Price` column from all input CSV files via table data import wizard.
-- And named tables as bajaj_auto, eicher_motors, hero_motocorp, infosys, tcs and tvs_motors.



-- Modifying Date column in bajaj_auto as data imported via table data import wizard took 'Date' column as text field
select * from bajaj_auto limit 100;

select data_type      					 ## checking the datatype			
from information_schema.columns
Where 
     table_name = 'bajaj_auto' and
     column_name = 'Date';

Update bajaj_auto
set Date = date_format(str_to_date(date,'%d-%M-%Y'),'%Y-%m-%d'); 

alter table bajaj_auto   	#though the format gets changed from above command, the data type was still text
modify Date date;			#so changing it into Date datatype.

-- Creating table bajaj1
Create table bajaj1(
WITH CTE_bajaj(Date, `Close Price`, RowNumber, MA20, MA50)
AS
(
SELECT Date,
       `Close Price`,
       ROW_NUMBER() OVER () RowNumber,
       AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS MA50
FROM  bajaj_auto
ORDER BY DATE ASC
)
SELECT Date,
       `Close Price`,
       IF(RowNumber > 19, MA20, NULL)`20 Day MA`,
       IF(RowNumber > 49, MA50, NULL)`50 Day MA`
FROM   CTE_bajaj 
ORDER BY Date ASC);

select * from bajaj1 limit 150;

-- Updating Date column of eicher_motors to date datatype.
Update eicher_motors
set Date = date_format(str_to_date(date,'%d-%M-%Y'),'%Y-%m-%d');

alter table eicher_motors
modify Date date;

select * from eicher_motors limit 100;

-- Creating table eicher1
Create table eicher1(
WITH CTE_eicher(Date, `Close Price`, RowNumber, MA20, MA50)
AS
(
SELECT Date,
       `Close Price`,
       ROW_NUMBER() OVER () RowNumber,
       AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS MA50
FROM  eicher_motors
ORDER BY DATE ASC
)
SELECT Date,
       `Close Price`,
       IF(RowNumber > 19, MA20, NULL)`20 Day MA`,
       IF(RowNumber > 49, MA50, NULL)`50 Day MA`
FROM   CTE_eicher
ORDER BY Date ASC);

select * from eicher1 limit 150;

-- Updating Date column of hero_motocorp to date datatype.
Update hero_motocorp
set Date = date_format(str_to_date(date,'%d-%M-%Y'),'%Y-%m-%d');

alter table hero_motocorp
modify Date date;

select * from hero_motocorp limit 100;

-- Creating table hero1

Create table hero1(
WITH CTE_hero(Date, `Close Price`, RowNumber, MA20, MA50)
AS
(
SELECT Date,
       `Close Price`,
       ROW_NUMBER() OVER () RowNumber,
       AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS MA50
FROM  hero_motocorp
ORDER BY DATE ASC
)
SELECT Date,
       `Close Price`,
       IF(RowNumber > 19, MA20, NULL)`20 Day MA`,
       IF(RowNumber > 49, MA50, NULL)`50 Day MA`
FROM   CTE_hero
ORDER BY Date ASC);

select * from hero1 limit 150;


-- Updating Date column of infosys to date datatype.
Update infosys
set Date = date_format(str_to_date(date,'%d-%M-%Y'),'%Y-%m-%d');

alter table infosys
modify Date date;

select * from infosys limit 100;

-- Creating table infosys1

Create table infosys1(
WITH CTE_infosys(Date, `Close Price`, RowNumber, MA20, MA50)
AS
(
SELECT Date,
       `Close Price`,
       ROW_NUMBER() OVER () RowNumber,
       AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS MA50
FROM  infosys
ORDER BY DATE ASC
)
SELECT Date,
       `Close Price`,
       IF(RowNumber > 19, MA20, NULL)`20 Day MA`,
       IF(RowNumber > 49, MA50, NULL)`50 Day MA`
FROM   CTE_infosys
ORDER BY Date ASC);

select * from infosys1 limit 150;


-- Updating Date column of tcs to date datatype.
Update tcs
set Date = date_format(str_to_date(date,'%d-%M-%Y'),'%Y-%m-%d');

alter table tcs
modify Date date;

select * from tcs limit 100;

-- Creating table tcs1

Create table tcs1(
WITH CTE_tcs(Date, `Close Price`, RowNumber, MA20, MA50)
AS
(
SELECT Date,
       `Close Price`,
       ROW_NUMBER() OVER () RowNumber,
       AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS MA50
FROM  tcs
ORDER BY DATE ASC
)
SELECT Date,
       `Close Price`,
       IF(RowNumber > 19, MA20, NULL)`20 Day MA`,
       IF(RowNumber > 49, MA50, NULL)`50 Day MA`
FROM   CTE_tcs
ORDER BY Date ASC);

select * from tcs1 limit 150;


-- Updating Date column of tvs_motors to date datatype.
Update tvs_motors
set Date = date_format(str_to_date(date,'%d-%M-%Y'),'%Y-%m-%d');

alter table tvs_motors
modify Date date;

select * from tvs_motors limit 100;

-- Creating table tvs1

Create table tvs1(
WITH CTE_tvs(Date, `Close Price`, RowNumber, MA20, MA50)
AS
(
SELECT Date,
       `Close Price`,
       ROW_NUMBER() OVER () RowNumber,
       AVG(`Close Price`) OVER (ROWS 19 PRECEDING) AS MA20,
       AVG(`Close Price`) OVER (ROWS 49 PRECEDING) AS MA50
FROM  tvs_motors
ORDER BY DATE ASC
)
SELECT Date,
       `Close Price`,
       IF(RowNumber > 19, MA20, NULL)`20 Day MA`,
       IF(RowNumber > 49, MA50, NULL)`50 Day MA`
FROM   CTE_tvs
ORDER BY Date ASC);

select * from tvs1 limit 150;

-- creating master_table

create table master_table 
as
(select b.Date as Date,
		b.`Close Price` as Bajaj,
        t.`Close Price` as TCS,
        v.`Close Price` as TVS,
        i.`Close Price` as Infosys,
        e.`Close Price` as Eicher,
        h.`Close Price` as Hero
from bajaj_auto b , eicher_motors e, hero_motocorp h, infosys i, tcs t, tvs_motors v
where ((b.Date = t.Date) AND (b.Date = v.Date) AND (b.Date = i.Date) AND (b.Date = e.Date) AND (b.Date = h.Date)));
        
        
select * from master_table;

-- Generating buy and sell signal from bajaj stocks
create table bajaj2
as
Select Date, `Close Price`,
	CASE
          WHEN (`20 Day MA` > `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  < (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Buy'
          WHEN (`20 Day MA` < `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  > (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Sell'
          ELSE 'Hold'
       END as `Signal`
From bajaj1
ORDER BY Date asc; 

select * from bajaj2;

-- Generating buy and sell signal from eicher stocks
create table eicher2
as
Select Date, `Close Price`, 
	CASE
          WHEN (`20 Day MA` > `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  < (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Buy'
          WHEN (`20 Day MA` < `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  > (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Sell'
          ELSE 'Hold'
       END as `Signal`
From eicher1
ORDER BY Date asc; 

select * from eicher2;

-- Generating buy and sell signal from hero stocks
create table hero2
as
Select Date, `Close Price`, 
	CASE
          WHEN (`20 Day MA` > `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  < (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Buy'
          WHEN (`20 Day MA` < `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  > (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Sell'
          ELSE 'Hold'
       END as `Signal`
From hero1
ORDER BY Date asc; 

select * from hero2;

-- Generating buy and sell signal from infosys stocks
create table infosys2
as
Select Date, `Close Price`, 
	CASE
          WHEN (`20 Day MA` > `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  < (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Buy'
          WHEN (`20 Day MA` < `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  > (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Sell'
          ELSE 'Hold'
       END as `Signal`
From infosys1
ORDER BY Date asc; 

select * from infosys2;

-- Generating buy and sell signal from tcs stocks
create table tcs2
as
Select Date, `Close Price`, 
	CASE
          WHEN (`20 Day MA` > `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  < (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Buy'
          WHEN (`20 Day MA` < `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  > (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Sell'
          ELSE 'Hold'
       END as `Signal`
From tcs1
ORDER BY Date asc; 

select * from tcs2;

-- Generating buy and sell signal from tvs stocks
create table tvs2
as
Select Date, `Close Price`,
	CASE
          WHEN (`20 Day MA` > `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  < (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Buy'
          WHEN (`20 Day MA` < `50 Day MA`) AND ((lag(`20 Day MA`,1) over(order by Date asc))  > (lag(`50 Day MA`,1) over(order by Date asc))) THEN 'Sell'
          ELSE 'Hold'
       END as `Signal`
From tvs1
ORDER BY Date asc; 

select * from tvs2;


-- User defined function to return signal for a particular day

drop function if exists fetchSignal;

create function fetchSignal(d varchar(30))
 returns varchar(30) deterministic
 return
 (
 select bajaj2.`Signal`
 from bajaj2
 where  str_to_date(d,'%Y-%m-%d') = bajaj2.date
);
 
 select fetchSignal('2015-08-24') as TradingResult; ## format of input date is: 'YYYY-mm-DD'
 
