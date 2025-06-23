Innfrielsessaldo
================

>Digital samhandling ved eiendomshandel
> 
><bjorn.soland@bits.no>

# Innledning

I Norge er eiendomsmeglingsvirksomhet strengt regulert for å beskytte forbrukerne i deres viktigste økonomiske investering. Eiendomsmegleren har plikt til å handle i tråd med god meglerskikk, og ivareta både selgers og kjøpers interesser.

Dette innebærer blant annet at meglere innhenter skriftlig bekreftelse på restgjeld fra panthavere i forkant, og hvor de bekrefter at pant blir slettet ved innfrielse av nevnte lån. Det er heller ikke anledning til å låne opp på eksisterende pant uten samtykke når megleren har etablert sikring og panthavere har avgitt restgjeldsoppgave.

Ved oppgjørsdato, som regel ved overtakelse, er det meglers oppgave å foreta oppgjøret. Megler innhenter da innfrielsessaldoen, et dokument som gir en nøyaktig oversikt over det totale beløpet som gjenstår å betale på lånet. Saldoen inkluderer påløpte og fremtidige renter på gitte oppgjørsdatoer, samt eventuelle gebyrer.

Spesifikasjonen inkluderer også bankbytte. Bankbytte er et forhold mellom låntaker og de involverte bankene og involverer ikke megler.

Denne funksjonelle spesifikasjonen beskriver både Restgjeldsoppgave og Innfrielsessaldo. Tekniske spesifikasjoner utarbeides på bakgrunn av kravene i denne spesifikasjonen


# Avgrensninger

I dette kapittelet avgrenser vi oppgaven – hva løser vi ikke:
- Oppgaver som har egne aktiviteter i DSVE og som derfor ikke er en del av denne spesifikasjonen:
  - Pantefrafall (sletting av pant uten full innfrielse av lån)
  -	Oppfordring om sletting (purring)
  -	Bekreftelse på sletting av pant
- Generalfullmakter og blankoskjøter
     
Disse må inntil videre håndteres som i dag.

Det skal i utgangspunktet være mulig å svare på all type saker utover dette, men det vil være ulik grad av automatisering i de forskjellige banksystemene. Man må regne med at noe som det går raskt å få svar om fra én aktør kan være komplisert og må besvares via e-post av en annen.

# Beskrivelse av Restgjeld- og saldoforespørsel

## Overordnet flyt 

Flyten for innhenting av restgjeldsoppgave og innfrielsesoppgave er
identisk, men innholdet i meldingene er forskjellig.

![](./figurer/flyt.drawio.svg)

## Restgjeldsoppgave

Innhenting av restgjeldsoppgave på hjemmelshavers eiendom. Meglere etterspør informasjon om restgjeld etter oppdragsinngåelse for å avdekke om eiendommen er overbeheftet og om man må gjøre tiltak som å be om pantefrafall fra en eller flere kreditorer. Når restgjeld etterspørres er eiendommen ennå ikke solgt, og megler vet foreløpig ikke overtakelsesdato. Man er her ikke ute etter helt nøyaktig rentebærende saldo. Banker kan også be om restgjeldsoppgave f.eks i forbindelse med bankbytte/ny lånesak.

## Innfrielsessaldo

Etter at eiendommen er solgt, og oppgjørsavdelingen forbereder oppgjøret, etterspørres innfrielsessaldo fra kreditorene. Dette gjøres tett på eller etter overtakelse. Svar på denne haster derfor mer enn for restgjeld. Megler ber om saldoen på konkrete datoer og får tilbake saldo inkludert renter for disse datoene. Det er på dette tidspunktet viktig at megler mottar alle betalingsopplysninger for å kunne gjennomføre oppgjøret, herunder sikre at midlene kommer frem til riktig person. Denne meldingen kan banker også benytte når kunden har fått innvilget lån i en annen bank og den nye banken skal gjøre opp restgjelden i ny bank.

## Forutsetninger
Meldingsflyten og meldingsinnhold er definert under forutsetningen om at det er meglers ansvar å innhente restgjeldsinformasjon før salg og sørge for oppgjøret etterpå. Videre forutsettes det at det svaret banken gir på meglers spørsmål om innfrielsessaldo inneholder alt banken krever for å kunne slette sine pant.  
Forespørsel om restgjeld og innfrielse må sendes til bank, ikke boligkredittforetak.
Det er ikke avtalt noen normert svartid på disse meldingene, men brukerne av løsningen skal etterstrebe og svare så raskt som mulig. Det vil være tilfeller der bank kan ha behov for å gjøre ekstra undersøkelser før svar foreligger.


# Informasjonselementer i de ulike meldingene

