create or replace TRIGGER w_di_trigger BEFORE DELETE OR INSERT ON workers FOR EACH ROW
BEGIN 
    IF :old.id IS NULL THEN 
        INSERT INTO changes VALUES(seq_changes.NEXTVAL, 'Inserted',:new.id, new.name, new.salary,sysdate);
    ELSE 
         INSERT INTO changes VALUES(seq_changes.NEXTVAL, 'deleted',:old.id, old.name, old.salary,sysdate);
    END IF;
END;