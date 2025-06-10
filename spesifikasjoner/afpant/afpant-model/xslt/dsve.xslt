<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>
  <xsl:decimal-format name="nb-no-space" decimal-separator="," grouping-separator=" " NaN=" "/>

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:call-template name="overskrift"/>
        </title>
        <style type="text/css">.rolleoverskrift,
          .seksjonsoverskrift {
          font-weight: 500;
          color: #255473
          }

          #footer,
          .overskrift,
          .rolleoverskrift {
          color: #255473
          }

          .seksjonsoverskrift {
          padding-bottom: 8px
          }

          .rolleoverskrift {
          padding-top: 8px
          }

          .listeelement {
          font-weight: 400;
          padding-bottom: 4px
          }

          .innhold {
          padding-left: 8px
          }

          body {
          margin: 0;
          padding: 0;
          height: 100%
          }

          .hovedseksjon {
          padding: 5px;
          margin-bottom: 4px
          }

          #container {
          min-height: 100%;
          position: relative;
          margin: 10px;
          font-family: helvetica;
          max-width: 210mm
          }

          #header {
          padding-left: 5px;
          padding-top: 1px;
          padding-bottom: 1px
          }

          #body {
          padding-top: 10px;
          padding-bottom: 50px;
          widht: 100%
          }

          #footer {
          position: absolute;
          bottom: 0;
          width: 100%;
          height: 50px;
          background: #BDCBBD!important;
          text-align: center
          }

          .tabell {
          display: table;
          padding-bottom: 4px;
          width: 100%table-layout: fixed
          }

          .rad {
          display: table-row
          }

          .celle,
          .divTableHead {
          border: 0;
          display: table-cell;
          padding: 1px
          }

          .kropp {
          display: table-row-group
          }

          .kol1 {
          min-width: 80px;
          width: 350px
          }

          .kol2 {
          width: 120px
          }

          .headerrad {
          color: grey;
          font-size: 11px
          }

          .kommentar {
          color: grey;
          font-size: 10px;
          font-style: italic;
          }

          .tall {
          text-align:right;
          }
        </style>
      </head>
      <body>
        <div id="container">
          <div id="header">
            <h1 class="overskrift">
              <xsl:call-template name="overskrift"/>
            </h1>
            <hr/>

            <xsl:call-template name="footerForH1">
              <xsl:with-param name="home" select="*"/>
              <xsl:with-param name="meldingsnavn" select="$dsveMeldingstypeBeskrivelse"/>
            </xsl:call-template>

          </div>
          <div id="body">
            <xsl:apply-templates select="saldoforespoersel"/>
            <xsl:apply-templates select="saldosvar"/>
            <xsl:apply-templates select="restgjeldsforespoersel"/>
            <xsl:apply-templates select="restgjeldssvar"/>
            <xsl:apply-templates select="intensjonfrabank"/>
            <xsl:apply-templates select="intensjonssvarframegler"/>
            <xsl:apply-templates select="intensjonsendring"/>
            <xsl:apply-templates select="gjennomfoertetinglysing"/>
          </div>
        </div>
        <xsl:comment>div id containe</xsl:comment>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="overskrift">
    <xsl:if test="saldoforespoersel">
      <xsl:text>Forespørsel om saldo</xsl:text>
    </xsl:if>
    <xsl:if test="saldosvar">
      <xsl:text>Saldosvar</xsl:text>
    </xsl:if>
    <xsl:if test="restgjeldsforespoersel">
      <xsl:text>Forespørsel om restgjeld</xsl:text>
    </xsl:if>
    <xsl:if test="restgjeldssvar">
      <xsl:text>Restgjeldssvar</xsl:text>
    </xsl:if>
    <xsl:if test="intensjonfrabank">
      <xsl:text>Forespørsel om tinglysingsmetode</xsl:text>
    </xsl:if>
    <xsl:if test="intensjonssvarframegler">
      <xsl:text>Tinglysingsmetode</xsl:text>
    </xsl:if>
    <xsl:if test="intensjonsendring">
      <xsl:text>Endring av tinglysingsmetode</xsl:text>
    </xsl:if>
    <xsl:if test="gjennomfoertetinglysing">
      <xsl:text>Gjennomført e-tinglysing</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/saldoforespoersel">
    <xsl:call-template name="mottaker"/>
    <xsl:call-template name="eiendom">
      <xsl:with-param name="registerenhetsliste" select="registerenheter/registerenhet"/>
    </xsl:call-template>
    <xsl:call-template name="megler"/>
    <xsl:call-template name="parter"/>
    <xsl:call-template name="saldoforespoersel"/>
    <xsl:call-template name="avsender"/>
    <hr/>
  </xsl:template>

  <xsl:template match="/saldosvar">
    <xsl:call-template name="mottaker"/>
    <xsl:call-template name="eiendom">
      <xsl:with-param name="registerenhetsliste" select="registerenheter/registerenhet"/>
    </xsl:call-template>
    <xsl:call-template name="parter"/>
    <xsl:call-template name="saldosvardetaljer"/>
    <xsl:call-template name="avsender"/>
    <hr/>
  </xsl:template>

  <xsl:template match="/restgjeldsforespoersel">
    <xsl:call-template name="mottaker"/>
    <xsl:call-template name="eiendom">
      <xsl:with-param name="registerenhetsliste" select="registerenheter/registerenhet"/>
    </xsl:call-template>
    <xsl:call-template name="megler"/>
    <xsl:call-template name="parter"/>
    <xsl:call-template name="restgjeldsforespoersel"/>
    <xsl:call-template name="avsender"/>
    <hr/>
  </xsl:template>

  <xsl:template match="/restgjeldssvar">
    <xsl:call-template name="mottaker"/>
    <xsl:call-template name="eiendom">
      <xsl:with-param name="registerenhetsliste" select="registerenheter/registerenhet"/>
    </xsl:call-template>
    <xsl:call-template name="parter"/>
    <xsl:call-template name="restgjeldssvardetaljer"/>
    <xsl:call-template name="avsender"/>
    <hr/>
  </xsl:template>

  <xsl:template match="/intensjonfrabank">
    <xsl:call-template name="mottaker"/>
    <xsl:call-template name="eiendom">
      <xsl:with-param name="registerenhetsliste" select="registerenheter/registerenhet"/>
    </xsl:call-template>
    <div class="hovedseksjon">
      <xsl:call-template name="listRoller">
        <xsl:with-param name="rolle" select="kjoepere/rettssubjekt"/>
        <xsl:with-param name="rolleNavn" select="'Kjøpere'"/>
      </xsl:call-template>
    </div>
    <xsl:call-template name="intensjonfrabank"/>
    <xsl:call-template name="avsender"/>
    <hr/>
  </xsl:template>

  <xsl:template match="/intensjonssvarframegler">
    <xsl:call-template name="mottaker"/>
    <xsl:call-template name="eiendom">
      <xsl:with-param name="registerenhetsliste" select="registerenheter/registerenhet"/>
    </xsl:call-template>
    <xsl:call-template name="megler"/>
    <xsl:call-template name="parter"/>
    <xsl:call-template name="intensjonssvarframegler"/>
    <xsl:call-template name="avsender"/>
    <hr/>
  </xsl:template>

  <xsl:template match="/intensjonsendring">
    <xsl:call-template name="mottaker"/>
    <xsl:call-template name="eiendom">
      <xsl:with-param name="registerenhetsliste" select="registerenheter/registerenhet"/>
    </xsl:call-template>
    <xsl:if test="megler">
      <xsl:call-template name="megler"/>
    </xsl:if>
    <xsl:call-template name="parter"/>
    <xsl:call-template name="intensjonsendring"/>
    <xsl:call-template name="avsender"/>
    <hr/>
  </xsl:template>

  <xsl:template match="/gjennomfoertetinglysing">
    <xsl:call-template name="mottaker"/>
    <xsl:call-template name="gjennomfoertetinglysing"/>
    <xsl:call-template name="ressurser"/>
    <xsl:call-template name="avsender"/>
    <hr/>
  </xsl:template>

  <xsl:template name="intensjonfrabank">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Ønsket metode for tinglysing'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <div class="rad">
            <div class="celle kol1">
              <xsl:text>Ønsket metode:&#x20;</xsl:text>
            </div>
            <div class="celle">
              <b>
                <xsl:value-of select="intensjonsdetaljer/metode"/>
              </b>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="intensjonssvarframegler">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Ønsket metode for tinglysing'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <div class="rad">
            <div class="celle kol1">
              <xsl:text>Ønsket metode:&#x20;</xsl:text>
            </div>
            <div class="celle">
              <b>
                <xsl:value-of select="intensjonsdetaljer/metode"/>
              </b>
            </div>
          </div>
          <xsl:if test="intensjonsdetaljer/harsignerthjemmelsovergangpaapapir">
            <div class="rad">
              <div class="celle kol1">
                <xsl:text>Signert hjemmelsovergang/skjøte (papir) tilgjengelig:&#x20;</xsl:text>
              </div>
              <div class="celle">
                <xsl:if test="intensjonsdetaljer/harsignerthjemmelsovergangpaapapir='true'">Ja</xsl:if>
                <xsl:if test="intensjonsdetaljer/harsignerthjemmelsovergangpaapapir='false'">Nei</xsl:if>
              </div>
            </div>
          </xsl:if>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="intensjonsendring">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Ønsket metode for tinglysing'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <div class="rad">
            <div class="celle kol1">
              <xsl:text>Ønsket metode:&#x20;</xsl:text>
            </div>
            <div class="celle">
              <b>
                <xsl:value-of select="intensjonsdetaljer/metode"/>
              </b>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="gjennomfoertetinglysing">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Gjennomført e-tingysing detaljer'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <div class="rad">
            <div class="celle kol1">
              <xsl:text>Dokumentreferanse:&#x20;</xsl:text>
            </div>
            <div class="celle">
              <b>
                <xsl:value-of select="gjennomfoertetinglysingdetaljer/dokumentreferanse"/>
              </b>
            </div>
          </div>
          <div class="rad">
            <div class="celle kol1">
              <xsl:text>Altinn SendersReference:&#x20;</xsl:text>
            </div>
            <div class="celle">
              <b>
                <xsl:value-of select="gjennomfoertetinglysingdetaljer/altinnsendersreference"/>
              </b>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="saldoforespoersel">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Info'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <xsl:if test="saldoforespoerseldetaljer/prisantydning">
            <div class="rad">
              <div class="celle kol1">
                <xsl:text>Prisantydning:&#x20;</xsl:text>
              </div>
              <div class="celle kol2">
                <xsl:call-template name="formatNumber">
                  <xsl:with-param name="prefix" select="'kr. '"/>
                  <xsl:with-param name="numericValue" select="saldoforespoerseldetaljer/prisantydning"/>
                </xsl:call-template>
              </div>
            </div>
          </xsl:if>
          <xsl:if test="saldoforespoerseldetaljer/salgssum">
            <div class="rad">
              <div class="celle">
                <xsl:text>Salgssum:&#x20;</xsl:text>
              </div>
              <div class="celle">
                <xsl:call-template name="formatNumber">
                  <xsl:with-param name="prefix" select="'kr. '"/>
                  <xsl:with-param name="numericValue" select="saldoforespoerseldetaljer/salgssum"/>
                </xsl:call-template>
              </div>
            </div>
          </xsl:if>
        </div>
      </div>
    </div>
    <xsl:call-template name="tinglyst"/>
  </xsl:template>

  <xsl:template name="restgjeldsforespoersel">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Forspurte datoer for restgjeld'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <xsl:for-each select="restgjeldsforespoerseldetaljer/saldoperdato/saldo">
            <div class="rad">
              <div class="celle kol1">
                <xsl:text>Saldo&#x20;per&#x20;</xsl:text>
                <b>
                  <xsl:call-template name="dato">
                    <xsl:with-param name="dato" select="@dato"/>
                  </xsl:call-template>
                </b>
              </div>
            </div>
            <xsl:for-each select="laanenummer">
              <div class="rad">
                <div class="celle kol1">
                  <span style="padding-left: 8px;">Lånenummer:</span>
                </div>
                <div class="celle kol2">
                  <xsl:value-of select="."/>
                </div>
              </div>
            </xsl:for-each>
          </xsl:for-each>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="saldosvardetaljer">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Lån med pant i eiendommen'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <div class="rad headerrad">
            <div class="celle">Lånenummer</div>
            <div class="celle">Saldo</div>
            <div class="celle">Type lån</div>
            <div class="celle">Låst ramme</div>
          </div>
          <xsl:for-each select="saldosvardetaljer/saldoer/laan">
            <xsl:call-template name="laan">
              <xsl:with-param name="dokument" select="."/>
            </xsl:call-template>
          </xsl:for-each>
        </div>
      </div>
    </div>
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Erklæring'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <div class="rad">
            <div class="celle">Hvis oppgitt lån er rammekreditt, er lånet sperret for ytterligere opplåning:</div>
            <div class="celle">
              <xsl:if test="saldosvardetaljer/sperret='true'">Ja</xsl:if>
              <xsl:if test="saldosvardetaljer/sperret='false'">Nei</xsl:if>
            </div>
          </div>
        </div>
      </div>
      <div class="innhold">Vi bekrefter med dette at pantet (pantene)/lånene ikke vil opplånes uten samtykke fra meglers oppgjørsavdeling. Megler må sørge for tinglysing av sperre på eiendommen for å
        sikre at banken ikke etablerer nye pant. Alle våre panteretter i eiendommen vil slettes ved innfrielse/mottak av vårt tilgodehavende.
      </div>
    </div>
  </xsl:template>

  <xsl:template name="restgjeldssvardetaljer">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Restgjeld'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <div class="rad headerrad">
            <div class="celle">Lånenummer</div>
            <div class="celle">Saldo</div>
            <div class="celle">Type lån</div>
            <div class="celle">Låst ramme</div>
          </div>
          <xsl:for-each select="restgjelddetaljer/restgjeldsdatoer/saldoerperdato">
            <div class="rad">
              <div class="celle kol1">
                <xsl:text>Saldo&#x20;per&#x20;</xsl:text>
                <b>
                  <xsl:call-template name="dato">
                    <xsl:with-param name="dato" select="@dato"/>
                  </xsl:call-template>
                </b>
              </div>
            </div>
            <xsl:for-each select="laan">
              <xsl:call-template name="laan">
                <xsl:with-param name="dokument" select="."/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:for-each>
        </div>
      </div>
    </div>
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Erklæring'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <div class="rad">
            <div class="celle">Hvis oppgitt lån er rammekreditt, er lånet sperret for ytterligere opplåning:</div>
            <div class="celle">
              <xsl:if test="restgjelddetaljer/sperret='true'">Ja</xsl:if>
              <xsl:if test="restgjelddetaljer/sperret='false'">Nei</xsl:if>
            </div>
          </div>
        </div>
      </div>
      <div class="innhold">Vi bekrefter med dette at pantet (pantene)/lånene ikke vil opplånes uten samtykke fra meglers oppgjørsavdeling. Megler må sørge for tinglysing av sperre på eiendommen for å
        sikre at banken ikke etablerer nye pant. Alle våre panteretter i eiendommen vil slettes ved innfrielse/mottak av vårt tilgodehavende.
      </div>
    </div>
  </xsl:template>

  <xsl:template name="tinglyst">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Pantedokumenter'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <xsl:for-each select="saldoforespoerseldetaljer/tinglyst/pant">
            <xsl:call-template name="pant">
              <xsl:with-param name="dokument" select="."/>
            </xsl:call-template>
          </xsl:for-each>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="laan">
    <xsl:param name="dokument"/>
    <div class="rad">
      <div class="celle kol2">
        <xsl:value-of select="$dokument/@laanenummer"/>
      </div>
      <div class="celle kol2">
        <xsl:call-template name="formatNumber">
          <xsl:with-param name="prefix" select="'NOK '"/>
          <xsl:with-param name="numericValue" select="$dokument/@saldo"/>
        </xsl:call-template>
      </div>
      <div class="celle kol2">
        <xsl:value-of select="$dokument/@type"/>
      </div>
      <div class="celle kol2">
        <xsl:call-template name="formatNumber">
          <xsl:with-param name="prefix" select="'NOK '"/>
          <xsl:with-param name="numericValue" select="$dokument/@laastramme"/>
        </xsl:call-template>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="pant">
    <xsl:param name="dokument"/>
    <div class="rad">
      <div class="celle kol1">
        <span>
          <xsl:value-of select="$dokument/@dokumentaar"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="$dokument/@dokumentnummer"/>
          <xsl:text>-</xsl:text>
          <xsl:value-of select="$dokument/@rettsstiftelsesnummer"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="$dokument/@embetenummer"/>
        </span>
        <br/>
        <xsl:call-template name="tiddato">
          <xsl:with-param name="dato" select="$dokument/@tid"/>
        </xsl:call-template>
        <xsl:if test="$dokument/@kommunenummer">
          <br/>
          <xsl:text>Kommune:&#x20;</xsl:text>
          <xsl:value-of select="$dokument/@kommunenummer"/>
        </xsl:if>
      </div>
      <div class="celle">
        <span>
          <xsl:text>Pantedokument</xsl:text>
        </span>
        <br/>
        <xsl:text>Beløp:</xsl:text>
        <xsl:call-template name="formatNumber">
          <xsl:with-param name="prefix" select="'NOK '"/>
          <xsl:with-param name="numericValue" select="$dokument/@beloep"/>
        </xsl:call-template>
        <br/>
        <xsl:call-template name="organisasjonAlaGrunnbok">
          <xsl:with-param name="organisasjon" select="$dokument/panthaver/organisasjon"/>
        </xsl:call-template>
        <br/>
        <br/>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="bank">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Bank'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">
            <xsl:call-template name="organisasjon">
              <xsl:with-param name="organisasjon" select="bank"/>
            </xsl:call-template>
          </div>
          <div class="celle">
            <xsl:if test="bank/referanse">Referanse:&#x20;<xsl:value-of select="bank/referanse"/>
            </xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mottaker">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Mottaker'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">
            <xsl:call-template name="organisasjon">
              <xsl:with-param name="organisasjon" select="mottaker"/>
            </xsl:call-template>
          </div>
          <div class="celle">
            <xsl:if test="mottaker/referanse">Referanse:&#x20;<xsl:value-of select="mottaker/referanse"/>
            </xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="ressurser">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Vedlegg'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad" style="font-style: italic;">
          <div class="celle kol1">Filnavn</div>
          <div class="celle">Beskrivelse</div>
        </div>
        <xsl:for-each select="metadata/ressurser/vedlegg">
          <xsl:call-template name="vedlegg">
            <xsl:with-param name="vedlegg" select="."/>
          </xsl:call-template>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="vedlegg">
    <xsl:param name="vedlegg"/>
    <div class="rad">
      <div class="celle">
        <xsl:value-of select="$vedlegg/navn"/>
      </div>
      <div class="celle">
        <xsl:value-of select="$vedlegg/beskrivelse"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="organisasjon">
    <xsl:param name="organisasjon"/>
    <xsl:value-of select="$organisasjon/foretaksnavn"/>
    <xsl:text>&#x20;org.nr.&#x20;</xsl:text>
    <xsl:call-template name="orgnr">
      <xsl:with-param name="id" select="$organisasjon/@id"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="organisasjonAlaGrunnbok">
    <xsl:param name="organisasjon"/>
    <xsl:text>Panthaver:</xsl:text>
    <xsl:value-of select="$organisasjon/foretaksnavn"/>
    <br/>
    <xsl:text>Org.nr:&#x20;</xsl:text>
    <xsl:call-template name="orgnr">
      <xsl:with-param name="id" select="$organisasjon/@id"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="eiendom">
    <xsl:param name="registerenhetsliste"/>
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Salgsobjekt'"/>
      </xsl:call-template>
      <div class="liste">
        <xsl:call-template name="registerenhetvisning">
          <xsl:with-param name="registerenhetsliste" select="$registerenhetsliste"/>
        </xsl:call-template>
        <xsl:if test="salgsobjekt/salgsoppgave">
          <div class="innhold">
            <a href="{salgsobjekt/salgsoppgave}" target="_blank">Salgsoppgave</a>
            <xsl:text>&#x20;|&#x20;</xsl:text>
            <a href="{salgsobjekt/nettannonse}" target="_blank">Nettannonse</a>
          </div>
        </xsl:if>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="registerenhetvisning">
    <xsl:param name="registerenhetsliste"/>
    <xsl:for-each select="$registerenhetsliste">
      <div class="listeelement">
        <xsl:call-template name="registerenhet">
          <xsl:with-param name="registerenhet" select="."/>
        </xsl:call-template>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="registerenhet">
    <xsl:param name="registerenhet"/>
    <div class="innhold">
      <xsl:if test="$registerenhet/matrikkel">
        <xsl:call-template name="eiendomsnivaatype">
          <xsl:with-param name="matrikkel" select="$registerenhet/matrikkel"/>
        </xsl:call-template>
        <xsl:if test="$registerenhet/adresse">
          <xsl:call-template name="adresse">
            <xsl:with-param name="adresse" select="$registerenhet/adresse"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="matrikkel">
          <xsl:with-param name="matrikkel" select="$registerenhet/matrikkel"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="$registerenhet/borettsandel">
        <xsl:text>Borettsandel</xsl:text>
        <xsl:if test="$registerenhet/adresse">
          <xsl:call-template name="adresse">
            <xsl:with-param name="adresse" select="$registerenhet/adresse"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="borettsandel">
          <xsl:with-param name="borettsandel" select="$registerenhet/borettsandel"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="$registerenhet/aksjeleilighet">
        <xsl:text>Aksjeleilighet</xsl:text>
        <xsl:if test="$registerenhet/adresse">
          <xsl:call-template name="adresse">
            <xsl:with-param name="adresse" select="$registerenhet/adresse"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="aksjeleilighet">
          <xsl:with-param name="aksjeleilighet" select="$registerenhet/aksjeleilighet"/>
        </xsl:call-template>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template name="aksjeleilighet">
    <xsl:param name="aksjeleilighet"/>
    <div>
      <xsl:value-of select="$aksjeleilighet/@organisasjonsnavn"/>
      <xsl:text>,&#x20;org.nr.&#x20;</xsl:text>
      <xsl:call-template name="orgnr">
        <xsl:with-param name="id" select="$aksjeleilighet/@organisasjonsnummer"/>
      </xsl:call-template>
      <xsl:text>,&#x20;leilighetsnummer:&#x20;</xsl:text>
      <xsl:value-of select="$aksjeleilighet/@leilighetsnummer"/>
    </div>
  </xsl:template>

  <xsl:template name="borettsandel">
    <xsl:param name="borettsandel"/>
    <div>
      <xsl:value-of select="$borettsandel/@borettslagnavn"/>
      <xsl:text>,&#x20;org.nr.&#x20;</xsl:text>
      <xsl:call-template name="orgnr">
        <xsl:with-param name="id" select="$borettsandel/@organisasjonsnummer"/>
      </xsl:call-template>
      <xsl:text>,&#x20;andelnr.&#x20;</xsl:text>
      <xsl:value-of select="$borettsandel/@andelsnummer"/>
    </div>
  </xsl:template>

  <xsl:template name="matrikkel">
    <xsl:param name="matrikkel"/>
    <div>
      <xsl:text>Kommune:&#x20;</xsl:text>
      <xsl:value-of select="$matrikkel/@kommunenavn"/>
      <xsl:text>&#x20;</xsl:text>
      <xsl:value-of select="$matrikkel/@kommunenummer"/>
      <xsl:text>,&#x20;gårdsnr.:&#x20;</xsl:text>
      <xsl:value-of select="$matrikkel/@gaardsnummer"/>
      <xsl:text>,&#x20;bruksnr.:&#x20;</xsl:text>
      <xsl:value-of select="$matrikkel/@bruksnummer"/>
      <!-- Siden XSD sier at seksjonsnummer / festenummer er optional tester vi også mot tom streng (PH) -->
      <xsl:if test="not($matrikkel/@seksjonsnummer = '0') and not($matrikkel/@seksjonsnummer = '')">
        <xsl:text>,&#x20;seksjonsnr.:&#x20;</xsl:text>
        <xsl:value-of select="$matrikkel/@seksjonsnummer"/>
      </xsl:if>
      <xsl:if test="not($matrikkel/@festenummer = '0') and not($matrikkel/@festenummer = '')">
        <xsl:text>,&#x20;festenr.:&#x20;</xsl:text>
        <xsl:value-of select="$matrikkel/@festenummer"/>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template name="eiendomsnivaatype">
    <xsl:param name="matrikkel"/>
    <xsl:if test="$matrikkel/@eiendomsnivaa = 'E'">Grunneiendom</xsl:if>
    <xsl:if test="$matrikkel/@eiendomsnivaa = 'F'">Festeeiendom</xsl:if>
    <xsl:if test="contains($matrikkel/@eiendomsnivaa, 'F_')">Fremfeste
      <xsl:value-of select="$matrikkel/@eiendomsnivaa"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="adresse">
    <xsl:param name="adresse"/>
    <div>
      <xsl:value-of select="$adresse/gatenavn"/>
      <xsl:text>,&#x20;</xsl:text>
      <xsl:value-of select="$adresse/postnummer"/>
      <xsl:text>&#x20;</xsl:text>
      <xsl:value-of select="$adresse/poststed"/>
    </div>
  </xsl:template>

  <xsl:template name="parter">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Parter'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp ">
          <xsl:call-template name="listRoller">
            <xsl:with-param name="rolle" select="parter/kjoepere/rettssubjekt"/>
            <xsl:with-param name="rolleNavn" select="'Kjøpere'"/>
          </xsl:call-template>
          <xsl:call-template name="listRoller">
            <xsl:with-param name="rolle" select="parter/selgere/rettssubjekt"/>
            <xsl:with-param name="rolleNavn" select="'Selgere'"/>
          </xsl:call-template>
          <xsl:call-template name="listRoller">
            <xsl:with-param name="rolle" select="parter/hjemmelshavere/rettssubjekt"/>
            <xsl:with-param name="rolleNavn" select="'Hjemmelshavere'"/>
          </xsl:call-template>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="listRollerMedAndel">
    <xsl:param name="rolle"/>
    <xsl:param name="rolleNavn"/>
    <xsl:if test="$rolle/rettssubjekt">
      <div class="rad">
        <div class="celle">
          <div class="rolleoverskrift">
            <xsl:value-of select="$rolleNavn"/>
          </div>
        </div>
      </div>
      <div class="rad headerrad" style="">
        <div class="celle">Navn</div>
        <div class="celle">Id</div>
        <div class="celle">Andel</div>
      </div>
    </xsl:if>
    <xsl:for-each select="$rolle/rettssubjekt">
      <xsl:call-template name="person_row">
        <xsl:with-param name="rettssubjekt" select="."/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="listRoller">
    <xsl:param name="rolle"/>
    <xsl:param name="rolleNavn"/>
    <xsl:if test="$rolle">
      <div class="rad">
        <div class="celle">
          <div class="rolleoverskrift">
            <xsl:value-of select="$rolleNavn"/>
          </div>
        </div>
      </div>
      <div class="rad headerrad">
        <div class="celle kol1">Navn</div>
        <div class="celle">Id</div>
      </div>
    </xsl:if>
    <xsl:for-each select="$rolle">
      <xsl:call-template name="person_row">
        <xsl:with-param name="rettssubjekt" select="."/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="person_oneliner">
    <xsl:param name="rettssubjekt"/>
    <div>
      <xsl:if test="$rettssubjekt/person">
        <xsl:value-of select="$rettssubjekt/person/fornavn"/>
        <xsl:text>&#x20;</xsl:text>
        <xsl:value-of select="$rettssubjekt/person/etternavn"/>,
        <xsl:text>fnr.</xsl:text>
        <xsl:call-template name="foedselsnr">
          <xsl:with-param name="id" select="$rettssubjekt/person/@id"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="$rettssubjekt/organisasjon">
        <xsl:value-of select="$rettssubjekt/organisasjon/navn"/>,
        <xsl:text>org.nr.</xsl:text>
        <xsl:call-template name="orgnr">
          <xsl:with-param name="id" select="$rettssubjekt/organisasjon/@id"/>
        </xsl:call-template>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template name="person_row">
    <xsl:param name="rettssubjekt"/>
    <div class="rad">
      <xsl:if test="$rettssubjekt/person">
        <div class="celle kol1">
          <xsl:value-of select="$rettssubjekt/person/fornavn"/>
          <xsl:text>&#x20;</xsl:text>
          <xsl:value-of select="$rettssubjekt/person/etternavn"/>
        </div>
        <div class="celle" style="min-width:120px;">
          <xsl:call-template name="foedselsnr">
            <xsl:with-param name="id" select="$rettssubjekt/person/@id"/>
          </xsl:call-template>
        </div>
      </xsl:if>
      <xsl:if test="$rettssubjekt/organisasjon">
        <div class="celle kol1">
          <xsl:value-of select="$rettssubjekt/organisasjon/foretaksnavn"/>
        </div>
        <div class="celle">
          <xsl:call-template name="orgnr">
            <xsl:with-param name="id" select="$rettssubjekt/organisasjon/@id"/>
          </xsl:call-template>
        </div>
      </xsl:if>
      <xsl:if test="$rettssubjekt/andel/@teller">
        <div class="celle">
          <xsl:value-of select="$rettssubjekt/andel/@teller"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="$rettssubjekt/andel/@nevner"/>
        </div>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template name="kontaktperson">
    <xsl:param name="kontakt"/>
    <xsl:param name="referanse"/>
    <div>
      <xsl:value-of select="$kontakt/navn"/>
    </div>
    <div>
      <div>
        <a href="tel:{$kontakt/telefon}">
          <xsl:value-of select="format-number( number($kontakt/telefon), '## ## ## ##', 'nb-no-space')"/>
        </a>&#x20;(telefon)
      </div>
      <div>
        <a href="tel:{$kontakt/telefondirekte}">
          <xsl:value-of select="format-number( number($kontakt/telefondirekte), '## ## ## ##', 'nb-no-space')"/>
        </a>
        <xsl:text>&#x20;(direkte)</xsl:text>
      </div>
      <div>
        <a href="mailto:{$kontakt/epost}?Subject=Angående%20{$dsveMeldingstypeBeskrivelse}%20med%20oppdragsnummer%20{$referanse}">
          <xsl:value-of select="$kontakt/epost"/>
        </a>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="orgnr">
    <xsl:param name="id"/>
    <xsl:if test="$id">
      <xsl:value-of select="substring( format-number($id, '000000000'),1,3)"/>
      <xsl:text>&#x20;</xsl:text>
      <xsl:value-of select="substring( format-number($id, '000000000'), 4,3)"/>
      <xsl:text>&#x20;</xsl:text>
      <xsl:value-of select="substring( format-number($id, '000000000'), 7,3)"/>
      <xsl:text>&#xA0;</xsl:text>
      <a href="https://w2.brreg.no/enhet/sok/detalj.jsp?orgnr={$id}" target="_blank" style="text-decoration: none;">
        <xsl:text>&#x29C9;</xsl:text>
      </a>
    </xsl:if>
  </xsl:template>

  <xsl:template name="foedselsnr">
    <xsl:param name="id"/>
    <xsl:if test="$id">
      <xsl:value-of select="substring( format-number($id, '00000000000'),1,6)"/>
      <xsl:text>&#x20;</xsl:text>
      <xsl:value-of select="substring( format-number($id, '00000000000'), 7,5)"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="seksjon">
    <xsl:param name="tittel"/>
    <div class="seksjonsoverskrift">
      <xsl:value-of select="$tittel"/>
    </div>
  </xsl:template>

  <xsl:template name="seksjonMedKommentar">
    <xsl:param name="tittel"/>
    <xsl:param name="kommentartext"/>
    <div class="seksjonsoverskrift">
      <xsl:value-of select="$tittel"/>
      <br/>
      <span class="kommentar">
        <xsl:value-of select="$kommentartext"/>
      </span>
    </div>
  </xsl:template>

  <xsl:template name="info">
    <xsl:text>Linker:&#x20;</xsl:text>
    <a href="{salgsoppgave}" target="_blank">Salgsoppgave</a>
    <xsl:text>&#x20;|&#x20;</xsl:text>
    <a href="{nettannonse}" target="_blank">Nettannonse</a>
  </xsl:template>

  <xsl:template name="tiddato">

    <xsl:param name="dato"/>
    <xsl:value-of select="substring($dato, 9, 2)"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="substring($dato, 6, 2)"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="substring($dato, 1, 4)"/>
    <xsl:text>&#x20;&#x20;</xsl:text>
    <xsl:value-of select="substring($dato, 12, 2)"/>
    <xsl:text>:</xsl:text>
    <xsl:value-of select="substring($dato, 15, 2)"/>
  </xsl:template>

  <xsl:template name="dato">
    <xsl:param name="dato"/>
    <xsl:value-of select="substring($dato, 9, 2)"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="substring($dato, 6, 2)"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="substring($dato, 1, 4)"/>
  </xsl:template>

  <xsl:template name="formatNumber">
    <xsl:param name="prefix"/>
    <xsl:param name="numericValue" select="."/>
    <xsl:if test="string-length($prefix) &gt; 0">
      <xsl:value-of select="$prefix"/>
    </xsl:if>
    <xsl:value-of select="format-number( number($numericValue), '### ### ### ###', 'nb-no-space')"/>
  </xsl:template>

  <xsl:template name="footerForH1">
    <xsl:param name="home"/>
    <xsl:param name="meldingsnavn"/>

    <div style="padding-bottom:16px;">
      <small style="float:right;">DSVE&#xA0;<xsl:value-of select="$meldingsnavn"/>,&#x20;opprettet
        <xsl:call-template name="tiddato">
          <xsl:with-param name="dato" select="$home/metadata/opprettet"/>
        </xsl:call-template>
      </small>
    </div>
  </xsl:template>

  <xsl:template name="footerForH2">
    <div style="padding-bottom:16px;">
      <small style="float:right;">
        DSVE&#xA0;<xsl:value-of select="$dsveMeldingstypeBeskrivelse"/>
      </small>
    </div>
  </xsl:template>

  <xsl:template name="avsender">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Avsender'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">
            <xsl:if test="avsender/kontaktperson">
              <div style="padding-bottom:8px;">
                <xsl:call-template name="organisasjon">
                  <xsl:with-param name="organisasjon" select="avsender"/>
                </xsl:call-template>
              </div>
              <xsl:call-template name="kontaktperson">
                <xsl:with-param name="kontakt" select="avsender/kontaktperson"/>
                <xsl:with-param name="referanse" select="avsender/referanse"/>
              </xsl:call-template>
            </xsl:if>
            <xsl:if test="not(avsender/kontaktperson)">
              <div style="padding-bottom:8px;">
                <xsl:call-template name="organisasjon">
                  <xsl:with-param name="organisasjon" select="avsender"/>
                </xsl:call-template>
              </div>
            </xsl:if>
          </div>
          <div class="celle">
            <xsl:if test="avsender/returnertil">
              <xsl:text>Returneres til:&#x20;</xsl:text>
              <div style="padding-bottom:8px;">
                <xsl:call-template name="organisasjon">
                  <xsl:with-param name="organisasjon" select="avsender/returnertil"/>
                </xsl:call-template>
              </div>
            </xsl:if>
            <div>
              <div>Referanse:</div>
              <xsl:value-of select="avsender/referanse"/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="megler">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Eiendomsmegler'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">
            <xsl:if test="megler/ansvarligmegler">
              <div style="padding-bottom:8px;">
                <xsl:call-template name="organisasjon">
                  <xsl:with-param name="organisasjon" select="megler"/>
                </xsl:call-template>
              </div>
              <div style="padding-bottom:8px;">
                <div>Referanse:
                  <xsl:value-of select="megler/referanse"/>
                </div>
              </div>
              <xsl:call-template name="kontaktperson">
                <xsl:with-param name="kontakt" select="megler/ansvarligmegler"/>
                <xsl:with-param name="referanse" select="megler/referanse"/>
              </xsl:call-template>
            </xsl:if>
            <div>Referanse:
              <xsl:value-of select="megler/referanse"/>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Oppgjørsavdeling'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">
            <xsl:if test="megler/oppgjoersavdeling">
              <div style="padding-bottom:8px;">
                <xsl:call-template name="organisasjon">
                  <xsl:with-param name="organisasjon" select="megler/oppgjoersavdeling"/>
                </xsl:call-template>
              </div>
            </xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- TODO: kontaktperson-template bruker dsveMeldingstypeBeskrivelse-variabelen i en mailto: href, men den er da ikke urlencodet korrekt der (PH) -->
  <xsl:variable name="dsveMeldingstypeBeskrivelse">
    <xsl:call-template name="type"/>
  </xsl:variable>

  <xsl:template name="type">
    <xsl:if test="saldoforespoersel">
      <xsl:text>Forespørsel om saldo</xsl:text>
    </xsl:if>
    <xsl:if test="saldosvar">
      <xsl:text>Saldosvar</xsl:text>
    </xsl:if>
    <xsl:if test="restgjeldsforespoersel">
      <xsl:text>Forespørsel om restgjeld</xsl:text>
    </xsl:if>
    <xsl:if test="restgjeldssvar">
      <xsl:text>Restgjeldssvar</xsl:text>
    </xsl:if>
    <xsl:if test="intensjonfrabank">
      <xsl:text>Forespørsel om tinglysingsmetode</xsl:text>
    </xsl:if>
    <xsl:if test="intensjonssvarframegler">
      <xsl:text>Svar om tinglysingsmetode</xsl:text>
    </xsl:if>
    <xsl:if test="intensjonsendring">
      <xsl:text>Endring av tinglysingsmetode</xsl:text>
    </xsl:if>
    <xsl:if test="gjennomfoertetinglysing">
      <xsl:text>Gjennomført e-tinglysing</xsl:text>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>