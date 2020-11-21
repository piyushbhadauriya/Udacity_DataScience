-- Quiz 8
SELECT a.first_name || ' ' || a.last_name as full_name,
      f.title, f.description, f.length
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id AND f.length >= 60
JOIN actor a
ON a.actor_id = fa.actor_id

SELECT a.first_name || ' ' || a.last_name as full_name,
        sub.actor_id, sub.num_movies
FROM
  (SELECT fa.actor_id,
        COUNT(f.film_id) num_movies
  FROM film f
  JOIN film_actor fa
  ON f.film_id = fa.film_id
  GROUP BY 1) sub
JOIN actor a
ON a.actor_id = sub.actor_id
ORDER BY 3 DESC

-- QUIZ 10
SELECT a.first_name || ' ' || a.last_name as full_name,
      f.title, f.length,
      CASE WHEN f.length <= 60 THEN '1 hour or less'
        WHEN f.length <= 120 THEN 'Between 1-2 hours'
        WHEN f.length <= 180 THEN 'Between 2-3 hours'
        ELSE 'More than 3 hours' END AS filmlen_groups
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
JOIN actor a
ON a.actor_id = fa.actor_id
WHERE f.title in ('Academy Dinosaur','Color Philadelphia','Oklahoma Jumanji');

SELECT COUNT(*),
  CASE WHEN f.length <= 60 THEN '1 hour or less'
    WHEN f.length <= 120 THEN 'Between 1-2 hours'
    WHEN f.length <= 180 THEN 'Between 2-3 hours'
    ELSE 'More than 3 hours' END AS filmlen_groups
FROM film f
GROUP BY 2
ORDER BY 1
/*
SELECT    DISTINCT(filmlen_groups),
          COUNT(title) OVER (PARTITION BY filmlen_groups) AS filmcount_bylencat
FROM
         (SELECT title,length,
          CASE WHEN length <= 60 THEN '1 hour or less'
          WHEN length > 60 AND length <= 120 THEN 'Between 1-2 hours'
          WHEN length > 120 AND length <= 180 THEN 'Between 2-3 hours'
          ELSE 'More than 3 hours' END AS filmlen_groups
          FROM film ) t1
ORDER BY  filmlen_groups
*/
