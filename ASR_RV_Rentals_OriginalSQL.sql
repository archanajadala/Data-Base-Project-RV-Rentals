--DROP DATABASE ASRRVRENTALS;
--CREATE DATABASE ASRRVRENTALS;

CREATE TABLE Address
(
	AddressId INT AUTO_INCREMENT,
	AddressLine1 varCHAR(150) NOT NULL,
	AddressLine2 varCHAR(150) NOT NULL,
	City varCHAR(50) NOT NULL,
	State varCHAR(50),
	Zipcode INT(11),
	Country varCHAR(50),
		CONSTRAINT pkAddressId PRIMARY KEY(AddressId) 
);

CREATE TABLE Branch
(
	BranchId INT AUTO_INCREMENT,
	BName varCHAR(50) NOT NULL,
	BPhoneNumber INT(10) NOT NULL,
	BEmail varCHAR(120),
		CONSTRAINT pkBranchId PRIMARY KEY(BranchId), 
	AddressId int,
		CONSTRAINT fkBAddressId FOREIGN KEY(AddressId)
		REFERENCES Address(AddressId)
);

CREATE TABLE Employee
(
	EmployeeId INT AUTO_INCREMENT,
	EPhoneNumber INT(10),
	ESsn int(32),
	EEmail varchar(128),
	ESupervisorId int(16),
	EFirstName VARCHAR(32),
	ELastName VARCHAR(32),
		CONSTRAINT pkEmployeeId PRIMARY KEY(EmployeeId), 
	BranchId int,
		CONSTRAINT fkBranchId FOREIGN KEY(BranchId)
		REFERENCES Branch(BranchId),
	AddressId int,
		CONSTRAINT fkEAddressId FOREIGN KEY(AddressId)
		REFERENCES Address(AddressId)
);

CREATE TABLE Customer
(
	CustomerId INT AUTO_INCREMENT, 
	CONSTRAINT pkCustomerId PRIMARY KEY(CustomerId),
	CFirstName varCHAR(32) NOT NULL,
	CLastName varCHAR(32) NOT NULL,
	CPhoneNumber INT(10) NOT NULL,
	CEmail varCHAR(120),
	CDOB Date,
	AddressId int,
		CONSTRAINT fkcAddressId FOREIGN KEY(AddressId)
		REFERENCES Address(AddressId)

);


CREATE TABLE Branches
(
	BranchId INT,
	CustomerId INT,
	NoOfBookings varCHAR(50) NOT NULL,
	CONSTRAINT pkBranchCoustId PRIMARY KEY(BranchId,CustomerId),
	CONSTRAINT fkBBranchId FOREIGN KEY (BranchId)
	REFERENCES Branch(BranchId),
	CONSTRAINT fkBcustomerId FOREIGN KEY (CustomerId)
	REFERENCES Customer(CustomerId)
);


CREATE TABLE VehicleType
(
	TypeId INT AUTO_INCREMENT,
	CONSTRAINT pkTypeId PRIMARY KEY(TypeId),
	TColor varCHAR(10),
	TMake varCHAR(10) NOT NULL,
	TModel varCHAR(16),
	TFuelType varCHAR(16),
	TYear INT,
	TCapacity INT NOT NULL
);

CREATE TABLE Vehicle
(
	VPlateNumber varCHAR(32),
	CONSTRAINT pkVPlateNumber PRIMARY KEY(VPlateNumber),
	VidentificationNumber varCHAR(64) NOT NULL,
	VPowerBrakes varCHAR(16),
	VAvailability varCHAR(16),
	TypeId INT,
		CONSTRAINT fkTyped	FOREIGN KEY(TypeId)
		REFERENCES VehicleType(TypeId)	
);

CREATE TABLE Booking
(
	BookId INT AUTO_INCREMENT,
	CONSTRAINT PKBookId PRIMARY KEY(BookId),
	BPickUpLocation varCHAR(128) NOT NULL,
	BDropOffLocation varCHAR(128) NOT NULL,
	BPickUpTime TIME NOT NULL,
	BDropOffTime TIME NOT NULL,
	BookingStatus varCHAR(16) NOT NULL,
	BPickUpDate DATE NOT NULL,
	BDropOffDate DATE NOT NULL,
	BTotalAmount  DECIMAL(10,4) NOT NULL,
	CustomerId int,
		CONSTRAINT fkCustomerId FOREIGN KEY(CustomerId)
		REFERENCES Customer(CustomerId),
	VPlateNumber varchar(32),
		CONSTRAINT fkVPlateNumber FOREIGN KEY(VPlateNumber)
		REFERENCES Vehicle(VPlateNumber),
	TypeId INT,
		CONSTRAINT fkTypeId FOREIGN KEY(TypeId)
		REFERENCES VehicleType(TypeId)
);

