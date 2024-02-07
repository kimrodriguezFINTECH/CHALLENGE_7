--- Check card_holder table data after import
SELECT *
FROM card_holder

--- Check credit_card table data after import
SELECT *
FROM credit_card

--- Check merchant table data after import
SELECT *
FROM merchant

--- Check merchant_category table data after import
SELECT *
FROM merchant_category

--- Check transaction table data after import
SELECT *
FROM transaction

----------------------------------------------------------------------------------------------
--- Query for Data Analysis 
--- Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
--- Count for fraudulent transactions between 7am and 9am
SELECT *
FROM transaction
WHERE amount < 2 AND date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00';

--- Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
--- Count for fraudulent transactions between 9am and 7am
SELECT *
FROM transaction
WHERE amount < 2 AND (date :: timestamp :: time < '07:00:00' OR date :: timestamp :: time > '09:00:00');

--- If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame
--- Count for all transactions between 7am and 9am
SELECT *
FROM transaction
WHERE date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00';

--- If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame
--- Count for all transactions between 9am and 7am
SELECT *
FROM transaction
WHERE (date :: timestamp :: time < '07:00:00' OR date :: timestamp :: time > '09:00:00');

--- What are the top 5 merchants prone to being hacked using small transactions?
SELECT merchant.name, COUNT(transaction.id_merchant) AS "Number of Transactions"
FROM transaction
JOIN merchant ON transaction.id_merchant  = merchant.id
WHERE transaction.amount < 2
GROUP BY merchant.name
ORDER BY "Number of Transactions" DESC
LIMIT 5;
----------------------------------------------------------------------------------------------
--- Create VIEWS for all queries
--- Create View for query for Data Analysis Part 1 Question 1
CREATE VIEW transactions_per_cardholder AS
SELECT card_holder.name AS "Card Holder", COUNT(transaction.id) AS "Transactions"
FROM transaction
JOIN credit_card on credit_card.card = transaction.card
JOIN card_holder on card_holder.id = credit_card.cardholder_id
GROUP BY "Card Holder"
ORDER BY "Transactions" DESC;

--- Create View for query for Data Analysis Part 1 Question 
CREATE VIEW transactions_sub2_per_cardholder AS
SELECT card AS "Card Number", COUNT(amount) AS "Count of Sub $2 Transactions"
FROM transaction
WHERE amount < 2.00
GROUP BY card
ORDER BY "Count of Sub $2 Transactions" DESC;

--- Create view for query for Data Analysis Part 1 Question 4
CREATE VIEW top100_between_7_9 AS
SELECT id, amount, date :: timestamp :: date AS "Date", date :: timestamp :: time AS "Time"
FROM transaction
WHERE date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00'
ORDER BY amount DESC
LIMIT 100;

--- Create View query for Data Analysis Part 1 Question 5
CREATE VIEW transactions_sub2_between_7_9_id_amount AS
SELECT id, amount, date :: timestamp :: date AS "Date", date :: timestamp :: time AS "Time"
FROM transaction
WHERE amount < 2 AND date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00'
ORDER BY amount DESC;

--- Create View for query for Data Analysis Part 1 Question 6a
CREATE VIEW transactions_sub2_between_7_9_all  AS
SELECT *
FROM transaction
WHERE amount < 2 AND date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00';

--- Create View for query for Data Analysis Part 1 Question 6b
CREATE VIEW transactions_sub2_between_9_7_all  AS
SELECT *
FROM transaction
WHERE amount < 2 AND (date :: timestamp :: time < '07:00:00' OR date :: timestamp :: time > '09:00:00');

--- Create View for query for Data Analysis Part 1 Question 7a
CREATE VIEW transactions_between_7_9_all  AS
SELECT *
FROM transaction
WHERE date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00';

--- Create View for query for Data Analysis Part 1 Question 7b
CREATE VIEW transactions_between_9_7_all  AS
SELECT *
FROM transaction
WHERE (date :: timestamp :: time < '07:00:00' OR date :: timestamp :: time > '09:00:00');

--- Create View query for Data Analysis Part 1 Question 8
CREATE VIEW top_5_hacked_merchants  AS
SELECT merchant.name, COUNT(transaction.id_merchant) AS "Number of Transactions"
FROM transaction
JOIN merchant ON transaction.id_merchant  = merchant.id
WHERE transaction.amount < 2
GROUP BY merchant.name
ORDER BY "Number of Transactions" DESC
LIMIT 5;
----------------------------------------------------------------------------------------------
-- Part1 : Top 100 highest transactions made between 7:00am and 9:00am
SELECT date, amount
FROM transaction
WHERE EXTRACT(HOUR FROM date) BETWEEN '07' AND '08'
ORDER BY amount DESC
FETCH FIRST 100 ROWS ONLY;

-- Part1 : Top 5 merchants prone to being hacked using small transactions
SELECT id_merchant, count(amount) as number_of_small_tx
FROM transaction
WHERE amount < 2
GROUP BY id_merchant
ORDER BY count(amount) DESC
LIMIT 5;

-- Part 2: Joining cardholder_id to transaction table where Card holder is 2 or 18
SELECT transaction.amount, credit_card.card, credit_card.cardholder_id
FROM transaction
LEFT JOIN credit_card 
ON transaction.card = credit_card.card
WHERE credit_card.cardholder_id = 2 or credit_card.cardholder_id = 18;

-- Part 2: Transactions for cardholder_id 25 change to month names and day number from january to june
SELECT to_char(transaction.date, 'month') as month, to_char(transaction.date, 'DD') as day, transaction.amount
FROM transaction
LEFT JOIN credit_card
ON transaction.card = credit_card.card
WHERE credit_card.cardholder_id = 25
and date >= '2018-01-01 00:00:00' 
and date < '2018-07-01 00:00:00';
----------------------------------------------------------------------------------------------
--- queries for Data Analysis Challenge
--- loading data for card holder data
SELECT card_holder.id AS "cardholder", transaction.date AS "hour",  transaction.amount AS "amount"
FROM transaction
JOIN credit_card on credit_card.card = transaction.card
JOIN card_holder on card_holder.id = credit_card.cardholder_id;