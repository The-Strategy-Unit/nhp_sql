DROP VIEW IF EXISTS nhp_strategies.ip_ambulatory_emergency_care_low;
GO

CREATE VIEW nhp_strategies.ip_ambulatory_emergency_care_low
AS

SELECT
  i.*,
  'ambulatory_emergency_care_low' [strategy],
  IIF(i.SPELDUR > 0, 1, 0) [fraction]
FROM
  nhp_modelling.inpatients i
INNER JOIN
  dbo.tbInpatientsDiagnoses d
  ON
    i.EPIKEY = d.EPIKEY
  AND
    d.DIAGORDER = 1
WHERE
  i.AGE >= 18
AND
  i.ADMIMETH LIKE '2[123]'
AND (
  (
    (
  	  	i.SUSHRG LIKE 'DZ26[NP]'
		) AND (
  		  d.DIAGNOSIS LIKE 'J93[0189]%'
  	)
	) OR (
	  (
  		  i.SUSHRG LIKE 'DZ15[PQR]'
		) AND (
  			d.DIAGNOSIS LIKE 'J45[0189]%'
		)
	) OR (
	  (
  		  i.SUSHRG LIKE 'DZ65[FGHJK]'
		) AND (
  			d.DIAGNOSIS LIKE 'J21[0189]%'
			OR
			  d.DIAGNOSIS LIKE 'J4[02]X%'
      OR
			  d.DIAGNOSIS LIKE 'J410%'
      OR
			  d.DIAGNOSIS LIKE 'J43[1289]%'
      OR
			  d.DIAGNOSIS LIKE 'J44[0189]%'
		)
	) OR (
		(
  			i.SUSHRG LIKE 'DZ11[TUV]'
			OR
			  i.SUSHRG LIKE 'DZ23[MN]'
		) AND (
  			d.DIAGNOSIS LIKE 'J1[01]0%'
      OR
			  d.DIAGNOSIS LIKE 'J12[12389]%'
			OR
			  d.DIAGNOSIS LIKE 'J1[34]X%'
			OR
			  d.DIAGNOSIS LIKE 'J15[3-9]%'
      OR
			  d.DIAGNOSIS LIKE 'J16[08]%'
      OR
			  d.DIAGNOSIS LIKE 'J17[018]%'
      OR
			  d.DIAGNOSIS LIKE 'J18[0189]%'
    )
	) OR (
	  (
  	  	i.SUSHRG LIKE 'FZ38[MNP]'
		) AND (
  			d.DIAGNOSIS LIKE 'K20X%'
			OR
			  d.DIAGNOSIS LIKE 'K21[09]%'
      OR
			  d.DIAGNOSIS LIKE 'K22[16]%'
      OR
			  d.DIAGNOSIS LIKE 'K2[5-8][046]%'
      OR
			  d.DIAGNOSIS LIKE 'K92[012]%'
		)
	)

);

GO