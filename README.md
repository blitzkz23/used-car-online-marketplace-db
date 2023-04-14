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
    - Car brand: Toyota, Daihatsu, Honda, etc
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
| car_product | Store detailed information about car that user want to sell |
| brand | Store information about product's brand name |
| model | Store information about product's model name |
| body_type | Store information about product's body tipe name |

## ER Diagram

After deciding required tables, we can create ER diagram that contain all of those table, relationship between them, field for each table, and primary-foreign key that are needed for this database.

![](doc/erd/used-car-marketplace.png)

## Establishing Business Rule

1. Table: user

    Business Rule:
    - All field can't be null
    - The relationship between city are mandatory to mandatory as user required to fill their data domicile included, and the data in city table can be deleted only if there are no related data in the user table

2. Table: city

    Business Rule:
    - All field can't be null

3. Table: advertisement

    Business Rule:
    - Desc and updated_at field can be null
    - The relationship between user are mandatory to optional as there are user is only looking or buying and don't put ads.  When user delete their account, respective field on this table are set to null (meaning the ads will still exist)
    - The relationship between car_product are mandatory to mandatory as product only exist becase its shown on the ads.  The data on the product can be deleted and the respective advertisement will be deleted as well

4. Table: bid

    Business Rule:
    - All field can't be null
    - Bid status value mus be in: Sent or Cancelled
    - The relationship between user are mandatory to optional as there are user who don't bid.  The data on the USER can be deleted and the respective BID will be deleted as well
    - The relationship between advertisement are optional to mandatory as there is ads that don't allow bid.  When an advertisement is deleted, respective data on this table will be deleted as well

5. Table: car_product

    Business Rule:
    - Color, and mileage can be null
    - Price must be > 0
    - Year must be > 1900
    - The relationship between brand, model, and body type are mandatory to mandatory, and the data in those table can be deleted only if there are no related data in the car_product table

6. Table: brand

    Business Rule:
    - All field can't be null

7. Table: model

    Business Rule:
    - All field can't be null

8. Table: body_type

    Business Rule:
    - All field can't be null

## Transactional Query Example

1. Find car with release date of 2015 and above

    ```
    SELECT 
        car_product_id,
        brand_name,
        model_name,
        year,
        price
    FROM car_product as cp
    JOIN brand as b
        ON b.brand_id = cp.brand_id
    JOIN model as m
        ON m.model_id = cp.model_id
    WHERE
        year >= 2015
    ```

    Output:

    ![](doc/trx_output/1.png)

2. Input new bid record

    ```
    # In case the query didn't immediately work because the table have been inserted with dummy data previously
    SELECT setval(pg_get_serial_sequence('bid', 'bid_id'), coalesce(max(bid_id),0)+1, false) FROM bid;


    INSERT INTO bid(user_id, advertisement_id , bid_date, bid_price, bid_status)
    VALUES(96, 69, '2023-04-10 17:09:05.000', 230000000, 'Sent');
    ```

    Output:

    Output:

    Before:

    ![](doc/trx_output/2-before.png)

    After:

    ![](doc/trx_output/2-after.png)

3. See cars that are sold by Opung Sihotang by newest date

    ```
    SELECT 
        cp.car_product_id,
        brand_name,
        model_name,
        year,
        price,
        created_at,
        concat(first_name, ' ', last_name) AS seller_name 
    FROM advertisement a  
    JOIN car_product cp 
        ON a.car_product_id = cp.car_product_id 
    JOIN "user" u 
        ON a.user_id = u.user_id 
    JOIN brand b 
        ON b.brand_id = cp.brand_id 
    JOIN model m 
        ON m.model_id = cp.model_id 
    WHERE first_name = 'Opung' AND last_name = 'Sihotang'
    ORDER BY created_at DESC
    ```

    Output:

    ![](doc/trx_output/3.png)

4. See cars with 'Yaris' model sort by cheapest

    ```
    SELECT 
        cp.car_product_id,
        brand_name,
        model_name,
        year,
        price
    FROM advertisement a 
    JOIN car_product cp 
        ON cp.car_product_id = a.car_product_id 
    JOIN brand b 
        ON b.brand_id  = cp.brand_id 
    JOIN model m 
        ON m.model_id  = cp.model_id
    WHERE model_name = 'Toyota Yaris'
    ORDER BY price ASC;
    ```

    Output:

    ![](doc/trx_output/4.png)

5. Looking for the nearest used car based on a city id 3173, the shortest distance is calculated based on latitude longitude. Distance calculations can be calculated using the euclidean distance formula based on latitude and longitude.
    
    ```
    -- Create euclidean distance fun
    CREATE OR REPLACE FUNCTION euclidean_distance(lat1 double precision, lon1 double precision, lat2 double precision, lon2 double precision)
    RETURNS double precision
    AS $$
    BEGIN
    RETURN sqrt((lat1 - lat2) ^ 2 + (lon1 - lon2) ^ 2);
    END;
    $$ LANGUAGE plpgsql;

    -- Where city id 3171(-6.186486, 106.834091)
    SELECT 
        cp.car_product_id,
        brand_name,
        model_name,
        year,
        price,
        city_name,
        euclidean_distance(c.latitude, c.longitude, -6.186486, 106.834091) as distance
    FROM advertisement a 
    JOIN car_product cp 
        ON cp.car_product_id = a.car_product_id 
    JOIN brand b 
        ON b.brand_id  = cp.brand_id 
    JOIN model m 
        ON m.model_id  = cp.model_id
    JOIN "user" u 
        ON u.user_id = a.user_id 
    JOIN city c 
        ON c.city_id = u.city_id
    WHERE euclidean_distance(c.latitude, c.longitude, -6.186486, 106.834091) = 0;
    ```

    Output:

    ![](doc/trx_output/3.png)