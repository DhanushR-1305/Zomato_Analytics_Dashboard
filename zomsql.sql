
desc zom;

select * from zom;

select datekey_opening
from zom
where datekey_opening is not null
and datekey_opening <> ''
and STR_TO_DATE(datekey_opening, '%d-%m-%Y') is null;

alter table  zom
add  datekey_opening_dt date;

update  zom
set  datekey_opening_dt = STR_TO_DATE(datekey_opening, '%d-%m-%Y');

select datekey_opening, datekey_opening_dt
from zom
limit 10;

select z.*, c.Country from zom z left join countrycode c on z.countrycode = c.CountryCode;

select c.Country,count(z.restaurantid) as restaurant_count from zom z
join countrycode c on c.countrycode = z.countrycode group by c.country order by restaurant_count desc;
 
 select year(datekey_opening_dt) as yr,count(restaurantid) as restaurant_count from zom 
group by yr order by yr asc ;

select month(datekey_opening_dt) as mon_num,monthname(datekey_opening_dt)as opening_mon ,count(restaurantid) as restaurant_count from zom 
group by mon_num,opening_mon  order by mon_num asc ;

select concat("Q",quarter(datekey_opening_dt)) as opening_qtr ,count(restaurantid) as restaurant_count from zom 
group by opening_qtr  order by opening_qtr asc ;

select city ,count(restaurantid) as restaurants from zom 
group by city order by restaurants desc limit 10 ;
 
 select 
 case when rating < 2 then '0-2'
 when rating < 3 then  '2-3' 
 when rating < 4 then '3-4' 
 when rating  <= 5 then '4-5'
 else ' No rating' end as Rating_bucket ,
 count(restaurantid) as restaurant_count from zom 
 group by rating_bucket order by rating_bucket;

select case 
when average_cost_for_two <500 then 'Affordable'
when average_cost_for_two <1000 then 'Standard' 
when average_cost_for_two <=1500 then ' Above Standard'
when   average_cost_for_two >1500 then 'Premium' 
else ' ' end as Price_bucket  , 
count(restaurantid) from zom 
group  by price_bucket ; 

select  has_table_booking ,count(restaurantid) as restaurant_count,
ROUND(count(*)*100.0/ sum(count(*)) over(),2) as Percentage from zom 
group by Has_Table_booking;

select has_online_delivery ,count(restaurantid) as restaurant_count,
round(count(*)*100 / sum(count(*)) over() ,2) as Percentage from zom
group by Has_Online_delivery;
 






