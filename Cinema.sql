DROP DATABASE IF EXISTS `database`;
CREATE DATABASE IF NOT EXISTS `database`;
USE `database`;

CREATE TABLE IF NOT EXISTS 'database'.'Cinema'{
    'id' INT NOT NULL,
    'città'  VARCHAR(15) NULL DEFAULT NULL,
    'Numero_Sale' INT NOT NULL,
    PRIMARY KEY('Id'),
    PRIMARY KEY('città'),
    CONSTRAINT 'città'
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
}
ENGINE= InnoDB
DEFAULT CHARACTER SET= UTF8MB4;

CREATE TABLE IF NOT EXISTS 'database'.'Sala'{S
    'id_sala' INT NOT NULL,
    'Aperta_e/o_Chiusa'  VARCHAR(15) NULL DEFAULT NULL,
    'Numero_Posti' INT NOT NULL,
    'Prenotabile' VARCHAR(13) NULL DEFAULT NULL,
    PRIMARY KEY('Id_sala'),
        FOREIGN KEY('id_sala')
        REFERENCES 'database'.'Film'
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
}
ENGINE= InnoDB
DEFAULT CHARACTER SET= UTF8MB4;

CREATE TABLE IF NOT EXISTS 'database'.'film'{
    'id_film' INT NOT NULL,
    'sala' INT NOT NULL,
    'nome'  VARCHAR(15) NULL DEFAULT NULL,
    'Orario_inizio'  VARCHAR(15) NULL DEFAULT NULL,
    'Orario_fine'  VARCHAR(15) NULL DEFAULT NULL,
    'Data_di_uscita'  VARCHAR(15) NULL DEFAULT NULL,
    'Durata'  VARCHAR(15) NULL DEFAULT NULL,
    'Data_di_ritiro'  VARCHAR(15) NULL DEFAULT NULL,
    'genere' VARCHAR(13) NULL DEFAULT NULL,
    PRIMARY KEY('Id_film'),
        FOREIGN KEY('id_film')
        REFERENCES 'database'.'Biglietto'
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
}
ENGINE= InnoDB
DEFAULT CHARACTER SET= UTF8MB4;

CREATE TABLE IF NOT EXISTS 'database'.'Biglietto'{
    'id_biglietto' INT NOT NULL,
    'id_del film' INT NOT NULL,
    'id_cliente' INT NOT NULL,
    '3D'  VARCHAR(15) NULL DEFAULT NULL,
    'Posti'  VARCHAR(15) NULL DEFAULT NULL,
    'Costo_Biglietto' INT NOT NULL,
    'Nome'  VARCHAR(15) NULL DEFAULT NULL,
    
    PRIMARY KEY('Id_biglietto'),
        FOREIGN KEY('id_del film')
        REFERENCES 'database'.'Biglietto'
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
        FOREIGN KEY('nome')
        REFERENCES 'database'.'Biglietto'
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
        FOREIGN KEY('id_del_cliente')
        REFERENCES 'database'.'Cliente'
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
}
ENGINE= InnoDB
DEFAULT CHARACTER SET= UTF8MB4;

CREATE TABLE IF NOT EXISTS 'database'.'Clienti'{
    'id_biglietto' INT NOT NULL,
    'id ' INT NOT NULL,
    'Nome'  VARCHAR(15) NULL DEFAULT NULL,
    'Cognome'  VARCHAR(15) NULL DEFAULT NULL,
    'età' INT NOT NULL,
    'Genere'  VARCHAR(15) NULL DEFAULT NULL,
    
    PRIMARY KEY('Id '),
        FOREIGN KEY('id_biglietto')
        REFERENCES 'database'.'Biglietto'
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
        FOREIGN KEY('Genere')
        REFERENCES 'database'.'film'
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
}
ENGINE= InnoDB
DEFAULT CHARACTER SET= UTF8MB4;

CREATE TABLE IF NOT EXISTS 'database'.'Dipendenti'{
    'id' INT NOT NULL,
    'id_cinema' INT NOT NULL,
    'Nome'  VARCHAR(15) NULL DEFAULT NULL,
    'Cognome' VARCHAR(15) NULL DEFAULT NULL,
    'Occupazione' VARCHAR(13) NULL DEFAULT NULL,
    'Stipendio ' INT NOT NULL,
    'Orario_Inizio' VARCHAR(13) NULL DEFAULT NULL,
    'Orario_Fine' VARCHAR(13) NULL DEFAULT NULL,
    'Presenza' VARCHAR(13) NULL DEFAULT NULL,
    PRIMARY KEY('Id '),
        FOREIGN KEY('id_cinema')
        REFERENCES 'database'.'Cinema'
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
}
ENGINE= InnoDB
DEFAULT CHARACTER SET= UTF8MB4;


CREATE TRIGGER cliente_insert_trigger
BEFORE INSERT ON Biglietto
FOR EACH ROW
BEGIN
    DECLARE sconto INT;
    IF (SELECT età FROM Clienti WHERE id = NEW.id_cliente) < 15 OR (SELECT età FROM Clienti WHERE id = NEW.id_cliente) > 68 THEN
        SET sconto = 4; 
    ELSE
        SET sconto = 0; 
    END IF;
    SET NEW.Costo_Biglietto = NEW.Costo_Biglietto - sconto;
END 

CREATE TRIGGER dipendente_presenza_trigger
BEFORE UPDATE ON Dipendenti
FOR EACH ROW
BEGIN
    IF NEW.Presenza = 10 THEN
        SET NEW.Stipendio = NEW.Stipendio + 20;
    END IF;
END 


SELECT c, b
FROM Clienti AS c
JOIN Biglietto AS b ON c.id_biglietto = b.id_biglietto
WHERE c.id = <id_cliente>;

SELECT f, s
FROM film AS f
JOIN Sala AS s ON f.sala = s.id_sala
WHERE f.id_film = <id_film>;

SELECT c.id AS id_cinema, c.nome AS nome_cinema, d.nome AS nome_dirigente
FROM Cinema AS c
JOIN Dipendenti AS d ON c.id = d.id_cinema
WHERE d.occupazione = 'Dirigente';