DROP VIEW IF EXISTS nhp_strategies.ip_preop_los;
GO

CREATE VIEW nhp_strategies.ip_preop_los
AS

SELECT
  i.EPIKEY,
  i.FYEAR,
  i.AGE,
  i.SEX,
  'preop_los' [strategy],
  MIN(v.preop_los) [preop_los],
  CASE
    MIN(v.preop_los)
      WHEN 1 THEN 1
      WHEN 2 THEN 1
      ELSE 0
  END [fraction]
FROM
  nhp_modelling.inpatients i WITH (NOLOCK)
INNER JOIN
  dbo.tbInpatientsProcedures p
  ON
    i.EPIKEY = p.EPIKEY
CROSS APPLY (
  VALUES
    (
      DATEDIFF(DD, i.ADMIDATE, p.OPDATE)
    )
) v (preop_los)
WHERE
  p.OPCODE NOT LIKE '[UYZ]%'
AND
  p.OPCODE NOT LIKE 'X62%'
AND
  p.OPDATE BETWEEN i.ADMIDATE AND i.DISDATE
AND
  i.ADMIMETH LIKE '1%'
GROUP BY
  i.EPIKEY,
  i.FYEAR,
  i.AGE,
  i.SEX

GO
