DROP VIEW IF EXISTS nhp_strategies.ip_excess_beddays
GO

CREATE VIEW nhp_strategies.ip_excess_beddays
AS
SELECT
  i.*,
  'excess_beddays_elective' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
INNER JOIN
  nhp_modelling_reference.hrg_trimpoints t
  ON
    i.SUSHRG = t.sushrg
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.SPELDUR > t.elective
UNION ALL
SELECT
  i.*,
  'excess_beddays_emergency' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
INNER JOIN
  nhp_modelling_reference.hrg_trimpoints t
  ON
    i.SUSHRG = t.sushrg
WHERE
  i.ADMIMETH LIKE '2%'
AND
  i.SPELDUR > t.emergency
;
GO
