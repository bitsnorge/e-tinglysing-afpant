# Digital samhandling ved eiendomshandel 
Digital samhandling mellom banker og eiendomsmeglere i forbindelse med gjennomføring av elektronisk eiendomshandel.


(Tidligere kalt AFPANT - Altinn Formidlingstjenester for kjøpers e-signerte pantedokument)

## Beskrivelse av prosjektet
Prosjektet er et samarbeid mellom Eiendom Norge, Finans Norge og Bits, samt deres medlemmer for å utarbeide bransjestandarder/spesifikasjoner for digital samhandling ved eiendomshandel.

Prosjektleder: Monique Lier Nes (monique.nes@bits.no).

### Overordnede mål
Muliggjøre en sikker og effektiv utveklsing av standardiserte og strukturerte data mellom bank-fagsystem og megler-fagsystem som er nødvendige for å gjennomføre elektronisk tinglysing.

Kartverket er tjenesteeier av denne formidlingstjenesten.

Kommunikasjonen foregår via Altinn Formidlingstjenester etter samme modell som Kartverket selv benytter for e-tinglysing.


#### Forutsetninger
Det forutsettes en viss grad av erfaring med integrasjon mot Altinn Formidlingstjenester. Spesifikasjonene er utformet slik at de tilsvarer i stor grad Kartverket's egen bruk av Altinn Formidlingstjenester.
Kartverket har også en eksempelklient: https://github.com/kartverket/eksempelklient-etinglysing-altinn

## Altinn Formidlingstjeneste - servicedetaljer
<table>
	<tbody>
		<tr>
			<td><p><strong>Navn</strong></p></td>
			<td><p><strong>ServiceCode</strong></p></td>
			<td><p><strong>ServiceEditionCode</strong></p></td>
		</tr>
		<tr>
			<td><p>AFPANT (Altinn Test TT02)</p></td>
			<td><p>4752</p></td>
			<td><p>1</p></td>
		</tr>
		<tr>
			<td><p>AFPANT (Altinn Prod)</p></td>
			<td><p>4752</p></td>
			<td><p>1</p></td>
		</tr>
	</tbody>
</table>
*NB:* ServiceCode for tjenesten er lik i Test og Prod.

