## Altinn Formidlingstjeneste - servicedetaljer
<table>
	<tbody>
		<tr>
			<td><p><strong>Navn</strong></p></td>
			<td><p><strong>Altinn 2 ServiceCode</strong></p></td>
			<td><p><strong>Altinn 2 ServiceEditionCode</strong></p></td>
			<td><p><strong>Altinn 3 Resource ID</strong></p></td>
		</tr>
		<tr>
			<td><p>AFPANT (Altinn Test TT02)</p></td>
			<td><p>4752</p></td>
			<td><p>1</p></td>
			<td><p>kv_dsve_test</p></td>
		</tr>
		<tr>
			<td><p>AFPANT (Altinn Prod)</p></td>
			<td><p>4752</p></td>
			<td><p>1</p></td>
			<td><p>kv_dsve</p></td>
		</tr>
	</tbody>
</table>
*NB:* ServiceCode for tjenesten er lik i Test og Prod.

## Maskinell kontroll av Altinn-tilganger (for systemleverandører)
Det er mulig å foreta en maskinell kontroll av hvilke organisasjoner som har delegert rettigheter til systemleverandør for en gitt ServiceCode. 
[Les mer om maskinell kontroll her](./altinn-maskinell-kontroll.md)

## Altinn-tilgang for systemleverandører/datasentraler
Kartverket må gi rettigheter (READ+WRITE) i tjenesteeierstyrt rettighetsregister for alle systemleverandører/datasentraler som skal koble seg direkte til denne tjenesten.
Bestillinger av denne tilgangen må gjøres via Kartverket JIRA (https://jira.statkart.no/).

## Altinn-tilgang for eiendomsmeglerforetak/banker
Kartverket må gi rettigheter (READ+WRITE) i tjenesteeierstyrt rettighetsregister for alle bank- og eiendomsmeglerforetak som skal sende- og motta forsendelser fra denne tjenesten, selv om forsendelsene skal hentes/administreres av tredjepart (systemleverandør/datasentral).
Bestillinger av denne tilgangen må gjøres via tredjepartsleverandør eller direkte til Kartverket.

## Delegering av roller fra egne kunder til systemleverandør/datasentral
Systemleverandører/datasentraler som skal utføre sending/mottak på vegne av *andre organisasjoner* (eks meglerforetak/bank) må registrere seg selv hos Kartverket (ref ovenstående punkt).
Ved henting av forsendelser på vegne av egne kunder skal systemleverandør/datasentral bruke organisasjonsnummeret tilhørende kunden som "reportee" mot Altinn.

*Hver organisasjon/kunde* som en systemleverandør/datasentral opererer på vegne av (eks meglerforetak/bank) må logge på Altinn for å delegere rettigheter til sin gjeldende systemleverandør/datasentral sitt organisasjonsnummer for tjenesten *4752* (AFPANT).
Oppskrift for å delegere rollen 'Utfyller/Innsender' eller enkeltrettighet til systemleverandør/datasentral sitt organisasjonsnummer finnes her: https://www.altinn.no/no/Portalhjelp/Administrere-rettigheter-og-prosessteg/Gi-roller-og-rettigheter/

*NB:* Delegering av denne rettigheten må utføres _etter_ at Kartverket har gitt tilgang til både systemleverandør/datasentral og kunden (meglerforetak/bank).
