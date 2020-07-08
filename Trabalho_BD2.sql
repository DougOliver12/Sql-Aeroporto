USE al550479580
;
DROP TABLE IF EXISTS companhia
;
/*ALTER TABLE aeroporto ADD (sig_uf VARCHAR(2),nom_pai VARCHAR(20),vlr_fuso_horario NUMERIC(2))
ALTER TABLE tripulante ADD (vlr_salario NUMERIC (8,2) default 1000)*/
/*ALTER TABLE tripulante ADD (CONSTRAINT ck_tripulante_vlr_salario CHECK (vlr_salario>=1000 AND vlr_salario<=2000 ))*/
CREATE TABLE companhia
(
cod_companhia NUMERIC(3)  NOT NULL,
nom_companhia VARCHAR(30) NOT NULL,
sig_companhia VARCHAR(5)  NOT NULL,

CONSTRAINT pk_companhia
       PRIMARY KEY (cod_companhia) 
)engine=innodb
;
ALTER TABLE aeronave ADD 
(
cod_companhia NUMERIC(3) NOT NULL
)
;
ALTER TABLE aeronave ADD 
(
CONSTRAINT fk_aeronave_companhia
      FOREIGN KEY(cod_companhia)
      REFERENCES companhia(cod_companhia)
      ON DELETE RESTRICT
        ON UPDATE RESTRICT
)
;
ALTER TABLE tripulante 
    DROP COLUMN  vlr_salario
;
ALTER TABLE tripulante ADD (

vlr_salario NUMERIC(8,2) DEFAULT 1000
)
;tripulantetripulante
/* PK-PRIMNARY KEY, FK-FOREIGN KEY,CK-CHECK */