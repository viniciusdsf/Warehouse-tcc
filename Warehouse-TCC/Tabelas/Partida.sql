CREATE TABLE [dbo].[Partida]
(
	[IdPartida] INT NOT NULL PRIMARY KEY, 
    [Clube1] INT NOT NULL, 
    [Clube2] INT NOT NULL,
    dataPartida date NOT NULL,
    horaPartida time NULL,
    golsMandante INT NOT NULL,
    golsVisitante INT NOT NULL, 
    [Idcampeonato] INT NULL, 
    CONSTRAINT [FK_Partida_Clube1] FOREIGN KEY ([Clube1]) REFERENCES [Clube]([IdClube]), 
    CONSTRAINT [FK_Partida_Clube2] FOREIGN KEY ([Clube2]) REFERENCES [Clube]([IdClube]), 
    CONSTRAINT [FK_Partida_Campeonato] FOREIGN KEY ([Idcampeonato]) REFERENCES [Campeonato]([IdCampeonato]),
)
