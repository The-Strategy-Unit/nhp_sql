DROP VIEW IF EXISTS nhp_strategies.ip_emergency_elderly;
GO

CREATE VIEW nhp_strategies.ip_emergency_elderly
AS
SELECT
  *,
  'emergency_elderly' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients
WHERE
  AGE >= 75
AND
  ADMIMETH LIKE '2%';
GO
