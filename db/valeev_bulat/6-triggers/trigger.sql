CREATE OR REPLACE FUNCTION abonement_balance_change() RETURNS TRIGGER AS
$$
BEGIN
IF (TG_OP='INSERT') THEN
UPDATE abonement SET abonement = abonement - visit_hour(NEW.id)
WHERE id = NEW.abonement_id;
END IF;
IF (TG_OP='DELETE') THEN
UPDATE abonement SET abonement = abonement + visit_hour(NEW.id)
WHERE id = NEW.abonement_id;
END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

REATE TRIGGER visits_count
AFTER INSERT OR DELETE ON visits
FOR EACH ROW
EXECUTE PROCEDURE abonement_balance_change();