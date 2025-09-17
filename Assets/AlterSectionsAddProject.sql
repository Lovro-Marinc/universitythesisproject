

ALTER TABLE dbo.ProjectSection 
ADD ProjectID INT NULL;


ALTER TABLE dbo.ProjectSection 
ADD CONSTRAINT FK_Sections_Projects 
FOREIGN KEY (ProjectID) REFERENCES Projects(ID);
