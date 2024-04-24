DROP VIEW IF EXISTS nhp_strategies.ip_intentional_self_harm;
GO

CREATE VIEW nhp_strategies.ip_intentional_self_harm
AS
SELECT
  i.*,
  'intentional_self_harm' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS (
    SELECT 1 FROM
      tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'X[67]%'
      OR
        d.DIAGNOSIS LIKE 'X8[0-4]%'
      OR
        d.DIAGNOSIS LIKE 'Y870'
    )
  );
GO
