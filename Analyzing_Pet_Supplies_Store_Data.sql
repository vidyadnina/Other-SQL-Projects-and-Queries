-- Cleaning the data and replacing missing values
WITH median_sales_cte AS (
    SELECT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sales) AS median_sales
    FROM 
        public.pet_supplies
)
SELECT 
	product_id,
	CASE 
            WHEN category = '-' THEN 'Unknown'
            ELSE COALESCE(category, 'Unknown')
        END AS category,
    COALESCE(animal, 'Unknown') AS animal,
	CASE 
            WHEN LOWER(size) IN ('large', 'l') THEN 'Large'
            WHEN LOWER(size) IN ('medium', 'm') THEN 'Medium'
            WHEN LOWER(size) IN ('small', 's') THEN 'Small'
            ELSE 'Unknown'
        END AS size,
	CASE 
            WHEN price = 'unlisted' THEN '0'
            ELSE COALESCE(price, '0')
        END AS price,
    COALESCE(sales, median_sales_cte.median_sales) AS sales,
	COALESCE(rating, '0') AS rating,
	repeat_purchase	
FROM
    public.pet_supplies,
    median_sales_cte	
WHERE
	repeat_purchase IS NOT NULL;

-- You want to show whether sales are higher for repeat purchases for different animals. You also want to give a range for the sales.
SELECT
    animal,
    repeat_purchase,
    ROUND(AVG(sales)) AS avg_sales,
    ROUND(MIN(sales)) AS min_sales,
    ROUND(MAX(sales)) AS max_sales
FROM
    public.pet_supplies
WHERE
    animal IS NOT NULL
    AND sales IS NOT NULL
    AND repeat_purchase IS NOT NULL
GROUP BY
    animal,
    repeat_purchase
ORDER BY
    animal,
    repeat_purchase;

-- The management team want to focus on efforts in the next year on the most popular pets - cats and dogs - for products that are bought repeatedly.
SELECT
    product_id,
    sales,
    rating
FROM
    public.pet_supplies
WHERE
    animal IN ('Cat', 'Dog')
    AND repeat_purchase = 1
ORDER BY
    sales DESC;


	

