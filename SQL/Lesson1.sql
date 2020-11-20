
-- Quiz 18 OrderBY
SELECT id,occurred_at,total_amt_usd
 FROM orders
 ORDER BY occurred_at DESC
 LIMIT 10;

SELECT id,account_id,total_amt_usd
 FROM orders
 ORDER BY total_amt_usd DESC
 LIMIT 5;

SELECT id,account_id,total_amt_usd
 FROM orders
 ORDER BY total_amt_usd
 LIMIT 20;

-- QUIZ 21 OrderBy

SELECT id,account_id,total
 FROM orders
 ORDER BY account_id,total DESC;

 -- Quiz 24 WHERE
SELECT *
 FROM orders
 WHERE gloss_amt_usd >= 1000
 LIMIT 5

 -- Quiz 27 WHERE
SELECT name,website,primary_poc
 FROM accounts
 WHERE name = 'Exxon Mobil'
 LIMIT 5

 -- Quiz 30 Arithmetic Operations
 SELECT id,account_id,standard_amt_usd/standard_qty AS standard_unit_price
 FROM orders
 LIMIt 10;

 -- QUIZ 34 LIKE
SELECT *
 FROM accounts
 WHERE name LIKE 'C%'

 --Quiz 37 IN
 SELECT  name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart','Target','Nordstrom')

--QUIZ 40 NOT
SELECT  *
FROM web_events
WHERE channel NOT IN ('organic','adwords')

-- QUIZ 43 AND/BETWEEN
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0

SELECT occurred_at,gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29
ORDER BY gloss_qty

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC

-- QUIZ 46 OR
SELECT *
FROM orders
WHERE (gloss_qty > 1000 OR poster_qty > 1000) AND
	standard_qty = 0

  SELECT name
  FROM accounts
  WHERE (name LIKE 'C%' OR name LIKE 'W%') AND
  	(primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana'
