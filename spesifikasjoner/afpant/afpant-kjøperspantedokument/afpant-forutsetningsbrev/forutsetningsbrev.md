# Forutsetningsbrev - Løsningsbeskrivelse

## Innledning
Dette dokumentet beskriver bruk og oppsett av forutsetningsbrev som sendes sammen med
pantedokumentet fra bank til megler. Forutsetningsbrev har også blitt kalt oversendelsesbrev og
følgebrev tidligere, men omforent benevnelse er forutsetningsbrev.


## Overordnet beskrivelse
Forutsetningsbrev skal kunne sendes sammen med pantedokumentet fra bank til megler. Dette er
ikke en egen meldingstype, men et vedlegg til pantedokumentet. Forutsetningsbrevet skal sendes
som strukturert data og gi megler oversikt over bankens krav før de kan arkivere saken. Det gir blant
annet informasjon om når megleren kan forvente å få overført penger fra banken og hvilken
prioritet banken forventer.

Tidligere har ordlyden i forutsetningsbrevet sagt at man har overført penger. Dette er endret til
heller å si at man vil overføre penger iht. forutsetningene i brevet. Dette medfører at bank kan legge
om sine rutiner til å sende pantedokumentet på et mye tidligere tidspunkt enn dagens prosess, som
medfører at megler kan få en bedre forutsigbarhet i tinglysing av skjøtepakken.


## Informasjonsflyt
Banken oversender forutsetningsbrevet og får en status tilbake om at megler har mottatt
pantedokumentet (og dermed også forutsetningsbrevet). Det vil ikke legges til rette for at megler
skal sende en tilbakemelding om at forutsetningene er godtatt. Dette vil dekkes av senere
meldingstyper som bekrefter at rett prioritet er oppnådd.

Feltene i tabellen under oversendes som strukturerte datafelter, og selve forutsetningsteksten under
tabellen igjen, oversendes som en standardtekst uten mulighet for redigering.

<table bgcolor="ffffff">
  <tr>
    <th>Datafelt</th>
    <th>Beskrivelse</th>
  </tr>
  <tr>
    <td><strong>Mottaker<strong></td>
    <td>Oppgjørsforetak/Firmanavn / Org.nummer</td>
  </tr>
  <tr>
    <td><strong>Registerenhet<strong></td>
    <td></td>
  </tr>
  <tr>
    <td><strong>Rettighetshavere<strong></td>
    <td>Navn og fødselsnummer</td>
  </tr>
  <tr>
    <td><strong>Pantedokument<strong></td>
    <td>Pantebeløp</td>
  </tr>
  <tr>
    <td><strong>Prioritet<strong></td>
    <td>Forventet prioritet. Eventuelt informasjon om hvilke vikelser man godtar dersom det er aktuelt (prioritet, pantehaver, beløp og beskrivelse)
    </td>
  </tr>
  <tr>
    <td><strong>Beløp<strong></td>
    <td>Kjøpesum og omkostninger</td>
  </tr>
  <tr>
    <td><strong>Overføringsdato<strong></td>
    <td>Dato for overføring</td>
  </tr>
  <tr>
    <td><strong>Til konto<strong></td>
    <td>Kontonummer</td>
  </tr>
  <tr>
    <td><strong>KID<strong></td>
    <td></td>
  </tr>
  <tr>
    <td><strong>Oppdragsnummer megler<strong></td>
    <td></td>
  </tr>
  <tr>
    <td><strong>Saksnummer kreditor<strong></td>
    <td></td>
  </tr>
</table>

### Forutsetninger

I Det påfølgende henviser uthevet tekst til ovenstående tabell.

Det forutsettes at beløpet ikke stilles til selgers disposisjon før hjemmel til eiendommen blir
overskjøtet til **rettighetshavere** eller annen tilfredsstillende sikkerhet (f.eks sikringsdokument) er
tinglyst, og at elektronisk **pantedokument** er tinglyst i ovennevnte **registerenhet** med angitt
**prioritet**, foran avtalepant, utleggspant og andre heftelser som begrenser omsetning av
eiendommen, herunder boretter og forkjøpsretter. Vi aksepterer likevel at andre typer heftelser som
kjøper har akseptert å overta, kan forbli tinglyst på eiendommen med prioritet foran bankens pant.

Det forutsettes videre at vi mottar bekreftelse så snart rett prioritet foreligger.

Dersom vi ikke har mottatt overnevnte bekreftelse innen 4 måneder, ber vi om at det meddeles når
vi kan forvente at rett prioritet vil foreligge.

### Avsender

Nordea Bank AB (publ), filial i Norge (Org.nr 983258344)  
Bjarne Bankrådgiver  
Bjarne.bank@nordea-afpant.com  
80000000 (direkte)  
23206001 (telefon)


## Alternative flyter

### Megler kan ikke stå inne for forutsetningene
Det er ikke støtte for å returnere/avslå et forutsetningsbrev. Avslag håndteres i henhold til allerede
eksisterende rutine.

### Endringer i forutsetningsbrevet
For å gjøre endringer i forutsetningsbrevet må bank sende et nytt pantedokument med tilhørende
forutsetningsbrev via løsningen. Det er ikke mulig å trekke tilbake det gamle pantedokumentet og
forutsetningsbrevet. Hvordan det gamle pantedokumentet og forutsetningsbrevet håndteres blir
opp til hvert enkelt fagsystem frem til det eventuelt legges til rette for å trekke dokumentene
tilbake.

### Bank kan ikke sende forutsetningsbrevet som strukturerte data
Dersom bank mot formodning ikke kan sende forutsetningene som strukturerte data, må brevet
skrives ut og sendes per post (eventuelt per e-post). Det vil være angitt i oversendingen at man kan
forvente et forutsetningsbrev på annet format, i annen kanal.

# Endring i spesifikasjonen 2026-04-27
På teknisk møte i DSVE 27. april 2026 ble partene enige om at vi skulle legge til et nytt, frivillig felt i 
overføringsdetaljene for å kunne angi en betalingsmelding når det brukes istedenfor KID. Skal ikke være et krav at dette feltet må fylles
ut, men man skal ikke fylle ut både KID og betalingsmelding.