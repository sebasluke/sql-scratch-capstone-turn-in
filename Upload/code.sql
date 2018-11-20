-- Db analysis

SELECT *
 FROM survey
 LIMIT 10;
 
-- Answers

SELECT question, COUNT(*) AS 'answers'
FROM survey
GROUP BY question;

-- 4 home try on funnels

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

-- sales share test

SELECT h.number_of_pairs AS pairs, SUM(p.price) AS price, COUNT(h.user_id) AS sales_count
FROM home_try_on h
JOIN purchase p
ON h.user_id = p.user_id
GROUP BY pairs;

-- 5 table 

WITH a_table AS (
SELECT q.user_id, 
	h.user_id IS NOT NULL as 'is_home_try_on',
  h.number_of_pairs,
  p.user_id IS NOT NULL as is_purchase
FROM quiz q
LEFT JOIN home_try_on h
ON q.user_id = h.user_id
LEFT JOIN purchase p
ON q.user_id = p.user_id
)

SELECT *
FROM a_table;


-- Buys

SELECT COUNT(user_id), SUM(is_home_try_on), number_of_pairs, SUM(is_purchase)
FROM a_table
GROUP BY number_of_pairs;

--- Survey questions

SELECT response AS question_1, COUNT(*) AS totals
FROM survey
WHERE question = '1. What are you looking for?'
GROUP BY response;

SELECT response AS question_2, COUNT(*) AS totals
FROM survey
WHERE question LIKE '2%'
GROUP BY response;

SELECT response AS question_3, COUNT(*) AS totals
FROM survey
WHERE question = '3. Which shapes do you like?'
GROUP BY response;

SELECT response AS question_4, COUNT(*) AS totals
FROM survey
WHERE question = '4. Which colors do you like?'
GROUP BY response;

SELECT response AS question_5, COUNT(*) AS totals
FROM survey
WHERE question = '5. When was your last eye exam?'
GROUP BY response;

--- Gender

SELECT style, SUM(price) AS sales
FROM purchase
GROUP BY style;


--- Sales quantity revenue

WITH quantity AS (

SELECT user_id, SUM(price) AS sales, COUNT(price) AS sales_quantity 
FROM purchase
GROUP BY user_id
  )
  
SELECT COUNT(user_id), sales_quantity
 FROM quantity
 GROUP BY sales_quantity;

 
-- Sales quantity
 
WITH quantity AS (

SELECT user_id, SUM(price) AS sales, COUNT(price) AS sales_quantity 
FROM purchase
GROUP BY user_id
  )
  
SELECT user_id as users, sales_quantity 
 FROM quantity
 GROUP BY sales_quantity;


-- Sales / revenue

SELECT color, COUNT(user_id) AS sales_num, SUM(price) AS revenue
FROM purchase
GROUP BY color;



 
 
 
 
 
 
 