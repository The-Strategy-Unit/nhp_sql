DROP VIEW IF EXISTS nhp_strategies.ip_medically_unexplained_related_admissions;
GO

CREATE VIEW nhp_strategies.ip_medically_unexplained_related_admissions
AS
SELECT
  i.*,
  'medically_unexplained_related_admissions' [strategy],
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
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'F510%'
      OR
        d.DIAGNOSIS LIKE 'G44[028]%'
      OR
        d.DIAGNOSIS LIKE 'G470%'
      OR
        d.DIAGNOSIS LIKE 'G501%'
      OR
        d.DIAGNOSIS LIKE 'H931%'
      OR
        d.DIAGNOSIS LIKE 'K580%'
      OR
        d.DIAGNOSIS LIKE 'K59[01]%'
      OR
        d.DIAGNOSIS LIKE 'M545%'
      OR
        d.DIAGNOSIS LIKE 'R002%'
      OR
        d.DIAGNOSIS LIKE 'R07[14]%'
      OR
        d.DIAGNOSIS LIKE 'R12X%'
      OR
        d.DIAGNOSIS LIKE 'R251%'
      OR
        d.DIAGNOSIS LIKE 'R42X%'
      OR
        d.DIAGNOSIS LIKE 'R5[13]X%'
    )
  );

GO
