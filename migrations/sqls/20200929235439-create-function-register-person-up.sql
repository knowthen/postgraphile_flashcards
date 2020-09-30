CREATE FUNCTION learn.register_person (first_name text, last_name text, email
  text, password text)
  RETURNS learn.person
  AS $$
DECLARE
  person learn.person;
BEGIN
  INSERT INTO learn.person (first_name, last_name)
    VALUES (first_name, last_name)
  RETURNING
    * INTO person;
  INSERT INTO learn_private.person_account (person_id, email, password_hash)
    VALUES (person.id, email, crypt(password, gen_salt('bf')));
  RETURN person;
END;
$$
LANGUAGE plpgsql
STRICT
SECURITY DEFINER;