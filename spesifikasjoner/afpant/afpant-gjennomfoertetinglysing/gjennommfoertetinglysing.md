# Melding om tinglyst kjøpers pantedokument (GjennomfoertEtinglysing)
GjennomfoertEtinglysing er en meldingstype som sendes fra megler til bank for å informere om at et kjøpers pantedokument, som bank tidligere har sendt til megler elektronisk, er tinglyst hos Kartverket.

## Implementasjonskrav
Banker som ønsker å motta meldingen må være registrert som aktiv i Akeldo registeret med støtte for meldingstypen GjennomfoertEtinglysing.

Når bank sender kjøpers pantedokument elektronisk til megler i form av en SignedMortgageDeed melding, må banken benytte sitt eget organisasjonsnummer som Reportee for meldingen som sendes via Altinn. Dette er for at megler skal kunne vite hvilken bank som skal motta potensiell GjennomfoertEtinglysing melding for det aktuelle pantedokumentet, siden det ikke finnes felter i selve pantedokumentet som er garantert å indikere dette.

## Validering og ruting

### Krav til filnavn i ZIP-arkiv
- Payload filen med GjennomfoertEtinglysing melding må følge konvensjonen "gjennomfoertetinglysing_*.zip".
- Vedlegget med forsendelsesstatus fra Kartverket må følge konvensjonen "forsendelsesstatus_*.xml".

### Ruting (meglersystem)
Når meglers systemleverandør mottar forsendelsesstatus fra Kartverket som tilsier at en forsendelse er vellykket e-tingyst, må systemleverandøren sjekke om forsendelsen inneholder ett eller flere kjøpers pantedokument fra bank.

For hver av disse pantedokumentene må meglers systemleverandør utføre følgende:
1. Finn organisasjonsnummer for Altinn reportee som sendte SignedMortgageDeed melding til megler med det aktuelle pantedokumentet. Dette organisasjonsnummeret regnes for å være avsender bank som skal motta GjennomfoertEtinglysing melding.
2. Sjekk om avsender bankens organisasjonsnummer er registrert i Akeldo med støtte i mottaksliste for meldingstypen "GjennomfoertEtinglysing". Dersom ja, send GjennomfoertEtinglysing melding til dette organisasjonsnummeret.

Merknad: flere pantedokumenter i samme e-tinglysing forsendelse fra samme bank, gitt at banken støtter meldingstypen i Akeldo, medfører GjennomfoertEtinglysing meldinger til banken for hvert enkelt av disse pantedokumentene.

### Ruting (bank)
Så lenge banken har registrert seg på Akeldo med støtte for meldingstypen GjennomfoertEtinglysing skal de kunne motta og prossessere disse meldingene. Det er også lagt opp til enveis kommunikasjon fra megler til bank, slik at bank ikke trenger å sende tilbake bekreftelse på mottak.
Banken bør også være oppmerksom på at pantedokumentet kan være tinglyst i en forsendelse til Kartverket sammen med andre dokumenter (f.eks hjemmelsovergang og pantedokumenter fra andre banker), og vedlegget med forsendelsesstatus fra Kartverket vil da gjenspeile dette.

## Meldingstype: GjennomfoertEtinglysing

Meldingstypen GjennomfoertEtinglysing sendes fra megler til bank for å informere om at kjøpers pantedokument fra bank til megler er tinglyst hos Kartverket.

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Ja|GjennomfoertEtinglysing|

### Payload
Et ZIP-arkiv med 2 filer:
- En GjennomfoertEtinglysing XML med data ihht. [definert skjema.](../afpant-model/xsd/dsve.xsd)
- Et vedlegg med forsendelsesstatus xml data fra Kartverket til megler for forsendelsen 
som inkluderte det aktuelle kjøpers pantedokumentet.

#### Om payload
Følgende info er inkludert om pantedokumentet som ble sendt i SignedMortgageDeed melding fra bank til megler, og nå er tinglyst:

- SendersReference fra Altinn
- Dokumentreferanse (pantedokumenet skal være tinglyst med samme dokumentreferanse som det hadde i SignedMortgageDeed meldingen)

I tillegg blir forsendelsesstatus for selve forsendelsen fra Kartverket til megler inkludert
som et vedlegg. Denne inkluderer enten signert grunboksutskrift eller link til signert grunnboksutskrift, avhengig av hva Kartverket har inkludert her.

#### Krav/begrensninger
I GjennomfoertEtinglysing meldingen må metadata.ressurser elementet registeres med "application/xml" i feltet "mimetype".
Feltet "navn" må tilsvare navnet på vedlegget (som følger konvensjonen "forsendelsesstatus_*.xml").
