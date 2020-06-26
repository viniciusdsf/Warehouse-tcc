﻿/*
Deployment script for DW_SOCCER

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DW_SOCCER"
:setvar DefaultFilePrefix "DW_SOCCER"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

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
USE [$(DatabaseName)];


GO
PRINT N'Rename refactoring operation with key 11b47d8b-2a9a-47c7-9d55-64b4398d802d is skipped, element [dbo].[Dim_tempo].[Id] (SqlSimpleColumn) will not be renamed to CodDia';


GO
PRINT N'Creating [dbo].[Dim_tempo]...';


GO
CREATE TABLE [dbo].[Dim_tempo] (
    [CodDia]           NVARCHAR (50) NOT NULL,
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
    PRIMARY KEY CLUSTERED ([CodDia] ASC)
);


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '11b47d8b-2a9a-47c7-9d55-64b4398d802d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('11b47d8b-2a9a-47c7-9d55-64b4398d802d')

GO

GO
PRINT N'Update complete.';


GO
