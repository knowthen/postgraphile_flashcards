CREATE FUNCTION learn.authenticate (email text, password text)
  RETURNS learn.jwt
  AS $$
DECLARE
  account learn_private.person_account;
BEGIN
  SELECT
    * INTO account
  FROM
    learn_private.person_account
  WHERE
    person_account.email = authenticate.email;
  IF account.password_hash = crypt(password, account.password_hash) THEN
    RETURN ('learn_person',
      account.person_id,
      extract(epoch FROM (now() + interval '30 days')))::learn.jwt;
  ELSE
    RETURN NULL;
  END IF;
END;
$$
LANGUAGE plpgsql
STRICT
SECURITY DEFINER;