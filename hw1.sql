
/* How many taxi trips were totally made on September 18th 2019? */
select count(*) from yellow_taxi_data where lpep_pickup_datetime::date = '2019-09-18'
and lpep_dropoff_datetime::date = '2019-09-18';

/*Which was the pick up day with the largest trip distance 
Use the pick up time for your calculations.
*/
select lpep_pickup_datetime::date as dt,
max(trip_distance) as max_trip_distance
from yellow_taxi_data
group by 1
order by 2 desc
limit 3;


/*
Consider lpep_pickup_datetime in '2019-09-18' and ignoring Borough has Unknown
Which were the 3 pick up Boroughs that had a sum of total_amount superior to 50000?
*/

select 
r."Borough" as loc,
sum(total_amount) as tot
from yellow_taxi_data ytd
	left join zones r on ytd."PULocationID" = r."LocationID"
where lpep_pickup_datetime::date = '2019-09-18'
and r."Borough" != 'Unknown'
group by 1
having sum(total_amount) > 50
order by 2 desc
limit 3;


/*
For the passengers picked up in September 2019 in the zone name Astoria 
which was the drop off zone that had the largest tip? We want the name of the zone, not the id.
Note: it's not a typo, it's tip , not trip
*/

select l.*, r.*, r2."Zone" as droppoff_zone
from yellow_taxi_data l
	join zones r on l."PULocationID" = r."LocationID"
	join zones r2 on l."DOLocationID" = r2."LocationID"
where r."Zone" = 'Astoria'
and date_trunc('month', lpep_pickup_datetime)::date = '2019-09-01'
order by tip_amount desc
limit 1
;
