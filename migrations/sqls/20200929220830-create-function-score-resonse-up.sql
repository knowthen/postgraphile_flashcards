CREATE TYPE learn.score_response AS (
  ease_factor numeric ( 7, 4),
  spacing integer);

CREATE FUNCTION learn.score_response (score integer, spacing integer, ease_factor numeric(7, 4))
  RETURNS learn.score_response
  AS $$
DECLARE
  new_ease_factor numeric(7, 4);
  new_days integer;
BEGIN
  IF score IS NULL OR score < 0 OR score > 3 THEN
    score = 0;
  END IF;
  IF score = 0 THEN
    new_ease_factor = ease_factor;
    new_days = 0;
  ELSE
    IF spacing = 0 THEN
      new_days = 1;
      new_ease_factor = 2.5;
    elsif spacing = 1 THEN
      new_days = 3;
      new_ease_factor = ease_factor;
    ELSE
      new_ease_factor = ease_factor + (0.1 - (4 - score) * (0.08 + (4 - score) * 0.02));
      IF new_ease_factor < 1.3 THEN
        new_ease_factor = 1.3;
      END IF;
      new_days = spacing * new_ease_factor;
    END IF;
  END IF;
  RETURN (new_ease_factor,
    new_days)::learn.score_response;
END;
$$
LANGUAGE plpgsql
IMMUTABLE
SECURITY DEFINER;
