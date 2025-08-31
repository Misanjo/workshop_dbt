

SELECT
    audit_id,
    run_started_at,
    run_completed_at,
    execution_time_seconds,
    dbt_version,
    dbt_command,
    run_status,
    models_processed,
    tests_executed,
    rows_affected,
    artifacts_generated,
    environment,
    target_name,
    target_schema,
    target_database,
    error_message,
    created_at
FROM "dev"."main"."dbt_audit"
ORDER BY run_started_at DESC