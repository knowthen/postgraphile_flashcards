CREATE VIEW learn.next_card AS
SELECT
  *
FROM
  learn.card
WHERE
  review_after <= now()
ORDER BY
  seq,
  review_after,
  id;
