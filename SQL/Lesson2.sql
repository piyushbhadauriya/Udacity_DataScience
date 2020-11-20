-- Quiz11
SELECT a.primary_poc,w.occurred_at,w.channel,a.name
 FROM web_events w
 JOIN accounts a
 ON w.account_id = a.id
 WHERE a.name = 'Walmart'

 SELECT s.name sales_rep, a.name account, r.name region_name
 FROM accounts a
 JOIN sales_reps s
 ON a.sales_rep_id = s.id
 JOIN region r
 ON r.id = s.region_id
 ORDER BY a.name

 SELECT r.name region_name, a.name account_name,o.total_amt_usd/(o.total+.01) unit_price
 FROM orders o
 JOIN accounts a
 ON o.account_id = a.id
 JOIN sales_reps s
 ON s.id = a.sales_rep_id
 JOIN region r
 ON s.region_id = r.id

 --Quiz 19
SELECT r.name RegionName,s.name SalesRepName, a.name AccountName
FROM region r
JOIN sales_reps s
ON r.id = s.region_id AND r.name = 'Midwest'
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name

SELECT r.name RegionName,s.name SalesRepName, a.name AccountName
FROM region r
JOIN sales_reps s
ON r.id = s.region_id AND r.name = 'Midwest' AND s.name LIKE 'S%'
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name

SELECT r.name RegionName,s.name SalesRepName, a.name AccountName
FROM region r
JOIN sales_reps s
ON r.id = s.region_id AND r.name = 'Midwest' AND s.name LIKE '% K%'
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY AccountName

SELECT r.name RegionName, a.name AccountName, o.total_amt_usd/(o.total+0.01) UnitPrice
FROM orders o
JOIN accounts a
ON o.account_id = a.id AND o.standard_qty > 100
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id

SELECT r.name RegionName, a.name AccountName, o.total_amt_usd/(o.total+0.01) UnitPrice
FROM orders o
JOIN accounts a
ON o.account_id = a.id AND o.standard_qty > 100 AND o.poster_qty > 50
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
ORDER BY UnitPrice

SELECT r.name RegionName, a.name AccountName, o.total_amt_usd/(o.total+0.01) UnitPrice
FROM orders o
JOIN accounts a
ON o.account_id = a.id AND o.standard_qty > 100 AND o.poster_qty > 50
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
ORDER BY UnitPrice DESC

SELECT DISTINCT a.name AccountName, w.channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id AND a.id = 1001

SELECT o.occurred_at,a.name AccountName,o.total,o.total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id AND o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY o.occurred_at DESC;
