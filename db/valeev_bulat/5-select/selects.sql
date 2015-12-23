/* 1 */

SELECT c.full_name, SUM(v.visit_to - v.visit_from) sum_visits 
FROM clients c, abonements a, visits v
WHERE c.id = a.client_id 
GROUP BY c.full_name 
ORDER BY sum_visits 
LIMIT 1;

/* 2 */

SELECT c.full_name, a.id, avg_visit_abonement(a.id) 
FROM clients c, abonements a 
WHERE c.id = a.client_id ;

/* 3 */ 

SELECT c.full_name, a.id, ceil(EXTRACT(EPOCH FROM v.visit_to-v.visit_from)/3600) visit_hour
 FROM clients c, abonements a, visits v
 WHERE c.id = a.client_id 
 AND v.abonement_id = a.id;