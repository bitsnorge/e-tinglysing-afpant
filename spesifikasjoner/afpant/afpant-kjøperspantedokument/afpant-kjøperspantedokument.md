# Kjøpers pantedokument
 
## Sammendrag
Bruker i avsender-bank må innhente hvilket organisasjonsnummer forsendelsen skal til (dette hentes normalt sett ut fra side nr 1 i signert kopi av kjøpekontrakt, og er enten organisasjonsnummeret til eiendomsmeglerforetaket eller oppgjørsforetaket).

Deretter produseres det et **ZIP**-arkiv som inneholder følgende filer:
* Kjøpers pantedokument SDO (kun 1 pantedokument pr forsendelse)
* Eventuelt forutsetningsbrev (XML) (med forutsetninger for oversendelse av pantedokument, evt innbetalingsinformasjon)
* XML data i forutsetningsbrevet må validere i henhold til <a href="./afpant-forutsetningsbrev/afpant-forutsetningsbrev-1-0-0.md">afpant-forutsetningsbrev spesifikasjon</a>.

**NB**: Dersom mer enn ett pantedokument fra samme lånesak skal tinglyses på samme matrikkelenhet må dette sendes som to separate forsendelser. For eksempel i tilfeller hvor det er to debitorer (låntakere) som ikke er ektefeller/samboere/registrerte partnere som skal ha likestilt prioritet, men separate pantedokumenter.

Avsender-bank angir manifest metadata-keys ved initiering av Altinn-forsendelsen som indikerer meldingstype, informasjon om avsender (navn, epost, tlfnr), og hvorvidt forutsetningsbrevet er inkludert i ZIP eller om det sendes out-of-band (f.eks via fax eller mail direkte til megler/oppgjør).
Mottaker (systemleverandør) pakker ut ZIP og parser SDO for å trekke ut nøkkeldata (kreditor, debitor(er), matrikkelenhet(er)) som brukes for å rute forsendelsen til korrekt oppdrag hos korrekt megler/oppgjørsforetak.

## Validering og ruting hos mottakende system
Hver enkelt systemleverandør som skal behandle forsendelser via AFPANT vil forsøke rute forsendelsen til korrekt meglersak/oppdrag i sine egne kundedatabaser.
For å rute forsendelsen blir pantedokumentet pakket ut fra SDO, og matrikkelenheter/debitorer ekstraheres.

### Krav til filnavn i ZIP-arkiv<a name="zip-filnavn-krav"></a>
- Eventuelt forutsetningsbrev må følge konvensjonen: "coverletter_&ast;.[xml]". Filtype må samsvare med valgt verdi i 'coverLetter'.
- Pantedokumentet må følge konvensjonen: "signedmortgagedeed_&ast;.[sdo|xml]"
Wildcard "&ast;" kan erstattes med en vilkårlig streng (må være et gyldig filnavn), f.eks lånesaksnummer eller annen relevant referanse for avsender.

## Krav til dokumentreferanse
- Benyttet dokumentreferanse må være unik i "signedmortgagedeed_&ast;.[sdo|xml]"
Referansen må lages på en slik måte at den også er unik på tvers av banker. Dette ettersom megler skal lage en skjøtepakke som kan inneholde flere dokumenter fra flere kilder og dokumentreferansene i en pakke må være unike. Id må være unikt på tvers av saker i den enkelte bank og på tvers av alle banker. Bruk av bankregisternummer er derfor ønskelig.
Referansen settes ved opprettelse av dokumentet i "no.kartverket.grunnbok.wsapi.v2.domain.innsending.Dokument.dokumentreferanse"
- Eksempler på ugyldige referanser: "0", "0_pantedokumnet", "1_[bankregisternummer]" 
- Eksempler på gyldige referanser: [caseId]-[dokumentId]-[bankregisternummer] "12345-123456789-9057", [UUID] "a39e6076-b775-11ea-b3de-0242ac130004"
	

### teknisk-beskrivelse: ruting
- mottakende systemleverandør søker blant alle sine kunders matrikkelenhet(er)
- utvalget avgrenses til matrikkelenheter som tilhører meglersaker hvor organisasjonsnummeret til _enten_ meglerforetaket eller oppgjørsforetaket på meglersaken er lik organisasjonsnummeret pantedokumentet er sendt til ("reportee")
- utvalget avgrenses til meglersaker hvor **alle debitorene i pantedokumentet også er registrert som kjøpere på meglersaken** (hvis det mangler fødselsnummer/orgnummer på kjøper(e) kan leverandør selv velge graden av fuzzy matching som skal tillates) 
- dersom det er registrert flere kjøpere på meglersaken enn det finnes debitorer/signaturer i pantedokumentet skal mottakende system avvise forsendelsen med en SignedMortgageDeedProcessedMessage (NACK) hvor status = DebitorMismatch.

### Håndtering av feil
- Den første feilen som oppstår stopper videre behandling av forsendelsen.
- SignedMortgageDeedProcessedMessage (NACK) returneres og vil ha utfyllende beskrivelse i property statusDescription. 
- SignedMortgageDeedProcessedMessage.statusDescription må være angitt på norsk.

## Avlesningskvittering
Etter fullført prosessering av en forsendelse, vil mottakende systemleverandør returnerer en avlesningskvittering via Altinn Formidlingstjeneste til avsender-bank. Denne vil inneholde en strukturert Ack/nack-melding som kan brukes av avsender-bank til å oppdatere state/workflow i eget (bank)fagsystem.

## Altinn Formidlingstjeneste: Manifest
Altinn ServiceEngine Broker støtter at avsender angir egendefinerte key/value pairs i Manifest.PropertyList (Manifest-objektet angis i ServiceEngine BrokerServiceInitiation.Manifest property). 

