DROP VIEW IF EXISTS nhp_strategies.ip_ambulatory_care_conditions_acute;
GO

CREATE VIEW nhp_strategies.ip_ambulatory_care_conditions_acute
AS

-- cellulitis
SELECT
  i.*,
  'ambulatory_care_conditions_acute' [strategy],
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
          d.DIAGNOSIS LIKE 'L0[34]%'
        OR
          d.DIAGNOSIS LIKE 'L08[089]%'
        OR
          d.DIAGNOSIS LIKE 'L88X%'
        OR
          d.DIAGNOSIS LIKE 'L980%'
      )
    )
  AND
    NOT EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsProcedures p
      WHERE
        i.EPIKEY = p.EPIKEY
      AND (
          p.OPCODE LIKE '[ABCDEFGHJKLMNOPQRTVW]%'
        OR
          p.OPCODE LIKE 'S[123]%'
        OR
          p.OPCODE LIKE 'S4[1234589]%'
        OR
          p.OPCODE LIKE 'X0[1245]%'
      )
    )
)

UNION

-- convulsions_and_epilepsy
SELECT
  i.*,
  'ambulatory_care_conditions_acute' [strategy],
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
          d.DIAGNOSIS LIKE 'G4[01]%'
        OR
          d.DIAGNOSIS LIKE 'O15%'
        OR
          d.DIAGNOSIS LIKE 'R56%'
      )
    )
)

UNION

-- dehydration_and_gastroenteritis
SELECT
  i.*,
  'ambulatory_care_conditions_acute' [strategy],
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
          d.DIAGNOSIS LIKE 'K52[289]%'
      )
    )
)

UNION

-- dental_conditions
SELECT
  i.*,
  'ambulatory_care_conditions_acute' [strategy],
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
          d.DIAGNOSIS LIKE 'A690%'
        OR
          d.DIAGNOSIS LIKE 'K0[2-68]%'
        OR
          d.DIAGNOSIS LIKE 'K09[89]%'
        OR
          d.DIAGNOSIS LIKE 'K1[23]%'
      )
    )
)

UNION

-- ent_infections
SELECT
  i.*,
  'ambulatory_care_conditions_acute' [strategy],
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
          d.DIAGNOSIS LIKE 'H6[67]%'
        OR
          d.DIAGNOSIS LIKE 'J0[236]%'
        OR
          d.DIAGNOSIS LIKE 'J312%'
      )
    )
)

UNION

-- gangrene
SELECT
  i.*,
  'ambulatory_care_conditions_acute' [strategy],
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
          d.DIAGNOSIS LIKE 'R02X%'
      )
    )
)

UNION

-- pelvic_inflammatory_disease
SELECT
  i.*,
  'ambulatory_care_conditions_acute' [strategy],
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
          d.DIAGNOSIS LIKE 'N7[034]%'
      )
    )
)

UNION

-- perforated_bleeding_ulcer
SELECT
  i.*,
  'ambulatory_care_conditions_acute' [strategy],
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
          d.DIAGNOSIS LIKE 'K2[5-8][012456]%'
      )
    )
)

UNION

-- pyelonephritis
SELECT
  i.*,
  'ambulatory_care_conditions_acute' [strategy],
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
          d.DIAGNOSIS LIKE 'N1[012]%'
        OR
          d.DIAGNOSIS LIKE 'N136%'
      )
    )
);

GO