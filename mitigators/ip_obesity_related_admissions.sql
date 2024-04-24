DROP VIEW IF EXISTS nhp_strategies.ip_obesity_related_admissions;
GO

CREATE VIEW nhp_strategies.ip_obesity_related_admissions
AS

SELECT
  i.*,
  'obesity_related_admissions' [strategy],
  d.diagnosis primary_diagnosis,
  a.fraction fraction
FROM
  nhp_modelling.inpatients i
INNER JOIN
  nhp_modelling.inpatients_diagnoses d
  ON
    i.EPIKEY = d.EPIKEY
  AND
    d.DIAGORDER = 1
INNER JOIN
  nhp_modelling_reference.obesity_attributable_fractions a
  ON
    d.DIAGNOSIS = a.diagnosis
WHERE
  -- I12 and I22 are massively over-represented prior to 2012/13, skewing the
  -- results
  d.DIAGNOSIS NOT LIKE 'I[12]2%';

GO
