Drop table if exists events;
CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

delete from events;

INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

select * from events;

-- find the play who won only gold and no of gold medals

select gold as player_name ,count(1) as no_of_golds from events
where gold not in(select bronze from events union select silver from events)
group by gold;


drop table if exists tickets;
CREATE TABLE tickets (
    ticket_id INT,
    create_date DATE,
    resolved_date DATE
);

INSERT INTO tickets (ticket_id, create_date, resolved_date) VALUES 
(1, '2022-08-02', '2022-08-03'),
(2, '2022-08-01', '2022-08-12'),
(3, '2022-08-02', '2022-08-16');

select * from tickets;

-- find the business days for solving the ticket between the created_date and resolved_date

select ticket_id,datediff(resolved_date,Create_date) as no_of_days
from tickets;

select ticket_id, datediff(resolved_date,Create_date),
WEEK(create_date),
week(resolved_date) ,
WEEK(resolved_date)-week(create_date),
datediff(resolved_date,create_date)-2*(week(resolved_date)- week(create_date)) as business_days
FROM tickets;

drop table if exists holidays;
CREATE TABLE holidays (
    
    holiday_name VARCHAR(100) NOT NULL,
    holiday_date DATE NOT NULL
);


INSERT INTO holidays (holiday_name, holiday_date)
VALUES ('Rakhi', '2022-08-11');

-- Insert Independence Day on 2022-08-15
INSERT INTO holidays (holiday_name, holiday_date)
VALUES ('Independence Day', '2022-08-15');

select * from holidays;

select create_date,resolved_date,count(holiday_date) as no_of_holidays,
-- ticket_id, datediff(resolved_date,Create_date),
-- WEEK(create_date),
-- week(resolved_date) ,
-- WEEK(resolved_date)-week(create_date),
 (datediff(resolved_date,create_date)-2*(week(resolved_date)- week(create_date))) -count(holiday_date) as business_days
 
FROM tickets
left join holidays on  holiday_date between create_date and resolved_date
group by ticket_id,create_date,resolved_date;


