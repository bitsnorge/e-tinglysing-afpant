## Banker med mer enn en leverandør

### Problemstilling

Det kan i visse tilfeller oppstå situasjoner hvor en bank har flere leverandører innenfor DSVE sammarbeidet.
For at dette skal fungere må det inngås visse kjøreregler for å unngå problemer.

#### Teknisk

Det finnes per i dag ingen muligheter i [AKELDO](https://akeldo.grunnbok.no/akeldo/aktoer) for å angi denne type fordeling.
Løsningen må derfor baseres på konkrete avtaler mellom Bank og bankens leverandører. Banken må gi rettigheter til begge leverandørene i Altinn.
Etter avtale med banken må leverandørene inngå en felles forståelse av hvilke meldinger som tilhører hvilken leverandør.
Når man henter informasjon om filer enten basert på webhooks fra Altinn eller via polling mot 'filetransfer' endepunktet
må leverandør benytte 'filtranser/{id} eller 'download' for å hente nok informasjon om filen for å verifisere att dette er en fil som tilhører dem.
Filer som ikke er av korrekt type skal ignoreres og ikke bekreftes.
Ved oppsett av webhooks kan en eller flere av partene abonnere, man skal gi 200 OK ved mottak av webhook kallet fra Altinn uavhengig om meldingen tilhører leverandøren eller ikke.
Hvis man ikke setter opp webhooks og bare benytter getAvailableFiles vil man risikere å bli påvirket av driftsforstyrrelser hos den andre leverandører.
Dette skyldes at getAvailableFiles maks gir 100 filer i svaret.
Dette betyr også at man som leverandør har ett ansvar for å hente ned og bekrefte sine filer innen rimelig tid.

### Begrensninger

En bank kan ha flere leverandører på løsningen totalt, men kan ikke ha flere leverandører på samme meldingstype
Det betyr at man for eksempel kan ha Ambita for [KjoepekontraktforespoerselFraBank](spesifikasjoner/afpant/afpant-kjoepekontrakt/kjoepekontrakt-teknisk-beskrivelse.md)
og en annen for [Restgjeldsforespoersel](spesifikasjoner/afpant/afpant-restgjeld/restgjeldsoppgave-og-innfrielsessaldo-loesningsbeskrivelse.md)
Det må benyttes samme leverandør for forespørsel og svar for meldings-parret.