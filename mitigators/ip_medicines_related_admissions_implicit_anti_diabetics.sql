DROP VIEW IF EXISTS nhp_strategies.ip_medicines_related_admissions_implicit_anti_diabetics
GO

CREATE VIEW nhp_strategies.ip_medicines_related_admissions_implicit_anti_diabetics
AS

SELECT
  i.*,
  'medicines_related_admissions_implicit_anti_diabetics' [strategy],
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
          d.DIAGNOSIS LIKE 'E16[012]%'
        OR
          d.DIAGNOSIS LIKE 'E781%'
        OR
          d.DIAGNOSIS LIKE 'R55X%'
        OR
          d.DIAGNOSIS LIKE 'R739%'
        OR
          d.DIAGNOSIS LIKE 'T383%'
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
          d.DIAGNOSIS LIKE 'E1[0-4]%'
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
