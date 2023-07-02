CREATE table if not EXISTS SEDE(
	ID_SEDE INT PRIMARY KEY,
	NOME_SEDE VARCHAR(255),
	INDIRIZZO_SEDE VARCHAR(255),
	COMUNE VARCHAR(255),
	LUOGO_APERTO BOOLEAN
);


/*
INSERT INTO SEDE(ID_SEDE, NOME_SEDE, INDIRIZZO_SEDE, COMUNE, LUOGO_APERTO)
VALUES (1, 'Menotti', 'Via Ciro Menotti 11', 'Milano', false),
(2, 'Modigliani Forum', 'Porta a Terra 57100', 'Livorno', false),
(3, 'Nelson Mandela Forum', 'Viale Malta 50137', 'Firenze', true),
(4, 'Ippodromo le Capannelle', 'Via Appia Nuova 1255, 00178', 'Roma', false);
*/


CREATE table if not EXISTS UTENTE(
	ID_UTENTE INT PRIMARY KEY,
	NOME_UTENTE VARCHAR(255),
	COGNOME_UTENTE VARCHAR(255),
	INDIRIZZO_UTENTE VARCHAR(255),
	MAIL VARCHAR(255),
	TELEFONO VARCHAR(255)
);

/*
INSERT INTO UTENTE(ID_UTENTE, NOME_UTENTE, COGNOME_UTENTE, INDIRIZZO_UTENTE, MAIL, TELEFONO)
VALUES (1, 'Mario', 'Rossi', 'Corso Vittorio Emanuele II, 101, Napoli - CAP 80121', 'mario.rossi@gmail.com', '345 6789012'),
(2, 'Sara', 'Bianchi', 'Piazza del Campo, 1, Siena, Italia - CAP 53100', 'sara.bianchi@yahoo.com', '334 5678901'),
(3, 'Giuseppe', 'Verdi', 'Via dei Fori Imperiali, 1, Roma, Italia - CAP 00184', 'giuseppe.verdi@tiscali.it', '339 1234567'),
(4, 'Manuela', 'Gialli', 'Via Dante Alighieri, 8, Firenze, Italia - CAP 50122', 'manuela.gialli@virgilio.it', '348 9012345');
*/

CREATE table if not EXISTS SALA(
	ID_SALA INT PRIMARY KEY,
	NOME_SALA VARCHAR(255),
	ID_SEDE INT,
	foreign key (ID_SEDE) references SEDE(ID_SEDE)
);


CREATE table if not EXISTS SPETTACOLO(
	ID_SPETTACOLO INT AUTO_INCREMENT PRIMARY KEY,
	NOME_SPETTACOLO VARCHAR(255),
	GENERE VARCHAR(255),
	ORARIO TIMESTAMP,
	DURATA INT,
	PREZZO DOUBLE,
	ID_SALA INT,
	FOREIGN KEY (ID_SALA) REFERENCES SALA (ID_SALA)
);


/*
INSERT INTO SALA(ID_SALA, NOME_SALA, ID_SEDE)
VALUES (1, 'sala1', 1),
(2, 'sala2', 2),
(3, 'sala3', 2),
(4, 'sala4', 4);
*/

/*
INSERT INTO SPETTACOLO(ID_SPETTACOLO, NOME_SPETTACOLO, GENERE, ORARIO, DURATA, PREZZO, ID_SALA)
VALUES (1, 'Macbeth', 'Tragedia', '2017-07-23 19:00:00', 200, 30.15, 1),
(2, 'I labirinti della mente', 'Thriller', '2021-09-14 15:00:00', 100, 55.27, 2),
(3, 'Paolo Fresu & Omar Sosa - Food', 'Commedia', '2022-11-06 18:00:00', 200, 64.07, 3),
(4, 'The Space Violin Visual Concert', 'Opera lirica', '2023-05-09 17:00:00', 250, 75.48, 4);
*/


