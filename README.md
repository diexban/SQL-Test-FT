This Repository includes two SQL files to be taken up for consideration

In this README I will go step by step explaining my reasoning behind the included code

First, we will explain "Diego Trejos - Fast Track Technical Test.sql" Please note that this file was created in SQL Server 2019, you can run the file as is in that environment in an already created test database, this will create the mentioned tables, insert dummy data and create the necessary queries mentioned in the test

Alternatively, we can run this in an online compiler such as **onecompiler.com**, Just make sure it is run in the correct database language this being SQL Server 

*drop table if exists Transactions;

drop table if exists Users;*

The first part of the file calls the drop function which tells the database that If the table exists, delete it. I implemented it just so I can run any new modifications to the script without creating a "table already exist error" this is just for testing purposes


