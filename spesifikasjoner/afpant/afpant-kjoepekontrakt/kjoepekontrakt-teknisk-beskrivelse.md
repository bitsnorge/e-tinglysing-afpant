Kjøpekontrakt - teknisk-beskrivelse
==========================================

Beskrivelse av teknisk løsning for meldinger som gjør at megler kan dele strukturerte data i kjøpekontrakten med bank.

![Enkel flyt](./enkel_flyt.svg)

Hovedflyten består i at bank [forespør megler](#meldingstype-kjoepekontraktforespoerselfrabank) etter kjøpekontrakt, og megler [svarer med kjøpekontrakten](#meldingstype-kjoepekontraktsvarframegler). 
Ved signifikante endringer skal megler [sende kjøpekontrakten](#meldingstype-kjoepekontraktframegler) igjen.
Hvilke endringer/felter som krever at megler sender på nytt er angitt med _hake_ i tabellen i [løsningsbeskrivelsen](kjoepekontrakt-loesningsbeskrivelse.md#svar-fra-megler) 

![Oversikt over strukurerte kjøpekontrakt data](./modell.svg)

# Implementasjonskrav

Alle banker som implementerer støtte for mottak av [KjoepekontraktSvarFraMegler](#meldingstype-kjoepekontraktsvarframegler) 
må også støtte mottak av [KjoepekontraktFraMegler](#meldingstype-kjoepekontraktframegler).

Kjøpekontraktsendringer stoppes dersom forutsetningene ikke lengre er tilstede. Dette uavhengig av om det er implementert støtte for [AvbruttSamhandling](#AvbruttSamhandling).

# Meldingstyper
## Oversikt over meldingstyper for kjøpekontrakt
| Navn                                                                                         | Beskrivelse                                                                                                                                                | Payload/vedlagt fil                    | 
|----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------|
| [KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank)         | Bank forespør kjøpekontrakt fra megler                                                                                                                     | XSD: KjoepekontraktforespoerselFraBank | 
| [KjoepekontraktSvarFraMegler](#meldingstype-kjoepekontraktsvarframegler)                     | Meglers svar på Kjøpekontraktforespørsel fra bank                                                                                                          | XSD: KjoepekontraktSvarFraMegler       |
| [KjoepekontraktEndringFraMegler](#kjoepekontraktendringframegler-ved-endring)                | Megler sender endringer og tillegg i kjøpekontrakten uoppfordret, til bank som allerede har forespurt kjøpekontrakten. Denne meldingen skal ikke besvares. | XSD: KjoepekontraktFraMegler           |
| [AvbruttSamhandling](#AvbruttSamhandling)                             | Megler sender til bank hvis det er endringer som gjør at videre samhandling ikke er aktuelt.                                                               | XSD: AvbruttSamhandling                |
| [KjoepekontraktUoppfordretFraMegler](#kjoepekontraktuoppfordretframegler-sendes-uoppfordret) | Megler sender kjøpekontrakt uoppfordret til bank som ikke har forespurt kjøpekontrakt. Denne meldingen skal ikke besvares.                                 | XSD: KjoepekontraktFraMegler           |

# Meldingstype: KjoepekontraktforespoerselFraBank
Bank forespør kjøpekontrakt fra megler

## Validering og ruting (banksystem)
Bank forespør kjøpekontrakt fra megler.

Skal innehold megler(`kjoepekontraktforespoerselfrabank.megler`), bank(`kjoepekontraktforespoerselfrabank.bank`) 
og minst en av kjøperene(`kjoepekontraktforespoerselfrabank.kjoepere`).

[Se XML-eksempel:](./examples/kjoepekontraktforespoerselFraBank-example.xml)

## Payload
ZIP-arkiv som skal inneholde en XML fil med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve.xsd)

**Krav til filnavn i ZIP-arkiv:** Filnavnet til meldingen KjoepekontraktFraMegler må følge konvensjonen: _kjoepekontraktforespoerselfrabank*.xml_ . (navnet til meldingen i lowercase)

Wildcard "*" kan erstattes med en vilkårlig streng (må være et gyldig filnavn), f.eks lånesaksnummer eller annen relevant referanse for avsender. 

## Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Required|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|KjoepekontraktforespoerselFraBank|


# Meldingstype: KjoepekontraktSvarFraMegler
Meglers svar på [KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank) fra banken. 

*Kjøperkontrakt fra aktive<sup id="ref_f1">[1](#f1)</sup> oppdrag som har minst en kjøper fra forespøreselen skal returneres.*

Megler må ta var på `kjoepekontraktforespoerselfrabank.bank.referanse` på saken. Skal brukes til å sette `kjoepekontrakt.bank.referanse` 
ved sending av svaret og evt. senere endringer, [KjoepekontraktFraMegler](#meldingstype-kjoepekontraktframegler) 

Dersom kjøpekontrakten er signert skal vedlegget med korrekt filnavn være definert som en ressurs/vedlegg i meldingens metadata 
OG eksistere i ZIP-arkivet.

## Validering og ruting (meglersystem)
Håndtering av meldingstype [KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank):
- Systemleverandør/meglersystem søker blant alle sine kunders oppdrag/oppgjør etter strukturerte kjøpekontraktsdata, eventuelt med tilhørende signert kjøpekontrakt.
- OG utvalget avgrenses til:
  - meglersaker hvor organisasjonsnummeret til meglerforetaket på meglersaken er lik organisasjonsnummeret megler(`kjoepekontraktforespoerselfrabank.megler`)
  - OG meglersaker hvor **minst 1 kjøper i forespørselen er registrert som kjøper på meglersaken**
  - OG meglersaker som ikke er slettet/arkivert eller eldre enn 1 år. Grensen på 1 år vil potensielt justeres hvis vi ser behov for dette etter å ha tatt i bruk systemet i produksjon.

[Se XML-eksempel](./examples/kjoepekontraktsvarFraMegler-example.xml)

## Payload

Dersom status i manifestet er _RutetSuksessfullt_ (se beskrivelse av manifest under) skal ZIP-arkivet inneholde en xml-fil 
med `kjoepekontraktsvarFraMegler` som root element definert av [definert skjema.](../afpant-model/xsd/dsve.xsd)
Dersom kjøpekontrakten er signert skal ZIP-arkiv også innholde den signert kjøpekontrakten være med som en egen fil.
Den signert kjøpekontrakten er enten en PDF eller en SDO.

Ved negativt resultat lasted et tomt zip-arkiv opp. Manifest key "status" og "statusDescription" må avleses for årsak.

**Krav til filnavn i ZIP-arkiv:** 
* Filnavnet til meldingen KjoepekontraktSvarFraMegler må følge konvensjonen: _kjoepekontraktsvarframegler*.xml_ . (navnet til meldingen i lowercase)
* Filnavnet til en evt. signert kjøpekontrakt skal følge konvensjonen: _signert_kjoepekontrakt*.(pdf|sdo)_.
* Filnavn kjøpekontrakt i zip må være unikt i forsendelsen og være likt `vedlegg.navn` for tilhørende kjøpekontraktsdata. 

## Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Ja|KjoepekontraktsvarFraMegler|
|status|String (enum)|Ja|Denne kan være en av følgende statuser: <ol><li>**RutetSuksessfullt**<br/>Status 'RutetSuksessfullt' er å anse som ACK (positive acknowledgement) hvor . Øvrige statuser er å anse som NACK (negative acknowledgement).</li><li>**UgyldigKjøper**<br/>Megler har ikke funnet oppgjør/oppdrag for angitt(e) kjøper(e)</li> <li>**Avvist** (sendt til et organisasjonsnummer som ikke lenger har et aktivt kundeforhold hos leverandøren - feil config i Altinn AFPANT, eller ugyldig forsendelse).</li></ol>Kun status '**RutetSuksessfullt**' er å anse som ACK (positive acknowledgement) hvor . Øvrige statuser er å anse som NACK (negative acknowledgement).|
|statusDescription|String|Nei|Inneholder en utfyllende, menneskelig-lesbar beskrivelse om hvorfor en forsendelse ble NACK-et.|

## Payload
En ZIP-fil som inneholder en XML med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve.xsd)

### Positiv resultat (ACK)
- En xml-fil med **kjoepekontraktsvarFraMegler** som root element og som er i henhold til [definert skjema](../afpant-model/xsd/dsve.xsd).

Merk at signert kjøpekontrakt skal finnes som en egen fil i ZIP-arkivet dersom metdata inneholder et vedlegg som matcher _signert_kjoepekontrakt*.(pdf|sdo)_.

### Negativt resultat (NACK)
- Tom payload returneres (ZIP arkiv med dummy innhold). Manifest key "status" og "statusDescription" må avleses for årsak.

# Meldingstype: KjoepekontraktFraMegler
Megler sender uoppfordret til bank eller ved ved signifikante endringer.

For hhv. uoppfordret kjøpekontrakt fra megler og endringer i kjøpekontrakt der megler tidligere har besvart bank på forespørsel, skiller vi på 2 meldingstyper med forskjellig navn men samme type/struktur:

### kjoepekontraktUoppfordretFraMegler (sendes uoppfordret)  
*Sendes uoppfordret, uten at bank har forespurt kjøpekontrakt.*

  Denne meldingen kan kun sendes uoppfordret fra megler til bank dersom kjøpekontrakten er signert. 
Den signert kjøpekontrakten skal da finnes i ZIP-arkivet som _signert_kjoepekontrakt*.(pdf|sdo)_ 
OG metdata skal inneholde en ressurs/vedlegg med korrekt navn.

### kjoepekontraktEndringFraMegler (ved endring) 
*Bank har tidligere forespurt kjøpekontrakt eller mottatt signert kjøpekontrakt uoppfordret.* 

  Sendes ved endring, dvs. at megler har tidligere sendt uoppfordret eller har mottatt en forespørsel.
Felter som krever at det sendes en `KjoepekontraktFraMegler` melding til bank er markert med _hake_ i tabellen i [løsningsbeskrivelsen](kjoepekontrakt-loesningsbeskrivelse.md#svar-fra-megler).

Meglers systemleverandør er ansvarlig for å sende oppdateringer til bank med KjoepekontraktFraMegler melding. Hvor ofte meglersystemene må polle for endringer og sende oppdatering til bank er definert i [løsningsbeskrivelsen](kjoepekontrakt-loesningsbeskrivelse.md#oversendt-informasjon-er-endret).

Dersom kjøpekontrakten er signert skal vedlegget med korrekt filnavn være definert som en ressurs/vedlegg i meldingens metadata OG eksistere i ZIP-arkivet.
For endringer i signert kjøpekontrakt er det et krav at KjoepekontraktFraMegler-meldingen sendes med et nytt unikt vedleggsnavn ift hva som er sendt tidligere for den aktuelle kjøpekontrakten - nytt filnavn skal inneholde tidsstempel. 

Meglers systemleverandør slutter å sende oppdateringer via kjoepekontraktEndringFraMegler for saker når de er slettet/arkivert eller eldre enn 1 år. Grensen på 1 år vil potensielt justeres hvis vi ser behov for dette etter å ha tatt i bruk systemet i produksjon.


_Denne meldingen skal ikke besvares._ 

### AvbruttSamhandling
Sendes når forutseningen for samhandling ikke lenger er tilstede. 
Dette kan for eksempel gjelde hvis kjøper i oppdraget er endret slik at opprinnelig kunde ikke lenger inngår i oppdraget og GDPR tilsier at man ikke lenger kan motta informasjon fra megler.
Det er opp til megler/megler sitt system å avgjøre når denne meldingen skal sendes.
Det er opp til mottaker å avgjøre hva som skjer i systmet i etterkant av denne meldingen.

_Denne meldingen skal ikke besvares._

## Validering og ruting(banksystem)
Mottakende systemleverandør søker blant lånesaker hvor saksnummer matcher `kjoepekontrakt.bank.referanse` dersom den er angitt.

Dersom dette er en uoppfordret melding med signert kjøpekontrakt, trenger ikke `kjoepekontrakt.bank.referanse` være utfylt.
I disse tilfellene må bank:
* søke blant lånsesaker avgrenset til:
  * eiendommer/borettsandeler angitt i kjøpekontrakten
  * OG minst 1 kjøper angitt i kjøpekontrakten
  
## Validering og ruting(meglersystem)
Megler må sette `kjoepekontrakt.bank.referanse` dersom megler tidligere har mottatt [KjoepekontraktforespoerselFraBank](#meldingstype-kjoepekontraktforespoerselfrabank) 

## Payload
At ZIP-arkiv som inneholder en xml-fil med **KjoepekontraktFraMegler** som root element og som er i henhold til [definert skjema](../afpant-model/xsd/dsve.xsd).
Dersom kjøpekontrakten er signert skal ZIP-arkiv også innholde den signert kjøpekontrakten være med som en egen fil.
Den signert kjøpekontrakten er enten en PDF eller en SDO.

**Krav til filnavn i ZIP-arkiv:**
* Filnavnet til meldingen kjoepekontraktFraMegler må følge konvensjonen: _kjoepekontraktframegler*.xml_ . (navnet til meldingen i lowercase)
* Filnavnet til en evt. signert kjøpekontrakt skal følge konvensjonen: _signert_kjoepekontrakt*.(pdf|sdo)_.
* Dersom filformat er sdo må innholdet være en pdf.

## Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Required|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|KjoepekontraktFraMegler|

# Fotnoter
<b id="f1">1</b> Aktive oppdrag [↩](#ref_f1)
* Når "arkiveres" eller ferdigstilles et oppdrag? Dette er opp til megler/meglersystem.
* Hensyn til GDPR. Hvor lange er det hensiktsmessig/lovlig å lagre data.
