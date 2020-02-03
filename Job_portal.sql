	DROP TABLE selection;
	DROP TABLE jobapply;
	DROP TABLE job;
	DROP TABLE jobsekeer;
	DROP TABLE company;
	
	CREATE TABLE jobsekeer(
		user_id integer,
		name VARCHAR(10),
		age VARCHAR(3),
		cgpa number(3,2),
		address VARCHAR(10),
		qualification VARCHAR(15),
		experience VARCHAR(10),
		contact_no VARCHAR(11),
		PRIMARY KEY(user_id));

	CREATE TABLE company(
		com_id VARCHAR(10),
		com_name VARCHAR(20) not null,		
		com_address VARCHAR(30),
		services VARCHAR(50),	
		com_contact_no VARCHAR(20),
		PRIMARY KEY(com_id));

	CREATE TABLE job(
		job_id INTEGER ,
		com_id varchar(10),
		salary INTEGER ,
		post VARCHAR(30),
		vacancy integer,
		description VARCHAR(50),
		city VARCHAR(20),
		PRIMARY KEY(job_id),
		foreign key (com_id) references company(com_id)on delete cascade
		);
		
		

		

	CREATE TABLE jobapply(
		user_id integer,
		job_id INTEGER,
		FOREIGN KEY(job_id) REFERENCES job(job_id) on delete cascade,
		FOREIGN KEY(user_id) REFERENCES jobsekeer(user_id) 
		);

	
CREATE TABLE selection(
        job_id INTEGER,
        com_name varchar(10),
		user_id integer,
		FOREIGN KEY(job_id) REFERENCES job(job_id) on delete cascade,
		FOREIGN KEY(user_id) REFERENCES jobsekeer(user_id)  on delete cascade
		);
		
create or replace trigger auto_update_vacancy 
after delete on selection for each row 
declare

begin

update job set vacancy=vacancy+1 where job_id=:old.job_id;
end;



	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(110,'Zabir','20',3.75,'Khulna','B.S.C in CSE','2','01521307471');

	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(111,'Niaz','22',3.70,'Dhaka','M.S.C in LE','1','01521317897');

	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(112,'Muit','21',3.50,'tangail','B.S.C in IEM','1','01521307409');
	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(113,'Tanim','20',3.80,'kustia','P.H.D in CSE','5','01521305471');

	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(114,'Manik','22',3.75,'jamalpur','M.S.C in CSE','4','01721307471');

	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(115,'Arafat','25',3.55,'Dinajpur','B.S.C in CSE','1','01911307471');
	
	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(116,'Nishat','22',3.66,'Dhaka','M.S.C in CSE','2','01521317897');

	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(117,'Mahin','21',3.55,'tangail','B.S.C in EEE','1','01521307409');
	
	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(118,'Amanullah','20',3.30,'kustia','P.H.D in ME','3','01521305471');

	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(119,'Anik','22',3.50,'jamalpur','M.S.C in CSE','4','01721307471');

	INSERT INTO jobsekeer(user_id,name,age,cgpa,address,qualification,experience,contact_no)
	VALUES(120,'Fattah','25',3.20,'Dinajpur','B.S.C in CSE','3','01911307471');







	INSERT INTO company(com_id,com_name,com_address,services,com_contact_no)
	VALUES('1000','Microsoft','USA','Web Design','www.microsoft.com');

	INSERT INTO company(com_id,com_name,com_address,services,com_contact_no)
	VALUES('1001','Samsung','Sydney','Software developing','www.samsung.com');

	INSERT INTO company(com_id,com_name,com_address,services,com_contact_no)
	VALUES('1002','Nokia','Lahore','Onine marketing','www.Nokia.com');

	INSERT INTO company(com_id,com_name,com_address,services,com_contact_no)
	VALUES('1003','Apple','Kolkata','Graphic Design','www.apple.com');

	INSERT INTO company(com_id,com_name,com_address,services,com_contact_no)
	VALUES('1004','Walton','Dhaka','Web Design','www.walton.com');

	INSERT INTO company(com_id,com_name,com_address,services,com_contact_no)
	VALUES('1005','hp','Kualalampur','Trainer','www.hp.com');

	INSERT INTO company(com_id,com_name,com_address,services,com_contact_no)
	VALUES('1006','Energypack','Dubai','Elec. components','www.Energypack.com');

	INSERT INTO company(com_id,com_name,com_address,services,com_contact_no)
	VALUES('1007','toyota','Egypt','Designer','www.toyota.com');




	INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(1,'1001',40000,'Chief Eng.',2,'Monitoring','Dhaka');

	INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(2,'1001',50000,'Asist. Eng.',1,'Software developer','Dhaka');

	INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(3,'1002',60000,'Soft. Eng.',3,'Designer','Dhaka');
	
	INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(4,'1003',40000,'Hardware Eng.',5,'Hardware testing','Dhaka');

	INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(5,'1004',50000,'Soft. developer',6,'Monitoring','Dhaka');

	INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(6,'1004',60000,'Chief Eng.',4,'Information security','Dhaka');
	
	INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(7,'1005',150000,'Designer',6,'Computer networking','Dhaka');

	INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(8,'1006',260000,'Chief Eng.',4,'Database management','Dhaka');
	
		INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(9,'1007',150000,'Soft. developer',6,'Machine learning','Dhaka');

	INSERT INTO job(job_id,com_id,salary,post,vacancy,description,city)
	VALUES(10,'1002',200000,'Chief Eng.',4,'Artificial inteligence','Dhaka');




	--INSERT INTO jobapply(user_id,job_id) VALUES(110,1);
	--INSERT INTO jobapply(user_id,job_id) VALUES(113,1);
	--INSERT INTO jobapply(user_id,job_id) VALUES(114,3);
	--INSERT INTO jobapply(user_id,job_id) VALUES(115,4);
	--INSERT INTO jobapply(user_id,job_id) VALUES(110,5);
	--INSERT INTO jobapply(user_id,job_id) VALUES(111,6);
	--INSERT INTO jobapply(user_id,job_id) VALUES(116,2);
	--INSERT INTO jobapply(user_id,job_id) VALUES(117,7);
	--INSERT INTO jobapply(user_id,job_id) VALUES(118,9);
	--INSERT INTO jobapply(user_id,job_id) VALUES(119,6);
	--INSERT INTO jobapply(user_id,job_id) VALUES(120,5);

	
	COMMIT;
/
