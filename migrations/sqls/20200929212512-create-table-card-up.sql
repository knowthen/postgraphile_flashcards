CREATE TABLE learn.card (
  id serial PRIMARY KEY,
  question text NOT NULL,
  answer text NOT NULL,
  review_after timestamptz NOT NULL DEFAULT now(),
  spacing integer NOT NULL CHECK (spacing >= 0) DEFAULT 0,
  ease_factor numeric(7, 4) NOT NULL CHECK (ease_factor >= 1.3) DEFAULT 2.5,
  seq integer NOT NULL CHECK (seq >= 0) DEFAULT 0,
  archived boolean NOT NULL DEFAULT FALSE,
  person_id integer REFERENCES learn.person (id),
  created_at timestamptz DEFAULT now()
);

CREATE INDEX card_review_after_idx ON learn.card (review_after);
CREATE INDEX card_archived_idx ON learn.card (archived);
CREATE INDEX card_person_id_idx ON learn.card (person_id);

COMMENT ON TABLE learn.card IS 'An individual persons flash card';
COMMENT ON COLUMN learn.card.id IS 'The primary unique identifier for the flash card.';
COMMENT ON COLUMN learn.card.question IS 'The question to prompt the person';
COMMENT ON COLUMN learn.card.answer IS 'The answer to the question';
COMMENT ON COLUMN learn.card.archived IS 'Indicates if the card is active or not';

COMMENT ON COLUMN learn.card.review_after IS '@omit create,update
The next time the card should be reviewed';
COMMENT ON COLUMN learn.card.spacing IS '@omit create,update
The current spacing in days between reviews';
COMMENT ON COLUMN learn.card.ease_factor IS '@omit create,update
The ease at which the answer was last remembered';
COMMENT ON COLUMN learn.card.seq IS '@omit create,update
controls the order in which to review cards.';
COMMENT ON COLUMN learn.card.person_id IS '@omit create,update
The creator/owner of this card';
COMMENT ON COLUMN learn.card.created_at IS '@omit create,update
The time this card was created';