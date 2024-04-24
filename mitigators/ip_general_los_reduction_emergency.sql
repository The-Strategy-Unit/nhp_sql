DROP VIEW IF EXISTS nhp_strategies.ip_general_los_reduction_emergency;
GO

CREATE VIEW nhp_strategies.ip_general_los_reduction_emergency
AS
SELECT
    i.*,
    'general_los_reduction_emergency' [strategy],
    1.0 [fraction]
FROM
    nhp_modelling.inpatients i
WHERE
    i.ADMIMETH LIKE '2%'
AND
    i.CLASSPAT = '1';
GO