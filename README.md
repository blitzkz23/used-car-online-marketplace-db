# Used Car Online Marketplace Database
PostgreSQL Database design and implementation for Used Car Online Marketplace.

## Mission Statement
A stakeholder is interested in developing an Online Marketplace that would enable individuals to advertise their cars for sale while allowing potential buyers to search and filter listings based on common features like brand, model, year, etc. Users should also be able to bid on prices if the seller permits this feature. 

As a database designer, your task is to create a relational database that can efficiently store and manage the seller, car, buyer, and related data.

## Feature Constraint
For more details, here are the features and limitations of this project:
1. Each application user can offer more than one used car product.
2. Before selling a car product, the user must first complete his personal data, such as name, contact, and location domicile.
3. Users offer their products through advertisements that will be displayed on the website.
4. This ad contains a title, detailed product information offered, and seller contact.
5. Some of the information that must be written in the ad is as follows
    - car brand: Toyota, Daihatsu, Honda, etc
    - Model: Toyota Camry, Toyota Corolla Altis, Toyota Vios,Toyota Camry Hybrid, etc
    - Car body type: MPV, SUV, Van, Sedan, Hatchback, etc
    - Car type: manual or automatic
    - Car manufacture year: 2005, 2010, 2011, 2020
    Other descriptions, such as color, distance traveled, etc., may be added as needed.
6. Each user can search for the cars offered based on the location of the seller user, the car brand, and the type of car body.
7. If a potential buyer is interested in a car, he can bid on the price of the product if the seller allows the bidding feature.
8. Purchase transactions are made outside the application so they are not within the scope of the project

## Table Structures

In order to design our database, first let's determine what tables are required in this database.


| Table Name | Description | 
| --- | --- | 
| user | Store general information of the user |
| city | Store more detailed information of user's city address |
| advertisement | Store information about product that user want to sell |
| bid | Store information about user who bid on certain advertisement |
| car_product | Store information about project accepted by PacProjects |
| brand | Store information about product's brand name |
| model | Store information about product's model name |
| body_type | Store information about product's body tipe name |

## ER Diagram

After deciding required tables, we can create ER diagram that contain all of those table, relationship between them, field for each table, and primary-foreign key that are needed for this database.

![](erd/used-car-marketplace.png)

## Establishing Business Rule

| User | City | Product | 
| --- | --- | --- |
| This table is used to store user's information | This table is used to store user's city information | This table is used to store detail of product |
| id | id | brand |
| first_name | city_name | model |
| last_name | latitude | body_type |
| phone | longitude | year |
| city_id |  | price |