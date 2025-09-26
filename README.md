# Task-4--Ecommerce-SQL-Database
task 4 
#  Data Analyst Internship - Task 4: SQL for Data Analysis

##  Project Objective

The objective of this project was to demonstrate proficiency in core SQL concepts by extracting and analyzing data from a structured database. This task required the creation of a relational schema from a single flat file and the application of advanced querying techniques, including **JOINS, Subqueries, Aggregate Functions, HAVING, and Views**.

---

## Data Model and Normalization

The analysis was performed on the `Ecommerce.csv` dataset, which was **normalized** and loaded into three interconnected tables to enable complex relational analysis:

| Table Name | Description | Key Relationships |
| :--- | :--- | :--- |
| **Orders (Fact Table)** | Core transaction details (Cost, Discount, Weight, On-Time Status). | Linked to Demographics (Customer\_ID) and Shipment (Shipment\_ID). |
| **Shipment\_Details (Dimension)** | Categorical data about logistics (Warehouse, Mode of Shipment, Importance). | Primary Key: `Shipment_ID` |
| **Customer\_Demographics (Dimension)** | Customer attributes (Gender, Prior Purchases). | Primary Key: `Customer_ID` |

---

# Key Analytical Queries

The following queries were executed to address the analytical hints provided in the task guide, demonstrating all required SQL concepts.

### 1. Basic Aggregation and INNER JOIN

**Goal:** Calculate the average product cost and total discount offered, grouped by shipment mode.

```sql
SELECT
    SD.Mode_of_Shipment,
    AVG(O.Cost_of_the_Product) AS Avg_Product_Cost,
    SUM(O.Discount_offered) AS Total_Discount_Offered
FROM
    Orders O
JOIN
    Shipment_Details SD ON O.Shipment_ID = SD.Shipment_ID
GROUP BY
    SD.Mode_of_Shipment
ORDER BY
    Total_Discount_Offered DESC;
