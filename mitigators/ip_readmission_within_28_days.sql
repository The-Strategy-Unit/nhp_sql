DROP VIEW IF EXISTS nhp_strategies.ip_readmission_within_28_days;
GO

CREATE VIEW nhp_strategies.ip_readmission_within_28_days
AS

SELECT
  i.*,
  'readmission_within_28_days' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '2%'
AND
  EXISTS (
    SELECT 1 FROM
      nhp_modelling.inpatients j
    WHERE
      i.EPIKEY <> j.EPIKEY
    AND
      i.person_id = j.person_id
    AND
      DATEDIFF(DD, j.DISDATE, i.ADMIDATE) BETWEEN 0 AND 28
    -- some additional logic: potentially we could have two records where the patient was a same day admission. In this
    -- case both of the records would show as readmissions. This logic will prevent that, but it will also mean that
    -- neither show up as readmissions.
    AND (
        j.ADMIDATE < i.ADMIDATE
      OR
        j.DISDATE < i.DISDATE
    )
  );

GO
