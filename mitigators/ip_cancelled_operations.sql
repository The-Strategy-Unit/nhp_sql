DROP VIEW IF EXISTS nhp_strategies.ip_cancelled_operations;
GO

CREATE VIEW nhp_strategies.ip_cancelled_operations
AS
SELECT
  *,
  'cancelled_operations' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients
WHERE
  (
    SUSHRG LIKE 'S22%'
  OR
    SUSHRG LIKE 'WA14%'
  OR
    SUSHRG LIKE 'WH50%'
  )
AND
  ADMIMETH LIKE '1[123]'
AND
  DISMETH <> 4;
GO
