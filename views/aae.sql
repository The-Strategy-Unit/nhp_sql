USE HESData;

DROP VIEW IF EXISTS [nhp_modelling].[aae];
DROP VIEW IF EXISTS [nhp_modelling].[aae_diagnoses];
DROP VIEW IF EXISTS [nhp_modelling].[aae_investigations];
DROP VIEW IF EXISTS [nhp_modelling].[aae_treatments];

GO

CREATE VIEW [nhp_modelling].[aae] AS
SELECT
  a.aekey,
  a.fyear,
  person_id = mpsid.tokenid,
  CASE WHEN activage >= 7000 THEN 0 ELSE activage END activage,
  sex,
  ethnos,
  imd04_decile,
  arrivaldate,
  aedepttype,
  aearrivalmode,
  s.new_code procode3,
  sushrg,
  icb.icb22cdh,
  CASE icb.icb22cdh WHEN p.icb22cdh THEN 1 ELSE 0 END is_main_icb,
  -- calculated columns
  is_low_cost_referred_or_discharged = CASE
    WHEN (sushrg LIKE 'VB0[69]Z' OR sushrg LIKE 'VB1[01]Z') AND AEAttendDisp LIKE '0[23]'
      THEN 1
      ELSE 0
  END,
  is_left_before_treatment = CASE
    WHEN aeattenddisp = 12
      THEN 1
      ELSE 0
  END,
  is_frequent_attender = CASE
    WHEN EXISTS (
      SELECT 1 FROM nhp_modelling.aae_frequent_attenders WHERE aekey = a.aekey
    )
      THEN 1
      ELSE 0
  END,
  is_discharged_no_treatment = CASE
    WHEN aeattenddisp <> '03' THEN 0
    WHEN EXISTS (
      SELECT 1
      FROM   tbAandEInvestigations
      WHERE  a.aekey = aekey
      AND    investigation <> '24'
    ) THEN 0
    WHEN EXISTS (
      SELECT 1
      FROM   tbAandETreatments
      WHERE  a.aekey = aekey
      AND    treatment NOT IN ('22', '99')
    ) THEN 0
    ELSE 1
  END
FROM
  tbAandE a
LEFT JOIN
  dbo.tbAandE_MPSID mpsid
  ON
    a.FYEAR = mpsid.FYEAR
  AND
    a.ORIG_AEKEY = mpsid.AEKEY
LEFT JOIN
    nhp_modelling_reference.ccg_to_icb icb
    ON
        a.ccg_residence = icb.ccg
INNER JOIN
    nhp_modelling.provider_successors s
    ON
        a.procode3 = s.old_code
INNER JOIN
    nhp_modelling.provider_main_icb p
    ON
        s.new_code = p.procode
WHERE
    a.fyear BETWEEN 201011 AND 201920
AND
    sex IN ('1', '2')
AND
    aeattendcat = '1';

GO

CREATE VIEW [nhp_modelling].[aae_diagnoses] AS
SELECT i.aekey, i.diagorder, i.diagnosis, i.diag_2, i.diag_anatomical_area, i.diag_anatomical_side
FROM   dbo.tbAandEDiagnoses i
WHERE  EXISTS (SELECT 1 FROM nhp_modelling.aae WHERE aekey = i.aekey);

GO

CREATE VIEW [nhp_modelling].[aae_investigations] AS
SELECT i.aekey, i.investorder, i.investigation, i.invest_2
FROM   dbo.tbAandEInvestigations i
WHERE  EXISTS (SELECT 1 FROM nhp_modelling.aae WHERE aekey = i.aekey);

GO

CREATE VIEW [nhp_modelling].[aae_treatments] AS
SELECT i.aekey, i.treatorder, i.treatment, i.treat_2
FROM   dbo.tbAandETreatments i
WHERE  EXISTS (SELECT 1 FROM nhp_modelling.aae WHERE aekey = i.aekey);
