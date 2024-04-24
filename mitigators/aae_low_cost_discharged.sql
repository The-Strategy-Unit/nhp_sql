DROP VIEW IF EXISTS nhp_strategies.aae_low_cost_discharged;
GO

CREATE VIEW nhp_strategies.aae_low_cost_discharged
AS

SELECT
  aekey,
  fyear,
  activage [age],
  sex,
  'low_cost_discharged-' +
    IIF(activage >= 18, 'adult', 'child') + '_' +
    IIF(aearrivalmode = '1', 'ambulance', 'walk-in')
    [strategy],
  is_low_cost_referred_or_discharged [fraction]
FROM
  nhp_modelling.aae;

GO