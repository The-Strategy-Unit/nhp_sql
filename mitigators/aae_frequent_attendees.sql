DROP VIEW IF EXISTS nhp_strategies.aae_frequent_attendees;
GO

CREATE VIEW nhp_strategies.aae_frequent_attendees;
AS
SELECT
  a.*
FROM
  nhp_modelling.aae a
INNER JOIN
  -- use full table as we need all years history
  (
      dbo.tbAandE b
    INNER JOIN
      dbo.tbAandE_MPSID b_mpsid
      ON
        b.fyear = b_mpsid.fyear
      AND
        b.orig_aekey = b_mpsid.aekey
  )
  ON
    a.person_id = b_mpsid.tokenid
  AND
    b.aeattendcat = '1'
WHERE
  DATEADD(YY, 1, b.arrivaldate) >= a.arrivaldate
AND
  b.arrivaldate < a.arrivaldate
GROUP BY
  a.aekey
HAVING
  COUNT(*) >= 3;
GO
