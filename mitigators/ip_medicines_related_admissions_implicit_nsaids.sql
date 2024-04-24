DROP VIEW IF EXISTS nhp_strategies.ip_medicines_related_admissions_implicit_nsaids
GO

CREATE VIEW nhp_strategies.ip_medicines_related_admissions_implicit_nsaids
AS

SELECT
  i.*,
  'medicines_related_admissions_implicit_nsaids' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND (
    EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND
        d.DIAGORDER = 1
      AND (
          d.DIAGNOSIS LIKE 'E87[56]%'
        OR
          d.DIAGNOSIS LIKE 'I50[019]%'
        OR
          d.DIAGNOSIS LIKE 'K25[059]%'
        OR
          d.DIAGNOSIS LIKE 'K922%'
        OR
          d.DIAGNOSIS LIKE 'R10[34]%'
      )
    )
  AND
    EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND
        d.DIAGORDER > 1
      AND (
          d.DIAGNOSIS LIKE 'M05[389]%'
        OR
          d.DIAGNOSIS LIKE 'M06[089]%'
        OR
          d.DIAGNOSIS LIKE 'M080%'
        OR
          d.DIAGNOSIS LIKE 'M15[0-489]%'
        OR
          d.DIAGNOSIS LIKE 'M16[0-79]%'
        OR
          d.DIAGNOSIS LIKE 'M1[78][0-59]%'
        OR
          d.DIAGNOSIS LIKE 'M19[01289]%'
      )
    )
  AND
    NOT EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND
        d.DIAGORDER = 1
      AND (
          d.DIAGNOSIS LIKE 'Y4%'
        OR
          d.DIAGNOSIS LIKE 'Y5[0-7]%'
      )
    )
);

GO
