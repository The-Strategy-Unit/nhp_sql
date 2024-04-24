DROP VIEW IF EXISTS nhp_strategies.ip_medicines_related_admissions_implicit_benzodiasepines
GO

CREATE VIEW nhp_strategies.ip_medicines_related_admissions_implicit_benzodiasepines
AS

SELECT
  i.*,
  'medicines_related_admissions_implicit_benzodiasepines' [strategy],
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
          d.DIAGNOSIS LIKE 'R55X%'
        OR
          d.DIAGNOSIS LIKE 'S060%'
        OR
          d.DIAGNOSIS LIKE 'S52[0-8]%'
        OR
          d.DIAGNOSIS LIKE 'S628%'
        OR
          d.DIAGNOSIS LIKE 'S720%'
        OR
          d.DIAGNOSIS LIKE 'W%'
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
          d.DIAGNOSIS LIKE 'F%'
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
