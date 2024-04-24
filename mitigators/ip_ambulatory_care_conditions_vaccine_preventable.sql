DROP VIEW IF EXISTS nhp_strategies.ip_ambulatory_care_conditions_vaccine_preventable;
GO

CREATE VIEW nhp_strategies.ip_ambulatory_care_conditions_vaccine_preventable
AS

-- influenza_and_pneumonia
SELECT
  i.*,
  'ambulatory_care_conditions_vaccine_preventable' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'J1[0134]%'
      OR
        d.DIAGNOSIS LIKE 'J15[3479]%'
      OR
        d.DIAGNOSIS LIKE 'J168%'
      OR
        d.DIAGNOSIS LIKE 'J18[18]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER > 1
    AND (
        d.DIAGNOSIS LIKE 'D57%'
    )
  )

UNION

-- other
SELECT
  i.*,
  'ambulatory_care_conditions_vaccine_preventable' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'A3[567]%'
      OR
        d.DIAGNOSIS LIKE 'A80%'
      OR
        d.DIAGNOSIS LIKE 'B0[56]%'
      OR
        d.DIAGNOSIS LIKE 'B16[19]%'
      OR
        d.DIAGNOSIS LIKE 'B18[01]%'
      OR
        d.DIAGNOSIS LIKE 'B26%'
      OR
        d.DIAGNOSIS LIKE 'G000%'
      OR
        d.DIAGNOSIS LIKE 'M014%'
    )
  );


GO