USE Asces;

UPDATE product_sales
SET Date = CONVERT(DATETIME, FORMAT(Date, 'yyyy-dd-MM HH:mm:ss'), 120);

-- SELECT * FROM Product_data;

-- SELECT * FROM product_sales;

SELECT Discount FROM discount_data;

ALTER TABLE discount_data
ALTER column Discount DECIMAL(10,2);

WITH product_cte as (
SELECT
	pd.Product,
	pd.Category,
	ps.Units_Sold,
	pd.Cost_Price,
	pd.Sale_Price,
	pd.Brand,
	pd.Description,
	pd.Image_url,
	ps.Date,
	ps.Customer_Type,
	ps.Country,
	ps.Discount_Band,
	format(date, 'MMMM') as month,
	format (date, 'yyyy') as Year,
	(Units_Sold * Sale_Price) as Revenue,
	(Units_Sold * Cost_Price) as Total_Cost_Amount
FROM Product_data pd
	JOIN product_sales ps
	ON pd.Product_ID = ps.Product 
)
 SELECT  *, 
 (1 - dd.Discount/100)* pc.Revenue AS Revenue_After_Discount
 FROM product_cte AS pc
 JOIN discount_data AS dd
	ON pc.Discount_Band = dd.Discount_Band and pc.month = dd.Month;