## Tools used for this exercise:

**SQL Server 2019**

**MySQL Workbench**

**phpMyAdmin**

**MySQL Database hosted on: freedb.tech**

## Intro

This Repository includes two SQL files to be taken up for consideration

In this README I will go step by step explaining my reasoning behind the included code, I won't include all the code as this can be repetitive but I will include new constraints that can be explained. 

First, we will explain "Diego Trejos - Fast Track Technical Test.sql" Please note that this file was created in SQL Server 2019, you can run the file as is in that environment in an already created test database, this will create the mentioned tables, insert dummy data and create the necessary queries mentioned in the test

Alternatively, we can run this in an online compiler such as **onecompiler.com**, Just make sure it is run in the correct database language this being SQL Server 

*drop table if exists Transactions;*

*drop table if exists Users;*

The first part of the file calls the drop function which tells the database that If the table exists, delete it. I implemented it just so I can run any new modifications to the script without creating a "table already exist error" This is just for testing purposes.

-- Create Users Table

*CREATE TABLE Users (*

  *UserId INT PRIMARY KEY IDENTITY(1,1),*
    
  *UserName VARCHAR(50) UNIQUE NOT NULL,*
    
  *Password VARCHAR(50) NOT NULL*
    

So here we are telling the program to create a table with 3 columns, *UserID* with a data type on *INT* which means it stores integer values or whole numbers, *PRIMARY KEY* means that this will serve as a unique identifier. *(1,1)* means that the value in this column will be auto-generated and incremented by one, for example when Diego signs up and is the first one to do so, he will be assigned the number 1, when Arturo signs up he will be assigned the number 2

The next column we call *UserName* assign a *VARCHAR* datatype with a length of 50 characters, assign it a UNIQUE constrain as no two persons can have the same username in our platform and we also assign it the *NOT NULL* so the value can not be NULL meaning every user has to have a username.

Password column does not introduce anything new to explain

Next up when we create the *Transactions* table we have the following code:

   *TransactionType VARCHAR(10) NOT NULL CHECK (TransactionType IN ('Deposit', 'Withdrawal')),*
   
   *TransactionAmount DECIMAL(10, 2) NOT NULL,*
   
   *TransactionDate DATETIME NOT NULL,*
   
   *FOREIGN KEY (UserId) REFERENCES Users(UserId)*

In this part of the SQL code I included the *CHECK* Constrain applied to the *TransactionType* column to ensure that the values in this column are either *'Deposit', or 'Withdrawal'* to maintain data integrity

The *DECIMAL* constrain means that the values in this column will store decimal numbers the *(10, 2)* part means of up to 10 digits where 2 digits are reserved for the fractional part.

Next up we see the newly introduced *DATETIME* which means that the column will store date and time values.

At the end of this snippet we have *FOREIGN KEY (UserId)* and *REFERENCES Users(UserId)* this is very important as this establishes a relationship between the *Users* table and the *Transactions* table, specifically it refers to the UserId column in the Users table. This will help us link which transaction belongs to which user.

The next part of the code introduces dummy data to our created tables so we can start creating the queries. these are pretty straightforward as they use the *INSERT INTO* function.

For the queries, I will provide a quick summary of what each query does as a more thorough explanation can be given on a call  



## --  Query #1 List All Users Having 3 Deposits Or More

*SELECT U.UserId, U.UserName*

*FROM Users U*

*JOIN (*

   *SELECT UserId*
   
   *FROM Transactions*
   
   *WHERE TransactionType = 'Deposit'*
   
   *GROUP BY UserId*
   
   *HAVING COUNT(*) >= 3*
   
*) AS Deposits*

*ON U.UserId = Deposits.UserId*

*ORDER BY U.UserName;*

This query identifies users who have made 3 or more deposits. It does so by counting the number of deposits each user has made in the *Transactions* table and then joining this information with the *Users* table to retrieve the corresponding user IDs and names. Finally, it orders the results alphabetically by user name.



## --  Query #2 List All Users Having Only 1 Withdrawal

*SELECT U.UserId, U.UserName*

*FROM Users U*

*WHERE U.UserId IN (*

   *SELECT UserId*
   
   *FROM Transactions*
   
   *WHERE TransactionType = 'Withdrawal'*
   
*group by UserId*

*having count(*)=1*
*)*

*ORDER BY U.UserName;*

This query retrieves users who have made only one withdrawal. It first identifies user IDs with exactly one withdrawal from the *Transactions* table and then selects the corresponding user IDs and names from the *Users* table, ordering the results alphabetically by user name.



## --  Query #3 List 3 Users That Have Made The Highest Deposits

*SELECT TOP 3 U.UserId, U.UserName, Concat (SUM(T.TransactionAmount), ' €') AS TotalDeposits*

*FROM Users U*

*JOIN Transactions T ON U.UserId = T.UserId*

*WHERE T.TransactionType = 'Deposit'*

*GROUP BY U.UserId, U.UserName*

*ORDER BY TotalDeposits DESC;*

This query identifies the top 3 users who have made the highest deposits. It joins the *Users* table with the *Transactions* table, filters for deposit transactions, groups the data by user, calculates the total deposits for each user and then selects the top 3 users based on their total deposits.



## --  Query #4 List all deposits for users. Display UserId, UserName, DepositDate, DepositAmount

*SELECT U.UserId, U.UserName, T.TransactionDate AS DepositDate, Concat (T.TransactionAmount, ' €') AS DepositAmount*

*FROM Users U*

*JOIN Transactions T ON U.UserId = T.UserId*

*WHERE T.TransactionType = 'Deposit'*

*ORDER BY U.UserName;*

This query retrieves all deposit transactions for users. It joins the *Users* table with the *Transactions table*, filters for deposit transactions, selects the user ID, user name, deposit date, and deposit amount, and finally orders the results alphabetically by user name.



## --  Query #5 Calculate balances of all users

*SELECT U.UserId, U.UserName,*

   *Concat (SUM(CASE WHEN T.TransactionType = 'Deposit' THEN T.TransactionAmount ELSE -T.TransactionAmount END), ' €') AS Balance*
   
*FROM Users U*

*LEFT JOIN Transactions T ON U.UserId = T.UserId*

*GROUP BY U.UserId, U.UserName*

*ORDER BY SUM(CASE WHEN T.TransactionType = 'Deposit' THEN T.TransactionAmount ELSE -T.TransactionAmount END) DESC;*

Finally, in summary, this query calculates the balance for each user by summing their deposit amounts and subtracting their withdrawal amounts. It includes all users, even those with no transactions, and orders the results by balance in descending order.


## Second Part

For the second part of this exercise, I replicated the database I created in SQL Server to a hosted MySQL database. To check this database please connect to it via MySQL Workbench using the following parameters and credentials.

Username: freedb_testuser

Password: RMt@QmWfz5NF6%v

![image](https://github.com/diexban/SQL-Test-FT/assets/166546790/96d7d695-793a-466f-b87e-0df451fb2c61)

The creation code for this database is more or less the same as the one used for SQL Server, there are a few syntax differences between programs.

As the queries would have been mostly the same, for this database I created those queries as views:

![image](https://github.com/diexban/SQL-Test-FT/assets/166546790/2b010e87-3fd2-4677-9f6a-b053ec04ee6d)

So to get the results of the created views please run the attached SQL Script in Workbench, it should look something like this.

*SELECT * FROM Users_With_Three_or_More_Deposits;*

*SELECT * FROM Users_With_One_Withdrawal;*

*SELECT * FROM Top_3_Users_Highest_Deposits;*

*SELECT * FROM All_Deposits_For_Users;*

*SELECT * FROM User_Balances;*

Please also make sure you have the *Schema: freedb_Work_Test_Project_FT* selected

Your screen should look similar to this as a result:

![image](https://github.com/diexban/SQL-Test-FT/assets/166546790/21ac8f0f-f7f7-469b-98e2-0cda89f39b90)


