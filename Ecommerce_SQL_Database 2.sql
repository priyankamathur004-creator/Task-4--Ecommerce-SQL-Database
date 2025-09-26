create database Ecomanalysis;
use Ecomanalysis;
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT, -- Foreign Key to Demographics
    Shipment_ID VARCHAR(5), -- Foreign Key to Shipment
    Customer_Rating INT,
    Cost_of_the_Product INT,
    Discount_offered INT,
    Weight_in_gms INT,
    Reached_on_Time_Y_N INT
);
CREATE TABLE Customer_Demographics (
    Customer_ID INT PRIMARY KEY,
    Prior_Purchases INT,
    Gender VARCHAR(10)
);
CREATE TABLE Shipment_Details (
    Shipment_ID VARCHAR(5) PRIMARY KEY, -- Use Warehouse Block as ID
    Warehouse_Block VARCHAR(5),
    Mode_of_Shipment VARCHAR(50),
    Product_Importance VARCHAR(50),
    Customer_Care_Calls INT
);
SELECT
    SD.Mode_of_Shipment,
    AVG(O.Cost_of_the_Product) AS Avg_Product_Cost,
    SUM(O.Discount_offered) AS Total_Discount
FROM
    Orders O
JOIN
    Shipment_Details SD ON O.Shipment_ID = SD.Shipment_ID
GROUP BY
    SD.Mode_of_Shipment
ORDER BY
    Total_Discount DESC;
    
SELECT
    O.Order_ID,
    CD.Gender,
    O.Reached_on_Time_Y_N
FROM
    Orders O
LEFT JOIN
    Customer_Demographics CD ON O.Customer_ID = CD.Customer_ID
WHERE
    CD.Prior_Purchases = 0;
    SELECT
    SD.Warehouse_Block,
    AVG(O.Cost_of_the_Product) AS Avg_Order_Cost
FROM
    Orders O
JOIN
    Shipment_Details SD ON O.Shipment_ID = SD.Shipment_ID
GROUP BY
    SD.Warehouse_Block
HAVING
    AVG(O.Cost_of_the_Product) > 200;
    SELECT
    Order_ID,
    Discount_offered,
    Cost_of_the_Product
FROM
    Orders
WHERE
    Discount_offered > (
        -- Subquery to find the average discount
        SELECT AVG(Discount_offered) FROM Orders
    );
    
CREATE VIEW High_Value_Shipments AS
SELECT
    O.Order_ID,
    O.Cost_of_the_Product,
    SD.Product_Importance,
    SD.Mode_of_Shipment
FROM
    Orders O
JOIN
    Shipment_Details SD ON O.Shipment_ID = SD.Shipment_ID
WHERE
    O.Cost_of_the_Product > 300 AND SD.Product_Importance = 'high';
    SELECT * FROM High_Value_Shipments;


-- Optimize Query Speed with an Index
-- Create an index on the Customer_ID column, as it will be used heavily in joins and lookups.
CREATE INDEX idx_orders_customer_id ON Orders (Customer_ID);