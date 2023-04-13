-- City
COPY city (
  city_id,
  city_name,
  latitude,
  longitude
)
FROM 'local\dummy-data\city.csv'
DELIMITER ','
CSV HEADER

-- User
COPY "user"(
  user_id,
  city_id,
  first_name,
  last_name,
  phone,
  email,
  password
)
FROM 'local\dummy-data\user.csv'
DELIMITER ','
CSV HEADER

-- Model
COPY model(
  model_id,
  model_name
)
FROM 'local\dummy-data\model.csv'
DELIMITER ','
CSV HEADER

-- Brand
COPY brand(
  brand_id,
  brand_name
)
FROM 'local\dummy-data\brand.csv'
DELIMITER ','
CSV HEADER

-- Body type
COPY body_type(
  body_type_id,
  body_type_name
)
FROM 'local\dummy-data\body_type.csv'
DELIMITER ','
CSV HEADER

-- Car product
COPY car_product(
  car_product_id,
  brand_id,
  model_id,
  body_type_id,
  year,
  price,
  color,
  mileage
)
FROM 'local\dummy-data\car_product.csv'
DELIMITER ','
CSV HEADER

-- Advertisement
COPY advertisement(
  advertisement_id,
  car_product_id,
  user_id,
  title,
  "desc",
  created_at,
  updated_at,
  is_active,
  is_bid_allowed
)
FROM 'local\dummy-data\advertisement.csv'
DELIMITER ','
CSV HEADER

-- Bid
COPY bid(
  bid_id,
  user_id,
  advertisement_id,
  bid_date,
  bid_price,
  bid_status
)
FROM 'local\dummy-data\bid.csv'
DELIMITER ','
CSV HEADER