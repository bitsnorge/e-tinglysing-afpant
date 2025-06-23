Restgjeldsoppgave og Innfrielsessaldo - teknisk-beskrivelse
===========================================================


# Implementasjonskrav
Det er ikke krav til å støtte både Restgjeldsoppgave og Innfrielsessaldo i førsteomgang. 
Det er opp til den enkelte aktør å velge rekkefølge på implementert støtte. Det er forventet at man støtter begge innen rimelig tid.

## Akeldo-registeret
For å kunne sende og motta meldinger av typen Restgjeldsoppgave og Innfrielsessaldo må aktøren være registrert i Akeldo-registeret med støtte for disse meldingstypene.  
En aktør kan være registrert for både sending og mottak av samme meldingstype. (Megler --> Bank, Bank --> Bank)

### Avsender:
**sendeliste:**  
 - Restgjeldsforespoersel
 - Innfrielsessaldoforespoersel
 
**mottaksliste:**
 - Restgjeldssvar
 - Innfrielsessaldosvar

### Mottaker:
**sendeliste:**
 - Restgjeldssvar
 - Innfrielsessaldosvar

**mottaksliste:**
 - Restgjeldsforespoersel
 - Innfrielsessaldoforespoerspoersel


# Meldingstyper

## Restgjeldsforespoersel

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Ja|Restgjeldsforespoersel|

### Payload *(request)*
En xml-fil av modell **Restgjeldsforespoersel** som er i henhold til [definert skjema.](../afpant-model/xsd/dsve.xsd).  
Navnet på filen må følge konvensjonen "restgjeldsforespoersel_*.xml". Case er ikke sensitivt.  

## Restgjeldssvar

### Retur av ACK/NACK notification fra fagsystem tilbake til requester (Megler/Bank) etter behandling av mottatt forespørsel:
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
			<td>
              <a href="../afpant-model/xsd/dsve.xsd">Restgjeldssvar</a> i henhold til definert skjema.
            </td>
		</tr>
		<tr><td colspan="3"><strong>Payload (ZIP-fil)</strong></td></tr>
		<tr><td colspan="3">En ZIP-fil som inneholder en XML fil av Restgjeldssvar-objektet. Og en fil av typen BrokerServiceManifest med navnet manifest.xml</td></tr>
	</tbody>
</table>

### Restgjeldssvar objekt

<table>
	<tbody>
		<tr>
			<td><p><strong>Key</strong></p></td>
			<td><p><strong>Type</strong></p></td>
			<td><p><strong>Beskrivelse</strong></p></td>
		</tr>
		<tr>
			<td><p>messageType</p></td>
			<td><p>String</p></td>
			<td><a href="../afpant-model/xsd/dsve.xsd">Restgjeldssvar</a> i henhold til definert skjema.</td>
		</tr>
		<tr>
			<td><p>status</p></td>
			<td><p>String (enum)</p></td>
			<td>Denne kan være en av følgende statuser:	
                <ul>
                    <li>RutetSuksessfullt</li>
                    <li>LånNedbetalt</li>
                    <li>LånSolgt</li>
                    <li>SvarerMedEpost</li>
                    <li>Feil</li>
                </ul> Kun status 'RutetSuksessfullt' er å anse som ACK (positive acknowledgement). Øvrige statuser er å anse som NACK (negative acknowledgement).</td>
		</tr>
		<tr>
			<td><p>statusDescription</p></td>
			<td><p>String</p></td>
			<td><p>Inneholder en utfyllende human-readable beskrivelse om hvorfor en forsendelse ble NACK'et. Teksten skal være på norsk og være mulig å vise til sluttbruker</td>
		</tr>
	</tbody>
</table>


## Innfrielsessaldoforespoersel

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Obligatorisk|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Ja|Innfrielsessaldoforespoersel|

### Payload *(request)*
En xml-fil av modell **Innfrielsessaldoforespoersel** som er i henhold til [definert skjema.](../afpant-model/xsd/dsve.xsd).  
Navnet på filen må følge konvensjonen "innfrielsessaldoforespoersel_*.xml". Case er ikke sensitivt.

## Innfrielsessaldosvar

### Retur av ACK/NACK notification fra fagsystem tilbake til requester (Megler/Bank) etter behandling av mottatt forespørsel:
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
			<td>
              <a href="../afpant-model/xsd/dsve.xsd">Innfrielsessaldosvar</a> i henhold til definert skjema.
            </td>
		</tr>
		<tr><td colspan="3"><strong>Payload (ZIP-fil)</strong></td></tr>
		<tr><td colspan="3">En ZIP-fil som inneholder en XML fil av Innfrielsessaldosvar-objektet. Og en fil av typen BrokerServiceManifest med navnet manifest.xml</td></tr>
	</tbody>
</table>

### Innfrielsessaldosvar objekt
<table>
	<tbody>
		<tr>
			<td><p><strong>Key</strong></p></td>
			<td><p><strong>Type</strong></p></td>
			<td><p><strong>Beskrivelse</strong></p></td>
		</tr>
		<tr>
			<td><p>messageType</p></td>
			<td><p>String</p></td>
			<td><a href="../afpant-model/xsd/dsve.xsd">Innfrielsessaldosvar</a> i henhold til definert skjema.</td>
		</tr>
		<tr>
			<td>Denne kan være en av følgende statuser:	
                <ul>
                    <li>RutetSuksessfullt</li>
                    <li>LånNedbetalt</li>
                    <li>LånSolgt</li>
                    <li>SvarerMedEpost</li>
                    <li>Feil</li>
                </ul> Kun status 'RutetSuksessfullt' er å anse som ACK (positive acknowledgement). Øvrige statuser er å anse som NACK (negative acknowledgement).</td>
		</tr>
		<tr>
			<td><p>statusDescription</p></td>
			<td><p>String</p></td>
			<td><p>Inneholder en utfyllende human-readable beskrivelse om hvorfor en forsendelse ble NACK'et. Teksten skal være på norsk og være mulig å vise til sluttbruker</td>
		</tr>
	</tbody>
</table>
