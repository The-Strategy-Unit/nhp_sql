DROP VIEW IF EXISTS nhp_strategies.ip_enhanced_recovery_bladder;
GO

CREATE VIEW nhp_strategies.ip_enhanced_recovery_bladder
AS
SELECT
  *,
  'enhanced_recovery_bladder' [strategy],
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
          p.OPCODE LIKE 'M34%'
      )
    )
;
GO
