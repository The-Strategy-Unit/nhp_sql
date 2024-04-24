DROP VIEW IF EXISTS nhp_strategies.ip_evidence_based_interventions_ent
GO

CREATE VIEW nhp_strategies.ip_evidence_based_interventions_ent
AS

-- adenoids
SELECT
  i.*,
  'evidence_based_interventions_ent' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND (
        p.OPCODE LIKE 'E20[1489]%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND (
        p.OPCODE LIKE 'D151%'
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
        d.DIAGNOSIS LIKE 'H65[2349]%'
      OR
        d.DIAGNOSIS LIKE 'H66[1349]%'
      OR
        d.DIAGNOSIS LIKE 'H681%'
      OR
        d.DIAGNOSIS LIKE 'H69[89]%'
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
        d.DIAGNOSIS LIKE 'G473%'
      OR
        d.DIAGNOSIS LIKE 'J32%'
      OR
        d.DIAGNOSIS LIKE 'Q3[57]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- grommets
SELECT
  i.*,
  'evidence_based_interventions_ent' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'D151%'
      OR
        p.OPCODE LIKE 'D289%'
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
        d.DIAGNOSIS LIKE 'H65[23]%'
    )
  )
AND
  i.AGE < 18
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- rhinosinisitis
SELECT
  i.*,
  'evidence_based_interventions_ent' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND (
        p.OPCODE LIKE 'E081%'
      OR
        p.OPCODE LIKE 'E1[2-7]%'
      OR
        p.OPCODE LIKE 'Y76[12]%'
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
        d.DIAGNOSIS LIKE 'J3[23]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- snoring_1
SELECT
  i.*,
  'evidence_based_interventions_ent' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'F32[4-6]%'
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
        d.DIAGNOSIS LIKE 'G473%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- snoring_2
SELECT
  i.*,
  'evidence_based_interventions_ent' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'F328%'
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
        d.DIAGNOSIS LIKE 'R065%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- 
SELECT
  i.*,
  'evidence_based_interventions_ent' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'E34[1-9]%'
      OR
        p.OPCODE LIKE 'E361%'
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
        d.DIAGNOSIS LIKE 'G47%'
      OR
        d.DIAGNOSIS LIKE 'J36%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )
;

GO