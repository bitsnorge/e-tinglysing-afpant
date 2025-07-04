# Digital samhandling ved eiendomshandel 
Digital samhandling mellom banker og eiendomsmeglere i forbindelse med gjennomføring av elektronisk eiendomshandel.


(Tidligere kalt AFPANT - Altinn Formidlingstjenester for kjøpers e-signerte pantedokument)

## Beskrivelse av prosjektet
Prosjektet er et samarbeid mellom Kartverket, Eiendom Norge, Finans Norge og Bits samt deres medlemmer, for å utarbeide bransjestandarder/spesifikasjoner for digital samhandling ved eiendomshandel.

Prosjektleder: Bjørn Søland (bjorn.soland@bits.no).

### Overordnede mål
Å etablere en heldigital samhandling mellom bank og meglerforetak. Dette inkluderer kommunikasjon og utveksling av informasjon,  oversendelse av ulike dokumenter, og elektronisk tinglysing av skjøtepakker.

Kommunikasjonen foregår via Altinn Formidlingstjenester etter samme modell som Kartverket selv benytter for e-tinglysing. Kartverket er tjenesteeier av denne formidlingstjenesten.



#### Forutsetninger
Det forutsettes en viss grad av erfaring med integrasjon mot Altinn Formidlingstjenester. Spesifikasjonene er utformet slik at de tilsvarer i stor grad Kartverket's egen bruk av Altinn Formidlingstjenester.
Kartverket har også en eksempelklient: https://github.com/kartverket/eksempelklient-etinglysing-altinn

### Nye aktører
Prosjektet er åpent for nye aktører som ønsker å delta. For å kunne ta i bruk løsningen er det noen hovedpunkter som må på plass
- Ta kontakt med [prosjektleder](#beskrivelse-av-prosjektet) for en introduksjon og gjennomgang.
- Kontakt Kartverket, som er tjenesteeier for å avtale tilgang til **testmiljøet** for Altinn og AKELDO(Aktørregister for elektronisk dokumentutveksling) Se [Bestill tilganger](./tilgang.md)
- Via prosjektleder etabler kontakt med eksisterende aktører for å avtale deltagelse i prosjektet og test. Prosjektleder styrer også tilgang til github-repoet. 
- Alle meldingstyper som meldes inn i AKELDO må testes mot eksisterende aktører før de kan tas i bruk i produksjon.
- Legg merke til at man ikke bare kan plukke ut de meldingstyper som gavner sitt system, det forventes at man er solidarisk med alle parter i samarbeidet.
- Når meldingene er testet og godkjent vil prosjektleder gi beskjed til Kartverket om at ny aktør er klart for produksjon med gitte meldingstyper.
- Kartverket vil da kunne gi tilgang til produksjonsmiljøet for Altinn og AKELDO. Vær klar over at Kartverket kan ha egne krav til tester av integrasjon før tilgang gis. Dette er uavhengig av prosjektet.
- Alle nye aktører skal lage en oppsummering av erfaringer og utfordringer som de har hatt underveis i prosjektet. Dette skal deles med prosjektet via en PR til dette repoet.
- Alle nye aktører forventes å delte aktivt i prosjektet og bidra til videreutvikling av løsningen.
- Når ny aktør er i produksjon kan nye meldingstyper meldes til Kartverket for innmelding i AKELDO. Det forutsettes fortsatt at det er testet.


## Kom i gang med det tekniske

- [Bestill tilganger](./tilgang.md)
- [AKELDO](./akeldo.md)
- For å få release til å fungere må det lages en merge commit


## Funksjonalitet

Prosjektet skal levere en rekke funksjonaliteter ifm. elektronisk eiendomshandel.

Se oversikt over:
- [Funksjonalitetene](./funksjonalitet.md)
- [Hvem som bruker løsningen](./hvem-bruker-loesningen.md)




