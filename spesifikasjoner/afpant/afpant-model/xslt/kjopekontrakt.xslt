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
        <style type="text/css">

          .hoved-overskrift {
          font-size: 48px;
          color: #000000
          }

          .kjoepekontrakt-overskrift {
          font-size: 40px;
          color: #000000
          }

          .rolleoverskrift {
          font-weight: 500;
          color: #255473
          }

          .seksjonsoverskrift {
          font-weight: 700;
          font-size: 30px;
          color: #000000;
          padding-bottom: 18px
          }

          .underseksjonsoverskrift {
          font-weight: 500;
          font-size: 27px;
          color: #000000;
          padding-bottom: 6px;
          padding-top: 16px;
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
          padding-left: 10px;
          margin-bottom: 20px
          }

          .innrykk {
          padding-left: 10px;
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
          
          .right {
          text-align:right;
          }
        </style>
      </head>
      <body>
        <div id="container">
          <div id="header">

              <h1 class="hoved-overskrift">
                <xsl:call-template name="overskrift"/>
              </h1>
            <hr/>

              <xsl:call-template name="footerForH2"/>

          </div>
          <div id="body">
            <xsl:apply-templates select="kjoepekontraktsvarFraMegler/kjoepekontrakter/kjoepekontrakt"/>
            <xsl:apply-templates select="kjoepekontraktEndringFraMegler/kjoepekontrakt"/>
          </div>
        </div>
        <xsl:comment>div id containe</xsl:comment>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="overskrift">
    <xsl:if test="kjoepekontraktsvarFraMegler">
      <xsl:text>Kjøpekontrakter</xsl:text>
    </xsl:if>
    <xsl:if test="kjoepekontraktEndringFraMegler">
      <xsl:text>Endring av kjøpekontrakt</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/kjoepekontraktsvarFraMegler/kjoepekontrakter/kjoepekontrakt">
    <xsl:call-template name="kjoepekontrakt-template"/>
  </xsl:template>

  <xsl:template match="/kjoepekontraktEndringFraMegler/kjoepekontrakt">
    <xsl:call-template name="kjoepekontrakt-template"/>
  </xsl:template>

  <xsl:template name="kjoepekontrakt-template">
    <h2 class="kjoepekontrakt-overskrift">
      <xsl:text>Kjøpekontrakt</xsl:text>&#160;-&#160;<i>
      <xsl:value-of select="megler/referanse"/>
    </i>
    </h2>
    <hr/>
    <xsl:call-template name="footerForH1">
      <xsl:with-param name="home" select="."/>
      <xsl:with-param name="meldingsnavn" select='"Kjøpekontrakt"'/>
    </xsl:call-template>

    <xsl:call-template name="objektstype"/>

    <xsl:call-template name="salgsobjekter">
      <xsl:with-param name="salgsobjekter" select="salgsobjekter"/>
    </xsl:call-template>

    <xsl:call-template name="omsetningsdetaljer"/>
    <xsl:call-template name="oppgjoer"/>
    <xsl:call-template name="megler"/>
    <xsl:call-template name="bank"/>

    <xsl:if test="lenkeTilSalgsoppgave">
      <xsl:call-template name="salgsoppgave">
        <xsl:with-param name="lenkeTilSalgsoppgave" select="lenkeTilSalgsoppgave"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:call-template name="ressurser"/>

    <div style="padding-bottom:16px;">
      <hr/>
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

  <xsl:template name="salgsoppgave">
    <xsl:param name="lenkeTilSalgsoppgave"/>
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Salgsoppgave'"/>
      </xsl:call-template>
      <div class="innhold">
        <a href="{lenkeTilSalgsoppgave}" target="_blank">Lenke til salgsoppgave</a>
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
        <div class="rad headerrad">
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

  <xsl:template name="omsetningsdetaljer">
    <div class="innrykk">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Omsetningsdetaljer'"/>
      </xsl:call-template>
      <div class="innhold">
        <div class="tabell">
          <div class="kropp">
            <div class="rad">
              <div class="celle kol1">
                <xsl:text>Kjøpesum:&#x20;</xsl:text>
              </div>
              <div class="celle tall">
                <xsl:call-template name="formatNumber">
                  <xsl:with-param name="numericValue" select="oppgjoersinformasjon/kjoepesum"/>
                </xsl:call-template>
              </div>
            </div>
            <div class="rad">
              <div class="celle">
                <xsl:text>Omkostninger:&#x20;</xsl:text>
              </div>
              <div class="celle tall">
                <xsl:call-template name="formatNumber">
                  <xsl:with-param name="numericValue" select="oppgjoersinformasjon/omkostningerkjoeper"/>
                </xsl:call-template>
              </div>
            </div>

            <div class="rad">
              <div class="celle">
                <xsl:text>Andel fellesgjeld:&#x20;</xsl:text>
              </div>
              <div class="celle tall">
                <xsl:call-template name="formatNumber">
                  <xsl:with-param name="numericValue" select="oppgjoersinformasjon/andelfellesgjeld"/>
                </xsl:call-template>
              </div>
            </div>
            <div class="rad">
              <div class="celle">
                <xsl:text>Andel fellesformue:&#x20;</xsl:text>
              </div>
              <div class="celle tall">
                <xsl:call-template name="formatNumber">
                  <xsl:with-param name="numericValue" select="oppgjoersinformasjon/andelfellesformue"/>
                </xsl:call-template>
              </div>
            </div>
            <div class="rad">
              <div class="celle">
                <xsl:text>Akseptdato:&#x20;</xsl:text>
              </div>
              <div class="celle right">
                <xsl:call-template name="dato">
                  <xsl:with-param name="dato" select="oppgjoersinformasjon/akseptdato"/>
                </xsl:call-template>
              </div>
            </div>
            <div class="rad">
              <div class="celle">
                <xsl:text>Overtagelsesdato:&#x20;</xsl:text>
              </div>
              <div class="celle right">
                <xsl:call-template name="dato">
                  <xsl:with-param name="dato" select="oppgjoersinformasjon/overtagelsesdato"/>
                </xsl:call-template>
              </div>
            </div>
            <div class="rad">
              <div class="celle">
                <xsl:text>Kontonummer: </xsl:text>
              </div>
              <div class="celle right">
                <xsl:call-template name="formatAccountNumber">
                  <xsl:with-param name="numericValue" select="oppgjoersinformasjon/kontonummer"/>
                </xsl:call-template>
              </div>
            </div>
            <div class="rad">
              <div class="celle">
                <xsl:text>Kid: </xsl:text>
              </div>
              <div class="celle right">
                <xsl:value-of select="oppgjoersinformasjon/kidnummer"/>
                <xsl:text> </xsl:text>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    </div>
  </xsl:template>

  <xsl:template name="objektstype">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Objekstype'"/>
      </xsl:call-template>
      <div class="innhold">
        <xsl:choose>
          <xsl:when test="./objektstype = 'UKJENT'">
            <xsl:value-of select="objektstypeFritekst"/>
            <span class="kommentar">&#160;(Fritekst)</span>

          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="capitalize">
              <xsl:with-param name="tekstSomSkalHaStorForbokstav" select="objektstype"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="salgsobjekter">
    <xsl:param name="salgsobjekter"/>
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Salgsobjekter'"/>
      </xsl:call-template>
      <div class="liste">
        <xsl:call-template name="salgsobjektvisning">
          <xsl:with-param name="salgsobjekter" select="$salgsobjekter"/>
        </xsl:call-template>
      </div>
    </div>
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

  <xsl:template name="salgsobjektvisning">
    <xsl:param name="salgsobjekter"/>
    <xsl:for-each select="$salgsobjekter/salgsobjekt">

      <div class="hovedseksjon">
        <xsl:call-template name="seksjon">
          <xsl:with-param name="tittel" select="'Salgsobjekt'"/>
        </xsl:call-template>

        <xsl:call-template name="salgsobjekt">
          <xsl:with-param name="salgsobjekt" select="."/>
        </xsl:call-template>

      </div>
    </xsl:for-each>
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

  <xsl:template name="salgsobjekt">
    <xsl:param name="salgsobjekt"/>

    <div class="innhold">

      <xsl:if test="$salgsobjekt/matrikkelSalgsobjekt">
        <xsl:call-template name="eiendomsnivaatype">
          <xsl:with-param name="matrikkel" select="$salgsobjekt/matrikkelSalgsobjekt/matrikkel"/>
        </xsl:call-template>
        <xsl:if test="$salgsobjekt/adresse">
          <xsl:call-template name="adresse">
            <xsl:with-param name="adresse" select="$salgsobjekt/adresse"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="matrikkel">
          <xsl:with-param name="matrikkel" select="$salgsobjekt/matrikkelSalgsobjekt/matrikkel"/>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$salgsobjekt/borettsandelSalgsobjekt">
        <xsl:text>Borettsandel</xsl:text>
        <xsl:if test="$salgsobjekt/adresse">
          <xsl:call-template name="adresse">
            <xsl:with-param name="adresse" select="$salgsobjekt/adresse"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="borettsandel">
          <xsl:with-param name="borettsandel" select="$salgsobjekt/borettsandelSalgsobjekt/borettsandel"/>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$salgsobjekt/aksjeleilighetSalgsobjekt">
        <xsl:text>Aksjeleilighet</xsl:text>
        <xsl:if test="$salgsobjekt/adresse">
          <xsl:call-template name="adresse">
            <xsl:with-param name="adresse" select="$salgsobjekt/adresse"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="aksjeleilighet">
          <xsl:with-param name="aksjeleilighet" select="$salgsobjekt/aksjeleilighetSalgsobjekt/aksjeleilighet"/>
        </xsl:call-template>
      </xsl:if>
    </div>

    <xsl:call-template name="andelshavere">
      <xsl:with-param name="salgsobjekt" select="$salgsobjekt"/>
    </xsl:call-template>

    <xsl:apply-templates select="$salgsobjekt//arealer"/>

    <xsl:if test="$salgsobjekt/matrikkelSalgsobjekt/realsameier">
      <xsl:call-template name="realsameier">
        <xsl:with-param name="realsameierInput" select="$salgsobjekt/matrikkelSalgsobjekt/realsameier"/>
      </xsl:call-template>
    </xsl:if>

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

  <xsl:template name="realsameier">
    <xsl:param name="realsameierInput"/>
    <div class="hovedseksjon">
      <xsl:call-template name="seksjonMedKommentar">
        <xsl:with-param name="tittel" select="'Realsameier'"/>
        <xsl:with-param name="kommentartext" select="'Skal ikke inngå i pantedokument'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="kropp">
          <div class="rad headerrad">
            <div class="celle">Matrikkel</div>
            <div class="celle">Andel</div>
          </div>
          <xsl:for-each select="$realsameierInput/realsameie">
            <div class="rad">

              <div class="celle kol1">
                <xsl:call-template name="matrikkelKortform">
                  <xsl:with-param name="matrikkel" select="./matrikkel"/>
                </xsl:call-template>
              </div>
              <div class="celle" style="min-width:120px;">
                <xsl:value-of select="./eierbroek/@teller"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="./eierbroek/@nevner"/>
              </div>
            </div>
          </xsl:for-each>

        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="arealer">
    <div class="tabell innhold">
      <xsl:call-template name="underseksjon">
        <xsl:with-param name="tittel" select="'Areal'"/>
      </xsl:call-template>

      <div class="kropp">
        <div class="rad headerrad">
          <div class="celle">Areal type</div>
          <div class="celle">Kvadratmeter</div>
        </div>
        <xsl:for-each select="./areal">
          <div class="rad">

            <div class="celle kol1">
              <xsl:call-template name="lowercase">
                <xsl:with-param name="tekstTilSmaBokstaver" select="./@arealtype"/>
              </xsl:call-template>
            </div>
            <div class="celle tall" style="min-width:60px;">
              <xsl:value-of select="./kvadratmeter"/>
            </div>
          </div>
        </xsl:for-each>

      </div>
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

  <xsl:template name="salgsobjektKortform">
    <xsl:param name="salgsobjekt"/>
    <xsl:if test="$salgsobjekt/matrikkelSalgsobjekt">
      <xsl:call-template name="matrikkelKortform">
        <xsl:with-param name="matrikkel" select="$salgsobjekt/matrikkelSalgsobjekt/matrikkel"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$salgsobjekt/borettsandelSalgsobjekt">
      <xsl:call-template name="borettsandelKortform">
        <xsl:with-param name="borettsandel" select="$salgsobjekt/borettsandelSalgsobjekt/borettsandel"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$salgsobjekt/aksjeleilighetSalgsobjekt">
      <xsl:call-template name="borettsandelKortform">
      <xsl:with-param name="borettsandel" select="$salgsobjekt/aksjeleilighetSalgsobjekt/aksjeleilighet"/>
    </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <xsl:template name="matrikkelKortform">
    <xsl:param name="matrikkel"/>
    <div>
      <xsl:value-of select="$matrikkel/@kommunenavn"/>
      <xsl:text>&#160;</xsl:text>
      <xsl:value-of select="$matrikkel/@kommunenummer"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$matrikkel/@gaardsnummer"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$matrikkel/@bruksnummer"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
        <xsl:when test="not($matrikkel/@seksjonsnummer) or $matrikkel/@seksjonsnummer = ''">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$matrikkel/@seksjonsnummer"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>/</xsl:text>
      <xsl:choose>
        <xsl:when test="not($matrikkel/@festenummer) or $matrikkel/@festenummer = ''">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$matrikkel/@festenummer"/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template name="borettsandelKortform">
    <xsl:param name="borettsandel"/>
    <div>
      <xsl:value-of select="$borettsandel/@borettslagnavn"/>
      <xsl:text>&#160;</xsl:text>
      <xsl:value-of select="$borettsandel/@organisasjonsnummer"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$borettsandel/@andelsnummer"/>
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

  <xsl:template name="andelshavere">
    <xsl:param name="salgsobjekt"/>
    <div class="tabell innhold">
      <div class="kropp">
        <xsl:call-template name="listRollerMedAndel">
          <xsl:with-param name="rolle" select="$salgsobjekt/parter/kjoepere"/>
          <xsl:with-param name="rolleNavn" select="'Kjøpere'"/>
        </xsl:call-template>
        <xsl:if test="$salgsobjekt/parter/hjemmelshavere">
          <xsl:call-template name="listRollerMedAndelUtenPID">
            <xsl:with-param name="rolle" select="$salgsobjekt/parter/hjemmelshavere"/>
            <xsl:with-param name="rolleNavn" select="'Hjemmelshavere'"/>
          </xsl:call-template>
        </xsl:if>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="listRollerMedAndel">
    <xsl:param name="rolle"/>
    <xsl:param name="rolleNavn"/>
    <xsl:call-template name="underseksjon">
      <xsl:with-param name="tittel" select="$rolleNavn"/>
    </xsl:call-template>
    <xsl:if test="$rolle/rettssubjekt">
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

  <xsl:template name="listRollerMedAndelUtenPID">
    <xsl:param name="rolle"/>
    <xsl:param name="rolleNavn"/>
    <xsl:call-template name="underseksjon">
      <xsl:with-param name="tittel" select="$rolleNavn"/>
    </xsl:call-template>
    <xsl:if test="$rolle/rettssubjekt">
      <div class="rad headerrad" style="">
        <div class="celle">Navn</div>
        <div class="celle">Id</div>
        <div class="celle">Andel</div>
      </div>
    </xsl:if>
    <xsl:for-each select="$rolle/rettssubjekt">
      <xsl:call-template name="person_row_no_pid">
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

  <xsl:template name="person_row_no_pid">
    <xsl:param name="rettssubjekt"/>
    <div class="rad">
      <xsl:if test="$rettssubjekt/person">
        <div class="celle kol1">
          <xsl:value-of select="$rettssubjekt/person/fornavn"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="$rettssubjekt/person/etternavn"/>
        </div>
        <div class="celle" style="min-width:120px;">
          xxxxxx xxxxx
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

  <xsl:template name="underseksjon">
    <xsl:param name="tittel"/>
    <div class="underseksjonsoverskrift">
      <xsl:value-of select="$tittel"/>
    </div>
  </xsl:template>

  <xsl:template name="seksjonMedKommentar">
    <xsl:param name="tittel"/>
    <xsl:param name="kommentartext"/>
    <div class="underseksjonsoverskrift">
      <xsl:value-of select="$tittel"/>
      <span class="kommentar">
        &#160;(<xsl:value-of select="$kommentartext"/>)
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

  <xsl:template name="formatAccountNumber">
    <xsl:param name="numericValue" select="."/>

    <xsl:value-of select="concat(substring($numericValue, 1, 4), '.', substring($numericValue, 5, 2), '.', substring($numericValue, 7, 5))"/>
  </xsl:template>

  <xsl:template name="formatNumber">
    <xsl:param name="numericValue" select="."/>
    <xsl:value-of select="format-number( number($numericValue), '### ### ### ###', 'nb-no-space')"/>
  </xsl:template>

  <xsl:template name="footerForH1">
    <xsl:param name="home"/>
    <xsl:param name="meldingsnavn"/>

    <div style="padding-bottom:16px;">
      <small style="float:right;">DSVE&#xA0;<xsl:value-of select="$meldingsnavn"/> / xslt 2.0.3,&#x20;opprettet
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

    <!--    <div class="hovedseksjon">-->
    <!--      <xsl:call-template name="seksjon">-->
    <!--        <xsl:with-param name="tittel" select="'Oppgjørsavdeling'"/>-->
    <!--      </xsl:call-template>-->
    <!--      <div class="tabell innhold">-->
    <!--        <div class="rad">-->
    <!--          <div class="celle kol1">-->
    <!--            <xsl:if test="megler/oppgjoersavdeling">-->
    <!--              <div style="padding-bottom:8px;">-->
    <!--                <xsl:call-template name="organisasjon">-->
    <!--                  <xsl:with-param name="organisasjon" select="megler/oppgjoersavdeling"/>-->
    <!--                </xsl:call-template>-->
    <!--              </div>-->
    <!--            </xsl:if>-->
    <!--          </div>-->
    <!--        </div>-->
    <!--      </div>-->
    <!--    </div>-->
  </xsl:template>

  <xsl:template name="oppgjoer">
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
    <xsl:if test="kjoepekontraktsvarFraMegler">
      <xsl:text>Kjøpekontraktsvar fra megler</xsl:text>
    </xsl:if>
    <xsl:if test="kjoepekontraktEndringFraMegler">
      <xsl:text>Endring av kjøpekontrakt</xsl:text>
    </xsl:if>
    <xsl:if test="kjoepekontraktsforespoersel">
      <xsl:text>Forespørsel om kjøpekontrakt</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="capitalize">
    <xsl:param name="tekstSomSkalHaStorForbokstav"/>
    <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ'"/>
    <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwzyzæøå'"/>
    <xsl:variable name="forste" select="translate(substring($tekstSomSkalHaStorForbokstav,1,1),$lower,$upper)"/>
    <xsl:variable name="resten" select="translate(substring($tekstSomSkalHaStorForbokstav,2),$upper,$lower)"/>
    <xsl:value-of select="concat($forste,$resten)"/>
  </xsl:template>

  <xsl:template name="lowercase">
    <xsl:param name="tekstTilSmaBokstaver"/>
    <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ'"/>
    <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwzyzæøå'"/>
    <xsl:value-of select="translate(substring($tekstTilSmaBokstaver,1),$upper,$lower)"/>
  </xsl:template>

</xsl:stylesheet>