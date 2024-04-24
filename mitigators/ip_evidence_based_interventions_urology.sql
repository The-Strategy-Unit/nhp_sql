DROP VIEW IF EXISTS nhp_strategies.ip_evidence_based_interventions_urology
GO

CREATE VIEW nhp_strategies.ip_evidence_based_interventions_urology
AS

-- cystoscopy
SELECT
  i.*,
  'evidence_based_interventions_urology' [strategy],
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
        p.OPCODE LIKE 'M45[589]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER > 1
    AND (
        p.OPCODE LIKE 'M45[1-4]%'
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

-- prostatic_hyperplasia
SELECT
  i.*,
  'evidence_based_interventions_urology' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  i.sex = 1
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'M6[15]%'
      OR
        p.OPCODE LIKE 'M641%'
      OR
        p.OPCODE LIKE 'M66[12]%'
      OR
        p.OPCODE LIKE 'M68[13]%'
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
        d.DIAGNOSIS LIKE 'N40%'
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
