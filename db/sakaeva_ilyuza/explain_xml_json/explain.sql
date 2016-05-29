explain analyze select cinemas.name from cinemas 
 join distributions d on cinemas.id=d.cinema_id and date_part('year', started) <= 2000 and date_part('year', finished) >= 2000
 join films on films.id=d.film_id and origin = 'foreign'
 except select cinemas.name from cinemas 
 join distributions d on cinemas.id=d.cinema_id and date_part('year', started) <= 2000 and date_part('year', finished) >= 2000
 join films on films.id=d.film_id and origin = 'local'
 
 "HashSetOp Except  (cost=17.51..56.67 rows=1 width=32) (actual time=0.943..0.946 rows=2 loops=1)"
"  ->  Append  (cost=17.51..56.67 rows=2 width=32) (actual time=0.537..0.903 rows=6 loops=1)"
"        ->  Subquery Scan on "*SELECT* 1"  (cost=17.51..28.33 rows=1 width=32) (actual time=0.534..0.759 rows=5 loops=1)"
"              ->  Nested Loop  (cost=17.51..28.32 rows=1 width=32) (actual time=0.529..0.738 rows=5 loops=1)"
"                    ->  Nested Loop  (cost=17.38..28.07 rows=1 width=4) (actual time=0.393..0.534 rows=5 loops=1)"
"                          ->  Seq Scan on films  (cost=0.00..1.13 rows=1 width=4) (actual time=0.015..0.036 rows=8 loops=1)"
"                                Filter: (origin = 'foreign'::original)"
"                                Rows Removed by Filter: 2"
"                          ->  Bitmap Heap Scan on distributions d  (cost=17.38..26.94 rows=1 width=8) (actual time=0.040..0.042 rows=1 loops=8)"
"                                Recheck Cond: (film_id = films.id)"
"                                Filter: ((date_part('year'::text, (started)::timestamp without time zone) <= 2000::double precision) AND (date_part('year'::text, (finished)::timestamp without time zone) >= 2000::double precision))"
"                                Rows Removed by Filter: 0"
"                                Heap Blocks: exact=6"
"                                ->  Bitmap Index Scan on distributions_cinema_id_film_id_key  (cost=0.00..17.38 rows=6 width=0) (actual time=0.009..0.009 rows=1 loops=8)"
"                                      Index Cond: (film_id = films.id)"
"                    ->  Index Scan using id on cinemas  (cost=0.14..0.24 rows=1 width=36) (actual time=0.031..0.033 rows=1 loops=5)"
"                          Index Cond: (id = d.cinema_id)"
"        ->  Subquery Scan on "*SELECT* 2"  (cost=17.51..28.33 rows=1 width=32) (actual time=0.104..0.121 rows=1 loops=1)"
"              ->  Nested Loop  (cost=17.51..28.32 rows=1 width=32) (actual time=0.101..0.115 rows=1 loops=1)"
"                    ->  Nested Loop  (cost=17.38..28.07 rows=1 width=4) (actual time=0.089..0.097 rows=1 loops=1)"
"                          ->  Seq Scan on films films_1  (cost=0.00..1.13 rows=1 width=4) (actual time=0.008..0.014 rows=2 loops=1)"
"                                Filter: (origin = 'local'::original)"
"                                Rows Removed by Filter: 8"
"                          ->  Bitmap Heap Scan on distributions d_1  (cost=17.38..26.94 rows=1 width=8) (actual time=0.021..0.022 rows=1 loops=2)"
"                                Recheck Cond: (film_id = films_1.id)"
"                                Filter: ((date_part('year'::text, (started)::timestamp without time zone) <= 2000::double precision) AND (date_part('year'::text, (finished)::timestamp without time zone) >= 2000::double precision))"
"                                Rows Removed by Filter: 1"
"                                Heap Blocks: exact=2"
"                                ->  Bitmap Index Scan on distributions_cinema_id_film_id_key  (cost=0.00..17.38 rows=6 width=0) (actual time=0.008..0.008 rows=1 loops=2)"
"                                      Index Cond: (film_id = films_1.id)"
"                    ->  Index Scan using id on cinemas cinemas_1  (cost=0.14..0.24 rows=1 width=36) (actual time=0.006..0.008 rows=1 loops=1)"


 