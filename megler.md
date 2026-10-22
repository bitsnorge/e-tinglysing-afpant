## Meglere med mer enn en leverandør

### Problemstilling

I DSVE forholder ikke bankene seg til systemleverandører på meglersiden. Alle DSVE meldinger som går fra banken via Altinn Formidlingstjeneste sendes til meglerfirmaet's orgnr som mottaker og leses/håndteres av meglerfirmaet's systemleverandør på vegne av meglerfirmaet. Dvs systemleverandør sjekker periodisk på Altinn Formidlingstjeneste om det er nye meldinger til meglerfirmaets orgnr siden sist, og dersom dette er tilfelle blir disse meldingene plukket opp, håndtert i fagsystemet, og bekreftet nedlastet hos Altinn slik at meldingen forsvinner fra meglerfirmaets tilgjengelige filer.

Problemene oppstår når 
1) et meglerfirma er i en overgangsfase mellom to forskjellige fagsystemer (med forskjellig systemleverandør i hver av dem) og gjerne har saker/oppdrag i det gamle fagsystemet som de ikke er ferdig å jobbe med, eller 
2) dersom enkelte kontor i et meglerfirma ønsker å benytte et annet fagsystem (med annen systemleverandør) enn resten av kontorene i meglerfirmaet.

I disse tilfellene er det ikke støtte for at flere fagsystemleverandører kan plukke opp meldinger som går til samme meglerfirma/mottaker. Når en melding er lest/håndtert/bekreftet vil den forsvinne fra meglerfirmaets tilgjengelige filer hos Altinn. Og det er ikke sikkert at riktig fagsystemleverandør plukker den opp først. I tilfellene der det er feil leverandør som plukker filen vil de avvise meldingen fra banken siden det ikke er noe match på eiendom/kjøpere/etc i deres fagsystem (for meglers sak/oppdrag ligger i fagsystemet hos en annen leverandør for samme meglerfirma).

#### Teknisk

Det foreligger per idag ingen plan på hvordan vi skal løse det teknisk via Altinn Formidlingstjeneste når samme meldingstype må mottas fra flere leverandører på vegne av samme megler.

Forøvrig skal det teknisk sett være mulig å fordele ulike meldingstyper på tvers av leverandører for samme megler, men dette vil kreve tilsvarende felles kjøreregler som dette scenarioet på banksiden. 
