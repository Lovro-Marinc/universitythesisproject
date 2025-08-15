/*
====| LIST CONSTRAINTS
*/
WITH  CONSLIST AS (
    SELECT
        fk.name AS ForeignKeyName,
        OBJECT_SCHEMA_NAME(fk.parent_object_id) AS ChildSchema,
        OBJECT_NAME(fk.parent_object_id) AS ChildTable,
        c1.name AS ChildColumn,
        OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS ParentSchema,
        OBJECT_NAME(fk.referenced_object_id) AS ParentTable,
        c2.name AS ParentColumn
    FROM
        sys.foreign_keys fk
            INNER JOIN sys.foreign_key_columns fkc
                       ON fk.object_id = fkc.constraint_object_id
            INNER JOIN sys.columns c1
                       ON fkc.parent_object_id = c1.object_id AND fkc.parent_column_id = c1.column_id
            INNER JOIN sys.columns c2
                       ON fkc.referenced_object_id = c2.object_id AND fkc.referenced_column_id = c2.column_id)
SELECT *
FROM
    CONSLIST
WHERE
    parentSchema='TRANS'

