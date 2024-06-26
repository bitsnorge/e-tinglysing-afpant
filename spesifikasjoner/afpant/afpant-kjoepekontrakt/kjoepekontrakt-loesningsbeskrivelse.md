Kjøpekontrakt - Løsningsbeskrivelse
===================================
---
# Innledning
Dette dokumentet beskriver løsning for oversendelse av kjøpekontrakt fra megler til bank. Kjøpekontrakten skal kunne sendes både som strukturerte data og som signert dokument, og informasjon skal også kunne sendes før endelig dokument er signert.

## Overordnet beskrivelse
Kjøpekontrakt eller informasjon fra kjøpekontrakten skal kunne oversendes fra megler til bank, via allerede etablert løsning mot AFPANT.

En bank kan sende forespørsel om kjøpekontrakt til en megler basert på kjøpers fødselsnummer (11 siffer). Megler vil besvare forespørselen med en forsendelse som inneholder strukturerte data, samt en signert versjon av den fulle kjøpekontrakten. Dersom den faktiske kjøpekontrakten ikke er signert, skal kun den strukturerte delen returneres. Dersom forespørselen ikke kan besvares, vil banken få en feilmelding i retur som beskriver hvorfor megler ikke kan besvare forespørselen. I noen tilfeller kan kjøpers fødselsnummer treffe på flere oppdrag for den aktuelle megleren, og en liste med 1 eller flere kjøpekontrakter sendes da til banken.

