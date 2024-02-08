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

----------------------------------------------------------------------------------------------
--- queries for Data Analysis Challenge
--- loading data for card holder data
SELECT card_holder.id AS "cardholder", transaction.date AS "hour",  transaction.amount AS "amount"
FROM transaction
JOIN credit_card on credit_card.card = transaction.card
JOIN card_holder on card_holder.id = credit_card.cardholder_id;