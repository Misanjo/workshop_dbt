

SELECT
    (SELECT COUNT(*) FROM dbt_audit) AS total_audit;

SELECT 'db_audit' AS tabla, * FROM dbt_audit order by run_started_at desc LIMIT 5;
