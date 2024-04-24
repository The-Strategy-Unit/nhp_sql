DROP VIEW IF EXISTS nhp_strategies.op_tele_conversion
GO

CREATE VIEW nhp_strategies.op_tele_conversion
AS

SELECT
  attendkey,
  fyear,
  apptage [age],
  sex,
  'tele_conversion-' +
    IIF(is_adult = 1, 'adult', 'child') + '_' +
    IIF(is_surgical_specialty = 1, 'non-', '') + 'surgical'
    [strategy],
  1 - is_tele_appointment [fraction]
FROM
  nhp_modelling.outpatients o;

GO
