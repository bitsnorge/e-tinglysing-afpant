# Bekreftelse på finansiering – funksjonell løsningsbeskrivelse

## Introduksjon

Dette dokumentet beskriver en løsning for meglere som ønsker å bekrefte at en budgiver kan finansiere et bud på bolig gjennom valgt bank.

## Generell beskrivelse

Informasjon fra bekreftelse på finansiering skal kunne overføres fra banken til megleren via AFPANT.

En megler kan be en bank bekrefte om en person har en bekreftelse på finansiering som dekker et bestemt beløp basert på følgende informasjon:

| Felt                                    | Beskrivelse                                  |
|-----------------------------------------|----------------------------------------------|
| Referanse                               | En unik ID som refererer til budrunden       |
| Personens fødselsnummer                 | 11 siffer                                    |
| Budbeløp                                | Inkludert alle omkostninger                  |
| Matrikkelinformasjon                    | Ved fast eiendom                             |
| Organisasjonsnummer og andelsnummer     | Ved borettslagsleilighet                     |
| Organisasjonsnummer og aksjenummer      | Ved aksjeleilighet                           |
| Matrikkelinformasjon                    | Ved eierseksjon                              |
| Fellesgjeld                             |                                              |
| Felleskostnader                         |                                              |
| Utleiemulighet                          |                                              |
| Salgsoppgave                            |                                              |
| Akseptfrist                             |                                              |
| Meglers kontaktinformasjon              |                                              |

Banken vil svare på forespørselen med strukturert data. Svarene kan ha én av følgende fire statuser:

| Status  | Beskrivelse |
|---------|-------------|
| **APPROVED** | Banken bekrefter at personen har en finansieringsbekreftelse som dekker budet på boligen. |
| **DISAPPROVED** | Banken kan ikke bekrefte at personen har en finansieringsbekreftelse som dekker budet på boligen. |
| **CUSTOMER_CONTACT** | Banken trenger mer informasjon for å kunne behandle forespørselen. Budgiveren blir bedt om å ta kontakt med banken. |
| **MANUAL** | Banken kan ikke håndtere forespørselen automatisk. Megleren blir bedt om å ta kontakt med banken for å bekrefte budets finansiering. |

Når budrunden avsluttes, sendes et signal til alle banker som tidligere har mottatt en finansieringsbekreftelsesforespørsel for den aktuelle budrunden.  
Hvis det godkjente budet **ikke** er bekreftet via banken, får banken kun en referanse til budrunden slik at den kan slette eventuelle lagrede data knyttet til den.  
Hvis det godkjente budet **er** bekreftet via banken, mottar banken også informasjon om det godkjente budet, kunden og boligen.