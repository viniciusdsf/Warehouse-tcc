﻿/*
Deployment script for Warehouse-TCC

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Warehouse-TCC"
:setvar DefaultFilePrefix "Warehouse-TCC"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[Fato_001]...';


GO
CREATE TABLE [dbo].[Fato_001] (
    [IdClube]            INT           NOT NULL,
    [IdPartida]          INT           NOT NULL,
    [IdCampeonato]       INT           NOT NULL,
    [IdClubesCampeonato] INT           NOT NULL,
    [IdDia]              NVARCHAR (50) NOT NULL,
    [ProbGolsTimeA]      INT           NULL,
    [ProbVitoriaTimaA]   INT           NULL,
    [ProbEmpateTimaA]    INT           NULL,
    [ProbDerrotaTimaA]   INT           NULL,
    [ProbGolsTimeB]      INT           NULL,
    [ProbVitoriaTimeB]   INT           NULL,
    [ProbEmpateTimeB]    INT           NULL,
    [ProbDerrotaTimeB]   INT           NULL,
    PRIMARY KEY CLUSTERED ([IdDia] ASC, [IdClube] ASC, [IdPartida] ASC, [IdCampeonato] ASC, [IdClubesCampeonato] ASC)
);


GO
PRINT N'Creating [dbo].[Dim_tempo]...';


GO
CREATE TABLE [dbo].[Dim_tempo] (
    [IdDia]            NVARCHAR (50) NOT NULL,
    [Data]             DATE          NULL,
    [CodSemana]        INT           NULL,
    [NomeDia]          NVARCHAR (50) NULL,
    [CodMes]           INT           NULL,
    [NomeMes]          NVARCHAR (50) NULL,
    [CodMesAno]        NVARCHAR (50) NULL,
    [NomeMesAno]       NVARCHAR (50) NULL,
    [CodTrimestre]     INT           NULL,
    [NomeTrimestre]    NVARCHAR (50) NULL,
    [CodTrimestreAno]  NVARCHAR (50) NULL,
    [NomeTrimestreano] NVARCHAR (50) NULL,
    [Ano]              NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([IdDia] ASC)
);


GO
PRINT N'Creating [dbo].[Clubes_campeonato]...';


GO
CREATE TABLE [dbo].[Clubes_campeonato] (
    [IdClubesCampeonato] INT NOT NULL,
    [Codigo_clube]       INT NULL,
    [Codigo_campeonato]  INT NULL,
    [Vitorias]           INT NULL,
    [Derrotas]           INT NULL,
    [Empates]            INT NULL,
    [Gols_pro]           INT NULL,
    [Gols_contra]        INT NULL,
    PRIMARY KEY CLUSTERED ([IdClubesCampeonato] ASC)
);


GO
PRINT N'Creating [dbo].[Campeonato]...';


GO
CREATE TABLE [dbo].[Campeonato] (
    [IdCampeonato] INT          NOT NULL,
    [Nome]         VARCHAR (50) NULL,
    [Data_inicio]  DATE         NULL,
    [Data_fim]     DATE         NULL,
    PRIMARY KEY CLUSTERED ([IdCampeonato] ASC)
);


GO
PRINT N'Creating [dbo].[Partida]...';


GO
CREATE TABLE [dbo].[Partida] (
    [IdPartida]     INT      NOT NULL,
    [Clube1]        INT      NOT NULL,
    [Clube2]        INT      NOT NULL,
    [dataPartida]   DATE     NOT NULL,
    [horaPartida]   TIME (7) NULL,
    [golsMandante]  INT      NOT NULL,
    [golsVisitante] INT      NOT NULL,
    [Idcampeonato]  INT      NULL,
    PRIMARY KEY CLUSTERED ([IdPartida] ASC)
);


GO
PRINT N'Creating [dbo].[Clube]...';


GO
CREATE TABLE [dbo].[Clube] (
    [IdClube]      INT          NOT NULL,
    [nomeClube]    VARCHAR (50) NOT NULL,
    [ufClube]      VARCHAR (2)  NOT NULL,
    [dataFundacao] DATE         NULL,
    PRIMARY KEY CLUSTERED ([IdClube] ASC)
);


GO
PRINT N'Creating [dbo].[Fato-1]...';


GO
CREATE TABLE [dbo].[Fato-1] (
    [Id]                      INT NOT NULL,
    [Clube]                   INT NULL,
    [ProbabilidadeGolsPro]    INT NULL,
    [ProbabilidadeGolsContra] INT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[FK_Fato_001_Clube]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Clube] FOREIGN KEY ([IdClube]) REFERENCES [dbo].[Clube] ([IdClube]);


GO
PRINT N'Creating [dbo].[FK_Fato_001_Partida]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Partida] FOREIGN KEY ([IdPartida]) REFERENCES [dbo].[Partida] ([IdPartida]);


GO
PRINT N'Creating [dbo].[FK_Fato_001_Campeonato]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Campeonato] FOREIGN KEY ([IdCampeonato]) REFERENCES [dbo].[Campeonato] ([IdCampeonato]);


GO
PRINT N'Creating [dbo].[FK_Fato_001_Clubes_campeonato]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Clubes_campeonato] FOREIGN KEY ([IdClubesCampeonato]) REFERENCES [dbo].[Clubes_campeonato] ([IdClubesCampeonato]);


GO
PRINT N'Creating [dbo].[FK_Fato_001_Dim_tempo]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Dim_tempo] FOREIGN KEY ([IdDia]) REFERENCES [dbo].[Dim_tempo] ([IdDia]);


GO
PRINT N'Creating [dbo].[FK_Clubes_campeonato_Clubes]...';


GO
ALTER TABLE [dbo].[Clubes_campeonato]
    ADD CONSTRAINT [FK_Clubes_campeonato_Clubes] FOREIGN KEY ([Codigo_clube]) REFERENCES [dbo].[Clube] ([IdClube]);


GO
PRINT N'Creating [dbo].[FK_Clubes_campeonato_Campeonato]...';


GO
ALTER TABLE [dbo].[Clubes_campeonato]
    ADD CONSTRAINT [FK_Clubes_campeonato_Campeonato] FOREIGN KEY ([Codigo_campeonato]) REFERENCES [dbo].[Campeonato] ([IdCampeonato]);


GO
PRINT N'Creating [dbo].[FK_Partida_Clube1]...';


GO
ALTER TABLE [dbo].[Partida]
    ADD CONSTRAINT [FK_Partida_Clube1] FOREIGN KEY ([Clube1]) REFERENCES [dbo].[Clube] ([IdClube]);


GO
PRINT N'Creating [dbo].[FK_Partida_Clube2]...';


GO
ALTER TABLE [dbo].[Partida]
    ADD CONSTRAINT [FK_Partida_Clube2] FOREIGN KEY ([Clube2]) REFERENCES [dbo].[Clube] ([IdClube]);


GO
PRINT N'Creating [dbo].[FK_Partida_Campeonato]...';


GO
ALTER TABLE [dbo].[Partida]
    ADD CONSTRAINT [FK_Partida_Campeonato] FOREIGN KEY ([Idcampeonato]) REFERENCES [dbo].[Campeonato] ([IdCampeonato]);


GO
PRINT N'Creating [dbo].[FK_Fato-1_clubes]...';


GO
ALTER TABLE [dbo].[Fato-1]
    ADD CONSTRAINT [FK_Fato-1_clubes] FOREIGN KEY ([Clube]) REFERENCES [dbo].[Clube] ([IdClube]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '38c47d00-2601-457a-a255-7f427a274587')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('38c47d00-2601-457a-a255-7f427a274587')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e23c7d55-7160-4bac-b869-676515763808')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e23c7d55-7160-4bac-b869-676515763808')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '82aee33f-b422-46fb-bfad-6edeb03f2d11')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('82aee33f-b422-46fb-bfad-6edeb03f2d11')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '861b654f-386f-4fe2-92f7-3ef762632edd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('861b654f-386f-4fe2-92f7-3ef762632edd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0af1d49a-3358-4aac-9467-cc2ce068bf7e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0af1d49a-3358-4aac-9467-cc2ce068bf7e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '976fc7b6-f55b-4285-aa12-b8df53e95f2c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('976fc7b6-f55b-4285-aa12-b8df53e95f2c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'db3e4e7f-c2c6-44b0-9477-6e3d5eae5f79')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('db3e4e7f-c2c6-44b0-9477-6e3d5eae5f79')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c0997336-011b-4531-ad94-217260a53fde')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c0997336-011b-4531-ad94-217260a53fde')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '53a5de8d-22a0-4bee-b9bb-6ab498320825')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('53a5de8d-22a0-4bee-b9bb-6ab498320825')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '11b47d8b-2a9a-47c7-9d55-64b4398d802d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('11b47d8b-2a9a-47c7-9d55-64b4398d802d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '46c6ad96-cb06-43fb-98b9-1f2642c5899e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('46c6ad96-cb06-43fb-98b9-1f2642c5899e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a03aa305-a49f-4b72-bd15-5b674331dec8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a03aa305-a49f-4b72-bd15-5b674331dec8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '76495740-1750-4efc-8415-93b0e4a0320a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('76495740-1750-4efc-8415-93b0e4a0320a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f857ad55-eec4-4a2b-b1bd-5c13e3ecf8d2')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f857ad55-eec4-4a2b-b1bd-5c13e3ecf8d2')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2822128b-b804-4a6b-9dbc-9f3d75f43cc4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2822128b-b804-4a6b-9dbc-9f3d75f43cc4')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '7d85fc9f-f573-4bd1-8733-0690c6327877')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('7d85fc9f-f573-4bd1-8733-0690c6327877')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '863d4137-3d17-4ead-bc56-4c7d4802b4a1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('863d4137-3d17-4ead-bc56-4c7d4802b4a1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd40081ca-7635-4b75-8ba3-7d8aec0a10c6')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d40081ca-7635-4b75-8ba3-7d8aec0a10c6')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1ae6e00a-331e-4777-9432-c282eddb8b93')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1ae6e00a-331e-4777-9432-c282eddb8b93')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1ed9adb6-27dd-48d0-a169-6a2af2090250')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1ed9adb6-27dd-48d0-a169-6a2af2090250')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'cc157023-5e5a-41d3-a8cb-3247f8254744')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('cc157023-5e5a-41d3-a8cb-3247f8254744')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4676e0c4-b0d6-4c3b-aa9a-9a7b697c315a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4676e0c4-b0d6-4c3b-aa9a-9a7b697c315a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'bc657074-acc8-40ad-953a-81dacc15dcc1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('bc657074-acc8-40ad-953a-81dacc15dcc1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b663af13-4714-47d9-b31a-dbdadb4c358a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b663af13-4714-47d9-b31a-dbdadb4c358a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '56ad6c0b-7e22-4679-91e7-7511001e2e27')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('56ad6c0b-7e22-4679-91e7-7511001e2e27')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Update complete.';


GO
