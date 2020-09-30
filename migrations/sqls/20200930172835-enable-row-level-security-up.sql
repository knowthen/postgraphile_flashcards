ALTER TABLE learn.card enable ROW level SECURITY;

CREATE POLICY select_card ON learn.card FOR SELECT TO learn_person USING
  (person_id = nullif (current_setting('jwt.claims.person_id', TRUE),
  '')::integer);

CREATE POLICY update_card ON learn.card FOR UPDATE TO learn_person USING
  (person_id = nullif (current_setting('jwt.claims.person_id', TRUE),
  '')::integer);

CREATE POLICY delete_card ON learn.card FOR DELETE TO learn_person USING
  (person_id = nullif (current_setting('jwt.claims.person_id', TRUE),
  '')::integer);

CREATE POLICY insert_card ON learn.card FOR INSERT TO learn_person WITH CHECK
  (person_id = nullif (current_setting('jwt.claims.person_id', TRUE),
  '')::integer);