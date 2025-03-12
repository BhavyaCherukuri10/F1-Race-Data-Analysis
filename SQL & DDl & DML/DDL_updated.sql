-- Database: F1cars

-- DROP DATABASE IF EXISTS "F1cars";


	drop table if exists circuits cascade;
	create table circuits(circuitId int primary key,circuitRef varchar(100),name varchar(50),location varchar(100),country varchar(100));

	drop table if exists constructors cascade;
	create table constructors( constructorId int primary key, constructorRef varchar(50), name varchar(100), nationality varchar(100));

	drop table if exists races cascade;
	create table races( raceId int primary key,year int, round int, circuitId int references circuits(circuitId), name varchar(100) not null, r_date date, r_time time not null);

	drop table if exists constructorstandings cascade;
	create table constructorstandings(raceId int not null references races(raceId), constructorsId int references constructors(constructorId), points numeric(5,2), position int, wins int not null);

	drop table if exists drivers cascade;
	create table drivers( driverId int primary key, driverRef varchar(100), number int, code varchar(5),forename varchar(100) not null, surname varchar(100), dob date, nationality varchar(100));

	drop table if exists driver_standings cascade;
	create table driver_standings(raceId int not null references races(raceId), driverId int not null references drivers(driverId),points numeric(5,2) not null, position int not null, wins int not null);

	drop table if exists qualifying;
	create table qualifying( raceId int not null references races(raceId), driverId int not null references drivers(driverId), constructorId int not null references constructors(constructorId), number int not null, position int not null, q1 time, q2 time, q3 time);

	drop table if exists laptimes cascade;
	create table laptimes( raceId int not null references races(raceId), driverId int not null references drivers(driverId), lap int not null, position int not null, l_time time not null, milliseconds bigint);

	drop table if exists pitstops;
	create table pitstops(raceId int not null references races(raceId), driverId int not null references drivers(driverId), stop int not null, lap int not null, p_time time, duration numeric(6,3) not null);

	drop table if exists status cascade;
	create table status(statusId int primary key, status varchar(50) not null);

	drop table if exists results cascade;
	CREATE TABLE results
	(
    	resultid int primary key,
    	raceid int NOT NULL references races(raceId),
    	driverid int NOT NULL references drivers(driverId),
    	constructorid int NOT NULL references constructors(constructorId) ,
    	number int NOT NULL,
    	grid int NOT NULL,
    	position int,
    	points numeric(5,2) NOT NULL,
    	laps int NOT NULL,
    	fastest_lap int,
    	rank int,
    	fastest_laptime time,
    	fastest_lapspeed real,
    	statusid int NOT NULL REFERENCES status (statusid));

	