DROP VIEW IF EXISTS nhp_strategies.ip_enhanced_recovery_prostate;
GO

CREATE VIEW nhp_strategies.ip_enhanced_recovery_prostate
AS
SELECT
  *,
  'enhanced_recovery_prostate' [strategy],
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
          p.OPCODE LIKE 'M61%'
      )
  )
AND
  i.SEX = '1'
;
GO
