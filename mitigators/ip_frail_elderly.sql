DROP VIEW IF EXISTS nhp_strategies.ip_frail_elderly;
GO

CREATE VIEW nhp_strategies.ip_frail_elderly
AS

WITH frs AS (
  SELECT
    i.EPIKEY,
    i.person_id,
    i.ADMIMETH,
    i.ADMIDATE,
    i.DISDATE,
    i.FYEAR,
    i.AGE,
    i.SEX,
    f.icd10,
    f.score
  FROM
    nhp_modelling.inpatients i
  INNER JOIN
    dbo.tbInpatientsDiagnoses d
    ON
      i.EPIKEY = d.EPIKEY
  INNER JOIN
    nhp_modelling_reference.frailty_risk_scores f
    ON
      LEFT(d.DIAGNOSIS, 3) = f.icd10
  WHERE
    i.DISDATE < '21000101'
), scores AS (
  SELECT
    i.EPIKEY,
    i.FYEAR,
    i.AGE,
    i.SEX,
    SUM(j.score) + i.score [score]
  FROM
    frs i
  INNER JOIN
    frs j
    ON
      i.person_id = j.person_id
    WHERE
      i.ADMIMETH LIKE '2%'
    AND
      i.AGE >= 75
    AND
      j.DISDATE < i.ADMIDATE
    AND
      i.ADMIDATE <= DATEADD(DD, 365 * 2, j.DISDATE)
  GROUP BY
    i.EPIKEY,
    i.FYEAR,
    i.AGE,
    i.SEX,
    i.score
)
SELECT
  EPIKEY,
  FYEAR,
  AGE,
  SEX,
  'frail_elderly-' + CASE
    WHEN score <   5 THEN N'low'
    WHEN score <= 15 THEN N'intermediate'
    ELSE N'high'
  END [strategy],
  1 [fraction]
FROM
  scores
WHERE
  score >= 5;
GO
