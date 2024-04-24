DROP VIEW IF EXISTS nhp_strategies.ip_zero_los_no_procedure;
GO

CREATE VIEW nhp_strategies.ip_zero_los_no_procedure
AS

SELECT
  i.*,
  'zero_los_no_procedure-' + IIF(AGE >= 18, 'adult', 'child') [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  NOT EXISTS (
    SELECT 1
    FROM   tbInpatientsProcedures p
    WHERE  p.EPIKEY = i.EPIKEY
  )
AND
  i.SPELDUR = 0
AND
  i.DISMETH IN (1, 2, 3);

GO
