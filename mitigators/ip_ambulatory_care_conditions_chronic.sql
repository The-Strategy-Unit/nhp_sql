DROP VIEW IF EXISTS nhp_strategies.ip_ambulatory_care_conditions_chronic;
GO

CREATE VIEW nhp_strategies.ip_ambulatory_care_conditions_chronic
AS

-- angina
SELECT
  i.*,
  'ambulatory_care_conditions_chronic' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'I20%'
      OR
        d.DIAGNOSIS LIKE 'I24[089]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
      p.OPORDER = 1
    AND (
        p.OPCODE LIKE '[ABCDEFGHJKLMNOPQRSTVW]%'
      OR
        p.OPCODE LIKE 'X[01245]%'
    )
  )

UNION

-- asthma
SELECT
  i.*,
  'ambulatory_care_conditions_chronic' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'J4[56]%'
    )
  )

UNION

-- congestive_heart_failure
SELECT
  i.*,
  'ambulatory_care_conditions_chronic' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'I110%'
      OR
        d.DIAGNOSIS LIKE 'I50%'
      OR
        d.DIAGNOSIS LIKE 'J81X%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND (
        p.OPCODE LIKE 'K[0-4]%'
      OR
        p.OPCODE LIKE 'K5[02567]%'
      OR
        p.OPCODE LIKE 'K6[016789]%'
      OR
        p.OPCODE LIKE 'K71%'
    )
  )

UNION

-- copd
SELECT
  i.*,
  'ambulatory_care_conditions_chronic' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND (
  (
      EXISTS(
        SELECT 1 FROM
          dbo.tbInpatientsDiagnoses d
        WHERE
          i.EPIKEY = d.EPIKEY
        AND
          d.DIAGORDER = 1
        AND (
            d.DIAGNOSIS LIKE 'J4[12347]%'
        )
      )
  ) OR (
      EXISTS(
        SELECT 1 FROM
          dbo.tbInpatientsDiagnoses d
        WHERE
          i.EPIKEY = d.EPIKEY
        AND
          d.DIAGORDER = 1
        AND (
            d.DIAGNOSIS LIKE 'J20%'
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
            d.DIAGNOSIS LIKE 'J4[12347]%'
        )
      )
  )
)

UNION

-- diabetes_complications
SELECT
  i.*,
  'ambulatory_care_conditions_chronic' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'E1[0-4][0-8]%'
    )
  )

UNION

-- hypertension
SELECT
  i.*,
  'ambulatory_care_conditions_chronic' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'I10X%'
      OR
        d.DIAGNOSIS LIKE 'I119%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND (
        p.OPCODE LIKE 'K[0-4]%'
      OR
        p.OPCODE LIKE 'K5[02567]%'
      OR
        p.OPCODE LIKE 'K6[016789]%'
      OR
        p.OPCODE LIKE 'K71%'
    )
  )

UNION

-- iron-deficiency_anaemia
SELECT
  i.*,
  'ambulatory_care_conditions_chronic' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'D50[189]%'
    )
  )

UNION

-- nutritional_deficiencies
SELECT
  i.*,
  'ambulatory_care_conditions_chronic' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'E4[0123]X%'
      OR
        d.DIAGNOSIS LIKE 'E550%'
      OR
        d.DIAGNOSIS LIKE 'E643%'
    )
  );

GO