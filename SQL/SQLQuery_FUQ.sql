-- LIMIT
/*
explore few rows from a big table
used at end of query statement
*/
SELECT occurred_at,account_id,channel
 FROM web_events
 LIMIT 15

-- ORDER BY
/*
Asending by default (use DESC to change)
works with dates
can use more than one column at a time
*/
SELECT account_id,occurred_at,total_amt_usd
 FROM orders
 ORDER BY account_id, occurred_at DESC

-- WHERE
/*
Filtering the data
Before ORDER BY and LIMIT, After FROM
Operator <,>,= for date and Number
*/
SELECT name,website,primary_poc
 FROM accounts
 WHERE name = 'Exxon Mobil'
 LIMIT 5

-- AS
/*
create alias for existing columns or derived columns
*/
SELECT id,account_id,standard_amt_usd/standard_qty AS standard_unit_price
 FROM orders
 WHERE nmae LIKE 'abc' OR account_id NOT IN 1000,1001,1002
 LIMIt 10;

-- LIKE
-- IN  (a,b,c,..)
-- NOT
-- AND & BETWEEN
-- OR
/*
Wild cards %- Any Number of character
WHERE column >= 6 AND column <= 10
WHERE column BETWEEN 6 AND 10 (include 6 and 10)
*/
SELECT name
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND
	(primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana'

-- JOIN
-- LEFT JOIN
-- ON with AND to Filter(before JOIN) rows instead of WHERE

-- IS NULL

-- SUM
-- COUNT
-- MIN
-- MAX
-- AVG

-- GROUP BY
/* Goes between WHERE and ORDER BY clause */

-- DISTINCT
/* used with SELECT */
SELECT DISTINCT a.name AcccountName, r.name RegionName
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name

--HAVING /* useed with aggregating function Instead of WHERE*/
SELECT o.account_id, COUNT(o.id)
FROM orders o
GROUP BY o.account_id
HAVING COUNT(o.id) >20

--DATE_TRUNC
--DATE_PART
/* DATE_PART('dow',xxxx)
DAY OF WEEK with SUNDAY 0 and SATURDAY 6*/


-- CASE
/* similar to if Else and switch CASE,
 components : WHEN, THEN, and END. ELSE is an optional
The CASE statement always goes in the SELECT clause.
*/
SELECT id, account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                            ELSE standard_amt_usd/standard_qty END AS unit_price
FROM num_orders
LIMIT 10;

-- SUB QUERY
SELECT AVG(avg_amt_usd)
FROM
  (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt_usd
  FROM orders o
  GROUP BY o.account_id
  HAVING AVG(o.total_amt_usd) >
    (SELECT AVG(o.total_amt_usd)
    FROM orders o)
  ) AS tbl1

  -- WITH
WITH table1 AS (
          SELECT *
          FROM web_events),
     table2 AS (
          SELECT *
          FROM accounts)
SELECT *
FROM table1
JOIN table2
ON table1.account_id = table2.id;

-- LEFT
-- RIGHT
/* Pull character from the Left/Right side of string */

--LENGHT
/* returns Lengh of a string */
--    POSITION  POSITION(',' IN city_state).
--    STRPOS  STRPOS(city_state, ',').
/* POSITION and STRPOS are case sensitive  */
--    LOWER
--    UPPER

-- CONCAT
/*
CONCAT(first_name, ' ', last_name)
 or with piping as first_name || ' ' || last_name
 */
 WITH tbl1 AS
       (SELECT a.primary_poc, a.name,
           replace(a.name, ' ','') AccountName,
           LEFT(a.primary_poc,STRPOS( a.primary_poc,' ')-1) firstName,
           RIGHT(a.primary_poc,LENGTH(a.primary_poc) - STRPOS(a.primary_poc,' ')) lastName
        FROM accounts a)
 SELECT *, Lower(firstName || '.' || lastName || '@' || AccountName || '.com') AS email,
           CONCAT(lower(LEFT(firstName,1)||RIGHT(firstName,1)||LEFT(lastName,1)||RIGHT(lastName,1)),
                  LENGTH(firstName),LENGTH(lastName),UPPER(AccountName)) AS pass
 FROM tbl1

 -- CAST(value AS dataType) or value::dataType
 SELECT date,(SUBSTR(date,7,4)||'-'||SUBSTR(date,1,2)||'-'||SUBSTR(date,4,2))::date formated_date
 FROM sf_crime_data

 -- COALESCE
 SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long,
    a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id,
     o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty,
     COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty,
    COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd,
    COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd,
    COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

-- LEAD
-- LAG
SELECT account_id,
       standard_sum,
       LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead,
       standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) - standard_sum AS lead_difference
FROM (
SELECT account_id,
       SUM(standard_qty) AS standard_sum
  FROM orders
 GROUP BY 1
 ) sub

 -- NTILE
 /* Calculate Percentile */

 -- INTERVAL
 SELECT o1.id AS o1_id,
        o1.account_id AS o1_account_id,
        o1.occurred_at AS o1_occurred_at,
        o2.id AS o2_id,
        o2.account_id AS o2_account_id,
        o2.occurred_at AS o2_occurred_at
   FROM orders o1
  LEFT JOIN orders o2
    ON o1.account_id = o2.account_id
   AND o2.occurred_at > o1.occurred_at
   AND o2.occurred_at <= o1.occurred_at + INTERVAL '28 days'
 ORDER BY o1.account_id, o1.occurred_at

-- SELF JOIN
/* same table different alias */
-- UNION
/* append similer data from different SELECT statement. No duplicates */

/*
 Here are sql practice recommendations:
 HackerRank https://www.hackerrank.com/domains/sql and
 ModeAnalytics https://community.modeanalytics.com/sql/tutorial/sql-business-analytics-training/
 The skill test by AnalyticsVidhya https://www.analyticsvidhya.com/blog/2017/01/46-questions-on-sql-to-test-a-data-science-professional-skilltest-solution/
 is a fun test to take too.
