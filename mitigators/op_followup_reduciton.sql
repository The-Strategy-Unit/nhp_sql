DROP VIEW IF EXISTS nhp_strategies.op_followup_reduction
GO

CREATE VIEW nhp_strategies.op_followup_reduction
AS

SELECT
  attendkey,
  fyear,
  apptage [age],
  sex,
  'followup_reduction-' +
    IIF(is_adult = 1, 'adult', 'child') + '_' +
    IIF(is_surgical_specialty = 1, '', 'non-') + 'surgical'
    [strategy],
  1 - is_first [fraction]
FROM
  nhp_modelling.outpatients o
WHERE
  is_tele_appointment = 0;

GO