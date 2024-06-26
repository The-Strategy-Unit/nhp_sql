DROP VIEW IF EXISTS nhp_strategies.ip_virtual_wards_ari;
GO

CREATE VIEW nhp_strategies.ip_virtual_wards_ari
AS

SELECT
  *,
  'virtual_wards_ari' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  i.DISMETH IN ('1', '2', '3')
AND 
  i.ADMIAGE >= 18
AND
  NOT EXISTS (
    SELECT 1
    FROM   tbInpatientsProcedures p
    WHERE  p.EPIKEY = i.EPIKEY
  )
AND
  EXISTS (
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND
      (
          d.DIAGNOSIS LIKE 'B3[34]%'
        OR
          d.DIAGNOSIS LIKE 'B97%'
        OR
          -- ^J(?!0[^69])
          d.DIAGNOSIS BETWEEN 'J060' AND 'J99X'
        OR
          d.DIAGNOSIS LIKE 'U0[467]%'
      )
  );

GO