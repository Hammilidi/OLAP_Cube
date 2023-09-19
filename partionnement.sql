USE Sales_Olap_Loading_DW;

--Cr�ation de fonctions de partitionnement
--Fact_Inventory
CREATE PARTITION FUNCTION PF_InventoryDate (DATE)
AS RANGE LEFT FOR VALUES 
    ('2023-01-01','2023-03-01','2023-06-01', '2023-09-01', '2023-12-01');

--Fact_Order
-- Cr�ez une fonction de partitionnement pour Fact_Order
CREATE PARTITION FUNCTION PF_OrderDate (DATE)
AS RANGE LEFT FOR VALUES 
    ('2023-01-01','2023-03-01', '2023-06-01','2023-09-01', '2023-12-01');




--Cr�ation des schema de partition
--Fact_Inventory
-- Cr�ez un sch�ma de partition pour Fact_Inventory
CREATE PARTITION SCHEME PS_InventoryDate
AS PARTITION PF_InventoryDate 
TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY]);


--Fact_Order
-- Cr�ez un sch�ma de partition pour Fact_Order
CREATE PARTITION SCHEME PS_OrderDate
AS PARTITION PF_OrderDate 
TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY]);




--Cr�ation des tables partitionn�es
--Fact_Inventory
-- Cr�ez la table Fact_Inventory partitionn�e
CREATE TABLE Fact_Inventory
(
    InventoryID INT PRIMARY KEY,
    Date DATE,
    ProductID INT,
    Quantity INT
)
ON PS_InventoryDate(Date);


--Fact_Order
-- Cr�ez la table Fact_Order partitionn�e
CREATE TABLE Fact_Order
(
    OrderID INT PRIMARY KEY,
    Date DATE,
    CustomerID INT,
    TotalAmount DECIMAL(18, 2)
)
ON PS_OrderDate(Date);


