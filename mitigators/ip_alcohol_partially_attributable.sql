--------------------------------------------------------------------------------
DROP TABLE IF EXISTS nhp_modelling_reference.aaf_table;
GO

-- create a table of all of the possible icd-10 codes for the wildcard diagnoses column
SELECT DISTINCT
  a.condition,
  a.diagnoses,
  d.DiagnosisCode [diagnosis]
INTO nhp_modelling_reference.aaf_table
FROM
  nhp_modelling_reference.aaf a
INNER JOIN
  reference.dbo.DIM_tbDiagnosis d
  ON
    d.DiagnosisCode LIKE a.diagnoses + '%';
-- build an index on the temporary table
CREATE CLUSTERED INDEX CIX_aaf_table ON nhp_modelling_reference.aaf_table (diagnosis);
GO

--------------------------------------------------------------------------------
DROP VIEW IF EXISTS nhp_strategies.ip_alcohol_partially_attributable;
GO

CREATE VIEW nhp_strategies.ip_alcohol_partially_attributable
AS

SELECT
  i.EPIKEY,
  i.FYEAR,
  i.PROCODE3,
  i.AGE,
  i.SEX,
  'alcohol_partially_attributable-' + a.condition_group [strategy],
  MAX(a.[value]) [fraction]
FROM
  nhp_modelling.inpatients i
INNER JOIN
  dbo.tbInpatientsDiagnoses d
  ON
    i.EPIKEY = d.EPIKEY
INNER JOIN
  nhp_modelling_reference.aaf_table aaf
  ON
    d.diagnosis = aaf.diagnosis
INNER JOIN
  nhp_modelling_reference.aaf a
  ON
    aaf.condition = a.condition
  AND
    aaf.diagnoses = a.diagnoses
WHERE
  i.AGE BETWEEN a.min_age AND a.max_age
AND
  i.SEX = a.sex
AND (
    a.mortality_flag IS NULL
  OR (
    a.mortality_flag = 1 AND i.DISMETH = 4
  )
  OR
    i.DISMETH <> 4
)
AND
  a.[value] > 0
GROUP BY
  i.EPIKEY,
  i.FYEAR,
  i.PROCODE3,
  i.AGE,
  i.SEX,
  a.condition_group;

GO
