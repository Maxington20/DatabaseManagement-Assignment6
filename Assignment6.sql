--Assignment6
--Max Herrington


CREATE DATABASE VehiclePartsDB


CREATE TABLE Plant
(
ID INT IDENTITY (1,1) PRIMARY KEY,
Location VARCHAR(30) NOT NULL
)


CREATE TABLE Employee
(
ID INT IDENTITY(1,1) PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(25),
Address VARCHAR(80),
Telephone VARCHAR(10),
PlantID INT CONSTRAINT PlantLocationID_FK FOREIGN KEY REFERENCES Plant(ID)
)


CREATE TABLE Customer
(
ID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(40) NOT NULL
)


CREATE TABLE PartType
(
ID INT IDENTITY(1,1) PRIMARY KEY,
TypeOfPart VARCHAR(30) NOT NULL
)


CREATE TABLE PARTS
(
ID INT IDENTITY(1,1) PRIMARY KEY,
IsMotorcycle BIT NOT NULL,
PartTypeID INT CONSTRAINT PartTypeID_FK FOREIGN KEY REFERENCES PartType(ID),
PartNumber VARCHAR(10)
)


CREATE TABLE Job
(
OrderID INT IDENTITY(1,1) CONSTRAINT OrderID_PK PRIMARY KEY,
CustomerID INT CONSTRAINT CustomerID_FK FOREIGN KEY REFERENCES Customer(ID)
	ON DELETE CASCADE,
PartID INT CONSTRAINT PartID_FK FOREIGN KEY REFERENCES Parts(ID)
	ON DELETE CASCADE,
EmployeeID INT CONSTRAINT EmployeeID_FK FOREIGN KEY REFERENCES Employee(ID)
	ON DELETE CASCADE,
PlantID INT CONSTRAINT PlantID_FK FOREIGN KEY REFERENCES Plant(ID)
	ON DELETE CASCADE,
Time INT NOT NULL,
)


INSERT INTO Plant
VALUES ('Waterloo'),('Guelph')


INSERT INTO Employee (FirstName,PlantID)
VALUES ('Joe',2),('Frank',1),('Mary',1),('Gary',2),('John',1)


INSERT INTO Customer
VALUES ('Suzuki'),('BMW')


INSERT INTO PartType
VALUES ('Crankshaft'),('Piston'),('Exhaust')


INSERT INTO PARTS
VALUES(1,1,'MOTO001'),(1,2,'MOTO002'),(0,2,'CAR001'),(0,3,'CAR002'),(1,3,'MOTO003'),(0,1,'CAR003')


INSERT INTO Job (PartID, CustomerID, EmployeeID,PlantID,Time)
VALUES (1,1,1,2,45),(1,1,2,1,40),(2,1,1,2,20),(3,1,3,1,15),(3,2,3,1,20),(2,2,3,1,10),
	(1,2,4,2,65),(4,2,4,2,110),(5,1,5,1,45),(6,1,5,1,25),(6,2,2,1,45)


PRINT'All jobs done for Suzuki'
PRINT''
SELECT OrderID,PartNumber AS 'Part #',TypeOfPart AS 'Part Type', FirstName AS 'Employee',
	Location AS 'Plant',Time AS 'Time(min)'
from Job,Employee,PARTS,PartType,Plant
where CustomerID = 1
	AND job.EmployeeID = employee.ID
	AND PARTS.ID = JOB.PartID
	AND PARTS.PartTypeID = PartType.ID
	AND JOB.PlantID = PLANT.ID
ORDER BY OrderID 

PRINT'Parts made by the various employees at the Waterloo Plant'
PRINT''
SELECT EMPLOYEE.FirstName, PARTS.PartNumber,Time
FROM JOB,PARTS,Employee
WHERE JOB.PlantID = 1 
	AND parts.ID = job.PartID
	AND Employee.ID = JOB.EmployeeID
ORDER BY FirstName


