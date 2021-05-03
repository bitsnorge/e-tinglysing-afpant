# Kjøpekontrakt

En bank kan sende forespørsel om kjøpekontrakt til en megler basert på kjøpers fødsels og personnummer og eiendomsobjektet som skal finansieres.
Megler vil besvare forespørselen med en forsendelse som inneholder strukturerte data samt en signert versjon av den fulle kontrakten.
Dersom den faktiske kjøpekontrakten ikke er signert, skal kun den strukturerte delen returneres.
Dersom forespørselen ikke kan besvares, vil banken få en feilmelding i retur som beskriver hvorfor megler ikke kan besvare forespørselen.

## Endring av strukturerte data i meglersystem
Ved endring av strukturerte data i meglersystemet må det kringkastes en oppdatering fra meglersystemet (_Kjøpekontraktsendring_) til alle banker som har mottatt kjøpekontrakt. Kjøpekontraktsendring-meldingen er en push-melding og har ingen tilhørende "svar"-melding. Kjøpekontraktsendring-meldingen inneholder en statuskode for årsaken til endring, og mottaker av den må be om kjøpekontrakt på nytt for å få oppdaterte data.

Kjøpekontraktsendring-meldingen sendes ved følgende endringer: 
- forkjøpsrett benyttet
- signert kjøpekontrakt er registrert
- signert kjøpekontrakt er endret
- overtagelsesdato er endret
- kjøpers eierandel(er) er endret
- kjøpersammensetning er endret (f.eks samboer/ektefelle legges til som kjøper 2)

## Forspørsel om kjøpekontrakt
Forespørsel sendes fra bank til megler for å hente kjøpekontrakten for en kunde.
Det forventes at positivt svar er en kjøpekontrakt som definert under.

## Validering og ruting hos mottakende system
Hver enkelt systemleverandør som skal behandle forespørsel om kjøpekontrakt vil forsøke å rute forsendelsen til korrekt meglersak/oppdrag i sine egne kundedatabaser.

### Implementasjonsbeskrivelse: ruting
- mottakende systemleverandør søker blant alle sine kunders matrikkelenhet(er)
- utvalget avgrenses til matrikkelenheter som tilhører meglersaker hvor organisasjonsnummeret til _enten_ meglerforetaket eller oppgjørsforetaket på meglersaken er lik organisasjonsnummeret pantedokumentet er sendt til ("reportee")
- utvalget avgrenses til meglersaker hvor **alle debitorene i pantedokumentet også er registrert som kjøpere på meglersaken** (hvis det mangler fødselsnummer/orgnummer på kjøper(e) kan leverandør selv velge graden av fuzzy matching som skal tillates) 
- dersom det er registrert flere kjøpere på meglersaken enn det finnes debitorer/signaturer i pantedokumentet skal mottakende system avvise forsendelsen med en SignedMortgageDeedProcessedMessage (NACK) hvor status = DebitorMismatch.

## Meldingstype: RealEstatePurchaseContractRequest
Benyttes av bank for å forespørre megler om kjøpekontrakt (strukturerte data + signert kjøpekontrakt). 

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Required|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|RealEstatePurchaseContractRequest|

### Payload
En ZIP-fil som inneholder en XML med requestdata ihht. [definert skjema.](../afpant-model/xsd/dsve-1.0.0.xsd)

#### Om payload *(request)*
- En xml-fil som er i henhold til xsd-filen.
- Se eksempel på presentasjon [Eksempel](examples/kjoepekontrakt-request-example-xml.png)

##### Model
![model kjøpekontraktforespørsel](examples/model_kjøpekontraktforespørsel.png "Model for forespørsel om kjøpekontrakt")

## Meldingstype: RealEstatePurchaseContract
Benyttes som svar fra meglersystem til banksystem etter mottatt "RealEstatePurchaseContractRequest".

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Required|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|RealEstatePurchaseContract|

### Payload
En ZIP-fil som inneholder en XML med responsdata ihht. gitte xsd.
Tilknytting av ZIP-fil til forsendelsen kan gjøres ved bruk av BrokerServiceExternalBasicStreamedClient / StreamedPayloadBasicBE.
		
#### Om payload *(response)*

##### Positiv resultat
- Må være en xml-fil som er ihht. [definert skjema](../afpant-model/xsd/dsve-1.0.0.xsd).
- Se eksempel på presentasjon [Eksempel](examples/kjoepekontrakt-example-xml.png)

##### Model
![model kjøpekontrakt](examples/model_kjøpekontrakt.png "Model for kjøpekontrakt")

##### Negativt resultat
- @todo:Må definere hvor ack/navk-informasjon skal legges

## Meldingstype: RealEstatePurchaseContractUpdated
Benyttes som pushvarsel fra meglersystem til banksystem etter endring i enkelte grunnlagsdata.

### Manifest
(BrokerServiceInitiation.Manifest.PropertyList)

|Manifest key|Type|Required|Beskrivelse|
|--- |--- |--- |--- |
|messageType|String|Yes|RealEstatePurchaseContractUpdated|

## Eksempel

### Forespørsel
![Eksempel](examples/kjoepekontrakt-request-example-xml.png)

### Svar
![Eksempel](examples/kjoepekontrakt-example-xml.png)