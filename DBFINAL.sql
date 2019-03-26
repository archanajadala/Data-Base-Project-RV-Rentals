CREATE TABLE Branch
(
	BranchId INT AUTO_INCREMENT PRIMARY KEY,
	BName varCHAR(50) NOT NULL,
	BPhoneNumber INT(10) NOT NULL,
	BAddress varCHAR(256) NOT NULL,
	BEmail varCHAR(120)
);


CREATE TABLE Employee
(
	EmployeeId INT NOT NULL  AUTO_INCREMENT PRIMARY KEY,
	EPhoneNumber INT(10),
	EAddress varchar(228),
	EEmail varchar(128),
	ESupervisorId int(16),
	EName VARCHAR(32),
	BranchId int,
		FOREIGN KEY fkBranchId(BranchId)
		REFERENCES Branch(BranchId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);


CREATE TABLE Customer
(
	CustomerId INT AUTO_INCREMENT PRIMARY KEY,
	CName varCHAR(32) NOT NULL,
	CPhoneNumber INT(10) NOT NULL,
	CAddress varCHAR(256) NOT NULL,
	CEmail varCHAR(120),
	CCountry CHAR NOT NULL,
	CDOB Date
);


CREATE TABLE VehicleType
(
	TypeId INT AUTO_INCREMENT PRIMARY KEY,
	TColor varCHAR(10),
	TMake varCHAR(10) NOT NULL,
	TModel varCHAR(16),
	TFuelType varCHAR(16),
	TYear INT,
	TCapacity INT NOT NULL
);


CREATE TABLE Vehicle
(
	VPlateNumber varCHAR(32) PRIMARY KEY,
	VidentificationNumber varCHAR(64) NOT NULL,
	VPowerBrakes varCHAR(16),
	VAvailability varCHAR(16),
	TypeId INT,
		FOREIGN KEY fkTypeId(TypeId)
		REFERENCES VehicleType(TypeId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);


CREATE TABLE Booking
(
	BookId INT AUTO_INCREMENT PRIMARY KEY,
	BPickUpLocation varCHAR(128) NOT NULL,
	BDropOffLocation varCHAR(128) NOT NULL,
	BPickUpTime TIME NOT NULL,
	BDropOffTime TIME NOT NULL,
	BookingStatus varCHAR(16) NOT NULL,
	BPickUpDate DATE NOT NULL,
	BDropOffDate DATE NOT NULL,
	CustomerId int,
		FOREIGN KEY fkCustomerId(CustomerId)
		REFERENCES Customer(CustomerId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
	VPlateNumber varchar(32),
		FOREIGN KEY fkVPlateNumber(VPlateNumber)
		REFERENCES Vehicle(VPlateNumber)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
	TypeId INT,
		FOREIGN KEY fkTypeId(TypeId)
		REFERENCES VehicleType(TypeId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);


CREATE TABLE Driver
(
	DriverId INT AUTO_INCREMENT PRIMARY KEY,
	DLicenseNumber INT(90) NOT NULL,
	DName varCHAR(10) NOT NULL,
	DAddress varCHAR(256) NOT NULL,
	DPhoneNumber INT(10) NOT NULL,
	DEmail varCHAR(120),
	DDOB DATE,
	VPlateNumber VARchar(32),
		FOREIGN KEY fkVPlateNumber(VPlateNumber)
		REFERENCES Vehicle(VPlateNumber)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
	BookId int(32),
		FOREIGN KEY fkBookId(BookId)
		REFERENCES Booking(BookId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);


CREATE TABLE Discount
(
	DiscId INT AUTO_INCREMENT PRIMARY KEY,
	DiscPromoCode varCHAR(32) NOT NULL,
	DiscValidityStartDate DATETIME NOT NULL,
	DiscValidityEndDate DATETIME NOT NULL
);


CREATE TABLE Bill
(
	BillId INT AUTO_INCREMENT PRIMARY KEY,
	BillDate DATE NOT NULL,
	BillTotalAmount DECIMAL(10,4) NOT NULL,
	BillDiscount DECIMAL(10,4),
	BillTaxAmount DECIMAL(10,4) NOT NULL,
	BillSecurityDeposit DECIMAL(10,4) NOT NULL,
	BillAdvancePaid DECIMAL(10,4),
	BillPaymentMethod varCHAR(64) NOT NULL,
	BillDamageAmount DECIMAL(10,4),
	BillRemainingAmount DECIMAL(10,4),
	BookId int,
		FOREIGN KEY fkBookId(BookId)
		REFERENCES Booking(BookId)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	DiscId int,
		FOREIGN KEY fkDiscId(DiscId)
		REFERENCES Discount(DiscId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);
 

CREATE TABLE CadrDetails
(
	CardId INT AUTO_INCREMENT PRIMARY KEY,
	CardNumber int(128),
	CardBillingAddress varchar(226),
	CardName varCHAR(16),
	CardCvv int(11),
	CustomerId int,
		FOREIGN KEY fkCId(CustomerId)
		REFERENCES Customer(CustomerId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);


CREATE TABLE Insurance
(
InsuranceId int AUTO_INCREMENT PRIMARY KEY,
IProvider varchar(16),
IStartDate Date,
IEndDate Date,
IBenifits varchar(32),
BookId int(32),
		FOREIGN KEY fkBookId(BookId)
		REFERENCES Booking(BookId)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);
------------------------------------------------------------
-- Step 11: Insert at least five (5) records into each table.
------------------------------------------------------------
INSERT INTO 
	Branch(BName,BPhoneNumber,BEmail,BAddress)
VALUES 
('Seattle', 	'3125145678', 	'seattle@rvrental.com', 	'1234 Sams Ave,Seattle,WA,97123'),
('California',	'3125145688', 	'california@rvrental.com', 	'236 Mark Johnson Street,San Jose,CA,91004'),
('Florida',   	'3125145698', 	'florida@rvrental.com',	 	'456 Steven Ave,Miami,FL,10007'),
('Texas',		'3125145648', 	'texas@rvrental.com', 		'5353 Lascollinas Blvd,Irving,TX,75038'),
('Alaska',		'3125145658', 	'alaska@rvrental.com', 		'7970 North Glen Dr,Bevarton,AK,91234');

Insert into Employee(Ephonenumber,EName,EAddress,EEmail,ESupervisorId,BranchId)values
(2143362568,	'Archana',			'123 cooperStreet,commerce,75428',		'12@gmail.com',				2,		1),
(2153362564,	'Sahithya', 		'245 WashingtonStreet,Houston,75423',	'Sahithya23@gmail.com',		5,		2),
(2163762565, 	'Raghuvarn',		'2543NW overlookDr,78093',				'Raghuvarn569@gmail.com',	4,		3),
(2243302567, 	'Mohan',			'7970 westlan,commerce,74093',			'mgbits@gmail.com',			1,		5),
(5043362599, 	'waxson',			'5353lascollinas,irving,75095',			'esg123@gmail.com',			NULL, 	4);
	
	INSERT INTO Customer(CName,CPhoneNumber,CEmail,CAddress,CCountry,CDOB)
VALUES 
('Chandler Bing', 		'4156782347', 	'chandler@hotmail.com', 	'2732 Baker Blvd,Eugene 97403',					'USA',	'1992-10-10'),
('Ross Geller', 		'4156782355', 	'ross@gmail.com', 			'Plaza 516 Main St.	Elgin 97827',				'USA',	'1993-12-10'),
('Joseph Tribbiani', 	'4156782333', 	null, 						'12Orchestra Terrace Walla Walla 99362', 		'USA',	'1994-11-09'),
('Rachel Green', 		'4156783298', 	'rachel@hotmail.com', 		'120 Hanover Sq WA1 1DP', 						'USA',	'1997-02-03'),
('Phoebe Buffay', 		'4156785678', 	null, 						'89 Chiaroscuro Rd Portland 97219', 			'USA',	'1998-12-04');


	INSERT INTO VehicleType(TColor,TMake,TModel,TFuelType,TYear,TCapacity)
VALUES 
('Black', 	'Benz', 	'model 1', 	'Diesel',	2016, 	4),
('White', 	'Mazda', 	'model 2', 	'Diesel',	2015, 	5),
('Silver', 	'Volvo', 	'model 3', 	'Diesel', 	2016, 	10),
('Black', 	'Tesla', 	'model 4', 	'Diesel', 	2017, 	6),
('Blue', 	'Ferarri', 	'model 5', 	'Diesel',  	2015, 	8);



	INSERT INTO Vehicle(VPlateNumber,VidentificationNumber,VPowerBrakes, VAvailability,TypeId)
VALUES 
('H634XX2', 'KTX987621934','brake',  '1', 5),
('MXG4343', 'QRP540468203', 'brake', '2', 3),
('TAMU221', 'GTAE49204657', 'brake', '3', 1),
('COMM333', 'EBU394675805', 'brake', '4', 2),
('US30122', 'IBRM34921188', 'brake', '5', 4);


	INSERT INTO Booking
(BPickUpLocation,BDropOffLocation,BPickUpTime,BDropOffTime,BookingStatus,BPickUpDate,BDropOffDate,CustomerId,VPlateNumber,TypeId)
VALUES 
('Seattle', 'Portland', '11:00', '17:00', 'Booked', '2017-10-21', '2017-10-21', 1, 'H634XX2',		5),
('Beaverton', 'Eugene', '09:00', '23:00', 'Booked', '2017-10-12', '2017-10-12', 2, 'MXG4343',		3),
('Redmond', 'Vancouver', '08:00', '15:00', 'Booked', '2017-11-23', '2017-11-24', 4, 'TAMU221',		1),
('SaltLake', 'Las Vegas', '20:00', '18:00', 'Booked', '2017-12-14', '2017-12-15', 5, 'COMM333',		2),
('SanJose', 'Los Angeles', '15:00', '15:30', 'Booked', '2017-12-13', '2017-12-14', 3, 'US30122',	4);


INSERT INTO Driver
(DLicenseNumber,DName,DAddress,DPhoneNumber,DEmail,DDOB,VPlateNumber,BookId)
VALUES 
(410382738, 'Raymond', 			'1221 N Rock Rd Coppel TX 710007', 	4459382355, 'Raymond@gmail.com', 		'1981-08-12', 		'H634XX2',	5),
(492045768, 'Brian Armstrong', 	'232 S Glen St Portland OR 97209', 	4139282372, 'BrianArmstrong@gmail.com', '1978-06-22', 		'MXG4343',	3),
(892037451, 'Mark Johnson', 	'2025 Savier St Eugene NV 76221', 	4153489358, 'MarkJohnson@hotmail.com', 	'1983-03-24', 		'TAMU221',	1),
(349036749, 'Martin Stiby', 	'16225 NW Schendel Ave Beaverton UT87666', 4234582363, 'StibyMartin@gmail.com', 	'1981-04-03', 	'COMM333',	2),
(984394659, 'Steven Trunzo', 	'2322 Overlook Dr Kingston NY 10992', 4234582363, 'StevenTrunzo@gmail.com', 	'1975-12-21', 		'US30122',	4);



INSERT INTO Discount(DiscPromoCode,DiscValidityStartDate,DiscValidityEndDate)
VALUES 
('RV10', '2017-10-06', '2017-11-30'),
('First30', '2018-01-01', '2018-01-05'),
('First20', '2017-12-01', '2017-12-10'),
('Holiday10', '2017-12-11', '2017-12-31'),
('First5', '2017-10-01', '2017-10-05');

INSERT INTO Bill
(BillDate,BillTotalAmount,BillDiscount,BillTaxAmount,BillSecurityDeposit,BillAdvancePaid,BillPaymentMethod,BillDamageAmount,BillRemainingAmount,BookId,DiscId)
VALUES 
('2017-10-04', '190', '5', '20', '100', '100', 'Cash', '0', '100',  1, 5),
('2017-10-11', '270', '10', '30', '100', '100', 'Cash', '50', '50', 2, 1),
('2017-11-20', '135', '10', '15', '100', '135', 'Card', '100', '0', 3, 1),
('2017-12-10', '200', '20', '10', '100', '200', 'Card', '90', '10', 4, 3),
('2017-12-12', '225', '10', '10', '100', '225', 'Cash', '54', '46', 5, 4);


	INSERT INTO CadrDetails(CardNumber,CardBillingAddress,CardName,CardCvv,CustomerId)
VALUES 
(5105105105105100, 	'Plaza 516 Main St.	Elgin 97827', 	'Ross Geller', 		333, 1),
(4111111111111111, 	'120 Hanover Sq WA1 1DP', 			'Rachel Green', 	466, 3),
(4012888888881881, 	'89 Chiaroscuro Rd Portland 97219', 'Phoebe Buffay', 	387, 5),
(4222222222222, 	'321 sowthwest,commerce,75039', 	'Johnson', 			109, 2),
(4955526743786072, 	'7950 NorthGlen Dr,irving,75036', 	'Karen', 			252, 4);


INSERT INTO Insurance(IProvider,IStartDate,IEndDate,IBenifits,BookId)
VALUES 
('GEICO', 	'2017-10-10', '2018-10-10', 'GoldPlan', 3),
('OnePoint','2017-11-09', '2017-12-29', 'PlatinumPlan', 4),
('GEICO',	'2017-10-01', '2017-11-01', 'SlverPlan', 3),
('USSA',	'2017-01-10', '2018-09-04', 'bronzePlan', 1),
('GEICO',	'2017-09-01', '2017-12-12', 'GoldPlan', 1);