CREATE TABLE Driver
(
	DriverId INT AUTO_INCREMENT,
	CONSTRAINT pkDriverId PRIMARY KEY(DriverId),
	DLicenseNumber INT(90) NOT NULL,
	DFirstName varCHAR(10) NOT NULL,
	DLastName varCHAR(10) NOT NULL,
	DPhoneNumber INT(10) NOT NULL,
	DEmail varCHAR(120),
	DDOB DATE,
	AddressId int,
		CONSTRAINT fkDAddressId FOREIGN KEY(AddressId)
		REFERENCES Address(AddressId)
);

CREATE TABLE DriverBooking
(
	DriverId int,
	BookId int,
	DateInserted Date,
		CONSTRAINT PKBookDriverId PRIMARY KEY(BookId,DriverId),
		CONSTRAINT fkDriverId FOREIGN KEY(DriverId)
		REFERENCES Driver(DriverId),
		CONSTRAINT fkBookId FOREIGN KEY(BookId)
		REFERENCES Booking(BookId)
		
);

CREATE TABLE Discount
(
	DiscId INT AUTO_INCREMENT,
	CONSTRAINT pkDiscId PRIMARY KEY(DiscId),
	DiscPromoCode varCHAR(32) NOT NULL,
	DiscValidityStartDate DATETIME NOT NULL,
	DiscValidityEndDate DATETIME NOT NULL
);

CREATE TABLE CardDetails
(
	CardId INT AUTO_INCREMENT,
	CONSTRAINT pkCardId PRIMARY KEY(CardId),
	CardNumber int(128),
	CardFirstName varCHAR(16),
	CardLastName varCHAR(16),
	CardCvv int(11),
	CardExpiryDate Date,
	CustomerId int,	
		CONSTRAINT fkCardcustomerId FOREIGN KEY (CustomerId)
		REFERENCES Customer(CustomerId),
	AddressId int,
		CONSTRAINT fkcardDAddressId FOREIGN KEY(AddressId)
		REFERENCES Address(AddressId)
);

CREATE TABLE Bill
(
	BillId INT AUTO_INCREMENT,
	BillDate DATE NOT NULL,
	BillAmountPaid DECIMAL(10,4) NOT NULL,
	BillDiscount DECIMAL(10,4),
	BillTaxAmount DECIMAL(10,4) NOT NULL,
	BillSecurityDeposit DECIMAL(10,4) NOT NULL,
	BillAdvancePaid DECIMAL(10,4),
	BillPaymentMethod varCHAR(64) NOT NULL,
	BillTransactionId varCHAR(32),
	BillRemainingAmount DECIMAL(10,4),
	CONSTRAINT PKBillId PRIMARY KEY(BillId),
	BookId int,
		CONSTRAINT fkBillBookId FOREIGN KEY(BookId)
		REFERENCES Booking(BookId)
		ON DELETE CASCADE,
	DiscId int,
		CONSTRAINT fkBillDiscId FOREIGN KEY(DiscId)
		REFERENCES Discount(DiscId),
	CardId int,
		CONSTRAINT fkBillCardId FOREIGN KEY(CardId)
		REFERENCES CardDetails(CardId)
		ON DELETE RESTRICT

);
 
CREATE TABLE InsuranceProvider
(
InsuranceId int AUTO_INCREMENT,
CONSTRAINT pkInsuranceId PRIMARY KEY(InsuranceId),
IProvider varchar(16),
IBenifits varchar(32)
);

CREATE TABLE InsuranceBooking
(
IStartDate Date,
IEndDate Date,
CONSTRAINT PKBookInsuranceId PRIMARY KEY(BookId,InsuranceId),
BookId int,
		CONSTRAINT fkIBookId FOREIGN KEY(BookId)
		REFERENCES Booking(BookId)
		ON DELETE CASCADE,
InsuranceId int(32),
		CONSTRAINT fkInsuranceProvider FOREIGN KEY(InsuranceId)
		REFERENCES InsuranceProvider(InsuranceId)
		ON DELETE CASCADE

);

CREATE TABLE UserLogin
(
	ID INT AUTO_INCREMENT,
	CONSTRAINT pkID  PRIMARY KEY (ID),
	UserID varchar(24),
	Password varchar(24),
	SecurityQuestion varchar(120),
	SecurityAnswer varchar(120),
	CreatedDate DATE,
	Role varchar(24),
	Active char,
	InternalID INT
);

