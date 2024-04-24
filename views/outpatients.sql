DROP VIEW IF EXISTS [nhp_modelling].[outpatients];
DROP VIEW IF EXISTS [nhp_modelling].[outpatients_diagnoses];
DROP VIEW IF EXISTS [nhp_modelling].[outpatients_procedures];
GO

CREATE VIEW [nhp_modelling].[outpatients] AS
SELECT
    o.attendkey,
    o.fyear,
    person_id = mpsid.tokenid,
    CASE WHEN apptage >= 7000 THEN 0 ELSE apptage END apptage,
    sex,
    ethnos,
    imd04_decile,
    mainspef,
    tretspef,
    apptdate,
    refsourc,
    firstatt,
    CASE sitetret
        -- Pennine Acute Hospitals NHS Trust (RW6) was succeeded by Northern Care Alliance (RM3) in 2019
        -- However: one site (North Manchester General Hospital) was aquired by Manchester University
        -- NHS Foundation Trust (R0A) in 2021
        WHEN 'RW602' THEN 'R0A' WHEN 'RM318' THEN 'R0A'
        ELSE s.new_code
    END procode3,
    sitetret,
    icb.icb22cdh,
    CASE icb.icb22cdh WHEN p.icb22cdh THEN 1 ELSE 0 END is_main_icb,
    sushrg,
    -- calculated columns
    is_surgical_specialty = CASE
        WHEN tretspef IN ('180', '190', '191', '192') THEN 0
        WHEN tretspef LIKE '1%' THEN 1
        ELSE 0
    END,
    is_adult = CASE
        WHEN apptage >= 7000 THEN 0
        WHEN apptage >= 18 THEN 1
        ELSE 0
    END,
    is_gp_ref = CASE
        WHEN refsourc = '03' AND firstatt IN ('1', '3') THEN 1
        ELSE 0
    END,
    is_cons_cons_ref = CASE
        WHEN refsourc = '05' AND firstatt IN ('1', '3') AND sushrg LIKE 'WF0[12]B' THEN 1
        ELSE 0
    END,
    is_first = CASE atentype
        WHEN  '1' THEN 1
        WHEN  '2' THEN 0
        WHEN '21' THEN 1
        WHEN '22' THEN 0
        ELSE NULL
    END,
    is_tele_appointment = CASE atentype
        WHEN  '1' THEN 0
        WHEN  '2' THEN 0
        WHEN '21' THEN 1
        WHEN '22' THEN 1
        ELSE NULL
    END,
    has_procedures = CASE WHEN EXISTS (
        SELECT 1
        FROM   tbOutpatientsProcedures p
        WHERE  o.attendkey = p.attendkey
        AND    p.opcode NOT LIKE '[UYZ]%'
        AND    o.atentype NOT LIKE '2%'
    ) THEN 1 ELSE 0 END
FROM
    tbOutpatients o
INNER JOIN
    dbo.tbOutpatients_MPSID mpsid
    ON
      o.FYEAR = mpsid.FYEAR
    AND
      o.ORIG_ATTENDKEY = mpsid.attendkey
LEFT JOIN
    nhp_modelling_reference.ccg_to_icb icb
    ON
        o.ccg_residence = icb.ccg
INNER JOIN
    nhp_modelling.provider_successors s
    ON
        o.procode3 = s.old_code
INNER JOIN
    nhp_modelling.provider_main_icb p
    ON
        s.new_code = p.procode
WHERE
    o.fyear BETWEEN 201011 AND 201920
AND
    SEX IN ('1', '2')
AND
    atentype IN ('1', '2', '3', '21', '22');

GO

CREATE VIEW [nhp_modelling].[outpatients_diagnoses] AS
SELECT i.attendkey, i.diagorder, i.diagnosis
FROM   dbo.tbOutpatientsDiagnoses i
WHERE  EXISTS (SELECT 1 FROM nhp_modelling.outpatients WHERE attendkey = i.attendkey);

GO

CREATE VIEW [nhp_modelling].[outpatients_procedures] AS
SELECT i.attendkey, i.oporder, i.opcode
FROM   dbo.tbOutpatientsProcedures i
WHERE  EXISTS (SELECT 1 FROM nhp_modelling.outpatients WHERE attendkey = i.attendkey);
