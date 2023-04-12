-- Used Car Marketplace Db

CREATE TABLE city(
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(60) NOT NULL,
    latitude NUMERIC(10, 8) NOT NULL,
    longitude NUMERIC(10, 8) NOT NULL
);

CREATE TABLE user(
    user_id SERIAL PRIMARY KEY,
    city_id INTEGER NOT NULL,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(80) NOT NULL,
    UNIQUE(first_name, last_name),
    CONSTRAINT fk_user_city
        FOREIGN KEY(city_id)
        REFERENCES city(city_id)
        ON DELETE NO ACTION
);

CREATE TABLE brand(
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(60)
);

CREATE TABLE model(
    model_id SERIAL PRIMARY KEY,
    model_name VARCHAR(60)
);

CREATE TABLE body_type(
    body_type_id SERIAL PRIMARY KEY,
    boty_type_name VARCHAR(60)
);

CREATE TABLE car_product(
    car_product_id SERIAL PRIMARY KEY,
    brand_id INTEGER NOT NULL,
    model_id INTEGER NOT NULL,
    body_type_id INTEGER NOT NULL,
    year INTEGER NOT NULL,
    price INTEGER NOT NULL,
    color VARCHAR(60),
    mileage INTEGER
    CONSTRAINT fk_car_brand
        FOREIGN KEY(brand_id)
        REFERENCES brand(brand_id)
        ON DELETE NO ACTION,
    CONSTRAINT fk_car_model
        FOREIGN KEY(model_id)
        REFERENCES model(model_id)
        ON DELETE NO ACTION,
    CONSTRAINT fk_car_body_type
        FOREIGN KEY(body_type_id)
        REFERENCES body_type(body_type_id)
        ON DELETE NO ACTION
);

CREATE TABLE advertisement(
    advertisement_id SERIAL PRIMARY KEY,
    car_product_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    title VARCHAR(100) NOT NULL,
    desc TEXT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    is_active BOOLEAN NOT NULL,
    is_bid_allowed BOLLEAN NOT NULL,
    CONSTRAINT fk_advertised_product
        FOREIGN KEY(car_product_id)
        REFERENCES car_product(car_product_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_advertisement_owner
        FOREIGN KEY(user_id)
        REFERENCES user(user_id)
        ON DELETE SET NULL
);

CREATE TABLE bid(
    bid_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    advertisement_id INTEGER NOT NULL,
    bid_date DATETIME NOT NULL,
    bid_price INTEGER NOT NULL,
    bid_status VARCHAR(20),
    CONSTRAINT fk_bidding_user
        FOREIGN KEY(user_id)
        REFERENCES user(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_bid_on_advertisement
        FOREIGN KEY(advertisement_id),
        REFERENCES advertisement(advertisement_id),
        CHECK (advertisement.is_allow_bid = true),
        ON DELETE CASCADE
);