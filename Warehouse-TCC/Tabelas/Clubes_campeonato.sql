CREATE TABLE [dbo].[Clubes_campeonato]
(
	[IdClubesCampeonato] INT NOT NULL PRIMARY KEY, 
    [Codigo_clube] INT NULL, 
    [Codigo_campeonato] INT NULL, 
    [Vitorias] INT NULL, 
    [Derrotas] INT NULL, 
    [Empates] INT NULL, 
    [Gols_pro] INT NULL, 
    [Gols_contra] INT NULL, 
    CONSTRAINT [FK_Clubes_campeonato_Clubes] FOREIGN KEY ([Codigo_clube]) REFERENCES [Clube]([IdClube]), 
    CONSTRAINT [FK_Clubes_campeonato_Campeonato] FOREIGN KEY ([Codigo_campeonato]) REFERENCES [Campeonato]([IdCampeonato])
)
