DROP VIEW IF EXISTS nhp_strategies.ip_ambulatory_emergency_care_very_high;
GO

CREATE VIEW nhp_strategies.ip_ambulatory_emergency_care_very_high
AS

SELECT
  i.*,
  'ambulatory_emergency_care_very_high' [strategy],
  IIF(i.SPELDUR > 0, 1, 0) [fraction]
FROM
  nhp_modelling.inpatients i
INNER JOIN
  dbo.tbInpatientsDiagnoses d
  ON
    i.EPIKEY = d.EPIKEY
  AND
    d.DIAGORDER = 1
WHERE
  i.AGE >= 18
AND
  i.ADMIMETH LIKE '2[123]'
AND (
  (
    (
        i. SUSHRG LIKE 'YQ51[CDE]'
    ) AND (
        d.DIAGNOSIS LIKE 'I80[123]%'
      OR
        d.DIAGNOSIS LIKE 'I822%'
      OR
        d.DIAGNOSIS LIKE 'M79[68]%'
    )
  ) OR (
    (
        i. SUSHRG LIKE 'FZ91[KLM]'
    ) AND (
        d. DIAGNOSIS LIKE 'T85[58]'
      OR
        d. DIAGNOSIS LIKE 'Z431'
      )
  ) OR (
    (
        i. SUSHRG LIKE 'HC27[LMN]'
      OR
       i. SUSHRG LIKE 'HD39[GH]'
    ) AND (
        d.DIAGNOSIS LIKE 'M80[01234589]%'
      OR
        d.DIAGNOSIS LIKE 'M80[0589][89]%'
      OR
        d.DIAGNOSIS LIKE 'M84[34]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'HE11[GH]'
      OR
        i.SUSHRG LIKE 'HE12[CDE]'
    ) AND (
        d.DIAGNOSIS LIKE 'S325%'
      OR
        d.DIAGNOSIS LIKE 'S3250%'
    )
  ) OR (
    (
        i. SUSHRG LIKE 'FZ22[DE]'
      OR
        i. SUSHRG LIKE 'FZ23A'
      OR
        i. SUSHRG LIKE 'FZ21D'
    ) AND (
        d.DIAGNOSIS LIKE 'K64[12389]%'
      OR
        d.DIAGNOSIS LIKE 'O224%'
      OR
        d.DIAGNOSIS LIKE 'O872%'
    )
  ) OR (
    (
        i. SUSHRG LIKE 'MB08B'
    ) AND (
        d.DIAGNOSIS LIKE 'O02[0189]%'
      OR
        d.DIAGNOSIS LIKE 'O03[1-9]%'
      OR
        d.DIAGNOSIS LIKE 'O05[49]%'
      OR
        d.DIAGNOSIS LIKE 'O06[49]%'
      OR
        d.DIAGNOSIS LIKE 'O20[089]%')
  ) OR (
    (
        i.SUSHRG LIKE 'MA2[23]Z'
      OR
        i.SUSHRG LIKE 'MB09[DEF]'
    ) AND (
        d.DIAGNOSIS LIKE 'N75[0189]%'
    )
  )
);

GO