INSERT INTO UserLogin(UserID,Password,SecurityQuestion,SecurityAnswer,CreatedDate,Role,Active,InternalID)
VALUES
('crazykid','crazykid123','favorite actor','Tom Hanks','2017-01-01','Customer','Y','1'),
('littleflower','LittleFlower12','Favorite Color','Black','2017-12-02','Customer','Y','2'),
('dfwhero','dfwhero5','Favorite Sport','NFL','2017-11-28','Customer','Y','3'),
('bigman22','BigMan2212','Best Friend','Myself','2017-06-21','Customer','Y','4'),
('SummerBend','Employee1','Favorite Color','Black','2017-10-15','Employee','Y','1');

INSERT INTO Address(AddressLine1, AddressLine2, City, State, Zipcode,Country)
VALUES 
('5353Lascollinas Blvd',NULL,'Irving','Texas',75039,'USA'),
('7970 North Glen Dr',NULL,'Irving','Texas',74211,'USA'),
('2824 Indeed Dr','Apt 311','Commerce','Texas',75428,'USA'),
('123 mayoStreet',NULL,'Commerce','Texas',75428,'USA'),
('2456 NorthWest Dr',NULL,'Frisco','Texas',76405,'USA'),
('5555 Rising Blvd',NULL,'Frisco','Texas',75009,'USA'),
('3232 RayanStreet',NULL,'Commerce','Texas',76628,'USA'),
('2424 NorthEastern Dr',NULL,'Frisco','Texas',76845,'USA'),
('5678 MarkJohnson Street',NULL,'Frisco','Texas',71109,'USA');

INSERT INTO Branch(BName, BPhoneNumber, BEmail, AddressId)
VALUES ('Seattle', 3125145678, 'seattle@rvrental.com', 1),
('California', 3125145688, 'california@rvrental.com', 2),
('Florida', 3125145698, 'florida@rvrental.com', 4),
('Texas', 3125145648, 'texas@rvrental.com', 5),
('Alaska', 3125145658, 'alaska@rvrental.com', 6);

INSERT INTO Employee(EFirstName, ELastName, EPhoneNumber, EEmail, ESsn, ESupervisorId, BranchId, AddressId)
VALUES 
('John', 'Smith', 4153452347, 'john.smith@gmail.com', 888665555, null, 1, 3),
('Bob', 'Smith', 4154356879, 'Bob.smith@gmail.com',  333445555, 1, 1, 8),
('Joseph', 'Tribbiani', 4155678222, null, 987654321, null, 2, 7),
('Rachel', 'Greene', 4152345745, 'rachel@hotmail.com', 123456789, 3, 2, 9),
('Phoebe', 'Buffay', 4156349800, null, 453453453, 3, 2, 3);

INSERT INTO Customer(CFirstName, CLastName, CPhoneNumber, CEmail, CDOB, AddressId)
VALUES 
('Chandler', 'Bing', 4156782347, 'chandler@hotmail.com', '1970-10-03', 9),
('Ross', 'Geller', 4156782355, 'ross@gmail.com','1971-12-31', 7),
('Joseph', 'Tribbiani', 4156782333, null, '1974-08-11', 6),
('Laurie', 'McLeod', 4156783298, 'rachel@hotmail.com', '1973-04-19', 8),
('Larry', 'Cynthia', 4156785678, null, '1971-08-13', 3);

INSERt INTO Branches(BranchId,CustomerId,NoOfBookings)VALUES 
(1,3,5),
(3,4,6),
(5,3,4),
(4,1,3),
(2,2,2),
(1,4,3),
(3,1,2),
(4,5,2);

INSERT INTO VehicleType(TColor, TMake, TModel, TFuelType, TYear, TCapacity)
VALUES 
('Black', 	'Benz', 	'model 1', 	'Diesel',	2016, 	4),
('White', 	'Mazda', 	'model 2', 	'Diesel',	2015, 	5),
('Silver', 	'Volvo', 	'model 3', 	'Diesel', 	2016, 	10),
('Black', 	'Tesla', 	'model 4', 	'Diesel', 	2017, 	6),
('Blue', 	'Ferarri', 	'model 5', 	'Diesel',  	2015, 	8);

INSERT INTO Vehicle(VPlateNumber, VidentificationNumber, VPowerBrakes, VAvailability, TypeId)
VALUES 
('H634XX2', 'KTX987621934', 'brake', 'Y', 5),
('MXG4343', 'QRP540468203', 'brake', 'N', 3),
('TAMU221', 'GTAE49204657', 'brake', 'Y', 1),
('COMM333', 'EBU394675805', 'brake', 'Y', 2),
('US30122', 'IBRM34921188', 'brake', 'N', 4);


