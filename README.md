# Used Car Online Marketplace Database Design

## Mission Statement
A stakeholder is interested in developing an Online Marketplace that would enable individuals to advertise their cars for sale while allowing potential buyers to search and filter listings based on common features like brand, model, year, etc. Users should also be able to bid on prices if the seller permits this feature. 

As a database designer, your task is to create a relational database that can efficiently store and manage the seller, car, buyer, and related data.

## Table Structures

In order to design our database, first let's determine what tables and fields that we need also determine the key and relationships between each table.

| User | City | Product | 
| --- | --- | --- |
| This table is used to store user's information | This table is used to store user's city information | This table is used to store detail of product |
| id | id | brand |
| first_name | city_name | model |
| last_name | latitude | body_type |
| phone | longitude | year |
| city_id |  | price |
