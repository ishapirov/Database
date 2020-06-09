/*Functional Requirement 1: Example of querying cost of all services received on a vehicle*/
SELECT SUM(SERVICE.cost) AS TotalServiceCost
FROM SERVICE
WHERE SERVICE.Service_ID IN (SELECT HAS_SERVICES.Service_ID
                             FROM HAS_SERVICES
                             WHERE HAS_SERVICES.Receipt_ID IN (SELECT REQ_SERVICE.Receipt_ID
                                              FROM REQ_SERVICE
                                              WHERE REQ_SERVICE.C_ID = '441' AND REQ_SERVICE.V_ID = 'MKM'));

/*Functional Requirement 1: Example of querying names of all services received on a vehicle*/
SELECT SERVICE.Type
FROM SERVICE
WHERE SERVICE.Service_ID IN (SELECT HAS_SERVICES.Service_ID
                             FROM HAS_SERVICES
                             WHERE HAS_SERVICES.Receipt_ID IN (SELECT REQ_SERVICE.Receipt_ID
                                              FROM REQ_SERVICE
                                              WHERE REQ_SERVICE.C_ID = '441' AND REQ_SERVICE.V_ID = 'MKM'));

/*Functional Requirement 2: Querying Revenues of each salesperson*/
SELECT SUM(SOLD.Price) AS Revenue,SOLD.ESSN
FROM SOLD
GROUP BY SOLD.ESSN;

/*Functional Requirement 2: Querying Revenues of each salesperson, and getting the names of the employees*/
SELECT SUM(SOLD.Price) AS Revenue,EMPLOYEE.ESSN,EMPLOYEE.FName,EMPLOYEE.LName
FROM SOLD,EMPLOYEE,SALESPERSON
WHERE SOLD.ESSN = SALESPERSON.ESSN AND SALESPERSON.ESSN = EMPLOYEE.ESSN
GROUP BY SOLD.ESSN;

/*Functional Requirement 3: Querying all services which technician may have to do*/
SELECT SERVICE.Type
FROM SERVICE;

/*Functional Requirement 3: Querying parts which can be ordered for each service*/
SELECT SERVICE.Type,Part.P_name,SUPPLIED_BY.Price
FROM PART,REQ_PARTS,SERVICE,SUPPLIED_BY
WHERE REQ_PARTS.Service_ID = SERVICE.Service_ID AND REQ_PARTS.Part_ID = Part.Part_ID AND PART.Part_ID = SUPPLIED_BY.Part_ID;

/*Functional Requirement 3: Querying duration of a specific service by ID and Type*/
SELECT SERVICE.duration
FROM SERVICE
WHERE SERVICE.Service_ID = 1;

SELECT SERVICE.duration
FROM SERVICE
WHERE SERVICE.Type = 'Serpentine Belt Replacement';

/*Functional Requirement 4: Querying number of vehicles in the inventory*/
SELECT COUNT(INV_CONTAINS.V_ID) AS numVehicles
FROM INV_CONTAINS
WHERE INV_CONTAINS.B_ID = 1 AND INV_CONTAINS.INV_ID = 1
AND INV_CONTAINS.V_ID NOT IN (SELECT OWNS.V_ID FROM OWNS);

/*Functional Requirement 5: Querying how many services were completed by each technician at branch 1*/
SELECT COUNT(REQ_SERVICE.ESSN) AS numServices,TECHNICIAN.ESSN,EMPLOYEE.FName,EMPLOYEE.LName
FROM REQ_SERVICE,TECHNICIAN,EMPLOYEE
WHERE REQ_SERVICE.ESSN = TECHNICIAN.ESSN AND TECHNICIAN.ESSN = EMPLOYEE.ESSN AND EMPLOYEE.B_ID = 1
GROUP BY REQ_SERVICE.ESSN;

/*Functional Requirement 6: Example of deleting transaction records*/
DELETE
FROM SOLD
WHERE SOLD.C_ID = '419' AND SOLD.ESSN = '427-30-5377' AND SOLD.V_ID = 'XPN';

/*Functional Requirement 6: Example of altering transaction records*/
UPDATE SOLD
SET SOLD.Price = 15000.00
WHERE SOLD.C_ID = '088' AND SOLD.ESSN = '427-30-5377' AND SOLD.V_ID = '6SKW';

/*Functional Requirement 6: Confirming deleting and update occurred*/
SELECT *
FROM SOLD
WHERE SOLD.ESSN = '427-30-5377';

/*Functional Requirement 7: Multiple examples of filtering available vehicles by price*/
/*Filtering by price*/
SELECT *
FROM VEHICLE, MODEL
WHERE VEHICLE.M_ID = MODEL.M_ID AND MODEL.MSRP<20000 AND VEHICLE.V_ID NOT IN(SELECT SOLD.V_ID FROM SOLD);

/*Filtering by model make*/
SELECT *
FROM VEHICLE, MODEL
WHERE VEHICLE.M_ID = MODEL.M_ID AND MODEL.Make='R8' AND VEHICLE.V_ID NOT IN(SELECT SOLD.V_ID FROM SOLD);

/*Filtering by color*/
SELECT *
FROM VEHICLE, MODEL
WHERE VEHICLE.M_ID = MODEL.M_ID AND VEHICLE.Color = 'Red' AND VEHICLE.V_ID NOT IN(SELECT SOLD.V_ID FROM SOLD);

/*Filtering by MPG*/
SELECT *
FROM VEHICLE, MODEL
WHERE VEHICLE.M_ID = MODEL.M_ID AND MODEL.MPG>25 AND VEHICLE.V_ID NOT IN(SELECT SOLD.V_ID FROM SOLD);


/*Functional Requirement 8: Calculating commission for a salesperson*/
SELECT SUM(SALESPERSON.Commission * SOLD.Price) AS CommissionEarned
FROM SOLD,SALESPERSON
WHERE SALESPERSON.ESSN = SOLD.ESSN AND SOLD.ESSN = '468-74-6913';

/*Functional Requirement 8: Calculating commission after a certain date*/
SELECT SUM(SALESPERSON.Commission * SOLD.Price) AS CommissionEarned
FROM SOLD,SALESPERSON
WHERE SALESPERSON.ESSN = SOLD.ESSN AND SOLD.ESSN = '468-74-6913' AND SOLD.Date > '2010-01-01';

/*Functional Requirement 9: Querying number of each model sold*/
SELECT COUNT(MODEL.M_ID) AS numModels,MODEL.Make
FROM MODEL,VEHICLE,SOLD
WHERE VEHICLE.M_ID = MODEL.M_ID AND VEHICLE.V_ID = SOLD.V_ID
GROUP BY MODEL.Make;

/*Functional Requirement 9: Querying number of each model not sold*/
SELECT COUNT(MODEL.M_ID) numModelsNotSold,MODEL.Make
FROM MODEL,VEHICLE
WHERE VEHICLE.M_ID = MODEL.M_ID AND 
VEHICLE.V_ID NOT IN(SELECT SOLD.V_ID
                    FROM SOLD)
GROUP BY MODEL.Make;

/*Functional Requirement 10: Comparing branches by sales*/
SELECT SUM(Sold.Price) AS Sales, EMPLOYEE.B_ID
FROM SOLD, SALESPERSON,EMPLOYEE
WHERE SOLD.ESSN = SALESPERSON.ESSN AND SALESPERSON.ESSN = EMPLOYEE.ESSN
GROUP BY EMPLOYEE.B_ID;



