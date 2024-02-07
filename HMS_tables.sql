#drop database healthcare_management_systam;

create database healthcare_management_system;
use healthcare_management_system;

create table physician (
employee_id int primary key,
name varchar(200),
position varchar(200),
snn int);

create table department (
department_id int primary key,
name varchar(200),
head varchar(200));


create table affiliated_with (
physician int ,
department int,
primaryaffiliation varchar(200),
foreign key (physician) references physician(employee_id),
foreign key (department) references department(department_id));

create table medical_procedure(
code int primary key,
name varchar(200),
cost varchar(200));

create table trained_in(
physician int,
treatment int,
certification_date varchar(10),
certification_expires varchar(10),
foreign key (physician) references physician(employee_id),
foreign key (treatment) references medical_procedure(code));

create table patient(
ssn int primary key,
name varchar(200),
address varchar(200),
phone varchar(20),
insurance_id int unique,
pcp int,
foreign key (pcp) references physician(employee_id));

create table nurse(
employee_id int primary key,
name varchar(200),
position varchar(200),
registered varchar(1),
ssn int);

create table appointment(
appointment_id int primary key,
patient int,
prep_nurse int,
physician int,
start_dt_time varchar(10),
end_dt_time varchar(10),
examination_room varchar(100),
foreign key (patient) references patient(ssn),
foreign key (prep_nurse) references nurse(employee_id),
foreign key (physician) references physician(employee_id));

create table medication(
code int primary key,
name varchar(100),
brand varchar(100),
description varchar(200));



create table prescribes(
physician int,
patient int,
medication int,
date varchar(10),
appointment int,
dose varchar(100),
foreign key (patient) references patient(ssn),
foreign key (medication) references medication(code),
foreign key (physician) references physician(employee_id),
foreign key (appointment) references appointment(appointment_id));

create table block_(
block_floor int,
block_code int,
primary key(block_floor,block_code));


CREATE TABLE room (
    room_number INT PRIMARY KEY,
    room_type INT,
    block_floor INT,
    block_code INT,
    unavailable VARCHAR(1),
    FOREIGN KEY (block_floor, block_code) REFERENCES block_(block_floor, block_code)
);

create table on_call(
nurse int,
block_floor INT,
block_code INT,
on_call_start varchar(10),
on_call_end varchar(10),
FOREIGN KEY (block_floor, block_code) REFERENCES block_(block_floor, block_code));

create table stay(
stay_id int primary key,
patient int,
room int,
start_time varchar(100),
end_time varchar(100),
foreign key (patient) references patient(ssn));
#drop table undergoes;
create table undergoes(
patient int,
procedure_ int,
stay int,
date varchar(100),
physician int,
assisting_nurse int,
foreign key (patient) references patient(ssn),
foreign key (procedure_) references medical_procedure(code),
foreign key (stay) references stay(stay_id),
foreign key (physician) references physician(employee_id),
foreign key (assisting_nurse) references nurse(employee_id));

alter table room modify room_type varchar(10);