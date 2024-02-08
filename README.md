# CHALLENGE_7
# Looking for Suspicious Transactions

## Background

Fraud is prevalent these days, whether you are a small taco shop or a large international business. While there are emerging technologies that employ machine learning and artificial intelligence to detect fraud, many instances of fraud detection still require strong data analytics to find abnormal charges.

In this homework assignment, you will apply your new SQL skills to analyze historical credit card transactions and consumption patterns in order to identify possible fraudulent transactions.

You are asked to accomplish three main tasks:

1. [Data Modeling](#Data-Modeling):
Define a database model to store the credit card transactions data and create a new PostgreSQL database using your model.

2. [Data Engineering](#Data-Engineering): Create a database schema on PostgreSQL and populate your  database from the CSV files provided.

3. [Data Analysis](#Data-Analysis): Analyze the data to identify possible fraudulent transactions trends data, and develop a report of your observations.

---

## Files

* [card_holder.csv](Data/card_holder.csv)
* [credit_card.csv](Data/credit_card.csv)
* [merchant.csv](Data/merchant.csv)
* [merchant_category.csv](Data/merchant_category.csv)
* [transaction.csv](Data/transaction.csv)

## Instructions

### Data Modeling

Create an entity relationship diagram (ERD) by inspecting the provided CSV files.

Part of the challenge here is to figure out how many tables you should create, as well as what kind of relationships you need to define among the tables.

Feel free to discuss your database model design ideas with your classmates. You can use a tool like [Quick Database Diagrams](https://www.quickdatabasediagrams.com) to create your model.

**Hints:** 

* For the `credit_card` and `transaction` tables, the `card` column should be a VARCHAR(20) datatype rather than an INT.
* For the `transaction` table, the `date` column should be a TIMESTAMP datatype rather than DATE.

### Data Engineering

Using your database model as a blueprint, create a database schema for each of your tables and relationships. Remember to specify data types, primary keys, foreign keys, and any other constraints you defined.

After creating the database schema, import the data from the corresponding CSV files.

### Data Analysis
#### Part 1:

The CFO of your firm has requested a report to help analyze potential fraudulent transactions. Using your newly created database, generate queries that will discover the information needed to answer the following questions, then use your repository's ReadME file to create a markdown report you can share with the CFO:

* Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by cardholders. 

  * How can you isolate (or group) the transactions of each cardholder?
    * I first needed to complete an entity relationship diagram (ERD). Within my ERD I assign primary and foreign keys in order to determine the number of tables to create and what kind of relationships I need to define my tables. Quick Database Diagrams was used for this process. 
    * Using hvPlot, I created a line plot representing the time series of transactions over the course of the year for each cardholder separately (df_2 & df_18).

![QuickDBD-Diagram_Challenge_7](https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/cbd96505-3698-4477-8ac1-c3a2465ccbc4)

<img width="883" alt="Screenshot 2024-02-07 at 5 08 11 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/07c99ec2-3645-4224-862d-e5659cea80a4">

<img width="857" alt="Screenshot 2024-02-07 at 5 08 18 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/93d8c88f-58dd-4c49-82be-6c676b2c912d">

<img width="871" alt="Screenshot 2024-02-07 at 5 08 26 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/0b1048a2-3825-4967-a79d-774313f70fc5">


  * Count the transactions that are less than $2.00 per cardholder. 
    * Cardholder ID 2 transactions are never greater than $20. On the other hand, cardholder ID 18 regularly makes very small purchases and then there are significant spikes with high cost purchases almost as high as $2000. (I personally like using the graph.)

<img width="883" alt="Screenshot 2024-02-07 at 5 08 11 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/72fc11ca-2fe2-467b-ba0b-0684de732199">

  * Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.
    * Since there are irregular spikes with cardholder ID 18 transactions, this might suggest there might be some fraudulent activity occurring with this account and is worth validating with the cardholder. Small transactions can be a fraudsters way to check whether the card is active and if the card has funds before making larger fraudulent purchases. Now, with Cardholder ID 2 there aren't irregular spikes so we don't need to worry to much about this account. (I personally like using the graph.)

<img width="871" alt="Screenshot 2024-02-07 at 5 08 26 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/52be38ab-3c2f-4360-ace7-29de672e971a">

* Take your investigation a step futher by considering the time period in which potentially fraudulent transactions are made. 

  * What are the top 100 highest transactions made between 7:00 am and 9:00 am?
    * Between $11.65 - $1,894.00
    - Folder query_questions: Top_100_Highest.csv

  * Do you see any anomalous transactions that could be fraudulent?
    * Possibly 1-9 that are over $100.00 With the new technology/algorithms cardholders have a text or email could be sufficient to let them know if they are the ones making the $100 purchases.
    - Folder query_questions: Top_100_Highest.csv

<img width="351" alt="Screenshot 2024-02-07 at 5 17 38 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/1c2866c8-6fc5-4b44-928c-72593177bf9a">

  * Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
    * Yes.

  * If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.
    * I believe hackers choose time of day to make fraudulent transactions as people are less likely to notice. This is the start of the day where people are busy getting ready to go to work or school and are often speding money on supplies food or travel etc. throughout the day. These transactions are also during busy hours when people tend to use their card the most compared to using your card in the middle of the night when people are asleep. 

   * What are the top 5 merchants prone to being hacked using small transactions?
        - "Wood-Ramirez", "Hood-Phillips", "Davis Lowe and Baker", "Clark & Sons", and "Greene-Wood."
        - Folder query_questions: Top_5_Merch.csv

<img width="352" alt="Screenshot 2024-02-07 at 5 17 43 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/bc4729b9-0fa2-43de-a618-401e3306d409">


#### Part 2:

Your CFO has also requested detailed trends data on specific card holders. Use the [starter notebook](Starter_Files/challenge.ipynb) to query your database and generate visualizations that supply the requested information as follows, then add your visualizations and observations to your markdown report:      

* The two most important customers of the firm may have been hacked. Verify if there are any fraudulent transactions in their history. For privacy reasons, you only know that their cardholder IDs are 2 and 18.

  * Using hvPlot, create a line plot representing the time series of transactions over the course of the year for each cardholder separately. 

<img width="883" alt="Screenshot 2024-02-07 at 5 08 11 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/26590e9a-6bc1-41ed-a19c-58bcc487e635">

<img width="857" alt="Screenshot 2024-02-07 at 5 08 18 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/84edd4f6-15c7-4ce4-9bdc-6a490402e4e0">


  * Next, to better compare their patterns, create a single line plot that contains both card holders' trend data.  

<img width="871" alt="Screenshot 2024-02-07 at 5 08 26 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/a0ec07a4-8e41-436d-b656-b37f1b0288b4">


  * What difference do you observe between the consumption patterns? Does the difference suggest a fraudulent transaction? 
    - As mentioned before Cardholder ID 2 transactions are never greater than $20. On the other hand, cardholder ID 18 regularly makes very small purchases and then there are significant spikes with high cost purchases almost as high as $2000. Since there are irregular spikes with cardholder ID 18 transactions, this might suggest there might be some fraudulent activity occurring with this account and is worth validating with the cardholder. Small transactions can be a fraudsters way to check whether the card is active and if the card has funds before making larger fraudulent purchases. Now, with Cardholder ID 2 there aren't irregular spikes so we don't need to worry to much about this account. 

* The CEO of the biggest customer of the firm suspects that someone has used her corporate credit card without authorization in the first quarter of 2018 to pay quite expensive restaurant bills. Again, for privacy reasons, you know only that the cardholder ID in question is 25.

  * Using Plotly Express, create a box plot, representing the expenditure data from January 2018 to June 2018 for cardholder ID 25.

<img width="969" alt="Screenshot 2024-02-07 at 5 23 09 PM" src="https://github.com/kimrodriguezFINTECH/CHALLENGE_7/assets/152752672/ac67932a-6669-4838-8a98-501903152dd8">


  * Are there any outliers for cardholder ID 25? How many outliers are there per month?
    * Every month except for February contains outliers. January, March, and May all have a single outlier. April and June each have 3 outliers.
  * Do you notice any anomalies? Describe your observations and conclusions.
    * There are a total of 9 outliers from January-June 2018 so each one of these transactions are worth validating with the cardholder. 
