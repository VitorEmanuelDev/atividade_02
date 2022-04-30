CREATE TABLE Regiao(
	CodRegiao 	DECIMAL(6) NOT NULL,
	NomeRegiao 	CHARACTER(20) NOT NULL,
	CONSTRAINT pk_regiao PRIMARY KEY (CodRegiao));

CREATE TABLE Estado(
	CodEstado 	DECIMAL(6) NOT NULL,
	NomeEstado 	CHARACTER(20) NOT NULL,
	SiglaEstado 	CHARACTER(2) NOT NULL,
	CodRegiao 	DECIMAL(6) NOT NULL,
	CONSTRAINT pk_estado PRIMARY KEY (CodEstado),
	CONSTRAINT fk_estado_pk_regiao FOREIGN KEY (CodRegiao) REFERENCES Regiao (CodRegiao));

CREATE TABLE Municipio(
	CodMunicipio 	DECIMAL(6) NOT NULL,
	NomeMunicipio 	CHARACTER(50) NOT NULL,
	CodEstado 	DECIMAL(6) NOT NULL,
	CONSTRAINT pk_municipio PRIMARY KEY (CodMunicipio),
	CONSTRAINT fk_municipio_pk_estado FOREIGN KEY (CodMunicipio) REFERENCES Municipio (CodMunicipio));

CREATE TABLE Indice(
	CodMunicipio 	DECIMAL NOT NULL,
	Ano 		DECIMAL NOT NULL,
	IDH_Geral 	decimal(8,3) NOT NULL,
	IDH_Renda 	decimal(8,3) NOT NULL,
	IDH_Longevidade decimal(8,3) NOT NULL,
	IDH_Educacao 	decimal(8,3) NOT NULL,
	CONSTRAINT pk_indice PRIMARY KEY (CodMunicipio,Ano),
	CONSTRAINT fk_indice_pk_unicipio FOREIGN KEY (CodMunicipio) REFERENCES Municipio (CodMunicipio));