Løsningen kjøpekontrakt er delt i to deler:
|Del|Beskrivelse|
|----|------|
|[1](#informasjonsflyt-del-1)|Bank forespør kjøpekontrakt, og megler sender informasjon om kjøpekontrakter tilbake. Megler pusher deretter endringer og tillegg i kjøpekontrakten uoppfordret, til bank som allerede har forespurt kjøpekontrakten.  |
|[2](#oversendelse-uten-forespørsel-fra-bank-del-2)|Megler pusher kjøpekontrakt uoppfordret til bank som ikke har forespurt noe. |

# Informasjonsflyt (del 1)

## Henvendelse fra bank
Ved henvendelse fra bank til megler, med ønske om å få oversendt kjøpekontrakt, skal banken sende følgende informasjon til meglers organisasjonsnummer;

| Én av kjøpernes fødselsnummer |
|---|

Meldingstype: [KjoepekontraktforespoerselFraBank](./kjoepekontrakt-teknisk-beskrivelse.md#meldingstype-kjoepekontraktforespoerselfrabank)

## Svar fra megler
Ved henvendelse fra bank om oversendelse av kjøpekontrakt, skal megler sende strukturert informasjon, i tillegg til signert kjøpekontrakt dersom denne er signert når henvendelsen kommer. Referansen i en kjøpekontrakt må være unik for et oppdrag og ikke endre seg ila samhandlingen.
Følgende informasjon skal oversendes som strukturerte data;

|Datafelt|Sendes ved endring|
|:-------|:-----------------|
|**Mottaker:** Bank/Finansieringsselskaps firmanavn / Org.nummer                                     |      |
|**Avsender:** Meglerforetak / Org.nr. / Ansvarlig megler / Mobilnummer / Mailadresse                |      |
|**Oppgjørsavdeling:** Inkludert oppgjørsmeglers fulle adresse                                       |      |
|**Oppdragsnummer:**                                                                                 |      |
|**Oppgjørsinformasjon:** Kontonummer / KID nummer / betalingsmelding                                | :white_check_mark: |
|**Eiendomsinformasjon:** Kommunenummer / Gårdsnummer / Bruksnummer / Festenummer / Seksjonsnummer / Adresse / Postnummer (det må være mulig med flere gårds- og bruksnummer) Ved andel/aksje: Organisasjonsnummer / Andelsnummer /Aksjenummer(Informasjon om personlige sameier og hvorvidt de skal pantsettes må inkluderes) | :white_check_mark: |
|**Kjøpesum:** Budakseptert beløp                                                                    | :white_check_mark: |
|**Omkostninger for kjøper:** (Eks. boligkjøperforsikring pga. manglende felt)                       | :white_check_mark: |
|**Oppgjørsbeløp:** Kjøpesum + kjøpsomkostninger (det skal angis om beløpet er tentativt eller satt) | :white_check_mark: |
|**Overtagelsesdato:** Denne skal ikke fylles ut dersom nybygg                                       | :white_check_mark: |
|**Andel fellesgjeld:**                                                                              | :white_check_mark: |
|**Andel fellesformue:**                                                                             |      |
|**Selger:** Navn og fødselsnummer på alle selgere, dersom selger ikke er hjemmelshaver              |      |
|**Hjemmelshaver:** Navn og fødselsnummer på alle hjemmelshavere                                     |      |
|**Kjøper:** Navn og fødselsnummer på alle kjøpere                                                   | :white_check_mark: |
|**Kjøpers eierandel:** Oppgitt i brøk pr kjøper                                                     | :white_check_mark: |
|**Objektstype:** Type eiendom/bygning                                                               |:white_check_mark: |
|**Link til salgsoppgave:** (Valgfritt felt)                                                         |      |
|**Signert kjøpekontrakt:** (Valgfritt felt)                                                         | :white_check_mark: |

Det er et ønske om at dersom ikke all strukturert informasjon er lagt inn i meglersystemet enda, skal megler likevel sende det som finnes av informasjon. 
Bank vil så få push-varsel om oppdatert informasjon så snart dette er lagt til. Kun endringer i de datafeltene som er merket over vil medføre push-varsel.
*For at dette skal være mulig, må også skjemaet (XSD-filen) gjenspeile dette ved at felter som kan mangle må defineres som valgfrie.*


Signert kjøpekontrakt skal alltid sendes elektronisk, uavhengig av om det er elektronisk signert, eller om det sendes en PDF av et fysisk signert dokument.
Når bank mottar en PDF av kjøpekontrakt betyr det at kjøpekontrakten er signert. Signeringsdato inkluderes ikke i kjøpekontrakt-meldingene som sendes fra megler til bank. 

Meldingstype: [KjoepekontraktSvarFraMegler](./kjoepekontrakt-teknisk-beskrivelse.md#meldingstype-kjoepekontraktsvarframegler)

## Oversendt informasjon er endret
Det er viktig at banken har oppdatert informasjon i systemene og at denne er lik det som ligger i det signerte dokumentet. 
Dersom bank allerede har fått KjoepekontraktSvarFraMegler og megler deretter endrer eller legger til informasjon i meglersystemene,  må banken få beskjed om dette. Det gjøres ved at 
meglersystemet sender en [melding](./kjoepekontrakt-teknisk-beskrivelse.md#kjoepekontraktendringframegler-ved-endring) til banken. Meglers systemleverandør er ansvarlig for å sende oppdateringen til bank med KjoepekontraktFraMegler melding. 

Vi skiller her på endringer som skjer før og etter kjøpekontrakt er signert:
- Oppdateringer som skjer etter at kjøpekontrakt er signert haster mest og her må meglersystemet minimum polle for endringer på sin side hvert 5 minutt og sende melding til banken ved endringer. 
- For endringer og ny informasjon knyttet til kjøpekontrakten som skjer før den er signert skal tilsvarende polling intervall og oppdatering til bank settes til minimum 1 gang pr døgn, dette for å unngå flere oppdateringer til bank enn nødvendig.

Når løsningen er tatt i bruk og det er opparbeidet erfaring, kan det vurderes om det er behov for å justere intervall-lengdene.


Hvilke felter som skal trigge en melding til banken om at det har skjedd en endring, er merket i tabellen under [Svar fra megler](#svar-fra-megler).


Meldingstype: [kjoepekontraktEndringFraMegler](./kjoepekontrakt-teknisk-beskrivelse.md#kjoepekontraktendringframegler-ved-endring) 

## Avbrutt samhandling

Sendes når forutseningen for samhandling ikke lenger er tilstede. Dette kan for eksempel gjelde hvis kjøper i oppdraget er endret slik at opprinnelig kunde ikke lenger inngår i oppdraget og GDPR tilsier at man ikke lenger kan motta informasjon fra megler.
Det er opp til mottaker å avgjøre hva som skjer i systmet i etterkant av denne meldingen.

Meldingtypen "AvbruttSamhandling" gir ikke ACK/NACK fra mottaker.

I AKELDO kan meldingstypen "AvbruttSamhandling" finnes både på en aktørs 'sendeliste' og 'mottaksliste'. 
Det lages ikke en avbrutt melding per "hovedmelding". Ved mottak skal man anta at all samhandling avsluttes for eksempel både kjøpekontrak og intensjon.

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk| Beskrivelse        |
|--- |--- |--- |--------------------|
|messageType|String|Ja| AvbruttSamhandling |

Meldingstype: [AvbruttSamhandling](./kjoepekontrakt-teknisk-beskrivelse.md#AvbruttSamhandling)


## Uoppfordret

Meldingstype: [kjoepekontraktUoppfordretFraMegler](./kjoepekontrakt-teknisk-beskrivelse.md#kjoepekontraktuoppfordretframegler-sendes-uoppfordret)

# Alternative flyter

## Kjøpekontrakten er ikke signert
Dersom kjøpekontrakten ikke er signert på det tidspunktet bank ber om data, skal det som finnes av strukturert informasjon sendes til banken. Resterende informasjon vil kunne ettersendes sammen med det signerte dokumentet.

Det skal gå en pushvarsling fra meglersystemet til banken eller bankene som har bedt om kjøpekontrakt så snart kjøpekontrakten er 
signert eller det er endringer i datafeltene. Dette skal sendes som en egen [meldingstype](./kjoepekontrakt-teknisk-beskrivelse.md#kjoepekontraktendringframegler-ved-endring). 
For at banken skal kunne koble kjøpekontrakten til sin egen sak, er det viktig at bankens referanse fra kjøpekontraktforespørselen er med.

Det er viktig at meglersystemene sørger for at det signerte dokumentet alltid inneholder lik informasjon 
som det som ligger av strukturerte data.

Det skal ikke sendes et dokument ved siden av de strukturerte dataene, dersom det ikke finnes et signert dokument.

## Kunden har kjøpt flere boliger
Dersom kunden har kjøpt flere boliger via samme megler og en henvendelse fra bank får treff på flere aktive oppdrag, 
skal informasjon om alle oppdragene sendes til banken. Banken må selv håndtere dette i sine systemer, og lage en løsning 
som støtter at rådgiver kan måtte velge mellom de ulike kjøpekontraktene.

## Det finnes ingen oppdrag på kunden
Dersom det ikke finnes noen megleroppdrag på angitt fødselsnummer, må megler kunne svare med en beskjed om dette.

## Boligen blir kjøpt på forkjøpsrett
Megler bør avvente signering av kjøpekontrakt til etter forkjøpsretten er avklart. I de tilfellene banken får oversendt en signert kjøpekontrakt, kan de derfor alltid regne med at eventuell forkjøpsrett allerede er avklart.

## Ny, signert kjøpekontrakt
Ved signifikante endringer i kjøpekontrakten, kan en ny kjøpekontrakt opprettes og signeres.
Signifikante endringer er:
* Kjøper lagt til eller fjernet
* Eiendom/andel lagt til eller fjernet. 
  
Banken skal da få oversendt den nye, signerte kjøpekontrakten sammen med strukturerte data.
Endringer i signert kjøpekontrakt indikeres ved at meldingen sendes med et nytt unikt vedleggsnavn ift. hva som er sendt tidligere for den aktuelle kjøpekontrakten. 

Merk: Bank har selv ansvar for å holde orden på hvilke endringer som er gjort siden siste kjøpekontrakt fra megler. Det gjelder også tilsendt PDF. Den opprinnelige kontrakten vil ikke automatisk trekkes tilbake. Dette må p.t. håndteres manuelt mellom bank og megler.


Meldingstype: [kjoepekontraktEndringFraMegler](./kjoepekontrakt-teknisk-beskrivelse.md#kjoepekontraktendringframegler-ved-endring)

## Bank spør på samme oppdrag flere ganger
Bank kan spørre på samme oppdrag flere ganger. Så lenge man spør med samme referanse kan megler anta at det er samme og skal bare å kommunisere endringer en gang. Hvis bank spør flere ganger på samme oppdrag, men med forskjellig referanse må det anses som urelaterte forespørsler og endringer må sendes til begge.

# Oversendelse uten forespørsel fra bank (del 2)
I tilfeller hvor megler har informasjon om banken som har verifisert finansiering, vil det være mulig for megler å sende kjøpekontrakt 
til bank når denne er signert, uten å først ha mottatt en forespørsel fra banken. 
Dette innebærer at megler kan sende kjøpekontrakt og strukturerte data ved hjelp av en pushmelding til banken.
I slike tilfeller vil megler da ikke kunne fylle ut bankens referanse i meldingen!