CREATE table if not EXISTS POSTO(
	ID_POSTO INT PRIMARY KEY,
	FILA INT,
	NUMERO_POSTO INT,
	ID_SALA INT,
	foreign key (ID_SALA) references SALA (ID_SALA)
);

/*
INSERT INTO POSTO(ID_POSTO, FILA, NUMERO_POSTO, ID_SALA)
VALUES (1, 7, 5, 1),
(2, 4, 9, 1),
(3, 1, 2, 2),
(4, 4, 6, 3);
*/


CREATE table if not EXISTS TICKET(
	ID_TICKET INT PRIMARY KEY,
	ORARIO_TICKET TIMESTAMP,
	ID_POSTO INT,
	ID_SPETTACOLO INT,
	ID_UTENTE INT,
	FOREIGN KEY (ID_POSTO) REFERENCES POSTO (ID_POSTO),
	FOREIGN KEY (ID_SPETTACOLO) REFERENCES SPETTACOLO (ID_SPETTACOLO),
	foreign key (ID_UTENTE) references UTENTE (ID_UTENTE)
);

/*
INSERT INTO TICKET(ID_TICKET, ORARIO_TICKET, ID_POSTO, ID_SPETTACOLO, ID_UTENTE)
VALUES (1, "2017-07-23 19:00:00", 1, 1, 1),
(2, "2021-09-14 15:00:00", 2, 2, 1),
(3, "2022-11-06 18:00:00", 3, 2, 2),
(4, "2023-05-09 17:00:00", 4, 3, 3);
*/




-- ---------------------------- CREAZIONE QUERIES ---------------------------------

-- 1) Selezionare lo spettacolo horror con il prezzo massimo.
select NOME_SPETTACOLO, GENERE, PREZZO
from spettacolo s
where GENERE = 'Horror' 
and PREZZO = (select MAX(PREZZO)
from SPETTACOLO where SPETTACOLO.GENERE = 'Horror');



-- 2) Selezionare gli id dei posti per lo spettacolo "Macbeth".
select posto.ID_POSTO
from posto
join ticket t on posto.ID_POSTO = t.ID_POSTO
join spettacolo s on s.ID_SPETTACOLO = t.ID_SPETTACOLO
where s.NOME_SPETTACOLO = 'Macbeth';



-- 3) Selezionare il numero di spettacoli prenotati dall'utente con id = 1 raggruppati per genere.
select COUNT(*)
from SPETTACOLO
join TICKET on TICKET.ID_SPETTACOLO = SPETTACOLO.ID_SPETTACOLO
join UTENTE on UTENTE.ID_UTENTE = TICKET.ID_UTENTE
where UTENTE.ID_UTENTE = 1
group by GENERE;



-- 4) Selezionare il numero di spettacoli raggruppati in base al nome della sede dove si sono svolti.
select COUNT(*)
from spettacolo s
join SALA s2 on s2.ID_SALA = s2.ID_SALA
join sede s3 ON s3.ID_SEDE = s2.ID_SEDE
group by s3.NOME_SEDE;



-- 5) Selezionare le sedi distinte dove l'utente con id = 2 ha visto uno spettacolo.
select *
from sede s
join sala s2 on s2.ID_SEDE = s2.ID_SEDE
join spettacolo s3 on s3.ID_SALA = s2.ID_SALA
join ticket t on t.ID_SPETTACOLO = s3.ID_SPETTACOLO
join utente u on u.ID_UTENTE = t.ID_UTENTE
where u.ID_UTENTE = 2;



-- 6) Selezionare gli spettacoli thriller che sono in programma a Roma.
select NOME_SPETTACOLO, GENERE, COMUNE
from spettacolo s
join sala s2 on s2.ID_SALA = s.ID_SALA
join sede s3 on s3.ID_SEDE = s2.ID_SEDE
where s3.COMUNE = 'Roma' and s.GENERE = 'Thriller';
