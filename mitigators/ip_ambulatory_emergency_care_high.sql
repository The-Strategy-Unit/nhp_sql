DROP VIEW IF EXISTS nhp_strategies.ip_ambulatory_emergency_care_high;
GO

CREATE VIEW nhp_strategies.ip_ambulatory_emergency_care_high
AS

SELECT
  i.*,
  'ambulatory_emergency_care_high' [strategy],
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
        i.SUSHRG LIKE 'DZ09[NPQ]'
      OR
        i.SUSHRG LIKE 'DZ28[AB]'
    ) AND (
        d.DIAGNOSIS LIKE 'I26[09]%'
      OR
        d.DIAGNOSIS LIKE 'R0[79]1%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'DZ16[QR]'
    ) AND (
        d.DIAGNOSIS LIKE 'C782%'
      OR
        d.DIAGNOSIS LIKE 'J9[01]X%'
      OR
        d.DIAGNOSIS LIKE 'J94[08]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'DZ22[PQ]'
    ) AND (
        d.DIAGNOSIS LIKE 'J20[0123456789X]%'
      OR
        d.DIAGNOSIS LIKE 'J22X%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'DZ19[LMN]'
      OR
        i.SUSHRG LIKE 'DZ25[KLM]'
      OR
        i.SUSHRG LIKE 'DZ27[TU]'
    ) AND (
        d.DIAGNOSIS LIKE 'E622%'
      OR
        d.DIAGNOSIS LIKE 'J80X%'
      OR
        d.DIAGNOSIS LIKE 'J84[0189]%'
      OR
        d.DIAGNOSIS LIKE 'J96[019]%'
      OR
        d.DIAGNOSIS LIKE 'J98[014689]%'
      OR
        d.DIAGNOSIS LIKE 'J998%'
      OR
        d.DIAGNOSIS LIKE 'Q340%'
      OR
        d.DIAGNOSIS LIKE 'R04[289]%'
      OR
        d.DIAGNOSIS LIKE 'R05X%'
      OR
        d.DIAGNOSIS LIKE 'R06[024]%'
      OR
        d.DIAGNOSIS LIKE 'R098%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'AA29[CDEF]'
    ) AND (
        d.DIAGNOSIS LIKE 'G45[0123489]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'AA26[EFGH]'
    ) AND (
        d.DIAGNOSIS LIKE 'R568%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'AA26[EFGH]'
    ) AND (
        d.DIAGNOSIS LIKE 'G253%'
      OR
        d.DIAGNOSIS LIKE 'G40[0123456789]%'
      OR
        d.DIAGNOSIS LIKE 'R568%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ36[NPQ]'
    ) AND (
        d.DIAGNOSIS LIKE 'A02[0289]%'
      OR
        d.DIAGNOSIS LIKE 'A04[45689]%'
      OR
        d.DIAGNOSIS LIKE 'A05[489]%'
      OR
        d.DIAGNOSIS LIKE 'A07[12]%'
      OR
        d.DIAGNOSIS LIKE 'A08[012345]%'
      OR
        d.DIAGNOSIS LIKE 'A09[09]%'
      OR
        d.DIAGNOSIS LIKE 'K52[01289]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ37[QRS]'
    ) AND (
        d.DIAGNOSIS LIKE 'K50[0189]%'
      OR
        d.DIAGNOSIS LIKE 'K51[023459]%%'
      OR
        d.DIAGNOSIS LIKE 'K523%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'GC1[27][JK]'
      OR
        i.SUSHRG LIKE 'GC01F'
    ) AND (
        d.DIAGNOSIS LIKE 'C22[012479]%'
        OR
          d.DIAGNOSIS LIKE 'C23[X3479]%'
        OR
          d.DIAGNOSIS LIKE 'C24[0189]%'
        OR
          d.DIAGNOSIS LIKE 'C25[01234789]%'
        OR
          d.DIAGNOSIS LIKE 'C787%'
        OR
          d.DIAGNOSIS LIKE 'D135%'
        OR
          d.DIAGNOSIS LIKE 'D376%'
        OR
          d.DIAGNOSIS LIKE 'K70[012349]%'
        OR
          d.DIAGNOSIS LIKE 'K72[019]%'
        OR
          d.DIAGNOSIS LIKE 'K73[01289]%'
        OR
          d.DIAGNOSIS LIKE 'K74[0123456]%'
        OR
          d.DIAGNOSIS LIKE 'K75[23489]%'
        OR
          d.DIAGNOSIS LIKE 'K76[01689]%'
        OR
          d.DIAGNOSIS LIKE 'K80[0123458]%'
        OR
          d.DIAGNOSIS LIKE 'K81[0189]%'
        OR
          d.DIAGNOSIS LIKE 'K82[123489]%'
        OR
          d.DIAGNOSIS LIKE 'K83[1489]%'
        OR
          d.DIAGNOSIS LIKE 'K86[012389]%'
        OR
          d.DIAGNOSIS LIKE 'K870%'
        OR
          d.DIAGNOSIS LIKE 'K915%'
        OR
          d.DIAGNOSIS LIKE 'R16[012]%'
        OR
          d.DIAGNOSIS LIKE 'R17X%'
        OR
          d.DIAGNOSIS LIKE 'R945%'
      )
    ) OR (
      (
          i.SUSHRG LIKE 'SA01[HJK]'
        OR
          i.SUSHRG LIKE 'SA03[H]'
        OR
          i.SUSHRG LIKE 'SA04[HJKL]'
        OR
          i.SUSHRG LIKE 'SA05[HJ]'
        OR
          i.SUSHRG LIKE 'SA06[HJK]'
        OR
          i.SUSHRG LIKE 'SA09[HJKL]'
    ) AND (
        d.DIAGNOSIS LIKE 'D46[012479]%'
      OR
        d.DIAGNOSIS LIKE 'D50[0189]%'
      OR
        d.DIAGNOSIS LIKE 'D51[012389]%'
      OR
        d.DIAGNOSIS LIKE 'D52[0189]%'
      OR
        d.DIAGNOSIS LIKE 'D531%'
      OR
        d.DIAGNOSIS LIKE 'D571%'
      OR
        d.DIAGNOSIS LIKE 'D58[01289]%'
      OR
        d.DIAGNOSIS LIKE 'D59[012489]%'
      OR
        d.DIAGNOSIS LIKE 'D64[89]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'KB01[CDEF]'
      OR
        i.SUSHRG LIKE 'KB02[HJK]'
      OR
        i.SUSHRG LIKE 'KB03[DE]'
    ) AND (
        d.DIAGNOSIS LIKE 'E1[01][0-9]%'
      OR
        d.DIAGNOSIS LIKE 'E1[34][2-9]%'
      OR
        d.DIAGNOSIS LIKE 'E16[012]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'JD07[HJK]'
    ) AND (
        d.DIAGNOSIS LIKE 'I891%'
      OR
        d.DIAGNOSIS LIKE 'L010%'
      OR
        d.DIAGNOSIS LIKE 'L03[012389]%'
      OR
        d.DIAGNOSIS LIKE 'L08[089]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ91[KLM]'
      OR
        i.SUSHRG LIKE 'FZ92[JK]'
    ) AND (
        d.DIAGNOSIS LIKE 'C15[01234589]%'
      OR
        d.DIAGNOSIS LIKE 'K22[0245789]%'
      OR
        d.DIAGNOSIS LIKE 'K238%'
      OR
        d.DIAGNOSIS LIKE 'R12X%'
      OR
        d.DIAGNOSIS LIKE 'R13X%'
      OR
        d.DIAGNOSIS LIKE 'T181%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'EB08[ABCDE]'
      OR
        i.SUSHRG LIKE 'WH16[AB]'
      OR
        i.SUSHRG LIKE 'WH09[EFG]'
    ) AND (
        d.DIAGNOSIS LIKE 'I951%'
      OR
        d.DIAGNOSIS LIKE 'R268%'
      OR
        d.DIAGNOSIS LIKE 'R296%'
      OR
        d.DIAGNOSIS LIKE 'R54X%'
      OR
        d.DIAGNOSIS LIKE 'R55X%'
      OR
        d.DIAGNOSIS LIKE 'T671%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ13C'
    ) AND (
        d.DIAGNOSIS LIKE 'R18X%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'HE21[FG]'
      OR
        i.SUSHRG LIKE 'HE22[GHJK]'
      OR
        i.SUSHRG LIKE 'HE31[EFG]'
      OR
        i.SUSHRG LIKE 'HE32[CDE]'
      OR
        i.SUSHRG LIKE 'HE51[EFGH]'
      OR
        i.SUSHRG LIKE 'HE52[CDEF]'
      OR
        i.SUSHRG LIKE 'HE41[BCD]'
      OR
        i.SUSHRG LIKE 'HE42[CDE]'
    ) AND (
        d.DIAGNOSIS LIKE 'S42[023489]%'
      OR
        d.DIAGNOSIS LIKE 'S43[0123]%'
      OR
        d.DIAGNOSIS LIKE 'S52[0-9]%'
      OR
        d.DIAGNOSIS LIKE 'S53[0123]%'
      OR
        d.DIAGNOSIS LIKE 'S62[0-8]%'
      OR
        d.DIAGNOSIS LIKE 'S63[02]%'
      OR
        d.DIAGNOSIS LIKE 'S67[08]%'
      OR
        d.DIAGNOSIS LIKE 'S72[4]%'
      OR
        d.DIAGNOSIS LIKE 'S82[0-9]%'
      OR
        d.DIAGNOSIS LIKE 'S83[0123]%'
      OR
        d.DIAGNOSIS LIKE 'S92[0-579]%'
      OR
        d.DIAGNOSIS LIKE 'S93[01]%'
      OR
        d.DIAGNOSIS LIKE 'S971%'
      OR
        d.DIAGNOSIS LIKE 'S9290%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'HE11[GH]'
      OR
        i.SUSHRG LIKE 'HE12[CDE]'
    ) AND (
        d.DIAGNOSIS LIKE 'M2555%'
      OR
        d.DIAGNOSIS LIKE 'S760%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ38[MNP]'
    ) AND (
        d.DIAGNOSIS LIKE 'K625%'
      OR
      d.DIAGNOSIS LIKE 'K922%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ91[KLM]'
      OR
        i.SUSHRG LIKE 'FZ22[DE]'
      OR
        i.SUSHRG LIKE 'FZ23A'
      OR
        i.SUSHRG LIKE 'FZ21D'
      OR
        i.SUSHRG LIKE 'JA13[BC]'
      OR
        i.SUSHRG LIKE 'JA4[45]Z'
    ) AND (
        d.DIAGNOSIS LIKE 'K61[0234]%'
      OR
        d.DIAGNOSIS LIKE 'K620%'
      OR
        d.DIAGNOSIS LIKE 'L02[0123489]%'
      OR
        d.DIAGNOSIS LIKE 'L05[09]%'
      OR
        d.DIAGNOSIS LIKE 'L72[01]%'
      OR
        d.DIAGNOSIS LIKE 'N61X%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'AA26[EFGH]'
      OR
        i.SUSHRG LIKE 'CB02[DEF]'
    ) AND (
        d.DIAGNOSIS LIKE 'S060%'
      OR
        d.DIAGNOSIS LIKE 'S09[89]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ91[KLM]'
    ) AND (
        d.DIAGNOSIS LIKE 'K563%'
      OR
        d.DIAGNOSIS LIKE 'K8[23]0%'
      OR
        d.DIAGNOSIS LIKE 'K80[012348]%'
      OR
        d.DIAGNOSIS LIKE 'K81[0189]%'
      OR
        d.DIAGNOSIS LIKE 'K83[189]%'
      OR
        d.DIAGNOSIS LIKE 'K82[489]%'
      OR
        d.DIAGNOSIS LIKE 'K83[19]%'
      OR
        d.DIAGNOSIS LIKE 'K870%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ91[KLM]'
      OR
        i.SUSHRG LIKE 'FZ18[JK]'
    ) AND (
        d.DIAGNOSIS LIKE 'K4[01][29]%'
      OR
        d.DIAGNOSIS LIKE 'K429%'
      OR
        d.DIAGNOSIS LIKE 'K43[259]%'
      OR
        d.DIAGNOSIS LIKE 'K458%'
      OR
        d.DIAGNOSIS LIKE 'K469%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'FZ22[DE]'
      OR
        i.SUSHRG LIKE 'FZ23A'
      OR
        i.SUSHRG LIKE 'FZ21D'
    ) AND (
        d.DIAGNOSIS LIKE 'K594%'
      OR
        d.DIAGNOSIS LIKE 'K60[01235]%'
      OR
        d.DIAGNOSIS LIKE 'T185%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'LB16[GHJK]'
      OR
        i.SUSHRG LIKE 'LB28[EFG]'
    ) AND (
        d.DIAGNOSIS LIKE 'N39[134]%'
      OR
        d.DIAGNOSIS LIKE 'R3[23]X%'
      OR
        d.DIAGNOSIS LIKE 'R33X%'
      OR
        d.DIAGNOSIS LIKE 'N320%'
      OR
        d.DIAGNOSIS LIKE 'N40X%'
      OR
        d.DIAGNOSIS LIKE 'N42[89]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'LB40[EFG]'
    ) AND (
        d.DIAGNOSIS LIKE 'N20[0129]%'
      OR
        d.DIAGNOSIS LIKE 'N21[0189]%'
      OR
        d.DIAGNOSIS LIKE 'N23X%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'LA09[PQ]'
      OR
        i.SUSHRG LIKE 'LB37[CDE]'
      OR
        i.SUSHRG LIKE 'LB38[FGH]'
    ) AND (
        d.DIAGNOSIS LIKE 'R30[09]%'
      OR
        d.DIAGNOSIS LIKE 'R31X%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'LB15[E]'
      OR
        i.SUSHRG LIKE 'LB20[EFG]'
      OR
        i.SUSHRG LIKE 'LB18[Z]'
    ) AND (
        d.DIAGNOSIS LIKE 'T83[0135689]%'
    )
  ) OR (
    (
        i.SUSHRG LIKE 'LB35[EFGH]'
      OR
        i.SUSHRG LIKE 'LB54A'
    ) AND (
        d.DIAGNOSIS LIKE 'N43[01234]%'
      OR
        d.DIAGNOSIS LIKE 'N44X%'
      OR
        d.DIAGNOSIS LIKE 'N45[09X]%'
      OR
        d.DIAGNOSIS LIKE 'N49[01289]%'
      OR
        d.DIAGNOSIS LIKE 'N508%'
    )
  )
);

GO