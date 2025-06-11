Finansieringsbekreftelse - funksjonell løsningsbeskrivelse
====================================================

# Introduksjon

Detta dokument beskriver en lösning för mäklare att bekräfta att en budgivare kan finansiera ett bud på bostad via vald bank.

## Generell beskrivelse

Informasjon fra Finansieringsbekreftelseet skal kunne overføres fra banken til megleren, via AFPANT.

En megler kan be en bank om en person har et finansieringsbekreftelse som dekker et visst beløp basert på:

| Felt                                    | Beskrivelse                                  |
|-----------------------------------------|----------------------------------------------|
| Referanse                               | Et unikt id som refererer til budgivningen   |
| Personens fødselsnummer                 | 11 siffer                                    |
| Budbeløp                                | inkl alle omkostninger                       |
| Matrikkelinformasjon                    | Vid Fast eiendom                             |
| Org nummer og andelsnummer              | Vid Brl. leil                                |
| Org nummer og aksjenummer               | Vid Aksjeleil                                |
| Matrikkelinformasjon                    | Vid Eierseksjon                              |
| Fellesgjeld                             |                                              |
| Felleskostnader                         |                                              |
| Utleiemulighet                          |                                              |
| Salgsoppgave                            |                                              |
| Akseptfrist                             |                                              |
| Meglers kontaktinformasjon              |                                              |

Banken vil svare på forespørselen med strukturert data hvor svarene kan inneholde tre ulike svartyper:

| Status  | Beskrivelse |
|---------|-------------|
| APPROVED | Banken bekrefter at personen har et finansieringsbekreftelse som dekker budet for boligen. |
| DISAPPROVED | Banken kan ikke bekrefte at personen har et finansieringsbekreftelse som dekker budet for boligen. |
| OTHER | Banken trenger mer informasjon for å kunne håndtere saken. Budgiveren skal bli henvist til å ta kontakt med banken. |

Ved avsluttet budgivning sendes et signal til alle banker som tidligere har mottatt finansieringsbekreftelseforespørsel for den avsluttede budgivningen.
Hvis det godkjente budet ikke er bekreftet via banken, får banken kun en referanse til budgivningen slik at de har mulighet til å rydde eventuelle data de har lagret for denne budgivningen.
Hvis det godkjente budet er bekreftet via banken, får banken også informasjon om det godkjente budet, kunden og boligen.