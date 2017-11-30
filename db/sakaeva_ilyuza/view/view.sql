
-- DROP VIEW distributions_view
CREATE VIEW distributions_view AS
  SELECT
    d.id,
    c.name               AS cinema_name,
    f.name               AS film_name,
    started,
    finished,
    seat_first_category_price,
    seat_second_category_price,
    seat_third_category_price,
    fee,
    (finished - started) AS duration
  FROM
    distributions d
    JOIN cinemas c ON d.cinema_id = c.id
    JOIN films f ON d.film_id = f.id;
