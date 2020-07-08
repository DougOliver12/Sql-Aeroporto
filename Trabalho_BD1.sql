USE al550479580
;
DROP TABLE IF EXISTS tripulante
;
DROP TABLE IF EXISTS base
;
DROP TABLE IF EXISTS cargo
;
CREATE TABLE base
(
	cod_base NUMERIC(3) 	NOT NULL,
	nom_base VARCHAR(30) 	NOT NULL,
	ind_base CHAR(1) 		NOT NULL,

	CONSTRAINT pk_base
		PRIMARY KEY(cod_base)
)engine=innodb
;
CREATE TABLE cargo
(
	cod_cargo NUMERIC(2) 	NOT NULL,
	nom_cargo VARCHAR(20) 	NOT NULL,

	CONSTRAINT pk_cargo
		PRIMARY KEY(cod_cargo)
)engine=innodb
;
CREATE TABLE tripulante
(
	cod_tripulante 	VARCHAR(5) 	NOT NULL,
	cod_cargo 		NUMERIC(3) 	NOT NULL,
	cod_base 		NUMERIC(3) 	NOT NULL,
	nom_tripulante 	VARCHAR(30) NOT NULL,
	dat_admissao 	DATE 		NOT NULL,

	CONSTRAINT pk_tripulante
		PRIMARY KEY(cod_tripulante),
	CONSTRAINT fk_tripulante_base
		FOREIGN KEY(cod_base)
		REFERENCES base(cod_base)
		
		ON DELETE RESTRICT
        ON UPDATE RESTRICT,
	CONSTRAINT fk_tripulante_cargo
		FOREIGN KEY(cod_cargo)
		REFERENCES cargo(cod_cargo)
		
		ON DELETE RESTRICT
        ON UPDATE RESTRICT
)engine=innodb
;
CREATE TABLE tipo_aeronave
(
	cod_tipo_aeronave VARCHAR(6) 	NOT NULL,
	dsc_tipo_aeronave INTEGER 		NOT NULL,

	CONSTRAINT pk_tipo_aeronave
		PRIMARY KEY(cod_tipo_aeronave)
)engine=innodb
;
CREATE TABLE aeronave
(
	num_prefixo 		VARCHAR(6) 	NOT NULL,
	cod_tipo_aeronave 	VARCHAR(6) 	NOT NULL,
	cod_base 			NUMERIC(3) 	NOT NULL,
	dat_aquisicao 		DATE 		NOT NULL,

	CONSTRAINT pk_aeronave
		PRIMARY KEY(num_prefixo),
	CONSTRAINT fk_aeronave_tipo_aeronave
		FOREIGN KEY (cod_tipo_aeronave)
		REFERENCES tipo_aeronave(cod_tipo_aeronave)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT,
	CONSTRAINT fk_aeronave_base
		FOREIGN KEY(cod_base)
		REFERENCES base(cod_base)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT
)engine=innodb
;
CREATE TABLE aeroporto
(
	cod_aeroporto 	VARCHAR(3) 		NOT NULL,
	nom_aeroporto 	VARCHAR(30) 	NOT NULL,
	nom_cidade 		VARCHAR(25) 	NOT NULL,

	CONSTRAINT pk_aeroporto
		PRIMARY KEY(cod_aeroporto)
)engine=innodb
;
CREATE TABLE voo
(
	num_voo 				NUMERIC(3) 		NOT NULL,
	cod_aeroporto_origem 	VARCHAR(3) 		NOT NULL,
	cod_aeroporto_destino 	VARCHAR(3) 		NOT NULL,
	vlr_distancia 			NUMERIC(6) 		NOT NULL,
	vlr_preco 				NUMERIC(6,2) 	NOT NULL,

	CONSTRAINT pk_voo
		PRIMARY KEY(num_voo),
	CONSTRAINT fk_voo_aeroporto_origem
		FOREIGN KEY(cod_aeroporto_origem)
		REFERENCES aeroporto(cod_aeroporto)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT,
	CONSTRAINT fk_voo_aeroporto_destino
		FOREIGN KEY(cod_aeroporto_destino)
		REFERENCES aeroporto(cod_aeroporto)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT
)engine=innodb
;
CREATE TABLE programacao
(
	num_voo 	NUMERIC(3) 	NOT NULL,
	dat_voo 	DATE 		NOT NULL,
	num_prefixo VARCHAR(6) 	NOT NULL,

	CONSTRAINT pk_programacao
		PRIMARY KEY(num_voo, dat_voo),
	CONSTRAINT fk_programacao_voo
		FOREIGN KEY(num_voo)
		REFERENCES voo(num_voo)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT,
	CONSTRAINT fk_programacao_aeronave
		FOREIGN KEY(num_prefixo)
		REFERENCES aeronave(num_prefixo)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT
)engine=innodb
;
CREATE TABLE equipe_voo
(
	num_voo 		NUMERIC(3) 	NOT NULL,
	dat_voo 		DATE 		NOT NULL,
	cod_tripulante 	VARCHAR(5) 	NOT NULL,

	CONSTRAINT pk_equipe_voo
		PRIMARY KEY(num_voo, dat_voo, cod_tripulante),
	CONSTRAINT fk_equipe_voo_programacao
		FOREIGN KEY(num_voo, dat_voo)
		REFERENCES programacao(num_voo, dat_voo)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT,
	CONSTRAINT fk_equipe_voo_tripulante
		FOREIGN KEY(cod_tripulante)
		REFERENCES tripulante(cod_tripulante)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT
)engine=innodb
;
CREATE TABLE escala
(
	num_escala 				INTEGER 	NOT NULL,
	num_voo					NUMERIC(3) 	NOT NULL,
	dat_voo 				DATE 		NOT NULL,
	cod_aeroporto 			VARCHAR(3) 	NOT NULL,
	hor_prevista_chegada 	TIME 		NOT NULL,
	hor_prevista_saida 		TIME 		NOT NULL,

	CONSTRAINT pk_escala
		PRIMARY KEY(num_escala, num_voo, dat_voo),
	CONSTRAINT fk_escala_programaca
		FOREIGN KEY(num_voo, dat_voo)
		REFERENCES programacao(num_voo, dat_voo)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT,
	CONSTRAINT fk_escala_aeroporto
		FOREIGN KEY(cod_aeroporto)
		REFERENCES aeroporto(cod_aeroporto)
		ON DELETE RESTRICT
        ON UPDATE RESTRICT
)engine=innodb;
