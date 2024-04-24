DROP VIEW IF EXISTS nhp_strategies.ip_falls_related_admissions
GO

CREATE VIEW nhp_strategies.ip_falls_related_admissions
AS

-- explicit
SELECT
  i.*,
  'falls_related_admissions' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  i.AGE >= 65
AND (
  EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND
        d.DIAGORDER > 1
      AND (
          d.DIAGNOSIS LIKE 'W[01][0-9]%'
      )
    )
AND
  EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND
        d.DIAGORDER = 1
      AND (
          d.DIAGNOSIS LIKE '[ST]%'
      )
    )
)
UNION

-- implicit_fracture
SELECT
  i.*,
  'falls_related_admissions' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  i.AGE >= 65
AND (
    EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND (
          d.DIAGNOSIS LIKE 'M48[45]%'
        OR
          d.DIAGNOSIS LIKE 'M80[0-589]%'
        OR
          d.DIAGNOSIS LIKE 'S22[01]%'
        OR
          d.DIAGNOSIS LIKE 'S32[0-47]%'
        OR
          d.DIAGNOSIS LIKE 'S42[234]%'
        OR
          d.DIAGNOSIS LIKE 'S52%'
        OR
          d.DIAGNOSIS LIKE 'S620%'
        OR
          d.DIAGNOSIS LIKE 'S72[0-48]%'
        OR
          d.DIAGNOSIS LIKE 'T08X%'
      )
    )
  AND
    NOT EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND (
          d.DIAGNOSIS LIKE '[VWXY]%'
      )
    )
)
UNION

-- implicit_tendency_to_fall
SELECT
  i.*,
  'falls_related_admissions' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  i.AGE >= 65
AND (
  EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND
        d.DIAGORDER = 1
      AND (
          d.DIAGNOSIS LIKE 'R296%'
      )
    )
);

GO
