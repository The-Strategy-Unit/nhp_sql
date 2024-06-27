DROP VIEW IF EXISTS nhp_strategies.op_consultant_to_consultant_referrals;
GO

CREATE VIEW nhp_strategies.op_consultant_to_consultant_referrals
AS

SELECT
  attendkey,
  fyear,
  apptage [age],
  sex,
  'consultant_to_consultant_referrals-' +
    IIF(is_adult = 1, 'adult', 'child') + '_' +
    IIF(is_surgical_specialty = 1, '', 'non-') + 'surgical'
    [strategy],
  is_cons_cons_ref [fraction]
FROM
  nhp_modelling.outpatients o
WHERE
  is_tele_appointment = 0;

GO