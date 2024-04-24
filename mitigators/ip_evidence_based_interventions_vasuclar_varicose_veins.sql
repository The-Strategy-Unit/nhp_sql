DROP VIEW IF EXISTS nhp_strategies.ip_evidence_based_interventions_vasuclar_varicose_veins
GO

CREATE VIEW nhp_strategies.ip_evidence_based_interventions_vasuclar_varicose_veins
AS

SELECT
  i.*,
  'evidence_based_interventions_vasuclar_varicose_veins' [strategy],
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
        p.OPCODE LIKE 'L83[289]%'
      OR
        p.OPCODE LIKE 'L8[4-8]%'
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
        d.DIAGNOSIS LIKE 'I8[03]%'
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
