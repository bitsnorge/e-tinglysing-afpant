# Melding om oppnådd prioritet (OppnaaddPrioritetOk)
'OppnaaddPrioritetOk' er en meldingstype som sendes fra megler til bank for å informere om at avtalt prioritet er oppnådd. 
Meldingen kommer etter meldingen 'GjennomfoertEtinglysing'(tinglyst hos Kartverket) som forventes mottatt først. 'GjennomfoertEtinglysing' skal sendes så fort tinglysning er gjennomført.

## Meldingstype: OppnaaddPrioritetOk

Meldingstypen 'OppnaaddPrioritetOk' sendes fra megler til bank for å informere om at korrekt prioritet er oppnådd.

## Implementasjonskrav
Banker som ønsker å motta meldingen må være registrert som aktiv i Akeldo registeret med støtte for meldingstypen 'OppnaaddPrioritetOk' i mottaksliste.
Meglere som støtter å sende 'OppnaaddPrioritetOk' skal være registrert i Akeldo med støtte for meldingstypen 'OppnaaddPrioritetOk' i sendeliste.


Når bank sender kjøpers pantedokument elektronisk til megler i form av en SignedMortgageDeed melding, må banken benytte sitt eget organisasjonsnummer som Reportee for meldingen som sendes via Altinn. Dette er for at megler skal kunne vite hvilken bank som skal motta potensiell 'OppnaaddPrioritetOk' melding for det aktuelle pantedokumentet, siden det ikke finnes felter i selve pantedokumentet som er garantert å indikere dette.

## Validering og ruting

### Krav til filnavn i ZIP-arkiv
- Payload filen med 'OppnaaddPrioritetOk' melding må følge konvensjonen "oppnaaddprioritet_*.zip".

### Ruting (meglersystem)
Når megler har verifisert oppgjøret og har fastslått at avtalt prioritet er oppnådd indikerer megler dette i systemleverandørs system. Systemleverandøren sjekker om oppdraget inneholder ett eller flere pantedokument fra bank.

For hver av disse pantedokumentene må meglers systemleverandør utføre følgende:
1. Finn organisasjonsnummer for Altinn reportee som sendte SignedMortgageDeed melding til megler med det aktuelle pantedokumentet. Dette organisasjonsnummeret regnes for å være avsender bank som skal motta 'OppnaaddPrioritetOk' melding.
2. Sjekk om avsender bankens organisasjonsnummer er registrert i Akeldo med støtte for meldingstypen "OppnaaddPrioritetOk". Dersom ja, send 'OppnaaddPrioritetOk' melding til dette organisasjonsnummeret.

Merknad: flere pantedokumenter i samme e-tinglysing forsendelse fra samme bank, gitt at banken støtter meldingstypen i Akeldo, medfører 'OppnaaddPrioritetOk' meldinger til banken for hvert enkelt av disse pantedokumentene.

### Ruting (bank)
Dersom banken er registrert med meldingstypen 'OppnaaddPrioritetOK' i mottakslisten i Akeldo skal de kunne både motta og prossessere meldinger av denne typen. Det er også lagt opp til enveis kommunikasjon fra megler til bank, slik at bank ikke trenger å sende tilbake bekreftelse på mottak.
Banken må være oppmerksom på at 'OppnaaddPrioritetOk' sendes per pantedokumentet sendt i 'SignedMortgageDeed'. Banken må selv se om de har fått bekreftelse på samtlige dokumenter i saken.

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Ja|OppnaaddPrioritetOk|

### Payload
Et ZIP-arkiv med 1 fil:
- En 'OppnaaddPrioritetOk' XML med data ihht. [definert skjema.](../afpant-model/xsd/dsve.xsd)

#### Om payload
Følgende info er inkludert om pantedokumentet som ble sendt i SignedMortgageDeed melding fra bank til megler, og nå er tinglyst:

- SendersReference fra Altinn
- Dokumentreferanse

#### Krav/begrensninger
Meldingen GjennomfoertEtinglysing skal sendes når tinglysning gjennomført og er en forutsetting for senere forsendelse av 'OppnaaddPrioritetOk'-meldingen.
