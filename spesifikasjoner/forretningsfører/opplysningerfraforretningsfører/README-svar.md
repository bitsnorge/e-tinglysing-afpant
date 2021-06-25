# Opplysninger fra forretningsfører (meglerpakke)
## Introduksjon
Opplysninger fra forretningsfører som megler behøver for markedsføring, salg og korrekt oppgjør av eiendommen.
Meldingstypen må støtte forskjellige datagrunnlag avhengig av eierform (borettsandel, selveierseksjon, eiet, boligaksjeselskap).

## Referat fra arbeidsgruppe 

## Forutsetninger

## Krav  

## Flytskisse

## Meldingstype (under utarbeidelse)
### OpplysningerFraforretningsfoerer
#### Feltliste uavhengig av eierform
```diff
* informasjon (fritekst) om alternative kjøpsmodeller som har betydning for omsetningen 
  (bostart/deleie og liknende modeller)
```
#### Feltliste borettsandel
```diff
- * hvem avklarer forkjøpsrett (styret | forretningsfører)
- * er forretningsfører kontaktpunkt for styregodkjenninger ja/nei
+ * kjente fremtidige endringer (totalbeløp)
+ * borettslagets stiftelsesdato
+ * forsikringsselskap og polisenummer (felles byggforsikring)
! * er det IN (individuell nedbetaling)-ordning ja/nei
+ * er det garantiordning på felleskostnader (ja/nei, tekstlig beskrivelse)
+ * kr felleskostnader pr måned
+ * felleskostnadenes fordeling: avdrag fellesgjeld, renter fellesgjeld, evt kommunale avgifter, 
    husforsikring, trappevask, kabel-tv, vedlikehold, evt
+ * hvis ikke det betales avdrag på fellesgjeld: når starter nedbetaling, og hva blir avdragene
+ * andel fellesgjeld kr
+ * andel fellesgjeld pr dato
+ * andel fellesformue kr
! * lånevilkår for nedbetaling av fellesgjeld
+ * har andelseiere/boligbyggelagets medlemmer forkjøpsrett ja/nei
+ * gebyr for overdragelse av andel (eierskiftegebyr, forkjøpsrettgebyr eller liknende). 
    gebyrer må kunne oppgis som en liste av (dato gjelder fra, beløp) for å kunne oppgi fremtidige priser 
    (håndtere prisjustering ved årsstart).
+ * styreleder i borettslaget (navn)
+ * kontaktinfo til styreleder i borettslaget (email, mobil)
```
#### Feltliste selveierseksjon, eiet, aksje
```diff
- * hvem avklarer forkjøpsrett (styret | forretningsfører)
- * er forretningsfører kontaktpunkt for styregodkjenninger ja/nei
+ * kr fellesutgifter pr måned
+ * andel fellesgjeld kr
+ * andel fellesgjeld pr dato
+ * andel fellesformue i sameiet
- * har øvrige (seksjons|aksje)eiere forkjøpsrett ja/nei
+ * forsikringsselskap og polisenummer (felles byggforsikring)
+ * evt gebyr for overdragelse av seksjon
+ * evt styreleder i sameiet/boligaksjeselskapet (navn)
+ * kontaktinfo til evt styreleder (email, mobil)
```
#### Feltliste boligaksjeselskap
```diff
- * hvem besitter eventuelle originale adkomstdokumenter
```
## Implementasjonsdetaljer
