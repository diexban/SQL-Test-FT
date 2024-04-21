-- Create Users Table

drop table if exists Transactions;
drop table if exists Users;

-- Create Users Table

CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    UserName VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL
);

-- Create Transactions Table

CREATE TABLE Transactions (
    TransactionId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    TransactionType VARCHAR(10) NOT NULL CHECK (TransactionType IN ('Deposit', 'Withdrawal')),
    TransactionAmount DECIMAL(10, 2) NOT NULL,
    TransactionDate DATETIME NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);


-- Insert Sample Data Into Users Table

INSERT INTO Users (UserName, Password)
VALUES
    ('Damo657', 'qwerty122'),
    ('Ben425', '8556723157'),
    ('Arturo132', 'asdf41234');

-- Insert Sample Data Into Transactions Table

INSERT INTO Transactions (UserId, TransactionType, TransactionAmount, TransactionDate)
VALUES
    (1, 'Deposit', 100.00, '2024-04-19'),
    (1, 'Deposit', 50.00, '2024-04-20'),
    (1, 'Deposit', 200.00, '2024-04-22'),
    (1, 'Withdrawal', 30.00, '2024-04-23'),
    (2, 'Deposit', 150.00, '2024-04-20'),
    (2, 'Withdrawal', 60.00, '2024-04-27'),
    (2, 'Withdrawal', 50.00, '2024-04-21'),
    (3, 'Deposit', 300.00, '2024-04-20'),
    (3, 'Deposit', 100.00, '2024-04-22'),
    (3, 'Deposit', 70.00, '2024-05-22'),
	(3, 'Withdrawal', 80.00, '2024-04-23');


--  Query #1 List All Users Having 3 Deposits Or More

SELECT U.UserId, U.UserName
FROM Users U
JOIN (
    SELECT UserId
    FROM Transactions
    WHERE TransactionType = 'Deposit'
    GROUP BY UserId
    HAVING COUNT(*) >= 3
) AS Deposits
ON U.UserId = Deposits.UserId
ORDER BY U.UserName;


--  Query #2 List All Users Having Only 1 Withdrawal

SELECT U.UserId, U.UserName
FROM Users U
WHERE U.UserId IN (
    SELECT UserId
    FROM Transactions
    WHERE TransactionType = 'Withdrawal'
	group by UserId
	having count(*)=1
)
ORDER BY U.UserName;


--  Query #3 List 3 Users That Have Made The Highest Deposits

SELECT TOP 3 U.UserId, U.UserName, Concat (SUM(T.TransactionAmount), ' €') AS TotalDeposits
FROM Users U
JOIN Transactions T ON U.UserId = T.UserId
WHERE T.TransactionType = 'Deposit'
GROUP BY U.UserId, U.UserName
ORDER BY TotalDeposits DESC;


--  Query #4 List all deposits for users. Display UserId, UserName, DepositDate, DepositAmount

SELECT U.UserId, U.UserName, T.TransactionDate AS DepositDate, Concat (T.TransactionAmount, ' €') AS DepositAmount
FROM Users U
JOIN Transactions T ON U.UserId = T.UserId
WHERE T.TransactionType = 'Deposit'
ORDER BY U.UserName;

--  Query #5 Calculate balances of all users

SELECT U.UserId, U.UserName,
   Concat (SUM(CASE WHEN T.TransactionType = 'Deposit' THEN T.TransactionAmount ELSE -T.TransactionAmount END), ' €') AS Balance
FROM Users U
LEFT JOIN Transactions T ON U.UserId = T.UserId
GROUP BY U.UserId, U.UserName
ORDER BY SUM(CASE WHEN T.TransactionType = 'Deposit' THEN T.TransactionAmount ELSE -T.TransactionAmount END) DESC;



