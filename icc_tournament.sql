create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;
with cte as(
select team_1,case when team_1= winner then  1 else 0 end  as win_flag
from icc_world_cup
union all
select team_2,case when team_2=Winner then 1 else 0 end as win_flag
from icc_world_cup
)
select team_1 as teamname ,count(1) as no_of_matches_played,sum(win_flag) as wins,count(1)-sum(win_flag) as no_of_loses  from cte
group by team_1
order by sum(win_flag) desc;

