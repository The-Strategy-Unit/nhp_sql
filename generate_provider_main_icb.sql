USE HESData;
GO

DROP PROCEDURE IF EXISTS [nhp_modelling].[generate_provider_main_icb];
GO

CREATE PROCEDURE [nhp_modelling].[generate_provider_main_icb] AS

TRUNCATE TABLE nhp_modelling.provider_main_icb;

INSERT INTO nhp_modelling.provider_main_icb
SELECT
    PROCODE3,
    icb22cdh
FROM (
    SELECT
        c.icb22cdh,
        i.PROCODE3,
        COUNT(*) n,
        RANK () OVER (PARTITION BY i.PROCODE3 ORDER BY COUNT(*) DESC) [n_rank]
    FROM
        dbo.tbInpatients i
    INNER JOIN
        nhp_modelling_reference.ccg_to_icb c
        ON
            i.CCG_RESIDENCE = c.ccg
    WHERE
        i.FYEAR = 201920
    AND
        i.PROCODE3 LIKE 'R%'
    GROUP BY
        c.icb22cdh,
        i.PROCODE3
) t
WHERE t.n_rank = 1;
GO

EXEC nhp_modelling.generate_provider_main_icb;
GO
