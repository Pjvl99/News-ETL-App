MERGE news_dev.news_data n
USING news_dev.news_raw_data nr
ON n.category = nr.category and n.date = nr.date and n.title = nr.title
WHEN NOT MATCHED THEN
INSERT ROW;

TRUNCATE TABLE news_dev.news_raw_data;

CREATE OR REPLACE TABLE news_prd.news_numbered 
CLUSTER BY number
AS
SELECT *,
ROW_NUMBER() OVER (ORDER BY date DESC) as number
FROM `trim-heaven-415202.news_dev.news_data`;