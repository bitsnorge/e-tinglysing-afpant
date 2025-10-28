# Løsning for elektroniske skjøtepakker

Prosessen ved elektronisk tinglysing av skjøtepakker, innebærer at kjøpers bank oversender elektronisk signert pantedokument samt forutsetningsbrev til eiendomsmegler/oppgjørsforetak, som deretter tinglyser elektronisk skjøtepakke (e-signert skjøte og pantedokument) hos Kartverket.

Det sendes kvittering fra mottakersystem til avsendersystem med informasjon om forsendelsene kunne rutes korrekt. Kvitteringen skal sendes automatisk fra mottakende system uten opphold enten i form av ACK eller NACK. For NACK benyttes kjente feilkoder der disse er identifisert.

Når kjøpers pantedokument er tinglyst hos Kartverket, sendes det en melding fra megler til bank for å informere om at pantedokument er tinglyst.

# Digital overføring av kjøpers pantedokument – forenklet forklaring

Når en bolig kjøpes og finansieres med lån, må banken sende et pantedokument til tinglysing. Dette skjer digitalt og involverer både banken og eiendomsmegleren. Her er hvordan prosessen fungerer:

---

## 📦 Hva sender banken?

Banken lager en digital forsendelse som inneholder:

- **Kjøpers pantedokument** (SDO-format)
- **Forutsetningsbrev** (valgfritt) – med informasjon om forutsetninger eller innbetaling

Alt pakkes i en ZIP-fil og sendes via Altinn til megler eller oppgjørsforetak.

---

## 🧭 Hvordan vet banken hvor det skal sendes?

- Banken henter **organisasjonsnummeret** til mottaker fra kjøpekontrakten.
- Dette kan være eiendomsmeglerforetaket eller oppgjørsforetaket.

---

## 🧠 Hva gjør meglersystemet?

- ZIP-filen pakkes ut.
- Systemet leser pantedokumentet og forsøker å **matche** det med riktig eiendom og kjøper i meglersystemet.
- Hvis alt stemmer, **rutes dokumentet til riktig sak**.
- Hvis noe ikke stemmer (f.eks. feil kjøper), sendes en feilmelding (NACK) tilbake til banken.

---

## ✅ Hva skjer etterpå?

- Megler bruker dokumentet i tinglysingen.
- Banken får en **kvittering** (ACK eller NACK) som viser om dokumentet ble korrekt behandlet.

---

## 🔐 Hvorfor er dette viktig?

- Sikrer at dokumentene havner hos riktig megler og sak
- Gjør prosessen raskere og tryggere
- Reduserer manuell håndtering og risiko for feil

---

> Denne digitale prosessen gjør det enklere og mer effektivt å håndtere pantedokumenter i eiendomshandler.


## Dokumentasjon
- [Oversendelse av pantedokument - teknisk beskrivelse](./afpant-kj%C3%B8perspantedokument.md)

### Dokumentasjon for tilhørende funksjonaliteter
- [Intensjonsmelding](./../afpant-intensjon/README.md)
- [Statusoppdatering fra megler til bank](./../afpant-gjennomfoertetinglysing/README.md)

##### Forutsetningsbrev (oversendelsesbrev) til megler tilhørende kjøpers pantedokument
- [Forutsetningsbrev - løsningsbeskrivelse](./afpant-forutsetningsbrev/forutsetningsbrev.md)
- [Forutsetningsbrev - teknisk beskrivelse](./afpant-forutsetningsbrev/afpant-forutsetningsbrev.md)
