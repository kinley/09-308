-- Для заданного кинотеатра выдать список фильмов отечественного производства,
-- которые когда-либо шли в этом кинотеатре
-- SELECT * FROM local_films_in_cinema("Родина");
CREATE OR REPLACE FUNCTION local_films_in_cinema(cinema_name_in VARCHAR)
  RETURNS TABLE(name VARCHAR) AS $$
SELECT films.name
FROM films
  JOIN distributions ON films.id = film_id
  JOIN cinemas ON cinemas.id = distributions.cinema_id AND cinemas.name = cinema_name_in AND origin = 'local';
$$ LANGUAGE SQL;

-- Выдать список кинотеатров, в которых в 2000 году шли только зарубежные фильмы.
CREATE FUNCTION cinemas_with_foreign_films_in_2000()
  RETURNS TABLE(name VARCHAR) AS $$
SELECT cinemas.name
FROM cinemas
  JOIN distributions
    ON cinemas.id = cinema_id AND date_part('year', started) <= 2000 AND date_part('year', finished) >= 2000
  JOIN films ON films.id = film_id AND origin = 'foreign'
EXCEPT
SELECT cinemas.name
FROM cinemas
  JOIN distributions
    ON cinemas.id = cinema_id AND date_part('year', started) <= 2000 AND date_part('year', finished) >= 2000
  JOIN films ON films.id = film_id AND origin = 'local'
$$ LANGUAGE SQL;

-- Для каждого кинотеатра подсчитать сумму реального сбора с проката фильмов за апрель 2000 года.
-- вызов SELECT * FROM fee_for_cinemas_for_april_2000()
CREATE FUNCTION fee_for_cinemas_for_april_2000()
  RETURNS TABLE(name VARCHAR, fee BIGINT) AS $$
SELECT
  -- COALESCE returns the first not NULL argument
  cinemas.name, sum(COALESCE(fee, 0)) AS fee
FROM cinemas
  LEFT JOIN distributions ON cinemas.id = cinema_id
WHERE (started <= '2000-04-30' AND finished >= '2000-04-01') OR started IS NULL
GROUP BY cinemas.id;
$$ LANGUAGE SQL;

-- процедура обновления данных в films.cinema_count
CREATE FUNCTION correct_cinema_count()
  RETURNS TRIGGER AS $$
DECLARE
  new_cinema_count INT;
  old_cinema_count INT;

BEGIN
  IF TG_OP = 'INSERT' THEN
    -- получаем данные нового фильма
    new_cinema_count := (SELECT count(*)
                         FROM distributions
                         WHERE film_id = NEW.film_id);

    -- обновляем данные для фильма
    UPDATE films
    SET cinema_count = new_cinema_count
    WHERE id = NEW.film_id;

    RETURN NEW;

  ELSEIF TG_OP = 'UPDATE' THEN
    -- получаем данные нового фильма
    new_cinema_count := (SELECT count(*)
                         FROM distributions
                         WHERE film_id = NEW.film_id);

    -- получаем данные старого фильма
    old_cinema_count := (SELECT count(*)
                         FROM distributions
                         WHERE film_id = OLD.film_id);

    -- обновляем данные нового фильма
    UPDATE films
    SET cinema_count = new_cinema_count
    WHERE id = NEW.film_id;

    -- обновляем данные старого фильма
    UPDATE films
    SET cinema_count = old_cinema_count
    WHERE id = OLD.film_id;

    RETURN NEW;

  ELSEIF TG_OP = 'DELETE' THEN
    -- получаем данные старого фильма
    old_cinema_count := (SELECT count(*)
                         FROM distributions
                         WHERE film_id = OLD.film_id);

    -- обновляем данные старого фильма
    UPDATE films
    SET cinema_count = old_cinema_count
    WHERE id = OLD.film_id;

    RETURN OLD;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- триггер на добавление/удаление/обновление в distributions.film_id
-- для films.cinema_count
CREATE TRIGGER check_cinema_count
AFTER INSERT OR UPDATE OR DELETE ON distributions
FOR EACH ROW
EXECUTE PROCEDURE correct_cinema_count();
