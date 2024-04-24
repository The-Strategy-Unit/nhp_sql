
DROP VIEW IF EXISTS nhp_strategies.ip_alcohol_wholly_attributable;
GO

CREATE VIEW nhp_strategies.ip_alcohol_wholly_attributable
AS

SELECT
  i.*,
  'alcohol_wholly_attributable' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.AGE >= 16
AND (
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'E244%'
      OR
        d.DIAGNOSIS LIKE 'F10%'
      OR
        d.DIAGNOSIS LIKE 'G312%'
      OR
        d.DIAGNOSIS LIKE 'G621%'
      OR
        d.DIAGNOSIS LIKE 'G721%'
      OR
        d.DIAGNOSIS LIKE 'I426%'
      OR
        d.DIAGNOSIS LIKE 'K292%'
      OR
        d.DIAGNOSIS LIKE 'K70%'
      OR
        d.DIAGNOSIS LIKE 'K860%'
      OR
        d.DIAGNOSIS LIKE 'T510%'
      OR
        d.DIAGNOSIS LIKE 'T511%'
      OR
        d.DIAGNOSIS LIKE 'T519%'
      OR
        d.DIAGNOSIS LIKE 'X45%'
      OR
        d.DIAGNOSIS LIKE 'X65%'
      OR
        d.DIAGNOSIS LIKE 'Y15%'
      OR
        d.DIAGNOSIS LIKE 'K852%'
      OR
        d.DIAGNOSIS LIKE 'Q860%'
      OR
        d.DIAGNOSIS LIKE 'R780%'
      OR
        d.DIAGNOSIS LIKE 'Y9[01]%'

    )
  )
);
GO
