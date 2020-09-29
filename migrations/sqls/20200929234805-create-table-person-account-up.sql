CREATE TABLE learn_private.person_account (
  person_id integer PRIMARY KEY REFERENCES learn.person (id) ON DELETE CASCADE,
  email text NOT NULL UNIQUE CHECK (email ~* '^.+@.+\..+$'),
  password_hash text NOT NULL
);

CREATE INDEX person_account_email_idx ON learn_private.person_account (email);