DROP VIEW IF EXISTS nhp_strategies.ip_medicines_related_admissions_implicit_diurectics
GO

CREATE VIEW nhp_strategies.ip_medicines_related_admissions_implicit_diurectics
AS

SELECT
  i.*,
  'medicines_related_admissions_implicit_diurectics' [strategy],
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
          d.DIAGNOSIS LIKE 'E86X%'
        OR
          d.DIAGNOSIS LIKE 'E87[56]%'
        OR
          d.DIAGNOSIS LIKE 'I470%'
        OR
          d.DIAGNOSIS LIKE 'I49[89]%'
        OR
          d.DIAGNOSIS LIKE 'R55X%'
        OR
          d.DIAGNOSIS LIKE 'R571%'
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
          d.DIAGNOSIS LIKE 'I10X%'
        OR
          d.DIAGNOSIS LIKE 'I1[12][09]%'
        OR
          d.DIAGNOSIS LIKE 'I13[01239]%'
        OR
          d.DIAGNOSIS LIKE 'I150%'
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
