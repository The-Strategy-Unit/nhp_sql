DROP VIEW IF EXISTS nhp_strategies.aae_left_before_treatment;
GO

CREATE VIEW nhp_strategies.aae_left_before_treatment
AS

SELECT
  aekey,
  fyear,
  activage [age],
  sex,
  'left_before_treatment-' +
    IIF(activage >= 18, 'adult', 'child') + '_' +
    IIF(aearrivalmode = '1', 'ambulance', 'walk-in')
    [strategy],
  is_left_before_treatment [fraction]
FROM
  nhp_modelling.aae;

GO
