DROP VIEW IF EXISTS nhp_strategies.general_los_reduction_elective;
GO

CREATE VIEW nhp_strategies.general_los_reduction_elective
AS
SELECT
    i.*,
    'general_los_reduction_elective' [strategy],
    1.0 [fraction]
FROM
    nhp_modelling.inpatients i
WHERE
    i.ADMIMETH LIKE '1%'
AND
    i.CLASSPAT = '1';
GO