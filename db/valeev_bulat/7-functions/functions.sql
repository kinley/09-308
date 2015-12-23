CREATE FUNCTION avg_visit_abonement(a_id INT)
  RETURNS TABLE(avg_visits INTERVAL) AS $$
SELECT AVG(v.visit_to - v.visit_from)
FROM visits v
  WHERE v.abonement_id = a_id LIMIT 1;
$$ LANGUAGE SQL;


CREATE FUNCTION visit_hour(v_id INT)
  RETURNS TABLE(visit_hour INT) AS $$
SELECT CAST(ceil(EXTRACT(EPOCH FROM v.visit_to-v.visit_from)/3600) as INT) visit_hour 
FROM abonements a, visits v 
WHERE v.abonement_id = a.id AND v.id = v_id;
$$ LANGUAGE SQL;
