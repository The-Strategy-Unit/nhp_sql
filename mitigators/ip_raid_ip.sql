DROP VIEW IF EXISTS nhp_strategies.ip_raid_ip;
GO

CREATE VIEW nhp_strategies.ip_raid_ip
AS

SELECT
  i.*,
  'raid_ip' [strategy],
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
    AND
      d.DIAGNOSIS LIKE 'F%'
  )
AND
  i.DISMETH != 4;

GO
