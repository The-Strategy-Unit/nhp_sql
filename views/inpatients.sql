USE HESData;
GO

DROP VIEW IF EXISTS [nhp_modelling].[inpatients];
DROP VIEW IF EXISTS [nhp_modelling].[inpatients_diagnoses];
DROP VIEW IF EXISTS [nhp_modelling].[inpatients_procedures];
GO


CREATE VIEW [nhp_modelling].[inpatients]
AS
SELECT
    i.EPIKEY,
    i.FYEAR,
    person_id = i_mpsid.tokenid,
    i.ADMIAGE,
    CASE
        WHEN (i.ADMIAGE = 999 OR i.ADMIAGE IS NULL)
            THEN IIF(i.STARTAGE > 7000, 0, i.STARTAGE)
        ELSE i.ADMIAGE
    END AGE,
    i.SEX,
    i.ETHNOS,
    i.IMD04_DECILE,
    i.CLASSPAT,
    i.MAINSPEF,
    i.TRETSPEF,
    i.ADMIDATE,
    i.DISDATE,
    i.SPELDUR,
    i.EPITYPE,
    i.ADMIMETH,
    i.DISMETH,
    CASE i.SITETRET
        -- Pennine Acute Hospitals NHS Trust (RW6) was succeeded by Northern Care Alliance (RM3) in 2019
        -- However: one site (North Manchester General Hospital) was aquired by Manchester University
        -- NHS Foundation Trust (R0A) in 2021
        WHEN 'RW602' THEN 'R0A' WHEN 'RM318' THEN 'R0A'
        ELSE s.new_code
    END PROCODE3,
    i.PROCODE3 [original_provider],
    i.SITETRET,
    i.LSOA11,
    i.RESLADST_ONS,
    i.SUSHRG,
    i.OPERSTAT,
    icb.icb22cdh,
    CASE icb.icb22cdh WHEN p.icb22cdh THEN 1 ELSE 0 END is_main_icb,
    CASE WHEN EXISTS (
        SELECT 1 FROM
            dbo.tbInpatientsProcedures p
        WHERE
            i.EPIKEY = p.EPIKEY
        AND
            p.OPCODE LIKE '[^U-Z]%'
        AND
            p.OPORDER = 1
    )
        THEN 1
        ELSE 0
    END [has_procedure]
FROM
    dbo.tbInpatients i
LEFT JOIN
    dbo.tbInpatients_MPSID i_mpsid
    ON
      i.FYEAR = i_mpsid.FYEAR
    AND
      i.ORIG_HES_EPIKEY = i_mpsid.EPIKEY
LEFT JOIN
    nhp_modelling_reference.ccg_to_icb icb
    ON
        i.CCG_RESIDENCE = icb.ccg
LEFT JOIN
    nhp_modelling.provider_successors s
    ON
        i.PROCODE3 = s.old_code
LEFT JOIN
    nhp_modelling.provider_main_icb p
    ON
        s.new_code = p.procode
WHERE
    i.SEX IN ('1', '2')
AND
    EXISTS(
        SELECT 1
        FROM   tbInpatientsSpellEnd
        WHERE  i.EPIKEY = EPIKEY
    )
AND
    -- the table above only works from 2008/09 onwards
    i.FYEAR >= 200809
AND
    -- remove well babies babies
    NOT (
            -- neonatal level of care is 0
            i.WELL_BABY_IND = 'Y'
        OR
            -- healthy baby HRG
            i.SUSHRG = 'PB03Z'
        OR
        (
            -- well baby specialty on a birth episode
                i.TRETSPEF = '424'
            AND
                i.EPITYPE = '3'
        )
    );

GO

CREATE VIEW [nhp_modelling].[inpatients_diagnoses] AS
SELECT
  i.FYEAR,
  i.EPIKEY,
  i.DIAGORDER,
  CASE
    WHEN i.DIAGNOSIS LIKE '____[0-9]%' THEN LEFT(i.DIAGNOSIS, 5)
    ELSE LEFT(i.DIAGNOSIS, 4)
  END [DIAGNOSIS]
FROM   dbo.tbInpatientsDiagnoses i
WHERE  EXISTS (SELECT 1 FROM nhp_modelling.inpatients WHERE EPIKEY = i.EPIKEY);

GO

CREATE VIEW [nhp_modelling].[inpatients_procedures] AS
SELECT i.FYEAR, i.EPIKEY, i.OPORDER, i.OPDATE, i.OPCODE
FROM   dbo.tbInpatientsProcedures i
WHERE  EXISTS (SELECT 1 FROM nhp_modelling.inpatients WHERE EPIKEY = i.EPIKEY);
