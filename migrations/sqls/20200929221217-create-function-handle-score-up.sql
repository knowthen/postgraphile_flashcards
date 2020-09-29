CREATE FUNCTION learn.handle_score (card_id integer, score integer)
  RETURNS learn.card
  AS $$
DECLARE
  card learn.card;
  ease_factor numeric(7, 4);
  new_review_after timestamptz;
  response learn.score_response;
BEGIN
  SELECT
    * INTO card
  FROM
    learn.card
  WHERE
    id = card_id;
  response = learn.score_response (score, card.spacing, card.ease_factor);
  new_review_after = card.review_after + interval '1 day' * response.spacing;
  UPDATE
    learn.card
  SET
    spacing = response.spacing,
    ease_factor = response.ease_factor,
    review_after = new_review_after,
    seq = CASE WHEN response.spacing = 0 THEN
    (
      SELECT
        coalesce(max(seq), 0) + 1
      FROM
        learn.card
      WHERE
        review_after < now()
        AND archived = FALSE)
  ELSE
    0
    END
  WHERE
    id = card_id
  RETURNING
    * INTO card;
  INSERT INTO learn.response (score, review_after, spacing, ease_factor, card_id, person_id)
    VALUES (score, new_review_after, response.spacing, response.ease_factor, card_id, card.person_id);
  RETURN card;
END;
$$
LANGUAGE plpgsql
VOLATILE
SECURITY DEFINER;
