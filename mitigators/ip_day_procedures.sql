DROP VIEW IF EXISTS nhp_strategies.ip_day_procedures;
GO

CREATE VIEW nhp_strategies.ip_day_procedures
AS
SELECT
    i.*,
    N'day_procedures_' + d.[type] [strategy],
    1 [fraction]
FROM
    nhp_modelling.inpatients i
INNER JOIN
    nhp_modelling.inpatients_procedures p
    ON
        i.EPIKEY = p.EPIKEY
INNER JOIN
    nhp_modelling_reference.day_procedure_opcs_codes d
    ON
        p.OPCODE = d.procedure_code
WHERE
    p.OPORDER = 1
AND
    i.ADMIMETH LIKE '1%'
AND
    -- if the admission is a daycase, only include the "op" types
    -- if it's an overnight admission, include all types
    (
            (i.CLASSPAT = '1')
        OR
            (i.CLASSPAT = '2' AND d.[type] LIKE '%op')
    );

GO