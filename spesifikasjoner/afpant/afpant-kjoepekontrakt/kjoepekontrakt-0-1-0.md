Kjøpekontrakt
=============


Table of Contents
=================

* [Kjøpekontrakt](#kjøpekontrakt)
* [Table of Contents](#table-of-contents)
  * [Kjøpekontrakt løsningsbeskrivelse](#kjøpekontrakt-løsningsbeskrivelse)
  * [Innledning](#innledning)
    * [Overordnet beskrivelse](#overordnet-beskrivelse)
  * [Informasjonsflyt](#informasjonsflyt)
  * [Henvendelse fra bank](#henvendelse-fra-bank)
  * [Svar fra megler](#svar-fra-megler)
  * [Alternative flyter](#alternative-flyter)
    * [Kjøpekontrakten er ikke signert](#kjøpekontrakten-er-ikke-signert)
    * [Kunden har kjøpt flere boliger](#kunden-har-kjøpt-flere-boliger)
    * [Oversendt informasjon er endret](#oversendt-informasjon-er-endret)
    * [Det finnes ingen kjøp på kunden](#det-finnes-ingen-kjøp-på-kunden)
    * [Oversendelse uten forespørsel fra bank](#oversendelse-uten-forespørsel-fra-bank)
    * [Boligen blir kjøpt på forkjøpsrett](#boligen-blir-kjøpt-på-forkjøpsrett)
    * [Ny, signert kjøpekontrakt](#ny-signert-kjøpekontrakt)
* [Implementasjon](#implementasjon)
  * [Implementasjonskrav](#implementasjonskrav)
  * [Meldingstyper](#meldingstyper)
    * [Oversikt over meldingstype](#oversikt-over-meldingstype)
    * [Meldingstype: KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank)
    * [Meldingstype: KjoepekontraktSvarFraMegler](#meldingstype-kjoepekontraktsvarframegler)
    * [Meldingstype: KjoepekontraktFraMegler](#meldingstype-kjoepekontraktframegler)

Kjøpekontrakt løsningsbeskrivelse
---
## Innledning
Dette dokumentet beskriver løsning for oversendelse av kjøpekontrakt fra megler til bank. Kjøpekontrakten skal kunne sendes både som strukturerte data og som signert dokument, og informasjon skal også kunne sendes før endelig dokument er signert.

### Overordnet beskrivelse
Kjøpekontrakt eller informasjon fra kjøpekontrakten skal kunne oversendes fra megler til bank, via allerede etablert løsning mot AFPANT.

En bank kan sende forespørsel om kjøpekontrakt til en megler basert på kjøpers fødsels- og personnummer. Megler vil besvare forespørselen med en forsendelse som inneholder strukturerte data, samt en signert versjon av den fulle kontrakten. Dersom den faktiske kjøpekontrakten ikke er signert, skal kun den strukturerte delen returneres. Dersom forespørselen ikke kan besvares, vil banken få en feilmelding i retur som beskriver hvorfor megler ikke kan besvare forespørselen.

## Informasjonsflyt
## Henvendelse fra bank
Ved henvendelse fra bank til megler, med ønske om å få oversendt kjøpekontrakt, skal banken sende følgende informasjon til meglers organisasjonsnummer;

| Én av kjøpernes personnummer |
|---|

Meldingstype: [KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank)

## Svar fra megler
Ved henvendelse fra bank om oversendelse av kjøpekontrakt, skal megler sende strukturert informasjon, i tillegg til signert kjøpekontrakt dersom denne er signert når henvendelsen kommer. 
Følgende informasjon skal oversendes som strukturerte data;

|Datafelt|Sendes ved endring|
|:-------|:-----------------|
|**Mottaker:** Bank/Finansieringsselskaps firmanavn / Org.nummer                                     |      |
|**Avsender:** Meglerforetak / Org.nr. / Ansvarlig megler / Mobilnummer / Mailadresse                |      |
|**Oppgjørsavdeling:** Inkludert oppgjørsmeglers fulle adresse                                       |      |
|**Oppdragsnummer:**                                                                                 |      |
|**Oppgjørsinformasjon:** Kontonummer / KID nummer / Øvrig merking                                   | :white_check_mark: |
|**Eiendomsinformasjon:** Kommunenummer / Gårdsnummer / Bruksnummer / Festenummer / Seksjonsnummer / Adresse / Postnummer (det må være mulig med flere gårds- og bruksnummer) Ved andel/aksje: Organisasjonsnummer / Andelsnummer /Aksjenummer(Informasjon om personlige sameier og hvorvidt de skal pantsettes må inkluderes) |      |
|**Salgssum:**                                                                                       | :white_check_mark: |
|**Omkostninger for kjøper:** (Eks. boligkjøperforsikring pga. manglende felt)                       | :white_check_mark: |
|**Oppgjørsbeløp:** Kjøpesum + kjøpsomkostninger (det skal angis om beløpet er tentativt eller satt) | :white_check_mark: |
|**Signeringsdato:** (dersom det finnes i meglersystemene)                                           |      |
|**Overtagelsesdato:** Denne skal ikke fylles ut dersom nybygg                                       | :white_check_mark: |
|**Andel fellesgjeld:**                                                                              |      |
|**Andel fellesformue:**                                                                             |      |
|**Selger:** Navn og personnummer på alle selgere, dersom selger ikke er hjemmelshaver               |      |
|**Hjemmelshaver:** Navn og personnummer på alle hjemmelshavere                                      |      |
|**Kjøper:** Navn og personnummer på alle kjøpere                                                    | :white_check_mark: |
|**Kjøpers eierandel:** Oppgitt i brøk pr kjøper                                                     | :white_check_mark: |
|**Objektsdata:** Type eiendom- kartverksinformasjon.                                                |      |
|**Link til salgsoppgave:** (Valgfritt felt)                                                         |      |
|**Signert kjøpekontrakt:** (Valgfritt felt)                                                         | :white_check_mark: |

Dersom ikke all strukturert informasjon er lagt inn i meglersystemet enda, skal megler sende det som finnes av informasjon. Bank vil så få push-varsel om oppdatert informasjon så snart dette er lagt til.

Signert kjøpekontrakt skal alltid sendes elektronisk, uavhengig av om det er elektronisk signert, eller om det sendes en PDF av et fysisk signert dokument.

Meldingstype: [KjoepekontraktSvarFraMegler](##meldingstype-kjoepekontraktsvarframegler)

## Alternative flyter

### Kjøpekontrakten er ikke signert
Dersom kjøpekontrakten ikke er signert på det tidspunktet bank ber om data, skal det som finnes av strukturert informasjon sendes til banken. Resterende informasjon vil kunne ettersendes sammen med det signerte dokumentet.

Det skal gå en pushvarsling fra meglersystemet til banken eller bankene som har bedt om data, så snart kjøpekontrakten er signert eller det er endringer i datafeltene. Dette skal sendes som en egen meldingstype slik at det er mulig for bank å fange opp. Banken vil da få en melding om at dokumentet er signert, og kan da hente data på nytt.

Det er viktig at meglersystemene sørger for at det signerte dokumentet alltid inneholder lik informasjon som det som ligger av strukturerte data.

Det skal ikke sendes et dokument ved siden av de strukturerte dataene, dersom det ikke finnes et signert dokument.

### Kunden har kjøpt flere boliger
Dersom kunden har kjøpt flere boliger via samme megler, og en henvendelse fra bank får treff på flere objekter, skal informasjon om alle objektene sendes til banken. Banken må selv håndtere dette i sine systemer, og lage en løsning som støtter at rådgiver kan måtte velge mellom ulike objekter.

### Oversendt informasjon er endret
Det er viktig at banken har oppdatert informasjon i systemene, og at denne er lik det som ligger i det signerte dokumentet. 
Dersom megler endrer eller legger til informasjon i meglersystemene, må banken få beskjed om dette. Det gjøres ved at meglersystemet pusher en melding til banken. 
Dette vil være en spesifisert melding med informasjon om hva som er endret, og banken kan da hente informasjon på nytt.

Hvilke felter som skal trigge en melding til banken om at det har skjedd en endring, er merket i tabellen under [Svar fra megler](#svar-fra-megler).

Meldingstype: [KjoepekontraktFraMegler](#meldingstype-kjoepekontraktframegler)

### Det finnes ingen kjøp på kunden
Dersom det ikke finnes noen kjøp på kunden, må megler kunne svare med en beskjed om dette.

### Oversendelse uten forespørsel fra bank
I tilfeller hvor megler har informasjon om banken som har verifisert finansiering, vil det være mulig for megler å sende kjøpekontrakt til bank når denne er signert, uten en forespørsel fra bank. Dette innebærer at megler kan sende kjøpekontrakt og strukturerte data ved hjelp av en pushmelding til banken.

Meldingstype: [KjoepekontraktFraMegler](#meldingstype-kjoepekontraktframegler)

### Boligen blir kjøpt på forkjøpsrett
Megler bør i rutinen avvente signering av kjøpekontrakt før forkjøpsretten er avklart. I de tilfellene banken får oversendt en signert kjøpekontrakt, kan de derfor alltid regne med at eventuell forkjøpsrett allerede er avklart.

### Ny, signert kjøpekontrakt
Ved signifikante endringer i kjøpekontrakten, kan opprettes ny signert kjøpekontrakt opprettes.
Signifikante endringer er
* kjøper lagt til eller fjernet
* eiendom/andel lagt til eller fjernet. 
  
Banken skal da få oversendt den nye signerte kjøpekontrakten sammen med strukturerte data.

Meldingstype: [KjoepekontraktFraMegler](#meldingstype-kjoepekontraktframegler)

# Implementasjon

---

## Implementasjonskrav

Alle banker som implementerer støtte for mottak av [KjoepekontraktSvarFraMegler](#meldingstype-kjoepekontraktsvarframegler) må også støtte sending av [KjoepekontraktFraMegler](#meldingstype-kjoepekontraktframegler).

## Meldingstyper

### Oversikt over meldingstype
| Navn | Beskrivelse | Payload/vedlagt fil | 
|------|------|----|
| [KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank) | Bank forespør kjøpekontrakt fra magler | XSD: KjoepekontraktforespoerselFraBank | 
| [KjoepekontraktSvarFraMegler](#meldingstype-kjoepekontraktsvarframegler)  | Svar på Kjøpekontraktforespørsel fra megler | XSD: KjoepekontraktSvarFraMegler |
| [KjoepekontraktFraMegler](#meldingstype-kjoepekontraktframegler) | Megler sender uoppfordret til bank eller ved ved viktige endringer. Denne meldingen skal ikke besvares | XSD: KjoepekontraktFraMegler |  

### Meldingstype: KjoepekontraktforespoerselFraBank

#### Validering og ruting (banksystem)
Bank forespør kjøpekontrakt fra megler. 
Skal innehold megler(`KjoepekontraktforespoerselFraBank.megler`), bank(`KjoepekontraktforespoerselFraBank.bank`) 
og minst en av kjøperene(`KjoepekontraktforespoerselFraBank.kjoepere`).

[Se XML eksempel](./examples/kjoepekontraktforespoerselFraBank-example.xml)

#### Payload
En ZIP-fil som inneholder en XML med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve-1.0.0.xsd)
  
#### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Required|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|KjoepekontraktforespoerselFraBank|


### Meldingstype: KjoepekontraktSvarFraMegler
Svar på [KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank) fra megler. 

*Alle kjøperkontrakter som har minst en kjøper fra forespøreselen skal returneres.*

Megler må ta var på `KjoepekontraktforespoerselFraBank.bank.referanse` på saken. Skal brukes til å sette `kjoepekontrakt.bank.referanse` ved sending av endringer, [KjoepekontraktFraMegler](#meldingstype-kjoepekontraktframegler) 

#### Validering og ruting (meglersystem)
Håndtering av meldingstype KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank):
- systemleverandør/meglersystem søker blant alle sine kunders oppdrag/oppgjør etter kjøpekontrakt.
- OG utvalget av kjøpekontrakter avgrenses til:
  - meglersaker hvor organisasjonsnummeret til _enten_ meglerforetaket eller oppgjørsforetaket på meglersaken er lik organisasjonsnummeret meldingen er sendt til ("reportee")
  - OG meglersaker hvor **minst 1 kjøper i forespørselen er registrert som kjøper på meglersaken**
  - OG meglersaker som ikke er slettet/arkivert eller eldre enn ?

[Se XML eksempel](./examples/kjoepekontraktsvarFraMegler-example.xml)

> Hvilke data skal minimum være på plass for en skal kalle det kjøpekontrakt? I den funksjonelle beskrivelsen over står det _Dersom ikke all strukturert informasjon er lagt inn i meglersystemet enda, skal megler sende det som finnes av informasjon_

> Hvor gamle kjøpekontrakter skal returneres?   
> Når "arkiveres" eller ferdigstilles et oppdrag?   
> Må også ta hensyn til GDPR. Hvor lange er det hensiktsmessig/lovlig å lagre data.

#### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Ja|KjoepekontraktsvarFraMegler|
|status|String (enum)|Ja|Denne kan være en av følgende statuser: <ol><li>**RutetSuksessfullt**<br/>Status 'RutetSuksessfullt' er å anse som ACK (positive acknowledgement) hvor . Øvrige statuser er å anse som NACK (negative acknowledgement).</li><li>**UgyldigKjøper**<br/>Megler har ikke funnet oppgjør/oppdrag for angitt kjøper(e)</li> <li>**Avvist** (sendt til et organisasjonsnummer som ikke lenger har et aktivt kundeforhold hos leverandøren - feil config i Altinn AFPANT, eller ugyldig forsendelse).</li></ol>Kun status '**RutetSuksessfullt**' er å anse som ACK (positive acknowledgement) hvor . Øvrige statuser er å anse som NACK (negative acknowledgement).|
|statusDescription|String|Nei|Inneholder en utfyllende human-readable beskrivelse om hvorfor en forsendelse ble NACK'et.|

#### Payload
En ZIP-fil som inneholder en XML med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve-1.0.0.xsd)

##### Positiv resultat (ACK)
- En xml-fil av modell **kjoepekontraktsvarFraMegler** som er i henhold til [definert skjema](../afpant-model/xsd/dsve-1.0.0.xsd).

Merk at signert kjøpekontrakte er inline i **Kjoepekontrakt** (base64 encoded) og ikke som en egen fil i ZIP-filen.

##### Negativt resultat (NACK)
- Tom payload returneres (ZIP arkiv med dummy innhold). Manifest key "status" og "statusDescription" må avleses for årsak.

### Meldingstype: KjoepekontraktFraMegler
Megler sender uoppfordret til bank eller ved ved viktige endringer.

Denne meldingen skal kun sendes uoppfordret fra megler til bank dersom kjøpekontrakten er signert.

Sendes ved endring, dvs. at megler har tidligere sendt uoppfordret eller har mottatt en forespørsel.
Felter som krever at det sendes en `KjoepekontraktFraMegler` melding til bank er marker med _hake_ i tabell under [Svar fra megler](#svar-fra-megler)

_Denne meldingen skal ikke besvares._ 

#### Validering og ruting(banksystem)
Mottakende systemleverandør søker blant lånesaker hvor saksnummer matcher `kjoepekontrakt.bank.referanse` dersom den er angitt.

Dersom dette er en uoppfordret melding med signert kjøpekontrakt, trenger ikke `kjoepekontrakt.bank.referanse` være utfyldt.
I disse tilfellene må bank:
* søke blant lånsesaker avgrenset til:
  * eiendommer/borettsandeler angitt i kjøpekontrakten
  * OG minst 1 kjøper angitt i kjøpekontrakten
  
#### Validering og ruting(meglersystem)
Megler må sette `kjoepekontrakt.bank.referanse` dersom megler tidligere har mottatt [KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank) 

> Trenger banken i disse tilfellen å få vite hvilke endringer som er gjort i de strukturerte data evt. om den signert kjøpekontrakten er endret?

#### Payload
En ZIP-fil som inneholder en XML med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve-1.0.0.xsd)

#### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Required|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|KjoepekontraktFraMegler|
	

