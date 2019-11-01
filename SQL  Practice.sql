SELECT * FROM country_club.bookings;
select * from country_club.facilities;
select * from country_club.members;

select * from country_club.facilities where membercost > 0.0;

select COUNT(membercost) from country_club.facilities where membercost = 0.0;

select facid,name,membercost,monthlymaintenance from country_club.facilities where membercost > 0.0 and membercost < (0.2*monthlymaintenance);

select * from country_club.facilities where facid =1
union
select * from country_club.facilities where facid=5;

select name,monthlymaintenance, 'cheap' from country_club.facilities where monthlymaintenance < 100
union
select name,monthlymaintenance, 'expensive' from country_club.facilities where monthlymaintenance >= 100;

select firstname, surname from members
where  joindate = (select max(joindate) from members);

select firstname, surname from members
order by joindate desc
limit 1;

select concat(f.name, ":", m.firstname, " ",  m.surname) from bookings b, members m, facilities f
where b.facid in (0,1)
and f.facid = b.facid
and m.memid = b.memid;

select m.memid, firstname, surname, name, sum(membercost* slots) amount from bookings b, facilities f, members m
where starttime > '201-09-14'
and starttime < '2012-09-15'
and b.memid > 0
and f.facid = b.facid
and m.memid = b.memid
group by m.memid, firstname, surname, name
having amount > 30
UNION
select m.memid, firstname, surname, name, sum(guestcost* slots) amount from bookings b, facilities f, members m
where starttime > '201-09-14'
and starttime < '2012-09-15'
and b.memid = 0
and f.facid = b.facid
and m.memid = b.memid
group by m.memid, firstname, surname, name
having amount > 30
order by amount desc;


select f.facid, f.name, membercost * slots amount from facilities f, bookings b, members m
where f.facid = b.facid
and m.memid = b.memid
and m.memid > 0
having amount >30
UNION
select f.facid, name, guestcost * slots amount from facilities f, bookings b, members m
where f.facid = b.facid
and m.memid = b.memid
and m.memid = 0
having amount > 30
order by amount desc;

select facid, name, sum(amount) from
(select f.facid, f.name, membercost * slots amount from facilities f, bookings b, members m
where f.facid = b.facid
and m.memid = b.memid
and m.memid > 0
UNION
select f.facid, name, guestcost * slots amount from facilities f, bookings b, members m
where f.facid = b.facid
and m.memid = b.memid
and m.memid = 0 ) X
group by facid, name
having sum(amount) < 1000
order by sum(amount) desc;
-------------------------------------
select memid, b.facid, name, membercost, membercost* slots amount from bookings b, facilities f
where starttime > '201-09-14'
and starttime < '2012-09-15'
and memid > 0
and f.facid = b.facid
limit 5000;

select * from bookings
where starttime > '201-09-14'
and starttime < '2012-09-15'
and memid = 1
limit 6000;







