RENAME TABLE transaction_data TO transaction_data_raw;

SELECT id, COUNT(*) AS cnt 
FROM transaction_data_raw
GROUP BY id
HAVING cnt > 1
limit 10;

SELECT * 
FROM transaction_data_raw
WHERE id = 0 OR id = 1 OR id = 2
ORDER BY id;

CREATE TABLE transaction_data AS
SELECT DISTINCT * FROM transaction_data_raw;

SELECT id, COUNT(*) AS cnt FROM transaction_data
GROUP BY id
HAVING cnt > 1
LIMIT 6;

SELECT quantity, quantity_tmp, 
		InvoiceDate, InvoiceDate_tmp,
        UnitPrice, UnitPrice_tmp 
FROM transaction_data
LIMIT 10;

ALTER TABLE transaction_data
DROP COLUMN quantity,
DROP COLUMN InvoiceDate,
DROP COLUMN UnitPrice;

ALTER TABLE transaction_data
RENAME COLUMN InvoiceDate_tmp TO InvoiceDate,
RENAME COLUMN Quantity_tmp TO Quantity,
RENAME COLUMN UnitPrice_tmp TO UnitPrice;

SELECT * FROM transaction_data
LIMIT 10;

ALTER TABLE transaction_data
ADD COLUMN TotalPrice DECIMAL (10,2);

UPDATE transaction_data
SET TotalPrice = Quantity * UnitPrice;

ALTER TABLE transaction_data
MODIFY COLUMN Quantity INT AFTER CustomerID,
MODIFY COLUMN UnitPrice DECIMAL(10,2) AFTER Quantity,
MODIFY COLUMN InvoiceDate DATETIME AFTER Description,
MODIFY COLUMN TotalPrice DECIMAL(10,2) AFTER UnitPrice;

UPDATE transaction_data
SET InvoiceNo = TRIM(InvoiceNo),
    StockCode = TRIM(StockCode),
    Description = TRIM(Description),
    CustomerID = TRIM(CustomerID),
    Country = TRIM(Country);
    
UPDATE transaction_data
SET CustomerID = NULL
WHERE CustomerID = '' OR CustomerID IS NULL;

SELECT * FROM transaction_data
WHERE customerID REGEXP '[^0-9.]';

ALTER TABLE transaction_data
MODIFY COLUMN CustomerID INT;

ALTER TABLE transaction_data
ADD PRIMARY KEY (id);

DESCRIBE transaction_data;

SELECT * FROM transaction_data
WHERE Quantity IS NULL
   OR UnitPrice IS NULL
   OR InvoiceDate IS NULL;
   
SELECT * FROM transaction_data
LIMIT 10;

SELECT * FROM transaction_data
WHERE Quantity = 0 OR Quantity < 0
	OR UnitPrice = 0 OR UnitPrice < 0;

SELECT * FROM transaction_data
WHERE InvoiceNo LIKE 'C%'
	OR UnitPrice <= 0
    OR Quantity <= 0;
    
CREATE TABLE transaction_data_special AS
SELECT * FROM transaction_data
WHERE InvoiceNo LIKE 'C%'
	OR UnitPrice <= 0
    OR Quantity <= 0;

DELETE FROM transaction_data
WHERE InvoiceNo LIKE 'C%'
	OR UnitPrice <= 0
    OR Quantity <= 0;

ALTER TABLE transaction_data_special
ADD PRIMARY KEY (id);

SELECT InvoiceNo, COUNT(InvoiceNo) AS cnt
FROM transaction_data
GROUP BY InvoiceNo
LIMIT 20;

SELECT * FROM transaction_data;

SELECT MIN(InvoiceDate), MAX(InvoiceDate) FROM transaction_data;

SELECT COUNT(DISTINCT(CustomerID)), COUNT(DISTINCT(InvoiceNo)), COUNT(DISTINCT(Country)), SUM(TotalPrice)/1000000
FROM transaction_data;

SELECT * FROM transaction_data t
JOIN (SELECT InvoiceNo, StockCode FROM transaction_data GROUP BY InvoiceNo, StockCode HAVING count(StockCode) > 1) d
	ON t.InvoiceNo = d.InvoiceNo
    AND t.StockCode = d.StockCode
ORDER BY t.CustomerID;

SELECT InvoiceNo, COUNT(DISTINCT(CustomerID)) AS cnt FROM transaction_data
GROUP BY InvoiceNo
HAVING cnt > 1;

SELECT DISTINCT(InvoiceNo) FROM transaction_data
WHERE CustomerID IS NULL;

SELECT StockCode, MIN(UnitPrice), MAX(UnitPrice), MAX(UnitPrice)-MIN(UnitPrice) AS Difference FROM transaction_data
GROUP BY StockCode
ORDER BY Difference DESC;

SELECT * FROM transaction_data
WHERE StockCode LIKE "Amaz%";

INSERT INTO transaction_data_special
SELECT * FROM transaction_data
WHERE StockCode IN ("DOT", "M", "POST", "AMAZONFEE", "B");

DELETE FROM transaction_data
WHERE StockCode IN ("DOT", "M", "POST", "AMAZONFEE", "B");

SELECT * FROM transaction_data
GROUP BY UnitPrice
ORDER BY UnitPrice DESC;

# Pareto analysis file for excel

SELECT
    StockCode,
    SUM(TotalPrice) AS revenue
FROM transaction_data
GROUP BY StockCode
ORDER BY revenue DESC;

# File for tableau

SELECT
    StockCode,
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
    SUM(TotalPrice) AS Revenue
FROM transaction_data
GROUP BY StockCode, Month;

SELECT
    StockCode,
    SUM(TotalPrice) AS revenue
FROM transaction_data
GROUP BY StockCode;

# File for concentration ratio for tableau

WITH CoreProductsCTE AS (
						SELECT t1.StockCode, DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, t1.TotalPrice 
                        FROM transaction_data t1 
                        JOIN 
							(SELECT StockCode, SUM(TotalPrice) AS revenue 
                            FROM transaction_data 
                            GROUP BY StockCode 
                            ORDER BY revenue 
                            DESC LIMIT 816) t2 
						ON t1.StockCode = t2.StockCode )
SELECT cte1.Month, SUM(cte1.TotalPrice) AS Core_driver_revenue, 
		t3.Monthly_revenue, ROUND(SUM(cte1.TotalPrice)/Monthly_revenue, 2) AS concentration_ratio 
        FROM CoreProductsCTE cte1 
        JOIN 
			(SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, SUM(TotalPrice) AS Monthly_revenue 
            FROM transaction_data 
            GROUP BY Month) t3 
		ON cte1.Month = t3.Month 
GROUP BY cte1.Month
ORDER BY cte1.Month;












