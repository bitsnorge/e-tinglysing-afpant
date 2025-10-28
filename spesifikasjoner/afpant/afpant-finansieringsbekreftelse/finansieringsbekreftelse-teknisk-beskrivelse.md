# Bekreftelse på finansiering – teknisk beskrivelse

![Flyt Finansieringsbekreftelse](./finansieringsbekreftelse.svg)

Flyten over beskriver hvordan finansieringen av et bud godkjennes av en bank under en budrunde.

1. Et signal ([FinansieringsbekreftelseForespoersel](#meldingstype-finansieringsbekreftelseforespoersel)) sendes til banken for å bekrefte finansieringen av et bud.  
2. Banken bekrefter dette ([FinansieringsbekreftelseSvar](#meldingstype-finansieringsbekreftelsesvar)).  
3. Hvis budet godkjennes av selger, betraktes budrunden som avsluttet, og et signal ([FinansieringsbekreftelseAvsluttet](#meldingstype-finansieringsbekreftelseavsluttet)) sendes til banken om at budet er godkjent.  
   Dersom det godkjente budet er verifisert via banken, sendes et signal ([FinansieringsbekreftelseAvsluttetForKjøpere](#meldingstype-finansieringsbekreftelseavsluttetforkjøpere)) til alle banker som har mottatt minst ett signal av typen FinansieringsbekreftelseForespoersel, som informerer om at budrunden er avsluttet.

![Oversikt over strukturerte data for FinansieringsbekreftelseForespoersel](./modeller/finansieringsbekreftelseForespoersel-modell.svg)  
![Oversikt over strukturerte data for FinansieringsbekreftelseAvsluttetForKjøpere](./modeller/finansieringsbekreftelseAvsluttetForKjoepere-modell.svg)

---

# Implementasjonskrav

Alle banker som implementerer støtte for mottak av [FinansieringsbekreftelseForespoersel](#meldingstype-finansieringsbekreftelseforespoersel)
må også støtte mottak av [FinansieringsbekreftelseAvsluttet](#meldingstype-finansieringsbekreftelseavsluttet) og [FinansieringsbekreftelseAvsluttetForKjøpere](#meldingstype-finansieringsbekreftelseavsluttetforkjøpere).

---

# Meldingstyper

## Oversikt over meldingstyper for bekreftelse på finansiering

| Navn | Beskrivelse | Payload / vedlagt fil | 
|------|--------------|------------------------|
| [FinansieringsbekreftelseForespoersel](#meldingstype-finansieringsbekreftelseforespoersel) | Forespørsel fra megler til bank om å bekrefte finansiering av et bud | XSD: FinansieringsbekreftelseForespoersel |
| [FinansieringsbekreftelseSvar](#meldingstype-finansieringsbekreftelsesvar) | Svar fra bank på FinansieringsbekreftelseForespoersel | XSD: FinansieringsbekreftelseSvar |
| [FinansieringsbekreftelseAvsluttet](#meldingstype-finansieringsbekreftelseavsluttet) | Signal om at budrunden er avsluttet. Signalet sendes kun dersom minst én [FinansieringsbekreftelseForespoersel](#meldingstype-finansieringsbekreftelseforespoersel) er sendt tidligere. | XSD: FinansieringsbekreftelseAvsluttet |
| [FinansieringsbekreftelseAvsluttetForKjøpere](#meldingstype-finansieringsbekreftelseavsluttetforkjøpere) | Signal om at budrunden er avsluttet og kunden er utpekt som kjøper. Signalet sendes kun dersom minst én [FinansieringsbekreftelseForespoersel](#meldingstype-finansieringsbekreftelseforespoersel) er sendt tidligere, og det godkjente budet er verifisert via banken. | XSD: FinansieringsbekreftelseAvsluttetForKjøpere |

---

# Meldingstype: FinansieringsbekreftelseForespoersel

Megler forespør bekreftelse på finansiering fra bank.

## Validering og ruting

### Ruting (meglersystem)
Megler forespør bekreftelse på finansiering fra bank.
 
[Se XML-eksempel](../afpant-model/examples/finansieringsbekreftelse-forespoersel-example.xml)

### Ruting (banksystem)
- Mottakende systemleverandør søker etter aktive finansieringsbevis som er knyttet til den aktuelle kunden.  
- Dersom finansieringsbevis finnes, sammenlignes kundens ønskede lånebeløp med beløpsgrensen i finansieringsbeviset.  
- Hvis lånebeløpet kan innvilges, skal banken svare **APPROVED**, ellers **DISAPPROVED**.

[Se XML-eksempel](../afpant-model/examples/finansieringsbekreftelse-svar-example.xml)

### Payload

En ZIP-fil som inneholder en XML med forespørselsdata i henhold til [definert skjema](../afpant-model/xsd/dsve.xsd).

**Krav til filnavn i ZIP-arkiv:**  
* Filnavnet til meldingen FinansieringsbekreftelseForespoersel må følge konvensjonen:  
  `_finansieringsbekreftelserequest*.xml_` (navnet på meldingen i små bokstaver)

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

| Manifest key | Type | Obligatorisk | Beskrivelse |
|---------------|------|---------------|--------------|
| messageType | String | Ja | FinansieringsbekreftelseForespoersel |

---

# Meldingstype: FinansieringsbekreftelseSvar

Svar på [FinansieringsbekreftelseForespoersel](#meldingstype-finansieringsbekreftelseforespoersel) fra banken.  
Banken svarer med status på forespørselen.

### Payload

En ZIP-fil som inneholder en XML med forespørselsdata i henhold til [definert skjema](../afpant-model/xsd/dsve.xsd).

**Krav til filnavn i ZIP-arkiv:**  
* Filnavnet til meldingen FinansieringsbekreftelseSvar må følge konvensjonen:  
  `_finansieringsbekreftelseresponse*.xml_` (navnet på meldingen i små bokstaver)

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

| Manifest key | Type | Obligatorisk | Beskrivelse |
|---------------|------|---------------|--------------|
| messageType | String | Ja | FinansieringsbekreftelseSvar |
| status | String (enum) | Ja | Denne kan ha én av følgende verdier: <ol><li>**APPROVED** – Banken bekrefter at budet kan finansieres av banken.</li><li>**DISAPPROVED** – Banken kan ikke bekrefte finansieringen av budet.</li><li>**CUSTOMER_CONTACT** – Banken trenger mer informasjon for å håndtere forespørselen. Budgiveren skal varsles om å ta kontakt med sin bank.</li><li>**MANUAL** – Banken kan ikke håndtere forespørselen automatisk.</li></ol> |

---

# Meldingstype: FinansieringsbekreftelseAvsluttet

Budrunden er avsluttet, og banken kan slette alle data knyttet til denne budrunden som er lagret i bankens system.

### Payload

En ZIP-fil som inneholder en XML med forespørselsdata i henhold til [definert skjema](../afpant-model/xsd/dsve.xsd).

**Krav til filnavn i ZIP-arkiv:**  
* Filnavnet til meldingen FinansieringsbekreftelseAvsluttet må følge konvensjonen:  
  `_finansieringsbekreftelseAvsluttet*.xml_` (navnet på meldingen i små bokstaver)

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

| Manifest key | Type | Obligatorisk | Beskrivelse |
|---------------|------|---------------|--------------|
| messageType | String | Ja | FinansieringsbekreftelseAvsluttet |

---

# Meldingstype: FinansieringsbekreftelseAvsluttetForKjøpere

Budrunden er avsluttet, og kunden er utpekt som kjøper.  
Banken kan velge å følge opp med kunden, eller slette alle data for denne budrunden som er lagret i bankens system.

### Payload

En ZIP-fil som inneholder en XML med forespørselsdata i henhold til [definert skjema](../afpant-model/xsd/dsve.xsd).

**Krav til filnavn i ZIP-arkiv:**  
* Filnavnet til meldingen FinansieringsbekreftelseAvsluttetForKjøpere må følge konvensjonen:  
  `_finansieringsbekreftelseAvsluttetForKjoepere*.xml_` (navnet på meldingen i små bokstaver)

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

| Manifest key | Type | Obligatorisk | Beskrivelse |
|---------------|------|---------------|--------------|
| messageType | String | Ja | FinansieringsbekreftelseAvsluttetForKjøpere |