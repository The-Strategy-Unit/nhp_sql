DROP VIEW IF EXISTS nhp_strategies.ip_evidence_based_interventions_msk
GO

CREATE VIEW nhp_strategies.ip_evidence_based_interventions_msk
AS


-- arthroscopic_meniscal_tear
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'W82%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M23[23]%'
      OR
        d.DIAGNOSIS LIKE 'S832%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- arthroscopic_shoulder_compression
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'O291%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER > 1
    AND (
        p.OPCODE LIKE 'Y767%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M754%'
      OR
        d.DIAGNOSIS LIKE 'M2551%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- back_injections
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'A52[1289]%'
      OR
        p.OPCODE LIKE 'A577%'
      OR
        p.OPCODE LIKE 'A735%'
      OR
        p.OPCODE LIKE 'V544%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER > 1
    AND (
        p.OPCODE LIKE 'Z67[567]%'
      OR
        p.OPCODE LIKE 'Z993%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M51[89]%'
      OR
        d.DIAGNOSIS LIKE 'M54[59]%'
    )
  )
AND
  NOT EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND (
          d.DIAGNOSIS LIKE 'C%'
        OR
          d.DIAGNOSIS LIKE 'D0%'
        OR
          d.DIAGNOSIS LIKE 'D3[7-9]%'
        OR
          d.DIAGNOSIS LIKE 'D4[0-8]%'
      )
    )

UNION

-- dupuytrens_release
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'A65[19]%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'G560%'
    )
  )
AND
  NOT EXISTS(
      SELECT 1 FROM
        dbo.tbInpatientsDiagnoses d
      WHERE
        i.EPIKEY = d.EPIKEY
      AND (
          d.DIAGNOSIS LIKE 'C%'
        OR
          d.DIAGNOSIS LIKE 'D0%'
        OR
          d.DIAGNOSIS LIKE 'D3[7-9]%'
        OR
          d.DIAGNOSIS LIKE 'D4[0-8]%'
      )
    )

UNION

-- fusion_surgery
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'V38[23456]%'
      OR
        p.OPCODE LIKE 'V404%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M54[59]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER > 1
    AND (
        d.DIAGNOSIS LIKE 'M40[012]%'
      OR
        d.DIAGNOSIS LIKE 'M41[0-589]%'
      OR
        d.DIAGNOSIS LIKE 'M42[019]%'
      OR
        d.DIAGNOSIS LIKE 'M43[01589]%'
      OR
        d.DIAGNOSIS LIKE 'M872%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- ganglion
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'T59[1289]%'
      OR
        p.OPCODE LIKE 'T60[1289]%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M674%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- knee_arthroscopy_1
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'W82[12389]%'
      OR
        p.OPCODE LIKE 'W85[12389]%'
      OR
        p.OPCODE LIKE 'W879%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M1[57]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- knee_arthroscopy_2
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'W83%'
      OR
        p.OPCODE LIKE 'W84[12349]%'
      OR
        p.OPCODE LIKE 'W861%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER > 1
    AND (
        p.OPCODE LIKE 'O132%'
      OR
        p.OPCODE LIKE 'Z846%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M1[57]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- knee_arthroscopy_3
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'W901%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER > 1
    AND (
        p.OPCODE LIKE 'O132%'
      OR
        p.OPCODE LIKE 'Z12[123]%'
      OR
        p.OPCODE LIKE 'Z504%'
      OR
        p.OPCODE LIKE 'Z577%'
      OR
        p.OPCODE LIKE 'Z58%'
      OR
        p.OPCODE LIKE 'Z77[12489]%'
      OR
        p.OPCODE LIKE 'Z78[1236-9]%'
      OR
        p.OPCODE LIKE 'Z84[456]%'
      OR
        p.OPCODE LIKE 'Z851%'
      OR
        p.OPCODE LIKE 'Z905%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M1[57]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- lumbar_disectomy
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'V33%'
      OR
        p.OPCODE LIKE 'V35[189]%'
      OR
        p.OPCODE LIKE 'V51[189]%'
      OR
        p.OPCODE LIKE 'V52[12589]%'
      OR
        p.OPCODE LIKE 'V58[389]%'
      OR
        p.OPCODE LIKE 'V60[389]%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND (
        p.OPCODE LIKE 'V55[12389]%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M51[01]%'
      OR
        d.DIAGNOSIS LIKE 'M54[134]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- radio_frequency_denervation
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'V48[57]%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND (
        p.OPCODE LIKE 'Z67[5-7]%'
      OR
        p.OPCODE LIKE 'Z993%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M51[89]%'
      OR
        d.DIAGNOSIS LIKE 'M54[59]%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- trigger_finger
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'T69[1289]%'
      OR
        p.OPCODE LIKE 'T70[12]%'
      OR
        p.OPCODE LIKE 'T71[189]%'
      OR
        p.OPCODE LIKE 'T72[389]%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER > 1
    AND (
        p.OPCODE LIKE 'Z56[489]%'
      OR
        p.OPCODE LIKE 'Z82[49]%'
      OR
        p.OPCODE LIKE 'Z839%'
      OR
        p.OPCODE LIKE 'Z89[457]%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M653%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

UNION

-- vertebral_augmentation
SELECT
  i.*,
  'evidence_based_interventions_msk' [strategy],
  1 [fraction]
FROM
  nhp_modelling.inpatients i
WHERE
  i.ADMIMETH LIKE '1%'
AND
  i.AGE BETWEEN 19 AND 120
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER = 1
    AND (
        p.OPCODE LIKE 'V444%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsProcedures p
    WHERE
      i.EPIKEY = p.EPIKEY
    AND
          p.OPORDER > 1
    AND (
        p.OPCODE LIKE 'V55%'
    )
  )
AND
  EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND
      d.DIAGORDER = 1
    AND (
        d.DIAGNOSIS LIKE 'M80%'
    )
  )
AND
  NOT EXISTS(
    SELECT 1 FROM
      dbo.tbInpatientsDiagnoses d
    WHERE
      i.EPIKEY = d.EPIKEY
    AND (
        d.DIAGNOSIS LIKE 'C%'
      OR
        d.DIAGNOSIS LIKE 'D0%'
      OR
        d.DIAGNOSIS LIKE 'D3[7-9]%'
      OR
        d.DIAGNOSIS LIKE 'D4[0-8]%'
    )
  )

;

GO