| Informasjonselement                                                                                                                                                                                    | Format                                 | Restgjelds-oppg. spm. | Restgjelds-oppg. svar | Innfrielse spm. | Innfrielsessvar |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------|-----------------------|-----------------------|-----------------|-----------------|
| Mottakers referanse                                                                                                                                                                                    | DSVE-standard                          | | X*                    | X | X*              |
| Avsenders referanse                                                                                                                                                                                    | DSVE-standard                          | X* | X*                    | X* | X*              |
| Eiendomsinformasjon (liste over eiendommer):<ul><li>Fast eiendom/seksjon: Matrikkelinformasjon</li><li>Brl. leil: Org. nr og andelsnummer</li> <li>Aksjeleilighet: org.nummer og aksjenummer</li></ul> | DSVE-standard                          | X*                    | X*                    | X*              | X*              |
| Prisanslag (<u>anslag</u> - ikke bindende)                                                                                                                                                             |                                        | X                     |                       |                 |                 |
| Hjemmelshavere                                                                                                                                                                                         | DSVE-standard                          | X*                    |                       | X*              |                 |
| Liste over dagbok-/dokumentnummer                                                                                                                                                                      |                                        |                     | X*                    |               | X*              |
| Avsenders kontaktinformasjon                                                                                                                                                                           | DSVE-standard                          | X*                    | X*                    | X*              | X*              |
| Betalingsinformasjon<ul><li>Lånenummer</li> <li>Kontonummer for innfrielse</li> <li>KID/melding (valgfrie)</li></ul>                                                                                   | Numerisk                               |                       | X*                    |                 | X*              |
| Faktisk restgjeld                                                                                                                                                                                      | Numerisk                               |                       | X*                    |                 |                 |
| Fastrente                                                                                                                                                                                              | Ja/nei                                 |                       | X*                    |                 |                |
| Realkausjon                                                                                                                                                                                            | Ja/nei<br/>                            |                       | X*                    |                 |                |
| Er transporterklæring/mellomfinansiering                                                                                                                                                               | Ja/nei<br/>                            |                       | X*                    |                 | X*              |
| Finnes låntakere som ikke er hjemmelshaver                                                                                                                                                             | Ja/nei<br/>                            |                       | X*                    |                 | X*              |
| Liste over navn på låntakere som er hjemmelshaver                                                                                                                                                      | Kun navn                               |                       | X*                    |                 | X*              |
| Rammelån<ul><il>eventuelt størrelse på rammelånet</il></ul>                                                                                                                                            | Ja/nei<br/>eventuelt størrelse på ramme |                       | X*                    |                 |                 |
| Bekreftelse på at panterett sperres for opplåning                                                                                                                                                      | Ja/nei                                 |                       | X*                    |                 |                 |
| Bekreftelse på at panterett slettes ved innfrielse                                                                                                                                                     | Ja/nei                                 |                       | X*                    |                 | X*              |
| Antatt innfrielsesdatoer (en eller flere)                                                                                                                                                              |                                        |                       |                       | X*              |                 |
| Innfrielsesbeløp. Primært på forespurte datoer, men bank kan velge andre (eller færre) datoer.                                                                                                         |                                        |                       |                       |                 | X*              |

Felter merket med `*` er påkrevde felter.

# Deling av status og feilhåndtering

Ulike scenarioer i løsningen der det ikke kan svares rett ut med beløp og betalingsinformasjon:
-   Lån nedbetalt, pant ikke slettet enda.
-	Feil panthaver. Panthaver har ikke pant i nevnte eiendom(er)
-	Pant solgt/overført til andre.
-	Svarer i (ekstern) e-post.
-	UkjentPantsetter: Feil med ID el.
-	Generelle feil. Kan være av teknisk art eller annet som vi på nåværende tidspunkt ikke klarer å forutse.

Forslag til svarkoder:
-	LAAN_NEDBETALT
-	SVARER_I_EPOST
-	LAAN_SOLGT
-	FEIL

Uansett hva feilkoden er, vil det også sendes med en tekst som beskriver hva som er feil.


# Juridisk grunnlag/personvern

Denne spesifikasjonen er laget for å erstatte informasjonsutveksling som i dag foregår på papir, epost etc. Arbeidsgruppen anser derfor at det denne spesifikasjonen i prinsippet er en strukturering av informasjon.
Overføring av fullt fødselsnummer fra meglersystemene til bank begrunnes med at det er behov for sikker identifikasjon av hjemmelshaver for å finne rett person/pant/lån i bankens systemer og i offentlige registre. Oppslag på navn alene vil gi stor risiko for feil pga. at dette ikke entydig identifiserer den aktuelle personen (mange kan bære samme navn). Videre er opplysningene nødvendige for at banken skal kunne vurdere om banken kan gi pantefrafall. Bruk av fullt fødselsnummer for dette formålet er saklig, all den tid dette bidrar til mer effektiv gjennomføring av salgsprosess og overdragelsesprosess, med mindre risiko for feil.
Av hensyn til GDPR skal ikke kontohavers navn deles dersom hen ikke er en del av salget. Her vil megler kun få informasjon om at det foreligger lån på andre enn de som er involvert i salget, og må ta kontakt med selger eller banken for å få ytterligere informasjon.
Dersom den juridiske vurderingen ender med at dagens myndighetskrav er tilstrekkelig overførings- og behandlings-grunnlag, er det ikke nødvendig med et samtykke fra kunden.
I tråd med prinsippet om «åpenhet», jf. GDPR art. 5 nr. 1 a., jf. art. 13 skal imidlertid megler opplyse selger om at megler må kontakte banken for å be om opplysninger. Typisk gjøres dette gjennom informasjon i salgsoppgaven, i det elektroniske budgivningssystemet eller i en oppdragsavtale.

