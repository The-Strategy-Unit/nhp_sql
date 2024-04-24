DROP VIEW IF EXISTS nhp_strategies.ip_raid_ae;
GO

CREATE VIEW nhp_strategies.ip_raid_ae
AS

SELECT
  i.*,
  'raid_ae' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH = '21'
AND
  EXISTS (
    SELECT 1 FROM
      tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGNOSIS LIKE 'F%'
    AND
      d.DIAGORDER = 1
  )
AND
  NOT EXISTS (
    SELECT 1 FROM
      tbInpatientsProcedures p
    WHERE
      p.EPIKEY = i.EPIKEY
  )
AND
  i.DISMETH != 4;

GO
