DROP VIEW IF EXISTS nhp_strategies.ip_eol_care;
GO

CREATE VIEW nhp_strategies.ip_eol_care
AS

SELECT
  i.*,
  CASE
    i.SPELDUR
    WHEN 0 THEN 'eol_care-0-2_days'
    WHEN 1 THEN 'eol_care-0-2_days'
    WHEN 2 THEN 'eol_care-0-2_days'
           ELSE 'eol_care-3+_days'
  END [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.DISMETH = 4
AND
  NOT EXISTS (
    SELECT 1
    FROM   dbo.tbInpatientsDiagnoses d
    WHERE  i.EPIKEY = d.EPIKEY
	  AND    d.DIAGNOSIS LIKE '[V-Y]%'
  )
AND
  NOT EXISTS (
    SELECT 1
    FROM   dbo.tbInpatientsProcedures p
    WHERE  i.EPIKEY = p.EPIKEY
  )
AND
  i.SPELDUR <= 14;

GO
