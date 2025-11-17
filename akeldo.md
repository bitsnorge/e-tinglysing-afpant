# Aktørregister for elektronisk dokumentutveksling (AKELDO - Kartverket)
Et aktørregister er utarbeidet av Kartverket ([REST API er tilgjengelig her](https://akeldo.grunnbok.no/akeldo/aktoer)).

Aktørregisteret har oversikt over hvilke organisasjonsnumre (banker og eiendomsmeglere) som er mulig å samhandle med, inkludert:
- Organisasjonens rolle (bank eller megler)
- Hvilke meldingstyper hver organisasjon kan sende
- Hvilke meldingstyper hver organisasjon har implementert støtte for å motta

Innmelding av organisasjoner og støttede meldingstyper gjøres via Kartverket Applikasjonsdrift.

For å hente ut informasjon om kun én aktør kan man gå til `https://akeldo.grunnbok.no/akeldo/aktoer/:organisasjonsnummer`.

## AKELDO test
[REST API i test er tilgjengelig her](https://akeldotest.grunnbok.no/akeldo/aktoer).
