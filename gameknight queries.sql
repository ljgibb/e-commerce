 
USE GameKnight;
    
-- Queries

-- Show product on hand
SELECT Name, QuantityOnHand FROM Game
WHERE QuantityOnHand > 0;

-- Show product with low stock level
SELECT Name, QuantityOnHand FROM Game
WHERE QuantityOnHand < 5;

-- Show products bought within the last 30 days
SELECT O.GameID, G.Name, SUM(O.Quantity) AS TotalQuantity
FROM Order_ O
JOIN Game G
ON O.GameID = G.GameID
WHERE O.Quantity > 0
AND O.OrderDate >= CURDATE() - INTERVAL 30 DAY
GROUP BY O.GameID
ORDER BY TotalQuantity DESC;



-- Show products that have not been bought within the last 30 days
SELECT G.GameID, G.Name, G.Publisher
FROM Game G
LEFT JOIN Order_ O
    ON G.GameID = O.GameID
    AND O.OrderDate >= CURDATE() - INTERVAL 30 DAY
WHERE O.OrderID IS NULL;

-- Show users that have not been made a purchase within the last 14 days
WITH InactiveCustomer AS (
    SELECT
        C.CustomerID,
        CONCAT(C.FirstName, ' ', C.LastName) AS Name
    FROM Customer C
    LEFT JOIN Order_ O
        ON C.CustomerID = O.CustomerID
        AND O.OrderDate >= CURDATE() - INTERVAL 14 DAY
        AND O.OrderDate <= CURDATE()
    WHERE O.OrderID IS NULL
)
SELECT *
FROM InactiveCustomer;

WITH InactiveCustomer AS (
SELECT C.CustomerID, CONCAT(C.FirstName, ' ', C.LastName) AS Name
FROM Customer C
LEFT JOIN Order_ O
    ON C.CustomerID = O.CustomerID
    AND O.OrderDate >= CURDATE() - INTERVAL 14 DAY
    AND O.OrderDate <= CURDATE()
WHERE O.OrderID IS NULL)

-- Show what inactive customers typically purchase
SELECT
    G.GameID,
    G.Name,
    SUM(O.Quantity) AS TotalPurchased
FROM Order_ O
JOIN InactiveCustomer IC
    ON O.CustomerID = IC.CustomerID
JOIN Game G
    ON O.GameID = G.GameID
GROUP BY G.GameID, G.Name
ORDER BY TotalPurchased DESC;

-- Which type of game is selling the best?
SELECT
    CASE
        WHEN BG.GameID IS NOT NULL THEN 'BoardGame'
        WHEN TCG.GameID IS NOT NULL THEN 'TradingCardGame'
        WHEN M.GameID IS NOT NULL THEN 'Merch'
    END AS GameType,
    SUM(O.Quantity) AS TotalSold
FROM Order_ O
LEFT JOIN BoardGame BG
    ON O.GameID = BG.GameID
LEFT JOIN TradingCardGame TCG
    ON O.GameID = TCG.GameID
LEFT JOIN Merch M
    ON O.GameID = M.GameID
GROUP BY GameType
ORDER BY TotalSold DESC;

SELECT * FROM INACTIVECUSTOMER;