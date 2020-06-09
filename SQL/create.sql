create table EMPLOYEE
(
    ESSN VARCHAR(11) PRIMARY KEY,
    Fname VARCHAR(25),
    Lname VARCHAR(25),
    Phone_num VARCHAR(12),
    Birthdate DATE,
    Street VARCHAR(50), 
    City VARCHAR(50),
    State VARCHAR(15),
    Zipcode VARCHAR(5),
    B_ID INT
);
create table BRANCH_MANAGER
(
    ESSN VARCHAR(11) PRIMARY KEY,
    Salary DECIMAL(9,2) NOT NULL Default 75000.00,
    Start_Date DATE 
);

ALTER TABLE BRANCH_MANAGER
ADD FOREIGN KEY(ESSN)
REFERENCES EMPLOYEE(ESSN);
create table DEALERSHIP_BRANCH
(
    B_ID INT auto_increment PRIMARY KEY,
    Phone_Num VARCHAR(12),
    Street VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(15),
    Zipcode VARCHAR(5),
    Mgr_ESSN VARCHAR(11)
);

ALTER TABLE DEALERSHIP_BRANCH
ADD FOREIGN KEY (Mgr_ESSN) 
REFERENCES BRANCH_MANAGER (ESSN);
ALTER TABLE EMPLOYEE
ADD FOREIGN KEY (B_ID) 
REFERENCES DEALERSHIP_BRANCH (B_ID);
create table INVENTORY
(
    INV_ID INT auto_increment,
    B_ID INT,
    PRIMARY KEY(INV_ID, B_ID),
    FOREIGN KEY(B_ID) REFERENCES DEALERSHIP_BRANCH(B_ID)
);
create table SERVICE
(
    Service_ID INT auto_increment PRIMARY KEY,
    Type VARCHAR(100),
    Cost DECIMAL(7,2),
    Duration INT 
);
create table RECEIPT
(
    Receipt_ID INT auto_increment PRIMARY KEY
);
create table PART
(
    Part_ID INT auto_increment PRIMARY KEY,
    P_name VARCHAR(100) 
);
create table SUPPLIER
(
    SP_ID INT auto_increment PRIMARY KEY,
    S_name VARCHAR(50),
    Phone_Num VARCHAR(12),
    Street VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(15),
    Zipcode VARCHAR(5) 
);
create table CUSTOMER
(
    C_ID VARCHAR(10) PRIMARY KEY,
    Fname VARCHAR(25),
    Lname VARCHAR(25),
    Birthdate DATE,
    Phone_Num VARCHAR(12),
    Street VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(15),
    Zipcode VARCHAR(5) 
);
create table MANUFACTURER
(
    Man_name VARCHAR(30) PRIMARY KEY
);
create table MODEL
(
    M_ID INT auto_increment PRIMARY KEY,
    Make VARCHAR(15),
    Year INT,
    Type VARCHAR(15),
    HP INT,
    MPG INT,
    MSRP DECIMAL(8,2),
    Man_name VARCHAR(30),
    FOREIGN KEY(Man_name) REFERENCES MANUFACTURER(Man_name)
);
create table VEHICLE
(
    V_ID VARCHAR(7) PRIMARY KEY,
    Color VARCHAR(15),
    Curr_mileage INT,
    M_ID INT,
    FOREIGN KEY(M_ID) REFERENCES MODEL(M_ID)
);
create table OWNS
(
    C_ID VARCHAR(10),
    V_ID VARCHAR(7),
    PRIMARY KEY(C_ID, V_ID),
    FOREIGN KEY(C_ID) REFERENCES CUSTOMER(C_ID),
    FOREIGN KEY(V_ID) REFERENCES VEHICLE(V_ID)
);
create table TECHNICIAN
(
    ESSN VARCHAR(11) PRIMARY KEY,
    Hourly_wage Decimal(5,2) NOT NULL DEFAULT 18.75,
    FOREIGN KEY(ESSN) REFERENCES EMPLOYEE(ESSN)
);
create table REQ_SERVICE
(
    C_ID VARCHAR(10),
    V_ID VARCHAR(7),
    ESSN VARCHAR(11),
    Receipt_ID INT,
    Date DATE,
    PRIMARY KEY(C_ID, V_ID, ESSN, Receipt_ID),
    FOREIGN KEY(C_ID) REFERENCES CUSTOMER(C_ID),
    FOREIGN KEY(ESSN) REFERENCES TECHNICIAN(ESSN),
    FOREIGN KEY(RECEIPT_ID) REFERENCES RECEIPT(RECEIPT_ID),
    FOREIGN KEY(V_ID) REFERENCES VEHICLE(V_ID)
);
create table INV_CONTAINS
(
    B_ID INT ,
    INV_ID INT ,
    V_ID VARCHAR(7) ,
    PRIMARY KEY(B_ID, INV_ID, V_ID),
    FOREIGN KEY(B_ID) REFERENCES DEALERSHIP_BRANCH(B_ID),
    FOREIGN KEY(INV_ID) REFERENCES INVENTORY(INV_ID),
    FOREIGN KEY(V_ID) REFERENCES VEHICLE(V_ID)
);
create table HAS_SERVICES
(
    Receipt_ID INT,
    Service_ID INT,
    PRIMARY KEY(RECEIPT_ID, SERVICE_ID),
    FOREIGN KEY(RECEIPT_ID) REFERENCES RECEIPT(RECEIPT_ID),
    FOREIGN KEY(SERVICE_ID) REFERENCES SERVICE(SERVICE_ID)
);
create table SALESPERSON
(
    ESSN VARCHAR(11) PRIMARY KEY,
    Sales_Phone_Num VARCHAR(12),
    Salary DECIMAL(9,2) NOT NULL DEFAULT 35000,
    Commission DECIMAL(4,2) NOT NULL DEFAULT .25,
    FOREIGN KEY(ESSN) REFERENCES EMPLOYEE(ESSN)
);

create table REQ_PARTS
(
    Service_ID INT,
    Part_ID INT,
    Qty INT,
    PRIMARY KEY(Service_ID, Part_ID),
    FOREIGN KEY(Part_ID) REFERENCES PART(Part_ID),
    FOREIGN KEY(Service_ID) REFERENCES SERVICE(Service_ID)
);
create table SOLD
(
    ESSN VARCHAR(11),
    C_ID VARCHAR(10),
    V_ID VARCHAR(7),
    Price DECIMAL(9,2),
    Date DATE,
    PRIMARY KEY(ESSN, C_ID, V_ID),
    FOREIGN KEY(C_ID) REFERENCES CUSTOMER(C_ID),
    FOREIGN KEY(ESSN) REFERENCES SALESPERSON(ESSN),
    FOREIGN KEY(V_ID) REFERENCES VEHICLE(V_ID)
);
create table SUPPLIED_BY
(
    SP_ID INT,
    Part_ID INT,
    Price DECIMAL(8,2),
    PRIMARY KEY(SP_ID, Part_ID),
    FOREIGN KEY(Part_ID) REFERENCES PART(Part_ID),
    FOREIGN KEY(SP_ID) REFERENCES SUPPLIER(SP_ID)
);
