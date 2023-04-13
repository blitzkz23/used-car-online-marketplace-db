-- City
COPY city (
  city_id,
  city_name,
  latitude,
  longitude
)
FROM 'local/city.csv'
DELIMITER ','
CSV HEADER