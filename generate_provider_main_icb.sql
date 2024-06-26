USE HESData;
GO

DROP PROCEDURE IF EXISTS [nhp_modelling].[generate_provider_main_icb];
GO

CREATE PROCEDURE [nhp_modelling].[generate_provider_main_icb] AS

TRUNCATE TABLE nhp_modelling.provider_main_icb;

INSERT INTO nhp_modelling.provider_main_icb
SELECT
    procode3,
    icb22cdh
FROM (
    SELECT
        c.icb22cdh,
        procode3 = s.new_code,
        COUNT(*) n,
        RANK () OVER (PARTITION BY s.new_code ORDER BY COUNT(*) DESC) [n_rank]
    FROM
        dbo.tbInpatients i
    INNER JOIN
        nhp_modelling_reference.ccg_to_icb c
        ON
            i.CCG_RESIDENCE = c.ccg
    INNER JOIN
        nhp_modelling.provider_successors s
        ON
            i.procode3 = s.old_code
    WHERE
        i.FYEAR = 201920
    AND
        s.new_code LIKE 'R%'
    GROUP BY
        c.icb22cdh,
        s.new_code
) t
WHERE t.n_rank = 1;
GO

EXEC nhp_modelling.generate_provider_main_icb;
GO
