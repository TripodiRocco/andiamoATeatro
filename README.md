Quello che segue è il testo di un'esercitazione che ci è stata data da uno dei tutor (Marco Adriani) presenti in Develhope, con lo scopo di familiarizzare nella progettazione di un diagramma Entity Relationship e nella creazione del relativo database, durante l'apprendimento dell'unità SQL:

------------

<i>Vogliamo progettare l’applicazione AndiamoATeatro, un’applicazione per visualizzare, prenotare e
acquistare biglietti per spettacoli teatrali in tutta Italia.
Gli spettacoli posso avvenire in diverse sedi, non solo teatri (ad esempio nei pressi di un
monumento, di un parco, ecc.), e di esse vogliamo sapere il nome, l’indirizzo e il comune dove
risiede, oltre che se è un luogo al chiuso o all’aperto.
Ogni sede inoltre può avere delle sale distinte, ognuna che può ospitare contemporaneamente uno
spettacolo distinto. Di ogni sala ci interessa sapere il nome e il numero di posti. Degli spettacoli
invece ci interessa l’orario, il luogo nel quale viene svolto, un genere (per semplicità considerare
che ogni spettacolo abbia un solo genere) il prezzo e la durata.
Ogni utente deve poter prenotare un numero massimo di 4 posti per un singolo spettacolo (per
evitare eventuali abusi del sistema) ovviamente se tali posti sono disponibili e non occupati. Dei
posti ci interessa conoscere la fila e il numero.
Al momento dell’iscrizione l’utente deve inserire i suoi dati personali come nome, cognome,
indirizzo di residenza, email e numero di telefono (facoltativo). Una volta iscritto l’utente può
procedere con la prenotazione degli spettacoli.
Le funzionalità che il sistema deve poter garantire sono le seguenti:

1) Gli utenti devono potersi registrare inserendo i loro dati personali.
2) Gli utenti registrati devono poter prenotare dei posti disponibili in uno spettacolo, e il sistema
deve calcolare il prezzo da pagare per l’utente.
3) L’utente deve poter ricercare gli spettacoli disponibili inserendo la città e una data, e
facoltativamente un genere e un luogo specifico.
4) Poter ricevere dal sistema dei suggerimenti sui prossimi spettacoli, in particolare deve ritornare
tutti gli spettacoli del prossimo mese che hanno lo stesso genere degli ultimi 3 spettacoli visti.