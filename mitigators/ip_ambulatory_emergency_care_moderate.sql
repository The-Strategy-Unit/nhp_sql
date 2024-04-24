DROP VIEW IF EXISTS nhp_strategies.ip_ambulatory_emergency_care_moderate;
GO

CREATE VIEW nhp_strategies.ip_ambulatory_emergency_care_moderate
AS

SELECT
  i.*,
  'ambulatory_emergency_care_moderate' [strategy],
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
        i.SUSHRG LIKE 'EB03[DE]'
    ) AND (
        d.DIAGNOSIS LIKE 'I110%'
      OR
        d.DIAGNOSIS LIKE 'I13[02]%'
      OR
        d.DIAGNOSIS LIKE 'I50[019]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'EB07[BCDE]'
    ) AND (
        d.DIAGNOSIS LIKE 'I144[014567]%'
      OR
        d.DIAGNOSIS LIKE 'I145[0-9]%'
      OR
        d.DIAGNOSIS LIKE 'I147[19]%'
      OR
        d.DIAGNOSIS LIKE 'I148[012349]%'
      OR
        d.DIAGNOSIS LIKE 'I149[124589]%'
      OR
        d.DIAGNOSIS LIKE 'R00[0128]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'EB14[CDE]'
      OR
        i.SUSHRG LIKE 'EB10[CDE]'
      OR
        i.SUSHRG LIKE 'EB12[ABC]'
      OR
        i.SUSHRG LIKE 'EB13[ABCD]'
      OR
        i.SUSHRG LIKE 'DZ28[AB]'
    ) AND (
        d.DIAGNOSIS LIKE 'I20[189]%'
      OR
        d.DIAGNOSIS LIKE 'I24[189]%'
      OR
        d.DIAGNOSIS LIKE 'I25[012689]%'
      OR
        d.DIAGNOSIS LIKE 'M94[01]%'
      OR
        d.DIAGNOSIS LIKE 'R01[12]%'
      OR
        d.DIAGNOSIS LIKE 'R07[234]%'
      OR
        d.DIAGNOSIS LIKE 'R091%'
      OR
        d.DIAGNOSIS LIKE 'Z03[45]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'AA31[CDE]'
    ) AND (
        d.DIAGNOSIS LIKE 'G43[012389]%'
      OR
        d.DIAGNOSIS LIKE 'G44[01348]%'
      OR
        d.DIAGNOSIS LIKE 'G971%'
      OR
        d.DIAGNOSIS LIKE 'R51X%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'LA04[QRS]'
    ) AND (
        d.DIAGNOSIS LIKE 'N11[0189]%'
      OR
        d.DIAGNOSIS LIKE 'N136%'
      OR
        d.DIAGNOSIS LIKE 'N30[0123489%'
      OR
        d.DIAGNOSIS LIKE 'N304[123]%'
      OR
        d.DIAGNOSIS LIKE 'N390%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'KC05[KLMN]'
    ) AND (
        d.DIAGNOSIS LIKE 'E222%'
      OR
        d.DIAGNOSIS LIKE 'E612%'
      OR
        d.DIAGNOSIS LIKE 'E83[45]%'
      OR
        d.DIAGNOSIS LIKE 'E86X%'
      OR
        d.DIAGNOSIS LIKE 'E87[015678]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'LA07[NP]'
    ) AND (
        d.DIAGNOSIS LIKE 'N17[89]%'
      OR
        d.DIAGNOSIS LIKE 'N990%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'HD23[FDHJ]'
      OR
        i.SUSHRG LIKE 'HD26[DEFG]'
    ) AND (
        d.DIAGNOSIS LIKE 'M20[0-389]%'
      OR
        d.DIAGNOSIS LIKE 'M05[089]%'
      OR
        d.DIAGNOSIS LIKE 'M06[0-489]%'
      OR
        d.DIAGNOSIS LIKE 'M10[02-49]%'
      OR
        d.DIAGNOSIS LIKE 'M10[0-9]%'
      OR
        d.DIAGNOSIS LIKE 'M1[13][09]%'
      OR
        d.DIAGNOSIS LIKE 'M13[0-9]%'
      OR
        d.DIAGNOSIS LIKE 'M25[569]%'
      OR
        d.DIAGNOSIS LIKE 'M66[01]%'
      OR
        d.DIAGNOSIS LIKE 'M673%'
      OR
        d.DIAGNOSIS LIKE 'M712%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'GC18[AB]'
    ) AND (
        d.DIAGNOSIS LIKE 'C23X%'
      OR
        d.DIAGNOSIS LIKE 'C24[0189]%'
      OR
        d.DIAGNOSIS LIKE 'C25[0139]%'
      OR
        d.DIAGNOSIS LIKE 'D135%'
      OR
        d.DIAGNOSIS LIKE 'D376%'
      OR
        d.DIAGNOSIS LIKE 'K805%'
      OR
        d.DIAGNOSIS LIKE 'K82[123489]%'
      OR
        d.DIAGNOSIS LIKE 'K83[19]%'
      OR
        d.DIAGNOSIS LIKE 'K870%'
      OR
        d.DIAGNOSIS LIKE 'R17X%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ90B'
    ) AND (
        d.DIAGNOSIS LIKE 'I880%'
      OR
        d.DIAGNOSIS LIKE 'K255%'
      OR
        d.DIAGNOSIS LIKE 'K297%'
      OR
        d.DIAGNOSIS LIKE 'K56[346]%'
      OR
        d.DIAGNOSIS LIKE 'K569[0189]%'
      OR
        d.DIAGNOSIS LIKE 'K913%'
      OR
        d.DIAGNOSIS LIKE 'N832%'
      OR
        d.DIAGNOSIS LIKE 'N940%'
      OR
        d.DIAGNOSIS LIKE 'R10[1234]%'
      OR
        d.DIAGNOSIS LIKE 'R11X%'
      OR
        d.DIAGNOSIS LIKE 'R19[01458]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ91][KLM]'
      OR
        i.SUSHRG LIKE 'FZ20[HJ]'
    ) AND (
        d.DIAGNOSIS LIKE 'K35[38]%'
      OR
        d.DIAGNOSIS LIKE 'K37X%'
      OR
        d.DIAGNOSIS LIKE 'K500%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ91[KLM]'
      OR
        i.SUSHRG LIKE 'MB09[EF]'
    ) AND (
        d.DIAGNOSIS LIKE 'K562%'
      OR
        d.DIAGNOSIS LIKE 'K57[1359]%'
      OR
        d.DIAGNOSIS LIKE 'N739%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'NZ18[AB]'
      OR
        i.SUSHRG LIKE 'NZ19[AB]'
      OR
        i.SUSHRG LIKE 'NZ20[AB]'
    ) AND (
        d.DIAGNOSIS LIKE 'O21[01289]%'
    )
  )
);

GO