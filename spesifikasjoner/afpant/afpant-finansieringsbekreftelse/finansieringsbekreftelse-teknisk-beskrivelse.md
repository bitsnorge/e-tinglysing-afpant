Finansieringsbekreftelse - teknisk beskrivelse
=======================================

![Flyt Finansieringsbekreftelse](./finansieringsbekreftelse.svg)

Flyten over beskriver hvordan finansieringen av et bud godkjennes av en bank under en budgivning.
For hvert nytt bud gjentas flyten.

# Implementasjonskrav

Alle banker som implementerer støtte for mottak av [FinansieringsbekreftelseRequest](#meldingstype-finansieringsbekreftelserequest)
må også støtte mottak av [FinansieringsbekreftelseAvslutet](#meldingstype-finansieringsbekreftelseavslutet) og [FinansieringsbekreftelseAvslutetForKjoepere](#meldingstype-finansieringsbekreftelseavslutetforkjoepere).


# Meldingstyper
## Oversikt over meldingstyper for finansieringsbekreftelse
| Navn | Beskrivelse | Payload/vedlagt fil | 
|-----|-----|-----|
| [FinansieringsbekreftelseRequest](#meldingstype-finansieringsbekreftelserequest) | Bank forespør finansieringbekreftelse av et bud | XSD: FinansieringsbekreftelseRequest |
| [FinansieringsbekreftelseResponse](#meldingstype-finansieringsbekreftelseresponse) | Svar på finansieringsbekreftelseRequest | XSD: FinansieringsbekreftelseResponse |
| [FinansieringsbekreftelseAvslutet](#meldingstype-finansieringsbekreftelseavslutet) | Signal om at budgivningen er avsluttet. Signalen skickas endast om minst ett [FinansieringsbekreftelseRequest](#meldingstype-finansieringsbekreftelserequest) har skickats tidigare. | XSD: FinansieringsbekreftelseAvslutet |
| [FinansieringsbekreftelseAvslutetForKjoepere](#meldingstype-finansieringsbekreftelseavslutetforkjoepere) | Signal om at budgivningen er avsluttet og kunden er utpekt som kjøper. Signalet sendes kun hvis minst én [FinansieringsbekreftelseRequest](#meldingstype-finansieringsbekreftelserequest) er sendt tidligere og det godkjente budet er verifisert via banken. | XSD: FinansieringsbekreftelseAvslutetForKjoepere |

# Meldingstype: FinansieringsbekreftelseRequest
Megler forespør finansieringbevis från bank.

## Validering og ruting
Megler forespør finansieringbevis från bank.

[Se XML-eksempel:](./examples/finansieringsbekreftelseRequest-example.xml)

## Payload
En ZIP-fil som inneholder en XML med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve.xsd)

**Krav til filnavn i ZIP-arkiv:** 
* Filnavnet til meldingen FinansieringsbekreftelseRequest må følge konvensjonen: _finansieringsbekreftelserequest*.xml_ . (navnet til meldingen i lowercase)

## Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|FinansieringsbekreftelseRequest|

# Meldingstype: FinansieringsbekreftelseResponse
Svar på [FinansieringsbekreftelseRequest](#meldingstype-finansieringsbekreftelserequest) fra banken.

Banken svarar med status på denne spørselen.

## Payload
En ZIP-fil som inneholder en XML med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve.xsd)

**Krav til filnavn i ZIP-arkiv:** 
* Filnavnet til meldingen [FinansieringsbekreftelseResponse](#meldingstype-finansieringsbekreftelseresponse) må følge konvensjonen: _finansieringsbekreftelseresponse*.xml_ . (navnet til meldingen i lowercase)

## Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|FinansieringsbekreftelseResponse|
|status|String (enum)|Yes|Denne kan være en av følgende statuser: <ol><li>**APPROVED**<br/>Banken bekrefter at budet kan finansieres av banken.</li><li>**DISAPPROVED**<br/>Banken kan ikke bekrefte finansiering av budet.</li><li>**OTHER**<br/>Banken trenger mer informasjon for å håndtere forespørselen. Budgiveren skal bli varslet om å ta kontakt med sin bank.</li></ol> Andre statuser skal anses som NACK (negative acknowledgement).|

# Meldingstype: finansieringsbekreftelseAvslutet

Budgivningen er avsluttet og banken kan slette alle data for denne budgivningen som er lagret i bankens system.

## Payload
En ZIP-fil som inneholder en XML med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve.xsd)

**Krav til filnavn i ZIP-arkiv:** 
* Filnavnet til meldingen FinansieringsbekreftelseAvslutet må følge konvensjonen: _finansieringsbekreftelseavslutet*.xml_ . (navnet til meldingen i lowercase)

## Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|FinansieringsbekreftelseAvslutet|

# Meldingstype: finansieringsbekreftelseAvslutetForKjoepere

Budgivningen er avsluttet og kunden er utpekt som kjøper. Banken kan velge å følge opp med kunden eller slette alle data for denne budgivningen som er lagret i bankens system.

## Payload
En ZIP-fil som inneholder en XML med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve.xsd)

**Krav til filnavn i ZIP-arkiv:** 
* Filnavnet til meldingen FinansieringsbekreftelseAvslutetForKjoepere må følge konvensjonen: _finansieringsbekreftelseavslutetforkjoepere*.xml_ . (navnet til meldingen i lowercase)

## Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|FinansieringsbekreftelseAvslutetForKjoepere|