## Altinn-tilgang for systemleverandører/datasentraler
Kartverket må gi rettigheter (READ+WRITE) i tjenesteeierstyrt rettighetsregister for alle systemleverandører/datasentraler som skal koble seg direkte til denne tjenesten.
Bestillinger av denne tilgangen må gjøres via Kartverket JIRA (https://jira.statkart.no/).

## Altinn-tilgang for eiendomsmeglerforetak/banker
Kartverket må gi rettigheter (READ+WRITE) i tjenesteeierstyrt rettighetsregister for alle bank- og eiendomsmeglerforetak som skal sende- og motta forsendelser fra denne tjenesten, selv om forsendelsene skal hentes/administreres av tredjepart (systemleverandør/datasentral).
Bestillinger av denne tilgangen må gjøres via tredjepartsleverandør eller direkte til Kartverket.

## Delegering av roller fra egne kunder til systemleverandør/datasentral
Systemleverandører/datasentraler som skal utføre sending/mottak på vegne av *andre organisasjoner* (eks meglerforetak/bank) må registrere seg selv hos Kartverket (ref ovenstående punkt).
Ved henting av forsendelser på vegne av egne kunder skal systemleverandør/datasentral bruke organisasjonsnummeret tilhørende kunden som "reportee" mot Altinn.
Systemleverandører/datasentraler må også hente meldinger for sitt *eget organisasjonsnummer* (for det er dit ACK/NACK meldinger fra mottakersystem sendes). 

*Hver organisasjon/kunde* som en systemleverandør/datasentral opererer på vegne av (eks meglerforetak/bank) må logge på Altinn for å delegere rettigheter til sin gjeldende systemleverandør/datasentral sitt organisasjonsnummer for tjenesten *4752* (AFPANT).
Oppskrift for å delegere rollen 'Utfyller/Innsender' eller enkeltrettighet til systemleverandør/datasentral sitt organisasjonsnummer finnes her: https://www.altinn.no/no/Portalhjelp/Administrere-rettigheter-og-prosessteg/Gi-roller-og-rettigheter/

*NB:* Delegering av denne rettigheten må utføres _etter_ at Kartverket har gitt tilgang til både systemleverandør/datasentral og kunden (meglerforetak/bank).

#### Hvem bruker løsningen?
Bransjestandardene kan benyttes av alle aktører (bank / eiendomsmegler) som skal samhandle om e-tinglysing. 

Leverandør | På vegne av
---------- | -----------
Ambita AS | Bank/Megler
Vitec Megler AS | Megler
Websystemer AS | Megler
Nordea | Bank
Evry | Bank


# Aktørregister for elektronisk dokumentutveksling (AKELDO - Kartverket)
Et aktørregister er utarbeidet av Kartverket ([REST API er tilgjengelig her](https://www.grunnbok.no/akeldo/aktoer)). Aktørregisteret har oversikt over hvilke organisasjonsnumre (banker og eiendomsmeglere) som er mulig å samhandle med, samt hvilke meldingstyper hver organisasjon har implementert støtte for å motta. 
Innmelding av organisasjoner og støttede meldingstyper gjøres via Kartverket Applikasjonsdrift.

# Meldingstyper / dokumentpakker i standarden
 
#### Dokumentpakke 1 - Elektronisk tinglysing
##### Kjøpers pantedokument og evt følgebrev
* Overføring av e-signert pantedokument (SDO) fra kjøpers bank til eiendomsmegler/oppgjørsforetak 
* Overføring av følgebrev som PDF eller XML 
* ACK/NACK-kvittering fra mottakersystem til avsendersystem med informasjon om forsendelsen kunne rutes korrekt
* [Oversikt og spesifikasjoner](spesifikasjoner/afpant/afpant-kjøperspantedokument/readme.md)

##### Intensjonsmelding
* Utveksling av intensjon om tinglysingmetode mellom bank og megler (elektronisk eller papir).
* [Oversikt og spesifikasjoner](spesifikasjoner/afpant/afpant-intensjon/afpant-intensjon.md)


##### Statusoppdatering etter e-tinglysing
* Statusoppdatering fra megler til kjøpers bank etter gjennomført e-tinglysing for overføring av tinglysingsdetaljer (dokumentnummer)
* [Spesifikasjon er under utarbeidelse](https://github.com/bitsnorge/e-tinglysing-afpant/issues/3)

<hr>

#### Dokumentpakke 2 -  Digital datautveksling bank/megler (under utarbeidelse)
##### Kjøpekontrakt 
* Overføring av / forespørsel om signert kjøpekontrakt (PDF/PadES/SDO) mellom megler/bank.
* [Spesifikasjon](https://github.com/bitsnorge/e-tinglysing-afpant/blob/master/spesifikasjoner/afpant/afpant-kj%C3%B8pekontrakt/afpant-kj%C3%B8pekontrakt.md)
##### Pantefrafall
* Forespørsel om pantefrafall fra megler til bank
* [Spesifikasjon](https://github.com/bitsnorge/e-tinglysing-afpant/blob/master/spesifikasjoner/afpant/afpant-pantefrafall/afpant-pantefrafall.md)
##### Saldoforespørsel
* Forespørsel om lånesituasjon på en registerenhet / tinglyste pant fra megler til bank eller bank til bank
* [Spesifikasjon](https://github.com/bitsnorge/e-tinglysing-afpant/blob/master/spesifikasjoner/afpant/afpant-saldoforesp%C3%B8rsel/afpant-saldoforesp%C3%B8rsel.md)
##### Restgjeldsoppgave
* Forespørsel om saldoer for innfrielse av tinglyst pant fra megler til bank eller bank til bank
* [Spesifikasjon](https://github.com/bitsnorge/e-tinglysing-afpant/blob/master/spesifikasjoner/afpant/afpant-restgjeldsoppgave/afpant-restgjeldsoppgave.md)