INSERT INTO Booking
(BPickUpLocation, BDropOffLocation, BPickUpTime, BDropOffTime, BookingStatus, BPickUpDate, BDropOffDate, BTotalAmount ,CustomerId, VPlateNumber,TypeId)
VALUES
('Seattle', 'Portland', '11:00', '17:00', 'Booked', '2017-10-21', '2017-10-21',700, 1, 'H634XX2',3),
('Beaverton', 'Eugene', '09:00', '23:00', 'Booked', '2017-10-12', '2017-10-12', 800,2, 'MXG4343',2),
('Redmond', 'Vancouver', '08:00', '15:00', 'Booked', '2017-11-23', '2017-11-24', 705,4, 'TAMU221',5),
('SaltLake', 'Las Vegas', '20:00', '18:00', 'Booked', '2017-12-14', '2017-12-15', 460,5, 'COMM333',4),
('SanJose', 'Los Angeles', '15:00', '15:30', 'Booked', '2017-12-13', '2017-12-14', 390,3, 'US30122',1);

INSERT INTO Driver
(DLicenseNumber, DFirstName, DLastName, DPhoneNumber, DEmail, DDOB, AddressId)
VALUES 
(410382738, 'Raymond', 'Shin',  4459382355, 'Raymond@gmail.com', '1981-08-12', 6),
(492045768, 'Brian', 'Armstrong',  4139282372, 'Brian_Armstrong@gmail.com', '1978-06-22', 3),
(892037451, 'Mark', 'Johnson',  4153489358, 'Mark_Johnson@hotmail.com', '1983-03-24', 9),
(349036749, 'Martin', 'Stiby',  4234582363, 'Stiby_Martin@gmail.com', '1981-04-03', 8),
(984394659, 'Steven', 'Trunzo',  4234582363, 'Steven_Trunzo@gmail.com', '1975-12-21', 7);


INSERt INTO DriverBooking(DriverId,BookId,DateInserted)VALUES 
(1,3,'2017-11-30'),
(3,3,'2017-12-1'),
(5,3,'2017-12-4'),
(4,1,'2016-12-10'),
(2,1,'2015-12-10');


INSERT INTO Discount(DiscPromoCode, DiscValidityStartDate, DiscValidityEndDate)
VALUES ('RV10', '2017-10-06', '2017-11-30'),
('First30', '2018-01-01', '2018-01-05'),
('First20', '2017-12-01', '2017-12-10'),
('Holiday10', '2017-12-11', '2017-12-31'),
('First5', '2017-10-01', '2017-10-05');


INSERT INTO CardDetails(CardNumber, CardFirstName, CardLastName, CardExpirydate, CardCVV, CustomerId, AddressId)
VALUES ('1234567812345678', 'Chandler', 'Bing', '2018-12-31',  432, 1,7),
('4321567843215678', 'Ross', 'Geller', '2019-11-30',  235, 2,3),
('1234876512348765', 'Joseph', 'Tribbiani', '2019-02-28',  567, 3,8),
('4321876543218765', 'Rachel', 'Greene', '2020-07-31', 937, 4,9),
('5678123456781234', 'Phoebe', 'Buffay', '2020-08-31', 994, 5,7);


INSERT INTO Bill
(BillDate, BillAmountPaid, BillDiscount, BillTaxAmount, BillSecurityDeposit, BillAdvancePaid, BillPaymentMethod, BillTransactionId, BillRemainingAmount, BookId, DiscId,CardId)
VALUES 
('2017-10-04', '190', '5', '20', '100', '100', 'Cash', 'VADE0B248932','0', 4,  1, 5),
('2017-10-11', '270', '10', '30', '150', '100', 'Cash', 'SDTE0B678932','50', 3, 2, 1),
('2017-11-20', '135', '10', '15', '160', '135', 'Card', 'TRDE5B246932','100', 1, 3, 1),
('2017-12-10', '200', '20', '10', '200', '200', 'Card', 'JHDE1B247932','90', 5, 4, 3),
('2017-12-12', '225', '10', '10', '250', '225', 'Cash', 'GYNJ0B248930','54', 2, 5, 4);


INSERT INTO InsuranceProvider(IProvider, IBenifits)
VALUES 
(' GEICO',  'GoldPlan'),
(' GEICO',  'platinumPlan'),
(' UnitedHealthOne',  'PlantinumPlan'),
(' Assurant Health', ' SilverPlan'),
(' GEICO',  ' BronzePlan'),
(' USAA', ' GoldPlan');



INSERT INTO InsuranceBooking(IStartDate, IEndDate,BookId,InsuranceId)
VALUES 
(' 2010-10-06', '2019-10-05',  1, 4),
('2011-11-23', '2020-11-22', 2, 2),
('2014-02-12', '2023-02-11', 3, 5),
('2013-07-07', '2022-07-06',  4, 1),
('2015-08-13', '2024-08-12', 5, 3);
