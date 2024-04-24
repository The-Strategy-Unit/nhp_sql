DROP VIEW IF EXISTS nhp_strategies.ip_medicines_related_admissions_explicit
GO

CREATE VIEW nhp_strategies.ip_medicines_related_admissions_explicit
AS

SELECT
  i.*,
  'medicines_related_admissions_explicit' [strategy],
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
      AND (
          d.DIAGNOSIS LIKE 'Y4%'
        OR
          d.DIAGNOSIS LIKE 'Y5[0-7]%'
      )
    )
);

GO
