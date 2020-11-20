-- QUIZ 3
SELECT RIGHT(a.website,3), COUNT(*)
FROM accounts a
GROUP BY 1
ORDER BY 2

SELECT LEFT(a.name,1), COUNT(*)
FROM accounts a
GROUP BY 1
ORDER BY 2

SELECT CASE WHEN LEFT(a.name,1) IN ('1','2','3','4','5','6','7','8','9','0') THEN 'number'
                ELSE 'letter' END AS starts_with, COUNT(*)
FROM accounts a
GROUP BY 1

SELECT CASE WHEN LEFT(a.name,1) IN ('a','A','e','E','i','I','o','O','u','U') THEN 'vowel'
                ELSE 'not_vowel' END AS starts_with, COUNT(*)
FROM accounts a
GROUP BY 1

SELECT a.primary_poc, LEFT(a.primary_poc,STRPOS( a.primary_poc,' ')-1) firstName,
       RIGHT(a.primary_poc,LENGTH(a.primary_poc) - STRPOS(a.primary_poc,' ')) lastName
FROM accounts a

SELECT s.name, LEFT(s.name,POSITION(' ' IN s.name)-1) firstname,
              RIGHT(s.name,LENGTH(s.name)-POSITION(' ' IN s.name)) lastName
FROM sales_reps s

-- QUIZ 9
WITH tbl1 AS
      (SELECT a.primary_poc, a.name,
        CASE WHEN STRPOS( a.name,' ') = 0 AND STRPOS( a.name,'.') = 0 THEN a.name
             WHEN NOT STRPOS( a.name,' ') = 0 AND STRPOS( a.name,'.') = 0 THEN LEFT(a.name,STRPOS( a.name,' ')-1)
             WHEN STRPOS( a.name,' ') = 0 AND NOT STRPOS( a.name,'.') = 0 THEN LEFT(a.name,STRPOS( a.name,'.')-1)
             WHEN STRPOS( a.name,' ') > STRPOS( a.name,'.') THEN LEFT(a.name,STRPOS( a.name,'.')-1)
             ELSE LEFT(a.name,STRPOS( a.name,'.')-1) END AS AccountName,
          LEFT(a.primary_poc,STRPOS( a.primary_poc,' ')-1) firstName,
          RIGHT(a.primary_poc,LENGTH(a.primary_poc) - STRPOS(a.primary_poc,' ')) lastName
       FROM accounts a)
SELECT *, Lower(firstName || '.' || lastName || '@' || AccountName || '.com') AS email
FROM tbl1


WITH tbl1 AS
      (SELECT a.primary_poc, a.name,
          replace(replace(a.name, ' ',''),'.','') AccountName,
          LEFT(a.primary_poc,STRPOS( a.primary_poc,' ')-1) firstName,
          RIGHT(a.primary_poc,LENGTH(a.primary_poc) - STRPOS(a.primary_poc,' ')) lastName
       FROM accounts a)
SELECT *, Lower(firstName || '.' || lastName || '@' || AccountName || '.com') AS email
FROM tbl1

WITH tbl1 AS
      (SELECT a.primary_poc, a.name,
          replace(a.name, ' ','') AccountName,
          LEFT(a.primary_poc,STRPOS( a.primary_poc,' ')-1) firstName,
          RIGHT(a.primary_poc,LENGTH(a.primary_poc) - STRPOS(a.primary_poc,' ')) lastName
       FROM accounts a)
SELECT *, Lower(firstName || '.' || lastName || '@' || AccountName || '.com') AS email,
          CONCAT(lower(LEFT(firstName,1)||RIGHT(firstName,1)||LEFT(lastName,1)||RIGHT(lastName,1)),LENGTH(firstName),LENGTH(lastName),UPPER(AccountName))
FROM tbl1

--QUIZ 12
SELECT date,(SUBSTR(date,7,4)||'-'||SUBSTR(date,1,2)||'-'||SUBSTR(date,4,2))::date formated_date
FROM sf_crime_data
