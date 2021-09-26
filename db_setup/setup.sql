IF NOT EXISTS(SELECT * FROM sys.databases WHERE name  = 'TestingDatabase')
    BEGIN
        CREATE DATABASE TestingDatabase
        EXEC sp_defaultdb 'sa', 'TestingDatabase'
    END