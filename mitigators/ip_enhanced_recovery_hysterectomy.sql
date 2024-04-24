DROP VIEW IF EXISTS nhp_strategies.ip_enhanced_recovery_hysterectomy;
GO

CREATE VIEW nhp_strategies.ip_enhanced_recovery_hysterectomy
AS
SELECT
  *,
  'enhanced_recovery_hysterectomy' [strategy],
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
          p.OPCODE LIKE 'Q0[78]%'
      )
  )
AND
  i.SEX = '2'
;
GO
