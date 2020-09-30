ALTER DEFAULT privileges GRANT EXECUTE ON functions TO public;

REVOKE usage ON SCHEMA learn FROM learn_anonymous, learn_person;

REVOKE EXECUTE ON FUNCTION learn.authenticate (text, text) FROM learn_anonymous, learn_person;
REVOKE EXECUTE ON FUNCTION learn.register_person (text, text, text, text) FROM learn_anonymous;
REVOKE EXECUTE ON FUNCTION learn.handle_score (integer, integer) FROM learn_person;

REVOKE ALL privileges ON TABLE learn.person FROM learn_person;
REVOKE SELECT, DELETE ON TABLE learn.card FROM learn_person;
REVOKE INSERT, UPDATE (id, question, answer, archived) ON TABLE learn.card FROM learn_person;
REVOKE usage ON SEQUENCE learn.card_id_seq FROM learn_person;
REVOKE SELECT ON TABLE learn.response FROM learn_person;
REVOKE SELECT ON learn.next_card FROM learn_person;
