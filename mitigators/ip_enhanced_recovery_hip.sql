DROP VIEW IF EXISTS nhp_strategies.ip_enhanced_recovery_hip;
GO

CREATE VIEW nhp_strategies.ip_enhanced_recovery_hip
AS
SELECT
  *,
  'enhanced_recovery_hip' [strategy],
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
          p.OPCODE LIKE 'W3[789]%'
        OR
          p.OPCODE LIKE 'W4[678]%'
        OR
          p.OPCODE LIKE 'W9[345]%'
      )
  )
;
GO
