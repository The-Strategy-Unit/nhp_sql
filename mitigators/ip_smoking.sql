--------------------------------------------------------------------------------
DROP TABLE IF EXISTS nhp_modelling_reference.saf_table;
GO

-- create a table of all of the possible icd-10 codes for the wildcard diagnoses column
SELECT DISTINCT
  CAST(a.sex AS NCHAR(1)) [sex],
  d.DiagnosisCode [diagnosis],
  a.[value]
INTO nhp_modelling_reference.saf_table
FROM
  nhp_modelling_reference.smoking_attributable_fractions a
INNER JOIN
  reference.dbo.DIM_tbDiagnosis d
  ON
    d.DiagnosisCode LIKE a.diagnoses + '%';
-- build an index on the temporary table
CREATE CLUSTERED INDEX CIX_saf ON nhp_modelling_reference.saf_table (diagnosis, sex);
GO

--------------------------------------------------------------------------------
DROP VIEW IF EXISTS nhp_strategies.ip_smoking;
GO

CREATE VIEW nhp_strategies.ip_smoking
AS

SELECT
  i.EPIKEY,
  i.FYEAR,
  i.PROCODE3,
  i.AGE,
  i.SEX,
  'smoking' [strategy],
  MAX(saf.[value]) [fraction]
FROM
  nhp_modelling.inpatients i
INNER JOIN
  dbo.tbInpatientsDiagnoses d
  ON
    i.EPIKEY = d.EPIKEY
INNER JOIN
  nhp_modelling_reference.saf_table saf
  ON
    d.diagnosis = saf.diagnosis
  AND
    i.SEX = saf.sex
WHERE
  d.DIAGORDER = 1
GROUP BY
  i.EPIKEY,
  i.FYEAR,
  i.PROCODE3,
  i.AGE,
  i.SEX;

GO
