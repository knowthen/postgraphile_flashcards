CREATE TABLE learn.response (
  id serial PRIMARY KEY,
  score integer NOT NULL CHECK (score >= 0 AND score <= 3),
  review_after timestamptz NOT NULL,
  spacing integer NOT NULL CHECK (spacing >= 0),
  ease_factor numeric(7, 4) NOT NULL CHECK (ease_factor >= 1.3),
  card_id integer NOT NULL REFERENCES learn.card (id),
  person_id integer NOT NULL REFERENCES learn.person (id),
  created_at timestamptz DEFAULT now()
);

CREATE INDEX response_card_id_idx ON learn.response (card_id);
CREATE INDEX response_person_id_idx ON learn.response (person_id);

COMMENT ON TABLE learn.response IS '@omit create,update,delete
An individual graded response to a flash card';
COMMENT ON COLUMN learn.response.id IS 'The primary unique identifier for the flash card response.';
COMMENT ON COLUMN learn.response.score IS 'An value indicating how well the answer was rememebered. Range from 0-3, where 0=could not recall answer, 3=perfect recall';
COMMENT ON COLUMN learn.response.review_after IS 'The calculated next review time.';
COMMENT ON COLUMN learn.response.spacing IS 'The number of days until next review';
COMMENT ON COLUMN learn.response.ease_factor IS 'A factor indicating how easy/hard the card is';
COMMENT ON COLUMN learn.response.card_id IS 'The card that this response is for';
COMMENT ON COLUMN learn.response.person_id IS 'The user who made the response';
COMMENT ON COLUMN learn.response.created_at IS 'The time this response was created';