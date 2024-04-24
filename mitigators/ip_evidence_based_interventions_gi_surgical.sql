DROP VIEW IF EXISTS nhp_strategies.ip_evidence_based_interventions_gi_surgical
GO

CREATE VIEW nhp_strategies.ip_evidence_based_interventions_gi_surgical
AS


-- colonoscopy
SELECT
  i.*,
  'evidence_based_interventions_gi_surgical' [strategy],
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
    AND (
        p.OPCODE LIKE 'H22[189]%'
      OR
        p.OPCODE LIKE 'H68[2489]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'Z121%'
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

-- endoscopy
SELECT
  i.*,
  'evidence_based_interventions_gi_surgical' [strategy],
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
        p.OPCODE LIKE 'G1[69]%'
      OR
        p.OPCODE LIKE 'G[46]5%'
      OR
        p.OPCODE LIKE 'G80%'
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
