This Repository includes two SQL files to be taken up for consideration

In this README I will go step by step explaining my reasoning behind the included code, I won't include all the code as this can be repetitive but I will include new constrains that can be explained. 

First, we will explain "Diego Trejos - Fast Track Technical Test.sql" Please note that this file was created in SQL Server 2019, you can run the file as is in that environment in an already created test database, this will create the mentioned tables, insert dummy data and create the necessary queries mentioned in the test

Alternatively, we can run this in an online compiler such as **onecompiler.com**, Just make sure it is run in the correct database language this being SQL Server 

*drop table if exists Transactions;*

*drop table if exists Users;*

The first part of the file calls the drop function which tells the database that If the table exists, delete it. I implemented it just so I can run any new modifications to the script without creating a "table already exist error" this is just for testing purposes.

-- Create Users Table

*CREATE TABLE Users (*

  *UserId INT PRIMARY KEY IDENTITY(1,1),*
    
  *UserName VARCHAR(50) UNIQUE NOT NULL,*
    
  *Password VARCHAR(50) NOT NULL*
    

So here we are telling the program to create a table with 3 columns, *UserID* with a data type on *INT* which means it stores integer values or whole numbers, *PRIMARY KEY* means that this will serve as a unique identifier. *(1,1)* means that the value in this column will be auto-generated and incremented by one, for example when Diego signs up and is the first one to do so, he will be assigned the number 1, when Arturo signs up he will be assigned the number 2

The next column we call *UserName* assign a *VARCHAR* datatype with a length of 50 characters, assign it a UNIQUE constrain as no two persons can have the same username in our platform and we also assign it the *NOT NULL* so the value can not be NULL meaning every user has to have a username.

Password column does not introduce anything new to explain