Avsender-bank angir i manifest metadata key 'coverLetter' en enum verdi som tilsier hvorvidt forutsetningsbrevet ligger som XML inne i ZIP eller om det sendes til megler/oppgjør på annet vis. Eventuell XML er ment til manuell behandling av oppgjørsansvarlig på lik linje med dagens papirbaserte forutsetningsbrev.

Ved bruk av ServiceEngine webservices vil Altinn Formidlingstjenester automatisk legge til en fil med navn "manifest.xml" i ZIP-filen som avsender tilknytter forsendelsen.

"Manifest.xml"-filen er av type BrokerServiceManifest.

## Forsendelse fra banksystem til meglersystem
<table>
	<thead>
		<tr>
			<th colspan="4">Manifest metadata (BrokerServiceInitiation.Manifest.PropertyList)</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><p><strong>Manifest key</strong></p></td>
			<td><p><strong>Type</strong></p></td>
			<td><p><strong>Required</strong></p></td>
			<td><p><strong>Beskrivelse</strong></p></td>
		</tr>
		<tr>
			<td><p>messageType</p></td>
			<td><p>String</p></td>
			<td><p>Yes</p></td>
			<td><p>Denne kan være en av følgende:</p><ul><li>SignedMortgageDeed</li></ul></td>
		</tr>
		<tr>
			<td><p>senderName</p></td>
			<td><p>String</p></td>
			<td><p>No</p></td>
			<td><p>Navn på avsender (mennesket)</p></td>
		</tr>
		<tr>
			<td><p>senderEmail</p></td>
			<td><p>String</p></td>
			<td><p>No</p></td>
			<td><p>Email til avsender</p></td>
		</tr>
		<tr>
			<td><p>senderPhone</p></td>
			<td><p>String</p></td>
			<td><p>No</p></td>
			<td><p>Tlf til avsender</p></td>
		</tr>
		<tr>
			<td><p>coverLetter</p></td>
			<td><p>String (enum)</p></td>
			<td><p>Yes</p></td>
			<td><p>Denne kan være en av følgende statuser:</p><ul><li>XmlAttached</li><li>SentOutOfBand</li><li>Omitted</li></ul></td>
		</tr>
		<tr><td colspan="4"><strong>Payload (ZIP-fil)</strong></td></tr>
		<tr><td colspan="4">En ZIP-fil som inneholder kjøpers pantedokument (SDO) + eventuelt forutsetningsbrev må tilknyttes forsendelsen. Filnavnene inne i ZIP-filen må følge krav til filnavn i ZIP-arkiv.<br>
		Tilknytting av ZIP-fil til forsendelsen kan gjøres ved bruk av  BrokerServiceExternalBasicStreamedClient / StreamedPayloadBasicBE.</td></tr>
	</tbody>
</table>


## Retur av ACK/NACK notification fra fagsystem til bank (etter behandling av mottatt pantedokument):
<table>
	<thead>
		<tr>
			<th colspan="4">Manifest metadata (BrokerServiceInitiation.Manifest.PropertyList)</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><p><strong>Manifest key</strong></p></td>
			<td><p><strong>Type</strong></p></td>
			<td><p><strong>Beskrivelse</strong></p></td>
		</tr>
		<tr>
			<td><p>messageType</p></td>
			<td><p>String</p></td>
			<td><p>Denne kan være en av følgende:</p><ul><li>SignedMortgageDeedProcessed</li></ul></td>
		</tr>
		<tr><td colspan="3"><strong>Payload (ZIP-fil)</strong></td></tr>
		<tr><td colspan="3">En ZIP-fil som inneholder en XML fil av SignedMortgageDeedProcessedMessage-objektet.</td></tr>
	</tbody>
</table>

## SignedMortgageDeedProcessedMessage objekt
<table>
	<tbody>
		<tr>
			<td><p><strong>Key</strong></p></td>
			<td><p><strong>Type</strong></p></td>
			<td><p><strong>Beskrivelse</strong></p></td>
		</tr>
		<tr>
			<td><p>MessageType</p></td>
			<td><p>String</p></td>
			<td><p>Denne kan være en av følgende:</p><ul><li>SignedMortgageDeedProcessed</li></ul></td>
		</tr>
		<tr>
			<td><p>Status</p></td>
			<td><p>String (enum)</p></td>
			<td>Denne kan være en av følgende statuser:	<ul><li>RoutedSuccessfully</li><li>UnknownCadastre (ukjent matrikkelenhet)</li><li>DebitorMismatch (fant matrikkelenhet, men antall kjøpere eller navn/id på kjøpere matcher ikke debitorer i pantedokumentet)</li><li>Rejected (sendt til et organisasjonsnummer som ikke lenger har et aktivt kundeforhold hos leverandøren - feil config i Altinn AFPANT, eller ugyldig forsendelse)</li></ul> Kun status 'RoutedSuccessfully' er å anse som ACK (positive acknowledgement). Øvrige statuser er å anse som NACK (negative acknowledgement).</td>
		</tr>
		<tr>
			<td><p>StatusDescription</p></td>
			<td><p>String</p></td>
			<td><p>Inneholder en utfyllende human-readable beskrivelse om hvorfor en forsendelse ble NACK'et.</td>
		</tr>
		<tr>
			<td><p>ExternalSystemId</p></td>
			<td><p>String</p></td>
			<td><p>Optional: ID/oppdragsnummer/key i eksternt meglersystem/fagsystem.</p></td>
		</tr>
	</tbody>
</table>
