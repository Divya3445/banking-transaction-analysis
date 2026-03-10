
-- Banking Transaction Data Analysis Project


-- Create Database
CREATE DATABASE BankingProject;

USE BankingProject;


-- 1. Total Number of Transactions

SELECT COUNT(*) AS Total_Rows
FROM bank_transactions_clean;



-- 2. Total Transaction Amount

SELECT SUM(TransactionAmount) AS Total_Transaction_Amount
FROM bank_transactions_clean;


-- 3. Average Transaction Amount

SELECT AVG(TransactionAmount) AS Avg_Transaction_Amount
FROM bank_transactions_clean;


-- 4. Total Unique Customers

SELECT COUNT(DISTINCT CustomerID) AS Unique_Customers
FROM bank_transactions_clean;



-- 5. Gender Wise Transaction Summary

SELECT 
    ISNULL(CustGender,'Unknown') AS CustGender,
    COUNT(*) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Amount
FROM bank_transactions_clean
GROUP BY ISNULL(CustGender,'Unknown');


-- 6. Location Wise Transaction Summary

SELECT 
    CustLocation,
    COUNT(*) AS Total_Transactions,
    SUM(TransactionAmount) AS Total_Amount
FROM bank_transactions_clean
GROUP BY CustLocation
ORDER BY Total_Amount DESC;



-- 7. Top 10 Highest Transactions

SELECT TOP 10 *
FROM bank_transactions_clean
ORDER BY TransactionAmount DESC;


-- 8. Highest Spending Customer

SELECT TOP 1
    CustomerID,
    SUM(TransactionAmount) AS Total_Spent
FROM bank_transactions_clean
GROUP BY CustomerID
ORDER BY Total_Spent DESC;



-- 9. Lowest Spending Customer

SELECT TOP 1
    CustomerID,
    SUM(TransactionAmount) AS Total_Spent
FROM bank_transactions_clean
GROUP BY CustomerID
ORDER BY Total_Spent ASC;


-- 10. Monthly Revenue Trend

SELECT 
    FORMAT(TransactionDate, 'yyyy-MM') AS Month,
    SUM(TransactionAmount) AS Monthly_Revenue
FROM bank_transactions_clean
GROUP BY FORMAT(TransactionDate, 'yyyy-MM')
ORDER BY Month;



-- 11. Gender Contribution Percentage

SELECT 
    ISNULL(CustGender,'Unknown') AS CustGender,
    SUM(TransactionAmount) AS Total_Amount,
    ROUND(
        SUM(TransactionAmount) * 100.0 /
        (SELECT SUM(TransactionAmount) FROM bank_transactions_clean),
        2
    ) AS Percentage_Contribution
FROM bank_transactions_clean
GROUP BY ISNULL(CustGender,'Unknown');


-- 12. Top 5 Cities by Revenue

SELECT TOP 5
    CustLocation,
    SUM(TransactionAmount) AS Total_Revenue
FROM bank_transactions_clean
GROUP BY CustLocation
ORDER BY Total_Revenue DESC;
