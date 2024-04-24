DROP VIEW IF EXISTS nhp_strategies.ip_stroke_early_supported_discharge;
GO

CREATE VIEW nhp_strategies.ip_stroke_early_supported_discharge
AS

SELECT
  i.*,
  'stroke_early_supported_discharge' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  i.DISMETH <> '4'
AND
  EXISTS (
    SELECT 1
    FROM   tbInpatientsDiagnoses d
    WHERE  d.EPIKEY = i.EPIKEY
    AND    d.DIAGNOSIS LIKE 'I6[^9]%'
    AND    d.DIAGORDER = 1
  );

GO
