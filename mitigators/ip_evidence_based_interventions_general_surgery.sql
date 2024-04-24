DROP VIEW IF EXISTS nhp_strategies.ip_evidence_based_interventions_general_surgery
GO

CREATE VIEW nhp_strategies.ip_evidence_based_interventions_general_surgery
AS

-- apendectomy
SELECT
  i.*,
  'evidence_based_interventions_general_surgery' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'H01[12]%'
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

-- cholecystectomy
SELECT
  i.*,
  'evidence_based_interventions_general_surgery' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'J18%'
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
        d.DIAGNOSIS LIKE 'K851%'
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

-- haemorrhoid
SELECT
  i.*,
  'evidence_based_interventions_general_surgery' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'H51[12389]%'
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

-- hernia
SELECT
  i.*,
  'evidence_based_interventions_general_surgery' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'T20%'
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
        d.DIAGNOSIS LIKE 'K40[29]%'
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
