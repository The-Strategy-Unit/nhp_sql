DROP VIEW IF EXISTS nhp_strategies.ip_virtual_wards_heart_failure;
GO

CREATE VIEW nhp_strategies.ip_virtual_wards_heart_failure
AS

SELECT
  *,
  'virtual_wards_heart_failure' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  i.DISMETH IN (1, 2, 3)
AND  
  i.ADMIAGE >= 18  
AND
  EXISTS (
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND
      d.DIAGNOSIS IN ('I110','I255','I420','I429','I500','I501','I509')
  );

GO